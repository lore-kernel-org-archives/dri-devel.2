Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A6DFF8863
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 06:47:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2C5D10E50F;
	Sun, 26 Apr 2026 06:47:14 +0000 (UTC)
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Sat, 25 Apr 2026 07:04:40 UTC
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D955510E0D6
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 07:04:40 +0000 (UTC)
X-UUID: 5018db82407411f1aa26b74ffac11d73-20260425
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:796fe8ce-2424-43df-837a-5824a8ff87b6, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:69e31420f7444c0bcb2c92291f08c449,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|898,TC:nil,Content:0|15|50,EDM:-3,IP
 :nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
 LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5018db82407411f1aa26b74ffac11d73-20260425
X-User: aichao@kylinos.cn
Received: from thinksys.. [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <aichao@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1869557384; Sat, 25 Apr 2026 14:59:32 +0800
From: Ai Chao <aichao@kylinos.cn>
To: deller@gmx.de, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, linux@armlinux.org.uk, dilinger@queued.net,
 adaplas@gmail.com, James.Bottomley@HansenPartnership.com,
 FlorianSchandinat@gmx.de, alchark@gmail.com, krzk@kernel.org,
 kees@kernel.org, rene@exactco.de, tzimmermann@suse.de,
 rongqianfeng@vivo.com, thorsten.blum@linux.dev,
 chelsyratnawat2001@gmail.com, soci@c64.rulez.org,
 gregkh@linuxfoundation.org, daniel@thingy.jp, linmq006@gmail.com,
 fourier.thomas@gmail.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-geode@lists.infradead.org, linux-parisc@vger.kernel.org,
 Ai Chao <aichao@kylinos.cn>
Subject: [PATCH 00/35] Use safer strscpy() instead of strcpy()
Date: Sat, 25 Apr 2026 14:58:51 +0800
Message-Id: <20260425065926.1091168-1-aichao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 26 Apr 2026 06:46:56 +0000
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

This patch series introduces wrapper functions strscpy().

Use a safer function strscpy() instead of strcpy() for copying to arrays.

Only idiomatic code replacement, and no functional changes.

Summary:

  fbdev: matroxfb: Use safer strscpy() instead of strcpy()
  fbdev: i810: Use safer strscpy() instead of strcpy()
  fbdev: sisfb: Use safer strscpy() instead of strcpy()
  fbdev: geode: Use safer strscpy() instead of strcpy()
  fbdev: atafb: Use safer strscpy() instead of strcpy()
  fbdev: tdfxfb: Use safer strscpy() instead of strcpy()
  fbdev: pm2fb: Use safer strscpy() instead of strcpy()
  fbdev: xen-fbfront: Use safer strscpy() instead of strcpy()
  fbdev: controlfb: Use safer strscpy() instead of strcpy()
  fbdev: stifb: Use safer strscpy() instead of strcpy()
  fbdev: fm2fb: Use safer strscpy() instead of strcpy()
  fbdev: arkfb: Use safer strscpy() instead of strcpy()
  fbdev: vt8500lcdfb: Use safer strscpy() instead of strcpy()
  fbdev: vt8623fb: Use safer strscpy() instead of strcpy()
  fbdev: gbefb: Use safer strscpy() instead of strcpy()
  fbdev: wm8505fb: Use safer strscpy() instead of strcpy()
  fbdev: rivafb: Use safer strscpy() instead of strcpy()
  fbdev: sh7760fb: Use safer strscpy() instead of strcpy()
  fbdev: savage: Use safer strscpy() instead of strcpy()
  fbdev: atmel_lcdfb: Use safer strscpy() instead of strcpy()
  fbdev: aty128fb: Use safer strscpy() instead of strcpy()
  fbdev: amifb: Use safer strscpy() instead of strcpy()
  fbdev: s3fb: Use safer strscpy() instead of strcpy()
  fbdev: viafb: Use safer strscpy() instead of strcpy()
  fbdev: platinumfb: Use safer strscpy() instead of strcpy()
  fbdev: cyber2000fb: Use safer strscpy() instead of strcpy()
  fbdev: mb862xxfb: Use safer strscpy() instead of strcpy()
  fbdev: mmpfb: Use safer strscpy() instead of strcpy()
  fbdev: ep93xx-fb: Use safer strscpy() instead of strcpy()
  fbdev: valkyriefb: Use safer strscpy() instead of strcpy()
  fbdev: pxafb: Use safer strscpy() instead of strcpy()
  fbdev: sa1100fb: Use safer strscpy() instead of strcpy()
  fbdev: sm501fb: Use safer strscpy() instead of strcpy()
  fbdev: acornfb: Use safer strscpy() instead of strcpy()
  fbdev: ocfb: Use safer strscpy() instead of strcpy()

 drivers/video/fbdev/acornfb.c               |  2 +-
 drivers/video/fbdev/amifb.c                 |  2 +-
 drivers/video/fbdev/arkfb.c                 |  2 +-
 drivers/video/fbdev/atafb.c                 | 10 +++++-----
 drivers/video/fbdev/atmel_lcdfb.c           |  2 +-
 drivers/video/fbdev/aty/aty128fb.c          |  2 +-
 drivers/video/fbdev/controlfb.c             |  2 +-
 drivers/video/fbdev/cyber2000fb.c           |  2 +-
 drivers/video/fbdev/ep93xx-fb.c             |  2 +-
 drivers/video/fbdev/fm2fb.c                 |  2 +-
 drivers/video/fbdev/gbefb.c                 |  2 +-
 drivers/video/fbdev/geode/gx1fb_core.c      |  2 +-
 drivers/video/fbdev/geode/gxfb_core.c       |  2 +-
 drivers/video/fbdev/geode/lxfb_core.c       |  2 +-
 drivers/video/fbdev/i810/i810-i2c.c         |  2 +-
 drivers/video/fbdev/i810/i810_main.c        |  2 +-
 drivers/video/fbdev/matrox/matroxfb_base.c  |  6 +++---
 drivers/video/fbdev/matrox/matroxfb_crtc2.c |  2 +-
 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c  |  2 +-
 drivers/video/fbdev/mmp/fb/mmpfb.c          |  2 +-
 drivers/video/fbdev/ocfb.c                  |  2 +-
 drivers/video/fbdev/platinumfb.c            |  2 +-
 drivers/video/fbdev/pm2fb.c                 |  6 +++---
 drivers/video/fbdev/pxafb.c                 |  2 +-
 drivers/video/fbdev/riva/rivafb-i2c.c       |  2 +-
 drivers/video/fbdev/s3fb.c                  |  2 +-
 drivers/video/fbdev/sa1100fb.c              |  2 +-
 drivers/video/fbdev/savage/savagefb-i2c.c   |  2 +-
 drivers/video/fbdev/sh7760fb.c              |  2 +-
 drivers/video/fbdev/sis/sis_main.c          | 16 ++++++++--------
 drivers/video/fbdev/sm501fb.c               |  2 +-
 drivers/video/fbdev/stifb.c                 |  2 +-
 drivers/video/fbdev/tdfxfb.c                |  6 +++---
 drivers/video/fbdev/valkyriefb.c            |  2 +-
 drivers/video/fbdev/via/viafbdev.c          |  2 +-
 drivers/video/fbdev/vt8500lcdfb.c           |  2 +-
 drivers/video/fbdev/vt8623fb.c              |  2 +-
 drivers/video/fbdev/wm8505fb.c              |  2 +-
 drivers/video/fbdev/xen-fbfront.c           |  2 +-
 39 files changed, 56 insertions(+), 56 deletions(-)

-- 
2.34.1

