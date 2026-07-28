Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FF1C54F52
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 20:21:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B7F810E3E1;
	Tue, 28 Jul 2026 20:20:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ES0R1ycL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9797C10E3E1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 20:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785270058; x=1816806058;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Nht3znZ0sFyaEkoVdT3zaFnbYkzej5ieUK4ykpOXWfk=;
 b=ES0R1ycLSSklrB7lwrJMf/4LA4XZb+nRac32viafhdqmyw14NK0Y3aMb
 BFjIZpvghDhcjBlat4erKAc09SiJdTJYlTkAal3Ari0PIhEKSTHnVjgEw
 hCL0Xsu4dPEe/rKbvYqM70XcIM0HUpIdNyeQjFSmi6MOIVwbjNVUruNPZ
 QdRKLNu4176OVsuVx3wQODc2UWuwGovWJgY9ggsnv2P5Vxoc4/K1lDsIC
 qsR6P7fPcFTl4WczDSNxCnmayFOJnX4vhHofovx5w5ro2D9GD0w6DZZ6S
 sYu3RGa7x90bXkb9mIIqF8AUCOTC7cDVIiqYwo6fc39nREMP/iAuDptFb g==;
X-CSE-ConnectionGUID: UX3zu5d9R9yQO+FesYyh/Q==
X-CSE-MsgGUID: TM2t0RkZTZibUh7btL/VPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85881007"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; d="scan'208";a="85881007"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 13:20:58 -0700
X-CSE-ConnectionGUID: GOPk3COvTe6d2xIzJe4+CQ==
X-CSE-MsgGUID: XoQ9xE9MTvif960qobY3uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; d="scan'208";a="257130814"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 13:20:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 13:20:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 28 Jul 2026 13:20:57 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.40) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 13:20:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfrE9Ct+HD6RWUhYxRAgN9CfqWv49OjqpO/ICnBjgoYnK4VYhKLrxTWEBcWeWxpYKrXHRVLLVtYC2M4EG10uECqIwHn4rkr+7UBdALJRKGAf/wJwQ+VAfsQwqHc7AbNVywXMvtuPWzO6eI0/USGXHHBVL4kQpT5nOlAtMvW8oMP4stmwc2zqIDiZdjTvkwtgJkRAjoXDwt392rWUG7pSXETbDrdO29KizgbgeAd/7qgD3VXCD+MwlrH7emYveBfa0QMmcm412iT+tX/xt9MrvdSxDQazAePXR41xY8+jSOXXCUwCaUDHn9AJW8dvfcodGs8e/Xne6I6nKjLtiV91ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsxMcYQhv/MSr7jYWNPwjo/Ew3AR6dBP24LL4vsm42I=;
 b=aV99sJwvOU3ut8QkhGB6CF08JNYUuvuX6f732aULU1VObTm7l3ZW8/NkkgyxK48dtXcsS35iMHp6d2VVv4wWODDMt72w3BiwOE+uqnIsq7f/pDbelpaAEenKNDOITF78/DLwBAOUkx5T3UwbvH/juaXw0Yj3/Y+/+MPkRa3J5UPzaO4afFcncxvCONiqJGFTuNJS3ySFgerk2MLviI8Kg9Xv520TZsvxcjIc8sCHw/FGrzBi8WHTFSlZy1XudmGcYrZXWkT5y+etAU0MgdVKpQao3/4q871afaIH2PmwOu5XDmxcz57sLX37PAklDk4uYMwxoLyG9RWEL+F/Nmu4Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by PH7PR11MB7480.namprd11.prod.outlook.com (2603:10b6:510:268::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 20:20:55 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%6]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 20:20:55 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Robert Mader <robert.mader@collabora.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: Gerd Hoffmann <kraxel@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] dma-buf/udmabuf: Disable the size limit by default
