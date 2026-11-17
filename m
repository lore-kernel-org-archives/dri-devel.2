Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20615606A335
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=PB8nsasG;
	dkim=pass (2048-bit key, unprotected) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=NqqhjiQq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B28410EA67;
	Wed, 18 Nov 2026 08:23:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="PB8nsasG";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="NqqhjiQq";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 168EF10E623
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 18:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1794939209; bh=bwLHiceTB047v2ScTeAnvuX
 njg5cRmD9pk1qQPUmwPY=; b=PB8nsasGFp1PALkuQ1gVW5V5BDCOTmTstEHR5ta9y2+qjvMFiO
 Krbk8uBBhltG2JPiSYUZ3IyHDihAG5gAfJAA==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=From:To:Subject:Date:Message-ID; t=1794939209; bh=bwLHiceTB047v2ScTeAnvuX
 njg5cRmD9pk1qQPUmwPY=; b=NqqhjiQqSJBXhiMp1YpwqXdku1q562bbd4lhZtSKmaRxjYeSAp
 n7mJzlqIkgGGYxa+vpgVbhiFBnh6FI5tSALpPzJ1cHJaW0hdjd6VqtBkoPAnuyVjV6bjJxhAxXQ
 Z4gUmlnq8p5e/whs+H8Z/YCSRC5DIxBxULGE96pzuoF60fNvwk6mCXNLTjaon8wMixAJZiS/6Fh
 n9HmNzaVAd7mi1A/2HBesw/eyH152TMTky4wG/y+B6GN6l5yjGvVj3IxsT0LKTC4K2IGocgRteJ
 CSN9PVyV5hDEWI0fa6vI0X/i4777cpexISNMGOWTgXdzJGhp3aYMbjMc5HTPEjEQYPg==;
Message-ID: <a164ee03-d2be-46b3-9079-3fd60ae02079@erebion.eu>
Date: Tue, 17 Nov 2026 19:13:28 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] arm64: dts: qcom: sm6350-lena: Add PM7250B
 thermals
Content-Language: en-GB
To: Luca Weiss <luca.weiss@fairphone.com>,
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
 phone-devel@vger.kernel.org
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-9-7318a19806eb@erebion.eu>
 <DMXH1UYFI74N.FT441QG9ND7@fairphone.com>
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
In-Reply-To: <DMXH1UYFI74N.FT441QG9ND7@fairphone.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Fa2ptS4d9zB5EK84n9ecp0Nu"
X-Mailman-Approved-At: Wed, 18 Nov 2026 08:23:05 +0000
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
--------------Fa2ptS4d9zB5EK84n9ecp0Nu
Content-Type: multipart/mixed; boundary="------------lsyxdZs7ypaUT8bUSEkJ07y6";
 protected-headers="v1"; hp="clear"
Message-ID: <a164ee03-d2be-46b3-9079-3fd60ae02079@erebion.eu>
Date: Tue, 17 Nov 2026 19:13:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] arm64: dts: qcom: sm6350-lena: Add PM7250B
 thermals
Content-Language: en-GB
To: Luca Weiss <luca.weiss@fairphone.com>,
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
 phone-devel@vger.kernel.org
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-9-7318a19806eb@erebion.eu>
 <DMXH1UYFI74N.FT441QG9ND7@fairphone.com>
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
In-Reply-To: <DMXH1UYFI74N.FT441QG9ND7@fairphone.com>

--------------lsyxdZs7ypaUT8bUSEkJ07y6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPbiAxMS8xNy8yNiAxMzowNiwgTHVjYSBXZWlzcyB3cm90ZToNCj4gT24gTW9uIE5vdiAx
NiwgMjAyNiBhdCAxMTo1MCBQTSBDRVQsIGVyZWJpb24gd3JvdGU6DQo+PiBDb25maWd1cmUg
dGhlIHRoZXJtYWxzIGZvciB0aGUgY2hnLXNraW4tdGhlcm1hbCBhbmQgY29ubi10aGVybSB0
aGVybWlzdG9ycyBjb25uZWN0ZWQgdG8NCj4gDQo+IFRoaXMgbGluZSBpcyBhIGJpdCBsb25n
LiBJZiB5b3UgcmUtc2VuZCwgcGxlYXNlIHdyYXAgaXQuDQoNCkFzIEkndmUgb25seSBhZGRl
ZCBhIGxpbmVicmVhayBpbiB0aGUgY29tbWl0IG1lc3NhZ2UsIEkgZ3Vlc3MgaXQgd2lsbCBi
ZSANCmZpbmUgaWYgSSBsZWF2ZSB0aGUgUmV2aWV3ZWQtYnkgaW4gdGhlcmUuIFRoYW5rcyEN
Cg0KDQotLSANCmVyZWJpb24NCg0KWE1QUDogZXJlYmlvbkBlcmViaW9uLmV1DQoNCkFjY2Vw
dGVkIGxhbmd1YWdlczogR2VybWFuLCBFbmdsaXNoLCBTd2VkaXNoLCBOb3J3ZWdpYW4sIERh
bmlzaA0KDQo=

--------------lsyxdZs7ypaUT8bUSEkJ07y6--

--------------Fa2ptS4d9zB5EK84n9ecp0Nu
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQScjKa1EcO/2KYx++uOr0AybgKufQUCavyZSAUDAAAAAAAKCRCOr0AybgKufThK
AP9g8PBKyZGAO8pyNFEgg6wZ68YTStLQFq+J7BWXndfEPwD/X1bI3N3C/4nmkakR9jdSQHJMac+i
OuTWiPNuXRRW6Ac=
=y+aL
-----END PGP SIGNATURE-----

--------------Fa2ptS4d9zB5EK84n9ecp0Nu--
