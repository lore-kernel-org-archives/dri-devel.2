Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14962D58B17
	for <dri-devel@archiver.kernel.org>; Sun, 15 Mar 2026 11:21:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D17A810E033;
	Sun, 15 Mar 2026 11:21:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=jumpstation.co.uk header.i=rob.github@jumpstation.co.uk header.b="H2jHEy7Q";
	dkim-atps=neutral
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73ECF10E478
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 20:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jumpstation.co.uk;
 s=s1-ionos; t=1773434197; x=1774038997;
 i=rob.github@jumpstation.co.uk;
 bh=yNeguXK/hCzjev/CuFv757Q16f+SKWneTOqzXdVeLgQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=H2jHEy7QTlxZpsHz2QGbFL8D81/fISi/3igPyBC96/8dc/TMFfGEqaLYOXqpMAt5
 IcxRSuXpEYuR59Q/nl9Kt22sSM5TEpKFhl34uFWF/hrr/I3NCWbcp85PzsodQBGd/
 q33148U85yyisOGzkap1iSnX8jb3RTSNL+1S4dV+LwBDrztppy8Aqg2EyQkVHoSkA
 cCj1hOfK4yfkO86KZuakn2aZ7CVQNLnOCbnP/y/ivQEuy53wbWFlW3nXtqJcpo8i1
 Yydyq4cnDfj2DJOGCXkrxgveO5iZYh6cHojQyFBjZCJmQWhYRAurUMwb2BkUE1BHB
 KAArrVYLBcHUmaiZ7w==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue106
 [212.227.15.152]) with ESMTPSA (Nemesis) id 1MNLVU-1wH1P51lAw-00JnkN; Fri, 13
 Mar 2026 21:36:37 +0100
Date: Fri, 13 Mar 2026 20:35:42 +0000
From: robgithub <rob.github@jumpstation.co.uk>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: robgithub <rob.github@jumpstation.co.uk>, Helge Deller <deller@gmx.de>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org,
 Prasanna Kumar T S M <ptsm@linux.microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>, Sukrut
 Heroorkar <hsukrut3@gmail.com>, Mukesh Rathor
 <mrathor@linux.microsoft.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: fbdev: update outdated help text for CONFIG_FB_NVIDIA
Message-ID: <20260313203443.7cf0a8f5@hexa5>
In-Reply-To: <034989df-cf86-4136-8522-6c48e5523645@infradead.org>
References: <20260312205507.70b9013b@hexa5>
 <034989df-cf86-4136-8522-6c48e5523645@infradead.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XUz8T25alQmrBIZdGDY40dw8GomJi3pVKhxc8LFmGxmNVDAs73v
 AtUD3OoNdc0+tA+L5MB7lyIf34i8B0kbl4YAP9UoP1V1419adWiNZeeowUyVFw13Lu7OXGY
 hbKQQHzR3ew/ioudmoGET3FRpAK1UCJZbYGn9btXqamEDZcW/qRy1z3sdPPTq1YbtLf8xaw
 GwC4bnWyE4ViGNXkm3c5w==
UI-OutboundReport: notjunk:1;M01:P0:o9HaNVhN59s=;lFAdKnjzIHgSBgW4MLd1hCngF8m
 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
X-Mailman-Approved-At: Sun, 15 Mar 2026 11:20:58 +0000
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
+	  Supports NVIDIA GPUs from TNT through early GeForce generations
+	  (NV4=E2=80=93NV2x: Twintor, Twintor2, Celsius, Kelvin).
+	  Later architectures (Rankine and newer) are not reliably supported.
+	  If unsure, say N.
=20
 	  To compile this driver as a module, choose M here: the
 	  module will be called nvidiafb.
--=20
2.52.0



Thanks, this my first time submitting a patch.

I have fixed the invisible whitespace inconsistency, wonder why I missed th=
at :)

I really wanted to stop future users reading the "and newer" and enabling i=
t on an unsupported card. It stopped my kernel booting with no errors.

The references I used to confirm the Nvidia devices affected are

List of devices documented in the code between lines 1228-1277
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drive=
rs/video/fbdev/nvidia/nvidia.c?h=3Dv6.19.6

with more human readable extraction available at
https://cateee.net/lkddb/web-lkddb/FB_NVIDIA.html

and the code names for all Nvidia cards are here
https://nouveau.freedesktop.org/CodeNames.html

Regards

Rob

On Thu, 12 Mar 2026 14:02:18 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Hi,
>=20
> On 3/12/26 1:55 PM, robgithub wrote:
> > The help text for CONFIG_FB_NVIDIA refers to obsolete hardware and
> > incorrect default behaviour. This patch updates the description to
> > reflect the current state of the driver and supported devices.
> >=20
> > Signed-off-by: robgithub <rob.github@jumpstation.co.uk>
>=20
> Inline patches are preferred over attachments.
>=20
> I thought that Claws mail could send inline patches successfully. (?)
>=20
> Documentation/process/email-clients.rst says that it works (after a little
> configuration setting).
>=20
> I don't know anything about which products are supported, so I have no
> comment on that.
>=20
> In the patch, the indentation is incorrect. Kconfig help text should be
> indented with one tab + 2 spaces, not with 4 spaces.
>=20
> thanks.

