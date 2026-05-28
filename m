Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC33CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 21:47:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAD5D10F64D;
	Thu, 28 May 2026 21:47:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hFq1jpyf";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB8FE10F651
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 21:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780004822; x=1811540822;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OAR14jjnlFwHcXEFZAqNIQhN69UhuNik8K53GYnlKNo=;
 b=hFq1jpyfCCPcdpOSzKV+SnOi7iPgM9GeU7Q1gQhgWD0qpr3tRwhvrzY+
 h1FsQxbpdnbYWDv4dxQEYHnQUvl65SyLbuXEaGaPkHXqr6L++dgYSXsfd
 BQwuFHoBL2Si0ai8fCi/FPVdXQ1H6kx9cO0eoehB9cNB9zCkzh2BI1CYE
 dRexXIq8YoRSv0l3dMoexkVgjTimgkCnEJc7K3072DaxOoxfonzeIspFi
 q4bWfx13y4RzEVuJiZnNl/UVlH0n0PdGGkITAaXQaWZAWIh89s01BTC1W
 Gz6PtpKysFS1qYoSKODFuAewurGRN0zLqajn24gBgFhwEwN1XgkLwKEbT A==;
X-CSE-ConnectionGUID: Pkjyt3uDS9CHeN+yicX+BQ==
X-CSE-MsgGUID: Afa2qTjlRDSXns9M59q5tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80883255"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; d="scan'208";a="80883255"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 14:46:48 -0700
X-CSE-ConnectionGUID: r92E8FcpQHiOpfdlDV53LQ==
X-CSE-MsgGUID: zHEGcjv8QLy6qhgdYPXtXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; d="scan'208";a="246678956"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 14:46:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 14:46:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 14:46:47 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 14:46:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aet6l04ZYF1xmmBMD4YkSm0pIbw4TsJdNx3AxBQJD0LdxfgjUdASW/ARzh3enUbsqo+Km6jpdNk/gENFztYf3ofmEBkMlmhm4h5V1CBGCsC6nP8tO7acejzvCwNzBwUK1o61gIdLQMLvmvzPFfah/5pI/mGv9ar0jN29E9Mv80qg/1ssyHc0GZa1m+DobD6ir5vTBleVefeS8qsM3esi7rOlt02Pyug+SXfNvjKQwNkUPUhq9f/sJxYnOOgZ4v7atbkJMcNh4IP592VNzMnxBXWFDgs07tTsBgsCExuClZDZx2z4HPaOOpkxy3feqXqGC/mZD5/WbmPevqeotEanUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qtm142x6O0VL7XQJkRvF4aXMkyy+U8rXyn8ZhBr5jWM=;
 b=jgN1RCOS61DXDzaWlcCW1Ge4QKbUFJi4QwOYQcaai0dthnS8Egb1GOUg/Vz4sZiLhKdgRnDk+5HbcGj5xjbIUDidD4Ql/9eW6gizscVHJE/46nSDCnYaCHpmY00PD3kCrQ6tjr2789ME/KrDWab8c2imR6ro0akikzmQXSh/s7V7wwNBF49G61mmZ5E6BJ3r+vDC/5oT+L/wl2wXSYL+QkzvQOmftydeJKICY71hl9FlvdRmPDxz2dgBLIo4RWgcedLgsuPymPhql5/cB/28cTvuwWa4TYMyAH76D5b7FMlkkXlkNmTLlqOznzLKl3dcgJLCzrruoOXeRMY4JuB9kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN6PR11MB2717.namprd11.prod.outlook.com (2603:10b6:805:60::32)
 by PH8PR11MB7021.namprd11.prod.outlook.com (2603:10b6:510:223::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 21:46:42 +0000
Received: from SN6PR11MB2717.namprd11.prod.outlook.com
 ([fe80::5d50:a82:a1d8:7b90]) by SN6PR11MB2717.namprd11.prod.outlook.com
 ([fe80::5d50:a82:a1d8:7b90%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 21:46:42 +0000
From: "Cavitt, Jonathan" <jonathan.cavitt@intel.com>
To: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Sousa, Gustavo" <gustavo.sousa@intel.com>
CC: "Gupta, Saurabhg" <saurabhg.gupta@intel.com>, "Zuo, Alex"
 <alex.zuo@intel.com>
Subject: RE: [PATCH] drm/xe/rtp: Check hwe before calling match_func
Thread-Topic: [PATCH] drm/xe/rtp: Check hwe before calling match_func
Thread-Index: AQHc7unBx7GE5VCcb0+gRyIKKBAiobYj+JkQ
Date: Thu, 28 May 2026 21:46:42 +0000
Message-ID: <SN6PR11MB2717759BA9F13612D404914AE5092@SN6PR11MB2717.namprd11.prod.outlook.com>
References: <20260528213412.3709399-1-jonathan.cavitt@intel.com>
In-Reply-To: <20260528213412.3709399-1-jonathan.cavitt@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB2717:EE_|PH8PR11MB7021:EE_
x-ms-office365-filtering-correlation-id: 8032822f-70d7-4aee-c90d-08debd029b35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: UawyZarVYMeMlpIPYCjH4tH8D71yelPSJBdjIqfzzhxQ9kqRc1H5cksRgsoa6vJgyphBlegdYn3SsMRioIjNhm7Oypq+A0O9TRcafkA5jsol7VXA50fNCL3abOJk1PLM0eUpECrH1dx9SKiJmPnrxgewIPPEXTCyqYPotEc3wrNp2BEtV4acxf+opSmxnS9CABzfEsWd3RPy9paIhsCcSXZ9yKxqNxdq3GbsRZ3X4lvxeSWO4i6NboNxcEHhvUK+GespJJwpRcas4Xa9mAejdc+x+GOjYvX2Hodu/Q2Y2XQEbY/uQvCQ3A9c5pNZzCMxbzRuAnu8Jl/Oyz4ghzWXaLSDC6Xr3JlNvg/dv6o12wmauddH94MZDT3Q5Wz/i6phVhiykYGUYqFJmu8yRAROsnrJ+K2DMahVWcmGgtK7xxLvHlW2JXl2Z3edEfFKf31RQ+QhvPWy22MG7yqX5w6BPJmG0gyImBRpuJXZuGghqQJxtfW7emB3h3BbYHMMod8PaITOyOcdriwCDkcZPMBxvB+LKC4GYuip1UJYynZhQDaB1oKIO/JKW2deW8aVpSZ59zwWPJFup8qggoP6KZzIJBGvQPGLDnm+PuxYiKvYxqqlfHZtaNw1N+Zcib+FSdaypDPbszwynpSJ2B8YiXH6r5wQAZFo9tlikjrBdK8W88xcQA8RrQkciMFyks9t/pwSGM+MQNZuALJEyMfCuosPAQf3UGpNhbrPF4Ov/wlpZn8Ue4WJBUx45pP4eMN0IfjH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR11MB2717.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KXqIFB5GKXdhDm2stwTqjfqX+XxS5yMGimySg/XkSdwBxwueWTBEHTeELGM5?=
 =?us-ascii?Q?ipLC8wF3ULQc63csW7/qxJNhroDpjLzg8yxhoJZ220NMiKE+ufe/HoGlgGJf?=
 =?us-ascii?Q?JgwdZP4KahrIuQ+0J01CyZfePS9w9z+8H0YadeQh2L0N/tQal3ZqhDzEjpXw?=
 =?us-ascii?Q?ldGAAyyDGJewmeq2KdgkiO9TjqRGB8NiQU7HZYUU3BoUbyNZ0sVAPTSG5Qz0?=
 =?us-ascii?Q?cXUKGKroZky5uHXbPe4BVhpf4i8Hw0ldSmnTqCO0IV5Kc8leMOgAOYYxVMti?=
 =?us-ascii?Q?fwbtzgRzPEKBFC+37CUXojEwRqOkpu/y3nv57IJ7z2+6D1jH85nPRqV1K2GN?=
 =?us-ascii?Q?kZvobCbFhXu1d/pQhS+S1eeZW6XkMdd7hPmBTX/mv24XwEpWCTUcHGr5J/i/?=
 =?us-ascii?Q?DG+/BbkxG7wvTa2ov9XFTau4YHss9blnfNT12XKidynaVZH1byNpSC01UwmR?=
 =?us-ascii?Q?JwiduP/bKD0TfUmwrUu5aToLYYHhOSPA1aIFIF3hJa85+y620EI3w0kYGzsp?=
 =?us-ascii?Q?v34OgqDIly3AzghC9y09Ux4ENGZdAMTYBm4NRx3dI43DIC/2Kx+bmN3d6B21?=
 =?us-ascii?Q?TEw84PiWwEVIZ75u0gi7Z1sq954eFW8PJLzR5u1fWCvd2DC2zh8/cen5tiK/?=
 =?us-ascii?Q?SIQR+oePNabXSzI2EfUSNCFyR92vzH/WarASWuAky4nuNC556h0RtOQ1M2Vq?=
 =?us-ascii?Q?hJDO/9aaSCRAZRk0LCzDP4NrJZnaQyVBVIswaalucj6+NpPK26pzOPPrroiZ?=
 =?us-ascii?Q?1Fb+opfP+ih9u+9j6x1Hee81PDmRpaqyzi/NSkHF8P2Qp15xJQ0461mhS6Gx?=
 =?us-ascii?Q?Ti/7Mm/AJk+NVLAR1qklIeaSJDv8ZEdLSF6PP0jpJ4NeXqC4HfZ60aOGZQOF?=
 =?us-ascii?Q?/Pt83UdbvxdMb/NPkvU4zqfVx9FbPu8OJD5wOUTqz8BrZ2YE6rrHAJzysxja?=
 =?us-ascii?Q?PI2fLyYHyzXZxc8/JsDYAnsQ0BzcZLtmoADJuLnOiAne37GP8glVd2ied/mG?=
 =?us-ascii?Q?0DWXLHzi2Hhu4T/tBoWJgiqkC1XQIr8tmHwCIMmIlNNZfBd7kcOqNs8M4PTO?=
 =?us-ascii?Q?wRqY6eUI7FjSqiy4TjUY5aZ8SoKu1AMhxGDBLpWZ7OQijEqlsPjnDCHdifZB?=
 =?us-ascii?Q?/3e1x2ijjHF013/4RM9R/YA8ZhQXWWiEYpF3S8HbzA6Gyo6WFofqXGYTnhl/?=
 =?us-ascii?Q?mNYmuT1/oWyhvOwPg+S1Hfp0R53S0emjUmiLQteFIEi+MVZrmAp/OMeMxzkB?=
 =?us-ascii?Q?gMU9033HGUC897qSx5B/VfdGFpKYqPTjfl6egRkBd5GWMIOUkwjYRisRxwjY?=
 =?us-ascii?Q?svHxh86rv9+tRNpSb0kRQqOOAdwKZL2LI3eDVTiRqOZlWu1qj/5YWSQS05Nj?=
 =?us-ascii?Q?yQ5U0HSDDy2Hl9zrZdqD8oqE+nQe3DRDZOitzwURrWv+yqULYdW5BVq3tovx?=
 =?us-ascii?Q?XPKxRAJLhBKZksdUKcRIV6M/ppdPSMU+lbl5EcA7GZThuQrrTyN/GpgdAGd7?=
 =?us-ascii?Q?FtrQlQUt9torV14MtJVO0w3CiRhxIUYzpnyltSJai4IVJbXqONI6IjRrkXBW?=
 =?us-ascii?Q?L2PNUFYtYfEVeP7vAKUu74THQKepU9pGhDzPi8A2LcRiH05QGVOYlogIyiku?=
 =?us-ascii?Q?uRBiKm08m4BL3zdNyyNRkf6UHTwdTZFrWGp4QaOuQqQIzHsJzNeSz7kGw3Fo?=
 =?us-ascii?Q?s/L6Ot8p6R/LDZtelSoP/u+iHvhGq+eKntVufW4t0qSHUPb3HcuEUlcmKy4o?=
 =?us-ascii?Q?QijvWIdYOha7BLbqy97ZOzcgNvB6QGxJLRWglymCBdyg5Gldb/pOqG0gzYE9?=
x-ms-exchange-antispam-messagedata-1: +xKlzNUTkEXarg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JHssZDz0heUAfMkLIic3dP+f14+HmodI1BQBE2fLNlqb6BiLeQO5QFSARmXwmTMJ5mR3SHqgq7wiFmYh8EIN+/Q0fRVOXb6a2OcCrAi9RsJ0t9qugUNIB1Kjb1U7UiicbSF74+lAC/IVCywKcVTchKT1Zapy8mnl6OXsVDiHwcjLBTjDmL95Qex69tCh3WEy1woOWX19xgsSzsIZSdbFdyHXps37BCQdnCrl+EGuvM7xq8biXHKoxvcPZjlqQ5i7ZliTBylbQp8ff95zKr84ZV4o1xcU+1oXLhBjXMz5W3LrlWE75GWbazjcw0LBewEJ/zAgNQLrzNykQBMOnpJhyQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2717.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8032822f-70d7-4aee-c90d-08debd029b35
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 21:46:42.4542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l/FNMr0a+A6uM+qD4qjfbZyNpsq7dPG4GlMkCw8yofW0PzZxqp6o15jNflP6EjQYXPrMG97pHZLQFYNtpvHRXLsXgGUY3Dqx9WvnA6REO4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7021
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
From: Cavitt, Jonathan <jonathan.cavitt@intel.com>=20
Sent: Thursday, May 28, 2026 2:34 PM
To: dri-devel@lists.freedesktop.org
Cc: Gupta, Saurabhg <saurabhg.gupta@intel.com>; Zuo, Alex <alex.zuo@intel.c=
om>; Cavitt, Jonathan <jonathan.cavitt@intel.com>; Sousa, Gustavo <gustavo.=
sousa@intel.com>
Subject: [PATCH] drm/xe/rtp: Check hwe before calling match_func
>=20
> XE_RTP_MATCH_FUNC may attempt to dereference the target xe_hw_engine.
> Ensure the hwe is not NULL before calling the function, matching
> XE_RTP_MATCH_ENGINE_CLASS, for example.
>=20
> This covers a static analysis issue.
>=20
> Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Cc: Gustavo Sousa <gustavo.sousa@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_rtp.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_rtp.c b/drivers/gpu/drm/xe/xe_rtp.c
> index dec9d94e6fb0..2cd26db113d9 100644
> --- a/drivers/gpu/drm/xe/xe_rtp.c
> +++ b/drivers/gpu/drm/xe/xe_rtp.c
> @@ -129,6 +129,9 @@ static bool rule_match_item(struct rule_match_ctx *ma=
tch_ctx)
> =20
>  		return hwe->class !=3D r->engine_class;
>  	case XE_RTP_MATCH_FUNC:
> +		if (drm_WARN_ON(&xe->drm, !hwe))
> +			return false;
> +
>  		return r->match_func(xe, gt, hwe);

I only just now noticed that this is also a possible issue with gt.
I'll wait for a response from Gustavo Sousa before creating a new revision =
with the added
gt check, as it's possible these checks aren't necessary.  If they aren't n=
ecessary, I'll just mark
these as false positives on my end.

-Jonathan Cavitt

>  	default:
>  		drm_warn(&xe->drm, "Invalid RTP match %u\n",
> --=20
> 2.53.0
>=20
>=20
