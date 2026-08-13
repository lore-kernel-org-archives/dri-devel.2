Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A542C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 22:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3AC910F56C;
	Thu, 13 Aug 2026 22:08:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HlFZ+duC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF51210F56C
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 22:08:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 32CB9600E2;
 Thu, 13 Aug 2026 22:08:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E3F1F00A3A;
 Thu, 13 Aug 2026 22:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786658935;
 bh=jrIPcVMxnlPuMal3sqo6bMxQqKnvMvX+SDQSujKpJ2w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HlFZ+duC2cFng8SsYcZxrwBNwMHvT484VD9ajyQcMkM4E8ugNmJDqzc8bDyyHtaf1
 yKdO2Vjw2pt5GAj9nFxK6S1bLAN7Svn9ocYvx8jtwfPeqECxlfZCA0EI9C8v6Io1zA
 GFmaRiwIkUrynNi95ttSKUx8RCCnDBZR4JDk4PMUxArPqNszO0RlEhTLnahOwVETn8
 ookQISJ6PMW1mDaPOTTAZLLuH7v6p7Ry95ZSmlR4mmZ/NAc+UOMY2S1OVMEPIi+QMY
 DuxI44MDJ1rCjIosb1ixkGO/wakktAOeo9b1HmwGtCesnv6cu/pBBSCd3E9HKQItqO
 plGA4oZznc+BQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/4] drm/msm/hdmi: switch to generic PHY subsystem
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
 olteanv@gmail.com, neil.armstrong@linaro.org, vkoul@kernel.org
In-Reply-To: <20260319-fd-hdmi-phy-v6-1-cefc08a55470@oss.qualcomm.com>
References: <20260319-fd-hdmi-phy-v6-1-cefc08a55470@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 22:08:55 +0000
Message-Id: <20260813220855.A9E3F1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 11 potential issue=
(s) to consider:
- [Critical] Hardcoded `devm_platform_ioremap_resource` indices scramble re=
gister mappings and cause fatal probe failures.
- [High] CCF integration broken by removing `.set_rate` from HDMI PLL
- [High] Hardware initialization failure due to inverted clock enablement s=
equence.
- [High] `qmp_hdmi_8998_pll_recalc_rate` calculates drastically incorrect c=
lock rates.
- [High] Severe integer truncation when setting the VCO calibration value i=
n 28lpm PHY.
- [High] Unclocked MMIO access when `hdmipll` is queried via debugfs.
- [High] Out-of-bounds array read in `qcom_hdmi_8960_pll_recalc_rate`.
- [Medium] Early return on `phy_power_on` failure causes unbalanced teardow=
n in `post_disable`.
- [Medium] Missing NULL check for `of_device_get_match_data()` return value=
 in QMP PHY probe.
- [Low] Uninitialized variable `div` is accessed and logged.
- [Low] Potential 32-bit arithmetic overflow during PLL frequency calculati=
ons.
--

--- Patch [1]: [PATCH v6 1/4] drm/msm/hdmi: switch to generic PHY subsystem=
 ---
commit 15860658522d56d641b98cdb28bb259cda20b0de
Author: Dmitry Baryshkov <lumag@kernel.org>
Subject: drm/msm/hdmi: switch to generic PHY subsystem

This commit changes the MSM HDMI driver to use the generic PHY subsystem.
Moving PHY drivers allows better code sharing with the rest of the PHY syst=
em.

Note: The format of this review is altered due to recitation restrictions. =
I am
providing a free-form summary of the findings rather than directly quoting =
the
original patch code.

[Severity: High]
In drivers/phy/qualcomm/phy-qcom-qmp-hdmi-msm8996.c, the hdmipll clock
operations (qmp_hdmi_8996_pll_ops) define .recalc_rate, .determine_rate, and
.is_enabled, but omit .set_rate.

Concurrently, in drivers/gpu/drm/msm/hdmi/hdmi_bridge.c,
msm_hdmi_bridge_atomic_pre_enable() calls clk_set_rate(hdmi->extp_clk,
hdmi->pixclock). Does this break the CCF integration? Because the hdmipll
clock operations omit .set_rate, the CCF's clk_calc_new_rates() strictly
rejects the rate change with -EINVAL. The failure propagates back, leaving =
the
downstream multimedia clock controller dividers unconfigured and resulting =
in
no display output.

[Severity: Critical]
In drivers/phy/qualcomm/phy-qcom-qmp-hdmi-base.c, qmp_hdmi_probe() uses
hardcoded indices for devm_platform_ioremap_resource: index 0 for serdes and
index 5 for phy_reg. Similarly, in drivers/phy/qualcomm/phy-qcom-hdmi-preqm=
p.c,
qcom_hdmi_preqmp_probe() maps pll_reg using index 1.

Will this cause probe failures and scramble register mappings? Standard dev=
ice
trees for qcom,hdmi-phy-8996 define hdmi_phy at index 0 and hdmi_pll at ind=
ex
5, swapping the expected memory regions. Furthermore, on msm8x60 platforms,=
 the
device tree supplies only 1 resource (hdmi_phy), so unconditionally request=
ing
index 1 for the PLL throws an error and causes the probe to fail entirely.
Mapping resources by name is safer.

