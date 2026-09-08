Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC6BC79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 19:45:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B53410E40D;
	Tue,  8 Sep 2026 19:45:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="Ck/aUgKV";
	dkim-atps=neutral
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8EAE10E40D
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 19:45:01 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-9399d52b1efso146342785a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 12:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1788896701; x=1789501501;
 darn=lists.freedesktop.org; 
 h=mime-version:user-agent:content-type:autocrypt:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=V3TjnSkAaGngA7Ul+JQ8TuSqUVKVX25sXhLVMtD92ig=;
 b=Ck/aUgKVsJ/ks82lnivOmIzR40zdBHUrhuzEgZ6IugC1dn1uHs8Uj4X2cCYSsRFmbE
 9ZWzpftWGDcOZr9dJAwPlPlyznyWX/kMZ03EeGKAG7SVwJYazoJkOugrlpjjiGIhFRfb
 fta0N5x2mcXpxwDByaE5uEsTFlLlDCAbg9crvO3y53cc0MSwLeNGf1wEKM+1EHrl3q5Q
 ynGfpwcS+jCmv1G3XK7jeu7V2vQzV+zRJP/xWTJ3ErNFRCfQygVcnFPJAvQM4KNnVw+D
 EKarXSgGIaBZWBdtQXMv1U5n/Qlk11vUL6kYuIIgGjdVLclaIRr/UfQqhf3pCJPwIg/o
 zY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788896701; x=1789501501;
 h=mime-version:user-agent:content-type:autocrypt:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V3TjnSkAaGngA7Ul+JQ8TuSqUVKVX25sXhLVMtD92ig=;
 b=sN8uIdDK3CkRUA8UtzggOJsb6lNtaX/WC1e3T/0gT8K9lwBExHyOavnA9AqKYPCBgS
 8NIhHPwtAIsLvlWbbgG5F7yCOpaHDl95FVzP3ij9zhwwT4T+Bu9wA2j6RNXOSAR6sKgc
 j5wf0G/EVFUp9vhnOYV4pcVbyXMqkM+VaZURxsztrbwKM9YHtcADpJkolxzj4aN+0tad
 Tuw0Gu15Ea9RvCw4y37UNcGdb1n6e46jwILxLhZJbqfS0LDlzVauHFa/+B8uyRTSRHu5
 Wk85rN7sComUKa8vxUFNs8fwlvZ+0n+lJy5PESVm37sa68MEZrYmBVVZh3uHUHoBOxPw
 0mpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/YE0BnnB8rDZ7ZJ0LwmO4jpDTBX1sxfAPNSP6OJzXaQ4eYcL534xCuN5trr7ZrvPogfQqedgDgV8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kBtrJZQlibbvVPGAgKtNKcIrWU3owO9ouWe/4d5dOOqJnoQdRQ
 BbUK3pjlO+EwWHnUXHoymjve4mg1/sZ0FWV40cMHn//VifXnLI/B3trf1mkMHqO3BVk=
X-Gm-Gg: AYBFou1FxThovZ9lV8xWUIIt7ijOS7q5Z6jvZ4EH02DpI6fMv0oY7iIAyUTNdB2MqSB
 eAV8I5XbgxTWiQXt7Ye/VklvCyBmHx3ZmsdNzFl0Qi2XIeCkYOPH81gDoivgR4x5sDD8lVudPZe
 otRh6DP+ScvX20jtHF+OX8n4hcLNPKU1hnkCW2GhSdw4+2KQDRSKrDd/JaCEN1qCc4zaCtw/OD7
 bqCZQ8e2o+vox+0Jvyyv6KBiNBphnpih5AoNM7owwRRw3CgjiGlujJk5Ia7tKRRw9ybs32lYUm0
 CMjxXRclq7QGpGgKrzygoKbaN2F5HEpPt1w02bm8IEg1CK5DXNncEonGzRxg4al1pSDoRuYAQxa
 gJVV7m7n5q+8pHDJGjIhiKYKpUpo++/pVkDiRxlQeRx/vD4lPD9jAhOpbYTQHiV2Sc1dvvewtkg
 DDn12rYsGdLQ/Kn8E0wkDUatjmTwq/wp0w7nqO/ZJ9on/8JDpxx+EzHNdU3shrtys48CMyj2jfh
 I9vF2KLN6sg/fM=
