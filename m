Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DCFC5B572
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 15:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFA6A10E31C;
	Sun, 16 Aug 2026 15:18:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ye+A8880";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D2AE10E31C
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 15:18:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6DD68600E2;
 Sun, 16 Aug 2026 15:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C241F000E9;
 Sun, 16 Aug 2026 15:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786893512;
 bh=ChGnMkWQa5EzRSOSa/ks9sMr8lpamJJC9dCgovmhCeQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ye+A8880PhANh05CpqVfiBFRVzZJ8L8CbgtDat0bQRw9KQWBhLoywxz2wGfvzwTll
 iclsR16Uey76mbCnK121qC/GZwJZy5Y7oMZo7CjlFayPnh4ohd3NIBJwSqKyFaC7Hl
 ny6z8aVU3UQQdsoGfm0DmE///V/fqnmgsLaj/m0qibzb2nleg07UdC9jfAiIAIXnfN
 Okt/tmWDPs6B/g96MPYi/YdZnO1nrYe557rdwird1xMshWUqD3d0lROt4MRCeWFBXk
 KuTt/nv+mzHWEQkdgKWyGG1N48JpnjioJP4nbxM1pDMZkLufNdYXFy5Ds203UDuZiH
 CQ/IzbQsiD62Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] fpga: versal: add dma-buf programming support
To: "Aravind Thokala" <aravind.thokala@amd.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260816150734.2092802-3-aravind.thokala@amd.com>
References: <20260816150734.2092802-1-aravind.thokala@amd.com>
 <20260816150734.2092802-3-aravind.thokala@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 15:18:31 +0000
Message-Id: <20260816151831.E3C241F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Passing a user-accessible dma-buf directly to the PMC firmware i=
ntroduces a speculative Time-of-Check to Time-of-Use (TOCTOU) vulnerability=
 that can potentially bypass FPGA bitstream authentication.
--

--- Patch [2]: [PATCH 2/2] fpga: versal: add dma-buf programming support ---
commit 92384704c37fbbfe16cd9659151fbb8646c178cc
Author: Aravind Thokala <aravind.thokala@amd.com>

fpga: versal: add dma-buf programming support

This commit adds a .write_sg callback to the Versal FPGA driver to support
dma-buf based programming. It extracts the DMA address from the scatter-gat=
her
table and passes it directly to the firmware, avoiding an intermediate buff=
er
copy.

> diff --git a/drivers/fpga/versal-fpga.c b/drivers/fpga/versal-fpga.c
> index e6189106c4686..bdaa15a6c9913 100644
> --- a/drivers/fpga/versal-fpga.c
> +++ b/drivers/fpga/versal-fpga.c

[ ... ]

> @@ -37,11 +38,34 @@ static int versal_fpga_ops_write(struct fpga_manager =
*mgr,
>  	return ret;
>  }
> =20
> +static int versal_fpga_ops_write_sg(struct fpga_manager *mgr,
> +				    struct sg_table *sgt)
> +{
> +	dma_addr_t dma_addr;
> +
> +	/* zynqmp_pm_load_pdi() takes a single base address */
> +	if (sgt->nents !=3D 1) {
> +		dev_err(&mgr->dev, "dma-buf has %u segments, need exactly 1\n",
> +			sgt->nents);
> +		return -EINVAL;
> +	}
> +
> +	dma_addr =3D sg_dma_address(sgt->sgl);
> +
> +	return zynqmp_pm_load_pdi(PDI_SRC_DDR, dma_addr);

[Severity: Medium]
Does this expose the firmware to a Time-of-Check to Time-of-Use (TOCTOU)
vulnerability if the Xilinx PMC firmware double-fetches the payload?

By extracting the DMA address from the user-provided dma-buf and passing
it directly to zynqmp_pm_load_pdi() without copying it to a kernel-owned
isolated buffer, a process could potentially modify the bitstream
concurrently during the firmware's authentication and loading process.

If a user with CAP_SYS_RAWIO maintains a writable memory mapping to the
dma-buf (for instance, using udmabuf) and invokes FPGA_IOCTL_LOAD_DMA_BUF,
they could overwrite the memory while the firmware reads it.

If the firmware re-reads any part of the bitstream after authentication,
could this be abused to bypass secure boot boundaries?

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260816150734.2092=
802-1-aravind.thokala@amd.com?part=3D2
