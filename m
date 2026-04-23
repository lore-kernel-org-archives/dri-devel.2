Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60C1FAD41B
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 06:16:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F97710E2FB;
	Thu, 23 Apr 2026 06:16:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IRj7M4P4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9744110E2FB;
 Thu, 23 Apr 2026 06:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776925005; x=1808461005;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=3JI1/w5OnKaCmAB6eEAkSchtNe2/ENk9qynX0lzETDA=;
 b=IRj7M4P47ZdCzf9MjKIZ+zo5bhTPVBsHrDrJktFjf19Cjs+tGnEDKF37
 7TIj9jhx8U1n2D2EYNaggmTSX2kRP2kS9Ec6wFOj0lQl3/tSrgDPnJ9Q3
 g3GKSrVPKJHlpvaNixXw03A/X67z2DjYWzFaLTAmueQm+zUY3eovbIugS
 vEByg2w4Vh8XW71wxmA2Db3egvDz7zbocv7snWdZ21ORyQCb0utKbQ6Fi
 cvbhTqusB+X9IBlBtzjiv7DZ03rgcS5QwzQwLU1LtBQc7b9kulaRWW1zF
 nrIJju4y2qOkYJCDpGhf/57JD3aHbaEf9EURlit5l+6Kisval3MZ1I41g Q==;
X-CSE-ConnectionGUID: SdyS2RFGT2eSzmDznf8/Eg==
X-CSE-MsgGUID: gE5iqqhnRuKb4GdUtN7lNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="89275694"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="89275694"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 23:16:45 -0700
X-CSE-ConnectionGUID: q93PDmAkTO+U66uWycQbyQ==
X-CSE-MsgGUID: Lv8emtX2TxGGwEjC74jcTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="232415756"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 23:16:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 23:16:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 23:16:44 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.51) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 23:16:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4Zk4gh5H97SJjrUHRPw2DzqbIIqOEi4ZD+INYMklCKtiKv2tY5+koZ+rT63Ekh3kTkXOuVSgB+v9NVhh7BRE91oOfXPSKdBz3tUk8s/G0J8QUtlbjURhZHgzPZtOMSz3acEZCXPXhsSCfqe0glDcPAzZFciy/wQ7B9riH7NSXPb3+cEr0gK9oIbdfi7JRUE9Q+HxPRfo0gY8vQh5TTa1SXI4zkk9amYKUAp/Ay9g6dXZqonVinUm+hpr/F+1Jt4NuiNfLnMJPP9QvIw3ixf27guAppW7sEqGM1EYIo/Hf2LDkEqxRQRVjtp0lBZeugbEjCEhue8wj0GrKK10j7epA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYj4utOR/2ORCuzsxgKV1M1p/J7aYD7p8B0A6oOviek=;
 b=eNEIksG17xsSpYbm3SjYAfa+7CwuiRjcKQayzPyV76ZTFocv0nC4bovhWBcDAOSDYTi0iAt8Oaai4tsxBeCRoux4KJ8XTY3TUB062LtMJGUt89+vmBk9EZJLupaWcswleClcLGJxUl8/12JBIjOgxxB4iotglkQBWLILkd2tY2fl4PgznI0hlCMKMaUhsHiLymG3Bw4ZIG5yur2ua6Ge7/59GKFwa7E42LJJ/12spg7Pw2w9SYuxaSjr8tlw3Gw7lqKHHW4m01Q9V5v5c4ZCIUzoGoa+RbWJpG4w1xFTiPpbGKQqxAFfNfodkKuxteHEgTrgQEFTFvxRsMuOWZZriw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SJ5PPF1FF629472.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::818) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 06:16:40 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 06:16:40 +0000
Date: Wed, 22 Apr 2026 23:16:37 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Balbir Singh <balbirs@nvidia.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
 <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] mm: Introduce zone_appears_fragmented()
Message-ID: <aem5RcHbj5zcKbsw@gsse-cloud1.jf.intel.com>
References: <20260423055656.1696379-1-matthew.brost@intel.com>
 <20260423055656.1696379-2-matthew.brost@intel.com>
 <b0bd6cdc-511e-4fad-959d-3fa75c865aa8@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0bd6cdc-511e-4fad-959d-3fa75c865aa8@nvidia.com>
