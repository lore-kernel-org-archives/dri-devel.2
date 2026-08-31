Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFBEC624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECC6D10E82C;
	Mon, 31 Aug 2026 13:24:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZlzIWYgg";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B465210E824;
 Mon, 31 Aug 2026 13:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788182652; x=1819718652;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=nWkJdNEj/ujrQAzLZAn02belUUvT+CUPl5d113Y1Jdw=;
 b=ZlzIWYggRUp4nQ9zTHpCr6Hgnqkucg+ThLftQ+oQ5WYR40Vih9WrjZ6D
 sA6THuIAD1E7Uy+1nNJff1htyYtcIS+B3QJOBWowP5DI6DobcWjnQaELc
 0LAPSxLQsEMZLA2qWUMuknkmlQLcAuKL35yl1lx5N076fe4UX+pwX+gzh
 OlqRmCnXZrl4QESz6fID/aeHFgcV5UrP+wQ5nhFBRMwU2zIwM3a4zZliK
 rwF5WJ0Ml5AkQmT1dHaFY6ccdxFtgp0Z2RsLIJnLBEIePoXX4JYSg+8rZ
 lrr2AEw0kKbpuCmktj8ZjbBF5rbZ/RPc/0P5004W5N2kK5K1BFH9cb+pZ Q==;
