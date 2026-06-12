Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588A7CD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 06:44:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A653410F29A;
	Fri, 12 Jun 2026 06:44:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KF0sA6pS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75B5910F29A
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 06:44:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8ED74600AF;
 Fri, 12 Jun 2026 06:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC701F00A3A;
 Fri, 12 Jun 2026 06:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781246678;
 bh=eTErHePYoLyGkrZLddn9Cyf5hPUTgyi1F17SqUCOu5c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KF0sA6pSUUnE2elvhCgH5juRmutyxl4yhstp0gJe8Z5lkCVnl3Npvc5wlcu81a1Qq
 Ty5is8lWrlf87sBzpIL3meKQthvrtRYpJZRFsWBa3Xyp7StlEjdwl5yH8xEMnh3ljo
 m+vHm0CYGCF0qaG3J2S9T8L0tlhjW5sg6xrfRdhq9ihA1z8xtb++WQ0GM9W7qeTqgd
 tVpT9e5++mrvS0sfrDrbabGXLb1u4x3Pq+Djl3cNBaFwS6AbvABLsC8XH58sW5LNqE
 gDNu12GiWMKdrmJpfyvS3F0Y4hb/yWeLkYhGtvN80vvqlCu1YIHACGHUxrreFEPhxa
 nD4RWrchoQQ9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] drm/tegra: falcon: Add support for RISC-V external
 boot
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260612-t264-host1x-v1-5-8d934987de67@nvidia.com>
References: <20260612-t264-host1x-v1-5-8d934987de67@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 06:44:37 +0000
Message-Id: <20260612064438.0EC701F00A3A@smtp.kernel.org>
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
- [High] Missing size validation for the `.desc` firmware file allows an ou=
t-of-bounds read of the firmware descriptor buffer.
- [High] Inverted condition in `falcon_wait_idle()` for RISC-V incorrectly =
waits for the CPU to become active rather than idle, causing premature retu=
rn.
- [High] Firmware segment offsets and sizes from the `.desc` file are not v=
alidated against the main firmware buffer size, leading to out-of-bounds DM=
A reads.
- [Medium] Missing endianness conversion when reading `u32` fields from the=
 `.desc` firmware descriptor breaks on big-endian architectures.
--

commit 9b921eae84dc7cacf7c324bd76e166d6a5d942be
Author: Mikko Perttunen <mperttunen@nvidia.com>

drm/tegra: falcon: Add support for RISC-V external boot

This commit adds support for loading and booting RISC-V firmwares on Falcons
with RISC-V hardware. It introduces a new firmware layout and uses different
registers for the boot flow compared to traditional Falcons.

> diff --git a/drivers/gpu/drm/tegra/falcon.c b/drivers/gpu/drm/tegra/falco=
n.c
> index 17f616bbcb45b..1172356b6af3b 100644
> --- a/drivers/gpu/drm/tegra/falcon.c
> +++ b/drivers/gpu/drm/tegra/falcon.c
> @@ -26,8 +26,12 @@ int falcon_wait_idle(struct falcon *falcon)
>  {
>  	u32 value;
> =20
> -	return readl_poll_timeout(falcon->regs + FALCON_IDLESTATE, value,
> -				  (value =3D=3D 0), 10, 100000);
> +	if (falcon->riscv)
> +		return readl_poll_timeout(falcon->regs + RISCV_CPUCTL, value,
> +					  (value & RISCV_CPUCTL_ACTIVE_STAT_ACTIVE), 10, 100000);

[Severity: High]
Does this condition successfully terminate when the CPU is active rather th=
an
idle?

If falcon_boot() calls this immediately after issuing the STARTCPU command,
the processor will instantly become active, and the wait will return
immediately instead of waiting for the processor to go idle. Would negating
the condition to !(value & RISCV_CPUCTL_ACTIVE_STAT_ACTIVE) correctly wait
for the firmware boot sequence to finish?

> +	else
> +		return readl_poll_timeout(falcon->regs + FALCON_IDLESTATE, value,
> +					  (value =3D=3D 0), 10, 100000);
>  }

[ ... ]

> @@ -122,6 +126,17 @@ static int falcon_parse_firmware_image(struct falcon=
 *falcon)
>  	return 0;
>  }
> =20
> +static void falcon_parse_firmware_desc(struct falcon *falcon)
> +{
> +	struct falcon_fw_riscv_desc *desc =3D
> +		(struct falcon_fw_riscv_desc *)falcon->firmware.desc_firmware->data;

[Severity: High]
Is it possible for the loaded firmware file to be smaller than
sizeof(struct falcon_fw_riscv_desc)?

If a truncated or malformed .desc file is loaded from userspace, could
casting and reading desc_firmware->data here result in an out-of-bounds
memory read of the allocated buffer?

> +
> +	falcon->firmware.code.offset =3D desc->code_offset;
> +	falcon->firmware.code.size =3D desc->code_size;
> +	falcon->firmware.data.offset =3D desc->data_offset;
> +	falcon->firmware.data.size =3D desc->data_size;

[Severity: Medium]
Do these assignments need endianness conversion, such as le32_to_cpu()?

The older .bin parsing path safely copies and byte-swaps the firmware via
falcon_copy_firmware_image(). Since this RISC-V path appears to perform
no conversions, could reading these fields directly from the raw byte
array produce incorrect, byte-swapped values on big-endian architectures?

[Severity: High]
Are these offsets and sizes validated against the main firmware buffer size?

In falcon_boot(), these sizes are used to calculate bounds and program
the Falcon hardware DMA engine via falcon_copy_chunk():

falcon_boot() {
    ...
    for (offset =3D 0; offset < falcon->firmware.data.size; offset +=3D 256)
        falcon_copy_chunk(falcon,
                          falcon->firmware.data.offset + offset,
                          offset, FALCON_MEMORY_DATA);
    ...
}

If the values are not checked to ensure
offset + size <=3D falcon->firmware.size, could a maliciously crafted .desc
file instruct the DMA controller to read out-of-bounds physical memory?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-t264-host1=
x-v1-0-8d934987de67@nvidia.com?part=3D5
