Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F7310AB802
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:54:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 197DE10EB44;
	Thu, 26 Mar 2026 18:54:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h/P2q9m6";
	dkim-atps=neutral
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1F1710EB44
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:54:37 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id
 5614622812f47-467161c4a1cso448570b6e.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551275; x=1775156075; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TvJTZGwFnKZj+neDJ4vh0DEg0/Ks/7VePFt3kMjVxDw=;
 b=h/P2q9m6kJtcjtecYpgpCnsfk7xikoTpYFXM8ndLg0o+ydGel2F3uZL+DOD/V5RHar
 wWwwH2UtOcVkxaxE7VVsusvZ0JHcinKk5AFLWdHQWjHVBAkaXVuk4NTvQc5cyA9jP/Lt
 FQKAYQlHCVxm+eKaQubjiGspNB/6VDvBGnHzLFFdOTgehmWJUiXPufZY6k6w5/g5q0kq
 MTQC3PYDzu0H9MonxDOgMUpsplnT2SqH7ykjdOhEGrtvm9O4Io6iXAzFG63tMnMXRgJn
 Lp3Jz/KNfd90pKwp8xyysHUHdK3XKlCf4IgaYJzMokPRefJoc+yPFaE3FDcjp0qqrQWp
 xuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551275; x=1775156075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TvJTZGwFnKZj+neDJ4vh0DEg0/Ks/7VePFt3kMjVxDw=;
 b=gjdpnxyKKL8NJ49Ew8Ld+j5I+PHrck3wsQllQJPIhxG1GWAoRg71wmobETuonng9pX
 ELIz07YLPwDFzd6KDqHb+S2CNgQqdOm3el7uPsIQqkaSz9LV0HJhOImmvsV7pteesqpZ
 ukBI+mt4Om1g8z8suEZ6mX7GSkDfvp0vU3t45LZ7mkbvk07bl2Vl/U/9RE3ZgF378fmw
 A/AO0ezjEUbMe/teKpPsqp+CeaLksbzJ6yRv7OzAbb6WnB34gvBI5uuJi9YuYe2Mcxhe
 I96qe8P9qthZFrNBn4Zb6Vou9KI6+Ib8nypMjW/V1sfiLTrZlYd+MCOAqsTGUls5JUod
 jh7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVveittEqFuElk3QK1lMrclxe8CJM03YuRfDfh3JZYudhBkvHCNP985JAB0LruWiOKTMArDzI09Zso=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyyq2Di4qYvkTh0sdIjBvdXExmZmz/sZyS7j6CITu00SpB75ZBI
 MNbRghlnshs7WuaE4MulVBiTmD3K6EJqooReiUm2KYeGQuRJGzLpXwYg
X-Gm-Gg: ATEYQzyNVNiAJQGpGFtnkGd3tWcZUgnEPFaCHSFJ6VTJAQgSUnj/6vzmEga1LB1t9Ji
 1DzQwABLhIn2llhVBmndYYjWvzDRXsRcu8iSGAbBdaKUcOHdow6aA74ZRGLzcFoq4k/dsOPDwSc
 OoKwuSg7HBwNUgpsxC2meHQ/ycouptIBRLgwMslHw8o+zCP3aNOQaQRSgcePQ6dC9FhqsjsTrvD
 0VYR0PxXYoxwY8FzCDF1Lyr1JZmjDeMWC5PsSwqeto2vFwaLeCztOLHPJOhh9sR7nXJtt6JGsh5
 qO/3IHSTu7hmaOj2zYtyyWbPR+r2ps2oSiIHrWDgiGkV/W9bHjSmVN+JR0vexgSv3Wi1/COl/Uy
 RrmF1FyDwvzx68/KCRM0ymEQMst+3zqtuf10vnPOOeGd5Eu3UIbti833h7T7fUteBu328mFKCi7
 QUZusJu96EgVdqyVtA8ZxNuEcZEC0rYq2L5P8Zli6cPXHn2rlB
X-Received: by 2002:a05:6808:1995:b0:467:1c6b:ee14 with SMTP id
 5614622812f47-46a5c708135mr3630668b6e.33.1774551275278; 
 Thu, 26 Mar 2026 11:54:35 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:54:34 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 jbaron@akamai.com, gregkh@linuxfoundation.org
Cc: jim.cromie@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v12 04/69] vmlinux.lds.h: drop unused HEADERED_SECTION* macros
Date: Thu, 26 Mar 2026 12:53:08 -0600
Message-ID: <20260326185413.1205870-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326185413.1205870-1-jim.cromie@gmail.com>
References: <20260326185413.1205870-1-jim.cromie@gmail.com>
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

These macros are unused, no point in carrying them any more.

NB: these macros were just moved to bounded_sections.lds.h, from
vmlinux.lds.h, which is the known entity, and therefore more
meaningful in the 1-line summary, so thats what I used as the topic.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/bounded_sections.lds.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/include/asm-generic/bounded_sections.lds.h b/include/asm-generic/bounded_sections.lds.h
index 280a893bbe29..416b2e6f6788 100644
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
2.53.0

