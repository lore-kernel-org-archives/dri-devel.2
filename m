Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A1AC44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 02:18:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A14EC10EF90;
	Wed,  8 Jul 2026 02:18:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VlUiRuIJ";
	dkim-atps=neutral
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A403110EF91
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 02:18:49 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id
 5614622812f47-4960fb63c75so126460b6e.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 19:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783477129; x=1784081929; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l/mBb0fGCUwSIYa5j0WOJP7wxrKLNvtiy/Z40bYPFTI=;
 b=VlUiRuIJHHfrju06bzFxB+AWZSZy0CdtUF9eef10GFMFirGwYu/MaLA+YU06A6vvtF
 xZ132CfKsHXpb3AQMnM0AQlMgGaIankYwOC5pL7D92zCd5kWy3vxOAD6N683pRksVu3R
 YBCjWxaTbOiXubHrapvdN99nHRITH4PxGKYbKAX5J0fUE6FosNMi2evOPqx9+eFV+/IK
 LeN/rxKtY+CrYu4QoxfIfqQ6TICqdmWplJ9jkKQYKtS0HRo7eEHSBfBI4GIbGT5+ldi7
 8E59gJSfDWBAfV5OFhw6Gh9mvSPqZ/IJIsf59DJbNWsecP2at4aHB/pWo0TGcTMnh8Rd
 G//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783477129; x=1784081929;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l/mBb0fGCUwSIYa5j0WOJP7wxrKLNvtiy/Z40bYPFTI=;
 b=b26EWkuWLIDVrOfzE6cgMbj3W8khokNW2B/Lbk/gl0JpJwvAVwApvEaBOOH4KwTTMa
 Yf5UOQl/uDh8POjQYs3yWinATCSDHXW2kyvhH+d/ufENWonYj5uGVU3VqUeKBodZ6VeC
 6ndc4TArlSwnYoJP7FbkwPdyts+PFRR8Vi/VWAwUIUK2naIUDeys0pZP1/ZI0uOfSK67
 mCAJ3qVhgalldZASKKMmcylgQq5DRLck1qZyHVsAtVH9j2uDcCINqrXvbPVDTDyFoAcW
 hvo8nXk9Nr32zW3G4yS1ytkdJPOfLMKogeG1acXQ1/2OXEwpYFKAyJYnrH6fI5NJEpK9
 8UHg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/T4cjObh4S6gL3OLRfkU7tHNGQhzWXw0gJmiHnu/RoNyN1o8SFl5dcO643xRQaqdevGhf0QwQunyE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YylTPVPOFsrxcKRm38Ac4qOoSEHAsNZ6sb58IXBZ43L1YtKe4YE
 Q02JBX87OnyTZCFTjFq0wBJaSAMiVqXFOTjOmXlkKEEevPOp/JAqHVyD
X-Gm-Gg: AfdE7cllzfhHvOG3pbFftznz1uCoKf2iXldG6PS0Ulmjl+uIrn2qSf80XWbHQTUXi40
 ojqQTDowcT0HsFkM2nG00YsiF49sTiebvTUfyPbtZATW8vlP+HTq+OVubYj4KibXLQZuDhJeDxw
 hX6xhp9xvMfGel6FcktjghYWUFdhc7SzzTKEv7A2JYGFTozu+QVMJPBQ1Ge7m1ch73JNzT/bOTI
 upGlLD8gctBvNfrTrsM92S7bwdLiNCg+tBysrycibza5lU2p6lD7e6DyI5EKBNVgwf8eYFFRVQy
 r5TjHOzQ8ZA6t9L2sh9PjstFoWsa9H3/1kB3Ok6kdRx0Ep30FIQJZnw5JjIb4+5NQElVaFDF5ga
 gvlBGYe/ODtIcIHqY5WowfqmgTwoprXDZfwohoBCkVqwSoemYUSNfIuDeGerZh2q85laKO8PgBW
 WqfhnSLwnzsXlCzx8C827jCXQwGzBan66eN3FzYdrdZR6feuAtHxk=
X-Received: by 2002:a05:6808:690a:b0:491:3ade:8b9e with SMTP id
 5614622812f47-4a204be6dafmr307849b6e.36.1783477128889; 
 Tue, 07 Jul 2026 19:18:48 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 19:18:48 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:13 -0600
Subject: [PATCH v6 13/24] lib/parser: add match_wildcard_hyphen() for
 agnostic matching
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-13-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
In-Reply-To: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=4222;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=cOvO6sx3YqLFd3U+lr49fTx42/CUMz8iaG20o06tc/Q=;
 b=fH4cz7gW7gQleI3gjGUtJ+SY/4OyEbN39bNTdvRHLXKHHDuXqOnwRFYYoExs8ygRoRpHkgAe6
 ZV6Ju8DSs2hD4+zruFWjdvsTEtNVTmLSJGv4jSilNH7wWImQjGLOnL4
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
2.55.0

