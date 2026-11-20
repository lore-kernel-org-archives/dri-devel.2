Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C9860A2604
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h7WEp2gn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C635F10E21A;
	Fri, 20 Nov 2026 17:19:14 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61F8C10E143
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 17:19:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C970861FFE;
 Fri, 20 Nov 2026 17:19:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795195144;
 b=i/mtdy3MYuIhLRvI1r4fdgVIZRJ4ttT45WVm+HSzDysMhmACw1RtDbJZTEVxanJHs7Um
 v3IIM5qb3lsDOEwsIwZC0ftdE9et0d212niX8PG6HwrPp6B2LOfUPwHA5ji+78bSHd6du
 mSWlKzPjWzUEo8zmQ2CI1SyroNwgLVwHEhZs7lQh16e4XDk86CBBgfJEw4zjmbd45LXMg
 KBWEFas3IU4N/P/ocXmE6r4VnXnUeMhOCc3pW4tAE6qqMa6nVdak4t3Snt3NZ3By57BQY
 ug8b1M566Ef4JnG+f+sF1kY4Qia8v2jfy9vJOsy4EwVZx77QQ6FyNmbPX2rWxwvXYbQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795195144;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=sXmqx/BpyxR0AvNm23D/0Zb6NYTqs5DaHn7y+tWuYsE=;
 b=TD/PklK08KRhJIc7rXcP4DQKb+XC0XiNNzOuu0aPj4GXyWXFHfZbbZvtq7blFkkpTzxN
 1n2Fv6Ef9SXaUCaJPjdloI6BcKObXRsHw+CdPyNXYIG/9I1zqK/Mt2jHDNGdw/8C5t8S2
 nowBKYxtTdQ11TZEK0Hjm7+AcSlzVPMh9tbGy15c+++u5Z75LFiz7hXzD+Q9frJQBk08a
 3x6kiCpjq4dfsG5tOYBbWg8rIHUqHAbfpw9Sv6COcoiD2uKHjVGjVQhIWVCu/mIggG2Nh
 vTcKWl6tdq4NBrvCYyD+2FUbin4v2MMfYFjNZ1iiKTyQxKZE3pnWDRPaHaSlTbBf9Eg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id B27BC1F000EE;
 Fri, 20 Nov 2026 17:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795195144;
 bh=sXmqx/BpyxR0AvNm23D/0Zb6NYTqs5DaHn7y+tWuYsE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=h7WEp2gnisp4cDW1LbH4y5G0hV3NX6azeR7RaJIASAuU8lq9P5jfvR3A7sYLI3D1R
 WKGYSjex6mXP1zLJ7j3H4RiT7TcEmnngnuj71UWWT7hC58ZBQ2ntCNYHX+iLsRk5Zo
 fDv7EOV6DmnYBJaKcFldEn8/fLWAvay8UZ8mWalz/H0wM1S8L4aIoGdMwAjeSw3Xx3
 Ikd/cPZ3hOyWbI8F2zhJFnQtcXy0LxEFZLg/haVA14hRI7QMzNP9wejOGPkZ8PmLhm
 CkB+in7ETiMTDgrn/UgrkY+LhN/BLRfITd0NZ2dIsanPfPyPuyEJGuHZVA+ZUTjr/5
 PhZMY89t7/abQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 411FF4B879;
 Fri, 20 Nov 2026 17:18:46 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Fri, 20 Nov 2026 10:18:29 -0700
Subject: [PATCH v2 2/5] drm: Fix incorrect CFLAGS-y spelling inside
 Makefile
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261120-rd-mostly-v2-2-88056ede02a8@gmail.com>
References: <20261120-rd-mostly-v2-0-88056ede02a8@gmail.com>
In-Reply-To: <20261120-rd-mostly-v2-0-88056ede02a8@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795195125; l=1720;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=hMEQq7DQ8Y+8kFzLF6fjt/pf2mXqFlMk3/m9BN7qO10=;
 b=YGPIoRWQF/LeWCs3OVwDqa81HNhlz/XS0XwldnHBv13k35ZLbsQgDT6QfQLMW38XDWpbrFC2z
 5ZhLXANqOUqBT6jUzvsBuW3ahyszHwZ+lljb5fxgx8pzv9mXADnGmL9
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: jim.cromie@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jim Cromie <jim.cromie@gmail.com>

DRM Makefile spelled CFLAGS-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)
incorrectly, which kbuild ignores.  So -DDYNAMIC_DEBUG_MODULE was
omitted, breaking DRM dynamic debug callsites when
CONFIG_DYNAMIC_DEBUG_CORE=y without CONFIG_DYNAMIC_DEBUG.

Replace CFLAGS- with ccflags-y, and also set subdir-ccflags-y so that
-DDYNAMIC_DEBUG_MODULE propagates to DRM driver and helper
subdirectories under drivers/gpu/drm/ (ccflags-y only applies to the
current directory).

NOTE: When CONFIG_DYNAMIC_DEBUG=y, -DDYNAMIC_DEBUG_MODULE is redundant
because defined(CONFIG_DYNAMIC_DEBUG) already enables callsites.
Passing it unconditionally under CONFIG_DRM_USE_DYNAMIC_DEBUG avoids
extra Makefile conditionals and keeps the preprocessor environment
consistent across DYNAMIC_DEBUG=y and DYNAMIC_DEBUG_CORE=y builds.

Fixes: 84ec67288c10 ("drm_print: wrap drm_*_dbg in dyndbg descriptor factory macro")
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 2c6bc093a923..4a93c09f08d9 100644
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
2.56.1


