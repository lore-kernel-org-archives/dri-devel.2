Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A528B10AB805
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADD9D10EBEE;
	Thu, 26 Mar 2026 18:55:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lgm8kYVx";
	dkim-atps=neutral
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com
 [209.85.160.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E024A10EBD5
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:26 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id
 586e51a60fabf-417571c6083so746876fac.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551326; x=1775156126; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U461BxJhRY45gNpAWL37hzV1gL48r7XKATdpr+1ais0=;
 b=Lgm8kYVxz4VV1XOLEvaGh9N7OWpoTsHXNkDRq57fTT7M2fgTTV2/r2s9c1BIhHqdsq
 pH/+bQp6EnucPLKf+9fbUcxBVHJVbX/U1hBe3+vyOt20UQdfqDroFrI+wjcXOYi+jUDq
 hDCrCWr7PkmdmjMoLI/SrjtkjF6wmFHGJjnV1tc3mMtvXzqfRxZVqzBecyQg/UXJRFg2
 09tM1XuIZXcfICaa8sfNjsuNcTg758FXNojFN+wjbnhOylgzTnx2KncCKU3upDR3HxJg
 ZW3WTX4YfCTP+ePqLe8MoTwkQQnfcR7o2ptxpA+/hVdPT2MI6qg2iiNJHCS2aiUlRXyo
 86uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551326; x=1775156126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U461BxJhRY45gNpAWL37hzV1gL48r7XKATdpr+1ais0=;
 b=XsXUs5IGLudBkvFY3a43G7LB/Xa3oCGlwqEzi7y5l5WJo7bcUzaWzIAA67q3OduZ/f
 S0/FpUyiF9Q1sJb8leQSU7cQv7puWFpYQ4ERbSR/yF8cGRCZcjVgogdc1lRgz6dLCpjx
 midYzHjh/xTWAFKO7fv+/ulEicItmtIOl5C1QlACV5osqG14Etx/6ic8Cgn1B5RFEWmK
 FybL6b4Vde8v3aR5zGm/IOEBYZs2c9fFiRk9gPsEQaTEsiWimGd7yhO6uGBOa8xXyAhw
 IFbvvWhJL8YrOSB/68ug5GLfwoYv/CXjdqGoH6NUEly/lheg0GMEyIZr4/IwHHAX5LMH
 QUBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSrXiiqr5gmdhRUUX0aCAWt8I9rB4avYdUPB8ATfhke4RqBwobTMjXLnF+WMrrJHRwAddXS8HP6sk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwKrMHrh7E4fJBvj9lb/vHDIfSdrS9N/yNXyV64Z9qMq32QSegF
 x3IL1p3o+7UhVa+IvnduA7iH5bymynnApIURHeqtONpI9NEDk+Wo1X6R
X-Gm-Gg: ATEYQzzmgqHjcnl/hnKputwGIH2mZ3Mo+rJXDjobrG853O+BqgKf3V/NLnWN9Mm/D5Q
 9D2A4Xq6RqF37gra6UfmY2WqjZ+8BNaqFthS/azkQ8yqVDhorb6rww81AEU5WRH7GMkOIwVrQHY
 XQjZufDNTd7T5Run4l1JeevV9KURE4NHtNLFNDoYJwWf2SAuKJSewlu1EPygn3yC65Q4T6PCj0g
 0eQABZLwenaXRPaSmxbOEnLGEuH23C+LvlT5IfB0e3iL1/Gn92PB2EjFyR9rZGMbV2eYqVWafQs
 dg4FwROy3bDXAKPK4yCXt5ofV36MPUlH/rFhoNRe6aTJYBOIi1JWrYtaik8z9s6YNDCCG8w2iI4
 7yXz1ukduqZXdNI6BIMfoxuCIo1yz7JU0UHvHsixeWv9OgNqa8UfSOu6g63WZ9EHrw9kS5VKkFD
 j5o6P/DE8C14px87DWl2UkQgAzNnPOoH17+CkybKy4qW1OQovw
X-Received: by 2002:a05:6870:5494:b0:3e7:fa5f:7269 with SMTP id
 586e51a60fabf-41ca6d6a46dmr4909366fac.2.1774551325975; 
 Thu, 26 Mar 2026 11:55:25 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:25 -0700 (PDT)
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
Subject: [PATCH v12 37/69] dyndbg-test: verify DYNAMIC_DEBUG_CLASSMAP_USE_()
 compile-time CHECK
Date: Thu, 26 Mar 2026 12:53:41 -0600
Message-ID: <20260326185413.1205870-38-jim.cromie@gmail.com>
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

Add another failing use-case, this time to verify that _USE properly
rejects an offset > 62.  This is an incomplete test; the proper test
is: classes.length + base + offset < 63, but the macro cannot test
classes.length at compile-time.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/test_dynamic_debug.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 779309898422..72a1a1c89cb2 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -156,8 +156,9 @@ DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_base_big, 0, 100, "TOOBIG_BASE_ARG");
 DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_str_type, 0, 0, 1 /* not a string */);
 DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_emptyclass, 0, 0 /* ,empty */);
 DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_maptype, 3, 10, "no such type");
-DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_base_len, 0, 60, "one", "two", "three");
-DYNAMIC_DEBUG_CLASSMAP_USE_(map_level_num, 100);
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_base_len, 0, 60,
+			      "base", "plus", "classes", "length", "too-big");
+DYNAMIC_DEBUG_CLASSMAP_USE_(fail_offset_big, 100);
 #endif
 
 #endif /* TEST_DYNAMIC_DEBUG_SUBMOD */
-- 
2.53.0

