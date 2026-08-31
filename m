Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2954C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 047D510E820;
	Mon, 31 Aug 2026 13:14:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XWYeHXO5";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1C3610E816;
 Mon, 31 Aug 2026 13:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788182051; x=1819718051;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=oPCKw2hHvlTmgO0mIE8Tr0HybCIyDHIoYuL+YCWnEeo=;
 b=XWYeHXO5c0XX9gnHR6V631ImuufDiyQ0WpBRRfD0T648eElu5f7iRFIs
 cTk6CzlnZE9DLQNjJt/m7rqQS8ghC4rWyGstRyyhMc/FiPGGH5tfkopUL
 gTWN8qklIyjGZGulHb+1yl4pU+Xh04GQw4L9O6IhSYkrJUPIkC7co0JI1
 e93j+evLikJ942aoF5j0tUCor5xF2Gomlg+p7PFvRUkWpx2UnJ/vpIBPB
 nR6iqXFr1wtH2mF8YyFcSTfiF0LuDyhB9rZ3yAzrPm+MkG7P8QRETsK7E
 hBE77hwuzelBt7tqU+7mQRvJWPciKjYXCjXVwTvmkJKHPy2yQSFP7RAEw A==;
X-CSE-ConnectionGUID: 69y82xvyTVSOsJjTcdCqGg==
X-CSE-MsgGUID: 7sI++zU5Qs6CfFnHzp2UoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="92455715"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="92455715"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 06:14:10 -0700
X-CSE-ConnectionGUID: BRt2BVsUSKeaEam6eFGTcQ==
X-CSE-MsgGUID: 6TI1wjMoQgaXhaNKk1d2iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="272306453"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 06:14:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 06:14:10 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 06:14:10 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.23) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 06:14:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjREPVJgaFdtOngYWCfF+3okm2Y1CF1For96lb0/6wLcPRhexxBAxh8sdd8XmEz0KoXvxzSSP03lHslxyCA/LhxW4629CMjryPdGEq4z12JstWesR0glbe44+SEjEH/XpEj3k7jCf8z7JoaBphQuZKyxdZaXybMZnjgXf/zdUquIaeeiL0B4Khlv0CFVukHD5emyTtYNM6nPBh+tjz9FMwv/D0anc53jKycXAAV4mbv0PaWoiALYY2B218WxgJhzXlMhO46eQEYPiiHDtD13Ll3Z4HRxBotfCyy4y8eR09ZPBzQzuEtCNQeubwpzOnKjlezKdJ7ZqRYiBYGG0nFMFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hD3hdmoxt9UtbOf7pSEUJOvR0XO1zYwXrFB7TcKBwfY=;
 b=CvdwQZC/lIr7LEVA2zMjIBaXuS8mTKb1+07IBk5rAZPvk523/0N1Aosei56q7zxb8RwPNDQpz8C2ct0ISYe69X+iY99y8jQ5UusfJDxmf1Rh0DsjtRVMzaBgUoYnbe/f3ke5lBGHJMtLllxLY43iVCTeDfNsmLFKG4KGxU3+6a5Z1cB1kR35oxsp7cgEd82ZWM+do26ZE01rDKjsT9UmaA58XRJZq1PyUaQPe4430afCoLXQGUiy8vugsQgeEaACgxRGdWkDx2YDuGdkGcEV8bvFmTMALo3BMlT73oGfFKt1fdSwLrYbZqqd7xRVAcHwXAgt2Jfn1Wk2v79NRJMrcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6360.namprd11.prod.outlook.com (2603:10b6:8:bd::12) by
 EA8PPF8DD15FF6B.namprd11.prod.outlook.com (2603:10b6:30f:fff5::795)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 13:14:01 +0000
