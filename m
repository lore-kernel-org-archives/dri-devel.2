Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817F1105F783
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 09:17:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2BFB10E0DA;
	Fri, 13 Mar 2026 09:17:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="mu1V+iMp";
	dkim-atps=neutral
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net
 [178.154.239.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DBD310E0DA
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 09:17:50 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0f:571a:0:640:23e3:0])
 by forward103a.mail.yandex.net (Yandex) with ESMTPS id A936B80CCD;
 Fri, 13 Mar 2026 12:17:48 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id 3HEusrTGkmI0-kVMePrg5; 
 Fri, 13 Mar 2026 12:17:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=mail; t=1773393468;
 bh=8Epwrrsq7LNYAHxJtynlSWzfRvuMl+7kFlXFQuGSZEk=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=mu1V+iMp1Xlzhfek9S3EnnAnGcQ053OJM6Y8J21ZaB4/uqXpVs0Wku53axPXjVrOt
 DsRyi303B52/nHGUO6eStJibo+60fyRz4ElzlHRokiAooXE68nnhYUCqFJ1rFaWwGo
 nvBn7CiH/bMvzMKwQ99Ts39LnzCA89TtAO0Pp2uo=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net;
 dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: linux-kernel@vger.kernel.org
Cc: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Deborah Brouwer <deborah.brouwer@collabora.com>
Subject: [PATCH v1 RESEND 1/4] drm/tyr: clear reset IRQ before soft reset
Date: Fri, 13 Mar 2026 12:16:41 +0300
Message-ID: <20260313091646.16938-2-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260313091646.16938-1-work@onurozkan.dev>
References: <20260313091646.16938-1-work@onurozkan.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Clear RESET_COMPLETED before writing GPU_CMD_SOFT_RESET.

This is also used in
drivers/gpu/drm/panfrost/panfrost_gpu.c::panfrost_gpu_soft_reset
and avoids seeing old reset-complete status from a previous reset.

Tested-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 drivers/gpu/drm/tyr/driver.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 69eff2a9e116..f7951804e4e0 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -91,6 +91,8 @@ unsafe impl Send for TyrDrmDeviceData {}
 unsafe impl Sync for TyrDrmDeviceData {}
 
 fn issue_soft_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
+    // Clear any stale reset-complete IRQ state before issuing a new soft reset.
+    regs::GPU_IRQ_CLEAR.write(dev, iomem, regs::GPU_IRQ_RAWSTAT_RESET_COMPLETED)?;
     regs::GPU_CMD.write(dev, iomem, regs::GPU_CMD_SOFT_RESET)?;
 
     poll::read_poll_timeout(
-- 
2.51.2
