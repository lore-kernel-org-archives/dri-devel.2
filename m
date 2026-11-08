Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021B0606A331
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=klZbEdh7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5755310E7D3;
	Sun,  8 Nov 2026 12:43:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2078B10E7D3
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 12:43:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C72B543EF5;
 Sun,  8 Nov 2026 12:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7AF1F0089F;
 Sun,  8 Nov 2026 12:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794141791;
 bh=pwLIRt8oLHmQi2GBVAVONFNIfIao7k665Kov0Bzqz1Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=klZbEdh7UcPPn7KeKgR5l/lEC9oEdxLLUOYpvC0n3Acjd5BxVB486lu8Tdnus2ja+
 EHw4EHvVmfj8XDSkW45i9+MVgcv/VMa2sh6m4SAtERH+5wb4cXrj6Yy3X3uxcorYGA
 NnbDcGYdaSIDNxAfvGblfh6N/5+Hwqx+RYOGEU7H0gzDyk0ItdUZEQ9uxbXQkVBBZ9
 zIVjsGPcJuyDEdygVSZemD1CPudy9BXB/ZXj1Wy/+LyI/KCewE4BUXInvhmgVN0HhK
 ElhT6jFNM4IcLHMb/tUZnNmUox/XjnZHTXB71WTXTusr+NKhafsyWhaB1PEbPoGKN/
 cJPVknZl45UhQ==
Message-ID: <sashiko-outbox-203741@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/10] arm64: dts: qcom: sdm845-samsung-starqltechn:
 Update panel compatible
To: "David Heidelberg" <david@ixit.cz>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261108-crosshatch-panel-v3-8-87dd4ec4f7cc@ixit.cz>
References: <20261108-crosshatch-panel-v3-0-87dd4ec4f7cc@ixit.cz>
 <20261108-crosshatch-panel-v3-8-87dd4ec4f7cc@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 12:43:11 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] arm64: dts: qcom: incompatible panel@0 compatible and
  reset-gpios change
--

commit 73ab76c040fc6673b910317ac87e836c9478306e
Author: David Heidelberg <david@ixit.cz>

arm64: dts: qcom: sdm845-samsung-starqltechn: Update panel compatible

This commit replaces the panel@0 compatible string with
"samsung,s6e3ha8-amb577px01" and changes reset-gpios to GPIO_ACTIVE_LOW in
sdm845-samsung-starqltechn.dts.

> diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/ar=
ch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> index bd59f1dcd96dc..c156ed3733b4e 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> @@ -267,13 +267,13 @@ &mdss_dsi0 {
>  	status =3D "okay";
> =20
>  	panel@0 {
> -		compatible =3D "samsung,s6e3ha8";
> +		compatible =3D "samsung,s6e3ha8-amb577px01";
>  		reg =3D <0>;
>  		vci-supply =3D <&s2dos05_ldo4>;
>  		vddr-supply =3D <&s2dos05_buck>;
>  		vdd3-supply =3D <&s2dos05_ldo1>;
>  		te-gpios =3D <&tlmm 10 GPIO_ACTIVE_HIGH>;
> -		reset-gpios =3D <&tlmm 6 GPIO_ACTIVE_HIGH>;
> +		reset-gpios =3D <&tlmm 6 GPIO_ACTIVE_LOW>;

[Severity: High]
As reported by Krzysztof Kozlowski on v2 [1], does replacing the
"samsung,s6e3ha8" compatible string and inverting reset-gpios break DTB ABI
compatibility for existing kernels and DTB consumers?

Existing kernels and trees that only match "samsung,s6e3ha8" and expect
GPIO_ACTIVE_HIGH (introduced in 70005c18c9f7 ("arm64: dts: qcom:
sdm845-starqltechn: add graphics support")) will no longer bind or reset
panel@0 when booted with this DTB, while the panel driver already handles
the legacy compatible and polarity via broken_reset_polarity.

[1] https://lore.kernel.org/r/20260929-spirited-umber-hedgehog-300ebd@quoll

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-crosshatch=
-panel-v3-0-87dd4ec4f7cc@ixit.cz?part=3D8
