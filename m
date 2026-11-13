Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE8A606A327
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=DWWUaiHf;
	dkim=pass (2048-bit key) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=pYpX/OdJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E9CD112516;
	Fri, 13 Nov 2026 13:43:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="DWWUaiHf";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="pYpX/OdJ";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CA1510E654
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 00:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1794531415; bh=31V3qdlSdnz4MOuLMwp5hpd
 A+AchzM1x7ZW8LBpE0QI=; b=DWWUaiHf2Zzhf66WBFqKi55LlUGCRU3F28bM+847Ubmi6Pvrfp
 j4o67zcS2QCznaX4eLWg+BtM7Ix0ypcf4/Aw==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=From:To:Subject:Date:Message-ID; t=1794531415; bh=31V3qdlSdnz4MOuLMwp5hpd
 A+AchzM1x7ZW8LBpE0QI=; b=pYpX/OdJ+Tu95tgwvaMZdmFQdITa/e1E7ZnzLskAMWiWgZIs5S
 ZF6P3nhbNEc4TcAUg0gtDt8GKnhJeK3yPfcC7ByQI4PKIW/HRaJN9hiFNf0+rXgjmamZc9/XbHR
 Tsa3GdeTkedManOnlP4p2QP4cWQKVWWYFh4Ws4TFJ8/gbseREFwbUReOIzBsQNKbkfJy8PsyXsZ
 OsE20YOckyFY1fg4MRCFp7l+5HYQqnx2B2NQ6vwPK4r1qGNAbXeIZ98ulVPSkDXrPo3ObcNGjlU
 jfNUma1obwoA2/SscF5xIh6oku5/FCZViwSPzm9QN7PtSl7W943FtrfsI2sKEPLlLIQ==;
Message-ID: <2b9c85e9-58d7-4e31-b908-db3b0d0bd871@erebion.eu>
Date: Fri, 13 Nov 2026 01:56:54 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] arm64: dts: qcom: sm6350-lena: Enable ADSP,
 CDSP, IPA & MPSS
Content-Language: en-GB
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Luca Weiss <luca.weiss@fairphone.com>
References: <20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu>
 <20261102-pdx213-upstream-3-v3-4-cdc3be96d257@erebion.eu>
 <d176aebe-bc30-4585-8b71-821a30657a0d@oss.qualcomm.com>
From: erebion <erebion@erebion.eu>
Autocrypt: addr=erebion@erebion.eu; keydata=
 xjMEY7S2FRYJKwYBBAHaRw8BAQdAUf0YlT6sBQSunZeO44bgAPe+ndqTifGaNjw7vzJ2KPHN
 HGVyZWJpb24gPGVyZWJpb25AZXJlYmlvbi5ldT7CjwQTFggANxYhBJyMprURw7/YpjH7646v
 QDJuAq59BQJpWnovBQkHhhzbAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQjq9AMm4Crn057AEA
 j3didUIhbtAoppk2eNu6CbtMvkDisHWHVLaWF8YC1VsA/1P0ngBoVghELMachirfTinwBplJ
 qP7GGlSGRqSfnlAKzjgEY7S2FRIKKwYBBAGXVQEFAQEHQN6NPWcyqKdecGU1vN8FVXBwYEUd
 OAhF5jpmd7M0Ybx8AwEIB8J+BBgWCAAmFiEEnIymtRHDv9imMfvrjq9AMm4Crn0FAmlaei8F
 CQeGHNsCGwwACgkQjq9AMm4Crn075QEAoDqfm4OeAEQWMgfQ496u2S3rWJw1EMgTOP51FQbX
 rY4BAKn6AhEBh605uas3OTVtcwNIAJn1sHTA7HqqWniUe9sP
In-Reply-To: <d176aebe-bc30-4585-8b71-821a30657a0d@oss.qualcomm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------EX2iq1P6U067v00X4SWZvkHm"
X-Mailman-Approved-At: Fri, 13 Nov 2026 13:43:28 +0000
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------EX2iq1P6U067v00X4SWZvkHm
Content-Type: multipart/mixed; boundary="------------RvxOpiSSF6PfCDrX939QHyOK";
 protected-headers="v1"; hp="clear"
