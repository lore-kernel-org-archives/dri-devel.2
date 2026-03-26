Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A672410AB802
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7428310EBEC;
	Thu, 26 Mar 2026 18:55:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kecb9Wbb";
	dkim-atps=neutral
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com
 [209.85.160.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42C7410EBE9
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:42 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id
 586e51a60fabf-41c0aae84e5so970851fac.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551341; x=1775156141; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=93dR2Z7/f38EiX2nhH8I335LY48jx/pTe8LM2CbujQc=;
 b=kecb9WbbHe0WJPkkW9xYW6t8hBEBq8OQ23n7G6ZP/lhh1HqeogNq1ZB6UvbGmz58hm
 C83d+dGlcAkdgECZaJ/pVD9jhxO6y7YndsV6f6BCjzGNoG+lE8fMM0PQ4nEejwja3FAL
 QFz1a2I92n7i3cikCYwCCc9p54GKPqh38mWdZEFnTpDIupMbLHXT7Vug1Y4tSkzZMNkR
 SUWeCxlKMXYV4Wba9wfSudsrQ0SZQ9W6G27WEsNhcFNigAE2sXKpFZBrvq37ujajJfKu
 55ImOKrPurq+HkBX1qqg1GRcgrc04p93W/rtanU/0o8wBmC+tFoZfcixbAwc08S2ej8b
 lg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551341; x=1775156141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=93dR2Z7/f38EiX2nhH8I335LY48jx/pTe8LM2CbujQc=;
 b=DsdCyIyiE5L8/wHVmEE5UPQJZj9hoEV00JIvV5+0nCeuaNDtxsBKcV3fxecpwlPzbP
 Uh1dzvbTrbhwK+tgfjktPEXcUIucJ388FFd/q7O/9D3lOKS+Y21FVt3d5KOKEeBxHk/f
 E9Fisf+7j3QiAlXhjheqnayHAl2x39+EK725gYtna7Dv/3suKhcVlI/Luu9n/sNpxcTt
 ZOhagT1lIHt7Vv816ikv3G1Zscy+/XUOxjoVYZcJAxX3rklr/+y+cUUo4WxKLfYvowSd
 bb1CHMm/cU3MPWaX2eVz8sFzdWwHoUnKkbAQ85QQWYWhu8zwvpbwm2VUgkQx0pKTrIj6
 SxRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8toSFQc6nKqJrO8qSSaA/T6iee7tW5/W8hU3WlyrJsVxHpdsHhHgpycXm2H6SnstwQc1T49gAkKc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz6TkHq16uUxiNjI4UwPjmtUtvUq0BzlZ6gKqBYCFxgl6Q75PGT
 7GO68zwhcRB8mmRU8KIxTpIuhjba8pEJ3TLLWRu0us5ttO644hJGl72b
X-Gm-Gg: ATEYQzzAACBx5lTLDon5/FtGy6km8YTEP+wANXgL42IJoAJWjHRro6GmKw4QsagrJ6/
 FuPBzItJbUz1wX3ykdd0URQmmD9VEVWMZfwHpdokETXaLpmg5e2v4TSNOyPrG9YF9eL9ynNkiO9
 TU8a8c3lB7fs3VfYd22nKegLvwd3lCiRj2XbVrB/RRTxM3TS70q5dP+syafYnPvbMwFCblU/fxV
 1foltt620NKg/CUS6Dw1U6w7UNG/a/ITj1Q9K7NbreegaeVrffhM5InndGkeXFKpHVw8cVp3kxn
 G11N2VgipNiY0CtL8X21WoL6AYe2Q7pDZE/4lJuH6Ta0wkUYORbktrlrMHuv9lCYTa6e213EVR7
 UE/gsTgacH8Y07AaXFxdmYv+HZsn7KAiMHwLmt7pJZdLGGB7A4NzPC8Bof6IdGO/NySVv46lKLY
 EzMdoDQXfUAMTEB80njZObJWkaeJNvUU6YRj2ZcnzH/Ksj4nO3
X-Received: by 2002:a05:6870:209:b0:417:2b13:f2cd with SMTP id
 586e51a60fabf-41ca6d734dcmr4697103fac.10.1774551341455; 
 Thu, 26 Mar 2026 11:55:41 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:40 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 jbaron@akamai.com, gregkh@linuxfoundation.org
Cc: jim.cromie@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v12 45/69] drm-dyndbg: DRM_CLASSMAP_USE in amdgpu driver
Date: Thu, 26 Mar 2026 12:53:49 -0600
Message-ID: <20260326185413.1205870-46-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326185413.1205870-1-jim.cromie@gmail.com>
References: <20260326185413.1205870-1-jim.cromie@gmail.com>
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

