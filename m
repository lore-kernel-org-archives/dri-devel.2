Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F43CD98F6
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 10:09:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EA9610F4F4;
	Fri, 19 Jun 2026 10:09:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="e98XQccm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C08A10F4F4
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 10:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781863769; x=1813399769;
 h=content-transfer-encoding:date:message-id:cc:subject:
 from:to:references:in-reply-to:mime-version;
 bh=d01lXWSOCFVAiPrMHi5UobG6hqCSVNfHn4Ad0pqM25s=;
 b=e98XQccmz9a9wUS9EAdfOapnpAu1uG7VGirfvoWysQ+pbkbL+++9/mlw
 ku4sH8Z51x2tdLVEW0X6ReowjOO9zRfkX6KIM7h678DNAJeH98nSckXET
 FCIkVbWSQ8yAmfZborqmkJlwjwrJuxfJITTmnT1JZd0tXwBdr+wVciK8s
 DGAZS9aD+LlX5F81la3bYbikWMEvDmx5cY+a3tqaz5FKTootlimyGaonQ
 q1XoDKgcS9BCQQZBmNkh11/D0lGtqZiTwkCK4TxjEbMME9M8FyIb9Ka2i
 /Qpm1kGqjK0YoPBbKlCKSxE9qZ4bSRldnF6cG0KJHussMGv0MXKzDVcE9 w==;
