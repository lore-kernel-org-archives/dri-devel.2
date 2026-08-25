Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C429C61DB9
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:36:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCFC7892F6;
	Tue, 25 Aug 2026 14:35:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LnO4AfgM";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CD6110E9E1
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 10:54:55 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-3964b061528so844825a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 03:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787655295; x=1788260095; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ecc+4+3fD7whcx5Dflr4OBgeAjnyDsX+6ud1zRaZ8Vk=;
 b=LnO4AfgM9AaSepyI4E0EoO++6BJMFMO4pRgUNIUElM6idadA4elcMYSsr1eAiXSSAD
 v7b5NPANy+5W8Vplhysilq4Pch+bzOGx5r1HwiaotBcOCUL7nyCkZadgnSqG9Cg5eO+J
 DfP99nuzR93wLQ4Js7zpeOjbs7gnZxlUUkoKpXbScWPMqmCIW+lXRb0N5eE/dWJqJskQ
 TygLNncBzEm9xL7tNmwlgjN6p9/y13jjG6s8ZoNyaUwWorX0ekSgKInnm2jllfogugYg
 Ip3qQyTLlU/+izlqYB86N6ZWFTmH3o5nm5zVsFRdWTp0mYvJhzvp+n5NMkGIsZdYwJAC
 X5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787655295; x=1788260095;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ecc+4+3fD7whcx5Dflr4OBgeAjnyDsX+6ud1zRaZ8Vk=;
 b=ogaAeB3piRl6VGolV5Ym2Hdjza+l2cEZeB7pdpMX0uao/siKSzQyBiYB2bTVmvNGbm
 HXaf15/v8VWPATA54/d4cAq+Gk3kJJvyfE5vHfshSiWeR2xkKTWkNySEVK/NvrLxk7WI
 7+jtScM8FcwiQm2r59CcatnWisetHTVI2bJt29dDW0MKu5HnzunL9t7eYXCkP8+Tqrvk
 EQvxZFhqVE+IdzFZfmFNJW0wcGJaUY9ktgI3t3v2yZogsa1TPN7jhrA+cMNg1MdVOpux
 GCQhAsCO+dYFe7cQllM4t9fFciK9NiM0O3wWGYT3FtSFIc3oI95ZRLuqeYN2zFVHh6KK
 LB+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqLgY3f8c7DvPXy+mERJB8TTBFrA1Dnm/kU/Bfum4z2QbTDu2SNntT0NTJ2OwIZcVlSFRJM0hJI9u8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mttsgZ8/Gy+x+EuNhV7uRQST/RJ7+dTKPdTAVlrVklhwEiNPCG
 wilkwkyIVK8/w0LnCl9aOGJtvMrvMhKkON8sEfreTTsDeuOncCFCjWZ38WU7AMJh
X-Gm-Gg: AR+sD13S+nOkAdm+IG1+1HYPkzGwzH99NIEVtTLZuRhgJNVv7AZElK0Vbj7OH/s4KmE
 ZT5B96w/fqmIlm2qkf4wxx4jqk9g2LffTIkN5r0NIfe+2qfUKiesqvnMSw0dGDoYqETj4HlipQ7
 wjwdhdKKHZP43i7gXdeJJ4VQWquXr/sFgLBzW9oXoI/a49Bs+76tEAPM/f460oCK11nwr2zyugv
 DnrWifydwvIrEroU5LBQ0LH63Dcie64fclpPagLiFftX0/Lx8RnnElcxAUPUOQaDh16170L4Nv5
 qNJZz13Y0BGge+UEyb0+kRhkloZwBdRtu6KSfrziOFHNMk0jT/X03SBLhhbsNHZLh7loGS3CZkC
 wnImYdKT0UB1SQgp5VdRaqZNXlIyr5got71HeLdStR9cIessc25Pt92VbY0ve3M3XaFOhFuIw3H
 Vemn5x/RILhrtvdBakBg2N0hDSrbvvvKoA1PiZc8wmXVsVN3XkN5E=
X-Received: by 2002:a17:90b:3805:b0:396:4c63:7193 with SMTP id
 98e67ed59e1d1-3964c6378fdmr8038558a91.11.1787655294838; 
 Tue, 25 Aug 2026 03:54:54 -0700 (PDT)
Received: from fox.. ([43.242.224.196]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f9209f51sm58375372eec.22.2026.08.25.03.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 03:54:54 -0700 (PDT)
From: Roshan Kumar <roshaen09@gmail.com>
To: linusw@kernel.org,
	dri-devel@lists.freedesktop.org
Cc: leandro.ribeiro@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, pimyn@google.com, linux-kernel@vger.kernel.org,
 roshaen09@gmail.com
Subject: [PATCH] drm/pl111: Advertise no pixel blending
Date: Tue, 25 Aug 2026 16:24:26 +0530
Message-ID: <20260825105427.686619-1-roshaen09@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Aug 2026 14:35:48 +0000
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

Commit 860e748bddcc ("drm: ensure blend mode supported if
pixel format with alpha exposed") added validation that warns when a
plane exposes an alpha format without a pixel blend mode property. PL111
exposes several such formats but does not attach the property.

The PL110/PL111 controller scans out a single framebuffer and does not
blend its alpha channel with a background. Advertise
DRM_MODE_BLEND_PIXEL_NONE to match the existing hardware behavior.

With panic_on_warn enabled, this warning prevents the syzkaller
vexpress-a15 manager from booting. The change was tested on current
master with QEMU 10 and the existing production DTB; the guest reached
sshd and returned an SSH banner.

Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
Link: https://github.com/google/syzkaller/issues/7805
Signed-off-by: Roshan Kumar <roshaen09@gmail.com>
---
 drivers/gpu/drm/pl111/pl111_display.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index 5d10bc5..758b297 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -15,6 +15,7 @@
 #include <linux/media-bus-format.h>
 #include <linux/of_graph.h>
 
+#include <drm/drm_blend.h>
 #include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
@@ -596,5 +597,10 @@ int pl111_display_init(struct drm_device *drm)
 	if (ret)
 		return ret;
 
+	ret = drm_plane_create_blend_mode_property(&priv->pipe.plane,
+						   BIT(DRM_MODE_BLEND_PIXEL_NONE));
+	if (ret)
+		return ret;
+
 	return 0;
 }
-- 
2.43.0

