Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91496C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09E3E10EB41;
	Tue, 21 Jul 2026 20:57:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c5F5Whjq";
	dkim-atps=neutral
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECF9C10EB36
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:57:15 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-7ee125ec926so743080a34.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784667435; x=1785272235; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kAocSYnxkpWO75UswebGg35q6tA7nY7bmvBjycg9mYY=;
 b=c5F5Whjqg8Fa5lmJ/l3EPHHRoshLdWmDuBImlmYIUnk65FGpesf57sBz594C2GheHe
 x89aJYgD5gmpIeUHj4QYU+C7gGsocjWlNTIaiNHlr4mlbXOQSvjxjDm3hLmtI9IhP2vf
 SjiN6/0lxAB/EG3DJzxECPx7JfztX5rk9DxobKhTY0biIP/1WHc/u9c+1+B9RbWL3hDC
 qdsKlcM233Dxxv5CNM3ngNzizCxP8W3XmKKGtXPEuk4jXCOJMVCId3OSaHx9AuHPkG/H
 BMtFNFPd4vT12kMgGS/8Psu/h9CnRLFIGFa/UmrtkCBfTqUsndULYSQdLHmgC6e/CPms
 7DkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784667435; x=1785272235;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kAocSYnxkpWO75UswebGg35q6tA7nY7bmvBjycg9mYY=;
 b=FGgLqoOlTCdzlW9Lxl22Y7hbXtp8iC6GJI8dN7LJHFp3T+sS5auTc0WPEybd/ZrwiG
 y3yTn0d64a7n5rtdZBCyvQ5LwEbuYFdeomsP3jDsNUGMSlhS7AfBliFwIO4aPVp+lpsf
 MBw3cX0T2YaDmTBaU7FzlQVJCmTgh3kxGKsmx/tH6iNQOHauUuE9a8SiAbzVAVfWUS6A
 jYk0zJGB/f61VoizK2sW975bbrwGuuXRDuVJw9+p6V6BwurTCv1V9IRF0k8kseB7oCxi
 uoxlFPKPl1nLJi3IcJXQ1X20z4hu/Wyh6j8GlCCEfBaS8XzJ8mChn6f/Z1EVYkbbbPD/
 y6kw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZJnI3DFraK1WczjGqY+OSrLH5v/8kpfFSB2gV/m5YhViBfELJvmT/bEeps5iYgYcBBmSPAZ7m7gQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy98gHqKFtlGXEknm87T4TlM/51aaodiL5PQf93BRgCzHFfRe/d
 wAarjMugmQprJTThxZeB6aOAUgE9todkTBqyhZkV2Nh86+e33pHFgTxT
X-Gm-Gg: AfdE7clsNyUS43UjyWnWSxu9Xdee7zkV/Iin5CBdxdI0i9yIzHdtthgjiB7iDi28rJ1
 fSqaALoMKJ8AyO1xWnrzJeF49OnuX0kkN07LHBVWhMxhiuUrb29Lf9/iQivS5YwX/1tHHp3dB+w
 Ye2FK7RVKqSZum04B8RWQnZY496OAxQhtDOcivUbH8WDcRLvXf0NF9MhsfBSbaoSQzte1fLmxk4
 UU4u8l0sTCzbxrIkxgRKK7HxMxfSbxhUWhMLk8gVtNH54jMwrm4Jg+XdmAShqo9dOm9DJBYMfFp
 jk1S7+Xzx1iRONX+IsDdcCm+qUhXOQlbsz0P9PQ8cNuTPX1nQjv6fMte5BSmkbclFC+VlpFZEMi
 rjNlVYTSaK9ca+MkNE3TkDRMDgDEkJTwW6tLR2FJCxlvXk9eUrwTgBDU/1Ph51Ib/a5uR+P/Iih
 jyo0y8amtuIXQU5nxRF+5p60idOXr316SLw+0gVxdL8+Z4BKrZSTCN1OUIXsPHQ1eeDDXiGxCaU
 yi1SzFICYkGMaLC2NxCZ+oKKw==
X-Received: by 2002:a05:6830:dc2:b0:7e9:b537:1032 with SMTP id
 46e09a7af769-7eda4e4a0d1mr10236409a34.31.1784667435133; 
 Tue, 21 Jul 2026 13:57:15 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 13:57:14 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:56:52 -0600
Subject: [PATCH v7 03/29] drm: Fix incorrect ccflags-y spelling inside Makefile
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-3-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=1097;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=es+00dI5lNkwt/sa4qLfcgHP71hLrTUzt4kFdW0j2uE=;
 b=OISPXRmljhHYEheJg69+sy9dq795LswJjyP2tozw2g6htoU6Pia5NBf9EwQ+pEa9lAVL6Pfb0
 IHWJ4VHNv3oBIjyfxg/R8nN7AW2ofYOryMj8dbmU4ZDrQcwAKV1DvJL
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

Fix a longstanding spelling error in the DRM Makefile by changing
'CFLAGS-y' to 'ccflags-y'. This fixes CONFIG_DRM_USE_DYNAMIC_DEBUG
dependent addition of -DDYNAMIC_DEBUG_MODULE, which is needed to enable
dyndbg-does-drm-debug when only DYNAMIC_DEBUG_CORE is enabled.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index e97faabcd783..b0d0a85cbd4f 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -3,7 +3,8 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
-CFLAGS-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
+ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)		+= -DDYNAMIC_DEBUG_MODULE
+subdir-ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
 
 # Unconditionally enable W=1 warnings locally
 # --- begin copy-paste W=1 warnings from scripts/Makefile.warn

-- 
2.55.0

