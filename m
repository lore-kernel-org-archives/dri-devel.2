Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B9CC88E59
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 16:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F4C510E507;
	Sat, 12 Sep 2026 16:18:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="ePN7Fimd";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A517A10E507
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 16:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789229929; x=1789834729; i=deller@gmx.de;
 bh=w8WCMmDY+7GAv/wNrOjacgEcYg105SHAGfq0EmOK3Sk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ePN7FimdsK/Ja1ca3lKZex1hF5y3RTDOZA0KcXH0smoYnEN1WbGO6h0b6rovuKHd
 vwmUi2OGIs8fzEA4XnIBjP2KD17Idyk+aMuWHuOrhb74fHb/MDoCy/L9AZIBBAYV3
 +8kUFZEz/wx6AMS78NRV4g0ewPop8QJmhPl0w9brYlzDJweP+j7xGFTPn3g2JPZCo
 JpYejN90PkDkud4KtHC9TgCf2Q9Ln8LVZz8JH0OifBp3Jjej481Til8Nm2x9l/d3u
 pVZWhQujUk9N6DFJCUkHv7rV/aiCIlKiEW4M7bxS6qGn+SLSMVpHjY7eSetAgsLwi
 w/CRKDdKZLlF0wS4pQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6UZl-1xBits0Thx-00DSQ4; Sat, 12
 Sep 2026 18:18:49 +0200
From: Helge Deller <deller@gmx.de>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [PATCH] fbdev: Drop unused FB_IOMEM_HELPERS_DEFERRED Kconfig option
Date: Sat, 12 Sep 2026 18:18:44 +0200
Message-ID: <20260912161848.968501-1-deller@gmx.de>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QHg+7Iow+YCJV3oHSXtGJWLP8FDERvGsBjP8rgia0t02TfEGaHP
 zRRDFdYgw/qwtuizXyXIY/FB2DKovKWRkVhngJChwpCTwDCFs0HeJkRz63YmWpqRw3GpJ5B
 pX+djzXToFMwDKU7vfhnS2uoBrEDYxEQlukxyxbWVJETUUGbziA54t4PakUECCg76BdUofB
 4irFt7k66PFATnEv3+bIA==
UI-OutboundReport: notjunk:1;M01:P0:4+0GlE/W214=;R0hTWFtT8fzhPx2YPd5gdJJkq/g
 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
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

Signed-off-by: Helge Deller <deller@gmx.de>
Noticed-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
=2D--
 drivers/video/fbdev/core/Kconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/video/fbdev/core/Kconfig b/drivers/video/fbdev/core/K=
config
index 8d1993e0b591..14860a1ae6bc 100644
=2D-- a/drivers/video/fbdev/core/Kconfig
+++ b/drivers/video/fbdev/core/Kconfig
@@ -155,12 +155,6 @@ config FB_IOMEM_HELPERS
 	select FB_CFB_IMAGEBLIT
 	select FB_IOMEM_FOPS
=20
-config FB_IOMEM_HELPERS_DEFERRED
-	bool
-	depends on FB_CORE
-	select FB_DEFERRED_IO
-	select FB_IOMEM_HELPERS
-
 config FB_SYSMEM_HELPERS
 	bool
 	depends on FB_CORE
=2D-=20
2.55.0

