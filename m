Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDCF606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=B1p9A4Y+;
	dkim=pass (2048-bit key, unprotected) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=tXhHXaQU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3420710F30E;
	Tue, 20 Oct 2026 07:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="B1p9A4Y+";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="tXhHXaQU";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DACA910EA9C
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 18:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1792435089; bh=VqmpqqxtdtIJZ/TLzgwyB+d
 L3v3MQcqOvb5KgYwYocw=; b=B1p9A4Y+0C6PVv3LUcNDYUvZLjXM7hMgxqclIUeZDGH17u3/12
 59TC3+svefDeQUfiW450E3g9puLpNneDMNBg==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=From:To:Subject:Date:Message-ID; t=1792435089; bh=VqmpqqxtdtIJZ/TLzgwyB+d
 L3v3MQcqOvb5KgYwYocw=; b=tXhHXaQUi5qgycsOpDpffLcROm85c90xVkmf35DHTkR7cZgv0z
 V/408OBAiL1ek9oMLgQ8hczG5blL82n266jjANzum6nTZHkp/5R7EKIb33ohLLO/OySUMmnfKFu
 7pKUR8zNlcIGgzmgBCljxqa2pqNER9EWI3KEwU4URfJOsgiDBZ+I5xT5l7u7krPI74geZgrzBy7
 aMcIAiBrXFqMUx+PNb0OIHdc+OQBy0AU2NgP91bdsLLKC1CGgNOmFj03MfMCuuJI1mWbV/x85vz
 T0uzOI/HTBgzy2seOdZ42RGtnyXo8nyBLS3XsVE5DrnLIohTu8TxIVX8ATe/Gc2LCHg==;
Message-ID: <dd7e4dd5-d544-4381-9d7d-14165f7d399a@erebion.eu>
Date: Mon, 19 Oct 2026 20:38:08 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] arm64: dts: qcom: sm6350-lena: Add flash LED
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
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20260926-pdx213-upstream-3-v2-0-b4612e3eb536@erebion.eu>
 <20260926-pdx213-upstream-3-v2-1-b4612e3eb536@erebion.eu>
 <0f3f754b-c612-406e-9d35-6966e64a876a@oss.qualcomm.com>
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
In-Reply-To: <0f3f754b-c612-406e-9d35-6966e64a876a@oss.qualcomm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1z05rDufjGAHpPQicdcypUP0"
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------1z05rDufjGAHpPQicdcypUP0
Content-Type: multipart/mixed; boundary="------------UKeaipVK5zzD958YpCQYpepW";
 protected-headers="v1"; hp="clear"
Message-ID: <dd7e4dd5-d544-4381-9d7d-14165f7d399a@erebion.eu>
Date: Mon, 19 Oct 2026 20:38:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] arm64: dts: qcom: sm6350-lena: Add flash LED
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
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20260926-pdx213-upstream-3-v2-0-b4612e3eb536@erebion.eu>
 <20260926-pdx213-upstream-3-v2-1-b4612e3eb536@erebion.eu>
 <0f3f754b-c612-406e-9d35-6966e64a876a@oss.qualcomm.com>
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
In-Reply-To: <0f3f754b-c612-406e-9d35-6966e64a876a@oss.qualcomm.com>

--------------UKeaipVK5zzD958YpCQYpepW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTAvMTUvMjYgMTI6NDYsIEtvbnJhZCBEeWJjaW8gd3JvdGU6DQoNCj4+ICsJCWxlZC1t
YXgtbWljcm9hbXAgPSA8MTgwMDAwPjsNCj4gDQo+IEdQVCBzdWdnZXN0cyA1MDBtQSBoZXJl
DQo+IA0KPj4gKwkJZmxhc2gtbWF4LW1pY3JvYW1wID0gPDEwMDAwMDA+Ow0KPiANCj4gYW5k
IDE1MDAgaGVyZQ0KPiANCj4gYnV0IHRoZSBkb3duc3RyZWFtIERUIGlzIG5vaXN5Li4gcGxl
YXNlIHZlcmlmeSBvbmNlIGFnYWluDQo+IA0KPiBLb25yYWQNCg0KDQpEb3duc3RyZWFtIERU
IHNheXM6DQoNCnFjb20sbWF4LWN1cnJlbnQgPSA8MHg1ZGM+OyAtPiAxNTAwIChtdXN0IGJl
IG1BKQ0KcWNvbSxjdXJyZW50LW1hID0gPDB4M2U4PjsgLT4gMTAwMA0KDQoNClNvIHRoZSBm
aXJzdCBvbmUgaXMgd3JvbmcgYW5kIHRoZSAybmQgb25lIGxvb2tzIGZpbmUuIFRoYW5rIHlv
dSwgd2lsbCANCmNoYW5nZSBsZWQtbWF4LW1pY3JvYW1wIHRvIDE1MDAwMC4NCg0KLS0gDQpl
cmViaW9uDQo=

--------------UKeaipVK5zzD958YpCQYpepW--

--------------1z05rDufjGAHpPQicdcypUP0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQScjKa1EcO/2KYx++uOr0AybgKufQUCatZjkAUDAAAAAAAKCRCOr0AybgKuffXz
AQCxliiMnmU679/FFw6CbveNLllX2vc3GERhxjlcSl/PzgD+Nejvu6sqndizVZHGKdcXkjPPsrjW
fBpZddRG908OTgA=
=pHoE
-----END PGP SIGNATURE-----

--------------1z05rDufjGAHpPQicdcypUP0--
