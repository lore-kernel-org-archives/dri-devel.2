Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9C4606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=FS4JYBs+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 761F210F50B;
	Thu, 26 Nov 2026 06:24:51 +0000 (UTC)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0982E10F51D
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:24:45 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-1ae58d17cd9so7385220c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795674284; x=1796279084;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8r10h3LnRLt9vjVGGqIH+e89aRk+gTjmWUgpe6jQIHI=;
 b=FS4JYBs+4vDYB8gI1H9/r85hB8C8G05fqCMOQ+wWxYg2mUH6w/y8oZyfu+lPGtOhzD
 f0KyL4imiPYa98RmZO9AhkopH2Bjbk2MfClYaTHcg494SLwQLvKX118YZDp4vedhJ+k4
 SUipJxyB9EjMaFq0XBQtDhB3lKSPnIPWu2qgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674284; x=1796279084;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8r10h3LnRLt9vjVGGqIH+e89aRk+gTjmWUgpe6jQIHI=;
 b=rYkdGKm6tt6gGjKFtXr7ucJ9eJX59kKx6yeonAb+r0FCGN4Uv7uCnBJRfoJF/lmHTh
 d66L2Ml6USyw6v2oxY3iPt4rI+2GplGb8337U0asUROSfVge3c9wHvCBM1guzewTi5ND
 G7rV20c5C2nN3ZmAiJi9KRmpeNZPKa3E/KN0cSFneO3xRRrvtEZLbrqEcMBfvKILPokr
 VUM2J7nIoTMKe+rTKwc+RzRcGoztd4di1AGb8mt7oIOJMbNpyMtIb518a1j0NhzIG8Bg
 xIA0g//omN7J/g6kim+1Bx3NtVp0A7eOcLUpiejaRotf2d3M/OmqfidZeYi5Wgl6DgOw
 E8aw==
X-Forwarded-Encrypted: i=1;
 AL+hErEWXJ4ADgU4Acutwspp4t+IsQ63JNclQoMuu/i4rvHkM+msyyDXi92isjsbbLA3RHaVdzaZ7Yi4YOY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/Jv0pn9ugtNi/ZQXG9yIe1f/FmSzozefLbJlHT+Td/u8VfJAt4
 e5OX7NSAV+9ztxK6VUgUgND5SCsjEvvAsQPTxIMW1O1U3Go013bFxAiH0C3Zgz4H+A==
X-Gm-Gg: AZFdTZfVwHdt26moy9XEkuVonixs8ZqcspDwJn7cZfQ0eXryYiip5FCDbCXaBR3r1qw
 DGONQ2SEVjyD4mqGadoYXRrsHyPOvgyAOfdN8j3sqdNsiiF4q2Ysim4zuSdz6ol42BWgxDZCcI0
 uMEkS37h+R4EoJXYlPdX+B3k6K8NL0p9H22NB5joeqRUnWBKbbEFjHE7aLp6ceti472KQvlOmd9
 dneOqsePRT/G2PhxObVV/lYsVfoFLjRtu+zkypoIoEbsp9FJsLsjZWIgbXF3257XaTDqSksgjaf
 fyf7rYi2r9thqR0I3WRfTqO/LACNkdgnxU9qIVW3OeTskNmZPJ6rUzmjZIwVaR4ry+wGRud2BuZ
 OCVC3dSLmNHQXZ30skewZ0iReDjoOAd6q0iSkQgEeTJ9D8r5gH4ayjW+vBMTtkTh270sEX3hnTg
 zyy1+qPacAR/OVprbUm0eKqTuJBYoirqAXlDi3bVSe9mYmygXqKNCUJXqzgwGnAf864/7anT7pb
 5K9kSrvyX6nHsxLyZQbcRiZpEYfiRSI+Ybh77F700kt4NpZx/jtVR1Ir5bazAQN52azmN91QbI9
 aR9QxwcPdQxGYqGtiAqyzQvx24DcmsA4UyWmpNEBU+6rjuG2zRx0gql/If5VduKMuLRABpbhSTs
 bVX4lxzuRITC8C0Tm5MMzxQ==
X-Received: by 2002:a05:701a:cc82:20b0:1b5:5a81:d388 with SMTP id
 a92af1059eb24-1b55a81ddfdmr16361341c88.4.1795674284302; 
 Wed, 25 Nov 2026 22:24:44 -0800 (PST)
Received: from fshao-cloudtop.c.googlers.com
 (123.142.199.104.bc.googleusercontent.com. [104.199.142.123])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b56ef9fd16sm36793186c88.4.2026.11.25.22.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:24:43 -0800 (PST)
From: Fei Shao <fshao@chromium.org>
Date: Thu, 26 Nov 2026 14:23:45 +0800
Subject: [PATCH 3/8] drm/etnaviv: Use DEFINE_DRM_GEM_FOPS()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-drm-fops-show-fdinfo-v1-3-7cb1d1a5d6ef@chromium.org>
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
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index ec1352c1b09f..93869e8f3f96 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -494,11 +494,7 @@ static void etnaviv_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 	drm_show_memory_stats(p, file);
 }
 
-static const struct file_operations fops = {
-	.owner = THIS_MODULE,
-	DRM_GEM_FOPS,
-	.show_fdinfo = drm_show_fdinfo,
-};
+DEFINE_DRM_GEM_FOPS(fops);
 
 static const struct drm_driver etnaviv_drm_driver = {
 	.driver_features    = DRIVER_GEM | DRIVER_RENDER,

-- 
2.56.1.839.g22a8290db9-goog

