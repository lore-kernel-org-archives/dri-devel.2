Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677F9CD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CED5210F663;
	Tue,  2 Jun 2026 22:49:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZKk4BOgb";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6331910F661
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 22:49:17 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-45eecb8bf67so4336051f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 15:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780440556; x=1781045356; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yYycUh0v045JLMzHv+cDjWaRSMlpTVGG8/fmLB5h0j8=;
 b=ZKk4BOgbLUesaXpWt79iLbZsWMq6bhbHNnjOWmi7BiAPTDacfUiOg1cwRV+gupS++A
 GsPSLQUFNAzs2Oq1iVhrjIZbozAd07+yOgaINjIgphekLtDKUJx+x6zmS/w0uIT3VJKw
 6jhpZ5SBAoG5/TaFGt/TbUmUgz78TQ3zJKyDjsggFgK/xqF91Md7EwW0es3rMARlmwy3
 PYEMG2Gzr3awMsRxQgfgD2BUQjzmbGUEXbEKHivI6BcP2QD2m0mp+tBqcKHTn2b+kbXy
 ZdBebGN/t0kR4t+atRe5I12Eix3m31taETI5j18GFFZeciWqceeRzhohdsW1fwg1BWNk
 hOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780440556; x=1781045356;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yYycUh0v045JLMzHv+cDjWaRSMlpTVGG8/fmLB5h0j8=;
 b=OHqFbl+YJXZw9FNCF2uj3mMvmz8lFwVR7YVDG+la5iki3PsjU2lcPSeHyt2qO6osTw
 12L+usOL14bEPBBlD6CdVOA31NWi+/tpsrjfBH5I7pL+imfSnDg3FsZRtgVfUvWNBc5Z
 xcBPu1teYoVwDfc/S0YM0d5XCgRldtrD7jE40YjQHpMrQTLjrkgSC1p/2BHosFM1IBbr
 aGA+qIiliYBeVcoXvfQyAPt7er+2yUT2bnSOi6pV8pJaUqDn/9lyt8wGnDAWiZk9DEzx
 cLVHk/GJG4jFGyApnigMP2SPBnA4xB59QTFaVmJY8WGsNhkDo8XSbgVBRruy43LKZl/K
 e9wg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9I4gOtb2UzpWHgBCWGRJTB7S8OKSoZkOCLiACb/g2YxPMuIjlQW6/HvcewoNoCHhJD3U1EWdrYhvc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzEuu5UtTvO8rxL49UBis9N+PxkrcjWS+A2RvZZ5lfblua8Rq/W
 Hi85hPigTOppT0IImPSDG5slCc6ga9w7HVXDij2ZhkDlbWvqrOdUZR6l
X-Gm-Gg: Acq92OH8DMNncsLIrvwziM5fC2DEXi0k1KB+NFOd6vZTaSMtXEF/TbMYXqOQl3r/1Yi
 EoEApzyweqgH7V78HwMbX74oLwgi/Un3GgPQrGMjummjrWWIpL0w9kAHT1hoPU13ZApsw3gBx6z
 glNBwOVXVJaf4ugyYTQhPsW0olkcI0fTXojGIUFn9n9wKLY3VVXiWxbUhfhHfswiM7+JlfRN7XK
 8PyoI7ZvrK0gCnllfRQCmEWw+CpCooLaKCjo4/OgisEwf7Dv84MLK7mZhzKZ4wfgn7xJq7OcCh1
 QHe4CxYfOmoYo2ct/+AXeDwJUOtXyB42r095QM9e2IpTQoMZ+3hCDcknXDfU7fIisXdC5puaTvn
 yJsWmB1FD6aHsXaaxC8okuNZ/xeiHlCNjP5gYJy9sRGQNBa0rZzx9jWesEDGQSNawFaq5nzJlGs
 gz0LJjI2UqflCNaMXnJtq/n26kHwI92+XwOOjQZGb4oA==
X-Received: by 2002:a05:6000:186:b0:45e:ce49:43d8 with SMTP id
 ffacd0b85a97d-460217815a2mr476777f8f.4.1780440555875; 
 Tue, 02 Jun 2026 15:49:15 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 15:49:15 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:20 +0000
Subject: [PATCH v4 23/25] dyndbg: change __dynamic_func_call_cls* macros
 into expressions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-23-19a1445585a8@gmail.com>
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
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=3131;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=h10PnN9dZij/9KIShcmtDym4aMWTMKg/65aOZIHej50=;
 b=nNRaRJnI6DmZfuQY2gv8wXs0tGfSMAFNC8nitrIbwD9TVpVCkTFOsGImAavGQUVyhdgdI2ALY
 opxK2UqBAt6C3hL60gGtbqcEnPcfAnMLTunbF8bSh/6ISOWnc9ixKTB
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

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
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
index e4a62cb73267..2d6983186f37 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -224,24 +224,26 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
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
@@ -321,10 +323,12 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
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
2.54.0

