Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68422C61DCD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFDCF10F30C;
	Fri, 28 Aug 2026 09:12:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tO2N5rIX";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011029.outbound.protection.outlook.com [52.101.57.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D459110F309;
 Fri, 28 Aug 2026 09:12:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYIjd2OXQTVnhwkNvFxk1bslaEHSgw8TFQDHsnPBmx15BVjUPq6+BD8ZkundCYPqGVuVPYrq+WSyyN+LjrfSt4JH+Lcn93ldcns+u+pIaaqbieqelLUqhv/i++rm0RQ08ygm+zBRkWk3hPNyEVPIz7MNjNOFFGDAOKF9ozag7NoWQWi9L7CoYLEvStx4E8NUdEIzPhV1ErZkfO6gJVvaNJG8BpDnaZWCXsORwkNwcGP7ZKY/dKvGIA3+vhVqfcTOOgmsT55VRampCGmi3BbpX7miY3Iiv6IrRQtuyObOPfNEuGsZIZQcGAp/ZIWgN0x4Gmfg+E+KwKlEpk8Zyx0yow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rf9/NjLbe0yq6rGc6UQYe6b1rciqWHr/iG63zHowHGM=;
 b=qfILXNfzJGr8anICfXo6m+Cj2La90P4KX7rcEQDEAjpq5xrmj0U+S2blZbfZ//LlksEEkjKeuGUoS0OdMy/rWssM+RVAow/Nt209fsZSyFJrGN1HpRJia9nM1zzPl0evALqr0Ik0/jJQAuNzUsBpkvR+vTuzpJds+zjGf+iqAIhtzerF/rqoBO9Qa1DwUnzSd1PcDM8+JSh8VYPBFz7PCqMVgjqi+XHLYvx8p5SXt+SlIh0POCDLq3/Gap4xVYrsa4s8vYfGjNrad9hYPZ8jP7rOPtfezFwZiWnWjhpYkHl4L+QzvMPqNL1+moF4KwRlhPM8Rlic77Vm8wfpICelXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rf9/NjLbe0yq6rGc6UQYe6b1rciqWHr/iG63zHowHGM=;
 b=tO2N5rIXR4EXi8ru/+l9/sIZ6ZDjEepAsP8dZOVDpet3Adi8N/R9PsWV94bd8uVPjRQ6iAw+pBGD1XfwR+MMOvEConf49jA6vvz/dbwZTZNQU2gvZO0AItJfpNkFoGlEW/otI7UJUAwYnHK5sESNHE4k4Mi9Mz5Z88UFxahfiN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6883.namprd12.prod.outlook.com (2603:10b6:510:1b9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Fri, 28 Aug
 2026 09:12:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Fri, 28 Aug 2026
 09:12:41 +0000
Message-ID: <99a34ffb-b702-45c8-aa0c-129442841c2f@amd.com>
Date: Fri, 28 Aug 2026 11:12:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] drm: Add common drm_user_fence helper
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 Matthew Brost <matthew.brost@intel.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260828063103.4106629-1-srinivasan.shanmugam@amd.com>
 <20260828063103.4106629-2-srinivasan.shanmugam@amd.com>
 <apE17lJZmTD4+5jR@gsse-cloud1.jf.intel.com>
 <IA0PR12MB8208533952E71C3153ED308190AC2@IA0PR12MB8208.namprd12.prod.outlook.com>
 <1ea90a49-ec2f-4150-a7e2-4f645ef3a98b@amd.com>
 <IA0PR12MB820813A9D08CAF799558FB5A90AC2@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <IA0PR12MB820813A9D08CAF799558FB5A90AC2@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0281.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6883:EE_
