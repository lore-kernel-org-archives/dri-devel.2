Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04117C4451C
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:03:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57C5910E763;
	Wed, 22 Jul 2026 06:03:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BG166eUW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D64410E763
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784700199; x=1816236199;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1sSK6sObOJl8hnwHzct753BcAu4XwTe/okjsyeGmUKA=;
 b=BG166eUWtlf4rrOjsIXB47N+QnWScYg7EuZISvzm34E+7Uzt5Q6ep3Tx
 UAY56Ir/G5BCZqeFangwrQJM3fQD7xsVyeeqxmD5sR1mkyvfbP4kjxUju
 bSj/eHg4uQFFo0F8IMhYb5sd9k/r7XHddqjwHeoeDYMmXnHgRr0wOGYvV
 HE7arE7Yk6+gOjWM9jg4Jf+n39y6ZYGT6JIkJb3Ly6BfrIjrM98eheVp+
 3ahAx14J2mv6Mfvp+ZL4GeTmWvSHqUtp04RW3pvhX7scTata0Xdk+Laxy
 inkqIoT7Z6X5VK7Mo8Ggfm6tOX/wIGKjl2YzFDPab02rv5HxYXZCrRz0u A==;
X-CSE-ConnectionGUID: 33nu1KwUSre95v7vx+31ag==
X-CSE-MsgGUID: 4jGlPrgzSr2CD3tBbHz2iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="89214396"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="89214396"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 23:03:18 -0700
X-CSE-ConnectionGUID: Qt83nZQ3StKhi1h7+rx2Sg==
X-CSE-MsgGUID: gFqJA/KFR7iFnGIOPGRrxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="259951284"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 23:03:16 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 23:03:16 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 23:03:16 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.14) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 23:03:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Az2lkU8sE9C6JS3kacq9+jcN2oOXkad2g5ELa4XjeTFOm78V5bBvhQsjR5zRevdpMpAvwHP+BzB9Mf70wLhE81kFiv7szRBTUhG52l+sRBVb9TXBDQmNwv0tq43caNevB6w5JGW75v0XW5f7k1Mk1mFNs7OmnhA/6/ITUrtTc5WE5d//WFTD+rGK3BqxNXFvQWA/EZUyMoTuShwG+SyLFCPLkYYHWMdRchQSH5BKqGyMB1gQKsPClWYMr/kBHCLI56KGr3ZdcE3W/5vCbJ6hZ6yWHqIySy5CBdlLZesZlh6FoAj280P6ljQaZGoKnjdRFX4c+eyXbKkm9NP4aeiV5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3rvBqx9mqn9tJWM5stqTdMfpEqrvVA9sH3PvNMKAFs=;
 b=yel6TtkmxFoCrW+XEvgRcCJ4yQK9YHUNO+uiGYaxQaKrLA5KycVxIUYaaJe8THVNqDaYZEm1+j7YKT25Cz76EhrOawfktXK2y4jHOvtYtdjX+16bf17ibINAKtBwWVWOUacogRs8BWdwzvGkdNeCaJvTc512x8EFxTBeaco21MjLcnQswP42mWA/5bQyJm5mYL2oJtWT6IYm6zP+k8IeY0kDSsrB15sOpRmeaN9PMFxcl+aX8d0sPypUGKRg/yM2k6YnF5dIo32ZDHmGrnRjMsQO4eg6KkAnRkXebY1IyeJ/0HnYd9FrW5enqdqMDbodPRBOfs2pXQ4i3F0DV16Rpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by CH3PR11MB8658.namprd11.prod.outlook.com (2603:10b6:610:1c5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 06:03:08 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%6]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 06:03:08 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Robert Mader <robert.mader@collabora.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: Gerd Hoffmann <kraxel@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] dma-buf/udmabuf: Disable the size limit by default
