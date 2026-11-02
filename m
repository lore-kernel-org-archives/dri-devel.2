Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772D7606A338
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=MZLxGlp+;
	dkim=pass (2048-bit key, unprotected) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=wJuk6bGH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EBBA10F42B;
	Tue,  3 Nov 2026 08:21:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="MZLxGlp+";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="wJuk6bGH";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC9E110E616
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 11:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1793617704; bh=/FwdiqEL1E7wjC1lZM45czY
 /I0C6kbRTSzkP+wrpdaE=; b=MZLxGlp+0k8QGWJZV98wRrFbJ/FIeUraYjfzx7Ff0eOyBbGXBg
 iTRgyg47oag+6auUhq4ShK0YOoWX+kA+lWBw==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=From:To:Subject:Date:Message-ID; t=1793617704; bh=/FwdiqEL1E7wjC1lZM45czY
 /I0C6kbRTSzkP+wrpdaE=; b=wJuk6bGHwGQ4tFSynG6Rk37tLq1jtfsoRRzv6Q0WLh+708IUnY
 iuak8c3LHpchH1uu9dpx4jbXx3UXcHd5GR4TUNXBxjeQbRumulwSAONP4hI4L8XyzYxjgJqL0mR
 7dx6HOcrik+pTn/6vEg4ngpytgTCwAczH0RLQdC4WuaPE3/3SNEaGpeU72xCo5NpbZf9J7eYOub
 o5A0hbWyfhKrq791HNWCgMJXhvYLoKN422rwCVG6GEVqLK8EHydI7dH+8O/G4zUwXW2vwC6DICS
 N3DZco59Q1jnCkvOg3dd5AhiilMWwitl0ERq5HlFYx/gpw393o7tdzmu6ICAceMpV8g==;
Message-ID: <13fe5cc6-d48e-42f3-a6d8-83401c2a4b2d@erebion.eu>
Date: Mon, 2 Nov 2026 12:08:24 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] arm64: dts: qcom: sm6350-lena: Enable PMK8350
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
References: <20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu>
 <20261102-pdx213-upstream-3-v3-8-cdc3be96d257@erebion.eu>
 <sashiko-outbox-192765@kernel.org>
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
In-Reply-To: <sashiko-outbox-192765@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Y0N0KbcBzWjDoz1M0GdtktLG"
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
--------------Y0N0KbcBzWjDoz1M0GdtktLG
Content-Type: multipart/mixed; boundary="------------Hh5BSwsB1xOqcFqoW06n2vWD";
 protected-headers="v1"; hp="clear"
Message-ID: <13fe5cc6-d48e-42f3-a6d8-83401c2a4b2d@erebion.eu>
Date: Mon, 2 Nov 2026 12:08:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] arm64: dts: qcom: sm6350-lena: Enable PMK8350
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
References: <20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu>
 <20261102-pdx213-upstream-3-v3-8-cdc3be96d257@erebion.eu>
 <sashiko-outbox-192765@kernel.org>
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
In-Reply-To: <sashiko-outbox-192765@kernel.org>

--------------Hh5BSwsB1xOqcFqoW06n2vWD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEvMi8yNiAwMDo0Miwgc2FzaGlrby1ib3RAa2VybmVsLm9yZyB3cm90ZToNCj4gVGhh
bmsgeW91IGZvciB5b3VyIGNvbnRyaWJ1dGlvbiEgU2FzaGlrbyBBSSByZXZpZXcgZm91bmQg
MSBwb3RlbnRpYWwgaXNzdWUocykgdG8gY29uc2lkZXI6DQo+IC0gW01lZGl1bV0gYXJtNjQ6
IGR0czogcWNvbTogc202MzUwLWxlbmE6IGR1cGxpY2F0ZSBxY29tLXBvbiBkZXZpY2UgZnJv
bSBwbWs4MzUwLmR0c2kNCg0Kd2lsbCBkaXNhYmxlIGluIHY0DQoNCi0tIA0KZXJlYmlvbg0K
DQpYTVBQOiBlcmViaW9uQGVyZWJpb24uZXUNCg0KTXkgbGFuZ3VhZ2VzOiBHZXJtYW4sIEVu
Z2xpc2gsIFN3ZWRpc2gsIE5vcndlZ2lhbiwgRGFuaXNoDQpZZXMsIEknbSBhIGxhbmd1YWdl
IG5lcmQuIEZlZWwgZnJlZSB0byB3cml0ZSB0byBtZSBpbiBhbnkgb2YgdGhlIA0KYWZvcmVt
ZW50aW9uZWQgbGFuZ3VhZ2VzLg0KDQo=

--------------Hh5BSwsB1xOqcFqoW06n2vWD--

--------------Y0N0KbcBzWjDoz1M0GdtktLG
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQScjKa1EcO/2KYx++uOr0AybgKufQUCauhvKAUDAAAAAAAKCRCOr0AybgKufb69
AQDKIN2UZJwU4v9BFS956kEjtIiuH8DP13rgxV7+nP+knwD+N+AiSHF3ZCfJxCio2fNieF+bGnEm
77iFbJSIptTvpgA=
=8/iB
-----END PGP SIGNATURE-----

--------------Y0N0KbcBzWjDoz1M0GdtktLG--
