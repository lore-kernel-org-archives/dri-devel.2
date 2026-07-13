Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427EBC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A18AB10E5CA;
	Mon, 13 Jul 2026 12:56:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kwYS+p1j";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0A1610E5CA
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:56:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 86719438C4;
 Mon, 13 Jul 2026 12:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B151F000E9;
 Mon, 13 Jul 2026 12:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783947409;
 bh=AeQ88YsTKdvbi/FZj6zWrkktdBCLQi9tblRYaaxcv5M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kwYS+p1jTVI9LOI9quB/Y8P7rFD6RH+HbNoOScM6AD9qDNMl+ATQ1lULwKOcXYDGJ
 3tPCbAMmyQCJ8mBsFD1mj6FPsNoEh9qojnuD5wLhFAIv1RaffRKQbPgd15jkunLb13
 xPFBdA7IYsmcOm4PUnoaLWvS/t7gKjreMk6prjjSTMT8qbTKr5oLyobGlsVmik/8Qc
 ofyjtWR5BV4dB0HgBOpfJY+pBidXf+vjUPE1yxSa1qLy7WOmcu/vM9cDqzrOFeNJTz
 vPUoFBZfgzH7LmczLOOdRqKgRFhoOcIyE42OGMvTtAFQgyh2lWfu5T5py1rmgquJKA
 PryksvLinumgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 15/19] media: meson: vdec: Fix concurrent firmware
 loading race and hardware timeout
To: "Anand Moon" <linux.amoon@gmail.com>
Cc: neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260713120840.17427-16-linux.amoon@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
 <20260713120840.17427-16-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 12:56:48 +0000
Message-Id: <20260713125649.33B151F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Low] Suboptimal use of atomic polling in a sleepable context.

Pre-existing issues:
- [High] Missing memory barrier between firmware memcpy and DMA start.
- [High] Incomplete fix: identical bugs (static variables and raw decrement=
 loop) remain in HEVC firmware loader.
- [High] Potential DMA Use-After-Free if firmware DMA transfer times out.
--

--- Patch [15]: [PATCH v7 15/19] media: meson: vdec: Fix concurrent firmwar=
e loading race and hardware timeout ---
commit 7acf244d598b1d1a15fbe219b6ceaead31b2210b
Author: Anand Moon <linux.amoon@gmail.com>

media: meson: vdec: Fix concurrent firmware loading race and hardware timeo=
ut

This commit fixes a concurrent firmware loading race condition by replacing
static variables with local ones in vdec_1_load_firmware(). It also address=
es
hardware DMA hang timeouts by replacing a fast decrement loop with
readl_poll_timeout_atomic().

> diff --git a/drivers/staging/media/meson/vdec/vdec_1.c b/drivers/staging/=
media/meson/vdec/vdec_1.c
> --- a/drivers/staging/media/meson/vdec/vdec_1.c
> +++ b/drivers/staging/media/meson/vdec/vdec_1.c

[ ... ]

> @@ -63,11 +63,11 @@ vdec_1_load_firmware(struct amvdec_session *sess, con=
st char *fwname)
>  	amvdec_write_dos(core, IMEM_DMA_COUNT, MC_SIZE / 4);
>  	amvdec_write_dos(core, IMEM_DMA_CTRL, (0x8000 | (7 << 16)));

[Severity: High]
This is a pre-existing issue, but is there a missing memory barrier between
the firmware memcpy and the DMA start?

Earlier in vdec_1_load_firmware(), the firmware is copied to a DMA-coherent
buffer:

    memcpy(mc_addr, fw->data, MC_SIZE);

Since amvdec_write_dos() maps to writel_relaxed(), there is no memory-to-I/O
ordering guarantee. Could the CPU issue the MMIO write to start the DMA
before the firmware data is flushed to main memory, causing the hardware to
read stale data?

> -	while (--i && amvdec_read_dos(core, IMEM_DMA_CTRL) & 0x8000);
> -
> -	if (i =3D=3D 0) {
> +	ret =3D readl_poll_timeout_atomic(core->dos_base + IMEM_DMA_CTRL, val,
> +					!(val & 0x8000), 10, 10000);

[Severity: Low]
Does this need to use the atomic polling variant?

Since vdec_1_load_firmware() runs in a sleepable context (it successfully
calls request_firmware() and allocates memory with GFP_KERNEL just prior),
could this use the non-atomic readl_poll_timeout() macro instead?

Using the atomic variant forces the CPU to busy-wait in a udelay() loop for
up to 10ms, which might be inefficient.

> +	if (ret) {
>  		dev_err(dev, "Firmware load fail (DMA hang?)\n");
> -		ret =3D -EINVAL;
> +		ret =3D -ETIMEDOUT;
>  		goto free_mc;

[Severity: High]
This is a pre-existing issue, but does this create a DMA use-after-free if
the firmware DMA transfer times out?

When a timeout occurs, the code jumps to free_mc:

free_mc:
    dma_free_coherent(core->dev, MC_SIZE, mc_addr, mc_addr_map);

If the hardware is merely slow and still executing the DMA transfer, will it
continue to read from these freed memory pages? Should the DMA controller be
explicitly halted (for example, by clearing the IMEM_DMA_CTRL register)
before releasing the buffer?

>  	}

[Severity: High]
This is a pre-existing issue, but does the same problem still exist in the
HEVC firmware loader?

Looking at vdec_hevc_load_firmware() in vdec_hevc.c, it uses the exact same
static variables and fast decrement loop that this patch fixes in vdec_1.c:

static int vdec_hevc_load_firmware(...)
{
    ...
    static void *mc_addr;
    static dma_addr_t mc_addr_map;
    ...
    while (i && (readl(core->dos_base + HEVC_IMEM_DMA_CTRL) & 0x8000))
        i--;
    ...
}

Will HEVC decoding also fail consistently on modern CPUs due to false DMA
timeouts? And could multiple HEVC decoding sessions corrupt state by sharing
these static variables?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713120840.1742=
7-1-linux.amoon@gmail.com?part=3D15
