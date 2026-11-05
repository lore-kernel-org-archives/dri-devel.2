Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6685D606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KPdWAQx5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCC8110E30A;
	Thu,  5 Nov 2026 17:52:36 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 591C010E30A
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 17:52:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIhLAOasj2LVQvfTLiHA3lCBeAB8mEBz52MKlBmdFjPC4kNP8+CFo9EEmMUyQTQqK26fnU9ezup6ixmg5NCoVguI9oHtU4bLdyS/NxgTRtBQs1RRlWnN06q9ihPMlUwpayJdacZuzxbhPskNK9nyV42ZTuC8rf507VDRg6mp+DYvDGcDhzL41u1/xqOMIDjQ41+RbsUHYK6piLAKlk2q62o4AWhIGAn2aJXvyZKvq4sg4Yz+jje4E1UwcKkeIQkaDu4KC9Xz/TMmyRHRerugx81OBTzTdYxXoA+kENgojXW1yUIHbfeASZ2h6xDJ7u/d3mvlmghcvQHvA7fFUbg/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50nPFRXRnBFn8Zx5v3yf5gXABfHFg/x/IWnNUu7chhw=;
 b=gSSme+S1PpgezqBE7xAoH0Dq+lVWdfc90iGjG77tOjN8YVYy5Jc/LZjuQ9SuKcZLxot2urY8WbaR7zyvKObxMF3P4qn8669cDmadrzn4T81nn1ge/uvfp6fsfa30S4fdIVghrd7WBpgNV5qhYIjDgxItinkWPX0HHGzYXOW+JSkJWxJM+Y2vmA0lBPmTTa+ynvW8u8nzvncL6ynZ7Q+Dx93yfc//wSCkYrRh+2QtUDxNq07JUsYtKJHVyZpfeUiCuq6YRyU450IJITlvoUa1p+hIRtt5EMloLzhzrzrzrJLZTMG/TCeFjxeUoqAoMVhuJMzJKvAzvugrcAW+6xXEZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50nPFRXRnBFn8Zx5v3yf5gXABfHFg/x/IWnNUu7chhw=;
 b=KPdWAQx536YPZFTgqdftlLejFzp/KMknI9OvUjqXRHaTsVrkuyXS8OZzfRcP2U5uVX9E9Ugh0St5oR6fhP6BitB6S5khtYB9Yr2IAZecvkx2MaQWHDJF6E/TmP1VE3eGrk7ptFxWufl2LTtg3SJ/+nC6fvTYiLsPtZuyhqeDgUs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by SJ2PR12MB8136.namprd12.prod.outlook.com (2603:10b6:a03:4f8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 17:52:21 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 17:52:21 +0000
Message-ID: <d8287036-7b05-41b3-bc99-3d351a3bce90@amd.com>
Date: Thu, 5 Nov 2026 11:52:19 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/amdxdna: Load the aie4 firmware variant the PSP
 reports
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261105-superm1-lms-npu-v2-1-ad6704226d47@amd.com>
 <18efa128-ffd5-793c-fe4e-6538d6eacd24@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <18efa128-ffd5-793c-fe4e-6538d6eacd24@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0047.namprd07.prod.outlook.com
 (2603:10b6:610:5b::21) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|SJ2PR12MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: b248e1fd-9c0a-4619-6028-08df3b658aa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|22082099003|18002099003|56012099006|4143699003|11063799006|261026140227099003|261026121527099003|261022115727099003|261028144727099003|261021123027099003|261102123227099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|260925021311599003|260925022911599003|260925021911599003;
X-Microsoft-Antispam-Message-Info: BkOP+fMvatNkWt/z3YZsY4VDYTbtF07QWHFuppcZ3W4kt/uo+aRk3lK5o097zmEsDkaXeoXFs26qgJ/54E0bFLpXWStd7VszMvu4Vm5aA15BFWNi6aTgjd6chSnBvRUmMGppyXexFQSbZogyyHx+0D/MS8586xpHEviK/T7TRxJ3V3MpjqXCWQFpHsBtqK/YXbM/RHQuvoH/jNrR1ZD+XlxByo4f1yq+1XExW/LatyZnmY+/V2UULDLJVnrXXm037Jx50c8SHwHzvOc3aBmA4gwP0gv5SGgEpW1RARw/id2G7Dd5JPOuMZqm598AqttMLsPlLTCQ7bL9pIVdoLbmqD1W05OtD2zPCzFTipyh5TNX1qLj2mG4G36VswhancYuIbdKM6S7tprZ1g4QAsS5IsPTUNr0Qv0NVLf7MXO18hqxeauRFb2mJfd6QexjijLrJfXKj1k96HnkhbVQ9fHDRa6bEqHEG5u3xh8rIm+k7gGv77EUcT9vXs7U5NfUtu2MjH4HrmvaoTYQXe2/2UnP5GftKwPFuaF7Aej7suZeSjINd8NHOgnvSSUj/yNrt6n6mjR97jcZ3r7AavLK3Kd8yWJsE+KiPmG8MsGrp+omqGc9wHqFtpCyMxu1RhppPe+l
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9174.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261026140227099003)(261026121527099003)(261022115727099003)(261028144727099003)(261021123027099003)(261102123227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(260925021311599003)(260925022911599003)(260925021911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejVtaFUyRklBRTM0T2lVbDB2RFcxVnBhdFpXQjd4RHpUcVBvYlRLQWxpQ2k4?=
 =?utf-8?B?dXJVVTljVExDWnJXSDlXS0tVS2UwTjNtNUw2S0t1cHRmRHQxWWtlTXpmK1ln?=
 =?utf-8?B?Ukx2YVZWejcyeXgza0JpaFJib3pONi9vMG5ZM2FLOWFwekdoVXRNL3p2SUQr?=
 =?utf-8?B?WW5PeEFmNmp2VVFlKzIrTTljaXhsMVhnMmNQeUpBVGxtMjhWYVF0MzNpeGE4?=
 =?utf-8?B?T0pPclB3QzN5MWNMejJTZEF4a2UxdG54YmJGcS9aZkYycVVSTXhRR29xaEl6?=
 =?utf-8?B?azd4dzZla2Y0WUs4aWd4amo1bFpxQktsdVplTkhHZ3lpSUJMYmErVVNldkI5?=
 =?utf-8?B?ZnlwZFdqODlYZkZmRFR0WjNhZFl6ZVJiaURVRS82TmtnckRLcG5USEdTUWtB?=
 =?utf-8?B?UVhUWXdJSWZEeVBKVEtrV1NmU0Fza1ZtU1RlQSszYjRmcmJId3p5WHR2S2d0?=
 =?utf-8?B?Um9FUWd6MTJqbzgwNXNGdkVvblo4REpYcDNjYno0WnlvY2dqdldJYm9tRlV0?=
 =?utf-8?B?ZXNlajRKTWEybjB5NzA5Ymp6ckpoZW82UWZGS1F6bWVzbHFxKzU3ZHZUdkVi?=
 =?utf-8?B?a3J2SC9Nb0tSN3ZQT1IwWExyRERxYWhER21oZ3ZwZzIycGlQOEJCcmZLeWtM?=
 =?utf-8?B?eXAwdzNhbXdVMDlnUEQ1RGgvTEJTMzVDRG1tdDI5c2gza05zczQ0cjRqbnNG?=
 =?utf-8?B?aUM5dlZjTWptUUhsVmw4N2FpVHlOemFWQnNoRnIyNFBuM3FlMnhhemNoQ2Vk?=
 =?utf-8?B?S3I1YXdmYy82Y1dZYWZaenNuNUlBemRWenVnRTNleldvaU1MVVpJUTlyREdJ?=
 =?utf-8?B?L1prTnNqa1VWMjVhWTJuSk9PVXJPTHVYdDQ0VXVXNmJYc2xqZWNjRjNjYXh2?=
 =?utf-8?B?Y3lzUVVNMzhNcmZrOGJOcVlaWWNUc3hvckNZdG9oS0RwSUhHa3pxMzJXM1VQ?=
 =?utf-8?B?UjNSdDVVNzJCbGZ2WTQ4U1piNHg0aG1EbkZtWEZ3M0tXcDJqUnV1YnBQMjQ5?=
 =?utf-8?B?NURBd25EeE5QM0V6MDBCR3BwSmc4TWt1Yzhmb3d0aWxHNGpyYk9QTmdzQ011?=
 =?utf-8?B?ZXlXVUhGazZaeXBVaHhEOUc5VWdoajU5bEhOK0FVUUZJWDFnWXE3QVAzY3BQ?=
 =?utf-8?B?ODU1NVk2ejJsd0RqMGROY1E5a3JUdHNwMFA0U1puSmNZN2RqZ2VXM3VkUzMr?=
 =?utf-8?B?cHl3dThPcWlPWjNqSzhRTE4zYVZ6bTd1c2NuWloxT2J5MmJSNkFYYndvWmF5?=
 =?utf-8?B?V1RLZzRDdGNEeDFjK2ViR21POUF0aDBMeW5oaGI0NjUxSnBxMTZubGQyRzF0?=
 =?utf-8?B?WVZuUmlvdjVOb013MEtUc2Z0S1ovRTlUa2premI4aTdTdkVaOXB0YlllcnIx?=
 =?utf-8?B?cmJjUkN1TzFUTHJGU0QxUk0wdTN4c1dZNVlybTJyU0htRm9OTC94dDl4blJ6?=
 =?utf-8?B?c09ld3FyejAvNTRRR0psK2c5ajZpV2FsaDFHRnJvcWwrNlN0STVXQ0FsZ1RD?=
 =?utf-8?B?Q2dHdjBhNk1Xd3NacGdvcXlBRVFHNzhVZEZPMXBGOGZ5ZzVDRWRQeUJJWGVP?=
 =?utf-8?B?MTlCTnJoZWhOS2MzSThMWE15RTlRU0YvNncyQjVmaThsTWtQQzJINGVKZWtO?=
 =?utf-8?B?L0JQK1J3S21kdzErTEpRWld2M0tJb2NZYmovZXkxejhUWWVLMEtuZldqdno3?=
 =?utf-8?B?YXE3ZVh4WUR0SW4yNjhaaE9OS1JyUFFzeHlHL3BYYktzVldqb0NYaGZRTndC?=
 =?utf-8?B?YU1UTnFOREhsclpzdE9BSElJeXlQM2dubkY4S3k3T3A3ZzdITEZCTDlSMmRD?=
 =?utf-8?B?M0VhNVNTTTN2cmtJUlRlY1ptV1loYllSeDJCVWt6YUZ5R29ZVVNWQ2NJb0Ro?=
 =?utf-8?B?anBNckt1UHhNVVZJMUhST3VXUXYrSGdxOCswL1FydzF6cDVLZHEwTlBkaEpv?=
 =?utf-8?B?ODhKZm42WHFXZEJyZmxPVWthb0paeFltODNFQ3FSazhwL2JOR0g0a1NBQWIv?=
 =?utf-8?B?cm83ajUzK3IwNG92a1ZwdnR2bU8rUE9OallIRUQvakdLT1hsUkJsQktYSlEz?=
 =?utf-8?B?YlBGYXIzbk42V3V4TFNKV2tNM2NRbGhmb3YyeUlKNVN0bUthNzZOSW9hRzIw?=
 =?utf-8?B?b0Jvb0NUcTN5aCsvb0pNQjY4aXZZV1c5QXhXejZwM1hxSjBSS2NCU1JNSjFC?=
 =?utf-8?B?bG5FaitVN3VPSlZ5ZlExM05qZEdDUVQwczBxc010ZUEyZnFxNHdNb1lodmVZ?=
 =?utf-8?B?Sm0rMU1PNzI0SHdXNUt3YTgxdTFNTjRWb05wZVU5VHZDYUl0RlhOZGVLWXE3?=
 =?utf-8?Q?1qkOj9Vm41aOBV0+UN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b248e1fd-9c0a-4619-6028-08df3b658aa1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 17:52:21.5878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLb3viU7EcLbx2hW5SvAQZ1scvWls1WWSKC8lYhqFfpVVUDX5b0R8Aj2eRHSwJxiB/S5IEoekl8R/LlpvIXVWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8136
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/5/26 11:47, Lizhi Hou wrote:
> 
> On 11/5/26 07:51, Mario Limonciello wrote:
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
> need to add entries for "_p" images.

Let me tell you my thought process in excluding them.

They are only for pre-prod hardware, and so *most people* who use this 
driver after the product launches shouldn't need them in their 
initramfs; they'll just bloat the initramfs.

If you think they should still be there; I'll spin a v3 an add them.

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
>>

