Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F4A606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=WrwxBB5C;
	dkim=pass (2048-bit key, unprotected) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=eBJL4P/I
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A711310EBEA;
	Mon,  2 Nov 2026 08:04:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="WrwxBB5C";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="eBJL4P/I";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C068410EB20
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 00:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1793580076; bh=ha553o7VVEnJLN7WZLxD2YS
 /lsVO9uX8I7dIyIXm6uI=; b=WrwxBB5Cgz087rd41Hd1MF3enU+yrMYIqZRBfGS68+OEI4f16j
 w4m+uROxszOmEV6PJtzySX0O4iZCII9hwhCQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=From:To:Subject:Date:Message-ID; t=1793580076; bh=ha553o7VVEnJLN7WZLxD2YS
 /lsVO9uX8I7dIyIXm6uI=; b=eBJL4P/IGvSkXECT3EVArc/gppxNf91dhq6SUUclwZ+LuZhrc+
 CEl8nOXvZRydX8CVZGqAJBT5hetDzPRILqLf+s0vLyUv+CnFww5EDDuzJy04TZjRZU+aVBGK20X
 6w3bulXcKwpfwqA1gE9LyT11D5SVmUihq/0+r9QZu9a8DFf3vMUnrvywPdHS0wIPXmW/xEjhTxW
 Fogq4+FkYNvX3qQcaBTCB0kxs2nxaj+RLMBg1mtcRSxEWCqZ3pgPmW/AYwS8nrHYIq7YuvaXNzY
 ID5yx6AVgZDd0evXP8EjEpEk+KbSCCw2F69U8O9JfCogfFD/XFGRn1C/sD6s4NmoS8A==;
Message-ID: <0a1333ab-9deb-425b-aaeb-737eedefb093@erebion.eu>
Date: Mon, 2 Nov 2026 01:41:15 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] arm64: dts: qcom: sm6350-lena: Enable Bluetooth
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu>
 <20261102-pdx213-upstream-3-v3-5-cdc3be96d257@erebion.eu>
 <sashiko-outbox-192770@kernel.org>
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
In-Reply-To: <sashiko-outbox-192770@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1q3Fave0c6Xa17tUQLJxEmYd"
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
--------------1q3Fave0c6Xa17tUQLJxEmYd
Content-Type: multipart/mixed; boundary="------------51ZeVxMtWai6uINlADMwO0VA";
 protected-headers="v1"; hp="clear"
Message-ID: <0a1333ab-9deb-425b-aaeb-737eedefb093@erebion.eu>
Date: Mon, 2 Nov 2026 01:41:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] arm64: dts: qcom: sm6350-lena: Enable Bluetooth
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu>
 <20261102-pdx213-upstream-3-v3-5-cdc3be96d257@erebion.eu>
 <sashiko-outbox-192770@kernel.org>
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
In-Reply-To: <sashiko-outbox-192770@kernel.org>

--------------51ZeVxMtWai6uINlADMwO0VA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

QCBLb25yYWQgRHliY2lvOiBJIHJlbW92ZWQgaXQgbGlrZSB5b3Ugc3VnZ2VzdGVkLCBub3cg
dGhlIGJvdCBpbnNpc3RzIEkgDQphZGQgaXQgYmFjay4NCg0KSG9waW5nIHlvdSBjYW4gY29t
bWVudCBvbiB0aGUgYm90J3MgZGlzYWdyZWVtZW50IHdpdGggeW91LiA6KQ0KDQpPbiAxMS8y
LzI2IDAwOjQ1LCBzYXNoaWtvLWJvdEBrZXJuZWwub3JnIHdyb3RlOg0KPiBUaGFuayB5b3Ug
Zm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJldmlldyBmb3VuZCAxIHBvdGVu
dGlhbCBpc3N1ZShzKSB0byBjb25zaWRlcjoNCj4gLSBbTWVkaXVtXSBhcm02NDogZHRzOiBx
Y29tOiBtaXNzaW5nIGJpYXMtYnVzLWhvbGQgb24gcXVwX3VhcnQxX2N0cyBpbiBkZWZhdWx0
IHN0YXRlDQotLSANCmVyZWJpb24NCg0KWE1QUDogZXJlYmlvbkBlcmViaW9uLmV1DQoNCk15
IGxhbmd1YWdlczogR2VybWFuLCBFbmdsaXNoLCBTd2VkaXNoLCBOb3J3ZWdpYW4sIERhbmlz
aA0KWWVzLCBJJ20gYSBsYW5ndWFnZSBuZXJkLiBGZWVsIGZyZWUgdG8gd3JpdGUgdG8gbWUg
aW4gYW55IG9mIHRoZSANCmFmb3JlbWVudGlvbmVkIGxhbmd1YWdlcy4NCg0K

--------------51ZeVxMtWai6uINlADMwO0VA--

--------------1q3Fave0c6Xa17tUQLJxEmYd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQScjKa1EcO/2KYx++uOr0AybgKufQUCaufcKwUDAAAAAAAKCRCOr0AybgKufUMi
APwNZEwTyKJYMOmzZqs5GguzMzZSAKiedoI/2s6f84B5cAD/XadEAiOe9TnWX7ZfFnCOoS7qSS6W
wH/u33x4bAGpxw0=
=fRZ1
-----END PGP SIGNATURE-----

--------------1q3Fave0c6Xa17tUQLJxEmYd--
