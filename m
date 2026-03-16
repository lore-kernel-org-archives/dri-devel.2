Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92282F53D7E
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:02:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F342810E2E8;
	Mon, 16 Mar 2026 18:02:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2CU2hluE";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011045.outbound.protection.outlook.com
 [40.93.194.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B27E910E2E8
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 18:02:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXm4AObnWbutORpqLGZvjjb9lQ8yh55/x4LD2eNBbW0xz/RZVBJTPhZY8IeJ/t93BrzPDjSKKpdtBT/XBxVECP55A6jrUyN3dSJxE8cMPj5qk86BAdHppaBC7JV2bSn19WA/c+4IzMK9CHSwLC8pNlNI7QlVW0YG5Y3yAA6+0SBWMMVVMmjoP6XWyupExjmSopJHcvXJTHp3OwXBIn24rrwBYthHNf3PXZ7S+nm40MVOBEiOfdT/+RQjPAmznDpluQAwnUb5dipPagDaGvriZxMiS0n5XBzPFurBRoTvzv4tTdhIzRpRo1rfpRvOizpLolyYcG/NpHeQBzVl7XKm2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RjrGxym0wewr4XK4mQPSJeHR8xkeVl8uKDM4AXUIBk=;
 b=cdTRyqtoQwXJ4x0IsDMLRMZfr1UPNJQOOGESO9j1AaAvBzdJZ3YZDmWosPhZS4Xqfl2rR1itlLr4w8D8VGqXm+pjo4f59e7NkiqWsduA0agBSXBE9spWYHscPSCi1vdR9J7vXZdRR+OsW7OHX5XiWCebep451UuSRMzx3pNoz7aBOejWn6mhvgcYRYiDRiWLvHZqrO3YMYo87M9gTIMi7TzQUWnPeiqOt9jhsliItaxhUrhj5qppL9p5Guv7elmmktMk+Ht8qigXsLkqHPbsbp89ROxuVwOoRXrz5jRq9nMCNxQBVj0FOzf7rK6ASunudOyNwBaQuriUY4MD2gMwhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RjrGxym0wewr4XK4mQPSJeHR8xkeVl8uKDM4AXUIBk=;
 b=2CU2hluE3Vi3HZZm29owMdumS+rWYs3zi6ob8MGz69PuQ3AwA+1gIPjz9GODcwseRp92EBHcowuDQuXU8LphnJwafkCCGO25mL5yZQNpYMyosGx58sZSllAnaLRr7zn2PEhIN0YKhZQ2mYf5OTibw4q5FdV2FMajM+LWurf6cZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SJ2PR12MB8883.namprd12.prod.outlook.com (2603:10b6:a03:538::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 18:02:45 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9723.008; Mon, 16 Mar 2026
 18:02:45 +0000
Message-ID: <1d2c1de6-3c2a-4c7e-b7a4-e3fbd5b8fdcb@amd.com>
Date: Mon, 16 Mar 2026 13:02:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] accel/amdxdna: Add debug prints for command submission
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260316175642.1451749-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260316175642.1451749-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0092.namprd04.prod.outlook.com
 (2603:10b6:610:75::7) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SJ2PR12MB8883:EE_
X-MS-Office365-Filtering-Correlation-Id: 244d9237-180d-4850-b1ab-08de838639ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 8qP0P2j2wmq0gzFUEt4Wscrqe5NQseUYRyPwYf8vrRmYDG2lHwCDA6X6tKXdeAGupRtN3NQW2wfsPSs045sHy8z31oaxD3yuo1YIHlqkFhQLZHuGdsGNB8ZJeBNbF63zpB0E/9xf2KPMADz8cBEf4jSE+VkL9FEebrzx2lz2wts/V0Wte0uoz8JFunGu6Bdojm48lRNvoe172UPiVJfVOxuzwfyi55C70lGdIQfwY0juOX9ClS6AlG4rxh9RDx+nHGjq7NCO3B0FqGA53eAO237fRbmuPJH0ven2Ij5VrKzMKocK9jnsqDHSGEm6dEfLuID1I7ANcrTbDFvz1Zu9hdRvjFMskhjO7Sp+N8SisMiVKCCg64w0WpLlmEFlFRv/GeZG6VF3UE1heWIxcBwWxHk8P6Mpzj2LK7CbdTumgkbWc9zrDXYPxc4rq2GV0FjiJvWin0qGfInatTLGgJzyyBEBAWdsRoxAKSo1SKs9LHYW+X/6hO3XdOUYTN48KREiEv2lHkVgvv4oXuYTYV9/i/edll13rAWYRc9npyL3s6WHbIWld4I+STmWRvnyjI5p0nGpAwom1OtXKlThD4BracbweOObuAhRnybOoiznaCBVgU6OAnd7sOtHGmmpMzwtMZIacy6MOb8E336BEd2PSU3B/IpwcdzVV1gIdobEvILwV0bQz2WG4ZJKCzagsPt8zWIqNf0vRpieOWHl/aRvRXQF/HwynPuWE2f7vn33LAs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1BzdlpKVTBWMWh3MG1lVUE5VFhXck4vTUpRTGZUdUZTRC9seDVlMTZkdlBw?=
 =?utf-8?B?b01rWFI2OWF1NVBkd3c0UDg5TUVkSnNQN3NObHJudVZPbERqbzVTTEI0bVlO?=
 =?utf-8?B?bDJIZVJ5VWxhbExBNVd1ejRoL2JPWWsvQzhVK1FOcEllU2h6d2RsWU9LeUM2?=
 =?utf-8?B?VU9LcytsaElzNUZrZk0vREJJNnNxZ0pkV3ptTi9XNE5lbXRta054ekowMENS?=
 =?utf-8?B?YmY2N09LaytHUnlYYkI4UzIycHVzRVpCcFQvQnpNZ2ZMOFB1VEdFYjd2OXlK?=
 =?utf-8?B?M1VBZU9XeGlKdWRZQVNGS3A3VkEvQWZiZWNzbXZaSURRWVptblFOTXBZWVRI?=
 =?utf-8?B?d1VpVDNMa0o4bVlwbGt2dVppR1RQclhSRWt5N3FGWnQ1SVVlbjVEZlNsUlo2?=
 =?utf-8?B?S1VrblFTOUtRTktza1YxTjdxVUM0YmZ5dnROYVd2UVhoUUd2STkxTndYS3pB?=
 =?utf-8?B?UHhCUGdPT08zUDYwdldJQmZyYzdrUlpTQUtjdnVkTkhKNW5Pd1p1VnRZNGVI?=
 =?utf-8?B?UUcwdEU5ODJRejV6MFV6bGt2bldTbXBMeW1IaXAvOWg5eFExTXlzZVV5RitN?=
 =?utf-8?B?Rk5QUUlLMk9VVEpBT3ZNYVRFVkI3Z1ZYaWV0QURFNHNlU3NodUNhZmZVNjZW?=
 =?utf-8?B?dGhERWhSTFJhazBVK0U1VUswVjVtUFNJb0Z5V2FtMFRWdXFWUG9VTmlwRDFG?=
 =?utf-8?B?SnRRZ1lMR1pNZUtwa3hCeDVURnhhbno2cHpZc3VZQm1KUUlzRkFoazY5Q0hv?=
 =?utf-8?B?cytKK09KREZsUVV4dUw1aEJlVUVuaVc4N091aklPT0Y1c0s2V0hXZG1pYVk5?=
 =?utf-8?B?dkwyUzBvSTJOMzhJSWdPekM5R0hOM1ZqVFAyOEpRTGJqaERNSWdHQ0VQZnJS?=
 =?utf-8?B?LzZhaEJjL3FvSEZSRHJoS1dxQ0ZudCtBd1hRek44bENuMUMrQ1djY1JYT1JC?=
 =?utf-8?B?ajYwZlB1S1Z5SXRTZ0Zsc0orSE1LczJJbWxsV2hrMnpiaTc5QVNYczR4QnlY?=
 =?utf-8?B?bmxSQTZGRVlxYzU3MmowN0k2OG9hc0JiY0dBdG5YbjNhbzQ4UkdpS3RvQVE4?=
 =?utf-8?B?ZDE1YUxiVmUwQ1ZXZmx4RVlLMUZMY0RlM09ZZmtlSjVoMXRjand4T1lWWTZ1?=
 =?utf-8?B?aE9sL0tOSGVIVFExZjNCSTV0K2pLZ2RjNFA2SDFhTmNTZ3pkY1d3VUpRT2Yx?=
 =?utf-8?B?VzJFY0JURlh5MFo4NU41MDFDZWRyVlpNanR4dGVHMHdxeWhmanZyeXJwOTZP?=
 =?utf-8?B?UDAxOHlGc3pyOXN6RjI4M0lTZjNHV3V6QkdFdGFNZDk5YXl0aTUxalM2clV2?=
 =?utf-8?B?L1p2Y1Q0WlUzTnU1U0l3c251MVUrbFVUZFZQK0dpZEdDQUVmakhKUHhBSUUy?=
 =?utf-8?B?cmlUVWNwQk03QS9Tek5yRzdydEJFaGw2MVMvQzkrYVJyMElDdWE2cTZiVWpK?=
 =?utf-8?B?MWxuQ1lhbEYzazZLanAwRVdQZHVjZzlFUUpCT2grZUpOdUJ1ZGcvMDFKcnpE?=
 =?utf-8?B?cWtUbHdGNGdPbGNEd3J4TWl1eDEvVzEzVk9sSTk5THZrOFcvOUpRNFhSM0hX?=
 =?utf-8?B?YWhDaDdTY2ZHNWV3VGVTaXBwblZBRDBzajhSNGxlTkpQOUJremJVSzBxV0Rp?=
 =?utf-8?B?dU04c285Q2JJamd4V09laUtCdWdzcFRiUG9vcE1La1FLSkxSelRlVnJtNXlJ?=
 =?utf-8?B?Q0N5SkQvWGo1VEwwWDB4MmNCSnNFUXFKaGptTkNjaHBxY2grLzM3QTVDNHZX?=
 =?utf-8?B?NjRQZEpSYy9xcmRYalUzMVZycVJDRU81M0UzS2RXUTRNRkhZd21ya2xKeVR1?=
 =?utf-8?B?d3Bta0FNMnU4RGpuN2dIRWJqd0tEcWZZcnl5ZE03VUJEUGtremQ3QWwwa1J4?=
 =?utf-8?B?cVdMbCtueHRjVlZFZDJxdk5RN29uUTM0Qkh5N0c0QitocHkzUjZ5Nnp0OXRZ?=
 =?utf-8?B?dlgwMTc3K21sRnRObEUvOFh5aENGVU9ETWxvNGxtazd1Mk5WQVlsNnRsaGlk?=
 =?utf-8?B?K1k0NjhxemgyYmZpK2RBaTlDQmlsZzNZQlBQTVR3TlRVUDJNMGFqMUFuNHJk?=
 =?utf-8?B?MGJqdVpDSWJhenlPWjk5ZGlYSWRZeWpVUjhrazR2VlZPYkFCY3pVbElwZWsz?=
 =?utf-8?B?dXZBUG93QW5jZ3U0RXpNbCttcnJrNG94VStqOHlWTUtiZ3hjSHpTMnU2SUM0?=
 =?utf-8?B?ODJwbmhLTFl5QjM5OWgza2U5eXhNc005YVJ4SmU3Z204ZThMdS9TWWFBQmNn?=
 =?utf-8?B?eWN0RW1qdE9mRUt3NFhNanZHRFVnMjlUV0hvMlREMFFROTNpRFZHSWZMYzVq?=
 =?utf-8?B?SXdIZnRiOGlDdzRRLzg1bnlsWVdlOElsSzNnSG1WV3o2ODJXcnpVdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244d9237-180d-4850-b1ab-08de838639ab
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 18:02:45.0806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VS8nSDqI8IbQJ5aFxXipcUXE9zN2BSznyDhtHfHugLmnHrPMekBhbhRjH3Qd9qKGddOVYwJ7hhZvpdMxpJgLsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8883
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



On 3/16/26 12:56, Lizhi Hou wrote:
> Add debug prints to help diagnose issues with incoming command submissions.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/accel/amdxdna/aie2_message.c | 34 ++++++++++++++++++++++++----
>   1 file changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
> index b764c7e8816a..4ec591306854 100644
> --- a/drivers/accel/amdxdna/aie2_message.c
> +++ b/drivers/accel/amdxdna/aie2_message.c
> @@ -1002,7 +1002,7 @@ int aie2_cmdlist_multi_execbuf(struct amdxdna_hwctx *hwctx,
>   	struct amdxdna_cmd_chain *payload;
>   	struct xdna_mailbox_msg msg;
>   	union exec_chain_req req;
> -	u32 payload_len;
> +	u32 payload_len, ccnt;
>   	u32 offset = 0;
>   	size_t size;
>   	int ret;
> @@ -1011,12 +1011,24 @@ int aie2_cmdlist_multi_execbuf(struct amdxdna_hwctx *hwctx,
>   
>   	op = amdxdna_cmd_get_op(cmd_abo);
>   	payload = amdxdna_cmd_get_payload(cmd_abo, &payload_len);
> -	if (op != ERT_CMD_CHAIN || !payload ||
> -	    payload_len < struct_size(payload, data, payload->command_count))
> +	if (op != ERT_CMD_CHAIN) {
> +		XDNA_DBG(xdna, "Invalid op code %d", op);
>   		return -EINVAL;
> +	}
> +
> +	if (!payload) {
> +		XDNA_DBG(xdna, "Failed to get command payload");
> +		return -EINVAL;
> +	}
> +
> +	ccnt = payload->command_count;
> +	if (payload_len < struct_size(payload, data, ccnt)) {
> +		XDNA_DBG(xdna, "Invalid command count %d", ccnt);
> +		return -EINVAL;
> +	}
>   
>   	op = ERT_INVALID_CMD;
> -	for (i = 0; i < payload->command_count; i++) {
> +	for (i = 0; i < ccnt; i++) {
>   		u32 boh = (u32)(payload->data[i]);
>   		struct amdxdna_gem_obj *abo;
>   
> @@ -1035,19 +1047,26 @@ int aie2_cmdlist_multi_execbuf(struct amdxdna_hwctx *hwctx,
>   
>   		offset += size;
>   	}
> +
> +	XDNA_DBG(xdna, "Total %d commands:", ccnt);
> +	print_hex_dump_debug("cmdbufs: ", DUMP_PREFIX_OFFSET, 16, 4,
> +			     cmdbuf_abo->mem.kva, offset, false);
> +
>   	msg.opcode = EXEC_MSG_OPS(xdna)->get_chain_msg_op(op);
>   	if (msg.opcode == MSG_OP_MAX_OPCODE)
>   		return -EOPNOTSUPP;
>   
>   	/* The offset is the accumulated total size of the cmd buffer */
>   	EXEC_MSG_OPS(xdna)->init_chain_req(&req, cmdbuf_abo->mem.dev_addr,
> -					   offset, payload->command_count);
> +					   offset, ccnt);
>   	drm_clflush_virt_range(cmdbuf_abo->mem.kva, offset);
>   
>   	msg.handle = job;
>   	msg.notify_cb = notify_cb;
>   	msg.send_data = (u8 *)&req;
>   	msg.send_size = sizeof(req);
> +	print_hex_dump_debug("cmdlist msg: ", DUMP_PREFIX_OFFSET, 16, 4,
> +			     &req, msg.send_size, false);
>   	ret = xdna_mailbox_send_msg(chann, &msg, TX_TIMEOUT);
>   	if (ret) {
>   		XDNA_ERR(xdna, "Send message failed");
> @@ -1076,6 +1095,9 @@ int aie2_cmdlist_single_execbuf(struct amdxdna_hwctx *hwctx,
>   	if (ret)
>   		return ret;
>   
> +	print_hex_dump_debug("cmdbuf: ", DUMP_PREFIX_OFFSET, 16, 4,
> +			     cmdbuf_abo->mem.kva, size, false);
> +
>   	msg.opcode = EXEC_MSG_OPS(xdna)->get_chain_msg_op(op);
>   	if (msg.opcode == MSG_OP_MAX_OPCODE)
>   		return -EOPNOTSUPP;
> @@ -1088,6 +1110,8 @@ int aie2_cmdlist_single_execbuf(struct amdxdna_hwctx *hwctx,
>   	msg.notify_cb = notify_cb;
>   	msg.send_data = (u8 *)&req;
>   	msg.send_size = sizeof(req);
> +	print_hex_dump_debug("cmdlist msg: ", DUMP_PREFIX_OFFSET, 16, 4,
> +			     &req, msg.send_size, false);
>   	ret = xdna_mailbox_send_msg(chann, &msg, TX_TIMEOUT);
>   	if (ret) {
>   		XDNA_ERR(hwctx->client->xdna, "Send message failed");

