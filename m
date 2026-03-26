Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6E910AB80E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F6D810EC0B;
	Thu, 26 Mar 2026 18:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CZp95l9S";
	dkim-atps=neutral
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com
 [209.85.160.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89C7210EBF0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:56:06 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-4043b27ddeaso853193fac.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551366; x=1775156166; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ves6/eFJLAs0HG68Znj+VH4wZtUdDvx4ZnDak47UPW8=;
 b=CZp95l9S9Yg0SfZ7f6KlJmcbF3c0GrNH5LivAhepCkzOCZxIzhYPQ5V0+MMdGr0oPj
 qvAAfkr2NuO6GnJMh2ijqtP1zTRFNQhamyI/4PfpO1PiSQ1HndiWySTNnYySVUGeGm0X
 MM1O1au+mgT/HW8nm+YBrfA/D1gKUpHmUrfjqgg9E/P55ms/lAfgqX0tfSkymtmadq44
 73IGoPISKS5Xcj9/vDEA7fzJeLZvJrTDFcd8KT9rMF33QhtrQbuGFICeLu3bYJXX/zrO
 pvzjML5Mf7pO4S7J3YI+mca0pEIRL6tZy5SPN7zezyG54qtBL5YI6ePzU5mXILcNUvbE
 2f3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551366; x=1775156166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ves6/eFJLAs0HG68Znj+VH4wZtUdDvx4ZnDak47UPW8=;
 b=HKjK0qIULfyrcNfbyKkf4Uj++JytLiw/laX4x5EuxznUeJIdRXKEvWrj08qLij/4RW
 xUlpG2FfpC14zM/4SQ0bqRt/WVewOxNqf0Ue+Yp/PA+NZKm1Tmk/bDFQpb8xqJ+cV/jW
 HXgzGnjfhHdw+Gzeya5LTQwNlcQ/7mflq2wL7G4naqGkoj1Yk0YxVZCZcIuZm4BU6rhS
 I4Ag8UTuA13QxLmiCSQlRV2UYXPeTy+jD0y3PXfaz9AcyG1HbLCn/gzfV5MdmQ1E8w7J
 Pa1LZYngp06Tc374q7FdLxF253NfR6+71a3zLmEFo3DucVNr2d2RqJAlOBVszQU7et1Y
 wpeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5C0ouCr3MGPPyzs29B25Y/+oE0k//rd9erUcilq4GmSCC7VwCG+JSrnURW/70elynGI1MLRfa9Ww=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxW+H5cZscyXNXdoEsZ8EZbN7oEADbmQY1cWZWWzyj9vNWKT/DK
 ZRr5ejEht70d0c3G4pKLZb7PTXEKeV4KwGFsdEsHThZJosmbYkJniT11
X-Gm-Gg: ATEYQzwxoF3MFQIw24PtWo/6UGlz8y1kxgGxMRpEiDTk/+zodxQnmLpVtlR1kMbRMn1
 iDNFBJSv0OqPoLYpvrFmX2lMvZT8Nj/EFDAJMz4hkjkvyCTogM2Xw2gCh61NrnqmvUv7uRfpAtM
 o6tlo3GF0Pcv1REpZFOzWnjV06o9QqVAzBAZln5pMys4WWhuiqyaGUkW/sQ5wxVTkCpJ97NKq+t
 M41E5QUc/KzokZu46gfn8HvhfF1ylNl8oW6GhVn9SNCXtzNhNK8XIJtJhrWHwlxPCKYPDCDhqZy
 OFdZdf6Kx3SvrZ9J3vT5h93BcunwwgwERfvPoJkN0YppTGWLS+hShfGw1vvpquSvoxUZRSfeeOE
 HhgBlN97I79jME8GALa3EspsCP8m7BTArDFemsktIR7w8+JfsXayHFrrSF7+Ttc4U0jCSh5lyuV
 GXBm/BeT4RaQ7o6pFEDm7S3fvhNpDoC8jTB179q2U3YAvVlvh6
X-Received: by 2002:a05:6820:1506:b0:660:ffcf:42e7 with SMTP id
 006d021491bc7-67dff45c71dmr3869491eaf.30.1774551365754; 
 Thu, 26 Mar 2026 11:56:05 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:56:05 -0700 (PDT)
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
Subject: [PATCH v12 62/69] drm-dyndbg: add DRM_CLASSMAP_USE to the qxl driver
Date: Thu, 26 Mar 2026 12:54:06 -0600
Message-ID: <20260326185413.1205870-63-jim.cromie@gmail.com>
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

The qxl driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 2bbb1168a3ff..73998bb331d9 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -67,6 +67,8 @@ module_param_named(modeset, qxl_modeset, int, 0400);
 MODULE_PARM_DESC(num_heads, "Number of virtual crtcs to expose (default 4)");
 module_param_named(num_heads, qxl_num_crtc, int, 0400);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static struct drm_driver qxl_driver;
 static struct pci_driver qxl_pci_driver;
 
-- 
2.53.0

