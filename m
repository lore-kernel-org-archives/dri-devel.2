Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FBF1088E4E
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 22:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1301710E456;
	Wed, 18 Mar 2026 22:40:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cSYfm6Mt";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2648B10E031;
 Wed, 18 Mar 2026 22:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773873651; x=1805409651;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=KFpjmTijDYpItf5NGehsmkyGlz1rXRquo+u9jnKepZg=;
 b=cSYfm6MtCG5d++m4CGiawPq6mMSDOGU1P0O21cIUbBXu6O1mnv9MXXfY
 33notgnK29rnejDwz7gqD1PHoYjmW9srfI9tsnFgdi0ZHUG7ZlnJRy7m7
 kRGXvof5HsYnU86H9rOwiK+MLvbxJJWs0FeYeYfNmxUsWdWgnBsxtpoyQ
 3PVwAioZbnXu8efEToo5cVSQ0rPbM4xArb0QLxvJXDqg2VuVn8XtaB5Mg
 HgJeRGTAhxmy15ZAv9GS+T36/EYCSP/bQ+5NbRP5SEyl0iOR+5NQeGvEz
 pCb4Y7HzUV6nhUBQ/nxf8DJ9lFY0cQFE8RztOg5Yk/VogBWuQ15S8yYut A==;
X-CSE-ConnectionGUID: z7QdSCgMQpS/1+Xpc9bK4w==
X-CSE-MsgGUID: 9w1j0T7FTLWzDZu93A0HAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85262008"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; d="scan'208";a="85262008"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 15:40:46 -0700
X-CSE-ConnectionGUID: JXotSR+/TbeqVumvU5kDEA==
X-CSE-MsgGUID: 8v5ycregTzKwUORrrFsjWA==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 15:40:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 15:40:43 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 15:40:43 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.52) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 15:40:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoOokyg3MyDAd3IOI72QYSvDd2o7sWCQOwcUqwVrNRs5KO2b0Cxpo/QQxV/Ze0V64OHd54k7gDJrr5NEff1xManGkHbwqCEMEfAOu/IqFge04FzfwbrYJwN5cBLDCgCVnhTaN9WywGyaL2vgN/HOIGBTgkSfWTNMtEe/pGIWIwuCRI1FxIpgnBKgTYHIUDR4UVaNhY8IICEK7/vBEMFi8pfKU4MyJpaQewuYhWhvX+K3n18m5fc1UZcBpH2qs6rADHGSmB26L5oNsqa5dRMGZSqxrt/CeIW4qMuhzT/wcrXZUkO3EUlqDSc0bkiGFk/VJ/ZIfsw+QeHo/elLXmztvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytfnhx3UpJP5MkXJIv6Gg/NyCsCUpPc1EIXfvO/lr9o=;
 b=ddYPHge/QwO9ax+3UVXyVnShSAelyzQ5G53fSuNYJGWZsJ+htPoHIJf2xTITZB5rvfvoi6HJd+oCVHUoSQum5l/qXKAL/dCJ8hlb6E11uiRfX9KUVyIktpHwwZ5AdZTpFItJGUla1gXAzXfSgbhbROi4niESFTL11p2ZzhApvCeCDbl8Uo7HD8pyp/b5RWxkUAcZVa6BAOiG4BGVkC032Ov+XeZvOK6sDd+h9sSvYX90ZuFwQzunOwGROMPqrWqwNclOioBBMtIhZ40qNpe7qwC4CpkmsqG4//pU0F+wmyBlUbIzlumP918VwaIiLWSVVst0/P+babQLogRnuTh2VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by DS7PR11MB9449.namprd11.prod.outlook.com (2603:10b6:8:266::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 22:40:41 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9723.014; Wed, 18 Mar 2026
 22:40:40 +0000
