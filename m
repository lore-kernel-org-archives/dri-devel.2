Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379C1C4452F
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:37:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F61910E33D;
	Tue, 21 Jul 2026 12:37:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Tdq87CEJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF1FE10E33D
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 12:37:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0AB8160A59
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 12:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949961F000E9;
 Tue, 21 Jul 2026 12:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784637436;
 bh=ijHyHCT1kNZoYw74s+/G4WF0USVAAfJRUH2ReuqdRNs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Tdq87CEJ7tSaFIrkoWVhYIAomkXxiWZ6YjxC0XDXesxS5tToRx8YHYChyIFPggKed
 X9sPQJe3kIQ+tcyRvxWqaX6DWOqmLRtW6Zo2539uG8Hb5Wkwg0+pgRCpC0XRi46Yry
 3aPC1w4pwT+WhIMKafka2YWmkF6saUf3/PTX7Z6S7pbj13Y9FG2yTbHBZGR2OaJE0G
 UFmZYjhPN99op5qOQtcsQ2YOHj3iJAoaVGSrO8uQQtjguocWpwW+gDy90NS5HQWBLf
 Rs5Z0mx4K0UfQ3tGUbAQ94k/aVFeL7g3nacrKGdgrM3FO/fLM1JAz1RXIjtmqUpXCP
 gBscuhcAJIemA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] soc: qcom: smem: Expose DDR data from SMEM
To: "Konrad Dybcio" <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260721-topic-smem_dramc-v4-1-748f992278a3@oss.qualcomm.com>
References: <20260721-topic-smem_dramc-v4-0-748f992278a3@oss.qualcomm.com>
 <20260721-topic-smem_dramc-v4-1-748f992278a3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 12:37:16 +0000
Message-Id: <20260721123716.949961F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

New issues:
- [High] The global pointer `__dram` is assigned memory managed by `devm_kz=
alloc`, but is never cleared to `NULL` upon driver removal, leading to a Us=
e-After-Free when accessed by other drivers.
- [High] Firmware/hardware SMEM structures incorrectly use the configurable=
 `phys_addr_t` type, breaking binary compatibility with the fixed firmware =
layout.
- [High] `debugfs_remove_recursive()` is called twice on the same dentry if=
 `socinfo` registration fails, leading to a Double-Free/Use-After-Free.
- [Medium] The `__le32` field `freq_khz` is used directly in an arithmetic =
operation without conversion to native CPU endianness.
- [Medium] Multiplying `freq_khz` by `1000` evaluates as a 32-bit unsigned =
integer, which will overflow for memory frequencies above ~4.29 GHz.
- [Medium] The global `__smem` pointer is published before `smem_dram_parse=
()` completes, allowing concurrent callers to `qcom_smem_dram_get_hbb()` to=
 erroneously observe a NULL `__dram`.
- [Medium] The global `__dram` pointer is written and read locklessly witho=
ut necessary memory barriers, risking exposure of uninitialized struct fiel=
ds to concurrent readers.

Pre-existing issues:
- [High] `platform_device_unregister()` is unconditionally called with an `=
ERR_PTR` if `socinfo` registration fails, leading to a crash.
--

--- Patch [1]: [PATCH v4 1/2] soc: qcom: smem: Expose DDR data from SMEM ---
commit 21c7410afeccade097a3fa15bf0554d407b561bb
Author: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

soc: qcom: smem: Expose DDR data from SMEM

Most modern Qualcomm platforms (>=3D SM8150) expose information about the
DDR memory present on the system via SMEM.

Details from this information is used in various scenarios, such as
multimedia drivers configuring the hardware based on the "Highest Bank
address Bit" (hbb), or the list of valid frequencies in validation
scenarios...

Add support for parsing v3-v7 version of the structs. Unforunately,
they are not versioned, so some elbow grease is necessary to determine
which one is present. See for reference:

ver 3: https://git.codelinaro.org/clo/la/abl/tianocore/edk2/-/commit/1d1189=
7d2cfcc7b85f28ff74c445018dbbecac7a
ver 4: https://git.codelinaro.org/clo/la/abl/tianocore/edk2/-/commit/f6e9aa=
549260bbc0bdcb156c2b05f48dc5963203
ver 5: https://git.codelinaro.org/clo/la/abl/tianocore/edk2/-/commit/617d32=
97abe8b1b8dd3de3d1dd69c3961e6f343f
ver 5 with 6regions: https://git.codelinaro.org/clo/la/abl/tianocore/edk2/-=
/commit/d770e009f9bae58d56d926f7490bbfb45af8341f
ver 6: https://git.codelinaro.org/clo/la/abl/tianocore/edk2/-/commit/62659b=
557fdb1551b20fae8073d1d701dfa8a62e
ver 7: https://git.codelinaro.org/clo/la/abl/tianocore/edk2/-/commit/734d95=
599c5ebb1ca0d4e1639142e65c590532b7

Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index afb21a778fe7b..4315512d3a1d4 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c

[ ... ]

> @@ -1239,17 +1244,24 @@ static int qcom_smem_probe(struct platform_device=
 *pdev)
> =20
>  	__smem =3D smem;
> =20
> +	smem->debugfs_dir =3D smem_dram_parse(smem->dev);

[Severity: Medium]
Is it safe to publish the global __smem pointer before smem_dram_parse
completes?

If a concurrent driver probe calls qcom_smem_is_available, it will return
true, and the driver might then call qcom_smem_dram_get_hbb. Since the
__dram pointer hasn't been initialized yet, wouldn't the caller falsely
receive -ENODATA?

