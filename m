Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C23C982D9
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:10:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EC5010ECC1;
	Fri, 18 Sep 2026 07:10:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p7d9p4Qq";
	dkim-atps=neutral
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F32F210ED73
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 10:49:51 +0000 (UTC)
Received: by mail-pz2-f41.google.com with SMTP id
 41be03b00d2f7-cc4c3304833so486647a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 03:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789642191; x=1790246991; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JgGGToNc2v5pflrpzy2awJuFvrt52U0TkSLrIqd2nHA=;
 b=p7d9p4QqSRDUHFvP+M9HWb+QxrB8Q3XDFRGMaI1hSHb9jOhXbH0H45+0zCqkZR4R+C
 ZhH3eYLnyKkCEUtTf8ZZjmd1V8+5jHGSKmAKYllquFeSOeB/esL/2zk8xpmX4Ve2vV8n
 LGSSZYrcIjansXu5gE8rRUkrRf+D0jO+TSr9NYr8nHY4GwQHT7ToWdUBDPZ3NnKpd8cU
 EeY2UYC/ONEMtT0MEaLOjsQEV9IRXG1B+BchkEM9gCVzytIdALyU86/dGIr8J4ag8CPf
 3c8L6vz1BDjTKHSJ6ec0DLWwBHsK3/bJVxIAMqhnI+3hDsk60JQYcHHShgEgyJAwXgB6
 6qqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789642191; x=1790246991;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JgGGToNc2v5pflrpzy2awJuFvrt52U0TkSLrIqd2nHA=;
 b=iRGlf/k1A8f5lgyvzpjxbkOizm2mpSgY8RcE8vueOKnPw57wk/uaN5VhJeN3a8t7CN
 nBL7+G0uKkYUkZhubH+DNEAinnegZ097VbqhrxL/lWE74YBqPZ+jgp8oO0kkkHMVCGcs
 hlQWwrcbGSB0lMcDx7OxCGP4yY58rDYsuLn/WIOxHtqLgstCHdkfNown/gYsWARJWfwI
 h7IajlwUSpjkX6T+gLpl5rc53DPptiDlzgWecMezGCbh7bkOsHH0VVa2ONeP2fyMBuBp
 xXBdJM6kqVQC2qYmiaMTlHRQL92UAeKmXGgTw37gs12xa2gQA26byyp1hwU0hlO2N9A7
 chRA==
X-Gm-Message-State: AFuF++nvZ3yAaWyfoSna9RPnlgte5Eqfn507yIldfZJo/DZi9lJNSIX9
 OPlX+TvDwmGJteMNIXTQwBEahrdEXcipCy7+3fJ77ccQIi8Jams0heJx
X-Gm-Gg: AYBFou2u5hVbPdL4gyEpi3U2q3cu3AstVlX/iBYLGMWtNoD0gVF/ZQ6qGW40t5Oy4Xy
 R5OXWIU2fml1Vu2RRB3/BROq4nTMt4gYqX/sZfDFzOSknsZ/TL+rqx/jkGkMTpVTTeB0jmOkD9N
 Z6RcE9z12Vcqu0sIymBOHHC5N6IucoK2dx+EteepwukiLY2l2OgYTwHLHjtobbx1psUCoH+EoLt
 EbWuAHRSpG+zpb6lZmbMGzcsK/rD574FLsAMQ9cEpNyltOtA6JZ4YjuyG8ik/TB0IG/DtqxQq0L
 yQLLtukcAmIkcTvBA8dXxkZ4JUzfXxMTiZ2yHh6d87krxeC2KNxSb2PdrWHUUyzulWMmnBF5ZnP
 B+lgB0AaxHU2CWz4vmvzDyGOg9OcINWyqIhEKvhLPW0jsDxtLUW4DkEOLVth/scKQeFgGvT3tGf
 VvVknUGZLzbAAOztqrWbTB9/7gCAFOfxhCkBhltpPepdlChr9fbQAxhR/mdeQKNiGm2P4PZcvWQ
 bFbJ67TNQ+BrrAp05vI15xyljOwrhvOjrD0BuAhz8W8XbqQQfq3d7sT1Jrr/Gi7xAwVlXb1Sd31
 J6RnZ4EI5tLdASKx+Kv2l9OlK/1UFQcfIM8pzVtp0YQnRkA=
X-Received: by 2002:a17:90b:4e88:b0:398:cb56:e92 with SMTP id
 98e67ed59e1d1-39e1e30ba45mr15259032a91.11.1789642191459; 
 Thu, 17 Sep 2026 03:49:51 -0700 (PDT)
Received: from [192.168.2.3] ([2403:581e:d87e:0:fc2d:ed31:e80e:412d])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e39bb3f1dsm1062109a91.3.2026.09.17.03.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 03:49:51 -0700 (PDT)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Thu, 17 Sep 2026 20:49:29 +1000
Subject: [PATCH RESEND] drm/fourcc: Add Apple Interchange layout format
 modifier
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-apple-interchange-modifier-v1-1-875294689c48@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, Oliver Bestmann <oliver.bestmann@googlemail.com>, 
 sofus <sofus.c@icloud.com>, James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2059;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=X1GV84Wq/vFzYUv/sfCUjMI1OdVSf5hhLntbftA070c=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDFmrjx7fMcmxc0PVGZ9HIrxaxg9nG8kejncTsVz6OcDp/
 Jn8/9vVOiayMIhxMViKKbJsaBLymG3EdrNfpHIvzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 aKRjrGPEwMUpAFMdFsXIsF1l057fpy2nK83nbVmU9Ex0n02S09e+U2nefeUd59dNymdkmHVg1ZT
 sJwbz/M/uleJP44+qa6q95nTvsPtND7dLJmuaeAA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960
X-Mailman-Approved-At: Fri, 18 Sep 2026 07:10:00 +0000
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
 include/uapi/drm/drm_fourcc.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index a103fdc0b3a3..aa51c116cd7d 100644
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
+ * Unlinke the GPU layouts, tile size is not dependent on bit depth. RGB
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
-- 
James Calligeros <jcalligeros99@gmail.com>

