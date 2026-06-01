Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A7ECD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 08:30:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93C88112F94;
	Mon,  1 Jun 2026 08:30:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gTT/h8y8";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013019.outbound.protection.outlook.com
 [40.107.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C57E2112F9A
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 08:30:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTsybIapZnT/gQLI9ENGqtSElp7L1xUwtd/XR4PWyHnAy7bGu34m+7znkmyDpoNjzBQLfdW3jEW2D0athE8j5fFOpaLoVI1ykaJ1FQoiRMwiFcE7ehL36Lg+t2q9666xC3DEq9ZGXtps1VmmmOH8DNYO4uDSGY4jUqb1OS2AY+NHCWs9TUyVwRaWeZcjBhibMvEcgRpw8aadcN0n/z6W67zfulsm2jYagId0S936Y9uLDJCw7n7Nt9h0OVlOWp8hEDYP7nLQT11BRJHfTnVH3Txjb3KyIy12XXqSxeqvwalh1l60jbtPKvm3XKgIFH8RCVDnjqHHYtoJLF/VnBwh9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUqFPLofsFkeyYL79a38hnoZFYP4loflvJ0qKPsEISs=;
 b=pjTVd+fY8fMw94xdwdYiyHIuSYt6GBxri9jJyUDhd321PwzvnropWOg3XkylXIgO+bYTlnjP/livysfvxfzvuPS+iF3VIW2ezNvaeWtzf775q6kq1ZgXTvGSwGX8AOT2TYqC8+gjuMIBeWUuqv3U8yLfVqzCCHzFchZjde0I1UwikDBf6Zt+fGyyO6Y822sQGoFWR+DxIMh7FNmYLzaC8wtjbBqiAEBK1C1QfUgyvO6SsuH13FlAYT8LJ7UA9B9E71kt3Tmj+eHN6RpGTKje1pc2so6VTbInsbX5uO/59NKv4kY4geoDfQErwHofJf2zSkiGjI2I+Ada4JBWfXhP2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUqFPLofsFkeyYL79a38hnoZFYP4loflvJ0qKPsEISs=;
 b=gTT/h8y8AyIigi7Xm3wyg8oYjbEco24QLyHmv2lmy900ERHdItjMx3pHe9sOlZhAG0NXPYmjjDXNZM2E8OuhB7FAvdKZmKz02dnTcskSxpbrvqZRtBs6ht0lupPdokzRI+cuYQwnO0kFVRciRNAEAl178c1X5/ou3PAHUqzRZT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BN3PR12MB9571.namprd12.prod.outlook.com (2603:10b6:408:2ca::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 08:30:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 08:30:16 +0000
Message-ID: <aceb688b-4f65-4539-a4f1-fc5455b60a5f@amd.com>
Date: Mon, 1 Jun 2026 10:30:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: drm: Add entry for removing spsc_queue to
 TODO list
To: Philipp Stanner <phasta@kernel.org>, avid Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 dakr@kernel.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260529215207.115513-2-phasta@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260529215207.115513-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BN3PR12MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: de4216da-abe6-41e0-e7c1-08debfb8022d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|18002099003|22082099003|921020|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: IH0Ovpw29Ht0WfJymSdz5f7HvK1y9rgWLTqik5cbqiYmeMNhL/KsnaJ0mtPotlj7WYrIqorb0ZUeKrVfKSGqdbvdMRmr1emvBbOhpqpgMuPY83bBk8yQyZGSnTWOe2vui+cHlmJTry1UE7XQEzNeeXIv8HXn/h8xQVrw5+X76IRJhI1xlKmA9f3PSttV3qzsKzdmsthd40j/UAdbWvgV+EXJSTJwF78WXePqAY+OW6qDCzar+6FE52B5FnF7UbWsVrYg6Uy8wRRIvDkVsGwAg0jXTL9XHck3xe9Yp5YvOtFxC/jAThqstK/D4TotHfdme/3/c6TvyTIxABWOuKhRrYiXoNb2Ya+/h3v/zXdxxKjpnYeT0sdiOnH8Kv3bIycL/eEY0Jq19Z8yXP7VYgJTOnQZuYoixahJnx8x3SxqZSQnw6sn6lZjcPhk2xRHkvM9EjfCU0PdnFHHkEoWGk14Z/SOYiHutm8bXzvkMBASh8iplo1LWQwpffqnecsx6wdSQoTGYEsid/AtDmpYnYPxNLVWtj2d7KQxCbZmwdyx/C8EBGxKW92EwbcSIIBwDCdfd1bf+SGD7cji/JFbxWJuNlEamfqQHkXRhnZFMlYaKE3aFEND+4/p6fqbnhxhB+CtZlAhUaIXIJIZ2gG1z+/qZHxVE/8NOQQgp/OjfB8YZRt73puYSCimK2pEG2STT6Ja2r2ZyszzyGEZnpufLI2IrBjDVsjMLwZQGrFlQbh7RXc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(18002099003)(22082099003)(921020)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVJKTXBWNlBsWFhuTndGc2FMM0NMeTBWNFdYK2cyVXdoUXluS2tLMDE3OXVa?=
 =?utf-8?B?V3RWc09JdktDS3pTZi9ITWxaMkRoYUJiZFl0TUV4UU9JZzV3d3QxWS9Ic2VT?=
 =?utf-8?B?elRld3hDWU5sK25OeEsvUURQeGxaU0lzZGxEb3IrbGVYVStYZnBsaE4wTk91?=
 =?utf-8?B?S1ljaTNlRjJxUzVSYzlzR25mNkdZVnRkYk5CTzdwQUxCa2tWa0E5RVNiNE5u?=
 =?utf-8?B?WGRtemVsNXdiYWxWcHNkSDlsSWJzM01CaW54Q1lHT0pXVStkcUhlWkpidDJp?=
 =?utf-8?B?RytUNTNaM0lad3JOc3JtamR5VFVNbXlFa0pkcjlaOEZUTlBmZCtQWGZiVjZD?=
 =?utf-8?B?RXAyaEMvUGNkY21kMWM3VE4vaW05TEhvcW9mYTlmemVDTy9QdnZoK1pSYzNE?=
 =?utf-8?B?TmlNdDFyL1NqaDZib29NVWZpUUxkUVROeDRpczJLRWxXWTJvbWRjNVloRVIw?=
 =?utf-8?B?VGtpSms2dHVnTUpoRUlZb3crTjRCZ0hvL01XVHRiUHZQZ3hoTGVieTlTcGlY?=
 =?utf-8?B?RENsRGtabG51ZXdFTTVnVWZuVWJSVjAwaUtOeFowQjFQdkU0cml6QVMrak11?=
 =?utf-8?B?elZ1SDlncnpjbnNQcDRuSHhYcy9Md2Iza05vWU93dzdiK2JLT1JkdFovN1c0?=
 =?utf-8?B?RzNrZkxlUmpBMTQzL0p2b1Fjem9VRllkUU5PR01PK3RwWlRCcmdtM0Y2MFVx?=
 =?utf-8?B?eGlCQ1RQNzBoOTI3YkxXUUF6NFRRYlUwcEJuVjFKNDZienQvZEtqUmdRVzlh?=
 =?utf-8?B?eUJwRUY4Y2lrM3JQdHJ6SnNLZ0MzcjFieWdKN0ZNSmo4a2lsdmY1NDlsNUFO?=
 =?utf-8?B?bklQZjQ2Y2JmMFl6NVQwWUdJUVRpUkk5QmpkaDZnUk01WjNCMThjUitLa2oz?=
 =?utf-8?B?YlRUQm94SUZLYk1hMHd4QVhBN3NJQmwwOFlLVkJHQjVXVVIwcEJoSlRSWDVJ?=
 =?utf-8?B?anNDNjR3SENIMDFZU0ovYTV4aUExc2tvU05IaTcrWVhnZzJkdTRJU2w4dGhR?=
 =?utf-8?B?ZTRxT0gyN0hIS1FUZDAvbDJJSkF0QnFZdFJpYVdxOTZTb2UvdzNIK3B6NWl6?=
 =?utf-8?B?WnhNc2tRbGJ5bVgycjJRVDZGaHZYdHZxRWZrMFVocWxudG5ua2t4bWhVc09D?=
 =?utf-8?B?S1c0U1JOT0NpNmdrSmlzbFR5SytycGwxOVV3M0M3SnU1cHpmRXNxM2ZIblM4?=
 =?utf-8?B?UUR0MEtIM0JmN3Y0c1V3Z1VGR3lMdENzd3ZKdVJTZThBMnYvUTNjcFYrU01U?=
 =?utf-8?B?RDI5clphMHJFOHVLVlJ1N2NLSkVQT0p2ZFBGaHBRZmI5UWVXczJKN1k3a2Fl?=
 =?utf-8?B?bnlpbFhWWkVnTUxTdXA0cFBIQmpuZWF5T0d2Z1I5ejgrNjBSWkpxajNiMGtL?=
 =?utf-8?B?NzVLMnJvMjBQanAvNmkzdE5EVER5L2RWSTlHMG5mVE9zMTB3UUZkTkQ0bThy?=
 =?utf-8?B?UFlPa1hJTllqWlo1MzRVeDhCYm1VSHltOVhxSE5Bb2RSUzVPOE5EamgzMVMy?=
 =?utf-8?B?TGxWRWlzeUpnOHpxK1o2QldMano1N1ltdEZHV09YZm5DTzZWazNiRXZkT0Rr?=
 =?utf-8?B?OU50cmJkUTVFQlFHbVRWTVBkbWhtdHUyaDR3V2xCcEpYcEJMdWxZaEhqU1Bu?=
 =?utf-8?B?cys4SEloc1Y2ajloZ3VUTjBLRWNNb0xHZU55a0xQTXZuRWNkWm1vSjZzckF3?=
 =?utf-8?B?MVRHYm9senlzZC84MWFzSTlGcDZGaVNoV29jby96YXl4QndpUVFpMGZyOEo3?=
 =?utf-8?B?cEZGOVQ3ay9sekExMWtickF0bnJxa2VnK3ZmNWRudnlFcXlWbEZ6Y0lqc2or?=
 =?utf-8?B?cGpxQ1BSbnhiK25yUWdPOWNOaEl0QU5LcXZFY0hWcEZxWmhPbUU2ajVKcHVW?=
 =?utf-8?B?SERYbTIvemdHV1pJWnJoc0NvNWhGVk5ITEN6LzZydmYwMWVwQkk3eGhqR0pN?=
 =?utf-8?B?SEY1MTgxUlJrKzBtaXpoelZtR2RKTC9mOWozZjBnS1hTbXFuc3NkUm1xZ1BX?=
 =?utf-8?B?U0k3aUdubm5ldDZMY1kzYXA1a1dkcUFuOTFuYVpDSFZOY1ZWT1YzMjhWclZU?=
 =?utf-8?B?SS9RL3FVcVlXTkNEaktNc2NCQ2tFekk5OXBVaG1UUFdMVTNrYy80U0VURHlN?=
 =?utf-8?B?S0FidlZjNWZoNDVKaDlNWG9PQnpsZHVvTDVuZ3hLS25lZVZ1WDduQTcvOE5W?=
 =?utf-8?B?a1RvYVF1ait2N2FRQUpSeWhFcC9FVHdQL2VjaU53RFZIazNGN2xlRTBUVjZL?=
 =?utf-8?B?UVZTa1hrMUw2dGprRVVodXlubndOdFBsMTljVmEvY0htWWhQc0lPRi9wb1lC?=
 =?utf-8?Q?dXLO4XiyxfTZ4KY+bP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de4216da-abe6-41e0-e7c1-08debfb8022d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 08:30:16.6255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8XQpYHcmTrPsJm6SycQCzck9dKvyPXqMAGfJRXaRt1PPD4j/aNgdRDBGr/tSpvI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9571
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



On 5/29/26 23:52, Philipp Stanner wrote:
> drm_sched contains a lockless queue (spsc_queue) that seems to be
> useless and potentially unsound.
> 
> Add a TODO list entry for replacing spsc_queue with a locked list.
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  Documentation/gpu/todo.rst | 41 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
> index cdddf8db35f5..87e082b0eb48 100644
> --- a/Documentation/gpu/todo.rst
> +++ b/Documentation/gpu/todo.rst
> @@ -948,6 +948,47 @@ Contact: Philipp Stanner <phasta@kernel.org>
>  
>  Level: Intermediate
>  
> +Replace the lockless queue with a locked list
> +---------------------------------------------
> +
> +drm_sched is the only user in the entire kernel of a special lockless queue, the
> +spsc_queue. This queue utilizes:
> +
> +- preempt_disable()
> +- atomic instructions
> +- memory barriers
> +- ACCESS_ONCE()
> +
> +whereas a conventional spinlock utilizes:
> +
> +- preempt_disable()
> +- 1 atomic instruction for taking / releasing the lock
> +- memory barriers
> +
> +Moreover, drm_sched_entity_push_job(), the only user of spsc_queue_push(), has
> +to take a lock in some situations anyways and calls to it are often serialized
> +with a driver lock.
> +
> +It is, thus, highly questionable whether the lockless queue grants any advantage
> +at all. Considering that its internals are not well documented and its correctness
> +is not formally proven, it seems desirable to replace the queue with a mere list
> +or hlist that is protected by a spinlock.
> +
> +Tasks:
> +
> +- Replace the spsc_queue in drm/sched (and those who might access the scheduler's
> +  internal queue) with a spinlock + (h)list.
> +- Ideally, check with some micro benchmarks and real world tests (preferably
> +  with amdgpu) for relevant performance regressions.
> +- Remove the spsc_queue from the kernel altogether.
> +
> +Contact:
> +
> +- Philipp Stanner <phasta@kernel.org>
> +- Christian König <christian.koenig@amd.com>
> +
> +Level: Beginner
> +
>  Outside DRM
>  ===========
>  

