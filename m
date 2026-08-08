Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45BDC5AD2C
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 08:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5D9110E008;
	Sat,  8 Aug 2026 08:36:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="deRp98zq";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2935D10E008
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 08:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1786178209; x=1786783009; i=deller@gmx.de;
 bh=P4tzviaFiVDrss1maZl/RhNlyenuKmb8eizSlmcmoug=;
 h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=deRp98zqXcniCitnlZsi0RoHLhLiatgC7uFXrWi2J5pMlZWVarRtrNl9qQ7h28U6
 5C1VWNiSO/+9hBj3RNTrsSo96gVc1x+tl/b1nbBX2cGoC/h7wS52eLcn/B/N9ftEI
 5uTe3+B1iyEWVPMhixcqsigHWgScBWUrqZmZ/GxLMdOLtD60OZihdZIbrm67i4NZr
 e0R1lTy93it2FjmvDNxNo2YjLL/TwUWrkrA1N/M0fcrDEaDKRXm5YnbnEm79IIw6W
 1Lk1crhqvPbjTamFoDTZ9JeTA4B8ad6o7QOv6/P6vUJ2RnllrIB+kGBgBnkVQDYxC
 w0wQ8n7qlXZtQ2zKxQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvsEx-1x8dpW1qfH-016z52; Sat, 08
 Aug 2026 10:36:49 +0200
From: Helge Deller <deller@gmx.de>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] fbdev: mb862xxfb: Silence possibly unused functions
Date: Sat,  8 Aug 2026 10:36:48 +0200
Message-ID: <20260808083648.257464-1-deller@gmx.de>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5Y4Ml/w3Xu1q4YvkyrB90TBl1ImzdXTQHVU6q++358X1HexZUIP
 6w739XB2x8okcOWZ6N1vtX8YhkPY2dPkKCYnLHHeKIeasjbHFKYV3nuE6irOlVwTwJkgprq
 MYn+iXwE4f1geJigf6zzOLsmjVPVUp7gjwfU5VBhhYx6zTmNXYQkW1BfIpwJs9o21TmoX9M
 jM5IZB/tPwx4jKRJ0trkg==
UI-OutboundReport: notjunk:1;M01:P0:ApWbUjf4Fo8=;vSZQkwIsJacUyPCcrMj85X12Z5t
 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
 c6PoPgYBCu9lw5hrtftaBLc9chJg=
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

When CONFIG_PCI=3Dn, the kernel test robot reports that on powerpc some
functions and variables may possibly be unused. Silence those warnings.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202608081537.o23Goj8d-lkp@in=
tel.com/
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c b/drivers/video/fb=
dev/mb862xx/mb862xxfbdrv.c
index 676c6d3ccc12..99c404dbc832 100644
=2D-- a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
+++ b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
@@ -408,7 +408,7 @@ static struct fb_ops mb862xxfb_ops =3D {
 };
=20
 /* initialize fb_info data */
-static int mb862xxfb_init_fbinfo(struct fb_info *fbi)
+static int __maybe_unused mb862xxfb_init_fbinfo(struct fb_info *fbi)
 {
 	struct mb862xxfb_par *par =3D fbi->par;
 	struct mb862xx_gc_mode *mode =3D par->gc_mode;
@@ -568,9 +568,9 @@ static ssize_t dispregs_show(struct device *dev,
 	return ptr - buf;
 }
=20
-static DEVICE_ATTR_RO(dispregs);
+static DEVICE_ATTR_RO(dispregs) __maybe_unused;
=20
-static irqreturn_t mb862xx_intr(int irq, void *dev_id)
+static irqreturn_t __maybe_unused mb862xx_intr(int irq, void *dev_id)
 {
 	struct mb862xxfb_par *par =3D (struct mb862xxfb_par *) dev_id;
 	unsigned long reg_ist, mask;
=2D-=20
2.55.0