Thread-Topic: [PATCH v1] dma-buf/udmabuf: Disable the size limit by default
Thread-Index: AQHdFewBXw9/TyC9jEKP1zNSIWNdAbZ5ExQQ
Date: Wed, 22 Jul 2026 06:03:08 +0000
Message-ID: <IA0PR11MB718505780A8DBCAC7C9EC0E2F8C12@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260717125750.62639-1-robert.mader@collabora.com>
In-Reply-To: <20260717125750.62639-1-robert.mader@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|CH3PR11MB8658:EE_
x-ms-office365-filtering-correlation-id: a2ddf7c5-aea0-4154-3da4-08dee7b6e724
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|11063799006|56012099006|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: PAx72jnjEZYJg3+pRHvUqyHr/4QYqxFnjuohIwbT9cDhC+TG5sSoKeo5nR+KMu8GgByud4YeU6yDoi27SW3P4dTxGCcADjX0MDXRRRIAJlDx8Y/QkYTexQ+VyzQ/JyRJ+qU7Dwe2yQ2Vf4iuF4/zopjeTaOt1aH+LvAXRttlGIxWSp7ApO0FdHw2Zw0xAo7yL2RNhX0mz89mnw90RHPbzk4naef+PlD5uq0s5QT0c0nLIEaeyHBsUq/bU9gaUowuIet3MIWf2jR1S7UfE6nqRFGx0RntCS4m9FPaSj3kodGYbcIbjre0/98JLLyTqIp8FRUcLOASXOoxAnlQYP1j/bl1T6CwLyROBAAHQU4UVtQjad7dlmtthrR+oY0m7C+kz2lsH5D4nikTFweUWJsF47PwDm1AQ+aTAXz8RTOTv+Y8eITOcjrKYfkz+vwPnqU2/LjjkYvHeI+S1q/CQ5TPT8P0wgHyunqkslTEJz8NFVqkVQutHmiPH/JacIwGlRtMo5ZP4zr9C2Xny/7+cH7vOvquh5UcuIDeOWouEzfauyGDwvviCGj1OPVi/jazqbXvDnICd5UE/AN/oLXGP/qNCRVXnO+MasIA5z7V0aPF98SpokhmOHC70hBdfojW+HhVkN8T80sV3VyRjZuadthw3dYzv19AfnWnc0Ft5jHKLyeQx0mETihnnbl5LExEUrNixGy3DPDCaouYr3Bukg5/hFAxhx5LE2qjDXroBqK37CY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pFyan+otjnsfeC40/yRaNzjq0nyyfhe3wKOFOnK75OBD7gGNsNkOeZt3sV?=
 =?iso-8859-1?Q?EXVYrgjpRYcTolk8i4OpriOKm4wFNE/22GKrGmT/gXrJ3PaabwX2fjzhYe?=
 =?iso-8859-1?Q?j0wBXt4GpC+18pQJ1RUFQCcyYTiptRVuFpQhtrhW5yE2iJPqHB/sXyd0JS?=
 =?iso-8859-1?Q?IS1tZGhrRvmsm1KoUv4PEN0owHq4c2vlene+05INErZN6k8WKb3ES3gWvQ?=
 =?iso-8859-1?Q?hPJGN3WIVDkQ/B5YQZrWv8eyNTEvY0u7otxDP/aP9BpTM1Sc+ivRboi3ve?=
 =?iso-8859-1?Q?t/O4lYMn6vY7co2XrCvfcUjdX3uWs5NHkdA+i55761zTEDBy90xOoit7y+?=
 =?iso-8859-1?Q?y9UCFwGmymeJjMFScTtH9pgjezaMayebj0iG2vP5yZGLkqe9hXTN7yf+Ap?=
 =?iso-8859-1?Q?5BfAUArpWsiKViSHfoD2O9YMZPerP076pyyEAlb9PZdHdmZ87VDgEbAeSA?=
 =?iso-8859-1?Q?SMo7RjZiHS15UsX9Yny6hOBI6kU8rq3Oog/nmlniRIJffpGBltFTkn8uHv?=
 =?iso-8859-1?Q?itUncfOuIcJ4lyFKkmylM20UoEtopBiZBfthibRZoxiLgqxQUKQHIL/GBL?=
 =?iso-8859-1?Q?p8z78U87rq3j63JvKgBVYtPUxzhxvwEqSzj30oNHaX/bajdpVG2eg9cbZ2?=
 =?iso-8859-1?Q?282l9SiguxwOlMrdU2DrFTx7yVwRavDBkGSL7gKCXfi+UEvfeg3B2/XK6p?=
 =?iso-8859-1?Q?o3t5VH1brCjb1nCrzpUqsqN62q2dnS/igLPAVYxLGLYlrFvObpK/jbJJ+y?=
 =?iso-8859-1?Q?fRu1N7BQL5aoswTr/bVTBs0QLpJbyGPP37F1jttzcQcd2gkreGJ5v2dqws?=
 =?iso-8859-1?Q?GFJAQXyasV2vAnCzeQJ37BpZUi2iOMBAQzAAOmny+6806nWndlN9LJ+M89?=
 =?iso-8859-1?Q?w6roz9TBAakyOyoRbjQVhvXbal3XzN39ffsP7jHFHojeOeCi9YYSpH6txa?=
 =?iso-8859-1?Q?zi1rqKTnyGiHlFdLbWS1S6G7nlTBUGMI2t1KN09FQ+BHbgqnKUNRFoYuzN?=
 =?iso-8859-1?Q?jsraV4CgLFQQH2jdvw7cZwTahnSbe6PXYQOt7TG2DWpf5s0kc66wUZixnh?=
 =?iso-8859-1?Q?djy1A1jZcW7CKTyqL5vdpS32JtfeegMeO0Y6bktKz4jhaffdzv9kEgrqSh?=
 =?iso-8859-1?Q?4mjAOvZhDIAyoc11r/uBW4zdHOgEyat0wDeAi5uEQoX99wEVvuraEuq9PL?=
 =?iso-8859-1?Q?iLjZoG7t03Kpe1QQOqyWGgikhvfK4iBVXEACoAYdQDro8+0of83b3ZbCSx?=
 =?iso-8859-1?Q?mtIzRqqLbkXHK/6h+t9ojtPSOd6QnjUWxjwJiMf1E8wOrrkr64q3r7EFhB?=
 =?iso-8859-1?Q?HiESDdR/6mb2v/ywiesaJUS491eVreG3Dl/BZa5AhzT5QnupWNkO3P62yq?=
 =?iso-8859-1?Q?00yWbDStODbX9CRNIHrTXxPGfuP6VEssQKPXYBLjNWUfZ0FfCh1rZBOWET?=
 =?iso-8859-1?Q?3sDY5GMAqo2l06hZo9JXnbXH7mvTWK/KIPXxa9jQtSNSsVk84E/5/hXg7j?=
 =?iso-8859-1?Q?Bz97jDcf211O5hKIfyEDqoHLNNmZfK7l0M9QVgiZoi+hLkcp94KMLyZaB6?=
 =?iso-8859-1?Q?LBTKeyWp3KIowX2ZL2M7kcfBluZQIIWwR7lb+lPKRO7d1Oss6nu49gOUh9?=
 =?iso-8859-1?Q?OrUKm6iEh5OWPt9jez2UprJhYJRkKYYskQb0RW9gjGcmmlQrVwwoNU4Asu?=
 =?iso-8859-1?Q?rtmojeXPG0mpd7PoS4JA77AWcghSnBIX1y3vlLAygF93XXccR+vi9+9/G+?=
 =?iso-8859-1?Q?S0XdYIVu1WhWeut4S2YMIqfvjmmXMpidtDNYxP082uH8SR0YUEDSsGV/+r?=
 =?iso-8859-1?Q?UV1dplS0Yw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jsl2BdiXPIy0SX8h1aKEHbXueuxLCn0SpwjltfMP+6MKO9r1t3fRmcvuw0GpaeHeFsm50SU0Su7AQOwFaXZ6HVH10Hj11UZfNsNEg3PjXISawh/PlX5ODPMspdNS+0Huoq2k62OpcN6e2MuntZdnVj5UViHlUeYfhSi0mECFHbqUUuUbPoALQgKt2VhjJn/TdvJdpAY/GXn7g/X/UkQe9lwJeQef/TGQJDZELBPu+C31q7HtGpXnivwy5cX6rNXy2eTnHK+RaLzQcx0G+RTQXMZ9WcYFzZto2z3pULiNDjj19T2XLc0rwlFN3ascTgU0En+KwiHDI5YCw8bCOsuRfQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ddf7c5-aea0-4154-3da4-08dee7b6e724
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 06:03:08.1019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uY3q4nV6P1d+lY0GJG5yHATGhiO7sj9U34wdmiamL7PHTQJqjeM29pukk4iJLw2heWgoFTqNv/fx111lDs++V0CqGalTvqEq0gXV3/ngphc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8658
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

