Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07084606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dNwm7JSX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60D9510E14C;
	Thu,  5 Nov 2026 11:32:18 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E46B10E14C
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 11:32:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B27DF6062F;
 Thu,  5 Nov 2026 11:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033091F000C1;
 Thu,  5 Nov 2026 11:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793878331;
 bh=Cb1CKFhhxBGgG/rsEsSCdHt132nUF6RoCXJXzHzVYG8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dNwm7JSXc1K9tvskdBsI72Dnl7PlbfKkUH1FCP0pSZz+my/UKTECLRZsUQbWtJeX5
 LJWNMSFeJgmqmW4/lj9awstqfFDoK8PzonObJi/lqAOc9GJlH2tgAXnbbhJ3C6DEmm
 Ng0hvGkRvLcj2pcnPJEJYzGeklaP875gtL7PH9zG537HBFpG9G82866r4s8kWbgMx4
 PQLAz3tf3UdVNiELWGvYTihcjrJn80aba6Qvo7wl1o1H2zTGdRd4/+fFOdAa52c3DG
 uB/pCqbCXq1F3mVqu65LQ9w61pJIXAIHc6alfmMjYUrAoLJGxsyO56GIkpb5wdnMsq
 m63F1A4t1cwqQ==
Message-ID: <sashiko-outbox-198958@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/11] arm64: dts: qcom: Add initial support for MSM8952
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dmitry.torokhov@gmail.com
In-Reply-To: <20261105-msm8952-initial-support-v8-9-311ae8e8f14b@mainlining.org>
References: <20261105-msm8952-initial-support-v8-0-311ae8e8f14b@mainlining.org>
 <20261105-msm8952-initial-support-v8-9-311ae8e8f14b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 11:32:10 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] arm64: dts: qcom: msm8952: missing bam_clk on cryptobam and usbbam
- [Medium] arm64: dts: qcom: msm8952: missing polling-delay-passive on CPU =
thermal zones
--

commit ea3b840e26e24e5872598db9df083561eb669ac2
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

arm64: dts: qcom: Add initial support for MSM8952

This commit adds the initial device tree source file for the Qualcomm
MSM8952 SoC, including CPU clusters, clocks, pinctrl, storage, display,
remoteproc, thermal sensors, USB, and BLSP peripherals.

> diff --git a/arch/arm64/boot/dts/qcom/msm8952.dtsi b/arch/arm64/boot/dts/=
qcom/msm8952.dtsi
> new file mode 100644
> index 0000000000000..3739d1c25c035
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8952.dtsi
> @@ -0,0 +1,2912 @@

[ ... ]

> +		cryptobam: dma-controller@704000 {
> +			compatible =3D "qcom,bam-v1.7.0";
> +			reg =3D <0x00704000 0x20000>;
> +			interrupts =3D <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells =3D <1>;
> +			num-channels =3D <16>;
> +			qcom,ee =3D <1>;
> +			qcom,num-ees =3D <4>;
> +			qcom,controlled-remotely;
> +		};

[ ... ]

> +		usbbam: dma-controller@78c4000 {
> +			compatible =3D "qcom,bam-v1.7.0";
> +			reg =3D <0x078c4000 0x17000>;
> +			interrupts =3D <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells =3D <1>;
> +			num-channels =3D <4>;
> +			qcom,num-ees =3D <4>;
> +			qcom,ee =3D <0>;
> +			qcom,controlled-remotely;
> +		};

[Severity: High]
As reported by Sashiko on v7 [1], both cryptobam and usbbam are enabled by
default with qcom,controlled-remotely, but omit clocks and
clock-names =3D "bam_clk". Can this cause unclocked register accesses when
freeing DMA channels or unbinding the BAM driver?

For cryptobam, qce_crypto_probe() in drivers/crypto/qce/core.c enables
runtime PM and calls devm_qce_dma_request(). Once the autosuspend delay
elapses (or if probe fails after requesting DMA), qce_runtime_suspend()
gates off the crypto clocks. When the qce driver is later unbound or
unwinds, devres runs:

