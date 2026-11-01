Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA959606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=DfD/WTzN;
	dkim=pass (2048-bit key, unprotected) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=Le0r227+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0C0A10EBBB;
	Mon,  2 Nov 2026 08:04:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="DfD/WTzN";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="Le0r227+";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1771710E3B6
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Subject:From:Date:Message-ID; t=1793575205; bh=6dm8J8E0M1ZNWs3l5j1o3es
 8syrK4YCFjARRn59ISEY=; b=DfD/WTzN9iChMjght3h2uUM7Xn+ZNCcpbAl4DtvkaqUFQKKULL
 s2eg2US6+yhhqRSOvR7puOJMTUJRlvvIx3CQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Subject:From:Date:Message-ID; t=1793575205; bh=6dm8J8E0M1ZNWs3l5j1o3es
 8syrK4YCFjARRn59ISEY=; b=Le0r227+TFsr16xUNP63aQZ0MUX0uzYbLzyeAi7Qwqi6ZIbe9f
 qwVLzlM+BGpHPgdV7ETxHmNmhyeD7bCDh64jO2IDrZ3CE+WdhwjdPXwskg9CQoIy1fWcC3tCj73
 1bYbMtrPHqXsO++z+LMEJdGIumm/1eLGwhI9E+BqA4kfXFTfbTNgnQ6z5t/g9M/pVNTT7rsCHPQ
 fP6fkR3CCwbKCHewdb8erOZqdpmNcYOvlvMJZNIbxquVlCjmKC01JYIwr2n8tcWqXHe+jbeouIn
 xav7PwVExAWGdNv/2bj8Hm2RORYVI6rGj77LXRcah/pk/W9ESlfjzk8LvpiF0wAIg8A==;
Message-ID: <2f96ca42-4ab2-4e3e-b15f-f1210362db7b@erebion.eu>
Date: Mon, 2 Nov 2026 00:20:04 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: erebion <erebion@erebion.eu>
Subject: Re: [PATCH v2 5/8] arm64: dts: qcom: sm6350-lena: Enable Bluetooth
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
 <20260926-pdx213-upstream-3-v2-5-b4612e3eb536@erebion.eu>
 <ddd2d324-4202-48bf-8984-45edae0c3278@oss.qualcomm.com>
Content-Language: en-GB
Autocrypt: addr=erebion@erebion.eu; keydata=
 xjMEY7S2FRYJKwYBBAHaRw8BAQdAUf0YlT6sBQSunZeO44bgAPe+ndqTifGaNjw7vzJ2KPHN
 HGVyZWJpb24gPGVyZWJpb25AZXJlYmlvbi5ldT7CjwQTFggANxYhBJyMprURw7/YpjH7646v
 QDJuAq59BQJpWnovBQkHhhzbAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQjq9AMm4Crn057AEA
 j3didUIhbtAoppk2eNu6CbtMvkDisHWHVLaWF8YC1VsA/1P0ngBoVghELMachirfTinwBplJ
 qP7GGlSGRqSfnlAKzjgEY7S2FRIKKwYBBAGXVQEFAQEHQN6NPWcyqKdecGU1vN8FVXBwYEUd
 OAhF5jpmd7M0Ybx8AwEIB8J+BBgWCAAmFiEEnIymtRHDv9imMfvrjq9AMm4Crn0FAmlaei8F
 CQeGHNsCGwwACgkQjq9AMm4Crn075QEAoDqfm4OeAEQWMgfQ496u2S3rWJw1EMgTOP51FQbX
 rY4BAKn6AhEBh605uas3OTVtcwNIAJn1sHTA7HqqWniUe9sP
In-Reply-To: <ddd2d324-4202-48bf-8984-45edae0c3278@oss.qualcomm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------m0Dl7hDtU9gzfRDxN9YR05gR"
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
--------------m0Dl7hDtU9gzfRDxN9YR05gR
Content-Type: multipart/mixed; boundary="------------8MmVZGt7YViH7ZG6jZ7S09Wz";
 protected-headers="v1"; hp="clear"
Message-ID: <2f96ca42-4ab2-4e3e-b15f-f1210362db7b@erebion.eu>
Date: Mon, 2 Nov 2026 00:20:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: erebion <erebion@erebion.eu>
Subject: Re: [PATCH v2 5/8] arm64: dts: qcom: sm6350-lena: Enable Bluetooth
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
 <20260926-pdx213-upstream-3-v2-5-b4612e3eb536@erebion.eu>
 <ddd2d324-4202-48bf-8984-45edae0c3278@oss.qualcomm.com>
