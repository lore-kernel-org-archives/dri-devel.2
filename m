Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BAACA5FF0
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED56F10EAC9;
	Sun,  4 Oct 2026 17:18:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qOSkLJpq";
	dkim-atps=neutral
Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com
 [74.125.227.168])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D060B10E53D
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 12:42:59 +0000 (UTC)
Received: by mail-pj2-f40.google.com with SMTP id
 98e67ed59e1d1-3a7d725ca09so110271a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 05:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791117779; x=1791722579; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=96zU+qlaXFSgWiLmhC8ZDksn5OkhGICnqsZNjrDt1Ew=;
 b=qOSkLJpqiF/ugKLMI/vThYNce7EinefzRFyAcUJXT3jVsFZOmzRmiPdPbiefww+6SK
 zZ16Anrig4i62nfvIv7wLy10RE0vHI3Ysefr+bl53aNO+vkgc2U2xjX7l4DO84ze+a8k
 LAoFiVi8/6si/K6YBqmYBj5H+QAMxop9P3SdSecsJkpeLs17DmbMB23BjNwJRWbU5Ubt
 1cOVQzm59Zef0iG+OB0FiaG6xOzcAAb02pqrY/HZ7b9Hj1d0XmD76daN+gk0RUYJpyFM
 Xeyk5ELxH/3lIVeEw6m0v0DIGrECyxzNlcjtX1Qi7wKCKHanf6pKO/1w9JSlkKe57soY
 TqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791117779; x=1791722579;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=96zU+qlaXFSgWiLmhC8ZDksn5OkhGICnqsZNjrDt1Ew=;
 b=1NqPXttEaKCCTLks0PSMtw9HVBtNrpVQn7tdXXLQGmH3e+GOQet3nA3iS3PNvRL3LI
 juVIAZyKDM6MprTvn3Aedm2JOtahddRpVAY4StUsY6YBWfnC8Ov4t2sTMeEU7aUQBVb7
 CUL4bSp8xGf6JMOIulhsNWy12A6C8sy+XyfFBxXih9FnMXU4mbnTWOKYfuRA6xe+cG15
 YzZwYEpxFzkpUPbLgFQ1P4TDT2UJRJBfC7m8RLcW1MVWES4d1S8jt35iRFcjPGrjXA2+
 iDl9HDS4gWPu/33+s97tzN+H9WAnOm5wot4gCeFeJolWXZPTVTY5EZSvJx58Z1PzpsXO
 MHQA==
X-Gm-Message-State: AFq9FYLX/sJ28rX4zGieMXwN6WW74ut4fFY4bYyxRFOkymyrJF4nP4AN
 q4Ii4OzzQoXd2aFywIClyauEFd/VnkRyM8n0STxAu/hmT1zhXY7pRgni
X-Gm-Gg: AYBFou3umm/uRsY8z3ifCeiYKm6Lz8tjkhwEMgLWfYkYPpoZk7Mxnb6bNryboS/rGgn
 vpw5oJTlV39OBYkWiTd5LlUNFnGGS8z19Hy8SUs3BzPzwSKW9SR73c/NnbXrM0mjpigaUcZTK7O
 W318JcPTsgyt7Rv7ODoPIWwRwL4YnEyqL/e4OgF+JwgiK1hmCS8Qgl+uLdIjpEXdP0fq104egOe
 I43C0Vxw4AvjFFC7N9tFGBBHkhwBfVrsWyG8APrYlBU6pJF+Q3iL/yr6RqN/ilspiBdbdNCJqlM
 f0aln+c/Nx+llIipIlr6u+MI62X+43sd2A+adKVYW8nz4COANm2dw0bykHMb58O8Y21isHf7x6j
 UmA5bb9Vs03afJOqDNUmqR27dtoIFNPo/Yv9vPTlQIiI2mC1QVIFONHJ7OSxTzN3cwxSkRonzqo
 OhqzcqOwC6g11ShODbpfkyVTD7TQ6+ItKyYQSlgJOyTr8YA5jM4s72oxdP4aRb9014om57WBChq
 KYh2nWaun2I7rSolK70dWQ5UFbEZpDg1TB/rvUdzaTa+xngD5LwLTxKfmV2vTfV+hu3gd1Sn/L8
 eqyEAs/QqW4Hbf1YG2DwCY/eY+cFR/6LJxP4HWgTLBBU/j4=
