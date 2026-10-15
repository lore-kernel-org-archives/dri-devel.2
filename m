Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63419CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:10:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6392510EBBE;
	Thu, 15 Oct 2026 13:10:03 +0000 (UTC)
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D589610EBBA;
 Thu, 15 Oct 2026 13:09:58 +0000 (UTC)
Received: from [IPV6:2400:2410:b120:f200:9e5c:8eff:fec0:ee40] (unknown
 [IPv6:2400:2410:b120:f200:9e5c:8eff:fec0:ee40])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by psionic.psi5.com (Postfix) with ESMTPSA id A23D73F072;
 Thu, 15 Oct 2026 15:09:45 +0200 (CEST)
Message-ID: <55218956-0520-4c26-b238-11747ba5ea9e@hogyros.de>
Date: Thu, 15 Oct 2026 22:09:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/hwmon: refresh Battlemage thermal telemetry under
 force-wake
To: Rodrigo Vivi <rodrigo.vivi@intel.com>, karthik.poosa@intel.com,
 Zongyao Bai <zongyao.bai@intel.com>, anshuman.gupta@intel.com
Cc: Constantinos Chalkias <cch@e-psn.eu>,
 =?UTF-8?Q?Bata_Roland_Kriszti=C3=A1n?= <batarolandkrisztian@gmail.com>,
 intel-xe@lists.freedesktop.org, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261012104245.2108030-1-cch@e-psn.eu>
 <as_iOd6A_Yncj8Gt@intel.com>
 <55cba965-208a-44cd-a644-e664410af8a5@hogyros.de>
 <atDLRDvuDES7u00Q@intel.com>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <atDLRDvuDES7u00Q@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------AJGqKuh09DWkZ2cOqjycczmr"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------AJGqKuh09DWkZ2cOqjycczmr
Content-Type: multipart/mixed; boundary="------------UxeokOPhNA9QHJ4YWd1LtkFA";
 protected-headers="v1"
From: Simon Richter <Simon.Richter@hogyros.de>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>, karthik.poosa@intel.com,
 Zongyao Bai <zongyao.bai@intel.com>, anshuman.gupta@intel.com
Cc: Constantinos Chalkias <cch@e-psn.eu>,
 =?UTF-8?Q?Bata_Roland_Kriszti=C3=A1n?= <batarolandkrisztian@gmail.com>,
 intel-xe@lists.freedesktop.org, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <55218956-0520-4c26-b238-11747ba5ea9e@hogyros.de>
Subject: Re: [PATCH] drm/xe/hwmon: refresh Battlemage thermal telemetry under
 force-wake
References: <20261012104245.2108030-1-cch@e-psn.eu>
 <as_iOd6A_Yncj8Gt@intel.com>
 <55cba965-208a-44cd-a644-e664410af8a5@hogyros.de>
 <atDLRDvuDES7u00Q@intel.com>
In-Reply-To: <atDLRDvuDES7u00Q@intel.com>

--------------UxeokOPhNA9QHJ4YWd1LtkFA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCk9uIDEwLzE1LzI2IDIxOjQ3LCBSb2RyaWdvIFZpdmkgd3JvdGU6DQoNCj4gRG8g
d2UgaGF2ZSBhIGdpdGxhYiBpc3N1ZSBmaWxlZCBvbiB0aGlzIGFscmVhZHk/IEl0IHNob3Vs
ZCBiZSBnb29kIHRvDQo+IGNvbnNvbGlkYXRlIGFsbCB0aGUgdmlldyB0aGVyZS4gRnVydGhl
cm1vcmUsIHBlcmhhcHMgd2UgY2FuIGdldCBzb21lIGludGVybmFsDQo+IGhlbHAgZnJvbSBG
VyB0ZWFtcyB0byBhc3Npc3QgaW4gaGVyZS4NCg0KWWVzLCBodHRwczovL2dpdGxhYi5mcmVl
ZGVza3RvcC5vcmcvZHJtL3hlL2tlcm5lbC8tL3dvcmtfaXRlbXMvNDU2MA0KDQogICAgU2lt
b24NCg==

--------------UxeokOPhNA9QHJ4YWd1LtkFA--

--------------AJGqKuh09DWkZ2cOqjycczmr
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEtjuqOJSXmNjSiX3Tfr04e7CZCBEFAmrQ0JMACgkQfr04e7CZ
CBEXGAf/XBBpS2sO4gmzGdVzb9m3KGs03e1hFEjwiaCzxlwexmFFYf9NTLtRp13h
NGwKrgxR0XWf+g6GGJ+yejsu8IPTwBBsngLvlfjUiL/Si/d7evAhpfqoSC+Xifx8
R3wuaefXw6WE/vPRbIL/yDd6zzM8WYIn8Sbf6rbNMqssZopt8T6RqBjk2vkIKXcc
gwmnDv5nBmBBdxJh0IiK2Igj5TmRFX/HLUl5yhG6lAPsHsgwqrKinJqhUBhlwR0+
v5ecThavBk5mSGZCN7SdXsjuBy7NJsihdoOaqnsZa2oP2jodeCnHtkupTaPGNgf1
XrEOLTtF/Fn7U+TvJtkGP+vQSLs3WA==
=sWty
-----END PGP SIGNATURE-----

--------------AJGqKuh09DWkZ2cOqjycczmr--