Content-Language: en-GB
Autocrypt: addr=erebion@erebion.eu; keydata=
 xjMEY7S2FRYJKwYBBAHaRw8BAQdAUf0YlT6sBQSunZeO44bgAPe+ndqTifGaNjw7vzJ2KPHN
 HGVyZWJpb24gPGVyZWJpb25AZXJlYmlvbi5ldT7CjwQTFggANxYhBJyMprURw7/YpjH7646v
 QDJuAq59BQJpWnovBQkHhhzbAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQjq9AMm4Crn057AEA
 j3didUIhbtAoppk2eNu6CbtMvkDisHWHVLaWF8YC1VsA/1P0ngBoVghELMachirfTinwBplJ
 qP7GGlSGRqSfnlAKzjgEY7S2FRIKKwYBBAGXVQEFAQEHQN6NPWcyqKdecGU1vN8FVXBwYEUd
 OAhF5jpmd7M0Ybx8AwEIB8J+BBgWCAAmFiEEnIymtRHDv9imMfvrjq9AMm4Crn0FAmlaei8F
 CQeGHNsCGwwACgkQjq9AMm4Crn075QEAoDqfm4OeAEQWMgfQ496u2S3rWJw1EMgTOP51FQbX
 rY4BAKn6AhEBh605uas3OTVtcwNIAJn1sHTA7HqqWniUe9sP
In-Reply-To: <ddd2d324-4202-48bf-8984-45edae0c3278@oss.qualcomm.com>

