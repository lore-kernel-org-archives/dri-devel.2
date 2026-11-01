Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4121606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 23:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRXCEyGM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 062A410E4F6;
	Sun,  1 Nov 2026 23:44:27 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94DCB10E4F6
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:44:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A170360098;
 Sun,  1 Nov 2026 23:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104321F000C1;
 Sun,  1 Nov 2026 23:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793576659;
 bh=0pTXx/D5UJqEqEyAM20FeNdjTYzwYesMcCjvTviCQCE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PRXCEyGMcMa8MlIc/dgUYgN0hiOU3RA2kxXHWatulyR0vPQC2LXScBD3Z1qRA63Vx
 kXO5FTVD+bttqx2UXiQsYGlWFnhMYyvsCKCKyNbnUGRspWQ8DEdAJJek2gYNCKbQrG
 3e3/IydaAGTlV5BUzSgKskngOCtRD0XDkd60+DalHFwbOqo3QS3dyBFhNTjp+gpk58
 nMD497AjAdqimXZ6DmR3JVo7aLlTkcK3C9Q85wEo+VCZqTf2ShB7N0LHJ+kuAk5uaZ
 mdnL5tWK1XE2JzGDTXe/uLshj0nCzybDKG5uAOeA/Ot1gj/EL3zp7s4PSapqNU/Wj3
 Bxb+fT34yNeUw==
Message-ID: <sashiko-outbox-192767@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/12] arm64: dts: qcom: sm6350-lena: Add PM7250B
 thermals
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261102-pdx213-upstream-3-v3-10-cdc3be96d257@erebion.eu>
References: <20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu>
 <20261102-pdx213-upstream-3-v3-10-cdc3be96d257@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 23:44:18 +0000
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
- [Medium] arm64: dts: qcom: sm6350-lena: xo-thermal overwritten by chg-ski=
n-thermal
--

commit f17bc49f693d9b82548c205964560df1771e0079
Author: erebion <erebion@erebion.eu>

arm64: dts: qcom: sm6350-lena: Add PM7250B thermals

This commit adds thermal zones for the chg-skin-thermal and conn-thermal
thermistors connected to PM7250B on Sony Xperia 10 III (pdx213).

> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts =
b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> index 6d5aa2fce4c0f..4e9707712a651 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> @@ -91,8 +91,8 @@ memory@fe901000 {
>  	};
> =20
>  	thermal-zones {
> -		xo-thermal {
> -			thermal-sensors =3D <&pmk8350_adc_tm 0>;
> +		chg-skin-thermal {
> +			thermal-sensors =3D <&pm7250b_adc_tm 0>;

[Severity: Medium]
Was xo-thermal intentionally removed here?

In the preceding commits ("arm64: dts: qcom: sm6350-lena: Enable PMK8350"
and "arm64: dts: qcom: sm6350-lena: Add PMK8350 thermals"), pmk8350_adc_tm
is enabled with child node xo-therm@0:

&pmk8350_adc_tm {
	status =3D "okay";

	xo-therm@0 {
		reg =3D <0>;
		io-channels =3D <&pmk8350_vadc PMK8350_ADC7_AMUX_THM1_100K_PU>;
		qcom,hw-settle-time-us =3D <200>;
		qcom,ratiometric;
	};
};

and the xo-thermal zone referencing <&pmk8350_adc_tm 0> is added under
thermal-zones.

Here, chg-skin-thermal replaces xo-thermal in-place rather than being added
alongside it. When drivers/thermal/qcom/qcom-spmi-adc-tm5.c probes
pmk8350_adc_tm via adc_tm5_probe() -> adc_tm5_register_tzd() ->
devm_thermal_of_zone_register(), registering channel 0 fails with -ENODEV
because no thermal zone references <&pmk8350_adc_tm 0> at this commit.

It looks like a hunk-splitting error across the series, as the subsequent
commit ("arm64: dts: qcom: sm6350-lena: Add PM6150L thermals") re-adds the
deleted xo-thermal node at the end of thermal-zones. Should xo-thermal be
preserved in this commit instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-pdx213-ups=
tream-3-v3-0-cdc3be96d257@erebion.eu?part=3D10
