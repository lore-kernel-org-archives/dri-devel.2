Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601D7CDB47A
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 18:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9ACA10E806;
	Mon, 22 Jun 2026 18:10:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="fdvAMZQR";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACA6D10E80F;
 Mon, 22 Jun 2026 18:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1782151848;
 bh=y7YrR9Jx1PcXUHjRQtEYdpxMBRgSE6y36uz2+nOziO0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fdvAMZQRy3BkoStbaMbxXr7cncV2mB4onpbhYObVv4JLfdGLsbAKsFU5d/YlZ/bas
 fnB3BUdkw4bY09Doz+IgLHBS67Nt+GBrK/vUyAoaw5oOhflqlnhgeRGuqBpDOClUi/
 EFSYKGpngBTCjtAMTwx9C/ESlmE0wcdetGxZEcJEBlrZY4TtruphEc6g3xnq1PHDsl
 2nKdQP430hmHmvI0WrO25/zlpPaYewMu6NrcbKiS9vCj+a118Pl9BewkZXGO0VbopU
 SurVM6qIaq1gLvKfoqkJO95GC4Lk8Pu/9svLNWpe/VRVKAJzaSybQlj+0LYKBncLWc
 LS61WHVVdjK/Q==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH v9 23/30] PREEMPT_RT injection
Date: Mon, 22 Jun 2026 20:10:36 +0200
Message-ID: <20260622181044.39335-24-dev@lankhorst.se>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622181044.39335-1-dev@lankhorst.se>
References: <20260622181044.39335-1-dev@lankhorst.se>
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

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 kernel/Kconfig.preempt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 88c594c6d7fcd..11bec9be95405 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -90,9 +90,9 @@ config PREEMPT_LAZY
 endchoice
 
 config PREEMPT_RT
-	bool "Fully Preemptible Kernel (Real-Time)"
-	depends on EXPERT && ARCH_SUPPORTS_RT && !COMPILE_TEST
+	def_bool y
 	select PREEMPTION
+	depends on ARCH_SUPPORTS_RT
 	help
 	  This option turns the kernel into a real-time kernel by replacing
 	  various locking primitives (spinlocks, rwlocks, etc.) with
-- 
2.53.0

