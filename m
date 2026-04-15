Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C851CF428D0
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 20:10:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 234A589954;
	Wed, 15 Apr 2026 20:10:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0U+y9T9H";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D425789954
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 20:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kD0SUefiwPE3Z0Wz82h4GQYPDRvxj2KCX8ha4BxsLiY76ouDeealE2QY/D00gKGANCE33VX2dlJoPZ6FFURojot6yco0vmG/D+gaupC1zOwEUWih8/iYjRPLNsJRN9zInm9g/IgaRx+3orSlp+R+By8u7KBddQthMyydkCzkUhm+LbONHnlJEnxAZTXU9fLf5vMuHENoIrpK4EaX5EcIFCCERe4pRRGZyU2gQzxu/e6Dxk2oMe9TUf0Aq7DUXS3BaLkQI0dl1njDrYPaKI4gR/u4eiqNNodC0/x8+XYqCRQagpjONKcZoEjfr8/grXFUl0lxmHudOdkRfG0H00Viqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0Bt0gNOePNorLAwDqSanw4XjhQhGG3XYh0S9VGjyuU=;
 b=XvWfX7mGOM+hnCV1QY+6BzIynOHqJgm0I5t7+p5HaqB5atb4CfVPkfc5m8ebi6crDVFiT0mZMAOyCXsOABCtqJzsUsP26o9wG0Ox2IOPieOzSiXXURjOQvJVbb5gACqG/Fjlr4MSci0gqnBEdTtAqJ22eqYW2oXAdk6ZSizIxQjgiKDv/REDPgWVQcBqB3T0pDlMSs9aY+t7XQ7ZCFFvhisy4NmWEgO2JvYc/tDvBJHs3AogNPJ8tsN2NyjioWMP+ok+7pbDIggjx4ylhSutfEh5m1igXvk9KrR703hf17bEJDfMYTtfOUCywPxImUkSMIGcsheqUKgHCYljz1xpmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0Bt0gNOePNorLAwDqSanw4XjhQhGG3XYh0S9VGjyuU=;
 b=0U+y9T9HDysDN7cQhpsC9eiSdi280lJgjOG0T7Uq/tK9+ueEi4G9DUx4mIuVdhbU+sVuxb4v61HDsMog8fS7zx6vz+OmKfxd6DGe91nXPEv//BxACV7zV6wGZaD1YVBgZ4iCoPTXaZQL3urIYjM7l6rGjFcCdPpqqzLhHJ+1qAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CY5PR12MB6645.namprd12.prod.outlook.com (2603:10b6:930:42::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 20:10:12 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 20:10:11 +0000
Message-ID: <ba510c73-b487-4c97-bf1c-3ae1823c0d79@amd.com>
Date: Wed, 15 Apr 2026 15:10:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] accel/amdxdna: Add hardware scheduler time quantum
 support
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: Max Zhen <max.zhen@amd.com>, linux-kernel@vger.kernel.org,
 sonal.santan@amd.com
References: <20260415171139.904947-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260415171139.904947-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0227.namprd04.prod.outlook.com
 (2603:10b6:806:127::22) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CY5PR12MB6645:EE_
