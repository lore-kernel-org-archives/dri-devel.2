Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EA3606A8B2
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GURFOUjJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C0C410E587;
	Thu, 12 Nov 2026 08:10:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AAB910E587
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:10:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 21FF4455C4;
 Thu, 12 Nov 2026 08:10:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794471040;
 b=S0jVKuIo0ChZACKK9/TNnPGxPgY0vHLyaLkSkloANHxJOKtSp4b4t5solTn97epf+2Tf
 kfQdG5qKhqmCty3uTRHr1E2qaS3oI/u8WDfZcwVSgrpvoTWNr5OeXB1Jnp91YaSM6T+4v
 2PO7DYVXBsNzKk3SqeHDdsP0owwidDV/qohfLEiZtmdtJ5gNtu+5bu/9ktnkj31DpDlQv
 JJNAOJjE0sIBj89IaeZ6rHsaHxiyLwTC3lV46Po8yMMQrtEtMyHca6fuUw6J1M5/m/4Lt
 EQplCgaXMGKDZUVitV138Ybae1nUN5KsVFzUrfy6bR5+rwlh3OqhGsC6Th95gFRFoTg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794471040;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=BycxkJDEkQrYGACgnxRcwOpm358ZLLzx9eK5XW7KLlA=;
 b=VhWbUzoXc4JGeEF2mxidvF6/gjSPn1UL5/3OR0TVgxUwiFiRjQnXcmHEJACjYCS9oaEn
 HKvuh+BIu+TMDKYR7/go2S+u2wugSpvKfxfIORTaR1kU/72wWLjyWnw94l2HPlsGlBpQa
 6x2KttNDxTMEOr7mX/u9brUpsDr7XCslf9X7PTQU/3+FxeV8L+A63GQMKhr3/NpWo1S7a
 FF6ENm9enqnZO3UPs6c6XG5mOhtpwRf/Z/d/CI9/3q3z8qFSWNgC1KYvNcGXaacrMbmoZ
 T6586fivu3sX+2QWKwbRHSjciEu38opnMthKJ9R+mBuNwhWbpuMlNhwpeMp+TqZaR3w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 5F1DE1F00A05;
 Thu, 12 Nov 2026 08:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794471040;
 bh=BycxkJDEkQrYGACgnxRcwOpm358ZLLzx9eK5XW7KLlA=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=GURFOUjJE8jzpEJuv/bXoOyr81p/2Uw4s9ZtUZuiVKULqMKyuOpkqlccwcdNL1LjD
 G4vtZfOIHM33g+pfWRnKEQN27TAyX3iz2jm1X2WeKz+1nKDybDLjlC3ubmbCf5yiSz
 4VkRWokLzBaS8yWLwEMJcMgr09HLwK6xUQVgHOWZ1UmQ7et5mYOHHuSHAH2nBzbguM
 QV1UlHZWyaMNckcIn7QwIhqPIBjrnUDzSP0H69yo/4LxRmxQihjEa6zIUumqh3hbjA
 czbGpC1lzv7nWqYseGLS6IBhfQHrCOdjEf7YTmH4fPebr+1VmT3A51ugFh68CK0Grb
 vAGo1s/f4ECAQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id B44534932C;
 Thu, 12 Nov 2026 08:10:38 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 08:10:39 +0000
Subject: [PATCH v2] drm/panthor: Suspend devfreq until the GPU is first resumed
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-panthor-suspend-clk-v2-1-62e1b168052d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OS47CMBBErxJ5jUfdSZyMWXGPEQu70yYeyAfbi
 QYh7o5D9rN86qp6/RSRg+cojsVTBF599NOYoTwUgnozXlj6LrMooWwQEeRsxtRPQcYlzjx2km5
 XidipBmrHyrLIzTmw83+f1Z/zznGxv0xpm9oSvY9pCo+PdsUt979hRYlSVbVqQQEr5NNlMP72R
 dMgzq9dEfi+5P/T7hXWRJb5Pvh0LMiCaSoHpBv+ZrIaUGtmqzVRaVpHzrRQdXUee70BaxZKHhQ
 BAAA=
X-Change-ID: 20261110-panthor-suspend-clk-11d5604fe5be
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Akash Goel <akash.goel@arm.com>, Karunika Choo <karunika.choo@arm.com>, 
 Lukas Zapolskas <lukas.zapolskas@arm.com>, 
 Chris Diamand <chris.diamand@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Jonas Karlman <jonas@kwiboo.se>, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794471038; l=6121;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=uiwyQooI2QqdHVVbIj2tbEKcTWRM+G3FzfbhcKof+kg=;
 b=wivOOwJ/7GTvbZBbl834segCag1oFnqKSy2+v8GXNHok6K8gnpd49EQDjqRZ2Ifr4AEJT7Xg3
 pSZ8BrJXh9wBSgatVc/kYmttND3QH/F7PLPS1qxGYtybmlz9/HqCGC5
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
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
Reply-To: aiyengar1990@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

panthor_devfreq_init() adds the devfreq device while the GPU is still
suspended, and the first panthor_device_resume() then calls
devfreq_resume_device() without a matching devfreq_suspend_device(). The
devfreq suspend count stays off by one for the lifetime of the device:
-1 while the GPU is active, 0 while it is runtime suspended.

