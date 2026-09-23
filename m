Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C239EC9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D91E110F0D3;
	Wed, 23 Sep 2026 14:56:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g4fZODT6";
	dkim-atps=neutral
Received: from mail-lr2-f10.google.com (mail-lr2-f10.google.com
 [74.125.230.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BECBB10F0D3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 14:56:29 +0000 (UTC)
Received: by mail-lr2-f10.google.com with SMTP id
 38308e7fff4ca-3a3552563d7so6219151fa.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 07:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790175388; x=1790780188; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EQsvAgfzLtsJnXkdBUm8r2goP4FuulbfN7zU4oyNzHQ=;
 b=g4fZODT6JGR+8ix4dPkJl0IsVRkZqYj+S92LiN27gjLAznrKsDOWAftLrKeFUDQYae
 7Jaohhba+Qv8GrYWrm8Kfee8mbK/be6HWixCCiDf4/a2CuSfIpNFc6KBjCRsekzRKiFt
 /IZBPO+jw9I4NSxHUMduBg+pKf2bsrFOnpOgL4VirXw2KJP4DTRlxBHp/0v5NL0yyF9C
 oBRSZ9ULz5+POKJYAcxzL7feZOGl/p+E3vGgwMN5O0UKKouAndpcRG0A51vSTOkmz6A1
 5pFHsGFRMKAMv1RC1qnZab8jFtTwMg+WviG7psXMVvciCRpxjU4ujKCXUr5JJ9UioAnL
 fz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790175388; x=1790780188;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EQsvAgfzLtsJnXkdBUm8r2goP4FuulbfN7zU4oyNzHQ=;
 b=NNJ43NHLersVvcyT3gvePX09OoUkBgReE7rG/tosNrSBr/C3yDP+Ljawt16bOICfDe
 0UEw3JWp3Y6NmzA56nRqUqmTScI+gmTqJQR1W1FhOqpxsC4/M53rFufMm8PA+NEUkSIt
 BgbSaLrTnKX3KQ6dt+veB+lpJEdtpkaXeHx3r8kWVCLjedEka3tNJreDey+2r6fiXuMK
 xR+2tJSpb3vSTZI8uN0OORP+oLlPLn6l7SN58GU/wTVfolCdu1H+mk2CLO8nv+YMdj+Q
 9Vq+OVEWMimFC2/1gL2LKNTLBswGFkzimMGqb35ezXlor4wggfMvzU/8u183gCeQmxni
 7vJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPGFfu0EJGzKitVTMBHG2/rNKGXm81vrm0mtpeGu5JRIFCAg52LLtbzXhASS6CvRuNVALpq++wiFM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lFwf2/EaJYHLQVfzC61tO0wLjFUebpZQLNA45nJh0ldBskVpJz
 EnAKqpAaKY528/oK7VbbaCmCrT5IDwZs7INkrGHpF9xv2+Om03Sq90Up
X-Gm-Gg: AYBFou2pFMdzHM1WVBEu8wv1S1ftdp1Q26oGE69zVe5JxSQYwctfK+4J/LfUe99IjfC
 14aYjl5/srpFV8+ooQ2RuX+bE21tgUBHfzik3AjYi0yaxJPlEds10zD5SdOAHoOgyxYg4T/2pNg
 PhThQSCUfxgiDLqAy3+IOoGKXRJV9/A5nf7y8Ag1t/sBClSGJZaH8d7XKxE7M9+7+blFB/Qtj3J
 ZWur37MQ11/LT9D/VGnur+ZFNN6L3IiULr8PuDVpPQVDBa0uCrj2su7sVNidmpTiemxY83To0+g
 X+Xv9b1cZXKK0BKuuvM49JYVb2yZwrTamRYbjxtzrXoMnTPnf/jKFGxTAcTHVeElQIbNfDIB+HQ
 QpKcwrG0TwCS8DNaxakO0m10SR8Fn2kqtMJDharKaQzKG8qLYdEWp+43vPtdZa3CZHqTU7KnVm9
 4C/p3+oMuidt8iaVk9nt9pzYny9glwwFONuv+/NrtMUY96yOVX1cWcEj3cvYmTpvaWTq81csDUE
 DipJT1gk4y9Jmn2
X-Received: by 2002:a05:651c:a205:20b0:3a2:72c:cde9 with SMTP id
 38308e7fff4ca-3a6305ca196mr5197841fa.4.1790175387706; 
 Wed, 23 Sep 2026 07:56:27 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a62f53b4efsm7512171fa.39.2026.09.23.07.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 07:56:27 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Sasha Levin <sashal@kernel.org>, Jani Nikula <jani.nikula@intel.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 David Airlie <airlied@redhat.com>, Philipp Stanner <pstanner@redhat.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Kees Cook <keescook@chromium.org>, Zack Rusin <zackr@vmware.com>
Subject: [PATCH 5.10 1/3] string.h: add array-wrappers for (v)memdup_user()
Date: Wed, 23 Sep 2026 17:56:18 +0300
Message-ID: <20260923145622.76242-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: Philipp Stanner <pstanner@redhat.com>

commit 313ebe47d75558511aa1237b6e35c663b5c0ec6f upstream.

Currently, user array duplications are sometimes done without an
overflow check. Sometimes the checks are done manually; sometimes the
array size is calculated with array_size() and sometimes by calculating
n * size directly in code.

Introduce wrappers for arrays for memdup_user() and vmemdup_user() to
provide a standardized and safe way for duplicating user arrays.

This is both for new code as well as replacing usage of (v)memdup_user()
in existing code that uses, e.g., n * size to calculate array sizes.

Suggested-by: David Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Zack Rusin <zackr@vmware.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230920123612.16914-3-pstanner@redhat.com
Stable-dep-of: c833d6c7199c ("drm/amdgpu: Limit BO list entry count to prevent resource exhaustion")
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-23468

 include/linux/string.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 98b053d9c700..85efd2b738ea 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -5,6 +5,8 @@
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
+#include <linux/err.h>		/* for ERR_PTR() */
+#include <linux/overflow.h>	/* for check_mul_overflow() */
 #include <stdarg.h>
 #include <uapi/linux/string.h>
 
@@ -13,6 +15,44 @@ extern void *memdup_user(const void __user *, size_t);
 extern void *vmemdup_user(const void __user *, size_t);
 extern void *memdup_user_nul(const void __user *, size_t);
 
+/**
+ * memdup_array_user - duplicate array from user space
+ * @src: source address in user space
+ * @n: number of array members to copy
+ * @size: size of one array member
+ *
+ * Return: an ERR_PTR() on failure. Result is physically
+ * contiguous, to be freed by kfree().
+ */
+static inline void *memdup_array_user(const void __user *src, size_t n, size_t size)
+{
+	size_t nbytes;
+
+	if (check_mul_overflow(n, size, &nbytes))
+		return ERR_PTR(-EOVERFLOW);
+
+	return memdup_user(src, nbytes);
+}
+
+/**
+ * vmemdup_array_user - duplicate array from user space
+ * @src: source address in user space
+ * @n: number of array members to copy
+ * @size: size of one array member
+ *
+ * Return: an ERR_PTR() on failure. Result may be not
+ * physically contiguous. Use kvfree() to free.
+ */
+static inline void *vmemdup_array_user(const void __user *src, size_t n, size_t size)
+{
+	size_t nbytes;
+
+	if (check_mul_overflow(n, size, &nbytes))
+		return ERR_PTR(-EOVERFLOW);
+
+	return vmemdup_user(src, nbytes);
+}
+
 /*
  * Include machine specific inline routines
  */
-- 
2.53.0

