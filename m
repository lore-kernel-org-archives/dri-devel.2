Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF07606A32C
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=/xmGjCTB;
	dkim=pass (2048-bit key, unprotected) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=oguozKng
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 581B510EBD4;
	Mon,  2 Nov 2026 08:04:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="/xmGjCTB";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="oguozKng";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5D5310E37A
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 01:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1793582621; bh=oYF6WKJQr7/UET0LEBtfGRV
 TZHFc4OlWWVDMWmtpkLY=; b=/xmGjCTBorFOiRLcreS3l+Z6CWgyiuUHDIYlwzDBRoNPc3ZbB0
 OuGoiEFZjaXNOST6VypfEjalesLA3LSHnqCg==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=From:To:Subject:Date:Message-ID; t=1793582621; bh=oYF6WKJQr7/UET0LEBtfGRV
 TZHFc4OlWWVDMWmtpkLY=; b=oguozKngTRlwngDFs2w+bp2m4E1qe/tevr0v2oW7hFiDLh7p2V
 UPwK287tqrPKZkz/LF0b5h83Lb93NmkHBsvA8qdzv4qA35Gr1I/tV4AsufSp+LjAcvKPTtsj4tz
 q8l+JCi6Rz90KmVEskYUyOnk+ipKHPHGKcER8eUfrXBNrw4n7Ekh8MvbI+8ldtSk+naR6SRZrtr
 FeXnhWiLuoL1ITrz3FYQ/YFROo2tN3uI7gVCqwa3ulVUZv8GFaiKUj2PXClmkrAv6Vu82AgFhd4
 QXS5GbUbMTSR+bntIR7OHLPPWjJMHk75DfIIOnBA2jvYQ2khByjsdX8BMy2K5WDIfAQ==;
Message-ID: <bc642f13-d532-46ca-afcf-678c49e8f1cd@erebion.eu>
Date: Mon, 2 Nov 2026 02:23:41 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] arm64: dts: qcom: sm6350-lena: Enable ADSP,
 CDSP, IPA & MPSS
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
References: <20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu>
 <20261102-pdx213-upstream-3-v3-4-cdc3be96d257@erebion.eu>
 <sashiko-outbox-192764@kernel.org>
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
In-Reply-To: <sashiko-outbox-192764@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------fTwScMSe0Hkot07lqpw0EolE"
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:03:58 +0000
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
--------------fTwScMSe0Hkot07lqpw0EolE
Content-Type: multipart/mixed; boundary="------------LgG41laI7Wv0Z1E1Z1jI5cAQ";
 protected-headers="v1"; hp="clear"
Message-ID: <bc642f13-d532-46ca-afcf-678c49e8f1cd@erebion.eu>
Date: Mon, 2 Nov 2026 02:23:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] arm64: dts: qcom: sm6350-lena: Enable ADSP,
 CDSP, IPA & MPSS
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
References: <20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu>
 <20261102-pdx213-upstream-3-v3-4-cdc3be96d257@erebion.eu>
 <sashiko-outbox-192764@kernel.org>
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
In-Reply-To: <sashiko-outbox-192764@kernel.org>

--------------LgG41laI7Wv0Z1E1Z1jI5cAQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEvMi8yNiAwMDo0MSwgc2FzaGlrby1ib3RAa2VybmVsLm9yZyB3cm90ZToNCj4gVGhh
bmsgeW91IGZvciB5b3VyIGNvbnRyaWJ1dGlvbiEgU2FzaGlrbyBBSSByZXZpZXcgZm91bmQg
MSBwb3RlbnRpYWwgaXNzdWUocykgdG8gY29uc2lkZXI6DQo+IC0gW0xvd10gYXJtNjQ6IGR0
czogcWNvbTogcmVkdW5kYW50IElQQSBwcm9wZXJ0aWVzIGluIHNtNjM1MC1sZW5hIGJvYXJk
IERUUw0KDQpRdWl0ZSByaWdodCwgZGlkbid0IG5vdGljZSB0aGF0LCBmaXhlZCBpbiB2NC4u
Lg0KDQotLSANCmVyZWJpb24NCg0KWE1QUDogZXJlYmlvbkBlcmViaW9uLmV1DQoNCk15IGxh
bmd1YWdlczogR2VybWFuLCBFbmdsaXNoLCBTd2VkaXNoLCBOb3J3ZWdpYW4sIERhbmlzaA0K
WWVzLCBJJ20gYSBsYW5ndWFnZSBuZXJkLiBGZWVsIGZyZWUgdG8gd3JpdGUgdG8gbWUgaW4g
YW55IG9mIHRoZSANCmFmb3JlbWVudGlvbmVkIGxhbmd1YWdlcy4NCg0K

--------------LgG41laI7Wv0Z1E1Z1jI5cAQ--

--------------fTwScMSe0Hkot07lqpw0EolE
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQScjKa1EcO/2KYx++uOr0AybgKufQUCaufmHQUDAAAAAAAKCRCOr0AybgKufWtX
AP4jK3dW/YOnu3EA0gqJMHxm/kZhJNPVapyjUZ7azijPHAEA1HQcddR5TgtF7N553oiD98cI0j4l
1Jz1+6Yz3oXRDgY=
=S2ah
-----END PGP SIGNATURE-----

--------------fTwScMSe0Hkot07lqpw0EolE--