X-MS-Office365-Filtering-Correlation-Id: b3dcf4d3-4e11-4aeb-4fd8-08df04e48383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|7416014|56012099006|11063799006|10067099003|18002099003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info: UzB9XEcQZJ1TbmU/dS6Xv8ejZ/cSBQGDB0whDJV5XUYizOhN5Hcx9lCalgJjq7WzAgqG9xf+KSdANNh++834R1Zb2b/JNy9oM7QX5+e3BN7KltHkuBlDFqos5BhomVK5gJkkgVQNcwWnzwgrqhzxW/j8ssLbIUYYNi/8UjbYjxubCLGNVyFTrke2l18oojyImmgQXykU2Xmq76xswMTQmajkEtDCDL3LzLR+02977CKVmzSKK9DeER0vs0KqncS/CAQl0jp4BziORQ2LXTFG+xqAcAI06ZPXpghCqPmNOZrIS2vT3RJt0wWdfkPVxPec6WRkYD23TfloMI/uVhvYeOMyFFFPLNbV4KyFP78BfjXE1V8y/iVWjyLLXcJIhj0MN/2Ent+ubyOsg1o84mY5mUMmOuqLvIVEQ/0wluzsVG83rhAEiCq4a/u9BMBQnqMIcXKjqtfQDqOkBFLC8rKmvFTkh2cE+iPO3QeqCFsVrbWbWeceLoBdEap8FvxSjW/8nCf9YVHlMnEkGnSRI248oeh7NG9HbBbD29CSTFNqAOi9+/b8Mwaqtz2GJOWgLZGf75R/XS6qQxexzwMQhg5ld/m0391XisvY+4cV/jIijcMkcBEih2w3fljj8Z3G7QLe+5xkxse7bOA2D2TWgfzYTWXxaejRAZsM3oZZwQoOLCo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(56012099006)(11063799006)(10067099003)(18002099003)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eldjbU5ZSENZRlJ4ZjNGd3l6MUlhTElGRUtWNW41VkczTGw3VDlVYm1iVXUv?=
 =?utf-8?B?enNCeHFZOFdhZlRYYjZjdi9wUExjbDdMQnRmWE1hTjh6ZENYcEQ4RjdwVWtX?=
 =?utf-8?B?OG1Yd1U5MmgrKy96M1F2NkZPZmhObVA0NGphVFhSUCtuSUhnOHBqYTVXbmts?=
 =?utf-8?B?ajE1YnlmdmZVMFN1SE54NWRYUEtiLzM4SExadk9WdXR6d2YxTDZBRUlQMm9t?=
 =?utf-8?B?Nms2ejlaaTBnQWhPTkdqOEorZ1c3RVNyRXJBZTFLdUpFb0gwS3FwZDV2QnpV?=
 =?utf-8?B?dEN1Mzd6TDIxU1NpdWtMSFIzOXpRMENCNWpacmJZVjdTL2M3L1pKRVFWYm9y?=
 =?utf-8?B?V1JMYmRWbEEzYksyZ1FBdUs3S3F3WmdZeTgveGxpMzNTRkpwbEY4OE5tUnJW?=
 =?utf-8?B?U1BQUGd1ZWhPblFpVFhZZzNpVldrMTliSk5rWW14MGxvSDJFYWpZUDZ1WGxQ?=
 =?utf-8?B?eFNYb1gvVnBBWGxtY1p4THkra3Q3VVJiU1dXNHUxRGZ6TXFoOTBpVG9RVmlY?=
 =?utf-8?B?Sjd4bTh1Wi9RRHVJUCtTWTAyYzJ1Y0VOMjFTdVh0NzlDRzdoRXdXT1ltVmJl?=
 =?utf-8?B?RENHOFFOcFZZVmdmOW4yTHRKWXR1UkJMQ3ZoMjFwNktSa1l0T2xGa3hXekFs?=
 =?utf-8?B?Vm1pZEhsYXhtU1JjYVJtZ2lvOVc1SFFGQjRUSFhWcnNsK1Mya09tYVg2NzlI?=
 =?utf-8?B?TDVCNk1NajR5dmY0cElJTk1ySFJTcGluRjNBZGZtaXNHbHBkenJFTG9zaFFI?=
 =?utf-8?B?UHpQenZqcVFIcHMxbVRmd0lrZm16OUhsWjQ1UWh6Y0JBLzR3aXFPVnd5NWUz?=
 =?utf-8?B?dTYzTW1CWWk2aFVEWmVPVW1qZGxiNGJFN0xnYVNMZ1dNMVhIczJISGtDTVUw?=
 =?utf-8?B?MlNjRDNJOStvbGxqZEd4RXFyVk9TQWhDb1pma1BEOFdYSzFWRytBZmltQnpt?=
 =?utf-8?B?ZlVuYUtXM3FWQnF2c25SaUtxZktqZW5kd0xES2hRQ3ZUUG5TYTMva3ZLN1p4?=
 =?utf-8?B?ZEg1RHVTZ1FXMkc2MUduVmlGL016UlBlYmZZVldINDJnUzZFTDM5dFZaWUZM?=
 =?utf-8?B?NkJHYXRJM0pTK3hqeHdyVThTU290THlvd2JQbDl3TVJhVEZkbHdJVTZUeVEy?=
 =?utf-8?B?V0NFQzd6S2hTWUJTQ0JiSXlic21vK24ycmpwTGxiLzZ3cWJXRGtjcUdQZVlr?=
 =?utf-8?B?OFhsVWx2Y2xEd3hZa291VlNyTmU4d09lZjArcXlONHVEakIrdzlLTTdGQnRR?=
 =?utf-8?B?U2U2RmZYVEM4NndiZWg4UWJsWXpweEZnbkNwdFh5Z1pNTWM2cHU5VHNMcjlI?=
 =?utf-8?B?Y1hlNVdIQTkyWFJxa1lqajZiY2NxTFltbDlmQ0I2VWFRclAwQlFtZnlGMkI0?=
 =?utf-8?B?Vm1IWmRMRTRuNlVFT01CY25yN0NPZnRLTllDejhNZkZ1K09KQ0h3Vkx5MDdy?=
 =?utf-8?B?YkJyc3h1N3FSa2JyZE11cy9EQVRMZkdlMXZMN0tyUE9GZEo3WXM5UnZIM3Nh?=
 =?utf-8?B?d2hqS0ZId25EaVBXRFlyYUNkU2tCMUpBT0NUWmlDUzZacHRZbVpZTzl4TjRK?=
 =?utf-8?B?MFlNbnNyRnRTNktWcmFGQnpKUkNLS1JycDVXaklRRU1KRXB2VWlIWXhxakxB?=
 =?utf-8?B?cnR3clFkVnJ4K2p3UHR5STNnUStzZTF1MVE0N29uRFl6OXFwQnh0SUZ5MWhw?=
 =?utf-8?B?bnRPK0hUWk9qY1ZYa0tpU0FBVHFTRlA4Q2RPUmo1WDBJcjVscGJOQzBsek9J?=
 =?utf-8?B?UXVnU2NEdWRnTjg3TU5Oc01YK243dUdNeFIyamE1ZDJrdlU2UTV5WHlnaHo0?=
 =?utf-8?B?OWJodVJodmJiNHRBUTNoQ2ZnYXZGcU5qYVhYaTh1K3VrRE5ZRjVhYkFoaUUv?=
 =?utf-8?B?Um9QaG9tL1hURkJJaG1tb2hGanNDdk5yMEJzNkloV0xzZGh1YnRhNlRpNkEy?=
 =?utf-8?B?STZMQVdYWUhNTFhiZmVwMFpCMWdNMTdWMlEzK1RDMWFUaVVTblM0c0NnK0Rx?=
 =?utf-8?B?K3o4VXhYSklSckMyTHFDUFhZTVpHSU01YzlOUVV6ci9JTVZvUHltWkNoUHY0?=
 =?utf-8?B?eTBvNXVuamNDa0NCMmxtTURuelNHbzBHUnBJL0srYktVOHd6RFVxcmhjY2JG?=
 =?utf-8?B?ekg2ZGlKa2xNR1lmbHlnMi9uNXlTdm5NcGxjbnZ6dXUxTWhrbEdGb0NKcmFD?=
 =?utf-8?B?MXVRZzkreXlUaGZ3WUQzdVF6UXBzYXVsS0hHNFJzeVVNbmxFbDNZY1FzbGxL?=
 =?utf-8?B?VXBlWnFqOG12VHZCWEY0dWt0MVBKWDFpR0twRDNNWlRaTzVrOWljUXhIdi8w?=
 =?utf-8?Q?1Mi7X7/CypyNqbafQW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3dcf4d3-4e11-4aeb-4fd8-08df04e48383
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 09:12:41.6944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xApinwDhbDbbo8iCuW5nSA61rg/zqypOJzhknepSsr5bJSL0VDmIbQs10YcsGDC8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6883
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