X-Received: by 2002:a17:90a:d64b:b0:3a0:c22d:fbe8 with SMTP id
 98e67ed59e1d1-3a6ce7cea97mr5790108a91.38.1791117779256; 
 Sun, 04 Oct 2026 05:42:59 -0700 (PDT)
Received: from [192.168.2.3] ([2403:581e:d87e:0:fc2d:ed31:e80e:412d])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a78d4a5150sm6599177a91.1.2026.10.04.05.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 05:42:58 -0700 (PDT)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sun, 04 Oct 2026 22:42:29 +1000
Subject: [PATCH v2] drm/fourcc: Add Apple Interchange layout format
 modifier
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-apple-interchange-modifier-v2-1-410a3d0541f6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Nyw6CMBBFf4XM2po+AqIr/8OwgHYKY4A2LRIN4
 d8tqFuX5+bk3AUiBsIIl2yBgDNFcmMCechAd/XYIiOTGCSXBS8VZ7X3fRrHCcNXGJwhSxiYbrR
 WQuhS5QZSwAe09Nzjt+rD8dHcUU9bcTM6ipMLr/19Fpv3OxL/jmbBBMtNgfJkz1bx8toONfVH7
 Qao1nV9A+HaPonWAAAA
X-Change-ID: 20260830-apple-interchange-modifier-cbcc311c835d
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, Oliver Bestmann <oliver.bestmann@googlemail.com>, 
 sofus <sofus.c@icloud.com>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Janne Grunau <j@jannau.net>, James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2440;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=nlCjiAzhkYiQ1nYPrjHibWe7jNID9lKUBjiluobqAug=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDFmHPE9PuJ/F/EJMgFuYfdPiDvPE3GuOx7PCrG+Yb+tW0
 uQrj9XtmMjCIMbFYCmmyLKhSchjthHbzX6Ryr0wc1iZQIZIizQwAAELA19uYl6pkY6Rnqm2oZ6h
 kY6xjhEDF6cATLW/CCPD6Xkfzy/7amBv+qe3oO+KQs8S+13n5dJW155a96lHXkL1PSPDw1kc4Zz
 h942PObpoK8e+yIp62zmxYl1VO/+aFxMl7y3jAgA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

Apple Interchange is a tiled and compressed image layout used
for buffer exchange between Apple hardware blocks. It is
similar to the already-supported GPU_TILED_COMPRESSED layout.

Add a format modifier for Apple Interchange so that it can be
used for buffer exchange.

Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
Changes in v2:
- Fix typo
- Link to v1: https://patch.msgid.link/20260831-apple-interchange-modifier-v1-1-5d6e27f9f308@gmail.com

To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 include/uapi/drm/drm_fourcc.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index a103fdc0b3a3..d304ee5c614c 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -1626,6 +1626,26 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
 #define DRM_FORMAT_MOD_APPLE_GPU_TILED fourcc_mod_code(APPLE, 1)
 #define DRM_FORMAT_MOD_APPLE_GPU_TILED_COMPRESSED fourcc_mod_code(APPLE, 2)
 
+/*
+ * Apple Interchange layout
+ *
+ * Apple Interchange is a compressed framebuffer format used exclusively for
+ * sharing buffers between hardware blocks (GPU, display controller, video
+ * codecs) on Apple platforms. It is similar to and uses the same compression
+ * scheme as GPU_TILED_COMPRESSED. There is no known uncompressed variant
+ * of Apple Interchange.
+ *
+ * Unlike the GPU layouts, tile size is not dependent on bit depth. RGB
+ * images and the chroma components of YUV images use 16x16 tiles. The
+ * luma component of YUV images uses 32x32 tiles. Compression tiles
+ * are once again 16x16 with 8 bytes of metadata per compression subtile.
+ *
+ * AGX has limited support for Apple Interchange. It cannot be used for Z/S
+ * buffers or array images, for example. It is intended for scanout buffer
+ * sharing only.
+ */
+#define DRM_FORMAT_MOD_APPLE_INTERCHANGE fourcc_mod_code(APPLE, 3)
+
 /*
  * AMD modifiers
  *

---
base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
change-id: 20260830-apple-interchange-modifier-cbcc311c835d

Best regards,
--  
James Calligeros <jcalligeros99@gmail.com>

