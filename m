Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E35D105F7AE
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:24:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC8B510EC18;
	Fri, 13 Mar 2026 13:24:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YUN6izY4";
	dkim-atps=neutral
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9934610EC19
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:33 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id
 5614622812f47-467161c4ba7so1424120b6e.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408273; x=1774013073; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCYC336WoUNdVp8/EmNZcTjPfopk7zVSApVc86osLdY=;
 b=YUN6izY4WAfT6zojS4VDTfnJAAAxMPUgONRwPSK6RQ5ZiMGMnK0AwAAileFH6moqDR
 e+Rfc6lMPhuQV/poWa/TmY0PPOaC0wt7ZjjJ3baEaYS81uH338mPoxzoGEnRX60CemXR
 iIvScED10NE4VPp9R1iSuR4EfqmSbvgJOIR2qlrhoHadrGM9WArmh7h8eLfzX3kpJH9J
 0kU8eYidDAt7/GB//jBUeuX+N70XkkXer+upxN6z7rpxE6htjMNT67QybxQ0tW2fr0Bm
 lYWiDruNK3kv06R12OhExrrvMEUCxYhL5bZz2KIsJ7FLeIjTgT0Cy9JxwjsNNM6HxzWQ
 MotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408273; x=1774013073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RCYC336WoUNdVp8/EmNZcTjPfopk7zVSApVc86osLdY=;
 b=bCzg5E0lY276EvBNVY8U9tuu658Ll8Rft7vwXuRs5S2P9AUOT064TXLcsMdUi+XCaW
 p6H0kO+YI1LBJXrK/stkVsDBo/mJspUGJToja2yVLAb7mZg/WFHQryfbCRaSYYTSKMXs
 WYdENFScfdTWmh8jobCD2HbbLllfme07uS+hrpCLbWA5v8NAJSeN9uQOvt7eFmalspja
 2301mffMN9LOefWrqsFD7PFwahlWcrdCSMYt3E5NkccxpwHM9AvDtV5yTE3R6tBonTbG
 XA7YmfesPatKKa/f2wJpVa69Y4bF2lZDkhY0gW2VjtmM53ucAydoHS3KfFCCH3g7vu7j
 NrkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaSslRkY2yete6A6J/7Iq0o5piks4LmjCRHqFnzMhtWuXRvxZlCii4EEn6iyCZ8RkYrgZ8BkrwWQQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwmKbm8Uo6fLGugGOIbiOE/6Q/30sSzw7odeGUBQM5TqG0gBUpl
 RqcYW+p6pG458tWloeS54ala5pW1QpX6TJ46UOk7XOQkGdWstl+LIzlf
X-Gm-Gg: ATEYQzxq2GLFYrO/iekSb1wuE/z/qw1Irtw/nwjdpKr0wF0nQ2pl3dbOhAuGMGh+9zb
 rt1lrHNIBNGhffPin5JCLW63oeqXcRra2mGxyE1aPMJbKLlrD+VK1rS7qiUSDrW9BnEr1t/7gFp
 0gqKsQeHsap9XMtvswODIZ5La1hNJuRYignnFTJhnsqNou/oANpdEdrjtRsfbvKIo0jw4+fVfA9
 89ent4zBtsCN37ONHstKAN0O1Xo1u68HWyucz9b0pwkqd/GM2/VKfCVYfdBzCgl/b94Zdngk5zh
 XN0OEPRjZFAR8GqQeHNCCiyqVvuYRxWWCMDB+mUOL5xFYnX0QijGs+IzxK92/kW85ClzjfdN7Jb
 MKUvREy95PLxRtRvE2+eNAn0gEwIQ3+FoMrXNhJbCLQMPok4aaxdVLSTnjftTsPDs528qnXMLEw
 aoCjK/e6kXcspSUzsBeyL0ovzqxc41v+Yj/kaESIAawhaPVAWi
X-Received: by 2002:a05:6808:1383:b0:466:f4cc:2b3c with SMTP id
 5614622812f47-467555834cdmr2362487b6e.8.1773408272824; 
 Fri, 13 Mar 2026 06:24:32 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:32 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 45/65] drm-dyndbg: add DRM_CLASSMAP_USE to virtio_gpu
Date: Fri, 13 Mar 2026 07:20:10 -0600
Message-ID: <20260313132103.2529746-46-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313132103.2529746-1-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
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

virtio_gpu has 10 DRM_UT_CORE debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index a5ce96fb8a1d..aea4c117b006 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -49,6 +49,8 @@ static const struct drm_driver driver;
 
 static int virtio_gpu_modeset = -1;
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
 module_param_named(modeset, virtio_gpu_modeset, int, 0400);
 
-- 
2.53.0

