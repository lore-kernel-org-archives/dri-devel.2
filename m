Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F31CA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 10:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FDEC10E253;
	Tue,  6 Oct 2026 10:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pXXxVg5w";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B39710E253
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 10:27:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqOABtv1DOcg7puWAYhMwwCQ05+kuz7qEbAZQ5J4vF/OxMBwzV5vle9LY2gWgACAQRzv+OEjbJ16phPbOxun5oLgwfnskecnAIFghSxbuBejF78pnfk3dH+Fcqm9OM1ZGraunQh/Twbm2koYOqIu2JDyffAFUpA2tjOgclqZh3qcjqbRxvzo9HvHwio0HMdTdiqyNZwOJ6nPnFwmTb5tMS9NBxe0S+wCFeIvrsCFnWWKbGRCuztxS0PcuoNn/f67WcTYWYiLrSF0DCQrwP6ZnHxaU/vVK7sl1t5mPXHkh4V0H0T8IWTUAWPDIJTrJHIuRxlFjpqh9yUW8X2hLcKqKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deaACu02DnjK3vw48FoOB7wUMksXFVQA5n1BvfkQtQA=;
 b=iJg9IyvfbPvfu0RaAaedqZk2ElASV8VdjUze3oDWVi22H3KIkNqMLzfrcndBa48ND17cZhLxO2cCnsG9A29bO3ywClcQMhxNfc8LDtGIoKA+8CS1hMCSDrZr9gqUv5BvtzRJsYYOYD28ur+DQDeZo47eb441Dt1kB/tf6upDh8NJx4q6nLGt9IY0g5A/mPqj1kYKXvLKW7BqU0vZwwf7o0TK+C3G889aei40wgbI3eTz5QiS9/bN02kNXYrcHHvrIPnCkmbNj/YCmIlfueNXhZvl1qHKX4oIOjhOtzlQxqMQeur1pjaMzF4J12Dik7EwQdfktRI+hlD0IA1msBNxeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deaACu02DnjK3vw48FoOB7wUMksXFVQA5n1BvfkQtQA=;
 b=pXXxVg5wiaMTQObr9pmWyUbsLKmTttJ79940iQWC5WgCFPcY64+r6Q9q7rJiDK7CTs6fXUkK3mZ6tz8A4H5AnDRkoUF97zKbbn/BhTqgxRppZzsJEjdcyeQNJht3wBR4Ynx0KISlj6o18JFm028FlDtChSZQ8/BtedQKUkrfiG8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 by IA4PR12MB9812.namprd12.prod.outlook.com (2603:10b6:208:55b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 10:27:13 +0000
Received: from BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::8e9c:2f3d:9679:942e]) by BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::8e9c:2f3d:9679:942e%5]) with mapi id 15.21.0472.015; Tue, 6 Oct 2026
 10:27:12 +0000
Content-Type: multipart/alternative;
 boundary="------------HcgNXXp0TaC7Kuj30BHYAbqB"
