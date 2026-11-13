Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82BF606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 01:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQ7VbLbV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2038710E737;
	Fri, 13 Nov 2026 01:40:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA4DE10E737
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:40:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ED1DB60141;
 Fri, 13 Nov 2026 01:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F181F000C4;
 Fri, 13 Nov 2026 01:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794534047;
 bh=Tqsq7DvU/IpDDIq00aR0Q6COF7tVcZ4eqelbtsbxLEU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fQ7VbLbVyCrko2ZrjTpms4BZq95ByurvA4TyHzjeUnMhfvn/Np0ZfTVbUNI8oc/Ij
 ehxkt5dk/HKpAGM0ciUTC4U/EUAhrN9dgKA9tYw4IfPgrtTwhd0AaTWLsXW0xzbBTe
 B91DzJ3QpXR5rBeSvIoVbQputMmvCD1NHYN7rqDZgw1BE8JEM4AOTuNXn+XIMv3eYZ
 b4/Pv55o2ge1DVisqtGO5K9ofBOslyeP8lDDCiMmwZSGZCgA5ANU31s8OOhhMPBqGW
 XObdAxEAfa0h13BOR/qce9X/6lzYeCUXrLiXrhF06wz8TGr6d+psI2mKA+e9/xXBXA
 dVcOj1mdcauMw==
Message-ID: <sashiko-outbox-212072@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/12] arm64: dts: qcom: sm6350-lena: Enable ADSP,
 CDSP, IPA & MPSS
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261113-pdx213-upstream-3-v4-4-4b01c50a821c@erebion.eu>
References: <20261113-pdx213-upstream-3-v4-0-4b01c50a821c@erebion.eu>
 <20261113-pdx213-upstream-3-v4-4-4b01c50a821c@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 01:40:46 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] arm64: dts: qcom: Signed-off-by uses handle erebion instead of
  real name
- [Low] arm64: dts: qcom: sm6350-lena: inconsistent Sony firmware-name
  path
--

commit 242b8f170866c87626f6fca5aa977fc4b21bc731
Author: erebion <erebion@erebion@erebion.eu>

> arm64: dts: qcom: sm6350-lena: Enable ADSP, CDSP, IPA & MPSS
>
> Enable the ADSP, CDSP, IPA and MPSS (Modem) nodes for the Xperia 10 III.
>
> Signed-off-by: erebion <erebion@erebion.eu>

[Severity: High]
The Author and Signed-off-by lines use a handle ("erebion") instead of a
real human name, which does not meet the Developer's Certificate of Origin
requirements in Documentation/process/submitting-patches.rst.

> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts =
b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> index a393b7533ccbf..4066de20ea23a 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> @@ -68,6 +68,12 @@ memory@fe901000 {
>  	};
>  };
> =20
> +&adsp {
> +	firmware-name =3D "qcom/sm6350/Sony/pdx213/adsp.mbn";
> +
> +	status =3D "okay";
> +};
> +
>  &apps_rsc {
>  	regulators-0 {
>  		compatible =3D "qcom,pm6350-rpmh-regulators";
> @@ -291,6 +297,12 @@ pm6150l_bob: bob {
>  	};
>  };
> =20
> +&cdsp {
> +	firmware-name =3D "qcom/sm6350/Sony/pdx213/cdsp.mbn";
> +
> +	status =3D "okay";
> +};
> +
>  &gpi_dma0 {
>  	status =3D "okay";
>  };
> @@ -316,6 +328,18 @@ touchscreen@48 {
>  	};
>  };
> =20
> +&ipa {
> +	firmware-name =3D "qcom/sm6350/Sony/pdx213/ipa_fws.mbn";
> +
> +	status =3D "okay";
> +};
> +
> +&mpss {
> +	firmware-name =3D "qcom/sm6350/Sony/pdx213/modem.mbn";
> +
> +	status =3D "okay";
> +};

[Severity: Low]
Should firmware-name for adsp, cdsp, ipa, and mpss use the platform
codename ("qcom/sm6350/Sony/lena/...") instead of "pdx213"?

Other Sony Xperia device trees in arch/arm64/boot/dts/qcom/, including
single-board files such as sm6375-sony-xperia-murray-pdx225.dts and
sm8550-sony-xperia-yodo-pdx234.dts, follow the
qcom/<soc>/Sony/<platform>/<file>.mbn convention standardized in commit
f0a577c3a807 ("arm64: dts: qcom: sm8350: sagami: Fix remoteproc firmware
path").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-pdx213-ups=
tream-3-v4-0-4b01c50a821c@erebion.eu?part=3D4
