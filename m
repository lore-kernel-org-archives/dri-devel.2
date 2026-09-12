Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D803C88E56
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 21:15:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D601210E045;
	Sat, 12 Sep 2026 21:15:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=asu.edu header.i=@asu.edu header.b="gvrqiCfL";
	dkim-atps=neutral
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBFDE10E045
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 21:15:18 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id
 5614622812f47-4c3eeefdf2bso1902683b6e.1
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 14:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=asu.edu; s=google; t=1789247717; x=1789852517; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jn+jkXZgmdqQdeTiGXA67KlphU8PH0hw9LcDIFI9mXU=;
 b=gvrqiCfLQk+DOXdQKU9vOkmO+SrmAcZiAN1D7mflGqlSxMkLL54D57R1nUTOhEtA5v
 d+fu+xEqZUQKd38WOvPyGGY6KnUdT4Egf56QPpgX96d+BEX4y6DDd6T3LDFa8pUQm4L8
 Rq+pPfgfyZpa6aSKyU2zKbgHzHNRQs32We35p/Mxv9PZZJy0wKo04Gza19A++QUpawI3
 HtSWt6yXL9QAAVHsUrtrkax0WOTcEcED3UwsTmdL9QFCUFo4lE6aZAhdReeoZGhuTrSo
 v9BwguFxqRg5kic/yP9Hzc7ybBPOGGt0cqzroxRygxG2XhqG7xRoxfMxTYNlZHPzbpbS
 UpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789247717; x=1789852517;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jn+jkXZgmdqQdeTiGXA67KlphU8PH0hw9LcDIFI9mXU=;
 b=dNWJ65RSM3+Zd8lx45qMbr3w0wEK41875GgbBh2Jq2GY4hrxml1kCipWyKq5g6UpeC
 Uh66gwL/qAfVvO1XkFdwixcop+wXhH6w9lum3/5k/DNZqjoO6AYAft8s5hhveWYipToB
 FM/BuAG+I8IeWLgT+fJOQOn4X6LTNPO1H/7yhwrVEBfBpGye+dRQlJ29R+p7+iY3R7dp
 13cziuyCDab57p4BNLNgPffgRBjNDe8e73lTUOxlPxlin6ZEudeE+6Ifb2nobYLMrEE6
 me3kC+c0TCzKnlO6eFZ3kG5uY4ynXoECI0uGbJhb14K09IUHD0+GV4cc000Ni3M3rUIH
 DItg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzi3I0IdNM3F8ASdaDbpbr9VZ9b4NFzWjgmqprvA+yTFcW/3bQVUDc43MOeSSXUG5ATPiNRytUBHQg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kYfAp9qqPnb+Rii2OccY8a6PBMI4y6CUb7q+JhfjHxW4L+zUx6
 CsZxBE0mT1oqeMfUnhmucvG7gZq8BOVh5fF97iyvvAIWOptLg6SUzSlmPXl00z5JCA==
X-Gm-Gg: AYBFou0OkwWrvwGHOqaS8H/bsHP8mVyZAs48YBG2UyQjIdHzIX8NkcSPhIl8BjPmONm
 iL1/mX0PpKNeDa9EdU+tOAikrH3U5iqFZNilDn23+yAzBo4Cud+dA9nsYWBPv/sSexC/06iA3+D
 XJszRs16wQ29cgJ/Xh+VqAGXYStEJDZ9krO9tKTYXxi7wIgwZ/CJxYFqDnz1xMdaBp4oe8a/yXG
 Lob+KQoEPvreNQZBB8rsabcG7CodixtiBWZvztI20+q8bsv+x24TmCrNmSW/Qb5yfgCJEOgCGk8
 z0rz2PliGwQBoigsN7gLM1qORTrXb4HADUiyGD4E22xfjBbBv0Rwx5kmLmypkzkmt7S4TkFo5Cd
 Vh7LZ8GhNX69eRmm4ePFHP1rBZjnXU+7kHVpvFwNAl6lY2gUU0ukDD8AcRVFMJ66J8EGeEWAKNr
 5zjk0+ytiXnefGrNXOH/q2zGucqTzM5LY6uTPzZsVcmg7oV8VWsctrbwEFbeEyGOmdDkIRTR4x0
 lTWdA4fNqFsAt2XFPNHB6spsyDXWgHaJojdfcPaRGelclL5oQ==
