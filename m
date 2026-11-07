Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70D7606A32C
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 05:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IhGfNohV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2105B10E513;
	Sat,  7 Nov 2026 05:07:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ED4110E00C;
 Sat,  7 Nov 2026 05:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794028070; x=1825564070;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=ILnqU5gq3XFLGs3qE7N3DexOtFvtSV4tSTl1s9dAQIs=;
 b=IhGfNohVyHBr527/YxKJ+i35tTrPjnmNeEg+CqANtr6s1Frsqhvfjddm
 ctPiVi8vxOXRhseaAC8mnzxr2SyNBO13HZ4ilp1y6zb+LpuqpPD1keOZ6
 ONLMKe0CfXfvr5Y2s6aPEiBc4RqqE6USSb8H8eKUmQToA2X5lZOijiAM/
 CzVP+Ei7k4HK+BJmNYNlu/+sNuFSGcOXsyJsccAdmj4gL1J5gwuqJK3gk
 WlBovdaXVaru0LqswUPnUlFE5AJ/VCAr++5kJuc+y2Irprq62zZBd0c5u
 DRvkE1R6cbLseujyVOgbQleq0D+qJ99FkMEB3AahFXGPe4KFhMbcWA01S g==;
X-CSE-ConnectionGUID: gzA01WgYS9ObC3xaZwylCQ==
X-CSE-MsgGUID: mqCzJb7VQry6BAELFWuXRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2875181"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2875181"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 21:07:48 -0800
X-CSE-ConnectionGUID: jG61I158R0u7O+f8rGylOw==
X-CSE-MsgGUID: rDDgkDiNT/CfU4ea30E7LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7785607"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 21:07:47 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 21:07:47 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 21:07:47 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.67) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 21:07:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VR+r/Z+dP7S8n+J0q6Wa5wFLZ5xqrC2nltwGHP42ClkdJDDfzuVAUsVP1YUWoOkMM9p0Z+Fm5TftnsRCKpqgQA1+hqSUiwNiQ8PJA9b+EnhSH7fan6KqHn/jXXqOFL3vJ/2MmFTj/XABVSw+rGqeI3rQUobRw2CfGSRwdEldmapz5GP69USXw8XlM5pyJ9dOjg5CyY99CZ2Z8YgfZ+bf5QAh/mbesurfacIA9lh5up7jK562mLNY+93eAdM1poD9i5KggMLRXkYGVb6xnbHPTHRcPF4s3z94QM9gQZAJjXyTNSkZnXE1zCs1xOAI+4vLTpw940YJB1JpI6HceO6IvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tp+IQTrGpP3sOjfzuvpnfVslGn1MncLBJMACSBXUwAU=;
 b=hEstUCrLU/lTffqP6PFjYCejxH6KyWdXUXPXC1ygVN+n2qO3kBBSiN+Qs7z0+zjpnx/mgCaLBwRSmJdkExRUYyO6hMsPgh3j1al4ZanKkfgS+dxDSyrN4W4qLjFxJfi0cSdYiebUHePJtmusD0kLQ0dnAJI8Y8VdQZA/nJhn1A6vV23nz8oGksR5VeQFLIdFJz5eBKjsZiEBsE6qV69sI/vkbMpURzp6wP4Q9hHimHiVmKouDmaLG9FlkZ2cTSsOkQ4Q1zXRhNMHQR+mtZ18mZ1wBhvVZfv+sWH9lJfVK8h1elYUnSxkgYgXLHt4Rxu3jeXMMzTs5Fu2lV8ZmNFxoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 05:07:39 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0569.011; Sat, 7 Nov 2026
 05:07:39 +0000
Date: Fri, 6 Nov 2026 21:07:36 -0800
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 17/33] drm/xe: Add xe_migrate_copy_defrag() for on-GPU
 defrag copies