X-MS-Office365-Filtering-Correlation-Id: dab66073-1d02-4030-56ec-08de9b2affa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: HuS0hsrJ28rpJsZCyIQwoSbATCwXkjm+4cvCgXtQPUAT0101T126+rOtf0EtEZnerguf/155jYpbG91uv1katQmKF12P95d5iwDX9F0womyLnH8S8GjFa7dCirGggN5OfU5d9sbxCSBYF+u9QBiA/3A+TaqcvQTTSaF4nPzc4Jh3dO6wFZhiPSO6QVH19Fpf2VPMF/GZHrqz2PFWNRxhzZ93tJT9zybtneUqo7mwhn66StTlAn+Bd41n1lSVuily4XegLUL2Fj76b/EQ2puvvyeNVXGYfhqj2fjEoFUQcHvtjyyreruzVVMLYKc+FQGt82gM6osTFDTyQd6R7txYMs3R3W1bdVho3EwBkkVgSuac2jz/qfD1J/ppwONO7vBCo5vuwm9UStzECCHxL+JjRkAAPAbVLC8LANAlvSMrYnLaTI+tA4lbHjcAPI+Bj8Tcyf+O/T1iifyfvslSZEQZZm1m1xixSI+98qxxdEUCaCfXckhihpE7PhviZb7HwI1ZnFn3keZV6mIXFBIa46qkas6uy6VShLZxNK2YZ7PbsjXn9o3/g1ANAAIWaUl8Roq7cYG0qEJG9nHRvN0CmtURL3UlXSu8Umq2seq0G5ALojFB9O5N4ipShAeckng2RUkZV5QyqUGg7CR9sm/I1CHDB2Uh0cKpPFCP4lHae4TJVGbdUZSZc0JCPM/UTKiXL6S3/eATt9cOD5AxC7O/2jewvWtSuExLSubRPsvoC1a2jxw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUNjUlpJSTducnNvTWtRR0Rna3F2Sk9ROHJRQVdNS0xBRFBXVjdJc2FWWDQy?=
 =?utf-8?B?TmRLYm9MRlVyYTBNT1VqMkFxS3NRQW9tYjFwRXFyMnR3ZVlGVEpJNjI5M1Ez?=
 =?utf-8?B?OWM0a1JUb3ZKbUIrUGVBT3l3SkJySUdreUJvZzBWcGo0TFVVYmFyOG1XNGls?=
 =?utf-8?B?MDc0UXFoYnNHYWhFMmpYK0FZVWczQkdWdnViRzlOUnA4RjBOVGhaZ0dYNnFG?=
 =?utf-8?B?a1pmOVZvQmIyZno1OFZhdCtYUjRsRnphNmw2bTRub3VNTTVuVFJzUWhuSUJy?=
 =?utf-8?B?T3hyQWVQVUF1cEdmVU5iUHpKd25oNmEvRnllUXE1VStYOCtZZkFwMmFkdzYv?=
 =?utf-8?B?QkxFeGYyNzBnZzRqeTZXQkM1WmxJOHNhUEUxQmxQUHBKR2dFa3lmZlREdDlu?=
 =?utf-8?B?SkRqdE5UeXZSNmIrd0NBeU4vWDYzQmdUNXlqcy9wRHVXLzgvTE5McXdDMU9K?=
 =?utf-8?B?eHVWWm5VMlQreGhIVzRsbTlwRnpuOE05WlBaWTNTYjJ6NDU0bDRvY2ducU9I?=
 =?utf-8?B?NHFGSFkxSXNCYjRzTzBzSmttV2YvamJzZU85blZwSUNDckZJc2RUcHJSaW1n?=
 =?utf-8?B?L3R5M1AxanlJRkpKa01NZ0VOcm1BWHRtSXFsVzY0ek9wYlBOUzRXZU5qUUUr?=
 =?utf-8?B?WU9aMStmWm5PZGtwclpYL1lobEYwVmV5L2UyZGU5YWZjZEoxU25YNHZMMTND?=
 =?utf-8?B?TUN1M25lL1Bua2M1OE9yWFF4TDJTZDlmL0NXNExPaEpmR1RTRWt1aEJaWFRm?=
 =?utf-8?B?Q1ptSnZhUDdIV3Iwc3J5WDhIdDNoSzlKMkh5R1JmTVZCSko5V1pkOUROTkNF?=
 =?utf-8?B?dTBaSzkwNWl6ZDN2R25mMVF3d1RPNFpwVmZTd0sxWGg2M0lnTWFjaENYTjZ6?=
 =?utf-8?B?bTBWZXBUOUc0YnFWSGlaME9rZkRCdlpZbDJoU2g1Q2VrZjJxWWdWNU9vWVVY?=
 =?utf-8?B?UFhkUjFRWXdaZGFkc2VBWVhCbG1tT2VDc2ZweGptWll4eUJLYXVIM1E3ZzVx?=
 =?utf-8?B?VzkvUFExejEvOWdSeXkvWVN0VTBKV1JMc2haWVJUdWhkNWJHSWVUaFo3UmhB?=
 =?utf-8?B?b3NJa1dIc09KNm5UZVBhUDVKeGpQNkJMSTc0NGFheW9aclY5Z2o2SjRDWUlz?=
 =?utf-8?B?Vm9XT0xGTDZaMVNWNldDem8rZHNkc2hZSDlsdE1zcmtLeCthNEp3WmZNTnMw?=
 =?utf-8?B?K1U3dmdRQWVFZ0ZST2hCOFFVSHRIK0VQT0VXdnBJNmFJbTJLVzNiSE95Y1d5?=
 =?utf-8?B?eDVpdk5JWGNGL0h1WGNaUXM2djk2YlZ0L1dTYnliV3VMUEZ1YnlSdDlBb3RX?=
 =?utf-8?B?bVU4bnk1WUI3RE52VTVDWkFOZS9TYVBSdHJYMFpocm0yQzYvZVQ1cFpWcHhP?=
 =?utf-8?B?eUVSeWhDdWdZRlgrc0JVWXFFM2pqRG1hOWtmOTZsRWQ2clRhU0hJcytXVUdj?=
 =?utf-8?B?RDRodXU1bkNySFJ1WWlkQXJ1UEtvMzlmbWFZZ1ZiNzF0VE0xNVAreWR6alhP?=
 =?utf-8?B?VUZlQ3JXKy9CUm1UcTliU0psSCs1bTFSVHFHSHRMY3MzL3VQVGpmQ28vaENm?=
 =?utf-8?B?aHdJdVhXU3lXcTIyUnlnYUQ4QjNmRXlaWEk2eXFUV0F5bHE1L0RxVDQ1ZUsv?=
 =?utf-8?B?Z3RjSFpGaVBlWEtYMjdBZEdzcGtsVXhoVUpMQ3gzQWZUL0pkaW80UEpmUHhq?=
 =?utf-8?B?djcxV3pDUkw0cVVpWm1FWnFSNDYrcllIa2tzb2pvYzdUVkt2MndoNzJTT1lQ?=
 =?utf-8?B?V01VTXVBUU1LMzdTRk13QWJlRkxGeXA4ekhNWG83bU5HVUFUYUtpczF0N29C?=
 =?utf-8?B?QnBGZlhTRkE5TFlxSHNEaE9Dc1M2UUs3UlY5Z2loR2ZHUEo0d2pTcmluOUJG?=
 =?utf-8?B?SXpkT3JuTDFMNWlLbnRMV1hpUjlWMVdid0RaMzBOQWh6RzhUWnBxckJFQVR4?=
 =?utf-8?B?WDVXNEZFRGhMZjRCN0ZCaWZJaTg0V09RWHV6Mm5zTkpuRmFzTEovNTdVdUFG?=
 =?utf-8?B?dy8ra0pOY2NvMzB4UlpjSVlJWW9ZeGRKYmNiTzZzYlNGS0V3Q0lXcytFbXZI?=
 =?utf-8?B?eWxNOC9Hbkl3Nm9pYUJwN2RUc2E3bkl2VTk2MzV3L0hPckd2VmxzRWs2a3lX?=
 =?utf-8?B?VEUwdFN0czdUMFBYVzE1TzRFTk95bzNxMnNmd1hyODM1UWc4dThadDM0RkZ1?=
 =?utf-8?B?S1FMWFJ3b0V3cGJnV281Rm8rMjdWaVdLV3EvRGhaaGxtNnZYRlFHUU9GTDgx?=
 =?utf-8?B?K00xUkVPSGRJNWZidmtKTXRjNXFhUWxDZXRQY2tkdmo1bEpaMXE5YnAxVTAv?=
 =?utf-8?Q?LraKKVPKUshrgOcEAj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab66073-1d02-4030-56ec-08de9b2affa1
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 20:10:11.4710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqsrbeI/XHX/B/fW9tf8LzYc6HjJUSTjHfwNrbunH0O2tBBZVFd1o8v7qyypU2Yf/+wtaTG9ulp91TyPOfel0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6645
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



