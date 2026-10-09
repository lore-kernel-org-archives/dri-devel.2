Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62F8CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 16:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0465D10E9C2;
	Fri,  9 Oct 2026 16:21:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2sFyRdpL";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011053.outbound.protection.outlook.com [52.101.62.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2F5510E9C2
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 16:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7uRQ//I0oiMC8cVczldn5oDhKWXDtPgf26dD2TftYMGZkuLzJw48GMI1iaIyEqkeKR2T6AA5tjVoQw/z6Mct2q7H5QFY6vGVuO2AQ+va7vjmZhvL70rht9RMps96Z1r3lUpMz7Ns4SPh1M7GLkHo8ta2wwjsddRT8js612EXVLl7TG7yJzb01T7h2vQAXLy+xJ6jw3l64opZlxKxvT6SJYHsID/tLnIvBHyohqp7GnWZcP6XmMcVb0D77OpDCPY4V1ch0pjV5FrRLvGYRKtvXHTZE6YlYE+zct01Ke75bCCuiYpv0Ti/PrUFMOipwJSx4o0bb6msTujzqbiWdZ9PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rffRKC3Z6j1S3o6d+vcUWE7lCuQ38c2SzCuBdgrWDfA=;
 b=Vid9omPiHRklCIOj1hfBb/1zl6IALfZPRQzn7TA+oEXNkneb7ePTqwaIR/mF+E/A5mUx5sUpjzfQgxQP2GYrlV5zgDRYg4TLpX4XLCje0nXhn+p3PM/3djU9FlYRwdZPNQFr38mOih+TV8t4vQrOD7z1c0a0l3WR6MQwSW4k8z7tsW2Rt8XShz6eblYUwTR6+cxpNrT8Rr9OTeJtjcJi5hf101fUX0R1/rjsHgN41DB6nDQTLuDZ+S73vZoFePyloGPrFWAWwTuqRLE86EK4PrvuJHX4NW3+He+6V1lEbw4rL/chLfkVtALf0ZvVOwdic7jR31/1GN+4lvS+8gfHQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rffRKC3Z6j1S3o6d+vcUWE7lCuQ38c2SzCuBdgrWDfA=;
 b=2sFyRdpLyudIjpGlR32sjh4OscQzeRBoR9vhj1VE15s7/4U+5z+QS7N5H1oy5a/LG8uUH0KPcWb3Er2d87nPUQiNigvdinQAuIJ/0/N9/vcOxYiSqczirM5FwhrdMsO5tKe6WUz61y4Xk+vNAlRaxVn8Ukl5GXp+LfVbJpj+9MU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 by MW3PR12MB4362.namprd12.prod.outlook.com (2603:10b6:303:5d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 16:20:55 +0000
Received: from BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::8e9c:2f3d:9679:942e]) by BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::8e9c:2f3d:9679:942e%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 16:20:54 +0000
Message-ID: <c32ca676-8c0b-4ba2-9403-33643818e863@amd.com>
Date: Fri, 9 Oct 2026 21:50:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] soundwire: amd: Add BRA/BPT firmware download
 support
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, vkoul@kernel.org
Cc: broonie@kernel.org, Sunil-kumar.Dommati@amd.com,
 vijendar.mukunda@amd.com, Mario.Limonciello@amd.com,
 venkataprasad.potturu@amd.com, yung-chuan.liao@linux.intel.com,
 anson.tsao@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Simon Trimmer <simont@opensource.cirrus.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 "open list:SOUNDWIRE SUBSYSTEM" <linux-sound@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS"
 <sound-open-firmware@alsa-project.org>,
 "open list:BPF [MISC]:Keyword:(?:\\b|_)bpf(?:\\b|_)" <bpf@vger.kernel.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK:Keyword:\\bdma_(?:buf|fence|resv)\\b"
 <linux-media@vger.kernel.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK:Keyword:\\bdma_(?:buf|fence|resv)\\b"
 <dri-devel@lists.freedesktop.org>, moderated "list:DMA" BUFFER SHARING
 "FRAMEWORK:Keyword:\\bdma_(?:buf|fence|resv)\\b"
 <linaro-mm-sig@lists.linaro.org>
