Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7DC60705C3
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=GVDeanTW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8655810F239;
	Thu,  5 Nov 2026 19:38:53 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7D6710E360
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 19:38:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYAc+4RLEOYqhWDCP0IA6LUWIDU4o+4aVFLcpdJvpEBtOBVkGGBeNHIG7NwVBNHB25Am6/Usl+lPlDMtWAQwGXWJF25NgDtgTqfHyFIrUfpxHFohDBWZIHK1HJ5Fdvb/JKCanMKYnPDnWQLHGJrTs2YKBeyGLx0nA+id7hdmJrlGrT/ruLgA+XqW6ictlF61UCaJVAQGyPIeKH3g5RtKzL/SGBOcPua3kTuPMFpGFOHOek4hiZci6uHBlLlJIsrBWKwkjd4pA/F/3GxdISS+6WYoFbgEDiQ8CSsvM35MBIWP2iU6fVxppz3UHtVL/oILabolxJo5OTssik6J0TgacQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f224wI31v3llLai3IS32ULrwwPeR6i86anL7vhhmu6A=;
 b=i5HkeK+p5NQoLLB0DlxjXWqfjKgt6eXtczWAcsOhXE8isWuwMm4Y6fOvOlg02pHzdggCFO8Jz5sgHOYkGg2SHv0CjUPp9L66QeVfqRrl/zDmJmpTwMMi9xRSU/R46CWKEAeZlHnLcpvmzHAgVcyEDHADha+ZlSiv8fwW9hj53s69QK11cASdYuX+e3947ze2J0mwnXm4pBUqaezk7ro0EVMY+7TuXJbm+GMzShpqIXHQk/T6kNKr1NOQ3esdmJgA1JETk/JMWhhndD2pEE0Mm+eld2ptJI0Ks2aDJbgUN4/NtG9ITo+APHIIFSZRvuZ2BzBDOC7DriwpWRMtqrnLXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f224wI31v3llLai3IS32ULrwwPeR6i86anL7vhhmu6A=;
 b=GVDeanTW8IfuuyyOXfYGjMup6gLC5gzzJ+qWdOd10AcyAhkz87yF7Ivo7TE76Ih6oGQZ+u2NjQCzZqKrhA1d9ujqa8GXJ4hSEAm+TzYviU8B9GjRV1fUGLPIVnmvvWFbk7DGbqEbyQKtW7HSfNQWdqXmO8wkzj4Szl+28ClGoRM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 5 Nov 2026
 19:38:37 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 19:38:36 +0000
Message-ID: <0161e0ed-3b6a-496f-8502-6dcd219f3aca@amd.com>
Date: Thu, 5 Nov 2026 13:38:33 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/amdxdna: Load the aie4 firmware variant the PSP
 reports
Content-Language: en-US
To: "Zhang, Yidong (David)" <yidong.zhang@amd.com>,
 Lizhi Hou <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261105-superm1-lms-npu-v2-1-ad6704226d47@amd.com>
 <2cf0906c-9766-4e3c-bfd0-3390263f5390@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2cf0906c-9766-4e3c-bfd0-3390263f5390@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0410.namprd03.prod.outlook.com
 (2603:10b6:610:11b::22) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|DM6PR12MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d1a072-3fd6-43de-0efe-08df3b746227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|261102123227099003|56012099006|261026140227099003|11063799006|261026121527099003|261022115727099003|261022105027099003|4143699003|10067099003|261022075727099003|261028144727099003|261021121427099003|261009223027099003|260925021911599003|260925022911599003|261021123027099003|260925021311599003;
