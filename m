Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2130E10AB803
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E29610EBF5;
	Thu, 26 Mar 2026 18:57:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dkjCJnPg";
	dkim-atps=neutral
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DA7610EBF1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:56:12 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-4670676ba03so501340b6e.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551372; x=1775156172; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NDrEVSsHN3/NxzQ31ZhlYG+/I6Z2jtFfe5b8tEwBAEg=;
 b=dkjCJnPgmwZXQDBSDoi4aUBvvDBV3dRyMClnqWfixRKMZiVaJ1gFMO9H7oZzwSkgyT
 cSZkqTprD3AzNqcs3OfIVGaOWUvWDT2Ox/yzC/xgbRDPEeqCBNXBUNZu/ynKZ0ab7CFy
 Do1vcb3l9QJF9zOWPsp4Gg8aRHTCj5gtET66AIdrZV9Vmnkb+8lS4mCdBW+pVYEqnb7K
 MRDtwIE9RfQ27NlRewnjxi7VE/6HkZ8KGBAYaMy6zgv/h4cd9IoRdPKZomUieaZPS3fU
 v93H1PvKkr8gDB+D3WuaDSVjN5bbl+UqUFV7HYjfLshM1GLr3SYlS1tF5UO9b1c/qAtL
 7xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551372; x=1775156172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NDrEVSsHN3/NxzQ31ZhlYG+/I6Z2jtFfe5b8tEwBAEg=;
 b=UWu5a4XFztFgAU8LtvXhZDoP0NHMxDXma9E9LB/WPiByDeh6pAqdWiGhx0egBq2yGZ
 wYxnRpkOKsw7iQ/+K6tghYt2n6TcDXZEFsjiHq9C3CjZWCogG9Z7tCkUbNVESWqzGYiB
 1rpnimkDHOk/AEOOtv00s/HyDznZGyiF0nNt7kaCUggAKjshla7Rf6b3KKKZP4uE+1Qq
 Zi/FNzMN9D+fvPsrXzi1u9ZVHasrudJ8nJk0f7+TMX8Cxo+42gq2H+yg6gR5Dvhlzcm8
 kP+kpIkAxyY/OYZy1pO1J8OiSxafOtT9VLogJon/dNHoRFQa1SRF2fv77hoLutxSg4he
 Oxeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXpMnKwJULntD6BSMzg4XsBU4siPkZ+S2wMFT0jt4MHmz0HAYyNQQOEgoczi55e/bVnUSCJzX/0n0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAul1SVY7izk1G0ZKf8zrlMSfTb67CwrLfLypMLuA69GymL5re
 0F3ZT/5Mw/T+/SKROble8UbelftrX+6Y5teIlsvueev3B0FdUxx+puu3
X-Gm-Gg: ATEYQzyS3D4qzGgZ55qvwOGnVCmcDYehMI9g6idZRsNnV6lkOvVU0yPb9WctnGDjzex
 gFGVUOL7QQL63RKBhXpgitcdDh6E6bYaKq9Z/VKvaGYIOYZVk5boxiNlM12mzI7lm/O8nfDawm8
 sZhhYbilWLiAMY44NvbPSXiUlOPb8EDoT3hTxAqP0w4RVcAo5Wblal2ZfntdcWR2TK4xiViAri6
 OwLRf9ZqDD0NOhSpu8l9Q2TvB+xUIeybwhUjlVaEeq3iRd+fB9edhV27bk0D62zKbUwq/1WWSec
 31nsF43F7Rp6jf/W2H2DKbZ+za4eVSyXSzEd6I3Md4K3NjBHCcxWwdDKOEXfgYHcC4z4/Es11oo
 DwOYE9tQ4zKadrz2nOtKFgGIqo7+mswFKp7g8VnqRjjgkpS/kenmeKP1N2FMSdeOTZXHU1h2Sr7
 vu2dBmqZIJh2uhWnJ3uPTimrw8GeAWij3eA81C2weByx/LOosZ
X-Received: by 2002:a05:6808:c295:b0:467:2926:123d with SMTP id
 5614622812f47-46a5c77d4b2mr3987875b6e.47.1774551371661; 
 Thu, 26 Mar 2026 11:56:11 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:56:11 -0700 (PDT)
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
Subject: [PATCH v12 66/69] accel: add -DDYNAMIC_DEBUG_MODULE to subdir-ccflags
Date: Thu, 26 Mar 2026 12:54:10 -0600
Message-ID: <20260326185413.1205870-67-jim.cromie@gmail.com>
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

With CONFIG_DRM_USE_DYNAMIC_DEBUG=y and CONFIG_DYNAMIC_DEBUG=n,
accelerator modules are currently missing the _dynamic_func_call_cls
macro, due to its conditional definition in dynamic_debug.h, which
depends upon -DDYNAMIC_DEBUG_MODULE.

So add that to subir-ccflags for all accels, in accel/Makefile.

Notes:

The added "indirection" allows modules to individually enable
dynamic-debug, where a CONFIG_ option would be global to the build.

Several accelerator modules make drm*dbg() calls, so in effect they
*are* DRM modules.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/accel/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
index 1d3a7251b950..44db786ea223 100644
--- a/drivers/accel/Makefile
+++ b/drivers/accel/Makefile
@@ -1,8 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+# several accel modules use drm*dbg, so they *are* DRM modules.
+# When built with only CONFIG_DYNAMIC_DEBUG_CORE
+# (and not CONFIG_DYNAMIC_DEBUG), they need this flag
+subdir-ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG) += -DDYNAMIC_DEBUG_MODULE
+
 obj-$(CONFIG_DRM_ACCEL_AMDXDNA)		+= amdxdna/
 obj-$(CONFIG_DRM_ACCEL_ARM_ETHOSU)	+= ethosu/
 obj-$(CONFIG_DRM_ACCEL_HABANALABS)	+= habanalabs/
 obj-$(CONFIG_DRM_ACCEL_IVPU)		+= ivpu/
 obj-$(CONFIG_DRM_ACCEL_QAIC)		+= qaic/
-obj-$(CONFIG_DRM_ACCEL_ROCKET)		+= rocket/
\ No newline at end of file
+obj-$(CONFIG_DRM_ACCEL_ROCKET)		+= rocket/
-- 
2.53.0

