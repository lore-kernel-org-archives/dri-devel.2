Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7B9CC6B1A
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:29:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0D8610E95B;
	Tue, 13 Oct 2026 18:29:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 714DB10E21B;
 Tue, 13 Oct 2026 18:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791916180; x=1823452180;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=RimMsQgqwilvJm5SIbMgpCAqzh1/+Ze3uMrNBfQiPJ0=;
 b=jHqoI03dn6q5swecADiWmj26jLrpWAqkiMN3VycMncJoX/dzZi0HJ43G
 7L6Ic9ApvYEmqhKHsmLSPDGKBPha/4GvrjArrForn6YUG/JkcgASfYvnn
 W0OHpQ5JiXI26WysAfPE3K5T8x+r+ELVhgK5iVLVEYBAWte/pocbvCX3A
 7W4ARqlG+9KVLLJPrinbewUMBog4sQNiblH2CIwuMb7/n8/htQXq2gRYA
 4wPmwlO7vzCnMAC79+q/4CHvy7EXuicTdEXE0x/J4bqU4adBEc9KnuTfc
 6QbYXVMup+aADC/Rr/vP4kGZDOwuPRtjTOzmQjV11V98+h520dS+LvIgK Q==;
X-CSE-ConnectionGUID: 9mYzYKYORuGx0o9ruh09mg==
X-CSE-MsgGUID: yh+OYgexROuSZvR9+O929w==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="754974"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="754974"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 11:29:40 -0700
X-CSE-ConnectionGUID: TPLFsfuhSAyrYX1RPBphdA==
X-CSE-MsgGUID: 9iGu6Zv4RFOPN+PytxrG7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1233367"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 11:29:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 11:29:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 11:29:39 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.13) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 11:29:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyjJAzQrmFtZ9Dbkyt0F1m37+XUpSD1Cf4lHMYkAjLsmz9tH5DT4//1WsWP6EJNcZzDW/gMMfRJHY7N7kmWQI7V6RBUvpINE2PRyvhcu1K6P9gnJUcHDmDC0QTU52oZIk4H4CyJm0WU2kjNHARp/BInQdM551UweOCDDWpr2xqC+EkEOFO3O7F7XNpyRJ4gf+fLJR8roqZrQsJ7LTQBIp2EkT3k0oibyS7QcRs5hF8K0n8r4KI/xel0r6dl+eDL2SFKB7G7NimcXDe3NFDYcgDVp3iLUlMMj6EXiM5peIbxej7WOixmr7Ers8BwmBV9DIBcg/iKm8a63Gh+hFoezNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohyMlDAW7+yxiZDHr2k1AguxAKdZFwDejgH3gPpjycU=;
 b=OBlOZFFItRGR8h4v2OcZAAa5oK6CXlixCj6wMcGK+LpXmrxt8kFgrwE/YyTeEhYI0UBYA02lVKJIU6WgDJU5wtfbIgszusuyUjjg7ExuWzsQpLhBu5QmqTQ9OgcVoSS9PAuBoeF/+GctMgHeSiFfEKlcasvweMjWE22FWlTZfqq8Jd88YJ8//Nn0BECzNzRIv+JY7e79T4L2H6HfPcf6cDdQnMe6jIm//LaZodyCfBz5eMlWWg5WkElo4Cc2AH1yTBbJ9a9aQZ6/1vkX1+IX+uG5yPSMRiEJd42bPpekV4mZ4t+vV0f3E5DuOzQKS7ECAQYLE4uAMBADvQRQImdIrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by SA1PR11MB6870.namprd11.prod.outlook.com (2603:10b6:806:2b4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Tue, 13 Oct
 2026 18:29:30 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 18:29:30 +0000
Date: Tue, 13 Oct 2026 11:29:28 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <matthew.brost@intel.com>
Subject: Re: [PATCH v2 0/6] drm: consolidate self-imported PRIME dma-buf
 detection
