Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F858CA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D7E110FEF4;
	Fri,  9 Oct 2026 07:17:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.b="Nf/2P4xv";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 886BA10E91F
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 19:13:16 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-33fb4680717so2079381eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 12:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1791486796; x=1792091596;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IWU3gZsRjQK7kls2sJA9yEwySYblQEWHXA6BXaEKqjg=;
 b=Nf/2P4xvFiuBuucQuR/G5lH+HmRXNEMtKkA9melOt4ilHboGGo+rPmwCXJrwcgck7M
 S0/Bh/6cqjxH2QZXOkZf8DRYUD00vp4BoxbAKbkQEPP6/qV/KsRYxH1M3WGuqBPV+NEj
 LnIr9o/pNgQNamyzoCkcJyLpiPY/zBdEM+QKNMmKLz/Gq/pFJQ2Ce0bXDFPWEI5rUbEY
 GJHagegqx0GPi0O41rGrUC1RygJm+rtaJOx6rs7sFm/Uc09ymAyXcp+XOltoyOaeHVSO
 95G8l/BrwgwZKLUv1uuVULR+1TRnAnXZoNIX/dTloGYKDVMJc3b7rM5ZY5Y3a3it2Qvp
 QI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791486796; x=1792091596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IWU3gZsRjQK7kls2sJA9yEwySYblQEWHXA6BXaEKqjg=;
 b=JZBezJXRpbsm339cQLoG6Gs0IleyDGLFbsdFcFkkLBB+Ng5ZnzL60lKAr/8LKS1biH
 N0viSXi70IRIMEc3ZNa+6K/zE1QLGNrbko13N8tbRqzyFwT45EXmriR9y7vs0xGPJJYc
 lffu05QJC2HEFANJpjstxHhEQ4VY0B9u35iui4BgVjvTcnv4iUNgeTGaX6MarYBO88B1
 vzvRiW2idFdRwFa1e+7GuH/7yGRNqUCBXWcEogxlIvFvJyPf9hQSETH5qpPtQvL4w2xf
 VztlfPO7NGTllu4Ikf2QaDCH2tdhItPjgHF6s8xvR+fJukugkrOw6M0e3hQdJVDhcXhe
 41Qg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8FxLH1Xs/oNJYCB7FcfqyWNkiseVLeZYlDESNZ8bL6K2xKVsua7q+omAT7ukUXgGMOz7ek+bIh/Q=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLowSYvgRlBglXww+TNxXEpTOdvJ7WaM/+oiu2/mL1rVOlz04Ms
 5kmSxjNcVY9GX7ABLOBLRMGae2M+RME+OoCA1LJwUCqxzomLDNP3VxXLvAvXMqV1BQ8=
X-Gm-Gg: AYBFou3fl6Nv28g+Lv4mq8C5xvPekVXJZJs6fSDQIYN8a/WK6XvLcEd6YkOMLkWRmk6
 2aXMNaod2Fbt+hm/rPPMub/69fYDOhQ2n45M/7t8Y74nBS0JDoEgK25BiIQIMUarHya1HQ5/iqU
 xfWN18ymetFYNc47yrGoQQK29USdiSiufGz/ww5q68NaOOnU9bRWW528GKxF5vdkQdQlTd24Iby
 KqO+oTPqayvcmGtlyLe3qkLLtkz7Fhbx0+bh+Og0e+HKrGn5uoDqEj7WT52bjh0W3Jn/xvndsT4
 cfc9znWuYsCGOEy3ChhWGXqFZelXV/wDUfRVNblstEVnCP8mAewTqB377uAmWG8nyzVHnHw3Sfo
 P911DxFLQ+yf8NFeRqYAYPWEJ9JOQqUznGqQKZvBgd6YI2z2vDyi8v8FOsh1qifqOGXIhNJx6fk
 xCWBGu2x+XVUYLml7Two3sPS4cq7lJRa3C3V7K36TjMTUKUUYMLeeRLvvw0gnBk7TNl1CZJd2d+
 ECi28LJZUXlqagZhSfn9QGk5pmFV/SBckpJQK5V2CmthkJcVolu3MZYZMU/vKmLve1EDDE=
X-Received: by 2002:a05:7301:b8b:b0:351:78e9:944e with SMTP id
 5a478bee46e88-35178e99942mr4032116eec.41.1791486795573; 
 Thu, 08 Oct 2026 12:13:15 -0700 (PDT)
Received: from localhost.localdomain
 ([2603:8001:5f01:8bab:bc88:5ec1:4f8a:5b23])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841579sm94214eec.4.2026.10.08.12.13.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Oct 2026 12:13:15 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Helge Deller <deller@gmx.de>, linux-hyperv@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: [PATCH 6.6.y 2/2] fbdev: hyperv_fb: Allow graceful removal of
 framebuffer