Date: Wed, 18 Mar 2026 15:40:35 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
CC: Daniel Almeida <daniel.almeida@collabora.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, "Tvrtko
 Ursulin" <tvrtko.ursulin@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "Danilo
 Krummrich" <dakr@kernel.org>, David Airlie <airlied@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Philipp Stanner <phasta@kernel.org>, Simona Vetter
 <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, <linux-kernel@vger.kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, "Alice
 Ryhl" <aliceryhl@google.com>, Daniel Stone <daniels@collabora.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>, John Hubbard
 <jhubbard@nvidia.com>, <shashanks@nvidia.com>, <jajones@nvidia.com>, Eliot
 Courtney <ecourtney@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 rust-for-linux <rust-for-linux@vger.kernel.org>
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
Message-ID: <absp4z1Op0BrXReP@lstrano-desk.jf.intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <7A8108C7-7CF0-4EA4-95ED-8003502DC35A@collabora.com>
 <abjqfXERS6Xk4FAQ@lstrano-desk.jf.intel.com>
 <abmaDElHmbQkYy57@lstrano-desk.jf.intel.com>
 <20260317214320.74e6c130@fedora>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260317214320.74e6c130@fedora>
X-ClientProxiedBy: MW4P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::26) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|DS7PR11MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d96e856-de76-4d47-8db9-08de853f61ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 1aSC9rzeMehHW7O+k12RpnIiCGtWV2iwDl4cNG+RcsM423PlQAdbNeDP/N+9dk1EYGaU7i6xMKmZzO+oXDPLfmYo3u8GHOPoYYF5XumtJfMB/ENl/AnN9FFlJZrwTvo3CPs7b+jvRrhOjb7l6rAdjJ6vIhN3NMGy6UyJ8fN1poVU4/k5lSFISVZrwrO5AJe2EazsUbvoAg4ZbZJQeYsqxloPQec2aibzjhEh5wLLk3RULke0Zz1psDC0Qjy/4p6Xtz4e/1YlKH2JS7mpws0kyGq0OzbwaRlJ7bz27gNj0LTue7pKbz5JjMo0jdcRpvqPnYvXWtuRSjsDh/ZU/3n0pR25mZqV1hdt6KC8naBNfFIUd5JYcg+rKgcRcPOpZgQ2ESEiyU781BRyKko88G+dGbgpFRDIVWD7inOdbRqk4mxebvabLhfN2y7/poPJY8jXC0sVokHbXKwYAb/fLBuZ1tfV90dBb6ZjswFeoml0BV1b2LBmTqlVrKXUngTi+XNsK+/tkC7Ovc1ZUbAbUk/QeIIVqng7Ma0gWfeZa+lRzaYpOSyXTJAO5Qkb3Edt5GYe+NB/I+uxBliO8FoLfmiDBaQqIrxbgXsJ0f8nkqrnzKQNqgR+m78o2a65Jhywf0VOPJfZyLaYdJEc96kKwiDHrhcgzENHnJGsYQuP4KliFkP7BwwNLaT4NfjA7Ch4WzzA/eKHZlqW9AMZ8GzZKlCAWSu0Jfvk36VbehUtg2+ab1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnlYb0xBMEVoaUZCZzdiR3ZtdERyanEwSmtzQld4RW1TTHZzM00wZUlwMmlh?=
 =?utf-8?B?L3BCSFU2WlN2Z1o0N1M0RTJjQU5qUmx4UTFDeXBKMmp1VFJRMStUVXo0M3p3?=
 =?utf-8?B?Y3VrM1RXRW5CRTNQWDcxdnY0eDVBZCtJYnZxOE1HR1pzMjJWejF2Q0RBbDRF?=
 =?utf-8?B?bDdKWEYyWXd6MEFVRDVLYS9ydHJScWFHS1lRQmVyV2Z4VGt2dy9YaWdXZk0x?=
 =?utf-8?B?N3YrWkJBMEdwTEdFYTN2RFpmUDJZeUQvRCsxWHpTSVA5dzNjc2taUUt6cjBR?=
 =?utf-8?B?R25nWDljTXZVcEF5amlQMTJ2dk1ySHNMb3hGcEhWTm03UGdwbDhyYnhpdjg3?=
 =?utf-8?B?aFBwaFIwZU1NbXFDQTlibDYzUjVvTGxGdldpNkJXSFdhS0hWTzJPNlBqbUdE?=
 =?utf-8?B?TGFoWEU3RUVnbnRtODFsRHZWVVo3ZFY1YmhnMGYvbWVDRDNyZktiUituOEcw?=
 =?utf-8?B?RmZtZGFEdENmaWZoTXI0QlpiV2VycXRGaUJmUHlmYS9LUmlXbmV6MVVvWUd0?=
 =?utf-8?B?eGZyaWkyNk9RcDFVWXl1U0FkSWZmM3ZiMGY0Tllod1ZNQ291MFdwVURGSnJk?=
 =?utf-8?B?dklraEVvTmpQM2Y5NHFrcDUxd0I1cnpLYkZHbVNvY3NmSVJ3NTdNWDNCOUZZ?=
 =?utf-8?B?WUJPRGl3d054MUxLK2xQMmk2UHh5K0pLS3hNcG42TVFvbWNqZVpiTmY1czVq?=
 =?utf-8?B?VzZ2QnczNUVzcXAwcDY0Vk9VYlhwdk8rYjZIczNFK25OTHMxMzF2aW9leHRx?=
 =?utf-8?B?MEtUSHVxV3JDMVV6d0k3dVdJeTZMQUxnS0F4S0FRbnU0WnRQZ3VqL2lsL3g3?=
 =?utf-8?B?ZEdSK0ZTRURvRU10VzFUOWZxZ25uY2V1SEF1N2ExS2h0REpxanRnbkVKcy8v?=
 =?utf-8?B?Sm9ZYmRtTEhtL2p6UjhwSnYxVVN5SmFGaVF1NmNlUEIwNDZUZDZ3M2pTR3dN?=
 =?utf-8?B?c2FSbHBnM2w2bmdoV2FPMEVCV2dzTzF1MEZEM0UrQjRZemZwQitYQzVDQzNr?=
 =?utf-8?B?emlsZGhHVGZMZGI1bnNnYUltR2dtQ3ZqTlZRQzZya0I3ZXNGZDlsUCtVMlFI?=
 =?utf-8?B?eEVsVzF1d0VqVzhBK1dpMHltbDZXcW9NaW1SQTBJalVnaVh5ekFPMFN2TTR6?=
 =?utf-8?B?UGpzZCtEc1pFcDdMV0NmekpoWEdjeTl2RnVVRGRrMkZtbkJtbWp6ZloxcjM0?=
 =?utf-8?B?dWFXa0FhYVVnSHE2WU92OHRmN1g2ekhSRU8wSTE5UjFDR1pjcGJDOGhWVURp?=
 =?utf-8?B?L2E3QVF2Lzlkd0NsUUswV2MwajduejB4WnNFV0tFMm1jM0pKcUdsOWgyYWRq?=
 =?utf-8?B?NmRaL3dRKzFQYTYva0ZaTXNKcFlmTlFSZWltS09KY2JnMm1UQ2FobWU0TEs4?=
 =?utf-8?B?Z1JSNjdvTFRhaENxU0FBWHg0ckdtOE13L1FnT0pKSyt5VDJuVHhnT0sxZDV4?=
 =?utf-8?B?cHRsbnc0YVgyeWNPZHJ1SElyRUFoQTJGOE5oSHlPNjlIMEltc0hvdk41MEgr?=
 =?utf-8?B?VTg0QUFyTmVqMVVKS1Naam9yRHJJdEE1OGZyR1FIaTBJd09zcy9QZ3JtRk9F?=
 =?utf-8?B?c2JqVy8ra0l5MWtkcXR3OGZVNWlYczR3L0YwZFl1TmhuOUk3QUw4c3loL09y?=
 =?utf-8?B?QjBCQXhLMXQ2TDV2a0dCSGNwNS9BdzF2RDdxUDJRcGNLWFpzYk5MdEh3SW9q?=
 =?utf-8?B?MWpMeW9meWx0cEVDUUR1a0pFZmZDTmVDZDBUZ0xsRkplMGtONlRyeDM1ei9I?=
 =?utf-8?B?WXdpRGVmUWtSWVI2OUMrVmQxci9mSmkrSyt4aktDSy93YUJMc1RoWVRld3Fh?=
 =?utf-8?B?YVRsdjJMNFRIczJYQmFKSHRNYjdCWG9oZ29qdmhIRGE2c2ErR09PT3R2aVhC?=
 =?utf-8?B?dm84bGV1Y2FRK1puRTFsWTJWaDFlMVp1R0dHeHRmK3RaWTNEaFBIeDJYY055?=
 =?utf-8?B?NmxLTDIvNU1GSWR4NlVxb00zVmVkTEdRWTBxcm1KVzhtZXBhVFYwVjYyVUZB?=
 =?utf-8?B?aElUb2VmeWUxSU0zdDRlZzkxaVdBaFcyTzNCTi9jenh2eHlFV1pXT0djRGlP?=
 =?utf-8?B?Ynh6Y0JXMDZOTk1sakVYQUh4aTlpd3h3UVQvZ0ZZOXdVbGhsdFF1OVBSaFR3?=
 =?utf-8?B?QXZNdGo4SnVTUFVwVDA5U3RVSFlleXpQMHlpTzdYa2w2dTI5Q3NmQjMyL2pN?=
 =?utf-8?B?QWdDQjE2bmdtam1JZzhuS1pmY2t0Vmh6WW9nNWZpTGhITzJ5eWgwS0NkQjZt?=
 =?utf-8?B?TC9FZVdmV0xLZFFUemFtb2lZUGZCcE8xbWR0a0w0cG4yTFp3OGcxbUg0Vm1M?=
 =?utf-8?B?R0N5NkwrUHMvUm1aUTlaNkJETlNIVFViVERlbWVtNXFhT0Z5aU5Ndz09?=
