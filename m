Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3051F9D0E9
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 16:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47BCD10E62C;
	Tue, 14 Apr 2026 16:58:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q8wyidLL";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012011.outbound.protection.outlook.com
 [40.93.195.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D61810E62C
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 16:58:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaG7ZuKEcjvwPmob6k3N66HtjmFcuK5ehj2JKS1O1r9VtQNoPOnNlVOCgld4s3xOfUwUsGe5ltsaxt7WL36L+iT8cD/V0WGFLPV9XfwIffGItuKTbuO6vldr41SCxeKbTjay4ELWWB6vXYvbTm24FIAGJ5PxoRX+jLfzJhw7hZWXoMLAjHx8sTq5n8tfjE8gPZlPuWKZ5ArctoUeXFTqaUIPb4SVGTcDS4YAXH+huqwm2N+3M2if8e8NqTmUVLUEIJvtAmEaC3z36KnBw/z5ddv15YzT04xHlDJfvMyKwh4ciYX1RsiLmOEyEM0YrzscjwVlP/ol9I3fcVjJWnZqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncOA76piXpJ01AReZGJPiQutjn1uUFxS8cWFDsLt+RQ=;
 b=q4SC4lykUVN49UkiRo06jJ/KwCTaJmnhV+0tnxgu/U8xxwLdfwQ9HfJIQSgRqCg8Zmgr7pCgEtOBrfTav12HI+exVKbOy9kFt1uL02iB3CL7FqyYHoX/HOoYP2LvMmxUfjjVA3Q0R7Nf63pfvVrXAPC6U3SksT8sd6dXUGn8WDEh9tpuVwd3G13j3urDE4mBUZHwo65antp0fpK4J+h4iDeal0xt1aZCTvYxljV75FaQkgfss1o1zBzpNP5T8QvLKiAal8Eq+i06R0Qa/vLnEUNro6ZHn51a1jAzmbNeKBlc1TqZrXC8Pgyk4ry1b8+uIZTbCA5OmymIlBdddn9TSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncOA76piXpJ01AReZGJPiQutjn1uUFxS8cWFDsLt+RQ=;
 b=q8wyidLLGPLAzX8HCACC/eax8+qdzbLNL5OA5edm/ady/CrAtQzWvzGsZzRfsbePwB+HZU/4eJKRZ2UHzr/IVwq9XlLxZgHFWA6WQ/Ctbq0SoGCzxf8PtyAMXfqh4iQpVL+BrZTV3Ux1vFK+49y07kg5Zw3XvY3ACzV05bc01XA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by BN3PR12MB9569.namprd12.prod.outlook.com (2603:10b6:408:2ca::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 14 Apr
 2026 16:58:25 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.041; Tue, 14 Apr 2026
 16:58:24 +0000
Message-ID: <f233b761-ca66-4790-bdba-8407e696006b@amd.com>
Date: Tue, 14 Apr 2026 11:58:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Add hardware scheduler time quantum
 support
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: Max Zhen <max.zhen@amd.com>, linux-kernel@vger.kernel.org,
 sonal.santan@amd.com
References: <20260414165602.788811-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260414165602.788811-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::16) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|BN3PR12MB9569:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d6dba3-d0ec-4269-7f91-08de9a470a5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: OG7wzX4YlK9hXfzXEjO3rvCfXmtBlRWnpn4tSib7k3KmMOh7L6eZlyyTeTtZ3hCie40Namg7Xm1dZZsXrzRDHrCYval2hUTSjl4QvxS9goZhpTYQxjPkGoiJl6YBRJfnjZiVStKvyNpqYfuodRnSJxnBbgdLH03gX0DZmb2KNaOGsJCb3jAh6bSjvGfhlsj/fBFHf/4Vna23rNk36WMsZEUS4OSmAMya7vCzTeAh+6UeCbyRu0AkU5swMm8auwYoIOVLJvmiSxvHBUpmy5RVS1FPOaYlIomHlFRiwnyftFFVorhSTGiNHEFrUqisYYmXOY4LJGOvV4l5QdKJ72NyW09Z06TWRdzwiU4x+q4B013MCQe/CpKVVEcdeHyq2IbIP+pyREVFuKZvNQZKWeVCseCGvL0zkoy/tXDCvPPy7EzvOv73uGNO/4Ixuoytc2IDvIEsI2/yxBncWv5iBg5Ches/W8xCa5bfZiGg5wpomSo7a3U93Fyio3YiJ31ibNIvM3agXDdh85zW8qazOnLyd0DWcpEdtv2jQIsoIEY3bZZOHB1F7oJ5SDRSOYKJfvI4DO3ahKX0FgA4u5MrQeOCGQckPiFLdrPoGaD8wmttkVF5P4FtE/5YGrpI4XhyIrpZ959BqLTPQCTmuJEHBzZ+ufoQLvoDL6iNFspCZHHK2OBjjfuwseSxkG7To2fHWUmgS91fggXzspblXw/5+b42yPCIPnz//tKi18iVAJXwtFE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVpJRml6Zm9RVWp0bDQ1T1I5UUs2ZmdjOU5Pa09JWGFaOHBGVkhvWTE1VzBF?=
 =?utf-8?B?Y1JLaFJQOGdRTHllSHh4NnMzSDZ0cmNCTlhIQWtTQnRHVk5peE5reDdKVVFB?=
 =?utf-8?B?bE1kMTJGOGdXMFNqbUUwakRKdzlBMHRtWFNkaXdYOE5scHdCVnFBTWY1UUkv?=
 =?utf-8?B?T1JZUUtHN1BndGRJQ0hKaThXWHZzSWtIdzRhN2RENmJjQnV0WkZXaExQdHQ0?=
 =?utf-8?B?S3hITGdqUjFKeEFZNFF1ZVYyM3Q5c1ppUnRBM2RFZVBTamhyWVMvcXJqRlRx?=
 =?utf-8?B?RDBEV2s5aEcyWnE2S0dyenh3OEoxeG9Ka1libnJCZ3VlSDdlMWJVcFRzTXVr?=
 =?utf-8?B?NUFDeEpuamYyWVMxamhBbWpmK0NEOUNLeDVEeTlCYStxVUs2TzVVdjBicENS?=
 =?utf-8?B?cVZDcHBtaElRYkFUVElpcGk4dmlQWnMzSFova29YVkJKZ09wVk9CZ1ZqQ3hR?=
 =?utf-8?B?aDdWNlJhYTlVdDl1Tk9LS01YN2k5TGRoNWIvR0RRaUhvN0F3dVhGL25obEpa?=
 =?utf-8?B?MVJlblpkOXE1bHdlK2l1NWhsenh3UUR6czh6Mmk0TVB1K2FzODlZR0NCeVR3?=
 =?utf-8?B?VHZQcDhQS2JkUDliWXlkdmtqdEI3R2tQbGxkdmliR01JenkwWEJkdzcwTnFz?=
 =?utf-8?B?TnRCZGFUS0JTbWpYNW4vMFJVOGdpNHBEbmQwMnlYdHAvT0hBQzBpTUdDMjA0?=
 =?utf-8?B?clYrc1JSeWUyeGtzSTZuTVR0MGhubFpIRS9mU3RwdGlzMnBta042OEkyYWFu?=
 =?utf-8?B?MjlDUmQwMDVLUmxMdUg0ano5WlAxYW8wdlV3ekltYVlXQ24vZ1A3NFUwMk93?=
 =?utf-8?B?eVgrWEhVdi9JQ0NkV0lwSysvUE9IRDNVK3hmVlNCdHRyRXE3SkxhNjcyYzgz?=
 =?utf-8?B?UURoV3VnOTBSaXE4Y1dzSWxRR215Um9tWnhPVVhhdDhmbmFDcnMySzFXUjE3?=
 =?utf-8?B?R1R5Y09idzZQL0RkNERHNGs0RlRxVUlDak9YT3kvYmJjNmlKdmxNMnA1S24z?=
 =?utf-8?B?b1V0TVArUFhmclR5YzVHYWVTczZVdm1ONEI1eEdBemU0dFp4TVJqOWhKTjhD?=
 =?utf-8?B?TUUrRHVmVUhSaFc2NjRNbCtObXVIcEhQZjR5RGNUUHI2RHVqZFd2Q09GdFR5?=
 =?utf-8?B?VzEyTU9ZSDZwNDY3VE1MSUFObm80UlVIbGxCS2I4ZVJDTWU3RGRqODg0NUpx?=
 =?utf-8?B?RmlVQVZzSm5JaWxjaXhxSHFFQSt0N3VkbnJBR012a0lhRk5ZcWUybmoxS0M2?=
 =?utf-8?B?UVpNRVYrbzhRbWhNQXdhSWNjRHNCR1BGZGdlemM4UFVQYnVxSncyS2NnMFdk?=
 =?utf-8?B?K3VUc1RFNkdmY2U2MGFDSHZFM1MrWEwwOGZHUzlzQzJJNVBkN0dOZk5CSWpW?=
 =?utf-8?B?R0JJbkFJdGRmRU05UjQ4a3JWcEhZZ0NMRGhGSVpOalpkUFBZYXNrd28waVhN?=
 =?utf-8?B?dGZLZXRyWkhNUjA4K3ZkQ0dNMVlHclptbnhjeU9HZ2lpbmFDeWQ0L01XakVP?=
 =?utf-8?B?VFozR3FOS3lOSEs1dHVtQWNrUmRrNEFTVEdHMyt6Z2ZJc0sxT1ZPdkJqbTFV?=
 =?utf-8?B?S1dXclhVSzR3Tlo1STE2cmJrLzMrV2xUaGpCR3FNN2ZxTDE1QmR4TDQ1ckxJ?=
 =?utf-8?B?U3kwb0YxczZZZVdjMExpeGp2WC8rSHhPN3JpS09oK0R2eHpsVGFLNDdOMENn?=
 =?utf-8?B?NGJmNjZ3Tzg5a2Zuck9YWmJBTGdObmhndXljbzJGNVFlaWh6c09ETmRDT1FM?=
 =?utf-8?B?MVVBNFRDeERVMWl6QnYycUFWc0NTNXM0RkowcEVBMnBxeWhMbm5WVm11REpD?=
 =?utf-8?B?N0daYkF5dEVLdzBFNWZ2UEsrWkxVTkIvai9vbTZUQWZzSWxycjdvM01xcTh6?=
 =?utf-8?B?WHF6YjJiSUpCZGUwU2ZyM0dUNFl0VHF5YUIrT0ZtQ3V1ZUM1NVhWSklDS0xS?=
 =?utf-8?B?L3p6UFhoWFRrK3BNNW5hUHFIZEppcGp2WlRYQWN4eUZyZXQwOE5oVWFQdmhQ?=
 =?utf-8?B?dUx1TlcwVmo4Nk9sdWxRZXNHdjZFMGNlUlpWeWZ2cERhd0VNbXIyOGJzNzk5?=
 =?utf-8?B?SW5zSVV6VDhYTDVicjZRRnFSUWZKQ1E1bjlRWjJLRjJjVFEyV1NWZUZHeDQx?=
 =?utf-8?B?RHlCYW5UZDBQUmsvYUpQbEhuQ0JyeUdFR01sYi9Pc1BqaG5UdkIvMnkzU3pK?=
 =?utf-8?B?RGtaOHI3UHg0d1hNU2c5NTd1dVlZWlROMExIYVZxa2hmcUh6WEpHZ3BEWkhB?=
 =?utf-8?B?N0prZG1WQzlPM2VzL2VDYTVFMXcwbWlQcXM1TjVBYldjQlB3ZzBhbC9PVU92?=
 =?utf-8?Q?8OkIKmHiYvJ89hwCTH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d6dba3-d0ec-4269-7f91-08de9a470a5a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 16:58:24.1625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0oHIflqtLvwvWAZpM1jM/BS0KxAZ4mqqGH8vhwfU6kkCtrrykOPjkH76YpgNjn8+TDDDRJCSIpLcZt/j5f+PfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9569
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



On 4/14/26 11:56, Lizhi Hou wrote:
> From: Max Zhen <max.zhen@amd.com>
> 
> Add support for configuring the hardware scheduler time quantum to
> improve fairness across concurrent contexts.
> 
> The scheduler enforces a fixed time slice per context, preventing
> long-running workloads from monopolizing the device and allowing
> other contexts to make forward progress.
> 
> The default time quantum is 30ms and can be configured via the
> time_quantum_ms module parameter.

Can you talk more about how you want to use it?  Adding new module 
parameters is generally frowned upon in lieu of doing something with 
debugfs at runtime.

IE if you can export it as a debugfs file that when you write to it 
updates the quantum or updates it and restarts the driver this might be 
more preferable.

> 
> Signed-off-by: Max Zhen <max.zhen@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/aie2_message.c  | 44 +++++++++++++++++++++++++++
>   drivers/accel/amdxdna/aie2_msg_priv.h | 16 ++++++++++
>   drivers/accel/amdxdna/aie2_pci.c      | 16 ++++++++++
>   drivers/accel/amdxdna/aie2_pci.h      |  2 ++
>   drivers/accel/amdxdna/npu4_regs.c     |  3 +-
>   5 files changed, 80 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
> index e52dc7ea9fc7..976ad6281078 100644
> --- a/drivers/accel/amdxdna/aie2_message.c
> +++ b/drivers/accel/amdxdna/aie2_message.c
> @@ -1200,3 +1200,47 @@ int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 context_id,
>   	aie2_free_msg_buffer(ndev, buf_size, buf, dma_addr);
>   	return ret;
>   }
> +
> +static int
> +aie2_runtime_update_ctx_prop(struct amdxdna_dev_hdl *ndev,
> +			     struct amdxdna_hwctx *ctx, u32 type, u32 value)
> +{
> +	DECLARE_AIE_MSG(update_property, MSG_OP_UPDATE_PROPERTY);
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +	int ret;
> +
> +	if (!AIE_FEATURE_ON(&ndev->aie, AIE2_UPDATE_PROPERTY))
> +		return -EOPNOTSUPP;
> +
> +	if (ctx)
> +		req.context_id = ctx->fw_ctx_id;
> +	else
> +		req.context_id = AIE2_UPDATE_PROPERTY_ALL_CTX;
> +
> +	req.time_quota_us = value;
> +	req.type = type;
> +
> +	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
> +	if (ret) {
> +		XDNA_ERR(xdna, "%s update property failed, type %d ret %d",
> +			 ctx ? ctx->name : "ctx.all", type, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +int aie2_update_prop_time_quota(struct amdxdna_dev_hdl *ndev, u32 us)
> +{
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +	int ret;
> +
> +	ret = aie2_runtime_update_ctx_prop(ndev, NULL, UPDATE_PROPERTY_TIME_QUOTA, us);
> +	if (ret == -EOPNOTSUPP) {
> +		XDNA_DBG(xdna, "update time quota not support, skipped");
> +		ret = 0;
> +	} else if (!ret) {
> +		XDNA_DBG(xdna, "Ctx exec time quantum updated to %u us", us);
> +	}
> +	return ret;
> +}
> diff --git a/drivers/accel/amdxdna/aie2_msg_priv.h b/drivers/accel/amdxdna/aie2_msg_priv.h
> index f18e89a39e35..fc2e99510980 100644
> --- a/drivers/accel/amdxdna/aie2_msg_priv.h
> +++ b/drivers/accel/amdxdna/aie2_msg_priv.h
> @@ -31,6 +31,7 @@ enum aie2_msg_opcode {
>   	MSG_OP_SET_RUNTIME_CONFIG          = 0x10A,
>   	MSG_OP_GET_RUNTIME_CONFIG          = 0x10B,
>   	MSG_OP_REGISTER_ASYNC_EVENT_MSG    = 0x10C,
> +	MSG_OP_UPDATE_PROPERTY             = 0x113,
>   	MSG_OP_GET_APP_HEALTH              = 0x114,
>   	MSG_OP_MAX_DRV_OPCODE,
>   	MSG_OP_GET_PROTOCOL_VERSION        = 0x301,
> @@ -503,4 +504,19 @@ struct get_app_health_resp {
>   	__u32 required_buffer_size;
>   	__u32 reserved[7];
>   } __packed;
> +
> +struct update_property_req {
> +#define UPDATE_PROPERTY_TIME_QUOTA 0
> +	__u32 type;
> +#define AIE2_UPDATE_PROPERTY_ALL_CTX	0xFF
> +	__u8 context_id;
> +	__u8 reserved[7];
> +	__u32 time_quota_us;
> +	__u32 reserved1;
> +} __packed;
> +
> +struct update_property_resp {
> +	enum aie2_msg_status status;
> +} __packed;
> +
>   #endif /* _AIE2_MSG_PRIV_H_ */
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index c9c23c889c78..7ed99ea471a9 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -33,6 +33,11 @@ static int aie2_max_col = XRS_MAX_COL;
>   module_param(aie2_max_col, uint, 0600);
>   MODULE_PARM_DESC(aie2_max_col, "Maximum column could be used");
>   
> +#define MAX_TIME_QUANTUM_MS 2000 /* milliseconds */
> +static uint time_quantum_ms = 30; /* milliseconds */
> +module_param(time_quantum_ms, uint, 0400);
> +MODULE_PARM_DESC(time_quantum_ms, "Execution time quantum. Default 30 ms, MAX 2000 ms");
> +
>   static char *npu_fw[] = {
>   	"npu_7.sbin",
>   	"npu.sbin"
> @@ -186,6 +191,17 @@ static int aie2_mgmt_fw_init(struct amdxdna_dev_hdl *ndev)
>   		return ret;
>   	}
>   
> +	if (time_quantum_ms > MAX_TIME_QUANTUM_MS) {
> +		XDNA_ERR(ndev->aie.xdna, "Bad time quantum %u", time_quantum_ms);
> +		return -EINVAL;
> +	}
> +
> +	ret = aie2_update_prop_time_quota(ndev, time_quantum_ms * 1000);
> +	if (ret) {
> +		XDNA_ERR(ndev->aie.xdna, "Failed to update execution time quantum");
> +		return ret;
> +	}
> +
>   	ret = aie2_xdna_reset(ndev);
>   	if (ret) {
>   		XDNA_ERR(ndev->aie.xdna, "Reset firmware failed");
> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
> index f83deca2b51a..69b53c7bcb86 100644
> --- a/drivers/accel/amdxdna/aie2_pci.h
> +++ b/drivers/accel/amdxdna/aie2_pci.h
> @@ -222,6 +222,7 @@ enum aie2_fw_feature {
>   	AIE2_PREEMPT,
>   	AIE2_TEMPORAL_ONLY,
>   	AIE2_APP_HEALTH,
> +	AIE2_UPDATE_PROPERTY,
>   	AIE2_FEATURE_MAX
>   };
>   
> @@ -308,6 +309,7 @@ int aie2_sync_bo(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
>   		 int (*notify_cb)(void *, void __iomem *, size_t));
>   int aie2_config_debug_bo(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
>   			 int (*notify_cb)(void *, void __iomem *, size_t));
> +int aie2_update_prop_time_quota(struct amdxdna_dev_hdl *ndev, u32 us);
>   void *aie2_alloc_msg_buffer(struct amdxdna_dev_hdl *ndev, u32 *size,
>   			    dma_addr_t *dma_addr);
>   void aie2_free_msg_buffer(struct amdxdna_dev_hdl *ndev, size_t size,
> diff --git a/drivers/accel/amdxdna/npu4_regs.c b/drivers/accel/amdxdna/npu4_regs.c
> index a3b6df56abd0..6ebf75ad5fb4 100644
> --- a/drivers/accel/amdxdna/npu4_regs.c
> +++ b/drivers/accel/amdxdna/npu4_regs.c
> @@ -93,9 +93,10 @@ const struct dpm_clk_freq npu4_dpm_clk_table[] = {
>   
>   const struct amdxdna_fw_feature_tbl npu4_fw_feature_table[] = {
>   	{ .major = 6, .min_minor = 12 },
> -	{ .features = BIT_U64(AIE2_NPU_COMMAND), .major = 6, .min_minor = 15 },
>   	{ .features = BIT_U64(AIE2_PREEMPT), .major = 6, .min_minor = 12 },
>   	{ .features = BIT_U64(AIE2_TEMPORAL_ONLY), .major = 6, .min_minor = 12 },
> +	{ .features = BIT_U64(AIE2_NPU_COMMAND), .major = 6, .min_minor = 15 },
> +	{ .features = BIT_U64(AIE2_UPDATE_PROPERTY), .major = 6, .min_minor = 15 },
>   	{ .features = BIT_U64(AIE2_APP_HEALTH), .major = 6, .min_minor = 18 },
>   	{ .features = AIE2_ALL_FEATURES, .major = 7 },
>   	{ 0 }

