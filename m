Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D191088E4B
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 23:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6EA010E464;
	Wed, 18 Mar 2026 23:02:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XkBiuGBR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5194910E06A;
 Wed, 18 Mar 2026 23:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773874962; x=1805410962;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=+jufJxUXlvLRM8SDiXtwu54Inp2XTLfw4K0jkVs6Ia4=;
 b=XkBiuGBRAKuQ9sSmxZMJsXLnd5b+7loTDMWFd8c1cGpKd+5yWdOa1+nF
 Z9yj5BebmRU0EEc5v92u55RPUXv8BH8JKKdPBKWWQZwma5ShQnpAhsok3
 Rqz76G095XknPRPiL2ZS0f1UiGnePQxlNETHihwD+M2MKUxS5ttUci/ZY
 PPKvvam0cugXL/2cQSP/EdJKEefrjrc634z/sboI7IMW1qQwFdNHvM6dw
 RlHA1E3aA61uv3VWFkxsg0Aouu3Qkvh7bqo83F+QFy+FtkXpQebZDrQH0
 aDRF4ASxo9hGGCFf3yW/8Ivh6mq/pbXuSdQ+MwSsbq3QQ3xdJlFo0iORl A==;
X-CSE-ConnectionGUID: tDozf2Q3Twyqen/GBOGx9g==
X-CSE-MsgGUID: s3OkhYQZThK1HcTH3DHx/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74976984"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; d="scan'208";a="74976984"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 16:02:40 -0700
X-CSE-ConnectionGUID: XOwm3BrgR+qneBqiZ+68DA==
X-CSE-MsgGUID: cjHCJagKQ1qo6kwwNBwFwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; d="scan'208";a="226917021"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 16:02:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 16:02:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 16:02:36 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 16:02:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKtzDt3Yb94as5+SoO8NtyAksytl3XWM/wR2bLXmff6CL582I+aHK1wEH4QfrAxju+3syKFLS34b/yV+4+kZ6OVT400CpWbksnZQ3y3xrPZFiShDz9SZ1BgAKNf6RyjCZZcjKdX9JIdfkK3zroJ7yq1ZjPjhyHcEHUAQQpa5YKLWY/KUQoPb073UG4vDyJuXHNDQ8nF7P7oObEip8pHiW2lVpBnunulQoYdDp2/Cz4XmI6z2OaHYoZOKjGvt7L1oQNkQcI6UryVxsHYgcZW5/21p0P7TkvXfnGfeWT7xKAreda6GYqfibx3k7JIdk+iioVO7bU1xLRYD6Cl9pQPO4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niY6AB2rk04QY/yMbfGtzrGUYDe1NY2kPY+z7i7mrcc=;
 b=jTf0dFgqO3VKmKMom4ESRMl2p1r+9TErdqeydK4hHdBmyJknuELYDKL19lizrhGwlZFB+arZ/aHWr5xQLdTEPOeyIugN3VYAy1u4IKoE+WcpihTFzhl7TCBtnqXv4wXzLRVFi8hmqW0zUh0v+EtsNv/E2JcOmjBF4QiI/6vlv8AxRkSccAQWyrb5enTO3Ee/LIGUjebFh+O36FF+almPDSJGqiKxcasAXFfLMBW6z4GA0Lpnlo/c5V9lpyvvTm0ZeKdohFDxJA5g5q4vyF2CnFp7RL+sBaDeKaWkIPTgsg8g0azUxBvVZHQ5kZx2Nw/UDEGCzle8T4Y2NpIG3+87HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by CHXPR11MB9676.namprd11.prod.outlook.com (2603:10b6:610:2fc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 23:02:32 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9723.014; Wed, 18 Mar 2026
 23:02:32 +0000
Date: Wed, 18 Mar 2026 16:02:28 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 "Boris Brezillon" <boris.brezillon@collabora.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, Christian
 =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, <linux-kernel@vger.kernel.org>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
Message-ID: <absvBHTRh/zqeWan@lstrano-desk.jf.intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <DH44U26ZLJS2.3DTS9D6PA0IL4@kernel.org>
 <abjiTQe4/mRQ8wyA@lstrano-desk.jf.intel.com>
 <DH51W6XRQXYX.3M30IRYIWZLFG@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DH51W6XRQXYX.3M30IRYIWZLFG@kernel.org>
X-ClientProxiedBy: MW4PR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:303:6a::8) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|CHXPR11MB9676:EE_
X-MS-Office365-Filtering-Correlation-Id: de4294fc-d56e-4c53-9d74-08de85426fd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Uxo0AxEPnGOO6IPzuSELzGfkDJtuJiGDVn8WnrzdSggDi2tFMMLU/CIS27LKCl86k9DyYGMpawe1DDyiTdlzb8DodIpweiuBcCGWUzcw8TyK8QQ/LpfA09XQoAZMRDijuFEH7g8QcFQwoamfhqB0rhbIW2XAMxJIOV+ERFoFUhl45psrlO1H9oeJ9RU3D2nEQDM17klV8apE9Y/qECo+7J42WFrCexPsq9PUF+Q3yAUvLTgqJ+afghURvOrYCgoklY88fWHw1bKqgyGryjBVmnE9v9af1YIuEnVQ1fBOah4QSVUy3miBg7x2oqArE+089IGOVB4IJtLCL4RsCmSr0y/bbCRVo9KATUfWfyBEyNqHCosnB2XD1HYGfJwXcYj+CBYzaXB056JJxowytB3SmXgXTyUcAWn9hxv5HZCOy+wtGf/YqNFiPe4469qhV1w7fxA7e9biaPhvEoDFTpitO0KAIzfsmmJEVNnhR2sGbH5vJM9R98kQh849m5P87Amu4ecc6nSWzqkg5bjEi+j85P9tbq26QcghSuX27dgUlruzs5N6ungIehxFhWZ/lAyCRojAUdobLgnllcQWQUH2hGbXkZ/5HRIuwKIPPtxYCXsQQbF7zJUakuHQjrhERKkfJaOmDZdLLGB06VsJQi7ZYneOlIavZ2FGMm1xGmDE/9Dto1rvfWcG8WBOY6H4Um8w
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXhwdVMzbnlnWkF5TkZ6UHlmUmduOFRLK1NDY2tQT3FqZlN0YjdERUxxVXZZ?=
 =?utf-8?B?Skl0NmRDdXVFdGRqeERrd1RkTGNiNU45QXMybFg4R3BjVS93NlQ5YWkwYkNC?=
 =?utf-8?B?SzFUMHNIaTZydFJmS2hFSTZZUWwvazhycU10YUE5c3VrUGpTM2VtejN5U3Vq?=
 =?utf-8?B?WFZkSDh0S2JJcmluOHZCUk1yL21sWWMzZU1EK0RrYzNBbTZZTmZzaXZKMzlU?=
 =?utf-8?B?Uk1yQWVwYzVVUUtud2cxRXZoVkxzd3BpQjA0TGRwR2c5YUdJSU1nM09jaWk5?=
 =?utf-8?B?VVRyQ05uZk9Nd0llZkJQVER3OTRuZEkxUGdzOE9jeXUrMDYrcGFiQTdvUWds?=
 =?utf-8?B?b3VwTTRXZzllSGN1N0QzeTJMWlNRc01uNlRiblJtL0RxMjdWUXJQUlRmeWRY?=
 =?utf-8?B?MGRaR240V3NEeVlHTkFZZ3dKalhlRHVsWG5IbkxIS2t6ejFaRnMvNjFaUzJS?=
 =?utf-8?B?b21SSC85aHdVbnJMUzB0M0FoaTMwMENvVHZXdEg0NWlVS0ZhVUJNMDNubkVk?=
 =?utf-8?B?NjFvWENTb2JRMTBXVnFMSit1WFZHUHhlV2RoYzhIakQweXB6aDBjN2UwaEQ2?=
 =?utf-8?B?VFNsa2RYNm15OEZqR3lhU2JVL1FIOS9pWG0yNWR0SWJtMXhsR0tmc1JvczZU?=
 =?utf-8?B?Zk1pMEZqbU5rRUwyZ0gzQlhYZTZmVGtORWNXNW5HbDJmajNTWWo5RldwUVJq?=
 =?utf-8?B?eExwZFNnSmsrbC8zQWpxWGprSTZrZlp3anM0NDhiVUxBU2x3ejcwb2IyZVVD?=
 =?utf-8?B?aXRHbFZ3REtIY3NTeGc2eC9yS1V5RllUYkQweXdkcEZHSUtkMm9pMklWNjBG?=
 =?utf-8?B?TDJoVWJBYmlTaWMvNlJ3VjlKWmhnSk5vZGFjVFIzdXhYWnViU21lTW9mN0lO?=
 =?utf-8?B?cHBpQy9PK3VpT0xkRkwzaUtJN2ZCRGdlNFJNNEdYTHlUcm5kMjA2YTNnZkQ0?=
 =?utf-8?B?WGFQQW5FeUxEWUJCQlQvRGZXRTM4UjFBQXg0a2EyVjhLTDdtVFFUQ216ZVlL?=
 =?utf-8?B?aTZlYXhmNUNmVEFrSWtEa3hXVXhVc091REZlV2tacmhnR3ZFaVNrUWhKVFoy?=
 =?utf-8?B?aFFhUXhzNEpzZnIwVlQ2TGxuVHRVcThRL1VmYXNMTmIwY2hVZVQ5amNIY1VV?=
 =?utf-8?B?K0QvRWlGUXdMK1VZWS9YRGMwWGVsMmVOYTExbDdQMEYxWklpWlIwRzVSancy?=
 =?utf-8?B?U2Y1V1BWQnl4ME5mTXR6VG9YR2s4ZldGNzBQMm1OMG91QW9IVkd4TlNpYzcw?=
 =?utf-8?B?Rlp1WVR3VWZtOHBHZTR6SG9ObVNTTzk1Zjk4cTZ6clpCN0VUS2hZaFN2cCsr?=
 =?utf-8?B?OGRUVWxMMzh1MG1IczJZRGhLTFhMVDErZGdvN2JIRkhDa0l4ZzBsMmdkZ1BW?=
 =?utf-8?B?bzBsTVN5SkVabDFpUHZnbE8ySDFiaWFuc3NuZ2x3eUlOeWZuRmNXaXVUV3F1?=
 =?utf-8?B?dG5aNUNRZGxtVEF6RjZTN3I2L1BHUUZFVHFVaW1NVnM4NDlkWVFSaXJzVVE2?=
 =?utf-8?B?aWdoYkNnYkdXOE5vcVJsL3ZTOEs0VXJqeW1VMGljVEJkT0Z3TEJWNEZqQ2FN?=
 =?utf-8?B?WUZGaXpNVFRtVnQ3LzdyNGhyVFU4TjgzTEZyUG5hNHhwc0IwQmJFWGRsK2VH?=
 =?utf-8?B?TnVtenhySHNpdTQvQXdYbExKVkM0c0JlMGJFem9abjFIQ1piTmIrM0VtVzI0?=
 =?utf-8?B?ekFQcEg4dXlMVUlzN2llV3ZMcGJ4cmZXeHVRczNOeHlycVI2S094Y2hEelJh?=
 =?utf-8?B?Y1ZCbVk5L3h1bU05dk1oUFNsR3dkTHJINGp0TUFKSlpDU2ZkT25RSUZrb2x3?=
 =?utf-8?B?bjgrcUdvM0YwQmUzbTVUQTdLQnpZbFArR29zbnVObkJMYkhYTnFjMUVVblNG?=
 =?utf-8?B?N1FwT0tWMHZhWEdhNzBXTVFkRUh4L3FwaFQ0RDZ3ZGl0dENnOVJaalRraW1p?=
 =?utf-8?B?dlBOSHlCellpeklGdk9TREx1RGFXb0o3Rzl2MG5MU2g4U1owU0NhN1VWeURX?=
 =?utf-8?B?UnJ3a0R4RDN2RFR4MGMrdGpZS3pyMENpSWs4U0daeVdORGo5NjE5V1dlY1FV?=
 =?utf-8?B?MENkZmZUeTRhRDE4MXJkc0tzOVdrUE1yWHVUTEdTNUZTaS8zT1BOc2xwNGFp?=
 =?utf-8?B?SC9rbE9LRGdjUTl5OTNkakkyMFV1RlV0TkZ5bUpSZUZGOEJsQ3JsZFdKdTRl?=
 =?utf-8?B?RE0xaWVWaDlPSkk1UTRLYVpnL2d2MGJGck44NlBKR3k3S2phSUVQZDUxbnFD?=
 =?utf-8?B?MjdkNklKdnBSejNsUmwrU1ZadHFCeUpocTBhQ2NoSmQvbmJ4R2RyYlRrSzkw?=
 =?utf-8?B?N2gzUXJMVkJhNHh4dXRUY2FNREtJZlBqL2REcHhzd0RDUm5uM3p6dz09?=
