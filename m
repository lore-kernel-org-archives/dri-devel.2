Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD09CD8C90
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 04:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E6DE10E6EA;
	Wed, 10 Jun 2026 04:07:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SI2xDOTv";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25D1910E437;
 Wed, 10 Jun 2026 04:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781064459; x=1812600459;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=7auf42aFKmgiLA56BpOZfJnXt3JfJgwjtvnr8zXYH5k=;
 b=SI2xDOTvifo66P7Nk/NXOlCRd8Iz/rEXwsxdQjnWudOC3Qd5hhig9aMn
 n4H0qc9deG2hP+eUX/90he/6niNbdKtDnY079s0JJYj1rFF17hoPH5ykv
 oAONhXjBYLtOpUKr79rgRIm8hPbLGbnoMO1JsSYD/v2i5EkOXY3YWqEVj
 JuE8g+gIhmRTd2trd1J8H0kPbOUjD8YapomMVcpywcLPfbtnyY/SJYDsW
 THlVFHwTfzCcy9V/J8u63QWGSq5N9tJPQ6dEI6UsY5JPM88ptewjiasco
 jFy0VAzc7Jnc1QgnU0q8N/YlwQcNuCRffKhwpn20vY8pIdjAwSQT77ttr w==;
X-CSE-ConnectionGUID: +pPK7Jt7TeyU21tuEKZqmQ==
X-CSE-MsgGUID: UNmWdFHnTySt3kRUfZzoBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81913731"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="81913731"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 21:07:38 -0700
X-CSE-ConnectionGUID: gDgC22/OTyik5elUI+LBCg==
X-CSE-MsgGUID: b7kaO2+FQX6GXtjpeuWGMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="239712052"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 21:07:36 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 21:07:35 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 21:07:35 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.12) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 21:07:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzvcLiJp/TrWJH50ge0KD/cSqQ0smgCjezr3EUxO5EdDQ/yb62IPPzRv/qUGAHDfAoChboZpyRvqWaOsTK1qSbRo3GZUujSlcEw7zrUIWPyr244/ESwx0F0DtaiGP2qIcrWP/x5wBRQdB+x7xaYEweMGIdBR7seR0QD6q1GqwWx6SEU6RAJKsA8Xwii6e5yRh160kZaxymj4luP4mkGGigejP2DoGCzR7LAlLIbVtEExdOU+MMY4ETh2xjrSpe3Y6IA5BNk2h35whXAMafQn48dJtHOGfH5+Cpjsh3OxodvOYq+OpM8Nr4EpNz1PPkI0AC9xvdSwPnfQh2oDCT/ukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsWg8FDdaq3mBPy6bGVTdMgbtYrE69/3OWqDiHxJ/GU=;
 b=RNWZtz0GgIE7nkk47UGYjYLhnBv3DSToigy3UwYNM5CrFBkZJTa4fMt++uyObY49LR9yKpujRCskDKy5EVZtgYxc2dSUIjL7CZHq28CMUfw1woavfSgc/sRj2I2uOUMMqIQm8XpJuV50ZQljQ/uds0BA3GB+CDkqpSch1QO1Zak6iAgQm2U7NHW9zbSoccbE9mRkSpLrxIlZ1M2yon8aBwK/9HE2qGFp7wLqASdmpD7MxiwyOAETU/468g0pymF5Gc5rLjeksu1tc4/YqeEEtSaQ3D6eC1NWiSBtUkN6t/2G3YL+6RshTjPwRlz15sBzEXisPMb44viZjBLED3uXXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH7PR11MB5768.namprd11.prod.outlook.com (2603:10b6:510:131::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Wed, 10 Jun 2026
 04:07:27 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 04:07:27 +0000
Date: Tue, 9 Jun 2026 21:07:24 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Honglei Huang <honglei1.huang@amd.com>
CC: <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>,
 <Jenny-Jing.Liu@amd.com>, <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>,
 <Ray.Huang@amd.com>, <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>,
 <Yiru.Ma@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: Re: [RFC 2/5] drm/gpusvm: embed struct drm_device into
 drm_gpusvm_pages
Message-ID: <aiji/CVY4WqFA3XS@gsse-cloud1.jf.intel.com>
References: <20260603065620.2555316-1-honglei1.huang@amd.com>
 <20260603065620.2555316-3-honglei1.huang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260603065620.2555316-3-honglei1.huang@amd.com>
X-ClientProxiedBy: MW3PR06CA0012.namprd06.prod.outlook.com
 (2603:10b6:303:2a::17) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH7PR11MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c1a082-4e8d-46d5-9470-08dec6a5c8e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|18002099003|22082099003|11063799006|4143699003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: 9VqwHHH9p91wKYoI91KtSEqTzunEaZRrGugdiuieq1RHAxAh4GezHgSJXCwHRiaYygo1tXaeuqc9xE441ef/qQtqnE8g6Sj0sxUpMfUQRQmyN2fqVcMRykQPnJSp3On+baMcDCVfrrM1ee6ihGTYkizyOzASsZtHXhQdTv9vW0sA/7J7DS67sTwPWhNtsGrjI71yKkV0XQVanTQqGuMngD/3DLLd21IWXG76piGbLigieyIRegIBLi8pi+TuzK/caRMeMrsqxKXuGP5jyveuzd03IhNhPOhpud8idOLQVHk8IX1UftZYMZen5C3rvJO+yRYqhrsMsETdAAK8Y6xAYR10ATQkBr1tueC5j8YfzPCgXywb/myC7AXzs9JR6qCkLb75frZqYSsVEzYAVk2C+wiLSE4XejUAn82QprSc+FojvaMxj2tiDPwwKbnbWiKW3AKDNCQA8RlG5WE5F7Y+tuW8rdEJgYnQv8SPmDLsKI4bsjT+pEsDOaaj3Hlpq48hXemVqUAlq+fDdCznyNqNb4N6m4A+O4OpFejQEgxo5he5bMXydX3OccCgY8GTQ5vkowGByY9UbGm9LageedLKDl3heND7KzdJRK6O4kDnmkkyIHdig4seC/jiVrqvWb7hn0k45lPE8nc0YMqUd9cG0zvWddapU6IzgjhKkyUrEJJqtUbqyqPlRTIdUZVspPQ1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm1OMEZwTjdhVUpxWW5aS1BiTGRQNlNhNlFzNlZ1VDdJYVBka2lxZUVkS0pM?=
 =?utf-8?B?b1R1TjMzZFgyUTU5R0FyeVpZUXFhQTBaT1VZNkhPbExXV2JINFJqV0hkeDBh?=
 =?utf-8?B?cmtSRmwvejRLWmx3ZERQTTVicTBrdFgyM0pSekVCQloraGtLRkhqL1Z6UDZB?=
 =?utf-8?B?Nml0UUdYd25IU0lDTUhTMVRoZSs3ZVdZKzJ6WHRIZFdyME5MUFdXRmZJU3V1?=
 =?utf-8?B?VGtDdm5IRnhvcjNlTisvTkpuTkU3Ukp1ZDVsTGVUNElJUkphQ2Fjc2RuOTJB?=
 =?utf-8?B?QWdPeHNxWklLM01RTEkvcEZxdFplbHdUZ0NRR2hIeWlOamFyZEtEMkYwd2Z3?=
 =?utf-8?B?TENxR3MvMlkwRWQ4S0pRU1hmNEVHdkZaZWxkTlR4NFFRSWNGZ1E3Rk5DREJJ?=
 =?utf-8?B?SkFodzFaeG9SVmdqVFFObmxjWDg5aVAzWlluSGhUa3AxRHBLL05xSUJXc0hj?=
 =?utf-8?B?OWNXYWdPTkozWVdFS2xEM1RzenZyYU9oK3Yva0g2MTQwWktSTnNIb2xTQzVt?=
 =?utf-8?B?VU84akdwSTVDMlNYeVp0ZHlUelczSGFGVWJiYUdsenhsbGppNXFoTE9pWUw2?=
 =?utf-8?B?SnUxYWliUUJTWW5FaFJmVVlTeDhPWXE5ajRZTjlKOCtna28vdlpvdjFVYU9n?=
 =?utf-8?B?VFY4SDRhZ2xrN0s1b1duRUNMQ0p5MFN1SmhNdjFGdlUzNUxjZ0hoZWMwV0la?=
 =?utf-8?B?WE9pOEpQTkgxMkNXQjRUUVJKRDhLTWc4L3lUZFdJLzRjUFBQZTZhN2xoNVJq?=
 =?utf-8?B?MjJmQlVxZ3U2dnJtT3FYZXRQc1ZlUlQ2RUlaVmd0MCtIRkdPNTg1bW9uNUpW?=
 =?utf-8?B?TjMvc0JWeWRia200L00zZGxFdWQwTHRPWFFBdzNsaklQUVN3MVYyK3NhVklT?=
 =?utf-8?B?OG45RzBUd1RkSnUzRzBNdTFBc1NIVVY0a0RFc3ZqTVRSdFR1ZVNFUmlHaWxv?=
 =?utf-8?B?WGhUMVBoOXc1cFBIQmRVWkxWYzNUR0owNVlUbjYxQ0JsOVhSMWtuUGJlSjVO?=
 =?utf-8?B?R1NhV2RjNW5jdkpqb2V2dUhSeFl3VkZCT24vbXkwMmd1OFdyTmdKaXkxVFhw?=
 =?utf-8?B?c2VMSmgzQ1MyYkYzVjllZnc5RlRIRUVhTEN2Q3VpdHJIWnlSU0FKVE9hVU9s?=
 =?utf-8?B?NzFoZitVSzFkVEkwSHl1c2NWTGpnQW53MnFONlJKTTdXNnRWRkFWd3dvTkNP?=
 =?utf-8?B?MzNpcThhQ01hVkpFbmxxd3ZkdXpncy9RVE5jN0J2Mzg1TWJwR2hvdUl0Q2dW?=
 =?utf-8?B?bnlBcVlpN21QWlhuRDlJM0YrZzdxN0dqZUpyYTRDTWlmVmttUUZwek5rOWJJ?=
 =?utf-8?B?R0s0endFQ3JOaStkUUNEd1BWRDU5TElTWFZhUHZvNXhwR0gvRVpWbmI4SG5Q?=
 =?utf-8?B?WlFObjlQYTgxMTFNYnp1L0VsUHNqV1BtQzBSV0ZUbk55ZmFXSUVObEkvMnlC?=
 =?utf-8?B?bW9kemdpRmE2MlQvZWg0L3oyUGdiZGZKcnMxRUxaNFNmbitUaXk1UkNVWEIw?=
 =?utf-8?B?WUdCQzJLU2cwQmd5b2FIZ3BvOHVYRWVaYVJkMXRSTzhiMktYTkpHWVpEY0xy?=
 =?utf-8?B?clBDUlR6eEczRGplZmJQMGJ3emRUenkyWHBiQVYyaTBIMy9yTFIrVFl0Wk5D?=
 =?utf-8?B?cmlIZXVsallYUWRuRmRQNTJxTVlsTTlWU0dCMVlCcmhGV0E3RlNFcGNMWk5X?=
 =?utf-8?B?emJHWGNienpBMGlRelIzV0xYTUpGUmg3WERMQ2N4ME9DOXpCUTh1M05pZzhX?=
 =?utf-8?B?ZjBaNnFxWDE4SU5UYjhYMGg0STdXMW4wSmJ5SGhYdG51OVExUkdNOUdodFMz?=
 =?utf-8?B?L2MvR25pWFByY0hrSUJrWXVhcVlxQjUrbDdFemFMYXErZHVTNjdhSXJZdmtp?=
 =?utf-8?B?KzRYVmQrT0MwcmJNRjZiTms5U3FTMjV5aHVEWXBxcTV2OFdnWkhtNUhRcmM0?=
 =?utf-8?B?SmhFb1pBS01zQkx3WEFrbzVsN01rSVpZTWhRZXpDVFBqMXdZMXVFbXdxZTZY?=
 =?utf-8?B?SDNJbHUxdWNqd3B2cmNOOU90ZFFtTU5jUG54QiswTlRIME05aEUwd2hzaVgr?=
 =?utf-8?B?bjlwb1ErWnVoVG9vTWpZMWlpOE5BOXh6ZWFWU1J4bUk0MXZYb0hwVXVaR2M4?=
 =?utf-8?B?VS9qNHB6NVhBQzVieXJyVnZyQjdyc09wQ2pXUGtFdlZDa2RUajl3amRTMGNO?=
 =?utf-8?B?QWQxS1lucURRVTJqTnExK1pPT1RPWFZ2dFB3V3dRWnY3SHBZM3ZwSEJPSjg3?=
 =?utf-8?B?T1lOeXdXMDZBakxBc0xvK3hEV2hRNkZMQ3RGR0VIUlZjRkl1OHVYc1pkNUZl?=
 =?utf-8?B?bTVHOXNwazlyczVQZlkzQU5ISWlCSTUrcUdTZ3RobmdCZjZ2blRzQT09?=
X-Exchange-RoutingPolicyChecked: g8R5YfAS/Q75zYp7wjLFi9xZti7AmFikvRzuy8xDDVkG90x6OXZVlaEuvUwNNpsIIMARwnwuNputhc4BeNSGHeeNti5hbbTH/73Grk4CREfC2p3g0mJ5x44yoqG2SXVIqfWxsFrC5st1lRmQJXB2K4nYPEzeMNmkcAvE30aehvGkXf59tDQ1smX/HwlsxqT+9aCFwPm2rDnjbaYSx/uM77+ElkWbxBOZiZUrbVCqlQVhLJgpS4ft8JGaoD2ZEmHqDe/10tRFAJKMId5Bl4aH6dlo0PSppSPlWF9omUI4fOqAfC2wFWee7yUYFAYx5IKabWQy4YC4x6j5DbTbK4R1PA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c1a082-4e8d-46d5-9470-08dec6a5c8e8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 04:07:27.7266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfWTKCpuIysLBdPqR6pWtt539DVER20YvYaFBKaMVdquhxxhf22i+YCUln+uug0J9uS1qw26oiAxCLdpV6a8lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5768
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

On Wed, Jun 03, 2026 at 02:56:17PM +0800, Honglei Huang wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> drm_gpusvm_pages is the layer that actually represents physical
> pages/mappings it owns the dma_addr array, the dma_iova_state...
> With the previous patch, so drm_gpusvm_pages is now strictly about
> physical pages and their DMA view.
> 
> Since now the drm_gpusvm_pages instance is inherently bound to one
> specific drm_device, make that ownership explicit by giving
> drm_gpusvm_pages its own drm_device handle, and drive all DMA through
> it instead of through the gpusvm:
> 
>   - Add drm to struct drm_gpusvm_pages and a matching drm parameter
>     to drm_gpusvm_get_pages(); the dma device is bound on first use
>     and immutable for the lifetime of the pages instance.
>   - Route all DMA in drm_gpusvm_get_pages() / __drm_gpusvm_unmap_pages()
>     through svm_pages->drm instead of gpusvm->drm.
>   - Update existing callers (drm_gpusvm_range_get_pages, xe userptr)
> 
> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/drm_gpusvm.c    | 37 ++++++++++++++++++++++++---------
>  drivers/gpu/drm/xe/xe_userptr.c |  1 +
>  include/drm/drm_gpusvm.h        |  3 +++
>  3 files changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 6000d587cf2..3f076178b2a 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -1135,11 +1135,16 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
>  				     unsigned long npages)
>  {
>  	struct drm_pagemap *dpagemap = svm_pages->dpagemap;
> -	struct device *dev = gpusvm->drm->dev;
> +	struct device *dev;
>  	unsigned long i, j;
>  
>  	lockdep_assert_held(&gpusvm->notifier_lock);
>  
> +	if (WARN_ON_ONCE(!svm_pages->drm))

I think it is valid to reach this point without calling get_pages() and
assigning ->drm, so I don’t believe a WARN_ON is required. One example
would be creating a range, attempting to migrate it, and then failing
because the user performs a munmap() on part of the range, resulting in
the range being freed. It’s a weird race, but it’s possible, and I’m
fairly certain Xe SVM tests exercise scenarios like this.

So I would drop the WARN_ON, add a comment like “get_pages() never
called,” and bail out silently. Alternatively, if drm is NULL and
has_dma_mapping is set, then a WARN_ON might make sense, as that should
not be possible.

> +		return;
> +
> +	dev = svm_pages->drm->dev;
> +
>  	if (svm_pages->flags.has_dma_mapping) {
>  		struct drm_gpusvm_pages_flags flags = {
>  			.__flags = svm_pages->flags.__flags,
> @@ -1379,6 +1384,7 @@ static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
>   * drm_gpusvm_get_pages() - Get pages and populate GPU SVM pages struct
>   * @gpusvm: Pointer to the GPU SVM structure
>   * @svm_pages: The SVM pages to populate. This will contain the dma-addresses
> + * @drm: The DRM device that will own the DMA mappings. Stored into @svm_pages
>   * @mm: The mm corresponding to the CPU range
>   * @notifier: The corresponding notifier for the given CPU range
>   * @pages_start: Start CPU address for the pages
> @@ -1392,6 +1398,7 @@ static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
>   */
>  int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  			 struct drm_gpusvm_pages *svm_pages,
> +			 struct drm_device *drm,

You could also move drm into a function like drm_gpusvm_init_pages() (as
mentioned in the cover letter). I don’t have a strong preference, but if
we want a helper that calls hmm_range_fault() once and accepts an array
of drm_gpusvm_pages to DMA-map, that might make sense.

>  			 struct mm_struct *mm,
>  			 struct mmu_interval_notifier *notifier,
>  			 unsigned long pages_start, unsigned long pages_end,
> @@ -1421,6 +1428,15 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  							   DMA_BIDIRECTIONAL;
>  	struct dma_iova_state *state = &svm_pages->state;
>  
> +	if (!drm)
> +		return -EINVAL;
> +	if (svm_pages->drm) {
> +		if (svm_pages->drm != drm)
> +			return -EINVAL;
> +	} else {
> +		svm_pages->drm = drm;
> +	}

Style nit: If we keep this I'd write this like:

if (!drm || (svm_pages->drm && svm_pages->drm != drm))
	return -EINVAL;

svm_pages->drm = drm;

Matt

> +
>  retry:
>  	if (time_after(jiffies, timeout))
>  		return -EBUSY;
> @@ -1515,7 +1531,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  
>  				pagemap = page_pgmap(page);
>  				dpagemap = drm_pagemap_page_to_dpagemap(page);
> -				if (drm_WARN_ON(gpusvm->drm, !dpagemap)) {
> +				if (drm_WARN_ON(drm, !dpagemap)) {
>  					/*
>  					 * Raced. This is not supposed to happen
>  					 * since hmm_range_fault() should've migrated
> @@ -1527,10 +1543,10 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  			}
>  			svm_pages->dma_addr[j] =
>  				dpagemap->ops->device_map(dpagemap,
> -							  gpusvm->drm->dev,
> +							  drm->dev,
>  							  page, order,
>  							  dma_dir);
> -			if (dma_mapping_error(gpusvm->drm->dev,
> +			if (dma_mapping_error(drm->dev,
>  					      svm_pages->dma_addr[j].addr)) {
>  				err = -EFAULT;
>  				goto err_unmap;
> @@ -1550,11 +1566,11 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  			}
>  
>  			if (!i)
> -				dma_iova_try_alloc(gpusvm->drm->dev, state,
> +				dma_iova_try_alloc(drm->dev, state,
>  						   0, npages * PAGE_SIZE);
>  
>  			if (dma_use_iova(state)) {
> -				err = dma_iova_link(gpusvm->drm->dev, state,
> +				err = dma_iova_link(drm->dev, state,
>  						    hmm_pfn_to_phys(pfns[i]),
>  						    svm_pages->state_offset,
>  						    PAGE_SIZE << order,
> @@ -1565,11 +1581,11 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  				addr = state->addr + svm_pages->state_offset;
>  				svm_pages->state_offset += PAGE_SIZE << order;
>  			} else {
> -				addr = dma_map_page(gpusvm->drm->dev,
> +				addr = dma_map_page(drm->dev,
>  						    page, 0,
>  						    PAGE_SIZE << order,
>  						    dma_dir);
> -				if (dma_mapping_error(gpusvm->drm->dev, addr)) {
> +				if (dma_mapping_error(drm->dev, addr)) {
>  					err = -EFAULT;
>  					goto err_unmap;
>  				}
> @@ -1585,7 +1601,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  	}
>  
>  	if (dma_use_iova(state)) {
> -		err = dma_iova_sync(gpusvm->drm->dev, state, 0,
> +		err = dma_iova_sync(drm->dev, state, 0,
>  				    svm_pages->state_offset);
>  		if (err)
>  			goto err_unmap;
> @@ -1635,7 +1651,8 @@ int drm_gpusvm_range_get_pages(struct drm_gpusvm *gpusvm,
>  			       struct drm_gpusvm_range *range,
>  			       const struct drm_gpusvm_ctx *ctx)
>  {
> -	return drm_gpusvm_get_pages(gpusvm, &range->pages, gpusvm->mm,
> +	return drm_gpusvm_get_pages(gpusvm, &range->pages, gpusvm->drm,
> +				    gpusvm->mm,
>  				    &range->notifier->notifier,
>  				    drm_gpusvm_range_start(range),
>  				    drm_gpusvm_range_end(range), ctx);
> diff --git a/drivers/gpu/drm/xe/xe_userptr.c b/drivers/gpu/drm/xe/xe_userptr.c
> index 6761005c0b9..7e28f6868ff 100644
> --- a/drivers/gpu/drm/xe/xe_userptr.c
> +++ b/drivers/gpu/drm/xe/xe_userptr.c
> @@ -75,6 +75,7 @@ int xe_vma_userptr_pin_pages(struct xe_userptr_vma *uvma)
>  		return 0;
>  
>  	return drm_gpusvm_get_pages(&vm->svm.gpusvm, &uvma->userptr.pages,
> +				    &xe->drm,
>  				    uvma->userptr.notifier.mm,
>  				    &uvma->userptr.notifier,
>  				    xe_vma_userptr(vma),
> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
> index 3dba4b9516f..ed228d9ff6b 100644
> --- a/include/drm/drm_gpusvm.h
> +++ b/include/drm/drm_gpusvm.h
> @@ -127,6 +127,7 @@ struct drm_gpusvm_pages_flags {
>  /**
>   * struct drm_gpusvm_pages - Structure representing a GPU SVM mapped pages
>   *
> + * @drm: The DRM device that owns the dma mappings
>   * @dma_addr: Device address array
>   * @dpagemap: The struct drm_pagemap of the device pages we're dma-mapping.
>   *            Note this is assuming only one drm_pagemap per range is allowed.
> @@ -136,6 +137,7 @@ struct drm_gpusvm_pages_flags {
>   * @flags: Flags for the range; see &struct drm_gpusvm_pages_flags
>   */
>  struct drm_gpusvm_pages {
> +	struct drm_device *drm;
>  	struct drm_pagemap_addr *dma_addr;
>  	struct drm_pagemap *dpagemap;
>  	struct dma_iova_state state;
> @@ -328,6 +330,7 @@ void drm_gpusvm_range_set_unmapped(struct drm_gpusvm_range *range,
>  
>  int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  			 struct drm_gpusvm_pages *svm_pages,
> +			 struct drm_device *drm,
>  			 struct mm_struct *mm,
>  			 struct mmu_interval_notifier *notifier,
>  			 unsigned long pages_start, unsigned long pages_end,
> -- 
> 2.34.1
> 
