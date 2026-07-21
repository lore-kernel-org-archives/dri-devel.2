Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22359C44537
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50E0310EB63;
	Tue, 21 Jul 2026 20:57:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MVlz2HPu";
	dkim-atps=neutral
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B94710EB56
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:57:34 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-7ea9c6ea7deso721247a34.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784667453; x=1785272253; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l/mBb0fGCUwSIYa5j0WOJP7wxrKLNvtiy/Z40bYPFTI=;
 b=MVlz2HPuvGbBRJ5pr3xtLun90tBdEREvQ9VNGfts+kILm9tkfDNmyD1VTT5z5iK4u1
 NnjZf8VzzjymwnRpiN7MZw5v6YxzFC9O55uybn430npVfF8EosB3/mk5XmXiv7lGdV7g
 VIutqq3UGO2Ee2aLWGmvV6BELlG8p8vyETjVqAA14p38oEgHHAaAYeEofw51gYTJdzCd
 eOo4c44Z36rvkCbLxHxsJEE0762sZB6hd6yrNzpnxy31/yC1pIfTGHEJSkrLNomjF0JT
 rDWFWvm3+YNdRPaCsldHJzU+lc7sa439fIlEl+eFCVV41exZi5v41czpm5FiTCeEOQKe
 O8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784667453; x=1785272253;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l/mBb0fGCUwSIYa5j0WOJP7wxrKLNvtiy/Z40bYPFTI=;
 b=XHhWk3Q4rSfgMU0m3gTN7YKcFx+rVJZ2ujG5jJqvPkUeuMvitggeEGD6jlslQzX3az
 /TwqKqQeg7ccyReorlRbo3rtDg1Te07O8xbffHmBc1JoauYsyqbb9GzWQBZqwTQo22ko
 yDtFkQI5C9waU+RMG8yYQmvsLbuFTVYmXLoXbL+USyjBjvDWXaxFDAEezAu1u1pryIL6
 ZJ9QLoppHfgOR/tQtCNo9NI2Osh7gJ4VPjGLKF8EmTx58xfFpZdfR6M8Mjfe2S3oHP3H
 cm7YrVWbaoewX5+t7Ibgwh04yCjiFqRJ7qBfiS9qlFEBNSudg6S0IRD3Yg8yvrE0Z0ZE
 E2Qg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5VsA5WpQNpwSz4Cn8ONSexZDKm94eT2nvdyMR6puotf+u/Jj2Okt+6xDLt0q3eupnhyUUfjJ7/Cw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzh9QVSIcWMV6d9LHg7OwSxCQcD53GsjySoLhUMERLMQbvh5hLG
 0q8OCXm9XLQSiMJ0fhayVSOwAdSn+WT24qWmVmVLxM0tbe6F55ep6psR
X-Gm-Gg: AfdE7clJZOlt6xCjARNHHz+gZ/OYu7utYsVqxW4uSfjztZo2ppYpgOLo4T3U4dShmrb
 yE7M5JFa6kgaebDC0d7grAhDnftjOopL+BkGRchCF9HEXHBCSYDY7P1n2mHWB6qLPCMBkwknPRC
 i9JoOEHi/w+l0VBhsGWNAEXaUojJBAeiSDY4+sO11xzh125O2gPPmxxYuX+RP3/MNvTuAXgWpRR
 j2WMO6kNUeZmDKiX8zSRaLMP+v1aWrHfJHJLvC+/P3yYo6TJ4vTajIwkQX1qYbPDRZrOKkuzR17
 S5z4yYanP46SeKLoQHCvtz6xucfPlqMF7iYAFwDnCY+4UtBh3+FS6CUlLRWCrD6XWPjSx/4AU/+
 FG36E5xREyNabBlRrC4YRs4eQoDiImuAMXAulNHT+VFZM+2P3gb6Ap0N3pDEDhDjiOhN2x8k595
 pCHPTSzIEK0l3BLbWZQNKRU+rBQosIEDBAzo+8ah5MsJEHimPzHeSanqUaxG2+BfqSer76tpZQy
 HZS3QYH0AlP7CPMjIsJ3YGIzA==
X-Received: by 2002:a05:6830:7002:b0:7e9:e82e:e683 with SMTP id
 46e09a7af769-7eda08ab141mr11477690a34.7.1784667453210; 
 Tue, 21 Jul 2026 13:57:33 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 13:57:32 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:57:07 -0600
Subject: [PATCH v7 18/29] lib/parser: add match_wildcard_hyphen() for
 agnostic matching
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-18-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=4222;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=cOvO6sx3YqLFd3U+lr49fTx42/CUMz8iaG20o06tc/Q=;
 b=omQ27F1Lj0I+8IXmB8JTu88Ef5LiDN+J0UVCbq+/MPKcMkHoSyEhHezbJpnSU+hYg3ip/fEgR
 mO3/oDXWNBOCjLYtJlHFX2MGwd1O38pZNZduH0FaAyqjqod07vIJjkT
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

