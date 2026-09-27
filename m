Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC5ACA5FA4
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:42:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A2F210E836;
	Mon, 28 Sep 2026 08:42:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nNBRYm1w";
	dkim-atps=neutral
Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com
 [74.125.227.168])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E65F10E419
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 07:54:41 +0000 (UTC)
Received: by mail-pj2-f40.google.com with SMTP id
 98e67ed59e1d1-3a0df0bb2d6so591612a91.3
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 00:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790495680; x=1791100480; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bjwFwUue96fleY0pohUkbrbEGxywxs4gaD//2C9cu0w=;
 b=nNBRYm1wvE/N5oZgIfvbJgdEnOZVzZIGgxtgKqsI41mdEHuss3rmKy3a+oqI5LS2Qm
 76B2ewFNR4I7pFHHIvUX1GSy05sAqlCQFGw1FmXTxIW0XOg6joaA00HkkDlxLWQAPqmL
 nny+ZqvMYojZBH5lo/w5/0l65JbIIOH7ngHm0AY1Z1/5C1FilbeWCC8OeBAdWP8HMzy4
 SODY5uyOkcTi3CiYehYIuKrK224qMSPvrSV1AVXdzozOOv/dbGdTttqgPm2XtawUlJG+
 oJPzMBZCTZM9gShwM61FUBqeOs9uYcZ6JKZs4ZLEvkO4co4phIk2p09AXGSluQeXkE24
 iqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790495680; x=1791100480;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bjwFwUue96fleY0pohUkbrbEGxywxs4gaD//2C9cu0w=;
 b=rPh0iL4iKm1nRYBFh1wXPyLHYukJDTb97l72726qHM8OiFSVF/cEVtdZ8AVCbnUCxv
 3lNIA4hi62Bq/7bO5k0VBN9INUBFmZjcYU1TmWEJKQp5ZAn+0tI4bYl7Rdnvg7q3U/Bv
 NFciAKp29IEnZwgUpTTeaMAqrDgGB27/IXXU1vBoZPRx3cMxAhiOIP97JLF5HAV6jhX4
 64MQGWqkth1uCvNBLRYexCJdk373gxcDnC0A7bI5hgTunKMs804wXUJJMj8dV+qFneTK
 iu/viyL+BnxFgNNr+IrpW/fEnDtQUpHKMuvooOQp0c0strr4gGgvfZ/YHuWUaT+x/r9b
 oFGg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxiLRVT374u/BvV2npBwrVfUTX6wYRst6L0+64dcNB7VoB5t3b/IHIpLHEINu+cSCstz5Go12sNRYg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJGej2gKBI33gjnQvAbhM3rouXEcVSfV9xSzm44wCDqLOrP+iwV
 V6ztzM5uLxinw5AlXiYb6aBFhKPL459q11bbZXPxkKkOLVQFjk4sdQ/d
X-Gm-Gg: AYBFou3q/kaqAOFn4JyTSZ8UDMQzH+xxUyMpLqv6B9DmDtlr0TG6b9JD/HCYzkzB5/0
 L4C2a+rQaNjhskhXrXExlb/pP/b01+IPW7gMHF3xmpCYCpmKnmbecehdL3jUYvWEsmkSeihqNrj
 GW9h82Qb7ygREdNXy8uyQo0fwkaEsYKgceJgzRQbS6fOaKNq8kjhoaw0m8Ggy2CIQlTSdKmVo+y
 nc8HAD1aswhczxh0LJx1wnOvAe0817r2nmEk+SA7cfftCo2cJhY3TL19xR5GL/tV9AfMdGZoSQe
 /QRQ3OdDjoU0FTc0kPFj9XIJX6KlkwxNPSErJCJG36xjvXUonZDXJCa10pGm248xrlJdzd7eL3T
 UZclrh4X+JEwO2essCqjNPEuoe19fMOOqrVi6s80g6H7nM0diHrEVUr1tHUa+K7cRUNcCUT6w7T
 XNOwYLpvhiIci4MWIuetwd+MEkAlVeSrHJ7azRUa5VYXyHeA5gpQCYSNfKmZ0eYG3/CkmsTCeLV
 kssS2bpfx2JqZGS
