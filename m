Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F436105F7AD
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A2E610EBF6;
	Fri, 13 Mar 2026 13:23:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kfHX+MkC";
	dkim-atps=neutral
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA8A710EBF7
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:23:16 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-466f59dbe4bso564530b6e.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408196; x=1774012996; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z18RPkW2IZoeg5aoWLW/CvDoUPtyLf/KFWO8hAB/+ds=;
 b=kfHX+MkCNEYvg9ohoNPBpKSHBEXIbF2Mtv+D28f7DNK6ABZDEXESdJsOZXBzp2ehfp
 NfOsDoCfRu20vYaWqPl/6vY1U4kCP2Wp6ItWI0Hligm88dR7bNNhgjqgNGF0d1JI4fsF
 R3Z/+GtKe4QRPQ2cTwUiYOLdQ7UnNnkN+qDwXQaHpspwbkNWeCVcRKm2RfgYZti7D99W
 SqzjrEKVagX/0z9YKczs5KlsgCibaJpfBWfYCv1HyHUbCh/uW0M20e4PT0Q1vAvy8QNK
 XQlphiq9H/nS6lUO9hSAYZFHlRA5KB042qZetN/XAURNq/haS1pBHAR3fEsVXaKjgEFh
 bVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408196; x=1774012996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z18RPkW2IZoeg5aoWLW/CvDoUPtyLf/KFWO8hAB/+ds=;
 b=Lv0Fi2j7W1X09TxGyzjd0aeGDRR/AashpyP13O1ljq9FZdVMHyxLxihu/JtnKd0CpV
 LsNWhL5QLT9eMgsbvE11aIuRaBGM0vSw/cmZWP5/9ns3fdCGiwdR02MwAj0f7SQvqEqX
 2s0hLgpeteddBUnckh1orWj7Kg422vE00Ch3jMf+wBYTx83bHX4VDJAwDfpnpdR7iRWH
 qg/Tg+tJ+9rIL3vGl3HViNwdbNiTfWJQm9La+CTnonNP/JImFnbhgXQ/U2PnXjAwdX2t
 WVEZc9qz5L5nWJPpWlisnpP1AEOtAGNezEooCzZ7daMmcikW41zSmTWsM+B0sp6zjMfz
 jDwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbixaFOoHJ6qsW8bFQmeXp1tVDfbqJlxrmq9smzdvOu6P6myCekopCWvYztYuG+ol5fZF7kr2VrVs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyHA2WCU4I5S+p2BFqHbkLhRQRlyDA3GWv096NeqZx1TelNwGuN
 6EJiLQQYkP1IqoE3DfGtXuWMabqYjP1kWwNkfdvH+kgIranDTYnJcWDa
X-Gm-Gg: ATEYQzwumxEgZ9VwXZ+GrBD+P1Pt/s0W+nxvG/8jDP4S7y7gVeP0JGjqA4tV+MYFAeR
 I7ILib0zwUYx/xWuZ3YkgGGZChybCd4KNHnRJrm9f6zqoPSFp1Nud3szvE8gcL9T+X2zkd3/GBg
 YNgCeYevX2T8cOp0BQ86pck9iO59F5aqwligzjHic3LF47roHF3JXC8EVd2xdWrtbBKrHCexY0r
 DOfykG9AxsJPl7O5U1atcpZFjk1W91TRgLG2JPjkTjxyeBaubvef2/IASeJ4anUCKwVL57RaANG
 u76BWnXa0RsuDNY4K37LAULxbmy2fgZz7H8K2VJe3kKlngT0PBvxuWJmvo8wtSx5BM5I7vY9P3f
 qwM0yaeeAoM4B8KAeezpwkYiJNWhr+sOrudYGYsM8Aw2UuO+2k7OnEWYkTUKcyZut7cyohFQ5sd
 t3gGrixCy6EO1kOin7ziLlrXF9pdVLd4ALy0qCC86N8W2Hk6wUit6AUFslX50=
X-Received: by 2002:a05:6808:c3ef:b0:466:fd51:6a66 with SMTP id
 5614622812f47-4675714c79fmr1554429b6e.20.1773408195957; 
 Fri, 13 Mar 2026 06:23:15 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:23:15 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Andrew Morton <akpm@linux-foundation.org>,
 Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org
Cc: mripard@kernel.org, tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 10/65] dyndbg: tweak pr_fmt to avoid expansion conflicts
Date: Fri, 13 Mar 2026 07:19:35 -0600
Message-ID: <20260313132103.2529746-11-jim.cromie@gmail.com>
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

Disambiguate pr_fmt(fmt) arg, by changing it to _FMT_, to avoid naming
confusion with many later macros also using that argname.

no functional change

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ffa1cf7c2c72..9575b92a8deb 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -11,7 +11,7 @@
  * Copyright (C) 2013 Du, Changbin <changbin.du@gmail.com>
  */
 
-#define pr_fmt(fmt) "dyndbg: " fmt
+#define pr_fmt(_FMT_) "dyndbg: " _FMT_
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.53.0

