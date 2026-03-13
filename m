Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C90E105F7AD
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D31A810EC1C;
	Fri, 13 Mar 2026 13:25:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lX6evrPp";
	dkim-atps=neutral
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
 [209.85.167.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A70110EC25
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:25:06 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id
 5614622812f47-466ed3bc95eso795572b6e.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408305; x=1774013105; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FB+tfLWkD+EbK14YUmCdfR6TCrKrYU/mryJ+Tht/PKw=;
 b=lX6evrPpLbTkpimTR3Ca+L1AVrOsppWbLU33iifFbe9ZLJlcAYAHh1HoiHFF5ZhH+V
 JxkMmOdasgqY8R7PXnVycpkpVVYuplg8oyY/OwcYKqiC7aWLbqH+ai4Tw2tLNt55w3A4
 IRaHN/XMmHiFF2Cn5oyQ98qSeQIGEAeu2slFv/RrflY4FzAEGp27W2+8HiLQsK4UDWPJ
 BbVPSs9e8hG9mKgKcSzD9kF6OcZWAIYtOQcrEIyybfcIMi45e5re0zNSubDL6t9bEzkC
 1+LvGqQLCpu2m7n8ahGcjWRW6KYVt6jyNlFb31ajN8nOzoLbs/chhBCRA7au26D1AQkx
 FNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408305; x=1774013105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FB+tfLWkD+EbK14YUmCdfR6TCrKrYU/mryJ+Tht/PKw=;
 b=nu+CBJcjcUWpO8OZt2d+r9UEUSi1NDFiNKwDFHeCMQuVe//4uq7hRg/Th7QhbVXqiN
 3PVR0sAkcgNOheCqF4EmpCGznePp0zeRpegWVLX8Kylx+wT5F1JXVO9c2I606FFLcTco
 N50oS/mlOywMDbhVqFUJzSDQF/BX2K6j8DtMHrlPzY5g7WVMLtkhdT8OcGd8Jcg9WMQm
 bXvk7kV5Bb0EvZ+/TwPhjEug80io6aMu2IIhIFUsolSaUzmqU6ow6JkbA/amqW1TiRCd
 hkO7imA9T1Vus+AJvc6uJKdmEHpWGfw4BYykGJ3nbJP4IcFjdYznpAHkNqNPzDR7eI+V
 tj1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtY6vxbNKtXidc4HlCkMAjYTWEfuIZqtG8IqThma/nB/3/kv9Xd09xo0ggBEqlx1J7qKYUFLo1ycQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyeZD/3dk5UfpAnFtaPEFnB8Umv2/6JiYmhv6lbcTX5RYwJac0D
 BdnhZiA7skILvgK/Aj/k77ABU0K5pVONb1BZHvesKxIeu6ec9rGJeVWO
X-Gm-Gg: ATEYQzxSNlTNnJh9XTFYFYTYYwSFcPK1cjfzN0vkPAxNqXiWt7zUjAd1MHV+KoGVZfz
 I6/BGJ8BHDdz6DObr26HSJYuHCXtA7LLDyMrYTmlZZkA2aHxMwoGAMoTES39VJksEtZ8HEL7uNK
 k9BlGBsCkoifFhdypcbmgeEfaeiW3jMfCAAPwmTn51mXuKsUsSZrWIiqaPBf988q7fvdGsGXsAc
 rkOWKF9W3ivjJNpZ/OtIKTdvQ206knszkLotiAlql8+eioFCl+GBwKKs0WfEEjMwZy2JcqI/+QQ
 T81Zwlrs7yT2rcwnHPDXF5KJD/RKxNtwI274wy0khC3Vi/gKofttLgB5VY9vfsb91OKdiMbf0Rt
 MvbLhc5h7UfWb/uVodpJU2ItJji4/2WuGPjr22kYY6bj97qXKVS4/A2eIIgyrvagGAi9RdmK38W
 h8Qv71MdWMP38GnPW0h7QRCEALgNQqw2Okk9GatcyVRRrzRKhr
X-Received: by 2002:a05:6808:1187:b0:467:3f4:907d with SMTP id
 5614622812f47-467575812d0mr1643061b6e.56.1773408305157; 
 Fri, 13 Mar 2026 06:25:05 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:25:04 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 62/65] accel/rocket: enable drm.debug control
Date: Fri, 13 Mar 2026 07:20:27 -0600
Message-ID: <20260313132103.2529746-63-jim.cromie@gmail.com>
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

rocket.ko has several drm*dbg() calls, it must call DRM_CLASSMAP_USE
to tell dynamic-debug what classmap enables them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/accel/rocket/rocket_gem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/rocket_gem.c
index b6a385d2edfc..0d06857b96ad 100644
--- a/drivers/accel/rocket/rocket_gem.c
+++ b/drivers/accel/rocket/rocket_gem.c
@@ -11,6 +11,8 @@
 #include "rocket_drv.h"
 #include "rocket_gem.h"
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static void rocket_gem_bo_free(struct drm_gem_object *obj)
 {
 	struct rocket_gem_object *bo = to_rocket_bo(obj);
-- 
2.53.0

