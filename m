Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8347EC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67D6310F507;
	Thu,  2 Jul 2026 16:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jRW34PJe";
	dkim-atps=neutral
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com
 [209.85.160.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD41F10F504
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 16:41:27 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id
 586e51a60fabf-44cc65b0a7fso585169fac.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 09:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783010487; x=1783615287; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+qvzOPyUHO3fHuBhGDC3KudpInHlOoaoXrnpC0iw+NA=;
 b=jRW34PJeKM1qBL+T8SXhrzieJn0R5eBytshlQeB76w+VZ8s5Y9VZp9wuwzVtjdQnad
 SBeUW4J7xvIcaYydDz+KU8IQqbstZQCy9c8HZqgwBkdNWlDBnfuD1FFOrQtS7BUZcGak
 1ZrA9tzjc8+t3o7xAR4gSi4Xo5JdIbT8Ec52ulXani1/nrqC6ZghNt9WFqVNEuU1npgr
 /VhUiWn2y0wQ9z2wqh7wZ5NoRlMU6h2pELv7DEfoejCwfuQuJDcUKbvi7lhS9mmxQuO6
 fUQXSERxFr1CWE4AaL31bIbSbcHbTU7+KSfI0tzXgdeIb/kx2Rj9UZEcAE8AXgfPYsVV
 zBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783010487; x=1783615287;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+qvzOPyUHO3fHuBhGDC3KudpInHlOoaoXrnpC0iw+NA=;
 b=aTPz7XvMT7tE2lJJmYhuJ6/vONqfsQjhbR7/YLfbnFk9CCqx8eZfmUS6xjzvwgHbBy
 mF8UwW8A7q0MHxihMDn4VpZ1NtnrbVIrd0I62e7108tXWx+DdMzaqvVci2klmxB5mTAQ
 hhz7b7VhUFNY3hCw5+JOjiDCxk4lrHV/4vbVjmSuv6DSdkpd4FR9YFudj5D5uVpzwQKg
 ecdGXT96EX6iNxRbKgUg2uqe7N5ukUupK7WvZueZfbCyCKZR62jSpeQHNLm1p0b08UKq
 LdPAaifhZGitPctEs4KUN5E+WkJ2XA6eEBD7QxqQC3CQHSoHYg/fFn37Rx2KFMpxF8q+
 8MTA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp3S+37lThQflvYJP6tBoStUoKPg2pdcF16bd82iO9S6Hp/vI33V5MQN2+etN/DxZyMGN0mhAFwgzg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIy0PegjnZ2kfcKlk8jHiSXLCVMRSk7sSzX8E2JBVoHoVZ+Jcr
 otNTJGvXNtGARAtrkl/7B20QAJeC2CgPWT7SrzJSIMh6SUy79CgkoJXt
X-Gm-Gg: AfdE7clu8SXD/GqhfRyXzwRVI5ulOUrpn0EpKeUD2QCQTST3t1zpRqNnnGmY+WwF/DF
 N+Ffu1RG58NNarFL85iw1+f1zusoXxxdQmAGz1+sxA9P1Qn/ZDFonLIBY+xNmN8FbV/iosaMIcK
 H2H+LjMP517lz/j77nRNltZgzxjkzJQKAqNU9txInYqcwJivw1NL+fnwH65UtCgk7znrzx/LmUY
 X396X2xjPL4YCYS6WhPcyuMh8I2vNHpF4AVH7HReUBZ8RAWNpO44ICOzl5L/NayqoZEDaRj/c9T
 dCsaxK3eqRSvFyLribE0MKn0PQfIgZyR0pG7VJKhLx4QD+xvGlC3FRVbSk/mY6Re3jtQblOlZPR
 kb/F1nym67jniRdzMLZccJamvbnslHj5HSA4mxDFNDM2ldckwDzZxOzdf2P1t7Fv4WDct8VxCHz
 vJ/Wy/0vgXfAXsK2xk+1nAJYZCmlDwywcQLgotNok0j4kYErU1v5c06dBhvDNgFg==
X-Received: by 2002:a05:6871:890:b0:448:558c:d8bf with SMTP id
 586e51a60fabf-44cea4ec473mr416039fac.17.1783010486868; 
 Thu, 02 Jul 2026 09:41:26 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 09:41:26 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:41:00 -0600
Subject: [PATCH v5 08/18] lib/parser: add match_wildcard_hyphen() for
 agnostic matching
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-8-24f22b052bf2@gmail.com>
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
 linux-modules@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=4222;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=qZKCtfeZXgr9USX3+37WWDppizwZjEcqYLWdj0ZjKXQ=;
 b=HDabVOht9/LjgxGn9EUPsGTjVLA6SABPlrw+n+vplGk0ZZsVg/BaAE17NvzN4FDBlciWIe69k
 oC0z4UynkjQDC8xxlVvCE64H0VdKQuGpVqPudup+cHHcIckvCztnQby
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

This commit introduces match_wildcard_hyphen() as a variant of the
existing match_wildcard() function. It treats hyphens and underscores
as identical characters during the matching process.

This is necessary for subsystems like dynamic_debug that need to match
module names provided by users (who often use underscores) against
names stored in the kernel (which may use hyphens, especially when
using KBUILD_MODFILE for built-ins).

To avoid code duplication, the core logic is refactored into a private
__match_wildcard() function marked as __always_inline. This allows the
compiler to generate optimized versions for both the strict and agnostic
callsites with zero runtime overhead.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v5: move ahead of array-slice patch to silence sashiko complaint about it
v4: initial version
---
 include/linux/parser.h |  1 +
 lib/parser.c           | 58 +++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/include/linux/parser.h b/include/linux/parser.h
index dd79f45a37b8..a3cc7bc5fb93 100644
--- a/include/linux/parser.h
+++ b/include/linux/parser.h
@@ -34,6 +34,7 @@ int match_u64(substring_t *, u64 *result);
 int match_octal(substring_t *, int *result);
 int match_hex(substring_t *, int *result);
 bool match_wildcard(const char *pattern, const char *str);
+bool match_wildcard_hyphen(const char *pattern, const char *str);
 size_t match_strlcpy(char *, const substring_t *, size_t);
 char *match_strdup(const substring_t *);
 
diff --git a/lib/parser.c b/lib/parser.c
index 62da0ac0d438..d5be01fa9adf 100644
--- a/lib/parser.c
+++ b/lib/parser.c
@@ -268,20 +268,13 @@ int match_hex(substring_t *s, int *result)
 }
 EXPORT_SYMBOL(match_hex);
 
