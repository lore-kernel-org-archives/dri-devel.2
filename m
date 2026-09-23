Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92459C98312
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:36:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA17410F229;
	Wed, 23 Sep 2026 22:36:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GSPHxXkO";
	dkim-atps=neutral
Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com
 [74.125.231.168])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C04010F205
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:36:07 +0000 (UTC)
Received: by mail-oo2-f40.google.com with SMTP id
 006d021491bc7-6c2613d80fbso880372eaf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790202966; x=1790807766; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nK6gBgZb148t7QUaccdLW5Z1TVwXqhGj+TWUBMmkbJM=;
 b=GSPHxXkOpumvPDuKSOB7NpzK8hqfkTKsPSwh7Fg2I/C/qIS7JRUI4YmjLmRDHZ503E
 zCSYRZGWP15njQOgbyMF05KyoPs36VKBVCWpIbbaw+OX8/V9dpC8b/sVM86zsxd0ic0W
 l3+tsTPU8oUgdaYrazqGI/XRtnToLO0XaRWAv1Nv/tdd+tGuTP2dmdX0ZJwHrfeAkagM
 Dkwj0b0HffeGjbMzwvYeOh5xLmp/utzzgpkttaZd0DbNKFOmU++jRGBVCWNV1sDczg3U
 z+B2wR6reQ+K+TBkJAToYHvFeNgbYP4FVdfM/6vceuzKUERN5C0DkY3z3STCjc7EMHmI
 f7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790202966; x=1790807766;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nK6gBgZb148t7QUaccdLW5Z1TVwXqhGj+TWUBMmkbJM=;
 b=EwM3inLHOKoSy+DYxiDLtuysp/GZ1Dq7nddMDsXI6Er6vAu9n2coXB+i/I0FrOuxuS
 70rvcDhn/Vy8KM3igzkSQSF43iuVo4QfO2zfRQ10zMsQTa+al/h5gfCbGZr03RofX85T
 MRDnTiKdnjcVZkQRjC2iUfOMeywk4aHzeyzrimWqACOoNwpHB7jmzSEqwQVkadxsUVf3
 Mt9BAsNmEzN0Ox0HF7B65Yenzw5Pp+hRotcO7coV2NpnecARxKw0XcapotjJJlX6KcrT
 +JtFVOEYscQ60JFkq9Ppl8dkpjEUppZTu/GIWviChCN68AnB5D8tL8vmvwvw6OztyLy3
 jfxw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxyI9+YQKFmXR6m4UYEY2e3RnBustXE1T9m9cnM6jx2wv7us9/Um1Pd4tWp9e+2JTGQ7nFu3pNaXV4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mFdcUyrnnCLW58GBY2TV/GR8OlfXN2f4d190Sl9yPmotFqjGLE
 F+8r+UrsZ7VGy5dpDHmYB7IWm7XQupQmq4VkeGDLF/BnMTk9M4J/16oH
X-Gm-Gg: AYBFou3nJSU/uaQX+KcOOPt46sPTEdvTWQ7WAkIwAcGTj1KroXaHUi65F6y/WXTC7T+
 xafsvsh5UtNJNzK6OxAjGGlqb1E/sQbJVAwIpskc0XdbAEe2HGGFHkLkp/ADUI4HCQ/2DtXyba1
 5yi86y+ma3T7xr3/iGAWifF+pQUUOdmAlbTkQzDH/f3+MV7Ssz0cftBjPH6753m9EMJNioTxWH5
 dpxxSpJ4zixDQlNkm0TnAq2/heUxbwS95W0G0UVhpdruVpNI+7RwgIrUk0i6vk2lQUHJFHgeNnC
 s4/qjok8eTOEUBXDMNXlIqvQJcnDcP7I7rR7W+0VIYv7V1/b7A6F6KBSGULnv51uyNeBWshwLfh
 TMW/Zosz6CROSEgetc3PK15CvT/vEdljkGG5BpLnLj2GGTFD03kBL+2GKY6oVgMAb9A3QqQJI2l
 UGrjVSW9sclo+IH4ebHPLDlwUHjo/CE5qx+iQ9qwLtTd4C9+gclZphIvpLmu57msbA43pK31bZi
 NP/FrB+3GL5W0Cu2g8PtnZFelOw+vAxr39tpjL7BahyhXRXEBgrjFX7KufVF5qyeWezkGZQ2e5C
 jsejfcMaJvAobmh8ZTPgifmcMUksQA==
