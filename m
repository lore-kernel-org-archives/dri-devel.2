Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C80A105F7AC
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:24:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55B8E10EC27;
	Fri, 13 Mar 2026 13:24:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cex2FG2q";
	dkim-atps=neutral
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84FB210EC13
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:21 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id
 5614622812f47-46708149af2so1223722b6e.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408261; x=1774013061; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=93dR2Z7/f38EiX2nhH8I335LY48jx/pTe8LM2CbujQc=;
 b=cex2FG2qfAzHWDVcVmL4MnXnoz9aA+MAFL1dC8QvwTH27YXcNi0EC5Mzjjuip12rLl
 92mZx0dkqNYSCCeVu87Dbv3nmO3pLB5t48e9kTh8HMIkIR5c28XW7/zRSHCEcOnm0RSl
 7RNdWSFEROtvIv9EjSwOC6L7veL7EULBmiOnWajhCK27eGjZLBlh6ER4/Vu7EHq8NAJJ
 H2qFNF7DSSFF33jm4V5DRUzQxg+fLJm8Bjbnlqvvn9rLRXvf0694Nf1E1svxs8m2wE9b
 wGdr0Rld46F52PBUe3rdgUPwWuPnwTLOydwKC9TNOJbMEJP3kASZF9isb8fylfL/jXH6
 YdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408261; x=1774013061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=93dR2Z7/f38EiX2nhH8I335LY48jx/pTe8LM2CbujQc=;
 b=TrMDvI9jOqbPjX4ERiKQX0+PJA2mvp4Ea13W7V4dI1P4D3Ony3pGgnpqXtwVKJ5kKE
 ilxJPmkhknG24tVWicN1USXbxFe1sJuchgvcN9shlCQRrvkHwVo3Dyz5sZszT4naARFd
 E3KmfWuAcUNzwQhYqoZEikHrr8mMCAJ2re5hv5BjCeiVZhy5hkDutwAJ+PhmrpXcxXM2
 grkwhNSEk7TuADDelUmliM80a8/ABuuZz6qGSyDn7aQv68Es/+O/ri0YiYGJapO+kDNH
 AJ13TUQgJdoxkAs/3TBpDt5+6bnppfqfK4MzV17416fi6Et0IKcy1BIlgoF6E6i9bBhd
 e0Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOkjtbjbUIVRqwrCVm/f9kOOGwweYmRqmMnMVE8vjXNiRB64/FEuOU2BsDgtkJEiXx8N9bnu3TV94=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzg7UGcGtv2B47umxAlpwqafpsLmOtkBJ0z8L1BVG6da5iEm8kc
 QrvoZgehJQD4dUJqwE669yiBiGFuPJnGOQGakXUTDUqF4AxGO6hF8X4S
X-Gm-Gg: ATEYQzy5HsNsfFlVB58WCPSke9kM2pR+KgOhlV7BFJwvAmAB/NsEEh3gqvGyz+ZIzRG
 C0diHTQmFeE6Jgo10Oz4UZijcfOaHjxOsz13jMPx4/Wk/fMRc6sjksQX1aTgZ4+sD42RT7Tw8zf
 ve9p3xCyBXuW8UUtchlmS0niTxMSpcvm00s1EUo1Dj/z0x1DHOYdtqrOXo2nfxVTYYJ7jqSE3Z/
 hWigWR0EmISA6zvAFNwqqDSwgO6RlvvLt3BJ4kHJluAn0v0rGSecmlOqKEhJdTQjkWlytvfigiR
 ffM0vQTRpQS5LN6YRahMTbEgwyBhB4z5PQ6vCgfgEpyU4d+usUh4ZD13yQhRbozL3bo5ae3P9Uq
 13IkeV22BVn9SxjZhr8Wv9t53xNY2oT6Ri0ZML92pEN4lozMkFFlpNHilEXRUCZcrzonRCcG5yI
 u0YcVzr7qkGuR188/AJt3mnav1z286xANkuSZKGLCOZaz5OGy6
X-Received: by 2002:a05:6808:470b:b0:467:f85:d832 with SMTP id
 5614622812f47-46757594cdbmr1633762b6e.59.1773408260671; 
 Fri, 13 Mar 2026 06:24:20 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:20 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jim Cromie <jim.cromie@gmail.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: mripard@kernel.org, tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org
Subject: [PATCH v11 39/65] drm-dyndbg: DRM_CLASSMAP_USE in amdgpu driver
Date: Fri, 13 Mar 2026 07:20:04 -0600
Message-ID: <20260313132103.2529746-40-jim.cromie@gmail.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 95d26f086d54..e5dd051eeba9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -249,17 +249,7 @@ int amdgpu_rebar = -1; /* auto */
 int amdgpu_user_queue = -1;
 uint amdgpu_hdmi_hpd_debounce_delay_ms;
 
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
 
 struct amdgpu_mgpu_info mgpu_info = {
 	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
-- 
2.53.0