X-Received: by 2002:a17:90b:57c6:b0:3a0:22bd:6ef6 with SMTP id
 98e67ed59e1d1-3a09853a6cdmr7064156a91.2.1790495680466; 
 Sun, 27 Sep 2026 00:54:40 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:3a0c:2ea9:4ab7:bd1b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm13771287a91.2.2026.09.27.00.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 00:54:40 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
 syzbot+ca23c8570669ead78867@syzkaller.appspotmail.com,
 stable@vger.kernel.org
Subject: [PATCH] drm/fb-helper: defer setup when fbdev_probe() fails,
 not just on -EAGAIN
Date: Sun, 27 Sep 2026 14:54:34 +0700
Message-ID: <20260927075434.72658-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:41 +0000
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

__drm_fb_helper_initial_config_and_unlock() calls
drm_client_modeset_probe() first, which already fills in each
mode_set->mode/num_connectors for every connected output, and only
afterwards calls drm_fb_helper_single_fb_probe() to create
fb_helper->fb and wire it into those mode_sets via
drm_setup_crtcs_fb().

If drm_fb_helper_single_fb_probe() fails with anything other than
-EAGAIN (e.g. dev->driver->fbdev_probe() itself fails), the function
bails out before drm_setup_crtcs_fb() runs and before setting
fb_helper->deferred_setup. The client is left with mode_sets that
have a mode and connectors but mode_set->fb == NULL, and nothing
marks this fb_helper as needing a retry.

__drm_fb_helper_restore_fbdev_mode_unlocked() only skips committing
when fb_helper->deferred_setup is set, so a later .restore() call
(drm_lastclose() on process exit, in this report) commits the stale
mode_set through drm_client_modeset_commit() ->
drm_client_modeset_commit_atomic() -> __drm_atomic_helper_set_config(),
which hits WARN_ON(!set->fb).

Mark fb_helper->deferred_setup on any drm_fb_helper_single_fb_probe()
failure, not just -EAGAIN, so restore keeps skipping the commit until
a later hotplug event successfully re-probes and re-populates
mode_set->fb. The real error code is still returned to the caller
unchanged.

Reported-by: syzbot+ca23c8570669ead78867@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ca23c8570669ead78867
Fixes: ca91a2758fce ("drm/fb-helper: Support deferred setup")
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Tested in QEMU (KVM, x86_64) with the syzbot C reproducer, which enumerates
a USB device over raw-gadget matching drm/gud's ID (idVendor 0x1d50,
idProduct 0x614d) then opens the resulting DRM node. In our test VM gud
lands on a different card minor than in the syzbot report since other
drivers (vgem/vkms/bochs-drm) register first, but retargeting the
reproducer's open() at gud's actual minor reproduces it directly on the
very first probe:

  gud 1-1:1.0: [drm] format XR24 little-endian (0x34325258) not supported
  gud 1-1:1.0: [drm] No compatible format found
  gud 1-1:1.0: [drm] *ERROR* fbdev: Failed to setup emulation (ret=-22)
  ------------[ cut here ]------------
  !set->fb
  WARNING: drivers/gpu/drm/drm_atomic.c:2031 ...

On the unpatched kernel this isn't benign: __drm_atomic_helper_set_config()
warns and then continues, committing an active CRTC/plane with a NULL
framebuffer, which escalates into a NULL-pointer dereference and a fatal
kernel panic a few lines later in our runs. With this patch applied, the
same gud probe failure (ret=-22) still happens every time as expected, but
restore() no longer commits the stale mode_set: no warning, no panic,
clean shutdown across repeated runs.

 drivers/gpu/drm/drm_fb_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index d4664ed468b2..0817b639b3fa 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1724,10 +1724,10 @@ __drm_fb_helper_initial_config_and_unlock(struct drm_fb_helper *fb_helper)
 
 	ret = drm_fb_helper_single_fb_probe(fb_helper);
 	if (ret < 0) {
-		if (ret == -EAGAIN) {
-			fb_helper->deferred_setup = true;
+		/* modesets are probed but fb_helper->fb isn't; defer restore too */
+		fb_helper->deferred_setup = true;
+		if (ret == -EAGAIN)
 			ret = 0;
-		}
 		mutex_unlock(&fb_helper->lock);
 
 		goto err_drm_fb_helper_release_info;
-- 
2.43.0

