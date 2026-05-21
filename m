Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AB5CD4F5E
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 12:14:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFD8810E47E;
	Thu, 21 May 2026 12:14:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X0RxjtdQ";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012070.outbound.protection.outlook.com
 [40.93.195.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0529510E47E
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 12:14:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Df4qOc/yc0me8SlVRSyV5LwN2ALsosqMLA2pF3ywKPHz2NE2xPdFAUC3RE2jFR6Ar7iEkj2kjwcf3SmdKnOknp23djQ6qQ0YOJcrIN5qz78ylre54Hiy3ZnEpTyz8ifauQU+9ozHhtCDiJo0Ub9kfZ3sI9+q85LQubWbGj7hPscxecOoF2HVQF2wkOyg9CCbCnzobkb2lzd8eoDnB6RjazfTSvmlTrTFB3o6D7Hfs91QJ1Kv7EaO6CoyEj9jFKAjzMbx3wsOvDTEOFeCt+p02dJE8JevC7Fzj1pgCewwjZFx9ssJ7mzAUu7eS4fVX11aBJLCQwEFejuZ+ps8NMJdOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9S/fnvGl2iDtNke6giS6ptJ1N8Lew0wxon+eBDYQPI=;
 b=inBM8N95V6zVoV6OMkiIlsRHedX6u2vrGlL2vGdRUOIUPM/szydJWA7bQrC/KwXSgzcl2sruHJaXGJ6Gck7OXHvfNBFFBMYgZq9wQs9kxvQk3jsN+gjAOfOJK+DvA2pNEukXFUiR90e+fEzfgtbrclqe0XQrdd4iKGG//h5GhuZM+bqRK/HpaKIMXJOjtt3MUM8pVZ/LzEFeCLQIyitfObSmAHTltduB0NcjzVpoS8b+3gt7oLN3WBNaX7HgGavAK7S0eibW24GY1j8ITdLNHuG0hZ9YyOHPms3y2ErfXKjpMDRfIiTTwO0Vm6hu5OLZIft+ZizVnZiRMBWe5uHVAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9S/fnvGl2iDtNke6giS6ptJ1N8Lew0wxon+eBDYQPI=;
 b=X0RxjtdQRAmsv/++Qt9f/vs6N3lkN27NTLDGZxhgDBYOBKSmz2uNO0FAY2RQYJU7NsFtL4slZkwfltVgkHrEbJT0zjxNEoOF/eSF64Q7wWTarUs68vYwubpJM8JYVTWnTrFofbEWBEkRzUwjrV27LGHWIK6C40IOwN+SuNViPic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV3PR12MB9186.namprd12.prod.outlook.com (2603:10b6:408:197::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 12:14:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Thu, 21 May 2026
 12:14:22 +0000
Message-ID: <43cc6f84-76fc-4653-83c0-6fa7eb474895@amd.com>
Date: Thu, 21 May 2026 14:14:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] dma-resv: Define guards for context-less dma_resv
 locks
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20260513-panthor-guard-refactor-v1-0-f2d8c15a97ce@collabora.com>
 <20260513-panthor-guard-refactor-v1-2-f2d8c15a97ce@collabora.com>
 <03a57011-e734-4a74-aef2-e3a6016e15fc@amd.com>
 <20260518111456.30ba9bba@fedora>
 <a9ee80aa-0c9b-4bd7-87bb-d3e228357b18@amd.com>
 <20260518161531.331cab2d@fedora>
 <d793568d-9611-4174-b9e9-c71ffec5ae93@amd.com>
 <20260521105402.4bc4b1e5@fedora>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260521105402.4bc4b1e5@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0276.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV3PR12MB9186:EE_
X-MS-Office365-Filtering-Correlation-Id: fbff5b8e-a2fd-42f1-c962-08deb7327e1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|8126099003|18002099003|22082099003|56012099003|11063799006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info: XL88AY4I7cDDJ8PH80JKu2A/VblnSOAWX1gmeT8GKdDvoxJvWqiFOvQ9xAd/87ngwj6nSk03VZ4KJYH8pWo5uMWz39T1EvKeWZCwDfZldqiXH2bH3TZF7rHr00NV+f4A+QeTJQUUITOq7XqNymSvhbxL1+fKy5ug2XW+FCKWCYuoKpWc49mwry9eKvH1I01gUyPenzvYOBjCayF3M4GGntpmroDHCDqO2Nf8attyz70yXTxXkHSQETC1tWPtWoqN2/86RIPb3MkrjY911rhB3r0RYPyUuro2Z3wUOFAYMqUxxXSanstqLe6hrccdNIqZmTjtw6RL8k6t/HH0kqdUMYzE7F39x8vCn7uR1MTrwVpswxkyVDLqGFal8vij0DzjLskdprFbb4A6vWWc3u3EzNaUY4vyHFyEUbrBW/1gkm5E2O3Y3aWaAKm92Bh4oYgjd6b5IIAXUKcU0uNyXXq3EE65O2Dicy11lGgwHBzqJ8iBcLA2BeSgq4K9n982ONQCxf58LaKDEVE5mfdymtFN1WEJXwuHCHwRwQsnKbx3drGGUFmxwQ3UfvUlbnrsR8sNLTfLXw4z9g1HfbIp7nYWNh/6SPB2YxXICS5b1zIt+t3Nu1IbUfQd5OBib+YnzQdvr5LomxrJ4PLYIWyDBpTzfGFQfumcfmbBuuSpgG5ZD6nBLoZUT1orT+KTd7sZhe/s
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(8126099003)(18002099003)(22082099003)(56012099003)(11063799006)(5023799004)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFhJRmdTSFdvbnNTMmZXZ01jZ1lOWWRXeXlscWVOek5Nb0xXa2srb3hXWmZO?=
 =?utf-8?B?bWFZOHVuVEJ4QkFTWmMvMGhaamh0VTcwd0dzMEJPSkVsUGF4YWhJWFlZOXhV?=
 =?utf-8?B?Zk9ET2VFYVVzT1pKMTh2YUlHdlFDaEx6VHlGcnhzZDk5c0NHbC9zKzYrbUll?=
 =?utf-8?B?OFNEY0hFMVV4MFVheFVBRDRMaFV2Y0ZnZUE4RXJUL0ZIVUtkcTlrd1czOElV?=
 =?utf-8?B?bVRaMVV4ayt6OG4vQ1FyKzNnYzFQUjFUVjBpdmdUcWJKQ1JzNXplZ1FLTFEz?=
 =?utf-8?B?NXNrNE9wanJCaUlLRFkyU1RIZWFNM29DeVpJaXhIK2Z5U25nc2lqR200RzVz?=
 =?utf-8?B?N0VtcmhSTGxId3VPMFVpaTJReGxiN0lsWTNOYVd0bkJmNm9aRnJVOEh0NDJj?=
 =?utf-8?B?VkIyL2JKN2FnNUVUTzRnVmxFdUdZME9aUGVjTk5uaG5jaDBqZVFkaE5Gemw0?=
 =?utf-8?B?ZitpdGZvd0EwWmgvVzd0SlM4ZEZnUkUzT052bWMra2xpU2dYVmtVRmVQT0gy?=
 =?utf-8?B?cTZlQml3bUJ0NmhLVmFadHo0L21zWUh5REd6dVBZd3dvTzl3Vm5jWVJKYXNK?=
 =?utf-8?B?OUZPQ0oyQ1N2aytVaThseDZoQmRmSUNlajdzTlh6bDBXVDR3aks4OUdDRDdn?=
 =?utf-8?B?THJ4elVwTnN6QTNKVkN6ajJsZ1JyemxNdmhNNytneWFKYTNFVjZRaWtJTlEz?=
 =?utf-8?B?OUxWditNejFvanBLa3dvSkdCSU8zUTlyTXRLbkhja0VqeGIwTlc1Sm53ajU1?=
 =?utf-8?B?aDZmN21uZlJjb1B4aXpDb2dFYS96Wm5BS2owRkFtait2Ulk4bi9Jbk9tS0N6?=
 =?utf-8?B?SXZvVnpRY0ZRczg0NXZkSnFENklxRGpSaXVKd3F2a3A4b25uWkRDZCtTTzZ0?=
 =?utf-8?B?ZG1tZnN4ajJEWlI3azV0WDErcnNwakt6TXVkUGFQV2RDb0NnaVFqRzZOZm5G?=
 =?utf-8?B?eGR0L1VBMVcyb0wvNDN4bnlDbTNRYUQrNWZwSjVGcTVuMmlKeHkxU1E0SnhJ?=
 =?utf-8?B?eEh0Zm42Y0JiaHZnbzBkMGhWOG53QWpoWjN5QUhnZnY0NC80RmZoWXhBTS94?=
 =?utf-8?B?dG95bitCaG11ZDJwWGFxSmhaL1dsYlNjTjNsVTgrdEdKZXl5b0pMdnYxR0Fi?=
 =?utf-8?B?a29sTEdpZjdrZXZpVW1HR3VmMVNtajA3d3pVVXpVR00wb0RVcExuL3hadmNq?=
 =?utf-8?B?L2JvanhoS2tjMjhiZUpieGh1eUMwT2RZYXZtUzNmQ0ZqQWlyU21GNmNtQ1Vo?=
 =?utf-8?B?TlcyUmZIcDlpRFo2WWJnN1ZuVlFuTFU3SGVVNWVTQ0lVeldPOWRWRHhXeFBR?=
 =?utf-8?B?QU45YWVxcDhVY0JxcVR0enNFYXAwQU9zK2J6c3dnaEx2U3dML2dHOXQ2ZlpY?=
 =?utf-8?B?OFdBMGYwVDhBSGpBMi9MdnYyL2FHeThnQmN0Z0FuNFN5MEZhWStCZmhFWW8x?=
 =?utf-8?B?VE01emJRaTZpdDhiU1pPTm9SZzlvZHp0Tk5BN0JhSzdwU1RtRmtQOUVvYlVz?=
 =?utf-8?B?LzQ1V29JZDZsSlI3SGlaUmJKa05uWURuN0hYWmxWNFUzbkZibFI0ejVtUzh5?=
 =?utf-8?B?Vkc4NWZ2Z1BqVWg0TnpzLzNha25WQkNQZ25iS2hhTjJGZW9WNTdTa0gzenlv?=
 =?utf-8?B?WlpQWDl5NjFMM0lzQjdRMkVBVVB1YlBoNEoxNzNvUTYyYW1IYW5jekNzdG1Y?=
 =?utf-8?B?dFRiL2ZlS21mOUkva1FxVjlVMWUxTVlNYy9OU25wbWNTb0pIYThOa0JzWFYz?=
 =?utf-8?B?bGdhVzRpQzRYWVQrcWlpblVubEVsNmFhWnNRVzIwTTYvbEwwdU1WajJ4Z1BT?=
 =?utf-8?B?SHdsTEVQM0x5a2ZMZU5aVHBIY2gvVXNzL20yRDVPVHpsK0RLaFlGZkp1MklM?=
 =?utf-8?B?ZEdXNk10VHpUNGxoSDFNVzl2NUNPZ3FZc3BPa3hLTndMdFRzdmM0NU1SMUFS?=
 =?utf-8?B?eGhCeWxHSldqZk0waXJmYUhTM1lsdTBxUXNWK3pLWS9TWm4rRXZ6eSs3MW9i?=
 =?utf-8?B?cUNRREZ6RWhHcUdKUENPeUFpMzJ2ZnFwK0RyUXVLUUlPUzJWRjZGUGhXK0g4?=
 =?utf-8?B?NXNscDBoU3lnUlg5Mi9pYzVGQzlZSG1yN1REQ3kxdmxJY1VEMzU0T0NieitZ?=
 =?utf-8?B?WFZFK0l6Yy9FbGtrUE0rWjRDdFhDbkJzdzQ2TVNpVmJiUVhEZkVGbENpRWpP?=
 =?utf-8?B?M0M3dmMwRElEaWNpOFlUUjcwbjVycnB3a3R1VFBNUXZleUNWZnE4RFdWd0NQ?=
 =?utf-8?B?QmVnTWpSL25aaEJVbDUyZWlid0k4dGVXbW43bE03d3JqV3NRN3AyRnYxajBy?=
 =?utf-8?Q?vUYgCx7gbpchIa0OYU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbff5b8e-a2fd-42f1-c962-08deb7327e1a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 12:14:22.6161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xd56pTD1WoZh3MsJFT+QS8JqIe3GLx9TX9Z6OAq4lYST6isnJS9bIa67ArQDTUlM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9186
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

On 5/21/26 10:54, Boris Brezillon wrote:
> On Thu, 21 May 2026 10:36:47 +0200
> Christian König <christian.koenig@amd.com> wrote:
> 
>> On 5/18/26 16:15, Boris Brezillon wrote:
>>> On Mon, 18 May 2026 14:18:41 +0200
>>> Christian König <christian.koenig@amd.com> wrote:
>>>   
>>>> On 5/18/26 11:14, Boris Brezillon wrote:  
>>>>> Hi Christian,
>>>>>
>>>>> On Mon, 18 May 2026 09:10:23 +0200
>>>>> Christian König <christian.koenig@amd.com> wrote:
>>>>>     
>>>>>> On 5/13/26 18:58, Boris Brezillon wrote:    
>>>>>>> When used without a context, dma_resv are no different from regular
>>>>>>> locks. Define guards so we can use the guard-syntactic sugars for
>>>>>>> explicit/implicit scoped locks.
>>>>>>>
>>>>>>> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>      
>>>>>>
>>>>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>>>>>
>>>>>> How do you want to upstream it? My preference would be drm-misc-next, but I think I can live with a panthor specific branch as well.    
>>>>>
>>>>> Everything Panthor related goes through drm-misc-next, so drm-misc-next
>>>>> also has my preference ;-). But I'd like to wait for more feedback on
>>>>> the other drm patches, and there are a few things I need to address in
>>>>> the panthor patches anyway, so it's likely to take a couple more weeks
>>>>> for this series to hit the drm-misc tree, unless you have a good reason
>>>>> to fast-track this specific patch.    
>>>>
>>>> Well the DMA-buf code itself uses dma_resv_lock/unlock  
>>>
>>> There's no use in dma-resv.c that can be converted to guards. I gave
>>> dma-buf.c a try, but just like for panthor, I don't really like the fact
>>> it's halfway through (other locks still use manual locking), so I'd be
>>> tempted to convert everything at once for consistency. If you're fine
>>> with that, I can give this a try.  
>>
>> Well depends on what everything means. I would only convert dma-buf.c in one patch and nothing else.
> 
> By everything I mean all type of locks, not just dma_resv ones.

Na, do that step by step for each lock type in individual patch sets. DMA-buf as one sequence of patches, then DRM dev enter/exit and finally everything panthor internal.

It's ok when the DMA-buf lock patch set contains changes to panthor as well, I'm happy to push that in one go.

It's just that this way we can easier revert things should we have missed anything during review.

Thanks,
Christian.