devfreq_suspend() and devfreq_resume() around a system suspend therefore
treat a runtime suspended GPU as an active one: devfreq_suspend()
applies the suspend OPP, if there is one, and devfreq_resume() restarts
the polling of the simple_ondemand governor, which then sets GPU rates
while the GPU is still runtime suspended, until its next runtime resume
and suspend. With the devfreq core keeping a suspended device's
frequency alone ("PM / devfreq: Do not change the frequency of a
suspended device"), the unbalanced devfreq_resume() also marks the
device resumed while the GPU is powered down.

Suspend devfreq right after adding it, as msm_devfreq_init() does, so
that the devfreq suspend and resume calls pair up.

Fixes: fac9b22df4b1 ("drm/panthor: Add the devfreq logical block")
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
v1 kept devfreq from changing the GPU clock rate while the GPU is
suspended by filtering the calls in panthor_devfreq_target(). As Boris
pointed out, that cannot be done race-free in the driver, so v2 moves it
to the devfreq core: "PM / devfreq: Do not change the frequency of a
suspended device" (linux-pm [1]) keeps devfreq from calling
->target() between devfreq_suspend_device() and devfreq_resume_device()
and applies the requests made in between on resume. The SError fix
needs that patch. What is left for panthor is this patch, which makes
panthor's devfreq suspend and resume calls pair up; it does not depend
on the devfreq patch to build or to be correct.

Tested on an Orange Pi 5 (RK3588S) running a v7.3-based kernel with
this patch and the devfreq patch, with the GPU core clock on the
firmware-managed SCMI_CLK_GPU and a 200 MHz opp-suspend (the
configuration of Jonas Karlman's RFC, not in mainline): min_freq,
max_freq, the userspace governor's set_freq and the devfreq cooling
state written while the GPU was runtime suspended, also right after a
suspend-to-idle cycle, no longer end in an SError and take effect on
the next GPU job; 200 runtime suspend/resume cycles with max_freq
toggling every ~35 ms and a 3 minute sustained load ran without an
SError, WARN or panthor fault.

This patch was developed with Claude (Anthropic) as a coding assistant:
it wrote the code and the commit message, and I reviewed it and tested
it as described above.

[1] https://lore.kernel.org/r/20261112-devfreq-suspend-sync-v1-1-af64603ef43e@gmail.com
---
Changes in v2:
- Dropped the check in panthor_devfreq_target() (Boris): neither
  pm.state nor devfreq::suspend_count can be read there without racing
  with devfreq_suspend_device() and devfreq_resume_device(), which only
  take devfreq->lock around the suspend and resume frequency changes.
  The devfreq core now tracks the suspended state under devfreq->lock
  and does not call ->target() while it is set, as Boris suggested.
- New patch: start with devfreq suspended. The first runtime resume
  called devfreq_resume_device() without a matching suspend, so the
  suspend count was -1 while the GPU was active and 0 while it was
  suspended (the reason v1 did not use it). Without this, the devfreq
  core change would not hold across a system suspend taken while the
  GPU is runtime suspended.
- Liviu, on returning 0 instead of -EINVAL: returning 0 was wrong, devfreq
  then records a rate the GPU does not run at (Boris). An error is
  better than 0, but -EINVAL reports a valid request as invalid (-EBUSY
  fits better), and either way nothing retries the request on resume:
  the userspace and performance governors never re-evaluate, and
  simple_ondemand only at its next poll. With the core change panthor
  never gets these calls, so there is nothing left to reject.
- Liviu, on disabling the clock when the power domain goes down: the
  clocks are already disabled in panthor_device_suspend() before the
  domain goes down, and the SError happens in that state. On RK3588 a
  rate change on the disabled SCMI clock still goes to TF-A, which
  programs the PVTPLL through the GPU GRF in the powered-down domain.
  So the rate change itself has to be held back while suspended.
- Liviu, on the comment length: the remaining comment is two lines.
- Sashiko's findings on v1 (a rate requested while suspended was lost
  without a suspend OPP or with a non-polling governor; the lockless
  state check could race with the clocks going off; Fixes: tag) are
  covered by the devfreq core change, which applies deferred requests on
  resume and keeps the state under devfreq->lock. Thanks to Sashiko for
  them. The new patch has Fixes: fac9b22df4b1, the commit Sashiko named:
  the unbalanced count is a mainline bug, independent of the SCMI clock.
- Link to v1: https://patch.msgid.link/20261110-panthor-suspend-clk-v1-1-53457050e51e@gmail.com
---
 drivers/gpu/drm/panthor/panthor_devfreq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
index 2249b41ca4af..45ae42dacdcb 100644
--- a/drivers/gpu/drm/panthor/panthor_devfreq.c
+++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
@@ -256,6 +256,12 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
 		return ret;
 	}
 
+	/*
+	 * The GPU stays suspended until the first panthor_device_resume(),
+	 * which resumes devfreq. Suspend devfreq to match.
+	 */
+	panthor_devfreq_suspend(ptdev);
+
 	cooling = devfreq_cooling_em_register(pdevfreq->devfreq, NULL);
 	if (IS_ERR(cooling))
 		DRM_DEV_INFO(dev, "Failed to register cooling device\n");

---
base-commit: cb0a63f0c96e8ecb90199eeb99cc2a7fcfa703d4
change-id: 20261110-panthor-suspend-clk-11d5604fe5be

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


