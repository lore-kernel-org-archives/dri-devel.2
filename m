Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6EFC624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:37:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C50B10E66B;
	Mon, 31 Aug 2026 07:37:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nEI6cl5/";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010069.outbound.protection.outlook.com [52.101.46.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43CD610E66B;
 Mon, 31 Aug 2026 07:37:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ji6GhECikTUI8PGMSZ2dgbSzDwI8KDs3Swr9+pUxhOQwtXtDM4PpKuBpj7lUzw+2z8//UbE1koDTNHXMYkJ9fbGFlJwObwv93fGJsDj+ZJn21urk7t3ILWJDxhovd7dBxL9o7if+Eur1yOlaZHS7UZJ8llNB2hZF5yg32G1QKkGxtDLpjGQGBzW/mdewANckB8bKXdqrkPx6VI9Y80JxiK2iuC7fPd+xaE6S28E4tTQs+RZ2kYJgPI+Vja/mRC0pmd8Fl40tcLZTI27sMok0IRyBXDfDotKO6GFiug48rucfUyN9rBoCUi4aztp+PuZOdpYc1SDm1i+1fFwT3+9EKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npY1bQO7qbXC1p5nUi+mlLlps32nRVoS0FIWiypX+TI=;
 b=s/lVFQ1YXAFbj0RwwMHFWLAa9RDcfY0/Qt4zNGAQK3QB27n5a0RSjAD8qDi2SrgUQxJdcBDEvyHMe1iMK5ioP5qRfJJxiiuSjADjyfRzLSazAqlBHvhfcXNSvMCF1ArJMdgEnQ64Y/zmZZTiz9bK5SOMtRtijxxkY8lNoiKKkDOF9zMb/LNJLJDTNfdCBVXy2eV+KuydUefUJchA2ssXcl42x6gHRmLxt9VNPBCSz86WgPX0ySk0bKFrSTrEJzcTgt1B9jxhT4rBBkcOMKKvThpaibj27XVc81UaIdFqz+6L11f7AfqsnEBilyr1guVwa0p6uiQbtvJhO7xxplxFXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npY1bQO7qbXC1p5nUi+mlLlps32nRVoS0FIWiypX+TI=;
 b=nEI6cl5/bB2+vEmwnyjD72IX0ecU6ydu8UAqVQDo5itVvEf77s7pH8XO+kcuo5t3VLz62weXO6Fa8pauvCPsE6UmhJh1FAWZIoeT6Id7NkPomDpQa1L9SCm2duBJfxI5pqTxxuj9VFScWzjDCR7RJcz6y/RGge74oO/jXBnxdQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8838.namprd12.prod.outlook.com (2603:10b6:208:483::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Mon, 31 Aug
 2026 07:37:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 31 Aug 2026
 07:37:14 +0000
Message-ID: <c359b608-c6af-4cb8-a750-a29b5b26180e@amd.com>
Date: Mon, 31 Aug 2026 09:37:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] dma-buf: Add reference counting to dma_resv
To: Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>
Cc: christian.koenig@amd.com, thomas.hellstrom@linux.intel.com,
 ecourtney@nvidia.com, nat@pixelcluster.dev, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
