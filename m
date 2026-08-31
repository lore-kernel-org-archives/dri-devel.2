Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFBAC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:36:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 832B810EB73;
	Tue,  1 Sep 2026 07:36:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Viq2PF3X";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 114E010E7A1
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:25:08 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-cc1e1ff659bso2802723a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 02:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788168307; x=1788773107; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=k1IRmhTgtgps2WH28DrYHzZw8IYzte0O10wXaGr0CRE=;
 b=Viq2PF3XNIBHkCgreXMZ/kcMy4BwCdMufNTjVVQbh7G9cRk8a6GEccoKWQM8fc3CD9
 eCbBNn/2ffv+QuI5gftZllv3V+lqUc6+egi1c+ZegVLSek7rfOlZdQq5WQc8duKcSox4
 8cNNtoCWdjSPtTFzgxR1v1iHMUK7Xr1CkR7t88oifmdUCskEmIX0J7DvCORD86OHdydx
 +gKuRqRTJJ65Fqx0EpaV1j4eaSunR5PJr2NRkwUMwA6X8bBdAgoUFI7h00VOx3cfWMx3
 2yEtHkk8fbDk5YOBLh4fwsqGs8csiawVY1o/tCsLV4FFGGzIIg5eO7YSrSRiPp1JXKT4
 FL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788168307; x=1788773107;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=k1IRmhTgtgps2WH28DrYHzZw8IYzte0O10wXaGr0CRE=;
 b=sx2V2VMQJZ4CYnHl/2bujl29i63mupkDY4TJ3onf4pk5cUH/aH45AsCIdsjxtD6RMQ
 qvGiljj2U6qOZMan9DY3fUhNJCbIVTLtgu6C/XIkUKJrnhLZidLGef4v3LLMZz8zeODl
 u/0QnKPeAnM+RwDoq7jAejlH6jXHzJNxYoYt37ThdSiE+NndO6xkUGuUL4zHry4MjAGM
 YMQJcMYsPHoLoPbPAsWNPyzH6b37hFOE+0osFHfhDVj24VuN2DhVRth470iGD41DU+Pc
 7iscTBUWRlqxXIBo/n2melQAqw+0KhdWsSzJ8HyJGHjMAdI0wS1lxHx6CnXpT/1mk/cc
 li4g==
X-Gm-Message-State: AFuF++lM6ggpTxpwgz+oix0qBbmpnTlVbdF5ONBP8IUlrwyLKLisXLvZ
 1y7POBAWmnfVxcz/1domFrseMWFi9VR/W+fJUZmBlYHN6yxUj0mW7Af4
X-Gm-Gg: AYBFou32W2nnN0/f+fvD/NhjivaehgiRwM1SgW387SCek5JKI4NY9yMNrcVl0l/Jla9
 xLWu2+53fNCUYauxRul+wkgguWGjWKT294ExvLncfcUnw+lOY4VRLY7wExIoZjaDLWQ7SM4UxKg
 xRfSI3rTzkvhCkBHXfVEvt7UuYoB4+dYtmxtlvLjp132AuR7/rmrNZB4LEmZ8mSl0S4yIYwliK7
 +1u4jIMay67qawtTeDGJNyuv67m5Jsw8arNiCljJbDJBbKgMp+oFtapc/djt9rA5HhYaUueS6TG
 7l7zzzb5Z5iz3k4SRHB4mxiWtyAfYBeMDoU8vezMR8K0ixAwa6RfT9XNCoDWhouufRoGU/c+SsP
 JXKVjGgjq52gCVyESEquCOkvlQqwjrBas7Yuao/eAK4myyPLi1WKdW2w2sltK85RAET3ILC2J/E
 TcHC6me2iGhPn/ywwZX4erc1XTXZ0KUQt/FVLEeVFiPojqS0MQzvOYmu48Fb0vFSBYnGIrybENB
 cHUonGJZJiX/N3V8yQED/BgUx6rwOg7GmBhgEOfMxdaEAnaMRAslPFzTnvDkr/k5vfUwgVoSucb
 La8ijCdVhisyjjEt18oAfhL4kgfqpOCoW9aLOEesrA7hw5Y=
X-Received: by 2002:a17:90b:4ccb:b0:398:c0fc:6ea0 with SMTP id
 98e67ed59e1d1-398c0fc7b03mr16400154a91.5.1788168307412; 
 Mon, 31 Aug 2026 02:25:07 -0700 (PDT)
Received: from [192.168.2.3] ([2403:581e:d87e:0:fc2d:ed31:e80e:412d])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0dc854dsm26587955c88.10.2026.08.31.02.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 02:25:07 -0700 (PDT)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Mon, 31 Aug 2026 19:24:28 +1000
Subject: [PATCH] drm/fourcc: Add Apple Interchange layout format modifier
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-apple-interchange-modifier-v1-1-5d6e27f9f308@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y3MQQqDMBCF4avIrBtIDIp4ldKFTkY7RWOYRBHEu
 xvbLv/H4zsgkjBFaIsDhDaOvPgc5lEAvjs/kmKXG0pd1rqxWnUhTHn0ieR/mBfHA5Mo7BGtMdj
 YykEGgtDA+xd/vn4d1/5DmG4RzvMCO3nK/34AAAA=
X-Change-ID: 20260830-apple-interchange-modifier-cbcc311c835d
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, Oliver Bestmann <oliver.bestmann@googlemail.com>, 
 sofus <sofus.c@icloud.com>, James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2012;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=qB8s8hgLiwwzQUS/BjiiGt7iGpPiuwlo6zbKh3mEro0=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDFlTPfL+avkx3Lp3UlD4xNInzHP+ep1t2Xy+ZacqK8Ovu
 ake23786pjIwiDGxWAppsiyoUnIY7YR281+kcq9MHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEz1aTtGhmvcX4O+sO9pyQnYlzOjtWELp0FX/mlX46W/J0yxUPBLOMvwP4j9i8e
 i1ihlbpvvFgZL3dec0HANYF/Xzfj11ZyXzpbFTAA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960
X-Mailman-Approved-At: Tue, 01 Sep 2026 07:36:10 +0000
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

