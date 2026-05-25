Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD39DCD5BC0
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 08:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37E8510E5BA;
	Mon, 25 May 2026 08:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jNHiYuWU";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BC4110E5C1
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:04:18 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-43d75312379so7775522f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 01:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779696257; x=1780301057; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e4TwWx9Jkv5+tXBeIF9TrY2gJYisieGsYYHEykccDJM=;
 b=jNHiYuWUe+kEoazNz4DItBh9QEE+Z1EAac0h1dxRgebpVP4/XWhCiss3kDSeaVHC9B
 idOkG7XBsVLLLw1vR13tFZ/pw6tTWrG40D9XHdSO05AJp44qLaeTJEl3m/CM9hOTXALA
 vPtWJo9ILC020Dkm4uQ/Ci9GNjJrfVuCX6e8zymZ107n3nkOnMIzze3F84GwhWlFbrXx
 ibaAjN483uQ51whSXbWV+9+5PsE06toe7WZeMLL+e0SDLvK3yUT/I2KjTbQCZgzDUUSc
 hvktWsnuw6OETP/P3Bfk14eqcFElDgQLyAz56TV8B88oOY+Sjmx0iRtBXKPDeApeVjWK
 l4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779696257; x=1780301057;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e4TwWx9Jkv5+tXBeIF9TrY2gJYisieGsYYHEykccDJM=;
 b=F8eyxhQ+pVp0Cejkn42fGKsga1A/BrL1Yq5C1wphUNiI4KcZfosdLJNF6akVt/np5z
 tt0/gaQDExMuq832JzoOd9Zo/cus7BAW/0PUADy6XuF0V9M+78BOhyulXz02hj+0WWs5
 snMT/VeFOdVmEM18PXtDdrZvcdrMYRLF1fJDIYBGvaYJNiFa/VUDy0PxYFXhq+tZh6m9
 5NyPePrEJGESH27Y5zwKwB5swvITREd88tYaUmxjIUydjsfMA1HLqq9MJVMOFMhBK2Uv
 /D+n3WK9pH4YUH/0PQdPR6kYFd6LAM3IZpR7VrMtRw2OoaySzVZ1OruJzXonYF9ziYQc
 BK4g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8aUprg93D6DregZt5bofhDawQ5o4Ad4aZucNfcdqKHQPyUTYV1Paa0sOUBILk7LDVyGIbTdvCeOXc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwSVrnFTOGo56BUQsBSDQ/x5UQswnoe7Py6fzOi9ItDCVeCLB6L
 u1Jcg2oSDCm6TCxCDXChQz3GiV9+tsSc82y54Wj6BP5/VRyTYNy3ILnA
X-Gm-Gg: Acq92OGBtboqxkUAeuwAaWPIjLHkrMmSd95JpvnkGyy1N24gnGDhnosnSgGosDWeCO5
 TGbpIQi3tOSywvFCKMyUR/M1GyN9dubdDYM7usqweP1vH/DlIGwiZQCTDtTOFFXnnzwmZOLz8lZ
 +vXa2Fhqa6a1DKcL78rcxFH8PL8ZwPsBoX45uvufQRJSZMu7fOBTv6KA5lClrLSEcqi/a9UJ4zA
 0fzVRIviP6tQbf/hk5NKMBd9JNA4sqGNkRmvN3gW0qbmSAcVifRPsKoeyumMDtauXgI5OxzoJdg
 1o+Y71EyWr4IFfcTu/8lU9j00Q2l3jupZZwI7VxtwFOkghkjf883Qms/SJcm8+aRGJqVAW2DUNf
 mzqeC70RvI0D64JcqdMUu2cXd21ZjpGqtJdxllHRen7Yt9YdgMI0aV3EoB7kcHC0uC6Pgf7Z49J
 aNhtLi5tYIFnaHj6QGHW5S5b3WSgneAhP9rw==
X-Received: by 2002:a05:600c:46cb:b0:48f:e044:927d with SMTP id
 5b1f17b1804b1-49042480f2dmr184665115e9.10.1779696256861; 
 Mon, 25 May 2026 01:04:16 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490428d698fsm78263835e9.19.2026.05.25.01.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 01:04:16 -0700 (PDT)
Date: Mon, 25 May 2026 11:04:13 +0300
From: Dan Carpenter <error27@gmail.com>
To: Alex Hung <alex.hung@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Ivan Lipski <ivan.lipski@amd.com>, Anthony Koo <anthony.koo@amd.com>,
 Lohita Mudimela <lohita.mudimela@amd.com>,
 Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amd/display: use READ_ONCE() in
 psr_su_set_dsc_slice_height()
Message-ID: <ahQCfcFVMQY4JGXM@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
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

This code has two checks for if "stream->timing.dsc_cfg.num_slices_v" is
zero so static checkers complain.  The second check was added based on
real life crashes so it suggests there is a race condition.  Use
READ_ONCE() to fix this more reliably.

In the original code we returns true for the first zero check and false
for the second check.  The caller doesn't care about returns so it
doesn't matter whether we return true or false.

Fixes: 21fc0ff38f57 ("drm/amd/display: fix a divided-by-zero error")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
Untested.  Just reviewing static checker warnings.  I wanted a chance
to use READ_ONCE().

 .../gpu/drm/amd/display/modules/power/power_psr.c   | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_psr.c b/drivers/gpu/drm/amd/display/modules/power/power_psr.c
index 5ecb570c204e..92c0aed08170 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_psr.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_psr.c
@@ -635,22 +635,23 @@ bool psr_su_set_dsc_slice_height(struct dc *dc, struct dc_link *link,
 {
 	uint32_t pic_height;
 	uint32_t slice_height;
+	uint32_t num_slices_v;
 
 	config->dsc_slice_height = 0;
 	if (!(link->connector_signal & SIGNAL_TYPE_EDP) ||
 	    !dc->caps.edp_dsc_support ||
 	    link->panel_config.dsc.disable_dsc_edp ||
-	    !link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT ||
-	    !stream->timing.dsc_cfg.num_slices_v)
+	    !link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT)
 		return true;
 
+	num_slices_v = READ_ONCE(stream->timing.dsc_cfg.num_slices_v);
+	if (!num_slices_v)
+		return false;
+
 	pic_height = stream->timing.v_addressable +
 		stream->timing.v_border_top + stream->timing.v_border_bottom;
 
-	if (stream->timing.dsc_cfg.num_slices_v == 0)
-		return false;
-
-	slice_height = pic_height / stream->timing.dsc_cfg.num_slices_v;
+	slice_height = pic_height / num_slices_v;
 	config->dsc_slice_height = (uint16_t)slice_height;
 
 	if (slice_height) {
-- 
2.53.0