X-Received: by 2002:a05:620a:8393:b0:939:6df7:73f0 with SMTP id
 af79cd13be357-9398058750cmr3405750385a.50.1788896700593; 
 Tue, 08 Sep 2026 12:45:00 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:e221::5ac? ([2606:6d00:15:e221::5ac])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9397f9f4b3csm1210879385a.5.2026.09.08.12.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 12:44:59 -0700 (PDT)
Message-ID: <c58d711ff5c9a01cfd69c2ddf86bfd969b36cc63.camel@ndufresne.ca>
Subject: Re: [PATCH 3/7] arm64: dts: rockchip: rk3588: add an OPP table for
 the NPU
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Igor Paunovic <royalnet026@gmail.com>, Tomeu Vizoso
 <tomeu@tomeuvizoso.net>,  Oded Gabbay <ogabbay@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas	 <diederik@cknow-tech.com>, Sebastian Reichel
 <sebastian.reichel@collabora.com>,  Jiaxing Hu <gahing@gahingwoo.com>,
 Jonas Karlman <jonas@kwiboo.se>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 08 Sep 2026 15:44:56 -0400
In-Reply-To: <20260904130858.27803-4-royalnet026@gmail.com>
References: <20260904130858.27803-1-royalnet026@gmail.com>
 <20260904130858.27803-4-royalnet026@gmail.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-6ejhBySV5wLJspcm2TMq"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
MIME-Version: 1.0
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


--=-6ejhBySV5wLJspcm2TMq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi there,

please note, I didn't submit as I didn't finish learning the implication of
everything in the series. I've used AI because I needed something quick and
dirty for a demo. But let me ask few questions here though:

Le vendredi 04 septembre 2026 =C3=A0 15:08 +0200, Igor Paunovic a =C3=A9cri=
t=C2=A0:
> The NPU compute clock is driven by the firmware, which only accepts one o=
f
> the rates in its own PVTPLL table: 300, 400, 500, 600, 700, 800, 900 and
> 1000 MHz through the PVTPLL, plus 200 MHz off GPLL. Anything else comes
> back as SCMI_INVALID_PARAMETERS, so the table has to name those rates
> exactly rather than describe a range.
>=20
> 200 MHz is included even though the vendor table stops at 300, because
> mainline pins the cores there with assigned-clock-rates and that is the
> rate the NPU boots and idles at. Leaving it out would put the boot state
> outside the table and give a driver nowhere to return to. Its voltage is
> the same 700 mV the vendor uses for 300 MHz, so it is conservative.
>=20
> The voltages are the vendor's, and the upper half of the table matches th=
e
> GPU table in this file step for step: 700 MHz at 700 mV, 800 at 750, 900 =
at
> 800, 1000 at 850. There is no PVTM or binning here, for the same reason t=
he
> GPU table has none: mainline uses conservative worst-case voltages instea=
d
> of per-chip nvmem data.
>=20
> The table is attached to rknn_core_0 alone. All three cores share one clo=
ck
> and one supply and cannot be scaled independently, and the driver hangs i=
ts
> devfreq device off the core that carries the table.

The goal of DT is to describe the hardware. You made the choice to not desc=
ribe
the rate of core 1 and 2, and also are missing something to describe the cl=
ock
relation (well indirectly you can probably notice they point to the same cl=
ock).
My impression, and I was to study this properly is that having the same tab=
le
on every core and adding the opp-shared set on it was actually probably the
proper way to describe this "single clock for all" relationship.

My driver implementation though hard coded this fact for simplicity, but if=
 we
add a variant in the future that does not have this limitation, we can just=
 read
the opp-shared property to differentiate them instead of coding it for ever=
y
compatibles. Matching clock to be the same would also be an option, but mor=
e
work. I'm curious what's the right approach, and what is the real meaning o=
f
opp-shared if I got that wrong.

>=20
> The full SoC range is described rather than a per-board subset, so that a
> board which cannot cool the upper rates drops them in its own .dts with a
> /delete-node/ on the OPP it does not want. A board may only delete OPPs
> that way, never invent intermediate ones: a rate that is not in the
> firmware's table is rejected outright.
>=20
> There is deliberately no opp-suspend property. The driver has to resume
> every core before it may touch the shared clock, so letting the devfreq
> core drive a suspend OPP from inside a runtime-suspend callback would
> deadlock against the driver's own governor worker. The driver records the
> boot rate and restores it itself instead.

