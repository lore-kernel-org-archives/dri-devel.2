Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA72CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92EDA10E270;
	Thu, 15 Oct 2026 13:54:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67B4510E270;
 Thu, 15 Oct 2026 13:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792072469; x=1823608469;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=iUxjUIN4fLahkahgLxlfrD7uCR3czLtmxeXOyC8bqvQ=;
 b=MiloV8apOdKFUXTpMoE8Hnrw6CMzajfsv0hc3NZslINLO2ZnQ04mOVp2
 mz3atU5ZSbVd9MmBaY0OAgtrxpuRmuDer5aq/FulStEI1hqcVoYtwu1uR
 K4ZCOgtl8PuUxBi8tMgQX77fznaAD758bzgN1DaQ2L1EaIfsiTQoiXJXb
 dJxBSjnAG6HK+Er+maoEdRXM7i6kCNVLkPdK31id+D/uNvG9Bf+kPSd9v
 n3/MYroRFqPand+yEMY0RC5plmptwA+UsQqDDx/tQcR4Z7JTr1skfDIgW
 snZjTGbS7cJtJ2Nnqg9VMEyd/MIZK/ZI9MrFBJu4j18yqxk+bX6lZOaC7 w==;
X-CSE-ConnectionGUID: UBM7BJD5TM2kwaEPnHlFJw==
X-CSE-MsgGUID: NISyMFdMRjCqvErO0D5eRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="945390"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="945390"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 06:54:28 -0700
X-CSE-ConnectionGUID: UryAHzfKTiqa1+PwrlUgVQ==
X-CSE-MsgGUID: vlYla9KsQ+2BsJ7eJhqAjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1609555"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 06:54:27 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 06:54:27 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 06:54:27 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.20) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 06:54:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMykvSJg5w0Ye58BWamFrTBaIIfMzgcS86YGcbbl84x61gljIORlrtsqD3SHZfBlV5sdhYknDEcXPYJPZ1+3Z1gwUDbt8ZRbFw+MclWW93aSknlBPe3rhGTWrNmjwGHnVadRr3JYS0F6wDsHqh2Uo1nFfoHmS1oauQ5Fbn8n86NHK4fCjUVCezksktg+3zPOwGEPrZuo2r5VnX3LEJ45NBHH0aOY9RKi2AVH3OZx8o0nnvIFtdunLBmmRb+C43b0RcgR1tNuVYPYQuecH872P8LN5WuTiDSOmR5o3J9E/BLjFpN/LPAu+ipWC+l1sMTCgCrd19KHDJjMU0HhP3dIkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2DrTMH/JAmanPFu/NgUvuRrC7JaZeaBnhPlqyVvViQ=;
 b=ZQopGjb/+hslNI9giiYcrQhwep2YRbcHtYn3nb8TQ9SX/ATzelImfCtrELhmEhRPVQBUBFgXB/GqvZnYg12cFQ3bmtf75qN34OK/E8uU3Cay+QCQbE7HNP/pNuXJ/dxmO6KR56p2tOcHDmehjoDczcca/8h+5C3tq5h6r38HRPq2W6w6Z56oqeMU5H4RBRY/ZOuzEvh4hahPJHxPxcjyJqQVHthbliE8adp+FEENUeZPIG/HLYZwtBOXzK6+ZObbtbBcDyWieU8oD51sepEvk0SsPBYS23ecXy40xylU9kjxgPIQJvcAXpn2n7uWU640y9nwEdBOLl5v7MY+QgsLSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 15 Oct
 2026 13:54:21 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 13:54:21 +0000