X-Exchange-RoutingPolicyChecked: dTxcgIHIiLSXE6WMMFZflEVA6MlL7aLy5GclC6JqxgJtGaqAos+T4kRNLVqFL2NKfqO2Vdu3KgBD9bpKrzFHnc6u3oCNw3Q6+fsQWFzolExHlmQXrTbDtOn9WQK8WlE5jlSnnoDPVRF5dNOLuiclc8ajWXCbw53eNVk1MF8Zz24oq3cfMVnud1bG54vUur5XMwlapvN4wJj4545rzxU8mT7e2OI04EY00lkl/h3DpWZPkeNCKioTW5JvD7soYQWxyhPF8NVcVxvIkgPxErgfW9gwtbWvvXc6rzSV5uw4OZ1LI2NXfVU9DWCLRBRWi2FPiIp2wjg5SP33jbti3mxaow==
X-MS-Exchange-CrossTenant-Network-Message-Id: de4294fc-d56e-4c53-9d74-08de85426fd6
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 23:02:32.4917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QWzDFYFNv1wvmmH4UYD1Zey3Da0YjRwIt0JpfYTRanogWerx8Uszn1XM9x8U71OhMrFUsIcN3nMPsD7w8cH1eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR11MB9676
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

On Tue, Mar 17, 2026 at 01:19:47PM +0100, Danilo Krummrich wrote:
> On Tue Mar 17, 2026 at 6:10 AM CET, Matthew Brost wrote:
> > On Mon, Mar 16, 2026 at 11:25:23AM +0100, Danilo Krummrich wrote:
> >> The reason I proposed a new component for Rust, is basically what you also wrote
> >> in your cover letter, plus the fact that it prevents us having to build a Rust
> >> abstraction layer to the DRM GPU scheduler.
> >> 
> >> The latter I identified as pretty questionable as building another abstraction
> >> layer on top of some infrastructure is really something that you only want to do
> >> when it is mature enough in terms of lifetime and ownership model.
> >> 
> >
> > I personally don’t think the language matters that much. I care about
> > lifetime, ownership, and teardown semantics. I believe I’ve made this
> > clear in C, so the Rust bindings should be trivial.
> 
> No, they won't be trivial -- in fact, in the case of the Jobqueue they may even
> end up being more complicated than a native implementation.
> 
> We still want to build the object model around it that allows us to catch most
> of the pitfalls at compile time rather than runtime.
> 

