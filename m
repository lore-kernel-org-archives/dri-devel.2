Received: from smtp.lore.kernel.org (ip-10-30-226-214.us-west-2.compute.internal [10.30.226.214])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311BC606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=j0JemJHL
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1A3CCF2E6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:48:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75A3110EDB5;
	Mon, 19 Oct 2026 14:48:31 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010060.outbound.protection.outlook.com [52.101.56.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED2B410E87C
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 14:48:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ob28qS+sM2K+mVgdvoGcOwVHnG5/JXn9deRpZoXIrlUfxG/BHoXc/3aQ9wS1pEUUzpuWz3O5BPW7tyOX8XC7aCWsmp5FVHQUmuFzVw4IabRL8RNo7MLICfVBx05mKOwA+9GPBUvTeicgR8wKFtVCvYX1SrlJFEhw3pz0418UWjNwwjh6buw9z49JgTJHP48VNddUSZiYYv99V5OHrJZ5CqACZsUOTfxFB/+RZ+1HXIrQgwivoFkL6hjT0+5CDwa6WeoA8ZjNnIwwS/4QOFtkz3rViXoR1YRtbuLr4CHtFU0QPqi75V6en/dU3wtnmu1dvpMk1SoKqgKu70sj5KDsiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxsVq36+6YP4UudoLlQFXQ6CJPlH1353QkIuI6ztx1g=;
 b=F2cPkjTKqHMcrl3bbB0SN3BQT1BzoZTgfaHRvwT+ZfuxYaCoi6CbB3bHRwd7/LFsb52jUnCeUv39Rya64f9et2Zp9zCmS59OrfaBPmqbhObSLsAndZiFtbpgatQcImM9UFFHtro4XB2yIgIbX56S4t+KN7cz/7r2vsNsKGCb3+Zny3RGi87EBxQsJo3GWfKYRHGVTYH63YfJJzjYokB4vEFJCUDIbda5ffDG3OH8AZWk5OJZaBI8NfXvUwhJlRQdKCymPE0MSR9ylI739Ii3zZeLu5lLON7zIVY8B3wm1Mqo4l8jcyKA2KBe2W4b+XAwezS+tDa0SOaBID3uQO4xCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxsVq36+6YP4UudoLlQFXQ6CJPlH1353QkIuI6ztx1g=;
 b=j0JemJHLd/dHdO3S43SXqEQIVt6EPe8UUeXFmZVabNABp1en9XoTZF3l4MoJGiuSr5OiNBKQ/QcggrGfn5wH7kKPrVYAthsjWvGZet0t0rN2Ds6iaV/59V3ZAgHSxitVSms5Ejg7w30NpvdUbYF/0y8cQBC0VhZ0Rc5oGsmpBgc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB9447.namprd12.prod.outlook.com (2603:10b6:8:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 14:48:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 14:48:19 +0000
Message-ID: <b9f5ee4d-987f-44c2-a1fc-2570f4500803@amd.com>
Date: Mon, 19 Oct 2026 16:48:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] media: synchronize CPU access to imported DMA-BUFs
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Karl Mehltretter <kmehltretter@gmail.com>
Cc: linux-media@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans de Goede
 <hansg@kernel.org>, Hans Verkuil <hverkuil@kernel.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Tomasz Stanislawski <t.stanislaws@samsung.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <cover.1792392288.git.kmehltretter@gmail.com>
 <20261019124433.GU595565@killaraus.ideasonboard.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261019124433.GU595565@killaraus.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0358.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB9447:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff771ab-58ae-4b5d-ab96-08df2df0040e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|7416014|18002099003|10067099003|22082099003|3023799007|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Lyxld7rgtwNNI/O9+JobFIUkObqmUIhal0vuAt7DLJ+ZySezdbyhD7C9W6ThwdF7IYgcEC9rT53ClVEBST5LwKSA5Nd040XRb55Tp1+xwW/f6ybX0mOVk3/ngQjxUJD6OuqcghUVTCH3MSuczUTrIt3U4aIa0JpAgZmdMxw071VGqxc22Oi91y/k0hiVyxxwV5Kv0gh/bejcXxYfsH4qpSpNiie0HGXmpVYn3ys3LqIROjnKVdGEi9AWG4ksaQOJ5RJoKBaETTKmcKmdBvbkUGVdwURwKkEQYNcY1fhPrt+gZQXlKYRLsc9jPTfmBHI8l0bjL0+SrYBzC7p3eTT4YMfMQnF1azGD5Sx11Ll6SBbrtSxw6ab8BU0tfvU89SJ8LHCFg7U1/dGrFJDXPg7frJjyaaozJYJPzycQbhSFSuqe0F9TLRSKjbAfhCzXSneS2ic3xJwvdrDlTgCf8SgRx2keIJnkNQzYZepv0GY7DLMt1yHoG6xxXsjF0ykXW1rlopr3lW8H3hsHmA+ueuwhRQ35u7lfGuVZO41YEal3iDj9irYGAdp/3rwdVRU/W6bi0kUC6Y7r1rPAoZ6VFyzUlMZD6tMu0ha1LzZzt3pJi49EASM4PCf5N8Q3426Ds9Js
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(18002099003)(10067099003)(22082099003)(3023799007)(4143699003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2hxNVFOMXBOVWErSXdVdUJzTDlZV2xoeXRvL3RQdlFFNjE2bVQyRUcrVGtj?=
 =?utf-8?B?USthczVibHB0b3hCRDFkUHZ3anA3VHNPaWhmZytaNEl2YnhUY1dFdlBrSjV3?=
 =?utf-8?B?aU9PVzFkRURyTy80blVNWi9oZEljU3IxNGR1dm1jLy92ZnM4WXRDSHU5QWFl?=
 =?utf-8?B?akVWdllNOVV1V2xDUEYrMVQ2SGdpRzBuY09IOW1vSHBIUzRTSTJ6akEraG95?=
 =?utf-8?B?bVdoNmFZendtMnZSZU56ODBKYTNmbXM5azNOMG9OMVlCSG5URWk1ZnU4eUtF?=
 =?utf-8?B?MW5hajRqMWlRVVBaKzVqV3BlZkVhZ3pLbFdCUnRza014NjY1NDdiK3FNbDNT?=
 =?utf-8?B?djhFY1B2OWg3OGlFclNBa2E4bWloU1l0VnUwUEdkWjdldUNtelJwWGlHcTlO?=
 =?utf-8?B?cGlha2k2aGs1bE8xUlR5bjZpb3VlZnNXWnJYUlV2bVlMVjZkK09MSUdER2I0?=
 =?utf-8?B?VjU5Wk5uWVQyYjdIVGpVU1dxcFcwK0hZOVczTGFycmw1cmJNTkUrcUVqdGtj?=
 =?utf-8?B?MllnTnZTMXVOMzgxREZyb2hwVzJSNHJNR3ZNRndjMDZqZS9tNWgyNEpxT0lD?=
 =?utf-8?B?a3R6dk5RdklKM2xlMUZML2V0aDNMNzNpWWNyT21ybUFEU0MzcE5QbnkvWVUw?=
 =?utf-8?B?UkZRcnNlb0Y3a0ovQ1V1cWRVeUNPUzV6S0xLY2diL1ljQUFxMEJmNzN2VnRt?=
 =?utf-8?B?eGJOZncyZUkzYllpLzV1dEFsZEhGbVVDK2V5Q3I3YTRFTDZvR3NZTVg3MlNQ?=
 =?utf-8?B?NkhMRURsQnlQYlI2Q29IWm1DSWZ0UjhyOXJ0QzN1NlFsSWRhdWw0UDlBS2Mx?=
 =?utf-8?B?VEx4YkRDejNTZXZ0c3phSVk2TmFFYkR1WHVHb0xmVDhCRmkxS3llOGRvbU1N?=
 =?utf-8?B?OWZFRzFNL2xCQy8wRkdVSGY1MUo4SGZsampiQ0VxWjBEMy9yVDl6eWQ4ZXo1?=
 =?utf-8?B?bFFDK0o3Q1NuNDlmam1YR2p0Y01RUWhReU1QRm9EcUpQVlF0MHBHMkZiNzFK?=
 =?utf-8?B?TDlKNWNVa3FjKzU3U2RtZ1REWE9WbkVtcnhqdlBBekxIaURXNGdiZzBlNU5t?=
 =?utf-8?B?OEZram9CYkhPRmpGNWZySzNsUnBCTldFODM0NDNXZkNxV2lTM2w4TURGYzZ2?=
 =?utf-8?B?R3ZnTEt2NFd4YWU1dy96cmIvRGNCSGdmTVVZMVZ5ZUwraHdlV2hLT3UyTjlu?=
 =?utf-8?B?S3JzZ2xveGpPOG5Rd2xiWXNaVThaODJveVppTURSU0MxWE9HQjgzeU5VeFdI?=
 =?utf-8?B?SXV6TW8wM2tBdGJ3WXVSZVRhRER3anU2SEE3bGhRdFluVFVvL1U4Z05kdlQ4?=
 =?utf-8?B?dWtGbHc3b2hGbXFESjY5MkNZSnFVdnVGY1JPbm1UU0VvNkdzSG1ua3RzMks1?=
 =?utf-8?B?dnR5Skx0U1NCNkliUFYxaDFrYXBLYUNCcXMxZU1CRzE2enN0VWE2cGJyc0Yw?=
 =?utf-8?B?bWgyL2NTSkVwT2IwSkhTV1F1MlJpZkEwVHFoU1hxeDVNWFJjNVo4MlMvbzZz?=
 =?utf-8?B?ZWFQeCs3aVFWQUVpNDJPcXJLSWM2eWJHdFJaZFVsU3kxWXNFc3JSdk5vSkVj?=
 =?utf-8?B?WUoySXJ4WEJLUWNXbnJvenpDQUtySlNld1JjOHBGRlBvQW5TY1lOdEVsRmFK?=
 =?utf-8?B?d2QwTGR5ZkdsUVpXdmJyVlNOWDJYZFBwVUhWdDJQaW5yUURZV1NOdkNPYnM4?=
 =?utf-8?B?TlpkdXZ0U09CRGp6WitpQkJUUTEwRm1lOWxaZFF6TU1TbzRyK0V0SUhpdUFx?=
 =?utf-8?B?eEdtamJHNjQ2ZUU4VlkrNWNQaTRUdlhxRXNEYkNXOVFSN1hOVXdoL0ZkZmhm?=
 =?utf-8?B?SzR5eUx4R2w1NHdvQUZiZ0xaUFBseWowUk9LOUN1Q2REZVM4czJneEZYN0xx?=
 =?utf-8?B?cmQ0SmtER0RsQlNCcXk5aHIzQmNvK1FiVjdXQXZRM1I5bVBQMkVxS21UbnVo?=
 =?utf-8?B?VUF1Z2JpMlA5SUVLRy92NWJ0RlZYV0dLSzZHMllEQVgrSEc2MXNBek1DRzA4?=
 =?utf-8?B?SGo2TXVGZVVMUU1GNEVRNFQ2NXdzcFVjRFJMamFldTJ2SlFETVcxajdsRHFP?=
 =?utf-8?B?VGVkMmxtUWtmQWl1RzhxRkQ0bExxSDJJNGthK21BREorRklWQUpHZy9LTkE5?=
 =?utf-8?B?L0xPT0ZvVjlkeGZKKzZsODdsNjVCVGZOOWl4NC9aa3ZxQ1VVc01QRXIxZk9M?=
 =?utf-8?B?ZmFGTEdWd2l0WkFTZS9VbUcrRXFOZk9JTWRVcXNsVU1tYXJXNTlFMVFXNm40?=
 =?utf-8?B?V3NUTDBRVFh6RXlGcERGang0cFBQaWtUQUM4YVUzVzRvcGVlWkVOT3RXMzNL?=
 =?utf-8?Q?mgBprrjVnIJFGhcYS8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff771ab-58ae-4b5d-ab96-08df2df0040e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 14:48:19.4966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlrCSvh/d0kL7l2lhAGJUNTgAkHzaji+afie3/5SW0ZoIkSv9r4ycfafqNIsLfJ+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9447
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
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/26 14:44, Laurent Pinchart wrote:
> On Mon, Oct 19, 2026 at 09:14:07AM +0200, Karl Mehltretter wrote:
>> UVC and vivid access imported DMA-BUFs with the CPU without cache
>> synchronization. On a Pi 400, captured data remained in the CPU cache
>> while physical RAM was stale.
>>
>> Add an opt-in queue flag to bracket CPU access from buf_prepare() through
>> buf_finish(). The allocator cannot imply CPU use because some vb2-vmalloc
>> drivers pass buffers to hardware. Patch 1 balances finish operations in
>> VIDIOC_REMOVE_BUFS so removing prepared buffers closes this interval.
> 
> This seems completely wrong.

It looks a bit questionable from 1000 miles above, but I might be wrong.

Let me iterate the rules here:

Accessing imported DMA-buf with the CPU from userspace should only be possible by using the dma_buf_mmap() interface and that includes the DMA_BUF_IOCTL_SYNC IOCTL to flush buffers dirtied by the CPU. If that is not done this way then that would be a *major* security issue, but I guess that this isn't the issue here.

What the drivers do more likely is that they use the vmap interface to access the DMA-buf with the CPU inside the kernel. Correct?

In this case dma_buf_begin_cpu_access() and dma_buf_end_cpu_access() should be called to properly frame that access.

That seems to be added in patch #2, but I absolutely can't judge if that is correct or not since at the same time you speak about userptr access and the code really looks a bit like spaghetti. 

Regards,
Christian.

> 
>> This follows the per-queue flag proposed here:
>> https://lists.openwall.net/linux-kernel/2024/06/20/236
>>
>> Based on Linux 7.3. Tests cover the same code on these earlier bases:
>>
>> - Pi 400, 7.3-rc4, all four patches: eight 640x480 YUYV frames per run,
>>   imported CMA DMA-BUFs with a DRM device mapping:
>>
>>   Path                          Runs   Stale frames
>>   UVC, vb2-vmalloc               12        0/96
>>   vivid, vb2-vmalloc             12        0/96
>>   vivid, vb2-dma-contig          12        0/96
>>
>>   All six lifecycle cases passed with both vivid allocators. Read-only
>>   output USERPTR passed. The test added no warnings or failed CPU-access
>>   callbacks. A control without the DRM mapping found 4/16 stale frames.
>>
>> - SAM9X75 (ARMv5), 6.18 backport of all four patches: the baseline
>>   PREPARE_BUF/REMOVE_BUFS imbalance was fixed. USERPTR and six lifecycle
>>   cases passed. All 128 vivid and 96 UVC frames matched RAM, with 100/100
>>   begin/end calls. The baseline was already coherent.
>>
>> - BeagleV Ahead (RISC-V), 7.3-rc7, patches 1, 2 and 4: read-only USERPTR,
>>   six traced lifecycle cases and 60 repeats passed with balanced callbacks
>>   and no kernel diagnostics. A vendor 5.10 backport of patches 2 and 3
>>   captured 96 UVC frames without stale data, with 100/100 begin/end calls.
>>   Its baseline was already coherent.
>>
>> Karl Mehltretter (4):
>>   media: videobuf2: finish prepared buffers in VIDIOC_REMOVE_BUFS
>>   media: videobuf2: add opt-in DMA-BUF CPU access
>>   media: uvcvideo: synchronize imported DMA-BUFs for CPU access
>>   media: vivid: synchronize imported DMA-BUFs for CPU access
>>
>>  .../media/common/videobuf2/videobuf2-core.c   | 96 ++++++++++++++++++-
>>  .../common/videobuf2/videobuf2-dma-contig.c   |  5 +-
>>  .../media/common/videobuf2/videobuf2-dma-sg.c |  5 +-
>>  .../common/videobuf2/videobuf2-vmalloc.c      |  5 +-
>>  drivers/media/test-drivers/vivid/vivid-core.c |  1 +
>>  drivers/media/usb/uvc/uvc_queue.c             |  1 +
>>  include/media/videobuf2-core.h                | 12 ++-
>>  7 files changed, 116 insertions(+), 9 deletions(-)
>>
>>
>> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> 

