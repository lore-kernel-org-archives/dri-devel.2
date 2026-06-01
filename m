Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0588BCD6E5D
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:05:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C36A11326B;
	Mon,  1 Jun 2026 12:05:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nSKzzcrf";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55A7A11326B
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 12:05:10 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4905529b933so76651875e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 05:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780315509; x=1780920309; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GsoCp+QEhPQqcC7YciJ1pPB6BZ3pQYi3CKXlL70tQeM=;
 b=nSKzzcrfnAWDWdllTPFv8glWbNdX6yHGaTjqB9/VEdYqE+q7ho/6vtlGFMEO8bIOKD
 sb6OvzDxSZzNE3/H4J3Lq6KpH+Hhd9hvozYbK/7oDGmWt3VH3Zfg6/BtLhco6gfFILEl
 2c9U3R6AsL+3xhBvG6Bf2E7QJhuUAnlT3T5c4CG+eDApVD/otXaMkuVUO7jRYADtJBRY
 5nC7KsjQ76z/bZq/CWdXCmUapCx6xhQT3ECqHyOmFuvULYA+4kBmmaSFgWQ5W4YEegsn
 Z7NtO4MkDchUA7ACRRF+30dVnsn1x/ZNTxB0vUsceyanBS/S/aIQ6jxv9h1ASPVFGWtU
 x+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780315509; x=1780920309;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GsoCp+QEhPQqcC7YciJ1pPB6BZ3pQYi3CKXlL70tQeM=;
 b=HAPxWxqyVDQmpWJgjyUzU9nR+xDNmPMXPyWHoTvVO+o3Y9Fm33VH2HMvSW7uUqP8p6
 /RINy0SL2samETjeZ55bj4JAKNGYwQzM6MY483R4IcinZLTxyws8iNZ/iAi8gnesOHih
 MBRTR+62vQCDcUMiw7PYrgsB8/A16whVow1db9yauNCwFpX65dnqF2vdqQ2ZRs5u27Gh
 VSuAkc2B7/+QsEEEzzxcIJR08O6qbmvSgVeaGDR2hozdffd2MRf45tES47E/BDEjaJQq
 M2jZf7HCOiDw4kH98rk49NReBNKxhoudbzB9ghB2wYtX/2VN/mmXoJhloEHqtxXlNWhM
 oqSQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/u+NP8zQKPCCW4W1Oor3QgthSPPpqbjAB5ZfeiGk+SXhs4Q9k64wB+1j5W/tIriFm8RBXWvMJB4FA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw94AGXOERiByYtw3/Xwf7dE/VbIaEQCJeXr3NMMHjGxL7tYEaC
 7zsIsOipsQQ7yQ1j43U3zLqQHm4pP/uBAXtMf5uXIWQmABjhlyiKhgjP
X-Gm-Gg: Acq92OHQhivecjiHPl7qF7AczDM6VJRGgFoV/pKMEVMF67F7fIN/erUL+5688tWhdaV
 gBnPln7FR8T4SYqvKNCa+bVn5TealnHwoGTnC2zmmwiJi7xREgevCGmuFnJgCwI4q6+sSU9rTvy
 KxYHe4rTyuAIYjJklvkqELtzxYx5u+rxo3+LRjtGdgMM5Y7h0PrDbfj4oSdTFqVDf7HdxuZuyh/
 SP7U9CFBqe3ucJ667rubb9kJlB5h/v6D5EmuaIUFkOVwz59F/OqGDvWxrhm9BZkMDbTjqGOku71
 NqPXOG2cn8gVhGOvs1Wlt/jvatD4B0j4ejL/ERKBWLCeMSIBe6yP79QdUC74viXbc9AfQ1QsKPR
 O4/oFfWe2z8W3hxbZ2/y0xGe9G83jd24PIB0157XMYj9ZwhGRuM0mc9zS5PBRWBq84BXFuCtIdN
 7hf8XZE9PG0KiPqXJFo44jHXPI2ZwpdFJd5LHDBNpXFw==
X-Received: by 2002:a05:600d:6443:20b0:490:a1be:6b01 with SMTP id
 5b1f17b1804b1-490a2923a7cmr151516555e9.4.1780315508566; 
 Mon, 01 Jun 2026 05:05:08 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 05:05:08 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:04:50 +0000
Subject: [PATCH v3 04/24] vmlinux.lds.h: drop unused HEADERED_SECTION* macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-4-4a15b241bd3c@gmail.com>
References: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
In-Reply-To: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=1428;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=gyhl2dDHOhDRfo2EoLm//e3PBy86xHd/L/qSVe14+FQ=;
 b=odAHg/A0RFY+meA/TW8ZCLAdsG0OHafCZnPdBgvkp1M24pCVckS1yoK9eKlBI1667V0xBIsYV
 ww1XkipaWKzA8FtpuBJ3CTxXacOCF8vQ5ShKpVOzVqZfQjDgCRGbJXP
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

These macros are unused, no point in carrying them any more.

NB: these macros were just moved to bounded_sections.lds.h, from
vmlinux.lds.h, which is the known entity, and therefore more
meaningful in the 1-line summary, so thats what I used as the topic.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/bounded_sections.lds.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/include/asm-generic/bounded_sections.lds.h b/include/asm-generic/bounded_sections.lds.h
index 8c29293ca7fb..268cdc34389b 100644
--- a/include/asm-generic/bounded_sections.lds.h
+++ b/include/asm-generic/bounded_sections.lds.h
@@ -18,19 +18,4 @@
 
 #define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
 
-#define HEADERED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_HDR_##_label_	= .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_label_##_HDR_ = .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_BY(_sec_, _label_)				\
-	HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
-
-#define HEADERED_SECTION(_sec)	 HEADERED_SECTION_BY(_sec, _sec)
-
 #endif /* _ASM_GENERIC_BOUNDED_SECTIONS_H */

-- 
2.54.0