References: <20260827124910.2245-1-christian.koenig@amd.com>
 <20260827124910.2245-2-christian.koenig@amd.com>
 <DL0SABOU2QO9.20AA8OP9CXXA5@kernel.org>
 <apHe5YcWWiZF4i2Z@gsse-cloud1.jf.intel.com>
 <apHiw91fFbKuogDJ@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <apHiw91fFbKuogDJ@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: f947525f-e1b1-4ede-2755-08df0732ad39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GIWC3Vl7hC0sSIBPy5I7rR1i/u3XcYwk125E+WkQyDUfa6oPOxdMKopVml98LIWV9bPuVQ7QJvis1bOK9Lt63VwMwkrfRFnX1jtTA8KcyNOQw5ZK8dgL+WzMmQllLI4z9/RyqmaeoWupN8GIBZqhE/EwhNbB1CwR/mw/tE4muBUC0XDomneMBl24rWbFJlxHr5ae4ZfJPErh8QiNRWC8MN3R0ndQ65YqtlhyZHmRPs0L09Me/R06WPZYiTKDwUjutiGMjtwuNfsv6hWiztRALiONQ2CG4Iz5qy9JxsXXZ99djxF+70ylvx9nt+Inx2DGl9tWWLA3Vrh4gynoaD1KSB7iA8I87gXxcf5I084/Msv+RaBNU1US7fELvXuKd7a8eCZwTk59qIulSVwhsDu1mq6M1oikkgz9NoQDfPVQjcqRbIr19gNBk/M9h1psVcHaowxMLIko+YZZXVImdwo5VmWkHI4Tv0VKdxNXTUdmc3syHIxLpQo9iHDUs5QftEHgkfthdyBy4+wcS3qD+Ot61vg5PAfgodbmvkB88GQeaXKHkat7PhPpl30+uXWVphnZ6BOpyJgtbiBC/hUG2uGeFZtXHe4E/SbkY4LIwp6iGJJZmzuCQzJ7wMtXUuFDWkZd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzY1Z3c3bXlkbWtUeFJPbFA0WXFDc21TSmxHejNuMXdaYm1pSFpFZkhGamRS?=
 =?utf-8?B?dmNRZHNZWEFGY0J4Y3hwMDVpT2MweDZIUnp4ZXFacFArUVc0aFZJNWUyZkZR?=
 =?utf-8?B?VXBKcWQ0dE5jRHFoQ0J6c1pPLzJZTEpVbnRQOWFGdUpaaTNlYTFGYmVSNVZD?=
 =?utf-8?B?NlZHNEZ5TTJyU0d3ZFNaMG9kQ2EzVmlIZFlxWHFLUWg5bG1aaDZBdllsY0ND?=
 =?utf-8?B?dHlZSmROdHFYL2hrbWIxYUNBSUhBV3BTbmhKcmFJVVNjeFZMSS9QMklRYm1P?=
 =?utf-8?B?azErVDJ0R2lsTExDVjVFY05NMHJ3alNxb3M2Nm5nN3ArcTZaVG5DYU9zYXFt?=
 =?utf-8?B?VzVSc2hMTkxQMFBFV0lSM3NQTFhEdmgyanJwWUJKclF3b1VYbmNsVS91NDEx?=
 =?utf-8?B?eVNDS0F4WXh6azlGRm5jUW1nSWhCdmNDdjlqL2lPQ0dVNEhGdTdLRUFTdmwz?=
 =?utf-8?B?M0kwQm5vNVFWNmNpaHVaOS9XYzBKaE11ZS9wSEpUTlpQVmMwZmJDdyszMEIv?=
 =?utf-8?B?ZktueFpJbjN5eGk0OTNnZVk2Qy9iZEFSWFR0Y2dmZHNQK0N4TzlHQkl6M0Nh?=
 =?utf-8?B?QXo2SWtwOW1NQjc0eXJkYWd2ZGV0Y1JETHlHd2VPcUx0MXJaUWg2R3RWZUFa?=
 =?utf-8?B?cWtBRHVhbUJyNnU4Lzg3RStOelRlbFJLSWxLeVFId1RPM1RRZ0FNU1NHTnZ3?=
 =?utf-8?B?c2Nha29EV3NUTlF4OHJMZlhBakNnWXdrdEp1OHdnODZXYUg5cW12UEJDdWVU?=
 =?utf-8?B?RXdZUlFZenZka3N1Nkh4bWZUV29PSGYxSHlld0RzOW5rL0ZEVEZPck1WRVZI?=
 =?utf-8?B?SFY4WWwyWkZuVmMwcXZUcXVrU0xhM0NZNzgvbS9QN2dCZDhvUFhrOVFzMTNO?=
 =?utf-8?B?bGhSWDh0cnZBbkxkeUFTbVpDd3RmMjIyWWluL1VQcHhBUEs2UTJrZU1lNi9H?=
 =?utf-8?B?eFYyNFo5YnNwVWJqN25uSklKaFk5bmM2UlljbjFZZE5QNXNab0locDBCV0Nt?=
 =?utf-8?B?MFlVSVpKakI4RW5IQ2FZMGFhTUZsS2hwS3dLbnpNZHF3K0hkNWg1azFLY2xR?=
 =?utf-8?B?RUZZUTUwMEdIUTY5R0VFM2R1RG80Vkw4elVEMEJ5emRqeU5ZR21ST0hrNTNE?=
 =?utf-8?B?Sjd4VmRJdUd3dlNOK01TRVh3QmFUanJDcnA4QWVsVW5EUWZPL3dvbFhzb29u?=
 =?utf-8?B?emQ4d1pEOVBtdGdCV2hDZlJ4TkVUcnkvRkJYWGFPY2JnMEhMME9NY0xLd1l3?=
 =?utf-8?B?Umxrc2k4Yk5Kdkxjb0hzdFlOMHlGbzM1cm9hK2gwNWh4UjRXcmUyUDNGbTdm?=
 =?utf-8?B?WjFpb0RuU1JkZkhPL2Fva2Fmc2NEWFBpczNKazN3cXpGZ0Jtb050KzRpckcr?=
 =?utf-8?B?SS9FYXUrQ0tRd2d3VEl6TC9kcjZjaFRuWS9zTk9oeUFTd0REVmVja1Rjd0J1?=
 =?utf-8?B?dmtXbTZwYXkxNUl2Q2F3WGgydVMrNDMya2hNT081bnQ0emtRYnVoS0Fqb0ly?=
 =?utf-8?B?SDBNMGh6UDNsWmNteWdBSDlJa0ZJVkdsM1Nqc3hDMlFBaldBSnc0dmhiaWF3?=
 =?utf-8?B?eWpFbnVNM3RoZnhXUzJXTUtLQUZtV0crdDIvWWpacXg3bzg3enJWNUs1UDBN?=
 =?utf-8?B?MzB0L3Flb2prbDhwOTRkWGx3dFN3VzRuRC8vUDZ3VTZYS0hSVW9mREFYNFRz?=
 =?utf-8?B?T1ZJZWVZVUxiS0Y2aXl0WlR4ZkJwSjVNTUlzNlBudWtFOVl4TzZMR1NMOHNL?=
 =?utf-8?B?SkZsS2xpMExYd3dZOC9RRjd4cW1vbC9PcDVJQVAzUjlwVHlJV3hBcFRJbElN?=
 =?utf-8?B?QzFram5tRXpJbHc1K3pNVjAvQnNXeFBDRW9ZeFZUSDQrUU9sZ0h3VVY0aTQr?=
 =?utf-8?B?WFN3VnhzRXFhZkZxb1FmajN2SlQrWndyY096ZkcwRnNwSTFhUGpKVHZEWlIz?=
 =?utf-8?B?ZXJFRUVnRTVQZU4xVXE4UkhVL0MvYjFzbTFTOWF6MGJweGNHYWUzMElJcHB0?=
 =?utf-8?B?TGZIK2tyS3p6dGZqRlUwb3ZnYUo0cjZnbnRwT1AyNmQySThHMXMvL0pObkdq?=
 =?utf-8?B?K254eVJzbmdXY2ErcDRVa3JNU2xSZDFoNWdxZHdnNTRIbFlGTmpyK2NDZTVE?=
 =?utf-8?B?cngrVnZkeE03T3BvWmRlZDdpblRTbWJ0V2VEbXN2TzNZdFdIQXRwVHhmNGhw?=
 =?utf-8?B?Ty93eE0yUkc1UTZFaG15bkVqeEp2dWQ4SVNOMGc1QmxDWnk5UGg0WTBzaDYr?=
 =?utf-8?B?OHN0Rlg2akRWMlB6dWFFZHpxT3hVSzZyM0NNck5sMTJ3MFlZMVhLRHE3YWZW?=
 =?utf-8?Q?bWaLO1iE4WC+RDT02e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f947525f-e1b1-4ede-2755-08df0732ad39
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 07:37:14.7018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8boiKH0yCGCBpPOv5NPwk6QhYoA9eLDcyC3xPLNfmz2a9mGdO0Ze8m5PQPibeya
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8838
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

