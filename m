Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39390CC6B38
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:43:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EAA310EC27;
	Thu, 15 Oct 2026 21:43:04 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011029.outbound.protection.outlook.com [52.101.57.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DA8210EC27
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 21:42:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjvfTtItxG0J1LDGFAjVBT3SJht+IoZpyFBLQlydcdAcVTWCHhh/DThLdQaUN0iwtVbLb9DPfiBrA7z9f6fWq1xZwKp4L+0IJjOzLcWhLfOGNHCAIKuE61ZsLhtlSAQweNtlg+v/ZMR4btwcaYHK5YPDWS5d0/4wItIy6k1kYlizNSzCNFcvO3HuOwWTzmsEGjgCC8NIQUM5rc+Myj1o7QWgOqozp3v9/HCvR4MR8/12igvYGCgeDP/VkZoujWbwnI8yK7Nbu21+imlCdhGTIYkqIB4HO2B79FJkPboHC8EF9qnuu6IxfRCqO8TICDsVVbkPbLZKh96NjDdGOUvPNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQla56rGGZ1Luhe6pk+LA30H+GVJ1b6BUau9lOcjnms=;
 b=jxk9el+IRgZDQWyeWI0T1/OCXhvyLMuiQrHbX6uCY4UrAgFnF44weGIJ4KfcTigvlqEraMay98PJetkoHdlx8TKymS197VVU5Pl6tavnU77GH9AFiPigZ7R+Lh0XbYfg0gDlnokoHrPbey0YCs2hvADid4R6aju55awFcm9yZ4tZI6LcRnUZqaGUF2AuxBjf9PlJ8fR7aR1rLzfGD0gwE2xAjYYrrlyK9g+JJoEpGBLo8+b4uRNqMtX8LkS5e6a8tKf3FdXcZBga+H2lYGsF6Lz93LMa3WDDvXmOpF2cUZgs5jKALu6g8bQr42h3jebO7/Kn1M5wE4/cnOtsQEb8Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQla56rGGZ1Luhe6pk+LA30H+GVJ1b6BUau9lOcjnms=;
 b=xpoqmgmTZPT66yheTsiYeIG4hjx8EK5I/07Aj/8MCS8I2IbU3kH4H/6ccqzVRn2G7BhH7wfQEGi+NWPi3L5OTobNJCX41+Is+5uU0sP521L4tarC1Rz25Ay/DvXc8/1GybmtbBYnbwcLJ5liX3MBpRNB1UAiGijE++yU+YRR22Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB9059.namprd12.prod.outlook.com (2603:10b6:8:c5::18) by
 LV1PR12MB999329.namprd12.prod.outlook.com (2603:10b6:408:3f8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 21:42:56 +0000
Received: from DS0PR12MB9059.namprd12.prod.outlook.com
 ([fe80::74da:85c:3e01:6ca3]) by DS0PR12MB9059.namprd12.prod.outlook.com
 ([fe80::74da:85c:3e01:6ca3%4]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 21:42:56 +0000
Message-ID: <4b8a17b0-efa4-4523-b98f-70bec947ef19@amd.com>
Date: Thu, 15 Oct 2026 14:42:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Serialize HMM range faults on one umap
To: Lizhi Hou <lizhi.hou@amd.com>, Matthew Brost <matthew.brost@intel.com>,
 Max Zhen <max.zhen@amd.com>
Cc: ogabbay@kernel.org, quic_jhugo@quicinc.com,
 dri-devel@lists.freedesktop.org, mario.limonciello@amd.com,
 karol.wachowski@linux.intel.com, linux-kernel@vger.kernel.org,
 sonal.santan@amd.com
References: <20261012203139.2573687-1-lizhi.hou@amd.com>
 <7a29937c-b591-40fc-95cf-021799ea52a7@amd.com>
 <as21qsFsf9HepYok@gsse-cloud1.jf.intel.com>
 <160b6982-7d87-547c-9d84-cb689b35f04f@amd.com>
Content-Language: en-US
From: yidong Zhang <yidong.zhang@amd.com>
In-Reply-To: <160b6982-7d87-547c-9d84-cb689b35f04f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::27) To DS0PR12MB9059.namprd12.prod.outlook.com
 (2603:10b6:8:c5::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB9059:EE_|LV1PR12MB999329:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e9b57cd-4251-4d25-26b2-08df2b0545e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|10067099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: qQdFM4b3XBuaePn0PLB6y/2taZ1NpoCBd6xZ0Hw7J0LF4fKid3xzGXK/4XXiMC2alGjlSRfje1Rw2vUqpEA8ot8zPr/TzODGasNRhKy26hqnJMEibLagSil2UhKS01IjGEubGaYvQi1/04z6vH5ypY75lfsODPTON3EIjZA8zSPKBVJ3ZXnm0DkKJOhM3BYueZ8OyUtlkdKutTGR1b5716w1BlPQq4UoTs1tjxw15MDs+dPc0RAh9QbTABVX27RO7Y2AK0WinL422xtKx5DGWCpNxyJXCxmrobLrO3kr/SFSmfrQjOmIhiVa/AGnW9d1yZ29CFUyYgQzfT5ebjvDF+CJzHdGaHtyPEZxA6C6hp5YSxQMSAg7qtjoxqR0EyP6yj0LOkFt0GoV8bWN7odMkL6ARBuIPyANJXRTC6qTaWP791L3dsq/omS+HuKwRqT0yz+Yd5CYR58V7NZZtdYXqPp0w0gULDv1+ZiLg9RHuyZv25RHZ4QGeHlEOr7JdO2F89e3sYWgrSjDBVu/lU31GmjVLioEF16a65g01wzRPSeLzmtAf//tX6X75HwDGBQBmhxayXkGAe2UWDeeydNq0E1VC6Hk2P6oqIiGs8UT7ZKlK+ijHshI6LK2Vz18IiFS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB9059.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alZ3ZjdIRUs5ZTVqOEhKaCtQOXRoWG5FbHVVem96M1l3UnE2dHdEK01sYXUx?=
 =?utf-8?B?dzNXN0NVbHZEQ2JuVDJQK01wNUgydTVVb2Jac0dlaG04blpiRU40WVFLMSsw?=
 =?utf-8?B?akViZ2ozcHJnQWwvaGE2L2dqUDUxUUVaaVV1YVpHSVM2SGw1Y2lTbGVnQndm?=
 =?utf-8?B?QmpsNi9MaTlGNW9iNlNCYlR0amJoa2phRFNmemcrMW1IT0NCTHBQRlUvazFY?=
 =?utf-8?B?akV5akIwV2tJdGZYSTRLa3hON2E2YTZ2WjhxM1Y1cHhCYjBuWldZQUdjclNh?=
 =?utf-8?B?ZjFydVRrd1VBbHVzRks5dC9HSGdhZzc4YVF2SUpCQlEvRnBhYXRpQXgrN1E5?=
 =?utf-8?B?b1pVZkdIaURiSkZBUDArd1h5ajcvWGNHUEZTbC81UVR2UGNKQ2ZKZE5RQjZu?=
 =?utf-8?B?Z3YrTHczaUNjUFdXdHBUTDJPSHZId0dra25pSk84aHV5R1krbjlqeXZjamJ1?=
 =?utf-8?B?MzRCTlBOWjAwcW13RVQyRVZ1UUtmOTBScEo1WVBoN0tVcVJkK252MVA4M1d6?=
 =?utf-8?B?U0JxeUlRLzlhUkgrTlVLU3JxRFViNlVEWjNZY3BiSWNBcW8zVE5maFBDVXNR?=
 =?utf-8?B?akxkSVZab1A5NytWTS9GYkZvVUNqeXhyQy9mT0M4M3JYOTdoNVdIZ3NCdDM1?=
 =?utf-8?B?SGUrSS9CNXhLM1BkVkFXU3VBQUhOb2s4ZEU0YVVWQ3JyclN3SGIzRlZaUEsr?=
 =?utf-8?B?dVpVbVNvL3creDMzTW4vNWFaWUJyV2NiQytmUG91MkZIT0xydDhtWGFRQm4x?=
 =?utf-8?B?QXRta1J4ZnMyQ2dUOHFQWWlpWVJmdHNRbVNCWklOdHRwK0swQ0dDUzFxMGpn?=
 =?utf-8?B?TEhIQ0dMQ1pOem1UYmNaaStFN05tcTNXQjhoWHAvdHhlTGIyaEhMbXNLdUMr?=
 =?utf-8?B?TVNleEFyTWIwb1p2RzFPSHlyRHNOcDg1b0pQZGtjdEsyZkF0ZzAxQnRqaVpW?=
 =?utf-8?B?bjhlOGpiQThvRXc2Mmc4bFY2clB4TUQrSnRwQkM0TC9PbTlsT1lEWXJhYmRE?=
 =?utf-8?B?NkZEM1BCYmFlNjF2REV0dXNwZ3VZNWNyZzhWeWZxeFNyZU9CTmhDZHZoOHdp?=
 =?utf-8?B?eGtBS0FOOTE1bW5qREdvVUxPUEtEcndNWXk5MGVtOCs2RmNGUHFrRFR5YjlO?=
 =?utf-8?B?NFYvaGN6dDlnaUEzTVhMSHFwS2ppYkErYW8xbnZtUGRMVmdJSEkxQkNUdHBQ?=
 =?utf-8?B?WHFibWs3RGUzNWMyVWRUVjduSjBmWUc2cWFETUdzNjZpdVM4TkdwQy9TMHRv?=
 =?utf-8?B?Y3dpNEVmWUNoQ09JU2cvS2VCUVpsRjZQUXBvazNiQjhFM1hEbm5jTGc0eXd2?=
 =?utf-8?B?ODQ0TGZpbGlDQTJNTmlybnlqWExKL0VkVEJOalVlTStiQ1pjMW40NnZMTmEw?=
 =?utf-8?B?VUN5MDlkMFZFL29kbnJJaGo3dFZCVFpQU0JLWHUwR3FVak9MQ0RIUk1Eb29i?=
 =?utf-8?B?eWxTRGVFaHJ0bEZ4dlVoQkh6N2VWVlpydUEvOHpNOTcxaUdoSXlBdjNGQytO?=
 =?utf-8?B?ZDlVNUlwSThpMll5d2VjT3EwbzFwTmh5RXZkS1I2WEpSQVNvRGFxU2FHazFq?=
 =?utf-8?B?ZExWaGJLV1Rqc2xmYUFFbkx3YjQyTXdXQ3lHd0RiaXoza1pZSVNWVlpkMm9a?=
 =?utf-8?B?b1d4ZjRhK2RncFllcytNQ3NPQ3dmNU12THpFNEdmWE5SdVFKSi9tem9Kei81?=
 =?utf-8?B?aDJGTEZyN3dqNk55RGo5NFIzUmdlT0MwNkQ3cnlDcThIeEtpZFZGUklnVGlY?=
 =?utf-8?B?UVM4MnhmTVNJUjhzU3RIcENycUJ0c3Z2TUlEZUdwdXF4L214TWtpU1hzV3Zk?=
 =?utf-8?B?ekM2alF5SGF1Z0pPK1haNVl3TjhScnNHbnphN2JtZFhIbDVzRXJKWVlUZUN6?=
 =?utf-8?B?QmU2RW1wWUR4L2ZJaWlwTXFITEpMcmY4OEh4ZUlMQjNIa0FJMW9WVlI3SjdZ?=
 =?utf-8?B?NmhaTEhkbXVqZ0dsVng0VFFUbERSa2dVL2pPRzdzK3dldklkaUlGeDk0eUdv?=
 =?utf-8?B?RndWMnNadGpFRnl1eExtOTY3N1FyS0swVWlzZVV3aWVyU0doQTVXRlpCajNX?=
 =?utf-8?B?YXFmNThPWGg1N2dab2ZyejZPWSs2eFBMbDlQMEFlREFEUytnZm1sbUhiZ1BK?=
 =?utf-8?B?eFI2Y0FsWDhzUmg3MFE4UncyUHpEZXU4NWwvOGNFOWg4UW42V0Z2S1djZVU5?=
 =?utf-8?B?djRuck9rUXJEUk9pSWJ0R3h1VXdUdDcxWkczTlV4SzdnOERQc2xDdDBlQy83?=
 =?utf-8?B?dzd1T1JvdDlHc1ZVYkM5UkpvRlJpVkMvZXZyOEg4NUZqOWp5Q3EyWmMzZUpF?=
 =?utf-8?B?WThNRlhXR2JYWnk5T0ZjREcxZ0ptaENBMkk5bHZEdHdtY0RST2N0QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9b57cd-4251-4d25-26b2-08df2b0545e4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB9059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 21:42:55.9202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NQASqnEEmLsIdDz1kWjf09ZuSARz/Wj62YNQQf2NeIw9kjcftNzhcqUPWxosh4o1PJoCcKE/DrMRoG3IeHItJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999329
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


On 10/13/26 14:11, Lizhi Hou wrote:
>
> On 10/12/26 21:38, Matthew Brost wrote:
>> On Mon, Oct 12, 2026 at 09:10:15PM -0700, Max Zhen wrote:
>>>
>>> On 10/12/2026 Mon 13:31, Lizhi Hou wrote:
>>>> Two hardware contexts can submit jobs that use the same GEM object while
>>>> a user mapping is invalid. aie2_cmd_submit() drops the reservation and
>>>> notifier_lock before aie2_populate_range(), and that function takes a
>>>> reference on the first invalid umap without clearing invalid until the
>>>> fault returns. Both submissions then call
>>>> hmm_range_fault_unlocked_timeout() on the same struct hmm_range. That
>>>> structure is not safe for concurrent callers. The calls write
>>>> notifier_seq and hmm_pfns[] at the same time, so mmu_interval_read_retry()
>>>> can see the other call's sequence, miss an invalidation, and clear
>>>> invalid. The job is then pushed while the pages may already be gone.
>>>> Give each umap its own mutex and hold it from the fault through the retry
>>>> check and the store that clears invalid. notifier_lock is dropped before
>>>> this mutex is taken, and the fault drops mmap_lock before notifier_lock
>>>> is taken again.
>>>>
>>>> Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
>>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>> Reviewed-by: Max Zhen <max.zhen@amd.com>
>> I was browsing dri-devel and this hmm interaction annoyed me enough to
>> ask my AI to fix this and converge properly on a DRM framework:
>>
>> https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commits/local_dev/amd_hmm_cleanup
>
> The patch looks clean.  I pull it on top of latest drm-misc-next and run some regression tests. It works fine too. :) 
>
Sure, I will wait for this fix merged then rebase my next patch on top of this fix.

/David

> Lizhi
>
>>
>> Improper HMM or abuse affects the entire kernel, hence we should
>> converge.
>>
>> Please consider the AI suggestions (last 3 patches) instead of open
>> coding this.
>>
>> Matt
>>
>>>> ---
>>>>    drivers/accel/amdxdna/aie2_ctx.c    | 7 ++++++-
>>>>    drivers/accel/amdxdna/amdxdna_gem.c | 2 ++
>>>>    drivers/accel/amdxdna/amdxdna_gem.h | 1 +
>>>>    3 files changed, 9 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
>>>> index d927c8c9d557..4db67a789c34 100644
>>>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>>>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>>>> @@ -1155,19 +1155,24 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
>>>>            return -EFAULT;
>>>>        }
>>>> +    mutex_lock(&mapp->lock);
>>>>        ret = hmm_range_fault_unlocked_timeout(&mapp->range, timeout);
>>>> -    if (ret)
>>>> +    if (ret) {
>>>> +        mutex_unlock(&mapp->lock);
>>>>            goto put_mm;
>>>> +    }
>>>>        down_write(&xdna->notifier_lock);
>>>>        if (mmu_interval_read_retry(&mapp->notifier, mapp->range.notifier_seq)) {
>>>>            up_write(&xdna->notifier_lock);
>>>> +        mutex_unlock(&mapp->lock);
>>>>            amdxdna_umap_put(mapp);
>>>>            mmput(mm);
>>>>            goto again;
>>>>        }
>>>>        mapp->invalid = false;
>>>>        up_write(&xdna->notifier_lock);
>>>> +    mutex_unlock(&mapp->lock);
>>>>        amdxdna_umap_put(mapp);
>>>>        mmput(mm);
>>>>        goto again;
>>>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
>>>> index f14484bc31ec..37bfa5058095 100644
>>>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>>>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>>>> @@ -318,6 +318,7 @@ static void amdxdna_umap_release(struct kref *ref)
>>>>        struct amdxdna_umap *mapp = container_of(ref, struct amdxdna_umap, refcnt);
>>>>        mmu_interval_notifier_remove(&mapp->notifier);
>>>> +    mutex_destroy(&mapp->lock);
>>>>        kvfree(mapp->range.hmm_pfns);
>>>>        kfree(mapp);
>>>>    }
>>>> @@ -402,6 +403,7 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
>>>>            goto free_pfns;
>>>>        }
>>>> +    mutex_init(&mapp->lock);
>>>>        down_write(&xdna->notifier_lock);
>>>>        if (list_empty(&abo->mem.umap_list))
>>>>            abo->mem.uva = addr;
>>>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
>>>> index 9b4aa21a37c9..456a537eb68c 100644
>>>> --- a/drivers/accel/amdxdna/amdxdna_gem.h
>>>> +++ b/drivers/accel/amdxdna/amdxdna_gem.h
>>>> @@ -19,6 +19,7 @@ struct amdxdna_umap {
>>>>        struct kref            refcnt;
>>>>        bool                invalid;
>>>>        bool                unmapped;
>>>> +    struct mutex            lock; /* protect range */
>>>>    };
>>>>    struct amdxdna_mem {
