Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A03606A323
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=RwkeM2rr;
	dkim=pass (2048-bit key) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=O8Wt/F+K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 074EA10F102;
	Tue, 17 Nov 2026 08:09:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="RwkeM2rr";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="O8Wt/F+K";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91E2910F4AF
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 23:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1794870263; bh=j2x8Tpvx8WYIy+3bXYn17np
 56lLBZUPkigXsxBhPbXU=; b=RwkeM2rrRXVsxVJAo1KQtXnQKR8g6iiL2CQiM45eJ2p5vH79Kf
 WNwznqlYRd1aTvxv+6xXF+4Tok6jKZQunhCQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=From:To:Subject:Date:Message-ID; t=1794870263; bh=j2x8Tpvx8WYIy+3bXYn17np
 56lLBZUPkigXsxBhPbXU=; b=O8Wt/F+K54x0eImL8PZCL9X50PA2vfGMxCkKta5PaJ7ArHxpif
 OzqUxZnkYrlsY6IAU5Gddd9wCnQklD7Y3gRNVow9pjZyKnjuZlVle/KpiYPaO2vKNtCvPDE/JD5
 DDDPg07nOzU5rIxQWmHoPqQLniRwDcMtsdDjg5p6j39+6pC5Xb78FPAAA5gQKvg+kA9BlnODhXP
 hf6tpHPl9RiiKuPiiouYawSRfA8SIZKlu1Knfy2WEFBNlN52bLWorWfj3RUypLKagGY9ElsihcN
 qPpIQhXT+cwkEyQ1t7IzkIdO92T8Qfhfkg4H/xnCQp8Cs/0YLcsw9TXoSHNqCX25eCw==;
Message-ID: <e11455d3-3c31-49f3-a07d-fcd16e07d7c7@erebion.eu>
Date: Tue, 17 Nov 2026 00:04:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/12] arm64: dts: qcom: sm6350-lena: Add flash LED
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-1-7318a19806eb@erebion.eu>
 <sashiko-outbox-217820@kernel.org>
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
In-Reply-To: <sashiko-outbox-217820@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------04ETg4ij6ZexJR73S0kW9FHD"
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
--------------04ETg4ij6ZexJR73S0kW9FHD
Content-Type: multipart/mixed; boundary="------------RfL70zXn0lhzzKbf2jtM0TQG";
 protected-headers="v1"; hp="clear"
Message-ID: <e11455d3-3c31-49f3-a07d-fcd16e07d7c7@erebion.eu>
Date: Tue, 17 Nov 2026 00:04:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/12] arm64: dts: qcom: sm6350-lena: Add flash LED
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-1-7318a19806eb@erebion.eu>
 <sashiko-outbox-217820@kernel.org>
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
In-Reply-To: <sashiko-outbox-217820@kernel.org>

--------------RfL70zXn0lhzzKbf2jtM0TQG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

PiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IEFzIHJlcG9ydGVkIGJ5IEJqb3JuIEFuZGVyc3NvbiBv
biB2MiBbMV0sIHRoZSBBdXRob3IgYW5kIFNpZ25lZC1vZmYtYnkNCj4gZmllbGRzIHVzZSB0
aGUgc2luZ2xlLXdvcmQgaGFuZGxlICJlcmViaW9uIiBpbnN0ZWFkIG9mIGEgcmVhbCBodW1h
biBuYW1lLA0KPiB3aGljaCBkb2VzIG5vdCBzYXRpc2Z5IHRoZSBEZXZlbG9wZXIncyBDZXJ0
aWZpY2F0ZSBvZiBPcmlnaW4gcmVxdWlyZW1lbnRzDQo+IGluIERvY3VtZW50YXRpb24vcHJv
Y2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMucnN0Lg0KPiANCj4gWzFdIGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL3IvYXJuRjB1MkY5aXBmbk5QLUB6ZW5ib29rDQo+IA0KDQpBbmQgYXMgTHVj
YSBXZWlzcyBwb2ludGVkIG91dCwgdGhlcmUgaXMgbm8gaXNzdWUuDQoNClBsZWFzZSwgY2Fu
IHNvbWVvbmUgZmluYWxseSBzdG9wIHRoZSBib3QgZnJvbSBzYXlpbmcgdGhlIHNhbWUgZm9y
IGV2ZXJ5IA0Kc2luZ2xlIGNvbW1pdC4uPw0KDQotLSANCmVyZWJpb24NCg0KWE1QUDogZXJl
YmlvbkBlcmViaW9uLmV1DQoNCkFjY2VwdGVkIGxhbmd1YWdlczogR2VybWFuLCBFbmdsaXNo
LCBTd2VkaXNoLCBOb3J3ZWdpYW4sIERhbmlzaA0KDQo=

--------------RfL70zXn0lhzzKbf2jtM0TQG--

--------------04ETg4ij6ZexJR73S0kW9FHD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQScjKa1EcO/2KYx++uOr0AybgKufQUCavuL9gUDAAAAAAAKCRCOr0AybgKufTKB
AP9/r3ZBRES9r+taE1xnjkcRYctw5SrDZ0NYkh3wgf5l5AEAnlggjbe9+aU5Hd3YjuLJPQ2kJcvr
y6/nZD7DswIgPwc=
=GYgI
-----END PGP SIGNATURE-----

--------------04ETg4ij6ZexJR73S0kW9FHD--
