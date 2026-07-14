Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0370CC43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 21:28:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47F3710EE46;
	Tue, 14 Jul 2026 21:28:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fj1ny07j";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B00D010EE46
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 21:28:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 09C30601D9;
 Tue, 14 Jul 2026 21:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B44F1F000E9;
 Tue, 14 Jul 2026 21:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784064496;
 bh=2f4HjWVUjLbB/FEPz13juu1OpUDPEMMqr2yXMY/H2JQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fj1ny07jP2biDeRsAa5+7oFUyr38HdZ1N49eFKktLX2BCp+0OxjWKJ0+C/gF4qRxo
 XNfXpPq/eSkFcZ8ytPd+hEdMEFi1BIHOh9wWSiUUgz7BKPwaetl0Pws1Sr69/hwlV3
 Xkjr2Iqr8Eh6jibB2O5l3eYgU9axZa0gUN5KrgA4RaKtOt3wN73ue7YIF2CKjVMADu
 CNkaNjlQQ5EpeZW7sq8tQQ1O8SAUyHSMmnUvHda//duWMouSafcJUSnrkE/Z/wkJkN
 80GMyUqCUiUhFeSoSYqFazaiYEpLPvC/lpM4BJDwaf9SmW76JWTa6PmoRDpOZ/fcu9
 53pSpMH43TNnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] drm/nouveau: add GSP hwmon support
To: "Mohamed Ahmed" <mohamedahmedegypt2001@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260714211429.238355-4-mohamedahmedegypt2001@gmail.com>
References: <20260714211429.238355-1-mohamedahmedegypt2001@gmail.com>
 <20260714211429.238355-4-mohamedahmedegypt2001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 21:28:16 +0000
Message-Id: <20260714212816.8B44F1F000E9@smtp.kernel.org>
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
- [High] Legacy (pre-GSP) hardware exposes duplicate dummy temperature and =
power sensor attributes.
- [High] Unconditional 2-second timeout delay during driver initialization =
if the GPU supports only thermal or only power telemetry.
- [Medium] The hwmon sysfs read callbacks fail intermittently with -EAGAIN =
when racing with GSP telemetry updates.
- [Medium] The GSP 'temp1' label incorrectly reports 'GPU core' instead of =
'gpu', leaving the new label definition as dead code.
--

--- Patch [3]: [PATCH 3/6] drm/nouveau: add GSP hwmon support ---
commit ceccedcbd9d07d5becab288795d358c7f8e9d71b
Author: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>

drm/nouveau: add GSP hwmon support

This commit wires up the RUSD telemetry to provide hwmon device support
for Turing through Blackwell boards. It adds temperature and power readout
channels, aiming to leave legacy therm/volt/iccsense paths unchanged.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_hwmon.c b/drivers/gpu/drm/no=
uveau/nouveau_hwmon.c
> --- a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_hwmon.c

[ ... ]

> @@ -243,52 +250,144 @@ nouveau_chip_is_visible(const void *data, u32 attr=
, int channel)

[ ... ]

> +static umode_t
> +nouveau_power_is_visible(const void *data, u32 attr, int channel)
> +{

[ ... ]

> +	if (nvkm_gsp_rusd(gsp))
> +		return nouveau_rusd_power_is_visible(gsp, attr, channel);
> +	else {
> +		if (!iccsense || !iccsense->data_valid || list_empty(&iccsense->rails))
> +			return 0;
> +
> +		switch (attr) {
> +		case hwmon_power_input:
> +			return 0444;

[Severity: High]
Does this inadvertently expose dummy power sensors on pre-GSP hardware?

The hwmon core iterates over the newly added channels in nouveau_info, but
this legacy fallback branch in nouveau_power_is_visible() does not check the
channel index. Because it unconditionally returns 0444 for hwmon_power_inpu=
t,
it advertises support for channels 1 and 2 on legacy boards, duplicating
channel 0.

A similar issue appears in nouveau_temp_is_visible() which returns 0444 for
hwmon_temp_input regardless of the channel parameter.

> @@ -368,47 +471,67 @@ nouveau_temp_read(struct device *dev, u32 attr, int=
 channel, long *val)

[ ... ]

> +	if (nvkm_gsp_rusd(gsp)) {

[ ... ]

> +		ret =3D nvkm_gsp_rusd_read(gsp, channel ? NVKM_GSP_RUSD_TEMP_HBM :
> +							NVKM_GSP_RUSD_TEMP_GPU, &value);
> +		if (ret)
> +			return ret;

[Severity: Medium]
Could this cause sporadic sensor read failures in userspace?

When userspace reads a sysfs attribute like temp1_input during a GSP write
window, nvkm_gsp_rusd_read() returns -EAGAIN. Since there is no retry loop
here in nouveau_temp_read() (unlike the one implemented in nouveau_rusd_ok()
for initialization), does this directly fail the userspace read and cause
monitoring tools to report errors?

This pattern also appears in nouveau_rusd_power_read().

> @@ -597,6 +770,8 @@ nouveau_is_visible(const void *data, enum hwmon_senso=
r_types type, u32 attr,
>  }
> =20
>  static const char input_label[] =3D "GPU core";
> +static const char * const nouveau_temp_labels[] =3D { "gpu", "vram" };
> +static const char * const nouveau_power_labels[] =3D { "gpu", "board", "=
vram" };
> =20
>  static int
>  nouveau_read_string(struct device *dev, enum hwmon_sensor_types type, u3=
2 attr,
> @@ -607,6 +782,18 @@ nouveau_read_string(struct device *dev, enum hwmon_s=
ensor_types type, u32 attr,
>  		return 0;
>  	}
> =20
> +	if (type =3D=3D hwmon_temp && attr =3D=3D hwmon_temp_label &&
> +	    channel < ARRAY_SIZE(nouveau_temp_labels)) {
> +		*buf =3D nouveau_temp_labels[channel];
> +		return 0;
> +	}

[Severity: Medium]
Is the new label for temp1 unreachable for GSP boards?

Earlier in nouveau_read_string(), there is a check for channel =3D=3D 0:

	if (type =3D=3D hwmon_temp && attr =3D=3D hwmon_temp_label && channel =3D=
=3D 0) {
		*buf =3D input_label;
		return 0;
	}

Because that check intercepts channel 0 and returns "GPU core", does it
prevent the execution of this new block and leave nouveau_temp_labels[0]
("gpu") as dead code?

> @@ -667,13 +854,39 @@ nouveau_hwmon_init(struct drm_device *dev)

[ ... ]

> +		for (;;) {
> +			thermal =3D nouveau_rusd_ok(gsp, NVKM_GSP_RUSD_TEMP_GPU);
> +			power =3D nouveau_rusd_ok(gsp, NVKM_GSP_RUSD_POWER_GPU) ||
> +				nouveau_rusd_ok(gsp, NVKM_GSP_RUSD_POWER_GPU_AVG) ||
> +				nouveau_rusd_ok(gsp, NVKM_GSP_RUSD_POWER_CAP);
> +			if ((thermal && power) || !time_before(jiffies, timeout))
> +				break;
> +			msleep(20);
> +		}

[Severity: High]
Will this loop introduce a noticeable boot delay on configurations that only
support one of these telemetry features?

The loop condition requires both thermal and power telemetry to become valid
to break early. If a GPU SKU natively supports only thermal or only power
sensors, the missing feature will constantly fail the check. Will this
unnecessarily block driver probe for the full timeout duration (typically
2 seconds) before proceeding?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714211429.2383=
55-1-mohamedahmedegypt2001@gmail.com?part=3D3
