Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4201ECA9ED2
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 08:44:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3077C10EF3B;
	Mon, 12 Oct 2026 08:44:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C9B510E396;
 Mon, 12 Oct 2026 08:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791794637; x=1823330637;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3yExNK+Xc5d2m1t4r0CKW10i11PyfOWqZFGtBJkkTHs=;
 b=hJ2OXIHhfyww7RefBoLazFXTmBqcQq1xqQ+HLLe4AoW27bcPihFs3Jgi
 gJkQ5eneqpneO5R028PR093U/qULeRtBndCzBLB24pv/NsF9G88ABz3oI
 du5hA15xGIVduJES3j8/ufMlO5lW0Nx5PkF5JHbFPzjAtLQlAUnmfkm39
 TFCSWRQPiI4tKCZw8YLAlhEQ6qWxBOvbpFY9BrveRbY85YqXPkCF8EwhD
 5esrPB9K4lyUuRP/RK3K4wnM3mKylwdVJaA2P9v0FmuuHpPRhiTidVCew
 w+xsCvbwXOT3pyPBP+k9axRk6qsvb34IMzPCyTtMvQHRNLzVlWwtHy/D8 w==;
X-CSE-ConnectionGUID: 21MdgdsuRh+hnoST00Qylw==
X-CSE-MsgGUID: t1rld/3DQXKMAHak5GsEXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="522200"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="522200"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 01:43:56 -0700
X-CSE-ConnectionGUID: DiFOhndRQAi3HL4I6h+UVw==
X-CSE-MsgGUID: A+AF4VkdTKeSFJf5B2sB6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="766226"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 01:43:57 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 01:43:41 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 01:43:41 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.45) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 01:43:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaXJ8l5rto0qDcem+zwRqeXV0/qhebtWE2VlNqSkVnO8pFVqBrkmMz85svq1BucScHZFHO5TVdVBPPF80zY9BQAk4JTFfKq+PCsQaR4F64lVNudyiMyJ2zlb1xwFzqAYkOx9Ce5EWMo2EnrWGm0dGS7jFCO1IVViyVWZ0nHVE6uHs+shc4I26mKuz/rEBQIPctdOebh112rILPMBp8W8qzd9VM4zmPwJ+/df1/pHdIEISzuJb1m7t45POoxnV1+yRdzmLODSk/qdHHaiLjdORkGOjuA2EVsLavWtiwneIeN6ypDuBoh9sgWQktgGFBGwZHDWRkfUp/zsT6GX+Obg0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Db81DFTZ4oGrnj3LbkvpOhqrEkoJaZGfOzf/0/qShRc=;
 b=gph84x7DTjbbD7f2CWX7RXa6JFxBBUtXd0w2+YYva1Kx20zZK+Dd5MZXBy961zuyuyYit8pRyZ2KxLyOAO4DgkqMhv7K/IyXucdffBITGvFSLWidRlj6UAqIOmqd8vKpZIocbtYMHRBNShCUaQK5P+LiK3eusJgF/IIeusloos2NbkhdGywfNgy4YSoSSnGLHNEERJR67hX/3CzsXcN02V8mmjC34cxCJAm6r8p2RNWFjDoLluWw6AuUjN9vTLvngEZ/OtSjzSaMhbDG8zaO7Tv4p7caDsqeLuezo8e8o9a4m4wiVE5+NzTivudKuU04HUaBZcd9gnm28Fv9I7DrpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6360.namprd11.prod.outlook.com (2603:10b6:8:bd::12) by
 DS0PR11MB8232.namprd11.prod.outlook.com (2603:10b6:8:15d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.20; Mon, 12 Oct 2026 08:43:37 +0000
Received: from DM4PR11MB6360.namprd11.prod.outlook.com
 ([fe80::22d9:ae03:5db1:680]) by DM4PR11MB6360.namprd11.prod.outlook.com
 ([fe80::22d9:ae03:5db1:680%6]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 08:43:36 +0000
From: "Shankar, Uma" <uma.shankar@intel.com>
To: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
 "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>, "Kandpal,
 Suraj" <suraj.kandpal@intel.com>
Subject: RE: [PATCH v2 03/56] drm/i915/hdmi: Add FRL link rate cap
Thread-Topic: [PATCH v2 03/56] drm/i915/hdmi: Add FRL link rate cap
Thread-Index: AQHdWgAuTocH/RbMs06U2B51ELutd7b5jqEw
Date: Mon, 12 Oct 2026 08:43:36 +0000
Message-ID: <DM4PR11MB6360464FFAC87E5ED757E240F49F2@DM4PR11MB6360.namprd11.prod.outlook.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-4-ankit.k.nautiyal@intel.com>
In-Reply-To: <20261012035806.3361439-4-ankit.k.nautiyal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6360:EE_|DS0PR11MB8232:EE_
x-ms-office365-filtering-correlation-id: de9a6ca2-4a6f-45d1-d59f-08df283ce836
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|6133799003|22082099003|18002099003|10067099003|261009223027099003|11063799006|4143699003|38070700021|56012099006;
x-microsoft-antispam-message-info: RnQIE5vXFuGyZXe4sk/xeJygHJbUjK1HE8fPLABQMU0pqpcgBJ3A3Wqdgg0AuPsRaIoqhK364DcNrKuObqpDGE/w5wI/KjTYca/D6VzuSapZ6y0ZLMJTx549sfDrsb2rwS9ZSmR7a8+guHIeHQTMWaReset1/xKLxbhx0BIzT1U7T9UA5M6ag+HmI+Y6zDMy7cU1X9sLzZ/A5rARtRpri1tdA3g0olOZL5Nk21dqSBD+Qa5i2CnIDFUUmTy0NN594I7AL8JlrBrShYXid0zeYNvaORNuwBfldknJeet1myMt1fEMTwB5p1On5IZ8rPxkZclebYqPGST8wWIobJjxEhDGFwYzvqmkpmoq3H6gsg7EnDYqtRXazv5qz4wEm9BU+hNBCXZmGSVh78hhWUMfSi4m7f6zzwwh5q5UXK19R7J8VMDYuUUZzsjuuHhvtcdWZxeetWWe8NxhE1JJhnJ+iYe5eeb4bpDC6TCvSj80KO6f1wChAhzbUvwmFY0ofvPY7l7EDAqXdZyPmy8nJ2p2DjF40NOhEru3cY0pazzJlyqJTt6sVlqyoDKjtz9L5FwHDDD3QUVvkz0V6dTPU0MkqjPuGDj41ryoXIUbsMOFxpF6PhgoxhKIHg1B3k94p2HhaQ8/L1IrThKIklQxcE3rGPMH737OFIleajCYDNvNHV6BWaIew4bp6zyRJ5fFEHZAuLVlUYgBNibF0N6Xu0y0DB0pPGWIsO5Oo2EIxmA67ko=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6360.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(4143699003)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GKVsvOSTx1xS0nMaM54SoFsP0tL2Pk5BpfOSHQv6Fl3wvQI6drtRoGiLsFCm?=
 =?us-ascii?Q?TEIqVzn96ik64Rucd31mTW2pWTfayccvHS+fySssx7t7BXZKxmcVxxKvavHT?=
 =?us-ascii?Q?P/7fMBzb//7DhybX9R5y/UK5MsNfbIk+t4swckeNowh6b+00qljw1L4cbABe?=
 =?us-ascii?Q?/iBfk54M7V932EJ98JbAMZD349Sly874h+plZUYzWMgpBh7Z2HjJKa/rhYhU?=
 =?us-ascii?Q?UPTRgJsFaGKRyMBQgxH9p82MqlHkxa9xl+vo6fkKvjPJAx3gQkIlC8s1xC+C?=
 =?us-ascii?Q?1Af6jOnbu+GBCleRrnKhzaDDLhZQKCAwwIEIjXfPRAFzbSvIyoplB4Nrf0sw?=
 =?us-ascii?Q?6YQrHsdIOY3vkk1uMkoPHjpBgcdGpad0DjXE4lWY3oF5p0yLtzk4zp8xhjOf?=
 =?us-ascii?Q?dBfxpbbDRANHd3OT7LbZ6Pe7jlkbE7ndxvpMItLEFjDtx5R0zD8TOmfRxOpC?=
 =?us-ascii?Q?9EUL7Ni18bqU7nC4Yzlm2Eh4QUJ3sS09g4RVzzjcxc0LMq/pCIm3M9VhBaU5?=
 =?us-ascii?Q?pmT7+I5vkoNdbmqICPFSrCnogE2HeJrYPnaN9s87rdIKJzJDjVgCQp+kWwC0?=
 =?us-ascii?Q?mJeQfLlBDdT1dwffPbL/NGolOQFXm8VppJmrEJESA3phEz3mUQ8y1PPxn4aY?=
 =?us-ascii?Q?8WN3n1RqEdNsZnIhopPkNVVXzkxAAtZJPWfQCOkjXTlWakAIv6rRKywT3FpY?=
 =?us-ascii?Q?i6Ur+wiyp3IPsnd2Ri6Td1Dj4RzvJRsaLJ9ERROR3naVHWsokuzKb16OUVRf?=
 =?us-ascii?Q?s5uAHb2f3LmWyo3kRoKOyo+ekysgF0tc/oMWle5NSqGWWTLj4IefE9kwBMSP?=
 =?us-ascii?Q?TI0aETvpUuJOWFbCfMOIjYa5sdVb4OdYd435pCXYSIlZCqQXrqxAatd+cjQO?=
 =?us-ascii?Q?Txtn9M8xSpRIZgPuZSrf8Thj13MdMiZrw2gxEL7doGH8EYSnP7EwflEtWfIm?=
 =?us-ascii?Q?mTjt3/aHf2d85WMJoZ5axeMB/jJP2a3ke9dFHgoOa7EBlLxZ0CsSDntqjv0m?=
 =?us-ascii?Q?B/M9j7Kg8e3Fn50Tsy8E5AY7GE37i+IhEI3bKxaxhRYIz0N1tDhCrjw+MCgZ?=
 =?us-ascii?Q?mX6J0sVkTbxmezXCLMXyWr1nCptwQ395nnx21ISVqzk4oNqe3Lu3Z7kQrA1e?=
 =?us-ascii?Q?FmCNVsJ/quP+RCFkZTq/r2FypvGTIiIzkMZZCopTYPXlEUpMmZm0bhX5/25V?=
 =?us-ascii?Q?8wNPgfOfyrMCvcgIjtyZfCe0l5WfUK0OMKoh5WHTJjOsnahJN+P+726Vgh4b?=
 =?us-ascii?Q?1W+SPPCmXoP12ENqV7cMPQGS4DMj3xBq5IGRTJR19Sd2UNuTW1mm8PSy95Ru?=
 =?us-ascii?Q?j+ljjvdC6QWzI8jmSvmlQ82d13pZIj1aAsTRDRk34drU4RBYszncuq1LEWWu?=
 =?us-ascii?Q?VxBTRjPBBiQ3dslsIA0N1yV84eeks3s5jJwgfB3x4bINBIys4C7Z85mmlFKT?=
 =?us-ascii?Q?7TSx8jvF8LMXiha79y8ha6RGqNKtJC1IebgQg9K0Vxv7mW7rlNcjE7XQTl3t?=
 =?us-ascii?Q?hMy/OuBND6rmwgV70lX3JjXM8Vs2qXnW2QwutpUvs4q6ysIppwXdSHm03LCU?=
 =?us-ascii?Q?ME8nlvLV8EOkNuxw4tuwX3bCQjQ9G2FUTw78iA9LTEcXQVrJ3CkEaSRCe/h7?=
 =?us-ascii?Q?witPDlkPl2oVVKNDbnHAUUfgVtnvKq+xvuQmnQFSfpQRHJfiZxILAd93H0XX?=
 =?us-ascii?Q?22v3qJ18PdU9D645yHNvPR5arNinHeFUkh4FJvxs1MoR0iOu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TOWk7Ld4JEbnzIG3iKvD6rssbpx/R/d8cASkgf3MZDd4u4yQ4RKgag5ayX8nut/T0hQxCwvB9ZVNbJU3fJzyIHs1+GdRTrwG9bgZNB/pf3ZaiHfZ6YLkIPqSiep5s1oZOjF0NkVQ8i0z2T0eYgSrjYkirOLXsRXxKKyRAwbaEqx5zo5k0ecAC/aqHfFfGDokYC2bnJVsc+cjkMChw9RMOBDjwa5qFeRv+tOOdjhbLHbPAcYz7NVauTkdpvgE+Yih3TZeuDup/5qSXWhHclnmJxP8h2VPLj8dnf0mRN7GDmvL79GHw/lJO3vuHugtQehr0gHA984uu9n3XnrL8QsLqg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6360.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de9a6ca2-4a6f-45d1-d59f-08df283ce836
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 08:43:36.8761 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bl5GqvzaZNp5XtBQdp/LVMh7FRjw/ZhDnHjdwY1VqXMzpYk1oGQRmRy9fLeEyWHOyPko1Ge7GHL5/SrzLTehvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8232
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
> Subject: [PATCH v2 03/56] drm/i915/hdmi: Add FRL link rate cap
>=20
> Add a member rate_cap to store the highest FRL rate the link is believed =
to
> sustain. This is initially set based on the source and sink FRL capabilit=
ies, and
> updated only when the capabilities change. To achieve this, the reset is =
gated by a
> reset_rate_cap flag, so that rate_cap is left as is on a plain re-probe.
>=20
> Also reset the rate cap when the status changes to disconnected, so that =
a re-plug
> of the same sink starts again from the full capability.
>=20
> Later during a Link training failure at a specific rate, rate_cap can be =
lowered, and
> since it is retained across a re-probe, the next training attempt will ho=
nor the
> reduced cap. No user for now, this will be used in the later changes.

Change Looks Good to me. With comments in earlier patches fixed this is:
Reviewed-by: Uma Shankar <uma.shankar@intel.com>

> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> ---
>  .../drm/i915/display/intel_display_types.h    |  2 ++
>  drivers/gpu/drm/i915/display/intel_hdmi.c     | 33 ++++++++++++++++---
>  2 files changed, 30 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h
> b/drivers/gpu/drm/i915/display/intel_display_types.h
> index 89333c9ddcc8..8a2128473f4f 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_types.h
> +++ b/drivers/gpu/drm/i915/display/intel_display_types.h
> @@ -1719,6 +1719,8 @@ struct intel_hdmi {
>  		int lanes;
>  		int rate_gbps;
>  		int ffe_level;
> +		int rate_cap;
> +		bool reset_rate_cap;
>  	} frl;
>  };
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c
> b/drivers/gpu/drm/i915/display/intel_hdmi.c
> index 69534eea78a1..5c57f81d971b 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
> @@ -2567,14 +2567,30 @@ intel_hdmi_init_frl_config(struct intel_connector
> *connector)
>  		intel_hdmi_sink_dsc_max_frl_rate(&connector->base);
>  	int max_sink_frl_rate =3D
>  		intel_hdmi_sink_max_frl_rate(&connector->base);
> +	int max_frl_rate, max_dsc_frl_rate;
>=20
>  	intel_hdmi->has_sink_hdmi_21 =3D max_sink_frl_rate > 0;
>=20
> -	intel_hdmi->max_frl_rate =3D min(max_sink_frl_rate,
> -				       max_src_frl_rate);
> +	max_frl_rate =3D min(max_sink_frl_rate, max_src_frl_rate);
>=20
> -	intel_hdmi->max_dsc_frl_rate =3D min(max_sink_dsc_frl_rate,
> -					   max_src_frl_rate);
> +	max_dsc_frl_rate =3D min(max_sink_dsc_frl_rate,
> +			       max_src_frl_rate);
> +	/*
> +	 * Set the FRL rate cap on connect / capability change only.
> +	 * Leaving it untouched on a plain re-probe lets a future
> +	 * training-driven reduction persist across the retry.
> +	 */
> +	if (max_frl_rate !=3D intel_hdmi->max_frl_rate ||
> +	    max_dsc_frl_rate !=3D intel_hdmi->max_dsc_frl_rate)
> +		intel_hdmi->frl.reset_rate_cap =3D true;
> +
> +	intel_hdmi->max_frl_rate =3D max_frl_rate;
> +	intel_hdmi->max_dsc_frl_rate =3D max_dsc_frl_rate;
> +
> +	if (intel_hdmi->frl.reset_rate_cap) {
> +		intel_hdmi->frl.rate_cap =3D max(max_frl_rate, max_dsc_frl_rate);
> +		intel_hdmi->frl.reset_rate_cap =3D false;
> +	}
>=20
>  	intel_hdmi_reset_frl_config(intel_hdmi);
>  }
> @@ -2656,9 +2672,16 @@ intel_hdmi_detect(struct drm_connector *_connector=
,
> bool force)
>  out:
>  	intel_display_power_put(display, POWER_DOMAIN_GMBUS, wakeref);
>=20
> -	if (status !=3D connector_status_connected)
> +	if (status !=3D connector_status_connected) {
>  		cec_notifier_phys_addr_invalidate(intel_hdmi->cec_notifier);
>=20
> +		/*
> +		 * Reset the rate cap so that the next connect re-initializes
> +		 * frl.rate_cap to the capability ceiling.
> +		 */
> +		intel_hdmi->frl.reset_rate_cap =3D true;
> +	}
> +
>  	return status;
>  }
>=20
> --
> 2.50.1

