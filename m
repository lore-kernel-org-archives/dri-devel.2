Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26746CD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 14:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 843B610E880;
	Mon, 18 May 2026 14:14:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="GmJ9nZMR";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E8F710E880
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 14:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779113661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X0PKPpLFUcJ5PNICdj+fODP+ieu23TytLui2uhS6hnY=;
 b=GmJ9nZMRzPWgTwYvRl3BlR1nJbd9ZPayn3+B4mvX2DWt4h/GHOJHPlMTjtTug+hEyGLA3x
 z9qrSdc2FSIQDuKUjURg/Qm2pEmr//PTTNTzroOYj6VvhI9lvljhDytyZJUSmjhEo/lXAx
 pfaHHnikkIYZ56RohbahzxvP8dgz7B4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-cjcY52dIMBac1SvNbDkZ7A-1; Mon, 18 May 2026 10:14:17 -0400
X-MC-Unique: cjcY52dIMBac1SvNbDkZ7A-1
X-Mimecast-MFC-AGG-ID: cjcY52dIMBac1SvNbDkZ7A_1779113656
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5a3fe7e7c94so134690e87.3
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 07:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779113656; x=1779718456;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X0PKPpLFUcJ5PNICdj+fODP+ieu23TytLui2uhS6hnY=;
 b=Pobd7DiRb5FvbAE3rG4qQFSzTYvKYiJoaisFq10iAt+MUWYU741rAgjVf+fPimGTkw
 O12SMRBVd4k958yzjyw8zngmeraMxCpk5WuZxmqYtYnRIO/xoN6qhYA4CUuruPJphiqk
 u8orS2p70B/Iy61pYoAJL78uLF3a9O5vdegW9A2prsRId+EXS47g5rniADUIelVIDrM9
 IVZBcPn1HlfPMo/1H6tqHks7M6zkA5912wvi9CLDkmem/y4gLHZvEPTz2AmiHsckOfUf
 9tEfffNvbXCg933CQ2+huggPKrrtdmObyfrekNKEDJWk1RU/debyEuIGmXTBnGbL4k9c
 Unvw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8VUuWKPG+h4Ty88VPnPnDlVkMrQkFkt63kcflYQ1REeyMROnI2KtPr8EaL4rBetjNe5pf0mCO+9S4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw7MhUTCEuuMcyDnuRjcclhmnn1hk+STBzplORGdiBLY6Z0y5/L
 iC94VFm3Fc/9wGGjzWM38f7qz25UXTWpLhlQNdiG2FlwHBmmmsWBXurNIp5ZnE7rq5nVoeIayz8
 MDnucVM9Si9pgBlSgAHB8p18j++3YQ7G4kalQ8bAcPFkBU7jpezlY8tvk/OznmCczHHxBNjV5/0
 FABp6XyO21t0MFEV/7Ebj9zwHOEHww7ybDSWMQxCtOpyf2
X-Gm-Gg: Acq92OF6JRSwvapitWGNilFBg4PIdOJO5Jt7xTPLmA5ZJRg/0QMl+kp8nUALDTU+ON4
 ZEcwjW7YZo7x7zddG4xIhRqE2RYkaBCeDXzKrN2vOgHkaWg7CpmMk7QgkFFcuzdoRu1oyVioa3Z
 BNSHYhmuLWSowVhtIL/Lhu2dRSK0Ojn8462kIx5yOzI+e79MJuvUuYvS64MBj4IsMC6JyZN97SM
 Qz9wA==
X-Received: by 2002:a05:651c:410e:b0:38f:f6a2:a61d with SMTP id
 38308e7fff4ca-39561f2f883mr11802421fa.4.1779113656333; 
 Mon, 18 May 2026 07:14:16 -0700 (PDT)
X-Received: by 2002:a05:651c:410e:b0:38f:f6a2:a61d with SMTP id
 38308e7fff4ca-39561f2f883mr11802281fa.4.1779113655655; Mon, 18 May 2026
 07:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260216150205.212318-1-larisa.grigore@oss.nxp.com>
 <aaGkGwbk-sh0YJqj@jkangas-thinkpadp1gen3.rmtuswa.csb>
