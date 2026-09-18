Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C3BC88E75
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1538F10F266;
	Fri, 18 Sep 2026 08:07:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ln5xMf8i";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AEA510F266
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 08:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789718858; x=1821254858;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=dcXb1N/ZOs92TUVSl5a3+HXdWLFz41o4kfTh/POAoGk=;
 b=Ln5xMf8ildKKG3mlxmPJxjBLZtAiF1f1FFVKXzUBr0lcIkQW0vcmiP2d
 SGrP6bPB1K91MDtZbyyg6WacFbgDnp/51d3KjztiqfI12fNpeAIP+8bXm
 hFzeBWYbWzLh37RVymI4RFrYTEsUAn3IdzoDyXSjDpLzEWGwcH7DSBVP2
 0gSwLLdFtfau+2imiGVeQQtT9qSlA1bomHFef7MdFj8FzaiL+c0POskJX
 zpRpfPiKtkBr478mmNIuKZ6G6Rh825l2xDh6CL3jBvlAaOjXZAOZs4zIr
 Mv6Kc5F/B6Wmg3Bo8m4ER2vJToThueUmfFjUs9NkyhehHjEOGgT7hkPXk Q==;
X-CSE-ConnectionGUID: ZVeMENoLQWGz5RO6IX7hSQ==
X-CSE-MsgGUID: 3KZXvpTHRcSyy0nD6vSalg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101555546"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
 d="scan'208,217";a="101555546"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 01:07:28 -0700
X-CSE-ConnectionGUID: poIuzPecT8K+DZLJbB5kGQ==
X-CSE-MsgGUID: ZS1cWOU+Ti+dlhXpILEuDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
 d="scan'208,217";a="269978195"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 01:07:26 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 01:07:25 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 01:07:25 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.50) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 01:06:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKjFAf1UnDZ35UJnqjgDgh9drXdDrfKFI552NKdcjo631qKBi8Un1QekXHrhnu8cMtaWPLHzyB4PdMZuxLdzu3dU9B2Q+ftRFxAAWT+0GwxPhkTr83JNL72EWcODczQeGyGjhVTV19Ab4jk2STVRnCyx4jO7GdjH1WzAtJ+o3xODVs4prezvLQlTzhVITPN+/Zbv6OTGRhdF1y+0AL6ysglsUssh/0as+P7igP3rDH4RObvnYhKo644RvB6BtZrQYZexchkYGfITE8FAnUECTnK5yxK9/lpCTe0//rbHnUGAsT679YjTKu/1nhJzAkMKJiBNbY/65QAZYG6JDRZ0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlck7xcFgWyqydued7UWrmnfUy4wCdaemmGAdStUcYY=;
 b=CFuEuwBXqFTMssM1fvs33oZvSWmuErQaX60Vqaf7vcsCEyul7oN5S/zuaW90n7Ce4ljVHQFlp/yreLR+I9oJ5vFM3tZjwgYAB2uFalF98EHvW1MarcRGgLtudkTs8Yh+OhhOYcXJlvSuEoTgVjHh8F6w1VtY/1OYxPPap7WT9PNWBCaZAs8xYwZ/XLC8O/c1uaV7+gb82wowvyAYHutk1yRLMjAz2TYpodOE4qZ5Mz26mQGJ0E2435HZ3P6U5/xSc93T5xDPGRO8KpyPrKPuqKBFWw2ilxeIW0bTmRugzkWCx9NXlxYuHNIuFv3Y47YKmvs4yP4SB4czAhYoy/X2Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6)
 by SJ0PR11MB6670.namprd11.prod.outlook.com (2603:10b6:a03:44a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 18 Sep
 2026 08:06:42 +0000
Received: from BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c]) by BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 08:06:42 +0000
Content-Type: multipart/alternative;
 boundary="------------I1DyKEPGu4GhazMUNsvNWcib"
Message-ID: <8395d8f4-2507-4e13-86da-5503a2ed6bcf@intel.com>
Date: Fri, 18 Sep 2026 13:36:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/pagemap: Prevent CPU stalls during unbounded pagemap
 teardown
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Varun Gupta <varun.gupta@intel.com>, <dri-devel@lists.freedesktop.org>
CC: <matthew.brost@intel.com>
References: <20260917170357.3926213-2-varun.gupta@intel.com>
 <7ee240d45896cf5f4845b4ca0740a307edaf83a7.camel@linux.intel.com>
