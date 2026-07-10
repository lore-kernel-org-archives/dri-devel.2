Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F6BC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 18:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D844610E218;
	Fri, 10 Jul 2026 18:29:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Jwh9gGu8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F265A10E218
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 18:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783708169; x=1815244169;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=upzgCgHWkQEkn0/JsrH9hAl0fVCostc8MyF0Q7yZoq8=;
 b=Jwh9gGu8sMxRzomLwlVQn98jYOpjj5Pp1BM3JR/H8C9w1YuA+aDJi3fa
 vvVoHHMCI0koilIfwLtgFdf2FrJ2fBbi3Z9fQCNr2VW7S0ssPRw5g1q2+
 XmUiuEr83sVTrz1r83axjfSm31/dV2aU7e0fKMVWJirqD4iOPdYOXtw5L
 HfBdtxcYcfxcxFrWoG+XhaH169mvmopuqnIHWDgSuP2qF2a41nljWlz2V
 jh3/xU1wIzjfx560yftUrbBUB9aoa+4TdkQ1tRcL++nfz+w0xaXVDj2DR
 vdz/suy5W+SU5ydZxoFsbS4pEjq1H97WN4B4FVblxaNLy++LPASHD9JPt A==;
X-CSE-ConnectionGUID: mrw9Y9uLQYWUZiX1+5HThw==
X-CSE-MsgGUID: p7w6GGBwS8W8v8ddpmRCuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84525825"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84525825"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 11:29:28 -0700
X-CSE-ConnectionGUID: w98C4CdGSzyPugxP8LEI7A==
X-CSE-MsgGUID: Vp5buFE9QYGYau1ngS+TrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="256897530"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 11:29:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 11:29:28 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 11:29:28 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.31) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 11:29:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYhJ3X+i98m6HBN9W0hQbznfriXO3mErMMbCc41ejwyV/SfXw46UiTQe2r3+7zyJoJAXttBn+0UlPbmoXvZQm/9JlOdTTxyx1RoCnYJVXg+s/bby2k/KxVAksLqidMA5KKUVOfBjqoiDtWolI6NNxHcWlFXarjgMpgLzDnOPPL2XSJcn4+WhZtAxB7J+tB1QmzFsAYAZSiUWHS4bpmDinT/YGYyfQyYNgQW6BHqJQeAiAXEeTodA6aH0azh9IcPS0NCEgkICqYkOWG3HIdUPND4N9mf/Y5QayrhoiTMSF9G2AVWlQCBcMIknUFdfabypZIHh9wJCXyCqO/IQWwEJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/0SWvoip+xMzj9Mr5gmw62VLkCnQ1VgfUKZ86/cR/4=;
 b=JEVgpud5bkmDvRrXiGMGVvt3Y6+mkvYuGwJ6AIy1m2FM815rgQMTUu8K4nSGWvPAQVKcGgRyW1xgt8/dI3tccN4G/qM05D/754T/45r/uXAlm7rRvQtXunUFvh8ODXUlTR0KL/nMcuQiEUgCtTkGMDKo8RBupxVXR29nIrnVxcY2Ex8NhEgGK9YCyhGB+58FuqXIFVJtzRiG/cC24jRF2SU5cCF9/tJz+tpK3RiYe38yaJHLyFyBwWUCT5V4TlC/87Qu0WzcHQfTf39yRrH4NnVZ+yUv2C5ZuR2WiDODf9lxnxLTsSmwGayKY/IxTjHdNWoKjOksL1V3WSfOunNGkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SJ2PR11MB8322.namprd11.prod.outlook.com (2603:10b6:a03:549::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 18:29:25 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 18:29:25 +0000
Date: Fri, 10 Jul 2026 11:29:22 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tejun Heo <tj@kernel.org>
CC: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, <phasta@kernel.org>,
 <dri-devel@lists.freedesktop.org>, Boris Brezillon
 <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, "Liviu
 Dudau" <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>, Danilo Krummrich
 <dakr@kernel.org>, <kernel-dev@igalia.com>
Subject: Re: [RFC 0/8] DRM scheduler kthread_worker for submission latency
 improvements
Message-ID: <alE6Anbf5nSYszVT@gsse-cloud1.jf.intel.com>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <4eb23476ff56bee108578adfe131be38e8fc1476.camel@mailbox.org>
 <b76ea01c-ead3-4eaf-86a7-5bf91bfdb9cb@igalia.com>
 <akwD28ihbzn1FB-P@slm.duckdns.org>
 <fe9c5564-9a56-429d-a991-9b77f8a97d5b@igalia.com>
 <19f0c3fe-7395-492f-b016-7a7a507da4f6@igalia.com>
 <250bfc53-e91b-4c48-9401-bbe636d3400b@igalia.com>
 <alEZlhfTZ1tD3hMo@slm.duckdns.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alEZlhfTZ1tD3hMo@slm.duckdns.org>
X-ClientProxiedBy: MW4PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:303:b7::12) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SJ2PR11MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 66572473-d2b7-4820-6ae7-08dedeb12b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|56012099006|11063799006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: Ycf/+Dqfv+fxfeU59v/9YUii7PU0nqcNZYi79XuxiD0Rq5zJCQ4aRMSOpu3QrJqktsjuNZ4HkgtmN/w4RZwi4QGInAEZx3uIPhd4jjyBbuIxq3TW2UgV6aPtg4gnK4uOO9PzZ32stmRswBJy+B5YioG02x1IpnfOLXedYq9LG0DPaAB9YXB9JrOLoqUxtB5W43BFFra3OavFZakixY8kq7dgA4CWeU39UYGGjPU15jCdB4Wa1A53FJmoYWMazKkB5JrzPRaAn4fYhle7yck3A9EOwktwf1xIsXAs0eWDBGztkCpbyzjVAc6IIe0vMR79vSA/9yXg6lkIIg4W9Q0aejnrwRl0qGG9Os1b+YSjBMt/Drh0DCK5RGPrbwWUDS/7G3/7aQHE1UoW5U1rlAjuZGbfKrAs2eSUc7GCO4ubba9B2Ut8fe+DhjwbMLr6WtmlP9PRrceQI+AOZ/bO8NWobcpbWOWvWLk4rbTDrnpRs6ZOHdzjE8nbRuIMF+YYLPvNkZ/SAxeQTVzOPuqZdshT9mIlW0us2NivZVa38ndEyWJBYiXYELXfAihybGKDdWO0w+fL3GaWkxAxgL0jsxPbpKsRGvQAh76fpeHXlwGej49eu5E7yspLadI1p3h8/idhBmFg4U1vnbMyUW2xM+KkfEtF0GUlDH/+V8fSMnrXaRY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(11063799006)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qCsONVhsQNrcbi8lFF9YfXTQtXM++GoOdRLhyQXYnvXAJFShIMZhQeAyzAOv?=
 =?us-ascii?Q?1t6eRTVVxdHD7Eer2Pc1fmpFgi7ouDeXWORsHHg8Vr7YWHLl0yMhurhmcrH8?=
 =?us-ascii?Q?PM8++sGc7EcQlV8e2EO9mwb85BiG5jtRqeC/e7IRTB6jGMuOvFAS9F6BSHa8?=
 =?us-ascii?Q?QB3RjzQopfd6tRN/19B2OLVzK4wfRIlkjzUuetw1ziLF7xAmmJeh+a4+Vmrw?=
 =?us-ascii?Q?93eAbg7eMCMKWMmgpKDqBw+ncezxvPXetHxRSFzT/rQwRXNwrfMLMV8X05ko?=
 =?us-ascii?Q?OTftG8ILNBN26wOLsCKfkoaCF/0l3p0vUjTjOjX9kJXS/07UePmpipp7AXek?=
 =?us-ascii?Q?FPDS0OPu2DYowtBEwxaHxjSc/MR6FOSBJ2mEBdQz3ryKStzMrJ2AWVcFff8l?=
 =?us-ascii?Q?zPq6noIXht19sAijcbeRzKh/Yzy5xdY7MhcU985sBiXjVvcWU/LFjzWo5134?=
 =?us-ascii?Q?3dE1kMyNqJ66rX+waM41XLgmyLAkFHdpGpD+a5qzJicbF88Dk7lMdR7I9Qo5?=
 =?us-ascii?Q?h3OCh4NVCMztrrsVRzcmfqIj+V86dl5ekTHe6qaqbPoh3gjPc7YfjhhWVtCq?=
 =?us-ascii?Q?HY13nHuslhuV5UAO3IxYIC6+b5CbvQj0X7OS+SssisavfFG4ycWkhFnNTubN?=
 =?us-ascii?Q?jfedsVbnFVzy48UJh/8QaQ0Wp2qPAegCrxtISKucd8lxdXpR21T3f+ohRIlO?=
 =?us-ascii?Q?f2+7wexA5MkZjI1canAPSFCecAz2CLwfKtynPiw5lmhoI06bUn4nG5jgFdGA?=
 =?us-ascii?Q?qYfNfb7awTpppMbCdZFdOtiFd98p08G9/+OfAMB2k9HuOBJlGC+ss161iBcl?=
 =?us-ascii?Q?z10eD9JhRVPtNRaijCxTBI8ussvsp6LPEg9hpTu4JnbYQsCAOH5T5icwVWiK?=
 =?us-ascii?Q?YSyB7xa6Jq9o3Vq0YC1/AnxXVfTf1aKEPR9jaFHuaBrxsomNHFivpuVURXp0?=
 =?us-ascii?Q?7RZ5hPplGLRgdM6LAwDkguX8PhZiFoLa82Hf9/Fe9SgpZkOFrGqqirVFl8VT?=
 =?us-ascii?Q?X6yqVFST8pqji5icqsyjF8NMI3konoZxG008/fJAwHp+L5jfsDXYYEQHompq?=
 =?us-ascii?Q?qLT5QyTWsDDTKYxz23M7ZexCZMbHAssc8OehcOzNe9O5Fo/Nrjjc30pIbyAS?=
 =?us-ascii?Q?jrDCUM2w1hifhkQhS6jiZxB5fQAK0wVK5E59gxh+0lWcyAZRhtjUrrGccG7k?=
 =?us-ascii?Q?37Is09s7Yb5yAIANe8dT4tPmdkvaT80IoWKzznLXmUPKqQE0YQ7wX0sZu2Nf?=
 =?us-ascii?Q?p0QrDVIsxlKSp5O9gYkkjNu5GsmK9LfWAwmCmvO8Lq4USCLKf3XjNxyDeTDs?=
 =?us-ascii?Q?btsghtCXW6g14hy8Ba/6qYjUINa7WcMiQ46FpfprDl2Ia3AMEMUjlQcPoqkx?=
 =?us-ascii?Q?6QnqgOzxEJf7FqBaheaHcE3j1vskdpjkJQ1hzr7V2Jr/yDzYw4zbs6xBfoZl?=
 =?us-ascii?Q?YH8Ml4TTV4mJ8IU3KmRijmbup6pEjrkec32iZdRDmVZuljEJ7/qR2rclbXbG?=
 =?us-ascii?Q?ja85wFBeWL3IpZRzmD28Fhce6AIIAriMC0j6CzEGYjaNSaUjSkzgPMIgYCZO?=
 =?us-ascii?Q?qscMYV/IX5xaHRaC/TslSUwFVz3u1SbGWRAk9h3anENAqmsPkKw1KHcQUULx?=
 =?us-ascii?Q?SqVueurmJ5viWrRVfMzg/PFxGR95g2h7VCu+ZFP8w4QM8fTsEDEjtAaDxvyS?=
 =?us-ascii?Q?KGtOAl0BEqQ8BiRCp6hEb0Oj9ZjTusm+KcxLUv7KtPStcocF52ult0TTixnn?=
 =?us-ascii?Q?gHnK3H8zV1p0nMGSf48IlIW+aqL68Rs=3D?=
