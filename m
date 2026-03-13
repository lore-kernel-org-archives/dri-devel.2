Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2656C105F7AC
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 460C010EC23;
	Fri, 13 Mar 2026 13:25:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m3kl09Ol";
	dkim-atps=neutral
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com
 [209.85.167.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2996610EC26
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:40 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id
 5614622812f47-4672076355aso1531076b6e.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408279; x=1774013079; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rnDJitpTduufuEe6X95vH8IiBFUBoxeB6eQQOPNaxFg=;
 b=m3kl09OlQN5dK2iZ3NA0J2efr132PpZtDsIPxBXmaAKJ4RI0ksQkuzxGLA6izbl41V
 k74ar3fx3+22dsxwwqDJLTrI77Fppo8C7usxpODu7DgqrKgG+//9SEg13QZE0dMNV2Od
 iDuopc7myG6Bq6sgV9TWhkzhBbx/oMXUABnmnhW3DX4GBTXsNZqxM9nEtW8oS3PI3q11
 eVue2eMom4TE8QvVJGeCqAyG9PYXV1iV91BGY+xom+yXKM/vc2nrTq+ZeSHJm1I8wU+Y
 /ek9E0mOkrZfncmtkCXwH4Y0r6Oxc3AOKju4dNqkaCsMMOcEuyDgMmItIbHudzGrXqGj
 ZtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408279; x=1774013079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rnDJitpTduufuEe6X95vH8IiBFUBoxeB6eQQOPNaxFg=;
 b=eZjjRYPSCH6zz26eUl607Q0wfMSeTZPX1RJCw4Dw9qpgxVjEx4qsQyuyjiHHXZGagh
 QkIvWdoSIePyKUZYqUh+/lbse8jal7ocsEBLCp1PokXs31u6lWKRa1idk/9FgesXRgqk
 lpsbxiN+f72kssToIzM0noSIJPSX8VTxoPGYL5rr+kb999f8kFz8Iek+Gbz6KX53WfOi
 tmOES+Ho/6JPsmAx7XiAK02qGy1gWZfnpsbmpczP3fHE/gsTjOg8e3IPWqsh8KG3rpuh
 bSuM/gOokT1bm5FhvlLuRfM1EEh7atmunkUH6tfFoi6tsA5RKIH/R2yBTptg7M1Fejpt
 ySMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW27RLQW9b6Ybzwu7BIqSJhfqSShvNC2ou4dMxS4r9iAj+dMx4cIM9tViSCL58JJFPr6hdsNwvYYI0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwtbXKDP7lAm+NL3n8/kzuIoWP8YNwWCDDflbrCBdlv/RwYFexs
 Pt+EDM0PNUuUHIjc9pmc/T/hjrVBTIAyCsO4rc2d7bIU2hG97QdOGrHT
X-Gm-Gg: ATEYQzwAF0RLvf4CJgFJhj9JR3Vz/r9Hr+ewrN5CvZyXbMifhmFHeOc0tGMekmwEBdC
 Far+crdFWPTQsJmEXdTczcYo5L0X+awt3o36wQ+p3pZPX/hzKlfvh3neNP9BRGjutxmJX3O469D
 EDwEdM/G9Q7I5DRGcBIlnbZJt6B64ezxR5zYmEBVAYkZtvhvQ+9qXukNhfrM8S/0lADV4s0g3Fm
 GM+2BZsq9WMQfYIPJ/AE7v2EIll9eGfpz8ieSqV2l3KUtPEsqM+XTusk8zG7lb3RDw8xU9XU73n
 Xck3DIrTYK68xrGvWf9h+OV7y7cAR9kK3ZpAw5wBt86oWy+Xa0T2q8jHLXwMl6MUP4XHn9MRH9l
 AWzVrQv7UGcxKM8s08V+Uy7UTMHPqhc/0lvgyWe8M/8PNrg5/R72s1sv/uDAMObkvYOGNdEZFKT
 GomViPZY3jMad850MNHl54+wcYv72Iv49PITQHDz5KbaGSNAKr
X-Received: by 2002:a05:6808:11cb:b0:464:305e:8fcc with SMTP id
 5614622812f47-4675713631amr1649395b6e.20.1773408279143; 
 Fri, 13 Mar 2026 06:24:39 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:38 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 48/65] drm-dyndbg: add DRM_CLASSMAP_USE to etnaviv
Date: Fri, 13 Mar 2026 07:20:13 -0600
Message-ID: <20260313132103.2529746-49-jim.cromie@gmail.com>
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

etnaviv has 5 DRM_UT_CORE debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs as well as plain-old pr_debug()s

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 08aca9035fc1..ef4423d4987f 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -26,6 +26,8 @@
 #include "etnaviv_mmu.h"
 #include "etnaviv_perfmon.h"
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /*
  * DRM operations:
  */
-- 
2.53.0

