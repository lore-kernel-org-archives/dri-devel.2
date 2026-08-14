Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673B8C5DF66
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 02:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8537A10E533;
	Fri, 14 Aug 2026 02:56:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="C3L/T7MZ";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13C4910E51A
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 02:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=zbky2Bpv4AINcxZq0H9Q0Wkjam+9jh7ePSFufJNMOnE=; b=C3L/T7MZSNxdlHLTLN/6kiOLHs
 pMURvi48uRh0dgxpa0C3lChgT5UnhjpcObla0HdPc/m4qDTNp13Z6lDwGT5PcnKdrhKlN5E5aJpCB
 zkz9AB2X2rzvAdfKqeyk1ZqbMOd6g/NsY5qkhkwtDqgcb3KRhqcUthAJDfSnz7n15zFaqryAgpmMK
 hrtztCdnhOvOQZKs+0l8vI9s9rnmlrqz1Hb59xSgdhER4JB9E5HyqNVC/VZF+M1UTy9Rnqrv8xIfL
 EYsgl0Ce4y7eeU+wwuiXu8EalLIBNLGIKYkdypJ6Hy0B6+rpvzE39VA0XJrJtDY3cfCTX5+oAan3T
 y8jyMMWQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wui65-00000001sfm-0YwG; Fri, 14 Aug 2026 02:56:41 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, sashiko-bot@kernel.org,
 Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH 04/04] fbdev: maxine: fix maxinefb_init() return value
Date: Thu, 13 Aug 2026 19:56:40 -0700
Message-ID: <20260814025640.2782161-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
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

A driver should return a negative error code on failure of its
module_init() function so that the system recognizes the failure.
Change the "return 1" to "return -ENODEV".

Suggested-by: sashiko-bot@kernel.org
Link: https://sashiko.dev/#/patchset/20260809234810.982500-1-rdunlap@infradead.org?part=1
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>

 drivers/video/fbdev/maxinefb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20260812.orig/drivers/video/fbdev/maxinefb.c
+++ linux-next-20260812/drivers/video/fbdev/maxinefb.c
@@ -160,7 +160,7 @@ static int __init maxinefb_init(void)
 	fb_alloc_cmap(&fb_info.cmap, 256, 0);
 
 	if (register_framebuffer(&fb_info) < 0)
-		return 1;
+		return -ENODEV;
 	return 0;
 }
 
