Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DD510AB805
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17B7A10EBDF;
	Thu, 26 Mar 2026 18:55:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WpID93gh";
	dkim-atps=neutral
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AD2610EBAC
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:54:50 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id
 46e09a7af769-7d7d4ebccf7so1046694a34.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551288; x=1775156088; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q4prZoq+o67W5OQsgLrKexlAzQC80y9w+24uEfnXM5Y=;
 b=WpID93ghVpitifRDUJcKgOvdzsq91/FZOXI6zs/WW14ShmaWjwlQ8stnpHC1XrkDpv
 Gb9ChAY3hOu+4kfF4Er6HsQ/1V6iowLKwXo9xLSRIXm4aumvsoKntGCKTwoA9REc2s6P
 I/tqJN7Qb2SNBmRlKK4cXFoYiWIEicnRl85iRqt2M8l1WrMudzRnbpk0d//P7vRr9E00
 j0i1oS35jKjbOuWfgb1z4ViS/zmmyJG9hcw2Nw2maDRyGWDJljcZWepH48Pz6eudF5xZ
 wioUqrK+9uLrMQRghCS4oOReQagv7LTAIUr2HWrOMsPb8IyZmhrs73yWj6qF8CluBUJV
 JlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551288; x=1775156088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q4prZoq+o67W5OQsgLrKexlAzQC80y9w+24uEfnXM5Y=;
 b=F+dieVyQ7gMIumsSo/ME7ni2915RQDAjyYWkuZAsUNpSN5e3pj8r1tDurS6UIf/rZU
 OyPUGHOYG1oii0xYuZxnf0GSRLWIpePBCvhoFP5ORPD8qiACcN2f5iXw4W/gy5v/WqhE
 CJDtNRhV7hvp98QHD47rMSpe/a9dcBatNbzhE3aiTP3VQt/ZnVX0opbaQOy90DpwkXWt
 ZqNoysgtSNYiT1yKXDpALeFaYpR+Jb7GZkMcLr3VMos4hT0EKaXkPizyHmrZyVI8umxc
 TRyF+/kkPFJNzVdANOHHBb1lrdMEht0hFf9mvy3q4AvkYK9paiB8F55rX7fJ8+MUppiu
 RMlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn6c2sgD2ut6pNw2b5k18yLaD1/ApUZncdL42XOADOGcAh9YeZAQ0IhClmCHHu0+EXUNqFJtbuj7E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQ7D6ufJqZdGV1HDbIrmGqHxu8YlBcWVTZPCb2L/P132Le4+ce
 JjYE/F+VIVLtgqmTxvEYFzEAcP2mjtCsJ9pWL0GLm69LAva4qrF/1DIR
X-Gm-Gg: ATEYQzyZiDYbdYXLmyCAKP3hVc2JPwJmZ1WKUWbJamOu1qBS6R3eHrM9YuPIUb9kwD7
 jaSR9z840s7iocIhHltue2E+G9p7apdZrJX3na1kfsVxp5L2z5EJXe+UGDJeBX/2SX9Mntju++G
 DKJh1P3HQX5veUb7MMs9Z+raFsCRMZ7fA+75uUPCxtFK7MsyEnyNAU7M+oV5rZk/9be/B/YExpC
 KxGgUCsKTxOscUDOk2KXyyR7DtLtZAx+bb4ME7bzTUrFGjTV+kDIs++fPMtMPsKK3gR+ps41/sG
 gU432UxD0SxLFQ4TLtS0gp92KYPJc5/Qe5ZTKQMSb9vhiKB0QtW8LZAdVvXnkc5Mk18CKOhGA4D
 gPtE5va2cP/xZ+Oz3x7e98hvJo/OLUFCVWzyaK2ssvbHv/qZEbQ2VvAD8aeDiQFwIw7LVdDtOPc
 xMxoZ/QBEdN5CaZ6GwaSksFdQpTZgDZ1V/4pp7uc1dcTwSQzHK
X-Received: by 2002:a05:6820:1893:b0:67d:b2f2:6e72 with SMTP id
 006d021491bc7-67dff3ce6efmr4416641eaf.13.1774551288030; 
 Thu, 26 Mar 2026 11:54:48 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.54.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:54:47 -0700 (PDT)
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
Subject: [PATCH v12 12/69] dyndbg: drop NUM_TYPE_ARRAY
Date: Thu, 26 Mar 2026 12:53:16 -0600
Message-ID: <20260326185413.1205870-13-jim.cromie@gmail.com>
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

ARRAY_SIZE works here, since array decl is complete.

no functional change

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 441305277914..92627a03b4d1 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -132,11 +132,9 @@ struct ddebug_class_param {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.length = ARRAY_SIZE(_var##_classnames),		\
 		.class_names = _var##_classnames,			\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-	(sizeof((eltype[]) {__VA_ARGS__}) / sizeof(eltype))
 
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);
-- 
2.53.0

