Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0477C624D6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 06:52:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C30BA10E03B;
	Wed,  2 Sep 2026 06:52:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hGttUbyH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C15B10E46A;
 Wed,  2 Sep 2026 06:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788331931; x=1819867931;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=it+O3bYaQZT9q3g5lZRdUMix9v/pxZVRiXtRUfzgLV0=;
 b=hGttUbyHqouO3PbRmLhs6p0agjPCSmgaymCPH0IF6J5JDl9yru8seL6t
 /M5GGLAETygtRaocj26dFm9U9r4hq/O/HVUT9xqFZN8kRVYC1olEK4gv+
 TGaZrC166Yb5Nek9q6jkCbSmVu+wqlZo2NUw6WsS/CwJOFrwanbipQfrx
 6p0M4HCpKwdkWWR/0PnFEXXzkt4JypAy7A4OWP6xoMEanrO6mlyjcbcMl
 tZGvtnaYPSM15eZPhZIldOAxy1xdqn/nGNL/Dp8Osv15ELXl0JCJJVNQ9
 EytbxoWPC910Dpgb4U1iY/EaJkX8S59tgva9PI9HigLI9+Pi9mTGSzQ2Y Q==;
X-CSE-ConnectionGUID: WVtsBOOiTNK9FBE1HwoxtQ==
X-CSE-MsgGUID: qOjYFFjdTjSDsPSBTrRnmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88826352"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="88826352"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 23:52:10 -0700
X-CSE-ConnectionGUID: KZ+aD2kKSfW9ntHtcsaMZQ==
X-CSE-MsgGUID: L+SjH9RpRIWrujtp/3ypUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="271292990"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 23:52:10 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 23:52:09 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 23:52:09 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 23:52:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUkm2XN+bPokpCorLlinFSog0lHMTmGAgApPHGwO83UB8ckAs6UGVIadhvDMPudFY2QdcKTmSZOR5TazAsB6VxamsU+U1suY+plnna3DHelGjGvxSu701D8PHgqGlX0jgdrIm+ezLHPGCmPfQQqEXPNUgpAsiSzGuf1l+mT6n0Qml7H26wXIUruiXbH3yKNc15SHFWwQo8KVA/p8sFjfxHPr6LLJvIDbY/PH6gLRngsTxLjQFDPbugUb6daxKJ3+nGYkndtwYNlrztr+hmzXHQR+VEiXgks/KkGAEQnye7vWf/a6B3+rC9GkxXqwzTwe04t+VEusodJagD2/dgMaTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axK7PGuM+dcEm/flXYgGz+Xo5PqIf8tCT2wEiTjOxLU=;
 b=bdJSMxk67h96xY5Nj8OVRZ+os104kfdEYexXA1Lm/kKmjbRpBwT/oQF3oV2lgRSvevA+hUKzMijoLQCNJVMkbSTKeHlC5ZbWbDUYXK5f7s0MXtq1x756G8VPlEbZ3dKm571ItmP5d75rb2GuQAkHhEsjefhj4vx0qxzdf3HdMbVjFxrIiECoYgz2Ga/1nSBY8FtRoIowuPdTjBn0pxY8mQEyRsOs6g4W+0T+UkwdsCSg3nod2ykjKu9/ND/4QZp8pm9QBg30GJInaKAUy5oxU6wAsvac7XDSxWMbGLNkTgOe5Qi+2+CXUj9dtt8IscVlCQrop6kyTf4qDtANgF2/qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::5b) by LV2PR11MB716723.namprd11.prod.outlook.com
 (2603:10b6:408:3ad::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 06:52:07 +0000
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::5be7:2ceb:99ef:6334]) by DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::5be7:2ceb:99ef:6334%8]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 06:52:07 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, "Shankar, Uma"
 <uma.shankar@intel.com>, "ville.syrjala@linux.intel.com"
 <ville.syrjala@linux.intel.com>