Message-ID: <au6yGIR4QDX_M_qO@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-18-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-18-matthew.brost@intel.com>
X-ClientProxiedBy: BY3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:254::7) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|CO1PR11MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: c9076d38-c5ea-4808-c810-08df3c8d0bc4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|23010399003|376014|366016|6133799003|18002099003|22082099003|3023799007|10067099003|11063799006|56012099006|4143699003|261102123227099003|261028144727099003|261026140227099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: +KbdREaJPgcUfdNfXeVuPtwytpeQdH5ka333KzeBbBMT3VbHQqDRS3b9nJvWHE2ihszApRlfYf5cYYzbqW24x2Y5jR39D9nyJXFjc6SrYCl82Xy38uy/4gvIHqoHkZUACclQOZ6D/B81JZ5xeyYWDwzgLmfYPVJW1Z6O9zGBscisjyD5IgF8OhwiJGNd+/QOb7jeX4uTV+ErAzFGr6JFNe+VEo5t3k4foEYU2afQbTpCSXUWKIW5KJ5pEd9X1pSM/ueNcjreXHIgiHt2+xNcy5s5drkHQG4niCL8O8W/+ctbkgkL++l81RaZmtHL5nG+bzpJCacjHs41SuTyjeSRFK8uk/6M6FYcgIQa9iUAyVekONJNPyOE/penlgQ57YBzGEUfkK8G/JwSwQnZbJC6l7CpNxVAy5UW2XfyhYUKjjD518Lnhx9ovJbuqnGlje4bzX6JLMPHzrj1ve90KCtCiLngZrx37SITabxVvQbBoxXths9zkFv3YjUEGLchmT3Br/a5s01nWlU1armwoR70gFlTNSU8o2Riv9fRJEMdDwpCzMf8vCrWzzUMGutLj3SdrlLdpE7v2DFBcvoFVVq2DrsuP0q5W3djJPLdPZQ7tzxDIY3h5NUa3TolT3qOudJ5kuNjjVf9wgRewZe0DHwUAE/qOuNdfRJsjFa6r7lo468=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(23010399003)(376014)(366016)(6133799003)(18002099003)(22082099003)(3023799007)(10067099003)(11063799006)(56012099006)(4143699003)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?aID6h/P98UxMIDoobm+QyQ6cSJ335lcYhtQpFWqJlYkh6PyZw0o2Vt05HM?=
 =?iso-8859-1?Q?jssKzXCQMH44otiVUmn/ur/HYrO4jpYTsfsOJ2vw0W8HntE1iT+YMDaHf3?=
 =?iso-8859-1?Q?jEActZaMT0hi/xzA1ubEjKdywkGNlihD8LbzCTLJlsFtLTNWQ7GjG95KbI?=
 =?iso-8859-1?Q?AePxLwwRRA4uhSQ+HpAIaSU0Zwzf8mfFLTxJVkkqRPE5RQOWf6aNaxnYH3?=
 =?iso-8859-1?Q?TqTgc0ByOfxl5+Lz8lyiom4Zvm2qcumE4G6Wy1VC7+NIEXE3FHudKOhawZ?=
 =?iso-8859-1?Q?dEzoJtfIzvbaZG6PPC6wT5A9jYzQy2EUGI0ZbZ1vBPNrB7dzJ7mrHm3GOS?=
 =?iso-8859-1?Q?LLZCMTH+v0tnQIF7o876LfCuKUsZyDpPERCxchkr+axBNWKS9HEO72Sx0n?=
 =?iso-8859-1?Q?nEKaOY5tfHmQp7b7IkMxk8Z2q7Iy5QxUPKcvjaM9p97glsnCYuzt1APGds?=
 =?iso-8859-1?Q?Ll3oB/pPk7rzmGsC7Qt6qKz0lrxjeYH6drF091uFB6zsd3OqCjwP3I9R+b?=
 =?iso-8859-1?Q?aJntM0UZLNX+1iCgYpvf0SNMPPMgOvFwP1UEOXOWdxSEdfXltILNbqoTKq?=
 =?iso-8859-1?Q?yCrGUQSbHk9HrQ8apYoKoqpddkBHaCsRrfEfpXfHE0rMvslnNfna300tf/?=
 =?iso-8859-1?Q?qNgIFtImbw8bJuIIU0Nui/FzRVhFewj05R6XF/pi8jZKFo4ldXG4T8/tn5?=
 =?iso-8859-1?Q?s+Fgd/SCMe4PZ5+cnkCJ4wJqx/Oi9/LJEGilLo4OKyBN2NLsev+b+KlVD2?=
 =?iso-8859-1?Q?DTgCB7NByBciRCyrn/Kt33gWecsiku+2+GKT4qfMCKeFWbbhMGsSztUABr?=
 =?iso-8859-1?Q?cuPCGTfzw+lRXqwTQXqthg0ZEABVH4rW6DQ0zB+PMbkTN3LVNw1m9M3QoE?=
 =?iso-8859-1?Q?ls5PK2ks2SikPbp1rWqwAEoj6Cs/fZLwUZR8uJEWS6t3Mlm+3GJAloeQcy?=
 =?iso-8859-1?Q?DY2YIBJ87bYCaWwqczp/SRm1kPUlebKmxMLQ4fkfvyosOYdoVXDOCZIlHK?=
 =?iso-8859-1?Q?d8mRf+Fv2wxi+rNmzme55SxwQL+2apmPAJBLPr/IIu0SpLnpNEAk7ht6Tg?=
 =?iso-8859-1?Q?nZ9XiTXFPWIaNv3bSecbD2jBF/RMoR9iZe6WSXL7jRJjhMxaKP22iEDo48?=
 =?iso-8859-1?Q?Gln4rW+fE8veir3SE76dGt8WqvBMnNPaqxwAnYU4NrL2p47QvDqvIZCvns?=
 =?iso-8859-1?Q?oJdDmwsFeL2rknk02dosH8o9YBmOel5vippbuAIkUhR9KqCY0NDWWu4pQB?=
 =?iso-8859-1?Q?4diWCKmjJCKmtlU9BZy/Tt9YKrm4niFccP4x+Oy1UVfxlVJmInWbEt6VeA?=
 =?iso-8859-1?Q?uAaz0YcuVGSayqpV/LPmWNqyqCn9LbecPHvdYQdBHyCx5nLl693C67Zz2D?=
 =?iso-8859-1?Q?5KuyVPAetQ0zKjVDIgaQUyplcO12xJb2Vff33N4dQnI4+dYHWXJ3uvOzmF?=
 =?iso-8859-1?Q?df4cCcdhv6cgjr4Xvi1ZCfZE6RYkDdQvmnoTsKMQHvHkSONL3jTQnNcAlu?=
 =?iso-8859-1?Q?ANrFxVSq0d6h8dTJAs+p4Y0rw9Y7wbzD3AR12BK2xU8u2GqrP84pyWKYjV?=
 =?iso-8859-1?Q?qDfbWPp9gJtGzd58hJOpAj0l1rO2DjiG9pWbWHJyDl041tHHxapC5DLGS+?=
 =?iso-8859-1?Q?kxRXChzpmG9N4dTIkcmbrN33x1KdnmzpY3m4XWGG+oh6Df2pY9VFcbUihK?=
 =?iso-8859-1?Q?xEswUPXcSf4NX0TezxbLfZAliPytizuXKNZAvrFKLf2Qj63iNowohbYfg1?=
 =?iso-8859-1?Q?ZHeC2kId6rb4yTIfTYJTiUcLvCg2SC6LNvfGDV504roE1lrykzIlwB6qpD?=
 =?iso-8859-1?Q?RIGA7yRh2XEmJqdo6b926Xf+jtaxUwt29uZepz3p/vQ1kLHKQqGK?=
