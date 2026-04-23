Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC78FDEE49
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 20:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7C0110E075;
	Thu, 23 Apr 2026 20:22:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="d193iRM3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54EF810E075;
 Thu, 23 Apr 2026 20:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776975750; x=1808511750;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=tC6AefDpFmPDzRkf0toZM8DiQ9uWYpAavTj/WZQTYcg=;
 b=d193iRM3KIehj9TaAM84pi0RFpU9yh8VaIJc4z8KnRDSCmgqrMbz4TLF
 4PsAjEwXNEpJrbwrYg2YR8B7s1VHUR+PuA0zue9tvDhtUaFbkSL3X/y+X
 sJez2OH2XT+/x+pSqOv9nNQOoLmS2lHVYb7vxr7AehggPICghmt9rzk0s
 6V2GRpM4XoGhumKD7/syYMD+HJVGQXt19l2XoFEiKqYbj4QRPZHj9HTyc
 8Nz5C7TOrB/3mztzg2f4ylsg5IhOx1MV8luTkthch1+jymN5Fz4m/Dtet
 p2joPVBL2Fmc0MLlDSVdvmumlqJ/b9HEvgYTWIjdgdZ5NmkHkUveWQT9b g==;
X-CSE-ConnectionGUID: JDkHBATeSXOfCVgPDNEvUA==
X-CSE-MsgGUID: XDv7bAttQLOv4LWBkaGAlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="89419593"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; d="scan'208";a="89419593"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 13:22:18 -0700
X-CSE-ConnectionGUID: KHGLK+SDTWCuL4sgnXk/wA==
X-CSE-MsgGUID: cicbWSeLRdC7Bpmls6U/hg==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 13:22:18 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 13:22:17 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 13:22:17 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.16) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 13:21:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IceqihUEiF4t81a3fVTcEiEpLOm47V8ObXm7twHR2CbiXkXAz+nK5N0T6dVA2YZ9uKGSGY7cx8hsaPQJKJbPUeuK923+IerXD7OKJVStxPGn4W36NrZOgdKkNPZYtjZ+9IflVXhgNNFxuyRqEZTM8knaGm2zGRhRGny0JlHJPCY7u3NmrJ1br9E43mgOi8efu7OQEqhRe9Db1mnb84zK4IStgJblI6nEoks8unyUvEmeptgMypfdBDepRYPT6qE0gH9w9rXiFamOfYv6MkfslHQZi+0e/e9x6z6ndZ8vnXNe3uapnci3QYYkRfNea7WSWoQiXkfn+bjVJ4OZ3Q7AJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FavvwbXIfFcmNLrNyV4Ma58Ypg2ajNTFNWPLivD9/tM=;
 b=L/06bsoy8m6Ee9eoXuCwm7Xr0jdbMwwLzGdJYWjcA/Uq29tMNSLRizkVt2FsxZt6f/4WjtBXwFWi+CBv6DCx7DvYCAxXxv65Ev9/RYvJGJMOFtD0j7SC4O0sf37AteK0oY4maAnUUB875S6BrToG93hkPWhB9eL+HBUV0Berp2zDr60/iD8yZq0Y3pd0CtTgrJY/ey4k6aiGxkIXP11tyxvvZOy9vFh26r5Bz3/dp0yL4WpCNANsXddvzKBIRjrcDvfDhGswMWiF9sLxvdluFm7VWXMpFoFcGEln/4iOdNyo9yYeWNmnZ+T3WQ08xDHr+o/7IgUr/YeKNirIFx9QWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH8PR11MB7047.namprd11.prod.outlook.com (2603:10b6:510:215::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 20:21:36 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 20:21:35 +0000
Date: Thu, 23 Apr 2026 13:21:31 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: "Huang, Honglei1" <honghuan@amd.com>
CC: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>, Honglei Huang
 <honglei1.huang@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Danilo Krummrich <dakr@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>
Subject: Re: [RFC/POC PATCH 00/12] POC SVM implementation in AMDGPU based on
 drm_gpusvm
Message-ID: <aep/S6m7vG5K7Ra9@gsse-cloud1.jf.intel.com>
References: <abuE0KBPtAZM9Bo0@lstrano-desk.jf.intel.com>
 <098d5d68-f218-4cee-8b73-201e7012a287@amd.com>
 <acDeRhCTh/ehOUyu@lstrano-desk.jf.intel.com>
 <26186168-abff-4ce4-ad93-db9bc2fd68d7@amd.com>
 <acRgr7QwdULsn6G2@gsse-cloud1>
 <d2fddc5d-2628-47e3-95c5-874b3a0466be@amd.com>
 <5fb57768-35b9-4e48-8178-2e1760a93aed@amd.com>
 <aem++OfFRJqHAPTG@gsse-cloud1.jf.intel.com>
 <aenH0REel7/enRi+@gsse-cloud1.jf.intel.com>
 <812102ac-906b-4fbf-bc8c-1881493a3eca@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <812102ac-906b-4fbf-bc8c-1881493a3eca@amd.com>
X-ClientProxiedBy: SJ0PR05CA0104.namprd05.prod.outlook.com
 (2603:10b6:a03:334::19) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH8PR11MB7047:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cbac23c-ee65-469f-4c57-08dea175ea5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 7eagK3Al2STj+v2g+RBOjLXXKSt+tvxpwRMop3mPvb5jXpzIP+6eFD4ffsaVoWaLDbkPdh7nbP79tyW91jio61ybR8wWZ/2ltBnjdyZHLqQdmdAnd6JREcpHvb7Uq7HcZT5IsfZXUibBwt2a+xho/rFFSR/E3IJwxIIkAwjBzIXcP7geujwoqZq8TmVcrTs1qcYAn2wPArutlP7dwtUEG6LzO6jQZ/rcg64nbQrvtiuqMAxf5SkU010t1MD1Cp/yu1rUfyDFj+YcawhELkU9P0n6cmBdK2sOy5NEKMV9dJaZ3XsgDXslfsRwE4g+6jPnP18j/j3pxlSHIQo+0G3acPHahxUvClclye6d59SX+TQ1kAcJNgZpvDYdTgodQArOSA3ZkvOWcXCdf+RF8pjHXARo5WGGAjC+7Is+eh/PzlufpkIaCBjY0UhOygpaMmt9JUcAd1pW5WAq6zx5gZzvknphlVU+1jSayFJE4OkkIhTImaF2WnMZ/lmWlsXEw3buoOvL+h16LJAUXvsRh8Kcae8F8TGN041snXEmktbBguYBgS9LBNvRrRegoTrWz4twZfhWLf1veVR393ZMmR8iXyhOjOP1t+jEd8nd5wy6X3PIMGpAMNbQUyCsaOdSQSpRr9h0YSNSXLUlaM+ldyp/nsBEzEqwivs+NN/1tx4pLZEZQHSkMnSovdGL7hCfPTlZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUExcktzMzRzQ244NFNldWJnaldncGNQWnpSLzh1aUJ1V1ptY0JTOWEweVVO?=
 =?utf-8?B?UUNPNjJyeGJ3anZDUUNtTnY1UHJ1WWlITjVpR0R0cGxFQVJaUHVUcEFTYnY4?=
 =?utf-8?B?aVZ5L21hclBUZ3pkWjk4VmZTM2NjdkRGQmFyWExXaTM3SUVRdzJUaFljOTNq?=
 =?utf-8?B?SThtTm1MNzdmSXRlRTFWdTBqZmxMdDAwNHVrS3ZqV1NLRWZ0YmFYdFZRVFdj?=
 =?utf-8?B?SXk5MjhCNGY1czJDZm03bUV3cTZlRkxib1A3UzM3dVdBS3lPa0N6MUtDOHVY?=
 =?utf-8?B?ak1FaHVmazFiT1hCbW8zUGpFRkpBNloxcFRIR0F6NVB5aEJEaGxWb0pWWjd6?=
 =?utf-8?B?Sk54SUlZL29tRjJEei8yV3plUzkrbmRxVjFXN0R5aUk1NzJDYjZIb2psWEN4?=
 =?utf-8?B?dE5PUGFYMkxnVmMyaVErTU1DY3NCWVdzK2NLeW5XRXlTUFU1dGsxTnYvaTRC?=
 =?utf-8?B?cm5DZDl4QzVIZzQzMno3dyt6dGFRSktnSzZucWRGdGJ0RHRaa1F0bnVhYTNO?=
 =?utf-8?B?RnQ4czgyNzBaQnZHRzVkbDB5aUc1MnB4dHJNcXljMXlWMHVFNFJscW1yOG1B?=
 =?utf-8?B?Y0cvVUwzanNZQW9FOUl3cGVxQXdudXdBMUNLVEpRdk5pd3BIemV0dGdrekZR?=
 =?utf-8?B?TTNwbTkwSUpkbEpabzVzdXQ1RGxQdGthT1RHR0tVTUcwN09mSnRsaXhBQ3pD?=
 =?utf-8?B?RFh2eXZFckNxSXdwc3hhVGkrOW5iYlh1RVdkUmc3M1pYb3BkeVgrNGpSQWZS?=
 =?utf-8?B?eE5oWU1ZOXdQSFp0d0xjejRkNk5RWnFVMWd1Q3FrWWxGVEdBMmtvSXRNVlF3?=
 =?utf-8?B?V0dabjM4Ly9oc3FQZ2RLM29HZmVpYTdlR2hzam5FNVEza2xwbk1ZSjFISFBz?=
 =?utf-8?B?ZHoyT1h4enBaZTR4dUEyTTdBT0pRUG9YYlZKZG9teEpBa011WS9qWlUvRWhK?=
 =?utf-8?B?RERjZ2hKQ1RRdUtkbjd3bmc2SmZ1Uk9CckFZZG8vNmJ0ckhUTlVTeDFHbnU4?=
 =?utf-8?B?bUNJVitXQ3JXSnZ2V0VxMnI0d2NKYTN2VmhTQ2F5Vk5XNWp2VEkxS251VTFY?=
 =?utf-8?B?TkQ2ZUhRaXlRTGNaM0tOdzF5T3MwaTBSYnB2bGVBaEZWNksvQ3AyZnRrVDFU?=
 =?utf-8?B?dy9HR3JtSjhBSlg0Z0JYNG9yckVMN3pQT0RhZUV0cmtNVkF4L3JSS0s0ZHBR?=
 =?utf-8?B?aXVlek9Ha0pUUlJ4QVRyb3E4SU1mRTNlanVUR3hpVmxxbnE1YTNEOElXdjUy?=
 =?utf-8?B?dmdmOG5EMVFCQUpOVmVuWnhaS3pybkVwQ3lkYkdYS1F1MVplY1N3YkxmM0xO?=
 =?utf-8?B?bmtJSWVnR21Gd1Z2QnBBOENjd25iODlyL3dIZzJKaXE3SEd6c05PQUFQUXFB?=
 =?utf-8?B?Mnl2V3dHaGE5eTVYQ1FlekUwclFLUVFxK0ZMMWw5d1l4dUZwOEdmeC9paldr?=
 =?utf-8?B?NFRjYXk2eG9hOFV2M2cydFg1Vkl5bThob3FIZFBsMUsyUUpyWUZSaGNjOGk2?=
 =?utf-8?B?bWR1MUZJdFRSR1BjdWlFRUJGaHdqaXB1NGZVc1lGVXhQb0ppNzJyMHp3bmtV?=
 =?utf-8?B?QnFwTzRGRzJybVQ1V1E4enYwYnovVERSbmUzKy9hNTJNV1RvYXBONFNxaVZt?=
 =?utf-8?B?cC9CeEs1REYvclYzTzBoQmtjd0piU2N0M1VwSVBHYUZTYWtWSjFlVUtjclBm?=
 =?utf-8?B?SHRjdW9GYXg3NlN2M000ZEJSQ1IyOXFZRFhEdWtaVUFXYVBmbm55Mll6YXRv?=
 =?utf-8?B?cTMxNXdUdmZNUjRibzd4cnhaT1YzdlU3OEVyaHljYUJIeG9rcVVEZjFWaFpL?=
 =?utf-8?B?bjQzdVMxN3hEaHF5c3J1bjFEMWszcWRwSGkyR1hheXNsT0JrZHFaMGhNdjV5?=
 =?utf-8?B?RExxQWJYSE4wKzRnRm9iQUVGRDRjd2xRTTRiemhTWEJxZU9JamdUUmxKSUFC?=
 =?utf-8?B?eVdzWWhPTmN1SDY0RmtyNEJoYVpHYUNmS2o0WTZzOEk3NmdHQUUrcERrN3h0?=
 =?utf-8?B?Vys4SzN4b2s4d3FRaVliSEVUeDI2WE9Xc2J6dHRvOWRFbUhXTGxUWFhDcXZF?=
 =?utf-8?B?b1dJNnFyNkxuNFFNTVN3ZEx2MWFTTnhjVzFWVDNxQTgrTXg4eHFpT2E5VzEr?=
 =?utf-8?B?Vko3QkpDbjVZbU9ha3dBdWRSWmYrNlNwQTViLzcvbDBESGh6SHI1UFV6bjNY?=
 =?utf-8?B?elVnak9BMUF5SDZ4eGFGOUM1d3lvL3hnRUVSVnpLT0Q1T0g0N2dQVTBXNWtQ?=
 =?utf-8?B?Uk5hRTVRdUVBc0dtSXIyT0FSNUNlOFdtL2FTMmdyWk5TRDQ3L1NxVHNORGhv?=
 =?utf-8?B?RE5OZERIb0NNcEsyR3dZSm9hY05FSjg0eDl1N2V3TG5aQkROb2t1Zz09?=
X-Exchange-RoutingPolicyChecked: JY9H9eTAZ6wFUtQsss8k93PVDR8JGFnw75UQwoEXtPhlFHZIdKbRUwHCL9skO7pRAbw+LrK7ApIuHZ4nKoYFWOwNGiH8EnHQbBCm/Wd5rS0igriDzZ+e+uzsiGp8Z5Uxdj40p0fUu/XVMNQLqS0sFIHi8eNuraWpZqnY6Otxpe0lcZPIC9QzWvpvMGszjfhAKxIKjAdpE42ddAUjsNL0BXq88vGMoKlYcRDVtCJxAjt4XyaCTBgROJNMgfZcPCeWYU/f9PgswU6chVn9oh1V1OeBBQW9WQt8rcugzzG9do8J9L99hgzd/NO+ARXTZ13yfGxuFRCwhYMoks60Vm9CSg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbac23c-ee65-469f-4c57-08dea175ea5a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 20:21:35.5734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1VJerIP8vqqIMjKs9ibCY3mVpeDmQvi3xYaPlaIv0zeqRKGSbZOdrpsbJ1M8Z5+Cr42LbCVm7Gzh01NhKYWKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7047
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

On Thu, Apr 23, 2026 at 07:03:52PM +0800, Huang, Honglei1 wrote:
> 
> 
> On 4/23/2026 3:18 PM, Matthew Brost wrote:
> ...
> > > > > > > > This clarifies a lot. This is what we’d call in Xe “preemption fence”
> > > > > > > > mode for a VM. Anytime memory is moved, we trigger a GPU preemption and
> > > > > > > > resume. We don’t actually support SVM in this case; instead, we use
> > > > > > > > “userptr binds,” which are built on gpusvm for page
> > > > > > > > collection. However,
> > > > > > > > we don’t support migrating memory to the device—though we could.
> > > > > > > > 
> > > > > > > > I’d look at how we converted 'userptr' to be based on GPU SVM [2]. In
> > > > > > > > this case, don’t maintain a range tree, as those—as you
> > > > > > > > suggest—are more
> > > > > > > > of an on-demand fault driver concern. Instead, just embed 'struct
> > > > > > > > drm_gpusvm_pages' in the VMA struct defined by the IOCTLs..
> > > > > > > > 
> > > > > > > > We could extend this to support migrating 'userptr', but we
> > > > > > > > just haven’t
> > > > > > > > done that yet—this may be what you want to do in “XNACK off..
> > > > > > > > 
> > > > > > > > [2] https://patchwork.freedesktop.org/series/146553/
> > > > > > > > 
> > > > > > > 
> > > > > > > Actually we need to swith the xnack mode between on and off, so
> > > > > > > in xnack off
> > > > > > > mode, the driver operats in "implicit  prefetch mode". This may
> > > > > > > be due to
> > > > > > > compatibility with older hardware and the need for UMD runtime. We will
> > > > > > > further discuss the handling method under xnack off internally.
> > > > > > > 
> > > > 
> > > > Hi Matt,
> > > > 
> > > > I studied the xe_userptr code and the conversion series [2] you
> > > > pointed to.
> > > > 
> > > > I have a question that:
> > > > Would it be possible to reuse drm_gpusvm_range to handle the hardware
> > > > without gpu fault feature(xnack off mode).
> > > 
> > > That’s not how we’ve done it. We embedded drm_gpusvm_pages into our VMA
> > > structure and then attached a notifier. The notifier attachment is
> > > open-coded on the Xe side, and this could be normalized and opened up
> > > for common driver use cases.
> 
> The way in xe_userptr likes the implementation in kfd_svm: embeded physical
> pages into structure and attach same size notifier.
> But kfd_svm is an implementation of SVM semantics, which supports partial
> unmap, doesn't need explicitly delete userptr ioctl calling when remove ,
> and doesn't need a explicitly userptr flag when creating.
> And actually there is also a existing implementation for userptr semantics
> in amdgpu kfd: KFD_IOC_ALLOC_MEM_FLAGS_USERPTR.
> If the no gpu fault mode can not use the drm gpu svm fram work, use the same
> way for xe_userptr, it seems like doing the duplicate work.
> 
> I think the core gap is we are trying to use the drmgpu_svm to implement a
> SVM semantics driver for no gpu fault hardware instead of userptr semantics.
> 
> > > 
> > > The problem with reusing drm_gpusvm_range directly is that a VMA may
> > > span multiple gpusvm notifiers—i.e., it can be larger than the notifier
> > > size. Of course, we could rework this as well.
> 
> So the "VMA spans multiple gpusvm notifiers" concern: I'd like to clarify
> that this is not actually a blocker for amdgpu's XNACK-off path, because
> amdgpu does not try to represent one user ioctl virtual address interval as
> a single drm_gpusvm_range.
> 
> we walk the attr interval and call drm_gpusvm_range_find_or_insert()
> repeatedly, letting gpusvm pick chunk aligned ranges bounded by
> notifier_size. One ioctl interval will create N chunk sized ranges.
> 
> > > 
> > 
> > Sorry for the double reply—I just glanced at the latest series. I don’t
> > think creating a range per page of the userptr is desirable. While it
> > would work, from a time-complexity point of view I don’t think this is
> > ideal.
> > 
> > The issue with spans across multiple notifiers is real, though.
> > 
> > My rough idea would be:
> > 
> > - Give drivers an interface to create larger ranges.
> 
> So maybe we do not need to create larger ranges if we call
> drm_gpusvm_range_find_or_insert() repeatedly.
> 

That will be functional, but consider it from a time-complexity point of
view.

Multiple ranges increase the time complexity of range-tree searches.
This isn’t a huge deal, but it will show up to some extent.

Multiple ranges will also slow down DMA mapping and migration. We
switched over to the dma_iova_alloc/link/unlink/sync uAPI here [1].
While dma_iova_link is a relatively fast radix-tree walk, the allocation
and sync steps are where things get expensive. Therefore, it is
advantageous to perform these steps as few times as possible. For
example, if your SVM buffer is 512MB, instead of doing these steps 256
times, you do them once. The same logic applies to the migrate_vma_*
functions—they are quite expensive, so doing them in a single shot is
significantly faster.

The same applies to invalidations. If you can invalidate a large range
in a single shot, it will be faster. Although the logic in the notifier
should be able to zap multiple ranges in one shot (Xe does this), having
to DMA-unmap a single large range will still be faster than multiple
smaller DMA unmaps.

The TL;DR is if your driver knows size of SVM allocation upfront (e.g.,
an IOCTL tells you the size) it makes more sense to use a single large
struct (either embedded drm_gpusvm_pages into a VMA or we figure out an
interface to insert large ranges / notifiers).

[1] https://patchwork.freedesktop.org/series/160587/

> > 
> > - If the range fits inside a single notifier’s size → done.
> > 
> > - If the range spans multiple notifier sizes → round up to a power of
> >    two and create a larger notifier. This may overlap with existing
> >    notifiers, which is likely fine given that interval trees support
> >    overlaps (?). We’d need to double-check and test this. If overlapping
> >    notifiers are not acceptable, we’d need some heavy-handed notifier merge
> >    logic—it will be complicated, but isolated, so once we get it right
> >    everyone can use it.
> 
> If we call drm_gpusvm_range_find_or_insert() repeatedly the drmgpu_svm will
> create the corresponding notifier correctly as far as I can see.
> 

I agree this will be functional but not ideal. You can always start the
approach you have here and optimize it later by adding the required
support in GPU SVM.

Matt

> Regards,
> Honglei
> 
> > 
> > - Finally, make sure that individual userptr pages can reside at any
> >    location.
> > 
> > Over conversely:
> > 
> > - Normalize embedding of drm_gpusvm_pages in VMA structs + notifier
> >    creation
> > 
> > - Make sure that individual userptr pages can reside at any location.
> 
> > 
> > Both options actually sound really similar after typing this out.
> > 
> > Matt
> > 
> > > So either way, the Xe userptr + gpusvm implementation should be refined
> > > further for common driver use.
> > > 
> > > > 
> > > > Reusing drm_gpusvm_range for the XNACK-off case would simplify our
> > > > implementation considerably, it already provides large page chunk
> > > > optimization, can reuse the existing migration infrastructure.
> > > > 
> > > > Building these on top of a standalone drm_gpusvm_pages
> > > > would mean reimplementing much of what the range layer already offers.
> > > > It would also let us keep a single code path for both XNACK modes,
> > > > which reduces maintenance burden and avoids behavioral difference.
> > > > 
> > > > Would this direction be acceptable, or do you see concerns with reusing
> > > > the range infrastructure for the no-fault case?
> > > > 
> > > 
> > > If you prefer something like insert a range exactly here + create range
> > > + notifier I think that completely reasonable direction and Xe would
> > > likely switch over to using this.
> > > 
> > > I guess my only concern is sub-userptr migration. We are trending
> > > towards allowing userptrs to being migrated either via prefetch IOCTLs
> > > or access counters on the GPU side - access counter we'd likely a single
> > > 2M page at time migration within the userptr. get_pages() supports mixed
> > > mappings between VRAM + system but likely needs some more work to really
> > > make this complete though.
> > > 
> > > Matt
> > > > Regards,
> > > > Honglei
> ...
> 
> 
