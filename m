Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D70A606A31A
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 07:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=it7yRxk/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=R1mJLfad
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5183E10E771;
	Sun,  8 Nov 2026 07:06:32 +0000 (UTC)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E7F410E76D
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 07:06:20 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id EE8171D00100
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 02:00:41 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Sun, 08 Nov 2026 02:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1794121238; x=
 1794207638; bh=MwXoVj7VtwK8+qdC3DCorsEevxh+0bdr4hybtczpCAk=; b=i
 t7yRxk/dSTjELIQQfuoCi95Ji3HwYx5mybimIsSiiWVD60IwBDLZZ/XKDUMYUK91
 OcXqaV+dJFgyw1+FV0fWc+c8LApdyOs+UVEs8KvWZA9THKdDhDPzJ/5/3Hs+fU6V
 +JZZsqkPTMN0wfI+9um9eiYCKUoR5aBofwKX2k/b+Ikuei5ZToKoqhHVrs5Ck0Ac
 +9y9Ugcc5dBbcDkvA6fDP7dq69ma7ydbFIk+8eIM6yPPlQnnkNtxQxbec9r15ANz
 sAc0VzhMK+qoQpLRnwg6DoGmnITssJe+sxwgc/IZBEdkGNR7FGo3c/TnmH9P/hEZ
 JGN3wwNpe/38R6HaWFlmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1794121238; x=1794207638; bh=M
 wXoVj7VtwK8+qdC3DCorsEevxh+0bdr4hybtczpCAk=; b=R1mJLfadEmvWDJ3tE
 w9TXbj31KdAKxgQtMYQM2hfxykrfAsKyRKcGup3cusx3QBL05lWNKOIvI5UitF4u
 y2C6K4IXOFZ4XgmeIDWkiQDXjVi04VS1/SXSQRYJ2skPkU9olysNgKFn8ng8ibUu
 aWo+sain0NRodzNRTgWsTslJu2i5ubgHuAnGOtq0gD5sWQ3C9FsXYHTJRnyzD7Or
 b2gAiEbj10hIbxsc1TB8wxshfGsJvsJu2sDyXgTEgalVoWVAwQszirHGJKA7mCLE
 ajmeATbmdEoXtax1g7afhPT17WY3DsuCmS3TftHLze8GDOwyzfMI6mZG9ili4cpO
 FR6rg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794121238; d=gahingwoo.com;
 mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm1:rsa-sha256:JrJxoY99GPAwSfPCE12nkkc3SjpBKUtDHB6J0PFKN+ZluWO
 BJYJetFUEuJedDIoMZsPwkuOfRVZVDKBQePFlZfc+NClYgJVbjT20SsLw02Kc0I2
 oFsNsJfjNJ9iwrruVA0/CDjQka055t9rUWvLdIJj8t7nEiJHBPRprQaRY9iEqQu1
 bwxmsYNGInF4u0efea0O6eO0PYuOOle9aA/rGHoJfvw6o/gtFGyUrhJNWwqSh1K7
 XfkcjQO3+xSfm/4dlU+/JFSYWxgztXzWpLtCxfuFWRLobq9gLP6IwIb2mP4gTYOw
 KNjKGyGIng+xAoaaaggwp2qV0lXxUiJWr4tn1+g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:504HtATi/nnS6Wir3Gd6PV91vUV1PYFEAMiQUnQ6kdo=:LiTAKv6w3ItMpetjIbtFp4/jsfoLAeZUbpGFftVddYo=;
X-ME-Sender: <xms:FR7wakN0ii5kR2RnK4FGHFqR8Z8cSnZeisioNV38p6DgRkF1YnY2ng>
 <xme:FR7wanYzu2Az_47LDZM4ONziPYuBlW7q4VcW_A5mZYyRfTyiKrCUm1rdjT7M8o15K
 sp9v2h-UGj6-SiRFudQ96KJfIPXUwKFqO3b2oNwqRu09N2HL5R9avc>
