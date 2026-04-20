Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0099EA71B3
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 01:37:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3D0310E094;
	Mon, 20 Apr 2026 01:37:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bnAP9YwF";
	dkim-atps=neutral
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com
 [209.85.128.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9454510E094
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 01:37:18 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-79a46ebe2beso23094147b3.2
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 18:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776649037; x=1777253837; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PKU11ok0UdmISqg+TyGzbe+U8sWE0AZJ6IK5DjOXMLY=;
 b=bnAP9YwFA3r47yMKn/+jyDHqT2d+eJJhPeOmsB9SE3Cw1/RfG1fUhFL74SovkiALBO
 gfw5owAiDRmmTR2J40pDxRUJF1ZRb74/anP6kQYyWJfgWwLKmhJKEG8X6f08r41ldABC
 CPswABGCOQRAD/ep2oK2xLA3rkIitw69Xgw4wTET7Y2SPhuP/e4Qk/pbyNsc0mwEcu1B
 JN7ADa88VsHCqEkufymMmJI1TvgsILc/TIo9lRRertUFRBT3EuGOtXgdCYKM36DAJB+U
 1RzVMhe+jKhrmwQQbnLjOYkS3lo0husCVeDvvslHBafw3wT6Y5KRIY0m1yFnsplvOzmk
 IcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776649037; x=1777253837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PKU11ok0UdmISqg+TyGzbe+U8sWE0AZJ6IK5DjOXMLY=;
 b=flm1z/vGv52k+HW9+gAgJcSlcloV1IfbM/M4/K5pOS5tJHlAj4e8KRBP7sGV8Gp3nc
 ZU0yNj8T9Djd+fDNXHWojA+6SNFmhlJEpSUxCeAEleMqfS3DXZaB8LWCexGFlK1Tck2r
 2Q8gsyjj9d8cTtLgx17Sh6gwiEP2+bAjOLghonhP2WORLkNS3GU8CqawIP5AXHOxflX4
 RMWRr2JuruyzNeLD84eN+xEU7ku0Fx2HKjieogzCLMy7u7siHERILZmYqtiKranOrjaw
 45J3HFbngKyqGpdp2DNC1mJ+Ty+esIquYa/79RshRzRJtdAIRwHXIr6b2n++k3YiR5T/
 DoaA==
X-Gm-Message-State: AOJu0YwfLgnpeIyXPcEEBeNKD0Vger4P85+os0T4CvIZtIEKR94SZB65
 8ZretX7xG0WlyjQnfwLDQw7H0DdmrCQStPmAT6Ao3Ng2+rlMOhrjFhDa
X-Gm-Gg: AeBDievFbpL8C/d9RNLGxHk6/BTuNFCyoHl8g8kDMqeRIoNRyMhqDz/dsUo7TGfV/dK
 8iHnQGbUIQcD5zR6R6grF/U8U3FGeYCagsb4Q4TfAV4sGDoGMygXAj/GsuDlLmpXrlzDXiESscu
 T6M1FeDVJFAVfk+kY5kIPQvwD2KZXKs//uuXyXcSlIrvscMrmj61V/eLL3GbbpZW+LcW4KJSCh7
 Y/W8LqpX2F3J85+m+V75AoFp7wC5ERTgzE3ohlhJSvL7maPktfZ1zYbURzFZdDmo88n+OkGH7B2
 eDCgdenhlPpoi5E6xeEkd8Ld/9dcHnz+/SIl4A+Co52h3xRt4KbkXVMvwjHBCk+FkXRWQf9249o
 FsxwavAtetPm5Cwg/pTLeINsUQgzth/GvMbn19KS/cXjsPNCdsuq7aaEiM8s0Ui0iH56kDYKSie
 LHdEnHuoSA2fOeQYl7+306stodT2kCNeekfELrYVM6sQeExNvV1Zm12bgvGReUTyLWoJghPBhH8
 zrvRNQY5IIRaRvePH941vSZDEcpVr+GS6Zj8co=
X-Received: by 2002:a05:690c:9:b0:7a2:7b00:67e6 with SMTP id
 00721157ae682-7b9ecee8228mr133713637b3.21.1776649037367; 
 Sun, 19 Apr 2026 18:37:17 -0700 (PDT)
Received: from
 TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net
 ([20.63.37.123]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7b9ee9b1c4dsm37350767b3.33.2026.04.19.18.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 18:37:16 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH v2] drm/gem: Fix inconsistent plane dimension calculation in
 drm_gem_fb_init_with_funcs()
Date: Mon, 20 Apr 2026 01:36:37 +0000
Message-Id: <20260420013637.457751-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2f9cd84b-0642-418b-a4ed-7863716a8531@suse.de>
References: <2f9cd84b-0642-418b-a4ed-7863716a8531@suse.de>
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

drm_gem_fb_init_with_funcs() computes sub-sampled plane dimensions
using plain integer division:

  unsigned int width  = mode_cmd->width  / (i ? info->hsub : 1);
  unsigned int height = mode_cmd->height / (i ? info->vsub : 1);

However, the ioctl-level framebuffer_check() in drm_framebuffer.c uses
drm_format_info_plane_width/height() which round up dimensions via
DIV_ROUND_UP(). This inconsistency corrupts the subsequent GEM object
size check for certain pixel format and dimension combinations.

For example, with NV12 (vsub=2) and a 1-pixel-tall framebuffer the
GEM size validation path sees height=0 instead of height=1. The
expression (height - 1) then wraps to UINT_MAX as an unsigned int,
causing min_size to overflow and wrap back to a small value. A tiny
GEM object therefore passes the size guard, yet when the GPU accesses
the chroma plane it will read or write memory beyond the object's
bounds.

Fix by replacing the open-coded divisions with drm_format_info_plane_width()
and drm_format_info_plane_height(), which use DIV_ROUND_UP() and match
the calculation already used in framebuffer_check().

Fixes: 4c3dbb2c312c ("drm: Add GEM backed framebuffer library")
Cc: stable@vger.kernel.org # v4.14+
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
V1 -> V2: add Fixes: tag, Cc: stable@vger.kernel.org, incorporate
  Reviewed-by from Thomas Zimmermann.

Link: https://lore.kernel.org/dri-devel/20260409164156.2235189-1-ashutoshdesai993@gmail.com/

 drivers/gpu/drm/drm_gem_framebuffer_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_framebuffer_helper.c b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
index 9166c353f131..88808e972cc1 100644
--- a/drivers/gpu/drm/drm_gem_framebuffer_helper.c
+++ b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
@@ -172,8 +172,8 @@ int drm_gem_fb_init_with_funcs(struct drm_device *dev,
 	}
 
 	for (i = 0; i < info->num_planes; i++) {
-		unsigned int width = mode_cmd->width / (i ? info->hsub : 1);
-		unsigned int height = mode_cmd->height / (i ? info->vsub : 1);
+		unsigned int width = drm_format_info_plane_width(info, mode_cmd->width, i);
+		unsigned int height = drm_format_info_plane_height(info, mode_cmd->height, i);
 		unsigned int min_size;
 
 		objs[i] = drm_gem_object_lookup(file, mode_cmd->handles[i]);
-- 
2.34.1

