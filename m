Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF07710AB803
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5381B10EBFA;
	Thu, 26 Mar 2026 18:57:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rfoyGiBK";
	dkim-atps=neutral
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com
 [209.85.160.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE5CB10EBF1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:56 +0000 (UTC)
Received: by mail-oa1-f41.google.com with SMTP id
 586e51a60fabf-40f0e14b9f9so936167fac.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551356; x=1775156156; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iu46xPMmyhe3j2aI3EiB0/ULgdgDrucXaD4Bb/DoM7A=;
 b=rfoyGiBKRbBFMB4GkjT8P5AzCsXt/oknR+wndkEGafObPWpQ+eSMRfBFIHx0po5dj4
 Eg9giTXlAaAt99nCFLDJMEDMKyshDmABf25O6RmEuy6j2KXTbI8R/Da8KtLJ87lR0LTT
 0uMSFSN3oCzWZlSdLgz4nRXbj1ODdpMPGFvkXzb4wtfimla7WHkJL1Q0EvShPa/6XUp2
 tNKC19LavNFbTNWg8hCIfkvW56vL3vPPIsAE7qW6d3sprvtNc7SkGX6Xu67RO5M6exwA
 bWqa8DgExc8DuFHoYdmdMZLw6YPRK5/PmTDBZtvv2JpXeTyJgnHCXHaQsnTwrUT/il3i
 FKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551356; x=1775156156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iu46xPMmyhe3j2aI3EiB0/ULgdgDrucXaD4Bb/DoM7A=;
 b=RCaZDKoFc23B8kORhGi1JVMY1HGvyfgIFbsBl7Z91IJ7WM2v+yJTwLgxs5ZJg4YVey
 5nJLFLqD9UtM7fPY3IxDZ4Zpd8f2y+Y2N0kmw6POBBQiOKhnLWzlQ5zv2iki08SzJKFF
 +LFlxLzEB/ocrvgncdPPIgYfq+CPPwma/BXZkyWLFyI5Eo5GiL8wy9udy5Ix3MSvcVPg
 SxPnPJFetKcfD8hAzoFKWi4yLEFHR8in0U6Yns2KHuimnXNTSxJjhX0erZOGvHgLFEVW
 aW63roOEZUeO9oY44qippbAToigwhesDRjETRBN6VzWtkmBMtSzBFS08okSfI3mifoQ7
 ZzQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGzDFSgvxb12bslnaSwVsbAnZw2qhsEgJAWsadW7+P44231vh4Q/SptLYdGhYwbwCAPJebmNjfYUI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzT4/PjoSTJDrJHGLU21zIZckpytkxPf+ZV2toD91TgA5KScIYF
 JD4ZZr4XDMG85EeqkUNDTYiTT5bv9+qmC9oh8Mgglt+1L3YmImTCdxc4
X-Gm-Gg: ATEYQzw8sq76B/47z6Hkb57+MEvG+/gHOA1hYD2+L6gBALcct//cVMsU70AXtzBHAxz
 6GvbNprBonts+m3DowX68p6jomerjkkHPTSbFszJRNdkxm1bH+Akv4fedsZ0xmuTEHCyqtEz3fY
 UVHLj2WEqsYaCWO9aE6zzwN6dvC+Rl1D4aR4CkjNt0gCnZdlFc9TNpDiHakk+d9O7I5YqGggypV
 m9EzGY8EWft5zuLZd339fKLBo31M48wkrenfogTS0NARSzV42xLy9SSrT5bJGrg4RXE6pR3hzgu
 VE7o7WtTGIpaCr+vdcvtzYVQb2Gtm1FWphTW0uI9XujDIxhAjuXHUP1JNBj36XP4Xyi4ZYr1LOs
 xRXtLkX5P/ZMrryd/Zs9OHG2+dO+zjRyJrAHz8V7ky5V4v0Q1/J48pE8zg3JLAPO9aiMPq7QsPx
 7Iz27qz0XvFYoTTIhnbJbpU1yGipt/4p3fB92iE1Yn+re5VRp1
X-Received: by 2002:a05:6871:728:b0:3f4:fed5:d88b with SMTP id
 586e51a60fabf-41ca7078b7dmr4565478fac.35.1774551355832; 
 Thu, 26 Mar 2026 11:55:55 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:55 -0700 (PDT)
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
Subject: [PATCH v12 55/69] drm-dyndbg: add DRM_CLASSMAP_USE to gma500 driver
Date: Thu, 26 Mar 2026 12:53:59 -0600
Message-ID: <20260326185413.1205870-56-jim.cromie@gmail.com>
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

The gma500 has 126 DRM_UT_* debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/gma500/psb_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 005ab7f5355f..92b18c76b44e 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -41,6 +41,8 @@
 static const struct drm_driver driver;
 static int psb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /*
  * The table below contains a mapping of the PCI vendor ID and the PCI Device ID
  * to the different groups of PowerVR 5-series chip designs
-- 
2.53.0

