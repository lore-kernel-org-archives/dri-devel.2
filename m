Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8B410AB808
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 327AE10EBC4;
	Thu, 26 Mar 2026 18:55:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ke/ptBKm";
	dkim-atps=neutral
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com
 [209.85.160.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2654C10EB82
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:54:44 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id
 586e51a60fabf-40f1a1f77a6so939337fac.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551283; x=1775156083; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/SjSwC+RMF8YRDI51sil3K6xHtCNjZlX0uljPPVd8o=;
 b=ke/ptBKm4p0ve06eSY2eIJ07OdE5RuwqIBhgbMR4ZPd5ufLiLOMoP6E8RP48+FRCKw
 Z1374oLFBknREp1qQUERPM1vKbmu1M/reuJUzE+hzmupgXJF1sQSSjY6ku5H0KBj/Gk8
 wKSL/Yaw0+CZyuSMbvrtYIfj2tmki6g9/HkR1H2yGBlWu+mN7A1wQY8TtoAW7erqxFGy
 awesWNVaGrkUaOgHnfjIi54A2ZhI7YqoAOTSvdl62JQxV0hRzM1gKFwm9vVLjt3eUC8V
 iroybWNjPiKgaRHYlk43naFxGbk+elRtuezp/wapaI9Y8+iL01ZxV/guXxJjlPyBW20m
 WSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551283; x=1775156083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R/SjSwC+RMF8YRDI51sil3K6xHtCNjZlX0uljPPVd8o=;
 b=jtzDB7MS8wOaJJ+1Ja8Bo9P7DUPT0Ub3rhpZOHUTDceCoknL8obsfloOVsJ0pg9yHf
 c+bopjvAl5goNq0Wu8dAYb1oYJllXKH/8wE10E7jd7c7hGD7ixURXgTdBeJ94fhHyGmk
 iZNyTe2Sd9bgOUgYmt1Mq6OgiBjo+6mN/QwgA7OXdh8U7VZpyRqq2+sY8ZQ4voyG/PcO
 /+qQt4WqIWDnSBtNR5nX/cSsBvjY0ULR9/sEDgNcT7q4PEUbjv2zaKUUPTyxOS778yhK
 c8phCShPGnQGV3KzWisXU26sxuxmUdpqhT6EmrKoVtYPx/TfJktKeABZImoxBXqnuIT6
 BErA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSEY83uGIUprl//j13lnhJFFZbroXEGgQHka2ln7RhAUBb4ISVu19fYviMqqN0LdtDDjqUIN9nSKk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw09goRfdit51AbcANtfsQiISZRgHuV7dbD4HoNhGEQLmBjgRi1
 fCbLgLdufoBUIwaeZWgi9JXJNo8oODzcDO47n7+MqxUDFjtEOJYpnyGk
X-Gm-Gg: ATEYQzwcgJfkwTCVW3VfeQOturgi93vDksF3cHSAVXXvupQibsPzkb/CpQ9kkzLjeMn
 S26PlWRBk5Z4D7f8GPAarkftCfpMWl40Hp0DzpVpcLFzJF4O+Wy6yAPimsvFT9CRDs06I6gl5v0
 WHyrldFVFW21+ED/JvR6nvGACDtvNkfJ/MaGK/bEIG+Tf0ZM1e6qn8Aa32Kvy+HP6C+fnqDPWPC
 I16wV5Zdr9TSs4wrILa+9nkJPpTtWD2TPGhaEmtjxJNBuHgMbh3PXie7j7UI6XSXj38rl/dXNlm
 YsWgJDptzILG1GTXnOVhiD36KsL6qOriLXlcgY0KszbkC11tte2qR4TfwnqvNUsxJlKkFejKGwY
 4567//EIp8JYtQrpY2224zckFjey2EfOqNE0+9f+apRTU18dGtcTtdaPb9VDJGqspbpbVhJfGHP
 QX9908WVrjAS7QLA5N2fmsFbbCG2KjM7UAl360N3Qnbnb2F4cx
X-Received: by 2002:a05:6870:f28d:b0:417:c2d1:fc2b with SMTP id
 586e51a60fabf-41ca6e86dcdmr4692709fac.21.1774551283268; 
 Thu, 26 Mar 2026 11:54:43 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:54:42 -0700 (PDT)
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
Subject: [PATCH v12 09/69] test-dyndbg: fixup CLASSMAP usage error
Date: Thu, 26 Mar 2026 12:53:13 -0600
Message-ID: <20260326185413.1205870-10-jim.cromie@gmail.com>
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

commit 6ea3bf466ac6 ("dyndbg: test DECLARE_DYNDBG_CLASSMAP, sysfs nodes")

A closer look at test_dynamic_debug.ko logging output reveals a macro
usage error:

lib/test_dynamic_debug.c:105 [test_dynamic_debug]do_cats =p "LOW msg\n" class:MID
lib/test_dynamic_debug.c:106 [test_dynamic_debug]do_cats =p "MID msg\n" class:HI
lib/test_dynamic_debug.c:107 [test_dynamic_debug]do_cats =_ "HI msg\n" class unknown, _id:13

107 says: HI is unknown, and 105,106 have a LOW/MID and MID/HI skew.

DECLARE_DYNDBG_CLASSMAP() _base arg must equal the enum's 1st value,
in this case it was _base + 1.  This leaves HI class un-selectable.

NB: the macro could better validate its arguments.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Tested-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/test_dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 77c2a669b6af..396144cf351b 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -75,7 +75,7 @@ DD_SYS_WRAP(disjoint_bits, p);
 DD_SYS_WRAP(disjoint_bits, T);
 
 /* symbolic input, independent bits */
-enum cat_disjoint_names { LOW = 11, MID, HI };
+enum cat_disjoint_names { LOW = 10, MID, HI };
 DECLARE_DYNDBG_CLASSMAP(map_disjoint_names, DD_CLASS_TYPE_DISJOINT_NAMES, 10,
 			"LOW", "MID", "HI");
 DD_SYS_WRAP(disjoint_names, p);
-- 
2.53.0

