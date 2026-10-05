Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCF2CA5FFC
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 09:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B5D810EC3E;
	Mon,  5 Oct 2026 09:28:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J+wln9TF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1197D10EC3E
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 09:28:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 410EF6022E;
 Mon,  5 Oct 2026 09:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC511F000FF;
 Mon,  5 Oct 2026 09:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791192506;
 bh=uJOTMVr6JIHo8Q8ETbx8Ett7aDV6pwSHA9X67nSRYn4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J+wln9TFy25WnLdfviMdK3McpOc/DfKZRASqxGW0dgs/F0DPt/fPEhQMS7EufrYfe
 UB28EdIyeN7HEEHrhsFESnJpoNKqLYAK6M9fzeP6uVcZRR8IP3Kcrmpn4eaYFHc7Pv
 l8Vto0mdx2eee3PVFOfFSfPKuCssuIs1ueWMI/97c0uamSJ+Di1O5V5UEHIlu1omzQ
 sCEiGbuclwBMhyy9eXO0Vmfx07WsOI9k7a70LvlgKIL9WryL2escvC8J7rTvdzG37M
 ID04aaM1lEL8zCq7Hxz03H5D2zYnC4TGxLTSQ7Fl2+57cda8TtgTJCKt/7fEEczwZg
 x2+d5lB5/yYuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] soundwire: amd: Add BRA/BPT firmware download
 support
To: "Syed Saba Kareem" <syed.sabakareem@amd.com>
Cc: bpf@vger.kernel.org, dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261005091620.1390916-5-syed.sabakareem@amd.com>
References: <20261005091620.1390916-1-syed.sabakareem@amd.com>
 <20261005091620.1390916-5-syed.sabakareem@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 09:28:25 +0000
Message-Id: <20261005092825.BFC511F000FF@smtp.kernel.org>
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
- [High] soundwire: uninitialized pointer dereference of acp_bra_wedged
--

commit bce4ebb14d16cc86a99aa8e0be380048484eab35
Author: Syed Saba Kareem <Syed.SabaKareem@amd.com>

soundwire: amd: Add BRA/BPT firmware download support

This commit adds Bulk Register Access (BRA) and Bulk Payload Transport
(BPT) support for AMD SoundWire platforms. This enables high-speed
firmware download to SoundWire peripherals via DP0, using the ACP BRA
DMA engine.

> diff --git a/drivers/soundwire/amd_init.c b/drivers/soundwire/amd_init.c
> index 8e419ddfa5161..00f4a87da7cbc 100644
> --- a/drivers/soundwire/amd_init.c
> +++ b/drivers/soundwire/amd_init.c
> @@ -120,6 +120,7 @@ static struct sdw_amd_ctx *sdw_amd_probe_controller(s=
truct sdw_amd_res *res)
> =20
>  		sdw_pdata[index].instance =3D index;
>  		sdw_pdata[index].acp_sdw_lock =3D res->acp_lock;
> +		sdw_pdata[index].acp_bra_lock =3D res->acp_bra_lock;
>  		sdw_pdata[index].acp_rev =3D res->acp_rev;
>  		pdevinfo[index].name =3D "amd_sdw_manager";
>  		pdevinfo[index].id =3D index;

[Severity: High]
Does this code miss initializing the acp_bra_wedged field in sdw_pdata?

Since sdw_pdata is allocated on the stack and not zero-initialized, this le=
aves
the acp_bra_wedged pointer containing stack garbage.

> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_mana=
ger.c
> index a3316efdf8ac2..078e13b01ac97 100644
> --- a/drivers/soundwire/amd_manager.c
> +++ b/drivers/soundwire/amd_manager.c
[ ... ]
> +static u32 amd_sdw_bra_configure_pte(struct amd_sdw_manager *amd_manager,
> +				     dma_addr_t dma_addr, size_t size)
> +{
> +	u32 num_pages =3D (u32)(PAGE_ALIGN(size) >> PAGE_SHIFT);
> +	u32 low, high, val;
> +	u16 page_idx;
> +	dma_addr_t addr =3D dma_addr;
> +
> +	if (*amd_manager->acp_bra_wedged) {

[Severity: High]
Can this dereference an uninitialized pointer and cause a kernel oops or pa=
nic?

When a BRA firmware download transfer is requested via amd_sdw_bpt_wait(), =
it
calls amd_sdw_bra_configure_pte() where *amd_manager->acp_bra_wedged is
dereferenced.=20

Because the field wasn't initialized in sdw_amd_probe_controller(), this wi=
ll
dereference an invalid stack address.

> +		dev_err(amd_manager->dev,
> +			"BRA engine previously wedged; refusing to reprogram shared ATU PTEs\=
n");
> +		return 0;
> +	}
[ ... ]
> @@ -1081,11 +2359,16 @@ static int amd_sdw_manager_probe(struct platform_=
device *pdev)
>  	amd_manager->mmio =3D amd_manager->acp_mmio +
>  			    (amd_manager->instance * SDW_MANAGER_REG_OFFSET);
>  	amd_manager->acp_sdw_lock =3D pdata->acp_sdw_lock;
> +	amd_manager->acp_bra_lock =3D pdata->acp_bra_lock;
> +	amd_manager->acp_bra_wedged =3D pdata->acp_bra_wedged;

[Severity: High]
This assigns the uninitialized stack garbage from pdata to
amd_manager->acp_bra_wedged.=20

Should sdw_amd_probe_controller() be updated to properly initialize=20
sdw_pdata[index].acp_bra_wedged before copying it here?

>  	amd_manager->acp_rev =3D pdata->acp_rev;
>  	amd_manager->cols_index =3D sdw_find_col_index(AMD_SDW_DEFAULT_COLUMNS);
>  	amd_manager->rows_index =3D sdw_find_row_index(AMD_SDW_DEFAULT_ROWS);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005091620.1390=
916-2-syed.sabakareem@amd.com?part=3D4
