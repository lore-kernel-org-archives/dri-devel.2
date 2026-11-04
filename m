Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA648606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 02:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fhZzOBbM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29A1310F939;
	Wed,  4 Nov 2026 02:37:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6251710F939
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 02:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793759854; x=1825295854;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=kZM3DCfv/MlTABumVRXnpIgjLFmkzEh6YdRYWbclaGM=;
 b=fhZzOBbMVys+t7XJDl+JcVLDXbbTtu1tesVtRlM1ENq0pszC/uXn2fnG
 aZaW25tedFAv5fYDUNRqLgdl0msdvvIGimhYMxLM+YDXdj16GjQD+KcVV
 knOS95dMi1Rhh2qLQ2fq+NhoP4O9UJfGV6EpEdKxGNa6pk5prjI7jim5s
 fGkyVXojZMn68vrYc9ezXsp9y49oUXRvruXDmnq2qv3R5i6r4kgQZFZ9j
 D2fR4WjRg77+Fh//1h7HNJxTVZv0Ul0Gc5HM0Aijx7IhQPKfJDyjx8f55
 FJVx8iQWE0Kg9tAjmKcX64agobptFD2sublTfc1NJeaFU8WEpXq4K1Q4A w==;
X-CSE-ConnectionGUID: tXEtD09ZRp+zU+vKsMgh3Q==
X-CSE-MsgGUID: L6pwTv6AQMyHl7uEe3ZD6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2500775"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2500775"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 18:37:33 -0800
X-CSE-ConnectionGUID: UN6nTfR2SQeoeduYq0EjaA==
X-CSE-MsgGUID: 189xM7HcRw+smn7WTl/Orw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6922090"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 18:37:34 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 18:37:33 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 18:37:33 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.5) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 18:37:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZiC6Fc3Rx3LPNMG4Y8Sw9Z997NFfij8MPi6ZX8Q9YHTPD2/jUqi86Y6algErcpPHNZojR7/uiN5tfCG8765v6sWWV5cI7mOr++Yq19nvJtLgWDTibEyPV3oeslV6HneNGoo8kQYGWcT66Kaokh468aMOdBOq4Pkn3mzVIH9beEdiQrVqL0JZuS4p6yz5/QgM2ZVVeIyo59OdsoMaIJ7GpijexO3AS/aanOoFbyMSGBNp2qu5XZaw66FvtYonfzVUFllCWs82KyWZ4xVZs6C53RtA9SksMJIsNeVD+C5Gd0rkWeh1A37OCoLtFR7zTtm7rnOjMmNm8zT+/QBcjlmclA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZyd64FS3Xq5kCcnUXIoGJsczOK7+39gNduRkEpf78c=;
 b=xj8u3q+nXVhlExl8+l/nUu9rhITWnllbSVdbJAIFwCN+uaElvWra7/Y049WgunVpARjwIq9PK4SQn2tJZ0fG0gTpNk+MxDu77FiyprU0ULb12KbkByZ4agYGsCsk99GvWf2czh7DV3ZgXymsSE3kqDSjmJTsndACRWvrtfJ3rMxAY5SWObuacQp58D0r2kTLSK6sIGzFYaqtU+0jfWa92ZhOwQlOhx0IyTKaRzLcmdDWIRJpZ7QeY1f1U/+Kp1CgMPTc2G0cM1QqoRUgS/MrlYamy9ac06D15PPjEPqKDX/jUEFUYXnCrlXkGx2Shew6MvKQPZmNJQLhsWq4tJuOLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by DSSPR11MB9667.namprd11.prod.outlook.com (2603:10b6:8:374::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 02:37:31 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 02:37:31 +0000
Date: Tue, 3 Nov 2026 21:37:25 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: Alex Deucher <alexdeucher@gmail.com>, Dave Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Alice Ryhl <aliceryhl@google.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, <dri-devel@lists.freedesktop.org>, Mark Brown
 <broonie@kernel.org>, <linux-next@vger.kernel.org>
Subject: Re: [RFC] linux-next: replace the DRM trees with a single
 drm-for-linux-next
Message-ID: <auqaZdocMvOIxN1c@intel.com>
References: <DMKY979I29AF.BS1DF5YAZMOY@kernel.org> <aujikV14tF6K1Xqw@intel.com>
 <DMKZR0YZV1CX.DWVK9V47GR1J@kernel.org>
 <CAPM=9tww=CJdxzvfUvLwQ6V4uoszg8JrB1XCAcp15upM-xPvSg@mail.gmail.com>
 <DMLTRKUXTL3P.11VRVU1A8ERMG@kernel.org>
 <aupFKGpAwAiGXN0U@intel.com>
 <DMLVPRO7XF7F.21199FO61MFRD@kernel.org>
 <CADnq5_N-6_T8EnihjoTSqpHGb_mZPogi6z=Ti-7_oue5d07oTw@mail.gmail.com>
 <aupktBCwcN_coHEH@intel.com> <DMLY7GDT8VBO.EE1P01ZX2HPK@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DMLY7GDT8VBO.EE1P01ZX2HPK@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0204.namprd05.prod.outlook.com
 (2603:10b6:a03:330::29) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|DSSPR11MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: 096cff94-7d44-4761-698d-08df3a1c92e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|22082099003|10067099003|18002099003|56012099006|4143699003|11063799006|5023799004|261102123227099003|261022075727099003|261028144727099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: 98iQpoCZ2gr8I9BedsXY9Tt8FR4GnAu7Gy7FgfPcEZh95iBGxzSk4l2dUxuv5a1sUOBvnlot5h8dmE8ng73ETdwEX2Vx8BbHg9NdSLtBrUoeVC6WKWQLodK/Pp+GkCapEqwwmYFsS4iIo6z+QY3Q8GW2wBya+vUtEbszSJTvBWgjGVZtaYE29bk/ADmnuuGgA2l5E7DizJqORbYesPuW3kDRI3b18sxPPCm2wBAnRcjPmaJqxnTqWuajbFOQHi4nBHz8N3b8x/xP8BZw3lOW0xnci6OrSmMEO7Jej4MtAXg4GC/KaWMnWVR/Ne9dyQe3zvM9+PmMg8njp6i+Q2DP5msy3486iOy82M+Ec4HsxkH8JoTI2kYLlCV+dt42eRkf9+o4d59vfWUfAohMHp0MeFdNQVouGimSi3D7QG+kTy4iuUlLnF0l1SQsQV9UtAn7m4YVJanESUDtbjUZpqWYq5zktJzgjGWhJh/9rL2Auc7ZwlIVYHAKa7QEqb6cb0jHt/DLcyjvDkylyBxO4FWa1E+buDRJFcBz93w+aZQ6vaGCn7cAghNPNP25FLT6dXuvByOw3bqKNGLTR2xo0wV9OXO+rfJN+U/yqFCO3bbFECF9jAQ7qUBe6UanXCSAzVwC7SkZ55WpLAmVEcuk3+1BrTxNLG3AZxqX+1051a8ndpU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(22082099003)(10067099003)(18002099003)(56012099006)(4143699003)(11063799006)(5023799004)(261102123227099003)(261022075727099003)(261028144727099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDd3Zks5QTNzcTBSVGhSVi96NzlXRVJiNE5mVU5RYnJzL3BkRlo0Z3RseE96?=
 =?utf-8?B?S0ZYVlQ1RXBiWWtIOWw3bEtRczZlUUxuS3NraEVIN1JvUS95T1ZIT09YZHJy?=
 =?utf-8?B?anJZdGhXaWxRMEN0dU5iemZ4UElIMVVra2RIWit4blRLQjVZRjFVdlRZZzR0?=
 =?utf-8?B?eUE1L0dBK1dtTE9LNG1YaTkxeDAyTnZISmhaemlSbTYvc0toTHR6WWNpaU1G?=
 =?utf-8?B?eUpiK216TnBESjZQNzI4RFlmeHlOdzRyWWJxZ2lXODY3alI1VysvaHlUUDZL?=
 =?utf-8?B?Vi9xKzhEU1FkRzZkRkFYdzR4cjVEREwyNDFaVjcxZ2piVHRlZTdwM1c4T3da?=
 =?utf-8?B?WDlmVkx2U05jdzZja1pzODNnTUxuVkV2akZ0YlBzYTdWOXFNQmtpakl4VjNI?=
 =?utf-8?B?dHR4MVhqWUhNellOejE3ODlQNVhIWmNUSTJmTVgveFAzaW5EQkFVc0lVZkpL?=
 =?utf-8?B?L2NmY2NKZzFUbjVaVmI3d0wrUkg4MnVoWFUyejE4b2RxYnhTcTBZSHlRaEJC?=
 =?utf-8?B?M2tNdU83U05MOGdmTDZnSVd3bXh3OTVTS2cyK091UC9LT2phdWxDdU1EQlJF?=
 =?utf-8?B?eXIrU29qbEVYMERLeGdTeTBQUC9GN2ZYT3JZeFlnYkpEQ0owYVQxSHVrNnZI?=
 =?utf-8?B?OWV2WGpCS3BrWGtMVWpPUnhvSzNpU0FWVThoMkpQZkpPNGFraFA2bndSU0VF?=
 =?utf-8?B?Q1ViUEZQcEVhSk9QYkZ0TmRYSGJqU3JIT3NBNUNicXNPS0tweUhNZUIwYXBk?=
 =?utf-8?B?QkJCd0NrcXB3TnVLZnkvdzd3SEJzQXYxeEthU1k2bUlZeXpGY29xb1RTTStw?=
 =?utf-8?B?c3F4Umh6VGVmMnoxcFhLS20vUXY5RzFPQjNEMTk2VTduUDNGc25WYjNLbVg5?=
 =?utf-8?B?NzhzMzJsN05pdXI0TEs0ZnB4TnFNL211a3dKNitDL1AzYktGNmF2dXZObGtu?=
 =?utf-8?B?UGVaUW9JL2hOOFZENE1GZmdTY1J3TFU2QWlGWDdYYXBRWThjOXVjNTFUYWYv?=
 =?utf-8?B?Zk1GN0ZKN1A5K2FqamhuN21GWWtvR0dYcGUwa1k3VmV2WmM2TVZpMXpYZlg2?=
 =?utf-8?B?TG1XZUo5S2p5c0V2RmpVTWhEU3FIeUUrMUtXdEM0Yi9uQWs1bnE5ZytLSlRm?=
 =?utf-8?B?UmdpT1c0TzBWVkM2b1Q2U2ZTaTYrUGF2OUsxRDRSdkhObmVxekNKTHoxQlgy?=
 =?utf-8?B?M1RpM2tsc3pPRkdOdDlFQjJjQm1UUlRCbUVaN1JFZUdRMG1ua0kvODdCa0Jo?=
 =?utf-8?B?TzJJV3ZQTFJMaFVqT1NTMTI2bnNvNWpCYWNmOFljNG9mMGhTM2NocW5VQ0hL?=
 =?utf-8?B?aGVNaHpXTG0yaVRSWENSYnhlZm9vN2RjUndqK001cE5VbXRUYUt0aitsRm1t?=
 =?utf-8?B?MG1HUGs3dmp5WElwUUdKL0RuT0wyOXhwZ2NPTjVWdFgxcnJjQ0VYM0dacEV6?=
 =?utf-8?B?RjRMWmJ2NmpGMHMxYUNLL3Z3MWUrNVBMWXlDdEdrcnE3YjlXaFduNEpwRkJT?=
 =?utf-8?B?WnV4TW9mdlRod3VTMGMva3lnZ2FWN0dldGowK0FqUWdFQVNiSllwVHVQcVFD?=
 =?utf-8?B?NDRJZ3BKRVRTOUsxQmlHZk1kTGpPaWsvTUxFM1dXejVOVjFxZjNoTW5IR0FB?=
 =?utf-8?B?YVFKNDlsZDdJY0RETEh6aktLa2lKOVM2U0YzTXQ0SEQ2endOL1lXZ0lhb0xE?=
 =?utf-8?B?VG56WUgreEEydHRIUzlCaVdCWHM2N0IzN0l0dUl3bm5leThuSjdRZGdDb3Qv?=
 =?utf-8?B?UC8xbnVWRE5uejVKU0xialV1V0p1c05qOVl4OTMxUkRFeDZib1Ixb1NPRkRE?=
 =?utf-8?B?N3BqYVdaZ01NVnRkV2Z5Y3JQN3A5aFdybFZUc2ZVOWNRKzlKRWYvdmN2L01F?=
 =?utf-8?B?RG1PSnczN0I1WUFGU1QrL0liY3BSMTV4MjB1NzVsQWZIMllqS1ZIMGNSZGNL?=
 =?utf-8?B?eklSajg2bEVRK2RPcVlIMzFXVVVtc0ZYaDVIOUFyUHMycTZody9WemdTaDgr?=
 =?utf-8?B?aHpkNWFJSW1KV3h4Q3NHR2xOVTRVeWJNWTFyRjVzUXNxdHYxV3QxaUxvSEpT?=
 =?utf-8?B?RTVreCsxTUU0aG9KWmZrYlZqc2JUaWdjYWl3amM1Mk4vNUI3OTV0dllvMjBv?=
 =?utf-8?B?bmVPeXNzcnRxUWNaTy9wSHlCT2ZKekQ3RExwL256MXdBU0xRcWV0MG81bWJJ?=
 =?utf-8?B?M0pIRmg4S1dYcVVHZEFWQ1o1YWtaUXlzWCtrU2M5YVBaUkVsZDI4eVpYbGls?=
 =?utf-8?B?VWNPclNIbStwajJNTXdTWHJtN2tETTVQTnRMcVY5cEVDTnNycGU5d3hncjNL?=
 =?utf-8?B?cTZadm5udTZxa3RxaTVkcVNka0crcE56aE5ud2JJdFBLbm5tRHJiQT09?=
X-Exchange-RoutingPolicyChecked: m/7wkFJFS9Fq+P3scf+PEbfLMd5sSNMJn+UWGMxJfViSdm3Hs3CBPbo1IScC5VmXAlwuRtHXJ+sJiDrXyu1GU81+OUXyC9ywl9SZ1IokrLVKatf9lzwD603MKr7ZCNEohBblJHvJ+39hZKPEjbPmiUqef11aju+BnG3qSNoAYNpq7pOu/Da1WxNTohlpTP2bbxznL/O/oeHg0jSG0Az09ahGJKSsnXcvWv+3ykwfGhvilAVtmJZAItCd8bALcfUXKH6zrPyB1qakULD7ZQpF40kzgo4xgLambkNwqzAS1eiqK13WAiQqjq2hmnVJQluX8KI/m+OlYZZvKe5UnDq+FA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 096cff94-7d44-4761-698d-08df3a1c92e2
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 02:37:31.0380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXmTziD262dUEHb8seKs08CAPFOtCjJQYtSiBKX/LPB/YqQ5VLcp8sVElcmeK+WAIJXs0jt0BuIinEBoT0JArQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR11MB9667
X-OriginatorOrg: intel.com
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 12:01:36AM +0100, Danilo Krummrich wrote:
> On Tue Nov 3, 2026 at 11:48 PM CET, Rodrigo Vivi wrote:
> > On Tue, Nov 03, 2026 at 04:19:11PM -0500, Alex Deucher wrote:
> >> On Tue, Nov 3, 2026 at 4:11 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >> >
> >> > On Tue Nov 3, 2026 at 9:33 PM CET, Rodrigo Vivi wrote:
> >> > > On Tue, Nov 03, 2026 at 08:32:48PM +0100, Danilo Krummrich wrote:
> >> > >> IOW, linux-next merges tip/for-linux-next, and tip/for-linux-next merges
> >> > >> $tree/for-linux-next, rather than $tree/$tree-next.
> >> > >
> >> > > For this to work we need:
> >> > > 1. xe to create for-linux-next for-linux-next-fixes
> >> > > 2. amd to create for-linux-next for-linux-next-fixes
> >> >
> >> > Huh, I thought all the trees are doing this already. Well, that explains
> >> > where the the problem comes from. :)
> >> >
> >> > In any case, drm-misc, drm-rust and drm-intel already have for-linux-next and
> >> > for-linux-next-fixes, and the implementation is generic. So, adding it to xe and
> >> > amd is trivial.
> >> 
> >> I've started doing this for amdgpu this cycle as well, but I still
> >> pushed an amdgpu-next branch as well since that is the source of all
> >> of the cherry-picks for -fixes and -next-fixes.
> >
> > But it only works if you stop this branch of updating after you sent your last
> > -PR and from that point and on you merge or cherry-pick-from your -next-fixes.
> > Otherwise you are sending next.next material to -linux-next.
> > And this is the current issue Mark is raising to us for a while.
> >
> > We have 2 proposals on the table:
> > 1. (this RFC): a global unified drm-for-linux-next that is a chop-point while
> >    drm-tip is getting constructed.
> >    If we go with this option you don't need to do anything, but stop maintaining
> >    your for-linux-next.
> > 2. (Danilo's proposal): Each driver/domain keep their for-intel-next and
> >    for-intel-next-fixes for granular control of the blackout weeks
> >    and dim merge them together into a drm-for-linux-next
> >    If we go with this you need to at least ensure that your for-linux-next
> >    doesn't contain next.next material during our blackout periods.
> 
> dim already does that, fully automatically, it checks:

right, but like xe, they don't have this for-linux-next setup with dim taking
care. So they do need to take some action.

> 
> 	git merge-base --is-ancestor $remote/$linux_next_fixes $remote/$linux_fixes
> 
> which means:
> 
> - If -next-fixes is an ancestor of (or equal to) -fixes: feed for-linux-next
>   from -next. This means -fixes has caught up with all of -next-fixes.
> 
> - Otherwise: feed it from -next-fixes, which contains changes that haven’t
>   reached -fixes.
> 
> The only think maintainers need to do is push $tree-next-fixes to catch up with
> $tree-next, which they need to do anyways.
> 
> IMO, this is more robust than relying on all maintainers freezing $tree-next at
> exactly one global cutoff.

This is the part that I disagree most. In my proposal, maintainers need to do
absolutely nothing. The freezing is already guaranteed by our rules.

In the current individual trees with maintainer control we are seeing that
only -misc and -rust are fitting this dim freeze and procedures
and it is fragile at best.

Again, at -intel branches we have no way of synchronizing that. we will
need to have a different solution for -intel, we need to modify current
flow for -xe and -amdgpu.

But right, feel free to propose your dim changes, then I will take care of
-intel and -xe on a follow up.

Thanks,
Rodrigo.
