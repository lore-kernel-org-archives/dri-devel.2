Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B89CD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 15:33:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6269210EB4A;
	Tue,  5 May 2026 15:33:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BR+CAvHi";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010018.outbound.protection.outlook.com [52.101.85.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0058010EB4A;
 Tue,  5 May 2026 15:33:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHtqR7nkQW0YM08PIJWXYojg9Imp0ccMj+MY/8x+TnszhTH7F5tNw8QEuRweZXzjDZFsHs3c6D7LZ4YO89uPBDBMlUm1J1BGE5CidvhyZ0dun8RBz+6AsY+tNrmBRbbUqeXkwLl/x9lyf7nGjBFW7Kvye6dnziEC6vNpwWZ+iVTDH2LrZcrETIVnWmo4hf4umCD49Idl6LI7F02V+LF+D7jV+JAFt4gB+IYcWehX7gCe1+poF1Xzpt0Dxron1UGpmilij7fUh8XZxIQmmN+Pb/1vw+PqokD+SuGGgqJLqvYw9Zyva6h5rpYgYP/FRBRbKDcNNSCUBLlzCEKiic8pGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18VqU27PNLZ32HHDNRQivAN5tWGVwMmKVOsBUYH6SBU=;
 b=FIPrMeRhH8ARwfkPabUsCxWBZLlCujHk57dEUXxjUpKN2yk195Xd5mpUpS+yZ5W6gHTiC3qMxnwqJ60Q8Nuz0qCbc5109JQx1K17dYux9AKljE4++hxIxXbdEo/Q7n3y5W9Ofc084FXj+5easO8fMuvBXYigimnUz02+KrQTJEKHiV7X8v+Y9uZw/oPJT8Ez5L0opb9w0DxYGyAu+8BWr8RndShgwEIpuXI9VrQaLASd3buaawYx/PKDDIwRr1kpg2lxUNOWQclTtFdlJUSPsF2sglJ/5L+1F1PV1LTYjdFBJjFnxHFqjqA2MuIL7Nrx9uIZRyQFAIgWOqSLxImEcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18VqU27PNLZ32HHDNRQivAN5tWGVwMmKVOsBUYH6SBU=;
 b=BR+CAvHiCV480R7T8Qrr4iUISV93p62Ug7kUCFwgCgA02mmobFLYFPg8nLa2Y1Tm2vuwdK+DPEV0sF+BK3vCMYnFV2ZPWqA9aw2m852pKf5LWmpUG/4k8MlZg/HDieXA9xGTdvLqsBApc25l/Cc4X1f7pyr6aERUhzrXwsPCX/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SJ0PR12MB6829.namprd12.prod.outlook.com (2603:10b6:a03:47b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 5 May
 2026 15:33:01 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 15:33:00 +0000
Message-ID: <8de14305-b4bd-43eb-9025-f9d210ee125b@amd.com>
Date: Tue, 5 May 2026 10:32:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] drm/atomic: attempt full modeset on page flip
 timeout
