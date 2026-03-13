Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239E6105F7A6
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:23:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FBC510E121;
	Fri, 13 Mar 2026 13:23:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dp0V0cci";
	dkim-atps=neutral
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BCBB10EBF8
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:23:08 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id
 5614622812f47-463a0e14abfso1411903b6e.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408188; x=1774012988; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/SjSwC+RMF8YRDI51sil3K6xHtCNjZlX0uljPPVd8o=;
 b=dp0V0cciEDCn+h31DffW5GB6xhZcH+5M6/0ypUrTGL0leHGsL4FQMlPdUKcRuL2GUg
 lbsbXGRgRczLzu0c/n/OWnZmQpDC5xjCWTMpBsGl+JbWzOeKfAGmKLH7IHCsrFvJyhGh
 ImEGcx/MBOvkUxsWwUQ6ZXj8hQkdfIAz8TIji312M7kWvvYesZnJBgbj/w2Y+c9UHWXz
 maOieuGvIlu+wZPIShhLVFOVpGcO3K0D2Xt0WsjcDvX90P8mG737XFHGFUFU+WsVwOyr
 sX9HR/5HIdI7I2YCqe50fqM6tE6iZNmVCUok0CONUWHDzFVIg4vYyzrAmFYacdvDfmIE
 tb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408188; x=1774012988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R/SjSwC+RMF8YRDI51sil3K6xHtCNjZlX0uljPPVd8o=;
 b=H7gf/bwho0gobkl5vFkENe/Feq9/lYyhB8F4+ztufXficGf9hABnqhghv1wRYxdHU+
 mmB2BAOw82gw10dTE8moDBpPn1Int52xcFFEe+DRzinSDjw7gH02PZ6rLhSsG/wZBXT7
 OUmt6FUzKOUqniwLfOKsQd3yijpvS0zjnh6SvtBDFY/49avgQhzyUXYnft0Ky00AJaDb
 lIP2laYEWIPzmPb/AV5rAueduTDFo9dki3uPLnwwu0Y9sYQ5s9uU1U+35GuTCvVWqDQs
 54V/S2HfG/C8FiLRjIR03HQu0uUO85RPUbdx5Elt4SkSd+z5KWIfEbbmgfnaLUIVk7KM
 ky4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrCsATuI24Qlk4GpTCOu0zlRdYlt4/hxLQ3q12xvx8SUbAvH31WC26BpV+43azuRNb5IrUx8fRm0Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyRG3F+2e67D/0t6j+uRdh8a1jSzFKR7xfSeNmJtY6Eq7WCJKvW
 tHWOxRvkiKKeX3wr84LmqUwhcNMNUcG+pvCjnwcfpBQ9Dox9NTsWkqVZ
X-Gm-Gg: ATEYQzyourUbFxzyxhagHs9cbssXWeBhnbS96gvAVHBE28cwz0MwVNv7nT0+NDrJkSG
 pbj2o7fYPWS9fYrlEZOjI2puzrvLMZLEWpOBDttRw2hwx5kTysP1Fiamms7Hxtl45L40J4ZH8rm
 1/ulUQ3N4mIotOTYcTdB5WAfF6KwaHgd0IQloFHF/kEaoiq6FbYNbMF1qHEmaLUg28B8cXh9AAl
 cbu8DiXXqf4LbIFBruQUg8Fsc+gnA9VjXYIkBKT/Voe8+cYP2ZeTULw1J+5vXVpZfx4g+ULi2nG
 A9xpb0w+f5lLwR4Hw2KVmSYIcXhaU+YawfhzMnjwYSiAQ1uxTwJNmom2h8oax8hRjS4sqbOL+RO
 N6MRG9mnVGT4BtAIIvq48jbN3MZ60GBC5neS8RZHmBycozct98ZC2mQIqkfFfiGIeryQW0ZHotH
 Bm3wlWNhbECTV97AI3F+7qdQ9haWlZzfkLQj3J+vdL1+onMYyQ
X-Received: by 2002:a05:6808:c188:b0:45e:e088:5f3e with SMTP id
 5614622812f47-467575cda13mr1872198b6e.49.1773408187615; 
 Fri, 13 Mar 2026 06:23:07 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:23:07 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: mripard@kernel.org, tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 06/65] test-dyndbg: fixup CLASSMAP usage error
Date: Fri, 13 Mar 2026 07:19:31 -0600
Message-ID: <20260313132103.2529746-7-jim.cromie@gmail.com>
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

