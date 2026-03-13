Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F01105F7AC
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3696210EC11;
	Fri, 13 Mar 2026 13:24:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JHhoQ1LH";
	dkim-atps=neutral
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com
 [209.85.167.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 032C710EC13
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:26 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id
 5614622812f47-466ebbf7ff7so802096b6e.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408265; x=1774013065; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nWuUyl3pJMGaRe5YpqoxGiWQwsY1kd47fne8B+3aeoU=;
 b=JHhoQ1LHbhboxKzHssmKPQavUUSA9XfexDh9MzwWt/CfUYvXh9u2emKWta+s/Lgi9s
 cVmZU5HRH+g8VRE6LxWxAqwy4sOm/KqiT98i0VsooX/633mPOAPYrNlAjlraNOSuOc15
 jxGKEa0+ChhjZvhvdlDUfbB8Ey8euoRQixOx3OV9YlcMdN/iCAxpnEhRSz+DfQMOJ073
 myeJJIGOmdbX54vquwxbRytPL7kimfIqXQH5kjzO5z/lj2ZN9/aZTswOWrsROZK/0iEs
 2rICOXrSdVrU//84Vn0TahNNtJZf9AeeTc+aCG5R5idzVKWb9jRb53+PZDs3ZQtTnmU+
 9aAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408265; x=1774013065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nWuUyl3pJMGaRe5YpqoxGiWQwsY1kd47fne8B+3aeoU=;
 b=CG15UdnKSl6cZCESVu81i27wFOKXAKExhHeCPhE8VrR6lzt2xjJsaAE5So4kwgjrC5
 JAWVHhweNR7BAUI0gnSNvBP5DU9IpmztdlMigSnws4PvLI8ZXGw3TQ2JCBpG97QM/pbC
 UwMAXO06hTqy7gHKpBAJ+ed2i9kK23NRXmIOyweeq6dNz2SwVm2rt2bsqjLAt+Jyz0Tw
 I8j20KUAuAerRHsmFOqO4cM4Xbylcw97Z3avdOhpvpW5ONJR/r2mPjY0NFU9tFbTX8S1
 9ac2C8rwH9z5t8uDGntAtME90YEjuh9IVa4oGBsb4eE8mlfNJtIaJLgIAHwkU+SUuYA1
 MfAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg4ewoqpmYyglM7yajLEc54/Es/l5TBvz/fIARZRar7vEDAvBzgn2zhlfaf8VpKQbc/YBExSX8VV0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyBqyfbkQyfS5SKlPwbvBdAwfJBtGWnpHl8G8m9/RjpUsJAilAF
 MXdv56AVzcKhinneVIEiH1VW6+Km00hbut4AW5SVsfnDlIVUKmxPx/Pp
X-Gm-Gg: ATEYQzxcJ9BlHgihpCfY6q5BDc1Nz+wEjxWMOYizWlUdLl9/cR60sfyP3P/RF7F09HS
 yOSJVmacdxRqZNfmHAHLuTBGGztuRIZYIfmwxrX3n2WebKbxLmSj7B0juaaLBYwjxY4uze64f6d
 TKxo7LEfiSyuF/IFz/BoA5HYRzatIMlQM+PXusxvJy+La2IWtxbsOKb4DYki3ylARaap0VXRUKq
 b43Fkfd+2mlIHL+yt2FGHtx5hdaJlCpmXGGiSvRAhGlzzZh/Prh4mp2CcZ8DzZkjcTWVZYi29j0
 5/mKFu5+UZId1SNSgLpEJJgPAUoqxPedg/vee7J3W+dpnbOMeUEFQJfFE8zDbv5vSGD86XjLQJz
 o3GOLNf3Tq3ITXr4Bv204/HKNs1EV8wvMmhByYas/T/CRk11hgJ20NRcnX0rfNNXxqge1DuE+Tr
 kWiI9J6n2xdju346rvTNcN9jRbwWhpJZOaODcHvVd2QSKvW+ml
X-Received: by 2002:a05:6808:30a7:b0:467:100d:22ad with SMTP id
 5614622812f47-4675708e938mr1535630b6e.18.1773408265054; 
 Fri, 13 Mar 2026 06:24:25 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:24 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jim Cromie <jim.cromie@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 41/65] drm-dyndbg: DRM_CLASSMAP_USE in drm_crtc_helper
Date: Fri, 13 Mar 2026 07:20:06 -0600
Message-ID: <20260313132103.2529746-42-jim.cromie@gmail.com>
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

Following the dyndbg-api-fix, replace DECLARE_DYNDBG_CLASSMAP with
DRM_CLASSMAP_USE.  This refs the defined & exported classmap, rather
than re-declaring it redundantly, and error-prone-ly.

This resolves the appearance of "class:_UNKNOWN_" in the control file
for the driver's drm_dbg()s.

Fixes: f158936b60a7 ("drm: POC drm on dyndbg - use in core, 2 helpers, 3 drivers.")

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/drm_crtc_helper.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
index 5de9aaa5ba04..31c5294b252c 100644
--- a/drivers/gpu/drm/drm_crtc_helper.c
+++ b/drivers/gpu/drm/drm_crtc_helper.c
@@ -50,17 +50,7 @@
 
 #include "drm_crtc_helper_internal.h"
 
-DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
-			"DRM_UT_CORE",
-			"DRM_UT_DRIVER",
-			"DRM_UT_KMS",
-			"DRM_UT_PRIME",
-			"DRM_UT_ATOMIC",
-			"DRM_UT_VBL",
-			"DRM_UT_STATE",
-			"DRM_UT_LEASE",
-			"DRM_UT_DP",
-			"DRM_UT_DRMRES");
+DRM_CLASSMAP_USE(drm_debug_classes);
 
 /**
  * DOC: overview
-- 
2.53.0

