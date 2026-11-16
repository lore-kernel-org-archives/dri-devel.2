Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B488606A330
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=60q11bcJ;
	dkim=pass (2048-bit key) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=ooCejUep
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA6BC10EB45;
	Tue, 17 Nov 2026 08:07:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="60q11bcJ";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="ooCejUep";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1483910EA82
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 23:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1794870464; bh=8+3U529qd98YQA4pnP8Fc2U
 R/OHyX4N7wio2v6kJcCs=; b=60q11bcJiNMgCW+li2uUR8ofFJeC6OOl5bTBk3miDpXMF1dPiy
 MMpvSUahT1Z4Wk3F7WaHl6aNPEGaohKUShDg==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=From:To:Subject:Date:Message-ID; t=1794870464; bh=8+3U529qd98YQA4pnP8Fc2U
 R/OHyX4N7wio2v6kJcCs=; b=ooCejUeps+mWMliB0nJ+m8yBz1LWyIVXPhaS0PmB+e9wAUgiJ9
 FlU2flXs5KO1+Q3A4Nn3jd5DB3Ci3Souf9G0oWP6UpnvwSCtX8QDV7eH4alNocYzp5vqK13OwNH
 wWtg4CWZqlomhv9kFnFCuimGHojR0kPe4jRAfp+NZltHzWg8weG+9fYJffyIsAY23VGoRo007BO
 ziu4zkDHK19BiCsbHNuff2YN717w64d7i2ReQ2Utbjed5STQXKxFGZW8WELqhk8DkyzAh0Xe1Zc
 nYxwIVlpx7Zf3OSmhwQe2hqWopW+KM8x62l7oFXvfwi0I7PHm4QeGPX5We/qk1TRN/Q==;
Message-ID: <65722de3-1a7a-4be4-87c3-db553ffe3f02@erebion.eu>
Date: Tue, 17 Nov 2026 00:07:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/12] arm64: dts: qcom: sm6350-lena: Add PMK8350
 thermals
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-10-7318a19806eb@erebion.eu>
 <sashiko-outbox-217832@kernel.org>
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
In-Reply-To: <sashiko-outbox-217832@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------5WWZRXgWmTAmybL0yLwsA4Su"
X-Mailman-Approved-At: Tue, 17 Nov 2026 08:07:18 +0000
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
--------------5WWZRXgWmTAmybL0yLwsA4Su
Content-Type: multipart/mixed; boundary="------------JjcnBEAqzdKFJPiL08fgFnv0";
 protected-headers="v1"; hp="clear"
Message-ID: <65722de3-1a7a-4be4-87c3-db553ffe3f02@erebion.eu>
Date: Tue, 17 Nov 2026 00:07:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/12] arm64: dts: qcom: sm6350-lena: Add PMK8350
 thermals
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-10-7318a19806eb@erebion.eu>
 <sashiko-outbox-217832@kernel.org>
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
In-Reply-To: <sashiko-outbox-217832@kernel.org>

--------------JjcnBEAqzdKFJPiL08fgFnv0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEvMTcvMjYgMDA6MDAsIHNhc2hpa28tYm90QGtlcm5lbC5vcmcgd3JvdGU6DQo+IFRo
YW5rIHlvdSBmb3IgeW91ciBjb250cmlidXRpb24hIFNhc2hpa28gQUkgcmV2aWV3IGZvdW5k
IDEgcG90ZW50aWFsDQo+IGlzc3VlIHRvIGNvbnNpZGVyOg0KPiAtIFtIaWdoXSBhcm02NDog
ZHRzOiBxY29tOiBTaWduZWQtb2ZmLWJ5IHRyYWlsZXIgdXNlcyBoYW5kbGUgaW5zdGVhZCBv
Zg0KPiAgICByZWFsIG5hbWUNClRoYXQgd2FzIGFscmVhZHkgZGlzY3Vzc2VkIGluIHYyIG9m
IHRoaXMgcGF0Y2ggc2VyaWVzLg0KDQotLSANCmVyZWJpb24NCg0KWE1QUDogZXJlYmlvbkBl
cmViaW9uLmV1DQoNCkFjY2VwdGVkIGxhbmd1YWdlczogR2VybWFuLCBFbmdsaXNoLCBTd2Vk
aXNoLCBOb3J3ZWdpYW4sIERhbmlzaA0KDQo=

--------------JjcnBEAqzdKFJPiL08fgFnv0--

--------------5WWZRXgWmTAmybL0yLwsA4Su
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQScjKa1EcO/2KYx++uOr0AybgKufQUCavuMvwUDAAAAAAAKCRCOr0AybgKufSkB
AQDtYQbjaZLozYYTWk/wQwfYDg0In3HWNYsKheTxEPQIWQEAmYKeDShJC1rsttQcFnOWzd+tF7Bd
FOSYQiXbBiw2zgg=
=Uzh6
-----END PGP SIGNATURE-----

--------------5WWZRXgWmTAmybL0yLwsA4Su--