References: <20261005091620.1390916-1-syed.sabakareem@amd.com>
 <20261005091620.1390916-5-syed.sabakareem@amd.com>
 <b8ab667c-8de2-47db-8fac-49faddd18f1a@linux.dev>
 <87dff7bd-fa1d-4153-8dd1-75947a25a466@amd.com>
 <f6790e78-8432-4bab-8363-501a2fb9783d@linux.dev>
Content-Language: en-US
From: Syed Saba Kareem <syed.sabakareem@amd.com>
In-Reply-To: <f6790e78-8432-4bab-8363-501a2fb9783d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0188.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::11) To BN9PR12MB5356.namprd12.prod.outlook.com
 (2603:10b6:408:105::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5356:EE_|MW3PR12MB4362:EE_
X-MS-Office365-Filtering-Correlation-Id: 25337edf-be53-4d1c-1146-08df26214ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: u1daaACOUNqMJFj+8Eh0e3YACVTL8sTe3r12j1ZejzKWGBVo3zOylAY3r63dFQTTJ6dA7zNvLIT8dEH3HbAcvzLWAwkRAGvNAeiGGhLni4TcxRb4SAvIofOCOXKxW9rI6lPDrzsKVea3oTl+IAdKqNRlGy1qBUzbqgSEUo20S6/pXRIzx89CqHE+Lfc6sDv+4F1luXkX19jPxmlsyx3SznaMuG8VWt9+zZdGXlITqWKyC4+fmX/q1cdzU6EIt3O4btbOTvGT90E8ENxXdJ0rK3xN3LisFgF+63IWqvXzOqrkKW1tRZsYu93+dpwNpir2D0kBNeZ5Ah+e6Io7308h8TDHZ5MXhya2JklhSpXtz6I9fCspx+UtdiFPSliMeftLyf/ESnL88Qe7iDB3DOy4AQppwxcnQwYBViwBSyX89ZCrDdcktUTzpAq3D+d3bAl92b5S53XrIB5j5qMWY8z+FUFm3oK3GHc4ZIvCJQSRUIkcWn4s/aidhk1mEbJHpz88cgVHdLRTjjM0jJiEYpwDyUPzshbeQMqdwsa7yKEhmevMMRYpSr2+KjL+quJSlqZqUsIRZYAFkWpVyxn97IEqabazhRmS7U15UGDSW3fwx2LIo+gZ/EWmvwrZca+XEQw4PnO1Ay4QzPyOnKwy9fvSEACjBA3mRENh9A2neOFz5BE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHhWRCtUR2gwOUdiTmc1TzFWckNqV2pNWXhZSVh5UkQ1VDZDNFc3NDdiaGZa?=
 =?utf-8?B?Zkt6ZWl5OUJQUDVIR2RROWZLNHk4TXphQnlhWUFlYnVoYXRaQ3poRjUyWlE5?=
 =?utf-8?B?UlFUT3JCVUhkTXhWYkRmNWZwTWNjYzRkclNOSElGamFneE1XVnhpN3QvUTJm?=
 =?utf-8?B?blFUTXdSMTBQWUJFcHBKWUpLcDU3NzVPWG9ZQ09SdUR0RDZuMDlCMkUxT0Zh?=
 =?utf-8?B?TUVqejNrRktWU2c4bDAxQ1crMkZjaWdCRnRsNDdLVFBuMEhCVFlSMzFpdVIx?=
 =?utf-8?B?Zm5nVDVMaE45ZFQ4QmM0Q2ovVzF1Y3JZWTBpa2tuSEtRM2VKWGh3aUFhbDBi?=
 =?utf-8?B?QlR4TWY1R2hQejgxSkE3TE9yZ2ZlMWxwKzVWVEVycC9oVk1nL1VQVituQzNq?=
 =?utf-8?B?TFF6WURYM2ZoT2dsS2N1M0Q2UlI0amlmaS9WUCtvS3FFTWs0c3ozdlNVK2tN?=
 =?utf-8?B?ZHpSTWNTYklSd1VTd2ZqV0JWa0FBS05HRGRrMUZyd1ZybnZtSlM1SUFFanBy?=
 =?utf-8?B?eVZxZ1lPTUhyNmY0Ty9aVXQ1YVR5R0NvNkJoa01qMXZzTXlUSEtDbjkrTm5J?=
 =?utf-8?B?OTJINGZFY09JMmYrUVI0SStNbXNjejdHMWVldXFMN3lpcU4xcUFqT2gvSU13?=
 =?utf-8?B?WTN4V3lqcjBrYjNyaGlVdFFJNEUwMmlJcW52b1BMRlA2NWV3U1pnNW1vY0Zv?=
 =?utf-8?B?UjB3dGZOendFWFRXZWJlek13MmtYVTBwTHdueGhXRkJ6T1Z6OGlhcGdlcVZl?=
 =?utf-8?B?SXFzNEJ5djdNTlhTTmJUcFh2YjBrQ2RyTnNyZytkSFhHWVovSE5sbUJ5NHln?=
 =?utf-8?B?NVFWN0lnSTR6Vk5rcHgrRkU5SVVaYnMzU0VOOXNvYTF1TVJnSmF0VlBqSFlT?=
 =?utf-8?B?b1BZbjR2NFB3ZzRqM2ZLOGkxQnptUGgvcnJwdWZVWkRtclNwd09zdWdUYVBu?=
 =?utf-8?B?MUc1QWo0Wi91MFV4alBBNm1uaXJyZ2hVNk1NMlNQSHI2L3BwejI3OTlqeXll?=
 =?utf-8?B?OGVrVjdXNnEwQUZMRTN6Yis1WkhmZUx4UVpxYWlBYXlUeDE4cmR3OFBOcVg3?=
 =?utf-8?B?SDRwUmJXaU5OV3d6c1g5dzl0U3RwanpLdG9OQll6RmE2WVIzMytla3JvVlNW?=
 =?utf-8?B?NEFwOWdSWlhJRmZPendaVy9pZm16cURXRlBjNlhHTlJveUkreDBoeThkSWdV?=
 =?utf-8?B?ZldJR0d5QnVXbkIxK09IZW9ua1d4K0g3RkM5eUNwM3RxVE5yczdadEk0NEpl?=
 =?utf-8?B?TnhCR1g3NGxpbDhBQktqV2Jpd2RETEVPSzhzNUVDZXFKN3MzZCthRWxVKzhQ?=
 =?utf-8?B?STBlcnZKS09SKzVDVmdDOWxMdm5CeElBSldnWkpqN0VqemljMzlGNUhqQW0y?=
 =?utf-8?B?OS9VYzVlZFBMZTFtcFRQN3ozZGU2RWNRNWRuUENZRG5wd3czZ3R3RURQMUEw?=
 =?utf-8?B?ckxreGowcGZlYmVsVFJ4dDU0UUV4bjBDcFNJOUtacHQ5UEptNDBQbXhzdWYz?=
 =?utf-8?B?Qmlxc2Q4RXBqR3QzRTdVVEVRTUhkUzllMnFWY0MvWHp0S01zY2dIK3NHbTht?=
 =?utf-8?B?TG9sUW9RUFhDN1dWclR0Zndhd3djeW9OV1RvdjkxZENFOHZONTF3ejNtRnUr?=
 =?utf-8?B?T2hJK3V1NExweWNjUzBHSHFuQ2VUaDlEK1FLc2hMZ0xMc3liQmFndEd6VVNK?=
 =?utf-8?B?ZW1RZm1zSzBTUFNrbHo2VVZXKzQxZmJZN1BCd0dhYnl6VE1yKzAwd3k0bk1I?=
 =?utf-8?B?eE5zUDNkeHc4dlY3bEkwNWNxdENmbTQwVkVNaFp5MDNsL0FMT0xWdHFqNW1R?=
 =?utf-8?B?UE9XeXVXYktEYXVPOVBDd0c4Y3g0bHJwT1JJWE1kaXo4Uyt4SUdtV2RUd3d1?=
 =?utf-8?B?ZlNOREZNdDVqOWVnTk9rL2g1L0pmZDJoUllOazhaY2FmY2NIZFRmUkgvUGxQ?=
 =?utf-8?B?RTZVeEgwUzYreW5zeVRqa0NkZ1BidGZsTzFFNE5PTU13c0ZyekNHblN1ME8z?=
 =?utf-8?B?WVkvd2gwZ3J1VHRmQTU0di9NTTcyeGt1UEd4N2ZCZzJEVzduZk4vOVVWQ1FW?=
 =?utf-8?B?MFV2Mlp6dUJKQzQ4ejc2SkVjZk5Va2d1NHZIcWpQYk5QclpQVWJaK2RmSWFt?=
 =?utf-8?B?Q2hKZHFiNXdJcGNyQy9Eb1NPTExnYlU1emsyYXY3ZjhnM1pBMVB6ZlVDTWF6?=
 =?utf-8?B?UitMZzJXdzdxaFBCZG85UUlRcEhaZmdSUUs3TWlRTlFwNXJ6NWNKV01SWVRB?=
 =?utf-8?B?cUdJbGJsczJlRWl1TWhETXVmN29RWksrNTZTQ05oUG5sR0lCVTI1U1VHZ3hK?=
 =?utf-8?B?YWxjK3dzcnFNTklYaTJtNG5BaGxEaEo5emxSRkJ0TzUrU1ZyNStXQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25337edf-be53-4d1c-1146-08df26214ae5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 16:20:54.6602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i99WZ8+J0edaPXmZatiNHMRC97ET/nw1hCezHJ8cs71xUluROrxNof8vHAVkigP51T5qouwGvLBq3HDmMAWVUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4362
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


On 10/7/26 21:45, Pierre-Louis Bossart wrote:
>>> general comment: this patch is quite complex, with code needed for the
>>> BTP side as well as the DMA side, only interleaved. Is there a way to
>>> have a 'cleaner' split between DMA functionality on the ACP side and BPT
>>> on the SoundWire bus side?
>>>
>>> Likewise the parts dealing with contiguous and non-contiguous parts of
>>> the firmware should be handled at a higher level using DMA/BTP support
>>> lower-level routines.
>> Agreed, I'll restructure this into three layers for v5: ACP BRA /DMA/
>> primitives (configure descriptor, arm, poll/wait, disarm, deconfigure)
>> with no SoundWire-stream knowledge; SoundWire /BPT/ primitives (open/
>> close stream, enable/disable);
>> and a higher-level orchestrator with a dispatcher for the contiguous
>> (single-buffer) vs non-contiguous (per-section loop, with the small-
>> section sdw_nwrite/nread fallback) cases.
> Sounds good.
>
>> One hardware detail I'll preserve and document along the way: the
>> SoundWire bank switch is itself the BRA DMA start trigger,and correct
>> teardown requires disarming the DMA before the disable-path bank switch.
> That sounds fine, provided that hardware pushes a invalid BPT frame on
> the link in the time window between the disarming and bank switch.
> Otherwise the peripherals might receive garbage BTP data, no?
You're right to flag this. The early disarm only runs on the error path 
— it's gated on the transfer having already timed out or failed (if (ret 
< 0) before sdw_disable_stream()),
so on a normal completion it's skipped entirely and there's no 
disarm-before-switch window on a good transfer (the ordering is in Q2).
On the error path the transfer is already being failed back to the 
caller and the firmware download is retried/aborted, so its result is 
never relied upon.
I also keep the error interrupt masked (ACP_SW_ERROR_INTR_MASK) and the 
error-reason registers cleared across the teardown, so the expected 
teardown error isn't mis-reported as a fresh failure.
If it helps, I'm happy to add an explicit note in the comment that the 
error-path frame is discarded by the retry rather than relied upon.
>> So the orchestrator still sequences an ACP call and a SoundWire call in
>> a fixed order — the layering makes each side independently readable and
>> testable while keeping that ordering contract explicit.
>>
>>>> +static int amd_sdw_execute_bra_transfer(struct amd_sdw_manager *amd_manager,
>>>> +					struct sdw_slave *slave,
>>>> +					bool *dma_unsafe)
>>>> +{
>>>> +	struct sdw_bus *bus = &amd_manager->bus;
>>>> +	u32 i2s_err_offset;
>>>> +	u32 saved_intr_mask;
>>>> +	u32 reg_addr, len;
>>>> +	u32 val;
>>>> +	int ret, ret_disable;
>>>> +
>>>> +	/* Read descriptor regs before enabling the DMA engine. */
>>>> +	reg_addr = readl(amd_manager->mmio + ACP_SW_BPT_PORT_FIRST_BYTE_ADDR);
>>>> +	len = readl(amd_manager->mmio + ACP_SW_BRA_TRANSFER_SIZE);
>>>> +
>>>> +	i2s_err_offset = (amd_manager->instance == 0) ?
>>>> +			 ACP_SW_I2S_ERROR_REASON : ACP_P1_SW_I2S_ERROR_REASON;
>>>> +
>>>> +	/*
>>>> +	 * Save and disable the error interrupt mask for manual error
>>>> +	 * checking.  acp_bra_lock is held across the whole BPT sequence by
>>>> +	 * amd_sdw_bpt_wait(), which serialises this shared-register
>>>> +	 * read-modify-write against the other manager instance.
>>>> +	 */
>>>> +	saved_intr_mask = readl(amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
>>>> +	writel(0, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
>>>> +	writel(0, amd_manager->acp_mmio + i2s_err_offset);
>>>> +	writel(0, amd_manager->mmio + ACP_SW_ERROR_REASON1);
>>>> +
>>>> +	/* Arm the ACP BPT DMA engine */
>>>> +	writel(1, amd_manager->mmio + ACP_SW_BPT_PORT_EN);
>>>> +
>>>> +	/*
>>>> +	 * Use the framework's sdw_enable_stream() to write CHANNELEN and
>>>> +	 * perform a bank switch.  The ACP BPT hardware uses the bank switch
>>>> +	 * as the trigger to start the DMA transfer.  The framework manages
>>> do you mean to say
>>> a) the DMA transfer was armed and started ealier, and the bank switch
>>> unblocks it, ob
>>> b) the DMA starts fetching data from memory when the bank switch happens?
>>>
>>> the latter case would be quite racy and dependent on the time needed to
>>> access memory..
>> It's (a). The BRA descriptor (BASE_ADDRESS/TRANSFER_SIZE/FRAME_FORMAT)
>> is fully programmed in amd_sdw_config_bra_descriptor(),
>> and the engine is armed with ACP_SW_BPT_PORT_EN=1, both before
>> sdw_enable_stream().
>> The bank switch is only the trigger for the already-armed engine — it
>> doesn't start a cold engine, so there's no memory-latency race on the
>> switch.
> ok
>
>> Once triggered the engine runs autonomously frame by frame, and any
>> stall/underrun surfaces as a BRA/I2S error (ACP_SW_I2S_ERROR_REASON /
>> ACP_SW_BRA_RESP), not silent corruption.
> but then if I follow your explanations above, if you stop the DMA first
> don't you get a systematic xrun error before the bank switch happens?
That would be true if the engine were still running, but on the normal 
path it has already finished before we stop it. The order is:

 1. arm (ACP_SW_BPT_PORT_EN=1, armed but idle)
 2. sdw_enable_stream() — the bank switch triggers the armed engine
 3. poll ACP_SW_BRA_DMA_BUSY to zero (transfer completes)
 4. ret == 0, so the early PORT_EN=0 is skipped
 5. sdw_disable_stream() — bank switch, CHANNELEN=0
 6. PORT_EN=0 on an already-idle engine (a no-op)

So there's no "stop a running engine, then switch" on the normal path, 
and hence no xrun. The early disarm only runs on an already-failed 
transfer, where the xrun is expected and is masked/cleared as above.
>> This is also why, on an aborted or timed-out transfer, the teardown
>> clears PORT_EN before the sdw_disable_stream() bank switch — otherwise
>> that switch
>> could re-trigger the armed engine into a buffer we're about to free.
>> I'll reword the comment to say the engine is armed here and the bank
>> switch only triggers it.
> ok
>
> [...]
>
>>>> +	/*
>>>> +	 * The ATU GRP_1 and scratch PTE registers programmed here are
>>>> +	 * ACP-global and shared by both SoundWire manager instances, as is the
>>>> +	 * BRA DMA engine that reads through them.  bpt_lock is per-manager and
>>>> +	 * does not serialise across instances, so hold the ACP-wide
>>>> +	 * acp_bra_lock across the whole configure -> transfer -> deconfigure
>>>> +	 * sequence to stop the other instance reprogramming the shared PTEs
>>>> +	 * mid-transfer.
>>> In that case, what is the point of having a per-instance btp_lock as well?
>>>
>>> It seems from the comment that only *one* BTP transfer can take place
>>> across all manager instances, which defeats the purpose of a
>>> per-instance lock, no?
>>> What I am missing?
>> You're right that the transfer itself is serialized ACP-wide: that's
>> acp_bra_lock, held only across configure → transfer → deconfigure,
>> because the ATU PTEs and
>>   the BRA DMA engine are single resources shared by both links. bpt_lock
>> is per-link and has a different scope rather than a different transfer
>> window:
>>
>>    * It guards bpt_disabled, which is per-link suspend/clock-stop/
>>      runtime-PM state — each link's amd_suspend()/clock-stop
>>      sets it and amd_resume_runtime() clears it under bpt_lock. A per-
>>      link flag doesn't belong under an ACP-global lock.
>>    * It serializes multiple BPT requests to the same link and lets that
>>      link's suspend path drain an in-flight transfer, without reaching
>>      for the global lock.
>>    * It keeps acp_bra_lock's hold time minimal: the per-link setup/
>>      teardown (open_stream, dma_alloc, the PM get/put, the bpt_disabled
>>      check) runs
>>      under bpt_lock but outside acp_bra_lock, so the other link contends
>>      for the global lock only during the actual shared-hardware window,
>>      not the whole sequence.
>>
>> Folding everything onto acp_bra_lock would mean the global lock has to
>> cover each link's full transfer path including its runtime-PM callbacks,
>>   i.e. one link's PM transitions would serialize against the other link's
>> transfer — a scope mismatch and a longer global hold time.
>>   So the two are intentionally different scopes: bpt_lock = per-link
>> lifecycle/PM, acp_bra_lock = ACP-global shared hardware. Today the
>> comment only documents acp_bra_lock; I'll expand it to cover both.
> The explanation make sense... but I am not fully clear on why you'd need
> to protect the BPT state for link-based pm_runtime. Presumably a BPT
> transfer would happen with a device reference held to prevent it from
> suspending? Something's not right if you need to drain a BPT transfer in
> a pm_runtime suspend, that suspend shouldn't happen in the first place...
You're right, and thanks for catching it — I described this poorly 
earlier. A BPT transfer takes pm_runtime_get_sync() in 
amd_sdw_bpt_wait() and holds the reference until the matching put after 
the transfer,
so usage_count stays > 0 and runtime suspend can't be entered while a 
transfer is in flight. amd_suspend_runtime() doesn't touch bpt_disabled 
at all — there's no draining of a runtime-PM suspend.
The mutex_trylock(&bpt_lock) there is only belt-and-braces for that 
invariant.
bpt_disabled exists only for the case the held reference can't cover: 
the system-sleep path. There runtime PM is disabled, so a BPT request's 
pm_runtime_get_sync() returns -EACCES instead of resuming the device,
and it would otherwise proceed with the bus clock stopped. That's a real 
scenario for us — the power-off-mode resume-time firmware re-download 
runs while userspace is still frozen.
  So amd_suspend() latches bpt_disabled under bpt_lock before 
amd_sdw_clock_stop(), any such request bails out with -ESHUTDOWN, and 
amd_resume_runtime() clears it once the clock is back.
amd_sdw_manager_remove() latches it for the same reason against 
sdw_bus_master_delete().
So the scope is really: bpt_lock = per-link serialization of BPT 
requests against that link's system suspend/resume clock-stop and driver 
removal (not runtime PM); acp_bra_lock = ACP-global serialization
of the shared BRA engine/ATU across the two links. I'll fix the comment 
that currently implies bpt_lock covers runtime-PM state — thanks for 
pointing it out.
