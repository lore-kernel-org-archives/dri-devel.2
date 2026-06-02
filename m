Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BADACD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD2C410F664;
	Tue,  2 Jun 2026 22:49:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qud5iYXK";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0DE510F661
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 22:49:19 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-45eecb8bf67so4336079f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 15:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780440558; x=1781045358; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FNu2VyRhrQI8zsAEpIkLCzKPvvxJoe9LgPS0NWOwvYU=;
 b=qud5iYXKpW6h5mOF8YOLrkWAwLRaLYmBEDTbjtsrKQO0Lg2k3+3gU+/GVY7jjXxnL2
 FnKVR1ndo+9PIs+6sBb7kG4TT+BqXU1+IygunkpPaAEADhEMZCnBidLYqywKdlP7XgN3
 4hzuetjUbi89mApm7XcQlyCH6yBwxI/QKS3XUbViAZzDCN7M1Y1PmMDzO8VHRKgVpnAg
 FW3trJO1vLRiNRgXKYo0inahpjp3n43dKUfo50NROEj3cNTqzptaOynd0FkEND4YEE84
 F43IfzVx9KYrpYt6w7y5WSTZMxClWiuYlnY3ewKF0YYlu3R5OFD04vfNP8e9QXQi6SEv
 Eqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780440558; x=1781045358;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FNu2VyRhrQI8zsAEpIkLCzKPvvxJoe9LgPS0NWOwvYU=;
 b=i0C9R146yc6MTFmaWRGim/3v/NsXBVfOVIiavfzFVayGiQlW7Da0kzQ2rCRlqbFyhy
 /no2chmvHx0rv0octQvN/1VF+vU3J7ZucMKK0lfrPPZqF8i9Q4IH1Akrl5qA07yOim1Z
 RrcuziPbkQceCzt0skfrcPvfydqmOjQ3cNhTRAjGVCZs3+29IEO2iS8E3DjeroOpgQOt
 xG4eiH1a4/Qnqi1LsQI8mqgyMJuIKL449mG57+FWUIYm4JlPM5pxHWbSyrfmvqYaygJE
 aqBp3jHpZPXfJbeXmfBuvZyPyNuN60GSFe35g/58SDgq0kwMBa9VH7GcmIXZCRamf+Hr
 AIOQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ANQhbn2TgNmHJvRA9nnCOgltQIlm0Q0NYxkGRxtGYQuGe6B4hNXI5rjAQyC+oBGic3mk240Tb4nQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5h30JBjHnbGQBoY4RWyWM9dAV2D/4AoQQ4mYD+I13NvAdlTW5
 g5XeiTnfeFmBiB5KVjh86o/bMiLGx3avt27gBh5v6vPS5IIi1qBT5llp
X-Gm-Gg: Acq92OGuQEsJxfKc5YMg7v5tzAoxcWsKSkJmf0L5IdeppcyKrdutJVqmHXcjS+B7nM0
 7a0h3HKTE3YaVRTPaFV1P6W4z5mHzmOT11x0beSL2VgDffOAGnBlr0krEHH5CKOE11C3FAzKy//
 qe+D4gJWLPB65VaDfWNyOGFuKhbgHtrnBlw4PLsQYsQ+AQ6Uy9bJaiKhs4xs14JGBNdE7DxXQKb
 aAYcNACx46Dm1VXroodsZtQGsKRAk5/MsR1eW5MJQvEpXCcgennDzCxNYVyHZ8vew+pK4FKGTiJ
 a5JPTYnsAK9EKJFwbwRAAP1eoG0KJo9AIjoiKZfZ4CcV8SX1/9UKGQnOYZ727S2AO7udEEv7qyk
 BtTzSpitn4sxxUIRh3m30rVDIAuRvY9ZzjeTKwyzs5E6/A4eIb220LUZkmWEUOFXYvEXk5MLa0K
 R0DmQfNd/lq/IGM29Eztea/qdIFOH1dOPECUJSlU59Ng==
X-Received: by 2002:a5d:44d2:0:b0:45e:651c:47bb with SMTP id
 ffacd0b85a97d-460218513b2mr497138f8f.28.1780440558379; 
 Tue, 02 Jun 2026 15:49:18 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 15:49:17 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:21 +0000
Subject: [PATCH v4 24/25] lib/parser: add match_wildcard_hyphen() for
 agnostic matching
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-24-19a1445585a8@gmail.com>
References: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
In-Reply-To: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=4121;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=mS8zYCuPveoKc7T4Im/jzVvP1HCLKypYVHp0g2j6Skw=;
 b=VXb9s6BILwbRYg9yQV7eipRGBEsG95GCuf6QT72hEVacy+qZBYi7X8O5FuSb5Iz5M4W1FDq67
 p9yjueJ/OsVCVSt5ROCmYhB9K2zwhc/6uV7MVoRWpT2QeQ8U6P+qRVG
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

