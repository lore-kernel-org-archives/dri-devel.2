Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CABCD6E5D
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:06:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 465ED113283;
	Mon,  1 Jun 2026 12:06:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BhQkJIWn";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C81CB113282
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 12:05:59 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49041fb8c23so76556875e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 05:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780315558; x=1780920358; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yYycUh0v045JLMzHv+cDjWaRSMlpTVGG8/fmLB5h0j8=;
 b=BhQkJIWnl5vdCnnNBrttwD95TcMLpayfea2l9Z4jcpd3nuXBt5u5xx4NLPrNzqzu5O
 cjTSVpA9mrwW71eZBmxTzGXNTzNRF1ECbW6nyAxv1n8COwMGSJBJmpzboneF0/9B2+Oe
 xrA4TXsAGef6IS28PIlx6kf1KwXWbVBpPIkY6jdJ8uGKF3Qqis7Z1FC5+cQUIrffJHkK
 MQkrvsLcxTLK8EEWzgSkFL2NuS8xaGkjQ9uLeyBb+Gnq0TTGzCITHIFpjkMxyutRII5d
 Xv4ucsQUnp6BzONL1k4Nj/zgmbJSiofNJ+CFmLoKQx/KXcvYhu7k7Fx9+zO1yRuy5c0m
 u2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780315558; x=1780920358;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yYycUh0v045JLMzHv+cDjWaRSMlpTVGG8/fmLB5h0j8=;
 b=tG0SIFeU0iECgs7JztjTsJ/9tMSbWVv1LCWAlghb3XFz3j5DTB1VgFvJnovpYPJ+Th
 INbiSwUiU6U8iYMyeahimS6jIPTU3IIxgiQjVw0dvsFUHxbYmN7a7b+x7m4f29jTxwDz
 OaamiiY1psMkFTKOykkxVBtI0HQfu6Uo3k9H18Iid43lR40/9Gbiz/mhhv/LCE0tuCiB
 8LYzIDSDjezM+y6Muj2+GTtp4qmY/+kmiCRXYoDblZ+BBWT00U5hQosYpneInBFNjxyF
 FgvbwXrrPKkVd5UCt07uCmIVDBNwxNzrGsUdpwqu00DfwFGQIiVWIuv9vMYPvYeHHjy0
 QG4w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+eZTaYmDqMWAIGzbyw5Js6YifWgCljZNYs5pIR+DzH8D+Q/Ws2w7GqPjcIy0d88zl17QmCgttoyOw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx38e3/z9tzNMisQFP8RZAKBkfYvDobnUMCpJ9zTmgn2OzmLxP7
 KIse3lVzeQFLyVRV5zQexJzAYWWs00PwaLD+mQ8TO7+ShGkfxi27uMIz
X-Gm-Gg: Acq92OGdvbpBmf+WhbM5wesKiv7RImcqLoADUfO/yltrFXsZdU5r2cQXMKTw3d4LOmp
 XSBSwRCvzb+MVibPmbwgiG0X7dUZnvCtFOMHnybY1xktWXloIRl3MaVG7qZXSKfSqEhb7bcm5jE
 S+CuYQ9NvGMSuxP8ZqmaZflof8Fe+Bd4hgVa2prz11mE59N2wBCD89prSQasivjSz1SzCC6h9qD
 X474vgvg+0EIA1sLRRfKIfsGiklg5RT6g79uUx+HHnuC6KePPbEDgeqpgEdrXS1GZEdQRAdOshO
 tSeSHKJ8xZkwpgrEtDUOYSLbGmIDqgnDW0c6m7wmocEcPRH9Lp64Wi+DlwQziDQMQcslnijlnYm
 vWm5AljN+oXH6wLtod8QsjqIniDBpyyaURZgfbyjMUNWcIKOO/Dqk7liL3LcVVsDZPuv5F3gmqj
 uvDaoj0j3d2bXGUDE/+r02WKhoZhmw5bXikAHa2B0O2IQAoVFZOPX7
X-Received: by 2002:a7b:c3c3:0:b0:490:5191:6e26 with SMTP id
 5b1f17b1804b1-490a2941d7emr123128335e9.18.1780315558152; 
 Mon, 01 Jun 2026 05:05:58 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 05:05:57 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:05:09 +0000
Subject: [PATCH v3 23/24] dyndbg: change __dynamic_func_call_cls* macros
 into expressions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-23-4a15b241bd3c@gmail.com>
References: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
In-Reply-To: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=3131;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=h10PnN9dZij/9KIShcmtDym4aMWTMKg/65aOZIHej50=;
 b=7d4cXQrVbi/WeQvP8ZQuwmniE0ZO2BzoQ9gySu/7FaWMnxSGtRwVplsGXCR/85fxmr/fnL+vF
 wSHFrEsdBaeBNH4X2ZDEhDHxsO9POFKRVGtZMsRU54EYlGrkzM4lXm0
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