X-Exchange-RoutingPolicyChecked: MJiD6WgVQ8cVzGoQVUKPbM41cWafgCsY5vusJTSJ7O4Kul8FxJPhkLbiTZqGPuPvUGy0IzYCWlvUiKuLbImXlflWWpkVTFskgSJpc1Lp7VrOUmrBbAl6NWGl0WbxlU1QxP3LlxrAkmvAwX1/Ym1LGZXE0JQFa6x/hFB1/otU5bVsnOVMDkN8017pz10N6PPQr1ZfNmFYYJLqacxH6heQPEedPZSC7uSLVrQXfKnaEEYBZAOJ2HmkEM6ydXFbU4x8fsE5YTs0ypQ2X17wcYP9N86sZTo4EHgcbtTa4Vfd2+5u/YjCygnXrfe6YBMwf+avW92NwKZvYfZpDb7zUTMnJw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c9076d38-c5ea-4808-c810-08df3c8d0bc4
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 05:07:39.6843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDNq5gGCq9h4rzVUfPXEMv1inqpolrbvoXGtSa3ffCwnpVDsQSuiyr1chEqi+Rm84sVxRx2tcUg9Pe9S49gv0he6STPhN9WBTcmh6qLMeRMziklpUn4d5Uybse2I4D/r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5154
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Jul 10, 2026 at 07:56:03PM -0700, Matthew Brost wrote:
>Add xe_migrate_copy_defrag(), a copy helper for the upcoming page
>defragmentation path where a single BO has its backing reallocated at a
>more beneficial page order and its contents must be relocated from the
>old pages to the new ones entirely on the GPU.
>
>The contents are relocated in up to two passes:
>
> - Data pass (always): copy the data pages verbatim. The pages are
>   mapped without the compression PAT, so the (possibly compressed)
>   bytes are copied as-is rather than being decompressed and
>   recompressed, and no CCS aux copy is appended.
>
> - CCS pass (need_ccs): copy the CCS aux (compression) state. Both the
>   old and new data pages are mapped with the compression PAT so the
>   copy engine accesses the aux state indirectly, issuing one
>   indirect -> indirect XY_CTRL_SURF_COPY_BLT; the data blit is skipped.
>
>The two passes are issued separately because they require opposite
>compression PAT settings on the data page mappings (cleared for the
>verbatim data copy, set for the indirect CCS access), which a single
>mapping cannot satisfy. Both passes run in order on the same migrate
>queue and are captured by the returned fence.
>
>The source pages are passed explicitly via an sg_table argument (the
>old, still populated backing) since they no longer match the BO's
>current backing. The boolean arguments to __xe_migrate_copy() are folded
>into struct xe_migrate_copy_flags to keep the growing set of copy
>variants readable.
>
>Cc: Carlos Santa <carlos.santa@intel.com>
>Cc: Ryan Neph <ryanneph@google.com>
>Cc: Christian Koenig <christian.koenig@amd.com>
>Cc: Huang Rui <ray.huang@amd.com>
>Cc: Matthew Auld <matthew.auld@intel.com>
>Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>Cc: Maxime Ripard <mripard@kernel.org>
>Cc: Thomas Zimmermann <tzimmermann@suse.de>
>Cc: David Airlie <airlied@gmail.com>
>Cc: Simona Vetter <simona@ffwll.ch>
>Cc: dri-devel@lists.freedesktop.org
>Cc: linux-kernel@vger.kernel.org
>Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>Assisted-by: GitHub_Copilot:claude-opus-4.8
>Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>---
> drivers/gpu/drm/xe/xe_migrate.c | 136 ++++++++++++++++++++++++++++----
> drivers/gpu/drm/xe/xe_migrate.h |   8 ++
> 2 files changed, 128 insertions(+), 16 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
>index 92d5e81ceac2..305c6e1942fb 100644
>--- a/drivers/gpu/drm/xe/xe_migrate.c
>+++ b/drivers/gpu/drm/xe/xe_migrate.c
>@@ -858,13 +858,39 @@ static u32 xe_migrate_ccs_copy(struct xe_migrate *m,
> 	return flush_flags;
> }
>
>+/**
>+ * struct xe_migrate_copy_flags - Flags for __xe_migrate_copy()
>+ * @copy_only_ccs: Only copy the CCS aux state, aliasing the destination data
>+ * mapping to the source (used when the data pages are shared between src/dst).
>+ * @is_vram_resolve: Decompression (VRAM -> system) resolve; always uses the
>+ * compression PAT index for the data copy.
>+ * @defrag_ccs: Defrag move pass that migrates only the CCS aux state between
>+ * two distinct page sets (old @src_sg pages -> new pages). The data blit is
>+ * skipped (the data was copied by the @defrag_copy pass) and both the source
>+ * and destination data pages are mapped with the compression PAT so the aux
>+ * state is copied indirect -> indirect.
>+ * @defrag_copy: Defrag move pass that copies the data pages between two
>+ * distinct page sets (old @src_sg pages -> new pages) without touching the CCS
>+ * aux state. The data pages are mapped without the compression PAT so the
>+ * (possibly compressed) bytes are copied verbatim rather than being
>+ * decompressed and recompressed, and no CCS aux copy is appended; the aux
>+ * state is migrated separately by the @defrag_ccs pass. The two passes need
>+ * opposite compression PAT settings, which is why they cannot be combined.
>+ */
>+struct xe_migrate_copy_flags {
>+	u32 copy_only_ccs : 1;
>+	u32 is_vram_resolve : 1;
>+	u32 defrag_ccs : 1;
>+	u32 defrag_copy : 1;
>+};