X-CSE-ConnectionGUID: hJo4/GOqTIGrtcsrtoopcQ==
X-CSE-MsgGUID: mdy78GEcTM6mqaYuiLHIhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="87535596"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="87535596"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 06:24:12 -0700
X-CSE-ConnectionGUID: JxPNbFluSoe9VAfxO7QXIg==
X-CSE-MsgGUID: Pvo5zRnmR5ugg3h+YW0erw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="274062899"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 06:24:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 06:24:11 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 06:24:11 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 06:24:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfDr0B3Baf7hndbl2cIDwF3+nUZ/X69YwBi+8WNclRAgIB5JSpiVLBrzxm0cbeOBCvsovdfR2bBswb+MEbNvch4pFQ8RPScoqQXkJtzLVEhk/Il3N05e2+1dj8Vd2pm9vl5cbReIAlpd5m9PcuGMoagEU0AI54wb2lgHe4ji6s5tssXhL0OF9oNhgC+IuG4ah1aNGfO9rEWXECRafB3BN3X3dNi9NrsZYwmfvfN4oNeG794u4BOo9KM2TN6U73OKziSQTReVeFtdgCxJKqVuLHDit62ZmDSnDs8xgWu7YGyBp0B/z6X9pBzGix8EQe/mDWt8DK6hxDpN+2CTzKuE0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OP0D/bmM0aBlx4T0ou5Hc+mt/OFr6t9OVeTEsMLoR6U=;
 b=UeZ9UJMFwwJbRc1bER9fUCadfBhxX3sdD4dMYFFOqIrOvS4CGGz5gODeOIdByS93nRGbmiXXSFWO940NST2h1qdpnlCeV5jHdK/Ql/DQft5ktTR/vJGXkJl+XYBRnQ+KHTaUzZKDjxz4oImD2b4Lv7rVL5P7kDNcEzGxpuZfVhnoW6YMYKBDbGbasjVRtDOWfbfQXqVWZqVTVQor0p6QD2/SclxlEtp6/PvuO8h9UaI7XfeL/1K4QOwZHTUYA6fK3LOs9drpZAeFV2432n/sPLZPJxHTqmJekRWrKidilJ27sxFnAB/h7bMkG2tp+y59EGNcYAUyRAFiH8WgKAhyCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6360.namprd11.prod.outlook.com (2603:10b6:8:bd::12) by
 SA1PR11MB8575.namprd11.prod.outlook.com (2603:10b6:806:3a9::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Mon, 31 Aug 2026 13:24:07 +0000
Received: from DM4PR11MB6360.namprd11.prod.outlook.com
 ([fe80::22d9:ae03:5db1:680]) by DM4PR11MB6360.namprd11.prod.outlook.com
 ([fe80::22d9:ae03:5db1:680%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:24:07 +0000
From: "Shankar, Uma" <uma.shankar@intel.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [v6 6/9] drm/i915/color: Add support for 1D LUT in SDR planes
Thread-Topic: [v6 6/9] drm/i915/color: Add support for 1D LUT in SDR planes
Thread-Index: AQHdJBCGi8jwRvuO10Sjj/hqyyXOq7a4T2pw
Date: Mon, 31 Aug 2026 13:24:07 +0000
Message-ID: <DM4PR11MB63608596E790F45C24DD18C9F4A92@DM4PR11MB6360.namprd11.prod.outlook.com>
References: <20260804123107.2256124-1-chaitanya.kumar.borah@intel.com>
 <20260804123107.2256124-7-chaitanya.kumar.borah@intel.com>
In-Reply-To: <20260804123107.2256124-7-chaitanya.kumar.borah@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6360:EE_|SA1PR11MB8575:EE_
x-ms-office365-filtering-correlation-id: 56c610ba-2190-4533-7c7d-08df07632297
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|38070700021|6133799003|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: 0DtipjS4U6ex8zxRFeVVh18IfIWKw4oWCnKC7keRoK9LLtzgMwM6ixLXSH0z3NVYF11Xfo9NgKFdOTfAoWwkfBVzQyC+xCf3kXxrXjFNL6OhzXCoPYI0LEl7fiRm0XavFRCHJoOAKJRHc1VEFpK2PbPM4le/PuOfOogWiaCwoGBKJvc8au8i2P7NyH2jER+h9yeg44gMYu/2kjKgpaOIE+rc2n6iQx6Q3YYPRPj44aLuQJ1JUcB9Zp0HCQsFFZ29U9xtV6AgcATf2c3WfCvjq+6WO5N1grxE1RVIBfG7SzgG8/OIcHtDvN/mN7Na2beZX4sllIn1dN07MaRDjymKZJMHHlr/EfqPgiGEiKROnsHoFoxwtX0Yj/1/JuqRdCcsas85kSmP4uOBEfRvKVdsmJp0yXKCz4Ap+DZ5s1YVUZjRnONDnimAaMWBaozMEmFO165ex7yh6FfItZoDneC9Y44tLObmZEziG/5v3QjLmnivimc9zIuon4CRLuPUfFxDMhyh53B8qlxeTvqXq0nogxv1CUEOkBcRzMLAKmnUDvYflrYX+3H3oUMZp8tLi5eDICew+bPkibciqgMC1rJCqBpHNgKTQtU3BQ6JD3lEiaoJ7E/9xJFMd5/pZoYoSO1BmsQSEAcKx8ko7kWs07FoK5pPz+U3yfkSrcOWZeCH0H6jCOTPPPdmSwrdsv+uCJBtI4eBX/dCik/BVXXiy9E4ZdG/no52VchmxavjHnQDP3Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6360.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SqsUTqEbHw1yRaR7SDAZQX7KjjbmUwBx9aF3MqH6nWen84dSf9GDlMqTCbp3?=
 =?us-ascii?Q?0FmLFFq7y6eb/2Ze9NFSc1zOC1izTz54JjyAGeMlvSG4hohEltfKRxgCqICK?=
 =?us-ascii?Q?1ad19N61GuyTkHvKe/qSckKDHiWRAQNk3oExTGw1ZGcecMBFkNO6L2Lsy4r+?=
 =?us-ascii?Q?dk7vCpe6vKGoAIhhVyMhT6ilj4whr7/NT+YeGfctAhNZnHje6h2t2V8Ldfab?=
 =?us-ascii?Q?ZeY0D4h3LKdL+gaP1jbQzuatS00Vcg87LqyPKHKHDjuMiSfsyMdvZpGCw8xb?=
 =?us-ascii?Q?s9fC/OoqhSDm8B3LOoHu5OeKthMlNvIu8sm6zgGmKAHqWQuEpozlXHex7D3H?=
 =?us-ascii?Q?tvgWqSyaE3pUaP8jQpfAvUcHb97/Z5m+tFehO2MVsoZfBui9iTDVwJotBdGi?=
 =?us-ascii?Q?GwobA09OwQSDntGw9IxNeRaCmDQkQTf4LUhTdsbq+gZGvZ3+12ihckC6CCvg?=
 =?us-ascii?Q?PArtqJUBcAlTBzrQnqnLJf5PouIMSqjW8gcjSNN8IhIZKwwi6zN6cNKP8iW/?=
 =?us-ascii?Q?oDrC7FThRT3VgSX/mNqYJUf0R8rUIrx9jtXJFGu2mkaRQGMx46kGElO7BHGE?=
 =?us-ascii?Q?e7Q+Kun088PJyk9Mr7AjBjsTc7kd3tl8tSI6pBMJBunpB8qlUM+Ed/liBGUD?=
 =?us-ascii?Q?7uRcQawY/SRaY/f5nA/yj3tfU4PcEHgH1mIXXXDpyBSlgr7dw7dI12Uo5f+d?=
 =?us-ascii?Q?b9BF11in0DZBXV/InNWrxlDbEvj/RGwE0XmRUdmNtOJUqQieynY8/uZcjyBw?=
 =?us-ascii?Q?pkmJ4vYMk27XfBVoHUVHDveYNNkMUVb8MC+TPlZco7+XAcwpl8xMlRZ+fb4c?=
 =?us-ascii?Q?1IcKsC9D1xucOiH/wnAb+byp4jExiABq7pHl6pdERJB8/heEtO/WXUK8l2gi?=
 =?us-ascii?Q?7uhbcbyY5MURvjX2ILLUkUHYnnrsailtCU1bvl3jCvBnBHZIQBze8PK5W9r/?=
 =?us-ascii?Q?R3FODrPttKUAcwRPRk6w65/y+Bva7cWeOQpgWYbaFgiHWp7l25NjUuOpRL0W?=
 =?us-ascii?Q?5G2cO+VfTF5xNYqsGIPaOmPcBgaj0alr2hi6iWbLlSiHWzxqi0liP7bLztXu?=
 =?us-ascii?Q?jPzY3Yf4FKVMKiK4yS5M6EszQi4I3H67xPhH4WVM5Lsrw3+xISACEDIQgp6e?=
 =?us-ascii?Q?+c3KjomdKw1V0CZa7nGvCrumkjP+d8aJ1Jnj/HSpjJnf7WDp2+HM76Ld14gA?=
 =?us-ascii?Q?hjs4QpXxcsW+fqScmhSXNnCyq4UBo8zVLNdKpQe9uK1lm3nWLeO3NFMrP28a?=
 =?us-ascii?Q?qTBTfrlSurG3Jks40Z/13pfFRhRHnkzG1LgMJ/1Vkq6ltxsUQTHdU6D2jj7q?=
 =?us-ascii?Q?goUULD9oSz4BDkIEqDKDk1jZUM9aQX5pV149aZOPA5FFj8CcEqPQfKvk/HT3?=
 =?us-ascii?Q?b+O6zXqztDtwkrg0pQklNfN91R93wCvFkAnlMbzBOgmHXJMG/T0+imh2rrRL?=
 =?us-ascii?Q?QBlZSiEBKWCycfcWjJtXaxLALalUuYec3N05ru1lnQMp1s6P1qKujAErAO0s?=
 =?us-ascii?Q?AisiMb3gcu0MfPC8+g5gnNkUUVFW+mzJlAtdH2FQZjNSwFmwhJfhxSXHtuzW?=
 =?us-ascii?Q?SaJwDOBieQaDjZXmJNPPbwW6a2vDCzWhKHnrgnS63VDPW12lFN2dCtxRPeDk?=
 =?us-ascii?Q?v2hoix3XVzgxUQPE3akz062pmiyf2qMS2Vswns/HFrL/GCk4zPD5LvOTbxeX?=
 =?us-ascii?Q?DQwhkojlAowz0Z5m3U9QFMtlxIr9VSz83s+a2Tm+zziMBn4Y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Fh3lOUabKVXrMV2j2cSMcQrTx3M5TTVp+ZJbXAMJ7sJn2VFgXqI0L82ZrkAdkRS9k/Qbw/HsnmaOPeZzASreIkSvVoTJtt9/EjAxRJ9q7ZPr1MiNAlBJaJe3aoQ4q7C9AOidwPUxRDwOu6CcW7nsZdqktGpZMpEiDJSWUuWGIwd2odVyJC26bOZ235xLoJit3Tj/lNAiw5K1h9WYehfhaj6WhydsripMl+YceQ9ZefK2ZXVvJ5XPwcMedOlORSnBk8prnDryrDGEt/ak7w1zxBkfkTmEpahNfFHHdAoRI9GteUBZW1w6TKXu3m7rFixKAZNAthm06NbN4OIwo0Kebg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6360.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c610ba-2190-4533-7c7d-08df07632297
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 13:24:07.3038 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jNd9Xb2oEimHMalVtEMsTmZqzijAZu1sBH1+rv83ryI3nRjsXcqBTEe1oCh07yY+S6G96rRtSF0XKHuuh7XDig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8575
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



> -----Original Message-----
> From: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
> Sent: Tuesday, August 4, 2026 6:01 PM
> To: intel-xe@lists.freedesktop.org; intel-gfx@lists.freedesktop.org; dri-
> devel@lists.freedesktop.org
> Cc: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>; Shankar, Um=
a
> <uma.shankar@intel.com>
> Subject: [v6 6/9] drm/i915/color: Add support for 1D LUT in SDR planes
>=20
> Extend the SDR plane color pipeline to post-CSC 1D LUT block.
>=20
> v2:
>  - In preparation of a simple pipeline
> 	[YUV Full/Limited -> RGB] -> [1D LUT]
>    Drop pre-CSC LUT from the pipeline as it has no use in a YUV -> RGB
>    pipeline. This makes the pipeline simple since the block lies between
>    the YUV range correct block and Fixed function CSC. It can be added ba=
ck
>    when [RGB709 -> RGB2020] capability is added. Then it can be used for
>    linearization.
>=20
> Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Reviewed-by: Uma Shankar <uma.shankar@intel.com> #v1
> ---
>  drivers/gpu/drm/i915/display/intel_color_pipeline.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
> b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
> index efd4375c4331..53e55ce0a5a3 100644
> --- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
> +++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
> @@ -45,6 +45,7 @@ static const enum intel_color_block hdr_plane_pipeline[=
] =3D {
>=20
>  static const enum intel_color_block sdr_plane_yuv_pipeline[] =3D {
>  	INTEL_PLANE_CB_CSC_FF,
> +	INTEL_PLANE_CB_POST_CSC_LUT,

With this we will expose support for post csc lut but corresponding handlin=
g in driver is added later in the
series. Would be good to move this after patch 8.

>  };
>=20
>  static const u64 intel_plane_supported_csc_ff =3D
> --
> 2.50.1

