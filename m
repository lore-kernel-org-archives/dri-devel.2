Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8967710AB807
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:55:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4623310EBD6;
	Thu, 26 Mar 2026 18:55:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gWJBE9iY";
	dkim-atps=neutral
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com
 [209.85.160.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE39410EBC6
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:06 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id
 586e51a60fabf-415b23dd6e5so537981fac.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551306; x=1775156106; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BtzYjTItScPv3ZPv5u0hQB8QpwmveJQikTbqnzcN8xo=;
 b=gWJBE9iYqkX5ifNy98GcVSPqaILTm3863mWMPbDrajjExuKMvKHWkqOmu8kgBG05KV
 sUnefqoABnDz0K8cuCMdyR9NBJT+Lp2sEM/GJGemLmBAnOFyk1bZSMEuuXUSSFweFj+8
 AnSf5ru/Szg+5l9I63KcTYfOhhKEZFUO9hxPdM0Fjx8L0//mBiX0rmUfDbGAHbfAFYqs
 8RkJNng9X4axFQFR5K4dw8zQZ53vyNpJZ1sP7fJ84Zx//xAZS8msz/oIzg7ubRvDnvE5
 4YXQA5sbzfvsn4Z+3IYApzQcxOSt/o1VGOKnEid0IZM22xAebx9s8IcJA6jGntM8EdEv
 oS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551306; x=1775156106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BtzYjTItScPv3ZPv5u0hQB8QpwmveJQikTbqnzcN8xo=;
 b=VbWUU3JeY+EFdLvtB4E9Bt971L5Jich6yQibYoPahBaFHTZbARmKJbnb5g+aQIMvKp
 38bslBSStiTmeDd0LsNCsnDziujJ92r9deuAyv5FgOrCT+tr9DBgDZRoBMPIyzFwY6Xk
 WdHNi1lf5vsJIV7dQrFvEBCIyhqvq7jDjccXS9xQeg9cISTgV8oIH8sl57yTTVqv3Nm3
 2v14NmDo/PyPZNdwE2x4q3Wx3LYJBbGoN9fn/ClEx1tJs5s+PVz5/xkl4Z0DoIopbmmo
 kyLmcfeaFOOUOZdPTWvSCkqfTXEcf43APVQTjyL1unRwJet3xuS1tVRQVOFkdTCKaSLO
 578w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0/4ZwVp25mJBaY9z0MKLi8hQ1HOXCUqGiZ79wpg9cO0rvq4Rj4IH5CRtazblGoXso5groz3ZLeow=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwN8CWQ01neZD5zW1upY7z5BPSoxyiS7oTNDYjnorWMooUN1R8B
 TcE9hSPuoJoExNV0lqPE+O/BG7ECoaAsdI91PdYfmmFN9XaLAuuUhNZ0
X-Gm-Gg: ATEYQzwGCDlRQ4nVtg8xU1oE9jQliQqpT1oHkf2KuON0u81ssWW46qN+iMUeg+mZitG
 tTgHsA3++h+gNa/8oxSCzQQNgFJPqcA/maZlgJLQDEgX+eHMtf5qr1U/4EOq8HH5zPZ9DksswMb
 D4Wmn/8U4bFF6YuxFT/SDAHJ8Qh+cG5jSwYLR5Pyh1o1exUFaYo7IUh9FYmI6YDP2RNfweRGWLe
 6wIzDpqrnq8MQ74h8o7YP5Xk2v94YMQjGyRJBV0XZf1B6DWvv7wCY8EdRWqsS4xXs0PGgr0rMew
 aWRY+QAaM+LOxzq/QVC8018j3pdTk5oqxjHABAQpYNBrNTxRUFOSlS5I5gVY2QWE6bDPxogmswj
 YUQ8chQ84Wz54Y0EalUQFNdQzQFQHlU+A5mVp1lewUYXbjxHnkVeImkORjHYo6l1YMr31Dqqtgt
 q+sz32Zk8R01aEaI3bN8MDGcl9+9lPiKbu6auD53T3a5CBFnCH
X-Received: by 2002:a05:6870:d18d:b0:417:4679:d550 with SMTP id
 586e51a60fabf-41ca6e15946mr4548356fac.22.1774551305958; 
 Thu, 26 Mar 2026 11:55:05 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:05 -0700 (PDT)
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
Subject: [PATCH v12 24/69] dyndbg: change __dynamic_func_call_cls* macros into
 expressions
Date: Thu, 26 Mar 2026 12:53:28 -0600
Message-ID: <20260326185413.1205870-25-jim.cromie@gmail.com>
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
index 3939b294c647..33291abd8971 100644
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

