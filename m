Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CAECA5FFD
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 03:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E371210E6DF;
	Thu,  8 Oct 2026 03:48:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kRG0M4Ys";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AB5710E6DF
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 03:48:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 07BF943286;
 Thu,  8 Oct 2026 03:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FEF1F000FF;
 Thu,  8 Oct 2026 03:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791431304;
 bh=G8/flLeRSkSyadKvjbOqvezan+CKByjVeQqyyjjWZAQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kRG0M4YsHfcxxYLebcj3mTyU4xlf4zjQpBkLjfxWcQue63mLw7NmSkTz8o2l8mVVw
 n1CMUw2e8GPAw8xRzkWox4562qujgzJF22ul/4ZmJgi6JEtY2NTbnXLDyOtkcXfdiH
 RBG37ONe/1SwBaIiOPIbGMWhHDGhzhSUHfkKfNlLAb+7yiQhzGCsBDo6dl7NUcUOUf
 9I1VG8iFp5zdDedxh/qq8NthRsVSAgztUmUjr8Au66/wM+goYa8oM3YaxoD1iuRURw
 J4m5iwNq1XzFr02BA5KKOses5N/2Q3EwJO29P75BjUB+YwcXWIwl//MJBtAk1OUSyJ
 tX8RwtG3/5WIg==
Message-ID: <sashiko-outbox-163583@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 08/19] accel/amdxdna: Add clock, DPM frequency, and
 resource info queries for AIE4
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261008032348.2044667-9-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261008032348.2044667-1-yidong.zhang@amd.com>
 <20261008032348.2044667-9-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 03:48:24 +0000
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
- [Low] accel/amdxdna: uninitialized max_tops exposed if aie_update_counter=
s fails
--

commit ce83bedb3ca3d2c33f7c97c3535a3c4783281e8b
Author: David Zhang <yidong.zhang@amd.com>

accel/amdxdna: Add clock, DPM frequency, and resource info queries for AIE4

This commit adds support for querying clock metadata, DPM frequency table,
and hardware resource information for AIE4/NPU3 devices. It moves common
clock/TOPS counters into aie_device and adds firmware queries for DPM levels
and frequency tables.

> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie=
4_pci.c
> index c905dc75c0764..fdcf6b8602e9e 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -298,6 +298,17 @@ static int aie4_query(struct amdxdna_dev_hdl *ndev)
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
> +
>  	return 0;
>  }

[Severity: Low]
If aie4_init_dpm_freq_table() succeeds during AIE4 hardware start (e.g.,
for NPU3 devices), the fallback to set_dpm() is bypassed. Will this leave
ndev->aie.max_tops uninitialized?

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

[Severity: Low]
If ndev->aie.max_tops was left uninitialized (at 0) during startup, and
aie_update_counters() experiences a transient firmware failure, the return
value of aie_update_counters() is ignored.=20

Does this result in successfully copying 0 to userspace for the static
capability field npu_tops_max?

> +	res_info.npu_tops_curr =3D ndev->aie.curr_tops;
> +	/* Context accounting is populated in later patches in the series. */
> +
> +	buf_sz =3D min_t(u32, args->buffer_size, sizeof(res_info));
> +	if (copy_to_user(u64_to_user_ptr(args->buffer), &res_info, buf_sz))
> +		return -EFAULT;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008032348.2044=
667-1-yidong.zhang@amd.com?part=3D8
