Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D055BCC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 338F010E643;
	Tue, 13 Oct 2026 10:58:22 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D93F10E643
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
 bh=SxIKnwNsRAL2rrwKxGSDkvlNoeNBUEJTKMLvbZQx7TY=; b=HjURApUecEtKtwol6WToZFmgNO
 gCR2gFppHwvNEYIQfa9H/gp3evBnOYMxvaJSf9vL6XGjdmhonp3HgLLhqT6Xd5N4kZCD4hESBCp5T
 g+wb4LqEazGsczCK5aZEqGVCXdbQzzp8fCi2bZ6xZesZJ8HaQhW5xSzOuzIhHNaLcjIAyncEp8wqL
 mWYfnvdL/XZwZS8riMwUovw6zlzEgJcnNaSZEyjzANZOJnQZnWxyaEsyUSGohkPzkHs/nUJ/rMDlq
 GBoxzFspvzyLHFlFY49kzGlspq3AzDt1DprBexJdTqGp1vSAcd06MhLLVnDRVFVxquOkBvsC6hsYa
 Pg6iKKAQ==;
From: Heiko Stuebner <heiko@sntech.de>
To: tomeu@tomeuvizoso.net
Cc: dri-devel@lists.freedesktop.org,
	heiko@sntech.de
Subject: [PATCH] MAINTAINERS: Add myself as reviewer for the Rocket NPU driver
Date: Tue, 13 Oct 2026 12:57:56 +0200
Message-ID: <20261013105757.3924282-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.3
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

While I definitly do not feel qualified (yet?) to tackle the changes
to deeply IP-related parts, I can at least help Tomeu with the more
basic changes.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a08087fb6e67..5fc5eaaebaed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8011,6 +8011,7 @@ F:	include/uapi/drm/ivpu_accel.h
 
 DRM ACCEL DRIVER FOR ROCKCHIP NPU
 M:	Tomeu Vizoso <tomeu@tomeuvizoso.net>
+R:	Heiko Stuebner <heiko@sntech.de>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
-- 
2.47.3