X-ME-Received: <xmr:FR7waig4ly850qcrrBxK2l5u_a_TtGR1WH2PNbpN1BSoOV4V18nd7Pmo78O7_ECBwLVOi-L4>
X-ME-Proxy-Cause: dmFkZTFmDpL6Lin4bBBXc5GaE/ahubP3zu2K50B7H9Imac3SJ4iIzn06K98HnlZ50ZwbMJ
 QFkB7kL+l/vkKbZGd1in8yKKFA4SA3uo2UUDHIHwZN7H4crBcmdk0qAnVO4P5AlVHCa7Uu
 pEvpLMR6M2ll6yTeLvRX4+DnYY02JpxSdsWiKCCOv1gfs4sbxTLUGiMZ3CUmwlqZM2Q8EZ
 rhTXTTtNYEnwT6sYYTWLMzmTAiaaxXOEWy0d5cSRHl/MzQXniauXMjzhOXRE4/24CMO7R2
 UJgAFJukB2IqkwUKkg1IlwgqZQAqWJvmMEhalQbrtZD0nVwdXW0vo4Jybnwr7hWctDEbAy
 dzcKtxQ7PtGyxrrCrWvU2143/6UTGDl6fgaK6tMCMTEpYlZ4LG+qd+2SdUEmuBjMhkKo37
 YBRavW03muiBsHSihgCHglGWvcZetcBIdjwzCKtzqGCO/xwAcD1e36JOTyjXEtNGefaI4y
 OKZKW+SY0FjKZEUSQDQ264HK6V4eTm+hpybCcukUqP4S78URa1CK0xVDAey8wqjT5wRhov
 TR57BuOexjSbORc9/JxhLYEjAoDfz4V+brhL/Ah714m6/1K/ZwlRhtDXSq7bcL05vl3Vvy
 MHtQxd5ioa+J76k4qS2Nh/6EQj5V+afnPvLOyQekv/uJTzJZrUIIhAMuGt4A
X-ME-Proxy: <xmx:FR7wajP1C1Ii35bYKNg_cJQ0-7tb_9-zkZO_g8IA4WVTqRq3GiHE5Q>
 <xmx:FR7wasudSkYfKR0NwB3nH-2Spke5mlXfe9HESDEqW4-G-sr3BsukYA>
 <xmx:FR7wam2ILc8ke79jZJCKqyX3njWVuXjzZyg3ZwD8dWXGfu5hqZtBbQ>
 <xmx:FR7wajz5Uj6JHB-znFAL5tfe35PCHJXsYbFnpg85CVCLDDU96woX-Q>
 <xmx:Fh7wagVJhIrpG6GXKZxNRgw7-nD-hGe0qQ-lkCZihwptm4Y8aC86PXKD>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 02:00:28 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 shawn.lin@rock-chips.com, finley.xiao@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 jeff.hugo@oss.qualcomm.com, rfoss@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v16 04/16] accel/rocket: let the core suspend after a reset
Date: Sun,  8 Nov 2026 19:59:05 +1300
Message-ID: <20261108065917.135194-5-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108065917.135194-1-gahing@gahingwoo.com>
References: <20261108065917.135194-1-gahing@gahingwoo.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The reset path drops the runtime PM reference with
pm_runtime_put_noidle(), which does not let the device suspend, so the
power domain is never switched off and on again.

On the RK3576, powering the domain on resets the NPU bus interface. If
that does not happen after a reset, the IOMMU may not respond and the
next job after a timeout fails.

Use pm_runtime_put_autosuspend() instead, so the reset path handles
runtime PM the same way as a normal job completion.

Also drop the runtime PM reference after rocket_core_reset(), so the NPU
core stays powered during the reset.

The earlier test on the ROCK 4D was done on the v15 code: the job after a
timeout went from all 128 channels wrong to all 128 correct.

Repeated resets were triggered with a 2 ms job timeout.

v15 (put, then reset): tested twice; both times the board hung within the
same second as the first batch of job timeouts, with nothing printed.

v16 (reset, then put): tested four times; the board never hung.

So moving pm_runtime_put_autosuspend() after rocket_core_reset() avoids
the board hanging during a reset.

Link: https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail.com/
Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/accel/rocket/rocket_job.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index abef12b86d48..4a577b642849 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -395,6 +395,8 @@ static void rocket_job_handle_irq(struct rocket_core *core)
 static void
 rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
 {
+	bool put_job_ref;
+
 	if (!atomic_read(&core->reset.pending))
 		return;
 
@@ -413,11 +415,10 @@ rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
 	/*
 	 * Remaining interrupts have been handled, but we might still have
 	 * stuck jobs. Let's make sure the PM counters stay balanced by
-	 * manually calling pm_runtime_put_noidle().
+	 * dropping the job's reference once the core has been reset.
 	 */
 	scoped_guard(mutex, &core->job_lock) {
-		if (core->in_flight_job)
-			pm_runtime_put_noidle(core->dev);
+		put_job_ref = core->in_flight_job;
 
 		iommu_detach_group(NULL, core->iommu_group);
 
@@ -427,6 +428,9 @@ rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
 	/* Proceed with reset now. */
 	rocket_core_reset(core);
 
+	if (put_job_ref)
+		pm_runtime_put_autosuspend(core->dev);
+
 	/* NPU has been reset, we can clear the reset pending bit. */
 	atomic_set(&core->reset.pending, 0);
 
-- 
2.43.0

