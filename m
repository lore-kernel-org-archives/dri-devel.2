Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E97CC44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:40:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B43010E627;
	Wed,  8 Jul 2026 16:40:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zs9ECW5I";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010000.outbound.protection.outlook.com
 [40.93.198.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB19410E117;
 Wed,  8 Jul 2026 16:40:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuobJjxoVNY7kZuci4Ydq8V6UA35zAhAJCqg1zU+DI67bDDt4KSgNLjWAJDEbEBpfFMj7vlj+eiHZs4vn7mkejlzLvDwgvXOgNskhiIIvFq+Af2/3PmmpKmQauzj8TZJMMH3aIPBVCO6gtGTUFcUqqSqgLboJlfZnlNeWmWZoRwNel+FMMflYUiaCVi5crQ7oIKWyu+uAbkosTqVJP46dv2U1Bszzo2GiqLxDl10WMj0NrVGqYQLr5CdekiYtHyn5KGTVbtl/PfQHX2JaILSX2dy7I6hROrJN1cCGd5RkbNDKiU6bR+2RupAZc7DtCOIgt5viuOatQKSLWh4Dn0eLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JeWoinbeDXfBAFNHuyRfjJFo/VZYVjGd5gNJcLrMT24=;
 b=upuGsrsh2ukQ8hWONq7TRDJPF9Gq+Pk9PXwKPGSR7Lorp9sUtRzZOoq3+eOe4Em80XzisBlp4aYbq7MuAjN1y4QKP0chcofr2pyTiu9knZTLQCDE7dFmUWuJx4twUUWGGkkNA99G1FgvBnqiZn0oeX4Qik1tFRCAzzGDvUIFYT8QycY8kNqHEiVbERsHSacFV8gxCPSZ/EChlxtTxxadc8Ky9+lWUZ5/zl5nloSelZZBYUN8xayK2//VVSaiv76RWIYwQmyNrBhkVTmhZ+dFhjoI9TSClA7bM3MrVklJ7fMUJAC1kWytkJEGsV+8nDteydQZkx0WRIRuK1Z4E7smNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeWoinbeDXfBAFNHuyRfjJFo/VZYVjGd5gNJcLrMT24=;
 b=Zs9ECW5IC5gubLZm2jy25HcHsJqfoWALKuqVuU9AM2BrNZttwgpyCypo9M580U/+1o61l+hqdCGkhh49VaW5aFtdKmQzHwH5DV6ZGqqb4asDE5qF0n1aWEt+WG78bPBu0yimll3i4U6w4FO2LnXKDLFUF+Q3HzHgVO6mrk28IlQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DM4PR12MB6565.namprd12.prod.outlook.com (2603:10b6:8:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Wed, 8 Jul
 2026 16:40:02 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 16:40:02 +0000
Message-ID: <bc1dbadd-a3ea-4ff9-826e-6826c20bb54e@amd.com>
Date: Wed, 8 Jul 2026 11:39:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/amdgpu: add firmware file fallback for APU
 VBIOS discovery
Content-Language: en-US
To: Oz Tiram <oz@shift-computing.de>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <716a31c5-0484-4ef9-b49e-b71310f92d86@amd.com>
 <20260705100436.6877-1-oz@shift-computing.de>
 <a8339282-e3ef-4a4f-a135-968f94855e76@amd.com>
 <42e07bbb-9384-4871-a345-e0fd6c00a772@shift-computing.de>
 <bd1f1632-f53d-4bfd-9d28-5b66e466366c@amd.com>
 <80f34509-9781-421e-b60f-1b8c772a01a9@shift-computing.de>
 <8dd56d76-e46d-43b6-831d-27e66fa2879a@amd.com>
 <cc849fb3-224e-43c0-bc50-67fd025009e7@shift-computing.de>
 <0478bdcd-dc55-4eeb-b7a3-6c5e625ac5c1@amd.com>
 <6e2eaccf-823b-4db2-a4f3-451e5753af8d@shift-computing.de>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <6e2eaccf-823b-4db2-a4f3-451e5753af8d@shift-computing.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR19CA0030.namprd19.prod.outlook.com
 (2603:10b6:610:4d::40) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DM4PR12MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: 745c6c10-2a97-40d3-e232-08dedd0f8e6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|4143699003|22082099003|11063799006|18002099003|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info: HbBEZwWqP6fw7w1/QqfHndKwI1jsG7T6ttyh5atmZBBkgQMJEi367gBoi3AZO23LJer6Ugt4wUSP2K9OsuaSF7rzVioOSCqkEjmF+Wcufx0IUO8DOO3LHik4H51xIphCbuPAS3W/O3Vc8/FLg6W1tF6OKt855cgXy+uomgI3xQR4RmJ5icJOI5kpo/0zdvoK37V9EVqjtLjC0xcXL0BcLI/XYnMAATGzXW2G3Y90cV2fE39RJnoUNvj6kJ/i2uUM9BSm+WoG2BxkWxi9v8AFZ0pW4E8RZoC8x20DqUzrmIkNGAtaOPJ2Hx/+Ak8Coy79TfzvZLwrFFKGBZ+X6pfkGqO33lE6Tv7tsO2mO+o+4DbbbX4tP9tYQ3Y08Kw4nKsSlSh3kj7bX/G5ribatcCIhW3g3srJx6rq2omcLFdu8qbWqFBIMh7GQFS5BQctVcvmEyAI47e907JE4vPGwSXvbYeUK/azmtMi9lGgQNk98XSk5440J7IC1GGLnzK2hXC5ZHQ51tKCAHTJ8ADpKl3rNAhaWJbxL1L/z7GsEHR5eqbf7xfO343IsXU3/s43rYDwV/CIhncKqfD8KYg6NQx2YnqRr7oWEGozzpn3kAwfPiVs9cgG+iJz3D77jfKHmStzAUkkOHKTPjzqGt5RnQPeyLGTUKnYqlx91QdiLXdTiUA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(4143699003)(22082099003)(11063799006)(18002099003)(5023799004)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WS8wMC9BL0w2dlh2UTFSRm9zTlZLYUhhb2pNTEhNOTZHWFhVYkh1NGF6dU82?=
 =?utf-8?B?aG5ZWUxJZXdhSm5GU2U5NUNYMVZ5clo5Qm1YdW1YNnNZTGtlOWYvSkxjQzZL?=
 =?utf-8?B?bW1waXZ6d0t2UnlGMEFSTUhVUVRkWG5YQzJxU3U1OFVlOWlWUllYQmx0WnQ0?=
 =?utf-8?B?WENHNUh2ZzAxYmUyL0J3MkxJYmJwekhkYnkzVFhJcTY3NTVYWW14N3NDZ0Uy?=
 =?utf-8?B?MVJnK1ZPV0cxTXQ2dlRtYUNyZ0htTVVtUmtGamNBOXd6VlY1VGVocno5Y1BQ?=
 =?utf-8?B?TTZKbzZSNTk5V1I3TFFvR0IvQUdvYVlIUjVlWW5lMjQzcFJ5bERWKyt5cUUy?=
 =?utf-8?B?bmg0S3NLL1VrZ3NVdW5aN0J5enk2bTR5WmJqVnZGbDcxYzFBa0ZGSkw5Z1Ev?=
 =?utf-8?B?VHB3NytBdHVBV291RGlqZjdXRlBCdFk1Q2k0bVU2bk8xUC8weFUyN3BLc1ZP?=
 =?utf-8?B?TUZsUlhmZmdrTCs3OE1qSEtTNlFXWDdwTHlFeVJCS3oyemtMczI0V1ZyUjBH?=
 =?utf-8?B?Z2p0eEhvZGZxa0lPMnEybzV2SWtsSEdoRUFhUmZtb2tNT2hjME1zWS9qMkk2?=
 =?utf-8?B?ZzV3VXY2VDhEc0VwaTFRWi8wTHg1ekVpRmpKSUNSeFRRYlp3eGFoRGJWTnl1?=
 =?utf-8?B?bmg1ckxxUkFGS25OQWp5VkJiRDRpdE9ycVc0RWhnV1g3MEx1c2MyYVZUd3Y2?=
 =?utf-8?B?dGVaUzk5UVd6SUZ5MUx1NzRkTkxJTFJld3JwSjRsdEJNVFJmWDRFdDNpUGtZ?=
 =?utf-8?B?YWF4VUo0bll0V2FOR0ZUbWtYVEtIVzlYWjdJbGQ5VzlnMzZXaXdrUFZVSkFk?=
 =?utf-8?B?b3MwaFdJUExTck5NdlFnZ1ZiUHdNQnVMWStjUW9XbFFGOEwvRjh0S0tFcUFF?=
 =?utf-8?B?ZHJ1UUFpSU9SVWJDYm0vd1UxcG1HdXRHUGpjZTN3aUI1R2k5bENTcTBxVnRo?=
 =?utf-8?B?QUUzQWRYejRBdHZSWTlTOG5sYllxNDJqb2JTNUl1Ym9LVHpkdVB5dUJwcnV5?=
 =?utf-8?B?VVA4QktYTlhubWthRVdrYldWNzVKZzlxaFp1cjAxS2MwR0ppS2xHUnNYVS9k?=
 =?utf-8?B?SVFlMnZnME1JcVFxbmhlVUYvQU9SQzVUQlFtN2UrM052bXAxSkdtSEpweVht?=
 =?utf-8?B?N3QrUmRTM0czNVk1b3FxRDczZ05wMkVvdGlDS244V3BUU1B0YUdnaUE2NzVr?=
 =?utf-8?B?bWk5dDAzNTJ2RFJlV29OWUpzQ2dMcG45Rmo0b1Y3UGpDeTVwUDdqTkhHYlFz?=
 =?utf-8?B?ZGllNFlTNzIzdnh5d3NaMkFlenhjWXo2SGN0RG1xcnRCTUhNM1VWQjBHMkh2?=
 =?utf-8?B?TU5Fak5yc25pSU9tRFAydVYwY1hkdE0zMjlva0tFSFoxdm5rcCtCMVpWOVRr?=
 =?utf-8?B?YWhmc05tWE54RnE1Yll1YjZKM3JGQk8zT2tEOUdzUHA4b1ZOWW1KRjlhaWxq?=
 =?utf-8?B?SlB0YUZ6VllVaUxKbWlHL0tINnlYRmVjelc2REFaK3VjN0ZHOUduOEJzZUxP?=
 =?utf-8?B?VnpxaGhkK3FYVWEveElkZWg1NlVNTGtUU1dJLy9CalFUWElEVi9QN2JrTVRl?=
 =?utf-8?B?MFV2YS9MTTZtOXFIa0ZVZEtkVnVWSHVoRUNBTjl1UzUwT28zcm4zTWMvNEg0?=
 =?utf-8?B?Vkhxb3h4UGVzY2hjTVBVc0EzTi9obHBPYlR1dTZBN0hjakh6TFhGN2xYUGUx?=
 =?utf-8?B?QkxlK1NBMm9ZYlNqMDRCc05KZ3ozWkNCSHpFS0x0c3B5K2hyamtWSkJEL2pw?=
 =?utf-8?B?a0dQY0loc3FVSCttbFVPS0xEOUJxVjU3RTZSL2poaXJDb2lXOEpBOS90emVQ?=
 =?utf-8?B?Q2FBV2p2d00rVzlobU9GK0RoQkdvMHhCRCtHNzRXVzRsVkYycHVqU005SFZK?=
 =?utf-8?B?blliaElmR3dST2h6V3o0UGphYkpMY2RvVHp0V2hTT21jbkhwWENvRCtSN2cx?=
 =?utf-8?B?Y3gybHFEMVg4OVR0aGFNS3dNRnNNNWw3MHVvWC9zZzlucXh4MXBSVEllc0Rn?=
 =?utf-8?B?RU84S2VuVE9IL3hZeE1LQUsvcE1abEZLYy9BOXBSYldlZVRjem94Q1lLbzR6?=
 =?utf-8?B?ZlRxTFZxZUc1YlV4MkR0SjBXa2IvZjYzNlU3ZmRZd1NCRGlPYTlSNmVrUE1x?=
 =?utf-8?B?Znc3M3ozLzlabkNzMGJqTWpJRXRnZ1ppUHk5UUtMQVg4SmNkMVI4aktYNCt4?=
 =?utf-8?B?QTdOeHRYMUpLa1dBYWhKQTZ0dWFhTVQwZzlzLzIwNmdkcEdSQnBhWXBPKzRm?=
 =?utf-8?B?d2RaZGtCaEp2UkxsNHpRQ2JINUhBeUk3U0F1TVMvQ2F1WE9FdVZHajhiYW1R?=
 =?utf-8?B?MkxDREFJY1BGYk1sVFUvM2xveGs2R01hemhJVXhKaGEreGJnd1IxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 745c6c10-2a97-40d3-e232-08dedd0f8e6a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 16:40:01.9126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15JZdrNQEjbH5ZYcebasINPQ7t8I3ahcky/CJCxIVF+dOpXgFyyhHSE3Ih63xD082+Jdvn24F3b7HQgJy1XToQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6565
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

On 7/8/26 11:35, Oz Tiram wrote:
> Hi Mario,
> 
> The GPU is internal. It's an AMD RADEON PRO W7800 48GB.
> The kernel is built from gentoo-sources-6.18.35.
> 
> I will test the latest sys-kernel/vanilla-sources (7.1.3) and let you know.
> 
> Best regards,

Thanks. Can you please test 7.2-rc2?

I'll clean up the workaround and propose it for review in parallel.

> 
> Oz
> 
> On 7/8/26 15:13, Mario Limonciello wrote:
>>
>> On 7/8/26 08:10, Oz Tiram wrote:
>>> Hi Mario,
>>>
>>>  > If you drop that - does this notice still come up?
>>>
>>> No, the notice does not appear without pci=realloc,assign-busses. The 
>>> iGPU  stays at its POST bus (0x6A = 106), VFCT matches directly, and 
>>> it fetches the VBIOS without any mismatch.
>>>
>>> However, dropping the kernel argument is not an option on this machine:
>>> without it the discrete GPU (0x7449) fails to probe entirely:
>>>
>>>    amdgpu 0000:03:00.0: amdgpu: Fatal error during GPU init
>>>    amdgpu 0000:03:00.0: probe with driver amdgpu failed with error -12
>>>
>>> The firmware BARs cannot be mapped without resource reallocation, so
>>> pci=realloc,assign-busses is required for the dGPU, which in turn 
>>> reassigns
>>> the iGPU to bus 0x0B and triggers the mismatch your patch resolves.
>>
>> Got it; thanks for clarifying.  I would like to dig a little bit 
>> futher into that though.  What kernel are you finding this behavior 
>> and can it still reproduce with 7.2-rc2 if it's older? There was a 
>> bunch of pci/realloc changes that happened in the last cycle that 
>> might have helped this.
>>
>> Also; is it an eGPU (external) or dGPU (internal)?
>>
>> If it's an dGPU IMO this is arguably a BIOS issue that not enough 
>> resources were applied in the first place.
>>
>> Thanks,
>>
>>>
>>>
>>> Thank you,
>>>
>>> Oz
>>>
>>>
>>> On 7/8/26 14:55, Mario Limonciello wrote:
>>>> Hi Oz,
>>>>
>>>> On 7/8/26 07:36, Oz Tiram wrote:
>>>>> Hi Mario,
>>>>>
>>>>> Tested on a Morefine MNAS X1 AI Workstation (AMD Ryzen 7 Pro 
>>>>> 8845HS / Radeon 780M iGPU) with pci=realloc,assign-busses.
>>>>>
>>>>> The VFCT entry for the iGPU has PCIBus=106 (0x6A, recorded at POST) 
>>>>> while the
>>>>> runtime bus is 11 (0x0B). Your patch fires exactly as expected:
>>>>>
>>>>>    amdgpu 0000:0b:00.0: amdgpu: VFCT bus number mismatch: table 
>>>>> 106 ! = runtime 11,
>>>>>        matching by device identity (vendor 0x1002 device 0x1900)
>>>>>    amdgpu 0000:0b:00.0: amdgpu: Fetched VBIOS from VFCT
>>>>>
>>>>> The iGPU initialises fully and drives the framebuffer.
>>>>>
>>>>> One minor nit: the dev_notice format string ends with \\n (two 
>>>>> characters) rather
>>>>> than \n. The resulting kernel message has a literal "\n" at the 
>>>>> end. Same issue
>>>>> exists in the nearby "too short #2" dev_info -- not introduced by 
>>>>> your patch, but
>>>>> might be worth cleaning up.
>>>>>
>>>>> Tested-by: Oz Tiram <oz@shift-computing.de>
>>>>>
>>>>
>>>> Thanks for confirming.  Before I split up this patch and post it in 
>>>> smaller logical pieces can you confirm my proposed root cause is 
>>>> right that this issue happens because "pci=realloc,assign-busses" 
>>>> was on your kernel command line?
>>>>
>>>> If you drop that - does this notice still come up?
>>>>
>>>> Thanks,
>>>>
>>>>> On 7/6/26 02:56, Mario Limonciello wrote:
>>>>>>
>>>>>>
>>>>>> On 7/5/26 14:10, Oz Tiram wrote:
>>>>>>> Hi Mario,
>>>>>>>
>>>>>>>    To make sure I understand correctly: are you suggesting that 
>>>>>>> the bus
>>>>>>>    number in the VFCT was legitimate at BIOS POST time, and that
>>>>>>>    pci=realloc,assign-busses is what changes it at runtime, 
>>>>>>> causing the
>>>>>>>    mismatch?
>>>>>>
>>>>>> That's what it sounds like right now.  You can easily drop all the 
>>>>>> superfluous kernel command line optiosn and see.
>>>>>>
>>>>>>>
>>>>>>>    I'm not familiar enough with the PCI subsystem to know the 
>>>>>>> right way to
>>>>>>>    implement that — could you point me in the right direction?
>>>>>>
>>>>>> Well there's a variety of ways to do it.  But how about we start 
>>>>>> here - if we make that specific busnr match optional and instead 
>>>>>> make a VID/DID match.
>>>>>>
>>>>>> See if the attached patch helps.
>>>>>>
>>>>>>>
>>>>>>>    Oz
>>>>>>>
>>>>>>> On 7/5/26 20:37, Mario Limonciello wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 7/5/26 05:04, Oz Tiram wrote:
>>>>>>>>> APUs (e.g. AMD Radeon 780M / HawkPoint, PCI 1002:1900) have no
>>>>>>>>> dedicated VBIOS ROM chip.  amdgpu_get_bios_apu() attempts four 
>>>>>>>>> paths
>>>>>>>>> before giving up:
>>>>>>>>>
>>>>>>>>>    1. ACPI VFCT table
>>>>>>>>>    2. VRAM BAR read
>>>>>>>>>    3. ROM BAR read
>>>>>>>>>    4. platform BIOS
>>>>>>>>>
>>>>>>>>> On some systems all four fail.  The specific case motivating 
>>>>>>>>> this patch
>>>>>>>>> is a hybrid graphics machine (dGPU + APU) where:
>>>>>>>>>
>>>>>>>>>    - The VFCT table contains the iGPU entry but with a stale 
>>>>>>>>> PCIBus value
>>>>>>>>>      from BIOS POST time (0x6A).  When the kernel boots with
>>>>>>>>>      pci=realloc,assign-busses, PCI bus numbers are reassigned 
>>>>>>>>> dynamically
>>>>>>>>>      and the iGPU lands on bus 0x0B at runtime. 
>>>>>>>>> amdgpu_acpi_vfct_bios()
>>>>>>>>>      matches entries by bus number, so the entry is never found.
>>>>>>>>>    - The VRAM BAR is unmapped at probe time.
>>>>>>>>>    - The ROM BAR is zero (PCI firmware did not assign it).
>>>>>>>>>    - No platform BIOS mapping exists.
>>>>>>>>>
>>>>>>>>> The UEFI GOP driver initialises the iGPU successfully for early 
>>>>>>>>> display,
>>>>>>>>> confirming the hardware is functional.  The VBIOS image data 
>>>>>>>>> embedded in
>>>>>>>>> the VFCT is also valid; only the PCIBus metadata is wrong.
>>>>>>>>
>>>>>>>> So the BIOS on this machine is actually totally fine; it's just 
>>>>>>>> when the kernel is booted to reassign busses there is a problem?
>>>>>>>>
>>>>>>>> In that case; why not detect the kernel was booted this way and 
>>>>>>>> keep track of the original bus number when reassigned to avoid 
>>>>>>>> the issue?
>>>>>>>>
>>>>>>>>> The firmware
>>>>>>>>> file can be extracted directly from the VFCT using dd:
>>>>>>>>>
>>>>>>>>>    dd if=/sys/firmware/acpi/tables/VFCT bs=1 skip=$((0x68)) 
>>>>>>>>> count=16896 \
>>>>>>>>>       of=/lib/firmware/amdgpu/1002_1900.bin
>>>>>>>>>
>>>>>>>>> (0x68 is the byte offset of the VBIOS image after the ACPI 
>>>>>>>>> table header
>>>>>>>>> and VFCT_IMAGE_HEADER; the image length 16896 comes from the 
>>>>>>>>> ImageLength
>>>>>>>>> field in VFCT_IMAGE_HEADER.)
>>>>>>>>>
>>>>>>>>> The driver then prints "Unable to locate a BIOS ROM" and 
>>>>>>>>> refuses to
>>>>>>>>> bind, leaving the APU completely unusable under Linux.
>>>>>>>>>
>>>>>>>>> Add a fifth fallback: request a firmware file named
>>>>>>>>> "amdgpu/<vendor>_<device>.bin" (e.g. "amdgpu/1002_1900.bin") via
>>>>>>>>> request_firmware().  This allows a VBIOS image extracted as 
>>>>>>>>> above to be
>>>>>>>>> placed in /lib/firmware/ and makes the binding succeed without 
>>>>>>>>> patching
>>>>>>>>> ACPI tables or BIOS.
>>>>>>>>>
>>>>>>>>> The fallback is only reached if all existing paths have already 
>>>>>>>>> failed,
>>>>>>>>> so there is no regression risk for boards where VFCT or ROM BAR 
>>>>>>>>> work.
>>>>>>>>
>>>>>>>> What happens if the VBIOS changes in another way one boot to 
>>>>>>>> another? You might have some other stateful information that 
>>>>>>>> isn't updated.
>>>>>>>>
>>>>>>>> The whole thing to me feels like a hack for a behavior we can 
>>>>>>>> control in the kernel when doing reassignments.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Oz Tiram <oz@shift-computing.de>
>>>>>>>>> ---
>>>>>>>>> v2: Fix commit message: clarify that VFCT contains the iGPU 
>>>>>>>>> entry but
>>>>>>>>>      with a stale PCIBus from BIOS POST that mismatches the 
>>>>>>>>> runtime bus
>>>>>>>>>      number assigned by pci=realloc,assign-busses. Explain that 
>>>>>>>>> the VBIOS
>>>>>>>>>      image data is valid and document the dd extraction command 
>>>>>>>>> and byte
>>>>>>>>>      offsets.  Note that the UEFI GOP driver initialises the iGPU
>>>>>>>>>      successfully, confirming the hardware is functional.
>>>>>>>>>
>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 23 +++++++++++++++ 
>>>>>>>>> ++ ++ ++++
>>>>>>>>>   1 file changed, 23 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/ 
>>>>>>>>> drivers/ gpu/ drm/amd/amdgpu/amdgpu_bios.c
>>>>>>>>> index aa039e148a5e..86064c753b09 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>>>>>>>>> @@ -26,6 +26,7 @@
>>>>>>>>>    *          Jerome Glisse
>>>>>>>>>    */
>>>>>>>>>   +#include <linux/firmware.h>
>>>>>>>>>   #include "amdgpu.h"
>>>>>>>>>   #include "atom.h"
>>>>>>>>>   @@ -457,6 +458,28 @@ static bool amdgpu_get_bios_apu(struct 
>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>           goto success;
>>>>>>>>>       }
>>>>>>>>>   +    {
>>>>>>>>> +        const struct firmware *fw;
>>>>>>>>> +        char fw_name[32];
>>>>>>>>> +        size_t fw_size;
>>>>>>>>> +
>>>>>>>>> +        snprintf(fw_name, sizeof(fw_name), "amdgpu/ 
>>>>>>>>> %04x_%04x.bin",
>>>>>>>>> +             adev->pdev->vendor, adev->pdev->device);
>>>>>>>>> +        if (request_firmware(&fw, fw_name, adev->dev) == 0) {
>>>>>>>>> +            adev->bios = kmemdup(fw->data, fw->size, GFP_KERNEL);
>>>>>>>>> +            fw_size = fw->size;
>>>>>>>>> +            release_firmware(fw);
>>>>>>>>> +            if (!adev->bios || !check_atom_bios(adev, fw_size)) {
>>>>>>>>> +                amdgpu_bios_release(adev);
>>>>>>>>> +            } else {
>>>>>>>>> +                adev->bios_size = fw_size;
>>>>>>>>> +                dev_info(adev->dev, "Fetched VBIOS from 
>>>>>>>>> firmware file %s\n",
>>>>>>>>> +                     fw_name);
>>>>>>>>> +                goto success;
>>>>>>>>> +            }
>>>>>>>>> +        }
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>>       dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
>>>>>>>>>       return false;
>>>>>>>>
>>>>
>>

