Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D534DC98315
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BE7A10F1F9;
	Wed, 23 Sep 2026 22:35:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VCox6+gV";
	dkim-atps=neutral
Received: from mail-oo2-f15.google.com (mail-oo2-f15.google.com
 [74.125.231.143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EA7010F1F7
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:35:06 +0000 (UTC)
Received: by mail-oo2-f15.google.com with SMTP id
 006d021491bc7-6b4bff33d18so635628eaf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790202906; x=1790807706; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1bPsIBSH9RJdyH1mjOKDynlo2sUv0Ir7YundPy4tLUs=;
 b=VCox6+gVJjIV8tc1641mkG37wM8iCNcJZUDCE8RNU3L8jUeTAoxiiWrPR+gv86bT3Y
 Xr1gKK+CluoxN7QvLs7frBLsC98YSsD4OODRiS7j42DUMHKf19CG/X6oGSHiOgdQJ9W7
 w/VerGd2C+mjRY9Okblxrg1KhEcCD7TCMJr3rf+BhY1uauw8+jP9adpNylX9wm3gPKVv
 nyG7SuZzHwOPcV5sLwBtVoXbZ7sUnZfx4YEAj+xjGnF7FwmaYnx9Ipf38s1OF2Ex9e3s
 upPLD9XRbC5bvkeUS49p571CYmwCdUP7oGRjJWdu95KvFSO/8X0jvAFfURwicTTSF/cZ
 /NZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790202906; x=1790807706;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1bPsIBSH9RJdyH1mjOKDynlo2sUv0Ir7YundPy4tLUs=;
 b=fbL/5eUciU6s0LIyycrXVal8PkqrvDvZHZRqF5VyApl+brK+6yvTY4elludpjdC7rJ
 iNwu7r4bxsns3w3c9taZqoVI+jW75oeadzCnhiB+ZVqNFu7xp+6LKJD5OYimYvaHz2OD
 KlUPGCQWrRpsQjrVRhCJ+oe1ipob+7m/u8lzgnSaeqLBORxS0n/LGfoPGVR2ykqBFMZK
 wZmdOeuWtxpN8L9VBBKAVWsy5ConilVfyQodr7MsOmSWgYhbosvbqe2wHd81mxH9GYEM
 YMSF21dV2zzWbCcRnSzxGLeOd9v0D1Jga3wKuQyiEUy/1nlQT2wPyvwLtpfgH6c/Ph7a
 a9QQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx14Ml7o11gYJhEiPGHnJrNzCUcsCi7N/sLBQsE9TAFuyCHBd8S5Wz4QXxBg2zU7DwcoNQUy1WINS0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++klOjNhkO6cjGxyJTHduDdwvSLhICe6viF+HbhlNt7nXtnUCBP9
 TAgJOLaJuW9NRfaqaVyne+OoIHfgB5fvQdY/LCVUkOsjAEOvEV1jzQtu
X-Gm-Gg: AYBFou2gDYWYHjQV+6Q8MPRv/QFQJSOsP89xTR1yO/tU+7wa+Lse5kNCKkH81WX0sQu
 5YNXR7705uszTLk29a8cj8fkOJ9YZiwAPdG1gk6sy0+WDmq7dtwCy8K6CnU6AK4EraAxXcl+UGw
 8t62tBe7O0G/p0KmGR8P8VfRr9hl+72ulUpziJZ2gsgu9w89bcIMca9nKvmkl0pfy1FIgkiZ5Cd
 IRHSD2oKXDZwdUd/XE9vLq2/RC2ejS096tgwpGSAT1G2gJcjI+3OZmKMps5iDfzYvfdwykkDT7q
 vnyKN8LAcgH9iswZ/Pnsy8aungzG/KcPInJLA7FF0vbkPihE+1ccJ5ZHsTD1L5wRr/b4B0pSKUx
 Zh0u4T0BGcx5Awoku/r0g3TzldrggdSDfcS/faRHGUB0gb7YTJ59JcpVwxX193dtcgAqfVp5+GJ
 Yb4dWQedLN+qX/T4LLcM70S5QWB76Fj76lB/oYb8K7GXoh9Fki4ye+0Jtu5hwK3FY7EyohA3BPO
 ViNWmSFu6/N78wQW0lfw+UXFrdFS278EEH7hNbm7jvWvoiQgSnCfuccmEgcyKe3dN9BAwAdKtsc
 pQLc0rRLSsa5ufxF/Yk=
X-Received: by 2002:a05:6820:178b:b0:6c1:d1af:dd8b with SMTP id
 006d021491bc7-6d4412cc69cmr595245eaf.45.1790202905634; 
 Wed, 23 Sep 2026 15:35:05 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:35:05 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:36 -0600
Subject: [PATCH v11 12/38] dyndbg: bump num-tokens in a query-cmd from 9 to 15
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-12-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
To: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Jonathan Corbet <corbet@net.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=3086;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=9lUeEUf43O4OsPSjpghThL5idlm8fYFS7L4pUake46s=;
 b=sbDzqlFisyDnbimrqXXl+C8tfRzl5ZiAIX3allVEEtSUoE7lRkljJy1fRdL0a1f+4wROKfFmU
 6uazVVCMibgBDQY9764iVLv+SJBugUpQ8TuuSEcFAGbrHlkj0hj9gUZ
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

Current MAXWORDS in ddebug_exec_query() is too small to accept a legal
query-command using all 6 keywords.  We *need* 13, but this adds a few
extra to allow certain errors to fail on subsequent, more meaningful
grammar checks.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c                                      |  2 +-
 tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a39144fd7c8c..a0723343e2a7 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -558,7 +558,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 {
 	struct flag_settings modifiers = {};
 	struct ddebug_query query = {};
-#define MAXWORDS 9
+#define MAXWORDS 15
 	int nwords, nfound;
 	char *words[MAXWORDS];
 
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 957e633ac555..50916583cb2b 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -319,8 +319,8 @@ function GOLDEN_RECORDS {
 #K= b9a397e807148d13ba07da7db7e69817 FT_grammar_errs.2
 #K= 5abefa504937a329f974504f1896e368 FT_grammar_errs.3
 #K= 1d94d0f239bf40bf51280caeab499de0 FT_grammar_errs.4
-#K= 135035c8a17ae100cc4ec954c4d75b2f FT_grammar_errs.5
-#K= a9cc14244f91a12d3174ad1314144a8e FT_grammar_errs.6
+#K= 9a5e1c1856f1ebbe57a4afdfc4c9703a FT_grammar_errs.5
+#K= b3809a6f9f643f049f1ef30827d4b001 FT_grammar_errs.6
 #K= 5d400aad1a7d71f548b6b81274d00a55 FT_grammar_errs.7
 #K= 61cd359b10f9051862d3745eda07a295 FT_grammar_errs.8
 #K= 567379f4f4d099f00f37d1469d9370bd FT_grammar_errs.9
@@ -339,8 +339,8 @@ function GOLDEN_RECORDS {
 #K= 1f6fedfe222af475211b3bfc6d08bc63 FT_grammar_errs.22
 #K= c67dfeca97697b707acdd70672816dff FT_grammar_errs.23
 #K= 9574dbfdac063409b41a44e6251fbcd9 FT_grammar_errs.24
-#K= 644b81753949ac1285e38ac995eeba46 FT_grammar_errs.25
-#K= 1bf2a93a39961f40e0c2dd4c5e2edc6d FT_grammar_errs.26
+#K= 3c694a0ee2cf3a1d39f2ca8a9f3b9094 FT_grammar_errs.25
+#K= c23be05426c8727be833ff055944aa96 FT_grammar_errs.26
 #K= cdddf4ffd7fde3c12eb0c73770b872bf FT_grammar_errs.27
 #K= cdf7a2e2740ec007efbd29feda478420 FT_grammar_errs.28
 #K= f6650d69963cef433c50e1f2acb899fc FT_grammar_errs.29
@@ -359,8 +359,8 @@ function GOLDEN_RECORDS {
 #K= 1a402ada248d0d50cec13a1af150ea33 FT_grammar_errs.42
 #K= 5b46a8eb0d74009462f74cf7553e3228 FT_grammar_errs.43
 #K= 546e440044828d86135dd63f1eb9ed17 FT_grammar_errs.44
-#K= 644b81753949ac1285e38ac995eeba46 FT_grammar_errs.45
-#K= 1bf2a93a39961f40e0c2dd4c5e2edc6d FT_grammar_errs.46
+#K= 3c694a0ee2cf3a1d39f2ca8a9f3b9094 FT_grammar_errs.45
+#K= 37b7ab754e579683a28ce086c470cdc9 FT_grammar_errs.46
 #K= 3e3acfb800cfb1bcb0cc07f33b75830a FT_grammar_errs.47
 #K= 42dc6cb4fe938bb82b64c82924ef28d8 FT_grammar_errs.48
 #K= cf9320d2188f5b48d508d610d95298b2 FT_grammar_errs.49

-- 
2.55.0

