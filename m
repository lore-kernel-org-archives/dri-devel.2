Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B6C10AB80C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:58:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CD9E10EC07;
	Thu, 26 Mar 2026 18:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CjHObJXX";
	dkim-atps=neutral
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB8E810EBF1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:56:09 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id
 5614622812f47-464ba2bb3aeso745613b6e.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551369; x=1775156169; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S4W3w9+Cd3LB8UtvA4xSE2rspTRatyv6KzC/l1k+Ff0=;
 b=CjHObJXXc8iTOat71jFYbA0lC96kHEBouJWuxm+wM4YfaHcKhFCrj++EdKTfowfnwC
 t8a/S9O5YE6HtmHRuJg+G+Sllih551sfoQHTSBqqoZ2wgsCFG9WuFCFl4DgKfYHqY5wC
 tfRQIIr9fnVL3hbVAI30tDJQ49bACzyAdvI6UkP57QN0UYAzKg5QjFjGu3zuHP2Iy6IB
 qGr1oGsFfQssyphIjhBlCinGOM/Uo2lEtyXIR2XV54GAA/H8PHpawQgQDzDt2uA/P/bg
 +evSE6hdk+Iptp1CH/nC+uCdn2I7HHn8hSoc92ZR5knKv0zjPrq2F5iESzXZOPb568kW
 UPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551369; x=1775156169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S4W3w9+Cd3LB8UtvA4xSE2rspTRatyv6KzC/l1k+Ff0=;
 b=kEMtXCtbSGGSL+2nFHBBR7rDAgjJ9DBbIq1aFZD0KKvUGk/RkEeI7KJrc71VYuv9jK
 Nj7/Di1VBCkbcUXEXGI8bPdR3X9PFnIBADRgrcojEjbFXMDzSXPakUp2qcyrxIy6taxL
 7Qr4y6K2oAhdAvO5XmiWde12iiZElRfAZB2BKnXA92zhJkznGNap77g5mTrqPddYFZPC
 KS7xtLNferz8Qr4fEywTDUBtY6G9vdXbluCbBF2zYCRm52RC0awVKfNBt6R2x6OR3AmT
 e5VxdChvI7n+e7v/tPuYt4m/3hvDzEgVms/2Nbw873rDGmJ5bD47F6x53muuPIYlKI4k
 tyJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQlpmk6aXUbyQPfDYl+0bHWQ5UlbjMovSoGu9C5G/SixK+2t+YEcQL5EbN+kFuRnJJL/zPBL9b8XQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1SwbcTtIAs+MbsUfkxyNAnMIHPkqTroxtq0rwKVuRKVyDCLgT
 NO9n51scb0UmHDb2VX2LwbzmGpEynaYkM2WooJtBiGHjkk9yK/Fb/qKj
X-Gm-Gg: ATEYQzybe1UEfkSXnVlRoU/mq58CrtxZApOlmkBmydtuSxjHegD+rRMGS2dnrL0wUoo
 jUPLZpZbKjXg44y5UU8lMlEhC3dGjG+KPFlJQVnPr6OC0C8R+dKVGjIV4qphVj89i/T0HBo9Vf/
 d3e77UmuKWur9DyWjrR926geTwV2JrK4+BjtOUu9vtVJzPq154wA6Mc7CfF+ABfjoNXhGvdOywh
 UhzKAFCvjvaNZIPewHYVhmdBdzRyB8d2azZR6qJD5bcaYVDvdlwN1cWVeakfohrokSgxikqLm1A
 iCaGssxkg2vyvX/2lMz5RU/GdljVo68kRNSOR6RRI1DdWQg2caREJ57VmuKJ43TjqO+rchSSBMw
 Exnm2KiVeuVUV0gHX3kTc9CkBdP4Y1MMH7qRBmqB4jYMNWEphfXoqWDJunIfkETg5zGax2Jfgdx
 E00m/k4pwhbdeEIYtWc2gaMglJjz/wRKFa9UVHFcdIqhvLfuxn
X-Received: by 2002:a05:6808:1807:b0:468:4b3:d12d with SMTP id
 5614622812f47-46a7a88ab56mr1246480b6e.11.1774551369095; 
 Thu, 26 Mar 2026 11:56:09 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:56:08 -0700 (PDT)
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
Subject: [PATCH v12 64/69] drm-dyndbg: restore CONFIG_DRM_USE_DYNAMIC_DEBUG
 un-BROKEN
Date: Thu, 26 Mar 2026 12:54:08 -0600
Message-ID: <20260326185413.1205870-65-jim.cromie@gmail.com>
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

Time for some thorough CI.

NOTE: the previous ~18 1-liner patches adding DRM_CLASSMAP_USE, can be
replaced by a single call to DYNAMIC_DEBUG_CLASSMAP_USE, from a source
file linked into all drm drivers & helpers.

Heres how it works:

1- drm/drm_dyndbg_classmap_user.h calls the macro.
   This is a weird header, since it declares a record (inside an ifdef).

2. drm/Makefile: ccflags-subdir-$(DRM_USE_DYNAMIC_DEBUG)
   adds -include $(drm-src)/drm_dyndbg_classmap_user.h
   This "header" is compiled into every object file in every module

3. the DYNAMIC_DEBUG_CLASSMAP_USE macro is altered to declare the
   classmap-user records as __weak, and to place them into the
   .gnu.linkonce.d.__dyndbg_class_user.* section.  This allows
   multiple declarations in a module to collapse to 1 record.

4. dyndbg.lds.h's MOD_DYNDBG_SECTIONS() renames the section, stripping
   the .gnu.linkonce.d prefix, so kernel/module/main can find the
   section and dyndbg can process it as before.

5. drm/Makefile: adds several ccflags-$(MODNAME)-DRM_DYNDBG_USER_SKIP
   definitions, this is one of the ifdefs in [1].  Its needed to break
   the dependency loop that is created when drm.ko depends upon
   itself, or when drm-quirks that it depends upon also depend on it.

So this works, but it is weird (horrible, hacky, obscure, marvelous),
and I dont have asbestos underwear.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Kconfig.debug | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig.debug b/drivers/gpu/drm/Kconfig.debug
index 05dc43c0b8c5..6c83b1276870 100644
--- a/drivers/gpu/drm/Kconfig.debug
+++ b/drivers/gpu/drm/Kconfig.debug
@@ -1,7 +1,6 @@
 config DRM_USE_DYNAMIC_DEBUG
 	bool "use dynamic debug to implement drm.debug"
 	default n
-	depends on BROKEN
 	depends on DRM
 	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
 	depends on JUMP_LABEL
-- 
2.53.0

