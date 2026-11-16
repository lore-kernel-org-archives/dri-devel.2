Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DFB606A332
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=X71u4DUl;
	dkim=pass (2048-bit key) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=LBVaY4Lw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 803DC10EE77;
	Tue, 17 Nov 2026 08:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="X71u4DUl";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="LBVaY4Lw";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEB9D10EA82
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 23:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1794870475; bh=9aNwN68lRN1fwqP/2UBNkUU
 K/b59LmcDO1GHfggdOv4=; b=X71u4DUlycqxtV5W1b6HBj8Ja1idQBeVNF6R38KVOYlkpqHD/2
 Ck1FDDlL7zMrP52aKebmhNPbRKTZwzF4ZmCw==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=From:To:Subject:Date:Message-ID; t=1794870475; bh=9aNwN68lRN1fwqP/2UBNkUU
 K/b59LmcDO1GHfggdOv4=; b=LBVaY4LwYV2F7s8XUI9/LWSqf+62rg7Aid+KhVhIeYftqQbHs+
 0Rzg5lxcjHIT/dKgJ8Xy8Vd5+t8A4u2tArGSKVLJLfZ6GENeRMOJ4ivg9cgi8CnjnCXJmD9osBz
 4sb9b14cehaWDcEQ8C3pscGTA83JwZ7Tc4DUjFdXdazynUgyQuGZ4ARvLl1eW3hz9cNTk7yhWrn
 Orj9mUzre0ezhChljgCu59dnZ0D5GC+dTnb4YDNoqqhwxLIaoO13OvA3AiwXmA6KLJvgUGs272u
 uMn3Zym8gPtQ0vsY9VhuU3EmuZUDWHvPA7MYFfeD5Td3LKdVwbM6D6As4hOla4DKk3g==;
Message-ID: <ff6cffb9-56fa-45c1-8631-96c6fa5646d7@erebion.eu>
Date: Tue, 17 Nov 2026 00:07:54 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/12] arm64: dts: qcom: sm6350-lena: Add PM6150L
 thermals
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-11-7318a19806eb@erebion.eu>
 <sashiko-outbox-217837@kernel.org>
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
In-Reply-To: <sashiko-outbox-217837@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------wUusbU8AqlzMnfGvnPIFQ6um"
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
--------------wUusbU8AqlzMnfGvnPIFQ6um
Content-Type: multipart/mixed; boundary="------------OGaPzVCDlJsZ6028o91o2k1J";
 protected-headers="v1"; hp="clear"
Message-ID: <ff6cffb9-56fa-45c1-8631-96c6fa5646d7@erebion.eu>
Date: Tue, 17 Nov 2026 00:07:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/12] arm64: dts: qcom: sm6350-lena: Add PM6150L
 thermals
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-11-7318a19806eb@erebion.eu>
 <sashiko-outbox-217837@kernel.org>
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
In-Reply-To: <sashiko-outbox-217837@kernel.org>

--------------OGaPzVCDlJsZ6028o91o2k1J
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEvMTcvMjYgMDA6MDIsIHNhc2hpa28tYm90QGtlcm5lbC5vcmcgd3JvdGU6DQo+IFRo
YW5rIHlvdSBmb3IgeW91ciBjb250cmlidXRpb24hIFNhc2hpa28gQUkgcmV2aWV3IGZvdW5k
IDEgcG90ZW50aWFsDQo+IGlzc3VlIHRvIGNvbnNpZGVyOg0KPiAtIFtIaWdoXSBhcm02NDog
ZHRzOiBxY29tOiBzbTYzNTAtbGVuYTogaGFuZGxlIHVzZWQgaW4gQXV0aG9yIGFuZA0KPiAg
ICBTaWduZWQtb2ZmLWJ5DQoNClRoYXQgd2FzIGFscmVhZHkgZGlzY3Vzc2VkIGluIHYyIG9m
IHRoaXMgcGF0Y2ggc2VyaWVzLg0KDQotLSANCmVyZWJpb24NCg0KWE1QUDogZXJlYmlvbkBl
cmViaW9uLmV1DQoNCkFjY2VwdGVkIGxhbmd1YWdlczogR2VybWFuLCBFbmdsaXNoLCBTd2Vk
aXNoLCBOb3J3ZWdpYW4sIERhbmlzaA0KDQo=

--------------OGaPzVCDlJsZ6028o91o2k1J--

--------------wUusbU8AqlzMnfGvnPIFQ6um
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQScjKa1EcO/2KYx++uOr0AybgKufQUCavuMygUDAAAAAAAKCRCOr0AybgKufZuZ
AQCBG0YTMqMCqbjtcag+2Qxlgz+BC4R2niNCXenJfVk54wEAj3YKkIEvzwEhR/36PRPP/n2zcfc9
3bodKKFagdjctAw=
=uL6p
-----END PGP SIGNATURE-----

--------------wUusbU8AqlzMnfGvnPIFQ6um--