X-CSE-ConnectionGUID: TDQIEKzoT+27pRvUXazE1A==
X-CSE-MsgGUID: QBITXqp4Ra2TdgHI0hlH6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="86391643"
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; d="scan'208";a="86391643"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2026 03:09:18 -0700
X-CSE-ConnectionGUID: HcVcnrlVTF+WC+6J/0w9bw==
X-CSE-MsgGUID: Zn3MaqmHSpGd5q0qcyw8Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; d="scan'208";a="247454452"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2026 03:09:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 19 Jun 2026 03:09:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 19 Jun 2026 03:09:16 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 19 Jun 2026 03:09:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cj6j22HxsccDFxRxm1uVgmyVLKGoM6ZqkO2A/iI9qqoShIp4wcoZUyyGgFsSE1CLx5hN2S01Oo7rJiTmiD+bXDRh5S66I1UB8oSkA9+rynRKvlRP56868GQ3zVeAlCSmieP4JA3C6QJulBI0l+SW3BOJs4gTG9T9H4Wgk5cFgPv+WPQHyHHr5klo1gYzbQ0VwNoFmV5TEjlljIQIip8h8TokCJx5StgG9/bHMTnu4RtRnXzw57It5uYlBOw1L/7ejz3mNCus39UFE9aFQk3youDtV6Kh3SNhtMpD1+F7IwzpFlTylYw2dRvmBLTnGu+wkxUrmDQHsLimB07rOMMR3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wd2Kl1i+VRsSVzxs7T6u3qSLPLc0OxZTEAionqhVgHA=;
 b=ghmIWqFyGgxcYJBMmsYhoGCUi4E9GS3qSD8Ufpsx7yY8I3SjVQ2iC3dKcnvb8YUYnlGdUXYzfUEP4Sa2RULBAcmGuUFCyWIfcuLSH9wcPygizzjt31lzEFOMn9Zb1WyvydJrl7wOcVhyUY0GO5ljIqF3VUM6R05tWKMCkRbE3S1mkKLzy1LbdtU5S+2yR69x6M8XCfHr8nOnxmi7WR+4Arw9VAgDDBY53dTIAfB+ue4JqxDtYkBPo0+AvAJU1ndvBvmGkiHvpyBj0DNPcztOmWRZF2UZhJO7S+scm1RGtIfIzmui+ak+jhL+BdD1BuzyUntGPrkGIT/VGNUOlrXDZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4SPRMB0067.namprd11.prod.outlook.com (2603:10b6:303:221::22)
 by DS0PR11MB6374.namprd11.prod.outlook.com (2603:10b6:8:ca::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Fri, 19 Jun 2026 10:09:09 +0000
Received: from MW4SPRMB0067.namprd11.prod.outlook.com
 ([fe80::3605:4f97:fbe7:2c4a]) by MW4SPRMB0067.namprd11.prod.outlook.com
 ([fe80::3605:4f97:fbe7:2c4a%3]) with mapi id 15.21.0113.015; Fri, 19 Jun 2026
 10:09:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 19 Jun 2026 12:09:31 +0200
Message-ID: <DJCXZNU1BVXT.14OT23V9UY39Y@intel.com>
CC: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Krzysztof Karas <krzysztof.karas@intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>
Subject: Re: [PATCH 2/2] gpu/tests: Add a dedicated .kunitconfig
From: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
To: Krzysztof Niemiec <krzysztof.niemiec@intel.com>,
 <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.21.0
References: <20260618152331.36763-1-krzysztof.niemiec@intel.com>
 <20260618152331.36763-3-krzysztof.niemiec@intel.com>
In-Reply-To: <20260618152331.36763-3-krzysztof.niemiec@intel.com>
X-ClientProxiedBy: DBBPR09CA0041.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::29) To MW4SPRMB0067.namprd11.prod.outlook.com
 (2603:10b6:303:221::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4SPRMB0067:EE_|DS0PR11MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f18b159-0deb-4248-e3d7-08decdeace02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MgjbCBV6+ZD/Jk3cl3/mW7GAjCpkD5x8YdbIlbEMhbjqgRa4FDm/XkDFVLjC4XVelhtuiZjh43qsOfgTZOU7REORslszIF4pv5kqZyqFCIs1GFs2ekJtq8dOAD5OY5zPfMJyz4c2szxOoKVZPaYwuK56C0+aZEdfr1IurZIUvoe/pHF1lXDjnZJMzsleGnpyUu9FQFK4mYXesX+vwuXo+1MC136pL3HKGYf9sntmjMqTkJo2ouqiQPHY3jPE3eKSH8N2e0YaNDDz00jIyzsrF24SpaBBC2QYmdLT6H9hX2IlhXSP7IbxFCJHmw+2QVhzCd+IFP9OZaeo6Cq87GMDmcfvKiCs7/nke8laQECUgelvFEwynqHvxU6fo1c/eorMir+ghG85xdrcczjtj05J7CBWjL09ZMU1PkV6FwpquFmHYwr9PUcNi9mLqnMOB8VzbxibNRW9agQk+ZxBn2aCK9JnrBYa0IgLDNIffh7VVrVhJeuCVUQ0EjLq9Qkwd/cCLIv0rxhJk/SNgEVCHGviQZ4y6YwZpc8v2BVbH6YfeJRsS67uGlWbceRt00/ZUoOmjAJ5ikatCrqeL5vh8jCxbffd3rLIo9Yob6VWnbdZkyH4ZCCrsWHwBHVbGHbNQblgJM8qUNueY6IY2jCtoswKXxii9Vny8BVlLyyScrBt4wA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4SPRMB0067.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlNOVGZZVlBKOVAxQ3Arek85YnZmRFpxUVd0MkRzZ0hLTTRLTTU1SkZ5Nkc4?=
 =?utf-8?B?S3hIaUFjWFVJMWtvVUZVUXNuSXBObEU5SGsvQXdHMS9XdnFDekQvVDRsdXRl?=
 =?utf-8?B?dmRRRGQ5YStPbEdFdGJoeEhwQS9XWUIybDdmdlBGc3c1TC9UZ3RCZzBYOFZu?=
 =?utf-8?B?RGExMDJKaG5DbXhoamprWXkzWHZhRHBneDJFRDZyRldUcVFVU0ZKTHN2WGpK?=
 =?utf-8?B?TmNYV1BiTm1xaWlFbFRHaHFLTnRJR244WmY5Q3BDc2p5NWx5M2ozd1hqeFJl?=
 =?utf-8?B?T0dhaDBpaWVhRGtSa1dPcUxzTHFjNU9RNnVPSjFiN3BISlA1bUlNNENQdGpQ?=
 =?utf-8?B?a0lWR1pSV0h1UHJWZzhvZmcyd21SV0tEWGRvd0IxcHB0U28ya0xPVGxtcUJJ?=
 =?utf-8?B?RGxZZGJ1czBrY1hKaDV3YjN0eG5xNjRKdWtnZGZlNVpYNE0vbXFmc1gxTytL?=
 =?utf-8?B?VWhPdWwzelF1bjVuL21HOFlqNlVsSmREZEFMNEc5TzMvbFFWNkp4NUdEUjNF?=
 =?utf-8?B?MmkvbHh5dkNaMjRQQXNxN2FYOG5wZlowaVdSUi9lb0ZuSXcrTG1HMHA3blBS?=
 =?utf-8?B?Qm9hNmxxWVJSS1JqeFBmUTVmeUcxSGkxTjdTODl2UGlLdkVJYVZuek1ZTUcr?=
 =?utf-8?B?SkZqWThVdDdlZHo2eGllN1F4K2pGL2tiU2QwYjRLblBTbnp5K2txZmlZa3M5?=
 =?utf-8?B?SVZBRkNRNi9PUnBUcHJLc2hNOXp1TklEWTQ4dU5kcGV6dEpZeElNd2I2MFo2?=
 =?utf-8?B?NDFWUEE5ZWVwVDREbThucEN6ZXdLMUJBV2NVaWs5MzgzbHMwUGM0VnVrQzZr?=
 =?utf-8?B?SWhVZWhKQi9WL0hkR0ZRZDdjVXFnUnV3OFdDWUN4QmpzSGNyR3c4VWMrR0dX?=
 =?utf-8?B?MjF0SlZCZTRta0tJckVQYTBucUtwbUw5WWdlZzdBbzdyRW1WNkZpL0JKdEtM?=
 =?utf-8?B?UEJSSVBSYm9aYzNVREVlREcyNU9mY2JMQ3BtYmRmVmpqWkJMN29oemk2cjgr?=
 =?utf-8?B?T3lneVAyZFltaHVFam5PenV4VW92N2NSMFA0N2xCZ09RV1p3NXFQRFJKVjlJ?=
 =?utf-8?B?Z3hpbHNDVDFaQThRY1p2SFQ5Rm9vMWZxcUE2SkNSbjAwN0QrcDluTzMwNWZY?=
 =?utf-8?B?Si9WT3FJZGJVMkR4aFc1TTMwMG1WVXhWMVhwek40L3ViT0s2LzZjaXRVWkdR?=
 =?utf-8?B?RFg2SC9XcmtPT3F1dXlTV2pKdk40V25XNWpHMExuWVQvanQ2WlhzOStkcTFJ?=
 =?utf-8?B?dXZkQmtpenViS3o0czBaUExQV3N1NFF1a2tLZG9ZZk1NYXQ3L0k4cUJQSkdD?=
 =?utf-8?B?b2dVbVArbE13ak5ISTNqZW5pYzMveHU1RVorUStoemVvUjBTUmY3K0VqSnBo?=
 =?utf-8?B?QU4zZkZ5QlpBYys3NWxHcHZQa1E2RCs2dytQRjdXdExMQ1Z0YjBTZ2ljWmpm?=
 =?utf-8?B?c1JacHhoRGVMcHk1QzgxN0llV0w3TTdiSkduU3hwMFBqK3l0RDYzZHdSZW1V?=
 =?utf-8?B?N0x3b1pmZ3g0NXBUa2V5Yko5L21JMzFhYTlpb0x3MVRaaU50cEZIOVNFd0Ny?=
 =?utf-8?B?eTJoa2l0TVN0L0thU3Z5Z1E5Vm5aRFlOeUVKb1ljSEU4MmpvYVduTzYzZSt3?=
 =?utf-8?B?Q3NWR01IU3JmRk5LK0gwTk4xVC9EVkR2cG1pYkdCU1hPOTVCc2czR25zcUdF?=
 =?utf-8?B?VGxXUkQ4K2RoaWxJWllyVmdwMTNVamZGVWNUN3M4a0JkeWo5M21EcmxJUzAr?=
 =?utf-8?B?UXBOdmNhRC80THAyVWgycVJ5MjlDeFNwTExCeTJzWDFTeVFwUlBham5LNmtr?=
 =?utf-8?B?WUkzc0VVVE91R2FMNEVOQjFTa25MR3ZKTXhub1pnNlZFMmlGS25YcHZkSFRL?=
 =?utf-8?B?VVY2QXhVTWJ3UXN4NEJvKzZLcG1DWlRSQUt2U1U5d0s5dGh3bDBhNHdZaEVX?=
 =?utf-8?B?U1hzVHFWVithOWxERXlmdXVkNzVveW5BSWRESnh0ODR3SWIwK1NMZGV5NXdP?=
 =?utf-8?B?S003RGVzOEdQV0pzZElURTg3YjhTVUI3ZnZjZy9yczJwUkhhTk9GdGZxZDYr?=
 =?utf-8?B?Q1JVOXFac2JlVWsxTC9CMWNocGtzWENZelVQcm9KY2oveXNRY0RZSytSQ2RN?=
 =?utf-8?B?UkpmSVNhN1Exa1ZiWTl2R1U1UHQ0RzlGRnVNV2hUTWxLeU05dDcrekJLQUJP?=
 =?utf-8?B?WjNENFI4NFhBTUI1VFp0OTlhNndmQkpjSzh3NUR4VmRyRlpJNUJ4bDB2ejJS?=
 =?utf-8?B?SHZTdkMxQVhSeEJQLzlDS3I5ZHJUZmt4K3VkUkZsNUhuMmxXSUVXSTl3dkZ3?=
 =?utf-8?B?K01vdzRBNEYwTGtySS8ycHpKMngxVkFnS05hem13aFZzUmI2ak9sREVzQTVk?=
 =?utf-8?Q?CcyCqk1w6GwCeasg=3D?=
X-Exchange-RoutingPolicyChecked: qgIY6/wJ5RJvPnYwUgNKvxdr0qsM8ygld3f0KM6j4EtcLGO4cazAbHbQ4UIJwR3GlljsDhaM80X6somg+OjQBCVzB2cAzXbhAkIR3TQyxHEyv65zdVn887Hrrysg7xLjDGHeb+2ZgSA8y4IKOBqfBebdwqCt7gQlFkbbvVGxRgJKJlPpm8VSn+XiOQw0TmRKKMxT/5W3AWu+WYjGArwgYU+rK87IBk3mrrolhxIhqFl3M1RSPNqIzK/z5oK1GLrmMNggCJsJZNOQgeglfv8/aTLaaiCpMwE5xDq7+4gFqXXRxUa1YBhCqyjknePIzHFjzmIh4/DhsBxnafryE+3Vaw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f18b159-0deb-4248-e3d7-08decdeace02
X-MS-Exchange-CrossTenant-AuthSource: MW4SPRMB0067.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 10:09:09.6854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6b8nLodgrzDEqcw7sIRdhe1OMNJ1KcNaTwCK/i1GZTuOjhEDYhYNTBvoa2IN5jwGKROj2LYQ8tiPcnuP3Bxbphv1sOXByxRwR1ynkZflzj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6374
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

Hi Krzysztof,

On Thu Jun 18, 2026 at 5:23 PM CEST, Krzysztof Niemiec wrote:
> Add a dedicated .kunitconfig for running the GPU buddy allocator tests.
>
> Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
> ---
>  drivers/gpu/tests/.kunitconfig | 2 ++
>  1 file changed, 2 insertions(+)
>  create mode 100644 drivers/gpu/tests/.kunitconfig
>
> diff --git a/drivers/gpu/tests/.kunitconfig b/drivers/gpu/tests/.kunitcon=
fig
> new file mode 100644
> index 000000000000..fd611b3dfe09
> --- /dev/null
> +++ b/drivers/gpu/tests/.kunitconfig
> @@ -0,0 +1,2 @@
> +CONFIG_KUNIT=3Dy
> +CONFIG_GPU_BUDDY_KUNIT_TEST=3Dy
Reviewed-by: Sebastian Brzezinka <sebastian.brzezinka@intel.com>

--=20
Best regards,
Sebastian

