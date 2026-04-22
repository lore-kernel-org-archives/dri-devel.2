Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3140F9EDC5
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01D4710E9F7;
	Wed, 22 Apr 2026 12:41:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LRAom1nX";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011068.outbound.protection.outlook.com
 [40.93.194.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 442BC10E9F2;
 Wed, 22 Apr 2026 12:41:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtN1nVPFfikVVku1xTgX9PuhlsJB9osLIKEyKP9WNRhrrJwevrtp9FChta4Yb/bcopyyLUVW6IX0B1tk108vPdWaLPE0IWV/EI66nVLFXthszxAiVEeY1qDRz/hiRa4/uCdPOwGfcdamPQ3cH+UIhra4L8sd7SNXbgyYHEno7ynCyJOWzAWWuDtYzBLsl9yPSc/OOl15nPpLElN8r6dQ69AsXgkSuJMAIXP+pAr2HOwjyepc+j6DUySBsD7uGHOnaLdwROk5J6vZeKWLdgOFEuoYoIEzW85X2Doo97xBO95SLFFOp9tfPfPBb+Xpdw9yYEyauY967cUTAFkPFehnZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAJkmUPdBhqXEFLa7X1tg/+/Yq6vhCioVSRoOS2JH84=;
 b=ycMeG8ZIpE5/6f5frEfU3C27f4J+lvSWa4Eule5iu+Nl0Jf5wXNtpgLuJgpWVALbBRrf/emtpqNZ5gb+qwjuLFA6MV6yJXmxddEKroT7LmStyY+JsPQQsV0qYa1QQIfKGUj62cCBCG/qxc9lxZd0G3uK6Mq77ag593qu04hbhwoiXPqevzXru/eDRZcAF2MG5iLF+o8yRpUeZl4zql+dEv0yXsX/i3y5DOOYzVeX4CCi/vcRGzU4ruSGcs6aaazydPDSSL3Jem2DHcSTadlEkQ2TCL8U29VotB3T8t/PFX8f0q0ZXdOdi78G96CrmbnlThDflsSI04NpAlm25WcrQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAJkmUPdBhqXEFLa7X1tg/+/Yq6vhCioVSRoOS2JH84=;
 b=LRAom1nXd1FvUx4rttyc/3iYelwT7+JQB0SNCWR848PwAMm2UQ8020zKUUWvv1dn26AO84xhEJgdOQgpYl3lHHYAfxWjC7+Yz2VKfbsHi1p//QLpRw4jGCsMdSI7lA0H9Dt0uPslIVS8GVwsD5bJifids8m+AWztmQLbv+jzZ54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 12:41:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 12:41:26 +0000
Message-ID: <879c6e0f-76e3-4eb0-bada-b38230d0d23e@amd.com>
Date: Wed, 22 Apr 2026 14:41:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: avoid double drm_exec_fini() in userq validate
To: Hongyan Xu <getshell@seu.edu.cn>, alexander.deucher@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn, 220245772@seu.edu.cn
References: <20260422123817.1940-1-getshell@seu.edu.cn>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260422123817.1940-1-getshell@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:208:52c::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: 62c1b374-87bd-4e86-98ef-08dea06c778b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: tdAGICUy9MflvLMLHkqVL33wnPNvpfmyGq9sGS9j9mWSgGynee4ut33NdR5snDmP9sQoShJ9A7vaSWnONRbX/Z5Imx0n0zgrCNwkv/dzWmDwgm3o5Xq3Suq+eIOBhUW/naqwTEN4Tc9jrFKf8gxlKmyVFfTdK41XGTDWeFqRSn9HNnyDXQY4GQH96EeYKHa0PvevetwGz7ujNjYmm5fNyj5zeh4U5Zqf0uqRm9uGr4YdJQmwsa6A0bSAbUMS9rUMcgWxySZ96T31SIU3gTHSrlOtBq5TFJ8YUfYkNTabra3jdsLuHtLpf5wgUK12FON6dnYXo1Qux2R/4ISW8A9VVLJA84CWxwziwCZqiVZwwG69KsRqjY57uwDucSbTZJQjFHJuMGJ0C13XwO+XBf2tUsIeYsR+L7FeIRO6BLYGRFcgHX8Ehey6NZkqz0un9aDgxnUvoAMTFrGtwXPXNk7ycqXuIQCmw56zyg7NoE+TXxVXaH3ppSEm5yXHpVPAaNmg9Fe/dOdWpBwzbIdG2ijPlY01BdkR29bY2IRCCxp+8R6lGHPJmY8MRxgcibmTx9ggmRLkJa/a/LSgItWvwS4teGd9U46u1f6UbwX9vmJmMJT7enCYa+aZwrnrKngBEGAi41lBdBctabJAMfCFTK8Ow8Cm08Oiu7bQFxkvNSUdeJKH/jrjadNxLtiDoh72ul8cvgT1G11dH07yr+aD47i3qF65L3mXrsLm80C4ogK1xrg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alBDK0tFcTBRRlMwRUJidUdycWVWcmo5UExtRDdLS2Mrc0JKc3lTallXak1i?=
 =?utf-8?B?bG5za2pkYlk0cWswc0k3ZCtwU0RqQjFYeVZ0QWFIdWFRd1YwOEljNmxMSmNO?=
 =?utf-8?B?YzNoWjZXU2FsYjd4WW9jWTNjTDZpbmJzTk9FTW95SmpDUjNtRGJSclUyaWZX?=
 =?utf-8?B?MGNhMHJqaEw2NnBMUzNLdGI2TkdpMjdyK0NRVmlJQkNNZlpURW5iMGhQUDhQ?=
 =?utf-8?B?d3pPZG9LRy93N1gwMkdPYU1TL0wvYjhXZTlrbS9SWDJUQmx4TmFaODVybzc0?=
 =?utf-8?B?bUNCcmszaGs1alorTWJhYmdRckYwVkpBZDEyS1ExNXJmb013MVBObHM0OHd6?=
 =?utf-8?B?R1BsMmhhN01LOTJFbUZvcUlEVUszeTdnTkFHVGpTdHJicDFlNE1DeG1rb3px?=
 =?utf-8?B?ZjZ0WGh5dVk5Y0Ryc0dXVDZ3ZVpycFYzRlRmYVVEZ3hBaFErbVRyVzNSQWNU?=
 =?utf-8?B?OC9KbERLTFlid29YdVVRT0dTa0hOQXV6dXQ4dlpkUCtLNm12azA2WmxTREVa?=
 =?utf-8?B?YjkweTBpcGtkcytzeXZpZXdQamgyeGpNYVRYTTY2S2ZxSFNsdjJqTnFPWFpN?=
 =?utf-8?B?UmMyQW4vb0w3Q1lTWU8yMnNScTVFZkdVYjlWcVdrakxxMjBMNE1jdThPN0lK?=
 =?utf-8?B?Rm42Q21aUmh4dHpXclkxNjU3c3F0T0tiOFVOZUluNHVBcVNSRjJ6MjB3VmJM?=
 =?utf-8?B?N21LMGVjMWllVHBEUGVqWTZHalp0ZXA3VEMxdGNmZFpRNzhNMTgzVXFOalJj?=
 =?utf-8?B?SjkvaThUZDlnYW9oMmhxbWNXM1VnS3BBbit1c1kvUHpDcVphMmowV2xMYnpo?=
 =?utf-8?B?c29LVEtyOU9QbmRYRGwrT3JhejFxVDA0WUlmL3ZXc3pEZ0dmbUpDbzJoQTg3?=
 =?utf-8?B?S3NFdDZMSENqam9Hb1NtdTJaSGVuUkV0RVIvbVE5TU15clQwVGl6NEZpbVQ0?=
 =?utf-8?B?bGh0OU5QWUxGN3NmRlVaVWVDU242WmxJSXRjUzBIWkVZbFlyK3hlV2dsaWdY?=
 =?utf-8?B?UTZzNzJTLzcrRjFUNFRnV1JGb2xwaGh3WnZNalJSTGl1bDBVclh3VW1YbGZk?=
 =?utf-8?B?aTVVWmVURU9DR1BteHQxQkJRWVJvMmswWCt5RlduWUg4SGRDNWh1Y3VjQ0Rt?=
 =?utf-8?B?V1d5a29GNXQ3RCtxWmllV3h0dVNPOTVvVkZqZHlSbUZWTlRBZTc2aHpkZW45?=
 =?utf-8?B?NHhEQWZ1RTl0aEVJbUFpREtiOUVjS1NkaDRGbHhSL1NOUG5vM0J5ZHpIN1hJ?=
 =?utf-8?B?R09JTlNMbnNpcUlZUy9NRGkyS0NzN1hhbE9mWHhsNitnK2U5L1kwb3ZHQ0NJ?=
 =?utf-8?B?MnUxeDZTY2UzeHpudFRFL1Jia1VlRTYrTnhnUXE4bW1Ld2pibUJKZGhISjgv?=
 =?utf-8?B?TW94ZXBST3hleDZpdUI4c0MzdkJQL29sc0FCU3BYY1FxRHQzZGxoL0ZVK0NX?=
 =?utf-8?B?MTBPVnB5T0dlYlF2UjhWM1NCcnZoSUEwM01VR3hPYWl0MWZkaW5lMnF0d3gx?=
 =?utf-8?B?Ujg3N2c2ZVdwZU5jK1U5L1VTYUZvbHpZWmoyVG1lM1J4RWxvK3FLaEpUajJt?=
 =?utf-8?B?YmErVGZGMUg0bG8yREtMOE1BdGNiWU5WN085U3lMOElqOHRwSHRmdmFhSVZh?=
 =?utf-8?B?VHQ2UnFDOTRVYXlWSUFzMlhCWWUzZWNuZmUvU3BlWFhiSXd0aTJZN0RqQ1l1?=
 =?utf-8?B?TFZjR0VIVTQxV2Q5RFh1aUVadll4TXBiMEdmeFBoTmd2WVJKVHVYNTBscXlY?=
 =?utf-8?B?VTB0c3NjN2FLYnk2S3BKc0dvcjFqd3VBRGRNSHZCTFRwZHYxZUVENmczcjNZ?=
 =?utf-8?B?TlNnK1JnZFdCTFdkYnRiNUorQkpNVE5QajRnNDFWVnlkVFRpcHZiNHkvdHpl?=
 =?utf-8?B?bG5FRTJYVEI1Z01oZkxWZW9NbWtqMStIalcybWFIRWZPZHVCS0FvYmRFN1h4?=
 =?utf-8?B?OXJUc1pHWVQ2THdWN21tWmlndXVZRkFJRi9nRGpveTdaSUo1NFJjamRlWlo3?=
 =?utf-8?B?Mi9vdHU0VEJqNXE4T3RVSXJ5dDFUY1hpYlhrRWxqem9MMWYzQWNGSHJadVdm?=
 =?utf-8?B?ZWc3WkpkL2lGOWpiZ1QrcnRBaTkxN01CL01paklGQnpRWWlVWjJUNVhVNGFC?=
 =?utf-8?B?NmJwQ1RIeDVTWkFEc3dtR0o3WHVTMHYzRU8rd2tPdEpWc3RabDVpUEJhaWNm?=
 =?utf-8?B?TkcrY1pTLzFoZ2JwMmpzU0N2aEhQeTdzc25zaWpBc1hBYW9SODFtWGtBS2hv?=
 =?utf-8?B?R2hXTzVUQjZPMkpVNUZhd1JUZWRncnowQmFQWmd6QnFnQ2hqWWRtQnBjSEgv?=
 =?utf-8?Q?AOKtcxGxeXqdW5vpIl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c1b374-87bd-4e86-98ef-08dea06c778b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 12:41:25.9120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxcPe0UlLbIXnke42jjMUu3V+LA/Al6iWKbYDWSzIKox8A68/jGkTb54Jf/1eGPl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594
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

On 4/22/26 14:38, Hongyan Xu wrote:
> When new_addition is true, amdgpu_userq_vm_validate() calls
> drm_exec_fini(&exec) before iterating over the collected HMM ranges and
> calling amdgpu_ttm_tt_get_user_pages().
> 
> If amdgpu_ttm_tt_get_user_pages() fails in that path, the code jumps to
> unlock_all and calls drm_exec_fini(&exec) a second time on the same
> exec object. drm_exec_fini() is not idempotent: it frees exec->objects
> and may also drop exec->contended and finalize the ww acquire context.
> 
> Route that error path directly to the range cleanup once exec has
> already been finalized.
> 
> Fixes: 42f148788469 ("drm/amdgpu/userqueue: validate userptrs for userqueues")
> Issue found using a prototype static analysis tool
> and confirmed by code review.
> 
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> Signed-off-by: Slavin Liu <220245772@seu.edu.cn>

Good catch, Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 9d67b770bcc2..fe49108fabbd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1193,7 +1193,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>                         bo = range->bo;
>                         ret = amdgpu_ttm_tt_get_user_pages(bo, range);
>                         if (ret)
> -                               goto unlock_all;
> +                               goto free_ranges;
>                 }
> 
>                 invalidated = true;
> @@ -1220,6 +1220,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
> 
>  unlock_all:
>         drm_exec_fini(&exec);
> +free_ranges:
>         xa_for_each(&xa, tmp_key, range) {
>                 if (!range)
>                         continue;
> --
> 2.50.1.windows.1
> 