-/**
- * match_wildcard - parse if a string matches given wildcard pattern
- * @pattern: wildcard pattern
- * @str: the string to be parsed
- *
- * Description: Parse the string @str to check if matches wildcard
- * pattern @pattern. The pattern may contain two types of wildcards:
- *
- * * '*' - matches zero or more characters
- * * '?' - matches one character
- *
- * Return: If the @str matches the @pattern, return true, else return false.
- */
-bool match_wildcard(const char *pattern, const char *str)
+static inline char dash2underscore(char c)
+{
+	return (c == '-') ? '_' : c;
+}
+
+static __always_inline bool __match_wildcard(const char *pattern, const char *str,
+					     bool hyphen_agnostic)
 {
 	const char *s = str;
 	const char *p = pattern;
@@ -301,7 +294,9 @@ bool match_wildcard(const char *pattern, const char *str)
 			pattern = p;
 			break;
 		default:
-			if (*s == *p) {
+			if (hyphen_agnostic ?
+			    (dash2underscore(*s) == dash2underscore(*p)) :
+			    (*s == *p)) {
 				s++;
 				p++;
 			} else {
@@ -319,8 +314,41 @@ bool match_wildcard(const char *pattern, const char *str)
 		++p;
 	return !*p;
 }
+
+/**
+ * match_wildcard - parse if a string matches given wildcard pattern
+ * @pattern: wildcard pattern
+ * @str: the string to be parsed
+ *
+ * Description: Parse the string @str to check if matches wildcard
+ * pattern @pattern. The pattern may contain two types of wildcards:
+ *
+ * * '*' - matches zero or more characters
+ * * '?' - matches one character
+ *
+ * Return: If the @str matches the @pattern, return true, else return false.
+ */
+bool match_wildcard(const char *pattern, const char *str)
+{
+	return __match_wildcard(pattern, str, false);
+}
 EXPORT_SYMBOL(match_wildcard);
 
+/**
+ * match_wildcard_hyphen - parse if a string matches given wildcard pattern
+ * @pattern: wildcard pattern
+ * @str: the string to be parsed
+ *
+ * Description: Same as match_wildcard, but treats '-' and '_' as identical.
+ *
+ * Return: If the @str matches the @pattern, return true, else return false.
+ */
+bool match_wildcard_hyphen(const char *pattern, const char *str)
+{
+	return __match_wildcard(pattern, str, true);
+}
+EXPORT_SYMBOL(match_wildcard_hyphen);
+
 /**
  * match_strlcpy - Copy the characters from a substring_t to a sized buffer
  * @dest: where to copy to

-- 
2.54.0

