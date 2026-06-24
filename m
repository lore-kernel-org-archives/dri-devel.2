Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8F3CDE033
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 18:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2848A10F06C;
	Wed, 24 Jun 2026 18:04:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="E4jFuVzV";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B268810F055;
 Wed, 24 Jun 2026 18:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1782324290;
 bh=QZQHP6SZcmIxH0/+L/HEwqRhaltY7tmMssFrjZ10E1s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=E4jFuVzVfC7yiclnU1EaN+xGr6SG2UlkM1saCeBo12xCk7u23o6HXsiTC59pZZ3hw
 PuMk4Fpq8B4U9W480BtBqSObYt357vksr5A1Hf6uhog5z16QMCVm3cxYoULOd6LM70
 GCCfdp4hkhi2ckje+RwR7QV/VZ74pwRVv7wcJBaSwjwOt3gYQoqmgahnjOWIL9hUxt
 R34mh2hhghNaOr8GoyiY6gTrClfuIaBEkJ9yoNBvHQir6+MZZ54RdNUcU7RyiM3H5B
 +vZkAALgavvChwX8uTOrZIfMAJXJq6Inhm3SoNpBDktPcM8AgAv0KwX+tKsJRIE0A9
 LcPXnF+SLTNBg==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH v10 24/30] FOR-CI: bump MAX_STACK_TRACE_ENTRIES
Date: Wed, 24 Jun 2026 20:04:51 +0200
Message-ID: <20260624180459.1024068-25-dev@lankhorst.se>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624180459.1024068-1-dev@lankhorst.se>
References: <20260624180459.1024068-1-dev@lankhorst.se>
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

We're hitting a bug in CI where MAX_STACK_TRACE_ENTRIES is set too low.
My guess is the repeated loading/unloading is creating multiples of the
same entries. As a hack just reset lockdep. This might only be necessary
for CI + PREEMPT_RT.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 lib/Kconfig.debug | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9b9f7c5935596..ec35b50068a73 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1625,9 +1625,8 @@ config LOCKDEP_CHAINS_BITS
 config LOCKDEP_STACK_TRACE_BITS
 	int "Size for MAX_STACK_TRACE_ENTRIES (as Nth power of 2)"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-	range 10 26
-	default 21 if KASAN
-	default 19
+	range 22 26
+	default 22
 	help
 	  Try increasing this value if you hit "BUG: MAX_STACK_TRACE_ENTRIES too low!" message.
 
-- 
2.53.0

