Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15437CA6004
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:51:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31C8810F5DD;
	Wed,  7 Oct 2026 13:51:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T46J/Hqq";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7756410E3DD
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 09:33:37 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-ccce967aa8dso1584612a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 02:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791365617; x=1791970417; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Vy63mdqIPndIk85N+xwyTXgE3amsDxjtRy55K/v9EX0=;
 b=T46J/HqqA/kIf+HJLRwzHvk9o4iShIR4XcBCEcjIinMiIsN1CN7/4IFL1p8po2OWXf
 culzApp4tIhNXaJmkQFvKwL3xSLUfoJrZqAmL/2CNYRG5eptEWPSaYBC0/Lrhp9XvC4t
 7WNRef8wPLjARUryTxO6tFnes0wnwS0FvzZa2k315djIw4yI1nS7KyW9P63z50LTaAOM
 Sot2q7iaeySog6fiBqpo6zjrXhpJNZI4GNj/x3SdFfVfaGYOEOx+Er4QzmuwCkzFpVP9
 p0/tNt7kPi1+2gI/eBszJtcLawZ++2NVkLK2rPCj21p2NHKlmYCu4pSzW7aptjTJrIlI
 ZK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791365617; x=1791970417;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Vy63mdqIPndIk85N+xwyTXgE3amsDxjtRy55K/v9EX0=;
 b=Moc3o9bO+mQf6XDNFSC0id0yAtG64u6c2KMv4ouAGcUJ3GAYQGD5iDL5KMjT7Gaw0W
 pNqWUIAL4QFqh4AriQ6Wc03eV5bk+9Pr8SAVTF0r7k4r99Frsc/Of3kMGXcWhpC+xMsI
 OM2kBU0czs0c0NJ7NCup9xipxTdPtuzPAq8aId6DHjFjfNFpVlHd9icc2YOX+jXLklLW
 1LviZwKpi8tObp4cZx1qLcM530kTRicX92vQYc2+zRjJ+Fq1mtUFxidhzNEUFhz43swV
 qg+8z8Y9wLCWuMfupa2t3I/3LBqFwREbvkaAobSsJ4UCzUzfbCu3M/GAprSZ2ChTUOrB
 m8Zg==
X-Gm-Message-State: AFq9FYK3/zq3YvwUP8d+C4v7TOY+vGRBPDHvSxyTFHQ3H0cDCjh71irv
 xkncIfyRYMbaYixO+ngNGQ5j32YKGDrBfoQ+l2HmVD0VgQk5sp70nFSs
X-Gm-Gg: AYBFou2VBTKZSFagi/w2TtXmwHXeFoael9ZzUrMs5LeXH5K5Oeheik+CtHE6vOS88c9
 QZPDcEz7WClaeaZGgZNFlOdcu1yjlG0hhdsGIlOl4flMJA/VZH0EKPC6LUPURbHl85qOV0fCmu6
 M0yMKRypg/X2D1jENmEJ1ex0OVsXVyMGC8ZzHYuNGb7/T2YzKvRKlCu1v6YemElafUkMm9y2TDK
 LaP7LNU/HJBdMtjkTD5o5ix7D9N48TQkdNAa1FLI6R6WblTEQJLI+tbqhkgFallbiNgy0kX0CF7
 uwQOP+Wx2Ih5Y2R7AoVmXix5sqm7oOWQzK23LNZbXLhzGE8HN5bHvqL+29pxmtoqJ6apj/TfMzZ
 UqNs6x6AvcSYX9ivTFaSPMurwVRflzGgb79HPEsUPJwS25UXqqQN9GpF8xTmgTvn4cPN7rKl78u
 s10pZ04LrqUFKaI36R3xti3See4ZZ7WdrX9GHTq9FCl2OLVWIJGeikKZkQan7sZdVGqu/FCyNAH
 0z9Uo5MzvF4n4JCkGHicGaM5kkJl7NSZ8Dqdt0aSOuX/m1ObsXwx8505kYAL2aBpHKiiSY9Ss7b
 ym4+5Am0b04Q8JKx9lAXlY1fLC4Wh20lUpbUZfnYD4ax61NLNf8Ig2azmg==
X-Received: by 2002:a17:90b:4a86:b0:3a7:f64f:6473 with SMTP id
 98e67ed59e1d1-3a8a1be69d6mr1440644a91.50.1791365616910; 
 Wed, 07 Oct 2026 02:33:36 -0700 (PDT)
Received: from [192.168.2.3] ([2403:581e:d87e:0:fc2d:ed31:e80e:412d])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a853e662a5sm9119994a91.4.2026.10.07.02.33.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 02:33:36 -0700 (PDT)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Wed, 07 Oct 2026 19:33:19 +1000
Subject: [PATCH v3] drm/fourcc: Add Apple Interchange layout format
 modifier
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-apple-interchange-modifier-v3-1-721fc44abf6b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Nyw6CMBBFf4V0bU2nBURX/odxAe0UxvBKi0RD+
 HcLPuKK5bm5OWdiHh2hZ6doYg5H8tS1AdQuYrrK2xI5mcBMCpmKTAme930dxnZA9zk0nSFL6Lg
 utFYAOlOJYUHQO7T0WOWX65v9vbihHhbj8qjID517rvURlt83BFuhETjwxKQoD/ZolcjOZZNTv
 dddw5bQKH8qECLeVMmgikHkyogkBpv+q+Z5fgEOhUYuIQEAAA==
X-Change-ID: 20260830-apple-interchange-modifier-cbcc311c835d
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, Oliver Bestmann <oliver.bestmann@googlemail.com>, 
 sofus <sofus.c@icloud.com>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenz.ca>, 
 James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2877;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=C3V4UXgsMyjfls0kAgGHGbnZQnqSrUwTQ3JG/daKfzg=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDFnHBF/88+VblZ+1TMx8yeJ83+NmB837n12arO/f7q3Vm
 Xw0OO9/x0QWBjEuBksxRZYNTUIes43YbvaLVO6FmcPKBDJEWqSBAQhYGPhyE/NKjXSM9Ey1DfUM
 jXSMdYwYuDgFYKpZKhj+Wbsab5+a0sgcHXn+o20uo7j+PPcyxQCZoK4qtZzv6cc5GBnuqXKZ597
 SvBPqMTfAw9O9rLVdyZO9I/oda4RefVNvDSMA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960
X-Mailman-Approved-At: Wed, 07 Oct 2026 13:51:21 +0000
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

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenz.ca>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
Changes in v3:
- Explicitly mention lack of stride and single-plane treatment
- Pick up Alyssa's R-b
- Link to v2: https://patch.msgid.link/20261004-apple-interchange-modifier-v2-1-410a3d0541f6@gmail.com

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
 include/uapi/drm/drm_fourcc.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index a103fdc0b3a3..0bb049f91524 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -1626,6 +1626,30 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
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
+ * Following the example set by GPU_TILED_{,COMPRESSED}, Interchange images
+ * are treated as a single plane by software and do not have a meaningful
+ * stride.
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