Thread-Topic: [PATCH v2] dma-buf/udmabuf: Disable the size limit by default
Thread-Index: AQHdGcmgIlKoMcnWgUS+mY72ClF+rLZ826QA
Date: Tue, 28 Jul 2026 20:20:55 +0000
Message-ID: <IA0PR11MB71859E0D17C2959DCBA7CF3AF8CB2@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260722110145.36641-1-robert.mader@collabora.com>
In-Reply-To: <20260722110145.36641-1-robert.mader@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|PH7PR11MB7480:EE_
x-ms-office365-filtering-correlation-id: e312ed58-410f-4952-a887-08deece5ba4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|38070700021|10067099003|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info: 4n6zWXBgp6tla0puckvwumR/eEHOTMsnrrzYRy/lFD2Yx9yLILlt+zgI2R37OMLCK6c52ONxzxldi9wvj1tvCF40nNOSPc57FM99ECu2jrDZ8fz1cfCX3Ypf9oxDI7hmyQcBHF9ol3aOp9u/VNAjjISuhP2cMaTe/1JzKA4d9KtrbDtfvRx4NW7Q1Fr0KyEn57msCPUv6mHbPCz2CR4KRut5xW/WD1DFfqRC05qLn8BNNlR386AUP1IqzM5h7DpyIvgkmuDUjM/tDj+N4kDcZC+bCskN/r0vRB/3OZy+aptFAjqnjOeM5SLonICnSgPWVFEf2iRiS48l+FC1uexEy55I3gelP6fkXkoMhFZ0C3UK8+p1JlhjHOd5J16WfGMNsTK8uUOOKXsC6Sz9T9nYvMW+gvmeEUdK5aA2A090VLqWi1N5HwiQofgRPmXfH9yrCiFo2TvWzIQE5fvseK/eo7HF6IHTA64YMr2phHN99GPgbZQ1+Cjhqf+DAafIjN2IUWXfahxb4JW/p7jsvxrWr/B89kZZG92tXBlVHGeJa5JUkiiKovM3ZPlJBCGqq8h2yPTYjar0X94xLkHdj6Q9zuDKoVhVnOssHnREJkbWcRBxahQ87k6PaYXndfSw/cyVJaCnHqTCgMeqDeErZhTXVVlwpIUXYJl81pKgBaUofrLT+kI3S+BQvP51SYtcYJBs8x5eCPTueR7dc9AOjSxk8+8Xtb17iegA/IeSpFzfoUY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(38070700021)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VzvMYGUe2RN4qesckW99NJY2xVfdEEYEPXv4OyG61OUShfCJI8El+yTT3N?=
 =?iso-8859-1?Q?JIhW9eEjo2BGrqJpROjvZK/PrRYbC8p9wWfPmucWVesuvglSx6YsEHF9nR?=
 =?iso-8859-1?Q?nvZitGoxDbUM1HsavhVWuVJmGk99UvT1nWaMEeEfK2lV1+bu04zm00LrLD?=
 =?iso-8859-1?Q?Dc27Kh09YuvAaOaoDQlPVi9IB/dojBN06a0DhuLRy2+pq0oqqGwGMX9pNf?=
 =?iso-8859-1?Q?S+Dw8pw4wJXRKPZuWwOWyEy3rlpi7iCHe1QmoTgLkc4zHbk6xtet1Pcp2q?=
 =?iso-8859-1?Q?KrGC50K+PYGo5OUHyAtQ7vtfd7XzFp0LRTbSu7lg0WJwG8AgSoJ6MwlqYd?=
 =?iso-8859-1?Q?P6W9zNMN4Z4QXsu4WeFSgng/j7U/cx9cZHg+TlvoP5uTXfHI/TEAL9v+z4?=
 =?iso-8859-1?Q?dOhAOW0eEnDismI8ESTnuDxZ828DxI/kLt+xsW+u3Ia3chPtsJopFMM0jO?=
 =?iso-8859-1?Q?eq5v81rpesIXRVbmB4pzO1+Z1djeab+BIkmNgEf5b1OMiujqy6s3xOesxY?=
 =?iso-8859-1?Q?n1eWhJPCDHdOsU791BE7UrNoEC2pnAGSxcTcZd58imJb1KaAiElNcUSnaS?=
 =?iso-8859-1?Q?9mmD88fVF8t7xDkM1eUFGspJt/ekjVPqLIv9il0Bwxxp+xGlHwY2HaL7/P?=
 =?iso-8859-1?Q?jUV6DA9NK7i7ZWlXeeL7cI7bwaW5F2TZnt/dbM8zKPoOlE6D0RDqvzhfck?=
 =?iso-8859-1?Q?+FCxLJ6KRip8ulfVbskhh6kVIbLUS+hj4Yam2UBowhzCrYF9t6MloF+Clv?=
 =?iso-8859-1?Q?D2YH1yF6hQuLBGX5BgactrFT3z+s7ke00g2mZ4CjKVBt02gWMckaqORwCd?=
 =?iso-8859-1?Q?nYCpfPg4sugT0OG52mx6pUxJfTPDZ7uAQHk9nbsRMVTuRH0EoJCC8U3Ahh?=
 =?iso-8859-1?Q?Njr7ZzUVdcVaCWBuPGf4Mh4AgbkwN5O3OImdkPw6p4AuWC6g4eKDWfGud6?=
 =?iso-8859-1?Q?p7YU6j3gUp/YmkUrVvlBMAZNrL56fzkAgRo0glB+u0b2744ldSpzoAEmI3?=
 =?iso-8859-1?Q?4xiCSsoNG7m+fdGy0J8mPON4cnLTQmQPpH8Dkh2NH2KMtdD4Q8f2ONDhi+?=
 =?iso-8859-1?Q?seRP/VoWJkb71w7vHwTs91r15bRhGEgqHo+pfLn9k9zeYKQECjnpxAzPmc?=
 =?iso-8859-1?Q?H8ovu2JHx7FWgAFxnBs6Uq8W3/2TtzzEBt2Jfh8PIKniigpYTxRcExMums?=
 =?iso-8859-1?Q?lprWgt2sUpzAaOCx49wjFt1OsuZ8M1oAU9hrE6eCtXInzMPn5SxzRSxz28?=
 =?iso-8859-1?Q?rYREck0Fi9Ga9z53cxkKVC6sJQPOoMpR0IaEy8vyovQ1BmKuhDQyE1uuDr?=
 =?iso-8859-1?Q?gIFADXXaXrb4d6jhJHGSiBbxrmBHzmBl9CQzQcA517UlJJesxljL/mgYcU?=
 =?iso-8859-1?Q?BlFKgpX2miKpqfY5To3FLmGXIapHm2Lc8TnWFpz2lb4M3ETir4v2Ur788p?=
 =?iso-8859-1?Q?3nyFeSa6lNK9x3+cn3f6q8NoeemzI6py88Vj6PeNRGqHEtvV2S/79s4ND9?=
 =?iso-8859-1?Q?HNmB6rnEB7RLqlA25EZByxZNGt8FfDkFjqf3pxETpYc4xyJUNJgxkeSPdN?=
 =?iso-8859-1?Q?LWvCrXmfnmDDASAXp2F3tWKOQRrF6dRUu5tInTvcw2nTh+zSGv/7yybwuI?=
 =?iso-8859-1?Q?3/3YD1wtFlILwq1M8unr16H/GV664HLUgV+oB/NA8CtJSSTayTirERZUkF?=
 =?iso-8859-1?Q?0eCmtO80dPcyc7bY11v1rAjYFSd96pe8cb+lUNpK2C2fnG+xfZ0SB3ei+s?=
 =?iso-8859-1?Q?jmYrSSB1Db0sX0L5RQAJdVgIJvxl6+Jd2bRRxZGc7FAHC3TgZ3sLFKiBqG?=
 =?iso-8859-1?Q?+GrrtFhVcQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aRAFrCLIoucwOEasEKi/pBZiQXHinCIn3581KBndPSf9janqTi2Fl+0HVvDc1xLBtoeFnbq4rgQZPBuDUtQSGYRCIXKghzu+tDpGXVhwSi1LdW8Xx7YEig7wfb+B8MyzKJhZ7NfC04y2zDpgZkVSYbFNA7piWSveOjYtq61q3Y8gyfc8QkiieVmsNh/ifWZG+zva27FhJ5FKzbYVJTnm1hdrwIzleZsPO3+Nzy6blNIUhuhsa9Mvn0clsLawVJkbDKAPoubHNiDXGOtE5OJl90ks3GJ9DFXhaD2ZezU1WvItw/Z6RiG5BH78BB2HSjH2bQ3VjwfXczvtZNixYyjksg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e312ed58-410f-4952-a887-08deece5ba4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 20:20:55.0351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q/qj4qcWSsxYVGwy6hlEK4HDrHhCceiQ0dEfJ5bhAU3oQuO6yKp6xv2Yl3l7x5ppP2RVwtwJH7Li7c/ln/hTHYVLSzn7rB+1HdJNW9J+GQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7480
