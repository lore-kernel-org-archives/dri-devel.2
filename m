Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F488CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 544D4112263;
	Thu, 15 Oct 2026 09:31:17 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5FC9112263
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:31:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 921D242B71;
 Thu, 15 Oct 2026 09:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101951F000C4;
 Thu, 15 Oct 2026 09:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792056671;
 bh=GDJE28v9HplFhKmYK8FEc1hvo6u/H16zAbKH8PclBc0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LzgJtwf4I5HWz54pyaEGELFSlr9tQcGEZ08+Iv/PBFZQxM84CjrDkZFfSbKmDwpAb
 0gA6+VdocLrKkT+qp9nBG3D1mpOIWimQigYJmymlId0IAjF579HTdzuMLFcXGSRE3v
 wbauKk5nsKsdKpzNbE5HUIcligoU3IamVZ6HSleL4/vk8RFMo4bXedP/s1hfWooXfE
 D8NYxKQNh+v1OXlojOak9ouRk4Ptxolt6YicoBo8UR352voF9DFDkKAzE2lXAC36cF
 p1TXQ4blssTIrS4Rc/p/6PFkEjBl/yVMLMLMC3gb9xdx4cQwz5OlV3dxVp5vr2c5hL
 R/9D35krhWs9w==
Message-ID: <sashiko-outbox-172577@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/9] regulator: add Qualcomm LCDB driver
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 mfd@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, lee@kernel.org
In-Reply-To: <20261015-sm8150-display-card-v1-5-5c14928cef29@oss.qualcomm.com>
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
 <20261015-sm8150-display-card-v1-5-5c14928cef29@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 09:31:10 +0000
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
- [High] regulator: qcom-lcdb: LDO pull-down left forced on after disable e=
rror
- [High] regulator: qcom-lcdb: self-deadlock in short-circuit notifier chain
- [High] regulator: qcom-lcdb: state desync on SC recovery failure
- [Medium] regulator: qcom-lcdb: internal state corrupted on hardware write=
 failure
--

commit 5e78a1b6d6d6c5c217f997a1d7627dc506e8ba37
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

regulator: add Qualcomm LCDB driver

Adds a driver for the LCDB block found on Qualcomm PMICs (PMI632, PM6150L,
PM8150L) to provide positive and negative bias rails for LCD panels. The
driver supports enabling with voltage ramp-up and disabling with an LDO
pull-down.

> diff --git a/drivers/regulator/qcom-lcdb-regulator.c b/drivers/regulator/=
qcom-lcdb-regulator.c
> new file mode 100644
> index 0000000000000..45b3b7118e31d
> --- /dev/null
> +++ b/drivers/regulator/qcom-lcdb-regulator.c
[ ... ]
> +static int qcom_lcdb_module_disable(struct qcom_lcdb *lcdb)
> +{
> +	int ret;
> +
> +	/* Force the LDO pull-down to discharge the output quickly */
> +	ret =3D regmap_write(lcdb->regmap, lcdb->base + LCDB_LDO_FORCE_PD_CTL,
> +			   LCDB_LDO_FORCE_PD_EN | LCDB_LDO_FORCE_PD_MODE);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(lcdb->regmap, lcdb->base + LCDB_ENABLE_CTL1, 0);
> +	if (ret)
> +		return ret;

[Severity: High]
If the regmap_write() to LCDB_ENABLE_CTL1 fails, the function returns
early without reverting the prior LCDB_LDO_FORCE_PD_CTL write. Will this
leave the physical regulator shorted to ground with the strong pull-down
resistor active while the LDO remains enabled?

> +
> +	lcdb->off_time =3D ktime_get();
> +
> +	usleep_range(10000, 11000);
> +
> +	return regmap_write(lcdb->regmap, lcdb->base + LCDB_LDO_FORCE_PD_CTL, 0=
);
> +}
[ ... ]
> +static int qcom_lcdb_disable(struct regulator_dev *rdev)
> +{
> +	struct qcom_lcdb *lcdb =3D rdev_get_drvdata(rdev);
> +
> +	guard(mutex)(&lcdb->lock);
> +
> +	lcdb->enabled_mask &=3D ~BIT(rdev_get_id(rdev));
> +	if (lcdb->enabled_mask)
> +		return 0;
> +
> +	return qcom_lcdb_module_disable(lcdb);
> +}

