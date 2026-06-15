Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83E5CD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C06310E68C;
	Mon, 15 Jun 2026 20:18:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="d9NGAgnK";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95FF110E625;
 Mon, 15 Jun 2026 20:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1781554727;
 bh=QZQHP6SZcmIxH0/+L/HEwqRhaltY7tmMssFrjZ10E1s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=d9NGAgnKDErUVrhEu/4x5zgRtdpuv1dmwSFvun+aByUgk5wWI3SSNrNyZxCgJeF9d
 VQ92db3tn5N3YGP++6Al9yWXGiZzOiz7RN+P/3mKMZuzGNGpy4EXQmaZv/kV0t7+xy
 OtOJyikO2LKLDQO2qHwGIQUfMeRqaJYhlZSzLdiBMsDC6H7N/Lnc48PSvfA9EK++Xz
 l/xo0rka6vgSwFtU+No3mqc9SgJ6fCk+laUwjh4Kgj/yyigV5e24H2xmaww6G98uUv
 3g2ajLC5nHun7btulEbY52rz1/Rk6T+Wbb0MMCqq1zgDX8Si8G8iThP3WnkeIQU6x4
 CZYHyO9Q3lBRQ==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH v8 24/27] FOR-CI: bump MAX_STACK_TRACE_ENTRIES
Date: Mon, 15 Jun 2026 22:18:42 +0200
Message-ID: <20260615201846.307297-25-dev@lankhorst.se>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615201846.307297-1-dev@lankhorst.se>
References: <20260615201846.307297-1-dev@lankhorst.se>
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

