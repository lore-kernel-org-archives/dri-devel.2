Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCC8606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=sz3wKmQ+;
	dkim=pass (2048-bit key) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=GgEId5a1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C722110EBC2;
	Wed, 18 Nov 2026 08:23:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="sz3wKmQ+";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="GgEId5a1";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8995610E62D
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 18:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1794939390; bh=tAFphuNZhSMbXbrfeyiF5cR
 g1vQ1G5E1UchQJDp49uM=; b=sz3wKmQ+4jyhpUeg8eBoRjZrUVtKSlSbP4ku5TcA8jfrDe7AXn
 IAd8CTJ0Y1DixtC0fQp3rhKkAi8iUzjfU3DQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=From:To:Subject:Date:Message-ID; t=1794939390; bh=tAFphuNZhSMbXbrfeyiF5cR
 g1vQ1G5E1UchQJDp49uM=; b=GgEId5a1Mn8eD2a2afWfliHlYTqly+FWA4sHjHZj8Z7xNlyw3z
 UsaGDphUM1pVQUZ830/KWZdO8FHJRqWAU66/v1tCrSeQv+t4Spezrx81vc7M1T2mWx2OFXAr5jI
 PX+qX0jElWKpRXaK4T7j42yTGJpCYlKjPw+hjm7MuW2F+ZIRrbE1DWjT1AjmB5BzSsbbyX6jgrx
 TpaFMo7dbKUHIhyWTkEgO4n4e0FrzGppISM8cUhH6w6YvsFwXGhvgti4Xypbo9MZq+MAuNS+AB3
 3yGJO8Tx4zUfg7DAxebZgV1PNGo48ErkHzKfczGxd2dtZt5J+NE2ondo7wUufDpXWMg==;
Message-ID: <4f63673e-67c8-4f68-b3f5-82a0579e2b49@erebion.eu>
Date: Tue, 17 Nov 2026 19:16:29 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/12] arm64: dts: qcom: sm6350-lena: enable remaining
 i2c busses
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
 phone-devel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-12-7318a19806eb@erebion.eu>
 <DMXH52GLPXUT.236KX5W7LSRY7@fairphone.com>
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
In-Reply-To: <DMXH52GLPXUT.236KX5W7LSRY7@fairphone.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------IZh0FgOC0Mzl8kpWZefDdfl9"
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------IZh0FgOC0Mzl8kpWZefDdfl9
Content-Type: multipart/mixed; boundary="------------sDXDqMcp6Uq300MvD41ZVktY";
 protected-headers="v1"; hp="clear"
Message-ID: <4f63673e-67c8-4f68-b3f5-82a0579e2b49@erebion.eu>
Date: Tue, 17 Nov 2026 19:16:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/12] arm64: dts: qcom: sm6350-lena: enable remaining
 i2c busses
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
 phone-devel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-12-7318a19806eb@erebion.eu>
 <DMXH52GLPXUT.236KX5W7LSRY7@fairphone.com>
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
In-Reply-To: <DMXH52GLPXUT.236KX5W7LSRY7@fairphone.com>

--------------sDXDqMcp6Uq300MvD41ZVktY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEvMTcvMjYgMTM6MTEsIEx1Y2EgV2Vpc3Mgd3JvdGU6DQo+IElmIHlvdSByZXNlbmQs
IGFkZCBhIG5ld2xpbmUgYmVmb3JlICdzdGF0dXMnLCBhbHNvIHdpdGggaTJjMTANCj4gDQo+
IFJldmlld2VkLWJ5OiBMdWNhIFdlaXNzIDxsdWNhLndlaXNzQGZhaXJwaG9uZS5jb20+DQpU
aGFua3MsIHdpbGwgYWxzbyBkbyB0aGF0IHdpdGggaTJjOC4NCg0KLS0gDQplcmViaW9uDQoN
ClhNUFA6IGVyZWJpb25AZXJlYmlvbi5ldQ0KDQpBY2NlcHRlZCBsYW5ndWFnZXM6IEdlcm1h
biwgRW5nbGlzaCwgU3dlZGlzaCwgTm9yd2VnaWFuLCBEYW5pc2gNCg0K

--------------sDXDqMcp6Uq300MvD41ZVktY--

--------------IZh0FgOC0Mzl8kpWZefDdfl9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQScjKa1EcO/2KYx++uOr0AybgKufQUCavyZ/QUDAAAAAAAKCRCOr0AybgKufZVv
AP44LNpwUJ4lzteMf21W5HgTm9u1oF/uAYdWgeHUv075HAD/WfEs1NmlCuXud45L6MnvzXwZ8RdY
ASC3DDAvI4RpzQU=
=hO4x
-----END PGP SIGNATURE-----

--------------IZh0FgOC0Mzl8kpWZefDdfl9--
