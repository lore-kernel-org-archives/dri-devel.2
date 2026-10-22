Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9FB606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LoXqAE8m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96C701126BC;
	Thu, 22 Oct 2026 14:26:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF7FD11269C
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 14:26:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6524E433FB;
 Thu, 22 Oct 2026 14:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159AB1F000C1;
 Thu, 22 Oct 2026 14:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792679184;
 bh=8h8OXWqqtzOcuHWP8HSyVX5O+/mE3tXrALm3cLcMPOs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LoXqAE8masGGNwano1UoePt8lyOHA8dr1s5YceEcbLKjGE16pgXRZFLP3MPk0E3gR
 teHDDPoh9fhny3iPx22hbkV1nNkyGwOytyt9wbi97YnbWgpRMUx0oeQ3A/XzchYlDi
 xzv8ygdJNgvac0Ld1No+yufHu0CPD1shQYSgn5tuTXvRmflHOJzqjAwcscouK8EJL9
 NcsnM5dktvdUOjCEBUyHZhdikyyXSoYNptpXA9ULpI5z0HO2VN6Jsfs4rH9W3UscBs
 HgvCjCr2ypi9+owOGcm9qWd/hn0dmK3lNBpwhMUGpzbUbKSecphMy4zx5qY0AMsfZv
 MDl2DyZ5FpQvQ==
Message-ID: <sashiko-outbox-181631@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] clk: qcom: dispcc-sm8750: reset the MDSS blocks at
 probe when the bootloader left them running
To: "Qianhui Xu" <xiaqinghuan@mail.ustc.edu.cn>
Cc: linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261022140811.469417-1-xiaqinghuan@mail.ustc.edu.cn>
References: <20261022140811.469417-1-xiaqinghuan@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 14:26:23 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] clk: qcom: dispcc-sm8750: unconditional MDSS reset in disp_cc_sm87=
50_probe()
- [Medium] clk: qcom: BCR resets in disp_cc_sm8750_probe() do not reset loc=
ked PLLs
- [Medium] clk: qcom: dispcc-sm8750: undocumented compatible in disp_cc_sm8=
750_probe()
- [Medium] clk: qcom: dispcc-sm8750: raw BCR regmap_write() without mask or=
 readback
--

commit 996de5a901e9074e1f51bf1b7638e333551726e6
Author: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>

clk: qcom: dispcc-sm8750: reset the MDSS blocks at probe when the bootloade=
r left them running

This commit adds a board-specific reset sequence in disp_cc_sm8750_probe()
for "lenovo,elden" that asserts and deasserts three display block resets
with a 50 ms delay before configuring the display PLLs.

> diff --git a/drivers/clk/qcom/dispcc-sm8750.c b/drivers/clk/qcom/dispcc-s=
m8750.c
> index 3205ce5c1ad9e..f38ba86b4fd54 100644
> --- a/drivers/clk/qcom/dispcc-sm8750.c
> +++ b/drivers/clk/qcom/dispcc-sm8750.c

[ ... ]

> @@ -1932,6 +1934,39 @@ static int disp_cc_sm8750_probe(struct platform_de=
vice *pdev)
>  		goto err_put_rpm;
>  	}
> =20
> +	/*
> +	 * Some bootloaders hand over with the display block still fully
> +	 * active: dispcc PLLs locked and MDSS core / core_int2 / RSCC out of
> +	 * reset. Probing on top of that live state makes the command-mode
> +	 * panel fail to initialise (command DMA timeout, panel init -EIO).
> +	 *
> +	 * Assert the three block resets and release them before the PLLs are
> +	 * configured, so the block starts from a known-zero state.
> +	 *
> +	 * Limited to Lenovo Elden for now: it is the only board where this
> +	 * handover behaviour was observed and the fix verified.
> +	 */
> +	if (of_machine_is_compatible("lenovo,elden")) {

[Severity: Medium]
Is it valid to match against "lenovo,elden" in disp_cc_sm8750_probe() in
drivers/clk/qcom/dispcc-sm8750.c when that compatible string is not
documented in the device tree bindings?

In Documentation/devicetree/bindings/arm/qcom.yaml, the documented board
compatibles for qcom,sm8750 are:

      - items:
          - enum:
              - qcom,sm8750-mtp
              - qcom,sm8750-qrd
          - const: qcom,sm8750

Since active bootloader display handover can occur on other qcom,sm8750
boards as well, should this handover state be handled in the display driver
or described via documented bindings rather than hardcoding an undocumented
board compatible in the SoC clock driver?

> +		static const u16 elden_bcrs[] =3D {
> +			DISP_CC_MDSS_CORE_BCR,
> +			DISP_CC_MDSS_CORE_INT2_BCR,
> +			DISP_CC_MDSS_RSCC_BCR,
> +		};
> +		unsigned int reg;
> +		int i;
> +
> +		for (i =3D 0; i < ARRAY_SIZE(elden_bcrs); i++) {
> +			reg =3D disp_cc_sm8750_resets[elden_bcrs[i]].reg;
> +			regmap_write(regmap, reg, 0x1);
> +		}
> +		/* Hold for one full ~30 Hz frame before releasing. */
> +		msleep(50);
> +		for (i =3D ARRAY_SIZE(elden_bcrs) - 1; i >=3D 0; i--) {
> +			reg =3D disp_cc_sm8750_resets[elden_bcrs[i]].reg;
> +			regmap_write(regmap, reg, 0x0);
> +		}

[Severity: Medium]
Should disp_cc_sm8750_probe() in drivers/clk/qcom/dispcc-sm8750.c use raw
regmap_write() calls on the full 32-bit reset registers without a bitmask
or readback?

In drivers/clk/qcom/reset.c, qcom_reset_set_assert() updates only the
target reset bit and reads back the register to flush posted writes across
the interconnect:

    rst =3D to_qcom_reset_controller(rcdev);
    map =3D &rst->reset_map[id];
    mask =3D map->bitmask ? map->bitmask : BIT(map->bit);

    regmap_update_bits(rst->regmap, map->reg, mask, assert ? mask : 0);

    /* Read back the register to ensure write completion, ignore the value =
*/
    regmap_read(rst->regmap, map->reg, &mask);

Could overwriting the entire register with 0x1 and 0x0 via regmap_write()
clobber other bits in those registers, and allow posted writes to remain
buffered when the msleep(50) delay begins?

> +	}

