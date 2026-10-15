Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF04DCC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:32:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FD06112373;
	Thu, 15 Oct 2026 14:32:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7E2F10E595;
 Thu, 15 Oct 2026 14:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792074722; x=1823610722;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=71Wca5iipC6nnbf9kOkF+mWvgF9p/rJyYhL7cNOzKVk=;
 b=R9mqObXEA0TREFoE6v09HZlBT8w0qOCN4SxqSiFfEkXT8d27U3DBB/6Z
 4YiiFw/e/YRksfqBpu8vukE5rzCj3lCkmfvTVNDQyyXg/G0V6P9vbAOls
 cKWixLrLFBDmb89BrmXBeNBK+9gtiQhnA/piM/WXh98wllWAUyJWu+Ajx
 zLZHLmp+Opue1tUk0FE1+ywIKdXuXCGE5HyeWttzGNk9SrUatOhlIhat3
 eLSASw7jk/Q0BsyyKvmiG3em6qaOdzIabmjn3DyItxKJjdQF4VNVPDNRF
 i+HUlYBMaCYe17H7nVD6T3+2FzBj5z0ygVbEb8RjyRnjw8T5miUM6zUAJ w==;
X-CSE-ConnectionGUID: S992/CMPQZ6KiHw7DOFWng==
X-CSE-MsgGUID: GxlBfJO3SOW3udJibh2hpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="878013"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="878013"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:32:02 -0700
X-CSE-ConnectionGUID: IFHuXZxySLCcmp1cE7+lkg==
X-CSE-MsgGUID: 02FRR2OsR+aljJOffhcZWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1618643"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:32:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:32:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 07:32:00 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.52) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:31:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNBMMImlyfgpQsGwB+rlKIPHlGVUJX3yPPVxIYe6e+p6fuhVjjAVL3kbu/V32GewnrVYRfl6cWMgGGsGz1oANk5gPrs0oPMiFqsIYYBb1HSMSj1mP9JAYKnT2Em6RCH5uBMKG8pF1Gk9ghrikaU8YqlYParK61oTdVH1/FOcRfqxvUZ4gDBP+pl8E79MdKa6i1MYrxM8HElMWN3KYTn4J5LmGe45gp2/Uxbn4LChy2bfQDYBYmQ96+XV8xWyQvn4KO28TqBiexTt2Z3Dx4jYpFTYqZA5H8PkOjF1pPoSUsR0r/zS3URPSH3F4n9/1maFYVRWrft3t9LXv1TC2eKyhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPiRfahW8ILvOp7ijBqwQMToxTunwAvw1Jzi4X+9vQg=;
 b=wohR1Oj9pONK33at6sZC8G6k4ZXGXCYKU2gi5mqgWBEje+ne5peWiinTXkKI5GMibEdyOVjkQM0s/mOlnPR8M6WyfOsYDza6RB7yp9iTsLl/yWa3bGAFfTVC5zMPB1aGtQE35YOlShCUl3Y8WRcjaw6DFP0sCD7ZtTX7i8WXPxb3ZlK6FibYh/9c9a4jt32dytAoxl0uAuBAdwWtAybrdXr8K+jNvJ5irQe9WXFiSagtynqWC5BvJDXz3M++RqCkhNQ6VdV6Vl2JeS8iIjy9tWYY0vvzoY+CXHRsPFq2HC6rVYZvVPxwQRimqS8SRUCbYj79yDS2VHN1ZfoDUYTg1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by CY8PR11MB7107.namprd11.prod.outlook.com (2603:10b6:930:51::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 14:31:50 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 14:31:50 +0000
Date: Thu, 15 Oct 2026 07:31:47 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
CC: Matthew Brost <matthew.brost@intel.com>,
 <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH v2 3/6] drm/gem: add drm_gem_prime_dma_buf_to_gem()
 self-import helper
Message-ID: <atDj06blYt3HH4VE@nvishwa1-desk>
References: <20261013010614.1516799-8-niranjana.vishwanathapura@intel.com>
 <20261013010614.1516799-11-niranjana.vishwanathapura@intel.com>
 <as2LL7IIs6EcL6Pj@gsse-cloud1.jf.intel.com>
 <ff266a33-2729-47b4-8a1e-ff96bb456782@suse.de>
 <as56X/w+CLUE2kQI@gsse-cloud1.jf.intel.com>
 <d39bd8f3-0fe0-4537-bba5-8eba5bb36704@suse.de>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d39bd8f3-0fe0-4537-bba5-8eba5bb36704@suse.de>
