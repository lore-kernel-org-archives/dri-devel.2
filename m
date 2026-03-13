Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8999C105F7AD
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:25:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 463F410EC24;
	Fri, 13 Mar 2026 13:25:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k7w0e5ZL";
	dkim-atps=neutral
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3AF710EC1F
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:55 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-4670bcc40d7so860001b6e.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408295; x=1774013095; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Zu2rs9LQXViGSxr3LJ2mebc7/BIvYzUYAAic1plGvM=;
 b=k7w0e5ZLr9fovWLe3iaT9eUbo/ALTH6NtnDM55Nc8RVm6sI/5GuCZlNsbCItF5HP0C
 yRUGbKbYqFwDibqk5Rd42ERkiFwSxjpO+s776p4PS1Y7ng7oAF23hJO3fVrBYuxvr53O
 2e56zJgMBCg5pnHVQnjMOWyTlTM3auser6dOT0cyTSey4xIcgYn+a9Q2kBcjNBjirWUd
 Kk2d7iGg6A7/F3I+C8ltJeANnhqosSkPBPCAIrOevH5G4xc8Rhsc9LwNc0k90mw4vfNE
 pEpCoKF+YA3R+ZHZIBujoaW06DKnrZQukikGba5JpFIUl7hmDZihsX6/8Iwgzwr+vzxH
 A7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408295; x=1774013095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+Zu2rs9LQXViGSxr3LJ2mebc7/BIvYzUYAAic1plGvM=;
 b=CdJIS7sX4nAPK2C06Ee7llHd9xdtHI3Z5gBZWBuT6uOQ8pRVxOCnrjuJZGCAOh2qqY
 sQPktsgQqvZhptxEI1p6KeefMqZd/CVCxIGnUCMWl32Ou01WDH4emFiOzgS74XgvW7PH
 rlauTIyyOmg+UuFpSmmB8FRT+aN6ebC4Und30DpRz8UApilRE0+9dAGmMUOklB+08LUd
 jK9Qz/e2yYL0r9Cq3RrUoBAhbT3bfgUDDMhVFmtGNDN4JF3bZfDLagOo42uWKQ2LO8jn
 XuRqBxyZk7BF+HHVQR+WFyA5lLspAtTFZ8WzPIUAuw4+zanS4LQFYIypX04kXl2bz8ks
 x0rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6dRsAfvP5KlSP0A4EEcNweZDnv/IlKaWVT2yzYdVLI3qXgLsCO+TxiUqa9yfAmrsJfmwp4zyio/0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDBZI71FLvKqo3S3hWCIcbSBM3mi61vpgxFagVCwiCZQEbYiHi
 9huk5xbhzf1R3DZJyX9xguqI9juyRugmQvqtqc/SWm48lEjZuSsQPhTV
X-Gm-Gg: ATEYQzxZOt/9C3d9xUWCvjtg0bgJKpNoL5kiVvdG8GVZfLO9z2PlbNxagbiyWm4uXS6
 voKY7rcrY6RuaxnfpuZkmyazvP2qPB/hMi9aoCB5pQsT+9NErgRTm+XjD/SNpL3bLgF6bjulRmb
 3d75kk4QqSwfmBwE1OfYDOCU8oAYn4Ea5JzecPvijsfzGq/hmQKZTC/h3k3ZF8g3+coWdQfcBpF
 pFlLKbCq67r+mYRDBrYiWL1kKCkFvRFnj38PKguGTiYNWkE0APftmtrqnfiIOTUv1IBcT7Kl+Gf
 NnxjCZK8PsE/Xygg2ldxv9//wUNEEhyV7x+WBdOcTYsPGFV8nllfGhofziA912kR6CuQbUuUboH
 w1LeuL3bJjNGsKrCy6GPhRSoy6el7xFD0V3b5joUdurRzpWTC0PibD47J6vMgjyNi6mEM7V3BC1
 uZTf789f23C56bVsUtvU6avB7zFgSW+UfbY2Tyx0qPTVBiOnll
X-Received: by 2002:a05:6808:2385:b0:467:1cf5:7684 with SMTP id
 5614622812f47-467570a44f8mr1658295b6e.6.1773408295128; 
 Fri, 13 Mar 2026 06:24:55 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:54 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 57/65] drm-dyndbg: add DRM_CLASSMAP_USE to the
 drm_gem_shmem_helper driver
Date: Fri, 13 Mar 2026 07:20:22 -0600
Message-ID: <20260313132103.2529746-58-jim.cromie@gmail.com>
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

The drm_gem_shmem_helper driver has a number of DRM_UT_* debugs, make
them controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling
dyndbg that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 4500deef4127..a0bb6110ad83 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -26,6 +26,7 @@
 #include <drm/drm_print.h>
 
 MODULE_IMPORT_NS("DMA_BUF");
+DRM_CLASSMAP_USE(drm_debug_classes);
 
 /**
  * DOC: overview
-- 
2.53.0

