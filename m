Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B31C43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CADC10F502;
	Thu,  2 Jul 2026 16:41:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V2z8sEDd";
	dkim-atps=neutral
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com
 [209.85.160.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84F3C10F4FA
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 16:41:23 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-44cb68d549fso343127fac.1
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 09:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783010483; x=1783615283; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Er/Iig+CT06OIxgKVI6YA3M1QIseY8trv6Rj+aIwPm0=;
 b=V2z8sEDdNYS4mjN1QwVA9ZBrGW3RDnCZMoakV2ASFAgOXH40GmU08fB1HEZAyVX/Zp
 ICXjRiULRIfSvm0F1pWUPCtycVlMBjPMIsmrAcNfHvF2psm/nOWg42KbXVWmxk9vujTW
 BaYY/IARY0nX3GxMaQsBpR8Ws3OaHkh1BGp1AQKq+IljjPOL7X37Q6fMd/oxAq3vj7+p
 n5pSslGqR8hpVyO/I3Qq+c3cV6ew/rfzzJOhchagmpzEXiaD9nqZ0AeiAVeIFEsyK5DK
 ZzLg+XHfnbU5y9mj2QHpLgEOpFOxkolsqmkPfVaCukMPj4tkKwlUCSRtTuYdmNWR98eS
 q/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783010483; x=1783615283;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Er/Iig+CT06OIxgKVI6YA3M1QIseY8trv6Rj+aIwPm0=;
 b=A1XCxo4HkRz2thwXytnNHmcnt1JXbkJE+nqH1kw6W+YnzuLi54VyFROjtu84Ph7IdC
 l1UZaDtyxiNpsQp5T4k2LBkoqb1zX2lbCIdU9pSUZQqCu5IBIxRVP9A37NnFm0lPSVog
 1OfIwiekpdRGRnfASPNcUefTwiDKY8Bo2hL48dYUHA+hmCxeUHCKmw5l1ScEGSXgsbPF
 ddtcqvLZAayyrj6EnOdvFUvOsB5fxeVVo34ezPX1+dAJg6YbKETLtXb6M2Gat5cR/2Wi
 IuA27enNBZz+IVNAl+yx8plgUtSz083GLZwYQF2d4VIy/Fism9LrJ5IfBbZIB89UGwzB
 njHQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCbGfgCNgT0M5X7v0uIo4DOsQawd3lh+mgrzXaB2m8umKpQzw5BtFCWE44THiXDRWz6+YK74PBCY0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3Ap9SAFGxU3EWDFWjpMHX1ISYpSitLDzNIpCbaj9eAncvmeB5
 6Jsez+2tDPvktnbCXdtTzBaNvmTFWkTcleVwntCIWOa9muvY7mUg8Mp1QEhmHC9Y
X-Gm-Gg: AfdE7ckoJDFMvftZ9tsyUx5Cqv6CgjdmtZtfisPOl7kWQ8ayObh8ywg8FFNnV8W0sgO
 ZHT1FCknETd8ANT6rEMx5lJg+pGpjvt7MsNdrYo9JVOOXv840/zIwwA8qMU6fu5PKbxf9hgCkyj
 1qcTdzLzCARNhDnF0sbqhztoYFzLnoaiLH0zrSNlnpktGYR+/4Rwwfq4qdjqV4Icy2hjeIoCl+u
 o7RWIh9N8VpBMp1LS01TKNEm3PKNz4aNKUIphzdZ62xdZKLTr1XrmitnGHh75MyeV8ptYkzqh1e
 aL5pEJH3qESbvb8qmA/bS41ndDUwz4ghKfrr1jgQcFMSov1F++YAvAy7u32/ZW+K7Z/+9I7pkh3
 akqMrQEb3xmyYs9CXdhnJvWEeo2aa+ErPkrCDjmQCTHdCPukoKAzdy/jL98XcFdlsvkRmfnKG26
 YDOm2JTn2lQq55Fa94b4d2/Dd8V7o7vZzByPrPfdyokEOntdJBihY=
X-Received: by 2002:a05:6871:408b:b0:43b:891d:7c89 with SMTP id
 586e51a60fabf-44cea45e2abmr371405fac.11.1783010482676; 
 Thu, 02 Jul 2026 09:41:22 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 09:41:22 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:40:57 -0600
Subject: [PATCH v5 05/18] dyndbg: drop NUM_TYPE_ARGS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-5-24f22b052bf2@gmail.com>
References: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
In-Reply-To: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=1538;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=DQaYrrCHfOWyw6I7/Alb/oOYcgAlY5tv2FwAXCcG82Y=;
 b=GFSnTtMH961Y7o+VaLt3lNBMKb5UiiKt2BLUAkWCu4TCnoTeTkKBd+sR212fvqeMrEWN2Opcz
 uYRSplmYhnZAjmAT8j1DEyjDJT0j/OaxPRXs/r1ayXuYUbIjiGKHIRN
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

ARRAY_SIZE almost works here, since array decl is complete.
But define it locally, named __DDEBUG_ARRAY_SIZE, to avoid
include conflicts with  boot/<something> on some arch.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v5: drop include, it causes redefined probs in /boot/* for some arch.
v2: include linux/array_size.h, correct commit subject, review after sob
---
 include/linux/dynamic_debug.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 9607121c3072..9ae1accb9bf6 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -8,6 +8,8 @@
 
 #include <linux/build_bug.h>
 
+#define __DDEBUG_ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
 /*
  * An instance of this structure is created in a special
  * ELF section at every dynamic debug callsite.  At runtime,
@@ -122,11 +124,9 @@ struct ddebug_class_param {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.length = (sizeof(_var##_classnames) / sizeof(_var##_classnames[0])), \
 		.class_names = _var##_classnames,			\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-	(sizeof((eltype[]) {__VA_ARGS__}) / sizeof(eltype))
 
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);

-- 
2.54.0

