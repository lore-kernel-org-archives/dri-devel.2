Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3C7C61DD7
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 13:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C41C10E4AE;
	Fri, 28 Aug 2026 13:40:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="G6QLc8bf";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1968310E4AE;
 Fri, 28 Aug 2026 13:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787924450; x=1819460450;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HY5C9iCkaXGiPN6HFcVw65INHVpxVoKY7a+WASuPuF0=;
 b=G6QLc8bfI2yDemkbiVEIEwyYgYdxaQlmzyyxQnswBiHCueDfJ8B92T+x
 yIy++tWYO4NoFLtYfCRisilBI8GXdw3m1+azFKr13SFwX573V6MsUd62v
 foAKamc+GZXo2RBUjWNEjyX1uf0RsfFdLCIdna9rMuZ7//l/NvI2FOW/y
 2ESU7xXjRHCzhJ1JLBcxGTVvQVGogJeRGWJcDC5B+YqSgIQp0FgbDFrDg
 MQZErsRygrCDG+HRSn84H1rkUmOgHXAVo2Evfo3rCMAnS6Q3WIv8aks7a
 j645sWnOliCgrkkMaGC7GBHJC4gCTYcPu0EutC4nnrhTdU0ah0f0bjTFk Q==;
X-CSE-ConnectionGUID: XgSJ+Ou1RginjXr8p0ClnQ==
X-CSE-MsgGUID: b01fU1WJSJKlOZHjVGqWng==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="92298512"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="92298512"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 06:40:49 -0700
X-CSE-ConnectionGUID: 3kG990UuTqGyo01GxWJKlg==
X-CSE-MsgGUID: yhSDIzaUSOqJUEGCFiVX+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="264404139"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 06:40:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 06:40:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 06:40:48 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.67) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 06:40:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJMPUD9750GcWh3LmyRB4RFS7vsjwiJIotrCdmQs1yptQ9sAqI9nXEyuT0fhZSaNzZNgzUbI4n/LhC654kBL/odxBq4a/BEq7wLCTOQ8OiEnskTJUOQaSn9IFrOMIzUkIinGHWXQJJBbjcrpolAhM5EGA6dDY/XoNvB19VHPq06j7XkeBAuaYukl3KRkGBHtaUUhWVO6CQtm5Gc855Af+uAU1Ylbp/IoFklUJFi+NYxNyMUV4JLNDHf1MR0HFYO93Esybn6MDf4LZHbcp+PWKQmAKfPV2urtmQJkabt4ZWrt1mNAN1cQePzyfWX++j5PqDcPld207TE0HWLdgvjGIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpgXSWq3AaSTwfIuDoOIYTQMNbCSAMXlVXo19j9btBQ=;
 b=YkQLN1/tAZTZjdwHl0m8AzdSBGmexPA32W6Gq8OrXOBAe4IP2Mterdf/B6OOlSgUHqFdin6ZTzJdAQlx6mb3wbOSnUbK13rEpIu1/ZgLQoZsBFEHqtIIcc/UAXhsVA2MdieSuAvX+8Ld73xnC2a/o51+pyu6jn1ky+SldhS8Yg/7xh+uHRwfTTDJvSQcJc4uGfctxpXYafUEMJ6G7Si+fa2HOKW5Zi/+EWCnficbmwnwVO8Anv9KJ5hAWe6HlRdnMjdvoujFfOAQNMI4RtwngMwAaBhGXeJ08RUvQdd4tt5QdxybR+TDa1xXamvQPYlne43PSfCHhsZVwhUT8omqjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PHXPR11MB9686.namprd11.prod.outlook.com (2603:10b6:510:3ca::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 13:40:38 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 13:40:38 +0000
From: "Ranjan, Joshua Santhosh" <joshua.santosh.ranjan@intel.com>
To: "Jadav, Raag" <raag.jadav@intel.com>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "simona.vetter@ffwll.ch" <simona.vetter@ffwll.ch>, "airlied@gmail.com"
 <airlied@gmail.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "lijo.lazar@amd.com" <lijo.lazar@amd.com>, "Hawking.Zhang@amd.com"
 <Hawking.Zhang@amd.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
 <edumazet@google.com>, "dev@lankhorst.se" <dev@lankhorst.se>,
 "zachary.mckevitt@oss.qualcomm.com" <zachary.mckevitt@oss.qualcomm.com>,
 "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "Tauro, Riana"
 <riana.tauro@intel.com>, "Wajdeczko, Michal" <michal.wajdeczko@intel.com>,
 "Roper, Matthew D" <matthew.d.roper@intel.com>, "Koujalagi, Mallesh"
 <mallesh.koujalagi@intel.com>
Subject: RE: [PATCH v6 2/5] drm/ras: Introduce error threshold
Thread-Topic: [PATCH v6 2/5] drm/ras: Introduce error threshold
Thread-Index: AQHdLxkfnmS1yYObwUuc5Yr7WLzxGLaxT/8w
Date: Fri, 28 Aug 2026 13:40:38 +0000
Message-ID: <IA1PR11MB7198552DE8DCE89CBE804A05A1AC2@IA1PR11MB7198.namprd11.prod.outlook.com>
References: <20260818135304.497098-1-raag.jadav@intel.com>
 <20260818135304.497098-3-raag.jadav@intel.com>
In-Reply-To: <20260818135304.497098-3-raag.jadav@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7198:EE_|PHXPR11MB9686:EE_
x-ms-office365-filtering-correlation-id: 60057b76-06e4-49b7-d77c-08df0509f225
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|3023799007|18002099003|22082099003|38070700021|4143699003|6133799003|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: E0nN7At7w2Cw4MU2dS767Ge+DjE8k8dT1z1nPJr9keyBZ0WyMQ2ej/mSYGNz7HISnRWMOmmBzIPFAi1hHdg1L4lz4K56XJ0IYf0oV0NGlSb2/EL98P1yTy1n8o5BweLn5PRSG8fwQr9LQ+NiVwJLVUZHjrP6dQyOCusTWnKsUvBIk+4rdez1daeAbozIkw0tRtE2wP1VUNCUcN5c39PrGneHTZCJ5rHgGo94FfBN179hqJyL3GnL9xuBVYlxLfLTBsX9yr3cIC8NyVnSxmdjz8VuAZu9vLOT3i3f3WXZs7Rhcke8VKe/jU5B3Vx4VA071H6jW8rO0Xru5OPp4qUUM82bKISatu1g1oMxhpvcmIB5bCSZez2bPlq44uEInlxSSYuYplb/CQlrRKQa9ntF8xmxisL89u3HpssxI+liNaXd/TuKMz6pK2uLZ1Whs7UQZHtgAxBqK0mtJ89hmTe3kxJe1uP6RyWwCZbyMybz64cPDjDAHfZd4TMLT594KuOM0miNTg2feVVOs6ZsLuuANaH+A+6ygB3gXsaSGFOPk7/sjs/ZeCvapWHghT3qoM18uUbmz+LXd+XnJk+HKmuD5ZfyJrOMYy/SZKVk+uHOhjS81PsUDc/mbES88jF3YrYPnNd8VEsmwi1/aaaELSQiSiKPagnkftSoii/q+QZM1zEIU7ByCtMNHzEOYHnBI/SeNM6avV1/By671UI14Wx1Rs47YdJNmgLRFxssgke+p2c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB7198.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(3023799007)(18002099003)(22082099003)(38070700021)(4143699003)(6133799003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?55NiWBAyo0CUTQh6YEQ4KOI58O0NdnScBUUMHR46GtJ5RhDV1XhCIAD3DNIu?=
 =?us-ascii?Q?qWLebQ2WolQP1Yb4ZzXKfuVkflYgeF4zKmq5TVyPHgzmPZ3YOPJM/tM2UYdG?=
 =?us-ascii?Q?if1oVudDRqXRNffsaSiahKt5mjqwZq3NU+jYcsg+aDSPShx24+J0epd45Nai?=
 =?us-ascii?Q?5qYn28sQF7dZasvyQS7XiPZZ9SajPac3jt7UYmLqy/Z3mWSkWNQtOKU10QQB?=
 =?us-ascii?Q?2KdcsIoIBDSwWKD9C5TaWf8t7W3+cg2TqmQhfFTw7wUqmeo4Xp7Tg9fWz3/6?=
 =?us-ascii?Q?eDWV1FTKMaa9kwqpQz/iQ1iY41eOhloLJcXk0hneJmU/4oFrKdKB1hekuycN?=
 =?us-ascii?Q?jykOuz8VpbULMYYcY4s4Z/6LjVuWw3TdrnSCpgzyTD4C5v5XZ8mGYccQNARR?=
 =?us-ascii?Q?aOxSLpxkH/vymz2UFfJfafYJoO9BIVPCao3mzhNdllXVtKuxLVwswEvPRK4q?=
 =?us-ascii?Q?BFVlRNEEbq00JD7P5e8H7fWATYcniE/5VFuHPKyskLS9s5zhLIENGgFM8SCF?=
 =?us-ascii?Q?5I8bPvreBMTgifoC+Gl55ywPTIpdXRqW9KTKzF5bo2E+AXzbUZtBn1zbjwAG?=
 =?us-ascii?Q?c3K6gOGeS0dOC6eDnUVWJg8rkYjKUIlzeln5Dmbmlk4M/CCxAu+DvGt7ksg0?=
 =?us-ascii?Q?oTbDwZVWcJLyhOfjv8T9uMS9A4654U+6r678buF6AcTUBO0ZObCuEvApOiuB?=
 =?us-ascii?Q?T+ijKgEN9sEVL8vlQbFaEIiT56PaUoiqCmAeziQlwH2EwlFdlA/iel3pYCF+?=
 =?us-ascii?Q?e+rFyA/qWZFXXijOwBu+I16auiCSYian4DLlcRZjMhzxVq5t04z61+iRAcKu?=
 =?us-ascii?Q?KIFeOyCMl36mSjp+XpHooAN4SCVIJjjpepNIfUY0vrYa/zd7KQCMb7b5KKg7?=
 =?us-ascii?Q?3Yiaxn+C8mjw0hKV45BiN8LLdf7sx++ee9jV5VozaHEvWtzlD+Xa3gnnMBJK?=
 =?us-ascii?Q?rC5iVjejHkBz7hTmUNOky8hgv3wRVeMi1Mvdr1d0ROZJSYBeTXFgNTlMlXit?=
 =?us-ascii?Q?gIoeuG/Vpz23+hPQQiwJaqnr2f2aEsY8ias16F2tfdYqbNP4NeknVEsvxeTb?=
 =?us-ascii?Q?zHGsFosX5oY5pdxvzElNjZa6/wf+A6axxwxYaqsiMYi6wsWch/OO/DuwZErd?=
 =?us-ascii?Q?sySxhVGuNG1D0t1X/aIeARWkPCsl75fma1VUn4iCAzCx78BTxGbrFFHD7jpo?=
 =?us-ascii?Q?65k0aDdVHTCRilFkrC0ZJrXe7ae5qx/CLiMyT6FWbOrIiyxmogmO2Xu2h6uq?=
 =?us-ascii?Q?QtI4LMbNO0KwCyaLivTtYO7CiqoDvs8tvRCyCV5Uv1LXLLm+B4Qi4dp174zD?=
 =?us-ascii?Q?xPUVmdPCI8c2wOQ8o/RQk8grh3hf4IZEK7viqlQLjmZtM6ZSQzli77oSg8fX?=
 =?us-ascii?Q?ouznZku8uwNoB/1SsvUXiZW0/inDgJhwbbBlWD/YhCa7pgynJB/0RciSm+2c?=
 =?us-ascii?Q?uMw9FLa9pvpllYC7IFEaN2SP1QSysWdxLkfjlJ1MgJSHxpCE8iS2964qYcro?=
 =?us-ascii?Q?Ekow/5RgIh+WPi0sj/YVTzGM2ceGZDq3U/ifAHgD0/TfJvcU2IiebeJItOcG?=
 =?us-ascii?Q?Hq1Cz1ixMb34SLIlpbVAgpz900BExm2i4cFQgBUTw69fENncYMf+vMS5xXIL?=
 =?us-ascii?Q?o1ZC43c+QiQ8luGLwx4WOr7ZbUv6N/acGuomhW6GLFgYAliT5AVxnZNLs92A?=
 =?us-ascii?Q?HeAwqlOdDnjk0EGy7A33JS7MEVn6xNL3QeVqCuUMxGrW3SJB5Kx8QDn8XnJz?=
 =?us-ascii?Q?TVbaMNA0C/TuBOFajZapcpIB2m77zQA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aeFNkEoafPqaBVj1RpMHSzJMu2pfeNlirh6FsBQUOHtllhgNwGOyx9kIKWUO9Sf+RERcPZxvXt/MKeg7DyMF7w8QN9Iu980joHd2/9VEMegXoQlMtfutCAtw/EpGpw98u/Arvegx+JPrnphYuA2uaS446NEyCN/kt8X39a9AvfvOSSllaF42Kj7twZmGFy3jkC6+bAW6M+at9smwQFQXdo3/i6eCEA4SN70zYCxwNIakZuuv/ekBVCv3464+3YQputhBAIqd/3eTwkutFuV+YN8i4SBvoM6q16TBGeC/1buDmOYCpRI9uijzFfSp3raY3RP5io/QfR36iXb602d5Jw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60057b76-06e4-49b7-d77c-08df0509f225
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 13:40:38.5174 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mQqFVEhDH6h8fSyLRP43MP9d1BeBpoiFqqdi0x0u8gkrnyTFr+cd98xLLWFV5g6me7J0dcnEiE12vPWNVD/hKaqsmezgQp4L11PG458EwpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR11MB9686
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

> Add get-error-threshold and set-error-threshold command support which all=
ows querying/setting error threshold of the counter. Threshold in RAS conte=
xt means the number of errors the hardware is expected to accumulate before=
 it raises them to software. This is to have a fine grained control over er=
ror notifications that are raised by the hardware.
>=20
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> Reviewed-by: Riana Tauro <riana.tauro@intel.com>

Hi Raag,

The userspace consumer for this threshold UAPI is available here:

https://github.com/intel/compute-runtime/pull/978/

This has been validated with the Xe KMD.

Acked-by: Joshua Santhosh Ranjan <joshua.santosh.ranjan@intel.com>

> ---
> v2: Document threshold definition (Riana)
>     Return -EOPNOTSUPP on threshold callbacks absence (Riana)
>     Cancel and free genlmsg on failure (Riana)
>     Document threshold bounds checking responsibility (Riana)
> v3: Move documentation from yaml to rst file (Riana)
>     s/value/threshold (Riana)
>     Use goto for error handling (Riana)
> v4: Clarify 0 threshold expectations (Riana)
>     Drop redundant wrapping (Riana)
> v5: Drop redundant documentation (Riana)
>     Aesthetic adjustment (Riana)
> ---
>  Documentation/gpu/drm-ras.rst            |  18 +++
>  Documentation/netlink/specs/drm_ras.yaml |  32 +++++
>  drivers/gpu/drm/drm_ras.c                | 158 +++++++++++++++++++++++
>  drivers/gpu/drm/drm_ras_nl.c             |  27 ++++
>  drivers/gpu/drm/drm_ras_nl.h             |   4 +
>  include/drm/drm_ras.h                    |  29 +++++
>  include/uapi/drm/drm_ras.h               |   3 +
>  7 files changed, 271 insertions(+)
>=20
> diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rs=
t index 406e4c49bac1..c4ce24067d4b 100644
> --- a/Documentation/gpu/drm-ras.rst
> +++ b/Documentation/gpu/drm-ras.rst
> @@ -57,6 +57,10 @@ User space tools can:
>  * Clear specific error counters with the ``clear-error-counter`` command=
, using both
>    ``node-id`` and ``error-id`` as parameters.
>  * Subscribe to the ``error-report`` multicast group to receive ``error-e=
vent``.
> +* Query specific error counter threshold with the=20
> +``get-error-threshold`` command, using both
> +  ``node-id`` and ``error-id`` as parameters.
> +* Set specific error counter threshold with the ``set-error-threshold``=
=20
> +command, using
> +  ``node-id``, ``error-id`` and ``error-threshold`` as parameters.
> =20
>  YAML-based Interface
>  --------------------
> @@ -132,3 +136,17 @@ Example: Subscribe to ``error-report`` multicast gro=
up
>              "error-value": 1
>          }
>      }
> +
> +Example: Query error threshold of a given counter
> +
> +.. code-block:: bash
> +
> +    sudo ynl --family drm_ras --do get-error-threshold --json '{"node-id=
":0, "error-id":1}'
> +    {'error-id': 1, 'error-name': 'error_name1', 'error-threshold': 16}
> +
> +Example: Set error threshold of a given counter
> +
> +.. code-block:: bash
> +
> +    sudo ynl --family drm_ras --do set-error-threshold --json '{"node-id=
":0, "error-id":1, "error-threshold":8}'
> +    None
> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/net=
link/specs/drm_ras.yaml
> index 8aed3d4515e5..4c2ac9a1ba3f 100644
> --- a/Documentation/netlink/specs/drm_ras.yaml
> +++ b/Documentation/netlink/specs/drm_ras.yaml
> @@ -69,6 +69,10 @@ attribute-sets:
>          name: error-value
>          type: u32
>          doc: Current value of the requested error counter.
> +      -
> +        name: error-threshold
> +        type: u32
> +        doc: Error threshold of the counter.
>    -
>      name: error-event-attrs
>      attributes:
> @@ -167,6 +171,34 @@ operations:
>            - error-id
>            - error-name
>            - error-value
> +    -
> +      name: get-error-threshold
> +      doc: >-
> +           Retrieve error threshold of a given counter.
> +           The response includes the id, the name, and current threshold
> +           of the counter.
> +      attribute-set: error-counter-attrs
> +      flags: [admin-perm]
> +      do:
> +        request:
> +          attributes: *id-attrs
> +        reply:
> +          attributes:
> +            - error-id
> +            - error-name
> +            - error-threshold
> +    -
> +      name: set-error-threshold
> +      doc: >-
> +           Set error threshold of a given counter.
> +      attribute-set: error-counter-attrs
> +      flags: [admin-perm]
> +      do:
> +        request:
> +          attributes:
> +            - node-id
> +            - error-id
> +            - error-threshold
> =20
>  mcast-groups:
>    list:
> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c index =
4fa1a257b0ed..b099eb67836e 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -46,6 +46,13 @@
>   * 5. ERROR_EVENT: Report an error event to userspace. The event contain=
s device, node
>   *    and error information that triggered the event.
>   *
> + * 6. GET_ERROR_THRESHOLD: Query error threshold of a given counter.
> + *    Userspace must provide Node ID and Error ID.
> + *    Returns the error threshold of a specific counter.
> + *
> + * 7. SET_ERROR_THRESHOLD: Set error threshold of a given counter.
> + *    Userspace must provide Node ID, Error ID and threshold to be set.
> + *
>   * Node registration:
>   *
>   * - drm_ras_node_register(): Registers a new node and assigns @@ -66,6 =
+73,13 @@
>   *     + The error counters in the driver doesn't need to be contiguous,=
 but the