I do understand this line of thinking.

> For instance, there has been a proposal of having specific work and workqueue
> types that ensure not to violate DMA fence rules, which the Jobqueue can adopt.
> 

Yes, want to add that too for C (ofc this can't be enforced at compile time).

I've started on this here [1]

https://patchwork.freedesktop.org/patch/711929/?series=163245&rev=1

> We can also use Klint to ensure correctness for those types at compile time.
> 
> So, I can easily see this becoming more complicated when we have to go through
> an FFI layer that makes us loose additional type information / guarantees.
> 
> Anyways, I don't want to argue about this. I don't know why the whole thread
> took this direction.

Yea, my bad. I apologize. This shouldn't be about is Rust or C better.

> 
> This is not about C vs. Rust, and I see the Rust component to be added
> regardless of this effort.

+1.

> 
> The question for me is whether we want to have a second component besides the
> GPU scheduler on the C side or not.
> 
> If we can replace the existing scheduler entirely and rework all the drivers
> that'd be great and you absolutely have my blessing.
> 

I'll copy paste my reply from [2].

The only weird case I haven't wrapped my head around quite yet is the
ganged submissions that rely on the scheduled fence (PVR, AMDGPU do
this). Pretty much every other driver seems like it could be coverted
with what I have in place in this series + local work to provide a
hardware scheduler...

[2] https://patchwork.freedesktop.org/patch/711933/?series=163245&rev=1#comment_1311418

> But, I don't want to end up in a situation where this is landed, one or two
> drivers are converted, and everything else is left behind in terms of
> maintainance / maintainer commitment.
> 

I can get other drivers to compile but I can't do things like test these
changes for other vendors. Also if existing drivers break dma-fencing
rules, those would need to fixed when converting over too. 

> >> My point is, the justification for a new Jobqueue component in Rust I consider
> >> given by the fact that it allows us to avoid building another abstraction layer
> >> on top of DRM sched. Additionally, DRM moves to Rust and gathering experience
> >> with building native Rust components seems like a good synergy in this context.
> >>
> >
> > If I knew Rust off-hand, I would have written it in Rust :). Perhaps
> > this is an opportunity to learn. But I think the Rust vs. C holy war
> > isn’t in scope here. The real questions are what semantics we want, the
> > timeline, and maintainability. Certainly more people know C, and most
> > drivers are written in C, so having the common component in C makes more
> > sense at this point, in my opinion. If the objection is really about the
> > language, I’ll rewrite it in Rust.
> 
> Again, I'm not talking about Rust vs. C. I'm talking about why a new Rust
> component is much easier to justify maintainance wise than a new C component is.
> 
> That is, the existing infrastructure has problems we don't want to build on top
> of and the abstraction ends up being of a similar magnitude as a native
> implementation.
> 
> A new C implementation alongside the existing one is a whole different question.
> 
> >> Having that said, the obvious question for me for this series is how drm_dep
> >> fits into the bigger picture.
> >> 
> >> I.e. what is the maintainance strategy?
> >>
> >
> > I will commit to maintaining code I believe in, and immediately write
> > the bindings on top of this so they’re maintained from day one.
> 
> This I am sure about, but what about the existing scheduler infrastructure? Are

