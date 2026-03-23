Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D65F46126
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 14:13:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C265410E200;
	Mon, 23 Mar 2026 14:13:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wiKnfx1l";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011001.outbound.protection.outlook.com
 [40.93.194.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3918310E200;
 Mon, 23 Mar 2026 14:13:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lD5uvRZj+jIUBCxp8jNgK852C9U/qodJm5zPYOn77PV3TASVplxubhlgdYk/8W0Z3MVSe68jP/MoZx4dquDG9vpvVgubbhjTYnw/1RIdviVY6XB6Ipqqc1jt7mMRFvyhh6DHT+d6v0ogjA/DewdpR8uxzfZGG11WVS74RodgRjDfs/uGrGKHRVjY2qf1qb5igeg9zZzvRCBiATtIiIVfgmRberdOnfyiio7ABFRYACCFwNZwENZEs3OVhmd3ysw9qFbrhJw/RVBuJO/JDAcmgwQxti3l8oNtIeCu2cI0+4ShU11nV7kaPOMua1BMM+TpCpnhtAaWzDoy6wxBLUtMCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pyDyIGpjY14uLZ0WUW8UgtjjI+ibZCX4LA5H/OL8FI=;
 b=lBuk8IXMfgowyqCiLSU/GW2aAyDQur/Rb93O6eP93cdaawGiLu+rGi+GGVKyuV2su8tqjC2tLcH9MIsCrSulz1FJb+q/P4/qRzJ3AxOlr/OPVvNmwK+oDC//pvwr93TWqZN7EdYa/udYfPBuEf3WLiwrlUx/gR3F2oGnV9Qrdy7SRvfw+wkFlAdoLaTIKPAXtq9pUy+UeEy2DeKKdoiCUmjX53cJ/GM2ffRYY/bSq4hSUJulFsmbJrZXdyUJdnCEpYi8PBlrt2N43Pjha4OtPw4v1PKWU3bz4zrb0lYCh1ARA8d0VhOOawgwpyC5ShA2c4PGTC3Am9tB8BpmVSuKgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pyDyIGpjY14uLZ0WUW8UgtjjI+ibZCX4LA5H/OL8FI=;
 b=wiKnfx1lImGySWl9Swt6HusDsvUH5S9uZQB5aohyRda0F+iitymjkxAVHV3FcJBTq8vFaBSo1pigjy895SA7eDTT3gg2FdgDDXAFG98TpMWuDuqNNPA5H1dylWut6xPbFFjd0veK87HMMynzM4W5zw174tfx+zsMejH6mpM9D8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by EAYPR12MB999158.namprd12.prod.outlook.com (2603:10b6:303:2c1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 14:13:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 14:13:43 +0000
Message-ID: <f98f29b2-ca6c-48e3-8742-366e6504b841@amd.com>
Date: Mon, 23 Mar 2026 15:13:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm: Update log for 'none' recovery method
To: Raag Jadav <raag.jadav@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, simona@ffwll.ch, mripard@kernel.org,
 matthew.brost@intel.com, rodrigo.vivi@intel.com, riana.tauro@intel.com,
 andrealmeid@igalia.com
References: <20260305130720.3685754-1-raag.jadav@intel.com>
 <20260305130720.3685754-3-raag.jadav@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260305130720.3685754-3-raag.jadav@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0256.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|EAYPR12MB999158:EE_
X-MS-Office365-Filtering-Correlation-Id: fe2eeda6-9976-412b-47b2-08de88e663ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: LNnRTBrX6Zj8xpoJyY9qHCSSh8MCJDJHgD1JzvoNt2hL4KEJpLG3vlUhh5aCvOeaON99y9sqPGm0HM0HoxmlfJGBnl8hDQS4uQaHVqxKkGlwnL3O36oNNH8sX0q86FKmUx9Doe1jyLPvkgaryTae0i9HxWDg56oY/Wae8OERbXpnuaMC43PgWawMXPgDp/W7lz3rBBIElsVYtGqf9hbDlRqyoPBShvEiG+Pn2qj6N5r1d4RGrWzpoIaVfuLAfpX3eCwMIp99EszrBtIv6hoo0dNiDyWJkDzO9MBwGG9zeb2oivSOG4zKCm9y+CkAwHxBBtx9BIlGUrBDYuinWCfFO4Dg3npxq1etwD2NKSM67oBancAfUX7L5SIIdZosrEx2KOr1qTlDyMVJfD81L22f4P+hi15g3qgzHdOypb7A+qVzA7ybFjFdN+aAZL6FFlMmIB/G2gVvXLM95Vl7qOPo/Tt6AW39cVFWmmDiPa012joL2E8BzoPJudrM6wRYZ7jx5mMh8r0pg2Axhb00mXbhfh7H/Uf1K29M4ItKmpF+RcrIiNfSV6VqfK1uHljh+0NzuGYqVHRtYmh8A1lCumzLVOFUaQjCjILDJ7DS4xUO+uwKzkZ2EHxHys8bwnFBaQAN06B/haRwbmb3H7k97X3V97MZM9FlTfBfipbCmTbUTtt1m7v3bZKQe6AEfB9+qng7MLGj8YeiTGTUK15AgPbh/EK7bHZIi/EvqNNlEFGzkVc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTVoVDZUZzljOVhBWlQ2U1lPRi9qVmF0U1B6RDlkdWJMSGVWS2pXOTRtY050?=
 =?utf-8?B?R1l0NFBOdmw3Z3ROenV1WVYvTUJaa3YxZ1J4NVRxZEQ4cWg0KzlkRSswbno0?=
 =?utf-8?B?eXlDWHYxMXBXSHo1VjZXMzVRZWkzZ1FoRlhEejZhOVZhQnVadlVROGF1R2tY?=
 =?utf-8?B?cEF3d3g4Y2NpL1ViQnA0M1VFUEpsL2VxWHc4amdodU5YUVRlSXZUL0NPU2d2?=
 =?utf-8?B?MzJYRWZBS3h2TVd1bjJ2d3NQeXN3MWUxalpXNnBTbWZPYUwvVG9nY0hhZjhH?=
 =?utf-8?B?ekdUQ2dHV0tkTW1qOEUwdnBPYnNPQjBlN0txaTc2TlpZelBBNmFLLzNyT3dM?=
 =?utf-8?B?ZWNxdVNoODloK0p3RkswdEVSdUtOTnFiTCtXM1pSS0FLUWtYRG5KNFJnMmtT?=
 =?utf-8?B?YTkwL3pHemZNQndCdWtIS2dDQlNORnBpNnJtVXhtTGFwUEZkbDBUcTRUMVFL?=
 =?utf-8?B?R1V3QmZ4STBZdkdDQ0R2L256NXh0eUpiWXlTRkhLZUtzNUVYQ3h2bTBKMGMy?=
 =?utf-8?B?UGk1aWN4OVhOM0NDWm5mK25XQk44U1hjR2Y4cmhXcGg3TCtTbFoxU1YzMmd3?=
 =?utf-8?B?d3pOTjVLdnBjVXlTT0IzWVB1bVFFV3V1bGMzTnM0dzF6Vjl5dDJjQkZZVi82?=
 =?utf-8?B?QjZDUXpqakkyaFB4MFliMDQrc1ZSQkdId3hTTEpIZHlKcXRPalkwNEVIUEto?=
 =?utf-8?B?emlEQW91MDdrbzZXdjVseVYwYWY0VmRHZXRZQjVTYmlhZUZteTlPY0xKcTRq?=
 =?utf-8?B?RzVvcktJQTdaWkdlaWgvZ1gxTWMxOWd4bEFveGRQQTF2UWlIMEYyenRDS1gv?=
 =?utf-8?B?QXNvdGR6UG1HdVVvNDQ1RGNhTHl2OThmeTBsamFEaTlJUEk3RzMrUzRXcHE4?=
 =?utf-8?B?TWNZaS9VeXVNQllaaEIwazhxYlFURGxscGx5a2NtVGpEWGNsOHY5ZDExUmk2?=
 =?utf-8?B?SStneTFiUHNDbzVha1NaZ0NVYmhTSXBvWm5tRnU4OUhhVytYS0JtOHp3TFVQ?=
 =?utf-8?B?VFcvVHdYZkFCUVBSQjZzcHpMdTE4WG1QWitaVWdvUHcxV1ZDQ3BLZ0JUbjhs?=
 =?utf-8?B?ZE5JMUJyeGpQZEk3MmYxa2YzRTVmTVJHZDhJUUpTZm9XeDhHOU9uOEhBSjd4?=
 =?utf-8?B?cjZqeTJrcnF0S2xQcVprSmZGZStVYlp5TnN4R2tRWW5TWCthM3l4cUNKMHpi?=
 =?utf-8?B?NjRHZHd0aXlEVlZNS2tFL0J2cFp3aUJFTDEyUFV4cWZIUFNMMU5jZVhVOTVt?=
 =?utf-8?B?eGMxaWNOcHROdHdpczlvTkZ0ZTdrbnpCajFVMGM2ZXlwTGpwVEs5Y1NSR3Rm?=
 =?utf-8?B?RnNwdmRmc0haNUlsbThqSlNzbDhPREt1MHdpRkRpcFVzN1BKSVA0Qm12bFRz?=
 =?utf-8?B?bHdFZFBmQ0k2dlRCM0M0L0JXZVdFenRRY1pjZ2I4MGtJZFgzMDBQYzV6eDRh?=
 =?utf-8?B?a0RHTUhHV2V6ZWZiM1I4R2l3amlIUWtnR3FnN1hCaHRoeVEvdkxsVVNpdDhs?=
 =?utf-8?B?RlZwVXd6Q0tNanFpeXQ3eUE3K1pSSW9VdVJ4RzQxZVNmbXlqZWZZY08rZGht?=
 =?utf-8?B?aHlyNnIzMG9oVFNSSDhWbEk1MmI0RitOTTRpUVlQTGJKdUxVeEFIUGZpM0RU?=
 =?utf-8?B?cUFsWXM5bzYreEFabXozSHAvZDdSK2FRL1hmejdoeWp2Y2hmZVdTTFF3WFlx?=
 =?utf-8?B?Rk9zTmhFL1U2eVM4Zi9PaDZ5cTBZdHd3MGM4WUJHS0lLcEV0Qmh6ZFZzZWF3?=
 =?utf-8?B?Z2lKUytmZFQwaTRXZmNpNnJRRHZvalhCbUVUb0NnZFdodVV1RXJlZ1AyLzNY?=
 =?utf-8?B?dHppUENrZEZ2N0t6dzNDOGdLSkFTNEwxUnZoc3pCcmZEV0VpZUVrdlJXVGRX?=
 =?utf-8?B?QUhNUWh5a2ZOU0VnY3U5WXZNMEtKa0JnM2FNNXp0K25PWEVKbG95b2NaeVpQ?=
 =?utf-8?B?SWF5NGFNN1llam0wcEd5UUFteDRPbk1veHJJeTREaWxjSWRNeVZ3Slg1Lzcw?=
 =?utf-8?B?RWlUd3VkUm5zS2tnR2t2L05aNm0yRVRhSHBCbE8wK1FZVC9UaFJuMGo4Y0tR?=
 =?utf-8?B?Ni9ZaXpuOWRqVWpMaEJvcHNGcXpTWWl2czhrME9VeHdDaTNFdDVSZ0RFRFFG?=
 =?utf-8?B?ZU5LZEhGQitMMjlOYk9IWXMwdSs0eE5Gay90bldtZVp4WGpTajJ2NWZNd2x2?=
 =?utf-8?B?V2cydWUrNzNoKzFVMXUyVjJibWtwUkQ4NmZSNFAvbGtJVWg5c2V0eGU2eUNU?=
 =?utf-8?B?MkpGaEtCTU8vWUR0RlFObDdEbkltMVAvTFJsNEJNTmxUQ2xicGlYeU0xb0ZY?=
 =?utf-8?Q?jEJUyhRraarDgf8Sfb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2eeda6-9976-412b-47b2-08de88e663ab
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 14:13:43.1950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Uqj8bksIsccO0hlIGnRr81ENsGlk833+yam89l+hTOYyYrXHgmZz5EwkGL0JaUM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999158
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

On 3/5/26 14:06, Raag Jadav wrote:
> Update log for 'none' recovery method for wedged event where driver wants
> to hint "no recovery" without resetting the device from driver context.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/drm_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 2915118436ce..72e7e09225c7 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -586,7 +586,7 @@ int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
>  		snprintf(event_string, sizeof(event_string), "%s", "WEDGED=unknown");
>  
>  	drm_info(dev, "device wedged, %s\n", method == DRM_WEDGE_RECOVERY_NONE ?
> -		 "but recovered through reset" : "needs recovery");
> +		 "but no recovery needed" : "needs recovery");
>  
>  	if (info && (info->comm[0] != '\0') && (info->pid >= 0)) {
>  		snprintf(pid_string, sizeof(pid_string), "PID=%u", info->pid);

