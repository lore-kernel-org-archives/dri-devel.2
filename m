Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F62606A329
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 23:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AimqHB4z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5264910E3F4;
	Sun,  1 Nov 2026 23:42:04 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 632F210E3F4
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:41:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 137E043D9B;
 Sun,  1 Nov 2026 23:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDA01F00919;
 Sun,  1 Nov 2026 23:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793576517;
 bh=6iRegssdGIhNKCNpk5hrItS2OkQ/SnEBgZjO9EF9dwM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AimqHB4zhXkoRGbnxP1kvovuUAGJRhGbb/U1ByT22uThax7kRFCuXzXzFCeLRm+Hq
 LXNwrVN3a38EZPYqvoaY0gxKSqGXhhBg2kPDRqFOfxIIGEPTC+AgNO+X4oghaW9H4u
 dWxUaKR8KRVAHNpvIqHPgJ/V357D8qiu/JnrYA7GblF5G4yjYl3ZXXzkoEmHVENGR0
 4UHMx+lIhgjmiUJIzclChNBY+ZtHTH9kyszlSsUPREtWSnriJ5e/eI7TPuSNZrJQGT
 bNqjUUoceQIjhY6F2vlq5OJ+6yH09f3n0IYZG26KYclz+rGIqJhALOWUpZvbKVP1Xw
 QJASn5AIqh8Zw==
Message-ID: <sashiko-outbox-192764@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/12] arm64: dts: qcom: sm6350-lena: Enable ADSP,
 CDSP, IPA & MPSS
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261102-pdx213-upstream-3-v3-4-cdc3be96d257@erebion.eu>
References: <20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu>
 <20261102-pdx213-upstream-3-v3-4-cdc3be96d257@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 23:41:56 +0000
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
- [Low] arm64: dts: qcom: redundant IPA properties in sm6350-lena board DTS
--

commit ea5a49fe7f1eb96f27686737dd2b4c7bc009edc7
Author: erebion <erebion@erebion.eu>

arm64: dts: qcom: sm6350-lena: Enable ADSP, CDSP, IPA & MPSS

This commit enables the ADSP, CDSP, IPA, and MPSS nodes in the Device
Tree for the Sony Xperia 10 III (pdx213).

> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts =
b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> index 1e89c9798edf8..ce351a3fa8727 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts

[ ... ]

> @@ -325,6 +337,20 @@ touchscreen@48 {
>  	};
>  };
> =20
> +&ipa {
> +	firmware-name =3D "qcom/sm6350/sony/pdx213/ipa_fws.mbn";
> +	memory-region =3D <&pil_ipa_fw_mem>;
> +	qcom,gsi-loader =3D "self";
> +
> +	status =3D "okay";
> +};

[Severity: Low]
Are memory-region and qcom,gsi-loader needed in &ipa here?

Commit dc88d56f27e0 ("arm64: dts: qcom: sm6350: consolidate IPA
properties") moved both properties into the base ipa: ipa@1e40000 node in
arch/arm64/boot/dts/qcom/sm6350.dtsi:

	ipa: ipa@1e40000 {
		compatible =3D "qcom,sm6350-ipa";
		...
		qcom,gsi-loader =3D "self";
		memory-region =3D <&pil_ipa_fw_mem>;
		status =3D "disabled";
	};

and dropped them from board files such as
arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts. Could &ipa in
arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts only specify
firmware-name and status =3D "okay", matching &adsp, &cdsp, and &mpss?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-pdx213-ups=
tream-3-v3-0-cdc3be96d257@erebion.eu?part=3D4
