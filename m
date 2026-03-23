Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D33FEC01A0
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 07:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB30510E3FF;
	Mon, 23 Mar 2026 07:59:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="m0aWmLjs";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFF5A10E3FC;
 Mon, 23 Mar 2026 07:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774252742; x=1805788742;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=1rZwKpQK60f3KgIEfZ88fNM0hP0gV3MqPldVksyQwAY=;
 b=m0aWmLjsFG8sZ03lL+Ha2giXPYk5K/R4P+3gUj8D73PVxCEkbZY1RaAI
 +WaVn32EdSZF0d1HoTnYr8tNuQgBdnKKM0lV+UG8DtCYLH4Cor4WtqzCm
 BoQ9J2u6kanMdv3q7T8sqC+trAFzdMG92iwis8SsjyAoAp/7y9Z2d7vDn
 gsQsdoXM4KZLPBxe3llTvL89yine4sjXOoErpyxPpqbtf1J+isivw0zk6
 lyZlNP1c1+uzZU8PUctbuped/dDd6YlgyDo7fHQH5RLDIcI0FDN3lECmW
 QwVOf3qkjJlH8ZIrtrhpLY8QhEzc9jrxa/EMp1+58HvgNaZgonxeKzDHo Q==;
X-CSE-ConnectionGUID: PtkKneiqRoKcBsxQf2G/aA==
X-CSE-MsgGUID: 6jQoIaR6RwG9aZX4Wz42LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75270898"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; d="scan'208";a="75270898"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 00:59:01 -0700
X-CSE-ConnectionGUID: b8MbGWWeR7yyeaWn2cXGIQ==
X-CSE-MsgGUID: YEb+kRNrQ+yujF7odgV5yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; d="scan'208";a="225684750"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 00:58:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 00:58:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 00:58:58 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 00:58:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4Latru6aRyymAEPyBw8sxr/me4Up3bt6kESZkf7lyDdYINARM8+OzXR6bFkg8DCLZX/WsjPU9kQUfXQi5IbYhSFU8/tz+wudgkZrkdqluyqmUHCSxvvEqvNC+kQ3d3jBmnDc6JS7HFIOvJHLawDp0LAqnbTQUixZxQjFkeqdr9epxIJX39E2XEhEF2XMDVanC/Lw8+p0b7ynBC+6zNwNE9lk6mZwLdvBhHwODFV12PLabif6BANDZtu79rcoQrUq+BoUJONTdyjebb4cVXlQVmn1fOKKdteY66NOGBmYwZtMzDauTdvtkHIdwnsZp3lLrUDQOKXIgALz6zuJOXDZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXIS4uOAgG/0G82iqD5+6dbWAq0aceOo8hjtuQ4tZSc=;
 b=LtjJG+llMj/NPhueBSIT5N51XEyUZjF9pDhmde+2iPQ8tZGm+Y7A787q+5w8xYrOs/0asWhHYKiFyLGnKVQU07f5qqhb8u+ZTN56xe1SV44c6CaWYtyLkajT+EAotJJSVb0BFi5dFXhy5U9oliOteozX/odZKPw108beGJ0q4jx/UZ9Lc/uaOwYOeGHdGZj8dQcKRUJWL6S6g2tW5dULKfuiHg6iFB1QidU9Vt+dRJ1yDjF8GpNyw8x5eEp5C4gYfxx/3WMQIDSOfBwrZNfxeVhvGZnnVXDSxdJ8gknjlvG3mmKopKQg7K6dILg9l6D41YrjCQ1dXgpZsSdCFssWpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by SA0PR11MB4621.namprd11.prod.outlook.com (2603:10b6:806:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 07:58:56 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 07:58:56 +0000
Date: Mon, 23 Mar 2026 00:58:51 -0700
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
Message-ID: <acDyu5M7KY0qQ5aD@lstrano-desk.jf.intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <7A8108C7-7CF0-4EA4-95ED-8003502DC35A@collabora.com>
 <abjqfXERS6Xk4FAQ@lstrano-desk.jf.intel.com>
 <abmaDElHmbQkYy57@lstrano-desk.jf.intel.com>
 <20260317214320.74e6c130@fedora>
 <absp4z1Op0BrXReP@lstrano-desk.jf.intel.com>
 <20260319105729.2c20116d@fedora>
 <ab+PgBzwJkhhj6dw@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab+PgBzwJkhhj6dw@lstrano-desk.jf.intel.com>
X-ClientProxiedBy: MW4PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:303:8e::14) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|SA0PR11MB4621:EE_
X-MS-Office365-Filtering-Correlation-Id: c24f8150-e260-49a4-013e-08de88b20862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: dg87T81nM5DjvD+4ml61qu8v/VLPdggRqMirNStvtONRhjaqap7ozMlYAnP83PgPUqTL9DLRQY3PKkd6Oa84VbxLAdq855/kw6QFRNa+OVmV94HY2Ir0puTQPnR23q3JYuVaFCmJrFQqfbabiWVJlWETH+OKdoG3DISTB1G2jg8CtAXvEas9PCXX+fueGTN4u9dH8+8O/10MbFvZd6/aaQ1WFjTHZ7w2T3Dl1hVB5SfEg9qvgweyXBBx+Biuxpt214oU+6Yu9r/C4GIyeP2YsrVDdcFTmLvKxQw6nLbPo6VotFvtWNbZZXl2DmdQcj8dMQQ7v8ZalUltoga1k9q0Lr/B3ya3SNWtSjAZJDcFb8NZURjYDV5ZVdrC53SjhgZfFORDAIZWqf14d6cCKt8ZVKKsd9ccE0OhztMTVqXEYZ2rewiwAH7gaEY7I8OtECdzUz2NRmXLrkRsNSR/wcZ4gBH/BQKL8aItOPWXUVC94YHxf7zd2u2EjOAmv8TcDTicx3n8MKFCKkx8kRhxDxMw6eHINXq5QlLVNAyO8heeFzpRhCUdkf95/zrBVV+2S2516S9Ug785m9k9tSPReSwIVIgbPNiqwaMPSTboqc1DS0IaY2W+UC8wdkSAwNMvo/45opbAaXs3VxxU1XEy2Z5yEnlw/zVJ+ne0pQ0ANwnz1RGtc6wcNfVADw16IbAWVUi/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkRGUnhoQ2hJeXlEUXo0K1VuZ29wZDJsVWx1NXlYdGFTR0h2dWFhVjlUaWh6?=
 =?utf-8?B?bnNCOHBwN0FVZ1dwRVI2RFlqd2xLcURsT2tucGRTbEZrc1VEK254T1Y1K0Jh?=
 =?utf-8?B?ZVVoNlR1aDdtck1xVy93amlVbHhFQmRKR2dRL2JkK3RpTitncTIwL01NYkJK?=
 =?utf-8?B?MWYzeEJvMlFua1BVY1BIVXV5QnJlQ0poM1Y3cTExNmdnOEh3NGJEcHZ0VTBj?=
 =?utf-8?B?d0c1Nk5FVmdNWXpQMktYdk1sY3ptUDBFZU5jeDhDYlpBRG5PU3QzOWQvc3hS?=
 =?utf-8?B?bEw1clc0S0tvaW1aVFRpdE9zN2NZTWVvM1hsQUxqVWxxOUk0ZlhHakxhSWhN?=
 =?utf-8?B?UzVzV056bk9ySEtzUTFOSkk5MzZkV3Ewd1U4QkFRbTBIem05YVpFeG55ZDNj?=
 =?utf-8?B?TUFqbU1lRFJHRTR1dHhJS3NQTHpyck1YdXlyc1gxVVh0UldKS05MNVVKSzBn?=
 =?utf-8?B?SGxMVlZUSUFoUmVTbDJieWtxK3d5LzgwSVVPV2RqUUNkUHJJZm8yQ3ZXM0xR?=
 =?utf-8?B?TEFxUjRMRzltMmxzdHFab09zRXlWNjNnaHhoRFFCV0o0UXRWanRNSTFRVVdi?=
 =?utf-8?B?R0RvQWFjdDVwdHh3dkxVRDQrTWxjQzJDKzJmeWRpWEd3RXhKK2RWZkRHdXk1?=
 =?utf-8?B?T0tTMmo0RWZCZWtjN1Y1Zm9IL1RUejBFWEN5MTl0bE5pQ1FBWXBDSklOdnFT?=
 =?utf-8?B?dXRGYUVmNnVqcUxYWG9vbXovYUJsRUhQc2lxWUxvUW1NV3phU0xNRHh3ZzhI?=
 =?utf-8?B?ZVRsNUZkRHluWllwSU9hL3h5ZnByNWJXSUhOcGlRWFdRRjBIdGt0aENaOHNL?=
 =?utf-8?B?Nlh3dU1SWFdwSldDWU81WStqRnhQaTZMUEgwbjkwaDZNaStNVWt1Z0xJbGw0?=
 =?utf-8?B?RWlSOGN2THhnTWxoZzA2cWcxZjcwNHU3T21ueGU2TmpncE5RZHEycENSK0xB?=
 =?utf-8?B?aHg5SGJieDQ2MVVXblgyM1hQZDF3ZUNZVS90bklLR3N0R3NIMlUzdG9jdkRr?=
 =?utf-8?B?MHZadlhzSHFKVzBWNUNJcU5IV2dOVk94aWczanJhVzdFOExEVzMvOFJmYkZy?=
 =?utf-8?B?WkZlM1ZZRFNsUytTU1c0MVhDNFN1elFTaWNueDY2U0NBTStXZ0RHOFMxK2xT?=
 =?utf-8?B?ZHJLelEvMGhtTHhBSUh5aVFPdG5BZ244OSs5bTJPbWxucEt4cmlXbXVEZmVF?=
 =?utf-8?B?TG9EV25zWjJDWVlpVWFSWFE0T2dtRUhQWGxiSCtiK0hkQnZnNnJNNm5IYlVp?=
 =?utf-8?B?b3FzZ3FrSUtVeW53TFdpby83NzhUekhpaGZPYitqaWs5MzUrSUE1RVpkSjF3?=
 =?utf-8?B?eFJPSjBOMEg5Y0ttOEpBNk1yK1AxUWpPbmNsWlV6bTB2WmRQZndKbEpYUEZF?=
 =?utf-8?B?dHJSOS9NcWRhOXZuMWJUTmp5UnhwWXIvTlhvRVNXcDBxNk5EN1NMRzh1RWM0?=
 =?utf-8?B?cDVDVnpzLzdRVnhmZ3l3aGZiUVN6Si9jWXRXNXpoZ3BVQStodlBxMWtRVHBU?=
 =?utf-8?B?TjJiSnNQQyszaE1SWEF6MzNNS3g4VzlrVlhra1FFWEFMemRiaTJ2OEdjbUxo?=
 =?utf-8?B?ek5tOEJGcmRablhJcWtZVENyU2kvUExpWHgrclNoa0MxMGg0M2RFMlprT0Ri?=
 =?utf-8?B?YUcvV29wSzJDZ1hpWHhGMkpyaVNHK0VOYk82UStaK1RpUCtsWE9IR2xseGRj?=
 =?utf-8?B?cWl2aTFIVXNVK3k3V3Y4R2ZPNmV3SlV0aGx5NUJDTmlGcllJclVwdm1Db3li?=
 =?utf-8?B?VVZBQWFRQ2VRVnFWcDhMZXJKOXF1SHRVd2ZrL3dTZ21qYVBVMWpRbUl3UFpw?=
 =?utf-8?B?aDJraUpnWUgwcFY5eGRjVGUxdnMwTmVvOUlrM2VYUitQTHJ0VVRhcVpYcldI?=
 =?utf-8?B?N0F0VTZUK3FhbmVyMXVjbWIzVDBiZWZ2STVCYkJjczkvaHZUVjRYbnVzVytB?=
 =?utf-8?B?akJkL1I4bS9rN0YySGVZa2d3MnkwYnFpK0hsNWcyQ3JGVzhBOVBCR0owbmls?=
 =?utf-8?B?Ym8zTVhrVmhXNlVUYnNla3R4U280R0o2VGJaZmtUVHU2QUFFUnViK0JpVmRL?=
 =?utf-8?B?LzVFUWFmSTBSZmw3ekxIMkVJSEprSU1iMm1OMHZTSXFmUzFLK2FmSCtrcWs1?=
 =?utf-8?B?T3RjZzN0c1VVQURjZWpzK2ZhUWUrMmtwWjJYZFhjWElyQzE5dzBiK3FLQnBY?=
 =?utf-8?B?ZFBwdHFXUklteWJHT2p0eFFtUHd1RysvYXJ2QmQrVzJTRitIMXVITDhDYWpm?=
 =?utf-8?B?STgxRmxrc1ZMeW1EODMvMURpRGVCbG9rTzU3bjhuYU5kK0pSMjRyTS9zdkNZ?=
 =?utf-8?B?M05teVdQQjhVbjN4LyttOC9VajJwSEVxZUdKRVArZ1luRDhHTkk2QT09?=
