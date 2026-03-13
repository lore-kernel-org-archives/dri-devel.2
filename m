Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E49105F7AC
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:24:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7967410EC1B;
	Fri, 13 Mar 2026 13:24:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aJsTz4Cv";
	dkim-atps=neutral
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4165B10EC1F
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:45 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id
 5614622812f47-4671cbce626so1073256b6e.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408284; x=1774013084; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TGwHOHakhEHhnxVqmZq5DXxfR0MylvY9XafKKBqzVj0=;
 b=aJsTz4CvCeOsXdRdEquKBA5SJsAyDCqUEOQyu1zTmEpIT1RFS6MmIrUm4cq87fB3Oc
 eRvF27tONI6SmsBFv0ISviq8x+1AjSFZx8jXAug6Vi9LirRI0vUC6vQjzBRpSPfaFkWy
 MnQhVWJyl/euCKqDkqgoHajbwk6LNujk0L3V/p5b8ma1XGLL9bkiR/ZypLl2Ql+5XtPT
 0yVD6zjIbYgiaemj3uRPIGcqzqFJccqusbe4eOD61qsI1fuynjDJVa7C+XGStlBoDP8D
 yQ5R97NZCNqGRK7Al5aZEdcUtxXttB8R2gfMctVQdu9MrQQPZ8IvKIeCJhLafYZiaMGk
 9q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408284; x=1774013084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TGwHOHakhEHhnxVqmZq5DXxfR0MylvY9XafKKBqzVj0=;
 b=FXZpTFh8uK5KXihANBP9qj+izTYdVCC3bxUMXf9Y+SCzJDt6CzUWOD2SYUt+6y05fE
 yfF2NdCCmULQgR02Xuf0xSl31A1A1UA+JuZUQIPeJlqyzk7LnMTHQL5lQx1VpC1Os7O9
 0B16lAaSDfTFDn0LgnuParJ0hshwqayw5ONfKbgIrkHI4cgdZ9aUquNuYqpqsZCKqfTI
 jwrt1MLrdyIun0/dEfbD5xFXWQWH2qbL+qyhAykgKKZdwhqTrObwb58jfUldJBwMkxM3
 Xk4d8oQYVWVY68NKR6sh8BkkSOors9pwp2EltkBQHxD6TQqwb8B1KUs3CcflQPYBPBwF
 OhUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZXuKNqp+XQp/2KRv3Bix3Z8v73TP2/irliGuDMy+rDIfRbZpJw/HD1JKOeyvIfuIIrrimbhPSNm0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBMnpoYo2VeYM1UqcOSx2RcX9E/jOk1S/Y2d+P9Xa2tPdW8MrV
 BHu5iTHwExxpjUJjqZWYB/w/B2ajJ+1UAEUkt4CU39YvpdgoejO+/Mxx
X-Gm-Gg: ATEYQzwRFzH0MUz8Mt7Mzswm5hFT3tCcGI6ytSI6AhpHAU7G0umwcL5Wfozb4RZy/fc
 kqixe/JTobSO7RQiHcM5gO+sRM6sxg+dn3/BjSs9TmJXg9r03In6Ll6GzH93AELGOB7+fGw8TdN
 PeHxYLJzaUhLSEgrM/LIT7oVT1gyh1JcdvfKnOe1DbXIvDn3ymyylStuKmsWLkjs69GAaJTPit0
 ZJussSYfWyzrTFtLKFPtnw+HEDxW0wAEmd3CbwLzjEgaAN0t9f6bN2TTVVWTyuGSrBS+dM27LR+
 TO+uSkwZz2zux/eXm9FMS9YUnObz8jDHDRq8SKiRqL1LAtFAwCsQXnWbYN+4h10cwc+ORxj37KA
 i8kBE87OWAaEPfoWR35gqDtXY70aEV10SMYDCJl6XXoB5OCP6apLywJLyQD8chYVjg/TZRLK90F
 GyrQ/pHtzVviBRik4pOYakMv2gkehwaUn964DWQI2bV/uyTz65
X-Received: by 2002:a05:6808:1a21:b0:464:3d5d:d9d4 with SMTP id
 5614622812f47-467572d38bcmr1582676b6e.39.1773408284383; 
 Fri, 13 Mar 2026 06:24:44 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:43 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Zack Rusin <zack.rusin@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
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
Subject: [PATCH v11 51/65] drm-dyndbg: add DRM_CLASSMAP_USE to vmwgfx driver
Date: Fri, 13 Mar 2026 07:20:16 -0600
Message-ID: <20260313132103.2529746-52-jim.cromie@gmail.com>
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

The vmwgfx driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 0f101aedb49a..d877d0a8c830 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -259,6 +259,8 @@ static int vmw_probe(struct pci_dev *, const struct pci_device_id *);
 static int vmwgfx_pm_notifier(struct notifier_block *nb, unsigned long val,
 			      void *ptr);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 MODULE_PARM_DESC(restrict_iommu, "Try to limit IOMMU usage for TTM pages");
 module_param_named(restrict_iommu, vmw_restrict_iommu, int, 0600);
 MODULE_PARM_DESC(force_coherent, "Force coherent TTM pages");
-- 
2.53.0

