Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221D0105F7AC
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7248D10EC2F;
	Fri, 13 Mar 2026 13:25:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iOkiVIqp";
	dkim-atps=neutral
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05CB410EC14
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:38 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id
 5614622812f47-4671cbce2feso975980b6e.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408277; x=1774013077; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v7n8LRPhTnKwHNdLKddxIC02c+MckVOPZFH0J7I21NQ=;
 b=iOkiVIqpkXY/meEVzhZwTzhrgpRJkQLK/j5beIO+UhaeXOCSacAZBFMGEJHF+49383
 RPv0mbNokAh00AcSFB0XFzxhrgUrtSv6eOYyTlGqQIPles/LiyoE0kNvK648BGL1iqOk
 jBIXOojVyQGiofh+0pRn9MKgBRv5cUSHZ4vGhLZ96CCl+oVGItxUPUz00EUcnKzH9VfH
 0dzgx9Ut22b49GKLWASfHEni4iEKTAaDG7JPpgQ7RVXHUcxWWYP/Yjh60og4BLgF8XuZ
 tKkauTGE2Cd3Gz6uzBLU4dpp/8iQ8lXzjLIxwPA8M4faLTNMNMaxB8Xg9yoL38v4y0eZ
 Oa0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408277; x=1774013077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v7n8LRPhTnKwHNdLKddxIC02c+MckVOPZFH0J7I21NQ=;
 b=i1KNrnlPRPP5BFh1miYTj2txGhzRnNm63YHGuLNrJueZXpA3LrWqYUmZYIb5sF7M5H
 ut+CcghGf6TUzp0RdB18Cpgv4yqwHqSR4wE1QTdUBJ8ihMs55+z1cUs0GBizFSopQiiy
 75b0AW5qt7kPq10kbQcrlFLmS6bBEDexclDoE1cPS52kxR5M7LogQWz3SdOo9nUiZ+7G
 u0Zf0Aq+2cfEVHOrynqcQ/R1AkQkSIEkkB0v9r1V37sYqzmYtbMbtrZrTTqgOJmAG5ku
 vWHk3wXCdgGCYV1Zr5tJ71xKDamd5EgJJ+xEcQ0Syqkij3aryIeQyWTry27TgFkBnvsi
 k/bA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEhKxY4ugzhztdSGTddW1+G/1M/YzyZshcFPX+ha9nbXjuTKiCVSH6bBDJil0HRFOUOruJLcuuaqA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx4kcdxIvn0RIapJ+1+bjERRiS64hlwzCaNF9MlspDdT7z+kHWE
 VC1kNqXjdpyrlmOlB6OgEMW/YK2/srcMotsZqCF04Wqo0nqbabvLmi0/
X-Gm-Gg: ATEYQzwfAIZS+yM5dLCSBXsqa6BbSZCOMYhF8N0TpG6N1YD3NCZu0eHDouLuif6YZhC
 hVkxWHiUr2d/4YL9IU8tcYP3uTepUl4JY80cQnB4APas49rQHBZM7FUlINlNQ/OSUQwOtKSBzPo
 C2n3E36Vwiepx4oULA/0qTyZQJnl3tUBPuJdviLPniuEL2OChyDOA2KCscMS2H4xY2YGPPiQyLo
 YKYaxZYRqmStsYDBaJonKxtxSfDJg456UrX58pHF5M8Pe+u+4tDKriX/ysImxHtdNmbqHMammc9
 pf/OzgPP+dw/2Pv+GY/qYTMdPSfe+boDpfp5Woi5RbiA85kWp6dAYCRw7l81NuD/xGFoWuqYwvy
 OUj9EQ/KbyvRqloOUBI0VAl0U8aRoyb6cOP/3vW1GpZu6DYOFOqreYq21atHAAV1J1LcimMhsfB
 ZYx62Sd+hAlpJXCTrQ7ag2ivvNP5bdGoR+HXxcs09t5ahMtoPj
X-Received: by 2002:a05:6808:c2ba:b0:467:100d:22ba with SMTP id
 5614622812f47-467570a534fmr1774878b6e.18.1773408277147; 
 Fri, 13 Mar 2026 06:24:37 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:36 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Gerd Hoffmann <kraxel@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, virtualization@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 47/65] drm-dyndbg: add DRM_CLASSMAP_USE to bochs
Date: Fri, 13 Mar 2026 07:20:12 -0600
Message-ID: <20260313132103.2529746-48-jim.cromie@gmail.com>
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

tiny/bochs has 5 DRM_UT_* debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/tiny/bochs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 222e4ae1abbd..8f04666e7def 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -63,6 +63,8 @@ static int bochs_modeset = -1;
 static int defx = 1024;
 static int defy = 768;
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 module_param_named(modeset, bochs_modeset, int, 0444);
 MODULE_PARM_DESC(modeset, "enable/disable kernel modesetting");
 
-- 
2.53.0

