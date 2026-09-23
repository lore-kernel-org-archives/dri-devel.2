Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7FBC98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E99A10E196;
	Wed, 23 Sep 2026 22:34:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bIA6mi9E";
	dkim-atps=neutral
Received: from mail-oa2-f13.google.com (mail-oa2-f13.google.com
 [74.125.231.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8DB010E402
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:34:44 +0000 (UTC)
Received: by mail-oa2-f13.google.com with SMTP id
 586e51a60fabf-466ccdd7695so552609fac.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790202884; x=1790807684; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PGwW+xKeGyj9qdYgvsjMj0TNagE0SwrpwzZecGCbsEo=;
 b=bIA6mi9ELcUsDNW/Hwkm5aeZrc/v3xGg3yToZ93+Aod53Se3u6SlmfTSSQOsujvBFs
 rHc6CSMT6ucuC/yIO6bZuChwmR7TUNLwDiQi6qMWELaRRzF3JDkGTI6LeluKAsBEcWS4
 XSwnYN08Ro3DHK7HTru6rbCHO+yYarnuzQuvdB+d+QLbTmUiflBXCIEtmAVdJfuv4PlD
 w8Ipkx63GLuBaw5CUpFxyeiOJlAyrkGWYVVxgJvf3+KPqQ6pRnlKA67wsJSJEQ9OUsth
 b54yGskaUdDSmUecKh6ysRLBy9FCY562oFmxnVhgeKnJ6gFPh7Xie/8f46cgKaLQ4hsz
 h7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790202884; x=1790807684;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PGwW+xKeGyj9qdYgvsjMj0TNagE0SwrpwzZecGCbsEo=;
 b=n722/PyNKuPAYJBTHYKRIQzsoDrFQHUOD729tlwYoW98g0DwYLvOfB0q6B+swawwq5
 CyQDMg5/Zd1qJ5TU6bbeGtSHURgUDmVqhzU+ItpvkuQDkA0NKkGoKaSGyDPkocJRfgLN
 cUMPe7SK1R1Tb4RZOZWMuXZEPrjaue8fPdj+Gf5CgIOnuUcPxcCZusO8UGnJVNwFbrlD
 /KORNMP4v84KXfsjSbzBf3RdmN5AoxPBUuMg/20qKkd3ZNlrX2Jf5Zru+6T8cIiSMuzr
 lgRUrkylgoWhkop3+bPPYc2NT4y8Zgj6o1sJQjeaUUjnw3vf7qwV9GlByYO/RpWvKUpS
 F/AA==
X-Forwarded-Encrypted: i=1;
 AKwUvByNObc1EWEBoxaeeb5Pxg2423s4QlrxzV8BY0yxg8uEOduHuMJ8ZDo8Yaf9KljpztOCdO+kC7hjmmU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nQK/24l8okb/2st+47O0gmvhQxDE7OwgntvBYT2Tiie2FZXbuX
 w30B4IWxWhQegHOo1Q9gtP9CP21BXSVIB1Mp7xHXZeaC2wnh6ZxRtYvU
X-Gm-Gg: AYBFou0aeGpeWhu2kfyEkFlk+qJnDymOp9xSnHvMGHc2MkLAh0VT8+/7rEbEQgY8tdJ
 i1/Rnz/tdb6s+JQx2EyhIXIL1fZw3mLra/53TOna9REj808ltxvbwBtvdjYZkcuSnwp9fkNPwuG
 hddD73kjXcyPBhjd6cWB8kr9Mdtju1Q4mlpPiFESEWjgnec+GRR01rmwIoNeRXowzL/t1WBh5mt
 cDeV5fCfaiGpz4oNHuBtBtPSeh2TwU6xo+KVl/ChzBAYuPo2fD+B8Bov91GE0D3pdnFQjP62uH/
 w7wIr725TKSuYW6aNT9AdsshJLfeFO8MhXdWeqQ2k7g8Dnr9tG3U/wuaM9VaI2CsNfs1rHnobdE
 gmno3gRoMaaYQ2PcYgRgu9Oa5W9hSLdZz0/BKDk76d9uMnHQxwKxV65t+T3eMi5tjFh0vjjymXy
 APE6U1eWAuoY2bFNUD7P48zZ+Rf1yVkj6qjmCIjZT3AB4GzwlOmn1beAK9nXgyiSnJJDOEWtJL8
 mcwJgfbZqmV8JqzAJq013bNcgrOazdJByJOjSecgzep2tuSKejbdDct/4XhV85EbZHfjFI8wy0S
 IIpl79Of5lRGGURLEEo=
X-Received: by 2002:a05:6870:6107:b0:48f:e0e5:a1d8 with SMTP id
 586e51a60fabf-491e7549be1mr695793fac.45.1790202883955; 
 Wed, 23 Sep 2026 15:34:43 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:34:43 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:27 -0600
Subject: [PATCH v11 03/38] vmlinux.lds.h: drop unused HEADERED_SECTION* macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-3-9b6c217fdf2f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=1428;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=R+ywodY9/HEwLU1o/08HL92DtAFTrUi2XM/5yuI7Itk=;
 b=bxDPb/z9jo7UuiYZseWaAwvUnLu7CVJN5jFaB5CAxvuhf0/HXxBBnanpsfVCx/MEPxG7FcGfB
 T0f9fVvRuRvBztk1ewVDGy9dmRJ/jHW/tyMzmWs2igmZUy5YtAh60po
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
2.55.0