Received: from DM4PR11MB6360.namprd11.prod.outlook.com
 ([fe80::22d9:ae03:5db1:680]) by DM4PR11MB6360.namprd11.prod.outlook.com
 ([fe80::22d9:ae03:5db1:680%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:14:01 +0000
From: "Shankar, Uma" <uma.shankar@intel.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Subject: RE: [v6 5/9] drm/i915/display: Program CSC on SDR planes based on
 Fixed Matrix Colorop
Thread-Topic: [v6 5/9] drm/i915/display: Program CSC on SDR planes based on
 Fixed Matrix Colorop
Thread-Index: AQHdJBCP3uaGEOSzIUCuiB6bFmgut7a4TN7w
Date: Mon, 31 Aug 2026 13:14:01 +0000
Message-ID: <DM4PR11MB6360C811A6C06C5505882C15F4A92@DM4PR11MB6360.namprd11.prod.outlook.com>
References: <20260804123107.2256124-1-chaitanya.kumar.borah@intel.com>
 <20260804123107.2256124-6-chaitanya.kumar.borah@intel.com>
In-Reply-To: <20260804123107.2256124-6-chaitanya.kumar.borah@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6360:EE_|EA8PPF8DD15FF6B:EE_
x-ms-office365-filtering-correlation-id: 33c6f148-416e-4e20-1309-08df0761b9ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|38070700021|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: TjSVD5fmETE8hCYr8doJSL3J1JiHiUiSE8Z6OztJwYPggpvhaEujjRKl6wE8gy8X6hKswqZ8XtXTigI/+m4jPw7ALakR9UVOOcKx3WT/PEwYp4S0gi7jeD2XcI3BxBTX3WfZgZJ9Fr+yG6pOZsY9j+c5jqPZVgYOZY5umzAM/bD93ZQQmmmG+zvzN1jNWwLepEae5ytFl5tK8F9OZJ+mrgO+5+j7KAoyJK6NAmdRsQDYK/CfPSTG5ZvqQcc3CqjBI/Xg7m1ySLabPu2wgwEwL7t9Ia70YHoe5modTaAHCJINJPb24ktw/3tc2UBCzATrmT5VSOwzMIVUWqHqdeN+8uKFWja0xrLaq5WdRVo5lIEP/uc75buXPwImoG6+o3lgZEstwPHRbcZG7dJfuOa7nRz8/0yqTllSAXMzN1qViyiRqY9e8kltlfwIORcpM1qBRA46zW2KV4n31dXVaN7hrAbw4F5btaoZ+x1h5oOvOtR9PU0xxC5Q6FyVg6hce7aaYp4Y3QVuU3md2Qriff9zzFLpCMoscDU25eLkVbR8Ac73csAIsfVadoLWDliQJbpD4xc04sW+pSZGnETsQZGWHf+PN9T4tr0Ztw8xYRcOczJZZ2GFr5NI73nmdUD8ehp6rlYuB1vIt5nsOmRMRCrgRBWRYHnhl/yTpj4dj8QdPgrd4XQyF74SzuOI8rmzpytsnLs0d+TULkX7YlG4/qLT3QmCqs0/dx9tYmjnQ4UrsHE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6360.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8422DBsWTip8gFWuHMynQu+RgB3+fg8DgbHdxjbq95AIdm/brLkINr+EtZIn?=
 =?us-ascii?Q?DaCkQpUa81+XF0fhIOcfUaPLYqoqQOeSAsnM1bIEw2AhHs9Iw1Se6Ox4hHmu?=
 =?us-ascii?Q?7uUzzZAKHovMc2P5WG2iqe1V/P4iXdI5Em3j0mUAeI8niynpen2kVZRVampi?=
 =?us-ascii?Q?YJIOfrloSeMXYhxovT+Gd+6xwBYmSA9u24IrIr/3HRAwKd/KeIscr0QvaNJJ?=
 =?us-ascii?Q?Do8IkFxcQuZlTQWokHjKFSNS0YHkEPS+eYVwambZVanvUoJ50kPhrBoYk2sh?=
 =?us-ascii?Q?lk/XCt/ngunZM77g2tReaGBFOCicu1uHCK+B8bcf4d9jUDwsuOfcMOx8G+fC?=
 =?us-ascii?Q?GHPsboJPIhZUdgwxnIfHKnb+meAAtt2yKN6vEJuS2eFZ+I0IcqsglRoOLwzk?=
 =?us-ascii?Q?u9LC59nzG67/fmajpcVyX4ZzcIVX5iDX0MgTp8jAvBA0ypB5py2za4DNqtoD?=
 =?us-ascii?Q?GGA0AfsGGfxXuautVhtX6YcUiEp8uRgZav9zJfWg/31SbkDkOS7kpm1RosFr?=
 =?us-ascii?Q?+gGOOV/nJ9Lhp51/wzvuy1vJUYRbYYLfQ3bZpjK0lGW8ulej+cxtgAM/e2l8?=
 =?us-ascii?Q?tl4JzrDh1KuVZj7wunbxiMmrcCuPT8WsTQAiECLH4kSMnA3DkXdXncKNQkQW?=
 =?us-ascii?Q?8arovKuP5/UjkfFrf0Y2EdfOHBcBqU7uFmEwHMm8su5FQfoy/1oojMMSPY9t?=
 =?us-ascii?Q?+GcjsvSIcDLRsCThDtUYmmLBkutIJ0WwiqGRRs6fpLc7Q1Wv+DVnuvov5fBi?=
 =?us-ascii?Q?ThWc4xf0GwQwlAcW6OQ3vhjiENMjJtrm9XSH9DZcqAxRnwoxBEFoLMdH++G0?=
 =?us-ascii?Q?d+hfanWW+0Ai1kssHpvPbGVROV31RJ8DnCBgqMLRCSolcf7Q/zEgoBCCdjOC?=
 =?us-ascii?Q?H48i5zizKCBnObuXBxY/YLMi+rT/bGsKpSPiXfJSg4gRzbrPOsd2wqMIBix+?=
 =?us-ascii?Q?Wy5ib8ZxwiC+Hf3VnBZmTcuuMDGZ5tEfq0R3sZSxuMYIEpTCFhcnbg68+s9W?=
 =?us-ascii?Q?a1rUI1q9Dg8pK/8UqhKNUdj+G55T3sLVAOTl+mzcMkY4ZLb9NP06W5qgWcse?=
 =?us-ascii?Q?XaACsJdF3b/af/AGjxNmLl/xtvAarZ3VL+kxp9rU0tZZITlZl31qA5EEnkKg?=
 =?us-ascii?Q?VYtf5hc9dCCqKQU704t+6eI0Ui0XlnuRWFPVT9VDYwyNI/Fdwqw3G6Ahujd0?=
 =?us-ascii?Q?cACM0JqxIRphKOF9nNn6ZjYgM/h6/efVPvviipNqba7/rLwb/Y5Qoqi47uNA?=
 =?us-ascii?Q?clvDr8uagLH5OAcIpCy/kjzhRMmC3zoEQrimMr2V5mvV6D1L00B0ag3w6z+f?=
 =?us-ascii?Q?k53VujpOrwAeQ96+t2Cd14EQ+aU+K3W3SEq5bZ/Yy0uQZJpGR2mA4IuZ+7uz?=
 =?us-ascii?Q?a+wgFM4UU3D1a097/wVqI27+u5fha4suTe2QsxUcm5zptNd6yh/TdZWbvfrc?=
 =?us-ascii?Q?atSR8Oe2/uvoK2HwNNoMBp1vvMGe1gnQh6Tf15phKVIMa+tTiGh6+8r9FTFO?=
 =?us-ascii?Q?nhKBszMwgXFmfncH1WUc4W35GZIvSnmKPTHt38zNKP+GUcWf0uk3Gt1YYW0J?=
 =?us-ascii?Q?UTjK/V5P6Sx6X4rLIJV8BcD6eIbS+T8aQ0uCgmpqqWQHLrKHRfmB7rphoHIP?=
 =?us-ascii?Q?FmBkGAn7tLrCkOOgKTb9VJ3gULhiecOa/oN8w+VX4ETikA8FR2/kvQzUYVrM?=
 =?us-ascii?Q?fISa5N29JNq/a98NoeW/Vq1cEqRAOIFj2FW8vXbEFHwAqypVhTuSLGNUkZm3?=
 =?us-ascii?Q?IIgjg9KxqQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xG5TmeA2egNiKDFy+JTaQ8dfbYw+dCM8O9hfUaTy/iib9Oy42IuKXt1uMMn4BdoD+BuQ4gbxT3tT8+gNC5YXjYQa0xsaDIHC2nuWOmEc2emB3UJQp1ojS6FMjqEIOuGavGMKEKmeqZJBa/2rbiqd+7StDJsG9yMa3r28FkQWV2Tkq+/+Yhr64Iob35b8bTzqcnBq05ZNeQM25hMhHh8QEe4767c8fFmobR35AL03qmSgnMGzcd3DJyqhrTAdqt1i5QTqgXkT7aCBUBBlP1sSMe0COg+GpBzitqIM06vbg3he94jwEg1dQ8+kXyvcaXpe26KNgyLv2VCBe7xwF3naNQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6360.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c6f148-416e-4e20-1309-08df0761b9ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 13:14:01.7899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lbfXbmWvKWElaj75fer1vstN4hU1WJf/U890iRZVAuqxU+00WOxHLMUuu9xubtgpV2uIxh5M3Rpsq5NlbGr/cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA8PPF8DD15FF6B
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
> From: Intel-gfx <intel-gfx-bounces@lists.freedesktop.org> On Behalf Of Ch=
aitanya
> Kumar Borah
> Sent: Tuesday, August 4, 2026 6:01 PM
> To: intel-xe@lists.freedesktop.org; intel-gfx@lists.freedesktop.org; dri-
> devel@lists.freedesktop.org
> Cc: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
> Subject: [v6 5/9] drm/i915/display: Program CSC on SDR planes based on Fi=
xed
> Matrix Colorop
>=20
> When a color pipeline is active, program the SDR plane fixed-function CSC=
 based
> on the Fixed Matrix Colorop's state. Re-use the existing plane state vari=
ables for
> color_range and color_encoding. Track the bypass state explicitly as a bo=
olean
> since bypass is managed separately from the FIXED_MATRIX enum value in th=
e
> colorop framework. Keep the programming based on color_encoding/color_ran=
ge
> legacy properties intact.

Looks Good to me.
Reviewed-by: Uma Shankar <uma.shankar@intel.com>

> Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> ---
>  .../drm/i915/display/intel_display_types.h    |  1 +
>  drivers/gpu/drm/i915/display/intel_plane.c    | 53 ++++++++++++++++++-
>  .../drm/i915/display/skl_universal_plane.c    |  4 +-
>  3 files changed, 55 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h
> b/drivers/gpu/drm/i915/display/intel_display_types.h
> index 20a07ea06b5e..beb0169cabef 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_types.h
> +++ b/drivers/gpu/drm/i915/display/intel_display_types.h
> @@ -683,6 +683,7 @@ struct intel_plane_state {
>  		enum drm_color_range color_range;
>  		enum drm_scaling_filter scaling_filter;
>  		struct drm_property_blob *ctm, *degamma_lut, *gamma_lut,
> *lut_3d;
> +		bool csc_ff_enable;
>  	} hw;
>=20
>  	struct i915_vma *ggtt_vma;
> diff --git a/drivers/gpu/drm/i915/display/intel_plane.c
> b/drivers/gpu/drm/i915/display/intel_plane.c
> index d0f99a87c42e..25ca049009ef 100644
> --- a/drivers/gpu/drm/i915/display/intel_plane.c
> +++ b/drivers/gpu/drm/i915/display/intel_plane.c
> @@ -462,6 +462,42 @@ intel_plane_colorop_replace_blob(struct
> intel_plane_state *plane_state,
>  	return false;
>  }
>=20
> +static u32
> +fixedmatrix_colorop_to_encoding(enum drm_colorop_fixed_matrix_type
> +fm_type) {
> +	switch (fm_type) {
> +	case DRM_COLOROP_FM_YCBCR709_FULL_RGB:
> +	case DRM_COLOROP_FM_YCBCR709_LIMITED_RGB:
> +		return DRM_COLOR_YCBCR_BT709;
> +
> +	case DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB:
> +	case DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB:
> +		return DRM_COLOR_YCBCR_BT2020;
> +
> +	case DRM_COLOROP_FM_YCBCR601_FULL_RGB:
> +	case DRM_COLOROP_FM_YCBCR601_LIMITED_RGB:
> +	default:
> +		return DRM_COLOR_YCBCR_BT601;
> +	}
> +}
> +
> +static u32
> +fixedmatrix_colorop_to_range(enum drm_colorop_fixed_matrix_type
> +fm_type) {
> +	switch (fm_type) {
> +	case DRM_COLOROP_FM_YCBCR601_FULL_RGB:
> +	case DRM_COLOROP_FM_YCBCR709_FULL_RGB:
> +	case DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB:
> +		return DRM_COLOR_YCBCR_FULL_RANGE;
> +
> +	case DRM_COLOROP_FM_YCBCR601_LIMITED_RGB:
> +	case DRM_COLOROP_FM_YCBCR709_LIMITED_RGB:
> +	case DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB:
> +	default:
> +		return DRM_COLOR_YCBCR_LIMITED_RANGE;
> +	}
> +}
> +
>  static void
>  intel_plane_color_copy_uapi_to_hw_state(struct intel_atomic_state *state=
,
>  					struct intel_plane_state *plane_state, @@
> -474,6 +510,7 @@ intel_plane_color_copy_uapi_to_hw_state(struct
> intel_atomic_state *state,
>  	struct drm_property_blob *blob;
>  	struct intel_crtc_state *new_crtc_state =3D state ?
>  		intel_atomic_get_new_crtc_state(state, crtc) : NULL;
> +	enum drm_colorop_fixed_matrix_type fm_type;
>  	bool changed =3D false;
>  	int i =3D 0;
>=20
> @@ -485,11 +522,23 @@ intel_plane_color_copy_uapi_to_hw_state(struct
> intel_atomic_state *state,
>  	while (iter_colorop) {
>  		for_each_new_colorop_in_state(&state->base, colorop,
> new_colorop_state, i) {
>  			if (new_colorop_state->colorop =3D=3D iter_colorop) {
> -				blob =3D new_colorop_state->bypass ? NULL :
> new_colorop_state->data;
>  				intel_colorop =3D to_intel_colorop(colorop);
> -				changed |=3D
> intel_plane_colorop_replace_blob(plane_state,
> +				if (intel_colorop->id =3D=3D
> INTEL_PLANE_CB_CSC_FF) {
> +					fm_type =3D new_colorop_state-
> >fixed_matrix_type;
> +
> +					plane_state->hw.csc_ff_enable =3D
> +						!new_colorop_state->bypass;
> +					plane_state->hw.color_encoding =3D
> +
> 	fixedmatrix_colorop_to_encoding(fm_type);
> +					plane_state->hw.color_range =3D
> +
> 	fixedmatrix_colorop_to_range(fm_type);
> +				} else {
> +					blob =3D new_colorop_state->bypass ?
> +						NULL : new_colorop_state->data;
> +					changed |=3D
> intel_plane_colorop_replace_blob(plane_state,
>=20
> intel_colorop,
>  									    blob);
> +				}
>  			}
>  		}
>  		iter_colorop =3D iter_colorop->next;
> diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c
> b/drivers/gpu/drm/i915/display/skl_universal_plane.c
> index 73be4c6ff1d3..222c3b6bbe46 100644
> --- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
> +++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
> @@ -1245,9 +1245,11 @@ static u32 glk_plane_color_ctl_input_csc(const str=
uct
> intel_plane_state *plane_s
>  	struct intel_display *display =3D to_intel_display(plane_state);
>  	const struct drm_framebuffer *fb =3D plane_state->hw.fb;
>  	struct intel_plane *plane =3D to_intel_plane(plane_state->uapi.plane);
> +	bool color_pipeline =3D !!plane_state->uapi.color_pipeline;
> +	bool needs_csc =3D color_pipeline ? plane_state->hw.csc_ff_enable :
> +fb->format->is_yuv;
>  	u32 ctl =3D 0;
>=20
> -	if (!fb->format->is_yuv)
> +	if (!needs_csc)
>  		return 0;
>=20
>  	if (!icl_is_hdr_plane(display, plane->id)) {
> --
> 2.50.1

