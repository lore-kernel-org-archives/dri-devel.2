Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6167FCA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 21:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE18C10EEA3;
	Mon,  5 Oct 2026 21:52:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CJqUnYdh";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49EFD10E7B7
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 21:52:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRKxtQ5VMHe/ZoHJqTRJuqR80idV0r0CrLZax96Yv+QSdHg4U1uFyDQB70OXERc3EA+ntGS33VRSAA9tI7+V3vFugXE7ylPOwEX4JmjSghJOju/nqzkgytV21Lz0u9TOcxofmLbQjKS5/QUpDEMU7njdZTpv9YtW3WSweNa/SojDNAuBHaIY/L4+5JukZkfx/BYC8lOaiqJnv7PG/6L9b/6Kmo0bBVK+/f/rX89JHzZrVUNwvhvkw+VpLAa+Ok/0KDPDGEXNBrzDD3orqwELexmk10+wU3SImClJ+AL7+KwYFH1oUvGJoaxH1WKXEFy2fthehP4vqM/uT+rBOdGEWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOy0iofitxxKgrzVGKBK/7s5Yj/lIhS1yMCTZ6MLvtw=;
 b=mAKIb7AuV180xT7Gdnxem1vyCb1Hsejl828iGChPuMfEhkyT9KDfCb7ovlx5klb+FFUxMKIoasgGyyu9mCoIViB5eyHiK6TANRozHYtFKe6YjHBGIWiYu60QjsWU5V4NUwLP4E+NedcxgSY4kDm37muA+vasLFl7y+DpCj5Mnw32eLIjLQ9bhNnyBLb2u+O2tKtKMT0SJhxwLYqHB/XpRMScNwtf/2CfH08I3bGXBHiGvNcfdNkxJILhsK45VUH17sCaQozTufCwrNrcZ+eR+UC19VtknyitAyydY7B3FsXcueQ/Vf6uuvfmS+PXi0/nMzkveTa7tw7PokoJh44iqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOy0iofitxxKgrzVGKBK/7s5Yj/lIhS1yMCTZ6MLvtw=;
 b=CJqUnYdhfy8FUvB/51zAQ3zHVDAiibM3psJ/Wi4fuG/8K8uNQ7zuiURUJuwHkbgTf9U02/rDvK8pS12L/vomwLym8ef2edlbjCnIzZWw+xq3ImazZewHfaCBJMCmc+qcxii9GRZ1P4Hgyfdu39+czCUSNZG7JW1iWKO5R0yYWYw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB9062.namprd12.prod.outlook.com (2603:10b6:208:3aa::14)
 by PH8PR12MB6961.namprd12.prod.outlook.com (2603:10b6:510:1bc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Mon, 5 Oct
 2026 21:52:10 +0000
Received: from IA1PR12MB9062.namprd12.prod.outlook.com
 ([fe80::28c6:3cbd:6e97:5257]) by IA1PR12MB9062.namprd12.prod.outlook.com
 ([fe80::28c6:3cbd:6e97:5257%6]) with mapi id 15.21.0451.022; Mon, 5 Oct 2026
 21:52:10 +0000
Message-ID: <cc53cfff-92b4-4204-9055-5c1cfb0f4155@amd.com>
Date: Mon, 5 Oct 2026 14:52:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 14/20] accel/amdxdna: Implement AIE4 command packet
 building and submission
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <yidong.zhang@amd.com>
 <20260930033233.1727265-1-yidong.zhang@amd.com>
 <20260930033233.1727265-15-yidong.zhang@amd.com>
 <20260930040416.D66771F000FF@smtp.kernel.org>
