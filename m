Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180F4FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 21:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3073910E24C;
	Tue,  5 May 2026 21:18:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BvgJfn/p";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012041.outbound.protection.outlook.com [52.101.48.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ED2110E24C
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 21:18:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yn4+kLK4z91PB5B0fLIrIShA5FqEYIPRvDqauzGP4oEhvDuepmswzCD66I5+5TosSuUhiWDBlwK1gCIAJGGopplxTh5fDWFRsv8yqijUAbN6ejC4Q5kasnVzurjZ6j8wsesws5wr0eBmzkMYRZ0IZtpKUQQYCRUjLdNtOSXGrKRAFQMKVs5NBt8bbOMqN8IkES5rNjORxjJPzcXjJLOaMCikf48Joe4Afdsk4tybqv0eYI7tvOll4BlwASISIawyCnv+z74RkaBMWyC2bokq85m/YhUQpSYsKGPd+8wuPyr32cvRUXqJyIPFRLlEsWEB+wugG1XRQKlPp3TRxdQZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QPFO6nEAsRlqP7drnfYAiXnzqx4bjvtXQyYZhzMbFA=;
 b=D5nqRFqbkEZLYz3nyZk3Ub8JmW0g47hc5hqaWIKr+0MGaf99yo0AKonugAY+QQraFsvn6zBAZyiK4MOlWb0DjyBbn/QwGh2axfMAdmn77ajMIh63oku4wXMnlXDsceOMD7TuQ2sScw8RgULX4UZgvXT8eUeNf0bC4LmM+jaGeVUWRC57Rw0zq3yexCq+oSqKL50aAAr7qskJ0IJPZwrf7wO3at3EYAsF6w1OeyXkqBwS8K9gd3AZdS9Mz5xprq816LSVWLGTXn+cTXCBrfxSpSKAUNE4qT9Ey1stkluwtXvj0wj/dVFd6CmJDQ7M+8h/ZbZDtbTiaWiSmJsaomiTsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QPFO6nEAsRlqP7drnfYAiXnzqx4bjvtXQyYZhzMbFA=;
 b=BvgJfn/p/5M6cyWP1AlgmEHsjrAslLqrtHDMzZpG5o8Jz6MjIufMqNXPlV+G8jAd4kL4qBCmfBJagHnakZo2av2nd7TZeW6fXqc/moLNQZVyaR2sJ62VtMsJq7vWdq70YaVXOyKBcwGlNhH4HmUsMReZln+XR1QkCQQj9bdrM85l80Or68v4cSkH4LThSiy4joKvhQUazmUGqNW/AUn3Y6iwOlMJho4MsfTDffyQU5d0GyZaNuBWYGgVt91JqpXJW1aTIR68YL93sNwnC9nlAxibfojLiU3LZQ/SH1gxJg+Lh+PUjm5LEfk8YVAan7S0S1X+L8uHmfpVOv6JgBsgSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SA1PR12MB6994.namprd12.prod.outlook.com (2603:10b6:806:24d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 21:18:45 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 21:18:45 +0000
Message-ID: <3f1d7af9-f77f-458b-a44a-d2da5d2499d9@nvidia.com>
Date: Tue, 5 May 2026 17:18:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 20/22] gpu: nova-core: mm: Add PRAMIN aperture
 self-tests
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, Nikola Djukic <ndjukic@nvidia.com>,
 David Airlie <airlied@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 Andrea Righi <arighi@nvidia.com>, Andy Ritger <aritger@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Balbir Singh <balbirs@nvidia.com>,
 Philipp Stanner <phasta@kernel.org>, alexeyi@nvidia.com,
 Eliot Courtney <ecourtney@nvidia.com>, joel@joelfernandes.org,
 linux-doc@vger.kernel.org
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
 <20260425211454.174696-21-joelagnelf@nvidia.com>
 <DI8B0M0QY3XW.4641TH1BU4YF@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <DI8B0M0QY3XW.4641TH1BU4YF@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::16) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SA1PR12MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: ac868158-d1a8-4ef5-acbe-08deaaebe3ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: N/BzM0Tda/G3vMUI3fRQc53sbFpAtdnbcYJY5pECkMpyoN+Ks09NGom91Mom6eBK1qijgf/zBptl3zK3DihsNsgDirkXxj03b+NA8n64ipllDsq8eyzJShdy7RnBKOJPmu4eRhn8bAPtQ8p5GoaI+3rWyA9WgVNC0gYmbWSX0Whhs/sFWzFfIpdWENUmSTNaEG4a4GAWmpE5CPXeK+QtM7CjASwkAgWSv4d8A9/xS375z8c69uBcyCiAwx3s7iNY70sPXatR5X6eEpMk1BJiXAp5n04S8BQPiTklyOXwXxtPfE1e4WqBYDbtvQyJyQTtt7a2Pxu/2Tg2eu9pQ8sOuKE9d9yGEPQQHbTSLwyven6CJuXdxmtJEaayWRZhwLjCCx62aJjoSr18FriEIo9bAmQ6Q7FaGHdOZtcdCZC+6q9tw2u6hDbgu569xBYNcM/o9O9zC6vs+pvOy45HjATxV27rOKqieK8kpWgiVFrT3zEq2MBGxXCLE4kbmZskXnckhOnNK8LApoThfi7xKbIOw68jlGmBGqirzziv3Xbw28b7JNfLnW9adsLUELnwiYR9qN7Is/DhVZ7k+IumryzdKNCRjT40MxiARetH9J9ut7O+FN0J6mYf2BVQ9y8xl6h0JV5DyUo2QBbi0usuumEbmIAOHYGyITI7S0zoiysE9xNo3BL84JCiLhf/KTT9/8eU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eElJMDlkTzdaUlh1dlRrYmRFbmttU3luSmdMclp4UFFOV2V4UG4wZzExd3NT?=
 =?utf-8?B?L09QaVpoWk1hK2dldG93MEZsbldCY3pMT2JWRzYyL3ZFOUZnQXBlMXA1N016?=
 =?utf-8?B?cU4vQ250UnQrYU80TjNoTkRSbHBqTXhGNWdWTXE5c2RGZFNleXFtRm9nVWFW?=
 =?utf-8?B?Slh3WWNBMm5uSXVGVTBMaVB3c3dYbUY4UUdWQUQwNjFKc2d5Q3E3cEtmc3Vl?=
 =?utf-8?B?Rkx3cTNCSlFqeTE0ZGNFQmNORExxRFlBSGNQVnVTd3YvMEwyL1pEbWY0NERJ?=
 =?utf-8?B?emx0ZlIrN08wK0x2cVRhZnh3RURmSTBBb3RHbmVGWlYzK3JudTlmYk5Id1Jn?=
 =?utf-8?B?MXJpYnpybTUvcXI1U0M3YWgzZDMvRTdjSXlURWM1MUlHczk3N1AyK0tSSnZ2?=
 =?utf-8?B?YjB2SEY4TUV2TTJSUnNvTFQvU3pjYmJMb1ZpS0NpT2lQVkFmcjlnOGFkMmht?=
 =?utf-8?B?Wi9rTElsNE1ETnFzblA3ZVZ3UGd4UDlxNWdpU0VUQWgxalIzT2Q5aEF4bXRs?=
 =?utf-8?B?bm9wUzY4UFMwN2FDZ2hpTU03cjFkb3MzZTJadm9aSk5QZXAxL25JamxuaTlK?=
 =?utf-8?B?bDN6Q3hSZ3NOTzVINjJnd3JuTVc4Q0s1UDFEbGpPNVNIaktFRk1kUFFuZXdK?=
 =?utf-8?B?N0xhN2dGUm5maHBWSkNHSVkzVVdYbStjcUdHTjN0UDZvOTIzc2FDcTlZNGF2?=
 =?utf-8?B?QmR2a0t0VDBIYUIzRzV1ODRmcVZzem5GQ25IRGwrNndMODVuL2xiNE9MZTIw?=
 =?utf-8?B?dkthRnZwODJZSTMwSnlZTDFUWU9qakdjVUp0bjhZdldGTWl6UWZubUtkOFd3?=
 =?utf-8?B?VEV3TTRmSXNZZTA0VDRjenIyaDdLYXByUk5qc2E3TEo5SklnTVNwV0dkS1pr?=
 =?utf-8?B?Znd2VHd1d1B2cTUrRTRpLzdvYklZeWlxSUJxbDdxMFdFMEJ0MDNSZC9xS29O?=
 =?utf-8?B?TlFuRElqSy9TM0tGTXByVGh4M3lyb2dLUFVCdVRUR1JGakwzcUd3MnpyTWZq?=
 =?utf-8?B?R2pWSTZjVXpJWWxyK002cy9OWFB0dDVEZXM2WGNtUjJlNXFnUzYzaFg3cm5U?=
 =?utf-8?B?dytNTG9xNms5eVVmTlJybDVIOTJCMjN0NXJ0RndocENtM3Y0SVlaOWdDaTVT?=
 =?utf-8?B?Y01hRStKUm5XeGFuNHlDQWJsMDhxVXBwY3QxMlBlaGRXbE9wYUFVb09XNkNq?=
 =?utf-8?B?cFJrR0Y4d3FPeXFEdGZaRGNIWko5Zk9CU2o0bzZIOWZDclR0cmZPWlRHTFpw?=
 =?utf-8?B?VE8xdHRVVTV3cXlIUHFVbmQyK2dsN2J5NXlvUnZqK0RmaS9mYUQ5SVBVVFg3?=
 =?utf-8?B?RlZJVFZqZE5xTmRsbk5XekdDT3FTeWlXMFdwdlpEazFIWkNKWDFsdlk1Q0JS?=
 =?utf-8?B?TVo3OTNocWdsaFpOZzlnYVdHbEFaRnRvQ0phVDNqQmZLNHlTdHMycHJIdk9w?=
 =?utf-8?B?TEhYMUxPMjZWZ0lKUzdQcjIxMGlGdjhoakg2M2xyWlpZOXFGc3N4UHA1dEM5?=
 =?utf-8?B?V3UrSEpBMTJJR3JhZVFtU2drdUpENW5xa1hnTkwxSmEybGN4SSt5c1VJK1BX?=
 =?utf-8?B?Qi81c1JDTWRCdEtxQnZOK0pNSUhqTzV4d2JJUFdtMzNqaXg3WGtZY2xqWFpO?=
 =?utf-8?B?ZmxlMDBncEM2ckxnZ2gyQUV6SG4rR2tvd2tLeXhpcVh2dmdoeXI2dDBTenBR?=
 =?utf-8?B?M081d3UwNEh4Y0VGMVdkN2hKNGJhaUZTditnVVRxRGtEZ0IvSUh0cTkwd1RP?=
 =?utf-8?B?MkQvOGswbFFYUmJZcm53Tlo0YXFPZ29hai9hd3BrYkp1WmRoMndFb21MVEow?=
 =?utf-8?B?NkFoTDR0alFwT2NQMzJNaUdpU3hpQ3E0bWxYQWVybjZSV1FPTEIxQ0QvZEk5?=
 =?utf-8?B?cFh5azAwYzBEUDZ1UnNPR1l6YU5sM1M4ZXFxZnIxSDVvanJHNjRHUkt0SlpS?=
 =?utf-8?B?YXcrQ2VUcG16YnVvaU5IRVlzQVBMMmhhVFJEOC9DKzM0VThDeXJIT3FJZDhS?=
 =?utf-8?B?Wk5CNzJ1Szd4UkJiWGc2ZTNJa0NyR002Y2MvZktnTEpkTHQrMjh3VWZrdXl5?=
 =?utf-8?B?VXR3cEZBT0ZQN2QrbE5CYmNZZFl1V0Irb3g1Vk5ETU5ZUEFwWkEyNWpMWFlF?=
 =?utf-8?B?SGhLQmphUmt0cXlSU0d6QWhiMWJzUlZFVXhvdG5IVjZKZVBvd0lTZi96clBv?=
 =?utf-8?B?K1hObVlOYStXQ0k2RVI2bTJud2RSUnhzVGlXSXFDYlFkNGZCcDJJUVJwd0t2?=
 =?utf-8?B?ZTFFQVNTdjkrOXZkVzJoaXg2VlllZG9PNDRlV1I3TFN3QWhYOWNwT2dBYTdS?=
 =?utf-8?B?TWlzODhVL1VIaGxWYXhKUzhBbE5hazdRVGNKOU9IbGJpbmRsZ1h3QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac868158-d1a8-4ef5-acbe-08deaaebe3ab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 21:18:44.8702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIPWRagtrSAI7EHoeQKb9VEHaQrh9O97YKIb8EWXGv7oe4oJ5fkiss3EQIKbndzNH/JZjPOvmwHkPbs+X3kf3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6994
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



On 5/2/2026 11:42 AM, Alexandre Courbot wrote:
> On Sun Apr 26, 2026 at 6:14 AM JST, Joel Fernandes wrote:
>> Add self-tests for the PRAMIN aperture mechanism to verify correct
>> operation during GPU probe. The tests validate various alignment
>> requirements and corner cases.
>>
>> The tests are default disabled and behind CONFIG_NOVA_MM_SELFTESTS.
>> When enabled, tests run after GSP boot during probe.
> 
> It makes sense for the PRAMIN self-test to be merged alongside PRAMIN
> support (and also gives us a reason to merge PRAMIN as soon as it is
> ready even if the rest of the series is still under review, as it
> exercises the code).
> 
> Can you move this patch right after patch 4?

Sure, I will do that.