qce_dma_release()
  dma_release_channel()
    bam_free_chan()
      pm_runtime_get_sync(bdev->dev);
      ...
      bam_reset_channel(bchan);

Because cryptobam has no bam_clk, bdev->bamclk is null in bam_dma_probe(),
so pm_runtime_get_sync() does not enable the crypto interface clock before
bam_reset_channel() writes to the BAM registers at 0x00704000.

Similarly, usbbam is enabled by default while usb@78db000 has
status =3D "disabled", so unbinding usbbam runs bam_dma_remove() and writes=
 to
0x078c4000 while the USB interface clock is gated off.

Should cryptobam and usbbam provide clocks and clock-names =3D "bam_clk"
(similar to blsp1_dma and blsp2_dma), or should usbbam also be marked
disabled until enabled alongside usb?

[ ... ]

> +	thermal-zones {
> +		qdsp-thermal {
> +			thermal-sensors =3D <&tsens 2>;
> +
> +			trips {
> +				qdsp_alert0: trip-point0 {
> +					temperature =3D <75000>;
> +					hysteresis =3D <2000>;
> +					type =3D "hot";
> +				};
> +			};
> +		};
> +
> +		cpu4-thermal {
> +			thermal-sensors =3D <&tsens 5>;
> +
> +			cooling-maps {
> +				map0 {
> +					trip =3D <&cpu4_alert0>;
> +					cooling-device =3D <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +
> +			trips {
> +				cpu4_alert0: trip-point0 {
> +					temperature =3D <75000>;
> +					hysteresis =3D <2000>;
> +					type =3D "passive";
> +				};
> +
> +				cpu4_alert1: trip-point1 {
> +					temperature =3D <85000>;
> +					hysteresis =3D <2000>;
> +					type =3D "hot";
> +				};
> +
> +				cpu4_crit: cpu-crit {
> +					temperature =3D <110000>;
> +					hysteresis =3D <2000>;
> +					type =3D "critical";
> +				};
> +			};
> +		};

[Severity: Medium]
As reported by Sashiko on v7 [2], cpu4-thermal, cpu5-thermal, cpu6-thermal,
cpu7-thermal, and cpu0-3-thermal each define a single passive trip point at
75000 mC mapped to the cluster CPUs, but omit polling-delay-passive. Without
polling-delay-passive, will passive CPU frequency throttling stall after a
single cooling step?

In drivers/thermal/thermal_of.c:thermal_of_monitor_init(), omitting
polling-delay-passive leaves tz->passive_delay_jiffies set to 0:

	ret =3D of_property_read_u32(np, "polling-delay-passive", pdelay);
	if (ret =3D=3D -EINVAL) {
		*pdelay =3D 0;

When a CPU thermal zone crosses 75000 mC, tsens_irq_thread() triggers
__thermal_zone_device_update(), which reprograms the hardware interrupt
window to [72999 mC, 85000 mC]. Because tz->passive_delay_jiffies is 0,
monitor_thermal_zone() in drivers/thermal/thermal_core.c never schedules
polling while the passive trip is active:

	if (tz->passive > 0 && tz->passive_delay_jiffies)
		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);

Under the step_wise governor, get_target_state() only advances the cooling
state by cur_state + 1 on that initial trip crossing and never re-evaluates
while the temperature remains between 73 C and 85 C, and under the
power_allocator governor, pid_controller() divides by
jiffies_to_msecs(tz->passive_delay_jiffies) which is 0.

Should these passive CPU thermal zones specify polling-delay-passive (such
as <250>, matching msm8916.dtsi, msm8939.dtsi, and msm8953.dtsi)?

[1] https://lore.kernel.org/r/20261030-msm8952-initial-support-v7-9-ad748ac=
e375d@mainlining.org
[2] https://lore.kernel.org/r/20261030-msm8952-initial-support-v7-9-ad748ac=
e375d@mainlining.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-msm8952-in=
itial-support-v8-0-311ae8e8f14b@mainlining.org?part=3D9
