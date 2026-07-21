Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4FFC44537
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB3210EB58;
	Tue, 21 Jul 2026 20:57:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jr2TM5Ox";
	dkim-atps=neutral
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C30D10EB45
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:57:18 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id
 46e09a7af769-7ec49608332so2723484a34.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784667437; x=1785272237; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tICvvWUDLTcQaplMAJMGSX4sdCGxuxLlP7txV6x7Ef0=;
 b=jr2TM5Oxe8Enc5EfN9ZNfhKae45ZNPbCMRAysaorhvYQhwhn7IEkApzIXCpTFT4HBL
 n8SMtzLxbS3ZMD41gZHUYJklH9vYlgHURMcGCzLHzgcNR0xyAA9LGoYiMJuL6YNI7s5c
 4BDLFAkVbxf7tLJHkrB5kO4rYrq4IkDpIeR+oS9tz3fY1QUnoIyLWcjPr4Eocvu1FljG
 +qGsfBGYH9t+wergNVUSJbEBakH9oyl8oRV9Ae5t306tiwdK6gZTfykn3p+5hchfDtbE
 csOI7jjtD6FadpDnnJF0YEZZUAjdiZITKP+POkCJaukCoRwv85Dmszg+T7P/LsYkaMa0
 +83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784667437; x=1785272237;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tICvvWUDLTcQaplMAJMGSX4sdCGxuxLlP7txV6x7Ef0=;
 b=RwqHzQlJeGe90u+Z8J0ZHEWB8798Rgoav4gXx0pqg0o77bGeNpnbVvhM1apmKuEJie
 wWOwF0kAoBBRSjrLh7aFgtCR7KhWOuiCGejP3SzpIlu9tTDj1EnYmwJQRauuv/zJ2tQ2
 ZlkPEi7uEKmNGwYAIfweLHBI0RQfSGX5NQ6a0N7IvnBlxWZZsIIMFcTffqxHhOV2bulc
 hCmQaRmFpdhWjDkCIh8ye4owXAPjRrb6snw6jdQxmfZdk5z6RAHtOxzfKuURHVcXDYWy
 8jCOyRpOH5gvNpRvwh2Y6VoohlNCKLyYI5wL30c17l7PLZ9FiYShGpNFFdGa5xk7mURo
 ZaSg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqtm1Fwbpp9PDrcT8TVrQgHT0DsrOQfActjfD5LjE2SXnYpTXl3Dvmb572xQ8AhIkEyMmzn21XNmzE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwKdGznLzR6NidusmGrvIL5k7xpI7tLqatXlhuyyu8q8ty6eGaZ
 2ySulTJtM6elaUH8c4pKGE1DpGUHEthYg+OSytR/8eIqTl4VJhEqUPW2
X-Gm-Gg: AfdE7clKvBoRROU133esPSb8bbr9SLyn1Q2/StwrH0y4JZEYvzkjF2LDBPGXALYrENi
 1ccT3U168ONJyayJoxBY5o5rNQ8XCzIKuNLTR+d5gTjbETP86Kf8Js8C1r/DEa02AZi3GT/Axvs
 oEPxxOSe1cv1w/N6chRY4KYd6ZCE5C9d3OL8BnswQpXx/bKBiJZ3AB5X/AwHD0lWVvQ+vIbVppS
 LuNtf+onEb8xz20WiKBOgaJdWZbRsN2pDufjFdT2nxS3WsGp75d2aNUXI2jMTfSuQlf0dV71RJw
 ggvJo6f1I3WZ/wRSamU51XJsCSpgN26l8RkIh6F3Ic++vjEzEXHsfHYfdqfJSvhqWBMGo2Rg7BT
 sqIUNtusgeCiDxgkAQL1nfyJneOnLL61qFaWJ5PpVCIukd5YifpydujsIGPI308qxOvR2EPgSmw
 rhkk7tzD8GVlCgO7S8Z3k9HQtQ/9fbzlT2VNBsJ2+/8GaSuNuEbaNkKOwool9SEglRM7S8dHt1b
 PfPrT3PN0YLCdc1qdbdklJQZA==
X-Received: by 2002:a05:6830:3746:b0:7e6:c9eb:535a with SMTP id
 46e09a7af769-7ed9aa4576emr10492097a34.6.1784667437350; 
 Tue, 21 Jul 2026 13:57:17 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 13:57:16 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:56:54 -0600
Subject: [PATCH v7 05/29] drm: Mark CONFIG_DRM_USE_DYNAMIC_DEBUG as
 unBROKEN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-5-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=924;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=hS/jtkq/JrVHcN/uc/pVKASKGCENsolPn7B4mWKffAg=;
 b=Lsf35FcMlCjbByxil/qjct2DAL4mr3Oc2q7x03tL/lqrAAMPWfcuP6gbFsC+oTgUeWP2YAwmG
 rTpFDD680+JBUtHGotBL8c4zwJWAzCGG1m6f1joIJBe2KBkLkyy1u+R
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
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

Remove BROKEN mark on CONFIG_DRM_USE_DYNAMIC_DEBUG, inside
drivers/gpu/drm/Kconfig.debug.

Un-breaking the var allows to enable the config, and build and test
dynamic-debug-enabled DRM drivers with full classmap query support.

Doing this early in the commit-set exposes the series to more
in-series enabled testing, which has more chance to expose bugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Kconfig.debug | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig.debug b/drivers/gpu/drm/Kconfig.debug
index 1f4c98cbf090..2ae59a616e75 100644
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
2.55.0