On 4/15/26 12:11, Lizhi Hou wrote:
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
> 
> Signed-off-by: Max Zhen <max.zhen@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/aie2_message.c  | 44 +++++++++++++++++++++++++++
>   drivers/accel/amdxdna/aie2_msg_priv.h | 16 ++++++++++
>   drivers/accel/amdxdna/aie2_pci.c      |  8 +++++
>   drivers/accel/amdxdna/aie2_pci.h      |  2 ++
>   drivers/accel/amdxdna/npu4_regs.c     |  3 +-
>   5 files changed, 72 insertions(+), 1 deletion(-)
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
> index c9c23c889c78..afbe3f8f67ce 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -33,6 +33,8 @@ static int aie2_max_col = XRS_MAX_COL;
>   module_param(aie2_max_col, uint, 0600);
>   MODULE_PARM_DESC(aie2_max_col, "Maximum column could be used");
>   
> +#define DEFAULT_TIME_QUANTUM 30000 /* microseconds */
> +
>   static char *npu_fw[] = {
>   	"npu_7.sbin",
>   	"npu.sbin"
> @@ -186,6 +188,12 @@ static int aie2_mgmt_fw_init(struct amdxdna_dev_hdl *ndev)
>   		return ret;
>   	}
>   
> +	ret = aie2_update_prop_time_quota(ndev, DEFAULT_TIME_QUANTUM);
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

