Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E15C4452F
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:40:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8950D10E771;
	Tue, 21 Jul 2026 12:40:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SnKR3sgc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F7C010E771
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 12:40:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 559C0600BB
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 12:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00041F00A3A;
 Tue, 21 Jul 2026 12:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784637606;
 bh=6Lb3rPLSBKgFgH67y/vyAXqj3AnUa5ziIsUXJys/CL0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SnKR3sgcdkKqbcTCyDXtiCvJL+Y1TxwfWE6ejJIk0P+R2nluAPT0PPuUXpw/5XKSC
 pPWpP5gOaejTYIPCHYNiWsLr5nfZ8L5retwDzfenOQT1Vu5QghzZB+wW90jkjjH11J
 7b1m8SMhODMkODd86RPhf0l2K96ZrdkQQ9KmBAvKK4MPautecaUMPlxlMsVkp+mDiB
 BOBifj68tQeCTKYrK5AhUL+thpKg/fMnc+Rwj9pcw/m/pV+tVzYQdzsDqeuZerdk5x
 pk2sd+0e3bfUtBmYJVBF0LyTMLOpEyLpyHqBrc+1BAfLu+i1gztHmkqQJhPM7XF6te
 BA/0sxRrp1EQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] soc: qcom: ubwc: Get HBB from SMEM
To: "Konrad Dybcio" <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260721-topic-smem_dramc-v4-2-748f992278a3@oss.qualcomm.com>
References: <20260721-topic-smem_dramc-v4-0-748f992278a3@oss.qualcomm.com>
 <20260721-topic-smem_dramc-v4-2-748f992278a3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 12:40:05 +0000
Message-Id: <20260721124005.E00041F00A3A@smtp.kernel.org>
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
- [High] A race condition between SMEM probing and `qcom_ubwc_config_get_da=
ta()` can cause the driver to bypass probe deferral, incorrectly fall back =
to default UBWC data, and return mismatched configurations to concurrent ca=
llers.
- [Low] Missing Kconfig dependency on QCOM_SMEM causes linker errors when Q=
COM_UBWC_CONFIG is selected but QCOM_SMEM is disabled or built as a module.
--

--- Patch [2]: [PATCH v4 2/2] soc: qcom: ubwc: Get HBB from SMEM ---
commit e0bf0c57e180329e2b45423901bc2dc1b3492f77
Author: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

soc: qcom: ubwc: Get HBB from SMEM

This commit updates the UBWC configuration driver to dynamically retrieve
the Highest Bank Bit (HBB) from SMEM. If SMEM is not yet available, it
returns -EPROBE_DEFER. Once available, it allocates and updates a copy of
the UBWC configuration data with the retrieved HBB value.

> diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_confi=
g.c
> index 0209a02c390f0..23901a4c51f73 100644
> --- a/drivers/soc/qcom/ubwc_config.c
> +++ b/drivers/soc/qcom/ubwc_config.c
[ ... ]
> @@ -168,9 +169,25 @@ static const struct of_device_id qcom_ubwc_configs[]=
 __maybe_unused =3D {
>  	{ }
>  };
> =20
> +static struct qcom_ubwc_cfg_data *cfg;
> +static DEFINE_MUTEX(cfg_mutex);
> +/**
> + * qcom_ubwc_config_get_data() - Retrieve UBWC data for the platform.
> + *
> + * Return: Pointer to valid struct qcom_ubwc_cfg_data on success, negati=
ve
> + * errno on failure. Note that this may return EPROBE_DEFER.
> + */
>  const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(void)
>  {
>  	const struct qcom_ubwc_cfg_data *data;
> +	int hbb;
> +
> +	guard(mutex)(&cfg_mutex);
> +	if (cfg)
> +		return cfg;
> +
> +	if (!qcom_smem_is_available())
> +		return ERR_PTR(-EPROBE_DEFER);

[Severity: Low]
Will this cause linker errors if the kernel is configured with
CONFIG_QCOM_UBWC_CONFIG=3Dy but CONFIG_QCOM_SMEM=3Dm or CONFIG_QCOM_SMEM=3D=
n?

Since these SMEM functions are called unconditionally without stub
implementations provided for when SMEM is disabled, it seems dependent driv=
ers
selecting QCOM_UBWC_CONFIG might trigger undefined reference errors during
the build.

>  	data =3D of_machine_get_match_data(qcom_ubwc_configs);
>  	if (!data) {
> @@ -178,9 +195,30 @@ const struct qcom_ubwc_cfg_data *qcom_ubwc_config_ge=
t_data(void)
>  		return ERR_PTR(-EINVAL);
>  	}
> =20
> -	return data;
> +	hbb =3D qcom_smem_dram_get_hbb();

[Severity: High]
Can a race condition occur between SMEM probing and this function, causing
it to bypass probe deferral and use incorrect default data?

In drivers/soc/qcom/smem.c:qcom_smem_probe(), the global __smem pointer is
published before the DRAM data is populated:

drivers/soc/qcom/smem.c:qcom_smem_probe() {
    ...
    __smem =3D smem;
    ...
    smem->debugfs_dir =3D smem_dram_parse(smem->dev);
    ...
}

If a driver calls qcom_ubwc_config_get_data() concurrently during this
window, qcom_smem_is_available() would return true, but
qcom_smem_dram_get_hbb() would return -ENODATA because __dram is not
populated yet.

> +	if (hbb =3D=3D -ENODATA) {
> +		/* Lack of HBB data is OK - it was only introduced later */
> +		return data;

Would this result in interpreting a transient initialization state as a
permanent lack of HBB data, returning mismatched configurations that could
cause issues like graphical corruption or SMMU faults across IP blocks that
share UBWC memory?

> +	} else if (hbb < 0) {
> +		pr_err("Couldn't get HBB data from SMEM: %d\n", hbb);
> +		return ERR_PTR(hbb);
> +	}
> +
> +	cfg =3D kmemdup(data, sizeof(*data), GFP_KERNEL);
> +	if (!cfg)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cfg->highest_bank_bit =3D hbb;
> +
> +	return cfg;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-topic-smem=
_dramc-v4-0-748f992278a3@oss.qualcomm.com?part=3D2