X-Exchange-RoutingPolicyChecked: OqVxSua6gB7fu4PLcuN2WlawzmGjAaHT5d1yuLB30HHPazsFxubxf0ALxhwdQOweSqyORIhS+bGlwTZ5FlmIHQJlaQEWyI8tj7x15UX/xKcFrFBdoxO70LtIclfjNNXmvOvADDbW2U6VCXEOU1RCI/FyGO8949vCUSm1ZCZj5Xdvc+eOEJF29PCTLipuzXgxp8tQ7iDbaJOhV42SVd+N0yM2y75Lwnrt4LHWNLUGLlS1ik2aXf4lZ84UO4/2OPi7u5sDW2onWeHcBNOD4fzAQ/wyheW7lMN9Nwi0DSGVWSZAb1JHv7eiKlcrA7utAyUpxCexA2aFNwi6s5gI5U073w==
X-MS-Exchange-CrossTenant-Network-Message-Id: c24f8150-e260-49a4-013e-08de88b20862
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 07:58:56.1339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wiNgTmG2XsTHKOHPGNTW7rrgvCPBYbLtCfZmUOpa33xJ5mRIXa/44iva1bDixOdNUrI2UDlJ89v98i27grucFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4621
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

On Sat, Mar 21, 2026 at 11:43:12PM -0700, Matthew Brost wrote:
> On Thu, Mar 19, 2026 at 10:57:29AM +0100, Boris Brezillon wrote:
> > On Wed, 18 Mar 2026 15:40:35 -0700
> > Matthew Brost <matthew.brost@intel.com> wrote:
> > 
> > > > > 
> > > > > So I don’t think Rust natively solves these types of problems, although
> > > > > I’ll concede that it does make refcounting a bit more sane.  
> > > > 
> > > > Rust won't magically defer the cleanup, nor will it dictate how you want
> > > > to do the queue teardown, those are things you need to implement. But it
> > > > should give visibility about object lifetimes, and guarantee that an
> > > > object that's still visible to some owners is usable (the notion of
> > > > usable is highly dependent on the object implementation).
> > > > 
> > > > Just a purely theoretical example of a multi-step queue teardown that
> > > > might be possible to encode in rust:
> > > > 
> > > > - MyJobQueue<Usable>: The job queue is currently exposed and usable.
> > > >   There's a ::destroy() method consuming 'self' and returning a
> > > >   MyJobQueue<Destroyed> object
> > > > - MyJobQueue<Destroyed>: The user asked for the workqueue to be
> > > >   destroyed. No new job can be pushed. Existing jobs that didn't make
> > > >   it to the FW queue are cancelled, jobs that are in-flight are
> > > >   cancelled if they can, or are just waited upon if they can't. When
> > > >   the whole destruction step is done, ::destroyed() is called, it
> > > >   consumes 'self' and returns a MyJobQueue<Inactive> object.
> > > > - MyJobQueue<Inactive>: The queue is no longer active (HW doesn't have
> > > >   any resources on this queue). It's ready to be cleaned up.
> > > >   ::cleanup() (or just ::drop()) defers the cleanup of some inner
> > > >   object that has been passed around between the various
> > > >   MyJobQueue<State> wrappers.
> > > > 
> > > > Each of the state transition can happen asynchronously. A state
> > > > transition consumes the object in one state, and returns a new object
> > > > in its new state. None of the transition involves dropping a refcnt,
> > > > ownership is just transferred. The final MyJobQueue<Inactive> object is
> > > > the object we'll defer cleanup on.
> > > > 
> > > > It's a very high-level view of one way this can be implemented (I'm
> > > > sure there are others, probably better than my suggestion) in order to
> > > > make sure the object doesn't go away without the compiler enforcing
> > > > proper state transitions.
> > > >   
> > > 
> > > I'm sure Rust can implement this. My point about Rust is it doesn't
> > > magically solve hard software arch probles, but I will admit the
> > > ownership model, way it can enforce locking at compile time is pretty
> > > cool.
> > 
> > It's not quite about rust directly solving those problems for you, it's
> > about rust forcing you to think about those problems in the first
> > place. So no, rust won't magically solve your multi-step teardown with
> > crazy CPU <-> Device synchronization etc, but it allows you to clearly
> > identify those steps, and think about how you want to represent them
> > without abusing other concepts, like object refcounting/ownership.
> > Everything I described, you can code it in C BTW, it's just that C is so
> > lax that you can also abuse other stuff to get to your ends, which might
> > or might not be safe, but more importantly, will very likely obfuscate
> > the code (even with good docs).
> > 
> 
> This is very well put, and I completely agree. Sorry—I get annoyed by
> the Rust comments. It solves some classes of problems, but it doesn’t
> magically solve complex software architecture issues that need to be
> thoughtfully designed.
> 
> > > 
> > > > > > > > +/**
> > > > > > > > + * DOC: DRM dependency fence
> > > > > > > > + *
> > > > > > > > + * Each struct drm_dep_job has an associated struct drm_dep_fence that
> > > > > > > > + * provides a single dma_fence (@finished) signalled when the hardware
> > > > > > > > + * completes the job.
> > > > > > > > + *
> > > > > > > > + * The hardware fence returned by &drm_dep_queue_ops.run_job is stored as
> > > > > > > > + * @parent. @finished is chained to @parent via drm_dep_job_done_cb() and
> > > > > > > > + * is signalled once @parent signals (or immediately if run_job() returns
> > > > > > > > + * NULL or an error).    
> > > > > > > 
> > > > > > > I thought this fence proxy mechanism was going away due to recent work being
> > > > > > > carried out by Christian?
> > > > > > >     
> > > > > 
> > > > > Consider the case where a driver’s hardware fence is implemented as a
> > > > > dma-fence-array or dma-fence-chain. You cannot install these types of
> > > > > fences into a dma-resv or into syncobjs, so a proxy fence is useful
> > > > > here.  
> > > > 
> > > > Hm, so that's a driver returning a dma_fence_array/chain through
> > > > ::run_job()? Why would we not want to have them directly exposed and
> > > > split up into singular fence objects at resv insertion time (I don't
> > > > think syncobjs care, but I might be wrong). I mean, one of the point  
> > > 
> > > You can stick dma-fence-arrays in syncobjs, but not chains.
> > 
> > Yeah, kinda makes sense, since timeline syncobjs use chains, and if the
> > chain reject inner chains, it won't work.
> > 
> 
> +1, Exactly.
> 
> > > 
> > > Neither dma-fence-arrays/chain can go into dma-resv.
> > 
> > They can't go directly in it, but those can be split into individual
> > fences and be inserted, which would achieve the same goal.
> > 
> 
> Yes, but now it becomes a driver problem (maybe only mine) rather than
> an opaque job fence that can be inserted. In my opinion, it’s best to
> keep the job vs. hardware fence abstraction.
> 
> > > 
> > > Hence why disconnecting a job's finished fence from hardware fence IMO
> > > is good idea to keep so gives drivers flexiblity on the hardware fences.
> > 
> > The thing is, I'm not sure drivers were ever meant to expose containers
> > through ::run_job().
> > 
> 
> Well there haven't been any rules...
> 
> > > e.g., If this design didn't have a job's finished fence, I'd have to
> > > open code one Xe side.
> > 
> > There might be other reasons we'd like to keep the
> > drm_sched_fence-like proxy that I'm missing. But if it's the only one,
> > and the fence-combining pattern you're describing is common to multiple
> > drivers, we can provide a container implementation that's not a
> > fence_array, so you can use it to insert driver fences into other
> > containers. This way we wouldn't force the proxy model to all drivers,
> > but we would keep the code generic/re-usable.
> > 
> > > 
> > > > behind the container extraction is so fences coming from the same
> > > > context/timeline can be detected and merged. If you insert the
> > > > container through a proxy, you're defeating the whole fence merging
> > > > optimization.  
> > > 
> > > Right. Finished fences have single timeline too...
> > 
> > Aren't you faking a single timeline though if you combine fences from
> > different engines running at their own pace into a container?
> > 
> > > 
> > > > 
> > > > The second thing is that I'm not sure drivers were ever supposed to
> > > > return fence containers in the first place, because the whole idea
> > > > behind a fence context is that fences are emitted/signalled in
> > > > seqno-order, and if the fence is encoding the state of multiple
> > > > timelines that progress at their own pace, it becomes tricky to control
> > > > that. I guess if it's always the same set of timelines that are
> > > > combined, that would work.  
> > > 
> > > Xe does this is definitely works. We submit to multiple rings, when all
> > > rings signal a seqno, a chain or array signals -> finished fence
> > > signals. The queues used in this manor can only submit multiple ring
> > > jobs so the finished fence timeline stays intact. If you could a
> > > multiple rings followed by a single ring submission on the same queue,
> > > yes this could break.
> > 
> > Okay, I had the same understanding, thanks for confirming.
> > 
> 
> I think the last three comments are resolved here—it’s a queue timeline.
> As long as the queue has consistent rules (i.e., submits to a consistent
> set of rings), this whole approach makes sense?
> 
> > > 
> > > >   
> > > > > One example is when a single job submits work to multiple rings
> > > > > that are flipped in hardware at the same time.  
> > > > 
> > > > We do have that in Panthor, but that's all explicit: in a single
> > > > SUBMIT, you can have multiple jobs targeting different queues, each of
> > > > them having their own set of deps/signal ops. The combination of all the
> > > > signal ops into a container is left to the UMD. It could be automated
> > > > kernel side, but that would be a flag on the SIGNAL op leading to the
> > > > creation of a fence_array containing fences from multiple submitted
> > > > jobs, rather than the driver combining stuff in the fence it returns in
> > > > ::run_job().  
> > > 
> > > See above. We have a dedicated queue type for these type of submissions
> > > and single job that submits to the all rings. We had multiple queue /
> > > jobs in the i915 to implemented this but it turns out it is much cleaner
> > > with a single queue / singler job / multiple rings model.
> > 
> > Hm, okay. It didn't turn into a mess in Panthor, but Xe is likely an
> > order of magnitude more complicated that Mali, so I'll refrain from
> > judging this design decision.
> > 
> 
> Yes, Xe is a beast, but we tend to build complexity into components and
> layers to manage it. That is what I’m attempting to do here.
> 
> > > 
> > > >   
> > > > > 
> > > > > Another case is late arming of hardware fences in run_job (which many
> > > > > drivers do). The proxy fence is immediately available at arm time and
> > > > > can be installed into dma-resv or syncobjs even though the actual
> > > > > hardware fence is not yet available. I think most drivers could be
> > > > > refactored to make the hardware fence immediately available at run_job,
> > > > > though.  
> > > > 
> > > > Yep, I also think we can arm the driver fence early in the case of
> > > > JobQueue. The reason it couldn't be done before is because the
> > > > scheduler was in the middle, deciding which entity to pull the next job
> > > > from, which was changing the seqno a job driver-fence would be assigned
> > > > (you can't guess that at queue time in that case).
> > > >   
> > > 
> > > Xe doesn't need to late arming, but it look like multiple drivers to
> > > implement the late arming which may be required (?).
> > 
> > As I said, it's mostly a problem when you have a
> > single-HW-queue:multiple-contexts model, which is exactly what
> > drm_sched was designed for. I suspect early arming is not an issue for
> > any of the HW supporting FW-based scheduling (PVR, Mali, NVidia,
> > ...). If you want to use drm_dep for all drivers currently using
> > drm_sched (I'm still not convinced this is a good idea to do that
> > just yet, because then you're going to pull a lot of the complexity
> > we're trying to get rid of), then you need late arming of driver fences.
> > 
> 
> Yes, even the hardware scheduling component [1] I hacked together relied
> on no late arming. But even then, you can arm a dma-fence early and
> assign a hardware seqno later in run_job()—those are two different
> things.
> 
> [1] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/22c8aa993b5c9e4ad0c312af2f3e032273d20966#line_7c49af3ee_A319
> 
> > > 
> > > > [...]
> > > >   
> > > > > > > > + * **Reference counting**
> > > > > > > > + *
> > > > > > > > + * Jobs and queues are both reference counted.
> > > > > > > > + *
> > > > > > > > + * A job holds a reference to its queue from drm_dep_job_init() until
> > > > > > > > + * drm_dep_job_put() drops the job's last reference and its release callback
> > > > > > > > + * runs. This ensures the queue remains valid for the entire lifetime of any
> > > > > > > > + * job that was submitted to it.
> > > > > > > > + *
> > > > > > > > + * The queue holds its own reference to a job for as long as the job is
> > > > > > > > + * internally tracked: from the moment the job is added to the pending list
> > > > > > > > + * in drm_dep_queue_run_job() until drm_dep_job_done() kicks the put_job
> > > > > > > > + * worker, which calls drm_dep_job_put() to release that reference.    
> > > > > > > 
> > > > > > > Why not simply keep track that the job was completed, instead of relinquishing
> > > > > > > the reference? We can then release the reference once the job is cleaned up
> > > > > > > (by the queue, using a worker) in process context.    
> > > > > 
> > > > > I think that’s what I’m doing, while also allowing an opt-in path to
> > > > > drop the job reference when it signals (in IRQ context)  
> > > > 
> > > > Did you mean in !IRQ (or !atomic) context here? Feels weird to not
> > > > defer the cleanup when you're in an IRQ/atomic context, but defer it
> > > > when you're in a thread context.
> > > >   
> > > 
> > > The put of a job in this design can be from an IRQ context (opt-in)
> > > feature. xa_destroy blows up if it is called from an IRQ context,
> > > although maybe that could be workaround.
> > 
> > Making it so _put() in IRQ context is safe is fine, what I'm saying is
> > that instead of doing a partial immediate cleanup, and the rest in a
> > worker, we can just defer everything: that is, have some
> > _deref_release() function called by kref_put() that would queue a work
> > item from which the actual release is done.
> > 
> 
> See below.
> 
> > > 
> > > > > so we avoid
> > > > > switching to a work item just to drop a ref. That seems like a
> > > > > significant win in terms of CPU cycles.  
> > > > 
> > > > Well, the cleanup path is probably not where latency matters the most.  
> > > 
> > > Agree. But I do think avoiding a CPU context switch (work item) for a
> > > very lightweight job cleanup (usually just drop refs) will save of CPU
> > > cycles, thus also things like power, etc...
> > 
> > That's the sort of statements I'd like to be backed by actual
> > numbers/scenarios proving that it actually makes a difference. The
> 
> I disagree. This is not a locking micro-optimization, for example. It is
> a software architecture choice that says “do not trigger a CPU context
> to free a job,” which costs thousands of cycles. This will have an
> effect on CPU utilization and, thus, power.
> 
> > mixed model where things are partially freed immediately/partially
> > deferred, and sometimes even with conditionals for whether the deferral
> > happens or not, it just makes building a mental model of this thing a
> > nightmare, which in turn usually leads to subtle bugs.
> > 
> 
> See above—managing complexity in components. This works in both modes. I
> refactored Xe so it also works in IRQ context. If it would make you feel
> better, I can ask my company commits CI resources so non-IRQ mode
> consistently works too—it’s just a single API flag on the queue. But
> then maybe other companies should also commit to public CI.
> 
> > > 
> > > > It's adding scheduling overhead, sure, but given all the stuff we defer
> > > > already, I'm not too sure we're at saving a few cycles to get the
> > > > cleanup done immediately. What's important to have is a way to signal
> > > > fences in an atomic context, because this has an impact on latency.
> > > >   
> > > 
> > > Yes. The signaling happens first then drm_dep_job_put if IRQ opt-in.
> > > 
> > > > [...]
> > > >   
> > > > > > > > + /*
> > > > > > > > + * Drop all input dependency fences now, in process context, before the
> > > > > > > > + * final job put. Once the job is on the pending list its last reference
> > > > > > > > + * may be dropped from a dma_fence callback (IRQ context), where calling
> > > > > > > > + * xa_destroy() would be unsafe.
> > > > > > > > + */    
> > > > > > > 
> > > > > > > I assume that “pending” is the list of jobs that have been handed to the driver
> > > > > > > via ops->run_job()?
> > > > > > > 
> > > > > > > Can’t this problem be solved by not doing anything inside a dma_fence callback
> > > > > > > other than scheduling the queue worker?
> > > > > > >     
> > > > > 
> > > > > Yes, this code is required to support dropping job refs directly in the
> > > > > dma-fence callback (an opt-in feature). Again, this seems like a
> > > > > significant win in terms of CPU cycles, although I haven’t collected
> > > > > data yet.  
> > > > 
> > > > If it significantly hurts the perf, I'd like to understand why, because
> > > > to me it looks like pure-cleanup (no signaling involved), and thus no
> > > > other process waiting for us to do the cleanup. The only thing that
> > > > might have an impact is how fast you release the resources, and given
> > > > it's only a partial cleanup (xa_destroy() still has to be deferred), I'd
> > > > like to understand which part of the immediate cleanup is causing a
> > > > contention (basically which kind of resources the system is starving of)
> > > >   
> > > 
> > > It was more of once we moved to a ref counted model, it is pretty
> > > trivial allow drm_dep_job_put when the fence is signaling. It doesn't
> > > really add any complexity either, thus why I added it is.
> > 
> > It's not the refcount model I'm complaining about, it's the "part of it
> > is always freed immediately, part of it is deferred, but not always ..."
> > that happens in drm_dep_job_release() I'm questioning. I'd really
> > prefer something like:
> > 
> 
> You are completely missing the point here.
> 

Let me rephrase this — I realize this may come across as rude, which is
not my intent. I believe there is simply a disconnect in understanding
the constraints.

In my example below, the job release completes within bounded time
constraints, which makes it suitable for direct release in IRQ context,
bypassing the need for a work item that would otherwise incur a costly
CPU context switch.

Matt

> Here is what I’ve reduced my job put to:
> 
> 188         xe_sched_job_free_fences(job);
> 189         dma_fence_put(job->fence);
> 190         job_free(job);
> 191         atomic_dec(&q->job_cnt);
> 192         xe_pm_runtime_put(xe);
> 
> These are lightweight (IRQ-safe) operations that never need to be done
> in a work item—so why kick one?
> 
> Matt
> 
> > static void drm_dep_job_release()
> > {
> > 	// do it all unconditionally
> > }
> > 
> > static void drm_dep_job_defer_release()
> > {
> > 	queue_work(&job->cleanup_work);
> > }
> > 
> > static void drm_dep_job_put()
> > {
> > 	kref_put(job, drm_dep_job_defer_release);
> > }
