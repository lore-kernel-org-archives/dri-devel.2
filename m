Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C2FC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:41:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B563410F513;
	Thu,  2 Jul 2026 16:41:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gUjJd255";
	dkim-atps=neutral
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com
 [209.85.161.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF39610F511
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 16:41:41 +0000 (UTC)
Received: by mail-oo1-f54.google.com with SMTP id
 006d021491bc7-6a166742b44so1294992eaf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 09:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783010501; x=1783615301; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NyPGwMs+hyIl4H1Hb9ukL6abOywy+AKG/840NZGmH+I=;
 b=gUjJd255jBYVfi6d5wBfnYxuIOFLnPyemSYvJHaai0It0XiC5UsY8z4G1dk0nrqngq
 kz7ljzaKcGpruj3hZM41/+mGnSf9oZgxu7SgdcHXdqJIGzGGqkaXbSEuBpBUQcQqtqPf
 eMoigWZKGwPoyqQsnzEKTjArglb1Qv8Mi3TlI+WcENhOGMBA4bOpuh5efF7M15ineL8f
 Fq+cY5Qep3zVK1w/j9pdUV1uQyulOGWPb9fKdlOD1TbQm/syjEh3wMAnhfO8USGQMdtq
 L3YeS58tXzNobZQblY/4+f3Sx0EykJnxO2OdP+oLMNaHCB9uXalFGx/RNbr1L7RPaqq2
 DCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783010501; x=1783615301;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NyPGwMs+hyIl4H1Hb9ukL6abOywy+AKG/840NZGmH+I=;
 b=h0gm/TCL9vbVChsrkLh3CbkEPyP9dSnhVWFfNoa59aPWhVG0BAluiHNb9f4ah3A61s
 MQM71WR9KwRS+HTUvlC/iqTJvW3kd+MF3lOqGH61ZGUsQnm6fSub3OvlKTHLbf5KWq/b
 oKKfHeOSn9i0T94+A2ZP9281QU9+0hxnHReC1z4a/xmavx0h03ZhFj+SZH+haGy1dwuX
 j1p1ihtOuLQ1PxaKpRTtL9VWyQWo7c7hwmRWau/9tYgiuRc0+7nCLH1sqgNyWE/YdYRv
 NCNEzscJwEPTd1UNo0CwEgFfcVwFgRk4xKhej2on61rgmy4EPhPK88vFhd9/yiPRs2Rf
 y9iQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xrujdJp57N7/FdlrHG/gQtxukc9j83DL6DFV1Oo0oI65MarFg78LZAq5r3l/G+TIm9nCQ/NAT1hc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyO5WAB8syR2dkxeBp7xc1SC8m9Y1bMJZxPmVeAeXhR0WAevTpA
 NN506FawpbDUzmWIzcyqXmRudzRfD042IpWuh8E+vPTBhFfWDKyhDJ/v
X-Gm-Gg: AfdE7ckRTt4kgyYp1RRfgRQQHxxNs3MTCwUnmOiB3VnqXwHJMGFm04wQRNPg4nWemu8
 9fq5pu70tZ+iuQ/QG0N/0Xg5E2lV47fUiyvqdf/mjxFpu/McyaN/wxh1jiDE/R85y8IqR9Pi5hI
 dD+7ryoQiGghyRlES55K5pUkq0qI5sXDamyR1bAso+bbELQum1WmMyu51muepoFTwnJgYW6gE5j
 /udsEKiV2MKasXvlv48rLu4jlvyWA3xkGHZnXK0+ePVA7MfeiZcPdUOmLJRlZ7oxRJdyELOKdeE
 qcJcpcPF0B7wZchK1p4ov7MZqDE7lsmwSL/xTdLv8GcJypwHxBP7DZwACTOpsVUXOqYZFi1AiC9
 K2SuOCUaJriARLrpzETJZWD8qBUiEm1hwPesZWLUqIuwnCEXC8ObYVCzQ2OzfpCJktVzb5ADUcS
 HvI8sMkSkIzavbjDHePvfXei5w8pvO3TS8tOeBMLY8NM0HTrTWX44=
X-Received: by 2002:a4a:ee12:0:b0:6a0:f7ed:8cd1 with SMTP id
 006d021491bc7-6a30d7c9b39mr3509681eaf.18.1783010500952; 
 Thu, 02 Jul 2026 09:41:40 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 09:41:40 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:41:10 -0600
Subject: [PATCH v5 18/18] dyndbg: change __dynamic_func_call_cls* macros
 into expressions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-18-24f22b052bf2@gmail.com>
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
 linux-modules@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=3522;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=YU9RtpCuL4COYNbswz5a4pt8F0knHWGAcRYBMAoMlB4=;
 b=u1c5Bhx9ascuV1Z7IHMlzsMCgPWlLsPkLIrMukkxro3mfC29P+COzhh7x2marMupmlPL+tRsT
 lqnL2g7lVnFCnJsDVXIR9nXv+uSk+s33YWUS/+uMa2ooHIyyqr8Y/55
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
2.54.0