X-Microsoft-Antispam-Message-Info: tylvNDGkngzIuB7thnsAqijCdKTDHe/gUgmin2zNHCS5gpKdlstgD0ohq27kLRGpayD6fDsLRUfofDdm2XXuD4bhaqXZvD2e8wtXHZzNAEbbAQSoRzhvZGgJRU9sDcOfP89/Bna3exdIfW1Ghzn7lTDiRNiUcSoy7HnXgWA0Wv/etpiyO5L5paidCaSJu6idGmEbgBoEzXG9eH175w837RACmNxpuDarAflkMVjJXpE9a3uG4uTAMatrqIuSImDTLCOQezSJKxV6KWjy3VhNf0yhKnfEpnYtao/Vq0dsxMeEPPA5frJRySwP3pk44uC9awIOZ1C/d6O1hf+AEzQBlHjlXTnK78j91X2vzRuPlGhdlJK48+G2p6T9BX283aMeetnH9xkJMUCbw6zuEXo36bIouqz4TtV0GoB0/fQf9Q4B4akP1BrerV8lWljvo15rjPHhTU1j/cmv0oJQkX4bQhazi9pn3y4xGAP1Jn9ot7r6DC71wy0Lh/V5CchDvTlYoTL6l4CsFxcM1ICgCKLVzVCxXIi4VflsCTLsR9ZEJoqWYSe4fD+BvHGf8xRikVcAttALFR7ELisjcYFBOaqfj3M3m2qD8hWqZnCY/eC/aU3hXeUoPbzAZkjA/sSmvAk8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9174.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(261102123227099003)(56012099006)(261026140227099003)(11063799006)(261026121527099003)(261022115727099003)(261022105027099003)(4143699003)(10067099003)(261022075727099003)(261028144727099003)(261021121427099003)(261009223027099003)(260925021911599003)(260925022911599003)(261021123027099003)(260925021311599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDJvYVA4bXY3V0dRMDM4NXpwTXRYSE9qSWZHRDR5cUw4ay82VElQN29rZ2Zk?=
 =?utf-8?B?eVdLc0VRckRsenBWQnlUNHh6M1grWDJvUG8zVSt4ekJvZ0RESU91ZDk2N1RP?=
 =?utf-8?B?eXJJQmZab0pzOGNpbDk3NHByYTlBeUE3UURsVU1DaGE0NnY2U3RydTJkZGk4?=
 =?utf-8?B?RnNIQlM2OGFRd0xIT0h2Snp1NzJZSHV0Z0hWV3ZmRU9zNTJJcXJ4U1p1Z1Bw?=
 =?utf-8?B?TEJLOEZGYWREcEdJdDFyRkhtaXJDckk3bTE3dWdwd3p4S2NuZDFWWjY0clVI?=
 =?utf-8?B?dHp5SENaZUFUNnRrclR0ZWxRU1Y3eVdNQlVBN2pzTURPOGQ1aGh3NHFuVjZm?=
 =?utf-8?B?bHFncFBObSt1cEJ3OFBXKzVhUGpDalpPc2d4bDBtMHRjOHhuK0xaTmJSWnk4?=
 =?utf-8?B?WUlKczcveWpUTGRYY3RrR3BmM1oxNjROZFU5a1dmNHh4cTVqT2swMU9hTFVp?=
 =?utf-8?B?MElWL3p5bmlIbi9ET1l4bTl3V0d3VEduVTk5SVN1dzdEaDRFblBUbVAzcFhs?=
 =?utf-8?B?a3ptVUhrbm5LV3liYzBtMHJOUmNaVExnWlJiODQzdi9vVmhITGtLdThKRTZh?=
 =?utf-8?B?NFVTdUFzNkh1ZEZDd1VjamN5YWhlRWlsU1ZzeTQ1Uk5IaElPelhkem96VWkz?=
 =?utf-8?B?Rjhyd3k3VE01SUlORGczNFZpVDFhWXhJM095MEtranJsRnFIOWlQT3RkTllL?=
 =?utf-8?B?aE9sZTQzd1pMNTR2OVFKaytvRHQwSHlFT0VkZFgwYXRHdFJJS1Z6RkhJdzBD?=
 =?utf-8?B?MFFhQTdENllwc09QQWZxYVZvc1hibWlUY0p3YmhMZUdHUVB2V1c2WVRtdEU4?=
 =?utf-8?B?cmtWaUE4d2dONFdONEo2Y01LTDZyTGo5UzZUaVI4RkhYa1VsaGZuZHM2R0Fq?=
 =?utf-8?B?ZGhZYVcxeHZ3Z002OVhTUWNCVE43YUNGU2FmV0JKYlc3WlZUZVNxNytqT3gv?=
 =?utf-8?B?Z1ZLd3NDUVQ1TUo3eStVM1pPUG9HL1l5elRyOUE0d3BPSTZpbzJWTndVYUFz?=
 =?utf-8?B?TU85VFdnaXFKUm9CWHF5bmNWSnVSYnY3LzV0endhMmxEeEg5SEw2WFVlUi9t?=
 =?utf-8?B?OXpBUTdWZzZvaUdVa09LZ1ErOTdxSEdSOG80dTRuSjVYZER3WlBsdW9lK1BN?=
 =?utf-8?B?cUUrczJhT2dlczF2eHRkS0t4ZkFuenVWUnVrTTZqOVhkNjV0a2g4c3lpWGxZ?=
 =?utf-8?B?NWh0SS9OV3lVY2JBQVZBY0lwWVRMeXdsalBrN0ZTSHdUVlBhQUtzNEZ5Wmwv?=
 =?utf-8?B?b1VQcWI0Wlp6WHZzSHZBcUV4eEQ3MTZIVmlLc1VKRjM2d2dEVWpuNUt5b0lw?=
 =?utf-8?B?Q2d4MjNQQU5ZNGxMM2JnSnNSVmhWcndlOENvdW1WZ0dwajhqbHVWVTVYNmxy?=
 =?utf-8?B?bjd0ZjBORWNoYWQrQ1lkTVh6V09aN3Mya3pINGQ4TGYzNDBOMVRFT3Z4cFc5?=
 =?utf-8?B?elNoNzNPWmVNelZjRlBhQkhZTTAyOVdRazU0ZTBXKzVqUjhiVnd1eWJma3BE?=
 =?utf-8?B?VlNWWEV2MmNPSlVwb29HSndBY2JsM2tlVWZXYjY1M1d6QnpVMmlRdnNHaWh1?=
 =?utf-8?B?WVgxa29Va0RtcVViQjIyV0J3ZFdHMDVFZWk3TXhUWVQ1VCtoVUpKam42a3Vk?=
 =?utf-8?B?YVNwWGNMV0tEQVdkZTE0WkVTa2o2T085Sm9CaTF3Uno5ZElJdnplSFpLWW11?=
 =?utf-8?B?S1FzbzZ5NmJiVjJKejc2M3ZxQ1I3WGN2dGRIN2RUVTZaQjFNOXNFMGpVbERx?=
 =?utf-8?B?UXhtbVBuZTJJdDZ0b2RkazN0d2lTL0ZWbjU2TDA1NmI4cW9VaWQvRVBQcFVy?=
 =?utf-8?B?U1JQMFFtcUNUUnhwY3RBVWNrajRaSnp3cUZMNVFMc2FwWURLd2tsSGRNczIv?=
 =?utf-8?B?Z0RIdjNhS2RSSmxkOWZtbkI0NEdVcms4YmR6RHA1OFF4bElpMnFySVE0SE80?=
 =?utf-8?B?dnB4K2p2UmdYeXRCQ204WnVWSDF0NGF0TVNFUTBSVHlCeHdKRkhUYU9UK29R?=
 =?utf-8?B?ZHdxTDhGdUdiK1BGVm55allKcjM0eE5rNXBuS213dUthWGJ4dnpqT1dYUHps?=
 =?utf-8?B?MWNzTHJOQ1FjUi9UUlQ0QlppRjNpUDN0a3NIeXZQWFpReGxhZWVERE9xaXd2?=
 =?utf-8?B?RVJrNHRyM3FuV3NoZTArMmdYSVFzTTNia2tYYVJ4WnFyaUFIbkdTSFRWeHFX?=
 =?utf-8?B?RTVuWkVrR21TK3pQRDVtMklSNy9JTWcvOTJJbkpTUCt0KzFqdVRvNnZVYzNy?=
 =?utf-8?B?WGVzZ040OTloUEpYRnY5UVdTRXQ3V1VqYUVIeDRHcXBoOHJXUmVJQTVWdHVy?=
 =?utf-8?B?REI5d012UVppOVRLRERtWDRoMThWWFhLNWJ1S25CbE5YdFBtdjJxdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d1a072-3fd6-43de-0efe-08df3b746227
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 19:38:36.3806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nZ6FHTssiDi5YbSNDp67oCmEXR8f/9GO3nkOOwJsA2wzTilMGWm6qUcjfNlaSjTCDs2Pr832QM0eZRrTTzKYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/5/26 13:19, Zhang, Yidong (David) wrote:
> 
> On 11/5/2026 7:51 AM, Mario Limonciello wrote:
>> Some Platforms ship BIOS with either a default or an alternative trust
>> authority. The PSP validates the NPU firmware, so it must be signed with
>> the matching scheme. Firmware for the alternative scheme is named with
>> an "_l" suffix before the extension. A preproduction part needs firmware
>> of its own, named with a "_p" suffix.
>>
>> The PSP reports the signing type in bit 6 of C2PMSG_63, and in bit 28
>> whether this is a preproduction part. A preproduction part that also
>> reports the alternative scheme is not expected, so warn about it and
>> use the default firmware.
>>
>> Add MODULE_FIRMWARE() entries for the "_l" variants of the npu and cert
>> images of the aie4 devices so that initramfs generators include them.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> Changes in v2:
>> - Initialize val in aie4_psp_fw_variant() so a failed SMN read can't 
>> leave
>>    it uninitialized
>> - Only read the PSP firmware variant after the npufw/certfw path 
>> check, so
>>    VFs (which have no firmware paths) skip the SMN access
>> - Drop the redundant all-ones check, amd_smn_read() already returns - 
>> ENODEV
>> - Link to v1: https://patch.msgid.link/20261104-superm1-lms-npu-v1-1- 
>> dbffcc5abc23@amd.com
>> ---
>>   drivers/accel/amdxdna/Kconfig           |   1 +
>>   drivers/accel/amdxdna/aie4_pci.c        | 162 ++++++++++++++++++++++ 
>> ++++------
>>   drivers/accel/amdxdna/amdxdna_pci_drv.c |   8 ++
>>   3 files changed, 141 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/Kconfig b/drivers/accel/amdxdna/ 
>> Kconfig
>> index eddff490b4f75..cd17a89cf4146 100644
>> --- a/drivers/accel/amdxdna/Kconfig
>> +++ b/drivers/accel/amdxdna/Kconfig
>> @@ -6,6 +6,7 @@ config DRM_ACCEL_AMDXDNA
>>       depends on DRM_ACCEL
>>       depends on PCI && HAS_IOMEM
>>       depends on X86_64
>> +    depends on AMD_NODE
>>       depends on AMD_PMF || !AMD_PMF
>>       select DRM_SCHED
>>       select DRM_GEM_SHMEM_HELPER
>> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/ 
>> aie4_pci.c
>> index 02dcb2f813d45..26c6162893760 100644
>> --- a/drivers/accel/amdxdna/aie4_pci.c
>> +++ b/drivers/accel/amdxdna/aie4_pci.c
>> @@ -11,6 +11,8 @@
>>   #include <linux/debugfs.h>
>>   #include <linux/firmware.h>
>>   #include <linux/sizes.h>
>> +#include <linux/string.h>
>> +#include <asm/amd/node.h>
>>   #include "aie.h"
>>   #include "aie4_msg_priv.h"
>> @@ -558,46 +560,124 @@ static void aie4_classic_hw_stop(struct 
>> amdxdna_dev_hdl *ndev)
>>       aie4_fw_stop(ndev);
>>   }
>> -static int aie4_request_firmware(struct amdxdna_dev_hdl *ndev,
>> -                 const struct firmware **npufw,
>> -                 const struct firmware **certfw)
>> +/*
>> + * PSP C2PMSG_63 (SMN) bit 6: 0 = default firmware signing, 1 = 
>> alternative
>> + * PSP C2PMSG_63 (SMN) bit 28: 0 = production part, 1 = preproduction 
>> part
>> + */
>> +#define AIE4_PSP_C2PMSG_63_SMN_ADDR    0x38109fc
>> +#define AIE4_PSP_FW_SIGN_ALT        BIT(6)
>> +#define AIE4_PSP_FW_PREPROD        BIT(28)
>> +
>> +enum aie4_fw_variant {
>> +    AIE4_FW_DEFAULT,
>> +    AIE4_FW_ALT,        /* "_l" images */
>> +    AIE4_FW_PREPROD,    /* "_p" images */
>> +};
>> +
>> +/*
>> + * The PSP only trusts firmware signed with the scheme the platform 
>> firmware
>> + * uses and a preproduction part needs firmware of its own. Reading 
>> which one is
>> + * in use is optional and only used as a hint for which images to try 
>> first:
>> + * anything but a clear answer is treated as default.
>> + */
>> +static enum aie4_fw_variant aie4_psp_fw_variant(struct amdxdna_dev 
>> *xdna)
>>   {
>> -    struct amdxdna_dev *xdna = ndev->aie.xdna;
>> -    struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
>> -    char fw_name[128];
>> +    u32 val = 0;
>>       int ret;
>> -    ret = snprintf(fw_name, sizeof(fw_name), "amdnpu/%04x_%02x/%s",
>> -               pdev->device, pdev->revision, ndev->priv->npufw_path);
>> -    if (ret >= sizeof(fw_name)) {
>> -        XDNA_ERR(xdna, "npu firmware path is truncated");
>> -        return -EINVAL;
>> +    ret = amd_smn_read(0, AIE4_PSP_C2PMSG_63_SMN_ADDR, &val);
>> +    if (ret) {
>> +        XDNA_DBG(xdna, "PSP firmware variant not available, ret %d", 
>> ret);
>> +        return AIE4_FW_DEFAULT;
>>       }
>> -    ret = request_firmware(npufw, fw_name, &pdev->dev);
>> -    if (ret) {
>> -        XDNA_ERR(xdna, "failed to request_firmware %s, ret %d", 
>> fw_name, ret);
>> -        return ret;
>> +    if ((val & AIE4_PSP_FW_SIGN_ALT) && (val & AIE4_PSP_FW_PREPROD)) {
>> +        XDNA_WARN(xdna,
>> +              "Preproduction part with alternative signing, using 
>> default firmware");
>> +        return AIE4_FW_DEFAULT;
>>       }
>> -    ret = snprintf(fw_name, sizeof(fw_name), "amdnpu/%04x_%02x/%s",
>> -               pdev->device, pdev->revision, ndev->priv->certfw_path);
>> -    if (ret >= sizeof(fw_name)) {
>> -        XDNA_ERR(xdna, "cert firmware path is truncated");
>> -        ret = -EINVAL;
>> -        goto release_npufw;
>> +    if (val & AIE4_PSP_FW_PREPROD)
>> +        return AIE4_FW_PREPROD;
>> +
>> +    return (val & AIE4_PSP_FW_SIGN_ALT) ? AIE4_FW_ALT : AIE4_FW_DEFAULT;
>> +}
>> +
>> +/*
>> + * Images for the other variants have a suffix before the ".sbin" 
>> extension.
>> + * Returns -ENOENT if @path has no such variant.
>> + */
>> +static int aie4_fw_name(struct amdxdna_dev *xdna, char *name, size_t 
>> size,
>> +            const char *path, enum aie4_fw_variant variant)
>> +{
>> +    struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
>> +    const char *suffix;
>> +    size_t len, base;
>> +    int ret;
>> +
>> +    ret = snprintf(name, size, "amdnpu/%04x_%02x/%s",
>> +               pdev->device, pdev->revision, path);
>> +    if (ret >= size) {
>> +        XDNA_ERR(xdna, "firmware path %s is truncated", path);
>> +        return -EINVAL;
>>       }
>> -    ret = request_firmware(certfw, fw_name, &pdev->dev);
>> -    if (ret) {
>> -        XDNA_ERR(xdna, "failed to request_firmware %s, ret %d", 
>> fw_name, ret);
>> -        goto release_npufw;
>> +    switch (variant) {
>> +    case AIE4_FW_ALT:
>> +        suffix = "_l.sbin";
>> +        break;
>> +    case AIE4_FW_PREPROD:
>> +        suffix = "_p.sbin";
>> +        break;
>> +    default:
>> +        return 0;
>>       }
>> +    len = ret;
>> +    if (len < strlen(".sbin") || strcmp(name + len - strlen(".sbin"), 
>> ".sbin"))
>> +        return -ENOENT;
>> +
>> +    base = len - strlen(".sbin");
>> +    if (strscpy(name + base, suffix, size - base) < 0)
>> +        return -EOVERFLOW;
>> +
>>       return 0;
>> +}
>> +
>> +static int aie4_request_one(struct amdxdna_dev_hdl *ndev, const 
>> struct firmware **fw,
>> +                const char *path, enum aie4_fw_variant variant)
>> +{
>> +    struct amdxdna_dev *xdna = ndev->aie.xdna;
>> +    struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
>> +    char name[128];
>> +    int ret;
>> +
>> +    ret = aie4_fw_name(xdna, name, sizeof(name), path, variant);
>> +    if (ret)
>> +        return ret;
>> -release_npufw:
>> -    release_firmware(*npufw);
>> +    ret = firmware_request_nowarn(fw, name, &pdev->dev);
>> +    if (ret)
>> +        XDNA_DBG(xdna, "firmware %s not loaded, ret %d", name, ret);
>> +
>> +    return ret;
>> +}
>> +
>> +/* The NPU and cert images are validated together, so both use the 
>> same variant */
>> +static int aie4_request_firmware(struct amdxdna_dev_hdl *ndev,
>> +                 const struct firmware **npufw,
>> +                 const struct firmware **certfw,
>> +                 enum aie4_fw_variant variant)
>> +{
>> +    int ret;
>> +
>> +    ret = aie4_request_one(ndev, npufw, ndev->priv->npufw_path, 
>> variant);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = aie4_request_one(ndev, certfw, ndev->priv->certfw_path, 
>> variant);
>> +    if (ret)
>> +        release_firmware(*npufw);
>>       return ret;
>>   }
>> @@ -645,18 +725,40 @@ static int aie4_prepare_firmware(struct 
>> amdxdna_dev_hdl *ndev,
>>       return 0;
>>   }
>> +/*
>> + * The firmware can only be started once. It is the PSP that decides 
>> whether it
>> + * accepts the images, and it does that when the firmware is started, 
>> so there
>> + * is no trying a variant and falling back. Pick the variant that the 
>> PSP
>> + * reported (the default one if it can't be read) and use the others 
>> only if
>> + * its images are missing.
>> + */
>>   static int aie4_load_fw(struct amdxdna_dev_hdl *ndev,
>>               void __iomem *tbl[PCI_NUM_RESOURCES])
>>   {
>> +    struct amdxdna_dev *xdna = ndev->aie.xdna;
>>       const struct firmware *npufw, *certfw;
>> -    int ret;
>> +    enum aie4_fw_variant order[3], hint;
>> +    int i, n = 0, ret = -ENOENT;
>>       if (!ndev->priv->npufw_path && !ndev->priv->certfw_path)
>>           return 0;
>> -    ret = aie4_request_firmware(ndev, &npufw, &certfw);
>> -    if (ret)
>> +    hint = aie4_psp_fw_variant(xdna);
>> +    order[n++] = hint;
>> +    if (hint != AIE4_FW_DEFAULT)
>> +        order[n++] = AIE4_FW_DEFAULT;
>> +    if (hint != AIE4_FW_ALT)
>> +        order[n++] = AIE4_FW_ALT;
>> +
>> +    for (i = 0; i < n; i++) {
>> +        ret = aie4_request_firmware(ndev, &npufw, &certfw, order[i]);
>> +        if (!ret)
>> +            break;
>> +    }
>> +    if (ret) {
>> +        XDNA_ERR(xdna, "failed to load firmware, ret %d", ret);
>>           return ret;
>> +    }
>>       ret = aie4_prepare_firmware(ndev, npufw, certfw, tbl);
>>       aie4_release_firmware(ndev, npufw, certfw);
>> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/ 
>> amdxdna/amdxdna_pci_drv.c
>> index f233eb70a2957..dab8603e2381f 100644
>> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> @@ -37,6 +37,14 @@ MODULE_FIRMWARE("amdnpu/17f1_13/npu.sbin");
>>   MODULE_FIRMWARE("amdnpu/17f1_13/cert.sbin");
>>   MODULE_FIRMWARE("amdnpu/17f2_13/npu.sbin");
>>   MODULE_FIRMWARE("amdnpu/17f2_13/cert.sbin");
>> +MODULE_FIRMWARE("amdnpu/17f1_10/npu_l.sbin");
>> +MODULE_FIRMWARE("amdnpu/17f1_10/cert_l.sbin");
>> +MODULE_FIRMWARE("amdnpu/17f2_10/npu_l.sbin");
>> +MODULE_FIRMWARE("amdnpu/17f2_10/cert_l.sbin");
>> +MODULE_FIRMWARE("amdnpu/17f1_13/npu_l.sbin");
>> +MODULE_FIRMWARE("amdnpu/17f1_13/cert_l.sbin");
>> +MODULE_FIRMWARE("amdnpu/17f2_13/npu_l.sbin");
>> +MODULE_FIRMWARE("amdnpu/17f2_13/cert_l.sbin");
> 
> 
> I tested against both _l, _p and default sbins. All passed.
> 
> Reviewed-by: David Zhang <yidong.zhang@amd.com>
> 
> Tested-by: David Zhang <yidong.zhang@amd.com>
> 
> /David
> 
>>   /*
>>    * 0.0: Initial version
>>
>> ---
>> base-commit: e32e83a6c5ec031a7f59d4794113d8484b220254
>> change-id: 20261104-superm1-lms-npu-6bc3bbe38c29
>>
>> Best regards,
>> -- 
>> Mario Limonciello <mario.limonciello@amd.com>

applied to drm-misc-next