Subject: RE: [PATCH 01/44] drm/i915/hdmi: Parse frl max link rate from vbt
Thread-Topic: [PATCH 01/44] drm/i915/hdmi: Parse frl max link rate from vbt
Thread-Index: AQHdJiWiIvXyNKKVb0SEFjZSIlP3a7a7Alyw
Date: Wed, 2 Sep 2026 06:52:07 +0000
Message-ID: <DS4PPFE901A304FA39152EC0B9FD5AEC323E3B72@DS4PPFE901A304F.namprd11.prod.outlook.com>
References: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
 <20260807041430.229038-2-ankit.k.nautiyal@intel.com>
In-Reply-To: <20260807041430.229038-2-ankit.k.nautiyal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFE901A304F:EE_|LV2PR11MB716723:EE_
x-ms-office365-filtering-correlation-id: 07e25601-1136-4a3d-45f5-08df08beb497
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|38070700021|6133799003|10067099003|11063799006|5023799004|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: LMbtozhpOytOoBnO8GRYMBHZpOqv68lVudQGy06TC/jruxke3magGAuZCMR3JsT3wex6Af1hKgKMbBnY00LZZ7YCki0qBBPWeaU9+KIkxctZH0EGJN7eDtTcE432JDumjOarcMLpLNbk0LibiZFiWS8BcxHoyM+y483KYvNuo+oj1qdtVHuEAL1Q6WuYSYjS3QVb3n3G+3a/bgkqYpPo4YSrTzO4wlT5IwJ9S57tCSfZ6AhVXYRK2Foekz0jVe+e3mWUnY188qE8lyhCAt2LeuGbYU2pRhhHU3tpz6VQjf65GQTomzlRh+FtCZN4ItUevxRQXe7Nsjh65jBpqwx8FiUpc2ryrL97Ym16JmGBkG1+ZpYwOO5dF3vMpPnHO3Zlcu9GANBnrK4uZvezL2Eh55vN2hQ5ZLNVuN7tYaYrssV939BJeGYd8EoP+4+7ZkeoNFGDjRE1lNGDRrgc35WT+BF58GZzZQrw4o7vq530d+VTLAWCOt9LOSeZXa2+6LOFarcphVOJcVMZBZadkB4aBmn5pKiQ0VubjbwcxB9RWFSJtyslVH0KF4jeb8PLStADaHLTuslMNf7TGsoO4q3DTTOgdGxAGD2+vfOFpxbu3LEaaf8qFY/T3VxYyQyLSupwnMOUxm8oNiIBgMYmuY0wqxA9n1Iy2k84VfMaQmAJYo1kMJRhDML3xYsEdE0rnGw6TpQBChh/cwQsAbrWmfV3DNr3+k+s367MCX04Jt9inpw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPFE901A304F.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(6133799003)(10067099003)(11063799006)(5023799004)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qfJtne/sLRyBTAhFm4w5Gtj7ezftpgGiE5RWUDrsqE72KZKake3CXaDc6TI0?=
 =?us-ascii?Q?wMCTYhmcxGl7zxAUjZvOJOaLah30ZyfiIovhVFDUNwj9571eXfWW85ZQFyp9?=
 =?us-ascii?Q?FP1nSqZOsbaZRMWnPnWBZTPr+Yl4dlZHGC1dNtDuJwqdwZBVDUzQ3yfdSOLQ?=
 =?us-ascii?Q?IurYqgJdupSps/f6c7qtP1Gaf10jY43oNqwPUtFZ+KGWD29D2YDfYttY2gfx?=
 =?us-ascii?Q?uJfBC3SU0nZ2uwcpUDjtk5udWiAlcdwh6m4Cd+BOPKPCDkyx8x82aAVqEDCc?=
 =?us-ascii?Q?6V9rFIvyno4D8I55HNBMjgQf6n+IcxlcoYw3eumYNzUFsI0LH+BlvAPripwt?=
 =?us-ascii?Q?bqabS3JZEgGfeaQAm9Jrmyjb3FuRpXGG01Gk7GDIQYMAdtsjAz5j6FTGtNYC?=
 =?us-ascii?Q?FX6Q/DJ6lEVfIZMcgeJQZD4r0Egd9iLZGAtOWxD1VmyrL/mTuHcl3DL1WviY?=
 =?us-ascii?Q?J9WIkypALVq6pIU3EFcIOScOjWUsydKYG7R6yiDKpm5WGkZsgyDiBn2Dphu6?=
 =?us-ascii?Q?AoY37xhGrcLf6/Fh9wVl5Ge1JUq+u9YiozG0IjUzJ9mh1zcgxcjcaYD4EgFJ?=
 =?us-ascii?Q?UDsjoCJfTMzA5br3NOHTqUu4pMKtnlA1XAD1mbrgxLMzNvu4ikalk17J9OGK?=
 =?us-ascii?Q?agGc2zsyXK3ukUPVOjuL4g2xiFoj1hTgI4Y9s8r/mZNaYJStvXuhbtS76HOx?=
 =?us-ascii?Q?yeip0HPnYDGYBJD6I3FOWas5H4Xrjj0ftmcKggtUcFr7t+row3F9czTDPgs4?=
 =?us-ascii?Q?kyodLAC0wPSeaiSmt3OiYjWvST5S4JBFZXT+ULLnV98hHc8Gpnrj7mmigx6z?=
 =?us-ascii?Q?aFx6k6wyRkJzKyDK7k2ZkQDiz2t5iF9pGNZ1HXvyBTcCXpjS4xMBE1j3XBGD?=
 =?us-ascii?Q?tsHizHueOm6gPszUJ74fDC77W6kOWcAjVMrMDQF45gC8GZNgbe5XzecFzsL9?=
 =?us-ascii?Q?d0o1dVIwxX/zVIwRjD0TOKJT+wSUwUErdaQ2h3qPbiF6XL4I8lXTp2b+iTeH?=
 =?us-ascii?Q?lOjmnHBgnv0cLVCEKbCpMLcbHSAfjLdtoqE6IFH7hDvmWemrCYAOPEiTEVhm?=
 =?us-ascii?Q?etVSBNpKlr3zmQJ8p0eNYes0osXzeVzPycOhnWpnFMJpmSnelSPWZf8/w1fC?=
 =?us-ascii?Q?5kNeyOw1BvHWpOr8mOGv0HodiEh47U/HHuExHH41bFszn1J2pjQbafMc0xSq?=
 =?us-ascii?Q?Xau7mCsKVjsMWmPEuazGQmSTR9RsnJ/JqvpE2ch6XD11YtYpBWyQjlxszpVy?=
 =?us-ascii?Q?aqxutbA58iJZm1la+PQzA/7PTKsKQ2G61TA/547gpI+82zvYTCaNbyqfGHP5?=
 =?us-ascii?Q?FXNGJVlWv2ALvKfSu+MvJzii4v2pjkno5+Y6ieR9gULPdsEPBTyTevHh8/uB?=
 =?us-ascii?Q?4ptlDBITyWUkBsO1bBQxxeKiYRF2Q3n+Iiyd0o+rR845WPAzIYrL3RiMl/6u?=
 =?us-ascii?Q?UWhfj1xSAm/o94JvCINivWnsluj39Qxq/UFG3xNN8Ik05yU3R9J3bMFp/LAM?=
 =?us-ascii?Q?UP5hbtCAhGF3SJE0yr304HOWvjuIqmjvp92cwuiWp1Q+3BpTPB2bjlyvbucT?=
 =?us-ascii?Q?lyfNyfsxQrH9LotsIPQkS4I4RJfCttqxTbsWHJ0/5Sxrij5YiXR8FyharHBP?=
 =?us-ascii?Q?WC4lkob4KC7uBjxmhLp81prfQjcS8mSi3bngHVNj8evLJTJ3bL/is7SR3/HU?=
 =?us-ascii?Q?HVQlRHf4CE+OugrnY0VleQ4kTles7ffbo6T6AvdU5RiKR90i0C1zwg1Ilx44?=
 =?us-ascii?Q?/chhrYf7dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: W6G2axT9y3JAHzSn9uwbOg1/M0URFJMV4q/OH5B9Q+67TBfMidyLORMQw8at0e7sg2MuE5/9eEB7MBdof9Wr9vWBRo7KUFXop45Eyw4NjXHts17xRjiPQRN0HZqEfUCQMPsUhOoxZbXua/tYbZb98KqB4NWbfwE0EMLuaGK0RQDL8yjXuedRFrsfXYMv5ikhY67kVog1VNBOKInIIBSaeUx0PdLAAviVN+75V17ug8vbyOqeafvKXivAkc2wUOaulX19mPkVGESMov//u34twUwkdgAre+yqwFyIZL0P+GmAm/G/91npKNxQN1ahplFE5O3/8EMcLXgcE4a6CpbEPQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFE901A304F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e25601-1136-4a3d-45f5-08df08beb497
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 06:52:07.6268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oz73mdOvnlFmS5Ouhr4/hIONum/QX9iB+CfHZAJzNmyw8KyGmydx/59YqOFNgzOua2l4IV3Av0DcXHTieYs8pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB716723
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

