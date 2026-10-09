Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C17DCA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 23:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3A7611231D;
	Fri,  9 Oct 2026 23:12:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BedzREXv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC92111231D
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 23:12:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AB1A34050B;
 Fri,  9 Oct 2026 23:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CF41F000FF;
 Fri,  9 Oct 2026 23:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791587529;
 bh=0+MDkJVSNw5RktgEPbPAnO0JgqsHl8jP4c61UeNTeBs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BedzREXvugSO47TrvYyPUIAuyjjOt0uYczXFG+NNGJMCBB6SwlFFYo5u5xpbvteTG
 VJhYCTGTVdeKRcrp8x3DmASPGJ4yTk8X6YS2VvcwCdo1Ody13RlAJBZZbjiuPoPq/h
 AY3k7UHGN4KypwshfnEzQG3XeVv6++Y/4+fLDIOB3pEnqEkykEfaAw6XbyCHbS2eFj
 g7Dg2xM0RCCGwr7nqhTKRcLAxR3mjvfeaUmd6iq7IRDqqi+O9ChWj9UwFl8wZoAbLw
 rUIqe3CQhj7gCx0c0ws7G+JK7adLLiqWqrvGwTm6YGnDMExoUjU67PbfN8u56pxVkS
 hpZ9r0TXCCvUg==
Message-ID: <sashiko-outbox-166178@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 08/19] accel/amdxdna: Add clock, DPM frequency, and
 resource info queries for AIE4
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261009225343.3079074-9-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
 <20261009225343.3079074-9-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 23:12:08 +0000
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
- [Medium] amdxdna: user-triggerable log spam in aie_update_counters ioctl =
path
- [Medium] amdxdna: uninitialized max_tops returned to userspace on telemet=
ry failure
--

commit 9f91f5ba98bc4ba5e1f461f3136872d989e22936
Author: David Zhang <yidong.zhang@amd.com>

    accel/amdxdna: Add clock, DPM frequency, and resource info queries for =
AIE4

This commit adds support for querying clock metadata, DPM frequency tables,
and hardware resource information for AIE4/NPU3 devices. It moves the DPM
frequency table to the device structure and queries active DPM levels via
messages to the firmware.

> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie=
4_pci.c
> index 6eacdc026ec7f..5593dfb6c7ed5 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -299,6 +299,17 @@ static int aie4_query(struct amdxdna_dev_hdl *ndev)
>  	if (ret)
>  		return ret;
> =20
> +	ndev->total_col =3D min_t(u32, AIE4_TOTAL_COLUMN, ndev->aie.metadata.co=
ls);
> +
> +	ret =3D aie4_init_dpm_freq_table(ndev);
> +	if (ret) {
> +		if (ret =3D=3D -ETIME)
> +			return ret;
> +		/* if query dpm from fw failed, using default value */
> +		if (ndev->priv->hw_ops && ndev->priv->hw_ops->set_dpm)
> +			(void)ndev->priv->hw_ops->set_dpm(&ndev->aie, 0);
> +	}

[Severity: Medium]
When aie4_init_dpm_freq_table() successfully queries the DPM table from
firmware, the fallback call to set_dpm() is skipped. Doesn't this leave
aie->max_tops and aie->curr_tops uninitialized (0) at startup?

[ ... ]

> @@ -635,11 +646,71 @@ static int aie4_get_power_mode(struct amdxdna_clien=
t *client,
>  	return 0;
>  }
> =20
> +static int aie4_query_clock_metadata(struct amdxdna_client *client,
> +				     struct amdxdna_drm_get_info *args)
> +{
> +	struct amdxdna_drm_query_clock_metadata *clock;
> +	struct amdxdna_dev *xdna =3D client->xdna;
> +	struct amdxdna_dev_hdl *ndev;
> +	int ret =3D 0;
> +	u32 buf_sz;
> +
> +	ndev =3D xdna->dev_handle;
> +	clock =3D kzalloc_obj(*clock);
> +	if (!clock)
> +		return -ENOMEM;
> +
> +	aie_update_counters(ndev);

[Severity: Medium]
Because this ioctl can be polled rapidly by unprivileged userspace monitori=
ng
tools, does calling aie_update_counters() without checking its return value
provide a vector for local denial of service via kernel log spam if the
telemetry query in npu3_update_counters() fails?

[ ... ]

> +static int aie4_query_resource_info(struct amdxdna_client *client,
> +				    struct amdxdna_drm_get_info *args)
> +{
> +	struct amdxdna_drm_get_resource_info res_info =3D {};
> +	struct amdxdna_dev_hdl *ndev;
> +	struct amdxdna_dev *xdna;
> +	u32 buf_sz;
> +
> +	xdna =3D client->xdna;
> +	ndev =3D xdna->dev_handle;
> +
> +	aie_update_counters(ndev);
> +	res_info.npu_clk_max =3D ndev->dpm_clk_tbl[ndev->max_npuhclk_level].hcl=
k;
> +	res_info.npu_tops_max =3D ndev->aie.max_tops;
> +	res_info.npu_tops_curr =3D ndev->aie.curr_tops;

[Severity: Medium]
Here we ignore the return value of aie_update_counters() as well. If the
underlying telemetry query fails and returns early without populating
aie->max_tops, will this copy the uninitialized 0 values to userspace?=20

Userspace might receive 0 for static hardware limits and clock frequencies,
causing incorrect statistics in clients that rely on accurate resource boun=
ds.

> diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/amdxdna/np=
u3_regs.c
> index c82433d629012..cff99ddd3a552 100644
> --- a/drivers/accel/amdxdna/npu3_regs.c
> +++ b/drivers/accel/amdxdna/npu3_regs.c
[ ... ]
> +static int npu3_update_counters(struct aie_device *aie)
> +{
> +	struct amdxdna_dev_hdl *ndev =3D aie->xdna->dev_handle;
> +	u32 aieclk_level, npuhclk_level;
> +	int ret;
> +
> +	/* Use firmware DPM table or pre-defined table, never mixed. */
> +	ret =3D aie4_query_dpm_level(ndev, &aieclk_level, &npuhclk_level);
> +	if (ret) {
> +		XDNA_WARN(aie->xdna, "Failed to get DPM level from fw: %d", ret);
> +		return ret;
> +	}

[Severity: Medium]
This is where the un-ratelimited warning is printed upon a telemetry failur=
e in
the ioctl path. If the firmware is older and lacks support for
AIE4_MSG_OP_GET_CURRENT_DPM_LEVEL, or the management channel times out, cou=
ld
this result in unbounded kernel log spam?

If this telemetry query fails, max_tops is never computed. Combined with the
uninitialized state from aie4_query() during probe, does this ensure 0 is
propagated to the caller?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009225343.3079=
074-1-yidong.zhang@amd.com?part=3D8