We must not justify our DTS choices based on driver behaviours (or miss-
behaviour). We must justify it based on how accurate the hardware descripti=
on
is. In my attempt, I was unable to go back to 200MHz and I could only resum=
e at
200MHz (could have been a bug ...). So opp-suspend described the rate the c=
ore
will be once resumed. But it goes a little confused, as resume/suspend isn'=
t per
core. I'm also curious the exact meaning of opp-suspend, and if my
interpretation was right or wrong.

It should probably be fine to not use opp-suspend, if transition back to 20=
0Mhz
works. It not fine if its to avoid a driver deadlock (argually due to a bug=
).

>=20
> The consumer is the devfreq support added later in this series; until the=
n
> the table is inert and the NPU keeps the fixed rate that
> assigned-clock-rates gives it today.

This is irrelevant, I think you can drop this paragraph.

>=20
> rk3588j.dtsi does not include this file; it carries its own derated table=
s
> for the CPU clusters and the GPU, and it gets no NPU table here. That is
> deliberate. The J part is rated lower than the rates in this table and no=
ne
> of it can be measured on the hardware this was written on, so inventing a
> derated NPU table would be guessing. Its NPU node stays disabled, so
> nothing binds and the cooling map added later in this series is simply
> never resolved.

Ack, this is safe thing to do.

>=20
> The same rates and voltages were arrived at independently by Nicolas
> Dufresne in a proof of concept that was never posted to the list; his
> version differs in that it marks 200 MHz as opp-suspend, shares one table
> across all three cores and drops the assigned-clock-rates pins.
> Link: https://gitlab.collabora.com/nicolas/linux/-/commits/rock5b-npu-poc=
-4
>=20
> Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
> Assisted-by: LLM checkpatch dtbs_check
> ---
>  arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi | 45 ++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi b/arch/arm64/bo=
ot/dts/rockchip/rk3588-opp.dtsi
> index b5d630d2c879f..3711727020ed1 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi
> @@ -151,6 +151,47 @@ opp-1000000000 {
>  			opp-microvolt =3D <850000 850000 850000>;
>  		};
>  	};
> +
> +	npu_opp_table: opp-table-npu {
> +		compatible =3D "operating-points-v2";
> +
> +		opp-200000000 {
> +			opp-hz =3D /bits/ 64 <200000000>;
> +			opp-microvolt =3D <700000 700000 850000>;
> +		};
> +		opp-300000000 {
> +			opp-hz =3D /bits/ 64 <300000000>;
> +			opp-microvolt =3D <700000 700000 850000>;
> +		};
> +		opp-400000000 {
> +			opp-hz =3D /bits/ 64 <400000000>;
> +			opp-microvolt =3D <700000 700000 850000>;
> +		};
> +		opp-500000000 {
> +			opp-hz =3D /bits/ 64 <500000000>;
> +			opp-microvolt =3D <700000 700000 850000>;
> +		};
> +		opp-600000000 {
> +			opp-hz =3D /bits/ 64 <600000000>;
> +			opp-microvolt =3D <700000 700000 850000>;
> +		};
> +		opp-700000000 {
> +			opp-hz =3D /bits/ 64 <700000000>;
> +			opp-microvolt =3D <700000 700000 850000>;
> +		};
> +		opp-800000000 {
> +			opp-hz =3D /bits/ 64 <800000000>;
> +			opp-microvolt =3D <750000 750000 850000>;
> +		};
> +		opp-900000000 {
> +			opp-hz =3D /bits/ 64 <900000000>;
> +			opp-microvolt =3D <800000 800000 850000>;
> +		};
> +		opp-1000000000 {
> +			opp-hz =3D /bits/ 64 <1000000000>;
> +			opp-microvolt =3D <850000 850000 850000>;
> +		};
> +	};
>  };
> =20
>  &cpu_b0 {
> @@ -188,3 +229,7 @@ &cpu_l3 {
>  &gpu {
>  	operating-points-v2 =3D <&gpu_opp_table>;
>  };
> +
> +&rknn_core_0 {
> +	operating-points-v2 =3D <&npu_opp_table>;
> +};

--=-6ejhBySV5wLJspcm2TMq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaqBluAAKCRDZQZRRKWBy
9J8NAP9lh1Widy2Bvw8gl4Tm1t9qqrXQdz+1CoaInkUXYDSEugEAjMajp1p87Z/m
tw6c0cbl4VSaOEug7JqUmeEGnhtkTQQ=
=zxz6
-----END PGP SIGNATURE-----

--=-6ejhBySV5wLJspcm2TMq--
