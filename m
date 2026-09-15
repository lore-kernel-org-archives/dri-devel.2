Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8955EC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 04:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7124110F8E4;
	Tue, 15 Sep 2026 04:31:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dvOp036C";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB80410F8E4
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 04:31:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0735B602A8;
 Tue, 15 Sep 2026 04:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905751F000FF;
 Tue, 15 Sep 2026 04:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789446712;
 bh=T0CVGKLgiIv6P0wOTqNaS63DygnR5tJwVWFpbGJX3YQ=;
 h=From:To:Cc:Subject:Date;
 b=dvOp036CuR+M7KMMWtke0gib9BPx5QuCIaDjAvjy3Q9pfT08RVeJo8YVPkNHdE1Jv
 cHyOTUNAFi/k61+BV/0MC9IsQ+hNbyTYrHk7iOL72AL7YabKnt1x32vgrS0I6zaziv
 1zvqMiA97xRhHFMBfoieddWHanmRl2Z/O+qQxYs3hSJLmaQJRozfXQUrT3GKvC1jg7
 VMS4il4dtrRxm9rVyIIYvsScMDom5crWl2JHYqmMPCrBeHcnUKJm/YSBF/r5bf3xqj
 sH3tLd+iUtcmDy6kRAHKkcHrSN2BzDP/1YlE9wQioFq2Wrof/isLztyl5Cbt68kxoq
 rnF/tpN18vqYQ==
From: Long Li <longli@kernel.org>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: ssengar@linux.microsoft.com, dri-devel@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 Long Li <longli@kernel.org>
Subject: [PATCH] MAINTAINERS: remove myself from the Hyper-V entries
Date: Mon, 14 Sep 2026 21:31:50 -0700
Message-Id: <20260915043150.10521-1-longli@kernel.org>
X-Mailer: git-send-email 2.34.1
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

I am no longer maintaining the Hyper-V/Azure core and drivers, or the
Hyper-V synthetic video DRM driver.

Signed-off-by: Long Li <longli@kernel.org>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ee9328178..7df36a2b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8168,7 +8168,6 @@ F:	drivers/gpu/drm/tiny/hx8357d.c
 
 DRM DRIVER FOR HYPERV SYNTHETIC VIDEO DEVICE
 M:	Dexuan Cui <decui@microsoft.com>
-M:	Long Li <longli@microsoft.com>
 M:	Saurabh Sengar <ssengar@linux.microsoft.com>
 L:	linux-hyperv@vger.kernel.org
 L:	dri-devel@lists.freedesktop.org
@@ -12162,7 +12161,6 @@ M:	"K. Y. Srinivasan" <kys@microsoft.com>
 M:	Haiyang Zhang <haiyangz@microsoft.com>
 M:	Wei Liu <wei.liu@kernel.org>
 M:	Dexuan Cui <decui@microsoft.com>
-M:	Long Li <longli@microsoft.com>
 L:	linux-hyperv@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
-- 
2.34.1