Message-ID: <as54iEp-iqR0ZJWs@nvishwa1-desk>
References: <20261013010614.1516799-8-niranjana.vishwanathapura@intel.com>
 <d93fe93e-628c-4551-9907-9872c150e530@suse.de>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d93fe93e-628c-4551-9907-9872c150e530@suse.de>
X-ClientProxiedBy: SJ0PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::23) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|SA1PR11MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: fa39021e-6c42-4834-2fe6-08df2957eb78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|4143699003|11063799006|56012099006|22082099003|18002099003|6133799003|261009221227099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: G1inpkF/J1vQ7Y2dc3lPqMlRforHnxN8uyTm2v92zRTacUHdi5/BAYqHxAf6PtPM9nPFoJM01HyuhgeftzvG5IIB5l1ywGetuXebsPmNwPtsVYaxXdkTXUt6d82WAer4q6vDrpuj3j7jI+ORqvj3ZjKyRrtGlYQaSWoGQ/EH8RdymPDZlrgds7PZnLhwM4+E8zWP6qYneMgl3Dcq/1JMX7mz9M8cgEr1nq28/XycP7eCHekUnektp5TRWAQ2FBlM568A/3hg3Y9MJpNoc3Hxd6AhTg92eHKIolLRCYKsVo9hT79fXZbm4gphDxxWNQ6cB971XwKNrKemOgeyo7aC3Gpz+rObDGusRVJBsl7og7EMAdfHMw1fL3HihEEPzipquSlXD9Q9FpzNXSUS9JUP5UKdePJ01CzYe8snDnScFZyV2oz/2Dugv+078nYP/j8+SBCWofG52WWQKD7SE4gKpkTMDLg5+8av1pIN+pSkQpLTZGHkPjBx9nHfxfLQ1iqhA7+CIkG15Tsf0ctN5NcQIGTZ2VjlrU3gsd95z8CRxH56WOh2AW/RMOnfZlvnWGjgJqd0CEhFzkW91GD5bTu9uoB7Z3LxBU2lkRjLoNsgtgQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003)(261009221227099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?yve9XNOmlMejM+py2SFSuCw3ibEfyWciY2HlVZofZP4723K7wwDJwbEuwl?=
 =?iso-8859-1?Q?zFA0HQmyEnfpX24ov1//IinxNNgEjxnq7Gsnn171/17XfPSEG56HmdbF6U?=
 =?iso-8859-1?Q?+hvYYXKPka6GxE0Pbn3S5+v400wUhGecY07jfnkptF7dHxhLPmBmg6yeC+?=
 =?iso-8859-1?Q?1vcRs41MVCMo6NGVTdAXUJCNxL9tXbm2nnr+GYsW1bqnAtcP29Jb6KRKVB?=
 =?iso-8859-1?Q?R/UfZQkQ0Nlime7TkpzVGPdmVRD3iMcHyNf6c3ULdpReTFXou0p7fArSFq?=
 =?iso-8859-1?Q?amdKfkjDtOBW0I4ZI/XjKRBaj9jBgUlqWIz81Dvf3s4z9wOgxXyIwaJBzN?=
 =?iso-8859-1?Q?I+l+olkVZuipAy6y7GeMcgRlu9b1AmNxM23RkxX3xTS1MAfFg/AIWT9dKw?=
 =?iso-8859-1?Q?JalZHBC9svvF+CU4Hh3Bq2BX0KAzMvhPWjRxOdP/lzSpjzyunlO/d4ioyj?=
 =?iso-8859-1?Q?Q+OfSYPPwn/HkPEb1pJJJqQGxzYv98/F/MtmH63z4xv3s1NN9MF1BYVEOV?=
 =?iso-8859-1?Q?V/B5uV3mr12m28je0Ek/CirW1KenVAlXKdtAOV7yjqMcmlzcW8J9oHrFAs?=
 =?iso-8859-1?Q?YKduRuzFmgC+0EU2/GVovEDjSQlWgrl752YMCkBTAYDCH1fHCG12a42za4?=
 =?iso-8859-1?Q?1NcK9hfbIU9modGgzOLX/f6ORsY8mZT15Y1I4ZqYOEch1rbwVFV1GzQIJ8?=
 =?iso-8859-1?Q?SnFheOv1nWkRNdhiTyNg8JfVxKLp5QES8BHz6h9DkaGAFvabscssfC62X/?=
 =?iso-8859-1?Q?xPHFDrv9W259QNubt6CFM7PhcC7NWqDaJyuGHXoBSm0k5jJKcylQTO57x8?=
 =?iso-8859-1?Q?XBQYuRmzbD1ZODB1R+d7Y9XiPm5RmcRoNtZoKs8Sq27t3KWkfq9H46uceT?=
 =?iso-8859-1?Q?w51B4Qu1oQA7VaJ+W80IQlEg3V9ddoPc2HGpwsEW8BWat0P6sCZazsUR92?=
 =?iso-8859-1?Q?cqu3OihadYld1MZn1O7R0xcaiNt9u/+2FCjlaNkAecn4eVgPqT5y1YeLK7?=
 =?iso-8859-1?Q?pyJXdrlFnFr7UeL59Tj9K7CzbqFg3HpX9SoVjncDxGXgYSlgi5qfLYg8DM?=
 =?iso-8859-1?Q?KcMnbHgTXh/jMv03zUlSfvBOVMVd4FI9fe3HwdRJMTIJ3S67FfJFVlU8Ja?=
 =?iso-8859-1?Q?zIqFyj170+KumcAwHeEqGHYGPu7P+iFjtzNAaegRsBN/aR31McYTsfqKIy?=
 =?iso-8859-1?Q?pBsYt0vQkXoOCCUY2A5xpYr5fV2eWcxNc0iUYTKez9XttvEun4G8y8x01O?=
 =?iso-8859-1?Q?djgUr1mY3x/in5HUIKEYwK81cCd16fkXdVs71stxdFzX0I+2PT3U2EIPJm?=
 =?iso-8859-1?Q?o7wKjdWKDMoNnHspbyqIbWVRanVURzrvDq8Uhk4aDtfHCUIs1GgrdKjS9Q?=
 =?iso-8859-1?Q?CLi317/A/oI+2tJ3zYj8KtPb0ua77gRE6DoD3SuUhQm573uUXQCVIlpH8B?=
 =?iso-8859-1?Q?mqM0DSkit+05wYPF+JjVea+CAd5Olyu6z0gQvU+YNJj1/2hjWgC053IsXh?=
 =?iso-8859-1?Q?8lqCgUERVgyck5MTwIn9WNxIQnrv8m8ZQ7jgnc/nrrO3Z3csK32143c/Yq?=
 =?iso-8859-1?Q?DJ0aUvV7ZLQ9hstm9WwtxIBvjGvDxf3nGzsn++PVSjDmpZ6zlbP+FNf4XV?=
 =?iso-8859-1?Q?35aNSFHiFYxwwGvoesAoCLsstEqJuZA2oHtt5EBsF6aSsmEQlPKAWR3zSN?=
 =?iso-8859-1?Q?PSD7ud6YGQLh5dfSljT/TojGxpaQkAlGaewyQtN3+zmHus04FookNnaYlt?=
 =?iso-8859-1?Q?vUloxWWaPeXUkwi/LR9MLb+gZecHKt8jvZVu/T3ObDhLpIBM6M9NdHf4VE?=
 =?iso-8859-1?Q?aVPWAPseNt5N3nGEXiiXKK2Wch7rj77TqtNvaBOXO7DLXNTgjx4r?=
X-Exchange-RoutingPolicyChecked: gBt73z8UYhdC162D8R454YpsyG85A7NziGaSHZdOYYivSrmNZLhbVz70LBy/mYG3AB0ivVb+NUYMZBjj+bATToDMovLvIWMEiN4q86omV624hecNbMbojTuGf1bvjFIWeiL4FNv33VvE6IhIYHOYpZGjC7OZAuOywS5KxGhHr3YpLhsdBMZbJGfAKhfyDT19nK9cKGzPbTGSR8EE5iXE3nRwNV+Y8RlCad2MPJdpsCj0lFT6RHkqFQdhlQVlGvhWJsShMfudh3KZTA56TeMNuFl/qqwqDWHZGB8ViAr1rFSd9yJQo5l9RLYfI1UOr8EtH0TUEw8EADD6Q4iUbqRMqw==
X-MS-Exchange-CrossTenant-Network-Message-Id: fa39021e-6c42-4834-2fe6-08df2957eb78
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 18:29:30.0575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4tSFgdGtgY9mHPvAd2z8uvO52fi83H44r1wgN2ijLdCBTRNRWZ56e2ttquxO6v/faYUNzaMQOVd7XUqUSyZBcLk8Ta5hOhrOdcag5kDiSy3xe6YNN13qax33nTrhWew0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6870
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

On Tue, Oct 13, 2026 at 09:17:17AM +0200, Thomas Zimmermann wrote:
>Hi,
>
>I don't think we should merge this series.
>
>Testing for the functions struct is a hack, which we do because it 
>works in practice. We don't any other good identifier for the source 
>of the imported dma_buf. We want to hide this from the outside world 
>as much as possible. Putting it into an exported interface goes in the 
>wrong direction.
>

Ok, I understand. Given it is just a utility function that is helpful
across drivers, would defining drm_gem_prime_self_import() as a static
inline helper in drm_prime.h is permissible?

Niranjana

>Best regards
>Thomas
>
>
>Am 13.10.26 um 03:06 schrieb Niranjana Vishwanathapura:
>>Detecting that a PRIME dma-buf being imported was exported by the same
>>DRM device is a pattern currently open-coded in many drivers (compare
>>dma_buf->ops against the driver's own ops, check obj->dev == dev, then
>>return the GEM object with an extra reference). This series adds generic
>>helpers for it and converts several drivers to use them.
>>
>>Patch 1 adds drm_gem_prime_self_import(dev, dma_buf, ops): for a dma-buf
>>self-exported via the given ops, it returns the backing GEM object with
>>a reference, letting a driver short-circuit the generic PRIME import and
>>skip the extra dma-buf file reference. Patch 2 converts Xe to it.
>>
>>Patch 3 adds drm_gem_prime_dma_buf_to_gem(), a thin wrapper that uses the
>>core PRIME ops, and replaces the drm_gem_is_prime_exported_dma_buf() bool
>>predicate with it so the shmem importer resolves the object directly
>>(the sole caller already wanted the referenced object).
>>
>>Patches 4-6 convert panthor, panfrost and amdgpu to
>>drm_gem_prime_self_import(), removing the duplicated open-coded checks.
>>
>>No intended functional change.
>>
>>Assisted-by: GitHub-Copilot:claude-opus-4.8
>>Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
>>
>>Farah Kassabri (2):
>>   drm/gem: add helper to detect self-imported PRIME dma-bufs
>>   drm/xe/dma-buf: Use drm helper to detect dma-buf self-import
>>
>>Niranjana Vishwanathapura (4):
>>   drm/gem: add drm_gem_prime_dma_buf_to_gem() self-import helper
>>   drm/panthor: use drm_gem_prime_self_import() helper
>>   drm/panfrost: use drm_gem_prime_self_import() helper
>>   drm/amdgpu: use drm_gem_prime_self_import() helper
>>
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 14 +---
>>  drivers/gpu/drm/drm_gem_shmem_helper.c      | 14 ++--
>>  drivers/gpu/drm/drm_prime.c                 | 74 +++++++++++++++------
>>  drivers/gpu/drm/panfrost/panfrost_gem.c     | 10 +--
>>  drivers/gpu/drm/panthor/panthor_gem.c       | 10 +--
>>  drivers/gpu/drm/xe/xe_dma_buf.c             | 23 ++++---
>>  drivers/gpu/drm/xe/xe_dma_buf.h             |  2 +
>>  include/drm/drm_prime.h                     |  8 ++-
>>  8 files changed, 91 insertions(+), 64 deletions(-)
>>
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
