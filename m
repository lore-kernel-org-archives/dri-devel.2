Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB6210AB802
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 755C110EBF3;
	Thu, 26 Mar 2026 18:57:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mJhJjzTm";
	dkim-atps=neutral
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com
 [209.85.161.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50FB810EBF0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:55 +0000 (UTC)
Received: by mail-oo1-f53.google.com with SMTP id
 006d021491bc7-67de15e8452so1423121eaf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551354; x=1775156154; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rnDJitpTduufuEe6X95vH8IiBFUBoxeB6eQQOPNaxFg=;
 b=mJhJjzTm8qISXbzl5jpQyS4CG7SCSUDLI+0ASdFjNJPf7y4DlBcsex23kVzT8MpSo6
 HACOvlioMgkFt28hF3c/KTn18MFDVP48YOtG7eu5EAFChuNzUXatsVZQtwf0ud8TSdTO
 138YeFE+469ngqVh/LUjLnSkvSvW2apoHUvgGmNebys5QOiv15unTYxhmU0UFda7mfSh
 G0qioJsLGmUfxRp6nVZFavQgdLnlcJIh1+NfTsUqeA2R6gG40bZezwE33Tzczx3JZpUj
 YvrXb0d/8zbbBH+ZQEOY+eUXbK1tP3dh/WUEmD+RS5aPDPZqMkLEACukCkkruVG+7xus
 kKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551354; x=1775156154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rnDJitpTduufuEe6X95vH8IiBFUBoxeB6eQQOPNaxFg=;
 b=TOb8BGihDXOk/6w22SniGzr/+eCjRirOkVTgefNDGLxVmO4jKx5HVSrYRYp6vil3Ok
 o40h4STmRq4p9+YVqS6PAO382+DrnnCbHbd+nXyXh8eBTgMgSZdETbycq5S765RG8xc/
 /k/5NbDoOM9HGYKepFxBr4Y3h1D9KZPUP092PuEmM6TN2zrnQKbGKCI3+sTFBTY8qIzA
 VV4JeD2241rEExJ7qD/6bSsE+nmw7MuMhhwX9xtJbIQK8pMS7PS8Onek+DyW1chwO7+o
 ddFqVj+u46sPCi7L/UKf6RYCIAPhv+/g5WUibqUpPgslpy0XXmjsrlm2BFrmBueIrbXl
 g6Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIBcRRZQn7ZKfgiH7YmNxB3MjnXPln5nZ+EWIzX59eES3dEt4AYWSCRW09oEJ8rg5Ilsiyw60JySY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdPVYbrO+Mz0g+IIEFYY2nLk9pLKiLcoOZNBloDMzyvV2PtTct
 xQZqXD3QqkYdQJ1Xu/85a7m4asb44GZnESYcfUA3Rj0sqmk+wRxNIc8g
X-Gm-Gg: ATEYQzxPrExW+9tz7bTMru4pu4FZI0QGvERmjMM4faiqhogAJOwYVALbm+FgsGEpZLd
 N+KS+Sml8G5fGbo34Zwi68N7IFb/HFqPL1fPIfK8QKMsPiMUYJ3FTamiVNPx7N1k2pCJE6i1njk
 HkdJGQZS31qukRhCXXQmZpDT/GX9p/IJb+/cSC5HidkeXeV2A37bh+WRDYQwocp8W/Qd69b5efG
 xQLL31CzJd/IxSH/TBWptgGgCrWP7qQh9FqgCUWUucrA3Mk9a07DyTETBJbvRtpCqRqZcgAJYGW
 V1Yh9QFE8EWL8bwWTymlz0owNOrN90ErQwRh3cM9vc/p4O3160w0G7YgE3pXHeKtKOI0ZbueXJZ
 G1Mwe3An/MtNGt1vDnga4R1/mRzF1WICBQic6A3S5rHlm9KuteDokUlB5yF8s1s6g+BdevX1aK8
 d8+WVI9Lb+0cW1LXp0/piwMHz5xn+w7S68iUBdbj9Kby0y+o0z
X-Received: by 2002:a4a:bb88:0:b0:67c:2bfd:24a3 with SMTP id
 006d021491bc7-67e10ce7d8dmr943404eaf.20.1774551354565; 
 Thu, 26 Mar 2026 11:55:54 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:54 -0700 (PDT)
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
Subject: [PATCH v12 54/69] drm-dyndbg: add DRM_CLASSMAP_USE to etnaviv
Date: Thu, 26 Mar 2026 12:53:58 -0600
Message-ID: <20260326185413.1205870-55-jim.cromie@gmail.com>
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