[Severity: High]
Can unconditionally resetting DISP_CC_MDSS_CORE_BCR,
DISP_CC_MDSS_CORE_INT2_BCR, and DISP_CC_MDSS_RSCC_BCR in
disp_cc_sm8750_probe() in drivers/clk/qcom/dispcc-sm8750.c cause
regressions during boot and driver probe?

disp_cc_sm8750_probe() is the clock, reset, and power domain provider,
whereas the consumer driver in drivers/gpu/drm/msm/msm_mdss.c already
handles resetting the display block during msm_mdss_init() via
msm_mdss_reset():

static int msm_mdss_reset(struct device *dev)
{
    struct reset_control *reset;

    reset =3D reset_control_get_optional_exclusive(dev, NULL);
    ...
    reset_control_assert(reset);
    msleep(20);
    reset_control_deassert(reset);
    reset_control_put(reset);

    return 0;
}

Running this reset inside disp_cc_sm8750_probe() happens before the drm/msm
driver probes and calls aperture_remove_all_conflicting_devices() in
drivers/gpu/drm/msm/msm_kms.c. If a bootloader framebuffer (such as
simpledrm or efifb) is active, or if drm/msm is disabled, modular, or
deferred, asserting these resets in disp_cc_sm8750_probe() will tear down
active display scanout and ongoing dma traffic.

In addition, this reset loop executes before qcom_cc_really_probe()
initializes mdss_gdsc and mdss_int2_gdsc via gdsc_init() in
drivers/clk/qcom/gdsc.c and before qcom_cc_clk_regs_configure() enables
disp_cc_sm8750_critical_cbcrs (DISP_CC_SLEEP_CLK, DISP_CC_XO_CLK,
DISP_CC_MDSS_RSCC_AHB_CLK, and DISP_CC_MDSS_RSCC_VSYNC_CLK), without
verifying that mdss_gdsc and mdss_int2_gdsc are powered on.

Would it be safer to handle the reset requirements in msm_mdss_reset() in
drivers/gpu/drm/msm/msm_mdss.c and the device tree reset properties rather
than in disp_cc_sm8750_probe()?

> +
>  	clk_taycan_elu_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_confi=
g);
>  	clk_taycan_elu_pll_configure(&disp_cc_pll1, regmap, &disp_cc_pll1_confi=
g);
>  	clk_pongo_elu_pll_configure(&disp_cc_pll2, regmap, &disp_cc_pll2_config=
);

[Severity: Medium]
Does asserting elden_bcrs[] in disp_cc_sm8750_probe() in
drivers/clk/qcom/dispcc-sm8750.c actually allow
clk_taycan_elu_pll_configure() and clk_pongo_elu_pll_configure() to
reprogram locked PLLs as described in the comment and commit message?

The comment states:

    Assert the three block resets and release them before the PLLs are
    configured, so the block starts from a known-zero state.

However, DISP_CC_MDSS_CORE_BCR, DISP_CC_MDSS_CORE_INT2_BCR, and
DISP_CC_MDSS_RSCC_BCR only reset the downstream display sub-blocks and do
not reset or unlock disp_cc_pll0, disp_cc_pll1, or disp_cc_pll2.

When the bootloader leaves those PLLs locked,
clk_taycan_elu_pll_configure() (which maps to clk_lucid_evo_pll_configure()
in drivers/clk/qcom/clk-alpha-pll.c) still returns early without
programming the PLL:

    if (trion_pll_is_enabled(pll, regmap)) {
        pr_debug("Lucid Evo PLL is already enabled, skipping configuration\=
n");
        return;
    }

And clk_pongo_elu_pll_configure() in drivers/clk/qcom/clk-alpha-pll.c does
the same:

    if (trion_pll_is_enabled(pll, regmap))
        return;

Also, disp_cc_sm8750_probe() does not check whether the display blocks or
PLLs were left running by the bootloader before asserting the resets and
sleeping for 50 ms. Should the code and comment be updated to reflect that
the block resets do not reset the PLLs and check whether the hardware is
actually active?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022140811.4694=
17-1-xiaqinghuan@mail.ustc.edu.cn?part=3D1
