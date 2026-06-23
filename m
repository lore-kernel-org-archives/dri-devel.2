Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A906FCDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 10:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CC7810EA8B;
	Tue, 23 Jun 2026 10:46:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="C2WRSfZ9";
	dkim-atps=neutral
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk
 [188.40.203.114])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9295610EA8B
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 10:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
 References; bh=9926qhdoGRi40OwFXRhsIDk6ZjvDAsbtGSVTfwomfTg=; b=C2WRSfZ9+dGfih
 ULN0zxeu8/r8lmpwkZ6GpKK+nkwczXeVT1jfAf6j7fWtVT8Y9X3DAMcUnyTvIMPM6ZWUhAYXO+xrw
 4febR84wXNTeucuQNQ+cTFKoZIpyPlxcFvndntDUGPTUrIYNheFHCI9/+A2ItN8ciVBucu4MTXexF
 8XdtvftLLkGSkWAXfzjcqI+bH7brqIPKNp9gZ2FkjS8r0tm5CBwGQwbdrbfcK/GycTnxSETvo/shj
 AiSHyV1kSbqsHvRKE6h04Nt6/Q5Xtxba6qE41uLgPwowF6o7Hy1YKZW371bc5E8RQ19f2oJv82QcE
 0IkAD+KmTkiECrlbicRQ==;
Received: from [167.98.27.226] (helo=rainbowdash)
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1wbye2-00Fv8X-Q9; Tue, 23 Jun 2026 11:46:19 +0100
Received: from ben by rainbowdash with local (Exim 4.99.4)
 (envelope-from <ben@rainbowdash>) id 1wbye2-00000003Dry-1fM8;
 Tue, 23 Jun 2026 11:46:18 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] drm/panfrost: include panfrost_drv.h for
 panfrost_transparent_hugepage
Date: Tue, 23 Jun 2026 11:46:17 +0100
Message-Id: <20260623104617.768289-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
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

The panfrost_transparent_hugepage variable is declared in panfrost_drv.h
but the panfrost_drv.c does not incldue this header. Fix the following
sparse warning by including panfrost_drv.h :

drivers/gpu/drm/panfrost/panfrost_drv.c:958:6: warning: symbol 'panfrost_transparent_hugepage' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 784e36d72c2b..36cc2e67a308 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -21,6 +21,7 @@
 #include <drm/drm_utils.h>
 
 #include "panfrost_device.h"
+#include "panfrost_drv.h"
 #include "panfrost_gem.h"
 #include "panfrost_mmu.h"
 #include "panfrost_job.h"
-- 
2.37.2.352.g3c44437643

