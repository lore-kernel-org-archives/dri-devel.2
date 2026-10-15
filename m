Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA23CCA462
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 544BC1124EA;
	Thu, 15 Oct 2026 21:55:02 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011010.outbound.protection.outlook.com [40.107.208.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9019E1124E7
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 21:54:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvRs8XgjmDcu87qFirE7aEwhfXi2umEFG3EaHKgvKbT34+w+rICZ2CwzxmOCEd6uUZHjEtuiFl9tnWHmM3p/svE/CBSIuc0ic6db/HAA9896tsNJm5z0Xv/MUHJBC+ydwsBRxStGNcJNya+/SlyRYZWl0UP2THGxH50e8U7p7GYx/XZrRXHnKx1xnEkxkwsPsKfF6etM0mvsKRWKwVBakND57qx4Zv23mgC+hweA7b5C4dskVKhFgfvbEFkVr9KU0WOfsSFHngcRR1hlJLiRso1BF4ayKTK/qzS/ob2Nbqobxn7FZ3CfGSxZrYel8lCd6zFA8xwIh48633CagRyJ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tItY5ll72IoixA7MuH/QsfMHAroxu2LcQfZTv50FYNs=;
 b=OOeGOf65hrWwPc6Wns51urZitfF/fkmyRdQWexolGn60ESnmOQoBvdqEEWJaUjWzfFYXDNsii6D2EBIh2AV3Z1Nophd51aWG8svcXn978bPHtXrwVOHeEbCkq637F9TR258NWUFCmgoDku89ip9h2KoJcUcr09DNmQDbphDifC4Y5YTTNAVVJvRMGT0+eoUMnQOSqvbFeql+M9dqAbN18F8xuz8KBWxeRaUbtWX9pkgVQqq24PvWNulLly6MJzEAaqt62GIWyl123kVNce73RqrFfaRHIfQ0wbJiov9r+a7MnYtqprBmTUlHeJozogm+qHcLV71TlP7+wjZTCv8Z/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tItY5ll72IoixA7MuH/QsfMHAroxu2LcQfZTv50FYNs=;
 b=3VLLAhaY9is5eQ/xu5DvTfyY5tZ4iv3Kq/Zst6W9dqNIYqgdTbO/kr7MtHsMvS5GLOsmfuofYGfBuYqahp9g/+IuCSlKRkIJ/UUMsAb1o9alGTmFUQRIXn2w6fd+gAgCw6oml6wabFJzdDa1JrGg+YVgkBhzIYIUv2kXpRW8xFk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB9059.namprd12.prod.outlook.com (2603:10b6:8:c5::18) by
 DS0PR12MB6464.namprd12.prod.outlook.com (2603:10b6:8:c4::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.13; Thu, 15 Oct 2026 21:54:53 +0000
Received: from DS0PR12MB9059.namprd12.prod.outlook.com
 ([fe80::74da:85c:3e01:6ca3]) by DS0PR12MB9059.namprd12.prod.outlook.com
 ([fe80::74da:85c:3e01:6ca3%4]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 21:54:53 +0000
Message-ID: <f07f3f85-7fb7-4cf0-aa71-bca993aab78a@amd.com>
Date: Thu, 15 Oct 2026 14:54:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 19/19] accel/amdxdna: Implement runtime suspend and
 resume support
To: Lizhi Hou <lizhi.hou@amd.com>, quic_jhugo@quicinc.com,
 karol.wachowski@linux.intel.com, max.zhen@amd.com, ogabbay@kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: sonal.santan@amd.com, mario.limonciello@amd.com
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
 <20261009225343.3079074-20-yidong.zhang@amd.com>
 <ebcf212e-fadf-8661-565e-bb7b63afc46a@amd.com>
Content-Language: en-US
From: yidong Zhang <yidong.zhang@amd.com>
In-Reply-To: <ebcf212e-fadf-8661-565e-bb7b63afc46a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0101.namprd05.prod.outlook.com
 (2603:10b6:a03:334::16) To DS0PR12MB9059.namprd12.prod.outlook.com
 (2603:10b6:8:c5::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB9059:EE_|DS0PR12MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: 32057278-1dcb-425a-db61-08df2b06f173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|10067099003|11063799006|261009221227099003|261009223027099003|261009223327099003|261009221727099003|261009220027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: wrJEX2mv+h7cAZ26ayxLQJyzESOKdp0IwIlpT72eWcFgqJ1Ct8/vFpscJOSbOrOPm43g/NNfGTB4rDHgSJiLtthyW5kNf9faHEyq6Pmfk8SsH6O3a4Wj7UmFsczBBygVnPdW6QoIX/BD0QfXAVgHQsXaA2Yh2Kb16XLZWALDz9bdAA8+ErwfOroAqTfyZU5hLs2tJeRnzjNVbSlPVLLnONcaQ90ihFqCKOK4gCX+d4qc5I9rDBkW2tgSS+0NR9DNaCJmWQp5yW+MtoeFtSS9W+saS2sBlSZ06IRm9I2OlfnoYnGEPOv7YdqkuWknl5yVpYy5IKt1KUQMN0lDwB/oitk4i/parigll1VNfT7w5SJK9abVikMd1dT7Nn05SvfQkZgfoV4B7aYWo3O881/WEv6aNOHoqszgnBMf0N3Nc1+OitbgWloFfk2cislnjTjikd6jJIOZgfxcVoC7txLbcE182Fx2inBZ8Ryms7Zk26ahb19CRrHL9Xx1VeACvADT7zMjxUm7+4Ihwj8mgkdWeszbQKp0RiHhHyefzQk/+SXtQ3OahnXjv/n7uJr/2i2QoR3ucNlBoS4Pmalj9yAg2NYfkzMwbi6eMZd25iN6aVeXVXyHrsLJYjlw6F+nmvMT0m5FMalSpZSBm/di1ZaINDqXfELtOcKhnmV8cZLpIcg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB9059.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(11063799006)(261009221227099003)(261009223027099003)(261009223327099003)(261009221727099003)(261009220027099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVJnY1J1RzZkUDVOd3BYUUl5N2FhSHJ6K1M3ZFo0aHNMUklQeEsrcGJaYXdk?=
 =?utf-8?B?eDNybm1nQlV6Q3JoYTFIb0pkQkFudFB3bmx2dkNRUlhCai9hcmpGNWUvUDE0?=
 =?utf-8?B?NlI1U2FBZjRsdWlYaVhmUU5zQ1VRa0I1OENId0xabmJwY3VjYkNpM1RjN3pV?=
 =?utf-8?B?R1J0UE1HK1NiWkdmZUYzZ3pjZEsyN3N1enhXZWRBSk80M1ZYeGpCT0szZDRW?=
 =?utf-8?B?NE80eWtYYWoxTXp2cGVLUFkrR3RjS2w3MkVZMkxHaE95UncxQUlSZUpEYlQv?=
 =?utf-8?B?UVFwZENPODl4azdXMGc3clJsMTNMbytUdysxcW8xMStNYmZwcEU2b1BWamtY?=
 =?utf-8?B?OFYrU25mbVJtclpaQ0xkKzcyQ3FIcndpU1hzb1RRZXlYVVp3aTRRWkZBVTln?=
 =?utf-8?B?cGJMM2pSaUtUSEl1SXZGeDVObU1jNzJ0QkpTRm9kbTJSa1RkWXpKcmZaZDVv?=
 =?utf-8?B?NmhIczlxUUFxY040UkNPN0FyQWh5aCs2c3NJT2lIT1V1V0U0Vzk5UkQrdWtu?=
 =?utf-8?B?VWxkRXhMbGs2Vkdja2VXNXV0NkpDOTFBQXkzdERpazIwejgyYXBWSXIybGMz?=
 =?utf-8?B?RlFLM1N4OEFoL1N2VzY1eXF5cmsxZ0dIY2ZLeUc0TG5GVzMvSVVwZkswZ0Er?=
 =?utf-8?B?YktvYjQ5SXRKVGJCdTJYQjdxTUVWYUNGdW9QcmRWNHJ0WldZT0xrZ3pNYndt?=
 =?utf-8?B?KzJ5YkpSSFZ6T1JJWG53Nmw1ZjJMNDhublJMVzR5Z1lpcHhReVlpc3ZrSE5J?=
 =?utf-8?B?Y3hFRkhUZWJYVEJvVGJBamNMTVdMazFWZCtENm00V2VFdTBVUWZxNE5aODRR?=
 =?utf-8?B?MkF5WlZJSzFjLzhtS1VQQldnYUZOY3lmM3ZvNnV5YWhVNlJHWFhSNkhlbEJ5?=
 =?utf-8?B?QjdVWHlKTG85QW1sQjZBQ3o1OFhNYjJkVHVJc1Zndi9tWDNhWVc3R3NkSEU1?=
 =?utf-8?B?M1R2ZCtKN29DbzVvRTZJeVlaUUFLZlBSUHpZKy9NTXZyZHNUOFdEdHhQWWFS?=
 =?utf-8?B?RTBhWnZEb2dFVG1BelNtQkZQRlNESVZiSDkvR1FTYzR3REc5MmFHUXFOZm5z?=
 =?utf-8?B?TUorS0tIMjF5UzU2OGZMZjY2RC9Ua0I4UnI0czcyUk1kWmJ4WUhWb2dnUnNY?=
 =?utf-8?B?ZXRqKzZIenZyc0dTNUdhR01JOWpGUUpMWFZFRXBhVHN3cmpaMHNKam9kWHlM?=
 =?utf-8?B?bkJ4ZCtvdFhBbVVWQmtMS2VsT0xTcWZnZldvbTBzNmN6di9xNVRMcnFZdThW?=
 =?utf-8?B?YkNkUDJsQS9ERGVyYklEZ2hpRVNnNUUzaXBYVmFFMFRQUldEU0FTM28vaEVK?=
 =?utf-8?B?ZzM1WmNVWUdIZm9qYUdRVE9OSm5hRjFDZ2h1SStGMGV1WU9QY2Z6ZTVGcDZt?=
 =?utf-8?B?ejQ2U2szZXo3bTJhZnFlaXFVZ1pHWlR2OWpTbUpRR3M5aHdTRWdKMUhBQ1k2?=
 =?utf-8?B?VDBneWI1OGN0V2lSSCtSZVdaR0hEMVdvZENkc3BYa25OSFE0OEtDd2lscXMy?=
 =?utf-8?B?Q3pMVVhxNzBMSU95d0hpK1A1YW8zWndYZWlmK2o5VVpVMkx5SVNvL253ZlA0?=
 =?utf-8?B?VWRPaVhCSU1ON0dIczNhaXJST2REbENWK3Q0cU9yNi9oVXRzaXJSeVd1SGtD?=
 =?utf-8?B?YUFBVUFhSnJacXE2S0tMK2U5U0hNYW9HLzlkVnlLZDRQbEJmb2p3QUMvNFVr?=
 =?utf-8?B?VDhheUFUZUM2Mzd4eE94Tmt1d2xOVEJSR000Ly9Zc0tqeVFmdXd1Vk5DUTY1?=
 =?utf-8?B?K042cE94VGZMTFFlSGs5Z1kvMDYvOU1HcHdaRmQ4M0M4UERFakRuVVZBa29x?=
 =?utf-8?B?V0JNVG1pM1RSY0tZMm8rRUhWOVJabVZOOE9xMy9IV1BEeEFSaFlhLytrRzQy?=
 =?utf-8?B?a2RjeThZT2ZmVWs0MitVTjQ1Wlp6UVFrM3VFSTZIb1RqVFp0RnFkVDl3d08y?=
 =?utf-8?B?c0NCcm9mUFIrOUFtcDNzU3duUVBNOHExM1laTTNMYWRnbVZmV2VLbFJUSE9P?=
 =?utf-8?B?UUxyQ0dUTTNpSzFuNXVYdG9ON2hYNUtKaS9mSWNVVHorWHdSc1ZiUHVCbytD?=
 =?utf-8?B?UHJ5OVRCajl3NDhSTEJYWDVZQnlDNmdJMlY4aTBpZWNURGFMQmp3ZlhqbUNX?=
 =?utf-8?B?VkU1TWZVNHZhbUliRXRRdWZ5OGszZEJURlBjSGh6b3YwMnJMTnZKeDBZaTZM?=
 =?utf-8?B?SHhEUFBqYkl3anpoZTBRamhqRStiY1hUWDA4UWgxOEdVT2x5TEtTdlJUU0xl?=
 =?utf-8?B?VXo1RU8rNFJZZFlvdnZkRzZKaDZZYlIrWVZWNDBkWEI4RlJkS3pBWDJvTXA1?=
 =?utf-8?B?c1ZuZW8zS3U2cnY3SlJreVhOSU9qcUJtc28wTVZ2Q1hKbGFTZGZNdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32057278-1dcb-425a-db61-08df2b06f173
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB9059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 21:54:53.2136 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LXrOHGLGMci5eo5SJtc/N3En3fkIYixkTvy8WoHVomw3kFQIo/zlI7LrfwhW2jarPmNl3KWiFYvxVd2H4uEKFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6464
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


On 10/14/26 11:36, Lizhi Hou wrote:
>
> On 10/9/26 15:53, David Zhang wrote:
>> Add runtime suspend/resume for the AIE4 classic device by using its
>> system suspend/resume handlers.
>>
>> Runtime suspend returns -EBUSY for a device without runtime_suspend,
>> so the PM core keeps it active instead of entering an error state.
>>
>> A context suspended by runtime PM makes the command wait return
>> -EAGAIN. Resume the device in the wait ioctl and wait again, so a
>> command wait does not fail because of power management.
>>
>> Wrap .driver.pm and the AIE4 PM callbacks with pm_ptr(), so they are
>> discarded when CONFIG_PM is disabled.
>>
>> Signed-off-by: David Zhang <yidong.zhang@amd.com>
>> ---
>>   drivers/accel/amdxdna/aie2_pci.c        |  2 ++
>>   drivers/accel/amdxdna/aie4_ctx.c        | 10 +++++-
>>   drivers/accel/amdxdna/aie4_pci.c        |  4 +++
>>   drivers/accel/amdxdna/amdxdna_ctx.c     | 47 ++++++++++++++++++-------
>>   drivers/accel/amdxdna/amdxdna_pci_drv.c |  4 +--
>>   drivers/accel/amdxdna/amdxdna_pci_drv.h |  2 ++
>>   drivers/accel/amdxdna/amdxdna_pm.c      | 34 ++++++++++++++++++
>>   drivers/accel/amdxdna/amdxdna_pm.h      |  2 ++
>>   8 files changed, 90 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
>> index 690ad035463c..a3866e8933e6 100644
>> --- a/drivers/accel/amdxdna/aie2_pci.c
>> +++ b/drivers/accel/amdxdna/aie2_pci.c
>> @@ -1221,6 +1221,8 @@ const struct amdxdna_dev_ops aie2_ops = {
>>       .fini = aie2_fini,
>>       .resume = aie2_hw_resume,
>>       .suspend = aie2_hw_suspend,
>> +    .runtime_resume = aie2_hw_resume,
>> +    .runtime_suspend = aie2_hw_suspend,
>>       .get_aie_info = aie2_get_info,
>>       .set_aie_state = aie2_set_state,
>>       .hwctx_init = aie2_hwctx_init,
>> diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
>> index a2b6b0fa2934..a3f0a69b93b7 100644
>> --- a/drivers/accel/amdxdna/aie4_ctx.c
>> +++ b/drivers/accel/amdxdna/aie4_ctx.c
>> @@ -22,6 +22,7 @@
>>   #include "amdxdna_mailbox.h"
>>   #include "amdxdna_mailbox_helper.h"
>>   #include "amdxdna_pci_drv.h"
>> +#include "amdxdna_pm.h"
>>     #define CTX_INVALID_ID            (~0U)
>>   #define CTX_INVALID_DOORBELL        AMDXDNA_INVALID_DOORBELL_OFFSET
>> @@ -377,10 +378,14 @@ int aie4_hwctx_init(struct amdxdna_hwctx *hwctx)
>>       if (ret)
>>           goto destroy_lock;
>>   -    ret = aie4_hwctx_create(hwctx);
>> +    ret = amdxdna_pm_resume_get_locked(xdna);
>>       if (ret)
>>           goto umq_fini;
>>   +    ret = aie4_hwctx_create(hwctx);
>> +    if (ret)
>> +        goto suspend_put;
>> +
>>       priv->job_work_q = alloc_ordered_workqueue("aie4_job_%d_%d", 0,
>>                              client->pid, hwctx->fw_ctx_id);
>>       if (!priv->job_work_q) {
>> @@ -388,12 +393,15 @@ int aie4_hwctx_init(struct amdxdna_hwctx *hwctx)
>>           ret = -ENOMEM;
>>           goto destroy_ctx;
>>       }
>> +    amdxdna_pm_suspend_put(xdna);
>>         XDNA_DBG(xdna, "hwctx %d.%d init completed", client->pid, hwctx->fw_ctx_id);
>>       return 0;
>>     destroy_ctx:
>>       aie4_hwctx_destroy(hwctx, AIE4_HWCTX_NORMAL);
>> +suspend_put:
>> +    amdxdna_pm_suspend_put(xdna);
>>   umq_fini:
>>       aie4_hwctx_umq_fini(hwctx);
>>   destroy_lock:
>> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
>> index 70a052ab5f77..60140c3927a2 100644
>> --- a/drivers/accel/amdxdna/aie4_pci.c
>> +++ b/drivers/accel/amdxdna/aie4_pci.c
>> @@ -1041,6 +1041,7 @@ static int aie4_classic_init(struct amdxdna_dev *xdna)
>>       if (ret)
>>           goto free_work_buf;
>>   +    amdxdna_pm_init(xdna);
>>       return 0;
>>     free_work_buf:
>> @@ -1064,6 +1065,7 @@ static void aie4_vf_fini(struct amdxdna_dev *xdna)
>>     static void aie4_classic_fini(struct amdxdna_dev *xdna)
>>   {
>> +    amdxdna_pm_fini(xdna);
>>       aie4_classic_hw_stop(xdna->dev_handle);
>>       aie4_free_fw_log_buffer(xdna->dev_handle);
>>       aie4_free_work_buffer(xdna->dev_handle);
>> @@ -1408,4 +1410,6 @@ const struct amdxdna_dev_ops aie4_classic_ops = {
>>       .set_aie_state        = aie4_set_state,
>>       .resume            = pm_ptr(aie4_classic_resume),
>>       .suspend        = pm_ptr(aie4_classic_suspend),
>> +    .runtime_resume        = pm_ptr(aie4_classic_resume),
>> +    .runtime_suspend    = pm_ptr(aie4_classic_suspend),
>>   };
>> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
>> index 608b86fe8f6b..f4004630dc1b 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
>> @@ -761,13 +761,32 @@ int amdxdna_drm_submit_cmd_ioctl(struct drm_device *dev, void *data, struct drm_
>>       return -EINVAL;
>>   }
>>   +static int amdxdna_hwctx_wait_cmd(struct amdxdna_client *client,
>> +                  struct amdxdna_drm_wait_cmd *args)
>> +{
>> +    struct amdxdna_dev *xdna = client->xdna;
>> +    struct amdxdna_hwctx *hwctx;
>> +    int ret, idx;
>> +
>> +    idx = srcu_read_lock(&client->hwctx_srcu);
>> +    hwctx = xa_load(&client->hwctx_xa, args->hwctx);
>> +    if (!hwctx) {
>> +        XDNA_DBG(xdna, "PID %d failed to get ctx %d", client->pid, args->hwctx);
>> +        ret = -EINVAL;
>> +    } else {
>> +        ret = xdna->dev_info->ops->cmd_wait(hwctx, args->seq, args->timeout);
>> +    }
>> +    srcu_read_unlock(&client->hwctx_srcu, idx);
>> +
>> +    return ret;
>> +}
>> +
>>   int amdxdna_drm_wait_cmd_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>   {
>>       struct amdxdna_client *client = filp->driver_priv;
>>       struct amdxdna_dev *xdna = to_xdna_dev(dev);
>>       struct amdxdna_drm_wait_cmd *args = data;
>> -    struct amdxdna_hwctx *hwctx;
>> -    int ret, idx;
>> +    int ret;
>>         XDNA_DBG(xdna, "PID %d ctx %d timeout set %d ms for cmd %llu",
>>            client->pid, args->hwctx, args->timeout, args->seq);
>> @@ -775,22 +794,26 @@ int amdxdna_drm_wait_cmd_ioctl(struct drm_device *dev, void *data, struct drm_fi
>>       if (!xdna->dev_info->ops->cmd_wait)
>>           return -EOPNOTSUPP;
>>   -    idx = srcu_read_lock(&client->hwctx_srcu);
>> -    hwctx = xa_load(&client->hwctx_xa, args->hwctx);
>> -    if (!hwctx) {
>> -        XDNA_DBG(xdna, "PID %d failed to get ctx %d", client->pid, args->hwctx);
>> -        ret = -EINVAL;
>> -        goto unlock_ctx_srcu;
>> +    ret = amdxdna_hwctx_wait_cmd(client, args);
>> +    if (ret == -EAGAIN) {
>> +        /*
>> +         * Suspended by power management before the command completed.
>> +         * Resume the device, which reconnects the context, and wait
>> +         * again. Take the PM reference outside hwctx_srcu: runtime
>> +         * resume takes dev_lock, which hwctx destroy holds across
>> +         * synchronize_srcu().
>> +         */
>> +        ret = amdxdna_pm_resume_get(xdna);
>> +        if (ret)
>> +            return ret;
>> +        ret = amdxdna_hwctx_wait_cmd(client, args);
>> +        amdxdna_pm_suspend_put(xdna);
>>       }
>>   -    ret = xdna->dev_info->ops->cmd_wait(hwctx, args->seq, args->timeout);
>> -
>>       XDNA_DBG(xdna, "PID %d ctx %d cmd %lld wait finished, ret %d",
>>            client->pid, args->hwctx, args->seq, ret);
>>         trace_amdxdna_debug_point(current->comm, args->seq, "job returned to user");
>>   -unlock_ctx_srcu:
>> -    srcu_read_unlock(&client->hwctx_srcu, idx);
>>       return ret;
>>   }
>> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> index f5f7831c4e80..cb78f145ffa1 100644
>> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> @@ -465,7 +465,7 @@ static void amdxdna_remove(struct pci_dev *pdev)
>>     static const struct dev_pm_ops amdxdna_pm_ops = {
>>       SYSTEM_SLEEP_PM_OPS(amdxdna_pm_suspend, amdxdna_pm_resume)
>> -    RUNTIME_PM_OPS(amdxdna_pm_suspend, amdxdna_pm_resume, NULL)
>> +    RUNTIME_PM_OPS(amdxdna_pm_runtime_suspend, amdxdna_pm_runtime_resume, NULL)
>>   };
>>     static int amdxdna_sriov_configure(struct pci_dev *pdev, int num_vfs)
>> @@ -484,7 +484,7 @@ static struct pci_driver amdxdna_pci_driver = {
>>       .id_table = pci_ids,
>>       .probe = amdxdna_probe,
>>       .remove = amdxdna_remove,
>> -    .driver.pm = &amdxdna_pm_ops,
>> +    .driver.pm = pm_ptr(&amdxdna_pm_ops),
>>       .sriov_configure = amdxdna_sriov_configure,
>>   };
>>   diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
>> index 505477b4a292..4d047cf3d981 100644
>> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
>> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
>> @@ -57,6 +57,8 @@ struct amdxdna_dev_ops {
>>       void (*debugfs_init)(struct amdxdna_dev *xdna);
>>       int (*resume)(struct amdxdna_dev *xdna);
>>       int (*suspend)(struct amdxdna_dev *xdna);
>> +    int (*runtime_resume)(struct amdxdna_dev *xdna);
>> +    int (*runtime_suspend)(struct amdxdna_dev *xdna);
>>       int (*sriov_configure)(struct amdxdna_dev *xdna, int num_vfs);
>>       int (*hwctx_init)(struct amdxdna_hwctx *hwctx);
>>       void (*hwctx_stop)(struct amdxdna_hwctx *hwctx);
>> diff --git a/drivers/accel/amdxdna/amdxdna_pm.c b/drivers/accel/amdxdna/amdxdna_pm.c
>> index b1fafddd7ad5..7d7bc965342d 100644
>> --- a/drivers/accel/amdxdna/amdxdna_pm.c
>> +++ b/drivers/accel/amdxdna/amdxdna_pm.c
>> @@ -37,11 +37,40 @@ int amdxdna_pm_resume(struct device *dev)
>>       return ret;
>>   }
>>   +int amdxdna_pm_runtime_suspend(struct device *dev)
>> +{
>> +    struct amdxdna_dev *xdna = to_xdna_dev(dev_get_drvdata(dev));
>> +    int ret = -EBUSY;
>> +
>> +    guard(mutex)(&xdna->dev_lock);
>> +    if (xdna->dev_info->ops->runtime_suspend)
>> +        ret = xdna->dev_info->ops->runtime_suspend(xdna);
>> +
>> +    XDNA_DBG(xdna, "Runtime suspend done ret %d", ret);
>> +    return ret;
>> +}
>> +
>> +int amdxdna_pm_runtime_resume(struct device *dev)
>> +{
>> +    struct amdxdna_dev *xdna = to_xdna_dev(dev_get_drvdata(dev));
>> +    int ret = -EOPNOTSUPP;
>> +
>> +    guard(mutex)(&xdna->dev_lock);
>> +    if (xdna->dev_info->ops->runtime_resume)
>> +        ret = xdna->dev_info->ops->runtime_resume(xdna);
>> +
>> +    XDNA_DBG(xdna, "Runtime resume done ret %d", ret);
>> +    return ret;
>> +}
>> +
>>   int amdxdna_pm_resume_get(struct amdxdna_dev *xdna)
>>   {
>>       struct device *dev = xdna->ddev.dev;
>>       int ret;
>>   +    if (!pm_runtime_enabled(dev))
>> +        return 0;
>> +
>>       ret = pm_runtime_resume_and_get(dev);
>>       if (ret) {
>>           XDNA_ERR(xdna, "Resume failed: %d", ret);
>> @@ -55,6 +84,10 @@ void amdxdna_pm_suspend_put(struct amdxdna_dev *xdna)
>>   {
>>       struct device *dev = xdna->ddev.dev;
>>   +    if (!pm_runtime_enabled(dev))
>> +        return;
>> +
>> +    pm_runtime_mark_last_busy(dev);
> This should be removed. mark_last_busy is called by put_autosuspend.
>>       pm_runtime_put_autosuspend(dev);
>>   }
>>   @@ -66,6 +99,7 @@ void amdxdna_pm_init(struct amdxdna_dev *xdna)
>>       pm_runtime_set_autosuspend_delay(dev, AMDXDNA_AUTOSUSPEND_DELAY);
>>       pm_runtime_use_autosuspend(dev);
>>       pm_runtime_allow(dev);
>> +    pm_runtime_mark_last_busy(dev);
>
> This should be removed. 

Thank you. I will remove these 2 line of code in next version of the patch.

/David

>
> Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>
>>       pm_runtime_put_autosuspend(dev);
>>   }
>>   diff --git a/drivers/accel/amdxdna/amdxdna_pm.h b/drivers/accel/amdxdna/amdxdna_pm.h
>> index 3d26b973e0e3..02beef6448f1 100644
>> --- a/drivers/accel/amdxdna/amdxdna_pm.h
>> +++ b/drivers/accel/amdxdna/amdxdna_pm.h
>> @@ -10,6 +10,8 @@
>>     int amdxdna_pm_suspend(struct device *dev);
>>   int amdxdna_pm_resume(struct device  *dev);
>> +int amdxdna_pm_runtime_suspend(struct device *dev);
>> +int amdxdna_pm_runtime_resume(struct device *dev);
>>   int amdxdna_pm_resume_get(struct amdxdna_dev *xdna);
>>   void amdxdna_pm_suspend_put(struct amdxdna_dev *xdna);
>>   void amdxdna_pm_init(struct amdxdna_dev *xdna);
