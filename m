Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84098606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 01:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Evf4aKWw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDB1F10E58C;
	Wed, 18 Nov 2026 01:25:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB18110E58C
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 01:25:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D69A260E11;
 Wed, 18 Nov 2026 01:25:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794965130;
 b=FdFSA3OnyT04HXpSk9/nU7vXQbeDi3dTcPiqQkVt1tHVZICobQ/DRsjW6qCNYY23xERk
 SSWSTjslBqrrrgJOQrRTwXEn1rcFRcRVceQDQBef+RBFPq+ef9oXBMKMRXB0nyb2M7WFd
 xaQxqLxZTlW2gf+9lN7VO3tAGiSe6fyLugzkmhDTaItyDyZA9qdG9n6oYzOnOPkB58pLf
 L9nJd3hkQ2bzR1GsCVPoPxnXnFZeYrFmh3U11Jg5EDwj6q/Qvvu2EiJXBOM3L9I57Zmwh
 qVqN/QPx64thzh6TxoyiR4Y7D5G0xUO3hc64es/5UOxrNJsavXdqgE5optvLgrDl4mg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794965130;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=savT1NQUMXc5EKxPUj2lCIipe5ZvsTIstXbCVAOb+ck=;
 b=CH9/rRnq6QiCKW21YlZ4AFjgHbMvgR6vYNWJJLhHXgB2H20B4o/z6KV2WfuwA4p0jTTA
 5UKncLAu2ncz1RC4Pwsfnn5DZc+Uk/IUZuBeoR4DjQGIZKIA566EMdynMZM2lgHPi9sDn
 +d2maUmQSGa6whu19gmcJqqwgAkOF466X24ZK2nMPpKsD2A1TA+UY639y5R+O3jfBPsfR
 gMIHBvpQ6wdSRo0hrmLHhjFv5RzX29AGDNA2t1jf8ZArHU7OodpNt/3Gk7mEu7thO8gNI
 EROysKXbOla1BCyMiYnMbmNww+BmNtJL7T6jQqTzMA6SgmCTIFLtK+MFbn2K1MAoFjQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 06ED71F000C4;
 Wed, 18 Nov 2026 01:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794965130;
 bh=savT1NQUMXc5EKxPUj2lCIipe5ZvsTIstXbCVAOb+ck=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=Evf4aKWwXD6FnbomEzIViDwLr+j9kKcQ4QLt5ZsvWEkKZ2vp3zAzTEwdbBuSoeyzO
 eNMbPeVVcOUSefDgAMtzmMcgMBQmJbVYF1cww93S+aPtkGg3F57UVifiR0ezJKIqQA
 5NXuQra188K2VFVNjldDEoCHhPE0Iv6MbjGb6LIasAi90HlBtLb91GyMFjWB/E5FVL
 dPATX5jgSB3WSCY34CTQ3SRpkFF4jvloZRrmsARW9aM/UEAMC0djIg2EiRyLegUiTY
 INuu/GoP1qG1xQDVMEzwGUmhOrP2yprp/SzpkzTEz89TIqA5YlQfXMhbVAWWb2MlJV
 14M3VGRoW7ULg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 5D1B14AB8A;
 Wed, 18 Nov 2026 01:25:29 +0000 (UTC)
From: Zi-Hao Huang via B4 Relay <devnull+zi-hao.huang.mediatek.com@kernel.org>
Date: Wed, 18 Nov 2026 09:25:18 +0800
Subject: [PATCH] drm/mediatek: dsi: Don't let a signal cut the IRQ wait short
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261118-mtk-dsi-irq-wait-v1-1-205f25fac8b2@mediatek.com>
X-B4-Tracking: v=1; b=H4sIAH3+/GoC/x3MzQpAUBBA4VfRrE2ZSciryGJyB5P83SuUvLub5
 bc454Gg3jRAnTzg9bRg6xJBaQLdKMugaC4aOOOCiCqcjwldMDS/4yV2oHBeEouTgkuI2ea1t/t
 fNu37fkZKzT5iAAAA
