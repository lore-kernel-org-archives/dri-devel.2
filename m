Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C775F105F7A6
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B5AE10EC04;
	Fri, 13 Mar 2026 13:23:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jVhvGoYp";
	dkim-atps=neutral
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B28110EC04
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:23:41 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id
 5614622812f47-466f935a82fso1463812b6e.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408220; x=1774013020; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o/myr2hp6uBA+KWlkM+krb2AJfDnLypCssuuL9Sraxc=;
 b=jVhvGoYp6rfuAQ10yhKjzqhklqPSPBHipCLjN+5ipZaKcS6lRYc07qkGIYRis3KARY
 mqs/lChGHPzbTEkbh1s/OyV7/RhOlJ6YwXganhTkOa1hLMQD/aBOsNvKg+MWYP1eyp3o
 0rd7HrhtNT7WxPEnARIwgGzS4oLabp1S0v8zpwNrpLDK1sAV2ALupqwdDa1m/dRbmLm7
 cv9LwknhqO2C8HcGchR9mozFcudxXyRxDxdrIGms9/auXb2tiK27NEigRaasXZOrG8sp
 FdiUj6HMfsxVJiwzIxGeNBay4fTcN2UyL0a34x9kZ4Ih6p+x4dN77aE5WIq/UXMSlL1U
 Iblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408220; x=1774013020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o/myr2hp6uBA+KWlkM+krb2AJfDnLypCssuuL9Sraxc=;
 b=j2trxqYrlNByd8qcCVmMnfwDZh4y8yRFZv99LyJQZCkBpx7WFGCcfkemCOOkYmVl0w
 fOJxF0HMmq39LiTXXCTRZv8QUaUMuRj63GKgMGrYykiWh3fsQP1dMeD/PmrAFUDMBQxf
 q+jD5jqyXOedoaJog65WBRMah3kPLGvn8r8bkYHa6Z+D52sZZQp5DVqdgtqIdPF42UCD
 jZUcCJowScKsHkbssXxyqS9vpz0hvs3fmwOTI5VCfuL/LEuqx8BgICqtYjQL4kyBVQfi
 zhaeeolWzzZYXKpQIia8ZwNXUaleMV7qXpBIdIkyD3jKikOqIbYv9oZgfuP4K8K11+2H
 OIEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb2izchwrfeLaD26kGissgUooxxoEYiScclz/wK8Mrb4HGFVviiUMR0ay6M6d/9rwjogulEOga6YE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxwsoUy1NVuzV215/UzPIpBTU4yaQmB60KfWxkn8bAuf8xAraiv
 3Qya7/JTtbbYRRJurFh07K5yPR1oj8dbL0ZADAVKJaA/+PNK/AJsiPuT
X-Gm-Gg: ATEYQzyRpl2zZMQbde+eIe6RHFgJpHp+0KAcOZRN4rnZW0el4GkKhPj8IWmzQwq7zky
 uyPiWNrfWwWhmwYVfR9esWKr0x5f6bfu4veLJapFObMaODnYnycokErxyqsDFXjwWNWGWVHuBMb
 7a5HhYnF9mJFBmT5x3TxwACH+/poEUokRKHgNi5svzZ/Oiyk7suewxgxb/YA5SWxc2xoBbc4eWi
 ZNflJ6tbE7h4Hl5nUorf8GLjcPjzTgYFDfPCkIQsKUurWPWJ/SKlfjQg43UsrIUBeprowT6E3hE
 ye6JSRXpC4hn6mpCZN6zYdcB82l5oE0W3StwTJaJzSDkZA0V+c8kS5GZYnOBI1erlcqH4tSzbdX
 DRuFck+CtCBQEZaP3pkEx47K/zpxPtamxVYL0x/h7TP85eqeVsQp4RmOjtPqu/b3amRd0kXPh+L
 F6CpjzzPRVt2ZQjik62+uuYDeD4OubehBLXOsg/zMEVqE0uTL4
X-Received: by 2002:a05:6808:6604:b0:45c:8fa8:7497 with SMTP id
 5614622812f47-46757530482mr1581686b6e.34.1773408220142; 
 Fri, 13 Mar 2026 06:23:40 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:23:39 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>,
 linux-kernel@vger.kernel.org
Cc: mripard@kernel.org, tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 21/65] dyndbg: change __dynamic_func_call_cls* macros into
 expressions
Date: Fri, 13 Mar 2026 07:19:46 -0600
Message-ID: <20260313132103.2529746-22-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313132103.2529746-1-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
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

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index b6198ecc854d..80160028461a 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -224,24 +224,24 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
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
+})
 #define __dynamic_func_call_no_desc(id, fmt, func, ...)			\
 	__dynamic_func_call_cls_no_desc(id, _DPRINTK_CLASS_DFLT,	\
 					fmt, func, ##__VA_ARGS__)
-- 
2.53.0

