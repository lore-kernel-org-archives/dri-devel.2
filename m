Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A11606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=k2CZ4G7P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4FED10F40A;
	Thu, 26 Nov 2026 06:25:37 +0000 (UTC)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3378D10F51D
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:25:26 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-1ae58d17cd9so7385841c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795674325; x=1796279125;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VZe39WaA8R6UeVIikLXAN07ESOsxBSo6V3fin9PGn8M=;
 b=k2CZ4G7P3ETLQjhCr7pkPKirhzeqRO8vb0lty5uy2evSgh4xgnxRg5DMHD+KFy53Ga
 vF8VwgnMsk0smNbUTCQZ9EwhkucsG7VGUFMEGIGKrD69DP9G3DYGdm+DHmtNJMfokjh7
 w7dWqKfmtlSBabp0+lJomCv9MH5bpwUsJNGhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674325; x=1796279125;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VZe39WaA8R6UeVIikLXAN07ESOsxBSo6V3fin9PGn8M=;
 b=rROirsnkuZwsiNp06BjISjFBBh2KvmcGjLQs4I9S2AVYhLurwroc4p17K1V0irrgzn
 jM5kOuV4bng+pGbgB2/KdgFWOt/U4kStXnBQgFGFVKTn5bTIjSkTdhZr0qDBJR5F+eqP
 U5kakorDPSaQf7e4avN1cvff31krP6mcnaKSo9y6YvHgfDpR1pRgcYfYte5qn2eLeVJ9
 pUPS+/iHYa9uqiPPyzwb/23n9t1IB+ToqXwuRdAvdQCGresckQhSJ5OaOtUahlZgHWqh
 pMZTnHTEj0noNIOM//woRjHIi6OOY9YRhtVlyBLIr2iYUg0pW7DfSHxCV8Z+jMWiid+3
 viMg==
X-Forwarded-Encrypted: i=1;
 AL+hErFfiSjxpMAJDQsNcAq6fKYx+uzsP9dr6nwGeeZlNBqMQmjuc7PIvZtFO8QZX132wnuPAP20nVktgaA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/I9XdvULVd3ZF4lLOZD85+xj1kSPdy4+x4vR7OsDq60AbUsBCC
 Hw+wzDHBo54iMZvGLsi7RvuL8NTts9q5+5D1JiWsMWDjMg/Z+TNcApPKP6Xdiw5AHw==
X-Gm-Gg: AZFdTZeqI4m3hjdX8DdV5s3/dK5iTwffdcfzHwJNjOs1ZYr4hOLUEJt8WBLK3KLP5S3
 zPYQqnGCUAzmOPw5adudSQDwQgd7OWF7/I2P7FVyxXh0wxq35ilubdlFhUinDsJTEkclHWU5v3Z
 +JotSeJwvUoHkmzHP5OIVyazNYkan/rDVIcS/EJdVWJUqgzZ6ZxSWjYkXvWRp+n7Buvzazb9GSN
 ZsfudjtnizJDlIMDveq6YMGbCj408URnJeCmDT/kYHQdSRrRqyBDZm30eCOorivELaJO7ESZOls
 byzsUY9erPtqrWfd384oBXh6b6dhAA7QRpj6PLTDS5rXBgcoIl8MGUIPTMm8EKVLOYBR1rm6aSb
 F3DSmBM54CJq0+RRAemDSsVTl7q65QaUFh4snwFG2EqK1mAvsUoKjiaXCG+erDC5j6+VkKZ8jDB
 13DvM3fb9rfnLfwiY6dS7cHxknEEwZu8DicnuWtWpJdTvO8t8wKkwas+3iPjlxgtJGjaB0ijs8h
 ohvL6AivZjVmLgypOIf8BXT7r3/nOOrt6FTI7/FC3jwU2slRKLO+EpgwEd7jN8HpNNTPFqctaCd
 +XQ3xxh+pi1DNVBSYV4bKlO2eWUojwU7RlKUuXPm60yk24RrhUhKI0uGCMEEJoJQ395n0Mi5/SC
 1VG3tnVLUMhJ26L2/V0SAKg==
X-Received: by 2002:a05:7022:7f01:b0:15e:9126:c60f with SMTP id
 a92af1059eb24-1b5568bb55cmr17922707c88.29.1795674325489; 
 Wed, 25 Nov 2026 22:25:25 -0800 (PST)
Received: from fshao-cloudtop.c.googlers.com
 (123.142.199.104.bc.googleusercontent.com. [104.199.142.123])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b56ef9fd16sm36793186c88.4.2026.11.25.22.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:25:25 -0800 (PST)
From: Fei Shao <fshao@chromium.org>
Date: Thu, 26 Nov 2026 14:23:50 +0800
Subject: [PATCH 8/8] drm/mediatek: Expose GEM memory usage stats via fdinfo
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-drm-fops-show-fdinfo-v1-8-7cb1d1a5d6ef@chromium.org>
References: <20261126-drm-fops-show-fdinfo-v1-0-7cb1d1a5d6ef@chromium.org>
In-Reply-To: <20261126-drm-fops-show-fdinfo-v1-0-7cb1d1a5d6ef@chromium.org>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Oded Gabbay <ogabbay@kernel.org>
Cc: Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Melissa Wen <mwen@igalia.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Karol Wachowski <karol.wachowski@linux.intel.com>, 
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 etnaviv@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Fei Shao <fshao@chromium.org>
X-Mailer: b4 0.16.0
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set .show_fdinfo to drm_show_memory_stats() to report standard GEM
memory usage stats in /proc/<pid>/fdinfo/<fd> via DEFINE_DRM_GEM_FOPS().

Signed-off-by: Fei Shao <fshao@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index a8bf0690756a..9d646740c468 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -18,6 +18,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_dma.h>
+#include <drm/drm_file.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_dma_helper.h>
@@ -607,6 +608,7 @@ static const struct drm_driver mtk_drm_driver = {
 	DRM_FBDEV_DMA_DRIVER_OPS,
 
 	.fops = &mtk_drm_fops,
+	.show_fdinfo = drm_show_memory_stats,
 
 	.name = DRIVER_NAME,
 	.desc = DRIVER_DESC,

-- 
2.56.1.839.g22a8290db9-goog