Message-ID: <87dff7bd-fa1d-4153-8dd1-75947a25a466@amd.com>
Date: Tue, 6 Oct 2026 15:56:56 +0530
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
Content-Language: en-US
From: Syed Saba Kareem <syed.sabakareem@amd.com>
In-Reply-To: <b8ab667c-8de2-47db-8fac-49faddd18f1a@linux.dev>
X-ClientProxiedBy: PN5PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:260::13) To BN9PR12MB5356.namprd12.prod.outlook.com
 (2603:10b6:408:105::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5356:EE_|IA4PR12MB9812:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d13ea3-d4ed-4a32-bcce-08df2394627a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|7416014|376014|10067099003|56012099006|4143699003|11063799006|6133799003|3023799007|8096899003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rhJy7wrYdj5AY8/PHpdYaHV04sManqt702eP1RDvJP+05peTScnsEH0EQA4HWfBSbR5Gg70eQ5HuTRG43ySqEyIfhsuiiVYfC+yMqPCxOgPthFPOtb44u492u4sTWAs/jO9mkvTnp2UQ4zi7JXTYrc5BDa0RS3PAF0TyJwSMZRb40HTF02OpFRf+/xdRrUocqZeE29rqLZI8auLKQiy7wzyxIYiZls7VgNkypOWTSEqS9o7KFbkMM4rHiEC5w392KDHA5aGuFxNUl5QkORjRGOM04gm8nNdUy9+uvdirJGAvMzVV2P05syIiAV208u6oHL5gXqzNcrhZCGxXKfBNi3k+6v0t7rM77CivcsfdvA83zJjY64BLAIh0nvkzBi1YO05JEy+V18qs7tXPKtmI3xuAohiEnVBoF3D6QivRPXsl134qywW8jEIF8e5iaPzhAJiG/3uqnJG96O0Wpje/FW+Mmaf8eGjq5vtcRythC35G/7VMIqWcXRM6KnsP+npVWjQbD5dq/kxZFetxoUWic5sUng390/NiUP133Jx6mNLhk6avDlkddILz33khWEXCql2pLRP9miHN86Dcz3Au1Jgkr4sKhDdn14001hki9q/DCrWDNNjnUdZySp5fU7Eut/kR2gTuwYaJ8AmKv5Td9HjrRUiXfhtDJjm9QYffaOA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(10067099003)(56012099006)(4143699003)(11063799006)(6133799003)(3023799007)(8096899003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2hGSFlnMzd1b25DeU5BdTBYdm5TRTBMZUYwZjF3cERXN2FHRzRaUlNnZ3Vq?=
 =?utf-8?B?bWw0VUx4L3V5b2dvL3JOOTFBV2wxMjFjNGh0TVl0MnM0T2tKZXA0eEg3QUNI?=
 =?utf-8?B?c3JodnEvdm1yMFFGR2dGdlc4RnFpWnc3VlgzQTRvVktYWi9LRUpSMUtVZHhj?=
 =?utf-8?B?bHh6WFpXZnNOelFkTmp0RDdWcVVKM1JjYjdPU3pSTm82QXdFZVg1ZkxuVHQv?=
 =?utf-8?B?a3NiQTdsVU5kdTRQZURhRWF6RENkQXI5UVV2SDAzVFovanpMVXhzRFZvLzFs?=
 =?utf-8?B?Qnp1a0J1TDRJK1JxaTJWa0k5VXBXMC9qa0Z2N0tQTis1RExMNzEwL1p6OVMr?=
 =?utf-8?B?Q2VEWDh1UnhEQURZWERWQU1oaVg1WHdkMnNJY3BSWlVvTXlEWVFjWDh6anNE?=
 =?utf-8?B?WGtjM1drY01uMi8vMVJtckVZQS8xMFdJSlJHWnIzUXMvR09ndzZiZXhRb0lG?=
 =?utf-8?B?L1FHSVc2emhBZUY3WGVDd0VYblZtaVRpN1czZ0xrQVRLOWpSUi9hNTBOWFhR?=
 =?utf-8?B?UVJRMkd0MnZXZVpXRmlUNzRWVFp5OFo4VldiZjROUlJGNkRnVS9pVUhyc01M?=
 =?utf-8?B?c2pNVjlDdDRsLzhpTkJCdzZxekJRcER6TEttcCtBNlo1ckVpWGZFZTI5c0s0?=
 =?utf-8?B?T0t5YlVJK3BTVFpSMnVyVHpoZHRuVTJKZWg5NExqWlp2VS9UMVE5NFJIN0Rr?=
 =?utf-8?B?T3dRcWgwY1FRdTRDcHl1SjVLcTh3QlJQV2ZwdzREaVFkazZKN09kY1JWYVZk?=
 =?utf-8?B?Q3hyYW5sb3hJUzlTU2x2ZEV2TjRMTGoxVGo3MTN1YlBNZ2NXY1lXY0xHM0Nw?=
 =?utf-8?B?ajZXZmN6ZFliZW9JTUMxTXM5MzV5V2x5WWZpejBsbHV0Y2JZQU1JeUZ4T0JW?=
 =?utf-8?B?Wk9WWTFjSktGYU9mWk8rWmxTbFpNaTQvRjMwdUxpdFRvMFBPUjBzY1hzTGl2?=
 =?utf-8?B?c21tSXhtYWVhcTEvRHVNWnB2UEhlaXpZWUxHUGhuOGh3eHBwQXE0UWN1S3cx?=
 =?utf-8?B?NUMwYXEwRVo0amFUemh5c0VOUTkxUVlUZmZmWWc5ZUc2a1ovNHFRWmVIbjJT?=
 =?utf-8?B?cUgvZ1VNNGlWc25BVGg1cXJqbkd1a1NpUkFTL0g3SXdUSkZkNzdXWjd0WHJP?=
 =?utf-8?B?bHJTNnVBMThVZ3R0WjZXR21sSGRtVEFUM29FMXY0MXAxdEt2QTZKb1JkQXRG?=
 =?utf-8?B?clFqemhCaG5nQlVzVUFRZUlCd204V254bGorS25UWGhDMVVaZGJQVkNxc2Fs?=
 =?utf-8?B?bVA3QS9IZld0QnkzU2RUTFlEQnEwYlpIUTgxN3lHNDNyS1ZzWXdlTkhyb25M?=
 =?utf-8?B?d3lPRGo3NGo0RHBWL0RldGk3cldZd0J6bHZtNXFpZDJGR0FaeGtXREhzMVl6?=
 =?utf-8?B?YnRuWkU5dVhYYXRtb2hrRlluYS9mRHUxeittQzcra3FxRHlyekJJZzh2N3I0?=
 =?utf-8?B?YThIbzl5dkkrNWpUUWh3N0tyR05jVVhCV2NuRGV2QXN5OFYzZmZtNWVNTk1G?=
 =?utf-8?B?VVJwSVRLdTZ5VDZhNTh4dE5oL2w5YitlR2ZmcEpKNjBkQ3duR2pYUFU2U0pQ?=
 =?utf-8?B?eUo3YVNraEFBWHcwMmMwT0VILzZFdVVld2lUSi9YdEgyUmNqVWtIMEtCV0R3?=
 =?utf-8?B?WGJMbThWT2t1cVBEa3VQNi92cmF1NXE4dS9KU0xydVZlQTZaaCtDQzZZN2ly?=
 =?utf-8?B?TDVaTUNaQVFsQzloZHNBTEd4QUxHWkFRMFZOZTd0cHlxc3lOaS9oVWErZmRH?=
 =?utf-8?B?eEswcGVna3RQTldUdXBaYlI2c0RGS2crejQ2YWVzbzF3TytLSWxDL2gyYURk?=
 =?utf-8?B?ZUxXSy9GWjdaK1dOTUtoSmVKY2FyRW9kNHFRSWhBcXdRcUxvNkd4RkVyaHU1?=
 =?utf-8?B?c3c1RGp6c1pjWDFScHdxODI0OTFycTFmc2hXd09JRmhKeTZFUVo4Rnc2OUNl?=
 =?utf-8?B?UzBReTJvNkhCbENHWmFCWFhDWHBqT040U0tIR29DRWFDTTd1UU9UZVFGYXho?=
 =?utf-8?B?bUNENUFjZ1JWNnV5bzZ1STExdnVQVGd1L3FFclpPUUY2bStlZ2VhTzJ1THl3?=
 =?utf-8?B?UzkyaDJOT0FIMUNJWEhvUS9FbWlSRWMyeGRHUGZvbnp3UWVvT01USTRSNFE5?=
 =?utf-8?B?aFRUendIVjlkK1dKaE4yRDExVlgrT09BVHhpNkdvbXUzaUo2THJSWVYrTlVV?=
 =?utf-8?B?RVFDL0hSSDRzQ3U2WUN6ZDRQV0MvaHJzcGt6QmVpVm5KalRXU0pXTlY0TUti?=
 =?utf-8?B?VWZsT0U2cWJNR0IwWmV0ZFYvUFZBSmlXMFkrWUZERjBQY3Z4a01Mb0kwdk9y?=
 =?utf-8?B?RkFiMjAvZHhBOUtnc0NURlJUOFpnY0hkYUpMK2haRDlERlVldWlxZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d13ea3-d4ed-4a32-bcce-08df2394627a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 10:27:12.8721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5h29BcQfZJ0qhbztbC5ATe9x6Bnwd6JlmeVfxZOTDdK5+Hcg+huX9ExXLOSp+csTAkgH5bAOdf4RkxDo6hKEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9812
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

--------------HcgNXXp0TaC7Kuj30BHYAbqB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/5/26 17:34, Pierre-Louis Bossart wrote:
> general comment: this patch is quite complex, with code needed for the
> BTP side as well as the DMA side, only interleaved. Is there a way to
> have a 'cleaner' split between DMA functionality on the ACP side and BPT
> on the SoundWire bus side?
>
> Likewise the parts dealing with contiguous and non-contiguous parts of
> the firmware should be handled at a higher level using DMA/BTP support
> lower-level routines.

Agreed, I'll restructure this into three layers for v5: ACP BRA /DMA/ 
primitives (configure descriptor, arm, poll/wait, disarm, deconfigure) 
with no SoundWire-stream knowledge; SoundWire /BPT/ primitives 
(open/close stream, enable/disable);
and a higher-level orchestrator with a dispatcher for the contiguous 
(single-buffer) vs non-contiguous (per-section loop, with the 
small-section sdw_nwrite/nread fallback) cases.

One hardware detail I'll preserve and document along the way: the 
SoundWire bank switch is itself the BRA DMA start trigger,and correct 
teardown requires disarming the DMA before the disable-path bank switch.
So the orchestrator still sequences an ACP call and a SoundWire call in 
a fixed order — the layering makes each side independently readable and 
testable while keeping that ordering contract explicit.

>> +static int amd_sdw_execute_bra_transfer(struct amd_sdw_manager *amd_manager,
>> +					struct sdw_slave *slave,
>> +					bool *dma_unsafe)
>> +{
>> +	struct sdw_bus *bus = &amd_manager->bus;
>> +	u32 i2s_err_offset;
>> +	u32 saved_intr_mask;
>> +	u32 reg_addr, len;
>> +	u32 val;
>> +	int ret, ret_disable;
>> +
>> +	/* Read descriptor regs before enabling the DMA engine. */
>> +	reg_addr = readl(amd_manager->mmio + ACP_SW_BPT_PORT_FIRST_BYTE_ADDR);
>> +	len = readl(amd_manager->mmio + ACP_SW_BRA_TRANSFER_SIZE);
>> +
>> +	i2s_err_offset = (amd_manager->instance == 0) ?
>> +			 ACP_SW_I2S_ERROR_REASON : ACP_P1_SW_I2S_ERROR_REASON;
>> +
>> +	/*
>> +	 * Save and disable the error interrupt mask for manual error
>> +	 * checking.  acp_bra_lock is held across the whole BPT sequence by
>> +	 * amd_sdw_bpt_wait(), which serialises this shared-register
>> +	 * read-modify-write against the other manager instance.
>> +	 */
>> +	saved_intr_mask = readl(amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
>> +	writel(0, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
>> +	writel(0, amd_manager->acp_mmio + i2s_err_offset);
>> +	writel(0, amd_manager->mmio + ACP_SW_ERROR_REASON1);
>> +
>> +	/* Arm the ACP BPT DMA engine */
>> +	writel(1, amd_manager->mmio + ACP_SW_BPT_PORT_EN);
>> +
>> +	/*
>> +	 * Use the framework's sdw_enable_stream() to write CHANNELEN and
>> +	 * perform a bank switch.  The ACP BPT hardware uses the bank switch
>> +	 * as the trigger to start the DMA transfer.  The framework manages
> do you mean to say
> a) the DMA transfer was armed and started ealier, and the bank switch
> unblocks it, ob
> b) the DMA starts fetching data from memory when the bank switch happens?
>
> the latter case would be quite racy and dependent on the time needed to
> access memory..
It's (a). The BRA descriptor (BASE_ADDRESS/TRANSFER_SIZE/FRAME_FORMAT) 
is fully programmed in amd_sdw_config_bra_descriptor(),
and the engine is armed with ACP_SW_BPT_PORT_EN=1, both before 
sdw_enable_stream().
The bank switch is only the trigger for the already-armed engine — it 
doesn't start a cold engine, so there's no memory-latency race on the 
switch.
Once triggered the engine runs autonomously frame by frame, and any 
stall/underrun surfaces as a BRA/I2S error (ACP_SW_I2S_ERROR_REASON / 
ACP_SW_BRA_RESP), not silent corruption.
This is also why, on an aborted or timed-out transfer, the teardown 
clears PORT_EN before the sdw_disable_stream() bank switch — otherwise 
that switch
could re-trigger the armed engine into a buffer we're about to free.
I'll reword the comment to say the engine is armed here and the bank 
switch only triggers it.
>> +	 * bank state consistently, eliminating the need for a manual bank
>> +	 * switch or DP0 bank mirror.
>> +	 */
>> +	dev_dbg(amd_manager->dev,
>> +		"BPT: pre-enable: curr_bank=%u next_bank=%u BPT_EN_STATUS=0x%x stream_state=%d\n",
>> +		bus->params.curr_bank, bus->params.next_bank,
>> +		readl(amd_manager->mmio + ACP_SW_BPT_PORT_EN_STATUS),
>> +		bus->bpt_stream->state);
>> +
>> +	ret = sdw_enable_stream(bus->bpt_stream);
>> +	if (ret < 0) {
>> +		dev_err(amd_manager->dev,
>> +			"BPT: sdw_enable_stream failed: %d\n", ret);
>> +		/*
>> +		 * Disarm the engine and wait for the port to quiesce before
>> +		 * returning: the caller (amd_sdw_bra_transfer()) then deconfigures
>> +		 * the BRA descriptor unconditionally, zeroing BASE_ADDRESS and
>> +		 * TRANSFER_SIZE, so the port must be idle first -- mirrors the
>> +		 * disable path below.
>> +		 */
>> +		writel(0, amd_manager->mmio + ACP_SW_BPT_PORT_EN);
>> +		ret_disable = readl_poll_timeout(amd_manager->mmio + ACP_SW_BPT_PORT_EN_STATUS,
>> +						 val, !val, ACP_DELAY_US, AMD_SDW_TIMEOUT);
>> +		if (ret_disable < 0) {
>> +			dev_err(amd_manager->dev, "BPT: PORT_EN disable timeout\n");
>> +			*dma_unsafe = true;
>> +		}
>> +		goto restore_intr;
>> +	}
>> +
>> +	dev_dbg(amd_manager->dev,
>> +		"BPT: DMA started: curr_bank=%u next_bank=%u BPT_EN_STATUS=0x%x stream_state=%d\n",
>> +		bus->params.curr_bank, bus->params.next_bank,
>> +		readl(amd_manager->mmio + ACP_SW_BPT_PORT_EN_STATUS),
>> +		bus->bpt_stream->state);
>> +
>> +	/* Poll DMA_BUSY until transfer completes */
>> +	{
>> +		unsigned long timeout;
>> +
>> +		timeout = jiffies + msecs_to_jiffies(BRA_DMA_TIMEOUT_MS);
>> +		do {
>> +			val = readl(amd_manager->mmio + ACP_SW_BRA_DMA_BUSY);
>> +			/*
>> +			 * Side-effectful read: reading ACP_SW_BRA_CURRENT_TRANSFER_SIZE
>> +			 * advances the BRA DMA engine to the next frame.  The value is
>> +			 * intentionally discarded (hence the (void) cast); removing this
>> +			 * read stalls multi-frame transfers, which then time out.
>> +			 */
>> +			(void)readl(amd_manager->mmio + ACP_SW_BRA_CURRENT_TRANSFER_SIZE);
>> +			if (!(val & 0x01))
>> +				break;
>> +			if (time_after(jiffies, timeout)) {
>> +				/*
>> +				 * Re-sample the busy bit before declaring a
>> +				 * timeout. cond_resched() below can park this
>> +				 * thread for longer than BRA_DMA_TIMEOUT_MS, in
>> +				 * which window the DMA may have completed; without
>> +				 * this final read a finished transfer would be
>> +				 * reported as a false timeout.
>> +				 */
>> +				val = readl(amd_manager->mmio + ACP_SW_BRA_DMA_BUSY);
>> +				if (!(val & 0x01))
>> +					break;
>> +				dev_err(amd_manager->dev,
>> +					"BPT: DMA timeout: periph=0x%08x len=%u EN_STATUS=0x%x RESP=0x%x I2S_ERR=0x%08x\n",
>> +					reg_addr, len,
>> +					readl(amd_manager->mmio + ACP_SW_BPT_PORT_EN_STATUS),
>> +					readl(amd_manager->mmio + ACP_SW_BRA_RESP),
>> +					readl(amd_manager->acp_mmio + i2s_err_offset));
>> +				ret = -ETIMEDOUT;
>> +				break;
>> +			}
>> +			/*
>> +			 * Runs in process context. Yield the CPU so a
>> +			 * multi-frame transfer cannot busy-spin for up to
>> +			 * BRA_DMA_TIMEOUT_MS and trip the soft lockup
>> +			 * watchdog on non-preemptible kernels. cond_resched()
>> +			 * keeps the poll cadence tight -- reading
>> +			 * ACP_SW_BRA_CURRENT_TRANSFER_SIZE every iteration is
>> +			 * required to advance the DMA engine between frames,
>> +			 * so usleep_range() (which would space out the reads)
>> +			 * is deliberately not used here.
>> +			 */
>> +			cond_resched();
>> +		} while (1);
>> +	}
>> +
>> +	/* Check for I2S/BRA errors */
>> +	val = readl(amd_manager->acp_mmio + i2s_err_offset);
>> +	if (val & AMD_SDW_BRA_I2S_ERROR_MASK) {
>> +		dev_err(amd_manager->dev,
>> +			"BPT: BRA failed I2S_ERROR_REASON=0x%08x (NAK=%u Clash=%u HdrResp=%u FtrResp=%u CRC=%u DMA=%u Cmd=%u)\n",
>> +			val,
>> +			!!(val & BIT(18)), !!(val & BIT(19)),
>> +			!!(val & BIT(26)), !!(val & BIT(27)),
>> +			!!(val & BIT(28)), !!(val & BIT(29)), !!(val & BIT(30)));
>> +		writel(0, amd_manager->acp_mmio + i2s_err_offset);
>> +		if (!ret)
>> +			ret = -EIO;
>> +	} else if (!ret) {
>> +		dev_dbg(amd_manager->dev,
>> +			"BPT: DMA done: periph=0x%08x len=%u\n", reg_addr, len);
>> +	}
>> +
>> +	/*
>> +	 * On an aborted or timed-out transfer the ACP BPT DMA engine can still
>> +	 * be armed (PORT_EN=1, DMA_BUSY=1). sdw_disable_stream() below performs
>> +	 * a bank switch, which is the BPT DMA start trigger, so disarm the engine
>> +	 * first -- otherwise the bank switch could (re)start a DMA write into
>> +	 * dma_buf, which amd_sdw_bpt_wait() frees as soon as this transfer
>> +	 * returns. On the success path the DMA has already completed, so this
>> +	 * early clear is a no-op.
>> +	 */
>> +	if (ret < 0)
>> +		writel(0, amd_manager->mmio + ACP_SW_BPT_PORT_EN);
>> +
>> +	/*
>> +	 * Disable the stream via framework (writes CHANNELEN=0 + bank switch).
>> +	 * This cleanly stops the port and keeps bank state consistent.
>> +	 * Propagate a disable failure: it leaves the stream in
>> +	 * SDW_STREAM_ENABLED, and sdw_enable_stream() returns 0 early for an
>> +	 * already-ENABLED stream without the bank switch that triggers the BRA
>> +	 * DMA, so the next section would be silently skipped rather than
>> +	 * transferred.  Report the failure to the caller so it stops instead of
>> +	 * chaining a section whose DMA never starts.
>> +	 */
>> +	ret_disable = sdw_disable_stream(bus->bpt_stream);
>> +	if (ret_disable < 0) {
>> +		dev_err(amd_manager->dev, "BPT: sdw_disable_stream failed: %d\n",
>> +			ret_disable);
>> +		if (!ret)
>> +			ret = ret_disable;
>> +	}
>> +
>> +	dev_dbg(amd_manager->dev,
>> +		"BPT: post-disable: curr_bank=%u next_bank=%u stream_state=%d\n",
>> +		bus->params.curr_bank, bus->params.next_bank,
>> +		bus->bpt_stream->state);
>> +
>> +	/*
>> +	 * Disarm the ACP BPT DMA engine and wait for the port to quiesce.
>> +	 * Like the manager enable/disable sequence (ACP_SW_EN paired with
>> +	 * ACP_SW_EN_STATUS), ACP_SW_BPT_PORT_EN_STATUS reflects the real port
>> +	 * state, so polling it here guarantees a non-contiguous transfer's next
>> +	 * section cannot re-arm PORT_EN before the current one has torn down.
>> +	 */
>> +	writel(0, amd_manager->mmio + ACP_SW_BPT_PORT_EN);
>> +	ret_disable = readl_poll_timeout(amd_manager->mmio + ACP_SW_BPT_PORT_EN_STATUS,
>> +					 val, !val, ACP_DELAY_US, AMD_SDW_TIMEOUT);
>> +	if (ret_disable < 0) {
>> +		dev_err(amd_manager->dev, "BPT: PORT_EN disable timeout\n");
>> +		if (!ret)
>> +			ret = ret_disable;
>> +		*dma_unsafe = true;
>> +	}
>> +	writel(0, amd_manager->acp_mmio + i2s_err_offset);
>> +	writel(0, amd_manager->mmio + ACP_SW_ERROR_REASON1);
>> +	/*
>> +	 * Clearing the immediate-command response-valid status races with the
>> +	 * immediate-command path (amd_sdw_send_cmd_get_resp()), which polls and
>> +	 * clears the same ACP_SW_IMM_CMD_STS bit under bus->msg_lock. The BPT DMA
>> +	 * poll loop above drops all locks, so a concurrent slave enumeration or
>> +	 * register access (amd_sdw_work / IRQ thread / codec regmap) can be
>> +	 * mid-command here. Take msg_lock so this teardown clear cannot erase a
>> +	 * response the command path has not yet consumed, which would make that
>> +	 * command time out. This msg_lock nests inside acp_bra_lock and bpt_lock,
>> +	 * both already held by the enclosing amd_sdw_bpt_wait(), preserving the
>> +	 * bpt_lock -> acp_bra_lock -> msg_lock order. do_bank_switch() inside
>> +	 * sdw_enable_stream()/sdw_disable_stream() only takes msg_lock for
>> +	 * multi-link managers, so this single-link manager establishes that order
>> +	 * via the explicit msg_lock here and in the non-contiguous
>> +	 * sdw_nwrite_no_pm()/sdw_nread_no_pm() fallback.
>> +	 */
>> +	mutex_lock(&bus->msg_lock);
>> +	writel(AMD_SDW_IMM_RES_VALID, amd_manager->mmio + ACP_SW_IMM_CMD_STS);
>> +	mutex_unlock(&bus->msg_lock);
>> +
>> +restore_intr:
>> +	writel(saved_intr_mask, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
>> +	return ret;
>> +}
> [...]
>
>> +static int amd_sdw_bpt_wait(struct sdw_bus *bus,
>> +			    struct sdw_slave *slave,
>> +			    struct sdw_bpt_msg *msg)
>> +{
>> +	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
>> +	bool is_write = (msg->flags & SDW_MSG_FLAG_WRITE);
>> +	struct amd_bra_params prep_params = {0};
>> +	u32 acp_sys_addr;
>> +	dma_addr_t dma_addr = 0;
>> +	u8 *dma_buf = NULL;
>> +	size_t offset = 0;
>> +	size_t total_len = 0;
>> +	int ret = 0;
>> +	int i;
>> +	bool dma_unsafe = false;
>> +
>> +	for (i = 0; i < msg->sections; i++) {
>> +		if (msg->sec[i].len > SDW_BPT_MSG_MAX_BYTES - total_len) {
>> +			dev_err(amd_manager->dev,
>> +				"BPT msg length exceeds maximum %d bytes\n",
>> +				SDW_BPT_MSG_MAX_BYTES);
>> +			return -EINVAL;
>> +		}
>> +		total_len += msg->sec[i].len;
>> +	}
>> +
>> +	if (total_len < AMD_BPT_MSG_BYTE_MIN) {
>> +		dev_err(amd_manager->dev,
>> +			"BPT msg length %zu < minimum %d bytes\n",
>> +			total_len, AMD_BPT_MSG_BYTE_MIN);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * Take the runtime-PM reference that keeps the bus clock alive before
>> +	 * acquiring bpt_lock, not after.  When the manager is runtime
>> +	 * suspended, pm_runtime_get_sync() runs amd_resume_runtime()
>> +	 * synchronously in this task, and that callback acquires bpt_lock to
>> +	 * clear bpt_disabled.  Taking the reference while already holding
>> +	 * bpt_lock would therefore deadlock against ourselves.
>> +	 */
>> +	ret = pm_runtime_get_sync(amd_manager->dev);
>> +	/*
>> +	 * -EACCES only occurs when runtime PM is disabled, which for this
>> +	 * device happens across the system suspend/resume window.  amd_suspend()
>> +	 * sets bpt_disabled before the clock is stopped and amd_resume_runtime()
>> +	 * clears it only once the clock is back, so the bpt_disabled check below
>> +	 * rejects the transfer with -ESHUTDOWN before any BRA access whenever the
>> +	 * clock could be down.  A merely runtime-suspended manager (clock stopped,
>> +	 * PM still enabled) is resumed by the get above and returns success, not
>> +	 * -EACCES; tolerating -EACCES therefore never drives the BRA engine on a
>> +	 * stopped clock.
>> +	 */
>> +	if (ret < 0 && ret != -EACCES) {
>> +		pm_runtime_put_noidle(amd_manager->dev);
>> +		dev_err(amd_manager->dev, "BPT: pm_runtime_get failed: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/*
>> +	 * The ACP BRA engine is a single shared resource.  Serialise all BPT
>> +	 * transfers so concurrent slave probes do not race over the hardware.
>> +	 */
>> +	mutex_lock(&amd_manager->bpt_lock);
>> +
>> +	/*
>> +	 * Refuse the transfer if the bus is being (or has been) clock-stopped
>> +	 * for system suspend.  Driving the BRA/command channel while the clock
>> +	 * is stopping wedges the channel and leaves the peripheral unable to
>> +	 * re-enumerate on resume; the codec retries once it re-attaches.
>> +	 */
>> +	if (amd_manager->bpt_disabled) {
>> +		mutex_unlock(&amd_manager->bpt_lock);
>> +		pm_runtime_mark_last_busy(amd_manager->dev);
>> +		pm_runtime_put_autosuspend(amd_manager->dev);
>> +		return -ESHUTDOWN;
>> +	}
>> +
>> +	/* BRA always uses all available data columns (1..NC-1). */
>> +	amd_manager->bra_hstart = 1;
>> +	amd_manager->bra_hstop  = bus->params.col - 1;
>> +
>> +	/*
>> +	 * Open the BPT stream so the framework stream state machine tracks the
>> +	 * transfer.  Slave DP0 is prepared below before bra_transfer().
>> +	 */
>> +	ret = amd_sdw_bpt_open_stream(amd_manager, slave, msg);
>> +	if (ret < 0)
>> +		goto close_stream;
>> +
>> +	/* Allocate single DMA buffer for entire BPT message */
>> +	dma_buf = dma_alloc_coherent(amd_manager->dev->parent, total_len,
>> +				     &dma_addr, GFP_KERNEL);
>> +	if (!dma_buf) {
>> +		ret = -ENOMEM;
>> +		goto close_stream;
>> +	}
>> +
>> +	/*
>> +	 * The ATU GRP_1 and scratch PTE registers programmed here are
>> +	 * ACP-global and shared by both SoundWire manager instances, as is the
>> +	 * BRA DMA engine that reads through them.  bpt_lock is per-manager and
>> +	 * does not serialise across instances, so hold the ACP-wide
>> +	 * acp_bra_lock across the whole configure -> transfer -> deconfigure
>> +	 * sequence to stop the other instance reprogramming the shared PTEs
>> +	 * mid-transfer.
> In that case, what is the point of having a per-instance btp_lock as well?
>
> It seems from the comment that only *one* BTP transfer can take place
> across all manager instances, which defeats the purpose of a
> per-instance lock, no?
> What I am missing?

You're right that the transfer itself is serialized ACP-wide: that's 
acp_bra_lock, held only across configure → transfer → deconfigure, 
because the ATU PTEs and
  the BRA DMA engine are single resources shared by both links. bpt_lock 
is per-link and has a different scope rather than a different transfer 
window:

  * It guards bpt_disabled, which is per-link
    suspend/clock-stop/runtime-PM state — each link's
    amd_suspend()/clock-stop
    sets it and amd_resume_runtime() clears it under bpt_lock. A
    per-link flag doesn't belong under an ACP-global lock.
  * It serializes multiple BPT requests to the same link and lets that
    link's suspend path drain an in-flight transfer, without reaching
    for the global lock.
  * It keeps acp_bra_lock's hold time minimal: the per-link
    setup/teardown (open_stream, dma_alloc, the PM get/put, the
    bpt_disabled check) runs
    under bpt_lock but outside acp_bra_lock, so the other link contends
    for the global lock only during the actual shared-hardware window,
    not the whole sequence.

Folding everything onto acp_bra_lock would mean the global lock has to 
cover each link's full transfer path including its runtime-PM callbacks,
  i.e. one link's PM transitions would serialize against the other 
link's transfer — a scope mismatch and a longer global hold time.
  So the two are intentionally different scopes: bpt_lock = per-link 
lifecycle/PM, acp_bra_lock = ACP-global shared hardware. Today the 
comment only documents acp_bra_lock; I'll expand it to cover both.

--------------HcgNXXp0TaC7Kuj30BHYAbqB
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/5/26 17:34, Pierre-Louis Bossart
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:b8ab667c-8de2-47db-8fac-49faddd18f1a@linux.dev">
      <pre wrap="" class="moz-quote-pre">general comment: this patch is quite complex, with code needed for the
BTP side as well as the DMA side, only interleaved. Is there a way to
have a 'cleaner' split between DMA functionality on the ACP side and BPT
on the SoundWire bus side?

Likewise the parts dealing with contiguous and non-contiguous parts of
the firmware should be handled at a higher level using DMA/BTP support
lower-level routines.
</pre>
    </blockquote>
    <span data-teams="true">
      <p><span style="font-size: inherit;">Agreed, I'll restructure this
          into three layers for v5: ACP BRA <i>DMA</i> primitives
          (configure descriptor, arm, poll/wait, disarm, deconfigure)
          with no SoundWire-stream knowledge; SoundWire <i>BPT</i>
          primitives (open/close stream, enable/disable);&nbsp;<br>
          and a higher-level orchestrator with a dispatcher for the
          contiguous (single-buffer) vs non-contiguous (per-section
          loop, with the small-section sdw_nwrite/nread fallback) cases.</span></p>
      <p><span style="font-size: inherit;">One hardware detail I'll
          preserve and document along the way: the SoundWire bank switch
          is itself the BRA DMA start trigger,and correct teardown
          requires disarming the DMA before the disable-path bank
          switch.&nbsp;<br>
          So the orchestrator still sequences an ACP call and a
          SoundWire call in a fixed order — the layering makes each side
          independently readable and testable while keeping that
          ordering contract explicit.</span></p>
    </span>
    <blockquote type="cite" cite="mid:b8ab667c-8de2-47db-8fac-49faddd18f1a@linux.dev">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+static int amd_sdw_execute_bra_transfer(struct amd_sdw_manager *amd_manager,
+					struct sdw_slave *slave,
+					bool *dma_unsafe)
+{
+	struct sdw_bus *bus = &amp;amd_manager-&gt;bus;
+	u32 i2s_err_offset;
+	u32 saved_intr_mask;
+	u32 reg_addr, len;
+	u32 val;
+	int ret, ret_disable;
+
+	/* Read descriptor regs before enabling the DMA engine. */
+	reg_addr = readl(amd_manager-&gt;mmio + ACP_SW_BPT_PORT_FIRST_BYTE_ADDR);
+	len = readl(amd_manager-&gt;mmio + ACP_SW_BRA_TRANSFER_SIZE);
+
+	i2s_err_offset = (amd_manager-&gt;instance == 0) ?
+			 ACP_SW_I2S_ERROR_REASON : ACP_P1_SW_I2S_ERROR_REASON;
+
+	/*
+	 * Save and disable the error interrupt mask for manual error
+	 * checking.  acp_bra_lock is held across the whole BPT sequence by
+	 * amd_sdw_bpt_wait(), which serialises this shared-register
+	 * read-modify-write against the other manager instance.
+	 */
+	saved_intr_mask = readl(amd_manager-&gt;mmio + ACP_SW_ERROR_INTR_MASK);
+	writel(0, amd_manager-&gt;mmio + ACP_SW_ERROR_INTR_MASK);
+	writel(0, amd_manager-&gt;acp_mmio + i2s_err_offset);
+	writel(0, amd_manager-&gt;mmio + ACP_SW_ERROR_REASON1);
+
+	/* Arm the ACP BPT DMA engine */
+	writel(1, amd_manager-&gt;mmio + ACP_SW_BPT_PORT_EN);
+
+	/*
+	 * Use the framework's sdw_enable_stream() to write CHANNELEN and
+	 * perform a bank switch.  The ACP BPT hardware uses the bank switch
+	 * as the trigger to start the DMA transfer.  The framework manages
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
do you mean to say
a) the DMA transfer was armed and started ealier, and the bank switch
unblocks it, ob
b) the DMA starts fetching data from memory when the bank switch happens?

the latter case would be quite racy and dependent on the time needed to
access memory..</pre>
    </blockquote>
    <span data-teams="true"><span style="font-size: inherit;">It's (a).
        The BRA descriptor (BASE_ADDRESS/TRANSFER_SIZE/FRAME_FORMAT) is
        fully programmed in amd_sdw_config_bra_descriptor(),&nbsp;<br>
        and the engine is armed with ACP_SW_BPT_PORT_EN=1, both before
        sdw_enable_stream().&nbsp;<br>
        The bank switch is only the trigger for the already-armed engine
        — it doesn't start a cold engine, so there's no memory-latency
        race on the switch.&nbsp;<br>
        Once triggered the engine runs autonomously frame by frame, and
        any stall/underrun surfaces as a BRA/I2S error
        (ACP_SW_I2S_ERROR_REASON / ACP_SW_BRA_RESP), not silent
        corruption.&nbsp;<br>
        This is also why, on an aborted or timed-out transfer, the
        teardown clears PORT_EN before the sdw_disable_stream() bank
        switch — otherwise that switch&nbsp;<br>
        could re-trigger the armed engine into a buffer we're about to
        free.&nbsp;<br>
        I'll reword the comment to say the engine is armed here and the
        bank switch only triggers it.</span></span>
    <blockquote type="cite" cite="mid:b8ab667c-8de2-47db-8fac-49faddd18f1a@linux.dev">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+	 * bank state consistently, eliminating the need for a manual bank
+	 * switch or DP0 bank mirror.
+	 */
+	dev_dbg(amd_manager-&gt;dev,
+		&quot;BPT: pre-enable: curr_bank=%u next_bank=%u BPT_EN_STATUS=0x%x stream_state=%d\n&quot;,
+		bus-&gt;params.curr_bank, bus-&gt;params.next_bank,
+		readl(amd_manager-&gt;mmio + ACP_SW_BPT_PORT_EN_STATUS),
+		bus-&gt;bpt_stream-&gt;state);
+
+	ret = sdw_enable_stream(bus-&gt;bpt_stream);
+	if (ret &lt; 0) {
+		dev_err(amd_manager-&gt;dev,
+			&quot;BPT: sdw_enable_stream failed: %d\n&quot;, ret);
+		/*
+		 * Disarm the engine and wait for the port to quiesce before
+		 * returning: the caller (amd_sdw_bra_transfer()) then deconfigures
+		 * the BRA descriptor unconditionally, zeroing BASE_ADDRESS and
+		 * TRANSFER_SIZE, so the port must be idle first -- mirrors the
+		 * disable path below.
+		 */
+		writel(0, amd_manager-&gt;mmio + ACP_SW_BPT_PORT_EN);
+		ret_disable = readl_poll_timeout(amd_manager-&gt;mmio + ACP_SW_BPT_PORT_EN_STATUS,
+						 val, !val, ACP_DELAY_US, AMD_SDW_TIMEOUT);
+		if (ret_disable &lt; 0) {
+			dev_err(amd_manager-&gt;dev, &quot;BPT: PORT_EN disable timeout\n&quot;);
+			*dma_unsafe = true;
+		}
+		goto restore_intr;
+	}
+
+	dev_dbg(amd_manager-&gt;dev,
+		&quot;BPT: DMA started: curr_bank=%u next_bank=%u BPT_EN_STATUS=0x%x stream_state=%d\n&quot;,
+		bus-&gt;params.curr_bank, bus-&gt;params.next_bank,
+		readl(amd_manager-&gt;mmio + ACP_SW_BPT_PORT_EN_STATUS),
+		bus-&gt;bpt_stream-&gt;state);
+
+	/* Poll DMA_BUSY until transfer completes */
+	{
+		unsigned long timeout;
+
+		timeout = jiffies + msecs_to_jiffies(BRA_DMA_TIMEOUT_MS);
+		do {
+			val = readl(amd_manager-&gt;mmio + ACP_SW_BRA_DMA_BUSY);
+			/*
+			 * Side-effectful read: reading ACP_SW_BRA_CURRENT_TRANSFER_SIZE
+			 * advances the BRA DMA engine to the next frame.  The value is
+			 * intentionally discarded (hence the (void) cast); removing this
+			 * read stalls multi-frame transfers, which then time out.
+			 */
+			(void)readl(amd_manager-&gt;mmio + ACP_SW_BRA_CURRENT_TRANSFER_SIZE);
+			if (!(val &amp; 0x01))
+				break;
+			if (time_after(jiffies, timeout)) {
+				/*
+				 * Re-sample the busy bit before declaring a
+				 * timeout. cond_resched() below can park this
+				 * thread for longer than BRA_DMA_TIMEOUT_MS, in
+				 * which window the DMA may have completed; without
+				 * this final read a finished transfer would be
+				 * reported as a false timeout.
+				 */
+				val = readl(amd_manager-&gt;mmio + ACP_SW_BRA_DMA_BUSY);
+				if (!(val &amp; 0x01))
+					break;
+				dev_err(amd_manager-&gt;dev,
+					&quot;BPT: DMA timeout: periph=0x%08x len=%u EN_STATUS=0x%x RESP=0x%x I2S_ERR=0x%08x\n&quot;,
+					reg_addr, len,
+					readl(amd_manager-&gt;mmio + ACP_SW_BPT_PORT_EN_STATUS),
+					readl(amd_manager-&gt;mmio + ACP_SW_BRA_RESP),
+					readl(amd_manager-&gt;acp_mmio + i2s_err_offset));
+				ret = -ETIMEDOUT;
+				break;
+			}
+			/*
+			 * Runs in process context. Yield the CPU so a
+			 * multi-frame transfer cannot busy-spin for up to
+			 * BRA_DMA_TIMEOUT_MS and trip the soft lockup
+			 * watchdog on non-preemptible kernels. cond_resched()
+			 * keeps the poll cadence tight -- reading
+			 * ACP_SW_BRA_CURRENT_TRANSFER_SIZE every iteration is
+			 * required to advance the DMA engine between frames,
+			 * so usleep_range() (which would space out the reads)
+			 * is deliberately not used here.
+			 */
+			cond_resched();
+		} while (1);
+	}
+
+	/* Check for I2S/BRA errors */
+	val = readl(amd_manager-&gt;acp_mmio + i2s_err_offset);
+	if (val &amp; AMD_SDW_BRA_I2S_ERROR_MASK) {
+		dev_err(amd_manager-&gt;dev,
+			&quot;BPT: BRA failed I2S_ERROR_REASON=0x%08x (NAK=%u Clash=%u HdrResp=%u FtrResp=%u CRC=%u DMA=%u Cmd=%u)\n&quot;,
+			val,
+			!!(val &amp; BIT(18)), !!(val &amp; BIT(19)),
+			!!(val &amp; BIT(26)), !!(val &amp; BIT(27)),
+			!!(val &amp; BIT(28)), !!(val &amp; BIT(29)), !!(val &amp; BIT(30)));
+		writel(0, amd_manager-&gt;acp_mmio + i2s_err_offset);
+		if (!ret)
+			ret = -EIO;
+	} else if (!ret) {
+		dev_dbg(amd_manager-&gt;dev,
+			&quot;BPT: DMA done: periph=0x%08x len=%u\n&quot;, reg_addr, len);
+	}
+
+	/*
+	 * On an aborted or timed-out transfer the ACP BPT DMA engine can still
+	 * be armed (PORT_EN=1, DMA_BUSY=1). sdw_disable_stream() below performs
+	 * a bank switch, which is the BPT DMA start trigger, so disarm the engine
+	 * first -- otherwise the bank switch could (re)start a DMA write into
+	 * dma_buf, which amd_sdw_bpt_wait() frees as soon as this transfer
+	 * returns. On the success path the DMA has already completed, so this
+	 * early clear is a no-op.
+	 */
+	if (ret &lt; 0)
+		writel(0, amd_manager-&gt;mmio + ACP_SW_BPT_PORT_EN);
+
+	/*
+	 * Disable the stream via framework (writes CHANNELEN=0 + bank switch).
+	 * This cleanly stops the port and keeps bank state consistent.
+	 * Propagate a disable failure: it leaves the stream in
+	 * SDW_STREAM_ENABLED, and sdw_enable_stream() returns 0 early for an
+	 * already-ENABLED stream without the bank switch that triggers the BRA
+	 * DMA, so the next section would be silently skipped rather than
+	 * transferred.  Report the failure to the caller so it stops instead of
+	 * chaining a section whose DMA never starts.
+	 */
+	ret_disable = sdw_disable_stream(bus-&gt;bpt_stream);
+	if (ret_disable &lt; 0) {
+		dev_err(amd_manager-&gt;dev, &quot;BPT: sdw_disable_stream failed: %d\n&quot;,
+			ret_disable);
+		if (!ret)
+			ret = ret_disable;
+	}
+
+	dev_dbg(amd_manager-&gt;dev,
+		&quot;BPT: post-disable: curr_bank=%u next_bank=%u stream_state=%d\n&quot;,
+		bus-&gt;params.curr_bank, bus-&gt;params.next_bank,
+		bus-&gt;bpt_stream-&gt;state);
+
+	/*
+	 * Disarm the ACP BPT DMA engine and wait for the port to quiesce.
+	 * Like the manager enable/disable sequence (ACP_SW_EN paired with
+	 * ACP_SW_EN_STATUS), ACP_SW_BPT_PORT_EN_STATUS reflects the real port
+	 * state, so polling it here guarantees a non-contiguous transfer's next
+	 * section cannot re-arm PORT_EN before the current one has torn down.
+	 */
+	writel(0, amd_manager-&gt;mmio + ACP_SW_BPT_PORT_EN);
+	ret_disable = readl_poll_timeout(amd_manager-&gt;mmio + ACP_SW_BPT_PORT_EN_STATUS,
+					 val, !val, ACP_DELAY_US, AMD_SDW_TIMEOUT);
+	if (ret_disable &lt; 0) {
+		dev_err(amd_manager-&gt;dev, &quot;BPT: PORT_EN disable timeout\n&quot;);
+		if (!ret)
+			ret = ret_disable;
+		*dma_unsafe = true;
+	}
+	writel(0, amd_manager-&gt;acp_mmio + i2s_err_offset);
+	writel(0, amd_manager-&gt;mmio + ACP_SW_ERROR_REASON1);
+	/*
+	 * Clearing the immediate-command response-valid status races with the
+	 * immediate-command path (amd_sdw_send_cmd_get_resp()), which polls and
+	 * clears the same ACP_SW_IMM_CMD_STS bit under bus-&gt;msg_lock. The BPT DMA
+	 * poll loop above drops all locks, so a concurrent slave enumeration or
+	 * register access (amd_sdw_work / IRQ thread / codec regmap) can be
+	 * mid-command here. Take msg_lock so this teardown clear cannot erase a
+	 * response the command path has not yet consumed, which would make that
+	 * command time out. This msg_lock nests inside acp_bra_lock and bpt_lock,
+	 * both already held by the enclosing amd_sdw_bpt_wait(), preserving the
+	 * bpt_lock -&gt; acp_bra_lock -&gt; msg_lock order. do_bank_switch() inside
+	 * sdw_enable_stream()/sdw_disable_stream() only takes msg_lock for
+	 * multi-link managers, so this single-link manager establishes that order
+	 * via the explicit msg_lock here and in the non-contiguous
+	 * sdw_nwrite_no_pm()/sdw_nread_no_pm() fallback.
+	 */
+	mutex_lock(&amp;bus-&gt;msg_lock);
+	writel(AMD_SDW_IMM_RES_VALID, amd_manager-&gt;mmio + ACP_SW_IMM_CMD_STS);
+	mutex_unlock(&amp;bus-&gt;msg_lock);
+
+restore_intr:
+	writel(saved_intr_mask, amd_manager-&gt;mmio + ACP_SW_ERROR_INTR_MASK);
+	return ret;
+}
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
[...]

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+static int amd_sdw_bpt_wait(struct sdw_bus *bus,
+			    struct sdw_slave *slave,
+			    struct sdw_bpt_msg *msg)
+{
+	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
+	bool is_write = (msg-&gt;flags &amp; SDW_MSG_FLAG_WRITE);
+	struct amd_bra_params prep_params = {0};
+	u32 acp_sys_addr;
+	dma_addr_t dma_addr = 0;
+	u8 *dma_buf = NULL;
+	size_t offset = 0;
+	size_t total_len = 0;
+	int ret = 0;
+	int i;
+	bool dma_unsafe = false;
+
+	for (i = 0; i &lt; msg-&gt;sections; i++) {
+		if (msg-&gt;sec[i].len &gt; SDW_BPT_MSG_MAX_BYTES - total_len) {
+			dev_err(amd_manager-&gt;dev,
+				&quot;BPT msg length exceeds maximum %d bytes\n&quot;,
+				SDW_BPT_MSG_MAX_BYTES);
+			return -EINVAL;
+		}
+		total_len += msg-&gt;sec[i].len;
+	}
+
+	if (total_len &lt; AMD_BPT_MSG_BYTE_MIN) {
+		dev_err(amd_manager-&gt;dev,
+			&quot;BPT msg length %zu &lt; minimum %d bytes\n&quot;,
+			total_len, AMD_BPT_MSG_BYTE_MIN);
+		return -EINVAL;
+	}
+
+	/*
+	 * Take the runtime-PM reference that keeps the bus clock alive before
+	 * acquiring bpt_lock, not after.  When the manager is runtime
+	 * suspended, pm_runtime_get_sync() runs amd_resume_runtime()
+	 * synchronously in this task, and that callback acquires bpt_lock to
+	 * clear bpt_disabled.  Taking the reference while already holding
+	 * bpt_lock would therefore deadlock against ourselves.
+	 */
+	ret = pm_runtime_get_sync(amd_manager-&gt;dev);
+	/*
+	 * -EACCES only occurs when runtime PM is disabled, which for this
+	 * device happens across the system suspend/resume window.  amd_suspend()
+	 * sets bpt_disabled before the clock is stopped and amd_resume_runtime()
+	 * clears it only once the clock is back, so the bpt_disabled check below
+	 * rejects the transfer with -ESHUTDOWN before any BRA access whenever the
+	 * clock could be down.  A merely runtime-suspended manager (clock stopped,
+	 * PM still enabled) is resumed by the get above and returns success, not
+	 * -EACCES; tolerating -EACCES therefore never drives the BRA engine on a
+	 * stopped clock.
+	 */
+	if (ret &lt; 0 &amp;&amp; ret != -EACCES) {
+		pm_runtime_put_noidle(amd_manager-&gt;dev);
+		dev_err(amd_manager-&gt;dev, &quot;BPT: pm_runtime_get failed: %d\n&quot;, ret);
+		return ret;
+	}
+
+	/*
+	 * The ACP BRA engine is a single shared resource.  Serialise all BPT
+	 * transfers so concurrent slave probes do not race over the hardware.
+	 */
+	mutex_lock(&amp;amd_manager-&gt;bpt_lock);
+
+	/*
+	 * Refuse the transfer if the bus is being (or has been) clock-stopped
+	 * for system suspend.  Driving the BRA/command channel while the clock
+	 * is stopping wedges the channel and leaves the peripheral unable to
+	 * re-enumerate on resume; the codec retries once it re-attaches.
+	 */
+	if (amd_manager-&gt;bpt_disabled) {
+		mutex_unlock(&amp;amd_manager-&gt;bpt_lock);
+		pm_runtime_mark_last_busy(amd_manager-&gt;dev);
+		pm_runtime_put_autosuspend(amd_manager-&gt;dev);
+		return -ESHUTDOWN;
+	}
+
+	/* BRA always uses all available data columns (1..NC-1). */
+	amd_manager-&gt;bra_hstart = 1;
+	amd_manager-&gt;bra_hstop  = bus-&gt;params.col - 1;
+
+	/*
+	 * Open the BPT stream so the framework stream state machine tracks the
+	 * transfer.  Slave DP0 is prepared below before bra_transfer().
+	 */
+	ret = amd_sdw_bpt_open_stream(amd_manager, slave, msg);
+	if (ret &lt; 0)
+		goto close_stream;
+
+	/* Allocate single DMA buffer for entire BPT message */
+	dma_buf = dma_alloc_coherent(amd_manager-&gt;dev-&gt;parent, total_len,
+				     &amp;dma_addr, GFP_KERNEL);
+	if (!dma_buf) {
+		ret = -ENOMEM;
+		goto close_stream;
+	}
+
+	/*
+	 * The ATU GRP_1 and scratch PTE registers programmed here are
+	 * ACP-global and shared by both SoundWire manager instances, as is the
+	 * BRA DMA engine that reads through them.  bpt_lock is per-manager and
+	 * does not serialise across instances, so hold the ACP-wide
+	 * acp_bra_lock across the whole configure -&gt; transfer -&gt; deconfigure
+	 * sequence to stop the other instance reprogramming the shared PTEs
+	 * mid-transfer.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
In that case, what is the point of having a per-instance btp_lock as well?

It seems from the comment that only *one* BTP transfer can take place
across all manager instances, which defeats the purpose of a
per-instance lock, no?
What I am missing?</pre>
    </blockquote>
    <span data-teams="true">
      <p><span style="font-size: inherit;">You're right that the
          transfer itself is serialized ACP-wide: that's acp_bra_lock,
          held only across configure → transfer → deconfigure, because
          the ATU PTEs and<br>
          &nbsp;the BRA DMA engine are single resources shared by both links.
          bpt_lock is per-link and has a different scope rather than a
          different transfer window:</span></p>
      <ul>
        <li>It guards bpt_disabled, which is per-link
          suspend/clock-stop/runtime-PM state — each link's
          amd_suspend()/clock-stop&nbsp;<br>
          sets it and amd_resume_runtime() clears it under bpt_lock. A
          per-link flag doesn't belong under an ACP-global lock.</li>
        <li>It serializes multiple BPT requests to the same link and
          lets that link's suspend path drain an in-flight transfer,
          without reaching for the global lock.</li>
        <li>It keeps acp_bra_lock's hold time minimal: the per-link
          setup/teardown (open_stream, dma_alloc, the PM get/put, the
          bpt_disabled check) runs&nbsp;<br>
          under bpt_lock but outside acp_bra_lock, so the other link
          contends for the global lock only during the actual
          shared-hardware window, not the whole sequence.</li>
      </ul>
      <p><span style="font-size: inherit;">Folding everything onto
          acp_bra_lock would mean the global lock has to cover each
          link's full transfer path including its runtime-PM callbacks,<br>
          &nbsp;i.e. one link's PM transitions would serialize against the
          other link's transfer — a scope mismatch and a longer global
          hold time.<br>
          &nbsp;So the two are intentionally different scopes: bpt_lock =
          per-link lifecycle/PM, acp_bra_lock = ACP-global shared
          hardware. Today the comment only documents acp_bra_lock; I'll
          expand it to cover both.</span></p>
    </span>
  </body>
</html>

--------------HcgNXXp0TaC7Kuj30BHYAbqB--