Assisted-by: LLM

These flags seems to be mutually exclusive. So, probably use an enum instead?

enum xe_migrate_copy_mode {
         XE_MIGRATE_COPY_NORMAL,
         XE_MIGRATE_COPY_CCS_ONLY,     /* dst aliases src */
         XE_MIGRATE_COPY_VRAM_RESOLVE,
         XE_MIGRATE_COPY_DEFRAG_DATA,  /* distinct dst, verbatim data */
         XE_MIGRATE_COPY_DEFRAG_CCS,   /* distinct dst, indirect->indirect aux */
};

Niranjana

>+
> static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 					   struct xe_bo *src_bo,
> 					   struct xe_bo *dst_bo,
> 					   struct ttm_resource *src,
> 					   struct ttm_resource *dst,
>-					   bool copy_only_ccs,
>-					   bool is_vram_resolve)
>+					   struct sg_table *src_sg,
>+					   struct xe_migrate_copy_flags flags)
> {
> 	struct xe_gt *gt = m->tile->primary_gt;
> 	struct xe_device *xe = gt_to_xe(gt);
>@@ -881,20 +907,29 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 	bool src_is_vram = mem_type_is_vram(src->mem_type);
> 	bool dst_is_vram = mem_type_is_vram(dst->mem_type);
> 	bool type_device = src_bo->ttm.type == ttm_bo_type_device;
>-	bool needs_ccs_emit = type_device && xe_migrate_needs_ccs_emit(xe);
>+	bool needs_ccs_emit = type_device && xe_migrate_needs_ccs_emit(xe) &&
>+		!flags.defrag_copy;
> 	bool copy_ccs = xe_device_has_flat_ccs(xe) &&
>-		xe_bo_needs_ccs_pages(src_bo) && xe_bo_needs_ccs_pages(dst_bo);
>-	bool copy_system_ccs = copy_ccs && (!src_is_vram || !dst_is_vram);
>+		xe_bo_needs_ccs_pages(src_bo) && xe_bo_needs_ccs_pages(dst_bo) &&
>+		!flags.defrag_copy;
>+	bool copy_system_ccs = copy_ccs && (!src_is_vram || !dst_is_vram) &&
>+		!flags.defrag_ccs && !flags.defrag_copy;
>
> 	/*
> 	 * For decompression operation, always use the compression PAT index.
> 	 * Otherwise, only use the compression PAT index for device memory
> 	 * when copying from VRAM to system memory.
> 	 */
>-	bool use_comp_pat = is_vram_resolve || (type_device &&
>+	bool use_comp_pat = flags.is_vram_resolve || (type_device &&
> 			    xe_device_has_flat_ccs(xe) &&
> 			    GRAPHICS_VER(xe) >= 20 && src_is_vram && !dst_is_vram);
>
>+	/*
>+	 * The defrag CCS pass migrates the aux state from the old pages
>+	 * (@src_sg) to the new pages with both sides accessed indirectly, so
>+	 * keep both src_is_pltt and dst_is_pltt set (no direct staging side).
>+	 */
>+
> 	/* Copying CCS between two different BOs is not supported yet. */
> 	if (XE_WARN_ON(copy_ccs && src_bo != dst_bo))
> 		return ERR_PTR(-EINVAL);
>@@ -903,7 +938,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 		return ERR_PTR(-EINVAL);
>
> 	if (!src_is_vram)
>-		xe_res_first_sg(xe_bo_sg(src_bo), 0, size, &src_it);
>+		xe_res_first_sg(src_sg ? src_sg : xe_bo_sg(src_bo), 0, size, &src_it);
> 	else
> 		xe_res_first(src, 0, size, &src_it);
> 	if (!dst_is_vram)
>@@ -912,7 +947,8 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 		xe_res_first(dst, 0, size, &dst_it);
>
> 	if (copy_system_ccs)
>-		xe_res_first_sg(xe_bo_sg(src_bo), xe_bo_ccs_pages_start(src_bo),
>+		xe_res_first_sg(src_sg ? src_sg : xe_bo_sg(src_bo),
>+				xe_bo_ccs_pages_start(src_bo),
> 				PAGE_ALIGN(xe_device_ccs_bytes(xe, size)),
> 				&ccs_it);
>
>@@ -942,7 +978,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 		batch_size += pte_update_size(m, pte_flags, src, &src_it, &src_L0,
> 					      &src_L0_ofs, &src_L0_pt, 0, 0,
> 					      avail_pts);
>-		if (copy_only_ccs) {
>+		if (flags.copy_only_ccs) {
> 			dst_L0_ofs = src_L0_ofs;
> 		} else {
> 			pte_flags = dst_is_vram ? PTE_UPDATE_FLAG_IS_VRAM : 0;
>@@ -963,7 +999,8 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 		}
>
> 		/* Add copy commands size here */
>-		batch_size += ((copy_only_ccs) ? 0 : emit_copy_cmd_len(xe)) +
>+		batch_size += ((flags.copy_only_ccs || flags.defrag_ccs) ? 0 :
>+			       emit_copy_cmd_len(xe)) +
> 			((needs_ccs_emit ? EMIT_COPY_CCS_DW : 0));
>
> 		bb = xe_bb_new(gt, batch_size, usm);
>@@ -975,13 +1012,15 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 		if (src_is_vram && xe_migrate_allow_identity(src_L0, &src_it))
> 			xe_res_next(&src_it, src_L0);
> 		else
>-			emit_pte(m, bb, src_L0_pt, src_is_vram, copy_system_ccs || use_comp_pat,
>+			emit_pte(m, bb, src_L0_pt, src_is_vram,
>+				 copy_system_ccs || use_comp_pat || flags.defrag_ccs,
> 				 &src_it, src_L0, src);
>
> 		if (dst_is_vram && xe_migrate_allow_identity(src_L0, &dst_it))
> 			xe_res_next(&dst_it, src_L0);
>-		else if (!copy_only_ccs)
>-			emit_pte(m, bb, dst_L0_pt, dst_is_vram, copy_system_ccs,
>+		else if (!flags.copy_only_ccs)
>+			emit_pte(m, bb, dst_L0_pt, dst_is_vram,
>+				 copy_system_ccs || flags.defrag_ccs,
> 				 &dst_it, src_L0, dst);
>
> 		if (copy_system_ccs)
>@@ -990,7 +1029,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 		bb->cs[bb->len++] = MI_BATCH_BUFFER_END;
> 		update_idx = bb->len;
>
>-		if (!copy_only_ccs)
>+		if (!flags.copy_only_ccs && !flags.defrag_ccs)
> 			emit_copy(gt, bb, src_L0_ofs, dst_L0_ofs, src_L0, XE_PAGE_SIZE);
>
> 		if (needs_ccs_emit)
>@@ -1078,7 +1117,69 @@ struct dma_fence *xe_migrate_copy(struct xe_migrate *m,
> 				  struct ttm_resource *dst,
> 				  bool copy_only_ccs)
> {
>-	return __xe_migrate_copy(m, src_bo, dst_bo, src, dst, copy_only_ccs, false);
>+	return __xe_migrate_copy(m, src_bo, dst_bo, src, dst, NULL,
>+				 (struct xe_migrate_copy_flags) {
>+					 .copy_only_ccs = copy_only_ccs,
>+				 });
>+}
>+
>+/**
>+ * xe_migrate_copy_defrag() - Migrate a BO's backing to a reallocated page set.
>+ * @m: The migration context.
>+ * @bo: The buffer object being defragmented. Both @src and @dst belong to @bo.
>+ * @src: The source TTM resource (the old backing).
>+ * @dst: The dst TTM resource (the freshly reallocated backing).
>+ * @src_sg: Scatter-gather table of the source (old) backing pages.
>+ * @need_ccs: Whether the BO has CCS aux state that must be migrated too.
>+ *
>+ * Used by the defrag path where a single BO has its backing reallocated at a
>+ * more beneficial page order. The contents are relocated from the old pages
>+ * (@src_sg) to the new pages (the BO's current backing) entirely on the GPU,
>+ * in up to two passes:
>+ *
>+ *  - Data pass (always): copy the data pages verbatim. The pages are mapped
>+ *    without the compression PAT, so the (possibly compressed) bytes are copied
>+ *    as-is rather than being decompressed and recompressed, and no CCS aux copy
>+ *    is appended.
>+ *
>+ *  - CCS pass (@need_ccs): copy the CCS aux (compression) state. Both the old
>+ *    and new data pages are mapped with the compression PAT so the copy engine
>+ *    accesses the aux state indirectly, issuing one indirect -> indirect
>+ *    XY_CTRL_SURF_COPY_BLT; the data blit is skipped.
>+ *
>+ * The two passes are issued separately because they require opposite
>+ * compression PAT settings on the data page mappings (cleared for the verbatim
>+ * data copy, set for the indirect CCS access), which a single mapping cannot
>+ * satisfy. Both passes run in order on the same migrate queue.
>+ *
>+ * Return: Pointer to a dma_fence representing the last copy batch, or an error
>+ * pointer on failure.
>+ */
>+struct dma_fence *xe_migrate_copy_defrag(struct xe_migrate *m,
>+					 struct xe_bo *bo,
>+					 struct ttm_resource *src,
>+					 struct ttm_resource *dst,
>+					 struct sg_table *src_sg,
>+					 bool need_ccs)
>+{
>+	struct dma_fence *fence2, *fence =
>+		__xe_migrate_copy(m, bo, bo, src, dst, src_sg,
>+				  (struct xe_migrate_copy_flags) {
>+					 .defrag_copy = true,
>+					 });
>+
>+	if (IS_ERR(fence) || !need_ccs)
>+		return fence;
>+
>+	fence2 = __xe_migrate_copy(m, bo, bo, src, dst, src_sg,
>+				   (struct xe_migrate_copy_flags) {
>+				   .defrag_ccs = true,
>+				   });
>+	if (IS_ERR(fence2))
>+		dma_fence_wait(fence, false);
>+	dma_fence_put(fence);
>+
>+	return fence2;
> }
>
> /**
>@@ -1096,7 +1197,10 @@ struct dma_fence *xe_migrate_resolve(struct xe_migrate *m,
> 				     struct xe_bo *bo,
> 				     struct ttm_resource *res)
> {
>-	return __xe_migrate_copy(m, bo, bo, res, res, false, true);
>+	return __xe_migrate_copy(m, bo, bo, res, res, NULL,
>+				 (struct xe_migrate_copy_flags) {
>+					 .is_vram_resolve = true,
>+				 });
> }
>
> /**
>diff --git a/drivers/gpu/drm/xe/xe_migrate.h b/drivers/gpu/drm/xe/xe_migrate.h
>index 965c45889c72..e4f996942a6d 100644
>--- a/drivers/gpu/drm/xe/xe_migrate.h
>+++ b/drivers/gpu/drm/xe/xe_migrate.h
>@@ -11,6 +11,7 @@
> struct dma_fence;
> struct drm_pagemap_addr;
> struct iosys_map;
>+struct sg_table;
> struct ttm_resource;
>
> struct xe_bo;
>@@ -132,6 +133,13 @@ struct dma_fence *xe_migrate_copy(struct xe_migrate *m,
> 				  struct ttm_resource *dst,
> 				  bool copy_only_ccs);
>
>+struct dma_fence *xe_migrate_copy_defrag(struct xe_migrate *m,
>+					 struct xe_bo *bo,
>+					 struct ttm_resource *src,
>+					 struct ttm_resource *dst,
>+					 struct sg_table *src_sg,
>+					 bool need_ccs);
>+
> struct dma_fence *xe_migrate_resolve(struct xe_migrate *m,
> 				     struct xe_bo *bo,
> 				     struct ttm_resource *res);
>-- 
>2.34.1
>