X-ClientProxiedBy: BYAPR01CA0063.prod.exchangelabs.com (2603:10b6:a03:94::40)
 To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SJ5PPF1FF629472:EE_
X-MS-Office365-Filtering-Correlation-Id: aac67cf7-6e13-4ed8-774d-08dea0ffe200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mLy3aJe+kU2fO4heCpvjyGHksV2NywbFkBwbqF6vpJS715LMjR58saVfbRsIcBjQmA5URN/m/p2cZg7Pur5gsW9FQBMkS/ZOHZ0MVKfxICxTGT+VW/PAyKXeXlovFFx8j2xKL5VHYMYPtnE7KEmvgMZUiLvDNb5i91BuobMtMjsfe48d2aPVZ9UtOL/5/w7ZsMbc+c/ialJ2hdcpQxGt+XD8hWlKESmHzJP8TQO2LUEGCHb+xxrHD1D02UAd1tUFUNe17Misb63wDDbdmGz2rg6dO6CSYLW+On0MXzY83abVLBfyCYe0YxhHQjDNQ3H6uZts0yVzvZOmoSammAPbmU/3f+qYo41JcjjSix7XWgLjbCeD3u4z1lpdw1B4I/oAo2uatxdpNp9KgZBTxuNTWxFHCWoZ6XMy1Rr6pTtdNZEi0NZB4mcmEweWAwlC084t3RbmjtkxlAFoHYkuw4TjnJXIF6KVpLcY7scU1vbKBp3MicR02mC78LyjVMGC+ncf92zUPCSRKlC3tgAeffL7ryyb8wzolxYPfL3/eqQ4gtKgu9j98dEFo0lJJFLbMNZuN4zwddaUBOO18pgTzBwUE6k1ZMWiNJ4heTujGG9/IoG43UCRptQjbXt7yibHJYVs6fa6R6QY2EBUFGdQr4GV25jSD19rYUZqRPqf18XHRujwlfJ2Ssm9qjOK4LhWAsMu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnUvSE1ZRkxnRVpWS2xnWHBROUFCTTk5bEJIU1oxWVNZMzVBQ0pBdStvMVls?=
 =?utf-8?B?ZHpSd3BOTlVQbnRJeVRtUWNUMllSYTY2V2dhQnE2a0FzanlBT3hhc05iZng0?=
 =?utf-8?B?R2YxQ09SaURjWjc5RWdvM2ppRmhXRjB4c2pDWldMTDhRVGtFNlpiclREbmxN?=
 =?utf-8?B?N2FDVmhaenNWVG1aMW9SNk56MXVnSVFvZVBSR1ZpckIwWEw3czAzN2RIU0I0?=
 =?utf-8?B?S05pcGlCSWF4WE5hMG1hRERTaGxKZW5qUUs3d1lVVmRjdG0rTmMvbUh5Rklu?=
 =?utf-8?B?bXNSc2N0cHFSblBQQXNQdkI1T2lYazdBcktlN21CVFNTNlBrREZuSWMvYUtz?=
 =?utf-8?B?VVpLZlFwb0VlcGhLL1hkVmFDSmlwdzJLbWc0ZlNCYnZyTzBZSjY0dlhXNUxz?=
 =?utf-8?B?VEJwZk0zdnQ4MTVWS0toNU9Pd3RIb1l5dHVzN3Irbkh1dVBaOXJWMW9LRmth?=
 =?utf-8?B?cnNVZ0RUVkdLZkFmWmllcTJTZTNTVVhHS3hMZFl2WVp2YjZpTFYwQjQ3TWEy?=
 =?utf-8?B?RzNsemRPeUpNVElMWTFFWGI5SGJqY0FMMTUyUktOVGtsQzRGOWlBcDVKb2tN?=
 =?utf-8?B?NkpBTHpGdnNQaEVPa0I3S0ZrWFJoVXpjd3hIL3R5MHNIWEZ3akYzSG9SSENQ?=
 =?utf-8?B?Qm9GaG1EbEh0U1VQQ3RlUzMwTVFsdGJFSVQxQk1aYXFNc3FPRzJIckM2VlRk?=
 =?utf-8?B?eUxzcWkzQjVtOTZIQUR0dU9IUnNUUSsrVzVISUpBMWdFY2NIOHBKWEtSRG5W?=
 =?utf-8?B?TlhnaWd3TUdwUTh5WU5Gb3VCMnRjcndGc205VFJ5L2djLzlvcjk2OFhkMW01?=
 =?utf-8?B?d3FLSzhxSEhnTkhlRFRQbFBVeW5BdTQwWXp5UDFzanFWM09IZ0w4R2tWbGpw?=
 =?utf-8?B?STEzZi85OENYL20zMGJFWjFsKy9Id01hNG5Jb0hCNCtoN0R0amxJbzRXN1RU?=
 =?utf-8?B?UjIzZis2NFh4d1dJRmUvekdmVXdGSFNybU40NHVxMXJ2Y0NEYkVWOEdhODlG?=
 =?utf-8?B?RlA5cjYvTWtCZG1iNVpnRHNkcHZwRURUTTFZaWpGdVlndmJxd0k0SkJLaGhl?=
 =?utf-8?B?WnBYMXJPNEEvaU1NaWphY0c5N2FZT3JuSGFoeDZGb1QycU92QnpQbVVIK2RF?=
 =?utf-8?B?elh5aVlsNm9FOEhQMmcwZ1ZLKzRNZzhzY0RqWXVhWC8yR0xvSEVIL015Nmw2?=
 =?utf-8?B?aDNPZ0xTQW14TlJnYjFrenpRREdRY0s0bTVCcitOQ3RjeHBWL2R3MlUxL3BV?=
 =?utf-8?B?ZGQ3N0h6eHpvRUNFdzVXcitQZ3BoYUs5aU44TGt1TzBIeWRCRG0zNFBOWnVZ?=
 =?utf-8?B?NUw5RDU1STRmc3BvMnlYa3ZvemsyR2lGRWFZV2lJT0ZFYnJTdXVqYjkxTWZZ?=
 =?utf-8?B?L2M4NEkzOGt1d2JNeEo3RkF5YzBlVWZ4K2JXajY5MkhKbTkrWEZtK0hJSzgv?=
 =?utf-8?B?Y1NLUEsrS05PaXFxTGhSMGhQZHRxSm1uQjF4K3h2SFZ6VjRvSWt4NndFQ3Y0?=
 =?utf-8?B?OVdMWTJOK1oydWlmZkdJOHMxTXNCZURWcXZ2RERKdWRicU5JVWUvTk51b08y?=
 =?utf-8?B?eWowZngrYXl2MFJvV2xqYkVtYjU0bGxoc2hLZ3lqRWdOVW5uUkVjTE1KT0Vq?=
 =?utf-8?B?dWx3RHpvaUVUakxTelVMSTZGVjgyem5TRG5aZll3LzUza2kwcElpVytGZklK?=
 =?utf-8?B?azRlWG5GNGtCK0RiOFdVQmRoRTlGWlRFQ2RabzF4cEVLNXl2M3hLVHdqTjVR?=
 =?utf-8?B?OE9VRDllNzNSYkJrcDMwZDliUmg3c0w1ejhLckNzTS9TSEd5d1pnQko4Vmsv?=
 =?utf-8?B?UWxKNXJRcHJlZ0gveS8vc1FadzNVNEp5UTRyQndyM2ZoNElZR2hOR2poSHZ2?=
 =?utf-8?B?aXlpVU95Q1RsTzFOSFJOQXhKUFRXV0tpR1pGZVkvMWNPY3ZuTDE4bXNFVzlO?=
 =?utf-8?B?MlphZDFVbUR3dDJNQlNOU3lGRHlpUWQyTEI2bnU5TEhQekdtVmJyTzIxQWJV?=
 =?utf-8?B?R1JIbkFoYWlNNlNHbU1ueWpLVG1MbENpZzNlamliV21IRW1HMDRtNWMxbjJ3?=
 =?utf-8?B?RjVwWm9aaUNEUE1KbXpvNFE3eHlvMHVqVDJTOHBNQ2RReFdDS1M4aDVnbXdQ?=
 =?utf-8?B?Z2VteVp5YnZrZVVCTm95azRXbjlDWGxNQ25lQmJDeHNnR1pSWE5UejZ2cGxv?=
 =?utf-8?B?czUvOTFQUmFnd3V4eGJzSnptaHk3NWNjaUpJbkI4SGNLOW9TcmNSdUloYnQ1?=
 =?utf-8?B?MUZkVk41OU5PaCtUR3ltODdJdVZpbG1aLyt5YjNxZjBFYXBsVTZlV2pwTUlX?=
 =?utf-8?B?MGJhb1dVQjllUHVNTmpUOEZiMTk0MWZtWExoa2VjN0t3cXNoVE10UT09?=
