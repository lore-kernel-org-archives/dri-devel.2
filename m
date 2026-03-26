Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CE410AB808
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0CAD10EC0C;
	Thu, 26 Mar 2026 18:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NSOxAFem";
	dkim-atps=neutral
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com
 [209.85.160.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 642A810EBF0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:56:03 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id
 586e51a60fabf-40f0e14b9f9so936221fac.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551362; x=1775156162; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hVWjZWuErU/TT0M/gLtU2+Pv2Hf/DF/3aPzw5cJbYqU=;
 b=NSOxAFem8i/tNrxRVVawg4jU9Uf13f0Z2Qm9vNtf7kHjMlfEC+xyPWqX821hK/un0d
 wDj3avjCg9P9AHkuwwbRWUZfd3Aro6fWdmzDbV+I+fO1/mI41spiSvROI/p+czSHW0FB
 4c9Um57AnLdRjIfsNIkGyNNGdglUKDkruRTelDdrmXp28zrckfezrguWx8ZBGabJzcw1
 AXkVvj8zYYrvkzk2NbFxNyPscCjvOcnoy9hJ58ivJ0aQ43bHZEfLWhA+RyEQxN19MN9i
 OR+7XAKiWsBAx7GguBakMFLFOxmwyTvYGmrO80rvPkeJBH1/j6km4xEqd8yX/qaDdpTn
 M3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551362; x=1775156162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hVWjZWuErU/TT0M/gLtU2+Pv2Hf/DF/3aPzw5cJbYqU=;
 b=DtFSoI0cVNi4W96mnPDvTQprZNL29Uf3w3QFiXnG997xkYlFSGtShVbtkw/Y+ndqtd
 aSpAVKoR08HFTm0YuViFbzSJ8GjYhR7PTvsA9revFKmw1rLyLZnaMhvGqSXUWQ+pN8eM
 uhKYn2nEY26FRcFpPhRmfrEaweTH12yCHyqXNCcjfKcrktcpP0dnR40HQY4YQdHAc0ec
 apKzm5bbcr/pKJkDlzpBpG41c8IqyoU33AdoiVSTPYhhRQt9sXxGsZeaE/J4qWlkVzl5
 mTsVcssfh9ztFhh0c9BCns65eLpwI1P/7ODY+FcrxtaoBgPzm59TbLhiB2HwW/LYAjJ6
 dESg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIXZ9dkvaIsIcg3yHijYsEzsVLZqlAxF93gsjSe/xOdpHLdQN9I2mcNUTILghWlilD9Kr4/7snss4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz63nWbYMaRt3BmS7mes7ZkdEidN1A5gSbiRt7p6L3ZD+B6FbQr
 4DctLVYBrh9UV8zJSwvQun+Uf0wQ0XiRO/gAXvh1s7sfqlw9JXbajqA+
X-Gm-Gg: ATEYQzwLQN2fCXXzi6B8zf/JpMJzuO4hB8a4c5jXffDGil5pPz6F5oSSzsuUCtbBMsm
 jhVEG/XQIwiKp7QfjHFUqeq2bn0ph8/l2RSq4ZvjdEXVHpjAZ44ugVHTGCbBnzqp6fxihkVooYz
 Dnhd0Of46FTcdz8Hfk9b49bXqC/6bRlqydfKb7xoBfWM5M84Swd0OgPdBtmEm87eQMJXAgUP7H9
 hzJXMJPU80PJhggOi5TZLyfSV49oOzlp/d9kEsy2Dg7gVW+hu/qhcJaM1YFQNWnyw8XbH4k1g2e
 V5vBd31ANw74QAjeuaReZuyhC0bnHw1YnToH1qLNchL7qLc51rDwOyBk1y+9gTrkkUiwAsZr2pM
 I7Cxcyqri1d7GFACq9vVgEJ93f3+N42YZLrOtC2yYf6KlXH583ce5VPs0yKcyK3CWKoJdKfUSUn
 UqZkwqv7TBR5D/ofO2ClfaGaWPUJYIFRosYW+kDscI15YeIQnO
X-Received: by 2002:a05:6870:6486:b0:416:414:bbd7 with SMTP id
 586e51a60fabf-41ca6e689c4mr4624024fac.21.1774551362660; 
 Thu, 26 Mar 2026 11:56:02 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:56:02 -0700 (PDT)
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
Subject: [PATCH v12 60/69] drm-dyndbg: add DRM_CLASSMAP_USE to mgag200 driver
Date: Thu, 26 Mar 2026 12:54:04 -0600
Message-ID: <20260326185413.1205870-61-jim.cromie@gmail.com>
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

The mgag200 driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/mgag200/mgag200_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c b/drivers/gpu/drm/mgag200/mgag200_drv.c
index a32be27c39e8..02a703e5de80 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.c
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
@@ -28,6 +28,8 @@ static int mgag200_modeset = -1;
 MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
 module_param_named(modeset, mgag200_modeset, int, 0400);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 int mgag200_init_pci_options(struct pci_dev *pdev, u32 option, u32 option2)
 {
 	struct device *dev = &pdev->dev;
-- 
2.53.0

