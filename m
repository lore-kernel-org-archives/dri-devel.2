Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F79C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D004F10F05D;
	Wed, 12 Aug 2026 15:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WehsZAa0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7707A10F099
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 15:46:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 25E40415EB;
 Wed, 12 Aug 2026 15:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41C61F00A3F;
 Wed, 12 Aug 2026 15:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786549613;
 bh=/GB3Fi/saC+PIBt7BBLpbVMxRJbxvo0Nk2bljOa6Wpg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WehsZAa0qGuX6wkbSAYmT3STz35SP7AebyxyLCKOpOqeUwl+1lForMDjMyDvo13br
 cau+yGA102XYGDNrPPi6MCu0WhqjXrydUeCQ0K11GnnfLa+yjBLmWmL9vwFim0+QyH
 PVl5+uzuGX9zb+6VSYzZtCDr3dh9MdY1Ulja9YUhEnmyOdeHwoRIsFJdLP4sxnFBnJ
 Z3XAiyyHdjETjDaKBmDAfG2LJkqmKVijMOGl+M+Ex6Y0WCOc97ktaCxmsgKazLmU5C
 Qoyz3iCFqQ1VO6YgZ3GCdehbH1ndtTXIcnmpMyy4chTacBktQCTUeK7my0LudN+Uws
 cOvm880OpXBiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] ALSA: hda: allow direct complete with a
 powered-off GPU
To: "Andre Eikmeyer" <dev@deq.rocks>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812144750.36797-4-dev@deq.rocks>
References: <20260812144221.35877-1-dev@deq.rocks>
 <20260812144750.36797-1-dev@deq.rocks>
 <20260812144750.36797-4-dev@deq.rocks>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:46:52 +0000
Message-Id: <20260812154652.C41C61F00A3F@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The `azx_prepare` function conditionally returns 1 early to reques=
t direct complete, bypassing mandatory ALSA state initialization and workqu=
eue flushing. If direct complete is subsequently aborted by the PM core, th=
e device will suspend in an inconsistent state.

Pre-existing issues:
- [High] The HDA interrupt handler uses a non-atomic runtime PM check, and =
the runtime suspend callback shuts down the hardware without synchronizing =
shared IRQs. This allows the interrupt handler to run concurrently while th=
e hardware is being powered down.
--

--- Patch [3]: [PATCH v3 3/3] ALSA: hda: allow direct complete with a power=
ed-off GPU ---
commit 8f27e09b7a8bd094dbb356dbe9893145a18d34a2
Author: Andre Eikmeyer <dev@deq.rocks>

ALSA: hda: allow direct complete with a powered-off GPU

The commit allows direct complete during system suspend for a switcheroo
audio client when the bound GPU is already runtime suspended and switched
off. It does this by checking the VGA switcheroo state and returning 1
from azx_prepare().

> diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
> index 4b03c64e72ab4..6f1c1d596e2ca 100644
> --- a/sound/hda/controllers/intel.c
> +++ b/sound/hda/controllers/intel.c

[ ... ]

> @@ -1025,6 +1027,10 @@ static int azx_prepare(struct device *dev)
>  		return 0;
> =20
>  	chip =3D card->private_data;
> +	/* A positive return allows the PM core to use direct complete. */
> +	if (azx_vga_is_powered_off(chip))
> +		return 1;
> +

[Severity: High]
If the PM core decides to abort direct complete for this device later in the
suspend process, will this leave the device in an inconsistent state?

For example, if a child HDA codec returns 0 from its own prepare callback,
the PM core clears the direct complete flag and will fall back to calling
azx_suspend().

Since this early return bypasses snd_power_change_state() and flush_work(),
the ALSA subsystem will still consider the device to be in SNDRV_CTL_POWER_=
D0
and the unsol_work may still be queued or running while the hardware gets
shut down.

>  	chip->pm_prepared =3D 1;
>  	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);

[ ... ]

[Severity: High]
This is a pre-existing issue, but I have a question about the existing
runtime PM handling and shared interrupts in this driver.

Does azx_runtime_suspend() need to call synchronize_irq() before powering
down the hardware?

Currently, azx_interrupt() in sound/hda/common/controller.c uses a
non-atomic pm_runtime_active() check. If a shared interrupt fires for
another device, azx_interrupt() could see the device as active, while
another CPU concurrently executes azx_runtime_suspend() and shuts down the
hardware.

A read from the powered-off hardware would then typically return 0xffffffff.
If this happens between reading INTSTS and RIRBSTS, the 0xff byte read could
incorrectly match RIRB_INT_MASK and trigger further invalid accesses or an
IRQ storm.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812144750.3679=
7-1-dev@deq.rocks?part=3D3
