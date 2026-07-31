Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A984C5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF9F210E194;
	Fri, 31 Jul 2026 07:25:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="toFAKU3u";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CC0C10E194
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 07:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1785482748; x=1786087548; i=deller@gmx.de;
 bh=Sh1l7FehpbIgdU4cPfAsbsDMvNMrQAUuXIkztScFUiY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=toFAKU3uky3ZpwYTL9xbBgAHjRLDsjRpoEvIG1Q2xFohaa9GeF4fJhrJUYAJbXSW
 g+Epz+3WPOwys8RWkIX/0jbyPMN99wdJMo/CquJpNamkcl4S/LNwwqRLsmzTos77g
 B04GTibol/gJAuxvxvvV8z3uiNG8o+/zCs8x90oCxhm9zqrMEo2kBwp8BOXKU1j+B
 Bu/yCOruEWNm0Os54PQyRCEm9dpT66TUq2FB9wtSdciFI7dNxHGjGodg4xrhnPSGC
 47dC6In6QDdiIqxSE+14nahBnbUtKnBRw/0mAUIivjep+tjjzYxZdUOzB/JQQmvlr
 ENvXBsgERvZeCcP7FA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqJm5-1xLVzb2yWJ-00gkma; Fri, 31
 Jul 2026 09:25:48 +0200
Message-ID: <6bbf7e18-92b9-4d18-beb0-0c9812fc7ba8@gmx.de>
Date: Fri, 31 Jul 2026 09:25:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] fbdev: tdfxfb: Make "unbooted" cards work
To: Daniel Palmer <daniel@0x0f.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260730182640.2808572-1-daniel@0x0f.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260730182640.2808572-1-daniel@0x0f.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XVstF37HDHfFv0NBIL+raCPXt5amd+E2V6+Envi+vwo0MB/17TZ
 zaqTLutjPYNt6OJl0xyTXjv2Nl85kWrUc8ADD4KQKz0s8wSDZdI+tfruxOjGSQOIdzXZ0CD
 8np7eKuLaH5UJkCwbSoJLUAuDEFe2eci74maWUQ6ZYwjVlcXFHTuSKqJF52lVi0Qvlzk6br
 aqWuq0hYPk/HlO8gvH/2A==
UI-OutboundReport: notjunk:1;M01:P0:iMO3mIb0xpE=;tIDAQP3MNjUQfVY02F3Os2AtqUH
 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
 =
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

On 7/30/26 20:26, Daniel Palmer wrote:
> Currently using voodoo cards that weren't booted by the video
> BIOS aren't usable.
>=20
> This means if you happen to have a proper - non-x86 - computer,
> another card is the primary or you have a new BIOS that cannot
> run the video BIOS tdfxfb would probe but you be staring at
> "no signal detected".
>=20
> This series implements manually booting cards using the
> values from the video BIOS' own table.
>=20
> Debugging was partially assisted by Claude Fable 5. I could not
> work out why this would not work for months so I told it to
> create a voodoo 3 emulation for QEMU to compare the BIOS against
> my code. That made it obvious my init sequence matched the BIOS
> but the VGA core wasn't running.
>=20
> This has been tested on a real voodoo 3 in an x86-64 board.
> I have some patches to add an interface for doing 3D rendering
> that are not included in this series and 3D rendering is also
> working so as far as I can tell everything is good.

Nice work!

Series applied to fbdev git tree.

Thanks for doing this!
Helge

 =20
> Daniel Palmer (5):
>    fbdev: tdfxfb: Add helper to read config table from BIOS
>    fbdev: tdfxfb: Attempt to detect if the card wasn't booted
>    fbdev: tdfxfb: Manually boot unbooted cards
>    fbdev: tdfxfb: Wake the VGA core before programming the CRTC
>    fbdev: tdfxfb: Program the initial video mode
>=20
>   drivers/video/fbdev/tdfxfb.c | 151 +++++++++++++++++++++++++++++++++++
>   1 file changed, 151 insertions(+)
>=20