X-Exchange-RoutingPolicyChecked: gsspHHNcmIYnMTl91aR99B7PUNhj5L9sXOq+pEp7OrS4ZM2colt74cZBROxUO7RPSP6aesNqdPKQaHgdXmuNdIXFEEwW0hXycfSDYeiJZsq7PlvzBARqkGrogzozxBd0Uf0GdXTZe7qOII60LLRLMMzLJZX7fZxLd8WJmHnTm5K3KwSOEhrwGr/YRnSI3/AnNYwBghZU0fnf0Is7MgLwVeYJWkKeiaUF0WoVLcQ2wOaDVwYKdh5ryaP7BcIVFq8LBJgWU/K6g3RCdkl9ELz/Tq6/UfTSWMxWQQQa+evFEMmbA/Ofg/F6i7ek9i+n0DmwLp6imxlcjIwb48pgDTTcVQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 66572473-d2b7-4820-6ae7-08dedeb12b72
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 18:29:25.4949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQ5Rc9Icvtcr9xUfrGGyrlVvGzncKViLF+dDlv96Iort2FqtfU802VnLE2q+P6XCMow70OOip0ZhKxIBJHhhVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8322
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

On Fri, Jul 10, 2026 at 06:11:02AM -1000, Tejun Heo wrote:
> On Fri, Jul 10, 2026 at 01:29:19PM +0100, Tvrtko Ursulin wrote:
> > So the question is whether something like this is acceptable to workqueue
> > core? If so, I can send it as a proper RFC and go from there.
> 
> Yes, that looks like enough data. Let's add RT support.
> 

+1 - This solves a bunch of our DRM internal debate around what to do
here.

Thanks.

Matt

> Thanks.
> 
> -- 
> tejun