X-Received: by 2002:a05:6820:f06:b0:6ce:7f39:7c2d with SMTP id
 006d021491bc7-6d441995854mr659245eaf.81.1790202966437; 
 Wed, 23 Sep 2026 15:36:06 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:36:05 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:35:02 -0600
Subject: [PATCH v11 38/38] dyndbg: add DEBUG-biased fallback stubs for
 _dynamic_func_call_cls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-38-9b6c217fdf2f@gmail.com>
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
 Jim Cromie <jim.cromie@gmail.com>, kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=2698;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=ATqajf/gbOgVHOHG+dtgeX5M5jVEAjDksP/Pl6A4CSs=;
 b=txBmlIpJKZ3sIAFazKAMFYgulL3i/ZCu8HE6q8J8RnlArxGJutYMSYxdMbkYxGs5PglmSgT73
 lKUC42nhgPMAz+S/DRsl2roh66CQA86RbVYjeWEEbt8mfIoVrvaDPAc
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

When the dynamic debug core is enabled (CONFIG_DYNAMIC_DEBUG_CORE=y) but
the global CONFIG_DYNAMIC_DEBUG is disabled, subsystems can opt-in to
dynamic debug by defining DYNAMIC_DEBUG_MODULE.

However, for built-in code (like DRM core) where DYNAMIC_DEBUG_MODULE
is not defined, the macros fall back to the disabled #else block in
include/linux/dynamic_debug.h.

In this block, the family of _dynamic_func_call_cls macros were
completely undefined. This caused build failures (implicit declarations)
in subsystems (like DRM) that attempt to use these macros to wrap their
own debug functions even when dynamic debug is disabled.

Add stub definitions that mirror the enabled behavior and respect the
DEBUG macro, similar to pr_debug. If DEBUG is defined, they inject NULL
as the first argument (to satisfy the expected descriptor pointer) and
pass the arguments through, allowing the wrapped function's own slow-path
fallback logic to execute. If DEBUG is not defined, they use an if (0)
statement-expression to compile out the call while returning 0, achieving
zero overhead while maintaining compile-time argument checking.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605201408.x1sHT6fx-lkp@intel.com/
Assisted-by: Gemini-CLI:gemini-2.5-pro
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 04620b869832..5e69cf6f37fd 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -542,6 +542,23 @@ void ddebug_increment_call_count(void);
 #define DYNAMIC_DEBUG_BRANCH(descriptor) false
 #define DECLARE_DYNDBG_CLASSMAP(...)
 
+#if defined(DEBUG)
+#define _dynamic_func_call_cls(cls, fmt, func, ...)		\
+	do { func(NULL, ##__VA_ARGS__); } while (0)
+#define _dynamic_func_call_cls_no_desc(cls, fmt, func, ...)	\
+	do { func(__VA_ARGS__); } while (0)
+#else
+#define _dynamic_func_call_cls(cls, fmt, func, ...)		\
+	do { if (0) func(NULL, ##__VA_ARGS__); } while (0)
+#define _dynamic_func_call_cls_no_desc(cls, fmt, func, ...)	\
+	do { if (0) func(__VA_ARGS__); } while (0)
+#endif
+
+#define _dynamic_func_call(fmt, func, ...)			\
+	_dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
+#define _dynamic_func_call_no_desc(fmt, func, ...)		\
+	_dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
+
 #define dynamic_pr_debug(fmt, ...)					\
 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
 #define dynamic_dev_dbg(dev, fmt, ...)					\

-- 
2.55.0

