Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7FB10AB808
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:58:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8765510EC0E;
	Thu, 26 Mar 2026 18:58:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jH8JNCjP";
	dkim-atps=neutral
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com
 [209.85.160.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB2B410EBF2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:53 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id
 586e51a60fabf-40ea36b56b7so1086501fac.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551353; x=1775156153; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v7n8LRPhTnKwHNdLKddxIC02c+MckVOPZFH0J7I21NQ=;
 b=jH8JNCjPnhoEXU8PXBKagfcumi83KxobSi9w6zSWsuLksp4W8J2B1gRcw772lV+oWG
 Z0pvsdQs15w1LZhq4r0oPX2zvEGnTctTZPFjg3TDovnf00IspfboybiKY3V++3SDFV3b
 7TRfM6q5V2mv+FEgitJ0HADKEBszbxqcT4EvNqpURVvc0y2ZRdI+/Ti8dtyChAMjUX4C
 NTVpOOGBQDiz7VoQXwM4oKRsWgdA6Oge8C7pJDih8T4/rG0rGS/bhNP9ZV0BiV8U4wjY
 kbrBXkImgcBLHCwTQzZH+AJkg2SNnVAc4AOynGxJTaJ0k7nNkiQKglLDd5k8bgWY/zD8
 OYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551353; x=1775156153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v7n8LRPhTnKwHNdLKddxIC02c+MckVOPZFH0J7I21NQ=;
 b=T9Eg3U43yNeMYP7AQbF0Dek5bCKOGZiqRFRiIXRgUz77h4aLBSure+vBCC+tM8MVIs
 7RsUQ/bRvELwv3PSF4NRgq9+npn8iHXUeGXAGIE/PBBMEbC2x7vQgRY+s342gIBkQaUy
 8ShaYHKwdJf+GzSfpcZMEnwZFr7oNvlAI3Fy5GJre+fMktOrRhztd//G6PJOkVLr3AU7
 eRi3KOMPRGmGlS4RaayraEd0D2VKF9GYkeF0vmyzbPmpqzDC3RV+maFLxA5hioWq7owI
 fGH2krAYgiZsIJqrKG05c5qMNkT5t0UAz7ELGXQ6QkK9MZkRUSFeerCOT/MTtxws+DNX
 fxRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4NuG7xw9hDconozcrIKgQtxZBvz+8oyA1jgrUI6bCV/snQj+aXNKWjnxO0aVOY/4dgiQ9zNBI21Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwWPkF5x/DKLI76Y+vrRJJhAF6ol3auS7YbHmfGwodzsYMqGXHX
 z1SfGZx1H5rJqc0JfWMloUVHd1WjnsBsw6toiEgrXPunSl6mF9ZM/zuF
X-Gm-Gg: ATEYQzyf/4AN4WmDNn4vLnGgtwucmvNHgqreIvNEtDXvJOtRQPdfoQSCATlgOwFjDW9
 hoeKjHkN5r4aFJ6PLrQzuok14ueFPt0/8V6n14bujxnA4fZkz9x4FKOacSwfpyapy6pXgq3sujg
 7rz79V5jWehPvNpviCPgA1vFr7eZxNl0QuNmAMaqMWv0/WGFSc899U8ymmtY+8vJgkVL+Bl1k3e
 URU0KZvyBDof9LxCCF/1fMq9h2R66XMgOfZx27qyGMdfmgClGwNNxgvh5XlaDfZD5EMwPh6txK2
 Wk7HyF+Xb4ZI4+8KqPB/hSFbY+iIeocksyTi+5nnBOIiEVmReaLLIBs5CeujIl7OHexasbBW3xh
 SrGMaDV/+jpWRrL0k0ZPRaHxbcms5dyQl1bKYF34utPZOu/M1wb5ZrVjQ0arr+z8FNDBmAk4PZ8
 Jy2BLJXBkhliPvoQ9IH/t8B8sTr+dQ3OkJcma/6Kp+JeI/+ejH
X-Received: by 2002:a05:6871:608:b0:41c:305b:14d0 with SMTP id
 586e51a60fabf-41ca7049e58mr4680983fac.35.1774551352968; 
 Thu, 26 Mar 2026 11:55:52 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:52 -0700 (PDT)
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
Subject: [PATCH v12 53/69] drm-dyndbg: add DRM_CLASSMAP_USE to bochs
Date: Thu, 26 Mar 2026 12:53:57 -0600
Message-ID: <20260326185413.1205870-54-jim.cromie@gmail.com>
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

tiny/bochs has 5 DRM_UT_* debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/tiny/bochs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 222e4ae1abbd..8f04666e7def 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -63,6 +63,8 @@ static int bochs_modeset = -1;
 static int defx = 1024;
 static int defy = 768;
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 module_param_named(modeset, bochs_modeset, int, 0444);
 MODULE_PARM_DESC(modeset, "enable/disable kernel modesetting");
 
-- 
2.53.0