Message-ID: <2b9c85e9-58d7-4e31-b908-db3b0d0bd871@erebion.eu>
Date: Fri, 13 Nov 2026 01:56:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] arm64: dts: qcom: sm6350-lena: Enable ADSP,
 CDSP, IPA & MPSS
Content-Language: en-GB
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Luca Weiss <luca.weiss@fairphone.com>
References: <20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu>
 <20261102-pdx213-upstream-3-v3-4-cdc3be96d257@erebion.eu>
 <d176aebe-bc30-4585-8b71-821a30657a0d@oss.qualcomm.com>
From: erebion <erebion@erebion.eu>
Autocrypt: addr=erebion@erebion.eu; keydata=
 xjMEY7S2FRYJKwYBBAHaRw8BAQdAUf0YlT6sBQSunZeO44bgAPe+ndqTifGaNjw7vzJ2KPHN
 HGVyZWJpb24gPGVyZWJpb25AZXJlYmlvbi5ldT7CjwQTFggANxYhBJyMprURw7/YpjH7646v
 QDJuAq59BQJpWnovBQkHhhzbAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQjq9AMm4Crn057AEA
 j3didUIhbtAoppk2eNu6CbtMvkDisHWHVLaWF8YC1VsA/1P0ngBoVghELMachirfTinwBplJ
 qP7GGlSGRqSfnlAKzjgEY7S2FRIKKwYBBAGXVQEFAQEHQN6NPWcyqKdecGU1vN8FVXBwYEUd
 OAhF5jpmd7M0Ybx8AwEIB8J+BBgWCAAmFiEEnIymtRHDv9imMfvrjq9AMm4Crn0FAmlaei8F
 CQeGHNsCGwwACgkQjq9AMm4Crn075QEAoDqfm4OeAEQWMgfQ496u2S3rWJw1EMgTOP51FQbX
 rY4BAKn6AhEBh605uas3OTVtcwNIAJn1sHTA7HqqWniUe9sP
In-Reply-To: <d176aebe-bc30-4585-8b71-821a30657a0d@oss.qualcomm.com>

--------------RvxOpiSSF6PfCDrX939QHyOK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEvMi8yNiAxMjo1OSwgS29ucmFkIER5YmNpbyB3cm90ZToNCj4gRldJVyBhbGwgb3Ro
ZXIgZGV2aWNlcyBoYXZlIGFuIHVwcGVyY2FzZSAnUycgZm9yIFNvbnkgaGVyZSwgSSdkDQo+
IGxpa2UgdG8ga2VlcCB0aGF0IGNvbnNpc3RlbnQNCj4gDQo+IEtvbnJhZA0KDQpUaGFuayB5
b3UsIGRpZG4ndCBub3RpY2UhDQoNCi0tIA0KZXJlYmlvbg0KDQpYTVBQOiBlcmViaW9uQGVy
ZWJpb24uZXUNCg0KQWNjZXB0ZWQgbGFuZ3VhZ2VzOiBHZXJtYW4sIEVuZ2xpc2gsIFN3ZWRp
c2gsIE5vcndlZ2lhbiwgRGFuaXNoDQoNCg==

--------------RvxOpiSSF6PfCDrX939QHyOK--

--------------EX2iq1P6U067v00X4SWZvkHm
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQScjKa1EcO/2KYx++uOr0AybgKufQUCavZgVgUDAAAAAAAKCRCOr0AybgKufeOR
AQDVK3MOSV1de4DgpwUZLclbSokb5/z2o/pm06MTPj1OKwEAoxATUApa46KC2SnV8619BKM+EufD
BsBloLmGfnS5og0=
=8KR5
-----END PGP SIGNATURE-----

--------------EX2iq1P6U067v00X4SWZvkHm--
