Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F164ACA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:06:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54E2810F0A1;
	Mon, 12 Oct 2026 13:06:30 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010070.outbound.protection.outlook.com
 [40.93.198.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1A9E10F0A9
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:06:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKl4L3luzOkgUJr8g5D+Fj/tsknSutBWh4eya2BLU5GLOLIE5gpgqHDuOd0jw3W1+0jdaaZn4GDDDtX+L0IwZvd1b9P27K4w7SXKxkKQgVrfMqCsHWzGkyr7X17lXOtFlWApB27GmUa+AVpTWBDpoFi5iSMC1jq34hvy31xGl9IQ2u+D82b6vFxLXd+k/UTV4LSc1HY3FQRNt97pwM8YYDFqyDFWi+NtyfsXtP+ibaNfEZ2CgowY8njztc5JhN2qpu0rJzGNQQHClZZsONFsqH6KPnYBqNfghaxDTfNNdvwVOstQmTPEqX+uL/q351+Z1JEXY/UDwciP+xTTL2KheQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHWhxznL26AOh9ei/4RtW+AOTKOEI7qm3POMeKdNp4k=;
 b=EfGIj0mYQEasfGMoAZV2xOIBixWYlzzbAabLWvrsAJSzbqBs5Q0iQ19VqtpHKTp8GDA258UgUlR1pQtqC0P1rXR0IwVthmUM2I0kiZdhu0pfQf81pzhesP33fKpFpRPmw/Mb8FLSfxsa8wKnDhcAn/9yWU6JedWnLfjZQhu88mWo6wySwGcVuxY55fuVX+fNshCVpNhfbWf7yuCISYUzxgmE23T19Z8SF89GAixR08iQWAaEzA4oMS7LtfK9nzgepHQbcs4z95AcbsDdihwhD9kcF+PluTs7snpnUnh2pQI+k0GE1G8WvzIMYFrkEhHiFau5Grx32W/E79Wqi61Z1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHWhxznL26AOh9ei/4RtW+AOTKOEI7qm3POMeKdNp4k=;
 b=J3pSQZE2XyAFPGr+sqGpgfC8eNqB4UTR8JxXIQv+aQmqBo+lCGAUAr/cGy8JYEsmsRYZ+wDR0zlR9KQx19NMg2XeUHYUFKOLuye24xn+wg/TPz6AAEQyUzm4MHWBdDy274mmKQtglwJxyzOdqRjK9CiHG8MXgtY0ujPYxK2i/zs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6926.namprd12.prod.outlook.com (2603:10b6:a03:485::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 13:06:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 13:06:18 +0000
Message-ID: <ce33a3ee-b3e2-434f-8a78-535a22cd9d19@amd.com>
Date: Mon, 12 Oct 2026 15:06:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/syncobj: flatten chains when importing sync_file
 into timeline point
To: Julian Orth <ju.orth@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20261010180711.1548333-1-ju.orth@gmail.com>
 <20261010180711.1548333-3-ju.orth@gmail.com>
 <f70c39c0-3754-4a18-8ad9-eaaf8a307b8f@amd.com>
 <CAHijbEV=510kPTYit=EbXtsYosQ+WOJ58Ey1AqK1Ca7Wb77bCA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAHijbEV=510kPTYit=EbXtsYosQ+WOJ58Ey1AqK1Ca7Wb77bCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6926:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c74effe-4006-4e23-1462-08df28619af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|10067099003|18002099003|22082099003|11063799006|4143699003|261009221227099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: qP30M8Mn6CstM0PnZhXhw76ARp/4cx+SQJd02k1SG9lGYwkfIwpmOEcPD3205S4Mm1MccUW21tYCQNnWwDBbmaIEJpHCT+6E2RqlI9B6iL/LMRE64HfDOFFllhKI/uwW6hVe900Y3cosob3nONvhoqOQBjs7ptvT80uFczJHD8x5BxWeEXwBHCv5ZUHudp05iD04O+EfMFGJQy/AiOV83ZxnIuBXo73MQZK/ZM/Frmr5pCgTfkqHZAz6RbQEorrAAUyR9b+yvIKwWAhzMhSAqh2JixEpKKmP6HuKXdJwOqVlcrmRt6TNES7PEPQIOqY7YgUYew6OpiQwWkSNnwZ09kGUsgm7D4B9iUHlAlr6kJuRTO2kOkkdijnB5E3tZ5bQqdRkAozjD1xu6uw2a0COD42PjbpgBRJlWB57jxzkaeM8w0E/AndFWP5L/sBrfiHMW0JYYghpeZ4Og/flDHcICA589lXoVBhjoPhbkZEsJeKFu0DOqAzPpM8sGj0g6eL1tAPDemHdBOOVMwgkJ0oYWPXfBg2TLe9KoJ7B49NkjLoNBydpJSfcfKu0B5T4v1TfQ5v2o9geGHISXN9BnYDYKrJZSMNvji+fdJH+sA6l9rLnTGEszedfbheWSJFifsy3vYDbS37Ik0jmXqT0Wa1lfEvLM3H2gCjIr2hHt0f9128=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(261009221227099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWZLLytIMDdub2d4SCtKbXl5YkIzWXJ3dDhjRVJUWUxFamxSeFpMY1dsSmhB?=
 =?utf-8?B?MGtnb0VhWnBMQ0dCNkJ5c3dWSEU2Z3RRSGk5SEN4eG9DdFEvL2tlVWJaNWtK?=
 =?utf-8?B?dVJzV0pjUFBhYnNSUmtsTllCSnFKVTR1NUd3NGtvL3VrY3IvZVlUNU1tbHJ3?=
 =?utf-8?B?OXZTeTc3QWxqTDlwS0U4YXhXdGRPN1RmemFOamRWN2lPMjQrZkxWcXk5YjEx?=
 =?utf-8?B?ajF3YXYwUTM3anBueG8yQ2ZrcVFYRCsrOVhscmZqaGd0dVZNUjAyZFNDNXlX?=
 =?utf-8?B?UmdHd3BuaWN5MzFORXozNXdydWd6MjVkd2RwMHFhRWFIQ1BjU3ArRTFMdzZj?=
 =?utf-8?B?b0sydGk2aXpOYU5FMzg5NEFVdEdSVU85ejQwekFZa3dJY3RwZXZBT1orWUU2?=
 =?utf-8?B?ejVWMVNCZ3hQc3pCOVZOOHh2ZVErWDRlRzRxcjVOMGlpTkdFd2RZa3JXVjZx?=
 =?utf-8?B?UWF1V1dBL1dySVdheGVSb1IwYUVOZE55d3NWN2F6Q0VoRTd5Zk1Yb1crMGR2?=
 =?utf-8?B?eXRSNy85VFFROFFQeERIbW53bytFdXRVN1hFRmUzWHMvQlhEYUllMmVyQXZ5?=
 =?utf-8?B?alR4UU9zNjM5RWpxazIvVGJKUnRMZnBiUXFlb200VXYyMWxOZlp6S3BGdHlH?=
 =?utf-8?B?WEQrMXVEVXlGMnkyTExxMXhsZEFxVEZFODNKVGhGeHpDejJneUc1aEM1QlpT?=
 =?utf-8?B?MmpvQ0l3dWZmb0d2OEw2TjUrVGxvUVJxdzNvQnpSQVNpQlNJL3ZSd0VDaVU0?=
 =?utf-8?B?dDFTelROKzhidDdJa1dybC92ZC9iTHFuU2F4cUt0cDBwNTdRSGN4ZTNseFA4?=
 =?utf-8?B?WUNIVGJBYkFiTG56VnpxU096RkxZYjBkd3p3Z1J1MTdyZFdzZWNQT2dOTjVo?=
 =?utf-8?B?Q2ptNzIwaC96NXlURVlYRHVxN1dEMmJESDRCSjBVQ0ZabTBMTktHRHhNcjlm?=
 =?utf-8?B?S0xSUDdqVUErbUMySnJCSnN1eU9EL1RkTTR3YTVWbThGOWNBMkxORklpclZY?=
 =?utf-8?B?TkUvS3lMZG5HVmNBbFFKSUFFVlpBdmhLbFlYKy9hdHdyMEMxb21Xajl1Ymsz?=
 =?utf-8?B?cjRnaW9ZRVdRZ1NCMFBndk5WaW1zWE4xdXA2RmUwdnk5NnhtM3hiS05aUzhJ?=
 =?utf-8?B?cjBveEF1dS9EUWtabFJJdWh3T1lDRitkWllxS0tHazBwdVNhRkYzeEU1ODYz?=
 =?utf-8?B?UFhzakxjNXpOVjBoMkZpS2xjQ1RWWnRUMjZKcnJ0ME1RUDMxblpia2d6NjVt?=
 =?utf-8?B?eDQ1ZjZPMThhZWdUMDcxcUszS29JK29Hd0VnaE02VkMxT3NsM3JGYmRHS3hx?=
 =?utf-8?B?ajRCM25GUis5TnJRQ1F5TmlZUCsxaFJRQVhNdmxUZXdJN0xQVkRIT2Izc0ll?=
 =?utf-8?B?Mm9CUGRFb09DbWNEb3QxNEE1R3A2dnA1QmEyQUVwdUsycThKKzAwb29DSlVX?=
 =?utf-8?B?VXpCODgvSVhjeWNxTGVHakUzcFQ0NHNBanJjMzUvR1VtK0ozZ1NqOXI2MFo5?=
 =?utf-8?B?TDhMNSt2MEZXM3FXeGNZdzN2clBUMFQ5TjlCLzBqNUVpcXBicElZaTY0eXhk?=
 =?utf-8?B?VHpYQmVhNnlybDVNUFBqRlNqWDlsRGJ3S2dQeVEwUHhOQjVReVBRTEl4Z0JV?=
 =?utf-8?B?aVJZcXpCK1lRMkwvejlFMUZhOC84bkU4UkxhQXptb1pQR3hvcGZXVmJHbzZX?=
 =?utf-8?B?RUplNEVuaUk4ejF2TjlhdEJRZUdGTDl2bWJNTVZ5WGJuT28rdngwcUsza1pG?=
 =?utf-8?B?U21BVnlsbVdvYUxTYU1MZ2VTbW5KUThTVTRBQWNNOUdkWFNSbjFGUXVlUmRV?=
 =?utf-8?B?VlpKSXE1NGFZOVZZdm80YjEyc2FnU0R3WE0wREVrQXhEc1N5b1FiYUZpYUhI?=
 =?utf-8?B?N3BmaTI2b0UwdDA4LzQ3V3Y1eTFoa1hzbTRFNG84OVNwRTBCRGdxNnExQlZ6?=
 =?utf-8?B?YnlLL3BaQ3dYTkRiVW9MS3o2MEJjYzFxUWhZZkExRU01YTdYb1VBYzZnQjVa?=
 =?utf-8?B?cEdiVjFiMEtjRnVQcFQxNjRzemJucnk2dTZJTnRYMmNvTUlpN1VpeFZ3alNx?=
 =?utf-8?B?QmtjTDNiVkpyMTZMMjk3NVNvNnBhZzN3SEExRUxpSURIblN2MkwvenRaSjNy?=
 =?utf-8?B?Z2o4cVZ4eHptbXVBU01nM01BdTdqYk15YU5TZ1l3OFR4amlNTGZCbEEvcDJj?=
 =?utf-8?B?REFCMVBjaU9YUkVCSWRJUXdEY01SeGxROElPWEFuMzNDZERUUk9TQmZoVzJG?=
 =?utf-8?B?bnEzWUwxNng2emNZVVhmRytLaDdVd2Zrc2JxVDQwZTJqbmFHNFBjM051a2dF?=
 =?utf-8?Q?G1i6SooEUh6UnMwE9+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c74effe-4006-4e23-1462-08df28619af1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 13:06:18.9045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KexQ83/4qLBmsRO+J7YArVes0M+elDN+5FiZQ4OUvOKY7yHDQrKNKyHXuG3wQfkq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6926
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

On 10/12/26 13:42, Julian Orth wrote:
> On Mon, Oct 12, 2026 at 9:51 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 10/10/26 20:07, Julian Orth wrote:
>>> A sync_file exported from a timeline point can contain a dma_fence_chain.
>>
>> No it can't, IIRC sync files are only supposed to contain raw fences or dma_fence_array containers.
>>
>> I think we never documented that and that's why this issue here leaked in.
> 
> When I reviewed this patch before sending it in, I asked the AI if it
> would not be better to do the merging at export time. It was adamant
> that it had to be at import time because of commit 519f490d by
> yourself:
> 
>     dma-buf/sync-file: fix warning about fence containers
> 
>     The dma_fence_chain containers can show up in sync_files as well

Yeah that fix was driven by the warning but it was never a complete audit.

IIRC we later found multiple other issues as well and because of that the approach of exporting dma_fence_chain in syncfiles was dropped for at least one other occasion.

I don't mind allowing a dma_fence_chain in a syncfile, but we really need to audit the code because I can't think of a way how to do this automatically.

Mixing dma_fence_chain and dma_fence_array containers into larger data structures can trivially exhaust the kernel stack on release/cleanup because of recursion.

Regards,
Christian.

> 
>>
>> I'm not sure if that doesn't break anywhere else as well, so I think we should fix the exporting side instead.
>>
>> Alternatively we need to audit everywhere where fences from syncfiles can be imported somewhere else.
>>
>> Regards,
>> Christian.
>>
>>> Importing such a sync_file into a timeline point with
>>> DRM_SYNCOBJ_FD_TO_HANDLE_FLAGS_IMPORT_SYNC_FILE |
>>> DRM_SYNCOBJ_FD_TO_HANDLE_FLAGS_TIMELINE passes the chain directly to
>>> dma_fence_chain_init() and triggers
>>>
>>>   WARNING: drivers/dma-buf/dma-fence-chain.c:286 at dma_fence_chain_init
>>>
>>> because chain fences must not be wrapped in other chain fences.
>>>
>>> Flatten the fence with dma_fence_unwrap_merge() before adding it to the
>>> timeline, as drm_syncobj_transfer_to_timeline() already does.
>>>
>>> Reproducer:
>>>
>>> 1. Export a sync_file from a point > 0 of a timeline syncobj with
>>>    DRM_IOCTL_SYNCOBJ_HANDLE_TO_FD.
>>> 2. Import it into a point > 0 of another timeline syncobj with
>>>    DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE.
>>>
>>> Fixes: c2d3a7300695 ("drm/syncobj: Extend EXPORT_SYNC_FILE for timeline syncobjs")
>>> Assisted-by: Claude:claude-opus-5-5
>>> Signed-off-by: Julian Orth <ju.orth@gmail.com>
>>> ---
>>>  drivers/gpu/drm/drm_syncobj.c | 12 +++++++++++-
>>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
>>> index 5ca5163d0..c545af77e 100644
>>> --- a/drivers/gpu/drm/drm_syncobj.c
>>> +++ b/drivers/gpu/drm/drm_syncobj.c
>>> @@ -742,8 +742,18 @@ static int drm_syncobj_import_sync_file_fence(struct drm_file *file_private,
>>>       }
>>>
>>>       if (point) {
>>> -             struct dma_fence_chain *chain = dma_fence_chain_alloc();
>>> +             struct dma_fence_chain *chain;
>>> +             struct dma_fence *tmp;
>>> +
>>> +             tmp = dma_fence_unwrap_merge(fence);
>>> +             dma_fence_put(fence);
>>> +             fence = tmp;
>>> +             if (!fence) {
>>> +                     drm_syncobj_put(syncobj);
>>> +                     return -ENOMEM;
>>> +             }
>>>
>>> +             chain = dma_fence_chain_alloc();
>>>               if (!chain) {
>>>                       ret = -ENOMEM;
>>>                       goto out;
>>