--------------8MmVZGt7YViH7ZG6jZ7S09Wz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCk9uIDEwLzE1LzI2IDEzOjA2LCBLb25yYWQgRHliY2lvIHdyb3RlOg0KID4gSSBk
b24ndCBsaWtlIGhvdyB0aGVzZSBjb21tZW50cyBhcmUgc3ByZWFkaW5nIGFjcm9zcyB0aGUg
dHJlZSBhcw0KID4gZXZlcnlvbmUgY29weS1wYXN0ZXMgdGhlbS4NCg0KSXQgc2VlbXMgb3Ro
ZXIgRFRzIGFyZSBqdXN0IHVzZWZ1bCBhcyB3b3JraW5nIGV4YW1wbGVzLiA6RA0KDQo+IE9u
IG5ld2VyIHBsYXRmb3Jtcywgd2Ugc2V0dGxlZCBvbg0KPiBzZXR0aW5nIGJpYXMtZGlzYWJs
ZSBldmVyeXdoZXJlIGFuZCB0aGVyZSBkb24ndCBzZWVtIHRvIGJlIGFueQ0KPiBpc3N1ZXMu
IEFyZSB0aGVzZSBlZGl0cyBiZW5lZmljaWFsIGluIGFueSB3YXk/DQoNCnRoZSBmb2xsb3dp
bmcgZXJyb3JzIGluIHRoZSBsb2cgZGlzYXBwZWFyIHdpdGggaXQgaW5jbHVkZWQ6DQoNCiAg
Qmx1ZXRvb3RoOiBIQ0kgVUFSVCBkcml2ZXIgdmVyIDIuMw0KICBCbHVldG9vdGg6IEhDSSBV
QVJUIHByb3RvY29sIEg0IHJlZ2lzdGVyZWQNCiAgQmx1ZXRvb3RoOiBIQ0kgVUFSVCBwcm90
b2NvbCBRQ0EgcmVnaXN0ZXJlZA0KICBCbHVldG9vdGg6IGhjaTA6IHNldHRpbmcgdXAgd2Nu
Mzk5eA0KLUJsdWV0b290aDogaGNpMDogRnJhbWUgcmVhc3NlbWJseSBmYWlsZWQgKC04NCkN
CiAgQmx1ZXRvb3RoOiBoY2kwOiBRQ0EgUHJvZHVjdCBJRCAgIDoweDAwMDAwMDBhDQogIEJs
dWV0b290aDogaGNpMDogUUNBIFNPQyBWZXJzaW9uICA6MHg0MDAxMDMyMA0KICBCbHVldG9v
dGg6IGhjaTA6IFFDQSBST00gVmVyc2lvbiAgOjB4MDAwMDAzMDINCiAgQmx1ZXRvb3RoOiBo
Y2kwOiBRQ0EgRG93bmxvYWRpbmcgcWNhL2NybnYzMnUuYmluDQogIEJsdWV0b290aDogaGNp
MDogUUNBIHNldHVwIG9uIFVBUlQgaXMgY29tcGxldGVkDQogIEJsdWV0b290aDogTUdNVCB2
ZXIgMS4yMw0KICBCbHVldG9vdGg6IGhjaTA6IHNldHRpbmcgdXAgd2NuMzk5eA0KLUJsdWV0
b290aDogaGNpMDogRnJhbWUgcmVhc3NlbWJseSBmYWlsZWQgKC04NCkNCiAgQmx1ZXRvb3Ro
OiBoY2kwOiBRQ0EgUHJvZHVjdCBJRCAgIDoweDAwMDAwMDBhDQogIEJsdWV0b290aDogaGNp
MDogUUNBIFNPQyBWZXJzaW9uICA6MHg0MDAxMDMyMA0KICBCbHVldG9vdGg6IGhjaTA6IFFD
QSBST00gVmVyc2lvbiAgOjB4MDAwMDAzMDINCiAgQmx1ZXRvb3RoOiBoY2kwOiBRQ0EgUGF0
Y2ggVmVyc2lvbjoweDAwMDAwZGU5DQogIEJsdWV0b290aDogaGNpMDogUUNBIGNvbnRyb2xs
ZXIgdmVyc2lvbiAweDAzMjAwMzAyDQogIEJsdWV0b290aDogaGNpMDogUUNBIERvd25sb2Fk
aW5nIHFjYS9jcmJ0ZnczMi50bHYNCiAgQmx1ZXRvb3RoOiBoY2kwOiBRQ0EgRG93bmxvYWRp
bmcgcWNhL2NybnYzMnUuYmluDQogIEJsdWV0b290aDogaGNpMDogUUNBIHNldHVwIG9uIFVB
UlQgaXMgY29tcGxldGVkDQoNClRob3NlIGFwcGVhciBpZiBJIHJlbW92ZSAmcXVwX3VhcnQx
X2N0cyAvICZxdXBfdWFydDFfcnRzIC8gJnF1cF91YXJ0MV9yeCANCi8gJnF1cF91YXJ0MV90
eCBmcm9tIHRoaXMgcGF0Y2guDQoNCkJ1dCBhcyB0aG9zZSBlcnJvcnMgZG8gbm90IG9jY3Vy
IHdpdGggdGhpcyBwYXRjaCBhcy1pcywgSSdtIGxlYXZpbmcgdGhlIA0KcGF0Y2ggYXMtaXMg
Zm9yIG5vdyBpbiBteSBuZXh0IHZlcnNpb24gb2YgdGhlIHBhdGNoIHNlcmllcy4NCg0KPiBG
V0lXIEkgdGhpbmsgdGhpcyBjbGFpbSBvZiBsb3dlciBwb3dlciBoZXJlIGlzIGp1c3QgcHJl
dmVudGluZw0KPiBsZWFrYWdlIGN1cnJlbnQgZnJvbSBhIGZsb2F0aW5nIHBpbi4uDQo+IA0K
PiBLb25yYWQNCg0KLS0gDQplcmViaW9uDQoNClhNUFA6IGVyZWJpb25AZXJlYmlvbi5ldQ0K
DQpNeSBsYW5ndWFnZXM6IEdlcm1hbiwgRW5nbGlzaCwgU3dlZGlzaCwgTm9yd2VnaWFuLCBE
YW5pc2gNClllcywgSSdtIGEgbGFuZ3VhZ2UgbmVyZC4gRmVlbCBmcmVlIHRvIHdyaXRlIHRv
IG1lIGluIGFueSBvZiB0aGUgDQphZm9yZW1lbnRpb25lZCBsYW5ndWFnZXMuDQoNCg0K

--------------8MmVZGt7YViH7ZG6jZ7S09Wz--

--------------m0Dl7hDtU9gzfRDxN9YR05gR
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQScjKa1EcO/2KYx++uOr0AybgKufQUCaufJJAUDAAAAAAAKCRCOr0AybgKufTfZ
AQCnD0TurP80LdTaqD/H+gj6C7X5ObJGq7r8ttskAQQktwEA9B3Mj1zYeuSP1MDVEsxPddx3xfGV
UTOSbv4posv10QU=
=9fIv
-----END PGP SIGNATURE-----

--------------m0Dl7hDtU9gzfRDxN9YR05gR--