X-Exchange-RoutingPolicyChecked: e8AFl+t808gtfltbpz7FWuNkEBkfANUD6jY6Q4JPQz/0DeXhv8XrWl4d84Uh0qjuYWFnHz7+80RLYC8wpIULVuROWwinTPomgpjnpa6RoVjHDtuvGmEVUp14VMlrVgwhIghiU3mcLNZpmE3grtA6yiPegs4RklkeJNaosSOvrWVr6V69ChFloZg10xwgMAkLTP5ec2e8rAzE1gVgv1DWH1SPtJPSp9Rf6N+KQvxbNQTsbleLyGgKmq914ABbImE2MHOjiy1O8MzsdceWxhGvRQ6PiybHPdIKzITKdQMXL87xMikmNHiBZjOubDmX+orPsKHQ4xwZkb5i/EaPlzwrCw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d96e856-de76-4d47-8db9-08de853f61ec
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 22:40:40.8613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gf/dOAgawXgh6t2hIIKnNjQCFB5WLQnDry0pAy1KpVSmLRP8EgjsHEW1qjehTh89LBIgYvBeRkQUa5I6eOo0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9449
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

On Tue, Mar 17, 2026 at 09:43:20PM +0100, Boris Brezillon wrote:
> Hi Matthew,
> 
> Just a few drive-by comments.
> 
> On Tue, 17 Mar 2026 11:14:36 -0700
> Matthew Brost <matthew.brost@intel.com> wrote:
> 
> > > > > Timeout Detection and Recovery (TDR): a per-queue delayed work item
> > > > > fires when the head pending job exceeds q->job.timeout jiffies, calling
> > > > > ops->timedout_job(). drm_dep_queue_trigger_timeout() forces immediate
> > > > > expiry for device teardown.
> > > > > 
> > > > > IRQ-safe completion: queues flagged DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE
> > > > > allow drm_dep_job_done() to be called from hardirq context (e.g. a
> > > > > dma_fence callback). Dependency cleanup is deferred to process context
> > > > > after ops->run_job() returns to avoid calling xa_destroy() from IRQ.
> > > > > 
> > > > > Zombie-state guard: workers use kref_get_unless_zero() on entry and
> > > > > bail immediately if the queue refcount has already reached zero and
> > > > > async teardown is in flight, preventing use-after-free.  
> > > > 
> > > > In rust, when you queue work, you have to pass a reference-counted pointer
> > > > (Arc<T>). We simply never have this problem in a Rust design. If there is work
> > > > queued, the queue is alive.
> > > > 
> > > > By the way, why can’t we simply require synchronous teardowns?  
> > 
> > Consider the case where the DRM dep queue’s refcount drops to zero, but
> > the device firmware still holds references to the associated queue.
> > These are resources that must be torn down asynchronously. In Xe, I need
> > to send two asynchronous firmware commands before I can safely remove
> > the memory associated with the queue (faulting on this kind of global
> > memory will take down the device) and recycle the firmware ID tied to
> > the queue. These async commands are issued on the driver side, on the
> > DRM dep queue’s workqueue as well.
> 
> Asynchronous teardown is okay, but I'm not too sure using the refcnt to
> know that the queue is no longer usable is the way to go. To me the
> refcnt is what determines when the SW object is no longer referenced by
> any other item in the code, and a work item acting on the queue counts
> as one owner of this queue. If you want to cancel the work in order to
> speed up the destruction of the queue, you can call
> {cancel,disable}_work[_sync](), and have the ref dropped if the
> cancel/disable was effective. Multi-step teardown is also an option,
> but again, the state of the queue shouldn't be determined from its
> refcnt IMHO.
> 
> > 
> > Now consider a scenario where something goes wrong and those firmware
> > commands never complete, and a device reset is required to recover. The
> > driver’s per-queue tracking logic stops all queues (including zombie
> > ones), determines which commands were lost, cleans up the side effects
> > of that lost state, and then restarts all queues. That is how we would
> > end up in this work item with a zombie queue. The restart logic could
> > probably be made smart enough to avoid queueing work for zombie queues,
> > but in my opinion it’s safe enough to use kref_get_unless_zero() in the
> > work items.
> 
> Well, that only works for single-step teardown, or when you enter the
> last step. At which point, I'm not too sure it's significantly better
> than encoding the state of the queue through a separate field, and have
> the job queue logic reject new jobs if the queue is no longer usable
> (shouldn't even be exposed to userland at this point though).
> 

'shouldn't even be exposed to userland at this point though' - Yes.

The philosophy of ref counting design is roughly:

- When queue is created by userland call drm_dep_queue_init
- All jobs hold a ref to drm_dep_queue
- When userland close queue, remove it from the FD, call
  drm_dep_queue_put + initiatie teardown (I'd recommned just setting TDR
  to immediately fire, kick off queue from device in first fire + signal
  all fences).
- Queue refcount goes to zero optionality implement
  drm_dep_queue_ops.fini to keep the drm_dep_queue (and object it is
  embedded) around for a bit longer if additional firmware / device side
  resources are still around, call drm_dep_queue_fini when this part
  completes. If drm_dep_queue_ops.fini isn't implement the core
  implementation just calls drm_dep_queue_fini.
- Work item releases drm_dep_queue out dma-fence signaling path for safe
  memory release (e.g., take dma-resv locks).


> > 
> > It should also be clear that a DRM dep queue is primarily intended to be
> > embedded inside the driver’s own queue object, even though it is valid
> > to use it as a standalone object. The async teardown flows are also
> > optional features.
> > 
> > Let’s also consider a case where you do not need the async firmware
> > flows described above, but the DRM dep queue is still embedded in a
> > driver-side object that owns memory via dma-resv. The final queue put
> > may occur in IRQ context (DRM dep avoids kicking a worker just to drop a
> > refi as opt in), or in the reclaim path (any scheduler workqueue is the
> > reclaim path). In either case, you cannot free memory there taking a
> > dma-resv lock, which is why all DRM dep queues ultimately free their
> > resources in a work item outside of reclaim. Many drivers already follow
> > this pattern, but in DRM dep this behavior is built-in.
> 
> I agree deferred cleanup is the way to go.
> 

+1. Yes. I spot a bunch of drivers that open code this part driver side,
Xe included.

> > 
> > So I don’t think Rust natively solves these types of problems, although
> > I’ll concede that it does make refcounting a bit more sane.
> 
> Rust won't magically defer the cleanup, nor will it dictate how you want
> to do the queue teardown, those are things you need to implement. But it
> should give visibility about object lifetimes, and guarantee that an
> object that's still visible to some owners is usable (the notion of
> usable is highly dependent on the object implementation).
> 
> Just a purely theoretical example of a multi-step queue teardown that
> might be possible to encode in rust:
> 
> - MyJobQueue<Usable>: The job queue is currently exposed and usable.
>   There's a ::destroy() method consuming 'self' and returning a
>   MyJobQueue<Destroyed> object
> - MyJobQueue<Destroyed>: The user asked for the workqueue to be
>   destroyed. No new job can be pushed. Existing jobs that didn't make
>   it to the FW queue are cancelled, jobs that are in-flight are
>   cancelled if they can, or are just waited upon if they can't. When
>   the whole destruction step is done, ::destroyed() is called, it
>   consumes 'self' and returns a MyJobQueue<Inactive> object.
> - MyJobQueue<Inactive>: The queue is no longer active (HW doesn't have
>   any resources on this queue). It's ready to be cleaned up.
>   ::cleanup() (or just ::drop()) defers the cleanup of some inner
>   object that has been passed around between the various
>   MyJobQueue<State> wrappers.
> 
> Each of the state transition can happen asynchronously. A state
> transition consumes the object in one state, and returns a new object
> in its new state. None of the transition involves dropping a refcnt,
> ownership is just transferred. The final MyJobQueue<Inactive> object is
> the object we'll defer cleanup on.
> 
> It's a very high-level view of one way this can be implemented (I'm
> sure there are others, probably better than my suggestion) in order to
> make sure the object doesn't go away without the compiler enforcing
> proper state transitions.
> 

