Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1766BCA9ED2
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 08:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 548C310EF3C;
	Mon, 12 Oct 2026 08:36:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D90410E552;
 Mon, 12 Oct 2026 08:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791794177; x=1823330177;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zFAgz8vulvn7Rlti0qMg21DA82roKkfUI46GL7g3WnA=;
 b=fHWWck9nSOXJsadolMTYDnn8b5HqOkkWx+3AehrsdXBwcrdRsAM0UWxm
 EEtlk/JoWavXD/79ZhIP/txoa47IUk1TLobUx7u5TgUhuKIDmEzORwNH0
 ETJYcbyXWkXUwpaFOqBgcD/LjFek9S6s91BNl/9iODkoQ7cm9V2dJhZke
 l0Ry2CpzJsQH4fHTBMAc4ngt9JthSx3BdFFmnodutQBBDJcJZEeIbCBJs
 CamSTPCXgyMtzB9Gw28KrHKHw9jOL7+I/Eg3xMzDXCrJRSOEJstHDNoQM
 yZG/sPzSpQsHyZ5KXrsEbkTysv0gIHZfSajP+7OtozTJrkmdcdcc+/dex g==;
X-CSE-ConnectionGUID: TxAv+iZZS1Oq484Ihouc5g==
X-CSE-MsgGUID: WTa3uvFORzi0UckQODLGWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="504357"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="504357"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 01:35:55 -0700
X-CSE-ConnectionGUID: xWnuwJijS5Of4D+1QOMx0w==
X-CSE-MsgGUID: 96PGagdZQKWuUTvZAkxK1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1211884"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 01:35:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 01:35:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 01:35:39 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.54) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 01:35:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLzzvvJcT+wbm6tKz5JDT16QmyRrJDSuum58aQD6n6R2BV23Yigp+kBAMbokpDK9ePHSoKgIoXkyw3bD6sSQ4RCMEpf/3ChkB/M++d4A15hevzF/9d1ejj8j0cszTCD5xSsRZdE91tPG5KpzvGSeircUyA0JwQNFg257d/WazFV20tFztDEuwPbw3/fztiSygAbyi8CIfvSD/NnK1sfyC4G1Sl1kbeicU5KFfa4rZy84dnHO7iYu7ozhxrrbwljb+0WE3hpuctaXInIIWkeuEzxGPRiAbwBllNE2pE9l03eK1eMjC8wxVXZIWG6tfgzLL9Y6h94XMIdFzR/IwhsHtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypLlrCJhsko1rXsqpmTTimoH5X0J5xOHXfDcpx2Xzqw=;
 b=X7z7IjPQNd1k8iwmoaQopJU4AeQDeQbs9XdgO/TxMe3sMB9dRoksLNNpNoWYNMwsjih9oMhL1Pw/aBM06MU/FCAUKyjnJm85vUheeV75UZH8Sxs6mfJ9ZyynS7M+NlHijOLkXfMMYH0o14kzHx4RE5G8d5izvwMLvKxYBtnsE3Q4/M5pB7vO1fN+74tdHOZ621yp/Zj3wXhQ2ses0jD2vs6RRrg2DpND8oYTo5bvnp9LCvlbWYUEFLMLfPNRGwY8WieyP3tDkrerxJRqAmDmJDAgmO0w9BLWLmxkGbgWqmf9i+AKYlSGFnJpX5O842apapGUN8l9vR3F4tq5OOHH8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6360.namprd11.prod.outlook.com (2603:10b6:8:bd::12) by
 CH3PR11MB8434.namprd11.prod.outlook.com (2603:10b6:610:176::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Mon, 12 Oct
 2026 08:35:32 +0000
Received: from DM4PR11MB6360.namprd11.prod.outlook.com
 ([fe80::22d9:ae03:5db1:680]) by DM4PR11MB6360.namprd11.prod.outlook.com
 ([fe80::22d9:ae03:5db1:680%6]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 08:35:32 +0000
From: "Shankar, Uma" <uma.shankar@intel.com>
To: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
 "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>, "Kandpal,
 Suraj" <suraj.kandpal@intel.com>
Subject: RE: [PATCH v2 02/56] drm/i915/hdmi: Add new data members for FRL
 configuration
Thread-Topic: [PATCH v2 02/56] drm/i915/hdmi: Add new data members for FRL
 configuration
Thread-Index: AQHdWgAu8w0emGJOZkCTBIAw95yIpLb5kcWw
Date: Mon, 12 Oct 2026 08:35:32 +0000
Message-ID: <DM4PR11MB636024DEF233CC9B1382E3C6F49F2@DM4PR11MB6360.namprd11.prod.outlook.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-3-ankit.k.nautiyal@intel.com>
In-Reply-To: <20261012035806.3361439-3-ankit.k.nautiyal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6360:EE_|CH3PR11MB8434:EE_
x-ms-office365-filtering-correlation-id: b92a15bd-e918-46a0-0b29-08df283bc74d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|6133799003|18002099003|22082099003|10067099003|261009223027099003|4143699003|38070700021|11063799006|5023799004|56012099006;
x-microsoft-antispam-message-info: LV5ADc+Z5fTMYZUmnqSWd/RRizu3svRsIjUXvQtqauOEH1qhzzWH/DwT06PMx4fVoVHIkHSe1dV6tYNNqY1aMxXyr4yTZkH+uT30oaxJvwerTnA1B+ykxxmD17mvqCOIAY0LkmUIHF73GfeXfaSVzzW3kIQp+JDLJIe59i1z78ttKCl4BLb8HRfKdyFSYOWBA9pCXDRBQd166/a4AkeRC7EB86Yw6GUcJ8H1z1mg3Ujl0pnYvrNymd8SVD3ij/o1vnMwG3g5VydXi05E6e1rBDvyeBx4UH8qkK9Q91z73Ba+D2pT5o3GSUZkp4z1zDLLKTfTxTzovRH3uI9PSIN6NPlQKodf78t2r19gmoGRGTxGwEIAT1YZkdoT0Jh4dHCcFYtLOWX+5zIcmGzxhkH6KO09CBDdryPKnCKB3q/Rom6Oqz0uksXBpyPi2ca6dAgJqy/Zk1YDPd0YgVidXwKJDoIo/902NGK7086q3hbe20SOvu0r0OIealKGjgrS8LevmKWP8BjC0lveygl8RDKEiwbpWGtKvZZzYZo0VTsTT2wC4293ErlBzykiPXaABjVJJUnqnp4F5qBTbYxc1ASkwteGhtzuELVWTRgeh69GqZPmnk1Ft0v/b2+qMD6EaWFmuAK5j2owkzXgRYbxg9OPi+tjlFtLeVKxXdLAjYqn2OGEcUJOL9kWO3W6GjX7+OrbPb3AlB9/0CTlonJS8K5Eecbq8H0DXBZUnus7xg7e8/Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6360.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(261009223027099003)(4143699003)(38070700021)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MD1KnNAhtFFG7S1Eu4auBVzfuqwIpVDM4XPVTfAPkHNVAcQsD1Mcm8Emh/qx?=
 =?us-ascii?Q?MqfnW4QKGXWiiZuZKS+FgVuSdjuf8v3qYZkzmoEJ1txHT3zxrqdxPhNJ+DD0?=
 =?us-ascii?Q?SiS1mO4oP3TuOUwuFaXeR+UPIhm6mjcjJEbiX9JdnsMUz95xrItV2kf35keQ?=
 =?us-ascii?Q?JumWUoUmPws1Nj5TwMYvWV10/YjKeHTrXjbyB6nTd82lH5abyHap4KNYj14M?=
 =?us-ascii?Q?mmVMIo4q9vhVZAVTBti8yV1nozOqFn+HV2Y5pSg6fJ5HWGJlZlwx3UTSw56b?=
 =?us-ascii?Q?Tgx3YcIoXi9wsvjIwUctBnwH+v6hP4bs5UUnsW4cmYZrX8mpiEjX5O+zv6c/?=
 =?us-ascii?Q?LyqWwtWRKtYKQvT/6zFDgZf4qBsY4ianWDeBaQ9EWYvY2eeJhaHsLRTEdZ1l?=
 =?us-ascii?Q?QWKB+qJZzRVd+3N9ZPnI2lBqETZdLIsaKhOdl4DIQEjFds5Q73b3P7LUmoDK?=
 =?us-ascii?Q?JnlcPKKVvCPlTCC9DO04DIdRPc4o9NJvxBTP0ramtfeSWah4hXI41xMGbGCl?=
 =?us-ascii?Q?gshOqCHNGIX8pA9Ej1T6xiDv5Jh05a/UMV61pqmbnRF5wmB8VOnxP1kjoIBC?=
 =?us-ascii?Q?6wfDpNgepqycNdCNWrcEaGU1exA9thEC+UQzMU9v2xOOgGw2mMbt8aTsfVtC?=
 =?us-ascii?Q?whv3MrinpmIf7IC2GuFoFkhm6rF9ZKqThtSwJXEC57phnp8UxlNn5cvHqksb?=
 =?us-ascii?Q?hSbLY5nAUSR2GUvyvUUN19PiTPmMUuceNDThC8aVE7r/06UvFewTyNdIHFRe?=
 =?us-ascii?Q?IkKlmU4RBnYwVFeNiKbN5RBHYt9guHIzt9PAdhHx9w7rMp6ModEyDkoB1P7r?=
 =?us-ascii?Q?4l76l0uBgnafT7TqeFf0HNAG9crc5OF6KE65vzuGnYdNqQY0Qoup334m3HLJ?=
 =?us-ascii?Q?2YahurYtETLSxWHXOypeNDxzHQGJqV5g8Smbec2UjNlGrNNOJEoZqEp0YE5Y?=
 =?us-ascii?Q?gyOIa/w6Mxq6ouN6z4k5EOJQwMEFD6eYdZoUvoLg9DroOPjVVD9Lliow3X3e?=
 =?us-ascii?Q?agrjew08hpy28/SLAM5/jttFrIWlcLkebI+C7zjhL5erXi+UIjsWaBwpZ0g5?=
 =?us-ascii?Q?LMWzsPSvhX5VlqVz3fUwtEJ7myPAXDV/yHIiQsHJnoVeaCTYrFpaPYLCtIJH?=
 =?us-ascii?Q?xxw3dikzfCTp8gCeGT693Hc+eSt2OrC6c5Jw+wC3tS3BZmiXPvvNAK2Oqxn6?=
 =?us-ascii?Q?Odq25RFLs55VmAtT4k8qZCUaHI6AETODObaicpi7hndrvh8fU5ugmfpmZnPR?=
 =?us-ascii?Q?Oe4esAb01zQKX1Ih9gloQQ+aZ/jlAmM892gt/daGY9r9AM68Gf9o65Gay93X?=
 =?us-ascii?Q?UqavH38kXFN1TsoyDVuiyWbkpcm36cg/veb0S1EfO0jjSryJt5WB9wHQ3Fa7?=
 =?us-ascii?Q?j8QLBM0Wk3opHDkLijpwW4nVgavsaL7pdOrRDxW+FVEzRvwKsfSyVn89fxlW?=
 =?us-ascii?Q?t2/k4gJslWsyr4R5fo+V0f50gUghGC8wvAeqh/Sxh5Ru7NoVuqCpa+WUaxq/?=
 =?us-ascii?Q?TtFcfumoPv+4XT0cjos/lDBRMR3/4TpDjwPbDXR6AVIqjHhLGK8plUmqsE46?=
 =?us-ascii?Q?sOAj4qFhFq5TEgAw8RL6jXSIeWUIUwXCQJSwjvXKiKQ0GdaH/WF//w6T44jy?=
 =?us-ascii?Q?uBvI6ZsHHG3fife0whC1CXSF6OfgrJyV1MVhDIypuBxnfhX3Ix3Rje5D+dBC?=
 =?us-ascii?Q?4qYHshqTXWYxe2GoMlix8d+U8pyQ8vFLg08qKK4Pr+UEtB2W?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: zpc6Bxokf49oLG8X9T+/mmrcVwpp8yAAl6WmLvnwzeGkPONcSOO+KPFdlJ52lTNBoDKFB7tu5ey8A6TXl6MUZ8lQfErUXl8zi928lzvQs8fR4cUIpRJygVUs4FOLJKH7UPPVlckQFGbJdW5vkPtR/tqdWtI87EDAlvnaXj2JTMFjW8rkFZCLfIt6tpSI9AYRcGui8X5h4WumscxtbsPLdKK/4HY9Mi4kQaB6EFnm1LpIx8FTzB9Bn2C8QQ1a63fq9vskzcRaM8ZVB+laVrdaYQMw5MuSvT+702KYfV/o0I/pZCd306HhU/Sn9OUHD+CD2UbTps0X1F299mG8HGZtCg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6360.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b92a15bd-e918-46a0-0b29-08df283bc74d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 08:35:32.1168 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bNaApmPBH7D8XO5BdxXKfb6XVOwgvp4u40UNXZPbbWrHLKsNM21CJRl6GWMxPPtG4sQsT5tAF+NMS7HSDn+VKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8434
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
> From: Nautiyal, Ankit K <ankit.k.nautiyal@intel.com>
> Sent: Monday, October 12, 2026 9:27 AM
> To: intel-gfx@lists.freedesktop.org; intel-xe@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org; jani.nikula@linux.intel.com; Shankar=
, Uma
> <uma.shankar@intel.com>; ville.syrjala@linux.intel.com; Kandpal, Suraj
> <suraj.kandpal@intel.com>
> Subject: [PATCH v2 02/56] drm/i915/hdmi: Add new data members for FRL
> configuration
>=20
> HDMI supports higher resolutions using Fixed Rate Link.
> Source needs to do FRL link training on the 4 lanes before video stream
> transmission.
>=20
> Add the members to crtc_state and intel_hdmi for identifying the FRL supp=
orting
> HDMI sink and to maintain the FRL training information after successful t=
raining.

Seems only intel_hdmi is touched here, drop crtc_state from comment.

>=20
> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> ---
>  .../drm/i915/display/intel_display_types.h    |  9 +++++
>  drivers/gpu/drm/i915/display/intel_hdmi.c     | 36 +++++++++++++++++++
>  2 files changed, 45 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h
> b/drivers/gpu/drm/i915/display/intel_display_types.h
> index 79f30660c2b6..89333c9ddcc8 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_types.h
> +++ b/drivers/gpu/drm/i915/display/intel_display_types.h
> @@ -1709,8 +1709,17 @@ struct intel_hdmi {
>  		enum drm_dp_dual_mode_type type;
>  		int max_tmds_clock;
>  	} dp_dual_mode;
> +	bool has_sink_hdmi_21;
> +	int max_frl_rate;
> +	int max_dsc_frl_rate;
>  	struct intel_connector *attached_connector;
>  	struct cec_notifier *cec_notifier;
> +	struct {
> +		bool trained;
> +		int lanes;
> +		int rate_gbps;
> +		int ffe_level;
> +	} frl;
>  };
>=20
>  struct intel_dp_mst_encoder;
> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c
> b/drivers/gpu/drm/i915/display/intel_hdmi.c
> index b6fa1a1558b8..69534eea78a1 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
> @@ -2485,6 +2485,8 @@ intel_hdmi_unset_edid(struct drm_connector
> *_connector)
>  	struct intel_connector *connector =3D to_intel_connector(_connector);
>  	struct intel_hdmi *intel_hdmi =3D intel_attached_hdmi(connector);
>=20
> +	intel_hdmi->has_sink_hdmi_21 =3D false;

but max_frl_rate, max_dsc_frl_rate, and the frl.* training state are left b=
ehind. On unplug,
these carry stale values from the previous sink. unset_edid should also zer=
o
max_frl_rate/max_dsc_frl_rate and call intel_hdmi_reset_frl_config()

> +
>  	intel_hdmi->dp_dual_mode.type =3D DRM_DP_DUAL_MODE_NONE;
>  	intel_hdmi->dp_dual_mode.max_tmds_clock =3D 0;
>=20
> @@ -2545,6 +2547,38 @@ intel_hdmi_dp_dual_mode_detect(struct
> drm_connector *_connector)
>  	}
>  }
>=20
> +static void
> +intel_hdmi_reset_frl_config(struct intel_hdmi *intel_hdmi) {
> +	intel_hdmi->frl.trained =3D false;
> +	intel_hdmi->frl.lanes =3D 0;
> +	intel_hdmi->frl.rate_gbps =3D 0;
> +	intel_hdmi->frl.ffe_level =3D 0;
> +}
> +
> +static void
> +intel_hdmi_init_frl_config(struct intel_connector *connector) {
> +	struct intel_hdmi *intel_hdmi =3D intel_attached_hdmi(connector);
> +	struct intel_encoder *encoder =3D &hdmi_to_dig_port(intel_hdmi)->base;
> +	int max_src_frl_rate =3D
> +		DIV_ROUND_UP(intel_bios_hdmi_max_frl_rate(encoder-
> >devdata), 1000000) * 4;

We should maybe check the validity of encoder->devdata before going further=
.
Also define a MACRO for the magic number. For 4 as well you can use MAX_FRL=
_LANES.

> +	int max_sink_dsc_frl_rate =3D
> +		intel_hdmi_sink_dsc_max_frl_rate(&connector->base);
> +	int max_sink_frl_rate =3D
> +		intel_hdmi_sink_max_frl_rate(&connector->base);
> +
> +	intel_hdmi->has_sink_hdmi_21 =3D max_sink_frl_rate > 0;
> +
> +	intel_hdmi->max_frl_rate =3D min(max_sink_frl_rate,
> +				       max_src_frl_rate);

Per the previous patch, intel_bios_hdmi_max_frl_rate() returns 0 to mean "n=
o VBT limit / use platform default".
Here src =3D=3D 0 makes max_src_frl_rate =3D=3D 0, and min(sink, 0) =3D=3D =
0 - so FRL is fully disabled even when
the sink supports it. Only MTL escapes this, every very other FRL-capable p=
latform collapses to 0. Clamp only
when source value is non-zero (e.g. if (max_src_frl_rate) rate =3D min(rate=
, max_src_frl_rate)), same for max_dsc_frl_rate.

> +
> +	intel_hdmi->max_dsc_frl_rate =3D min(max_sink_dsc_frl_rate,
> +					   max_src_frl_rate);
> +
> +	intel_hdmi_reset_frl_config(intel_hdmi);
> +}
> +
>  static bool
>  intel_hdmi_set_edid(struct drm_connector *_connector)  { @@ -2576,6 +261=
0,8
> @@ intel_hdmi_set_edid(struct drm_connector *_connector)
>  	if (drm_edid_is_digital(drm_edid)) {
>  		intel_hdmi_dp_dual_mode_detect(&connector->base);
>=20
> +		intel_hdmi_init_frl_config(connector);
> +
>  		connected =3D true;
>  	}
>=20
> --
> 2.50.1

