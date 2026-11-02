Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54987606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q3Jd3jKb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 871E710EC4D;
	Mon,  2 Nov 2026 09:05:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DAE810EC38;
 Mon,  2 Nov 2026 09:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793610329; x=1825146329;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=fCR+IYFHRQGnJ0J9passNpl36OK7ua0LKZbyPArsc9M=;
 b=Q3Jd3jKbS1ZfvJCain6nWYmFQWDCJmPK1hIA7NPNZYwj04WaY3C4j6ty
 1MNGC8CnwvhnwTyFS30T0+hQ9FSfS0ZwsejkClq5j88zJ9poDDJT54hl6
 gAppyRrBUafk4/tvJEGb8ScqjFU1vVk5fFARf0jRZgNiwKfv8XbSqOxCF
 tvaes6gcq5PG9oaE/Z1OI1sliqZXC1v5uHR2n9C33QdVnMfiLdNhwGbYn
 I6w0dNuxd3teLiRZq3IDbPrQ9wClv43gCcVtzAYhXbj9NCEek8O36FVFD
 777yj7wVCtbCWrWluk5BYwtYBPSOQX88FLKXRd/46JsnbAKZvDJvto1xz g==;
X-CSE-ConnectionGUID: oG/J2OmUScSK+UsiXjmNMg==
X-CSE-MsgGUID: EL5lyyjcRs6HYiteM1pqog==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2308431"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2308431"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 01:04:18 -0800
X-CSE-ConnectionGUID: Q8uOMTKQQOODZlGJ4ryj3g==
X-CSE-MsgGUID: 8KOnHIS5S2GQHZ6SatzjTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6450315"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 01:04:17 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 01:04:17 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 01:04:17 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.4) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 01:04:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voumtj0iw8J7V/ckoTOSJp/SX9dmxiy25CMq8wXDGjDjfOvr7kXPmUxsUujYDO5BBkbvoLCtya5HoZAK3UYB6WDO85gvUuTKWa50COgye8ef3Uz0BO0l753AehhrXZs8be2yF5ttYocZgRtiTF7dqCpjCmsqYjoli4wlhw928RqrtKmJJYD1jSMOajfdBXb9GE8Fm5ni51ZZjXS0VSAcp/UVETWOlcnhO/aS6P7PMOB9HzcEvC5nvvrSI6grQRvL0afjMDDfgyzUw3J1WRZTRZ3Gb75vwaLQxI5mjtl3j/o4XE9yOzr+qjZM1dYW3x6Rb9FaQtvl4+Ny3C7S9UH1bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPD7BDjdW0l2feDPtL1kqFXf1uvUA+AbEwwZITzf1qY=;
 b=LXAIZQE2CUZxmOT1r5MSlADyp8VtLQHwMz0YUcmO9C+YmIDHiUQkLZpObeaTBTAKExgW3wv9O+zHhZ6Fl0fXIQVg+xdkjwP9RnJXf+YFa1V5hg5JEaq/EWBSHMH4sFDByGIMcGcLaMhXG1e63w7iiUen5gCfg3MiIZF+IAo5N33ZENjZ+yKLQe5a/kiES4MAp8l20QgCRiHSGf8Od+rl2M9umcpHL5Xi8XY9FcvrGFeSUNmjTfx5O5p8o0ochO/7I7ksh3jxpjttKoKfWkRJkxBN7Sbp3FMeUU0XH9UzSZxPgj3U8ejj6h6qmZ31IyHNQ0EJZFtPX+kdnUyCIdN+vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0SPR01MB0030.namprd11.prod.outlook.com
 (2603:10b6:408:16d::16) by PH8PR11MB7022.namprd11.prod.outlook.com
 (2603:10b6:510:222::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Mon, 2 Nov 2026
 09:04:15 +0000
Received: from BN0SPR01MB0030.namprd11.prod.outlook.com
 ([fe80::43a1:340e:3e9a:5b1f]) by BN0SPR01MB0030.namprd11.prod.outlook.com
 ([fe80::43a1:340e:3e9a:5b1f%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 09:04:14 +0000
Message-ID: <04675a6c-7572-485b-b300-6c5c3fbd591f@intel.com>
Date: Mon, 2 Nov 2026 14:34:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: Tear down kernel mappings in release_notify
To: <sashiko-reviews@lists.linux.dev>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
References: <20261102082626.747462-1-arvind.yadav@intel.com>
 <sashiko-outbox-193137@kernel.org>
Content-Language: en-US
From: "Yadav, Arvind" <arvind.yadav@intel.com>
In-Reply-To: <sashiko-outbox-193137@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0083.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::15) To BN0SPR01MB0030.namprd11.prod.outlook.com
 (2603:10b6:408:16d::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0SPR01MB0030:EE_|PH8PR11MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: 18871c0f-4873-4864-6f05-08df38c0446d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|11063799006|4143699003|56012099006|261009223027099003|261026140227099003|261026121527099003|261028144727099003|10067099003|261022105027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PHaDE7MoJPiwVGRQFAjkVU5OfdXBr+JFXxc7iXgmDFHW+OtBrX/OjdR8BZf4+4KvNqnezKC00K9JXNPYmHsM0fry/HaPNycwmGKapoglpETXPGcHAJS8rKejvXU9sFRIS7kE+10rG+8MKNUSpTxKNp4n5g6HcmAwBJPWJrn9DXEfeaJ9qr0GRmGqzZ/x9txlWi0j5eY4RwtmhnvmnQAR+ySOgH/T89GXcw1sarqnZZHVnIAdLM+19/i7r50eG+X6JYXmC5qaqChLuniRmAtwatbN4oAa9DKacj2aIMWpIr0EWAY8LZC+MgiMY+SYZ9BCb/yu31lDFggtSLpz+waXHVarG+bdX9ScoM15E8FRgQtg+3QHn4XomrquSW5vhmf5H/DQgdsqfx9NcePlcyzLQrFd9YTbdbROEhJczKKkZu9HbG2eE4MiT4llQ7hkLMyRYbGZL1Y58aYub1jByA/ow77EiG6IQReYrrmu644mbaHXyq/KCSmkd9Oy2GI3R9jkbZaFWJHUgdFSClnfdu8Yt4EwwoyNZV/ZEMTsDk9Ua4jEIQDNAHoNl9qX9RTJjoAj5cruDdCnxpygK2cHEdJUA5Df9ejs/pnO/Na3AmSbZ5lpsDr4kAtYEreZ63cBpsgutKsgHb3Krm8aonTc5aqKWx4ya+nQGOICyim1S/phBTs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0SPR01MB0030.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(261022105027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0NPdU9xRHVkOHI2d2h0bEkvWHpERStZVXF0RTU2ZVFjWlRKK29KZWZmaHlR?=
 =?utf-8?B?MVVjUUxRVmRreEN4T0ZPVnVqQjIwMEs2Slo2cHVjVEJHd1VuYy9oNTdWNnJH?=
 =?utf-8?B?R0hXc1gxREVpL1lna1dDaWZsemJMQ01nb3NQc1A3Qm8yS0x4ZDF1SzBpNUhi?=
 =?utf-8?B?ZGxIS25zTk1UWkxaWGt3dXltZGN4b2tKZGRTVWtkTG1WbjdlL0RwajNocDJt?=
 =?utf-8?B?ZUxwQnJIWmFtK2hJV0tVUE1qN0k1emlmZldxKzQ3Y2REQnEzcDJNeGdWV29Q?=
 =?utf-8?B?Z0NGcHg1TTQ4ZE9Hb2h1VE95a3EwdUFXd1dBTEFKdTE5MkRlVUEvNHhQVlBJ?=
 =?utf-8?B?VENwbFhSbmE4eCtPOFJWeDFnL1V5M0svdjQzeGZWMlRneU96WlZBRDBTdnhD?=
 =?utf-8?B?NmJWWDYrWDJydmZ2WFJtempXK1JmUk9NSGpaNlYxYXRxaTlWMXlPc0JtWEda?=
 =?utf-8?B?eG56MCtqeGY1ODZ1M2ZsWVk1cmdKSG14elArREQzVVhiQmI3OHBYWE9iL0Vk?=
 =?utf-8?B?b3BiZ3JGTDRKcEN6UDdnYTVUcll0NVlFY3gwK0lnS2tObTJSc2JlS085RGpt?=
 =?utf-8?B?VGp2cHJBWFk2UFFaZjJpcFRwS1lQb2c5am1JNHJ2L2N6c3JoZ3dBeDhBQTZC?=
 =?utf-8?B?QnIvU3NReU5MM0NSdU4wamN5UzhQajZ1R3pNd0Y4QjMzK28rWWhySStzSjh3?=
 =?utf-8?B?TVNxRkt5TlNrbGtPaEM3enlCRDFKNDdnY3l4MDJieTFjQ2RDdVZPdzZqNGdG?=
 =?utf-8?B?elBjTGFYbElRcVF0VmlxbXVWY3NaaXVEMjY2bDE0T3htQkdpcWdFUW9ZUy9B?=
 =?utf-8?B?VzJ1ZTA4Y08rSFFuOTd4Q1FpZWkvTWRnUVA0ZitrTDI3bnR6ME90M21pQzNY?=
 =?utf-8?B?ZXVuK2w3OTBsTG5zNkk2TkdHR0tMVk1wZzlSNXk1ZEduT2dGN2d1Q2pUdmo5?=
 =?utf-8?B?b3pIYW0yZmM2aHpXcHE3aXRnQW41aW94RUdDVlROUVY1SjRFLzJ0TGNKcE5z?=
 =?utf-8?B?aXNHUzFITStFRzNPbkNTOWF0ZHQ3cHd1NnNCRFJKTEhyOWZob2hSaUdwOC9t?=
 =?utf-8?B?ZEVFM3hnMmZWaG9LL2JxTkxCU0t2bTdieXRtb05mZGdZSjE3REVrVlllOTFM?=
 =?utf-8?B?Vm1CN0xZYVFJWjlSenloSS9aMWEySGdDd1F1Q3hiWXErOHd3Slozbmt0bm5P?=
 =?utf-8?B?a1V6SFZsOFBpUXl2UFExUko0SmpOamxUZUh5eStHaDArN01wQmxGZlNadlN3?=
 =?utf-8?B?MkNHNE8zenUzS1FxTnVJOXY0dUlVMVBMdG1nbGVIQXB2dExLYUhFUzFMUHNh?=
 =?utf-8?B?SHVkSUU0R3VsTmRIaUhqeU9oR2RJYVo3OC82bHJIdjFTVm1BSGxJMGRneGJP?=
 =?utf-8?B?R0NCREp6V2U0SS83eTNGYzdRc2t3Vk1YM01PcFBVeHZkV3VMNko0N2h0dXBz?=
 =?utf-8?B?dGVTbFR6OHNPT2ZBaEtYRld6U3IyZDdjanlHQ3MyR01wa0xUYXkxV2pNTVhZ?=
 =?utf-8?B?YWJQVFhXa1pFNENSY2Y1eDV2VlRVTVllRHhuWUVQT09SRlo5N3hHR1RBYkFG?=
 =?utf-8?B?aGNYOTNFOUtTU1JZd3BRNklxMXZtbU9HSXRlclBaUS9obFZ3SUJUU3FUY3pk?=
 =?utf-8?B?cFlZaVFMdDdTNnRhR0MreU9nL3dpR1dleVk4cVNiVHg4bVk2b0l0WmxiTndq?=
 =?utf-8?B?a2RXeUVhMVo3MDlSM2wzODJxWlFJNDU2WkdndG83TWhVdmtFRUh5OG0rYXlN?=
 =?utf-8?B?ODliWm9xZGlxWCtqSjUvYnVHY1JVMWVhV2RpZVp6YllQRmI1Q2NubHZ5dEx4?=
 =?utf-8?B?d3BiTXc5ZVl5Q09iRitiK0htaG9XN29BUVhJRGN6ZlpEWGZhYUhYUStSUlo4?=
 =?utf-8?B?NG5tSEgxYVFtQ2Jzbko4aVJlTXpNajJyQnFncmtQMUlRSnZCd1IzUTNjdlJm?=
 =?utf-8?B?cEM5RExRQmcxSThhaDJGQUpFN3l1ZFpqeGxJTDBobS9KYnhCWk4zWXVGMXpQ?=
 =?utf-8?B?dC9yaE1NdXgxeHg2YVlXcmpRRThYbDJibjJ0dGQ3V2lqa3plNlpscWZLaW9p?=
 =?utf-8?B?cWRjQjZVTCtieWhQdGpUMDJSNzVwcTMySGdxMExQc2toeXV4ZXBTQng3Qy82?=
 =?utf-8?B?WVV5aytXbWlYMXdzeDE1Y2Q4WiswYTRVQlREbU1zcVR1SEpSVTVsZDJvWXAy?=
 =?utf-8?B?V3RUQkUyTVFMMGhlL0UwUHZYdTdxMTFzVlA0am8yL1BBY3JMdUhpbHlWNitx?=
 =?utf-8?B?RnJhT3RDVmoyYmxCNWJLZjlTdlpHUnpkQ3VjNUxtdEQ3OFJXclYyNDdPeVdF?=
 =?utf-8?B?RnFDVkIvVytHblFmZEVQNm5lUDJCbDVtMk5PckhuWE1tWlFzSGZEQT09?=
X-Exchange-RoutingPolicyChecked: IKMC78yeqsvJQ0bGbi3YzHY/R17ecKa1gBBuuEM14hFLmQTSTUP6jc4NTHYYL7FuOusb8lJLhgRcgnUiAwUCtyiAH6ThXZSfVntQC2HhuE7KFMT0NLchsUPO+Ribal/KuGz0mnTU3qlbRzMxbPLxev6HpjX7po/R/fcXf9JA6shXFz9enpQ2C2w3MFDJsY1ya4Hd04cBCkev7QEpSquH7tUy1hnZ1yz+1RZhXkiNlEUVvckHw+J50x8jSY4u9TQh2CLA6PGvTXMGUUOlICd/W/Ju7QHiUYj7topykchgUt235+09LISq2yFLDZtC5Fa3qLXNXdO+xrTE53L+9WDzGg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 18871c0f-4873-4864-6f05-08df38c0446d
X-MS-Exchange-CrossTenant-AuthSource: BN0SPR01MB0030.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 09:04:14.6310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tKKRwmGrsremC46khMn3N1Hrmb78zMUs3YfTtfj6lPI+9NLd7OBhBK7uKnT+mbgAJA5OMTx3Z4s04Dk0h1rO1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7022
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 02-11-2026 14:16, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] drm/xe: use-after-free in __xe_bo_vunmap() after xe_bo_shrink_purge()
> --
>
> commit e49e34413e8a801c5062d0f07639d200170d532c
> Author: Arvind Yadav <arvind.yadav@intel.com>
>
> drm/xe: Tear down kernel mappings in release_notify
>
> This commit moves the __xe_bo_vunmap() call from xe_gem_object_free() to
> xe_ttm_bo_release_notify() so that kernel mappings are torn down when the
> TTM BO reference count reaches zero rather than when the GEM object
> reference count drops to zero.
>
>> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>> index 42a6aa1a2e4a0..b7a982a9d81ac 100644
>> --- a/drivers/gpu/drm/xe/xe_bo.c
>> +++ b/drivers/gpu/drm/xe/xe_bo.c
>> @@ -1866,6 +1866,12 @@ static void xe_ttm_bo_release_notify(struct ttm_buffer_object *ttm_bo)
>>   	bo = ttm_to_xe_bo(ttm_bo);
>>   	xe_assert(xe_bo_device(bo), !(bo->created && kref_read(&ttm_bo->base.refcount)));
>>   
>> +	/*
>> +	 * The TTM BO refcount is zero, so eviction and swapout cannot
>> +	 * take a reference. Unmap before TTM frees the backing store.
>> +	 */
>> +	__xe_bo_vunmap(bo);
>> +
>>   	if (!xe_ttm_bo_lock_in_destructor(ttm_bo))
>>   		return;
>>   
>> @@ -2056,7 +2062,6 @@ static void xe_gem_object_free(struct drm_gem_object *obj)
>>   	 * driver ttm callbacks is allowed to use the ttm_buffer_object
>>   	 * refcount directly if needed.
>>   	 */
>> -	__xe_bo_vunmap(gem_to_xe_bo(obj));
>>   	ttm_bo_fini(container_of(obj, struct ttm_buffer_object, base));
>>   }
> [Severity: High]
> Does deferring __xe_bo_vunmap() until xe_ttm_bo_release_notify() cause a
> use-after-free and premature backing store free if the shrinker purges a BO
> after its GEM refcount reaches zero?
>
> When a kernel-mapped BO in XE_PL_TT (such as one created via
> xe_bo_create_pin_map() or xe_bo_create_pin_map_at_aligned()) is unpinned and
> its last GEM reference is dropped, bo->vmap and bo->kmap now remain active
> while xe_gem_object_free() calls ttm_bo_fini().
>
> If the shrinker grabs a TTM BO reference before ttm_bo_fini() drops the last
> kref, xe_bo_shrink() sees that the GEM refcount is already zero and calls
> xe_bo_shrink_purge() directly:
>
> drivers/gpu/drm/xe/xe_bo.c:xe_bo_shrink() {
> 	...
> 	if (!xe_bo_is_xe_bo(bo) || !xe_bo_get_unless_zero(xe_bo))
> 		return xe_bo_shrink_purge(ctx, bo, scanned);
> }
>
> Unlike xe_bo_move(), xe_bo_shrink_purge() does not call xe_bo_move_notify()
> or __xe_bo_vunmap():
>
> drivers/gpu/drm/xe/xe_bo.c:xe_bo_shrink_purge() {
> 	...
> 	if (bo->resource->mem_type != XE_PL_SYSTEM) {
> 		...
> 		xe_tt_unmap_sg(xe, bo->ttm);
> 		ttm_bo_move_null(bo, new_resource);
> 	}
>
> 	*scanned += bo->ttm->num_pages;
> 	lret = ttm_bo_shrink(ctx, bo, (struct ttm_bo_shrink_flags)
> 			     {.purge = true,
> 			      .writeback = false,
> 			      .allow_move = false});
> }
>
> This purges the BO via ttm_bo_shrink() -> ttm_tt_backup() ->
> ttm_pool_backup(), which resets the page caching attributes via
> set_pages_array_wb() and frees the pages in tt->pages while bo->kmap is
> still mapped.
>
> When the shrinker later drops its TTM BO reference,
> xe_ttm_bo_release_notify() -> __xe_bo_vunmap() -> ttm_bo_kunmap() will run
> and call kunmap(map->page) on an already-freed struct page, or
> vunmap(map->virtual) after the underlying physical pages were already freed.


Noted, I will fix this in next version.

~Arvind

>