X-Received: by 2002:a05:6808:2224:b0:4c3:cd49:bbf7 with SMTP id
 5614622812f47-4c3cd49bf95mr7236782b6e.42.1789247716315; 
 Sat, 12 Sep 2026 14:15:16 -0700 (PDT)
Received: from p1.. (209-147-138-4.nat.asu.edu. [209.147.138.4])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c331bc937bsm6003521b6e.11.2026.09.12.14.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 14:15:15 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: bernie@plugable.com, deller@gmx.de, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: gregkh@linuxfoundation.org, co+ed9902f2e44184d9@bugs.sh,
 Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Subject: [PATCH] fbdev: udlfb: don't rebuild the mode list while the
 framebuffer is in use
Date: Sat, 12 Sep 2026 14:15:12 -0700
Message-ID: <20260912211512.2049147-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

dlfb_setup_modes() frees info->modelist with fb_destroy_modelist() and
rebuilds it, but fbcon holds raw pointers into that list in
fb_display[i].mode and nothing un-publishes them the way
do_unregister_framebuffer() and store_modes() do with
fbcon_delete_modelist(). The function does refuse to install a new mode
while the framebuffer has users (dlfb->fb_count != 0), but only after the
list is already destroyed. Reached from the 0666 "edid" sysfs attribute,
an unprivileged write to /sys/class/graphics/fb0/edid therefore fails with
-EINVAL and still leaves every fb_display[i].mode dangling; the next
console switch reads the freed fb_videomode in fb_videomode_to_var().

Test fb_count before touching the list. fbcon takes a reference through
fbcon_open(), so that condition covers exactly the states in which
fb_display[] points into the list, and the errno returned to userspace is
unchanged.

  BUG: KASAN: slab-use-after-free in fb_videomode_to_var (drivers/video/fbdev/core/modedb.c:905)
  Read of size 4 at addr ffff8880107b449c by task kworker/1:1/47
  Workqueue: events console_callback
  Call Trace:
   fb_videomode_to_var (drivers/video/fbdev/core/modedb.c:905)
   display_to_var (drivers/video/fbdev/core/fbcon.c:998)
   fbcon_switch (drivers/video/fbdev/core/fbcon.c:2182)
   redraw_screen (drivers/tty/vt/vt.c:994)
   complete_change_console (drivers/tty/vt/vt_ioctl.c:1141)
   console_callback (drivers/tty/vt/vt.c:3358)
   process_one_work (kernel/workqueue.c:3396)
   worker_thread (kernel/workqueue.c:3479 kernel/workqueue.c:3560)
   kthread (kernel/kthread.c:436)
   ret_from_fork (arch/x86/kernel/process.c:158)
   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
  ...
  The buggy address is located 28 bytes inside of
   freed 96-byte region [ffff8880107b4480, ffff8880107b44e0)

Cc: stable@vger.kernel.org
Fixes: 7d9485e2c53c ("Staging: udlfb: Add functions to expose sysfs metrics and controls")
Reported-by: co+ed9902f2e44184d9@bugs.sh
Closes: https://lore.kernel.org/all/1jSCSNaDKmuUG7h40rTsSl1rMaSwdlJef4rp%40bugs.sh/
Assisted-by: Claude:claude-opus-5
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 drivers/video/fbdev/udlfb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index e78d6f95c9c5..92b352bc7e96 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1293,6 +1293,11 @@ static int dlfb_setup_modes(struct dlfb_data *dlfb,
 		goto error;
 	}
 
+	if (dlfb->fb_count) {
+		result = -EINVAL;
+		goto error;
+	}
+
 	fb_destroy_modelist(&info->modelist);
 	memset(&info->monspecs, 0, sizeof(info->monspecs));
 
-- 
2.43.0