> Subject: [PATCH v1] dma-buf/udmabuf: Disable the size limit by default
>=20
> As udmabuf increasingly enjoys popularity - being used in projects like
> libcamera, Gstreamer, Mesa, KWin and Weston - users more frequently
> encounter cases where the current default size limit of 64MB is too low.
> Examples include allocating video buffers at a 8K resolution - and even 4=
K
> is affected when using non-subsampled video formats and high bit depths.
>=20
> In its current form the size limit for individual buffers does not seem t=
o
> provide any additional level of protection - such as limiting the amount =
of
> memory a process can pin - as the later can just allocate multiple buffer=
s.
> If additional guardrails are desired, they would likely require some kind
> accounting not limited to individual buffers.
>=20
> Therefor let's disable the size limit by default. Use the special value
> of zero to do so, which prevously could be used to effectively disable th=
e
> interface. Using other means, such as file permissions, appears to be a
> much better fit for that purpose.
>=20
> Signed-off-by: Robert Mader <robert.mader@collabora.com>
>=20
> ---
>=20
> Please let me know if changing the meaning of the parameter value of zero
> is considered a breaking change / not acceptable. In that case INT_MAX
> might be a better option.
Yeah, I think using INT_MAX might be better.

Thanks,
Vivek

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
>  drivers/dma-buf/udmabuf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index bced421c0d65..3509b690d8e2 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -20,9 +20,9 @@ static int list_limit =3D 1024;
>  module_param(list_limit, int, 0644);
>  MODULE_PARM_DESC(list_limit, "udmabuf_create_list->count limit.
> Default is 1024.");
>=20
> -static int size_limit_mb =3D 64;
> +static int size_limit_mb =3D 0;
>  module_param(size_limit_mb, int, 0644);
> -MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in
> megabytes. Default is 64.");
> +MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in
> megabytes. Setting 0 disables the limit. Default is 0.");
>=20
>  struct udmabuf {
>  	pgoff_t pagecount;
> @@ -373,7 +373,7 @@ static long udmabuf_create(struct miscdevice
> *device,
>=20
>  		subpgcnt =3D list[i].size >> PAGE_SHIFT;
>  		pgcnt +=3D subpgcnt;
> -		if (pgcnt > pglimit)
> +		if (pglimit && pglimit < pgcnt)
>  			goto err_noinit;
>=20
>  		max_nr_folios =3D max_t(unsigned long, subpgcnt,
> max_nr_folios);
> --
> 2.55.0