>   *       driver must return -ENOENT to the query_error_counter as an ind=
ication
>   *       that the ID should be skipped and not listed in the netlink API=
.
> + *     + The driver can optionally implement query_error_threshold() and
> + *       set_error_threshold() callbacks to facilitate getting/setting e=
rror
> + *       threshold of the counter. Threshold in RAS context means the nu=
mber of
> + *       errors the hardware is expected to accumulate before it raises =
them to
> + *       software. This is to have a fine grained control over error not=
ifications
> + *       that are raised by the hardware.
> + *     + The driver is responsible for error threshold bounds checking.
>   *
>   * Netlink handlers:
>   *
> @@ -77,6 +91,10 @@
>   *   operation, fetching a counter value from a specific node.
>   * - drm_ras_nl_clear_error_counter_doit(): Implements the CLEAR_ERROR_C=
OUNTER doit
>   *   operation, clearing a counter value from a specific node.
> + * - drm_ras_nl_get_error_threshold_doit(): Implements the GET_ERROR_THR=
ESHOLD doit
> + *   operation, fetching the error threshold of a specific counter.
> + * - drm_ras_nl_set_error_threshold_doit(): Implements the SET_ERROR_THR=
ESHOLD doit
> + *   operation, setting the error threshold of a specific counter.
>   */
> =20
>  static DEFINE_XARRAY_ALLOC(drm_ras_xa); @@ -173,6 +191,40 @@ static int =
get_node_error_counter(u32 node_id, u32 error_id,
>  	return node->query_error_counter(node, error_id, name, value);  }
> =20
> +static int get_node_error_threshold(u32 node_id, u32 error_id, const=20
> +char **name, u32 *threshold) {
> +	struct drm_ras_node *node;
> +
> +	node =3D xa_load(&drm_ras_xa, node_id);
> +	if (!node)
> +		return -ENOENT;
> +
> +	if (!node->query_error_threshold)
> +		return -EOPNOTSUPP;
> +
> +	if (error_id < node->error_counter_range.first || error_id > node->erro=
r_counter_range.last)
> +		return -EINVAL;
> +
> +	return node->query_error_threshold(node, error_id, name, threshold); }
> +
> +static int set_node_error_threshold(u32 node_id, u32 error_id, u32=20
> +threshold) {
> +	struct drm_ras_node *node;
> +
> +	node =3D xa_load(&drm_ras_xa, node_id);
> +	if (!node)
> +		return -ENOENT;
> +
> +	if (!node->set_error_threshold)
> +		return -EOPNOTSUPP;
> +
> +	if (error_id < node->error_counter_range.first || error_id > node->erro=
r_counter_range.last)
> +		return -EINVAL;
> +
> +	return node->set_error_threshold(node, error_id, threshold); }
> +
>  static int msg_reply_value(struct sk_buff *msg, u32 error_id,
>  			   const char *error_name, u32 value)  { @@ -219,6 +271,22 @@ static =
int msg_put_error_event_attrs(struct sk_buff *msg, struct drm_ras_node *n
>  	return nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_VALUE, value)=
;  }
> =20
> +static int msg_reply_threshold(struct sk_buff *msg, u32 error_id, const =
char *error_name,
> +			       u32 threshold)
> +{
> +	int ret;
> +
> +	ret =3D nla_put_u32(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID, error_=
id);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D nla_put_string(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_NAME, e=
rror_name);
> +	if (ret)
> +		return ret;
> +
> +	return nla_put_u32(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,=
=20
> +threshold); }
> +
>  static int doit_reply_value(struct genl_info *info, u32 node_id,
>  			    u32 error_id)
>  {
> @@ -258,6 +326,43 @@ static int doit_reply_value(struct genl_info *info, =
u32 node_id,
>  	return ret;
>  }
> =20
> +static int doit_reply_threshold(struct genl_info *info, u32 node_id,=20
> +u32 error_id) {
> +	const char *error_name;
> +	struct sk_buff *msg;
> +	struct nlattr *hdr;
> +	u32 threshold;
> +	int ret;
> +
> +	msg =3D genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	hdr =3D genlmsg_iput(msg, info);
> +	if (!hdr) {
> +		ret =3D -EMSGSIZE;
> +		goto free_msg;
> +	}
> +
> +	ret =3D get_node_error_threshold(node_id, error_id, &error_name, &thres=
hold);
> +	if (ret)
> +		goto cancel_msg;
> +
> +	ret =3D msg_reply_threshold(msg, error_id, error_name, threshold);
> +	if (ret)
> +		goto cancel_msg;
> +
> +	genlmsg_end(msg, hdr);
> +
> +	return genlmsg_reply(msg, info);
> +
> +cancel_msg:
> +	genlmsg_cancel(msg, hdr);
> +free_msg:
> +	nlmsg_free(msg);
> +	return ret;
> +}
> +
>  /**
>   * drm_ras_nl_error_event() - Report an error event
>   * @node: Node structure
> @@ -459,6 +564,59 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_bu=
ff *skb,
>  	return node->clear_error_counter(node, error_id);  }
> =20
> +/**
> + * drm_ras_nl_get_error_threshold_doit() - Query error threshold of a=20
> +counter
> + * @skb: Netlink message buffer
> + * @info: Generic Netlink info containing attributes of the request
> + *
> + * Extracts the Node ID and Error ID from the netlink attributes and=20
> +retrieves
> + * the error threshold of the corresponding counter. Sends the result=20
> +back to
> + * the requesting user via the standard Genl reply.
> + *
> + * Return: 0 on success, or negative errno on failure.
> + */
> +int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb, struct=20
> +genl_info *info) {
> +	u32 node_id, error_id;
> +
> +	if (!info->attrs ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID))
> +		return -EINVAL;
> +
> +	node_id =3D nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_=
ID]);
> +	error_id =3D=20
> +nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
> +
> +	return doit_reply_threshold(info, node_id, error_id); }
> +
> +/**
> + * drm_ras_nl_set_error_threshold_doit() - Set error threshold of a=20
> +counter
> + * @skb: Netlink message buffer
> + * @info: Generic Netlink info containing attributes of the request
> + *
> + * Extracts the Node ID, Error ID and threshold from the netlink=20
> +attributes and
> + * sets the error threshold of the corresponding counter.
> + *
> + * Return: 0 on success, or negative errno on failure.
> + */
> +int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct=20
> +genl_info *info) {
> +	u32 node_id, error_id, threshold;
> +
> +	if (!info->attrs ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID) |=
|
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRES=
HOLD))
> +		return -EINVAL;
> +
> +	node_id =3D nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_=
ID]);
> +	error_id =3D nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERRO=
R_ID]);
> +	threshold =3D=20
> +nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD])
> +;
> +
> +	return set_node_error_threshold(node_id, error_id, threshold); }
> +
>  /**
>   * drm_ras_node_register() - Register a new RAS node
>   * @node: Node structure to register
> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c =
index 9d3123cc9f9c..c9f5e0ceb3b5 100644
> --- a/drivers/gpu/drm/drm_ras_nl.c
> +++ b/drivers/gpu/drm/drm_ras_nl.c
> @@ -28,6 +28,19 @@ static const struct nla_policy drm_ras_clear_error_cou=
nter_nl_policy[DRM_RAS_A_E
>  	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] =3D { .type =3D NLA_U32, },  }=
;
> =20
> +/* DRM_RAS_CMD_GET_ERROR_THRESHOLD - do */ static const struct=20
> +nla_policy drm_ras_get_error_threshold_nl_policy[DRM_RAS_A_ERROR_COUNTER=
_ATTRS_ERROR_ID + 1] =3D {
> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] =3D { .type =3D NLA_U32, },
> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] =3D { .type =3D NLA_U32, }, };
> +
> +/* DRM_RAS_CMD_SET_ERROR_THRESHOLD - do */ static const struct=20
> +nla_policy drm_ras_set_error_threshold_nl_policy[DRM_RAS_A_ERROR_COUNTER=
_ATTRS_ERROR_THRESHOLD + 1] =3D {
> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] =3D { .type =3D NLA_U32, },
> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] =3D { .type =3D NLA_U32, },
> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD] =3D { .type =3D NLA_U32=
,=20
> +}, };
> +
>  /* Ops table for drm_ras */
>  static const struct genl_split_ops drm_ras_nl_ops[] =3D {
>  	{
> @@ -56,6 +69,20 @@ static const struct genl_split_ops drm_ras_nl_ops[] =
=3D {
>  		.maxattr	=3D DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
>  		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>  	},
> +	{
> +		.cmd		=3D DRM_RAS_CMD_GET_ERROR_THRESHOLD,
> +		.doit		=3D drm_ras_nl_get_error_threshold_doit,
> +		.policy		=3D drm_ras_get_error_threshold_nl_policy,
> +		.maxattr	=3D DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
> +		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
> +	{
> +		.cmd		=3D DRM_RAS_CMD_SET_ERROR_THRESHOLD,
> +		.doit		=3D drm_ras_nl_set_error_threshold_doit,
> +		.policy		=3D drm_ras_set_error_threshold_nl_policy,
> +		.maxattr	=3D DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
> +		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
>  };
> =20
>  static const struct genl_multicast_group drm_ras_nl_mcgrps[] =3D { diff =
--git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h index 0=
3ec275aca92..9aef097ea10f 100644
> --- a/drivers/gpu/drm/drm_ras_nl.h
> +++ b/drivers/gpu/drm/drm_ras_nl.h
> @@ -20,6 +20,10 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff=
 *skb,
>  					struct netlink_callback *cb);
>  int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>  					struct genl_info *info);
> +int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
> +					struct genl_info *info);
> +int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
> +					struct genl_info *info);
> =20
>  enum {
>  	DRM_RAS_NLGRP_ERROR_REPORT,
> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h index ee2caa0e=
dc6f..1765a3130b09 100644
> --- a/include/drm/drm_ras.h
> +++ b/include/drm/drm_ras.h
> @@ -71,6 +71,35 @@ struct drm_ras_node {
>  	 */
>  	int (*clear_error_counter)(struct drm_ras_node *node, u32 error_id);
> =20
> +	/**
> +	 * @query_error_threshold:
> +	 *
> +	 * This callback is used by drm-ras to query error threshold of a
> +	 * specific counter.
> +	 *
> +	 * Driver should expect query_error_threshold() to be called with
> +	 * error_id from `error_counter_range.first` to
> +	 * `error_counter_range.last`.
> +	 *
> +	 * Returns: 0 on success, negative error code on failure.
> +	 */
> +	int (*query_error_threshold)(struct drm_ras_node *node, u32 error_id, c=
onst char **name,
> +				     u32 *threshold);
> +
> +	/**
> +	 * @set_error_threshold:
> +	 *
> +	 * This callback is used by drm-ras to set error threshold of a specifi=
c
> +	 * counter.
> +	 *
> +	 * Driver should expect set_error_threshold() to be called with error_i=
d
> +	 * from `error_counter_range.first` to `error_counter_range.last`.
> +	 * Driver is responsible for error threshold bounds checking.
> +	 *
> +	 * Returns: 0 on success, negative error code on failure.
> +	 */
> +	int (*set_error_threshold)(struct drm_ras_node *node, u32 error_id,=20
> +u32 threshold);
> +
>  	/** @priv: Driver private data */
>  	void *priv;
>  };
> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h inde=
x eab8231aa87c..2f832275ee6e 100644
> --- a/include/uapi/drm/drm_ras.h
> +++ b/include/uapi/drm/drm_ras.h
> @@ -33,6 +33,7 @@ enum {
>  	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
>  	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_NAME,
>  	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_VALUE,
> +	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
> =20
>  	__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX,
>  	DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX =3D (__DRM_RAS_A_ERROR_COUNTER_ATTRS_=
MAX - 1) @@ -55,6 +56,8 @@ enum {
>  	DRM_RAS_CMD_GET_ERROR_COUNTER,
>  	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
>  	DRM_RAS_CMD_ERROR_EVENT,
> +	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
> +	DRM_RAS_CMD_SET_ERROR_THRESHOLD,
> =20
>  	__DRM_RAS_CMD_MAX,
>  	DRM_RAS_CMD_MAX =3D (__DRM_RAS_CMD_MAX - 1)
> --
> 2.43.0