Content-Language: en-US
From: "Zhang, Yidong (David)" <yidong.zhang@amd.com>
In-Reply-To: <20260930040416.D66771F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::33) To IA1PR12MB9062.namprd12.prod.outlook.com
 (2603:10b6:208:3aa::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9062:EE_|PH8PR12MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: 546b57a6-086b-40e9-a56e-08df232ae835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|4143699003|6133799003|11063799006|56012099006|10067099003|5023799004|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: rNSKXgjF+w8eoSW+9Amz8fyju9t0IezL06yX88/ELGGrrfC7Lxstcp+xA0M0OFqpb8uf81QjkQ5QuOtOutLc51AZTxcgoeK0rc0Rl4f2R1vS6hCRlvzZJKstI6ROYRtfnUjBORGoO4Rd2V7ZSpmIk61XFPb+oSq9GCxSgmGxDESY1pbugYl5/mavQPFLhCvxsklUlyTLJxrp/8X/8XtUTnwVSRxiAFlFJu0iXqQbn2wbHIczrdeMTUHoG93BP6XEqe+uCYikJa5YOyju65aoMEZ8acxP666i/kp/V1J1aIUhFtlM+I6DrgwAbbQlPRW+ju8gIsMU4IVTPePoEUUZL9ur8iIETGYpE9IwGUm0c/fMSpM68NIeeGeLjT3bKEhoar7DWWJJrmN+AsWxsp1TML3WoPT/xlz5GoAGO28V+BvsAymtuvsNQyQ5C80+XL6H+JDm1xMU0GsutYl1Ae6+t+h3RltqGIh8iiFOFWodx9Fk2FGyTNO7OD5ZfgeVR/aZKXmF8KpK072Gsr1LnYa5WtT7HFS7Bt0dJ94J7b5zG9sjx/BeCYO/1dP42CmYmJWx3TUmnD0xyhHGhT+MPOmWFy9TUeYCqBziwDKIMdGOokQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB9062.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(4143699003)(6133799003)(11063799006)(56012099006)(10067099003)(5023799004)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXNFWlQyTngwcGp5S0Rhbm9SWS9RUFhwUEN1cXBuRmpLaE90dE0rSUZNd3V6?=
 =?utf-8?B?cEhhbWJjOVRGQ1hPNUxVazd1Qnp0Mm0zWWI1cmFXTTgyV0pJYlZ5Q1VHU3Nj?=
 =?utf-8?B?LzFEYW1jVHk0ZUdvZlhHUS9wZFlUa0RUVHhzd3RGRk1YTTRyc0lDRkhoTTY4?=
 =?utf-8?B?ZVJuWmN5b3RqUEFRcFFpQkYra1NsSjkrdHVheU1zaEpoR01Qb2RiM21EcHRy?=
 =?utf-8?B?dm8zbGdpZ3J4d2dscVhjZEtTZTNWbkxGdFlQbE9KdVpoc2V5L1FtK2YrT091?=
 =?utf-8?B?MUx1UVBrVDhuMUE2VHF4VGpxUDdSeW1sSmw2K1pGSVEyMDJ2SkdLMHBJRGhR?=
 =?utf-8?B?SENaRWM3MGZGNzBpU3FnMDFhRkkzUGZBZW1IQmtVM2FPa09lcHJSd2wxT3dJ?=
 =?utf-8?B?dmF2dlowWGtTZEhtdHUvQzJhL2ZXcWtXVktSY0Zla2w1Um4wcGdwb3lKenpQ?=
 =?utf-8?B?c3RPRkxmSGxzM0xZRlMwUDBPYVpMYlVmVERNSHFMVis2MUVGYXdpWVhUQ3JX?=
 =?utf-8?B?RUhFemZFNUM2QnAyU2lnOGsvMXl4NmZGL2Z2b1A5Zy9qWU01QnQ5NUJMNmF6?=
 =?utf-8?B?N01PQU5UdSs1bUZReUxIZG85am9WdzRtTnZtSGd5NTJWV1krdVhQeTY4TEM2?=
 =?utf-8?B?Z2ZFVWE1TkppbEtFdGo4ZXBHOEUyK0QyWEgxTytEOTVmbmd4QW5weCtZVXVj?=
 =?utf-8?B?amFNdFpvdkFjTmkrNFhodW54U0xDVk9JcG9mdHJlWEZFbU9GS0YvSzhKWUhx?=
 =?utf-8?B?UkdtVWg0TW52TG40dUE3bFpMSWo1bzhjV0h5WDB2dWV4dzAybzFXUEFrK0ha?=
 =?utf-8?B?TUZWRkVOeXNnczVDTE41Vzk5UmtCMWFRQlQxZ3J1UjFORDlaSDJncG56aytV?=
 =?utf-8?B?WUsxR2xXRkhVK2Q5alJFY2g3d3BCZ2NNdmVYYUNRTXNiRndNbFBUOUI0c1J2?=
 =?utf-8?B?QjV0MXpMaFQ0c0dIeDNUTTFBMXRqTWVnSys4SjA3c1JNeTJuM3FiWjZiY3Ji?=
 =?utf-8?B?eVI1aHlUYUtwaEdyRys5OUlGMmZQcWlLUEdtMmZ0dmdKRTRpczdBSm9SVGFR?=
 =?utf-8?B?cWN6VHpLaXFYSkVNdmxGN0VhQ0l2ckZvSXRXcWhDYkd2SVdZT3psYXZKV1VT?=
 =?utf-8?B?SzV0N2l1SDBkVnZ5WHVvR0w2NjRSc1E2azFzbzk4KzlYN3RsbElEWW5ob0Nt?=
 =?utf-8?B?N0M0eG50endFczRuSWQ4SGxkMXJnRVcyK2kwWDdaRXgwSHllOUltUFVBZFNp?=
 =?utf-8?B?MkFibXNNelZ5SVhzVjBINGRlT0ZGdlZvRmxzOVlIRTQ4NkMyamZkcElmZGJZ?=
 =?utf-8?B?b09GcXZwM3lhbkJtZWNhb1JYWDBkYWUyanJwS3VoZVl6cGFwWlpySXcrOFFy?=
 =?utf-8?B?eGFRSW1PYWM5dFlqSzFIOHlDNjN3S2I4NzEzd0xweER0NDNGUHNIeTRhMmhC?=
 =?utf-8?B?SjBFV2l0WkNuZkphbjZGUGFUYU9ORDJIaWlEdkJUVWtiWUpaVkk0MG9jUjRs?=
 =?utf-8?B?aHp2N0hVU2RLTDhuZllnbGtWd09xNHdaRUZxTmlxUlJsSmc1Zjd2bUJSVVUw?=
 =?utf-8?B?MVZpQWc2RjN2V1p5dzFVdytHb3RCRGlGN002bVpkRkE0NU5lS2IrVFJ2Ukx0?=
 =?utf-8?B?a0t2NW5aSW9QSkZoOGsrelduVFRreUFWQmQvdHdQVFZVSFVLZlR4NzFoN1Rn?=
 =?utf-8?B?alV4S2M3UnFNdDYwR05RVEtOa1NZcDQ0V3A0Qnlwak15a0s4bjVlcXA2UVRT?=
 =?utf-8?B?NnA2T0Z2cGVUOE9lNGtNOWV3aWlYNHFrTjJoSkVPQkdPNy9qaDUyMVplVjJZ?=
 =?utf-8?B?OTFNQi80RkluL1VqSE1vYnA0YWRMMmRXSGNTdGI3UFlsNWkzWWxEMmRmYVVH?=
 =?utf-8?B?MDhpb0hRV3JuMTkrUlJ5cktHdHYwOGZIM0o3VlgzUjFUOTBuRHJyU0ZtU3Zs?=
 =?utf-8?B?Wk1xb1IwbnZmNVlVazUzM2Z3TUVMU3ZjQnNOaFBYd2RJVmQvMk1lYUpReWFm?=
 =?utf-8?B?dU8wd253Z0NIY2dEa1BMMWJ0aUJQSGx6OHNQMktlZGF0MlYwOWUwOElWcVdm?=
 =?utf-8?B?Q3QwdjgxTU5mcmhPRk5ickdpV04yOGFzbVZBZ3lnb3BoVW4zck16MkFJbkxP?=
 =?utf-8?B?MFJUL3BvZ0ZXMCtxazA1aGVpeDk2c3FyTEtoTzlDNXd3dWpOVUFCTTQ1dmV1?=
 =?utf-8?B?S2NLUVI4Y3lXTnNJSjFIZFI4R28xcHNyaStUTWp3SVVRMjNOdUJrVmxRK2VV?=
 =?utf-8?B?SFFNdGQ1c2wvVjY3NU90Q0hMUWEraHBCUytDZXphOS9sL1RqZmFRTlo1aFJs?=
 =?utf-8?B?UHpLWEM3a09xUmpRc0hDUVViZyt3NE5nM3UyZmF6dGoxTGZIV1pFQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546b57a6-086b-40e9-a56e-08df232ae835
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9062.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 21:52:10.3222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HF7q3RbRtRuzRu5NDw8H6vTDMPsR/PHMFgzoni5K6efPtMO4A0dT78N4yK70vmdZW7UjPkL5d6oTdCYdjFP8DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6961
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


On 9/29/2026 9:04 PM, sashiko-bot@kernel.org wrote:
> [You don't often get email from sashiko-bot@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:
> - [Critical] accel/amdxdna: TOCTOU in submit_job_cmds allows arbitrary DMA to freed memory (UAF)
> - [High] accel/amdxdna: Unhandled mid-chain submission failure permanently hangs dma_fence
> - [High] accel/amdxdna: dtrace_buffer address truncated to 48 bits, corrupting memory
> - [High] accel/amdxdna: dma_fence uses unreferenced struct device pointer causing UAF
> - [High] accel/amdxdna: Submitter holding SRCU lock waits forever for reconnect, deadlocking teardown
> - [High] accel/amdxdna: Missing READ_ONCE allows double-fetch of user-shared control fields
> --
>
> commit 3eb430c5785965c7805a7d4c133aa9e24f11869b
> Author: David Zhang <yidong.zhang@amd.com>
>
> accel/amdxdna: Implement AIE4 command packet building and submission
>
> Implement kernel-mode command submission and hardware queue packet
> assembly for AIE4.
>
>> diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
>> --- a/drivers/accel/amdxdna/aie4_ctx.c
>> +++ b/drivers/accel/amdxdna/aie4_ctx.c
> [ ... ]
>
>> @@ -622,7 +622,10 @@ static int wait_till_connected_hsa_not_full(struct amdxdna_hwctx *hwctx,
>>                        if (!ret)
>>                                hsa_not_full = true;
>>                }
>>                ret = wait_event_freezable(priv->job_list_wq,
>>                                           aie4_hwctx_connected(hwctx) ||
>>                                           (!wait_through_reset &&
>>                                            aie4_hwctx_has_reset(hwctx)));
> [Severity: High]
> Can this block indefinitely and cause an SRCU deadlock?
>
> When wait_through_reset is true for the first command, the wait condition
> completely ignores the reset or error state. Since the submitter thread holds
> the hwctx_srcu read lock, if a device unplug occurs and the teardown thread
> calls synchronize_srcu(), the teardown will wait forever for this lock to be
> released, while this code waits for a reconnect that will never happen.
>
>>                mutex_lock(&priv->io_lock);
> [ ... ]
>
>> @@ -696,7 +699,8 @@ static int fill_indirect_pkt(struct amdxdna_hwctx_priv *priv, u64 slot_idx,
>>        for (i = 0; i < entries; i++, dpu++, hipe++) {
>>                struct host_indirect_packet_data *hipd;
>>                u64 indirect_pkt_dev_addr;
>>                u32 uci = dpu->uc_index;
> [Severity: High]
> Can the compiler double-fetch dpu->uc_index from shared memory here?
>
> Because READ_ONCE() is missing, a concurrent userspace thread could modify
> the value immediately after the bounds check against
> HSA_MAX_LEVEL1_INDIRECT_ENTRIES, allowing an out-of-bounds array index into
> priv->umq_indirect_pkts[idx] later in this function.
>
>>                u32 idx;
>>
>>                /*
> [ ... ]
>
>> @@ -715,7 +718,8 @@ static int fill_indirect_pkt(struct amdxdna_hwctx_priv *priv, u64 slot_idx,
>>                        upper_32_bits(dpu->instruction_buffer);
>>                hipd->payload.dtrace_buf_host_addr_low =
>>                        lower_32_bits(dpu->dtrace_buffer);
>>                hipd->payload.dtrace_buf_host_addr_high =
>>                        lower_16_bits(upper_32_bits(dpu->dtrace_buffer));
> [Severity: High]
> Does this truncate the 64-bit user address to 48 bits?
>
> By using lower_16_bits(upper_32_bits()), bits 48-63 of the virtual address
> are silently dropped. On SVA/IOMMU platforms with 5-level paging, user
> virtual addresses can reach 57 bits, which might cause the hardware to write
> trace data to unintended memory locations.
>
>>        }
>>        pkt->pkt_header.common_header.distribute = 1;
> [ ... ]
>
>> @@ -730,7 +732,8 @@ static void fill_direct_pkt(struct amdxdna_hwctx_priv *priv, u64 slot_idx,
>>        ebuf->dpu_control_code_host_addr_high = upper_32_bits(dpu->instruction_buffer);
>>        ebuf->dtrace_buf_host_addr_low = lower_32_bits(dpu->dtrace_buffer);
>>        ebuf->dtrace_buf_host_addr_high = lower_16_bits(upper_32_bits(dpu->dtrace_buffer));
> [Severity: High]
> Similar to fill_indirect_pkt(), can this truncate the user address to 48
> bits, potentially corrupting memory on systems with 5-level paging?
>
>>        pkt->pkt_header.common_header.distribute = 0;
> [ ... ]
>
>> @@ -772,7 +774,8 @@ static int submit_one_cmd(struct amdxdna_hwctx *hwctx,
>>         * against the actual payload size before dereferencing chained+1 DPU
>>         * entries, so a bogus count cannot drive an out-of-bounds read.
>>         */
>>        chained = dpu->chained;
> [Severity: High]
> Could the lack of READ_ONCE() here allow a double-fetch of dpu->chained?
>
> If userspace modifies this value after the bounds check, it could bypass the
> validation.
>
>>        if (chained >= HSA_MAX_LEVEL1_INDIRECT_ENTRIES) {
>>                XDNA_ERR(xdna, "Invalid DPU data");
> [ ... ]
>
>> @@ -1012,7 +1014,8 @@ static int submit_job_cmds(struct amdxdna_hwctx *hwctx,
>>                XDNA_ERR(xdna, "Invalid cmd payload for chained cmd");
>>                return -EINVAL;
>>        }
>>        ccnt = payload->command_count;
> [Severity: High]
> Since payload points to a GEM object mapped into user memory, can the compiler
> optimize this and re-fetch payload->command_count after the bounds validation?
>
> Without READ_ONCE(), userspace could potentially modify the count concurrently
> to bypass the checks and trigger out-of-bounds reads.
>
>>        /*
>>         * A chain (runlist) must fit within the queue. CERT advances the host-visible
> [ ... ]
>
>> @@ -1032,15 +1034,22 @@ static int submit_job_cmds(struct amdxdna_hwctx *hwctx,
>>        for (i = 0; i < ccnt; i++) {
>>                u32 boh = (u32)(payload->data[i]);
>>                struct amdxdna_gem_obj *abo;
>>
>>                abo = amdxdna_gem_get_obj(hwctx->client, boh, AMDXDNA_BO_SHARE);
>>                if (!abo) {
>>                        XDNA_ERR(xdna, "Failed to find cmd BO %u", boh);
>>                        ret = -ENOENT;
>>                        break;
>>                }
>>
>>                /*
>>                 * submit_one_cmd() blocks in wait_till_connected_hsa_not_full() until the
>>                 * ctx is connected and a slot is free, so a concurrent suspend/disconnect
>>                 * is waited out inline rather than returned here. The first sub-command
>>                 * (i == 0, nothing published yet) waits through a TDR reset and runs on
>>                 * the recreated ctx; a later sub-command returns -ECONNRESET if a reset
>>                 * landed while waiting for a slot, so the published prefix is not split
>>                 * across the reset. It also returns -ERESTARTSYS on a signal, or a
>>                 * validation error. Break on any; a published prefix is then reaped by
>>                 * the job worker's reset drain (see below).
>>                 */
>>                ret = submit_one_cmd(hwctx, abo, i + 1 == ccnt, i == 0, &job->seq);
>>                amdxdna_gem_put_obj(abo);
> [Severity: Critical]
> Does this allow arbitrary DMA to freed memory?
>
> The driver reads the BO handle (boh) directly from the user-shared GEM object.
> Userspace can modify this handle concurrently after the DRM scheduler
> validates job->bos.
>
> Because this substituted BO is not part of job->bos, it lacks a tracking
> fence. By immediately dropping the kernel reference via amdxdna_gem_put_obj(),
> userspace can close the handle and free the memory while the hardware
> asynchronously executes DMA operations on the freed physical memory.
>
>>                if (ret)
>>                        break;
> [ ... ]
>
>> @@ -1054,6 +1056,7 @@ static int submit_job_cmds(struct amdxdna_hwctx *hwctx,
>>         * published prefix and reports the partial chain as failed (ABORT). Only when
>>         * nothing was published (i == 0) is the error returned to the caller.
>>         */
>>        if (i > 0)
>>                return 0;
> [Severity: High]
> If submit_one_cmd() fails for a sub-command mid-chain (e.g., due to an
> invalid payload) after the first command is published, this masks the failure
> and returns success.
>
> Since the final command is never published, CHAIN_FLG_LAST_CMD is never sent
> to the hardware. Will this cause the hardware to wait indefinitely, preventing
> job_done() from ever signaling the dma_fence?
>
>>        return ret;
>>   }
> [ ... ]
>
>> @@ -1182,7 +1184,8 @@ int aie4_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
>>
>>        job->out_fence = dma_fence_get(job->fence);
>>        for (i = 0; i < job->bo_cnt; i++)
>>                dma_resv_add_fence(job->bos[i]->resv, job->out_fence, DMA_RESV_USAGE_WRITE);
> [Severity: High]
> Following up on the mid-chain failure issue in submit_job_cmds(), since the
> fence is attached to shared BOs here, if it never signals due to an abandoned
> hardware queue, won't any future access to those BOs by other processes hang
> forever, creating a denial of service?
>
>>        up_read(&xdna->notifier_lock);
>> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
>> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> [ ... ]
>
>> @@ -47,7 +49,8 @@ static const char *amdxdna_fence_get_timeline_name(struct dma_fence *fence)
>>         * another process). The device outlives any individual context, so
>>         * dev_name() is safe to call at any point during the fence's lifetime.
>>         */
>>        return dev_name(xdna_fence->dev);
> [Severity: High]
> Can this trigger a use-after-free if the sync_file outlives the DRM device?
>
> Userspace querying the timeline after the device has been torn down or
> hot-unplugged would access the freed struct device pointer here.
>
>>   }
>>
> [ ... ]
>
>> @@ -62,7 +65,8 @@ static struct dma_fence *amdxdna_fence_create(struct amdxdna_hwctx *hwctx)
>>        if (!fence)
>>                return NULL;
>>
>>        fence->dev = hwctx->client->xdna->ddev.dev;
> [Severity: High]
> Does this store the struct device pointer without taking a reference via
> get_device()?
>
> This allows the use-after-free mentioned above when the fence outlives the
> device.


The srcu locking issue will be addressed in next version of the patch, 
and those UAF (use-after-free)

cases will be addressed too.

/David

>
>>        spin_lock_init(&fence->lock);
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260930033233.1727265-1-yidong.zhang@amd.com?part=14
