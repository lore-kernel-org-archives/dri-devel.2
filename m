Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408D9606A327
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ex+i4VAM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D1B610F354;
	Thu, 26 Nov 2026 06:24:42 +0000 (UTC)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D082F10F40A
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:24:36 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-14394530ec6so80282c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795674276; x=1796279076;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ePKddXgsQ/sIOcUIgiDq+rw3pTmufgmB0dzzvy5WTTU=;
 b=ex+i4VAMxeydb8vFmt/p0LPycPxoqyrzLdS5mmLB4pByfOEfGqfoqpnP/5PK+qB4AE
 G2kGVgUQkSHGciMyzC7yqq4mX3ThOB+eIf0Zq2mJww+DIb09yI43+4/edNppVIK6elEZ
 m3mAdLSAbAbspO218YCIeT1kKSpwI2JfSRcCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674276; x=1796279076;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ePKddXgsQ/sIOcUIgiDq+rw3pTmufgmB0dzzvy5WTTU=;
 b=Fb7RAUufSDvXoBTgORUrtCSpUGBjhgBaCoDm+h5p8ZtNy4qrdYIbjSCklq70BoCZUK
 R7uy/Z6tlAAPtXIyNG6aoZpuiv/xv4pusTG+ymUIp3tuthpYXVb27caS3VZNikbN+dHG
 YwdMuqD8+EInt3bH2q77tj5i4TLvZnVeBVagjpbInoswpDEHNfYPQBV0W1t+8/h93Nho
 oRDmxHnI5F0xTZR8O6YJ2fXSJQR1/2u/nwHg/SwwHr7/IkENUPAO/DiRvRq78LnZGcCt
 wJZ0oXhXWLX+ObhHy9NgFtU1CWhUfZ4nZo1v+4wDWTrUIUDFGPyPrjkaRSNN/O4xk20C
 EUtw==
X-Forwarded-Encrypted: i=1;
 AL+hErFvhrufbbmuJWfKN8GIDsfLZcQdgMmroDi8RB85EAD7fGnSJuZEINwELL3FY3JYgkGflJN7Fq7Btqg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9mfz3GxyjByw/2qHIffGzMo7ifNruVh1Tw8NQL0sOd00CT+lWQ
 B+s1qTjlI5f2mqPKU9IuiD/Zr3jEkO6m5oL0+Qyjt+l0Ei3UjKIirhQh61P0/st6Qw==
X-Gm-Gg: AZFdTZdorgVa/HJSKCWssOY5a7ygGY7OMmldNreJwuH6DfqGHRJuUI1kYaIA1FN2PBb
 R17y7uPEox/3aeID6ZDrTPfATfOo/4cbMupAPHRBk5NgNS4y69BqJeUgulXgCwbHuFfC4EAuXKW
 Tg+achL84VdqjQ4eW1akfXJdj4OYrSbokUwovFL23++4FeHikbvw3zptT9abokxhStY1A0E8n9o
 aqTLEZONOQzpjJXZG8Maw/Cx71W3Gr5/cS5OrSuEkF4QORmuZZjAvM3auGfT5U+s++e4ZrmqKE+
 dG718xV+5QttjUYRNuXHgFCGUF2/79LYu2sNsufANFCkVWjyGiWJadR+fbn+/FYJjRoJc/azBiT
 jpROiRT+KJnDFwz8c/aA2ZnEOZq0Khhobcily16ZmEh9wtXq0QuXBSOZwPUJCI8H1cgLW4l9bod
 dLYIpFIe5uAGBTcCd1CWna3T2Jq5TTZb0RnJ0XytiCWtt1PE4rdsvJN8OAmGf7V0GY80H1iD/FP
 l3tW3PVx1mHZZ+FOW/K3ktWR97OSLZgI9aiK2JoUETAU4ngEv0c+0VMzVnpOFfg965+UgmdjEtp
 aZSHG1G8NwULMvcDIKfqgIka0OlNCBKBx6OizNxXecUbvDiFLdEjfT47Bu0UeRRkN/paauwWagi
 48ktvbCyCwGBWCW7R0sZwAg==
X-Received: by 2002:a05:701b:4585:10b0:1b5:8f22:9803 with SMTP id
 a92af1059eb24-1b58f229b6bmr2042435c88.1.1795674276127; 
 Wed, 25 Nov 2026 22:24:36 -0800 (PST)
Received: from fshao-cloudtop.c.googlers.com
 (123.142.199.104.bc.googleusercontent.com. [104.199.142.123])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b56ef9fd16sm36793186c88.4.2026.11.25.22.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:24:35 -0800 (PST)
From: Fei Shao <fshao@chromium.org>
Date: Thu, 26 Nov 2026 14:23:44 +0800
Subject: [PATCH 2/8] drm: Wire drm_show_fdinfo() into default fops helpers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-drm-fops-show-fdinfo-v1-2-7cb1d1a5d6ef@chromium.org>
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

Wire drm_show_fdinfo() into DEFINE_DRM_*_FOPS() in the DRM headers, so
drivers using the default fops helpers support showing standard fdinfo
out of the box.

Signed-off-by: Fei Shao <fshao@chromium.org>
---
 include/drm/drm_accel.h          | 1 +
 include/drm/drm_gem.h            | 2 ++
 include/drm/drm_gem_dma_helper.h | 1 +
 3 files changed, 4 insertions(+)

diff --git a/include/drm/drm_accel.h b/include/drm/drm_accel.h
index 20a665ec6f16..1f3088002e52 100644
--- a/include/drm/drm_accel.h
+++ b/include/drm/drm_accel.h
@@ -48,6 +48,7 @@
 	static const struct file_operations name = {\
 		.owner		= THIS_MODULE,\
 		DRM_ACCEL_FOPS,\
+		.show_fdinfo	= drm_show_fdinfo,\
 	}
 
 #if IS_ENABLED(CONFIG_DRM_ACCEL)
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 56dd15921c7a..d0c30bf23e58 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -43,6 +43,7 @@
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #include <drm/drm_device.h>
 #endif
+#include <drm/drm_file.h>
 #include <drm/drm_vma_manager.h>
 
 struct iosys_map;
@@ -501,6 +502,7 @@ struct drm_gem_object {
 	static const struct file_operations name = {\
 		.owner		= THIS_MODULE,\
 		DRM_GEM_FOPS,\
+		.show_fdinfo	= drm_show_fdinfo,\
 	}
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/include/drm/drm_gem_dma_helper.h b/include/drm/drm_gem_dma_helper.h
index f2678e7ecb98..3fc22b426070 100644
--- a/include/drm/drm_gem_dma_helper.h
+++ b/include/drm/drm_gem_dma_helper.h
@@ -267,6 +267,7 @@ unsigned long drm_gem_dma_get_unmapped_area(struct file *filp,
 		.read		= drm_read,\
 		.llseek		= noop_llseek,\
 		.mmap		= drm_gem_mmap,\
+		.show_fdinfo	= drm_show_fdinfo,\
 		.fop_flags = FOP_UNSIGNED_OFFSET, \
 		DRM_GEM_DMA_UNMAPPED_AREA_FOPS \
 	}

-- 
2.56.1.839.g22a8290db9-goog

