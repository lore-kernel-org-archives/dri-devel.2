Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80AEC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 02:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0493F10EF9A;
	Wed,  8 Jul 2026 02:19:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qkH6LLil";
	dkim-atps=neutral
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
 [209.85.167.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49BEE10EF95
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 02:19:12 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id
 5614622812f47-49ff971e903so793151b6e.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 19:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783477148; x=1784081948; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QEjbqhV2gwoIMldtbZBgfn/e8I1IhfNrhj/88jNL8xA=;
 b=qkH6LLilIlcQOF6jaSZTZHSRfK3UJiS+T4jfZl9V1baMqEpbGd/t3rNwKEckisdGGQ
 VMZ43R+6P8rtFGqVZ+CJWnbZ8GJmnB09edBGjss1YGp24Xofs8rdDVY37Ivfm9hLlvx9
 DUI6RHYL5g7EuCP4gC5JY3Z0cakm9Gggzs0iBWlgdC7/hqjDNNZI5K0mMIx/0ARUjw6K
 z21xpJscAF7l7HNDqxF0H8goeimzaAa8ySfHmHHZ6ogl8NS/hBsEGbKlU4j+xg8Sfd8u
 2l/X9kniGO7PTLf9WCosCq3oxzsEbuz6eyEB7wEJm0L/AKHINHyJiwR/sdyMJ934vBxo
 SolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783477148; x=1784081948;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QEjbqhV2gwoIMldtbZBgfn/e8I1IhfNrhj/88jNL8xA=;
 b=Nkfe4Zu+6aO0D3xvs6ykIoeFc9QyguSJupoUYpqxkMqFbqdZ/Me7Ri3AdDSPpwU8H5
 1L3JzMTjMcGUOih1P6Irfcb3UFtv3T7XYac4SLEF5mmbpAFZvCHNIRuFR8Z0a4GZuQtf
 IQ0k4pVhs8XC3qLJ1xbyBX0oSMGE6jjhOBfwErWqmNmWg/p8Hijk3xINb57LAlnX90Mt
 /6PoJ4FXoGx5E6994eU5p+boSuEWfVZ/IHui2yz1ifV3is33tmz6f6bZRYLndJKkz/LC
 EJd1hOV8HnrjBY6f+hCHZuVe5bDMboHAjVM/Zc8al2Nm3EGwXJ4r3E0VaXc2/tvv8V22
 rqQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8OaWrc42cucxYRrnGuGwConaEM0x1/fqxt5I44UEtH2T7d/Jso6PsDTQZFAUbsiy3eicRK/2cAVcI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyBKb4IstHzzA0PwLRuqzc1QAFH5LgAa4BpKT5SdGy70I20KcfV
 GOOdyEdjWRCWwtQMFwdsGNhNCJhrkApdObADxOnXb8H6TZqxz7ENikMk
X-Gm-Gg: AfdE7ckIKI6BrcVhNwRpu9bWyYtAMNcD5pIRz1KWzVkHaAF8keiNUZBcGOcRZVqy2TR
 VY2QN8oGl2Sc9LPpvCZv0wpR+g9aFomV1PCzDoUoCJ/yghZj2/7IpeDUhLQkKaMOiWTDpu8NOBU
 Sn8Em90eOwnYfXJtqri2Dt3YeoU6O8/Y3DmymNt8lgu2IGYTYb0mLwKCBRDGNKeGkmhPrZ+Twmv
 IX/cVFb9kLKlnEhjnowxO3qadvKhu41Pt8OQA4qHDWt/ysVU0NGTF4K7cX7qeuIu0gC0dNFH3Gw
 JyNgi2KJSbGe/6I8DeDqesZcGRgiPnGGpJSmES36lDhlwnmdVtrljxEtyfBobylDpOneQocQbbL
 qQrIKjLITtDNuP6Q5zlFE4dYzLgDPjqMoN+8tKRbtjp6xqoBNGAhiDKFlNY+g1aGvjIqIbSFYnN
 Oln27c//cDRG4h7Bpp6IUOxDs1Gb2OAjBZrD7CW2J2V6pbhi1XBQBvvp5+pR9MOg==
X-Received: by 2002:a05:6808:3502:b0:4a1:8ace:b41f with SMTP id
 5614622812f47-4a1f090567cmr454807b6e.10.1783477148516; 
 Tue, 07 Jul 2026 19:19:08 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 19:19:07 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:23 -0600
Subject: [PATCH v6 23/24] dyndbg: change __dynamic_func_call_cls* macros
 into expressions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-23-381f3edb0045@gmail.com>
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
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=3522;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=x7Lmuj8LN3O7Zdv08MDGavB+OL7HP+Z+IL4O8u3sLcQ=;
 b=auMc58zWcPnKYuLlJzABwZIDMclW0m/WEujPrsC0hQmmgedi7cqvgzrPVVb/aJbMKrOobeRnz
 DBkn9Zgm7FKBGU/A4pvfN0yNcOY+GUSa1HBOOL551M4YWstK6tjcURa
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

The Xe driver's XE_IOCTL_DBG macro calls drm_dbg() from inside an if
(expression).  This breaks when CONFIG_DRM_USE_DYNAMIC_DEBUG=y because
the invoked macro has a do-while-0 wrapper, and is not an expression.

   if (cond && (drm_dbg("expr-form"),1)) {
      ... do some more stuff
   }

Fix for this usage by changing __dynamic_func_call_cls{,_no_desc}
macros into expressions, by replacing the do-while-0s with a ({ })
wrapper.  In the common usage, the trailing ';' converts the
expression into a statement.

   drm_dbg("statement form");

Additionally, change the dynamic_hex_dump() fallback macro (used when
CONFIG_DYNAMIC_DEBUG is disabled) from a do-while-0 statement into a
statement expression returning 0.  This ensures that the fallback form
of dynamic_hex_dump() behaves consistently with its enabled form, and
makes it safe for use in conditional expression contexts.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---

v5: also convert dynamic_hex_dump() stub

v2:

fix statement-expressions to return 0 (not void) like their respective fallbacks

   1. Add 0; to __dynamic_func_call_cls
   2. Add 0; to __dynamic_func_call_cls_no_desc
   3. Convert the disabled fallback of dynamic_hex_dump from do { ... } while(0) to ({ ... 0; })

move RvB after SoB
---
 include/linux/dynamic_debug.h | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 355f2cb11733..8822f9a3605f 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -238,24 +238,26 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
  * (|_cls):	adds in _DPRINT_CLASS_DFLT as needed
  * (|_no_desc):	former gets callsite descriptor as 1st arg (for prdbgs)
  */
-#define __dynamic_func_call_cls(id, cls, fmt, func, ...) do {	\
+#define __dynamic_func_call_cls(id, cls, fmt, func, ...) ({	\
 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);	\
 	if (DYNAMIC_DEBUG_BRANCH(id)) {				\
 		func(&id, ##__VA_ARGS__);			\
 		__dynamic_dump_stack(id);			\
 	}							\
-} while (0)
+	0; /* match no_printk return value */			\
+})
 #define __dynamic_func_call(id, fmt, func, ...)				\
 	__dynamic_func_call_cls(id, _DPRINTK_CLASS_DFLT, fmt,		\
 				func, ##__VA_ARGS__)
 
-#define __dynamic_func_call_cls_no_desc(id, cls, fmt, func, ...) do {	\
+#define __dynamic_func_call_cls_no_desc(id, cls, fmt, func, ...) ({	\
 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);		\
 	if (DYNAMIC_DEBUG_BRANCH(id)) {					\
 		func(__VA_ARGS__);					\
 		__dynamic_dump_stack(id);				\
 	}								\
-} while (0)
+	0; /* match no_printk return value */				\
+})
 #define __dynamic_func_call_no_desc(id, fmt, func, ...)			\
 	__dynamic_func_call_cls_no_desc(id, _DPRINTK_CLASS_DFLT,	\
 					fmt, func, ##__VA_ARGS__)
@@ -335,10 +337,12 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 	dev_no_printk(KERN_DEBUG, dev, fmt, ##__VA_ARGS__)
 #define dynamic_hex_dump(prefix_str, prefix_type, rowsize,		\
 			 groupsize, buf, len, ascii)			\
-	do { if (0)							\
+({									\
+	if (0)								\
 		print_hex_dump(KERN_DEBUG, prefix_str, prefix_type,	\
-				rowsize, groupsize, buf, len, ascii);	\
-	} while (0)
+			       rowsize, groupsize, buf, len, ascii);	\
+	0;								\
+})
 
 #endif /* CONFIG_DYNAMIC_DEBUG || (CONFIG_DYNAMIC_DEBUG_CORE && DYNAMIC_DEBUG_MODULE) */
 

-- 
2.55.0