On 8/28/26 21:34, Matthew Brost wrote:
> On Fri, Aug 28, 2026 at 12:17:57PM -0700, Matthew Brost wrote:
>> On Fri, Aug 28, 2026 at 08:21:17PM +0200, Danilo Krummrich wrote:
>>> On Thu Aug 27, 2026 at 2:38 PM CEST, =?UTF-8?q?Christian=20K=C3=B6nig?= wrote:
>>>> This provides clearer ownership semantics and makes the code more
>>>> maintainable by removing the embedded allocation hack.
>>>
>>> Again, fundamentally disagree; please see [1] for details and reasons.
>>>
>>
>> I think Christian is doing this incrementally rather than as a single
>> change across the tree. The last patch [2] in the series removes
>> `dma_resv_init` and the `allocated` flag. I believe that was the main
>> concern, and it appears to be addressed now.
>>
>> I'm taking the series for a spin now, as our CI [3] had trouble applying
>> this patch. I'll let you know what my testing shows.
>>
> 
> I ran our basic CI suite and didn't see any regressions. I also ran some
> eviction and shrinker tests that stress interactions with active fences
> and exercise individualization paths, and those passed as well.

Thanks, that is exactly what I wanted to know. The whole patch set was AI generated and I still distrust its quality.

The interesting thing is that most comments come from Sashiko-bot, so AI is now criticizing the quality of AI generated code ^^.

> 
> Matt
> 
>> [2] https://patchwork.freedesktop.org/patch/748868/?series=172875&rev=1
>> [3] https://patchwork.freedesktop.org/series/172873/
>>
>>> Besides that, I don't really know what to expect from the series. The cover
>>> letter says "Refcounting dma_resv v2", yet there's no changelog telling people
>>> what has changed since v1. On the other hand, none of the patches has a v2
>>> prefix, so what is it?
>>
>> Yes, change logs / cover-letter would help as Danilo likely could have
>> spotted the above change.

Mhm, I though I added that in the cover letter.

Regards,
Christian.

>>
>> Matt
>>
>>>
>>> [1] https://lore.kernel.org/all/DJVRML4G11GZ.Z7FTZH7I1LZN@kernel.org/

