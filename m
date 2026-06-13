Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F934CD98D2
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 15:44:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3172B10E0CF;
	Sun, 14 Jun 2026 15:44:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=romanilin.is header.i=@romanilin.is header.b="ZePpn2/C";
	dkim-atps=neutral
X-Greylist: delayed 354 seconds by postgrey-1.36 at gabe;
 Sat, 13 Jun 2026 22:50:32 UTC
Received: from mail.romanilin.is (mail.romanilin.is [146.185.235.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E9D610EE97
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 22:50:32 +0000 (UTC)
Received: from macbook-pro (unknown [188.134.85.196])
 by mail.romanilin.is (Postfix) with ESMTPSA id C29D760108;
 Sun, 14 Jun 2026 01:44:33 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=romanilin.is;
 s=default; t=1781390674;
 bh=9oYp8yi77Kwv8NZIbSfwDwV3pUxghNgMFtDhmAWFxic=;
 h=From:To:Cc:Subject:Date;
 b=ZePpn2/Czwfki1YNm7A6dqJKMLsjGg2v2BfkjY/+xqGzfZ1fu5JzRNTGdYEoIwa7/
 HB1MkKWTKeoRyAWnCw9nGBCA3gxSP2s90s6rzMA9F5HwLlbbev7uoxrhQx/YGC4ilN
 WHm5V+Z7CkohE0xmRchlkLZYGZ49Bkaf6jUM4a4nlmz5TaFlNYqCJtnC4T2u6A9vCA
 P7zGCEgLlKZGxuFgABvI9SJIyVGRaqNhwVMcfTDygQ4yckfd+NogcpgWHAx1qwwA4b
 tDr/anJwMjUZBF6ROZ5Mw7ZIuYgFLCpAlqc6C/v2KQPsM+9Cj6vhDDGdH91HO+pcuK
 +DwisMFZ7M5Bw==
From: Roman Ilin <me@romanilin.is>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Roman Ilin <me@romanilin.is>
Subject: [PATCH] drm/vblank: Don't arm vblank timer with invalid frame duration
Date: Sun, 14 Jun 2026 01:44:34 +0300
Message-ID: <20260613224434.96501-1-me@romanilin.is>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 14 Jun 2026 15:44:15 +0000
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

When a CRTC's display mode carries a too small pixel clock,
drm_calc_timestamping_constants() computes a frame duration that
exceeds INT_MAX. drm_vblank_crtc.framedur_ns becomes negative.
drm_crtc_vblank_start_timer() then arms the vblank hrtimer with this
interval, after which vblank events are no longer delivered. Pending
page flips never complete and the display appears frozen.

This could be triggered on virtio-gpu guests that have dynamic resolution
enabled: when the SPICE agent or the X server resizes the output, it
submits a mode whose pixel clock is off by a factor of 1000, e.g.:

    clock = 406 kHz, htotal = 3152, vtotal = 2148

    framedur_ns = 3152 * 2148 * 1000000 / 406 = 16675852216 ns (~16.7 s)

16675852216 does not fit into an int and wraps to roughly -504000000.
ns_to_ktime() then yields a negative interval and the timer stops working.

Found by bisection, which pointed at commit a036f5fceedb ("drm/virtgpu:
Use vblank timer"). That commit merely made virtio-gpu use the vblank
timer and thereby exposed the pre-existing problem in the timer setup
added by commit 74afeb812850 ("drm/vblank: Add vblank timer").

Reject a non-positive frame duration in drm_crtc_vblank_start_timer() and
return an error. enable_vblank then fails and the driver falls back to
sending the vblank event immediately, as it did before the vblank timer
was introduced. Valid modes are unaffected, and the timer self-heals on
the next mode that has a sane clock.

Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
Cc: stable@vger.kernel.org
Signed-off-by: Roman Ilin <me@romanilin.is>
---
Notes:

Based on v7.1-rc7. Tested on 6.19 and 7.1-rc7.

Open questions:

This relies on the int overflow producing a negative value. The deeper
issue is that drm_calc_timestamping_constants() truncates framedur_ns to
int. Would you prefer to widen framedur_ns to s64, or to bound the
interval here (e.g. reject framedur_ns above one second) so that any
bogus interval is rejected regardless of sign?

Should virtio-gpu additionally sanitize the user-supplied clock in its
atomic_check (similar to vmwgfx for the clock==0 case) so the
vblank-timer throttling is preserved for these resizes, instead of
falling back to immediate events?

 drivers/gpu/drm/drm_vblank.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index f78bf37f1..557cd0bc8 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -2235,7 +2235,13 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
 
 	drm_calc_timestamping_constants(crtc, &crtc->mode);
 
+	/*
+	 * Return an error so the driver falls back to sending vblank events
+	 * when a small mode clock yields a frame duration exceeding INT_MAX.
+	 */
+	if (vblank->framedur_ns <= 0)
+		return -EINVAL;
+
 	spin_lock_irqsave(&vtimer->interval_lock, flags);
 	vtimer->interval = ns_to_ktime(vblank->framedur_ns);
 	spin_unlock_irqrestore(&vtimer->interval_lock, flags);
-- 
2.54.0

