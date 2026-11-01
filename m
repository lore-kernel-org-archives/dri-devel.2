Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496B1606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 23:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MewjkK2i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95F6B10E4A0;
	Sun,  1 Nov 2026 23:42:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E70C510E4A0
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:42:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D006140E92;
 Sun,  1 Nov 2026 23:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EA81F000C1;
 Sun,  1 Nov 2026 23:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793576542;
 bh=PfQg/XLPbRo0jSdDV+Z9gAuJ8LwW1GkVfRxgQ7I/YYs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MewjkK2iz9D4ZVk8xEKxXmkceHjrKhfpslhzwYjkNoqrH2slpM3xM919NYUsHcq9j
 u8phS16/hPC7AEkZB+EB3jeSlbi7ZYxQOJgmXninxWpDuH8rCXcAdfY0WJwtRBmYTM
 RmoiCPoBo/YHv68mUb7ztCAX0vdEoc/nxbcg5Vw1n25CowhkiqfA0+GJtrI7ybr6wy
 EQ46Sd2o/6tcEpMetQtvcgrO5BLFxGuV9/i4QFsyN29XLYyh1GNtAHdx2H0hMjD+W2
 dHq98+EmOAo7uXaO7u1Cy+T9SX1dfr9F0SY6n6lhm3CAPzdG7+yj7j1OD7vXeXwlII
 xpELQDPx0h5Vw==
Message-ID: <sashiko-outbox-192765@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/12] arm64: dts: qcom: sm6350-lena: Enable PMK8350
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261102-pdx213-upstream-3-v3-8-cdc3be96d257@erebion.eu>
References: <20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu>
 <20261102-pdx213-upstream-3-v3-8-cdc3be96d257@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 23:42:22 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] arm64: dts: qcom: sm6350-lena: duplicate qcom-pon device from pm=
k8350.dtsi
--

commit ab0852d01a0d63b999b8519d90b2ed3ef4a0420c
Author: erebion <erebion@erebion.eu>

arm64: dts: qcom: sm6350-lena: Enable PMK8350

This commit includes pmk8350.dtsi and configures and enables the PMK8350 AD=
C,
thermal monitor, and RTC nodes on the Sony Xperia 10 III.

> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts =
b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> index 61e191133cb4f..246a290e44f77 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> @@ -8,7 +8,11 @@
>  #define PM7250B_SID 2
>  #define PM7250B_SID1 3
> =20
> +/* PMK8350 (in reality a PMK8003) is configured to use SID6 instead of 0=
 */
> +#define PMK8350_SID 6
> +
>  #include <dt-bindings/firmware/qcom,scm.h>
> +#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
>  #include <dt-bindings/leds/common.h>
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> @@ -16,6 +20,7 @@
>  #include "pm6150l.dtsi"
>  #include "pm6350.dtsi"
>  #include "pm7250b.dtsi"
> +#include "pmk8350.dtsi"

[Severity: Medium]
Does including pmk8350.dtsi alongside pm6350.dtsi without disabling or
deleting pmk8350_pon cause a probe conflict between two active qcom-pon
instances?

In arch/arm64/boot/dts/qcom/pm6350.dtsi, pm6350_pon is already enabled as t=
he
primary PON device hosting reboot modes, pm6350_pwrkey, and pm6350_resin:

arch/arm64/boot/dts/qcom/pm6350.dtsi:
		pm6350_pon: pon@800 {
			compatible =3D "qcom,pm8998-pon";
			reg =3D <0x800>;
			mode-bootloader =3D <0x2>;
			mode-recovery =3D <0x1>;

In arch/arm64/boot/dts/qcom/pmk8350.dtsi, pmk8350_pon (and a root
/reboot-mode nvmem-reboot-mode node) is also enabled by default:

arch/arm64/boot/dts/qcom/pmk8350.dtsi:
		pmk8350_pon: pon@1300 {
			compatible =3D "qcom,pmk8350-pon";
			reg =3D <0x1300>, <0x800>;
			reg-names =3D "hlos", "pbs";

Both qcom,pm8998-pon and qcom,pmk8350-pon match qcom_pon_id_table with
reason_shift =3D GEN2_REASON_SHIFT in drivers/power/reset/qcom-pon.c:

qcom_pon_probe() {
	...
	if (reason_shift !=3D NO_REASON_SHIFT) {
		pon->reboot_mode.dev =3D &pdev->dev;
		pon->reason_shift =3D reason_shift;
		pon->reboot_mode.write =3D qcom_pon_reboot_mode_write;
		error =3D devm_reboot_mode_register(&pdev->dev, &pon->reboot_mode);
		if (error) {
			dev_err(&pdev->dev, "can't register reboot mode\n");
			return error;
		}
	}

	platform_set_drvdata(pdev, pon);

	return devm_of_platform_populate(&pdev->dev);
}

In drivers/power/reset/reboot-mode.c, devm_reboot_mode_register() ->
reboot_mode_register() -> reboot_mode_create_device() registers a sysfs cla=
ss
device named after reboot->dev->driver->name ("qcom-pon"):

reboot_mode_create_device() {
	...
	priv->reboot_mode_device =3D device_create(&reboot_mode_class, NULL, 0,
						 (void *)priv, "%s",
						 reboot->dev->driver->name);
	...
}

reboot_mode_register() {
	...
	ret =3D reboot_mode_create_device(reboot);
	if (ret)
		goto error;

	return 0;

error:
	kfree(info);
	reboot_mode_unregister(reboot);
	return ret;
}

When the second qcom-pon instance probes, device_create() fails with -EEXIST
and triggers a sysfs duplicate filename warning, and the error path in
reboot_mode_register() calls reboot_mode_unregister(), which looks up
"qcom-pon" by driver name via class_find_device(), unregisters the first
instance's sysfs device, and leaks the struct device reference returned by
class_find_device(). In addition, if pmk8350_pon probes before pm6350_pon,
qcom_pon_probe() for pm6350_pon returns an error before reaching
devm_of_platform_populate(), preventing pm6350_pwrkey and pm6350_resin from
being populated.

Should pmk8350_pon (and the root /reboot-mode node from pmk8350.dtsi) be
disabled or deleted in sm6350-sony-xperia-lena-pdx213.dts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-pdx213-ups=
tream-3-v3-0-cdc3be96d257@erebion.eu?part=3D8
