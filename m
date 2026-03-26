Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BAE10AB80C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2949B10EC0D;
	Thu, 26 Mar 2026 18:58:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XrHNz6CC";
	dkim-atps=neutral
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69AE410EBF2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:56:16 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-466f1c3c627so783889b6e.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551376; x=1775156176; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FB+tfLWkD+EbK14YUmCdfR6TCrKrYU/mryJ+Tht/PKw=;
 b=XrHNz6CCgaDEUAEukvcraDrd2glQXYXVpWkB7rhXY2nf3WX+5hlbxBnTALSuuh8Uwe
 y0EzW8aSNpA5ez7iRydKoSlT69VBke5mS5l7s6jyyK1au7n7gtggTcnwkfVyiPCXX/Dy
 yKLKAjuc4fQfL3yGyOYebh7AKGV5j+Fi8i8tB0+VUkq73FstiSgzA6lxS+VCJqwSciEG
 q1pZPirCsrcfGun1fepGu+VrmR0MrHJCga/J+2N5Gaq5+gaG51tqGAsiFT8qjY0q1A04
 3QFgQrBLaoH86LYC9onq/Y1NBbJakcWVOTldKlTFcaJi2l7njV6h7wC+B5ngSoHHlBSS
 yFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551376; x=1775156176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FB+tfLWkD+EbK14YUmCdfR6TCrKrYU/mryJ+Tht/PKw=;
 b=kxswbzE0zuymLQOA6xki+CgpnUj2DiIITWBBRyDbnPy2qyzphcyMvSBrEKjRqIIohw
 DXvlUmxTy9+ynC0GjbvAgtoDJdsBAJ+BgdwxTuws6ZCoyQySQL+XYOktFHse5j2BR1rh
 8n85MDjHyAtcWitlqN7AUu/TCgGAJUYw691etftbg/EIrBsu+urSppADnKFbViGMuAT6
 zLwtn9ZsegMr7THaAW5ACFWVmOpWeIleCWn8Wfo8YV6x2wqboT9xin5Mb0/mjFsbWprV
 CzMFFE04o2x/FCIWLbhw9Ucr6+5enLJTqmHUDy7YQlH2efzG1W802L2HMJbg1w/3zab8
 WO2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO3ekJaBqcwsbkxtEsxOlfM7DLCYCDKtKYjqQIK31mnFiva4XD1mdp6KEUqmIInK2vAC4LrkOPmzs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzaJ0Y0HaWxMjXMDK+514a33chdy/1hMBr5TwrHOkVNury3tLcc
 gzjSbnS5lIEyWHVtewRSDu/na7U52WSb+p0+IRgBJ7cRctROC4l8Fk4A
X-Gm-Gg: ATEYQzzLeXiFS8fpCdDyayVMoOOiA2g8olk6E8rFvWtFnUjeSrF33Wb4bykv/QUJ1Od
 8mlgVH36mVooLm1s0A+ER3cKjCKrK9dHXHWJMdnKjkWx/qzs/gfIXc7HR0t3xdhxO2Ut2LBSRAn
 6LWtYlb3JmnBEpZdaA4N1G3QRAmU2aU7ERgRG8c7AgMRtV8ghL0FIzAaFfr6graiPOxMEZut6RE
 isVT4FiI0b3kjTaVxnC7rhmZG8Nw/Kse0HuzG/BDXyrXzShczGMHehXuaBbfdV8MmOHUQ/lHaou
 2cMmAnuNEQy92XOtlSxlFHyHmNF3CQ5WbrDl7qH7Tq7meSu12sTox3iNVu3db5GuPr6EqghaEzf
 +MfG+xp6wbigqLaXqsv+YkvPCaGtiwrCmrKnGsNgXmhJ4V55YU/U8qrhy285J1R3yNiX03Xvs89
 +5PpItsxoNtvt501yLEGxq71K2NpwAcHRqycHJTa78tsxNF3wZ
X-Received: by 2002:a05:6808:6f92:b0:467:db5:8b1c with SMTP id
 5614622812f47-46a5c610272mr3956953b6e.21.1774551375644; 
 Thu, 26 Mar 2026 11:56:15 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:56:15 -0700 (PDT)
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
Subject: [PATCH v12 69/69] accel/rocket: call DRM_CLASSMAP_USE
Date: Thu, 26 Mar 2026 12:54:13 -0600
Message-ID: <20260326185413.1205870-70-jim.cromie@gmail.com>
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

