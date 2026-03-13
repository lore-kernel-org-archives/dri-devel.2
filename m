Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7106A105F7A6
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6317810EC25;
	Fri, 13 Mar 2026 13:25:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JYdwpci1";
	dkim-atps=neutral
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4498210EC1F
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:58 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id
 5614622812f47-466ebbf7ff7so802320b6e.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408297; x=1774013097; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NDrEVSsHN3/NxzQ31ZhlYG+/I6Z2jtFfe5b8tEwBAEg=;
 b=JYdwpci1Yd7N3lJxHR/Ue0LFCgIZrz5BNSRVr37NSRL3qI8GEbpoAkROUuGz+0wKXw
 xF7RSwgveMEzzEl51Sxfzf9KpXkii9DB3y6OrloIoUF33OP+/8U2aaqzrwJPuSqtMLHV
 d6x8RFZeA8dfRXyZm9C81mbcz8MZUuFcaUz52KLpZ3QgrszPO1qyRHLsxFWET8ZGlIhk
 gTQJ6waZhVrJGsnX2/3RiqR9idjCjZ/PBa2Y7dJNpE+5teFq4aejZR5de9609RQ/0dnx
 qBK5jQF4C4KvK3wKYeNna8SLaEAQirCRsdeT0L49RbN715dqg7wH0p4hH4g/AZTUhLe3
 NLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408297; x=1774013097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NDrEVSsHN3/NxzQ31ZhlYG+/I6Z2jtFfe5b8tEwBAEg=;
 b=QI7fiN+SKgzDd0HBd/SNS2F4K182zrhnRMGuACu1hvPSJDZMZadNIeBn+gk6AoslaT
 hh91obNzQeRDmiOvsFnWmq8xkTplrylNS0VDaYYkV3TPflfcdEoaaF3NCnuAlbLyBUt1
 0saQszag1yfrdi1XhXmOoZVOa5WaFIRCUdT1Oc1a5BcG0YlToMzMHqNYR8FPKU91VBLQ
 5EyKxmV0RCojRUnB6kLZRsNzzFTiTnSCRFRio2rgtSSACXE2rtQFj23gflMDvsVDXKZI
 80CtzdyY9ZQj6H2jJltSxdNKn7QEA6CxN4pyJcwRUOvsJv+j2PSTD2A1J6CLDapTQWM8
 EVmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW843i21JcR79DvOeAxJwPiwOD+bKVTu5vxqAMiqwsBsR9Xep4wo0lbgK7HzyuTYS2+EwoYcdsVwbs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw5LST/VeMOBFaiOrwPg5spUDpsJeUPPLgyUFsq5DuLPQXHzQdg
 XXfznPf3YmH6m/L4jwYSeJS8QorWxZ8v+UbxVEllBUy6EwbVDmNU029w
X-Gm-Gg: ATEYQzyLszPYRIg0MJ8BJvOuBRL3MbMqVsSmalyYy/6su/OrvyvQYCcJyHye9lERdaU
 4k2OfVIijRrmNMH5s5WyKZrE0yMWo10JdyE+utZiHwSlQhzhBVOQ02BZhiynwPDssS/HCevRHtK
 cJKGDY0eb6l2srboqTfSnl1OCcfbponwbTKKhcFB/g4w1nUFdQ1zsrot2VpxoLDQ+Pq0GNbNcQo
 qORGAcItFo1aStPO1IQFkBCTjGIOt2+s+bjrVt7j3ll3fpiVjkXjlvVw6D+pMUOym1srzn6WRY/
 kk8PE5BsB1XYnh6JNVh/b7PR9TkFmt/HwdmV9BAI2a9GMAZWzwbsXVo9XFsqnHtoA8qWSWYvzYG
 zbkbqu7kU/Q5F4j4Pu2XVkEeiXcA3wx6NQfCJhyhd1g2Sg80LXP8dqD7RIoSJ/qZiVDmvivwJGk
 MauKMaKs6rsEaoy4UWXN6PriGptN0nuEcDfCSZTYaZBqjh0kEu
X-Received: by 2002:a05:6808:670b:b0:450:275b:d942 with SMTP id
 5614622812f47-467570374e6mr1313194b6e.10.1773408297398; 
 Fri, 13 Mar 2026 06:24:57 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:56 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 58/65] accel: add -DDYNAMIC_DEBUG_MODULE to subdir-ccflags
Date: Fri, 13 Mar 2026 07:20:23 -0600
Message-ID: <20260313132103.2529746-59-jim.cromie@gmail.com>
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