On 8/28/26 10:31, SHANMUGAM, SRINIVASAN wrote:
> AMD General
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Friday, August 28, 2026 1:48 PM
>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>> Matthew Brost <matthew.brost@intel.com>
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Maarten Lankhorst
>> <maarten.lankhorst@linux.intel.com>; Maxime Ripard <mripard@kernel.org>;
>> Thomas Zimmermann <tzimmermann@suse.de>; David Airlie
>> <airlied@gmail.com>; Simona Vetter <simona@ffwll.ch>; Sumit Semwal
>> <sumit.semwal@linaro.org>; Thomas Hellström
>> <thomas.hellstrom@linux.intel.com>; dri-devel@lists.freedesktop.org; intel-
>> xe@lists.freedesktop.org; linux-media@vger.kernel.org; linaro-mm-
>> sig@lists.linaro.org; linux-kernel@vger.kernel.org; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH v4 1/2] drm: Add common drm_user_fence helper
>>
>> On 8/28/26 10:06, SHANMUGAM, SRINIVASAN wrote:
>> ...
>>>>> +/**
>>>>> + * struct drm_user_fence - embeddable DRM user fence
>>>>> + *
>>>>> + * Drivers embed this in their own structure and implement
>>>>> + * &drm_user_fence_ops. Call drm_user_fence_init() at creation and
>>>>> + * drm_user_fence_add_callback() to arm on a dma-fence.
>>>>> + * Call drm_user_fence_cancel_sync() before driver teardown.
>>>>> + */
>>>>> +struct drm_user_fence {
>>>>
>>>> Should this common layer be split into two distinct concepts?
>>>>
>>>> - drm_work_fence: 90% of what is here, minus the kthread_use_mm() and
>>>>   mm-related code.
>>>> - drm_user_fence: a subclass of drm_work_fence that adds the
>>>>   kthread_use_mm() and mm-related code.
>>>>
>>>> I suggest this because I was thinking about it the other day (I
>>>> forget the exact
>>>> context) and reconsidered a pattern where a fence signals and then I
>>>> need a worker because some work must be done outside of IRQ context.
>>>> A user fence is one example, since copy_to_user() can fault, which is
>>>> not allowed in IRQ context. At various times in Xe we've had multiple
>>>> patterns like this, although at the moment user fences are probably
>>>> the only case that requires it. If we looked across DRM as a whole, I suspect
>> we'd find this pattern open-coded in a number of places.
>>>>
>>>> Yes, drm_user_fence would be a very thin layer on top of
>>>> drm_work_fence, but I still see value in the split.
>>>
>>> Hi Matt,
>>>
>>> Thanks for the review and for being supportive of the idea.
>>>
>>> The split into drm_work_fence (general fence-to-workqueue pattern) and
>>> drm_user_fence (subclass adding kthread_use_mm) makes sense. I'll
>>> restructure v5 as follows:
>>>
>>>   drm_work_fence: kref, work_struct, dma_fence_cb, stored fence ref,
>>>                   wq, ops — add_callback, cancel, cancel_sync
>>
>> Yeah, this pattern came up so often that I already considered adding it to the core
>> dma_fence framework.
> 
> Hi Christian,
> 
> Thanks for the feedback.
> 
> On dma_fence_work: would you prefer I place the generic fence-to-work
> helper directly in the core dma_fence framework (drivers/dma-buf/),
> or is starting with drm_work_fence in DRM and promoting it later also
> acceptable?

Maybe ask AI to search for use cases. If you find something outside of drivers/gpu/drm then please place it under drivers/dma-buf.

If you don't find any existing use case drivers/gpu/drm should do as well.

Thanks,
Christian.

> 
> I'll add the value comparison logic and will add a clear note that this cannot be
> used to implement dma_fence_ops.
> 
> Thanks,
> Srini

