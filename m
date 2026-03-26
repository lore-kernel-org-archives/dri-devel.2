Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A4210AB807
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6AFC10EC00;
	Thu, 26 Mar 2026 18:58:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mj9P+dgz";
	dkim-atps=neutral
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com
 [209.85.160.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E717F10EBF2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:57 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id
 586e51a60fabf-404254ffe8aso775171fac.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551357; x=1775156157; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QeA7b49GNmqPBpy8bbweHTxpApMcFe3iFgz41hqVwCU=;
 b=Mj9P+dgzDwdhPEqBHMNGeOF1x5WytNOWdAS1R3h8ApNSURK0dDaCkk7Em5A67zQGXE
 /cYTajPQARaA0Q7Mcv12PfBgNwZ5oQpM9KEzdoqsM+uCTWkj/K614s+7m1M4lPV2FqGj
 kNWriKbUbFc8dbkpNS2422M16aBpNVqsiupHMEbLUFb95eNj3QFNnVJd6bL5wXnn2Sv3
 eTDIlnej+JrkTmNTsvXz8hbzxRHDeLTMXmnItErF9NgrQm9JOwahvvwS6dAlEFGg967H
 qBiDurL3Pm/H4RLHRUxfdNL/Bwdz461poBO7jieXsL337UrF0eyklsmGR5UT9aeRzs2G
 MaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551357; x=1775156157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QeA7b49GNmqPBpy8bbweHTxpApMcFe3iFgz41hqVwCU=;
 b=EIE+OBZcTyzXdapKlZGDP2W1N0SY09dDvZ+lk3AUFSF35AqNtR0vtrmb+xpQq1WHPh
 gpa/qAH6rHOHSLG4It7xAFogwpTgbSZsBpPpeW6R8Fzw0ETJqs1IeQQeyntZVOGr2Mqx
 hM0N5+9A73D0l/CUo9GZX54w6XjlK8KR+fgrkseBkqVvwp5QVadszL1KtBtH1dgGPg18
 vrbOLnCAK8IjhQvBqbr0wEVBLo7cBwIMvmG3c0RdKrkCSw/i7g9omx0CkoHwZ1+sCxf/
 vdk28BDpb3tcL6yHZ/AqqkBZl/LP/GKOV5MJ3z+3Cn4+hzbU6xPSp2zYMwUqH3VqNGpf
 IXnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSuH69xVIesHvK01RB0Ek6ZrdoEYoEIJfjDHOBr1E3WGI1CjIkHsZsGisH5dskcOq8s8zWf31BhwU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyb2F8isLtvvXZ26AvwM4QP0aITTclG4DLWRC8zCe6mbb0v+Oaa
 gBgdPXTUk779rspsLKVfLUxYQ4x9dVfe9n5EnuJiKChUWoc+69fWRSZQ
X-Gm-Gg: ATEYQzx0pP461CUMqf8ukxmcdvh6efgLfeQKzuV6dwFC+730TQV2QWqwpL8JaHlFtzs
 MPQcJKfFdCB8OdTR+kvWRihyWaGvY5XqSm9w8SXn+oU/PkXYCGiphx+OlCwYia29qhlnliY8drY
 rkQqbP0zIGt7ejRc6z48teUSqFTu89gbrSXfvPjcRMG9QpDHDGTPR3SbbUJO50D0TvdCwi+iRJy
 V+xhb/O8WAD22kucGzXfIWsdqSANOWGTpGNd60ZuFK5uqzSdTVnFvRMEbkUte+1EoyH7wYs2W8y
 KZXlwiu6OYMq9xVJImlzdR7l42JRG2t/y6sLp8zkSqa9TfAM1g+T5iwftcGvliHlMrGrxAmZVyT
 FcFZHQUwcVVrEE7h5D/djcoLS0eYdjmMlEU9biof1BrXz4hamKhu2zrDUvQ0WnWHmC/JFQTOpM0
 uVXWcEF9G9/W9ItXkWgE8hdzV2ElzDZ5gfHbzB7XwYXttSBa27OShCgDjxWsc=
X-Received: by 2002:a05:6871:4e41:b0:41c:4cd8:4e8a with SMTP id
 586e51a60fabf-41cd7bf490emr1301986fac.15.1774551357153; 
 Thu, 26 Mar 2026 11:55:57 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:56 -0700 (PDT)
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
Subject: [PATCH v12 56/69] drm-dyndbg: add DRM_CLASSMAP_USE to radeon
Date: Thu, 26 Mar 2026 12:54:00 -0600
Message-ID: <20260326185413.1205870-57-jim.cromie@gmail.com>
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

radeon has some DRM_UT_* debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg about its use of
the class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 87fd6255c114..a7133fb6377d 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -254,6 +254,8 @@ static const struct pci_device_id pciidlist[] = {
 };
 MODULE_DEVICE_TABLE(pci, pciidlist);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static const struct drm_driver kms_driver;
 
 static bool radeon_support_enabled(struct device *dev,
-- 
2.53.0

