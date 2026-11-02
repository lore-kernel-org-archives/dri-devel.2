Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EBF606A329
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=2FLt/AkK;
	dkim=pass (2048-bit key, unprotected) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=Ie5KVRw1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8C7810F437;
	Tue,  3 Nov 2026 08:22:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="2FLt/AkK";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="Ie5KVRw1";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B90F310E5B8
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 08:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1793608605; bh=LOCTMQ1srMwoLHdDzXY4ap1
 GXVFuZ/PHi1A1lWwV1zM=; b=2FLt/AkKxcYYaJqfZj3/Bz3H1cJsYNQL89ggm8T1ATo+FM6Ts4
 Uaxjxaq3YsH1KlpUUzMXLxxxHJrQwmQMOjCg==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=From:To:Subject:Date:Message-ID; t=1793608605; bh=LOCTMQ1srMwoLHdDzXY4ap1
 GXVFuZ/PHi1A1lWwV1zM=; b=Ie5KVRw1YO61cNzjzUIQqLDzGb995KaYQQS0AMPyFpj2H+Ki32
 mbMlBJNmdIehHfbJWU0SkpuW9hOcD74kCTZon74XNrq10f2wMU4yFyf+d3pstUVvyEFYOllosrX
 VZxB5v2MOg2ftY5AKLL1Eo4tmWoDeqbA3/o1hoLD2eFjQRvNSRT0prOvP0cw0fXTHiusJJp9YiR
 wn8jV41PxCg7biHE0o3QiR0jfcbCuCs5o+RMRiqYvECDfnddHdixicI+BpslcNmWsjWh0AM3aoq
 qFk9QruJLDRYumMcHUtGglb094PYqEpG7P+kX/dhlxhaU4vdLJeBUf9SJccZc37QxGQ==;
Message-ID: <63c329fc-0ff2-4402-b575-e26e25b3ff8b@erebion.eu>
Date: Mon, 2 Nov 2026 09:36:46 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/12] arm64: dts: qcom: sm6350-lena: rename
 touch-en-regulator
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
References: <20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu>
 <20261102-pdx213-upstream-3-v3-2-cdc3be96d257@erebion.eu>
 <sashiko-outbox-192758@kernel.org>
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
In-Reply-To: <sashiko-outbox-192758@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1zMlbbPw2yA7NEha6URysRrv"
X-Mailman-Approved-At: Tue, 03 Nov 2026 08:21:46 +0000
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
--------------1zMlbbPw2yA7NEha6URysRrv
Content-Type: multipart/mixed; boundary="------------Yc0R4nlDaTZca2G7LoGTbbzt";
 protected-headers="v1"; hp="clear"
Message-ID: <63c329fc-0ff2-4402-b575-e26e25b3ff8b@erebion.eu>
Date: Mon, 2 Nov 2026 09:36:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/12] arm64: dts: qcom: sm6350-lena: rename
 touch-en-regulator
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
References: <20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu>
 <20261102-pdx213-upstream-3-v3-2-cdc3be96d257@erebion.eu>
 <sashiko-outbox-192758@kernel.org>
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
In-Reply-To: <sashiko-outbox-192758@kernel.org>

--------------Yc0R4nlDaTZca2G7LoGTbbzt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEvMi8yNiAwMDozOCwgc2FzaGlrby1ib3RAa2VybmVsLm9yZyB3cm90ZToNCj4gVGhh
bmsgeW91IGZvciB5b3VyIGNvbnRyaWJ1dGlvbiEgU2FzaGlrbyBBSSByZXZpZXcgZm91bmQg
MiBwb3RlbnRpYWwgaXNzdWUocykgdG8gY29uc2lkZXI6DQo+IC0gW01lZGl1bV0gYXJtNjQ6
IGR0czogcWNvbTogc202MzUwLWxlbmE6IHN0cmF5IHVudXNlZCByZWd1bGF0b3ItbGNkYi1k
dW1teSBub2RlDQoNCk9oIG5vLCB0aGF0IG9mIGNvdXJzZSBzaG91bGQgbm90IGJlIGluIHRo
ZXJlIGFuZCB3aWxsIHJlbW92ZSB0aGF0IHdpdGggDQp2NCBvZiB0aGlzIHBhdGNoIHNlcmll
cy4uLg0KDQo+IC0gW01lZGl1bV0gYXJtNjQ6IGR0czogcWNvbTogc202MzUwLWxlbmE6IGlu
dmFsaWQgbGVkLW1heC1taWNyb2FtcCBpbiBwbTYxNTBsX2ZsYXNoDQoNCkJvdCBhbHJlYWR5
IGNvbXBsYWluZWQgb24gdGhlIGZsYXNoIExFRCBwYXRjaC4uLg0KDQotLSANCmVyZWJpb24N
Cg0KWE1QUDogZXJlYmlvbkBlcmViaW9uLmV1DQoNCk15IGxhbmd1YWdlczogR2VybWFuLCBF
bmdsaXNoLCBTd2VkaXNoLCBOb3J3ZWdpYW4sIERhbmlzaA0KWWVzLCBJJ20gYSBsYW5ndWFn
ZSBuZXJkLiBGZWVsIGZyZWUgdG8gd3JpdGUgdG8gbWUgaW4gYW55IG9mIHRoZSANCmFmb3Jl
bWVudGlvbmVkIGxhbmd1YWdlcy4NCg0K

--------------Yc0R4nlDaTZca2G7LoGTbbzt--

--------------1zMlbbPw2yA7NEha6URysRrv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQScjKa1EcO/2KYx++uOr0AybgKufQUCauhLngUDAAAAAAAKCRCOr0AybgKufbAj
AQCugOnQNhF7bSbWnpiRtSybkYyGVFdtISiL0f8r/aViigEAttB4YzFPc7KahhGlrIDPfqGv9VKm
JSWf+3NL/MwMpgc=
=XyV4
-----END PGP SIGNATURE-----

--------------1zMlbbPw2yA7NEha6URysRrv--
