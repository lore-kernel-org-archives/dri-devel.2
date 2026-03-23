Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFB5F532FF
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9708B10E639;
	Tue, 24 Mar 2026 09:12:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=cyberprotect.ru header.i=@cyberprotect.ru header.b="XysKIAOS";
	dkim=permerror (0-bit key) header.d=cyberprotect.ru header.i=@cyberprotect.ru header.b="hwnjyxiz";
	dkim-atps=neutral
X-Greylist: delayed 2045 seconds by postgrey-1.36 at gabe;
 Mon, 23 Mar 2026 11:03:54 UTC
Received: from mx2.cyberprotect.ru (mx2.cyberprotect.ru [176.10.93.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E01610E2BD
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 11:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cyberprotect.ru; s=dkim-r; h=MIME-Version:Date:From:Sender:Reply-To;
 bh=QcbI5Xku4fL4lXhZomurIoI8W7kAjTeXntNYDbnIz3I=; b=XysKIAOSOYPk5gW7S0b71zF9Li
 UByknk+MwzDidsKgKUgVxA3JtDO2fBHf/1uEvLnICjA6i+ifY9MlU47AXbt9oA9PLV8L77YaEcL3/
 cLGx5mdMwM1HN3MmdsZfOrE/BfGXAGqtAp5QCdYe7pK0YCQmb6otNSrIIymWyfiLoWgT0JxgTe/C4
 75fUKfYdE7M1uzLCLgU7fUlGu4mZUV66LXvMZ944bNowQnrFt7wwsKM1Yrsq17INlQ/2OiFiF81pX
 h3sGGKgdNoysm7Bwtl4z1fZy3HH5MK9lrhmAA7hCfkJavNHPnfOI45vAyA0a/Ns5krm0k/YrBvlyd
 H14MhkWA==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cyberprotect.ru; s=dkim; h=MIME-Version:Date:From:Sender:Reply-To;
 bh=QcbI5Xku4fL4lXhZomurIoI8W7kAjTeXntNYDbnIz3I=; b=hwnjyxiz9371raxn6PLZzNScaW
 AJSuZZfz5912EOXjePSXht8dny98iLOVnDqC4rg3XOt80OYc81DTJ0c6/2Cg==;
From: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
CC: Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Andrew Morton <akpm@osdl.org>,
 Andreas Oberritter <obi@linuxtv.org>, Johannes Stezenbach <js@linuxtv.org>,
 <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>,
 <lvc-project@linuxtesting.org>
Subject: [PATCH] media: pluto2: fix potential buffer overflow in
 pluto_dma_end()
Date: Mon, 23 Mar 2026 13:29:20 +0300
Message-ID: <20260323102920.19937-1-Dmitry.Chumachenko@cyberprotect.ru>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.0.30]
X-ClientProxiedBy: AIP-EXCH-1.aip.ooo (10.77.28.101) To AIP-EXCH-2.aip.ooo
 (10.77.28.102)
X-Mailman-Approved-At: Tue, 24 Mar 2026 09:12:22 +0000
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

The while loop in pluto_dma_end() scans the DMA buffer for MPEG-TS sync 
bytes (0x47) at 188-byte intervals. However, it does not check the buffer 
boundary. If the buffer contains 0x47 at every 188-byte offset, the loop 
index will exceed the buffer size, causing an out-of-bounds read.

Add a check to ensure the index stays within TS_DMA_BYTES.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c7cadb3a02b5 ("[PATCH] dvb: add Pluto2 driver")
Signed-off-by: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
---
 drivers/media/pci/pluto2/pluto2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/pluto2/pluto2.c b/drivers/media/pci/pluto2/pluto2.c
index 6ac9b9bd7435..fd7f8d8b85a8 100644
--- a/drivers/media/pci/pluto2/pluto2.c
+++ b/drivers/media/pci/pluto2/pluto2.c
@@ -291,7 +291,7 @@ static void pluto_dma_end(struct pluto *pluto, unsigned int nbpackets)
 	 */
 	if ((nbpackets == 0) || (nbpackets > TS_DMA_PACKETS)) {
 		unsigned int i = 0;
-		while (pluto->dma_buf[i] == 0x47)
+		while (i < TS_DMA_BYTES && pluto->dma_buf[i] == 0x47)
 			i += 188;
 		nbpackets = i / 188;
 		if (i == 0) {
-- 
2.49.0