Date: Thu,  8 Oct 2026 15:13:05 -0400
Message-ID: <20261008191309.98263-3-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008191309.98263-1-artem@trailofbits.com>
References: <20261008191309.98263-1-artem@trailofbits.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Oct 2026 07:17:39 +0000
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

From: Saurabh Sengar <ssengar@linux.microsoft.com>

[ Upstream commit ea2f45ab0e53b255f72c85ccd99e2b394fc5fceb ]

When a Hyper-V framebuffer device is unbind, hyperv_fb driver tries to
release the framebuffer forcefully. If this framebuffer is in use it
produce the following WARN and hence this framebuffer is never released.

[   44.111220] WARNING: CPU: 35 PID: 1882 at drivers/video/fbdev/core/fb_info.c:70 framebuffer_release+0x2c/0x40
< snip >
[   44.111289] Call Trace:
[   44.111290]  <TASK>
[   44.111291]  ? show_regs+0x6c/0x80
[   44.111295]  ? __warn+0x8d/0x150
[   44.111298]  ? framebuffer_release+0x2c/0x40
[   44.111300]  ? report_bug+0x182/0x1b0
[   44.111303]  ? handle_bug+0x6e/0xb0
[   44.111306]  ? exc_invalid_op+0x18/0x80
[   44.111308]  ? asm_exc_invalid_op+0x1b/0x20
[   44.111311]  ? framebuffer_release+0x2c/0x40
[   44.111313]  ? hvfb_remove+0x86/0xa0 [hyperv_fb]
[   44.111315]  vmbus_remove+0x24/0x40 [hv_vmbus]
[   44.111323]  device_remove+0x40/0x80
[   44.111325]  device_release_driver_internal+0x20b/0x270
[   44.111327]  ? bus_find_device+0xb3/0xf0

Fix this by moving the release of framebuffer and assosiated memory
to fb_ops.fb_destroy function, so that framebuffer framework handles
it gracefully.

While we fix this, also replace manual registrations/unregistration of
framebuffer with devm_register_framebuffer.

[ Backport to 6.6.y: retain explicit unregister_framebuffer(), but call it
  only after delayed work and the VMBus channel are shut down; defer
  hvfb_putmem()/framebuffer_release() to fb_destroy. This preserves the
  upstream teardown order without requiring devm_register_framebuffer(). ]

Fixes: 68a2d20b79b1 ("drivers/video: add Hyper-V Synthetic Video Frame Buffer Driver")

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Link: https://lore.kernel.org/r/1740845791-19977-3-git-send-email-ssengar@linux.microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <1740845791-19977-3-git-send-email-ssengar@linux.microsoft.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
This is patch 2 of 2 in the ordered 6.6.y backport series.
This change addresses CVE-2025-21976. The target remove path unregisters the
framebuffer before completing driver cleanup and then directly frees its
memory even when another open reference keeps the framebuffer alive.
This needed a target-specific adjustment; I called it out in the bracketed
backport note above.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.

 drivers/video/fbdev/hyperv_fb.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 80e6d9682179..e0d68953aa1a 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -283,6 +283,8 @@ static uint screen_depth;
 static uint screen_fb_size;
 static uint dio_fb_size; /* FB size for deferred IO */
 
+static void hvfb_putmem(struct fb_info *info);
+
 /* Send message to Hyper-V host */
 static inline int synthvid_send(struct hv_device *hdev,
 				struct synthvid_msg *msg)
@@ -887,6 +889,17 @@ static void hvfb_cfb_imageblit(struct fb_info *p,
 					       image->width, image->height);
 }
 
+/*
+ * fb_ops.fb_destroy is called by the last put_fb_info() call at the end
+ * of unregister_framebuffer() or fb_release(). Do any cleanup related to
+ * framebuffer here.
+ */
+static void hvfb_destroy(struct fb_info *info)
+{
+	hvfb_putmem(info);
+	framebuffer_release(info);
+}
+
 static const struct fb_ops hvfb_ops = {
 	.owner = THIS_MODULE,
 	.fb_check_var = hvfb_check_var,
@@ -897,6 +910,7 @@ static const struct fb_ops hvfb_ops = {
 	.fb_imageblit = hvfb_cfb_imageblit,
 	.fb_blank = hvfb_blank,
 	.fb_mmap = fb_deferred_io_mmap,
+	.fb_destroy = hvfb_destroy,
 };
 
 
@@ -1246,14 +1260,11 @@ static void hvfb_remove(struct hv_device *hdev)
 
 	fb_deferred_io_cleanup(info);
 
-	unregister_framebuffer(info);
 	cancel_delayed_work_sync(&par->dwork);
 
 	vmbus_close(hdev->channel);
 	hv_set_drvdata(hdev, NULL);
-
-	hvfb_putmem(info);
-	framebuffer_release(info);
+	unregister_framebuffer(info);
 }
 
 static int hvfb_suspend(struct hv_device *hdev)
-- 
2.39.5
