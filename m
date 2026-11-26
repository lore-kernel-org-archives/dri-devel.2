Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B619606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=HYe6S/0i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 762DE10F57F;
	Thu, 26 Nov 2026 06:25:10 +0000 (UTC)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75E5E10F532
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:25:01 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-1aefd1bf74aso3477923c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795674301; x=1796279101;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1gKLDwGyxRU9dYe2xyWHPCu5Y64d2Lo1PuFNknEYqTk=;
 b=HYe6S/0i8gJ4YL/1/mF+pN0kYFYblUjGJK9aDL+N6sL4GG3By5GzIIHHti+bcgShFp
 2514rW79mNTne9mAVGpbezclWAAAZkfm/emFIUExZDcEzsDkQhFldulXgHZqGyucrw96
 ZUhizPzf2hEjTFlL6DM3H2r7BmiBkYLh0fDXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674301; x=1796279101;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1gKLDwGyxRU9dYe2xyWHPCu5Y64d2Lo1PuFNknEYqTk=;
 b=NDsYidSqV8e5shClu1vUXmnlHOLCzHbX4p5G1vAXyX4iqh/EK3s3aB11gqMEJzA275
 9mgr7I1QdjCDeF611SnPtBrKvyLJSrT3zEY4msklXts8/Hy+zkeFE0PoF+tJLeA42477
 2otkyRmPpMX6NcjoDiX+dpsK6e4Yfqo0mmJewc33K90zJAYM9P6lI81gvvUAFwjvUauM
 6Z7HNIxOO+Tnlv/DeeZi82ogBnFetJTWmiraNw+OcBTq6BfOXmSSzCfz0O1n/OsUulbu
 PuYAtjCHXvp9VDQYBOPY/shEOwaIiggzOzG1J4Ras6tP63bPt/nPrlxcb3MXuioKnUcH
 AJiw==
X-Forwarded-Encrypted: i=1;
 AL+hErGtc/ZIlH4qKZslhqG8AXeEFSisGTyqZeTNqcFjq9BSd+B5s0rRyiT/gg7ADu8NThCpoBnHt6mkinY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/AaQrfXFar/hEg7yvGqiqw1K6+p8J+EWNJuLR75egS9D6sK7MU
 XWxffs5hT2fuQJJFSwRjFCfQ0FZsaCGpEGbV+P9Px5kBaSVqjElewwbhT68NvHOIJw==
X-Gm-Gg: AZFdTZddBvtv2IgHS8ARSTM2cIRegO62chHGg/BAQV/ynnoDw3B1avoHCRvICPBwVAP
 SHS1pqjHGHfC3LsBf/K2qWqJPXBtl6G32N4o5DnkyMFmVsd1jn018HYeLznie1jkBGsI7326/F/
 sWiMx7Ncv5H/E/niuNNCVn6ED5DwGQtzCFu/+ctrGMr4jUK+chTGylF8M63mxRef5An2KSP2tFY
 AY3oBBQJd+usMozkDJjfy/kiYFQcaWMhlQYtYqrHTXb860gSLMJlMcs32J4qF6/7umz8fBV7XLi
 eQhI4tEMMn8DC0HiZVuqLfAOqyY19Mwba+apzqQ4KhftaTVR1InMwBL8Ch27CSCcD/5oxsmM4LX
 YEUSfEA+sbzuq6W521S6yenrH7cuRARB5NYaTg7xz64xgTUd7vMFRUwHhOFxz2X1t996SOaamdJ
 tNhP4r9C1d4IYvQYaK/MFbz14QQLxEO3OX5Hogkw90pJpvf/+6/PEQhL0bYSdLEshWLXMWfpbKt
 +UnDHNSKM3QhaadHFYVWl98IP5jpaAVDdwfBSpJMjqILNOCw6Y23xaSm/n5veUoer9X980nOGDD
 HofBET+uSEYZuoabA6AkNkS0UNGr4jeufU0HtSudwjh1By1Giz4/QwJgLi5O1PMs4394eSUtHw0
 /FTTRETPl+HFu1Slrv/mbZg==
X-Received: by 2002:a05:701b:2603:b0:1b2:5ecf:9bd1 with SMTP id
 a92af1059eb24-1b55249484cmr20664343c88.7.1795674300778; 
 Wed, 25 Nov 2026 22:25:00 -0800 (PST)
Received: from fshao-cloudtop.c.googlers.com
 (123.142.199.104.bc.googleusercontent.com. [104.199.142.123])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b56ef9fd16sm36793186c88.4.2026.11.25.22.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:25:00 -0800 (PST)
From: Fei Shao <fshao@chromium.org>
Date: Thu, 26 Nov 2026 14:23:47 +0800
Subject: [PATCH 5/8] drm/panfrost: Use DEFINE_DRM_GEM_FOPS()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-drm-fops-show-fdinfo-v1-5-7cb1d1a5d6ef@chromium.org>
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
 drivers/gpu/drm/panfrost/panfrost_drv.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index eeda113037fe..205838513379 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -789,11 +789,7 @@ static void panfrost_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 	drm_show_memory_stats(p, file);
 }
 
-static const struct file_operations panfrost_drm_driver_fops = {
-	.owner = THIS_MODULE,
-	DRM_GEM_FOPS,
-	.show_fdinfo = drm_show_fdinfo,
-};
+DEFINE_DRM_GEM_FOPS(panfrost_drm_driver_fops);
 
 /*
  * Panfrost driver version:

-- 
2.56.1.839.g22a8290db9-goog

