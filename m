Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189C4105F7AC
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E08C610EC17;
	Fri, 13 Mar 2026 13:24:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m2M9ZwD8";
	dkim-atps=neutral
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC03B10EC23
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:31 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id
 5614622812f47-467166cb638so882385b6e.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408271; x=1774013071; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6v3HiIDRukL8wqePVR5l3Bo2Gj7Iv9DgR3CyiTeT7DE=;
 b=m2M9ZwD8aCUQtZGu7iVH6hWRTABvTAlsoDXTyuJ7V2AahorDA73SlA/GShhM01BBaR
 mMMrVw2bippTj04HCqWBNB9kzvLdR85tnQiU40PU/c+cVWzj+RYTipaghy+dLDZV2Lin
 nAls1bqx9PNdfIjdU0yKzrjZxSY7kP6aij2aWNc6Gu/fdb3Wv9vw1IxPttWY0FkrcJHu
 HvUzOY5LX76fCN9j6NGDFFpDmKLMxd/JR+PHGjnTWhvr7bLWsvB+ewvyLkxQ4AiAIlCm
 l05EIJv7hPaW9ibVMHNDV4IK5+lmmgk7CWZkooQEIe20bsHDUsIK2Gzc+LjWG9vHZVWz
 lCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408271; x=1774013071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6v3HiIDRukL8wqePVR5l3Bo2Gj7Iv9DgR3CyiTeT7DE=;
 b=IL9XLUlkaGIWRSCAHDQCgzS9veFEjokrcTrN6pobmDZ86josC8gpYr939klgnajepy
 zN87Hq+WOFpJcSizFKfajqW0YldzyepS3gv1iewEnpEi1KWAK0Q7BYNzXG8qZck+7eu5
 I7CvbR8jju5iyJ32rzgvpK4Nhdf/qXC28RAhq2om2upQ9EJEro/+Br9XUZn6wT/wXNP9
 STv93Rl1HFUO1a95rh+pnrnBBCiESuHmf5y4Qrsat9xQNTKp6bhPB/STu0EEDmkRlixV
 p0dcYnNTkwV81a6oMJILYVyaVGZyJwvAySYiyk6zSKT467P9Axl/C2CPo/+dmWiKtgAI
 t0oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeoMpkNvPFQm72FGW74QLoioJgHn6RNLDZaX4MawLGz7+2GgIQvlThCK5SgWIPomJN0kOrK4sMssU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBW80s4Mj/Oj3xwQ5h1sG2dOcJl91F0aRNNjYgsX+Cep+0rWyf
 TpIj4Ag75rAgCDmc+ljgTn2TsZdzw+Cbqo9zIaj8rYuvi8QxiQraXtd4Uf350Vb6
X-Gm-Gg: ATEYQzx1hBuU5kPoTmZvAZluGQ2EWOrva0bGznF8g4Sbbh7hhJjveMcwreOyhyuiqWj
 qB6Ki1k5qDAkaovc9p5z0FmOLhcKQ0YJumkvDhNPUqGiWUCOvJRon9UfdL1escLM6CqzjAwzg6Q
 /7r/g0WJYaBDKgrIXMBFbjI4Sq0YEsEfTVDJ8/EX3BtsAaZN1c2jISus9UfLE6BlKvyti9f5tqF
 UTk0ZJpITG6UNgKktd1bFTl6Ist0HzhwVuhvZeivp92Kar/yLu3GHx0eDvRElv76OtWakkT8YKB
 69GaU/fuRt0zny0TIcroZES+BFMmiAG1LzkvJdfEBoLhRiYheBuHwLS1iVSeOmlHM+RfZVv4r9a
 rYCL0BXuECAEVIqmXcS6OPG+ZYZFZsm2kgNedhmDdULyx38xrlsJpNp8k9zvNKtOiXE0dyKjzgG
 PXejCvRGy6HjTjnJtUlqr+vFWPbklLYBGldLeIDg7WUwhER2Bq
X-Received: by 2002:a05:6808:1203:b0:467:32c1:acf1 with SMTP id
 5614622812f47-467572f2d47mr1467910b6e.39.1773408270898; 
 Fri, 13 Mar 2026 06:24:30 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:30 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 44/65] drm-dyndbg: add DRM_CLASSMAP_USE to Xe driver
Date: Fri, 13 Mar 2026 07:20:09 -0600
Message-ID: <20260313132103.2529746-45-jim.cromie@gmail.com>
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

Invoke DRM_CLASSMAP_USE from xe_drm_client.c.  When built with
CONFIG_DRM_USE_DYNAMIC_DEBUG=y, this tells dydnbg that Xe has
drm.debug callsites.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/xe/xe_drm_client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_drm_client.c b/drivers/gpu/drm/xe/xe_drm_client.c
index 84b66147bf49..3af476f0449f 100644
--- a/drivers/gpu/drm/xe/xe_drm_client.c
+++ b/drivers/gpu/drm/xe/xe_drm_client.c
@@ -21,6 +21,8 @@
 #include "xe_pm.h"
 #include "xe_trace.h"
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /**
  * DOC: DRM Client usage stats
  *
-- 
2.53.0

