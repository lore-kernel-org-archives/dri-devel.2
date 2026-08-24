Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7821C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:00:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0588A10E07A;
	Mon, 24 Aug 2026 15:00:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GddRLnan";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DADF210E07A
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 15:00:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTGo7FUch4/ziVOfhFRBmjTYan5QdRBw7yRheH8urxtyoY6eLJ5TSk9ZQbQCF+QTl83iKGOwYILq/FXFKPwzD50LlS+F1A0ssLC+KPfpSPk9UKoVpbZlgKBIOxjMwQyrfO9iibDIltS5/5WjD2DE3uOJoDadqHDCeC4zKRXGOemiW6P+L+NwrmtUSvecl7bzLtOw8IUavcNpsg7QLfMA/HfiKUJMMnp/eyYbe5tclKvPQtA6X+p2UUW3DIp5dENOPA77ms5YfLgqVQ7RjX36oo0uqOnJoUMlGBwEz8H6eMANYKWiiRGQyMnExSiE5DZxP6zlpGjnSlwh8d3HRNu6fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBXIJ7YyhrHhc6iAOSZApA5LfE4ZlomHcKt5QYZCqxU=;
 b=HRW6qbfWYWl+9IebU2m7SSIrKk8VUhsEbOjCUYarz/UP1j75B5xkJzbl84hhH2MZq5/HaGLIRAC9vfqOoAr2oRhlNzp6Vejt5n+dOVJKkEGGl9ZQo6psZM8slbLqpUmX7DEJ5afutBFkmlZnkRYTRn8TaNxYGdRQWI8PBsXb9M2KQeZGaP7VazqVgzSeUvTfXY0npuqb6tI1rSMInoBisNWzEVske6wDflCM6XFLU61JLaregphF5sNGNavKiwVeuXv/EqfeU7Ot8jjXxv9hYp1R78DleBmV29syz+NMIizAJARNsZzyc728iX9W73lLkMVDJyiNYNRh44okmLlQjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBXIJ7YyhrHhc6iAOSZApA5LfE4ZlomHcKt5QYZCqxU=;
 b=GddRLnanvSVdjE1xgeVYaCYUno22zOFDnkrUu8pO1zr08+oO3favU+LkJvb5T3kUzWaT4I6zMEMKFTjXDqaH6uS49N9yHTicR3JWL5QNP6U+Zt3lWDbUfYj8pzHdmdIvIbTLZTOYP4Y/sbj3kTGqwhAr/4XO8fsvQKlWDmz6eUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB9497.namprd12.prod.outlook.com (2603:10b6:208:593::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 15:00:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 24 Aug 2026
 15:00:31 +0000
Message-ID: <5cd11b52-0d91-4c94-912e-53c01cba7a37@amd.com>
Date: Mon, 24 Aug 2026 17:00:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] drm/ttm: two small ttm_bo.c cleanups
To: Sean Chang <seanwascoding@gmail.com>, Huang Rui <ray.huang@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260818163719.115946-1-seanwascoding@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260818163719.115946-1-seanwascoding@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB9497:EE_
X-MS-Office365-Filtering-Correlation-Id: babf0c35-67b4-45ce-9b59-08df01f070f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pjpss2eXXsP6H/Vh7bn3Ss/acncR26T7Of27wchCfYx6Na0OIq56EQ6ci+/BL3a7P6VtVwwvr7JCdRi2e4RzLNszcJ527XnakZqAt8V6grJGZjMNvGPQF4RdFezsc7Mq6bGYr5gZ7UtgtQvZK1b3gy9O+5wRoHHON2qaMgq2SDGV3HfK+CBQqmWbMc+4cwsgyGV5FHypNgB80EEQ/oUk9JwI7Ui5jxqKOMYOcRP0HFxyxz9NtGW8X3INy8FmnjiiusP8GkvRp8YqprETWKT52NHavryX2EPHbQaooxnS225X5iaC/xEhDFLFQ+GZZM4E4tZAuYntZKvle2s/8BailrDyx+vUZZkyBq3z1iUxS1OX5dYFh0tIdOdYRgPVHSC5Z9vNUu+kI7Mp+jj6IPAWmn4OSw9LMT9UbBj1tBS9QfpfZ639Yh0wOHH0A+MkD1XHI3j2Qmezpc9bswo+TbK9vDvwrppmDzLN0K8VpPo9spwn3f1k3BFggRK36ubevnLHFU+vVmvwBitFZXRC3GzAEJHwAM2nyHfZq0q6XcYh9m/B5pBoPcOUB/TLwrdyJ2ggze4zMFVNVEIIldJslA0zMB0f0+OxAskuAH5fUP8idpE1b36diz2IkMecdxb8h83NHbx/agcK02g4jlcg5s/d5Ifx/jm3T1PRvNZulmKfvuo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?US9LaXVTK0JZL3JyakZKb1pPWVBMZXpDaGtrMGVEcGQ4cXJsZCsrTXZpMjBJ?=
 =?utf-8?B?eWlPaVJqZTczR1RGY0R0M2NDeE8ySlVGeTJiZXg2eGU4VzFYSGxiSm1lZ0ZL?=
 =?utf-8?B?N3hYMzVqTUdrNGRsUnFHUUF3c1RWUXpwVWJQNnJ6ZmhVZW9oNGh2blZTTTB2?=
 =?utf-8?B?R0Y4amEzWjlkRjlCL1RNMVVmeUFTWDRpQkQ1L3AyZURXQ00xWmFXMDd1Q0dt?=
 =?utf-8?B?bDJ4QXZwZkllSGFtRUlndno2ZVQ5UExLcFZBVEJ0WEd0c1NHalBjcUVKUzd1?=
 =?utf-8?B?dURFWU9YdHF2Ym5jTnFBZXU1YlJtbXJLRE0wVXNsVEZBQ0U5VGJWSU9pRkNz?=
 =?utf-8?B?bTdjN0NkTmdLKythOUlYR25LRlVHaldKb1lNQVM0Mjg3alVkMm9HajZPdlhE?=
 =?utf-8?B?YjdjSUNQVVo1WGxYVW8vSkY1YzFabU1ScmkxYk50TWh5U2pWQVhlR29wZmkw?=
 =?utf-8?B?cFNSSmlYMjRiT2tFU3dZdUh5bGhGLzlVWGJabE4xczZpcWE0Z1h1TnRLZTV6?=
 =?utf-8?B?VjdacEt5dXNyd3plZTI0eHlOMllnVHhLR3NETU1sVUhjUFY1bDgvSFZQVGp4?=
 =?utf-8?B?N3dJbkhIbE1ZMVpXNmFYaE1iVFVja2JFZTN1YlZETlhpdTdiL1llT1dtTDNE?=
 =?utf-8?B?cHNZTGFQYW9jS3FRQ3RzRTlKUk5Cc2pia2gzSUUyaXloTjA4STNlY3JsM1hx?=
 =?utf-8?B?cGFUSVU0WXQ3ZGR5cEJyMHJ2Rm8yTjFwNWxNUVRhWXpFQWJ0RHdJZ0xKdTNL?=
 =?utf-8?B?Z3p6Zk45emxjbTIzei9xdzNTeWVlNG9ac3dpSVZQRUNoNGtxZ2JlaERnQ0hR?=
 =?utf-8?B?OE1VK01aWFB4VDVsOFhGQzlXYW9Rejh3ekhEaThESGRQWCtOdWIzRG9KR1dS?=
 =?utf-8?B?OWVKTjhRbFB4TXNCSjM0MnJycGVoblB0Smkyd3M3dFlySmIwVU51YStPa3Js?=
 =?utf-8?B?RngvM1gvUHc0c3V4WGs5dUZXbE1lYjNoTTRncnZFM1oyNnhjc3FjNjRaVXlV?=
 =?utf-8?B?UFdxZ1N5c2Y2dWV3MTVBMVBxY2lmZC9kWThhTlNYQXdBTDgxZW1McDJXK1FC?=
 =?utf-8?B?VmNkTlZSM3VpcXJmSmNRREt5dGx4dlIrNHFvQjZ5bnFEbDlrSTNZQnlyYjl6?=
 =?utf-8?B?TmlZdC9vOHY5cHl5Q0Z2WXM2VVRBVUlHLzhSbHNYcnVMbDdpVlpvV2FLeFNo?=
 =?utf-8?B?RVpRL216RTZvVlRzVy96SjdpQmh1OHlxT1lyVGhERERUckJpaFVHMEVMcnlO?=
 =?utf-8?B?aFpoOHpHemUrMXB6ckFSeVJwT3I2YUtsbmRMQ2Y4TGI3QXdoNHQra282dGRH?=
 =?utf-8?B?aXM1MU9CQ1NleXF2OGp3TGQraDhxeExGcWJHRnBOTVpmeFBBZ29FYlk0ekxE?=
 =?utf-8?B?SGpQVmlDd1N2bzczcHRsbkQyQmlzZ2UzcDVSM3gxMzNBakoxUWNNelc5TThj?=
 =?utf-8?B?ZzB1Um5vMWE4djZmM21hRGtUNU1adUFpbjdjYXBZbEdXZWFDQXpGY0p5RXVt?=
 =?utf-8?B?UUxGL2FhR0tNdnVrTlNrNkhoem5Rckt0TUZOQ216Qi9GNnpaMGFnbTN5d0Nr?=
 =?utf-8?B?SmJzWUVSTnV0V29VblFDK0t1SlJobkhyRFZ0Q3VFd2JjZHJQQ0lWMGlZa0g3?=
 =?utf-8?B?cXhmay8vYk8wOWdEbFlENE5FSXlYK0lEazlPR1BpaWx6ZjdkY2FBYVIxbzZX?=
 =?utf-8?B?VWFtaHJxNm1MV2dnQkFRN0lIT3Axa00wRXFpanZRMmpVdHdKWEFhaWVKemRz?=
 =?utf-8?B?c21IYnN2bXl5aW9WUVBuZ3YwSHJNOWdBYlpZdDQzUkRsK0xxbVArazRhYmNj?=
 =?utf-8?B?d3k5a1VCTW5hNGkyYUtMT0o4a0lEemp0SWxGZ1Q4bDdDdDVMSjVjT2dyUytl?=
 =?utf-8?B?MmlPVjh4K09jeEZqMlY2VlRiVndUMDRjQS9iTlhoeGRodXVkRWJidWNFTkxF?=
 =?utf-8?B?eEFmVVpLRjY0N1VlcnQyZm85VnpVdkcwYlA2TS9BajVRTlhRbkN4bWFPSnZF?=
 =?utf-8?B?VVZqekwvQUpXcU5TUjZLUHp1OGJSN1ZuQVJCRTlodUNqTHU5UVBaNWlRNE9Z?=
 =?utf-8?B?Y3NkZ1JhQlNuRUNEQVNpMnJHUCtvak1SV1gyM1ovMEl1NjQxYnRlMVhpTkVL?=
 =?utf-8?B?M3NleTFGd0lMMEV5Z3NRQWZCY2tGZ21ERW1RUE11SjVrVFg5LzJabWoxNTA4?=
 =?utf-8?B?VzNrSGQ2eGtHVVRYcG5UK1pmbWNmWGMvWTVvRCtpRnFCRWpYUC9VME5EVzhZ?=
 =?utf-8?B?K1ZINGgwOEF0aSthQzZGbmVOWFlFYmgxd3F5U1FOSUV6d1NNejNLdUpPZHFq?=
 =?utf-8?Q?eRcbOeBIR4SpnFfYXW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: babf0c35-67b4-45ce-9b59-08df01f070f6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 15:00:31.4124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5fPp9eLKn3MYEOaPV52WTEAFtWkg6O6GJ8FzPxSrpxhDqu/Rr6/iXCjxeeVySZg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9497
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

On 8/18/26 18:37, Sean Chang wrote:
> This series contains two independent, minor cleanups to
> drivers/gpu/drm/ttm/ttm_bo.c found while auditing the file. They do
> not depend on each other and could be applied in either order or
> separately.
> 
> Patch 1 removes a stale @ctx kernel-doc entry left over from an
> earlier struct change, fixing a kernel-doc / W=1 mismatch warning.
> 
> Patch 2 gives ttm_swap_ops static linkage since it is not used
> outside this file and is not exported, fixing a sparse
> "was not declared, should it be static?" warning.
> 
> Both patches were build-tested with make W=1 C=2.
> 
> ---
> v2:
>  - Correct target function name in patch 1 commit message to
>    ttm_bo_alloc_at_place.

I haven't seen v2 in my inbox for some reason before pushing v1.

So the name is wrong in the commit message, but that shouldn't really hurt.

Anyway patches have been pushed to drm-misc-next.

Thanks,
Christian.

> 
> Sean Chang (2):
>   drm/ttm: drop stale @ctx kernel-doc entry
>   drm/ttm: make ttm_swap_ops static
> 
>  drivers/gpu/drm/ttm/ttm_bo.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --
> 2.43.0
> 

