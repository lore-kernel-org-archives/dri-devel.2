Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9516D606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=aSNHcSQ8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E407B10F559;
	Thu, 26 Nov 2026 06:25:09 +0000 (UTC)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3876110F559
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:24:53 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-1a3c08d6928so9890154c88.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795674292; x=1796279092;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jXfP+BBaRmFRvRsRkzl26nbPuaGAtebafKyAvaeF1Hk=;
 b=aSNHcSQ8dyxfYfubF4DigQ9Wlkl3fjxUycOwcq0CtgZdjm7p2P5+S0U7tB+uKXnOXN
 b/uGeImkz9t8MnCCdUVSmtM9UQRU0GzdnXRJTzEGmbRFrB2QJJ5xP9Hq/3ij9lH/0vWP
 kdSddNUK76z8oP2wD904z09TzvXJNchxFh5og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674292; x=1796279092;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jXfP+BBaRmFRvRsRkzl26nbPuaGAtebafKyAvaeF1Hk=;
 b=qpH8H/A2LEcHtf0Xbl1ysvf/uGh2ynRvRPKuLClDHVtzsP24z1ftmeBZrYsETDc5gW
 cHGftGTFQwSEDNHf5609OMR5KQrcKPRaZBVnks5oTiB2L4TAwr8OppCS4mPA4iG2/W/x
 Hcox1Lu+IM3HpbMT8FUPsFcdMSFvsA6v9IcPtIgP+adPt1em6q/C+QhG9CkCbvrE84mD
 o2OzS8hcnHuzCzOo5q61NpeIA3IAeRFcOC9aNnWr4a9VEWACaEc7iypj6hqJ2iBBxdz1
 holO8Dec+F4jx5YnNzIhNJevtC+KvLWns8TdNRUBJ0USvNGaYwCZ7WX1mvpxGvU0dyOP
 EseQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGtOYwIQK6ck6Ukug7QBTfabTOdAXvVq2rfZesdutfNitFF99OcIjamz9Oyg0SN4lcOOWmKA+25X28=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9T/62qZVhhTOlDyM4n6mTTuwq/S1J+SaPY91gGKwrWQ6AR7fGE
 4IrPdoGdNKCT2eQKAEKvcwrtJhKJJxohmFuua+Q8DoVn0wzOaAsEa5Kgb/umxHxxrw==
X-Gm-Gg: AZFdTZcGc6vUtjIUvPKQKKZ0EfF/6B591iidF2rALgrvTGgTVv9ad2sH4JyRBCXLlN2
 RkZJ54nFQZmVgPj4VD/78bRfRSi0mS/6aQ3NO2uVt/DUV3RS/gUxrxf4HHEVCCoWX0k2o/rztMb
 8sgBOx6glesdS787pJuvcVCiUZvmz7xyMc+wDg7PmvRnB3qweA+MReNWVvQBNBWZpDzwtLTTjRB
 IKrkplXUbCgZjpKDdV6MuseJIRX0mCTLTDRwDnZphqt19n6egfe80oqyOpTkIgwAJp9NqqJUe/w
 j63Zze2STzTGuAv5dKwICzoNMvbZNPln1I0rVKBSxagO6y7DMJApZW8/xc4kuKqJonFxUP+I+en
 YFqPfWBhSSN7OKV9vKYj3C5V9GabLAoK8AT4IW1exu/E9RHOvypziXag+jHAr+2DVn51GhskGeD
 OeNzbGGTQkuJWuRN4+i671GI7+w1CWSSE2OS1UlbjjwcEyfywXsp8KhiRhLBxDPIZFbiWyWTLJ3
 XqGjn6AMw8N2L4Bk1c/UlGJ01Ns8/mRvB9ltiZqvYobcVnqX3aGw716DknX3E7p+jrKhLC4yrVD
 viVMacjwqpVGiXS7nP+eY6J7WCVGfY0ceo6oV9GIQ+bMUpHU69rEmVnK8dseFikm6a46+w9yDnC
 LTRjZNn7w9O2/Bago325AEQ==
X-Received: by 2002:a05:7022:28b:20b0:1ac:f84d:4036 with SMTP id
 a92af1059eb24-1b55686f9bamr17794762c88.9.1795674292446; 
 Wed, 25 Nov 2026 22:24:52 -0800 (PST)
Received: from fshao-cloudtop.c.googlers.com
 (123.142.199.104.bc.googleusercontent.com. [104.199.142.123])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b56ef9fd16sm36793186c88.4.2026.11.25.22.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:24:52 -0800 (PST)
From: Fei Shao <fshao@chromium.org>
Date: Thu, 26 Nov 2026 14:23:46 +0800
Subject: [PATCH 4/8] drm/msm: Use DEFINE_DRM_GEM_FOPS()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-drm-fops-show-fdinfo-v1-4-7cb1d1a5d6ef@chromium.org>
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

DEFINE_DRM_GEM_FOPS() now wires .show_fdinfo to drm_show_fdinfo() by
default. Migrate the driver to use DEFINE_DRM_GEM_FOPS().

Signed-off-by: Fei Shao <fshao@chromium.org>
---
 drivers/gpu/drm/msm/msm_drv.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 3675df277f6a..06d997a7a237 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -898,11 +898,7 @@ static void msm_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 	drm_show_memory_stats(p, file);
 }
 
-static const struct file_operations fops = {
-	.owner = THIS_MODULE,
-	DRM_GEM_FOPS,
-	.show_fdinfo = drm_show_fdinfo,
-};
+DEFINE_DRM_GEM_FOPS(fops);
 
 #define DRIVER_FEATURES_GPU ( \
 		DRIVER_GEM | \

-- 
2.56.1.839.g22a8290db9-goog