X-ClientProxiedBy: PH5P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::6) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|CY8PR11MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: a3457c7e-69ec-4b72-d114-08df2ac90cb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|4143699003|11063799006|56012099006|22082099003|18002099003|6133799003|261009223027099003|10067099003|261009221227099003|13003099007;
X-Microsoft-Antispam-Message-Info: +kUrF41MChdsBkup8wX99M/BwB9WOf0L99Xgp8jYeO0B6K4HdfxhprI82z73WCSOw/oe21I8LZl6FpcVHTnIbsFHma+h+t2E+yg+7fVxrBAb7M9A+wwjm8M4XB6O+yu08kM7v6RicI4WokbitvgTwen8CVLlpYqyp5d6V/2u2Ki5fGWH0m2yMXXNQYfqBtqz8st/BkXLwMGUJVkXyDUzU2x34A+oLYhf4KNxFgeLskFtdhBUht6eCo4BsoG0Gw+dMbUmjnCPAuSbcvs9uOTtvMyAwVBqebNkTEN9MMVJqlv86ozL8yD1sO2VvA7Atckm4xkyOIl37cinQtuqN8E02IEMsJFMVE14bQqvwtE65R/iWMoBxH4WlSRlt31sQ8aCDO9sflAEts9iL/+hiwhQ8CXdI5Um2+nrcOGTrmayC71uKYvPJOGMh5HVr0dbcEnOXWZfsjhF0e+JDjYf+9ZpXbQnUwCSTmorJqfsGxq31vPD7Qq1Ty2e+qIPCO7FIZNkXBDd8YpB5nlL1hj5um4+fa4tASxwyM99ePmuJzjloluRvsYqALRHWUGZZLmqLQvWncU4g8zYZo57V6BfCKDXbfE0UoZ6Y/sCZU85IafpmPw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003)(261009223027099003)(10067099003)(261009221227099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?oMsl2fgOTF8sc4GHUCdzYbj4IrTwVqPNAw6hNZgzaN1yg78zMU6tjDLK4a?=
 =?iso-8859-1?Q?+8gGLDbOXbALpsRfUyGDWtZA1AYYEQAmTrJjSbOTmZPQ/1w7Or7XYHC0+9?=
 =?iso-8859-1?Q?97CT8TNIq0hu/o/oO+coyOn1DmFYl2BGcSvhd4U4Wt20QiYb3gkAavinan?=
 =?iso-8859-1?Q?bhU44Hvc7eF+OLKCPWAR9JFt4/twajx8eSkRgWy7eYk155xA+QT3/jfUUY?=
 =?iso-8859-1?Q?ICgLvWXhJH8GhCURd2Sm8BzH4GYXnCKtiwSsXS050k81B5oNyxvGx8q9b9?=
 =?iso-8859-1?Q?aO8IG1W/UNO5iGsFbnpOsA05ScHpRLY9Z92KGvtkQVsBqDQIktcCNKiegX?=
 =?iso-8859-1?Q?3QEdOD0jtpn/HuKv+8+GKiKp4ONSTgTMoMPR8FDKZvjV0W3tLayiJ25l4B?=
 =?iso-8859-1?Q?fD7qy9A7Haph0H4zgOsQYMvsFZNfFSQ73i2KLoqVcrC1XwENbFam1DfiGI?=
 =?iso-8859-1?Q?7CFZmqcJ4amg8NdDH8gtFWXwniCcVPIuhLB4MAFlWkixZyJLBzu2vPj6gD?=
 =?iso-8859-1?Q?AYUL4OTuM6f7APQ1Wpe5lHP6hVqvEVv0Ez0X07pIxHNvJTX3a67WysRUn6?=
 =?iso-8859-1?Q?4AY7OAIF/DZGcogp5mU2nCgbwS7Mgu/M7KMl02M44cmjGDZSUplQ6nO0H7?=
 =?iso-8859-1?Q?/nWYKnK7R0cVXVR/a9oluisxnSj0hwg7mFzByHzRgxLrZSArXLfvJk6951?=
 =?iso-8859-1?Q?XFEjPk35jnciWx1qqCA7Bcdd1nNaNru7ZDmS2oGvA5EELZqZFA4dYiW9KV?=
 =?iso-8859-1?Q?5uEAdhfViQ/41Rah1FiP3h4MSrDLaYR48m66lphAoAWxrNFY4gisQhtojR?=
 =?iso-8859-1?Q?xHWUCFiazdylrYTrnzmpfi287iQIvki2Y+YDis65tuGZppvEbdICbjAgJW?=
 =?iso-8859-1?Q?u2LJmmGl+qHlzqG/0maVj8VYN44Thiq8GDSW7CPRNKojadrSxdmE9cy1r0?=
 =?iso-8859-1?Q?iHeDEXxPhiBpc+Z6N9hexLtPLvFmOlJYg6LGaU8NNzW9yWmLNlOqpS/86P?=
 =?iso-8859-1?Q?lIJ5O16SG0eLeNXET/TXciKoZpcVZnVHFlk/GwlPN9IU7sEptxvoKbQNjY?=
 =?iso-8859-1?Q?Z87nN6s1ze6C+2BJYq3L1FLc4YEVlMJ3VTXHotMH8TTc26jVSbO0bGYG2H?=
 =?iso-8859-1?Q?6slUSVfaMrlr260qP/4saQwFiVKOYa8vIOYvouqqAJWtu+Gln4cMedXf4F?=
 =?iso-8859-1?Q?4WFT0OJq+7J/YooXIZMd1EPkar2GbdMTbqhNl2hAGpEZSZe5rJTG5sIASL?=
 =?iso-8859-1?Q?fUzY1CG97wwa3EV7tTtoxcgwIJrqjVfrudpiVSL0SkkKZ37RwYDj1F6UeX?=
 =?iso-8859-1?Q?Jaik6UkahcFNefrkPUuCTYfr2tM7+a1wQcklj8bPyzCgMGkRFHJSsdu5GY?=
 =?iso-8859-1?Q?L31Fjll9NzuxYk64XjMY14K3d6kX/AQhYMeNeDqJDoocElqtEZMUtditOq?=
 =?iso-8859-1?Q?lEAIiBWQMQE0jXSR6bNTV8GX855w2YNG7VpwQQd86iuVL1uyRUxNc/nboG?=
 =?iso-8859-1?Q?cbv6mnnhZSn+NDkoCI5Ibi3NadO2UYnMkyqVwxYBlp/Qeo3h9yq36BUSeq?=
 =?iso-8859-1?Q?KKRTxYZCU4OL2b0L3cm5OSX/GeOiLsEuCoWQLPh96HNORIFn0dpc1Br10n?=
 =?iso-8859-1?Q?9C0u6AZ+yG//BRDZEQOA1nxItpH9/P1fuyYZ+qIUMLziHf9bbOusbFoxvX?=
 =?iso-8859-1?Q?v0inWmzuGgGwjNQkte2nGqfEIWI71zeazgUgUDDO0InHzbn4ns6J2gGw7l?=
 =?iso-8859-1?Q?l1IQZHC6uTEPwW68ZBa0OcE3gtZwtC1pIbpNxEpSQ8pppNauGbsFJ2SBld?=
 =?iso-8859-1?Q?MVaTvv/vdhhtcqcnwRXDYwzqSJ/uQ0Jv/DF1a1l6f740hD8hvO6X?=
X-Exchange-RoutingPolicyChecked: WKSqbgE/Unx1gBygcQ/Jg4WdRQYjREN27WR1NwWEajMSFm+FwBKsUZDvukVudSeRSW8y1XhMiPMnhelY7QZacrAQQ2X43bZcRZKKaWeExsghyW72OZRfRK/16yQEr59EGaqoT9iE2wVuh6Q4GgGtK0jP8KVsygrPd5IUTVbl+mA1MTZxCX+lkaqpfed/rzudBocdACKps2I2R8HE+NaXOJ+O9A6jpqaR5lUfs35A1lkm3KuRSgrsjsVtJi0RKFo+Q8ReCT8Xh0lujWQAurDWeKFbdiIu8hIZVW3e9SEaddj/3CzVNTkp/8bEGSuU4/y/ZUr8+Cho/9AOywWSCFKBSw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a3457c7e-69ec-4b72-d114-08df2ac90cb0
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:31:50.1198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Kt11WGQMXtt7ENdfRVaqiobDMpO/zZcOUawK28WExosgVAGjxILoeNznTe1fX+17D1S4UzUm7Q/QyY8Mi3qDqc6gxl+hJSco9A5CMldooo/Bp7uMADgjdcGx+adgINi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7107
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

On Wed, Oct 14, 2026 at 09:22:13AM +0200, Thomas Zimmermann wrote:
>Hi
>
>Am 13.10.26 um 20:37 schrieb Matthew Brost:
>>On Tue, Oct 13, 2026 at 09:17:53AM +0200, Thomas Zimmermann wrote:
>>>Hi
>>>
>>>Am 13.10.26 um 03:36 schrieb Matthew Brost:
>>>>On Mon, Oct 12, 2026 at 06:06:15PM -0700, Niranjana Vishwanathapura wrote:
>>>>>drm_gem_is_prime_exported_dma_buf() is a bool predicate that open-codes
>>>>>the core PRIME self-import check. Its only caller, the shmem importer,
>>>>>then repeats the dma_buf->priv lookup and the reference get.
>>>>>
>>>>>Replace it with drm_gem_prime_dma_buf_to_gem(), a thin wrapper around
>>>>>drm_gem_prime_self_import() that returns the backing GEM object -- with
>>>>>a reference taken -- for a core-PRIME self-export, or NULL otherwise.
>>>>>This consolidates self-import handling onto drm_gem_prime_self_import()
>>>>>and lets drm_gem_shmem_prime_import_no_map() reuse the object directly.
>>>>>
>>>>>Unlike the removed predicate, the helper takes a reference on the
>>>>>returned object; the sole caller already wanted the referenced object.
>>>>>
>>>>>Assisted-by: GitHub-Copilot:claude-opus-4.8
>>>>Assisted-by: LLM
>>>>
>>>>I was going to suggest this last rev too as I noticed
>>>>drm_gem_shmem_prime_import_no_map called
>>>>drm_gem_is_prime_exported_dma_buf which should prefer the new helper but
>>>>shmem couldn't look at drm_gem_prime_dmabuf_ops.
>>>>
>>>>This is a good cleanup:
>>>No it's not. Please see my reply to the cover letter.
>>>
>>Ok, I can't say I agree, but I'm not going to die on this hill. Still,
>>here's my two cents.
>>
>>I'm not sure I agree that comparing a vfunc is a hack, but let's assume
>>it is. Is it better to have four drivers plus two cases in DRM core all
>>open-coding this logic, or to consolidate it in a single place so that
>>if we find a better approach later, we have a central point where it can
>>be changed?
>
>The helper leaks the prime implementation to the outside world. That 
>alone is a problem. In practice there's no real guarantee that it 
>works with drivers that do not fully use prime, such as amdgpu.
>
>The importer whats to know if it has exported the dma_buf, but there's 
>no clear unique identifier. So it checks the device pointer stored in 
>priv. Because it cannot know if priv contains a device pointer, it 
>first compares the vtable.  All of that really is a hack. A driver 
>could use different vtables for the exported dma-bufs, or also have 
>multiple memory managers that share the same vtable for exported 
>dma-bufs.  Neither would work with the current workarounds.
>
>What the importer needs a  unique identifier for each dma-buf 
>allocator. That workaround is just the next best thing.
>

Though an explicit driver identifier would be good, I am not sure
if it is warranted here.
I have posted an updated series by moving the helper routine to
drm_gem.h file as a static inline helper with proper documentation
about dma_buf_ops usage as the driver identifier. May be that is
good enough for now and drivers can use it if it makes sense for
them?

>Best regards
>Thomas
>
>
>>
>>To me, the answer is obvious, but again, I'm fine with ignoring this.
>>
>>Matt
>>
>>>Best regards
>>>Thomas
>>>
>>>>Reviewed-by: Matthew Brost <matthew.brost@intel.com>
>>>>
>>>>>Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
>>>>>---
>>>>>   drivers/gpu/drm/drm_gem_shmem_helper.c | 14 ++++++--------
>>>>>   drivers/gpu/drm/drm_prime.c            | 26 +++++++++++++++-----------
>>>>>   include/drm/drm_prime.h                |  4 ++--
>>>>>   3 files changed, 23 insertions(+), 21 deletions(-)
>>>>>
>>>>>diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
>>>>>index d654a22a30de..a0e161f2333e 100644
>>>>>--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
>>>>>+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
>>>>>@@ -954,15 +954,13 @@ struct drm_gem_object *drm_gem_shmem_prime_import_no_map(struct drm_device *dev,
>>>>>   	size_t size;
>>>>>   	int ret;
>>>>>-	if (drm_gem_is_prime_exported_dma_buf(dev, dma_buf)) {
>>>>>-		/*
>>>>>-		 * Importing dmabuf exported from our own gem increases
>>>>>-		 * refcount on gem itself instead of f_count of dmabuf.
>>>>>-		 */
>>>>>-		obj = dma_buf->priv;
>>>>>-		drm_gem_object_get(obj);
>>>>>+	/*
>>>>>+	 * Importing a dmabuf exported from our own gem increases the refcount
>>>>>+	 * on the gem itself instead of the f_count of the dmabuf.
>>>>>+	 */
>>>>>+	obj = drm_gem_prime_dma_buf_to_gem(dev, dma_buf);
>>>>>+	if (obj)
>>>>>   		return obj;
>>>>>-	}
>>>>>   	attach = dma_buf_attach(dma_buf, dev->dev);
>>>>>   	if (IS_ERR(attach))
>>>>>diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
>>>>>index 588910c250b8..275c5661528d 100644
>>>>>--- a/drivers/gpu/drm/drm_prime.c
>>>>>+++ b/drivers/gpu/drm/drm_prime.c
>>>>>@@ -933,23 +933,27 @@ EXPORT_SYMBOL(drm_gem_prime_export);
>>>>>   /**
>>>>>- * drm_gem_is_prime_exported_dma_buf -
>>>>>- * checks if the DMA-BUF was exported from a GEM object belonging to @dev.
>>>>>+ * drm_gem_prime_dma_buf_to_gem - GEM object backing a self-exported PRIME dma-buf
>>>>>    * @dev: drm_device to check against
>>>>>    * @dma_buf: dma-buf object to import
>>>>>    *
>>>>>- * Return: true if the DMA-BUF was exported from a GEM object belonging
>>>>>- * to @dev, false otherwise.
>>>>>+ * If @dma_buf is a PRIME export of a GEM object that belongs to @dev and uses
>>>>>+ * the core PRIME dma-buf ops, return that GEM object with an extra reference
>>>>>+ * taken, so a self-import reuses the GEM object instead of referencing the
>>>>>+ * dma-buf file. Returns NULL for a foreign dma-buf or one using driver-private
>>>>>+ * ops; such drivers call drm_gem_prime_self_import() with their own ops.
>>>>>+ *
>>>>>+ * The returned object carries a reference the caller must drop with
>>>>>+ * drm_gem_object_put().
>>>>>+ *
>>>>>+ * Return: the referenced GEM object on self-import, or NULL otherwise.
>>>>>    */
>>>>>-
>>>>>-bool drm_gem_is_prime_exported_dma_buf(struct drm_device *dev,
>>>>>-				       struct dma_buf *dma_buf)
>>>>>+struct drm_gem_object *drm_gem_prime_dma_buf_to_gem(struct drm_device *dev,
>>>>>+						    struct dma_buf *dma_buf)
>>>>>   {
>>>>>-	struct drm_gem_object *obj = dma_buf->priv;
>>>>>-
>>>>>-	return (dma_buf->ops == &drm_gem_prime_dmabuf_ops) && (obj->dev == dev);
>>>>>+	return drm_gem_prime_self_import(dev, dma_buf, &drm_gem_prime_dmabuf_ops);
>>>>>   }
>>>>>-EXPORT_SYMBOL(drm_gem_is_prime_exported_dma_buf);
>>>>>+EXPORT_SYMBOL(drm_gem_prime_dma_buf_to_gem);
>>>>>   /**
>>>>>    * drm_gem_prime_import_dev - core implementation of the import callback
>>>>>diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
>>>>>index d378404f8ab4..02665205aed1 100644
>>>>>--- a/include/drm/drm_prime.h
>>>>>+++ b/include/drm/drm_prime.h
>>>>>@@ -101,8 +101,8 @@ struct dma_buf *drm_gem_prime_export(struct drm_gem_object *obj,
>>>>>   unsigned long drm_prime_get_contiguous_size(struct sg_table *sgt);
>>>>>   /* helper functions for importing */
>>>>>-bool drm_gem_is_prime_exported_dma_buf(struct drm_device *dev,
>>>>>-				       struct dma_buf *dma_buf);
>>>>>+struct drm_gem_object *drm_gem_prime_dma_buf_to_gem(struct drm_device *dev,
>>>>>+						    struct dma_buf *dma_buf);
>>>>>   struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
>>>>>   						struct dma_buf *dma_buf,
>>>>>-- 
>>>>>2.43.0
>>>>>
>>>-- 
>>>--
>>>Thomas Zimmermann
>>>Graphics Driver Developer
>>>SUSE Software Solutions Germany GmbH
>>>Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>>>GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)
>>>
>>>
>
>-- 
>--
>Thomas Zimmermann
>Graphics Driver Developer
>SUSE Software Solutions Germany GmbH
>Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)
>
>
