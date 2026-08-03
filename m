Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6321FC5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F51010E655;
	Tue,  4 Aug 2026 07:15:12 +0000 (UTC)
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de
 [185.203.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 489A310E42B
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 12:39:33 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de
 (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
 (Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
 by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3B4DC20077D;
 Mon, 03 Aug 2026 14:39:31 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <u.oelmann@pengutronix.de>) id 1wqrx5-002hRS-0U;
 Mon, 03 Aug 2026 14:39:31 +0200
Received: from uol by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
 (envelope-from <u.oelmann@pengutronix.de>)
 id 1wqrx5-00000007p19-08Ll; Mon, 03 Aug 2026 14:39:31 +0200
From: =?utf-8?Q?Ulrich_=C3=96lmann?= <u.oelmann@pengutronix.de>
To: Max Pedraza <maximpedraza@gmail.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,  Rob
 Herring <robh@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,
 kernel@pengutronix.de,  devicetree@vger.kernel.org,  Helge Deller
 <deller@gmx.de>,  linux-fbdev@vger.kernel.org,  Maxime Ripard
 <mripard@kernel.org>,  linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,  Thomas Zimmermann
 <tzimmermann@suse.de>,  Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
In-Reply-To: <am2mvECnCcO9IxuI@monoceros> ("Uwe =?utf-8?Q?Kleine-K=C3=B6ni?=
 =?utf-8?Q?g=22's?= message of "Sat, 1 Aug 2026 10:08:00 +0200")
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros>
User-Agent: mu4e 1.12.15; emacs 30.2
Date: Mon, 03 Aug 2026 14:39:30 +0200
Message-ID: <6rbjbj74zh.fsf@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 04 Aug 2026 07:15:10 +0000
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

Hi M=C3=A0xim,

On Sat, Aug 01 2026 at 10:08 +0200, Uwe Kleine-K=C3=B6nig <u.kleine-koenig@=
baylibre.com> wrote:
> Hello Max,
>
> On Fri, Jul 31, 2026 at 11:50:37PM +0200, Max Pedraza wrote:
>> Embedded products routinely need their own boot logo. Today the only way=
 to
>> get one is to replace one of the logo_*_clut224.ppm files in the kernel
>> source tree, which bakes the image into the kernel image. Two products t=
hat
>> share a board support package but differ in branding therefore need two
>> kernel builds, and rebranding an existing product means rebuilding and
>> requalifying a kernel for what is purely a cosmetic change.
>>
>> This series lets the logo be described by the device tree instead: a node
>> compatible with "linux,boot-logo-clut224" supplies the image in the same
>> paletted format the built-in CLUT224 logos already use, and the kernel
>> prefers it over the built-in ones when it is present and enabled. If the
>> node is absent or disabled, nothing changes.
>>
>> The image can come from the node itself (patches 1-2) [...]

independently of the specific implementation, please keep in mind that
the kernel is distributed under the GPLv2, which may have implications
for a proprietary image embedded in the device tree. That doesn't
necessarily have to be a deal-breaker, but it's probably something that
should be considered carefully.

Best regards,
Ulrich


>> [...] or from a reserved
>> memory region the bootloader filled in (patches 4-5), because the image =
and
>> its placement are independent axes of variation. One board sold to sever=
al
>> customers wants several device trees differing in the logo. One customer
>> with several products built on that board, with different panels, wants =
the
>> same logo placed differently on each: there the image belongs in a shared
>> binary and only the placement belongs in the device tree. Patch 3 adds t=
hat
>> placement.
>>
>> We have been carrying a cruder version of this downstream on an AM335x
>> product since 2020, across a handful of board revisions, and it has remo=
ved
>> a real maintenance burden for us. This is an attempt to find out whether
>> something along these lines is wanted upstream, and if so in what shape =
--
>> hence RFC.
>>
>> I am aware of the contentious part: a bitmap is not hardware, and the de=
vice
>> tree is not an obvious place to put one. The argument for it is that the
>> logo identifies the board in the same way the model property does, it is
>> available before any filesystem is mounted, and it is per board rather t=
han
>> per kernel. The argument against is presumably that this is policy and
>> belongs in userspace or in the bootloader. I would rather hear that
>> explicitly than keep the patch downstream on a guess, and if the concept=
 is
>> rejected I would still like to know whether a smaller subset -- say the
>> placement properties driven from the fbcon command line, without any ima=
ge
>> in the device tree -- would be worth submitting separately.
>
> My 0.02=E2=82=AC: Usually you want to use the display using drm and not f=
b once
> the machine is fully booted. If you're using fb during boot to display a
> logo, it's hardly possible to switch to drm later in the boot process
> without flicker.
>
> So my recommendation for your usecase is to not use the kernel boot logo
> stuff, but something like https://github.com/pengutronix/platsch.  Then
> all the configuration is in userspace and modifyable using kernel
> parameters. Or you create your own application using libplatsch that
> selects the image based on the actual product derived from the dt
> compatible or some EEPROM's content.
>
> Best regards
> Uwe
--=20
Pengutronix e.K.                           | Ulrich =C3=96lmann            =
   |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
