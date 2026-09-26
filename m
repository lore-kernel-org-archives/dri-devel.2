Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D31C98328
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 06:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3F3610E01F;
	Sat, 26 Sep 2026 06:21:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="OBX52Ti7";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E274310E01F
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 06:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1790403698; x=1791008498; i=deller@gmx.de;
 bh=7ZTkKTvdC1gjjipMWpb97SPsj8DfOBt64OjJY18vt94=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=OBX52Ti7t3g0l/xlIhR9jGwMMeux5FjALE2OjVUnmpVPd86dT6KEmNP4hmZoO/BT
 +Bqlim+7XxDQrp3CLy9PeQzl+f2NmBxOeupjUu2nxdTbemJCWOg/f/uvDp4TOPBQI
 3AkTSFLbTVwIL9U0cOPeX0wpfjfYuYlWuBSljVnD2lu2D7l2AUE+tm6xog0PmyUBR
 77b1ERLeBlRxoCmF5mqpepTTi4tNLfDHyKhX8XoPjh/tMfTYpJVcFJV1EuGNguDtT
 qaqcI4OxCfn/NQttKOcTI8jimzSETSKnivmesUqUrzYJIEubVYTUcMj84O+Zsbx/B
 CGFVvsU7vDnxO4vwBQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCKBc-1x0y7U0B3y-00Alpn; Sat, 26
 Sep 2026 08:21:38 +0200
From: Helge Deller <deller@gmx.de>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: kernel test robot <lkp@intel.com>, Miro Kropacek <miro.kropacek@gmail.com>
Subject: [PATCH] fbdev: atafb: fix sparse warnings
Date: Sat, 26 Sep 2026 08:20:08 +0200
Message-ID: <20260926062136.162108-1-deller@gmx.de>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WkERM5rc0elLackmbo06OWyyRnDv0O4Qumd1yVtU26dDy2iPiI/
 0kKxxQ5xsSVjUFIvf3tD8egFu3YFnkcwQMJP9ZgRuMYvI+p0XBQoxPg+NY8vOTlvtuh3gKn
 ZFWwwxBKHnBurqrqWEn52iDvs9NMYwOjBYU56eHtFB20we4Mz+214otgohId49rq8FQvaWy
 1A0SSZzSaxdn3re3zyGGg==
UI-OutboundReport: notjunk:1;M01:P0:9f6Eyb3X7lg=;B+XjY7Gh/xbDSFe4B8TaeOcEax7
 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
 usOP
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

Fix two sparse warnings:
- atafb.c:1092: sparse: Using plain integer as NULL pointer

Use NULL instead of 0 when assigning a pointer.

- atafb.c:2824: sparse: switch with no cases

FBCMD_GET_CURRENTPAR and and FBCMD_SET_CURRENTPAR seem to be
historic defines, which are not any longer in the kernel, and
as such the code isn't built any longer and may be dropped.

Fixes: d463633d63e6 ("fbdev: atafb: Add support for SuperVidel's SuperBlit=
ter")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202609261313.kgFtkz2t-lkp@in=
tel.com/
Cc: Miro Kropacek <miro.kropacek@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 drivers/video/fbdev/atafb.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index c3011b61a94b..5c3e5861543a 100644
=2D-- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -1089,7 +1089,7 @@ static int falcon_decode_var(struct fb_info *info, s=
truct fb_var_screeninfo *var
 			/* Choose largest pixelclock <=3D wanted clock */
 			int i;
 			unsigned long pcl =3D ULONG_MAX;
-			pclock =3D 0;
+			pclock =3D NULL;
 			for (i =3D 1; i <=3D 4; i *=3D 2) {
 				if (f25.t * i >=3D var->pixclock &&
 				    f25.t * i < pcl) {
@@ -2818,29 +2818,6 @@ static void atafb_imageblit(struct fb_info *info, c=
onst struct fb_image *image)
 	}
 }
=20
-static int
-atafb_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
-{
-	switch (cmd) {
-#ifdef FBCMD_GET_CURRENTPAR
-	case FBCMD_GET_CURRENTPAR:
-		if (copy_to_user((void *)arg, &current_par,
-				 sizeof(struct atafb_par)))
-			return -EFAULT;
-		return 0;
-#endif
-#ifdef FBCMD_SET_CURRENTPAR
-	case FBCMD_SET_CURRENTPAR:
-		if (copy_from_user(&current_par, (void *)arg,
-				   sizeof(struct atafb_par)))
-			return -EFAULT;
-		ata_set_par(&current_par);
-		return 0;
-#endif
-	}
-	return -EINVAL;
-}
-
 /* (un)blank/poweroff
  * 0 =3D unblank
  * 1 =3D blank
@@ -2922,7 +2899,6 @@ static struct fb_ops atafb_ops =3D {
 	.fb_fillrect	=3D atafb_fillrect,
 	.fb_copyarea	=3D atafb_copyarea,
 	.fb_imageblit	=3D atafb_imageblit,
-	.fb_ioctl =3D	atafb_ioctl,
 	__FB_DEFAULT_IOMEM_OPS_MMAP,
 };
=20
=2D-=20
2.55.0

