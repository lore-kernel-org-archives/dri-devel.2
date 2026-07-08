Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1DCC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 17:59:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDB2010F208;
	Wed,  8 Jul 2026 17:59:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eGUvSMNK";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012067.outbound.protection.outlook.com [40.107.209.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C0EF10F207;
 Wed,  8 Jul 2026 17:59:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnJBRzHeNzIYjXUDsaBUV1Qna+539KQ2oFBzpNJwfnXcSNGrkJ2mORlWPyQxIrMgpcwvNbyg3Krm9j68d23VQYWqU93/9UlV4wyQzEIsJtNMhpub3n2h1r/FOvJpDJT5XsOSayFZw8kylTYFo4Ft+Jg9Wl2/O7tmaJiyDaymQOKnZdqKH1N3IUQs2NvqhXJTHpomtzb0WprepQqvaUZp4o8oRmFHoPxQb8v0/UIcRAfnLJg5WS5ZwW6KesgyLsqpC4QksljRm/Dtw02QuZ0Z+9Mt3vEsIPuZtWlI5Ou2kRnr9SDyFfhvaC/ysZHBTHgL1Nk8uldmpK/RFUrlxiiunQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppjC7d1a40emkBP8KQ+44IsQYkFpIGqa6DigHS/o3lA=;
 b=r2ZidV2WzsGEOgzM9GCyLVliVmMSEYtadh5sCeBWD/g/+256yG0LQ7i1VOPMQgvh3Ow6Q2dMN8c19JfIFPHrrXbUYcrn8pUN/yv3zOiPkmGSj185Noh3KL4+q5D6lv5Wbp2OmJNhMxpQCI6MMKt09UmTm12ExSCPS5cDo16EQOruofiYEBIfdA4Qh61srT/6485MqFTLe8vndBYy9NHaAi/1lCxvfH/Fy/90dcIOIe30suhBrikBmKchJyKKPS9Ul/Izv9Mf7LtUlBcQfPAkk8thYdJQxqMO1HzT1mlRNpRLWGj2i7eezi99i5v/28Jt23PZFZWQFbG3PEtSna3Prg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppjC7d1a40emkBP8KQ+44IsQYkFpIGqa6DigHS/o3lA=;
 b=eGUvSMNK8dkpji/karSzzUi2e7+gXtdc4IY37YKCTGlcyN1NnX3JhyB1k2+5aAgoBQvyHyphhN9Cgx7h8Ch93JO3jyULtrHsc1Z4+mE89hP8+mAdn/TOgOTC5H/l9XhDxDGfB5TQdMDzJEYUMQfPQct2d5XvalVL5LbhXrP2Ez4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by PH7PR12MB5829.namprd12.prod.outlook.com (2603:10b6:510:1d4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 17:59:22 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 17:59:22 +0000
Message-ID: <fc0fbda4-87a1-4a58-a66f-728274b4df92@amd.com>
Date: Wed, 8 Jul 2026 12:59:19 -0500
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
 <bc1dbadd-a3ea-4ff9-826e-6826c20bb54e@amd.com>
 <d224d046-0480-4e38-9e93-29a0d37f3331@shift-computing.de>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <d224d046-0480-4e38-9e93-29a0d37f3331@shift-computing.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0237.namprd03.prod.outlook.com
 (2603:10b6:610:e7::32) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|PH7PR12MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: fef1810c-8614-49eb-d37b-08dedd1aa3d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|56012099006|11063799006|5023799004|6133799003|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: ZaxIKU4fkfpGxC9Oh47NYwuedeFAJdLYFRzjZlFG8JMxyxFuTovdMETOU7lWEV2m6ItXFUjVkjSCDjn9DOVDQXcsGpcHHt7WPjfdeWnNv9fEpFn+FsJjq6Qw50NMIB0U/j+sdZQglBWaDGYhdRd3xMF+Khm2n7n5v94nJRKA/jISG37MSrLIKjP3W4+l333X2CIjZxXWMGAh+fx1b2fUlw2mS9jQ31NTtm1bPxjCDkucbcgOxuvFtwD+NCSKMVDs8vhB0PBYuoP3WmJ4DjVhpG1wnrss2oeewgmKJ9weNTi0ViUHAqnM785ptNzdvfalnJoZ/EW0RVK7hbAOkjae5Fjxp6axnd0Vpe1lXcCfxwChXO8Mw62aYLQ6EvDsA8dF/vhZgiikwfucY4hcXnRO416N835ZN49itZQH3G/EbbP2Y+myVS0+QrsaRf59+77zx2ZpOdM9Zms8t7/KAXAeqpLcXoq/Il1FY+i0+l6/0CbH+R306ug3ZWW7szwDfkze9xWDfDTT+Qe/iDp8ALe6BnCZPSL4igNYpz/lRU2pB/UJKSrPLqzZSEMd9ToJHnfO+kxiiG14Jz6HUKWTMv3ZvzIeU4WLs3nSdh/jVaclrcq3ukwKnCE4FFP/IS/hNV9iJ5u2+J7CFYgvtNJln3CAIbJiRuNfj6leSjDcAy51iPY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(5023799004)(6133799003)(4143699003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGdDTmJ0SHduR2xReS9XNWRITmxsM0hOaTNGOXlGbmZXNG9QdXJzWTRoYzF4?=
 =?utf-8?B?dm81d3RQTHM1ZUVEUFRMUVUrczM1SWVrQWp4R0ZqdWFleXdyMWg0aUIvdi9U?=
 =?utf-8?B?dUhxczBiYitPV1ZZVUJPRGFUMjBVSXdoTmJ6cU1seU95aWUrRXlxNWlzZVhR?=
 =?utf-8?B?VzJhZUZ2M0pma1R4cjhCbHpIeGZiVWR6WTUweC9rZ1lpbEFDbWQxbHI1QlFC?=
 =?utf-8?B?VXI2YTFLQVhYTEZwTkw5T05Bam5MQysvdG9pU29BRE1Jem9zMmNNM1JRdWt5?=
 =?utf-8?B?Y2t2NUowN3FrT1ZDY2N4S1Y3RkFxdkg5ckZ5cnRLUDVuM0VQdEdNZ2hJRUlU?=
 =?utf-8?B?TjgzZi8rVWs3SndCaGQ5cFg3NDMxVFhtNVZucC9KWTZyWUlvTXRLaEtkL0dQ?=
 =?utf-8?B?c3g1QktGSFZLMS9oRWhJdGRRNDdtU21FK2U3U0Z2R3ZVdG5RVThhaXNLQ2cy?=
 =?utf-8?B?RVNQM0JIdU9hc3hkRytFS1k4aDFwNGgyZWRQWjNWSkNoSDVnQmFuUSs4TUg1?=
 =?utf-8?B?Vm5GTnVwNXB6ZGpFZUtEU1lRbXgzT09MS3hDemtqWnZMd3VZT2VNQkhZZ2Nh?=
 =?utf-8?B?cGJTc3RMZUJjYmc2cHZtdmtuTzUwV0V0THN3TCt3NjVlaURpazV0eFJuZ2pz?=
 =?utf-8?B?Z3BnbTMrWEZKNEZvSUdvYW94NGUyc0p6V29XaWNaSDRrV0dkWDAyTDhidHZ2?=
 =?utf-8?B?VW93M1hzdW82TnlPeFhKR0ZWTlc4UXVaaVBMejlWbUdZRzJIa3RuN0h5WVZk?=
 =?utf-8?B?Vi9vNWVkT1NCa0FJWStpVDZ6OVZZYTZ5Ym41OTk0dzJLUDE4QWZOV3BBMytQ?=
 =?utf-8?B?eXhlblQzb3B0WEhmek00OVZPYWVmbHl1STZxY2VXSzNjQWtlRDd0Qkx3dUNK?=
 =?utf-8?B?QTlDbU05UDFyRm1zYWl5VFJqNysyVlArOFJFWk42ZnA2MGdWVWRVcFNFUzQ4?=
 =?utf-8?B?MlBJTWtvRUphbThTcTF1NHR0N1FLMm5NYmJyT0t2clh4bTdyZFNzbktUN2Fx?=
 =?utf-8?B?VStUc0xVUUZIMGZKc0o0N1dwemUweTdBZ05aRmNueTZmeGdGV2cxWm9LVEg1?=
 =?utf-8?B?T3UrQVU0TWQvbVRXbk1rRjhIdTQyYUdPWTM3Qjg0T1hQd0xnOThMOS9QTHRS?=
 =?utf-8?B?ZnNUOHZBVG5jZ3hNVzcwUlg5bkRvYXJlTUFPVWVqdWRQS0w3eS9jOFJpdVlO?=
 =?utf-8?B?dDFJOVJTQlJrY0syTkgxRm9SY1gyUVBzYjJKVlhQY0drbGRSQzNleWFJUnoz?=
 =?utf-8?B?d05hWWdNeHB2Q1JJa0V1Zk4yQkQvVVVjWXRQamQ4ZFM4WU1kVVFvczdSZE1j?=
 =?utf-8?B?Qkt3TWdrVjlsUlF3NXREWW9PY2cveWNFKzNZazljY3g1cTdhd3p3T1pCQ243?=
 =?utf-8?B?MjB3K1ZTRHVZTWx1emJhZHRXMHBxOGlhdDF0dE1IUm8zejdneWpiNUh3Yyt3?=
 =?utf-8?B?OTU1NjNuamg2WnNDOE9YZ2gxKzQ5MUE0bDlMa1VOVTZQejdWZG1KTWQ3NFlH?=
 =?utf-8?B?R3R2T2krSDBkREFFcTh6WUJMM1M0VXJPNDZSMkc1YkZQemZPcHZaNUM5OGFr?=
 =?utf-8?B?b0t0aUlWaWFXRzlyWldPY1F4K2xNVjBSUkVFMVg3QkhXVVA3UWtVaUF2eExO?=
 =?utf-8?B?ZmVTMnlHZmhwelNsUFpQamJCc2JleFk4YXBGL3JqWGFwR0xSMkxhdmMvN3F4?=
 =?utf-8?B?a2cyTXpCVVhld3FDSHNvayt6dUpTZnllTUlWcGptSmVPWmtVMmk0blZVdmQz?=
 =?utf-8?B?VVYwQlFSdEs5VHp2TXBYblM0N0pCaUhZZE9OOE5yeGh3Q3RrT1lZa0JWZHZr?=
 =?utf-8?B?SzF6ai9vMXFQWDh0MUIxS1pid1h0U0tLaUQySEw3OUwwejZ4NmhLQUdDdExt?=
 =?utf-8?B?MTNwKzFMNUdqaXVaaEQzUFJrcnZaYzlyL0EzWGVEblhENkRYSkdMZXhKTkdn?=
 =?utf-8?B?RzRmcHdnTVZwK0RIbFRMTjZURlMwVkZuSkhySzFmNlgrRndNNUNLL3VzN2JM?=
 =?utf-8?B?QUF3L3JVNlc4TitBZzRpanRodG9JWVhaOWpJejNEbHNRay9qTlE5aWxoRkly?=
 =?utf-8?B?Mzdlc2pqMzkxWDZLR3hPbEtMUEJxQXI2dGNwZWxLeThVM1ZoVytsNWVSM3lu?=
 =?utf-8?B?amZ2bWZEL2tSV2o5a0poYW9TbXd1RXBiZXdyWmdqVVBzd3o3UWZGaUozeXNQ?=
 =?utf-8?B?UHFkdDhUWWNycDVMbHJLSS9mZW9VT1FaODBHVVNQU0dVM1JqZXVxLzRsTDlo?=
 =?utf-8?B?N2pqcFZmWGZBbWxjOTBncjduazN1KzFOUVQwMnc4U0FoMEJsS0NES1pudkhG?=
 =?utf-8?Q?bQN2qhWumcwOzIhIg4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef1810c-8614-49eb-d37b-08dedd1aa3d9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 17:59:22.2812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqNoUSS+YCtNUS25RK3nhq4N3TS0/OSfkIQ4kFUlMRAZDE2CxP71pMJN3lEFUQdyr1v/JAZUr0z8IEcjsOYLkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5829
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



On 7/8/26 12:52, Oz Tiram wrote:
> Hi Mario,
> 
> Tested on 7.2-rc2 with your patch applied. The mismatch condition is
> unchanged from 6.18.35:
> 
>    amdgpu 0000:0b:00.0: VFCT bus number mismatch: table 106 != runtime 11,
>        matching by device identity (vendor 0x1002 device 0x1900)
>    amdgpu 0000:0b:00.0: Fetched VBIOS from VFCT
> 
> Both GPUs initialise fully with your patch.
> 
> I also tested 7.2-rc2 without pci=realloc,assign-busses to check whether
> the pci/realloc changes fixed the dGPU probe failure. They did not -- the
> dGPU still fails on 7.2-rc2:
> 
>    amdgpu 0000:03:00.0: Fatal error during GPU init
>    amdgpu 0000:03:00.0: probe with driver amdgpu failed with error -12
> 
> Without the kernel argument the iGPU sits at its POST bus (0x6A), VFCT
> matches directly, and it works fine -- but the dGPU is unusable.
> pci=realloc,assign-busses remains necessary for this machine on 7.2-rc2,
> which means the VFCT mismatch persists and your patch is still needed.
> 
> Thank you for not giving up on me so quickly!
> This is my first time working on such issue. It feels
> daunting to modify kernel code.

OK, in that case I will clean up and post the patches shortly.  You'll 
be able to use them for a workaround if everyone else is aligned.  The 
part I'm worried about with these is how they would interplay with a 
system with multiple of the same GPU.  But I don't believe we would be 
fetching VBIOS from VFCT in that case most likely?  Not sure.

We really shouldn't have to set pci=realloc,assign-busses on a design 
with all internal PCIe devices.  We should adjust resource allocation
code for this case.

So please start another another thread with the linux-pci mailing list 
on this issue, include a full dmesg showing what happens when you don't 
add the parameters and then what happens when you do (feel free to 
include/reference this patch in that thread too).

If you want to use one, this is the kind of thing an LLM with access to 
a kernel checkout and both those dmesgs might be good at helping to 
propose a draft for a solution to the resource allocation code too.

You can CC me on that linux-pci mailing list submission, and we'll see 
if we can come up with a better solution for you.

> 
> Oz
> 
> 
> On 7/8/26 18:39, Mario Limonciello wrote:
>> On 7/8/26 11:35, Oz Tiram wrote:
>>> Hi Mario,
>>>
>>> The GPU is internal. It's an AMD RADEON PRO W7800 48GB.
>>> The kernel is built from gentoo-sources-6.18.35.
>>>
>>> I will test the latest sys-kernel/vanilla-sources (7.1.3) and let you 
>>> know.
>>>
>>> Best regards,
>>
>> Thanks. Can you please test 7.2-rc2?
>>
>> I'll clean up the workaround and propose it for review in parallel.
>>
>>>
>>> Oz
>>>
>>> On 7/8/26 15:13, Mario Limonciello wrote:
>>>>
>>>> On 7/8/26 08:10, Oz Tiram wrote:
>>>>> Hi Mario,
>>>>>
>>>>>  > If you drop that - does this notice still come up?
>>>>>
>>>>> No, the notice does not appear without pci=realloc,assign-busses. 
>>>>> The iGPU  stays at its POST bus (0x6A = 106), VFCT matches 
>>>>> directly, and it fetches the VBIOS without any mismatch.
>>>>>
>>>>> However, dropping the kernel argument is not an option on this 
>>>>> machine:
>>>>> without it the discrete GPU (0x7449) fails to probe entirely:
>>>>>
>>>>>    amdgpu 0000:03:00.0: amdgpu: Fatal error during GPU init
>>>>>    amdgpu 0000:03:00.0: probe with driver amdgpu failed with error -12
>>>>>
>>>>> The firmware BARs cannot be mapped without resource reallocation, so
>>>>> pci=realloc,assign-busses is required for the dGPU, which in turn 
>>>>> reassigns
>>>>> the iGPU to bus 0x0B and triggers the mismatch your patch resolves.
>>>>
>>>> Got it; thanks for clarifying.  I would like to dig a little bit 
>>>> futher into that though.  What kernel are you finding this behavior 
>>>> and can it still reproduce with 7.2-rc2 if it's older? There was a 
>>>> bunch of pci/realloc changes that happened in the last cycle that 
>>>> might have helped this.
>>>>
>>>> Also; is it an eGPU (external) or dGPU (internal)?
>>>>
>>>> If it's an dGPU IMO this is arguably a BIOS issue that not enough 
>>>> resources were applied in the first place.
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>>
>>>>> Thank you,
>>>>>
>>>>> Oz
>>>>>
>>>>>
>>>>> On 7/8/26 14:55, Mario Limonciello wrote:
>>>>>> Hi Oz,
>>>>>>
>>>>>> On 7/8/26 07:36, Oz Tiram wrote:
>>>>>>> Hi Mario,
>>>>>>>
>>>>>>> Tested on a Morefine MNAS X1 AI Workstation (AMD Ryzen 7 Pro 
>>>>>>> 8845HS / Radeon 780M iGPU) with pci=realloc,assign-busses.
>>>>>>>
>>>>>>> The VFCT entry for the iGPU has PCIBus=106 (0x6A, recorded at 
>>>>>>> POST) while the
>>>>>>> runtime bus is 11 (0x0B). Your patch fires exactly as expected:
>>>>>>>
>>>>>>>    amdgpu 0000:0b:00.0: amdgpu: VFCT bus number mismatch: table 
>>>>>>> 106 ! = runtime 11,
>>>>>>>        matching by device identity (vendor 0x1002 device 0x1900)
>>>>>>>    amdgpu 0000:0b:00.0: amdgpu: Fetched VBIOS from VFCT
>>>>>>>
>>>>>>> The iGPU initialises fully and drives the framebuffer.
>>>>>>>
>>>>>>> One minor nit: the dev_notice format string ends with \\n (two 
>>>>>>> characters) rather
>>>>>>> than \n. The resulting kernel message has a literal "\n" at the 
>>>>>>> end. Same issue
>>>>>>> exists in the nearby "too short #2" dev_info -- not introduced by 
>>>>>>> your patch, but
>>>>>>> might be worth cleaning up.
>>>>>>>
>>>>>>> Tested-by: Oz Tiram <oz@shift-computing.de>
>>>>>>>
>>>>>>
>>>>>> Thanks for confirming.  Before I split up this patch and post it 
>>>>>> in smaller logical pieces can you confirm my proposed root cause 
>>>>>> is right that this issue happens because "pci=realloc,assign- 
>>>>>> busses" was on your kernel command line?
>>>>>>
>>>>>> If you drop that - does this notice still come up?
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>>> On 7/6/26 02:56, Mario Limonciello wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 7/5/26 14:10, Oz Tiram wrote:
>>>>>>>>> Hi Mario,
>>>>>>>>>
>>>>>>>>>    To make sure I understand correctly: are you suggesting that 
>>>>>>>>> the bus
>>>>>>>>>    number in the VFCT was legitimate at BIOS POST time, and that
>>>>>>>>>    pci=realloc,assign-busses is what changes it at runtime, 
>>>>>>>>> causing the
>>>>>>>>>    mismatch?
>>>>>>>>
>>>>>>>> That's what it sounds like right now.  You can easily drop all 
>>>>>>>> the superfluous kernel command line optiosn and see.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>    I'm not familiar enough with the PCI subsystem to know the 
>>>>>>>>> right way to
>>>>>>>>>    implement that — could you point me in the right direction?
>>>>>>>>
>>>>>>>> Well there's a variety of ways to do it.  But how about we start 
>>>>>>>> here - if we make that specific busnr match optional and instead 
>>>>>>>> make a VID/DID match.
>>>>>>>>
>>>>>>>> See if the attached patch helps.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>    Oz
>>>>>>>>>
>>>>>>>>> On 7/5/26 20:37, Mario Limonciello wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 7/5/26 05:04, Oz Tiram wrote:
>>>>>>>>>>> APUs (e.g. AMD Radeon 780M / HawkPoint, PCI 1002:1900) have no
>>>>>>>>>>> dedicated VBIOS ROM chip.  amdgpu_get_bios_apu() attempts 
>>>>>>>>>>> four paths
>>>>>>>>>>> before giving up:
>>>>>>>>>>>
>>>>>>>>>>>    1. ACPI VFCT table
>>>>>>>>>>>    2. VRAM BAR read
>>>>>>>>>>>    3. ROM BAR read
>>>>>>>>>>>    4. platform BIOS
>>>>>>>>>>>
>>>>>>>>>>> On some systems all four fail.  The specific case motivating 
>>>>>>>>>>> this patch
>>>>>>>>>>> is a hybrid graphics machine (dGPU + APU) where:
>>>>>>>>>>>
>>>>>>>>>>>    - The VFCT table contains the iGPU entry but with a stale 
>>>>>>>>>>> PCIBus value
>>>>>>>>>>>      from BIOS POST time (0x6A).  When the kernel boots with
>>>>>>>>>>>      pci=realloc,assign-busses, PCI bus numbers are 
>>>>>>>>>>> reassigned dynamically
>>>>>>>>>>>      and the iGPU lands on bus 0x0B at runtime. 
>>>>>>>>>>> amdgpu_acpi_vfct_bios()
>>>>>>>>>>>      matches entries by bus number, so the entry is never found.
>>>>>>>>>>>    - The VRAM BAR is unmapped at probe time.
>>>>>>>>>>>    - The ROM BAR is zero (PCI firmware did not assign it).
>>>>>>>>>>>    - No platform BIOS mapping exists.
>>>>>>>>>>>
>>>>>>>>>>> The UEFI GOP driver initialises the iGPU successfully for 
>>>>>>>>>>> early display,
>>>>>>>>>>> confirming the hardware is functional.  The VBIOS image data 
>>>>>>>>>>> embedded in
>>>>>>>>>>> the VFCT is also valid; only the PCIBus metadata is wrong.
>>>>>>>>>>
>>>>>>>>>> So the BIOS on this machine is actually totally fine; it's 
>>>>>>>>>> just when the kernel is booted to reassign busses there is a 
>>>>>>>>>> problem?
>>>>>>>>>>
>>>>>>>>>> In that case; why not detect the kernel was booted this way 
>>>>>>>>>> and keep track of the original bus number when reassigned to 
>>>>>>>>>> avoid the issue?
>>>>>>>>>>
>>>>>>>>>>> The firmware
>>>>>>>>>>> file can be extracted directly from the VFCT using dd:
>>>>>>>>>>>
>>>>>>>>>>>    dd if=/sys/firmware/acpi/tables/VFCT bs=1 skip=$((0x68)) 
>>>>>>>>>>> count=16896 \
>>>>>>>>>>>       of=/lib/firmware/amdgpu/1002_1900.bin
>>>>>>>>>>>
>>>>>>>>>>> (0x68 is the byte offset of the VBIOS image after the ACPI 
>>>>>>>>>>> table header
>>>>>>>>>>> and VFCT_IMAGE_HEADER; the image length 16896 comes from the 
>>>>>>>>>>> ImageLength
>>>>>>>>>>> field in VFCT_IMAGE_HEADER.)
>>>>>>>>>>>
>>>>>>>>>>> The driver then prints "Unable to locate a BIOS ROM" and 
>>>>>>>>>>> refuses to
>>>>>>>>>>> bind, leaving the APU completely unusable under Linux.
>>>>>>>>>>>
>>>>>>>>>>> Add a fifth fallback: request a firmware file named
>>>>>>>>>>> "amdgpu/<vendor>_<device>.bin" (e.g. "amdgpu/1002_1900.bin") via
>>>>>>>>>>> request_firmware().  This allows a VBIOS image extracted as 
>>>>>>>>>>> above to be
>>>>>>>>>>> placed in /lib/firmware/ and makes the binding succeed 
>>>>>>>>>>> without patching
>>>>>>>>>>> ACPI tables or BIOS.
>>>>>>>>>>>
>>>>>>>>>>> The fallback is only reached if all existing paths have 
>>>>>>>>>>> already failed,
>>>>>>>>>>> so there is no regression risk for boards where VFCT or ROM 
>>>>>>>>>>> BAR work.
>>>>>>>>>>
>>>>>>>>>> What happens if the VBIOS changes in another way one boot to 
>>>>>>>>>> another? You might have some other stateful information that 
>>>>>>>>>> isn't updated.
>>>>>>>>>>
>>>>>>>>>> The whole thing to me feels like a hack for a behavior we can 
>>>>>>>>>> control in the kernel when doing reassignments.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Oz Tiram <oz@shift-computing.de>
>>>>>>>>>>> ---
>>>>>>>>>>> v2: Fix commit message: clarify that VFCT contains the iGPU 
>>>>>>>>>>> entry but
>>>>>>>>>>>      with a stale PCIBus from BIOS POST that mismatches the 
>>>>>>>>>>> runtime bus
>>>>>>>>>>>      number assigned by pci=realloc,assign-busses. Explain 
>>>>>>>>>>> that the VBIOS
>>>>>>>>>>>      image data is valid and document the dd extraction 
>>>>>>>>>>> command and byte
>>>>>>>>>>>      offsets.  Note that the UEFI GOP driver initialises the 
>>>>>>>>>>> iGPU
>>>>>>>>>>>      successfully, confirming the hardware is functional.
>>>>>>>>>>>
>>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 23 +++++++++++++ 
>>>>>>>>>>> ++ ++ ++ ++++
>>>>>>>>>>>   1 file changed, 23 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/ 
>>>>>>>>>>> drivers/ gpu/ drm/amd/amdgpu/amdgpu_bios.c
>>>>>>>>>>> index aa039e148a5e..86064c753b09 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>>>>>>>>>>> @@ -26,6 +26,7 @@
>>>>>>>>>>>    *          Jerome Glisse
>>>>>>>>>>>    */
>>>>>>>>>>>   +#include <linux/firmware.h>
>>>>>>>>>>>   #include "amdgpu.h"
>>>>>>>>>>>   #include "atom.h"
>>>>>>>>>>>   @@ -457,6 +458,28 @@ static bool amdgpu_get_bios_apu(struct 
>>>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>>>           goto success;
>>>>>>>>>>>       }
>>>>>>>>>>>   +    {
>>>>>>>>>>> +        const struct firmware *fw;
>>>>>>>>>>> +        char fw_name[32];
>>>>>>>>>>> +        size_t fw_size;
>>>>>>>>>>> +
>>>>>>>>>>> +        snprintf(fw_name, sizeof(fw_name), "amdgpu/ 
>>>>>>>>>>> %04x_%04x.bin",
>>>>>>>>>>> +             adev->pdev->vendor, adev->pdev->device);
>>>>>>>>>>> +        if (request_firmware(&fw, fw_name, adev->dev) == 0) {
>>>>>>>>>>> +            adev->bios = kmemdup(fw->data, fw->size, 
>>>>>>>>>>> GFP_KERNEL);
>>>>>>>>>>> +            fw_size = fw->size;
>>>>>>>>>>> +            release_firmware(fw);
>>>>>>>>>>> +            if (!adev->bios || !check_atom_bios(adev, 
>>>>>>>>>>> fw_size)) {
>>>>>>>>>>> +                amdgpu_bios_release(adev);
>>>>>>>>>>> +            } else {
>>>>>>>>>>> +                adev->bios_size = fw_size;
>>>>>>>>>>> +                dev_info(adev->dev, "Fetched VBIOS from 
>>>>>>>>>>> firmware file %s\n",
>>>>>>>>>>> +                     fw_name);
>>>>>>>>>>> +                goto success;
>>>>>>>>>>> +            }
>>>>>>>>>>> +        }
>>>>>>>>>>> +    }
>>>>>>>>>>> +
>>>>>>>>>>>       dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
>>>>>>>>>>>       return false;
>>>>>>>>>>
>>>>>>
>>>>
>>