Content-Language: en-US
From: "Yadav, Arvind" <arvind.yadav@intel.com>
In-Reply-To: <7ee240d45896cf5f4845b4ca0740a307edaf83a7.camel@linux.intel.com>
X-ClientProxiedBy: MA5P287CA0282.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:221::15) To BN0PR11MB5709.namprd11.prod.outlook.com
 (2603:10b6:408:148::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR11MB5709:EE_|SJ0PR11MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d5a723-3b4c-400a-7123-08df155bc61b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|10067099003|4143699003|56012099006|8096899003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SFQ0wx2zKMWTPU6noxaP3lvFKbncxmZBloCwjnnuJwCqZa4DUIV2KXunh+z5jIxzgCgAtUKV2vrgMSfd2ZOG3uxs1AefDH4YhR7mphwCKyTnyCcOx3b1/hEanzQ/rWrT1I0TOH2AJFtzTe79EohjnVv1fJ5oXhNB7dD1KtS+QtZo7eLzeFm4nHummXWc3jDr6OWdFj08hoazCM1c7WSaMIuYQm8oAsositwe3imR5qX38OBV7Worup+d5Z7IVH1AHxg4vmMqQTLvJzIv8g21YsscgHEXRy7yJ5I8d4I9uUT2bQFZ0LXjkoAqamOKlwAcNFy8YDOJBbxwWO7yZpsk/CZF4qHPryaF3xnyoXlRXT61EV6sE73WIYePJpTxA0F7kwVxs73PQzI9WmIDgGEnUBSxla66CO+pEkBXllReLKHNsrcdZg077b4Dl1kbaRCfFJgi5f9lYkIO91TC0iOzj7feG5q0t73TMNxWgyLKmfYkhVnpFAEQNOWqekJwWitx08KhEjvlw+T18tcQF+n/34RIX20QR9zWK+tDM64uWDLF0Kod8xsHS0HbPN/4MTBitU2uyADJ5b73ASw3Hq2oLMa2Hq8hFTm85oErIDxRKsS4K0PjiwgXMzUnL1BnZfB8fjW2cDdGVXUUx2k5H07N+RWhJaYdXAdGRVBz7aAyp08=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR11MB5709.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(4143699003)(56012099006)(8096899003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE9NVVdFNzU0bkl3NnkwK3ExZjc1Sy8wMWJjU3B0TThMNXU0Um9COVA2Q1V3?=
 =?utf-8?B?VUNyK3V4WUNaMldJdjlGK3FCYjRhb0dyeUVrTlJTdHhPUVQ5KzFCOVdkeXpE?=
 =?utf-8?B?WHVwSE5MNVBrY3RuWlM5RlJJTXMrd0xhZVYwYlR4S0FHdEFzQVBEcC9YbzFY?=
 =?utf-8?B?dlROSklXNHpxMEY0cFVTNFdrM1pUSVJONDkvVjVNOEx4cFZmS3BzbUNGRjg1?=
 =?utf-8?B?cDY0VXY4QzAwclQ5NXJNZDNUdVByM0Evc2dVQi94dkRvWjYvWWIza3RhVjJR?=
 =?utf-8?B?ZENFdlNkdDNvSzlIcFYrM3BvUWN4emlKMDloa3QrUnM0SHBiRHJiMitOVkFW?=
 =?utf-8?B?cXJZb1BZeEpYVmpGa3JobTJ5QklibW1wMlIrajNpQnIxYUVudzd2MDE3MVVR?=
 =?utf-8?B?ZHRFem9uYXNxVmk4T1BMVzN3R1V6NXRScEdkZjk1OWJWTGhDQU1udGxEbGFh?=
 =?utf-8?B?QTVWYU1iQkFXL1kwS2RGMnptbmFBYk9GTUxpbkxPTzNTTmVKWjVwRCsyNmlY?=
 =?utf-8?B?YlNoWVVUemkzNG9BTWF4VkZWN3NCYks3TUoyQWpmQjhGYkVtMDNmMDJJcmYy?=
 =?utf-8?B?VGVwL2NPVjB6V2JMcTdsRjBtV3dJV3VCenNlVWQ1Z05yMitrSlZKRXo2SE0x?=
 =?utf-8?B?am1LdkEwbHZYa2F5MUlMbnpzR0Fzb1lQNHIzL2lmRThjcmZPQUc4NUdRbEdW?=
 =?utf-8?B?YzIwZGNlbjJEN1BOS1hpTERNanozS3dyKzd1Y2FJNXd1YWJvcGxpQ2JqNTlF?=
 =?utf-8?B?ZWg3TC85RUNPdW1tMWlQNHFLWEtmM1psb1E4Zm8zT1crQlN3U0tXN0JSMmlq?=
 =?utf-8?B?QnkzU2l5SUtCM0g3UkQwcDhjTHQvT3ZEN1FWWmxqeCtVSUx3Wk9KYy9odjJQ?=
 =?utf-8?B?TEtGU0tHbk1Qa1NCS3dEWjhIeC81NDZBVkRnTHFIT2pPb1hRYWt3WkFKdHUw?=
 =?utf-8?B?OVZhb2FGUC93aUZmRHYrajR5WGVCT3dxdVNSU3Z2a2lIaVMxSVl5VE03WDNp?=
 =?utf-8?B?akZaUms2dTlONzFFdGlTYW4ybGxvclFuczRtekh6UGY2WGFYZ2JzMjFpaGVZ?=
 =?utf-8?B?bUJOeTFRcGMzN2ZxUm02blBzTEdDTERLOXR4UlozanhHaHNsWWhWMkFsREZ2?=
 =?utf-8?B?ZHdjT2lWSTdsUVQxZThZNmhsaWFvT21UdDJTWFhGL01UVVZGNVZoSitYRXRX?=
 =?utf-8?B?SUF4SFJEWDZFenUrc1FHb3hha3hBbFVkblFDMHd2dkVlSFYvUDB0UUNYT1U3?=
 =?utf-8?B?ZERhUHBvak1UMjExOUltcGJXdTRQSjlvTEFYaC9mYVdYRjVTUmdFRlR3bU10?=
 =?utf-8?B?WWdudExwY1BucnNaOHR3UFJFTmRyaXM2d3o4QjdoOHhxeVBhazJvMXdIY2dI?=
 =?utf-8?B?QUFBaXQyRnNlWHd3MHFUa0NFZ204QlV0cFBwdk10NkE4S2tGUnlXSkpWdUZB?=
 =?utf-8?B?T3NuN2FtWXgrOXhKeWIyMWJTZTBjKzdjWDN0cjhoK29IMEtrRUora0VxU3dO?=
 =?utf-8?B?eGNlUVlCSk9qWWNpN0p5N2gydXlXcEJDWlR3Y3lMbnlFZjNxT3IrbWp4Vkl4?=
 =?utf-8?B?WDZRemp3N1N4K2FNWjlJUm1pZzloWmlvSzU5TVFpcHdhNnpwNFZXZ1hVWlRz?=
 =?utf-8?B?QXhuZ3JUcTdKZXgrbHF3YmVBYmpwTmMrVFpwL3hTbW5WM21QWkc3WTFkUVZs?=
 =?utf-8?B?aE1uOGh1eG1FUldsVUhlb2V0NDB0UmZjMko0cE9OcUVNb25yclQvM3RCWWRC?=
 =?utf-8?B?cXM3K3ZFYnZKdlcya1FLOGw3Mm1QWFlzWjdQeDZSbjJnMTdhRHVkdXBRaEdO?=
 =?utf-8?B?VlNaNHozSHRkbktxTGIxY1RxYTZCS3EzejUxMk5EZVkyby84bVNXRUhlK0d3?=
 =?utf-8?B?cnJFdEczcXhHNmVGZkQ4aEtTcHdEYTV2cHVNSjExV2JOZ1VWajhNeWNvRmE5?=
 =?utf-8?B?WG9yM3lkRUxSWDJvTnI0UDBSeit6S1RTM2VwSFBobTlibk9tbmRxYUdRbmRk?=
 =?utf-8?B?aGExUVZPS1ZKL2VrSHNMTkdvdWFXc0IvVFNmbE03dkVuNU8xV3Y3ZGRaMHFz?=
 =?utf-8?B?SUpWODFHRjU4ak9UNndOR0l0ZUg1YWE5eExtL3JmNTQ5R2kyeFdpQW9SNXFS?=
 =?utf-8?B?dmswS05hNnpDcUsxYjlEaGtGVFdJRUp3UlIvSTUrb0YyVkhFZjh0eUhidWow?=
 =?utf-8?B?azZ5cUdIZGhlTFdyaDg3VlVCbGpFZHp2aHdxTnR3b0VlY3piOXhSZkRoNjVK?=
 =?utf-8?B?VVhRTWRwWE5saWYzSFo0MjJkMmVHT3dzMGlibjJqbndZTjhnM3NObENzdjY4?=
 =?utf-8?B?YXhGcGtlTnRnWlUzbExoWllPODJTSjkxaFhsWWhZUVYzZGRFQW9Gdz09?=
X-Exchange-RoutingPolicyChecked: iuoDo6xHTqmfZVrOnLBALa4Shj/5gP5Jt7IuX239a327jvcbS4/IlSzldpsTHWPqpuTxhHsjNTdMg6dTzz8Hrw/5ZvZpO0T0WR8HGPA+8n9SHOisuEY8zjCkl+JcgkDNNexc500IVwns13M4u6yd59fk5IHXDBbLo/ffGrwqplzR+rMB5mot9o20TNdDb0C5kMICPiMri4eHHPm6q7ovuifZpYiXfzXWy9l3ntfDqX75HY19qu+71O648CLg2b7gpFgdpNW1Gyyepj+iuncKV73xCpqeu+kIVsYBAzXXYSKaElnncS2oMV4Zg8006RKXI2crpwZ4R9lK7GPB9YcyGQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d5a723-3b4c-400a-7123-08df155bc61b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5709.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 08:06:42.4404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jz1V29emDHMFyVKRMvmn5hV8sQORK8z1QZ4EPT1oKSmZ/hMsshBLxoj30MRI2el5iMYtpwxa0nxuc8o0bCfHnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6670
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

--------------I1DyKEPGu4GhazMUNsvNWcib
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit


On 18-09-2026 12:35, Thomas Hellström wrote:
> On Thu, 2026-09-17 at 22:33 +0530, Varun Gupta wrote:
>> drm_pagemap_dev_unhold_work() processes an unbatched llist of
>> pagemaps
>> on the system workqueue. This creates potential latency traps during
>> heavy teardown cycles due to two compounding factors:
>>
>> 1. The loop contains a per-item drm_dbg() trace. If dynamic debug is
>> enabled on a slow serial console, synchronous print latency scales
>> linearly with the batch size and can block worker execution.
>> 2. The llist can accumulate large batches during intensive unmap
>> operations, monopolizing worker resources without yielding.
>>
>> This causes below log warning:
>> "workqueue: drm_pagemap_dev_unhold_work [drm_gpusvm_helper] hogged
>> CPU
>> for >10000us 19 times, consider switching to WQ_UNBOUND"
>>
>> Fix this by implementing a latency mitigation strategy:
>> - Move the teardown work to system_unbound_wq to avoid tying up
>>    per-CPU bound worker pools.
>> - Add cond_resched() inside the teardown loop to yield the CPU during
>>    large batch teardowns, ensuring system responsiveness.
>> - Convert the drm_dbg() trace to drm_dbg_ratelimited() to mitigate
>>    serial console bottlenecks while preserving debuggability.
>>
>> Fixes: a26084328ac4 ("drm/pagemap, drm/xe: Manage drm_pagemap
>> provider lifetimes")
>> Signed-off-by: Varun Gupta<varun.gupta@intel.com>
> LGTM.
> Reviewed-by: Thomas Hellström<thomas.hellstrom@linux.intel.com>
>
>> ---
>>   drivers/gpu/drm/drm_pagemap.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_pagemap.c
>> b/drivers/gpu/drm/drm_pagemap.c
>> index 892b325fa99b..f8d5428f1750 100644
>> --- a/drivers/gpu/drm/drm_pagemap.c
>> +++ b/drivers/gpu/drm/drm_pagemap.c
>> @@ -986,7 +986,7 @@ static void drm_pagemap_release(struct kref *ref)
>>   	dpagemap->dev_hold = NULL;
>>   	drm_pagemap_shrinker_add(dpagemap);
>>   	llist_add(&dev_hold->link, &drm_pagemap_unhold_list);
>> -	schedule_work(&drm_pagemap_work);
>> +	queue_work(system_unbound_wq, &drm_pagemap_work);


Instead of system_unbound_wq we should use system_dfl_wq because 
system_unbound_wq is deprecated.
Apart from this LGTM:

Reviewed-by: Arvind Yadav <arvind.yadav@intel.com>


>>   	/*
>>   	 * Here, either the provider device is still alive, since if
>> called from
>>   	 * page_free(), the caller is holding a reference on the
>> dev_pagemap,
>> @@ -1009,10 +1009,11 @@ static void
>> drm_pagemap_dev_unhold_work(struct work_struct *work)
>>   		struct drm_device *drm = dev_hold->drm;
>>   		struct module *module = drm->driver->fops->owner;
>>   
>> -		drm_dbg(drm, "Releasing reference on provider device
>> and module.\n");
>> +		drm_dbg_ratelimited(drm, "Releasing reference on
>> provider device and module.\n");
>>   		drm_dev_put(drm);
>>   		module_put(module);
>>   		kfree(dev_hold);
>> +		cond_resched();
>>   	}
>>   }
>>   
--------------I1DyKEPGu4GhazMUNsvNWcib
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 18-09-2026 12:35, Thomas Hellström
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:7ee240d45896cf5f4845b4ca0740a307edaf83a7.camel@linux.intel.com">
      <pre wrap="" class="moz-quote-pre">On Thu, 2026-09-17 at 22:33 +0530, Varun Gupta wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">drm_pagemap_dev_unhold_work() processes an unbatched llist of
pagemaps
on the system workqueue. This creates potential latency traps during
heavy teardown cycles due to two compounding factors:

1. The loop contains a per-item drm_dbg() trace. If dynamic debug is
enabled on a slow serial console, synchronous print latency scales
linearly with the batch size and can block worker execution.
2. The llist can accumulate large batches during intensive unmap
operations, monopolizing worker resources without yielding.

This causes below log warning:
&quot;workqueue: drm_pagemap_dev_unhold_work [drm_gpusvm_helper] hogged
CPU
for &gt;10000us 19 times, consider switching to WQ_UNBOUND&quot;

Fix this by implementing a latency mitigation strategy:
- Move the teardown work to system_unbound_wq to avoid tying up
&nbsp; per-CPU bound worker pools.
- Add cond_resched() inside the teardown loop to yield the CPU during
&nbsp; large batch teardowns, ensuring system responsiveness.
- Convert the drm_dbg() trace to drm_dbg_ratelimited() to mitigate
&nbsp; serial console bottlenecks while preserving debuggability.

Fixes: a26084328ac4 (&quot;drm/pagemap, drm/xe: Manage drm_pagemap
provider lifetimes&quot;)
Signed-off-by: Varun Gupta <a class="moz-txt-link-rfc2396E" href="mailto:varun.gupta@intel.com">&lt;varun.gupta@intel.com&gt;</a>
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
LGTM.
Reviewed-by: Thomas Hellström <a class="moz-txt-link-rfc2396E" href="mailto:thomas.hellstrom@linux.intel.com">&lt;thomas.hellstrom@linux.intel.com&gt;</a>

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">---
&nbsp;drivers/gpu/drm/drm_pagemap.c | 5 +++--
&nbsp;1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c
b/drivers/gpu/drm/drm_pagemap.c
index 892b325fa99b..f8d5428f1750 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -986,7 +986,7 @@ static void drm_pagemap_release(struct kref *ref)
&nbsp;	dpagemap-&gt;dev_hold = NULL;
&nbsp;	drm_pagemap_shrinker_add(dpagemap);
&nbsp;	llist_add(&amp;dev_hold-&gt;link, &amp;drm_pagemap_unhold_list);
-	schedule_work(&amp;drm_pagemap_work);
+	queue_work(system_unbound_wq, &amp;drm_pagemap_work);</pre>
      </blockquote>
    </blockquote>
    <p><br>
    </p>
    <p>Instead of system_unbound_wq we should use system_dfl_wq because
      system_unbound_wq is deprecated.<br>
      Apart from this LGTM:&nbsp;</p>
    <p><span style="white-space: pre-wrap">Reviewed-by:  Arvind Yadav <a class="moz-txt-link-rfc2396E" href="mailto:arvind.yadav@intel.com">&lt;arvind.yadav@intel.com&gt;</a></span></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:7ee240d45896cf5f4845b4ca0740a307edaf83a7.camel@linux.intel.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
&nbsp;	/*
&nbsp;	 * Here, either the provider device is still alive, since if
called from
&nbsp;	 * page_free(), the caller is holding a reference on the
dev_pagemap,
@@ -1009,10 +1009,11 @@ static void
drm_pagemap_dev_unhold_work(struct work_struct *work)
&nbsp;		struct drm_device *drm = dev_hold-&gt;drm;
&nbsp;		struct module *module = drm-&gt;driver-&gt;fops-&gt;owner;
&nbsp;
-		drm_dbg(drm, &quot;Releasing reference on provider device
and module.\n&quot;);
+		drm_dbg_ratelimited(drm, &quot;Releasing reference on
provider device and module.\n&quot;);
&nbsp;		drm_dev_put(drm);
&nbsp;		module_put(module);
&nbsp;		kfree(dev_hold);
+		cond_resched();
&nbsp;	}
&nbsp;}
&nbsp;
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------I1DyKEPGu4GhazMUNsvNWcib--
