Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE7910AB80A
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BA9A10EC09;
	Thu, 26 Mar 2026 18:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RxrCJHfc";
	dkim-atps=neutral
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8BE610EBF1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:56:00 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-7d9d929e27aso1095152a34.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551360; x=1775156160; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ApYYz6FzGjXUWRVflTKhpBjuKsTkjzi7xxuPDPmj4w=;
 b=RxrCJHfcGn7BTsDUpIIySWAU9b/wzhkFqhtxEDboJ++uqFFv8WNQCwi2NOsTZYa5Uw
 3e0laRaGDl14DKPrxFmaTUTWNXV7pJOZz3OPgZ2gW2xeO7d1+Gz0Np0YtZueNim0z951
 ggFPCMhQdV3Ik2y01HPHSIIJfk4h0JdAqQGRDGZY3g0mM1UvG09g6FZPGgO7Dz3+d4sJ
 d3APVQcUTTJfszYBpSJ4/lJe1gHEd5Kc86d+hZOY8EfiRyetQDlWSSyOKKFbxdNCU5nz
 bfXdp6pqw7o7wsq0bxuZ14Df/2Gl4H1ZIEzKVxcvuryEtWLN5/DDCQ6LmvIa5OwKzUw3
 BwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551360; x=1775156160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0ApYYz6FzGjXUWRVflTKhpBjuKsTkjzi7xxuPDPmj4w=;
 b=rOEOlJqDj07s9b+NjAUTJMyGA9jErvPHl3ovPa3RbLfgqaSJm3pvuYLaPagPvwXqxr
 whNos0VRChKivri0aHZa3hHZNh6MYxpNn/io45F/SPUKmZ8VA8KKkahiuSYyc4xQWzCu
 n1aPsRQ6iqeKEopCMZDgM85SNm9xhXMakCXKfa0No9XJ/XoMgXE4Sl2v+dptcCEPX/a9
 rzON5Is3qllQBd4Rv4Z5UilWw8M6t0RjoerHO2Eb4BZklxCUYAGOviXIV9juMJr8ASrW
 UINGY8OkV4DIaQN6IbGsMN2sp7DG0yJj0j/7mADlHF0WMa/0LxyHigxqkUFHRY3z6jIT
 aaCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGokR7hWjDbNe7LNMMrMz2sfpwzyFR9Wzq734IpMIqmWUmNmKCYjCEK994M7fYxQtvWYTqbg/TSlI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxsPVpEtzvDA1DUikilTbKs/HINTN0WtPXYxTyE/eAzVXL8ujU6
 ow4CjULYzL2cxUJuAMdy4dEZndOBl2Ypgi7ctCnBfVQBWVJHQ+g8ObJf
X-Gm-Gg: ATEYQzwXXTodb90IHBG28qke9Hr67jMjiHffDJuEYcoDvIhLIijKb2z/iEqKAFcftrS
 AvJ2oChwrMJRc+1PoLpTqABvgBS5tySr6qpPO43Lg+AfIKjVdHg+C6xHQMDh/DmnTs+vvRy9W3k
 c09ZgFIMoFxN/Tt8cuJLq5bnlIH49LpyOj+fUtR/11KV5yaL5kdbX99ufP/j9SK+vmI/Bv0H2tW
 UDhSiXo7KryoDmc5ZlajHZDprSbj1ns81nORuUOweN53Ou5CI+R549PmoGuMpQ9L7bsO5hLtws8
 oJYwf3+wOm1RGatK+5aU3e98a/IkAsDy7+HUmb8OR8LZOd2GR7AJ0iPzLH2SCAV5QhDlnA4sjf+
 3CZPlI2/Cf6Tzv5Y3h0BhFKrDuk4deSA8iTxgllaVFpGD+zU9TahM9g3++bpM3E4jqonOYT+uX2
 nAwIMs4aZ16dwzhj8jL/NlMhUCmu7srquNq1z1E36yGtb42iAN
X-Received: by 2002:a05:6820:4b08:b0:67d:f840:798f with SMTP id
 006d021491bc7-67dff5a3b75mr4157635eaf.69.1774551359906; 
 Thu, 26 Mar 2026 11:55:59 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:59 -0700 (PDT)
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
Subject: [PATCH v12 58/69] drm-dyndbg: add DRM_CLASSMAP_USE to vkms driver
Date: Thu, 26 Mar 2026 12:54:02 -0600
Message-ID: <20260326185413.1205870-59-jim.cromie@gmail.com>
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

The vkms driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 434c295f44ba..02201460859f 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -40,6 +40,8 @@
 
 static struct vkms_config *default_config;
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static bool enable_cursor = true;
 module_param_named(enable_cursor, enable_cursor, bool, 0444);
 MODULE_PARM_DESC(enable_cursor, "Enable/Disable cursor support");
-- 
2.53.0

