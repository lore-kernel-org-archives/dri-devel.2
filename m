Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FFAC5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 23:29:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1080E10F590;
	Thu, 13 Aug 2026 23:29:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="CKNQB5db";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57DB810F5A4
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 23:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=4xDOoRVfx4DzTe1p1zmU0BCJRCQhsbwPhmZYGCEo7Dg=; b=CKNQB5dbietwRWYGnEJplufeND
 6fg68c0A8zHOHSD2Rle7OXJHTDVoPwTLIb2pCDOMEjxVKBETckJOHx+c4MQxAMTpVo96JsQ5T7TcV
 hSrZ1ege1948UGOGXLA6p1dS36pZTPPbaF2H9tCBL1vZ0flrwQ96K0yr+BS70QQ1zexZYrNoqxEXP
 4rwcQJpldAbqcd8OVJxf9wBUqpCD725VML3eHW7uEoTnL4rs9hhBYGGU9c8R1kWRHsub4AMJ8FI4N
 2EcTE182D2mh6Y2bd0B/a0ptjppUOVEZzyFBhVZKW7Al4QgNKAf2eUOwLB4gvR9Akq6gVghedMZ06
 09dlHU/g==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wuerf-00000001k8D-05B9; Thu, 13 Aug 2026 23:29:35 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH 00/03] fbdev: maxine: clean up build issues
Date: Thu, 13 Aug 2026 16:29:31 -0700
Message-ID: <20260813232934.2718291-1-rdunlap@infradead.org>
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

This is all ancient source code from the beginning of git time.
Now builds cleanly on 32-bit and 64-bit MACH_DECSTATION.


Subject: [PATCH 01/03] fbdev: maxine: make functions static
Subject: [PATCH 02/03] fbdev: maxine: elide an unused function
Subject: [PATCH 03/03] fbdev: maxine: fix 64-bit build error

 drivers/video/fbdev/maxinefb.c |    9 ++++++---
 include/video/maxinefb.h       |    4 ++--
 2 files changed, 8 insertions(+), 5 deletions(-)

Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