+1

> you going to keep this up as well?

The fact is we can't maintain DRM sched as it is now, techincal debt is
just too high.

> 
> Who keeps supporting it for all the drivers that can't switch (due to not having
> firmware queues) or simply did not switch yet?
> 

I'd say I agree with your no new features statement in DRM sched, if you
want new features in C, fix your driver to use what I have here.

Ofc if bugs pop up in drm sched, happy help fix those.

> >> Do we want to support three components allowing users to do the same thing? What
> >> happens to DRM sched for 1:1 entity / scheduler relationships?
> >> 
> >> Is it worth? Do we have enough C users to justify the maintainance of yet
> >> another component? (Again, DRM moves into the direction of Rust drivers, so I
> >> don't know how many new C drivers we will see.) I.e. having this component won't
> >> get us rid of the majority of DRM sched users.
> >> 
> >
> > Actually, with [1], I’m fairly certain that pretty much every driver
> > could convert to this new code. Part of the problem, though, is that
> > when looking at this, multiple drivers clearly break dma-fencing rules,
> > so an annotated component like DRM dep would explode their drivers. Not
> > to mention the many driver-side hacks that each individual driver would
> > need to drop (e.g., I would not be receptive to any driver directly
> > touching drm_dep object structs).
> 
> I thought the API can't be abused? :) How would you prevent drivers doing this
> in practice? They need to have the struct definition, and once they have it, you
> can't do anything about them peeking internals, if not caught through review.
> 

I agree with this statement. So it would require disciplined reviews...

e.g., You are touching this struct directly - why? Is is drm dep missing
something in the API your driver needs, if it is real issue we add to
drm dep.

> > Maintainable, as I understand every single LOC, with verbose documentation
> > (generated with Copilot, but I’ve reviewed it multiple times and it’s
> > correct), etc.
> 
> I'm not sure this is the core criteria for evaluating whether something is
> maintainable or not.
> 
> To be honest, this does not sound very community focused.
> 

That is not my intent. I did write this as common component for driver
and to used by the community.

> > Regardless, given all of the above, at a minimum my driver needs to move
> > on one way or another.
> 
> Your driver? What do you mean with "it has to move"?

DRM sched is not maintainable, thus it is not going to fit the needs of
Xe in the longterm. Other drivers like are facing similar issues.

Matt