Date: Thu, 15 Oct 2026 06:54:19 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: FNU VISHWANATHA <fnu.vishwanatha@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Kornel =?utf-8?Q?Dul=C4=99ba?= <korneld@google.com>
Subject: Re: [PATCH 1/2] RFC: drm/xe: Fix pinned list UAF panic
Message-ID: <atDbC824Oc6YKrOA@gsse-cloud1.jf.intel.com>
References: <20261006175741.3582911-1-fnu.vishwanatha@intel.com>
 <atDaS9XDmNGa63JR@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atDaS9XDmNGa63JR@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: BYAPR21CA0013.namprd21.prod.outlook.com
 (2603:10b6:a03:114::23) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|PH7PR11MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d61f30-69f8-4198-8590-08df2ac3d09a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|11063799006|3023799007|22082099003|18002099003|4143699003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: lzIbr0wSIcDeZJYCLg81EYlnJM7Tzk2J1744h/aDb/rJ1pUhLM515MKD/e9E2q2rmXjOIWCbo7Y5PYljUoc1TR/48LjS58zJay7FMlgNxG7OkA76XMe3OQhLwQNkCDVe5Id8Cbip2D0/cWFqS9iWJpT6aTEzCV63Vylgh2u47A5tYDUe16SpAl6L4/A5eyGANPeGyErow0JRYkqzaWZpoQ5GcaVXamDSMM6R9HQSu0HtJ3oWnWEdzIO6rg1R/5yJgVXTw2T9Ts8aPW/7IHSENyFCiiNDcjyrU0ZBYSYJh6oUtpWyz8L451eLZW0fcIyHBplS4vJ5rERdm1nwDeQD4Tl5XPIxLuKaP18NAzoDSdr7bRGZRK4V010ddoxlW/xlson0DJuRvnJ00nT5AxgYNbA2zmrrtnrynR6hEQVGLK5vOtQaqONeBHSHUkW2Ko1ns6chu0ekh8ehNfUDtkAdF8OQgHchX3a+NDrofPAbUYwpzaryhT9YdyiJWWE9Fn/ZSm6kiwAj+ZSAZjz2pBH9SOkR3AI4Y2T474M41dTZcvb1qt9W1dHDaA+I/89E/uv7kIBwGBu3vm78K3ERPVW/vLNg9VGIygzqFMHYvXe55PIQckELOq3EP9FWn9EdgCe5D7vbkedexkvTUggVlxYBDsRW2v8F/TaQD7Pgl5sDv5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(11063799006)(3023799007)(22082099003)(18002099003)(4143699003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjFTOG4yUFRGTmdiaXhQUUY0OU9XWjNpZ1FFdnhjcktiL3ZpMWM0a0tKVmc4?=
 =?utf-8?B?NSs2akFBL21WMFJVbS9ENVRBRzdaWElhYVRMcHJ3ZXRGWHBsczhpRE9UVWEr?=
 =?utf-8?B?cVVrcVR6VlRHYWg2KzhXQVZOVUFrME1iQnNNME9pVTZZUCsrUnpnY0EzcDYz?=
 =?utf-8?B?MG1mYWllSkRQRnRhUVkzdy9kaFQ2dDdSNFR1U0UwZG9tSTl6cWF0aHEvdTJz?=
 =?utf-8?B?cU1jRDNrUHF3cHk5dEpaRTRMZEo4MjBxRVVzaUdOT0xreTd4c0FqZ2QzVktZ?=
 =?utf-8?B?K2IvS2tHSnVGSVFZemFWR25obGZEbXVVWW9nbnBXQWQ2VklCNmNpMzhvUG1i?=
 =?utf-8?B?d2REdkNlVUpqQml5ckw3S1JIc2hudHlxeWdoOC9iYzdKYmI2dmRiYVZqOTFa?=
 =?utf-8?B?QzVFOWdrbnlsZjB0eXJwUU02dklBSmZtR3RoZjFxR3hwbEJNL1E0cW9ROGVN?=
 =?utf-8?B?ZHhZS1hwRTJUb0ZlU3pBTzJKeU1tVVRWS1JpRnh1QnhwTXM0djl4a0lmRStV?=
 =?utf-8?B?Tkt1U1cvV0hIWXhYaHdyUHdZaFFkaFR0Q01jOC9Dd3JaR2cvR05FRHpvTm00?=
 =?utf-8?B?NHhxR3ppSmk4WlRHNHl5cnExc2V5VldZblEwb09rcDNSSDB6T3U5MlREajM0?=
 =?utf-8?B?VEx0YmN2SmJFSUFtUitTc1BhMVFvTVQ5Q21HOUFseGpHSDhPUEVtMFZZWE5M?=
 =?utf-8?B?dnI5aE5YMmRGc2ZvYUk4SlBMUXZhRlJEaDNBY3RzT2FWUCtWSmRFQTU0THdl?=
 =?utf-8?B?TlNHaVRuWlBTRUxHcWU1NGZTLzF1Wmx3ZGJqbnNERFVEYWVyQW1CTjNaQXJ5?=
 =?utf-8?B?SmRpUW1Oc09sSmVuR1lNcDhDK3J3b1RlTkdYWmVsVmJUL1MvRVR2QVlqN25i?=
 =?utf-8?B?T25XRVhycFZXUXpyTStiRDA0dlBLY0hDMzN5SWNDdW1GOTZ1eVAyQlpkcFZY?=
 =?utf-8?B?RGl2bzRhSHNPYzdsRXc5cXFMcmRYN1h4cytFYisrVGx6MWVMKyszTDljMkhY?=
 =?utf-8?B?ZTNMYVFrdmJvOE1RTEJOaDFTTEpONkFFaGZYUVlvUkVQT1EwNHBDdkxERyt1?=
 =?utf-8?B?S01FZUQ4enNRdnFZVFFWeFRsdUJVRzJiVzhXazlnTnF5RS82WkVDMTZHVmx6?=
 =?utf-8?B?d2hrcUIwbHp2V2NEN0dyekIybWxhM2RDY0dYNVF0cGJjVlFXY0tFYlhMT2pK?=
 =?utf-8?B?WWQ2UWJwbmRxSU55NmZjTEltZ3ZheTdaQzRVdHBYcEFHb1AvQ0dvN2hPU2hO?=
 =?utf-8?B?ZXRlMDhDcWZyUEdyWFM4dTlGTlRVanJWdjVnVlJTeHJtdkdyTk9yTUkyQ093?=
 =?utf-8?B?UktFRGJCSEt4SFpLTlVFcFdPYU1QSHZSaTFaSTB5S2JvZ1BBRmpFU2xidWF5?=
 =?utf-8?B?TzYrUElVa0FUMUdZYzlzZ1JJY1Fqb2ZhTFZSQUF1T0NVZ1VnU1cwazBoTUM4?=
 =?utf-8?B?Y1JwWWRvNG53MVh0S25rajFHR20zY3lxNm5SakhvSWtiTUZhT1JVRkhONFNv?=
 =?utf-8?B?bFNiZWJtZkFOUTR5M3QwM1pIcWU1TldENWc4OFNES0FWZzA0ZG16NllEbkFq?=
 =?utf-8?B?S0NCVkltMS9PVXNZY3VpMkZ0RlNVNi8wcnQ5WUNCdzdoRUN4VHN3S3A3Yjky?=
 =?utf-8?B?aDVYcFV4UEpPUTNPVC9DL3BNajBaQ1FLNnpUN0I0MVJMVHJOUW5manVYWURt?=
 =?utf-8?B?RDA0bmg1dlpWVmxhakpheDI0ZGxHdGpPS3c3NlRLWW9IbVpnd2RxbDJZR3VJ?=
 =?utf-8?B?R1N5RVJ0RnN0R0hZSVB6T0x4V1Z5OHN4dGNVaXB4a2VBY1BhQklsVTkrQTUy?=
 =?utf-8?B?cDFBOG03TDBZY0dpRkd3RmxLc1BVYzYyUURrdkg5L1hOaEVZc2llWmZ2ZFlS?=
 =?utf-8?B?VU9UOFI0Z0ZUaWNZNU13T0Z0OTdjc0cxZTVPZ01MY3k1Uy9iMnloSm1KUDc3?=
 =?utf-8?B?clovZTFKRTU1TWtYUDhTY3pBV3NPbE1BK1p6YnExZGFMeHlhQ3RIRzYraUtY?=
 =?utf-8?B?QzRjc0NhdVVESzFFT3RHQkUvMGxpMXZkQy9LRGJLQ3JYMnFMVTl5alFncHM2?=
 =?utf-8?B?UklKSjFqQ1Z6b3FZUm1BZ21vOEFtdVVmd3lxcS9iU3Fzem11MTlVc01lQWJz?=
 =?utf-8?B?cTZXV2NYOVVxMk5HS0Z4TElJRlVYQnh5S01CVlovemY4b1BiKzN3dEhjT0pw?=
 =?utf-8?B?bGNId0FmTjV5WjJRcXE0UzdoR1RxWGpNR3BXVDFadVQ4R28zZjBWb1JWNjlO?=
 =?utf-8?B?NjYveWJTYVJ2SlV3TXA0bWE4Wkl4cktWMGJ3akw5WktENHlsS3NxWW5SY3JV?=
 =?utf-8?B?ZEtURXN4ZWkranNqelJrZWEwVUlvMWdVd1VPMmFOWFVpaFp4NUJsZz09?=
X-Exchange-RoutingPolicyChecked: R5Any5qCUIyB8p4is9FLRGNY+BxC2rI21ROee6iVq1Xc4f7yatVa1a3D534XAuHHbSZC/t/AydpNGA6Edexcs7tbUnJv0vOsImY2SpY1ZoJ9uDAP+5TXeMqCuwZ3ibZj4mv+T6bQTvtcvJMIezM+wJERqWCh/fWv1C4LXCtZY9ciR5zqOFm5IK9I62AyB49640CMbgmFTmFYJG3tmpg1SoN1l1dbOjgHPv2S6WnVatNwFDFWQ9MGVFhNfglfrcOUb9wipwlnslhtaGqwo/KRqAjrRBjNpJNdOysM+wHAUxk6HwFLxf2eLpWW3wyVUoimtxSPnWdZ0EH1MOufiU28xA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d61f30-69f8-4198-8590-08df2ac3d09a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 13:54:21.7562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBr8aRIruDJ3MsQ3YvcN5H4R8lFLcKznAo6vUW7W9edj8PPWuLenUpRYR5iRAVoGW5sG/PccANmKl3jeSeiKnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6605
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

On Thu, Oct 15, 2026 at 06:51:07AM -0700, Matthew Brost wrote:
> On Tue, Oct 06, 2026 at 10:57:40AM -0700, FNU VISHWANATHA wrote:
> > From: Kornel Dulęba <korneld@google.com>
> > 
> > A kernel panic caused by a list corruption was observed when the IPU6
> > driver is running under heavy load. The panic would reproduce
> > consistently within a few minutes of the test suite running, though
> > never during the same test. The corruption would always happen in
> > list_add_tail called from xe_bo_pin_external:
> > 
> > list_add corruption. prev->next should be next (ffff8bb9862912c8), but was ffff8bb9e811e2a8. (prev=ffff8bb9e811e2a8)
> > 
> > Having prev->next == prev, suggests that node was re-initialized without
> > being removed from the list first. This indicates that the BO might have
> > been destroyed while it was still pinned.
> 
> This is a bug if true.
> 
> > Looking into xe_ttm_bo_destroy and its caller ttm_bo_release, reveals
> > that the latter supports a case where bo->pin_count > 0, albeit with a
> > WARN_ON_ONCE. Since ttm_bo_release sets bo->pin_count to 0 in that case,
> > add a complementary change to also remove bo->pinned_link from the list.
> > With this applied, the test progresses much further, with the newly
> > added warning seen in dmesg.
> > 
> > Test: atest CtsCameraTestCases
> >
> 
> I don't doubt the test case but this an investigation for a proper fix.
>  
> > Signed-off-by: Kornel Dulęba <korneld@google.com>
> > ---
> >  drivers/gpu/drm/xe/xe_bo.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> > index f2634d048cd4..c5989db950f7 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.c
> > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > @@ -1688,6 +1688,11 @@ static void xe_ttm_bo_destroy(struct ttm_buffer_object *ttm_bo)
> >  	if (bo->parent_obj)
> >  		xe_bo_put(bo->parent_obj);
> >  
> > +	spin_lock(&xe->pinned.lock);
> > +	if (WARN_ON_ONCE(!list_empty(&bo->pinned_link)))
> > +		list_del_init(&bo->pinned_link);
> > +	spin_unlock(&xe->pinned.lock);
> > +
> 
> It shouldn't be possible to get here with a BO on the pinned list, so
> this is papering over a bug some where else in the driver.
> 
> I'd prefer 'xe_assert(xe, !list_empty(&bo->pinned_link));' be added to

Inverted the logic...

s/!list_empty(&bo->pinned_link)/list_empty(&bo->pinned_link)/g

Matt

> the code to assert this and if this pops, we case down the root cause.
> 
> Can you please file a gitlab issue with the details of this failure so
> we assist debugging and get a proper fix?
> 
> Matt
> 
> >  	mutex_lock(&xe->mem_access.vram_userfault.lock);
> >  	if (!list_empty(&bo->vram_userfault_link))
> >  		list_del(&bo->vram_userfault_link);
> > -- 
> > 2.34.1
> > 
