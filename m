Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF31DCA600D
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 17:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2304810E93D;
	Thu,  8 Oct 2026 17:25:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IxGbtWFM";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013025.outbound.protection.outlook.com
 [40.93.196.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAFE610FAA1
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 17:25:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HALhl0nbKrfQL37vnBu5WTOjGKfHcX6i6adKvkawBzGw9fNx4PPULtq1M3qfWhOQlmpQNeX+xCopSzsDT3t312Ot+vxwA16TVb+XVgDLavJK4kkrN12CtA+4ZLs3S7Nf16W3v74570YPjUuLgRQFv0+2frsh/kOwyGzXvrN++XutDQQ3fsz7NlFi2ZJj9VtseccmgDJ4E3j88F1DJWrac8PI0K+4/YeMg+oaBiDmXkQa+eHRpxkRo6Yz5GB9CQ/NcL6Qmfxqw8sjFLSrJAoWpjjJCPDNsxkh4WYxDounZj2+d2qFvfPTBb4bfokC+laDJfPGyOiqT8rLoDIOxHle6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nMwtoFpbQDY7gyv9bOunWvkXTfkHM8RDy8rYfQmSKc=;
 b=HscrcJCqLST3CbAnIwIabZTKDboFybPBUg9JAgjyzaf30mGTX/WeFHRfdoVxUb1j+VXBlAnyOiuD6ikGUoIN04+WFP6bRaqvzO5TMEnlmPHzaFpkGfW2u/FgcrJu0R9C2ZcCn3D4oHzXwSk+ObOE6qspNGzqvfkeHe952GIqDTiJf0BMHcoUN9xqogNYciqH5NCwf90vYS5uHF5cwqkviV3b5Xh/qSjeiVHOSGuJmuQKW42Ub8cRV0HgHRDRLgpFWSbZb56YGbwjwPZu2AboX4+iJOdF8TcQonsvdO8gtWvdz27dx+lWjhwYqjBYJ9emxWYCWcnp4pVYy7CsRB33Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nMwtoFpbQDY7gyv9bOunWvkXTfkHM8RDy8rYfQmSKc=;
 b=IxGbtWFMVeblBL94tkmjQ+L8JDl4t7IFcYFg2TudcmTQ+inmWMIeuitIcsQotsYtuv52Z2lv3kBMvgKIwx+sSnhcwmwDPr013PVJBIO+/+Q9xdw37vpVTJaSuuh2ZkY/G27vmYYiN/9TAL8nXmoqPJWPe3HidpebYvkwunaCItw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB9062.namprd12.prod.outlook.com (2603:10b6:208:3aa::14)
 by DS0PR12MB7994.namprd12.prod.outlook.com (2603:10b6:8:149::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.35; Thu, 8 Oct
 2026 17:25:14 +0000
Received: from IA1PR12MB9062.namprd12.prod.outlook.com
 ([fe80::28c6:3cbd:6e97:5257]) by IA1PR12MB9062.namprd12.prod.outlook.com
 ([fe80::28c6:3cbd:6e97:5257%6]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 17:25:14 +0000
Message-ID: <dea37d3a-a66c-4620-b6c5-032b27e9c43c@amd.com>
Date: Thu, 8 Oct 2026 10:25:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 05/19] accel/amdxdna: Add NPU3 classic device support
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <yidong.zhang@amd.com>
 <20261008032348.2044667-1-yidong.zhang@amd.com>
 <20261008032348.2044667-6-yidong.zhang@amd.com>
 <sashiko-outbox-163576@kernel.org>
Content-Language: en-US
From: "Zhang, Yidong (David)" <yidong.zhang@amd.com>
In-Reply-To: <sashiko-outbox-163576@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0201.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::26) To IA1PR12MB9062.namprd12.prod.outlook.com
 (2603:10b6:208:3aa::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9062:EE_|DS0PR12MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b46e76-8277-4ef4-535c-08df25611d13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: xGliV/YUBUiuTxIGRuF6Rp4jVTPpYRxj2zI/McNwZDmTPEcdJBKNEsLkjGmx4VU6vgA7e+eyJZFaLmh1gBV6/asWh8KRebtshlrdp1YLFA0898i1ygySO7ZQvmtLTXB3HIn6FYCcg5sdwR5BJ4vcFxoOk+BRUWWv2aR5pdUzTQlJZsxgI2B33Rm/4jtBk51pCmuvcS/XI7rJ5m95v8QUgoBsAdH2l5GWtgoAXLjhAJPheQriKxenJqRYnDEL50qR5kIyrrsYZh8RHFvWAz76wtoeLtC1d7QjTgM3hjsFCB4V//IAIiIIyz44iHUhdeI+PTTiLoLt1X+YHTXmW1+L0f1t7nUxnm0knQVfUp1ItJxXv3uTaSykdSZRe4wb5kdcgClWf2CylAIJ/Sn8yhd1E0Ayv2P4d8id6XT+GG0aIJDcTMq6tkk/vAQtiOJxY3B9kwfM8dW2ww5B/uB6FMOD98N4kmrr4B4LyXZwVvLV0LRn/5SzOfJZZroIvmtRJmjn0GycfbmBHheb3R1jb6LnhJ3Zexlb4NyYWgPWN72Md/xSiYgCckXSTMGzJm7v2NpN+4d4YdZ2Qope4OvL1NP+JiOsjMBQcUrIWy7//eWvDoWhfh/vexufqjlEB56bF53ROpawU3PngZxt296zSZ2K5343kTY7JZvuy3wni/rD1pw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB9062.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0dhdGV1TWhqQ1p5QmQ0bUE5d1VLVHQxRVhMdXVUdDcxZ3ppU3ZXVFFLVW5w?=
 =?utf-8?B?T0lDbm5ZUCtaYmNQNVl1NWRHVGN5OExpdmY4d1dYSythdkluczNaQzQ1L0ZD?=
 =?utf-8?B?SlJ5OWUxNHJFVDFseDFUUXgwZ2M2Nm1KbGxFdWhYZkZ1ZEVMdkpDd0FGNFBJ?=
 =?utf-8?B?WmpCc3hBdURrVGR6ZTZyaWUwb1FaOVM0WlRsY01sbHdCTHF6SUVkWFZJQWFF?=
 =?utf-8?B?Q0FjS3ZpdGRiY0hsMjZrc0tBMFlZWmNMUHZsanZNK3JheUJ6bkVRZTJBNTVz?=
 =?utf-8?B?Q0s4SS9rSlljUVA4dFAxNkxBaGVvWlhTRm9jcXNMTThPZmxscS93aU96dVV6?=
 =?utf-8?B?RWU4RVczVTlMRi95OWxNK0trdlY3MTRpd2ZaenhaT2NZOVZUSmVuWHZZRnc0?=
 =?utf-8?B?NEp4cmtTNHp3ZlQ3cENsdTZ6UkNFWFlsWVBCT2c0MzdWcjRqelBvVU5BeWwr?=
 =?utf-8?B?MHk1djU3UjFJYjhkYWJ2WHBHRldBbkdsL0JqUWl1YU93SWhCdXEwWElObzJ2?=
 =?utf-8?B?OTU0S3JmNkNtcFQ4aHJiOEpBb1ZMR0lWU1JKYThLbC83eFMrNkovanFWZjgw?=
 =?utf-8?B?RU9SUWNETW9xak42cVZCMlRqVDVYVVhocGZWSERnVm1aOUQxbWJKMmdYd0RN?=
 =?utf-8?B?dERrU2xES3dBQWhZNTVrWmNRQkZLVEZPeEV1R0VmVU9wNUlGMHArVm5NQklI?=
 =?utf-8?B?OS83dG5UMWQwd3hQQ0RDUDFnWVovLzdES0Z4ZkVqVzBVblh6b2labEZZL2d2?=
 =?utf-8?B?d3FvZE51N2ZJK1Q0aXJ2MFcvTkdxM2gzU2dzckhxUXE0RTRnd3pHRDd6dGRo?=
 =?utf-8?B?YnA4bm5wdVZYMmhIVzRFT01NSFFJclFlWWY1V3dVMFlHM0tSUjJiVUltY2VN?=
 =?utf-8?B?Y0FweEN0T0ZBY1ArN2g2dDVYaWo3SDAvK3JwRDVTQUc5RkhFOW9zM0o2VlR1?=
 =?utf-8?B?MU5WL0MzVjh2QUNUZmFWSmx0S3prU0JaZ3hwZzFXeW9uZm5RZnh4Yk1qSXRE?=
 =?utf-8?B?dlZKVVJXZ01HWFpUVGdGRUNmWVQ2NzlhdDhVdk1tYzVzbXhPMi9ISHVNRzBZ?=
 =?utf-8?B?RGRmMzBzYXV3b1I0MVptK2poU0xHK2o3QXpjVEdBRXA3OHFrTnNtSmNwalBZ?=
 =?utf-8?B?L2NvOFBnckVybGltVVdMdDE1QVdLWkJEclI0THpUUEZIWmdVUU1hK290OEdY?=
 =?utf-8?B?NmlncHNrRkk1TWRoQWc0OGtnMkpISEEwblUrZFNiYllXTDJiaVJ3alBPMkNO?=
 =?utf-8?B?cGVxc2hCc1Q2L21hb2k4NCt0VTdmRjB1YisvUmNZbFpWTlIwRkg4UVRyZkxB?=
 =?utf-8?B?eml4YWdBeE96NWFSSXRtbkNrUk14WVNWMzQxNjFhMis1MkZENGNMNXJ4OFp1?=
 =?utf-8?B?RjIrOXVVN2w1RFFqN05RbUhGQmE1S2FXV0k3Y1IzRHZNSmVBQlJKcENwLysw?=
 =?utf-8?B?cktJS01CdHRZWi9EcDdxYXdZVkllU3hBbFlOWEF2ZkwycW9SNWMzY3hCUnh0?=
 =?utf-8?B?SUtvaDltZm80WWRaMHhpejc2R1ZqaW9SOWd1RS9zbEI0b3F0WU5lTCtzWHA1?=
 =?utf-8?B?TU5SVUg5T1RNZ1BTWnFJMCs4eUk5Q1BPTlppanFKOEtTQklnaWtURXhyc21i?=
 =?utf-8?B?TTJNUElJcWl4VGNSTzRLZkxTNkNaNW9hbVZsZ2loZU1GMllvVzFrYlh6eTNS?=
 =?utf-8?B?dXhqeHduVEdjVEErZVkvOVNSM2FWaVVpSE1CN2lVRWhlZ2hHYTlUMWNMNDJz?=
 =?utf-8?B?MDZ5N2Y4ZW02Y2xKOUU1UDk3WjNaUFBSWXU3M05HeTlzdm9yZ1o4ZjFNZEJO?=
 =?utf-8?B?emFod2lKZzR6dy9aTFdVaWN4RUZGTnp2Z0ZIa3F0V2ZTZ3g3cS9EU3ZNMm5p?=
 =?utf-8?B?TUlRVVZZV3diWFpHa2NXWEF3Z1JxQU1pWkt6Nlg2ZWpOemtCSUs1ZytmbEZ4?=
 =?utf-8?B?bnFWc0VDUVJCNTVFbUZlYTA4eDcwaTdKT2NHYnFvdjBhMHZvMDBzc2o2Y3Bl?=
 =?utf-8?B?cUxORllOdjk0RWZaS2JXdWtBaTRoK0JQM0p0RGMxMkF5QlBPU3I0YnY5NjlH?=
 =?utf-8?B?YlVlcFJGTVJnd0J4cFZwZ1ZYTXBNd0I4eGNldlVNNk4xL1ZGYzJxL1dBWlhl?=
 =?utf-8?B?aVJ1dkw5Y3NKOTBScDkralU2SFF0ekpjekIrczNjY25QbHNFUjNiMHlPa2pF?=
 =?utf-8?B?VXBKRFkyK3hpUGV2Yld0Si9VSFAxQTI3aDN5bCsyd01lWnpwMlRyQ2NUbGRI?=
 =?utf-8?B?bWUxMjdBQndwaVg3a1MxNEUrMWo1Z3RZcEtCM3FwbjBROG56aUpML3N1MURw?=
 =?utf-8?B?UVAxTll5eWk2blVJRjJUQWp6ajdqRW4zNzdrWE45azFudHFNSlZLdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b46e76-8277-4ef4-535c-08df25611d13
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9062.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 17:25:14.1261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 758MQ2hwNOXx6VbxFTRlH95qrW/3xbGJXO6zxynVdunKkXT8UmJF6avtvx0+ISbHt3GCRawdXcaT5LTwAzUDYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7994
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


On 10/7/2026 8:44 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] amdxdna: user-triggerable WARN_ON due to 0 dev_mem_size on NPU3
> --
>
> commit f86aaf866bc504bcba674227ac3b36c9902b057f
> Author: David Zhang <yidong.zhang@amd.com>
>
> accel/amdxdna: Add NPU3 classic device support
>
> This commit adds NPU3 classic device operations, register definitions, PCI
> device IDs, and firmware declarations. It also guards device heap memory
> initialization against a zero-sized device heap, since NPU3 does not
> configure a dedicated device memory heap.
>
>> diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/amdxdna/npu3_regs.c
>> index 93f749acb5d5d..c82433d629012 100644
>> --- a/drivers/accel/amdxdna/npu3_regs.c
>> +++ b/drivers/accel/amdxdna/npu3_regs.c
> [ ... ]
>
>> @@ -105,3 +105,17 @@ const struct amdxdna_dev_info dev_npu3_vf_info = {
>>   	.cert_feature_tbl	= npu3_cert_feature_table,
>>   	.ops			= &aie4_vf_ops,
>>   };
>> +
>> +const struct amdxdna_dev_info dev_npu3_classic_info = {
>> +	.mbox_bar		= NPU3_MBOX_BAR,
> [Severity: Medium]
> Since this struct leaves dev_mem_size uninitialized (defaults to 0),
> can this cause a user-triggerable WARN_ON?
>
> When an unprivileged user space client calls the DRM_IOCTL_AMDXDNA_CREATE_BO
> ioctl with args.type == AMDXDNA_BO_DEV_HEAP, the handler delegates to
> amdxdna_drm_create_dev_heap_bo() without verifying if the device actually
> supports a heap.
>
> In amdxdna_drm_create_dev_heap_bo():
>
>          WARN_ON(!is_power_of_2(xdna->dev_info->dev_mem_size));
>
> Since dev_mem_size is 0, is_power_of_2(0) evaluates to false, causing the
> WARN_ON to execute. This allows any local user with DRM node access to
> flood the kernel log or potentially trigger a crash if panic_on_warn is
> enabled.

Yes, will fix this with a single patch.

/David

>> +	.sram_bar		= NPU3_MBOX_BUFFER_BAR,
>> +	.psp_bar                = NPU3_PSP_BAR_INDEX,
>> +	.smu_bar		= NPU3_SMU_BAR_INDEX,
>> +	.doorbell_bar		= NPU3_DOORBELL_BAR,
>> +	.default_vbnv		= "RyzenAI-npu3",
>> +	.device_type		= AMDXDNA_DEV_TYPE_UMQ,
>> +	.dev_priv		= &npu3_dev_priv,
>> +	.fw_feature_tbl		= npu3_fw_feature_table,
>> +	.cert_feature_tbl	= npu3_cert_feature_table,
>> +	.ops			= &aie4_classic_ops,
>> +};