X-Exchange-RoutingPolicyChecked: rA1DQaf4A4Vj7/NTnoeyC39NlXHh4KYv7GF9iAv0ez/yRKz/AgTtu9S+Gdst42+B51JbjDwOGEug7RpU85b/7zjodUgTLJTy21Qd27LVF2LstLcjWx+psm1+0cxmnjqGGKDgG1TTcImxdG3+hcZmUZJrrOuRMda58T3vSxdLwrTSIhZiGKhCJoU6w2ZteYOZGxYYHqw5eLTYYK81TNk0irPeWQHHtFvY28L5d1uxz52QhpCsEAQSs4wkEEVfH+rRe/i4nBVjscxVCWslKiSu4AJKvaTH+KDe0JFboTk0foK3QHHgHJWo3Q8f3aHDDVqD90Q3RqpTgL00LrhZImSPaA==
X-MS-Exchange-CrossTenant-Network-Message-Id: aac67cf7-6e13-4ed8-774d-08dea0ffe200
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 06:16:40.3849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBpyHPLzuehK5/TT56TJoE54PQzDphF+53lYRmq16ZujZ3UAQ6vPd+UFB74LVfeOhWK4jPdTYrr8v/bE+n8PgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1FF629472
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

On Thu, Apr 23, 2026 at 04:04:32PM +1000, Balbir Singh wrote:
> On 4/23/26 15:56, Matthew Brost wrote:
> > Introduce zone_appears_fragmented() as a lightweight helper to allow
> > subsystems to make coarse decisions about reclaim behavior in the
> > presence of likely fragmentation.
> > 
> > The helper implements a simple heuristic: if the number of free pages
> > in a zone exceeds twice the high watermark, the zone is considered to
> > have ample free memory and allocation failures are more likely due to
> > fragmentation than overall memory pressure.
> > 
> > This is intentionally imprecise and is not meant to replace the core
> > MM compaction or fragmentation accounting logic. Instead, it provides
> > a cheap signal for callers (e.g., shrinkers) that wish to avoid
> > overly aggressive reclaim when sufficient free memory exists but
> > high-order allocations may still fail.
> > 
> > No functional changes; this is a preparatory helper for future users.
> > 
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Hildenbrand <david@kernel.org>
> > Cc: Lorenzo Stoakes <ljs@kernel.org>
> > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > Cc: Vlastimil Babka <vbabka@kernel.org>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> >  include/linux/vmstat.h | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> > index 3c9c266cf782..568d9f4f1a1f 100644
> > --- a/include/linux/vmstat.h
> > +++ b/include/linux/vmstat.h
> > @@ -483,6 +483,19 @@ static inline const char *zone_stat_name(enum zone_stat_item item)
> >  	return vmstat_text[item];
> >  }
> >  
> > +static inline bool zone_appears_fragmented(struct zone *zone)
> > +{
> > +	/*
> > +	 * Simple heuristic: if the number of free pages is more than twice the
> > +	 * high watermark, this strongly suggests that the zone is heavily
> > +	 * fragmented when called from a shrinker.
> > +	 */
> > +	if (zone_page_state(zone, NR_FREE_PAGES) > high_wmark_pages(zone) * 2)
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> >  #ifdef CONFIG_NUMA
> >  static inline const char *numa_stat_name(enum numa_stat_item item)
> >  {
> 
> 
> Without any usage/users, this is hard to review. I don't understand the heuristic
> or it's logic as applied to fragmentation either.
> 

Sorry—it’s always confusing who to CC on cross-subsystem series. Last
time this occurred, we agreed to CC everyone listed in the cover letter,
which I did. Anyway, let me provide the Patchwork links...

Cover letter: https://patchwork.freedesktop.org/series/165329/
TTM patch which uses this: https://patchwork.freedesktop.org/patch/720036/?series=165329&rev=1
Xe side which uses the TTM helper: https://patchwork.freedesktop.org/patch/720031/?series=165329&rev=1

Matt

> Balbir