[Severity: Medium]
Does clearing lcdb->enabled_mask before qcom_lcdb_module_disable() completes
permanently desynchronize the software state if the hardware disablement
fails?=20

If the write fails, the mask will remain cleared, causing qcom_lcdb_is_enab=
led()
to return false even though the hardware is still active. This misalignment
might cause the next enable call to incorrectly execute the ramp-up sequence
on an already active rail.

[ ... ]
> +static int qcom_lcdb_set_voltage_sel(struct regulator_dev *rdev, unsigne=
d int sel)
> +{
> +	struct qcom_lcdb *lcdb =3D rdev_get_drvdata(rdev);
> +
> +	guard(mutex)(&lcdb->lock);
> +
> +	lcdb->uV[rdev_get_id(rdev)] =3D qcom_lcdb_sel_to_uV(sel);
> +
> +	return qcom_lcdb_write_voltages(lcdb, lcdb->uV[LCDB_LDO],
> +					lcdb->uV[LCDB_NCP]);
> +}

[Severity: Medium]
If qcom_lcdb_write_voltages() fails, the cached lcdb->uV array will already
have been updated. Will this cause subsequent calls to qcom_lcdb_get_voltag=
e_sel()
to return the new but unapplied voltage instead of the actual hardware
state?

[ ... ]
> +static void qcom_lcdb_handle_sc(struct qcom_lcdb *lcdb)
> +{
> +	int i;
> +
> +	guard(mutex)(&lcdb->lock);
> +
> +	if (!lcdb->enabled_mask || lcdb->sc_disabled)
> +		return;
> +
> +	qcom_lcdb_module_disable(lcdb);
> +
> +	if (ktime_us_delta(ktime_get(), lcdb->sc_time) > LCDB_SC_RESET_CNT_DLY_=
US) {
> +		lcdb->sc_count =3D 0;
> +	} else if (lcdb->sc_count > LCDB_SC_CNT_MAX) {
> +		dev_err(lcdb->dev, "persistent short circuit, keeping the outputs off\=
n");
> +		lcdb->sc_disabled =3D true;
> +
> +		for (i =3D 0; i < LCDB_NUM_RAILS; i++)
> +			regulator_notifier_call_chain(lcdb->rdev[i],
> +						      REGULATOR_EVENT_FAIL, NULL);
> +		return;
> +	}

[Severity: High]
Can calling the synchronous notifier chain with lcdb->lock held result in a
self-deadlock?

Consumers often react to REGULATOR_EVENT_FAIL by attempting to disable the
failing regulator via regulator_disable(). This acquires rdev->mutex and
then invokes the driver's disable callback:

regulator_disable()
  qcom_lcdb_disable()
    guard(mutex)(&lcdb->lock);

Since lcdb->lock is already held by qcom_lcdb_handle_sc(), wouldn't this
result in a self-deadlock?

> +
> +	lcdb->sc_count++;
> +	lcdb->sc_time =3D ktime_get();
> +
> +	if (qcom_lcdb_module_enable(lcdb))
> +		dev_err(lcdb->dev, "failed to recover from a short circuit\n");
> +}

[Severity: High]
If qcom_lcdb_module_enable() fails here, it returns an error and the
hardware is left off, but lcdb->enabled_mask is not cleared and
lcdb->sc_disabled is not set.=20

Does this create a state mismatch where future consumers might call
qcom_lcdb_enable() and falsely see a success without any actual physical
hardware enablement?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-sm8150-dis=
play-card-v1-0-5c14928cef29@oss.qualcomm.com?part=3D5