[Severity: High]
In drivers/gpu/drm/msm/hdmi/hdmi_bridge.c, msm_hdmi_bridge_atomic_pre_enabl=
e()
calls phy_power_on(hdmi->phy) before enabling the external pixel clock
(hdmi->extp_clk).

Will the PLL lock poll timeout because the reference clock isn't available =
yet?
The new sequence sets the PLL registers and actively polls for the hardware
lock status in qmp_hdmi_8996_phy_power_on() (in
drivers/phy/qualcomm/phy-qcom-qmp-hdmi-msm8996.c). However, the reference c=
lock
is not actively running when the PHY tries to lock the PLL, so the polling =
loop
inevitably times out and fails.

[Severity: Medium]
In drivers/gpu/drm/msm/hdmi/hdmi_bridge.c, msm_hdmi_bridge_atomic_pre_enabl=
e()
returns early if phy_power_on() fails, but before the early return,
hdmi->power_on is set to true.

Does this create an unbalanced teardown if phy_power_on() fails? The DRM co=
re
will subsequently call msm_hdmi_bridge_atomic_post_disable(), which disables
clocks and HDCP unconditionally, attempting to undo operations that the ear=
ly
return skipped.

[Severity: High]
In drivers/phy/qualcomm/phy-qcom-qmp-hdmi-msm8998.c,
qmp_hdmi_8998_pll_recalc_rate() returns mult_frac(pll_cmp + 1, parent_rate,
HDMI_PLL_CMP_CNT).

Does this return an unscaled value instead of the true pixel clock rate? The
function computes the output rate strictly as fdata / 10. However, the driv=
er
configures fdata using fdata =3D (rate * 10 >> half_rate_mode) * (1 <<
tx_band_sel). Therefore, dividing fdata by 10 yields rate * (1 << tx_band_s=
el)
>> half_rate_mode. The function fails to account for tx_band_sel and
half_rate_mode, incorrectly inflating the reported pixel clock by factors o=
f 2x,
4x, or 8x.

[Severity: High]
In drivers/phy/qualcomm/phy-qcom-hdmi-28lpm.c, qcom_28lpm_set_rate() comput=
es
the VCO calibration config via vco_freq / 1000 and passes it to write16().

Is there an integer truncation happening when setting the VCO calibration v=
alue?
Since vco_freq is in Hz, this yields a KHz value. When passed into write16(=
),
this u32 value overflows the expected u16 limit and truncates, causing garb=
age
values to be written to the PHY calibration registers. The hardware expects=
 MHz
(vco_freq / 1000000).

[Severity: High]
In drivers/phy/qualcomm/phy-qcom-qmp-hdmi-base.c and
drivers/phy/qualcomm/phy-qcom-hdmi-preqmp.c, the hdmipll clock is initializ=
ed
with the CLK_GET_RATE_NOCACHE flag.

Will this cause an unclocked MMIO access crash if queried via debugfs? This
flag forces the CCF to dynamically read hardware registers even when suspen=
ded.
If the display is turned off and the PHY is in a runtime PM suspended state,
this unclocked read from user space (e.g., reading
/sys/kernel/debug/clk/clk_summary) will crash the system via an external ab=
ort
or hard hang.

[Severity: High]
In drivers/phy/qualcomm/phy-qcom-hdmi-28lpm.c, qcom_hdmi_8960_pll_recalc_ra=
te()
fetches div_idx directly from REG_HDMI_8960_PHY_PLL_REFCLK_CFG, shifts it r=
ight
by 4, and uses it as an index into the 4-element qcom_hdmi_8960_divs array.

Can this perform an out-of-bounds array read? The value is never bitmasked
(e.g., & 0x3), so any non-zero value residing in bits 6 or higher will gene=
rate
an array index greater than 3, leading to an out-of-bounds memory read.

[Severity: Medium]
In drivers/phy/qualcomm/phy-qcom-qmp-hdmi-base.c, qmp_hdmi_probe() assigns =
cfg
from of_device_get_match_data() and then dereferences it unconditionally
(init.ops =3D cfg->pll_ops).

Should there be a check for the return value of of_device_get_match_data()?=
 If
the driver is forcefully bound to a device via sysfs,
of_device_get_match_data() will return NULL, causing a NULL pointer derefer=
ence.

[Severity: Low]
In drivers/phy/qualcomm/phy-qcom-hdmi-28lpm.c, qcom_28lpm_set_rate() declar=
es
the local variable unsigned int div and passes it directly to dev_dbg().

Is the div variable logged uninitialized here? This prints garbage values i=
nto
kernel debug logs and could trigger memory sanitizers.

[Severity: Low]
In drivers/phy/qualcomm/phy-qcom-qmp-hdmi-msm8998.c,
qmp_hdmi_8998_pll_get_post_div() calculates rvar1 =3D HDMI_DEFAULT_REF_CLOC=
K *
rng1 * HZ_PER_MHZ.

Could this result in a 32-bit arithmetic overflow? HZ_PER_MHZ is defined as
1000000UL. On 32-bit architectures, this forces an unsigned long 32-bit
multiplication, wrapping around before being assigned to u64. Explicit cast=
ing
to u64 would secure this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260319-fd-hdmi-ph=
y-v6-0-cefc08a55470@oss.qualcomm.com?part=3D1
