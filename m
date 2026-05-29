Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A254CD4F54
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 14:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1271C10FF9C;
	Fri, 29 May 2026 14:04:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XwZr7sym";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D342010FF9C
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 14:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780063484; x=1811599484;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=i4PPXxe8ZRLwAtdTJ13XqLofs3V4jmZnGOFFPUrwDX8=;
 b=XwZr7symg6iDp6cjH9i1PaO/wm8v+koozQihxuf37CCL5Z0V9/hWRpbZ
 xXrp0TnehpIRKr69OuRZd10cs7ogOI7R6ri3BE8SWMMIf26Jgwe1madEg
 iRDZkgFXvbiPMFLzE1WGz2ESPu/ekZl8AtuaJGFJeLVqItSYzuobMQMF/
 /zlymaAcs9D757YiUvvr45SRjtNUXSkN5v0Zh0TpZqqVtXd+w9HpbjBbH
 /6j+qkA6Cl7Qi+oFLaonbyRecmK9dOIhuXNMRK2dRza4SRuKWWVOQOV2W
 WZD1irqKOyQqQlTbuCIGRRaS5uy4TKB1e28bycrAPmluzXgP1sIvdTzui g==;
X-CSE-ConnectionGUID: TV3jI19MSk6eBt0aJn4S4A==
X-CSE-MsgGUID: AijvqS52Tji1zKOkVNWVAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="84541216"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="84541216"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 07:03:25 -0700
X-CSE-ConnectionGUID: uACxFOAfTC6CO1QF8Xb8ow==
X-CSE-MsgGUID: utmWJ/MKTsOyT4R9O1v1AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="238670384"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 07:03:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 07:03:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 29 May 2026 07:03:23 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.45) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 07:03:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BneFN2WkLH88o0dEymsIqz+OcdCEa+ir1bi96eZbV31DKYz6GWj74UyinUHPCz8Y5Sg1RKsgi5R0BN5VoITMm2to3A8xk2cxKxAN+owiX/Ff0UoW1h3lRS8UEZSbzfKw+mqtaCXWeHuw2Ur6KyweqUbB/QJgNxSIOA/4lMcTzesFUosajzsR+t6g9Q3w9F+J8eMZppdw7oGIlOVb8a4pIEjScq7rOtRz7dzNS3bm22P52hSBk+hZ/p3BMcuXCfrjvAHi0GD6Gd3r/9em/cJBg+FTFwlxw8daIl8vbOm9xpuclWbzEMO+vxMPGkHNOZKmwh0wXKTufpQ06LamarbzZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Y4qOrkBo9kF9ZQHWqSfyA9JABTtGMO0clXzHDz2BUY=;
 b=uneBAsbqywnof5nUYhgBdT0kHW2pou7PVXAyenYa1q0frh1q/tiD9J/i8xeG5wLNShPARbmDgKxFkmObovYHCXPi9B3uSNbll0lSuS5r4yjYfxXyzcd/u/eiAfohV4KYI8y80UX+HV706NaR+ZfqHC43WATBVDsU39dV1umVro6Ms+kGrzxbHMykV2WZSuSH6PPTHAa9y2i8Lb8DoFwbIAkVP9caL6rKH3Io4Tl3lweRRYGFMS7SefEGWlvFQ2t73105u7r2kYhidmWlLGFVHQr6VqJsgldqsGwdl/Ay/hfNVFxg4O00TZBPL6smNZxakITJ+gkKAQNyTekGljk7Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN6PR11MB2717.namprd11.prod.outlook.com (2603:10b6:805:60::32)
 by DS7PR11MB6064.namprd11.prod.outlook.com (2603:10b6:8:77::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Fri, 29 May
 2026 14:03:16 +0000
Received: from SN6PR11MB2717.namprd11.prod.outlook.com
 ([fe80::5d50:a82:a1d8:7b90]) by SN6PR11MB2717.namprd11.prod.outlook.com
 ([fe80::5d50:a82:a1d8:7b90%5]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 14:03:16 +0000
From: "Cavitt, Jonathan" <jonathan.cavitt@intel.com>
To: "Sousa, Gustavo" <gustavo.sousa@intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: "Gupta, Saurabhg" <saurabhg.gupta@intel.com>, "Zuo, Alex"
 <alex.zuo@intel.com>
Subject: RE: [PATCH] drm/xe/rtp: Check hwe before calling match_func
Thread-Topic: [PATCH] drm/xe/rtp: Check hwe before calling match_func
Thread-Index: AQHc7unBx7GE5VCcb0+gRyIKKBAiobYkBTQAgAEEkyA=
Date: Fri, 29 May 2026 14:03:15 +0000
Message-ID: <SN6PR11MB2717B102CEDA7B2203A66DFEE5162@SN6PR11MB2717.namprd11.prod.outlook.com>
References: <20260528213412.3709399-1-jonathan.cavitt@intel.com>
 <87mrxj5frt.fsf@intel.com>
In-Reply-To: <87mrxj5frt.fsf@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB2717:EE_|DS7PR11MB6064:EE_
x-ms-office365-filtering-correlation-id: 3475d5bd-caf8-4478-55ab-08debd8b07e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|22082099003|18002099003|38070700021|6133799003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: 1YdVqItqK/4T3GNKvOnEL40na+2qkZkp4py99SPIk3EUKMyoYiPoVU4R/BcfBfQxUh+uhFl/SkkhOoYDq6B0hqJZemJHr4kJLOKqqZorTg6q/HnXKPRWYdExndQ6UudXNJ7uRGhEx4wiMmoydQ1AHCkazwVVwPMMYie5l5a2lIdJIQ+/1oBBTBXwNdH/w8xKpqDUcX4ckdZmF7uTStPY+yZbM/0tM/qj3LfQNwpPm1zSKKnyGJugCrCotRPIdWZYzdzaK5T2B99ios2kswlGiR60OZFwG0hWcPOute3Hj/tOndMlJTbrgywRSLPftq+yGdLHm2VeYGLRLoT1iI4lKtNOtK+QbYR2oyq2pkwgfP+JluXlFRQaZq04PwlEFM2XF+UMKjY4WZjUzXjt4UsCAb7yU4jnQOQTh8SSJYCJHbzRY907JVyM8oYgJUkHzXH49JXJtNsQN3UFW6qne4dQL16015cfOMvhDTGEytuVX1pqPX2MKO4T/AWU6JBDG8+M50pYHKxXbgt+sa5RTKl8jr8WRyUjUbXBuLouMOemtBlMCBoCf9UreswJlFM3FFZAwzMSJE//bt5fgwbUyFxsqpp8YIYpZ2JjPoIAn6fBJIpnq0Q9G6Lfk97LBdqZQMRYQgWtbnV7hRlusm1MDyG62DfLdgf3CK2xSV4l9KKMZosmtRoR+XhxTJNT/otqLTNt8HEfLaik2q4PrjMhZdk1vGitoVKn9OImqobQAtM7JJzdFoPmy8X7qURDSF+vkKjx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR11MB2717.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(22082099003)(18002099003)(38070700021)(6133799003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ux3g5bof9Su6AOe08yf5edP/S+a5RsqBwsYvwYpMz6ciwfkpbYfDWPo/aPJP?=
 =?us-ascii?Q?W0JJ8nucIqILF5IS4XivgFilQnLDNYoicASHPGp9+1KZSxrBoRpDLHc79xKz?=
 =?us-ascii?Q?8hurcfQnUfmJF5s3hnsPgn3PoQEnwr/GESLl7XX/z/BAHSR6a7tHSQ03lhhw?=
 =?us-ascii?Q?eCMsQpRHKfBzzh2fSS1L+uStzCqmxpvA5mURK/ePqwW9sLvKEZTM2TbEj3I9?=
 =?us-ascii?Q?lnRzdr1nO6chdIRwtBQYGk+QJypnSjFFJ13BYSrfSE6wFiDTIBbV0u3DzusH?=
 =?us-ascii?Q?IoBxa2WTuZkQMpMUznaDGC4QZpo1Ew/H3dJ5bUvSKpQ/DUz43bKiCUWJUAR/?=
 =?us-ascii?Q?HghIU1yNZHS7/tba5Cok6Ish6/YeKR7i/mZaNsHA6DmmdYzcQLfUW0dF0QOP?=
 =?us-ascii?Q?WWMyM4TtNR/7Q0PQGOmlWiWUedtLDzeS57sK32bsvW+ArHKyi0DpkcV7zb04?=
 =?us-ascii?Q?vkf1Ou2DInyzFTPwMJOpeaHw5DqtE4ZAA0LZ00byD6803E1HKhDHu3E20LFC?=
 =?us-ascii?Q?TnK6mLhdvvPRAyNyFb+jnqeQ5jjfDB3rMelgMKSc7/0YHKdVyRV7oWlSzjg+?=
 =?us-ascii?Q?nc1lGPs+kWGVaMpCtAuO4Qnrmhln97atkT2mudJpOhqadcRTAWc9fJDuAUu/?=
 =?us-ascii?Q?WNOrqmQyikL4b07RzSCP6YmO+MBYP5vhr+lqKYAv7eLB56BmgKCxWnkQYdhE?=
 =?us-ascii?Q?J8vX357MIJEs/yCTmDTxdnsstKWFKNYAjxErihuSg14GoRYaPQNQainbe5Bq?=
 =?us-ascii?Q?uwGN986vh8OqvM8aOvJc9rP923pJHWE3oSf25Mh82hbJf06oUirzrLp/4RGr?=
 =?us-ascii?Q?1Ean0IxcFP6zGBAVCcSYEi//4RTXMD02TORYjWhKflkc9kRlHb2U5JPR1J1C?=
 =?us-ascii?Q?5t995edFrStn8vxnOUgAwXfiq0z8hSShsvem0rGP5pP0HtpINe19zKZAZSn+?=
 =?us-ascii?Q?aB8da65Xyco9zZAxezxzObcu+BZNA6QxRjp8EWKcajtpwxZMnS2NKGPz6n8r?=
 =?us-ascii?Q?LaNT5f80/8pICamCeCL62fJpjmVqdJDQZAJOM0SCxbr6H8WTD/c1XBXsoBjl?=
 =?us-ascii?Q?psiAuORX0QhPZlreg1UwlHYpTPnbwLiBksD+D2S9wrnWlU4c2dzmD5+YqGzT?=
 =?us-ascii?Q?LGlyLEgg4KCvD4yNj9j22ZV40PGri0Ug1cr7nMV2S1E20xY78eAGiWBQHQtV?=
 =?us-ascii?Q?UV3M39jYWBE299XnDTJW9zXG8qL4Xs7YLJY0/PmfyCf8/exulk0CBZrfywOe?=
 =?us-ascii?Q?DQKyoxmE/4i+DtIbAUHUzN7TlISx4HbkibL5tWTdeGc/KBpCD7KJRqzBlu1V?=
 =?us-ascii?Q?DOR2GmFQeu2MrWZxmKp5jzdpMGu7ahcpHGZj5LfGeymEfQj8Rz27nihLVS/9?=
 =?us-ascii?Q?zmSL3byOLZDbOGmayT42IvqkF9BuJ2Krb2ybb/KgK883h3Z9ca2x+i52vKPK?=
 =?us-ascii?Q?3SObRLDrelu/qJ+JdefL2j/S83jEBgDMFPsfUryJxcCQoQlI4EX4fmXZIm9X?=
 =?us-ascii?Q?cwmHIyh/8sh0YbfS5pMpm4TRXzrE2pwkqzX6ODNubBOYOV4w6WbEl6/e4KBg?=
 =?us-ascii?Q?MYJIYcAVWYgJXAuBBcaFqfpZdxlEN4uY6F5A2mUpsDLT0GC8jUrKXICd2QiA?=
 =?us-ascii?Q?0pm8RKei9Y4o6BI/iA+B0YBA/XATgefyAfmXOaV6obcYsHHhStA8RZ4rrYgm?=
 =?us-ascii?Q?vZ1rdcfPKahP24PdddIuMG5XSV+EhbxQs16WJvZHFPCuT/Px+WpGt6VMBR4V?=
 =?us-ascii?Q?DIZ5wfftHtZ7KZ+x6/i1aD8gIoXGbKS+ote0dzUotqEjksOVjanJkJZnYK7/?=
x-ms-exchange-antispam-messagedata-1: mXUlx342Zrjzag==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: T+TmEKMrQgP7ZwSDqQJMUcjK50KIKwARv208LJ3PbYVwQp2JbOu0k2LJZMblzZCpfOrYCzpwUevnF5fpaoIMjGOlzPFkolcub4xNYqBLdgnwl0XBiXCafZVJkqvRIQt+RSffVM7kfHuXAdBCpQC3IdBWxzfU18MZ682Fzf+SN4UsgQP6VIadsnLnnG+pB4gwIY0tcMKil6rmc7GjSHwxnAXoQARMj1hSERAj8nYl0FDQ++tE0YhuW/L4rvbi16iHohwisqoFMKe6Jt8NMhthG5iVJZzIho8lpfzyNWs4/xWI/9fDdfU/zFpE93xVrQ/tJ/Arm3LzyNIbDP4jYeJ3tw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2717.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3475d5bd-caf8-4478-55ab-08debd8b07e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 14:03:16.3825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alkYLWa677liSGvG1eXO97JlaVl2OGJCEOSzRTfY8IuFpRZVlgxrvMk3Q4gXhGdfD+4DaVb6ZdoCMHNQr7CmQkSQKt/KKnDWaISNpSvfVnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6064
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

-----Original Message-----
From: Sousa, Gustavo <gustavo.sousa@intel.com>=20
Sent: Thursday, May 28, 2026 3:30 PM
To: Cavitt, Jonathan <jonathan.cavitt@intel.com>; dri-devel@lists.freedeskt=
op.org
Cc: Gupta, Saurabhg <saurabhg.gupta@intel.com>; Zuo, Alex <alex.zuo@intel.c=
om>; Cavitt, Jonathan <jonathan.cavitt@intel.com>
Subject: Re: [PATCH] drm/xe/rtp: Check hwe before calling match_func
>=20
> Jonathan Cavitt <jonathan.cavitt@intel.com> writes:
>=20
> > XE_RTP_MATCH_FUNC may attempt to dereference the target xe_hw_engine.
> > Ensure the hwe is not NULL before calling the function, matching
> > XE_RTP_MATCH_ENGINE_CLASS, for example.
> >
> > This covers a static analysis issue.
> >
> > Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> > Cc: Gustavo Sousa <gustavo.sousa@intel.com>
> > ---
> >  drivers/gpu/drm/xe/xe_rtp.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/xe/xe_rtp.c b/drivers/gpu/drm/xe/xe_rtp.c
> > index dec9d94e6fb0..2cd26db113d9 100644
> > --- a/drivers/gpu/drm/xe/xe_rtp.c
> > +++ b/drivers/gpu/drm/xe/xe_rtp.c
> > @@ -129,6 +129,9 @@ static bool rule_match_item(struct rule_match_ctx *=
match_ctx)
> > =20
> >  		return hwe->class !=3D r->engine_class;
> >  	case XE_RTP_MATCH_FUNC:
> > +		if (drm_WARN_ON(&xe->drm, !hwe))
> > +			return false;
>=20
> There are several functions passed via XE_RTP_MATCH_FUNC() (i.e. MATCH()
> in definitions of RTP rules) that are meant to be used to do checks that
> do not depend on hwe.  Returning false here is wrong as it will cause
> those checks to be skipped.
>=20
> The developer is responsible for not passing a function that uses hwe in
> a context where it is NULL.

Understood, though quick question: is this also the case for GT?
-Jonathan Cavitt

>=20
> --
> Gustavo Sousa
>=20
> > +
> >  		return r->match_func(xe, gt, hwe);
> >  	default:
> >  		drm_warn(&xe->drm, "Invalid RTP match %u\n",
> > --=20
> > 2.53.0
>=20