In-Reply-To: <aaGkGwbk-sh0YJqj@jkangas-thinkpadp1gen3.rmtuswa.csb>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Mon, 18 May 2026 16:14:02 +0200
X-Gm-Features: AVHnY4JRP0kGP-z42K5FI0qcb3gAysvgY6dzw7kUR8X3jOVZKVkXLna2nVCi7XY
Message-ID: <CALE0LRuahJy2EKa7YUukGRq1w9iws6kDvjZ7o33ahJUGc2JSsw@mail.gmail.com>
Subject: Re: [PATCH 00/13] Add DMA support for LINFlexD UART driver
To: Jared Kangas <jkangas@redhat.com>
Cc: Larisa Grigore <larisa.grigore@oss.nxp.com>, gregkh@linuxfoundation.org, 
 jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com, 
 chester62515@gmail.com, cosmin.stoica@nxp.com, adrian.nitu@freescale.com, 
 stefan-gabriel.mirea@nxp.com, Mihaela.Martinas@freescale.com, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, s32@nxp.com, 
 imx@lists.linux.dev, clizzi@redhat.com, aruizrui@redhat.com, 
 echanude@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MtEN_0HLyHkjqDhtpAxkqvUOYC7p6UEY4UE-o2jNWsE_1779113656
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi all,

Any chance these series can be considered? They still apply on top of
the mainline kernel.

On Fri, Feb 27, 2026 at 3:03=E2=80=AFPM Jared Kangas <jkangas@redhat.com> w=
rote:
>
> Hi Larisa,
>
> On Mon, Feb 16, 2026 at 04:01:52PM +0100, Larisa Grigore wrote:
> > This patchset enhances the LINFlexD UART driver and its device tree bin=
dings to
> > support DMA transfers, configurable clock inputs, dynamic baudrate chan=
ges, and
> > termios features. It also includes a series of fixes and improvements t=
o ensure
> > reliable operation across various modes and configurations.
> >
> > The changes added can be summarized as follows:
> > 1. Fixes with respect to FIFO handling, locking, interrupt related regi=
sters and
> > INITM mode transition.
>
> Tested this series with the default devicetree configuration by booting
> the board to a login prompt about 200 times. Without the series applied,
> I was seeing a bug roughly every 30-50 boots where the kernel would
> would hang in linflex_console_putchar() waiting for DTFTFF. In my tests
> with the series applied, I didn't see any regressions and the bug no
> longer appeared. Thanks for the fix!
>
> Tested-by: Jared Kangas <jkangas@redhat.com> # S32G3, interrupt-driven
>

FWIW I also reproduced the issue Jared faced. Current state of the
LinFLEX serial driver in mainline seems a bit buggy and I can confirm
that these fix the problem.

Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>

> > 2. Removal of the earlycon workaround, as proper FIFO handling and INIT=
M
> > transitions now ensure stable behavior.
> > 3. Support for configurable stop bits and dynamic baudrate changes base=
d on
> > clock inputs and termios settings.
> > 4. Optional DMA support for RX and TX paths, preventing character loss =
during
> > high-throughput operations like copy-paste. Cyclic DMA is used for RX t=
o avoid
> > gaps between transactions.
> >
> > Larisa Grigore (8):
> >   serial: linflexuart: Clean SLEEP bit in LINCR1 after suspend
> >   serial: linflexuart: Check FIFO full before writing
> >   serial: linflexuart: Correctly clear UARTSR in buffer mode
> >   serial: linflexuart: Update RXEN/TXEN outside INITM mode
> >   serial: linflexuart: Ensure FIFO is empty when entering INITM
> >   serial: linflexuart: Revert earlycon workaround
> >   serial: linflexuart: Add support for configurable stop bits
> >   serial: linflexuart: Add DMA support
> >
> > Radu Pirea (5):
> >   serial: linflexuart: Fix locking in set_termios
> >   dt-bindings: serial: fsl-linflexuart: add clock input properties
> >   dt-bindings: serial: fsl-linflexuart: add dma properties
> >   serial: linflexuart: Add support for changing baudrate
> >   serial: linflexuart: Avoid stopping DMA during receive operations
> >
> >  .../bindings/serial/fsl,s32-linflexuart.yaml  |  31 +
> >  drivers/tty/serial/fsl_linflexuart.c          | 972 +++++++++++++++---
> >  2 files changed, 846 insertions(+), 157 deletions(-)
> >
> > --
> > 2.47.0
> >
>

