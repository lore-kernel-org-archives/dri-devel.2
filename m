Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D346105F7AD
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:25:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C8BC10EC26;
	Fri, 13 Mar 2026 13:25:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kxKogpGm";
	dkim-atps=neutral
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B83C210EC20
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:41 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id
 5614622812f47-467161c4ba7so1424217b6e.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408281; x=1774013081; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iu46xPMmyhe3j2aI3EiB0/ULgdgDrucXaD4Bb/DoM7A=;
 b=kxKogpGmhw7mwAsLuF/cNhURBdNMPRLwWlsYMzzTJVmty2nGwGnZPB7dLsSRHoCloo
 To5TQop6InxG4TKSA08WuaCfUSpp76Yng+7Ckt6UgrO3LF+u1XqYAsfs9QLPXr+1cpY8
 7OzlzilvssTF/r4Cnz957a0behSAG0Jfg2TLA9aT4vRDZMs0fAveRmHYyZF6rtw/6C4Q
 iW9Yeq/xAnY5OY/YDNN3Dm1gQiNtKgH7/A5yLCFJT3AW/r0HzO8pOZEh1ogIYNd4Q8Qq
 PnNX25fMJGlkiHGfkmldWR8KLPUKiRaAbZO9MUPKAQ0MGnr/42OZB93JbTjksnFl+UfU
 DbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408281; x=1774013081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iu46xPMmyhe3j2aI3EiB0/ULgdgDrucXaD4Bb/DoM7A=;
 b=WU9bhDoj4/4kp5gmdv6qY+pepIbURowD/UIFRl1ta2H0WJ7LaiuQujkMs92STeC0Jy
 slHivOuT9Cfe+78LnWalwPxaOFDGSFMk1lxK87VSt4q7UtfmHH1haDH8/rKjL8yBieNr
 sUfdGpXT1mGYP2ShjB6xLo9BSd3WDncYCiVXbyl8nB/hjO5fkQBchj+b8M6Jap+LKb4Q
 Fo7NHzsQt26NmZpoQCbrKEQi92G4SeG5z1zROOH0x3cveXcnL9eARsBZBiuUcWKkVGPh
 l9cT/ikBiq+QtG141Zy0xW9wprPqjzRQ9RfGK0h/aGr9Ocz3wffYrG5jX5BLYal4PAo1
 psWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVih9lFnSN/9hR47YX49wb4vaZSQUU5eIpHJqbk7vC05ULeeU7yZzsah88WQdl2cUTFonWk6/yTxm0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwJIXmRD0yOmKEg0FfkJXsKVDkJAYL3sCd7pJIzCmfVk6ci00Ta
 Aja6K+0I78aUQU8RMz1MoB+R57X5dcORhgAnJKZP1iVdodBdxPvcIii4
X-Gm-Gg: ATEYQzxinWumVP8VN7lOlG+LXyvZOd/9wHtZKIGk1jvccJMkwwdNWdf4f/TBfo1IeSB
 uhTp6MzjF4VcVFlOBKKrjQjepwxR0haahq2sethL2z3BIVnnyJdNPYvBG73nMT2IwhNZFAUsPM9
 G98Ur8ja1FZZz/hNoFgtb/ag6DOgEMAt3mc7HfKIvytDxIIqK4itYOT0K1DhKiQsAFI6T4TeoEO
 /c1l/Fuwn0syKPOKnyAOC/tJeOiGkOkFEjUFw9EVUgyag9Wi1HYPs+mkbUcvahSSFR85BEr3KmH
 g28xgVb4VFATJBW7/7L08yuAwRs5neDcxW2MwbYo0JGWIsmRRAGPOip65ASEGDvgyWfoxgt5kbC
 GhMsf8dBsLvsuAEsfznj/4NXrCmXUjmnQlpSD0ZoBzl1vacx6ifpRLbHWQSbJKC+UpPKIlC3ZXy
 sjoNgWo+ij/c42CRQwNgZCPLbwiQ3PwF6aGHHg4dWYKUFmRsBw
X-Received: by 2002:a05:6808:c40d:b0:45c:80bc:964c with SMTP id
 5614622812f47-467557e5b52mr1847301b6e.26.1773408280854; 
 Fri, 13 Mar 2026 06:24:40 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:40 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 49/65] drm-dyndbg: add DRM_CLASSMAP_USE to gma500 driver
Date: Fri, 13 Mar 2026 07:20:14 -0600
Message-ID: <20260313132103.2529746-50-jim.cromie@gmail.com>
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