Content-Language: en-US
To: Hamza Mahfooz <someguy@effective-light.com>
Cc: dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Hung <alex.hung@amd.com>, Ray Wu <ray.wu@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Ivan Lipski <ivan.lipski@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>, Yussuf Khalil
 <dev@pp3345.net>, Tom Chung <chiahsuan.chung@amd.com>,
 Roman Li <Roman.Li@amd.com>, Colin Ian King <colin.i.king@gmail.com>,
 Charlene Liu <charlene.liu@amd.com>, Kees Cook <kees@kernel.org>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260501203552.749080-1-someguy@effective-light.com>
 <5dd93e29-a076-491b-9861-e08a0204c77d@amd.com>
 <afnXTwKBfjBYdwgL@hal-station.localdomain>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <afnXTwKBfjBYdwgL@hal-station.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0178.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::33) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SJ0PR12MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a40a49-e0d0-4068-f16b-08deaabb971f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: kGvoQdbE6AYCBbuLncSz1qJMLjFoHZ703iOzAx+nUcWUN+bC/21oKZjPrC0npJVaUsnq4lVZ4Hc7sBGv1Cn3LGVgIn+afPhA++zjd5mQhWmL7RsjemoOaw0CTxJz2YZKek5wPmkcEJH7K9ieyx3TkREcfuhne2gvaIdHUg3IJhoyPB8Tj4zvNbMomsFatmDq9IdXD1gqO7Qb5eA3Qy+jVIEJ4jyiaa0OVSX4YKh4eeP5SCX6m4I/DnPcv0RCxVQt6GPA65qYaNpos9k3CsdVv79uv8XcPvym65foGZEzZ4rY2kWory6jdEDrqJl87IGiIu/DDJ+cgGAfjloKWondmwOPiFT/xvV6m61NzWNncI9olzcgT/9Wo5K9Dr3nocZ5I/MTbejTvaplBE/v86WDtncK/CAs0lxBWPcTJB8CoqtHP5nLq0P3NOSGtNOnrxlb/05llKmK9A6qRXlQmF8eInb5sjQTac2Tx6vcjDLNSb0WPtzxAqja+beDKT5UvBCIza3aGjQobixU33U6JXkr9TybGacPrW/C3FJ0YdYcL+68vkwQRu+gz3c21Emy+/jCJQnew/KmczNPWNst/Uibed6bfmVPTKS8B6xtWKY5DsIq9x5JpkiCFJGXoKxqEznP9809YCE9AoZKE6krxWy/WQ/fF12jZD3HuHaTBUQV9KrFbEZ7W/RCFqKpn5SdHKGXlmcsayFf3cGLxfmdr3hntg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzdCYzdNWWpFQUpkSkUvNXJoN2JGSlYrTHRONWNiRG53cVNiQSt2SWl2c05W?=
 =?utf-8?B?MGZmenZCMVZsci9ETTJmOVR2M3c2c2hIV3AwY0NYazZwOFAzdzdCTklnTUU1?=
 =?utf-8?B?NG14Umc1UlRxNHA2TGlSNkFOYWFTMU9IQVlkeVZSbTUwbzVOa1VJS3piVC9k?=
 =?utf-8?B?TFJWV2hwVFVDdXlWR3ZxcUp6azA2SE9HdEk4R1h3WkQyTFFPOXJweFA5RmVa?=
 =?utf-8?B?anFRclR6L1p2VVdsTzhDVmY5UXF4Q0hpVVNoN0NuN082QlhWem5NMGhYOW5s?=
 =?utf-8?B?bXFlRTEyWnlxT2lxOGZ2dUI0a21KQzh6V1NkaVViZklVRnRUdXVVQ0x0TWVY?=
 =?utf-8?B?S3VKWFgrRXM1SjliSG1FQmVhWGZUTzViZ2V0Wk02Wi8rYlZoUjlnRXR3WXpD?=
 =?utf-8?B?dDRkWEpLN29yYm43Uk1kbUxGMXlVbytaRkt6cWxoUWE4eHBZS1dxWlE5NDVr?=
 =?utf-8?B?RHVwWTJGNUl6L3hSZE84MFo5Z3RzRWFNWFUyOUxjV2hjaEMyL1QxOGhwZDRx?=
 =?utf-8?B?bU5EakEzMVhjTDZPcU9jdGpPUWpPZkRyUWNxWk1zYUVHR0RvOEFUZWhEblhZ?=
 =?utf-8?B?czZHR0tLaTQ2ZkRlNjN4TzNKOXpDb0NWZWJVeGc5VVdwWDg5WEE1SUJWUGRB?=
 =?utf-8?B?bXBhelN2ejZseVhQTDhlS3A0NzJ0OUFNYTFCSEpzSGQwU3h4WFhKVSthdEFO?=
 =?utf-8?B?RUZlM2pCWmlJNUI3YmdoZDdjdm5FdVFqNVg5cFNDZTh1S1lHSHA4YXJEZFhP?=
 =?utf-8?B?RGZKVzM2SUt4THE1c0QzdU9MZExLMkZkVkZ6ZnBPMkU5cjNvc0ZVbkM4ODVv?=
 =?utf-8?B?WCtaMEltL3B3Vjkrc29XTXVacDRYQVNsb1BEOFZNUGlrc1Y4ZjdmZ2VuYVdk?=
 =?utf-8?B?VUZYS3U4T0VkZGlxNFlPM2p2bzVxZkQ5WmhNWURNTFZLSlh0bjJpTTdyK0wx?=
 =?utf-8?B?blRHaXUrbE0wc2JuWStjd0VScDJ0emVyZWYrVVVLQUs5Y0RNazBSYWlsLzRE?=
 =?utf-8?B?THdjdzhKY21XcHU1Z3BCVlF4ekI4L1dnSmc5UE5VSUlYTERJcnVjZy9qYWFu?=
 =?utf-8?B?bytGdGkzRmhKTXVvZlloOHFGdW9BYWVRSXV0UWdyYkRkZC9BTDg4TjRmczdz?=
 =?utf-8?B?SEJSY29kZzNHVTNpVitJN1AyZFlVTStaMWc3Ujh5REFTUFh1dEdWSFhjcUpG?=
 =?utf-8?B?VmpkS2NlcThFYXkyRG1JUldNQ1BLZUJFdkt2b2tEZi8xZnZyTGFCck1mckwz?=
 =?utf-8?B?V3dMdzAzWXZZQnovUXhnbkl2SWRmQnF3b0c0VkRtbEVkYlk3VW5lZDBkZ3NK?=
 =?utf-8?B?aklLYVlFeE5kZkRrYVZDc1VyN2lJdGVYTVhpYTlLNW5CbzAyRmJKUVVia2hC?=
 =?utf-8?B?TjFrbWVxV3NtYlFiZ1JId1ZPaTJGTHJkR3grb1I5eWphWTlPV3ZDK3BUZFdP?=
 =?utf-8?B?TmYrWDRoR3k1eXVoalJLV2YzbWpvc25KR0d5SmhjSjJxWFNCelNuajBNQjFu?=
 =?utf-8?B?c2FzWkFlMjFhc2RVbGQvVWRxNnRhcWFQaXE3cVRjMlMwMW5sb1VZaWFabVcx?=
 =?utf-8?B?RWJCVGxIMjI4UDZUdjRJNmNLZU4vSU1rd1BVK0xncURXQW91RVRiSjFFNlBl?=
 =?utf-8?B?MlNuUnhaREdzQzBheWRLTVVCTHhGUXB6cHFBeEt1RlVYYjAzbTFwbGlXL1RK?=
 =?utf-8?B?dVNYbmk2cXlDWGtkTzdYWUNUOTBKOWdSWkQ5dklCd1hMVGdScU1YVFNQQnMv?=
 =?utf-8?B?U1NQV1ZHK3BPZUpqWktmZUdDWVRXeEExQkREMTlINWg4L3JEc3pxOFpCTE91?=
 =?utf-8?B?NEZYcmY5K1N6WDV3S2Jya2pjbXo1L3paQjRnOXh0R1JyYUFDNmw1R3ZUWmQw?=
 =?utf-8?B?OGN4N2dBSHBNU0pMcGpRV1dsTVo0WklJaktxSC9nQzhSS2pUeGZNOWYzQTA3?=
 =?utf-8?B?ZXlSb0xrU2RZMTFSNlhqSlh4Y2pBekpzMEt0K1VpZmpTbXZaRFRETVlVbEF0?=
 =?utf-8?B?VldiNzNHRGtLeVUxc1NqQTBSUllKTG9IYnNheGlWZkw0UWlabW1oNnZNZHJ1?=
 =?utf-8?B?bjU0NE12N3djZC8yQ3RBUzVFR3d5NFhkNnZIVXd2dzBsNmphYWR3NVFaeVU0?=
 =?utf-8?B?TVIxV2R5eDZaeDEzUmQwejlzRHpCdEFlRnZwYm91eWRCWHpTM0hXdTBlaExS?=
 =?utf-8?B?bkE5dlpJQWFlYkhmaE0ybjJlU2FuaUtKM0pTSXpyM205L0dMelJhU0dJQTkw?=
 =?utf-8?B?dVRTTTVTZThFMzZYMUpaMWJqQXlwQXIvODJEbFptczY5N0F4cnZvc21rOWYx?=
 =?utf-8?B?MzFXSVBjQWhwZjUyNndhR3lCcnhyZjVaa3Z2ZlZsemlrTnlBd1laQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a40a49-e0d0-4068-f16b-08deaabb971f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 15:33:00.6334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Qxzn2w6YzzH7LoLHI9dz/xmdW1qtlBbPiu3ny7C1VY2F8MjiqVcSRU6BhDkmMzagBi1LWsgHsOFzWeUKmqVXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6829
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



On 5/5/26 06:41, Hamza Mahfooz wrote:
> On Mon, May 04, 2026 at 04:50:21PM -0500, Mario Limonciello wrote:
>> Do you actually need to set all 3 of these to true?
>>
>> I would think you only need:
>>
>> crtc_state->mode_changed = true;
>>
> 
> According to my testing `mode_changed` on it's own is sufficient for
> amdgpu and the documentation [1] seems to suggest that it should be fine
> more broadly. Though, it doesn't seem harmful to set all of them just
> for safe measure.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/drm/drm_crtc.h?h=v7.1-rc2#n118

My main concern was it's safe right now, but what if future changes to 
atomic control flow mean it executes more code paths than needed; or 
worse unexpected code paths.