X-Change-ID: 20261118-mtk-dsi-irq-wait-a24712ada627
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 shaoming chen <shaoming.chen@mediatek.com>, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Zi-Hao Huang <zi-hao.huang@mediatek.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794965128; l=2609;
 i=zi-hao.huang@mediatek.com; s=20261112; h=from:subject:message-id;
 bh=mBD6dS6d064X8Z2NA64EwiPmxgRAZHmv32EB6c3egAE=;
 b=h0n34iq4oweQpJL4Q1/996A0FU3QFKpqo/f4lya6mqbzxROzBIxyGIe0y5Q1hebLNaOvGCuh6
 Uzd8VWv4YnTCLk29wrnRg3YlOT4kPhXxSEBsbUMS+exxPHW/ApTnAvr
X-Developer-Key: i=zi-hao.huang@mediatek.com; a=ed25519;
 pk=tbMIVegYSSBtz5MaQSUCX9RJO88MA/AI5cbmQKbaoIc=
X-Endpoint-Received: by B4 Relay for zi-hao.huang@mediatek.com/20261112
 with auth_id=1493
X-Original-From: Zi-Hao Huang <zi-hao.huang@mediatek.com>
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: zi-hao.huang@mediatek.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Zi-Hao Huang <zi-hao.huang@mediatek.com>

mtk_dsi_wait_for_irq_done() waits for the DSI IRQ with
wait_event_interruptible_timeout(). If it returns early, for example
with -ERESTARTSYS when a signal is pending, both callers still treat the
command as done, because they only handle a return value of 0 as a
failure.

On an MT8196 board this led to a hard lockup during shutdown. The wait
returned before the IRQ arrived, the panel disable sequence went on and
restarted video mode, and the late CMD_DONE interrupt was then handled
by mtk_dsi_irq(). The handler writes RACK and loops until DSI_BUSY
clears, but DSI_BUSY stays set while video mode is running, so the CPU
never leaves the handler until the watchdog fires. Forcing the wait to
return early reproduces the lockup every time, and it no longer
happens once the wait cannot return early.

The wait is made from the driver's own context to synchronise with the
hardware, not on behalf of a userspace request, and it is bounded by its
timeout. Use wait_event_timeout() so that it only ends on the IRQ or the
timeout.

wake_up_interruptible() cannot wake a task in uninterruptible sleep, so
switch mtk_dsi_irq() to wake_up(). Without it every wait would last
until its timeout.

Fixes: dd5080a54df8 ("drm/mediatek: add dsi interrupt control")
Signed-off-by: Zi-Hao Huang <zi-hao.huang@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index f82506e10fd5..1315dd31a834 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -627,9 +627,8 @@ static s32 mtk_dsi_wait_for_irq_done(struct mtk_dsi *dsi, u32 irq_flag,
 	unsigned long jiffies = msecs_to_jiffies(timeout);
 	struct drm_device *drm = dsi->bridge.dev;
 
-	ret = wait_event_interruptible_timeout(dsi->irq_wait_queue,
-					       dsi->irq_data & irq_flag,
-					       jiffies);
+	ret = wait_event_timeout(dsi->irq_wait_queue,
+				 dsi->irq_data & irq_flag, jiffies);
 	if (ret == 0) {
 		drm_warn(drm, "Wait DSI IRQ(0x%08x) Timeout\n", irq_flag);
 
@@ -656,7 +655,7 @@ static irqreturn_t mtk_dsi_irq(int irq, void *dev_id)
 
 		mtk_dsi_mask(dsi, DSI_INTSTA, status, 0);
 		mtk_dsi_irq_data_set(dsi, status);
-		wake_up_interruptible(&dsi->irq_wait_queue);
+		wake_up(&dsi->irq_wait_queue);
 	}
 
 	return IRQ_HANDLED;

---
base-commit: 067c5c24cef23d913b67eaaf71ae67e7169a6620
change-id: 20261118-mtk-dsi-irq-wait-a24712ada627

Best regards,
-- 
Zi-Hao Huang <zi-hao.huang@mediatek.com>