I'm sure Rust can implement this. My point about Rust is it doesn't
magically solve hard software arch probles, but I will admit the
ownership model, way it can enforce locking at compile time is pretty
cool.

> > > > > +/**
> > > > > + * DOC: DRM dependency fence
> > > > > + *
> > > > > + * Each struct drm_dep_job has an associated struct drm_dep_fence that
> > > > > + * provides a single dma_fence (@finished) signalled when the hardware
> > > > > + * completes the job.
> > > > > + *
> > > > > + * The hardware fence returned by &drm_dep_queue_ops.run_job is stored as
> > > > > + * @parent. @finished is chained to @parent via drm_dep_job_done_cb() and
> > > > > + * is signalled once @parent signals (or immediately if run_job() returns
> > > > > + * NULL or an error).  
> > > > 
> > > > I thought this fence proxy mechanism was going away due to recent work being
> > > > carried out by Christian?
> > > >   
> > 
> > Consider the case where a driver’s hardware fence is implemented as a
> > dma-fence-array or dma-fence-chain. You cannot install these types of
> > fences into a dma-resv or into syncobjs, so a proxy fence is useful
> > here.
> 
> Hm, so that's a driver returning a dma_fence_array/chain through
> ::run_job()? Why would we not want to have them directly exposed and
> split up into singular fence objects at resv insertion time (I don't
> think syncobjs care, but I might be wrong). I mean, one of the point

You can stick dma-fence-arrays in syncobjs, but not chains.

Neither dma-fence-arrays/chain can go into dma-resv.

Hence why disconnecting a job's finished fence from hardware fence IMO
is good idea to keep so gives drivers flexiblity on the hardware fences.
e.g., If this design didn't have a job's finished fence, I'd have to
open code one Xe side.

> behind the container extraction is so fences coming from the same
> context/timeline can be detected and merged. If you insert the
> container through a proxy, you're defeating the whole fence merging
> optimization.

Right. Finished fences have single timeline too...

> 
> The second thing is that I'm not sure drivers were ever supposed to
> return fence containers in the first place, because the whole idea
> behind a fence context is that fences are emitted/signalled in
> seqno-order, and if the fence is encoding the state of multiple
> timelines that progress at their own pace, it becomes tricky to control
> that. I guess if it's always the same set of timelines that are
> combined, that would work.

Xe does this is definitely works. We submit to multiple rings, when all
rings signal a seqno, a chain or array signals -> finished fence
signals. The queues used in this manor can only submit multiple ring
jobs so the finished fence timeline stays intact. If you could a
multiple rings followed by a single ring submission on the same queue,
yes this could break.

> 
> > One example is when a single job submits work to multiple rings
> > that are flipped in hardware at the same time.
> 
> We do have that in Panthor, but that's all explicit: in a single
> SUBMIT, you can have multiple jobs targeting different queues, each of
> them having their own set of deps/signal ops. The combination of all the
> signal ops into a container is left to the UMD. It could be automated
> kernel side, but that would be a flag on the SIGNAL op leading to the
> creation of a fence_array containing fences from multiple submitted
> jobs, rather than the driver combining stuff in the fence it returns in
> ::run_job().

See above. We have a dedicated queue type for these type of submissions
and single job that submits to the all rings. We had multiple queue /
jobs in the i915 to implemented this but it turns out it is much cleaner
with a single queue / singler job / multiple rings model.

> 
> > 
> > Another case is late arming of hardware fences in run_job (which many
> > drivers do). The proxy fence is immediately available at arm time and
> > can be installed into dma-resv or syncobjs even though the actual
> > hardware fence is not yet available. I think most drivers could be
> > refactored to make the hardware fence immediately available at run_job,
> > though.
> 
> Yep, I also think we can arm the driver fence early in the case of
> JobQueue. The reason it couldn't be done before is because the
> scheduler was in the middle, deciding which entity to pull the next job
> from, which was changing the seqno a job driver-fence would be assigned
> (you can't guess that at queue time in that case).
> 

Xe doesn't need to late arming, but it look like multiple drivers to
implement the late arming which may be required (?).

> [...]
> 
> > > > > + * **Reference counting**
> > > > > + *
> > > > > + * Jobs and queues are both reference counted.
> > > > > + *
> > > > > + * A job holds a reference to its queue from drm_dep_job_init() until
> > > > > + * drm_dep_job_put() drops the job's last reference and its release callback
> > > > > + * runs. This ensures the queue remains valid for the entire lifetime of any
> > > > > + * job that was submitted to it.
> > > > > + *
> > > > > + * The queue holds its own reference to a job for as long as the job is
> > > > > + * internally tracked: from the moment the job is added to the pending list
> > > > > + * in drm_dep_queue_run_job() until drm_dep_job_done() kicks the put_job
> > > > > + * worker, which calls drm_dep_job_put() to release that reference.  
> > > > 
> > > > Why not simply keep track that the job was completed, instead of relinquishing
> > > > the reference? We can then release the reference once the job is cleaned up
> > > > (by the queue, using a worker) in process context.  
> > 
> > I think that’s what I’m doing, while also allowing an opt-in path to
> > drop the job reference when it signals (in IRQ context)
> 
> Did you mean in !IRQ (or !atomic) context here? Feels weird to not
> defer the cleanup when you're in an IRQ/atomic context, but defer it
> when you're in a thread context.
> 

The put of a job in this design can be from an IRQ context (opt-in)
feature. xa_destroy blows up if it is called from an IRQ context,
although maybe that could be workaround.

> > so we avoid
> > switching to a work item just to drop a ref. That seems like a
> > significant win in terms of CPU cycles.
> 
> Well, the cleanup path is probably not where latency matters the most.

Agree. But I do think avoiding a CPU context switch (work item) for a
very lightweight job cleanup (usually just drop refs) will save of CPU
cycles, thus also things like power, etc...

> It's adding scheduling overhead, sure, but given all the stuff we defer
> already, I'm not too sure we're at saving a few cycles to get the
> cleanup done immediately. What's important to have is a way to signal
> fences in an atomic context, because this has an impact on latency.
> 

Yes. The signaling happens first then drm_dep_job_put if IRQ opt-in.

> [...]
> 
> > > > > + /*
> > > > > + * Drop all input dependency fences now, in process context, before the
> > > > > + * final job put. Once the job is on the pending list its last reference
> > > > > + * may be dropped from a dma_fence callback (IRQ context), where calling
> > > > > + * xa_destroy() would be unsafe.
> > > > > + */  
> > > > 
> > > > I assume that “pending” is the list of jobs that have been handed to the driver
> > > > via ops->run_job()?
> > > > 
> > > > Can’t this problem be solved by not doing anything inside a dma_fence callback
> > > > other than scheduling the queue worker?
> > > >   
> > 
> > Yes, this code is required to support dropping job refs directly in the
> > dma-fence callback (an opt-in feature). Again, this seems like a
> > significant win in terms of CPU cycles, although I haven’t collected
> > data yet.
> 
> If it significantly hurts the perf, I'd like to understand why, because
> to me it looks like pure-cleanup (no signaling involved), and thus no
> other process waiting for us to do the cleanup. The only thing that
> might have an impact is how fast you release the resources, and given
> it's only a partial cleanup (xa_destroy() still has to be deferred), I'd
> like to understand which part of the immediate cleanup is causing a
> contention (basically which kind of resources the system is starving of)
> 

It was more of once we moved to a ref counted model, it is pretty
trivial allow drm_dep_job_put when the fence is signaling. It doesn't
really add any complexity either, thus why I added it is.

Matt

> Regards,
> 
> Boris
