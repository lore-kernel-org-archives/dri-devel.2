Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04ACACDB466
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 08:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B73010E587;
	Mon, 22 Jun 2026 08:48:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bexvx1+e";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A8EF10E587
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 08:48:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E42A841717;
 Mon, 22 Jun 2026 08:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9742A1F000E9;
 Mon, 22 Jun 2026 08:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782118106;
 bh=Ip851X7bkgURMoyrElEEM17vIHpXT3xsP2yIrtuWlUM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bexvx1+ekowZ+J9+FtgudKx+fAndkkYoeBjR1uM8TTO6zXt1t0uAwbwXcKn31dCmL
 9iy3LwJ2Zti2f3oX9L9laPtCGwR9I2XXtbEE0m/6m83DK86zt4kMSyX0VCmMX//PdG
 rhMoBBQMaSeaWlEfTgGhyjWddQ+uKOVNVYodHKct/zfjIBmID62sZeOiXl3kG/x9ro
 m1LMHDdhbzLhF9y3UKm1sCn8G1wpQUrYCyLaEzVcRFrjdj8/aDI9SIry40bOD38z5v
 7goqZoxXZOlXTKuj5gdaXXko4nqDLBDHN50/er3ITHyPeat7bHud6xyVMgIZ+2zAGU
 ssA0Z6MStxO/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] gpu: host1x: Allow limiting usable channel and
 syncpoint ranges
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260622-host1x-nohv-v1-4-65bc682a617f@nvidia.com>
References: <20260622-host1x-nohv-v1-0-65bc682a617f@nvidia.com>
 <20260622-host1x-nohv-v1-4-65bc682a617f@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 08:48:26 +0000
Message-Id: <20260622084826.9742A1F000E9@smtp.kernel.org>
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
- [High] Unvalidated device tree properties allow out-of-bounds array acces=
s and memory corruption.
- [High] Unconditional hardware state reset clobbers interrupt states and w=
ait bases for unowned syncpoints.
--

commit bdd04d3945b8f8760d8be70ce0ab1595927b08f4
Author: Mikko Perttunen <mperttunen@nvidia.com>

gpu: host1x: Allow limiting usable channel and syncpoint ranges

Allow specifying usable channel, and allocatable syncpoint ranges
through the device tree. This is necessary when Host1x resources
are shared between multiple operating systems or independent hardware
units and Linux has limited access to them.

> diff --git a/drivers/gpu/host1x/channel.c b/drivers/gpu/host1x/channel.c
> index ca5d0f51cf7da..38fcdda8388ad 100644
> --- a/drivers/gpu/host1x/channel.c
> +++ b/drivers/gpu/host1x/channel.c
> @@ -121,13 +121,13 @@ EXPORT_SYMBOL(host1x_channel_put);
>  static struct host1x_channel *acquire_unused_channel(struct host1x *host)
>  {
>  	struct host1x_channel_list *chlist =3D &host->channel_list;
> -	unsigned int max_channels =3D host->info->nb_channels;
>  	unsigned int index;
> =20
>  	mutex_lock(&chlist->lock);
> =20
> -	index =3D find_first_zero_bit(chlist->allocated_channels, max_channels);
> -	if (index >=3D max_channels) {
> +	index =3D find_next_zero_bit(chlist->allocated_channels,
> +				   host->channel_end, host->channel_base);

[Severity: High]
Does this code allow out-of-bounds memory accesses if the device tree values
exceed the hardware limits?

Since chlist->channels and chlist->allocated_channels are allocated based on
host->info->nb_channels, could a large value in the nvidia,channels device
tree property cause an out-of-bounds access here when host->channel_end is
passed to find_next_zero_bit()? Should host->channel_end be validated
in host1x_get_assigned_resources()?

[ ... ]

> diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
> index 545fa2e3f180c..7103f018cb1bf 100644
> --- a/drivers/gpu/host1x/dev.c
> +++ b/drivers/gpu/host1x/dev.c
> @@ -331,6 +331,39 @@ static void host1x_setup_virtualization_tables(struc=
t host1x *host)
>  	}
>  }
> =20
> +static int host1x_get_assigned_resources(struct host1x *host)
> +{
> +	struct device_node *np =3D host->dev->of_node;
> +	u32 vals[2];
> +	int err;
> +
> +	err =3D of_property_read_u32_array(np, "nvidia,channels", vals, 2);
> +	if (err =3D=3D 0) {
> +		host->channel_base =3D vals[0];
> +		host->channel_end =3D vals[0] + vals[1];
> +	} else if (err =3D=3D -EINVAL) {
> +		host->channel_base =3D 0;
> +		host->channel_end =3D host->info->nb_channels;
> +	} else {
> +		dev_err(host->dev, "invalid nvidia,channels property: %d\n", err);
> +		return err;
> +	}
> +
> +	err =3D of_property_read_u32_array(np, "nvidia,syncpoints", vals, 2);
> +	if (err =3D=3D 0) {
> +		host->syncpt_base =3D vals[0];
> +		host->syncpt_end =3D vals[0] + vals[1];

[Severity: High]
Similarly, could large values for nvidia,syncpoints cause out-of-bounds rea=
ds
and writes?

Arrays like host->syncpt are allocated based on host->info->nb_pts.
If host->syncpt_end exceeds this limit without validation, functions like
host1x_syncpt_alloc() that iterate up to host->syncpt_end might access
memory out of bounds.

[ ... ]

> diff --git a/drivers/gpu/host1x/syncpt.c b/drivers/gpu/host1x/syncpt.c
> index acc7d82e0585e..fe27a386cc0c8 100644
> --- a/drivers/gpu/host1x/syncpt.c
> +++ b/drivers/gpu/host1x/syncpt.c
[ ... ]
> @@ -138,7 +138,7 @@ void host1x_syncpt_restore(struct host1x *host)
>  	struct host1x_syncpt *sp_base =3D host->syncpt;
>  	unsigned int i;
> =20
> -	for (i =3D 0; i < host1x_syncpt_nb_pts(host); i++) {
> +	for (i =3D host->syncpt_base; i < host->syncpt_end; i++) {
>  		/*
>  		 * Unassign syncpt from channels for purposes of Tegra186
>  		 * syncpoint protection. This prevents any channel from

[Severity: High]
Does this clobber the hardware state for unowned syncpoints?

Right after this loop, the code in host1x_syncpt_restore() unconditionally
restores wait bases for syncpoints 0 to nb_bases-1:

	for (i =3D 0; i < host1x_syncpt_nb_bases(host); i++)
		host1x_hw_syncpt_restore_wait_base(host, sp_base + i);

Similarly, host1x_intr_disable_all_syncpt_intrs() unconditionally disables =
and
clears threshold interrupts for all syncpoints across the entire hardware.

Since this patch restricts Linux to a specific range of syncpoints to allow
sharing the Host1x device, will overwriting the wait bases and interrupt st=
ates
unconditionally break synchronization for other operating systems or hardwa=
re
units sharing the device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-host1x-noh=
v-v1-0-65bc682a617f@nvidia.com?part=3D4
