Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B205CC79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:00:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6C6210E66D;
	Mon,  7 Sep 2026 07:00:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LKSBLM4r";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B339E10E108
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 17:03:52 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-484392e3d33so1771605f8f.2
 for <dri-devel@lists.freedesktop.org>; Sun, 06 Sep 2026 10:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788714231; x=1789319031; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=THUyQtBNkmYvdRFdNm5FE+fhYKPDNfLX377CAHW/VUc=;
 b=LKSBLM4r6vAhDDvmOgx8k10zxjHNljSk2MBWvKfQON6hm4ew12U6hhSEd2vMcgUwBk
 liBiqjvGlmd6q5rXQkL9S9wDy8nUgUOrD35u95YMuZ7S1sBlWLclGfqOV7TR/TQnZ1By
 2SAPlzFTaVVe6hbkqzSEQAf4nYP7UnzED0GPp2l7MCcoKa3Sb/tJmDx3bejRR5oAkCc9
 kFrw23m6Ilg/1P0A3/xRLVETiMSfVMCJQdPhyeMewW1fcd2P69bJPH9uN2wI/SjQzkN3
 s4kJ7mfJ6K56GJjaZeMmK9m6oMn3aMvxnlsZgGOEzPUsK42Tb59m5Fhico9uWpItRJK1
 G9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788714231; x=1789319031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=THUyQtBNkmYvdRFdNm5FE+fhYKPDNfLX377CAHW/VUc=;
 b=GUBvJJ7CKfb/Fz08ukslvTGLPELKfD2P2gnx09evFzaK3TASrS9qh/pty38DD5UbhM
 KaMe+Fa+YIwr8kCt2O/1KovRxQXfBNvHlH1VndDH+s+TuanqslwYFz0BXx08baTdv/xP
 oYxShSJQxqgc5vcrKa00Sn4/hxOkt7UdvC4yR6cTPUpr/+EhfT5ai2sSqcIbLD52cQgj
 iU2u9jjUVgXk3tC/vAQ2uMu4dKFmojiJVCfPUiql9yZzFQIinyeMEwo1E1SYz13WRB3o
 RG7hIgzH4RCLgKBWt/a3iqtz9un/DbJ2Zn9SjlGGb3xcpvMwHoR8GNSqsCOrcQlX3bOS
 EZlQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzEKAp7sysGe6kAfJeFTV2kvdjvLuQVoUP1qBNkHjt/f093WQiC6O93YPYtPFE71FBiYyUmQUMxKmQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lQAU5dfdKMZ82MFph4OSvbYS/knmEhCQdR0Zc8q8w+Dw9FEY6r
 X6TpJv7c1DEpOotQuux8DpxvCWKbdWRj72lWj/5pqunM4Wbn4CwgBvqI
X-Gm-Gg: AYBFou1bRlP1/X/oStHU6G5iSgVDcVcpHpv72zMwYc6FnAWH8ZdGRr3ETqxKgE1D8Yd
 BrbiVzF1s8awJQRB/te5Kx3XZRZDSpG5FBYybwcsgo8l5shE56XJGf/F2DjX+OfBcnUSF26WuJu
 l+pPFWF70vr4HO4ZIVii4Gr6D/MSpEqN+xAWXlYaBohocMPvDwljBaoctWSEzPJghvv6t2GDPC/
 SJjWSqhNkFBVONkcjGJijRDTyWbMptd27VvGAFpLwn2mF4eW0suTMq8w9v5WvcdkvkqMg7w7nsV
 2o3n1xHq1Q/v99sfZ9K6y9xhzei/+8vf+fIwLpa/cNxOSbPr3+0FTFSlf7mXnUU9cloun8BuzsP
 psV8mKFu2DtcKXRlX0lTbaJd4te/GWqHidALg/+10B8yxqY69pO2L2Qea/rP+8w/kBEEYBAMWya
 6oDm5XViQFn9qilZ5c3GfaEUKdKAFmI5V7DcNIhXeT06A6w3QO0CV0RHyYJeu9SpxeXQrEOXJXx
 NXf8Z2BF57kcUDq4eDelnun+tp38QPxghcqvJqOMwT8nPkkpy5Bk3SAZesWazXnOElpOJcZQxbj
 TCq+Q7HT6qQR2mvu8krfPVDO5sBKLlGyn927uIu1fQV4OOGe27UaQMwh3slPYaX1FlnwUxRc
X-Received: by 2002:a05:6000:41db:b0:485:8c17:9768 with SMTP id
 ffacd0b85a97d-4858c179982mr14761414f8f.42.1788714230809; 
 Sun, 06 Sep 2026 10:03:50 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-9d84-5101-9c80-d25b-14b6-410c.310.pool.telefonica.de.
 [2a02:3100:9d84:5101:9c80:d25b:14b6:410c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885bf3f0sm24566946f8f.33.2026.09.06.10.03.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 06 Sep 2026 10:03:50 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
Subject: [PATCH] drm/msm: Fix the separate_gpu_kms parameter description
Date: Sun,  6 Sep 2026 19:03:47 +0200
Message-Id: <20260906170347.2427-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 07 Sep 2026 07:00:30 +0000
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

The module parameter is separate_gpu_kms, but its MODULE_PARM_DESC()
names separate_gpu_drm, so modinfo describes a parameter that does not
exist and shows no description for the real one.

Use the parameter name in the description.

Fixes: 217ed15bd399 ("drm/msm: enable separate binding of GPU and display devices")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index db1b655dd055..f3d2eaa04f14 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -55,7 +55,7 @@ MODULE_PARM_DESC(modeset, "Use kernel modesetting [KMS] (1=on (default), 0=disab
 module_param(modeset, bool, 0600);
 
 static bool separate_gpu_kms;
-MODULE_PARM_DESC(separate_gpu_drm, "Use separate DRM device for the GPU (0=single DRM device for both GPU and display (default), 1=two DRM devices)");
+MODULE_PARM_DESC(separate_gpu_kms, "Use separate DRM device for the GPU (0=single DRM device for both GPU and display (default), 1=two DRM devices)");
 module_param(separate_gpu_kms, bool, 0400);
 
 DECLARE_FAULT_ATTR(fail_gem_alloc);

base-commit: 986c24e0fe44f844b44d365b71ce831947f50298
-- 
2.53.0

