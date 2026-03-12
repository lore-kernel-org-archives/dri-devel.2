Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C84106FD9B
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7FDA10EB22;
	Fri, 13 Mar 2026 08:25:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=jumpstation.co.uk header.i=rob.github@jumpstation.co.uk header.b="sZny4rMa";
	dkim-atps=neutral
X-Greylist: delayed 874 seconds by postgrey-1.36 at gabe;
 Thu, 12 Mar 2026 21:10:16 UTC
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 894AB10E215
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 21:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jumpstation.co.uk;
 s=s1-ionos; t=1773349815; x=1773954615;
 i=rob.github@jumpstation.co.uk;
 bh=V9Jz4M+Z9QN56aIB3snMb32hgRyUtBNNksRT8e1ZYxQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:
 MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=sZny4rMag7ckz44JYvFv4SDZH7lR9KhVR736C1AmoFG682y2TqZZMv+aRnxKnJsg
 NjWoyag9E339b3ccpjSNL+tUb7guw8SAeM4X2Je7zU8gayY51z9/nx7IchUOHo5Yl
 RcntJfebE+kwE3brkso03jv78a6Yz8DTRN8ptWzFAPj1xScR4nWq8shQ5DfhN6vz+
 5R2qNr2J57XmW2GydArdwT6RS627wAmmD73g/iIc9dqzFx3bgkHZOesxYv8jgXjNB
 KvN1sd3ruepHYr979OJ21m4c6nq9crCk0WVFUavKSruBBNWD9iddfLOWph8bxG+RI
 z4IYOyboi11J8L77hA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue109
 [212.227.15.153]) with ESMTPSA (Nemesis) id 1MYvTy-1w5F2h3Aky-00YwXR; Thu, 12
 Mar 2026 21:55:39 +0100
Date: Thu, 12 Mar 2026 20:55:07 +0000
From: robgithub <rob.github@jumpstation.co.uk>
To: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-fbdev@vger.kernel.org
Cc: robgithub <rob.github@jumpstation.co.uk>, Prasanna Kumar T S M
 <ptsm@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>, Michael Kelley
 <mhklinux@outlook.com>, Sukrut Heroorkar <hsukrut3@gmail.com>, Randy Dunlap
 <rdunlap@infradead.org>, Mukesh Rathor <mrathor@linux.microsoft.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: fbdev: update outdated help text for CONFIG_FB_NVIDIA
Message-ID: <20260312205507.70b9013b@hexa5>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/yGBOsdgxZKPDmDkoTfe./G4"
X-Provags-ID: V03:K1:m4dxKb2C/lhZ6yoYeupD2qV4gdJy+SHNHiOBkdjEWEM+AXGZQdf
 Dd+MLdHQ8sIBriWhNWbrrNvgibU7MqoW81ArvXzay0of27YKPh5qQ1KYlShh3QE0fSWcmpb
 Oguyfcr/kzc9VmB3ec4eF2R9iSvnrikB+Q0Ja6lEDXgP/rFNPXYRyIEdyfck4nKGsfxhwOU
 atvldWUXkwgLWf4+YXY+w==
UI-OutboundReport: notjunk:1;M01:P0:TCDb2iEfj9k=;XXTKWmjREQN1MACwTufqj+7jSp3
 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
 CYPaWuuQnQ2/UVqmC7sEhy6YTT7VM=
X-Mailman-Approved-At: Fri, 13 Mar 2026 08:25:02 +0000
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

--MP_/yGBOsdgxZKPDmDkoTfe./G4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The help text for CONFIG_FB_NVIDIA refers to obsolete hardware and
incorrect default behaviour. This patch updates the description to
reflect the current state of the driver and supported devices.

Signed-off-by: robgithub <rob.github@jumpstation.co.uk>

--MP_/yGBOsdgxZKPDmDkoTfe./G4
Content-Type: text/x-patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename=0001-fbdev-update-outdated-help-text-for-CONFIG_FB_NVIDIA.patch

=46rom 688a061ba0db71fc2d5facd8344db7a4d5b1575a Mon Sep 17 00:00:00 2001
From: robgithub <rob.github@jumpstation.co.uk>
Date: Wed, 11 Mar 2026 22:14:43 +0000
Subject: [PATCH] fbdev: update outdated help text for CONFIG_FB_NVIDIA

The help text for CONFIG_FB_NVIDIA refers to obsolete hardware and
incorrect default behaviour. This patch updates the description to
reflect the current state of the driver and supported devices.

Signed-off-by: robgithub <rob.github@jumpstation.co.uk>
---
 drivers/video/fbdev/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index ac9ac4287c6a..d8e331427443 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -668,10 +668,10 @@ config FB_NVIDIA
 	select BITREVERSE
 	select VGASTATE
 	help
-	  This driver supports graphics boards with the nVidia chips, TNT
-	  and newer. For very old chipsets, such as the RIVA128, then use
-	  the rivafb.
-	  Say Y if you have such a graphics board.
+    Supports NVIDIA GPUs from TNT through early GeForce generations
+    (NV4=E2=80=93NV2x: Twintor, Twintor2, Celsius, Kelvin).
+    Later architectures (Rankine and newer) are not reliably supported.
+    If unsure, say N.
=20
 	  To compile this driver as a module, choose M here: the
 	  module will be called nvidiafb.
--=20
2.52.0


--MP_/yGBOsdgxZKPDmDkoTfe./G4--
