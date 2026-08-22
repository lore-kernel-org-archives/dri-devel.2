Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F3FC5B572
	for <dri-devel@archiver.kernel.org>; Sat, 22 Aug 2026 09:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64EB510E3DA;
	Sat, 22 Aug 2026 09:48:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="Rj38kdt3";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB07410E3DA
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 09:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1787392086; x=1787996886; i=deller@gmx.de;
 bh=jigFtLfgCxxaL+7pPpX8YIoMFDu6GdJ7zexO2+HZIW4=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Rj38kdt3AIDE0GVFWy8BQVwKzvozG6AOr2WwgPNQZlq+9flU2JjQdb5WzOkWFcQN
 QKEYCM1kdX4lm0vCB+XSm798e/KfLdne4oqYA4gde4GvdzG86o1zN4vC107GDr0J3
 VGsNTUinxwCcb4qwU4r611f8m45DieHFQZUJfvNat5Afh9OHi0Oj37zniPx3OFMWj
 3Puo3ttEUufkpuZ6/x7bKPJA6fEjPPbzDU5ZF2nF0ngefDlFhPAh/KR7JChhSZDc0
 IgSIc2/t6cKCZViW5RrGomzIhO4uNwsvHN9dxAVdHuo5pOSR3v/DSxSkWvUfFZiE+
 v0g5fSo+SoUWLsgxew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1fn0-1wml4A2hgW-00s79C; Sat, 22
 Aug 2026 11:48:06 +0200
From: Helge Deller <deller@gmx.de>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: kernel test robot <lkp@intel.com>
Subject: [PATCH] fbdev: omapfb: Fix __be32 sparse warning in panel_enabled()
Date: Sat, 22 Aug 2026 11:48:05 +0200
Message-ID: <20260822094805.421002-1-deller@gmx.de>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tKdUT2X+nSw31k5q8xHf/QMjA5gGm6Z1KifSygP/arSOOtgTrIJ
 9VgylpZgzDa/t5YW23aBeLBCzS4QkKv98aX99VKBhFlGqZoT9rgjgHagVbnaDsHXoLGWr+B
 cOu6LuESdjVtR4+jG88LbCYuSsx2DyWKKibLMgM++FDjAWGnbnnGOu5abAD8LQhAVFYpnh2
 iH9XTTYWJr0f5gb9/+uDQ==
UI-OutboundReport: notjunk:1;M01:P0:scTP5kwn8k0=;W02Hf9JiC1y7EgZxLwdhr86SiLZ
 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
 1wZrpIr4YOlu6QzQN0+XgaCQDWJMnDit
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

Fix a sparse warning:
../omapfb/displays/panel-sony-acx565akm.c:218:23: sparse: sparse: cast to =
restricted __be32

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202608211811.lps93xao-lkp@in=
tel.com/
=2D--
 .../video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565ak=
m.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
index 8f430d9e8054..0202ca8cbfc2 100644
=2D-- a/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
@@ -210,12 +210,13 @@ static void set_display_state(struct panel_drv_data =
*ddata, int enabled)
=20
 static int panel_enabled(struct panel_drv_data *ddata)
 {
+	__be32 disp_status_be;
 	u32 disp_status;
 	int enabled;
=20
 	acx565akm_read(ddata, MIPID_CMD_READ_DISP_STATUS,
-			(u8 *)&disp_status, 4);
-	disp_status =3D __be32_to_cpu(disp_status);
+			(u8 *)&disp_status_be, 4);
+	disp_status =3D __be32_to_cpu(disp_status_be);
 	enabled =3D (disp_status & (1 << 17)) && (disp_status & (1 << 10));
 	dev_dbg(&ddata->spi->dev,
 		"LCD panel %senabled by bootloader (status 0x%04x)\n",
=2D-=20
2.55.0