> +
>  	smem->socinfo =3D platform_device_register_data(&pdev->dev, "qcom-socin=
fo",
>  						      PLATFORM_DEVID_NONE, NULL,
>  						      0);
> -	if (IS_ERR(smem->socinfo))
> +	if (IS_ERR(smem->socinfo)) {
> +		debugfs_remove_recursive(smem->debugfs_dir);
> +

[Severity: High]
This is a pre-existing issue, but if platform_device_register_data fails, it
returns an ERR_PTR which is stored in smem->socinfo.

Since probe still returns 0 (success) in this case, when the driver is later
removed, qcom_smem_remove will pass this ERR_PTR directly to
platform_device_unregister. Could this cause a crash when the driver core
attempts to dereference it?

[Severity: High]
Additionally, when socinfo registration fails, we call
debugfs_remove_recursive on smem->debugfs_dir, but we leave the pointer
intact.

When the driver is later unbound, qcom_smem_remove calls
debugfs_remove_recursive again on __smem->debugfs_dir. Does this trigger a
double-free or use-after-free in the debugfs core?

>  		dev_dbg(&pdev->dev, "failed to register socinfo device\n");
> +	}
> =20
>  	return 0;
>  }
> =20
>  static void qcom_smem_remove(struct platform_device *pdev)
>  {
> +	debugfs_remove_recursive(__smem->debugfs_dir);
> +

[Severity: High]
When the driver is unbound, the devm-managed dram memory allocated in
smem_dram_parse will be freed.

However, the global __dram pointer is never cleared to NULL. If an external
driver later calls the exported qcom_smem_dram_get_hbb, will it bypass the
NULL check and dereference the freed memory?

>  	platform_device_unregister(__smem->socinfo);
> =20
>  	xa_destroy(&__smem->partitions);

[ ... ]

> diff --git a/drivers/soc/qcom/smem_dramc.c b/drivers/soc/qcom/smem_dramc.c
> new file mode 100644
> index 0000000000000..2998573a6e074
> --- /dev/null
> +++ b/drivers/soc/qcom/smem_dramc.c

[ ... ]

> +/* V3 */
> +struct ddr_freq_plan_v3 {
> +	struct ddr_freq_table ddr_freq[MAX_DDR_FREQ_NUM_V3];
> +	u8 num_ddr_freqs;
> +	phys_addr_t clk_period_address;
> +};

[Severity: High]
Does using phys_addr_t in these firmware structures break binary compatibil=
ity?

Since the size of phys_addr_t depends on kernel configuration (e.g., 32-bit=
 vs
64-bit), this could alter the structure layout and offsets. Should these use
explicit fixed-width types like u32 or u64 to match the fixed firmware ABI?
(This also appears to affect ddr_xbl2quantum_smem_data and ddr_freq_plan_v5=
).

[ ... ]

> +int qcom_smem_dram_get_hbb(void)
> +{
> +	if (!__dram || !__dram->hbb)
> +		return -ENODATA;

[Severity: Medium]
Are memory barriers required here?

Since smem_dram_parse writes to the global __dram pointer without
smp_store_release, and this function reads it without smp_load_acquire, cou=
ld
CPU or compiler reordering cause concurrent readers to observe a non-NULL
pointer but read uninitialized values from its fields?

[ ... ]

> +static void smem_dram_parse_v3_data(struct smem_dram *dram, void *data)
> +{
> +	struct ddr_details_v3 *details =3D data;
> +
> +	for (int i =3D 0; i < MAX_DDR_FREQ_NUM_V3; i++) {
> +		struct ddr_freq_table *freq_entry =3D &details->ddr_freq_tbl.ddr_freq[=
i];
> +
> +		if (freq_entry->freq_khz && freq_entry->enabled) {
> +			u32 freq_khz =3D le32_to_cpu(freq_entry->freq_khz);
> +			dram->frequencies[dram->num_frequencies++] =3D 1000 * freq_khz;

[Severity: Medium]
Can this multiplication overflow on modern high-speed memory?

The expression 1000 * freq_khz uses a 32-bit unsigned integer multiplicatio=
n.
If the frequency exceeds 4,294,967 kHz, the value will wrap around before
being implicitly promoted to unsigned long for the array assignment. Would =
it
help to cast freq_khz to unsigned long first? (This logic appears in
smem_dram_parse_v5_data as well).

> +		}
> +	}
> +}
> +
> +static void smem_dram_parse_v3_14freqs_data(struct smem_dram *dram, void=
 *data)
> +{
> +	struct ddr_details_v3_14freqs *details =3D data;
> +
> +	for (int i =3D 0; i < MAX_DDR_FREQ_NUM_V3 + 1; i++) {
> +		struct ddr_freq_table *freq_entry =3D &details->ddr_freq_tbl.ddr_freq[=
i];
> +
> +		if (freq_entry->freq_khz && freq_entry->enabled)
> +			dram->frequencies[dram->num_frequencies++] =3D 1000 * freq_entry->fre=
q_khz;

[Severity: Medium]
Is the little-endian to CPU conversion missing here?

In the other parsing functions, le32_to_cpu is used to read freq_khz. Here =
it
is read directly, which might result in incorrect frequency calculations on
big-endian systems.

> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-topic-smem=
_dramc-v4-0-748f992278a3@oss.qualcomm.com?part=3D1
