Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E645C79F95
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 527CF10E46D;
	Sat,  5 Sep 2026 15:04:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G97aM5vn";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B85910E273
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 10:35:48 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-482f2ee53e7so1286053f8f.1
 for <dri-devel@lists.freedesktop.org>; Sat, 05 Sep 2026 03:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788604547; x=1789209347; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VJDdbsg84+qh/sWYdUP/IhYfrbB3wqJKGfShDqyhgkw=;
 b=G97aM5vnd1KzWsaGkoXxk5Ndwgan/Pr5ExsmAo6sJ7UCaHsVk+coaalDw87fmIL4dK
 yMALBhUsI8P1N24vc72bcyljMRNQLvxWyx/dzb5gf+smTEXCUhVDZ/U0UuXB/oYeQ7f+
 XMd2/y3eWFArhQjnmPsKKnw/6ODS1DQLxj6vNmghNkVqGyNEFkIn9j5A5E65FFs6s9LR
 mJJYfeJMVWhfs1VVXgIyzB/POGg6wMLbLIXSs3CGrE7AwbolULIdiSB1B7DbZK40Oaui
 fDZBX6ia5xpWTU/rw+loVA7vpa3c4CgxsRqMOAwwIaqUbUU0ZzlbkLCeXHVkvuk350lE
 iHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788604547; x=1789209347;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VJDdbsg84+qh/sWYdUP/IhYfrbB3wqJKGfShDqyhgkw=;
 b=SSHGP2KoDMgqakraslSWe3+HGwgx6sxI056REYGBSiz9YsIvNktYJzRpFkDvfIQWe5
 6Y6/xFYbN9qFF3D5Tl0VXifAxwbEDr8wgwVcifPEdMxB+B4bEnH16zSNx2wjS+zLB4XS
 boPRgCgrOshP5w9uy2sOPL11+/WQaJkI0OhxYQZti1ryFogRYhk1hciZIR3oKtN85lwi
 cyyfvU/M7yDyWy5ogWPonfqaS5YPKv1ADBzh0nXfgDkPYl5CuUCXCR35vJoRmat2qMA1
 vkU2w9Cn+Wx2Pg2EQl83bEGuVtulozYXaBfDOyA6NYEZfnNZIJp3dlYlLDM7pJS+qXmK
 cmhg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgZu2R+DZ3srbCl+amKex+zwg2t6F3nP3Is4Wk1NW8E5vcSQIJ2IxP/dnFowYj6bCnPnLS9ky6RK8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lcDZuV7VsicGdnK6SbTNHzd479HOPTBqv7BLt6C3COcgL1gfuW
 YZzff6mPx22kgXPjC608EGWKPHMoswDC7dXw/P6n5QL/U3yMcB7xieYn
X-Gm-Gg: AYBFou1kRp6uzBZsFqYCXD7jP30hvRUDGScaYqdvRPv4Pxroi2iXPvhzx8BxOBWcl4n
 KH/ew8CY9YThbHnyV1i7o165VeRz/64f1ApWJt8oIAshOcaw7cOpShY9gKkf6+EvMUL+wtCbTEF
 l79fZc2n1RjEEusDxokrMhBB9nhiMf0E8vZvLh0TwDVy1XAh+52NaXzrZMXTUEi/i0cY4piY1Wo
 nIkUny5/KGTx1EqWtuLdKeoXVQ7ix9Jh3PsEDbMH3SaXu0fEQ2P8ldgVB0zl4xio+3XgKG1nQmu
 8fV1qfEZAafPpbWYM2+ghyKj1ybaPGdLFw2zt7/fMHkNXSJ2Ul7wfft4wp8/K3ECwkieJ2r9Eq4
 E9C4jW5buxO6jZ5oVrpSUo8+3WNqMK5UKeFIs2HPs7dUrad5TLbIzIjcxms+mznG84s/qD3Cg8f
 J9wbYP/fWmf1qz4fjgmuvUP7U10NAPW5ZTLUhQtSibh30d68/irKs+EHMJVaI5K7YsKod6QpD8V
 09g12W+OxgSROal8brFKUFW7mwDifQph6lfj6BnbDU0cOqKdDS4LVMpcHB3Bf3DVFWPf4Pk7HiX
 W5ae4xb6jy6P2igoTHEz/giylga2oKvcNtBh90n7ylQO2YVBLIB1hfcSq6wVYMzfoJ2DdH/QTXe
 BfA==
X-Received: by 2002:a05:6000:2287:b0:485:8c17:975c with SMTP id
 ffacd0b85a97d-4858c179908mr8526206f8f.30.1788604546381; 
 Sat, 05 Sep 2026 03:35:46 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de.
 [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485881353e8sm13302083f8f.1.2026.09.05.03.35.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 05 Sep 2026 03:35:45 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, dri-devel@lists.freedesktop.org,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] drm/doc: drm_wait_vblank is a union
Date: Sat,  5 Sep 2026 12:35:42 +0200
Message-Id: <20260905103542.43360-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:13 +0000
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

drm_wait_vblank is a union of the request and the reply
(include/uapi/drm/drm.h), not a structure, and has been since before
commit 2d2ef822758e ("drm: add initial DRM developer documentation")
wrote the sentence.

Say union.

Fixes: 2d2ef822758e ("drm: add initial DRM developer documentation")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/gpu/drm-uapi.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index 93df92c4ac8c..b08d731a093f 100644
--- a/Documentation/gpu/drm-uapi.rst
+++ b/Documentation/gpu/drm-uapi.rst
@@ -707,7 +707,7 @@ VBlank event handling
 The DRM core exposes two vertical blank related ioctls:
 
 :c:macro:`DRM_IOCTL_WAIT_VBLANK`
-    This takes a struct drm_wait_vblank structure as its argument, and
+    This takes a union drm_wait_vblank as its argument, and
     it is used to block or request a signal when a specified vblank
     event occurs.
 
-- 
2.53.0