> Subject: [PATCH 01/44] drm/i915/hdmi: Parse frl max link rate from vbt

Nit: * FRL * VBT
>=20
> From: Vandita Kulkarni <vandita.kulkarni@intel.com>
>=20
> Parse the maximum FRL link rate from VBT and store it for use during FRL =
mode
> selection and link training.
>=20

Bspec link here

> Signed-off-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_bios.c     | 53 +++++++++++++++++++
>  drivers/gpu/drm/i915/display/intel_bios.h     |  1 +
>  drivers/gpu/drm/i915/display/intel_vbt_defs.h |  7 +++
>  3 files changed, 61 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_bios.c
> b/drivers/gpu/drm/i915/display/intel_bios.c
> index 97cbae2e547e..6354fa4041dc 100644
> --- a/drivers/gpu/drm/i915/display/intel_bios.c
> +++ b/drivers/gpu/drm/i915/display/intel_bios.c
> @@ -2734,6 +2734,43 @@ static bool is_port_valid(struct intel_display
> *display, enum port port)
>  	return true;
>  }
>=20
> +static int _intel_bios_hdmi_max_frl_rate(const struct
> +intel_bios_encoder_data *devdata) {
> +	struct intel_display *display =3D devdata->display;
> +
> +	if (display->vbt.version >=3D 237 &&
> +	    devdata->child.hdmi_max_frl_rate_valid) {
> +		switch (devdata->child.hdmi_max_frl_rate) {
> +		default:
> +		case HDMI_MAX_FRL_RATE_PLATFORM:
> +			drm_dbg_kms(display->drm,
> +				    "HDMI limited to support only TMDS
> modes\n");
> +			return 0;
> +		case HDMI_MAX_FRL_RATE_3G:
> +			return 3000000;
> +		case HDMI_MAX_FRL_RATE_6G:
> +			return 6000000;
> +		case HDMI_MAX_FRL_RATE_8G:
> +			return 8000000;
> +		case HDMI_MAX_FRL_RATE_10G:
> +			return 10000000;
> +		case HDMI_MAX_FRL_RATE_12G:
> +			return 12000000;
> +		}
> +	}
> +
> +	/*
> +	 * When hdmi_max_frl_rate_valid is 0
> +	 * Don't consider the hdmi_max_frl_rate for
> +	 * limiting the FRL Rates on FRL-capable displays
> +	 */

This comment would make more sense on top of the switch block rather than h=
ere
You don't really check the hdmi max frl rate here


> +	if (display->vbt.version >=3D 237 &&
> +	    display->platform.meteorlake)
> +		return 12000000;
> +
> +	return 0;
> +}
> +
>  static void print_ddi_port(const struct intel_bios_encoder_data *devdata=
)  {
>  	struct intel_display *display =3D devdata->display; @@ -2741,6 +2778,7
> @@ static void print_ddi_port(const struct intel_bios_encoder_data *devda=
ta)
>  	bool is_dvi, is_hdmi, is_dp, is_edp, is_dsi, is_crt, supports_typec_usb=
,
> supports_tbt;
>  	int dp_boost_level, dp_max_link_rate, hdmi_boost_level,
> hdmi_level_shift, max_tmds_clock;
>  	enum port port;
> +	int hdmi_max_frl_rate;
>=20
>  	port =3D intel_bios_encoder_port(devdata);
>  	if (port =3D=3D PORT_NONE)
> @@ -2806,6 +2844,12 @@ static void print_ddi_port(const struct
> intel_bios_encoder_data *devdata)
>  			    "Port %c VBT DP max link rate: %d\n",
>  			    port_name(port), dp_max_link_rate);
>=20
> +	hdmi_max_frl_rate =3D _intel_bios_hdmi_max_frl_rate(devdata);
> +	if (hdmi_max_frl_rate)
> +		drm_dbg_kms(display->drm,
> +			    "VBT HDMI max frl rate for port %c: %d\n",
> +			    port_name(port), hdmi_max_frl_rate);
> +
>  	/*
>  	 * FIXME need to implement support for VBT
>  	 * vswing/preemph tables should this ever trigger.
> @@ -3879,3 +3923,12 @@ void intel_bios_debugfs_register(struct
> intel_display *display)
>  	debugfs_create_file("i915_vbt", 0444, display->drm->debugfs_root,
>  			    display, &intel_bios_vbt_fops);
>  }
> +
> +int intel_bios_hdmi_max_frl_rate(struct intel_encoder *encoder) {
> +	struct intel_display *display =3D to_intel_display(encoder);
> +	const struct intel_bios_encoder_data *devdata;
> +
> +	devdata =3D intel_bios_encoder_data_lookup(display, encoder->port);
> +	return _intel_bios_hdmi_max_frl_rate(devdata);
> +}
> diff --git a/drivers/gpu/drm/i915/display/intel_bios.h
> b/drivers/gpu/drm/i915/display/intel_bios.h
> index 75dff27b4228..53d46c9fa6e1 100644
> --- a/drivers/gpu/drm/i915/display/intel_bios.h
> +++ b/drivers/gpu/drm/i915/display/intel_bios.h
> @@ -102,6 +102,7 @@ int intel_bios_hdmi_max_tmds_clock(const struct
> intel_bios_encoder_data *devdata  void intel_bios_for_each_encoder(struct
> intel_display *display,
>  				 void (*func)(struct intel_display *display,
>  					      const struct
> intel_bios_encoder_data *devdata));
> +int intel_bios_hdmi_max_frl_rate(struct intel_encoder *encoder);
>=20
>  void intel_bios_debugfs_register(struct intel_display *display);
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_vbt_defs.h
> b/drivers/gpu/drm/i915/display/intel_vbt_defs.h
> index 0dc13d080e8a..db7484542dc0 100644
> --- a/drivers/gpu/drm/i915/display/intel_vbt_defs.h
> +++ b/drivers/gpu/drm/i915/display/intel_vbt_defs.h
> @@ -381,6 +381,13 @@ struct bdb_general_features {
>  #define HDMI_MAX_DATA_RATE_340		4			/*
> 249+ */
>  #define HDMI_MAX_DATA_RATE_300		5			/*
> 249+ */
>=20
> +#define HDMI_MAX_FRL_RATE_PLATFORM	0			/* 237
> */
> +#define HDMI_MAX_FRL_RATE_3G		1			/* 237
> */
> +#define HDMI_MAX_FRL_RATE_6G		2			/* 237
> */
> +#define HDMI_MAX_FRL_RATE_8G		3			/* 237
> */
> +#define HDMI_MAX_FRL_RATE_10G		4			/* 237
> */
> +#define HDMI_MAX_FRL_RATE_12G		5			/* 237
> */
> +
>  #define LEGACY_CHILD_DEVICE_CONFIG_SIZE		33
>=20
>  /* DDC Bus DDI Type 155+ */
> --
> 2.50.1