X-OriginatorOrg: intel.com
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

Hi Robert,

> Subject: [PATCH v2] dma-buf/udmabuf: Disable the size limit by default
>=20
> As udmabuf increasingly enjoys popularity - being used in projects like
> libcamera, Gstreamer, Mesa, KWin and Weston - users more frequently
> encounter cases where the current default size limit of 64MB is too low.
> Examples include allocating video buffers at a 8K resolution - and even
> 4K
> is affected when using non-subsampled video formats and high bit
> depths.
>=20
> In its current form the size limit for individual buffers does not seem t=
o
> provide any additional level of protection - such as limiting the amount
> of
> memory a process can pin - as the later can just allocate multiple
> buffers.
> If additional guardrails are desired, they would likely require some kind
> accounting not limited to individual buffers.
>=20
> Therefor let's disable the size limit by default by setting it to the
> maximal possible value, INT_MAX.
>=20
> Signed-off-by: Robert Mader <robert.mader@collabora.com>
>=20
> ---
>=20
> Changes in V2:
>  - Use INT_MAX instead of 0 in order to not change behavior otherwise.
>=20
> See
> https://lore.kernel.org/dri-devel/20260711144814.8205-1-
> robert.mader@collabora.com/
> for a previous attempt to make the value configurable via kconfig - and
> in particular
> https://lore.kernel.org/dri-devel/6764ca6f-b4d8-4baa-9d27-
> 2ca867ac2d41@amd.com/
> for the suggestion and discussion to remove the default limit.
> ---
>  drivers/dma-buf/udmabuf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index bced421c0d65..639e93704924 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -20,9 +20,9 @@ static int list_limit =3D 1024;
>  module_param(list_limit, int, 0644);
>  MODULE_PARM_DESC(list_limit, "udmabuf_create_list->count limit.
> Default is 1024.");
>=20
> -static int size_limit_mb =3D 64;
> +static int size_limit_mb =3D INT_MAX;
>  module_param(size_limit_mb, int, 0644);
> -MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in
> megabytes. Default is 64.");
> +MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in
> megabytes. Default is INT_MAX.");

Acked-by: Vivek Kasireddy <vivek.kasireddy@intel.com>

If there are no further concerns/questions from anyone, I'll push it to
drm-misc-next soon.

Thanks,
Vivek
>=20
>  struct udmabuf {
>  	pgoff_t pagecount;
> --
> 2.55.0

