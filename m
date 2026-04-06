Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EEAFB5168
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 21:29:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5FCF10E2A1;
	Mon,  6 Apr 2026 21:29:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dTKHYaS8";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013037.outbound.protection.outlook.com
 [40.93.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 917D010E2A1
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 21:29:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzKOeDv4ozaq7/0cwamllc1NzbmmGvZr7roKPDpaJiFUfSTPUdh2dPoT3Tsd+8Okg3qI4FWZr8OoTgXMZBBcNwKtZqRcLakEdg53KT5r6lLSdZzvy1AuN/jHGmQJp7W0YAz1sg7+rRoMYw+F4ty8Wc5BfK0OtpWU+h+Dq/al2EUGXBgV22HLCmr72NE/JP1b5hbp92Nmb6qqCs6B6n1oEbsu6kyBoGhyUjXTPytCRPo034l5I0+EG0PujG7lMCF3wCExVdugAFNtQWi5p+xJPYSswa1NNKP85VZfYHdx9TZLo0H8l9xrCdDi+HPcdJ3bLvO2vD1UrPeuHmWafWUoDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxKRQ7Mn7gRx/CCSjC5hcbd0a9qX0OOy5t3V6n8741c=;
 b=ysFKrtgp4dCxJlNhdcAN51J5MMVQIDIv1jQDo0T1cqOTy7aIWtx0/2/XiU3h9UY4kFTuobQkXga++JaNBQeK5gVqN7VaGx24IdyOK5ZaM98nxhs2LHRN5xbuO0ncT6YhnYqGobkAAcInTrsFnIilu9QJMHT8fdz61NrhOnK/sY6Osrw6ZSl5lkHyOzdM/tzW3bgblcy9IMJ5+/5R8uV4cIeLSo0mSBK+5W//bHVQ3nWm2Le5Hnofev7y/O1lp1fdFTKnxniLJupuCsPcg+l43y4nJXbMAO06dZcpDWJOHQOv7ro/aKV+sF7/qHHwMXDXZ36GaMYLwtstOvk/2WlrkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxKRQ7Mn7gRx/CCSjC5hcbd0a9qX0OOy5t3V6n8741c=;
 b=dTKHYaS8fnSatAEuoPAvWxdvScJv5xwvTCiOiO0rF2FWqgfrNP9svZkUdwx5jDWlc/JZbMEZCe114W8fMCWWaVwB24/z1Phk3V3kBouqpJNjid51WQU2trw/CAZBgOP8D5Sbyanw/DlIHJ451Df+9ZOKBRQWQGLDwErLsaamZq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SN7PR12MB7251.namprd12.prod.outlook.com (2603:10b6:806:2ab::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Mon, 6 Apr
 2026 21:29:10 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 21:29:10 +0000
Message-ID: <ea3bc9a5-e21f-4346-8af4-4ebc0f44a234@amd.com>
Date: Mon, 6 Apr 2026 16:29:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Handle DETACH_DEBUG_BO through
 config_debug_bo path
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: Max Zhen <max.zhen@amd.com>, linux-kernel@vger.kernel.org,
 sonal.santan@amd.com
References: <20260406211403.4011988-1-lizhi.hou@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260406211403.4011988-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0310.namprd03.prod.outlook.com
 (2603:10b6:408:112::15) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SN7PR12MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 405b1b5b-8e03-405b-a5c8-08de94238aa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: qD0ARnov7k+UmTG4V2+NR95UMgrMHNqG+F0+FzVjDQPR4iWCOa1BQe7EPVjUmToWRwS7PI21xXt09unlCRvbtLwL07EbqMT/2OPeiHkRELeaWuwXHIJ1/GybAttMRxAx/KLC+sQPjvhVH5dVjGHNz8zd7THy8/AopwYHXRi4lG4AH9KHvdj1tMBbXU2i1fJ/eoJ1nQDPcAPN3Rig2Lsvyb+/kqjYuakCfWWtweroS0WBqr+emXVkao4N1hdQgXxXvP1QPXWbE/J14vsUyaEBn46SVODUGQUdhUuQ1qiLq08+tDIu54Wqk6yg+0SUQ4pM+xPqrVkU5qE1bqhPMOc7YxjIwGEFwECoJOBH3utMZeGC9xBKmduWi1Pd89egVRzVbadB+j0o1ywa443mG1tPMZUSIcV2y272OA32JFmQdbkFRswHuEM9zufv1n79mI/UqRm6lrAzdbcWO45VPddf6BqCTV/uF1FVEyS5ktWW1ZRLoxHKnbKJtDc/9oFALSExnuRvU7GiF1Wj64+iM9HU3VgrLIgUKHqn6flgF/4cf8Urfl86yhseOqEsVzTuVdyMKUA2jHIyidbM0T4EweQTUZ2IbGD8AAUlztiNOSPky87ke4N3a4MQBHpJ2qYrGDKqz4KxXpygcO7ucrx/2wVRlUgqbZtuU6p4OyuNQms5iLR1IedkJnFleyRFFZnwamonYjydWtpd4dAbH42ixvltJ7SVknQtQtyMjHSL37hs08w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emRSR3lJSGIycjkvSFhCL1QyOXNiZVkyYzVZLzI2cjFSZGZ6Q0tjcjFPTmtr?=
 =?utf-8?B?MWdlNnlSa0d3a3FCT2dDWVJYeHgrem5ZTHl1bkZFZVUxYTg0a1BOb0Y5dVJL?=
 =?utf-8?B?d3BmcU4zb0NlRzRBWDRqSlNheHZBRExYbk03K1UwQk5FakVWMGI2NWFybnNz?=
 =?utf-8?B?SE1zaEJEUll5bGUxdVRiOFBnc1JtMTJBZWhjQWZ6N0N1NVhPdHdxU21PSTZY?=
 =?utf-8?B?SG9hSThFSkx2TVNwOHBYT1NoSWF4TDRsTzVoTHVIbEQ5UDMvMjRQSDZsUU1K?=
 =?utf-8?B?MCt6UlhFaERHMmkvQ1hSQUR3M0RoZkhwdHNUMzgxWDhkakl2YmlkTUhudGsv?=
 =?utf-8?B?RVRQazNSOGJiTngreVc4TWxXWmN0QUFJZ2RwZGJYQ0h5ODRrNm45Zm9PYVJ1?=
 =?utf-8?B?ZjhuR0VUL1M0aDI5SUJlWDJmV2tZUUY0Vko5bTZMdzRaMHZnNEhvWVowRDNn?=
 =?utf-8?B?OXoyWmJJV1J6OWdPSHpXZCsyUU00RWxSQUwwVG9vMkwvKzBZTE41VUFZazZ1?=
 =?utf-8?B?a2dyc2p1SEF0NjJOY01mWVZUL0Y4MnNwZ2M0OG9YR1o5MEdvSG1zc0dVZy9o?=
 =?utf-8?B?cWZGN0NFM1lETzYxZG5FVE9rd2JlTFRKUUV1eDFENTJjWkhNQXRsMy9ZRWg3?=
 =?utf-8?B?djEyOUxldy9UK2JGWEUxTDhEcUorMUlyUmQ2L0hQWGFERHZVRlcwMDdPU0Z0?=
 =?utf-8?B?ODNnOXZ5MmdkU3lnY1hySGl3Q3VMNHZIOElJc1QzTWRmdmNSUFFxK1cxNnRS?=
 =?utf-8?B?NWxsYVl3MDdEckpBZ1phcllDcDhhUnJJMXoxRWdJSE9MdXhpNm9xK1ZGUzFI?=
 =?utf-8?B?YVQreE1yMHZxZjdzUjlwMUdlMEdDUTdxbUI3aFlUdVRNeWtiRUN5R0tiS05I?=
 =?utf-8?B?YTFaNTRPNWFvTStOd2VSM0p3akJxRWZFUWZSOVFUb1ZyaStUTER1QUgxUEFn?=
 =?utf-8?B?NnlpNURUQVpPTW1QRjJYTitkQ0hnSVErb1E0ejN4OERZODRjL0ZUSlo4TzFv?=
 =?utf-8?B?NE5rRGVrWDRBbkJNRWl0OTVudWMzQUZ1dUVHM0JrY00rZGdnTGUvbUYra0ow?=
 =?utf-8?B?MFlObUNFenRZT2NjUGMzaEsyOG1xaHM3SktCdFFOdGxpVFZMQS8xNmhvSmNC?=
 =?utf-8?B?RkUrb2xiVXMybWVTUHBmZlp5QVVIeW9ackl3cTRtdzRva2ZDb1RtZ0VpQmdZ?=
 =?utf-8?B?a0lOMW9uOURoTnIzOUxpeTgrMGdmK1o5Y3NIWWxYRXQ4UTJDWDNvWnJnU1My?=
 =?utf-8?B?d0N2S2VzaFFqdmo2MjNYYjlVUmxCV1dxQzhuS29UOTh6djBrZlZLZkhnN1kr?=
 =?utf-8?B?MitWdEZuTnpYMGp4OEZaeVBZam9zbTAzZHpDeGNpYUNuRG9nVDZkS0Q0WVBO?=
 =?utf-8?B?RkY3cjFJTlIyd1dtN3d1bFlWU3Y0WW1VeExyazFCcWdEVVQ1aHI1OTdUTCtw?=
 =?utf-8?B?RHdtWWkxeWhxWmZkK2pqSjhCNnJtdmVFT3BESTMyOHUxMkkwdnpQSU1GV1pP?=
 =?utf-8?B?QkN6ZzRWK01nRHlLaklVYndiSVZRZnJJMW92bi81T01VTWVYWHVRL0FLQW0z?=
 =?utf-8?B?SVJWSVVZUzN5elpCUjZsRTR3U1dzYWtZQWNLN2RMaC9CaisyQ0VnY09pSFVn?=
 =?utf-8?B?RHhYcy9HbEJzNzhKc1lxdWlSbzVnSlhWazl0MlJxNjFrMlhJL3RtM2ZDamZ0?=
 =?utf-8?B?WTFxb1Ntc2VMYllSYUFiR3MzOVNPd1R2UkRNUTU5MUpNd0xBYk1YcDRTVC90?=
 =?utf-8?B?N3pJNXpkS1h3MWRNbTVmNWtpVEYzMlYrTEhTTGpBdEMyazhyZDBlTEd1dER2?=
 =?utf-8?B?ZEZXV1hTTzlONmVjMXlKTUoyN0dyUURwMzNBTXhGMU93cm9scEFUa1oyTTVP?=
 =?utf-8?B?MXBLUjQ1OWJacVRDRGwydjZjWTlWeWF0RTF2TTVBRkVSZFB0cTAvdk1LTis4?=
 =?utf-8?B?T2M5OFFMZlZaMVlpakhrSktIK0ZQRm13eGRXZ0Fnb0N5UU9pOFoxSkFMeXJP?=
 =?utf-8?B?L0xodG90WWMxQnBzSDRscDlzVWdFdjVlNkVUclg4eEVSNVdjRzlrcndzT0pa?=
 =?utf-8?B?U1BvN3FHT0hUMU1nMWkrSDkra1d4OWhTa2Y2VkRLcllPU1RTM0NHWjdaemJI?=
 =?utf-8?B?Y3I4SkgveVc2OWxIUTBQWHR2TFY4NUR1YUZWSk9xbmxuRjl0b0wyam9jWkp4?=
 =?utf-8?B?elN4QjZKRmM4OHpmaG94YzNKSzlpMFl3bmpzb2U4bHhzbmt3QlREL2gyaVd1?=
 =?utf-8?B?aXBQRTJITkljeUc5dGR6STJSMHJiZGJSWmhGQmlCZEZlMC9HQnpUQmZtdVhG?=
 =?utf-8?Q?5HRhIC3JGUnmm36kqJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405b1b5b-8e03-405b-a5c8-08de94238aa3
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 21:29:10.4999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GvyNexfe/NUTwptRNO1XBdT5xGVLfId0Qc4NwWFjuArFaP6Ffq4FKxIPjgCj3kZAY2Mm4jZgBsHut1T/pAQJuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7251
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



On 4/6/26 16:14, Lizhi Hou wrote:
> From: Max Zhen <max.zhen@amd.com>
> 
> Route DETACH_DEBUG_BO through aie2_config_debug_bo() the same way as
> ATTACH_DEBUG_BO.
> 
> The scheduler switch in aie2_sched_job_run() already handles
> ATTACH_DEBUG_BO with aie2_config_debug_bo(), but DETACH_DEBUG_BO was
> not included in that path. Add an explicit fallthrough so both attach
> and detach operations use the same handler.
> 
> This fixes debug BO detach handling by ensuring the detach command is
> processed by the expected configuration path.
> 
> Fixes: 7ea046838021 ("accel/amdxdna: Support firmware debug buffer")
> Signed-off-by: Max Zhen <max.zhen@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/aie2_ctx.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index 8db32f8e2362..c464cf8024c3 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -360,6 +360,8 @@ aie2_sched_job_run(struct drm_sched_job *sched_job)
>   			ret = aie2_sync_bo(hwctx, job, aie2_sched_drvcmd_resp_handler);
>   			break;
>   		case ATTACH_DEBUG_BO:
> +			fallthrough;
> +		case DETACH_DEBUG_BO:

TBH - I don't think you actually need the fallthrough command here 
unless you plan to add new code in the ATTACH_DEBUG_BO case.

IE you can do this:

case ATTACH_DEBUG_BO:
case DETACH_DEBUG_BO:

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

>   			ret = aie2_config_debug_bo(hwctx, job, aie2_sched_drvcmd_resp_handler);
>   			break;
>   		default:

