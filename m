Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0477CDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2171B10E4D8;
	Mon, 22 Jun 2026 07:08:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TqEKGAV3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D66C310E4D8
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 07:08:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AD96F40650;
 Mon, 22 Jun 2026 07:08:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567391F000E9;
 Mon, 22 Jun 2026 07:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782112120;
 bh=V31gL4OYl0/uRXC4ZDNPMdp1oUQ0/6DdvCPuDgOUckI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TqEKGAV3+rEKVpj4FkdH4p3Re96FiJ3EgZNONAQKod5nxeISmjtbYNOfIwkd1o5E/
 Tryx6Napukgz4+ND62s+vi0RRYG2caqN+EZCOgZPQRQxTZRirXeN59PZia/s8cmoTt
 o6x5XukV4ZLd28VkfUpKwm8vyP1RLI5j1F/nHjPE2+LJ35KipzcNh8nEWqAMe0bNBc
 ceTEsmikZEqmbYX969qXn9qA4dkRx7g1WV90I5LyOL1d+nCepnmegSxvJDQc94+avZ
 6mBGEqenEG+LaaEHwU8e0GceVAntIMKsYyOPOGFhPLQnZdqoWYAezdpnwwUhhNfkt5
 xFbq3jL4hH64Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/7] drm/tegra: falcon: Add support for RISC-V
 external boot
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260622-t264-host1x-v2-5-ff7364d9ff7b@nvidia.com>
References: <20260622-t264-host1x-v2-0-ff7364d9ff7b@nvidia.com>
 <20260622-t264-host1x-v2-5-ff7364d9ff7b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 07:08:39 +0000
Message-Id: <20260622070840.567391F000E9@smtp.kernel.org>
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
- [High] Missing bounds check, endianness conversion, and size validation o=
f the RISC-V firmware descriptor leads to out-of-bounds memory accesses and=
 unbounded DMA.
--

commit ce83e1285215f11b260dbf628363fe352ce09b78
Author: Mikko Perttunen <mperttunen@nvidia.com>

drm/tegra: falcon: Add support for RISC-V external boot

Add support for loading and booting RISC-V firmwares on Falcons with
RISC-V hardware.

> diff --git a/drivers/gpu/drm/tegra/falcon.c b/drivers/gpu/drm/tegra/falco=
n.c
> index 17f616bbcb45b..1172356b6af3b 100644
> --- a/drivers/gpu/drm/tegra/falcon.c
> +++ b/drivers/gpu/drm/tegra/falcon.c

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
> +
> +	falcon->firmware.code.offset =3D desc->code_offset;
> +	falcon->firmware.code.size =3D desc->code_size;
> +	falcon->firmware.data.offset =3D desc->data_offset;
> +	falcon->firmware.data.size =3D desc->data_size;

[Severity: High]
Does this code need to validate the size of desc_firmware before casting its
data to struct falcon_fw_riscv_desc? If the firmware file is smaller than t=
he
struct size, this could lead to an out-of-bounds read.

Also, do these fields need le32_to_cpu() conversion for big-endian systems,
similar to how the main firmware is handled in falcon_copy_firmware_image()?

Finally, are the parsed sizes and offsets validated against the main firmwa=
re's
size? If not, these unchecked values could cause out-of-bounds host memory
accesses later in falcon_boot() when they are used in the falcon_copy_chunk=
()
DMA loops:

    for (offset =3D 0; offset < falcon->firmware.data.size; offset +=3D 256)
        falcon_copy_chunk(falcon,
                          falcon->firmware.data.offset + offset,
                          offset, FALCON_MEMORY_DATA);

> +}
> +
>  int falcon_read_firmware(struct falcon *falcon, const char *name)
>  {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-t264-host1=
x-v2-0-ff7364d9ff7b@nvidia.com?part=3D5
