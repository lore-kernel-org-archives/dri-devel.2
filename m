Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78403C55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 08:34:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B17210E1BD;
	Wed,  5 Aug 2026 08:34:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DiH0xj7V";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54DF710ED78;
 Wed,  5 Aug 2026 08:34:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EE/g2zqMCb6FTDVb2a5FSoRLjvR9cijzN4WgYvSj96JqdZf1fT074VI+YfvQZbRETWIkGzdmxTkJy9zkta6RWRVtNEqOC6OKh0fVMltUzyTTQiLGky4c43PFycFCShFNveN9uVmw9nq944cfddlnGF6JcFRMCznxJa/0qBl1cMU/3Pw22G2qE9+0kuyW8dujgIHNS6sXhR/ODjqseIAvzbKfT9gFaiMg10rmnf8529uiy7uEnIxosKnHvnv0e0CiY6BWXHp4W/8QT+0wF+HrRMAUBaUqoIuM4YnBgOj7OmHm96RbN1CsICl2dTlRXvVI8ItYVxyH6N+FKzIH3w+N3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IF7VK1CRSdSA6D8Xoy7beA3IuG4XL5sd9Z54NcjPS/A=;
 b=XZDJ6l+cqHhfxQWJruV8gsL0WDUJIQGVg4y4wW/XKlY8jivVkAgADWCZ+H32yQjlFOLnHXjTvYN/I/KmQBUzN/6xIkJQKrFR+Glrm43+cbuyRknIj244pAWnB7AMH6SjMR/acHhzBQML6cDc3JmphujHr9PHUttxWZYDV1mQ7F3ObT52jg1bVqhx5M3w4tqlZUeLt6T8vbcJ/4LBOZyLzgmGLuHajSy6sm2qFmeILFiwMpilglYsLaonsjB4zoaw9Qrk8yg5kflP2GUg2zyncyCY4AFc6voD2xC9OTmHYzrdWxvEwVfAjuk1je4/AK7R0aDZCrlx3hdMlVHHqjEr9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IF7VK1CRSdSA6D8Xoy7beA3IuG4XL5sd9Z54NcjPS/A=;
 b=DiH0xj7VwF3+fATk80GFFx4v2LjA7daHOR7aVpD3levLCHz4Qq2HSdkk/rIooRATaSIm8Cb2jXluGhxmWy888lshjbyT4jbNcPaAPHr6Jn3Juw5cgElbgzQeJmb/MaOJjgLRhTe31y0/pHUKzJChU3DZNbprtwtyP74vb6u46pQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 08:34:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 08:34:40 +0000
Message-ID: <baa434d9-e0a9-482d-a071-42d204b82126@amd.com>
Date: Wed, 5 Aug 2026 10:34:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/radeon: restore hardware polling in fence_is_signaled
 to fix performance regression
To: 2564278112@qq.com, alexander.deucher@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Wang Jiang <jiangwang@kylinos.cn>, Philipp Stanner <phasta@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <tencent_BB2A7CAE632BA0AC08D9296E78A15786200A@qq.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <tencent_BB2A7CAE632BA0AC08D9296E78A15786200A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR20CA0055.namprd20.prod.outlook.com
 (2603:10b6:208:235::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 6825c8ac-623f-404c-3ea0-08def2cc640a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DxSG92ZkzKq5uLEffhgZ/fSVLfXTpwkSTs5kzHHCChqUEZPp9idIgelyLoYCyCGa8dV8vZtQp/dW74oRUlBRucq/LcvIVbjcw37d2pQ2qcha2Ccxe7Sb8H/WLXM+h9KnIzmp4wBpJOhjWz1OjDkNemcgKgbN0kQSHyc9gIhzPEVN6s4j17rtFL/12FBOhHcbO/qmAbcsOOrmVZQdhScG3hE2gg/ykvXS3uqJVz25JfgUwqJ2Ac9d6Fhiv4RdM9y+nWIruEmfk+CuuAD+PzzwtlcxjpIHc0nvp6EhuqKPwyZ5iVnzpjDBJYeBpuqgWaESKkbD8gH1g0bSMH/g60E4h8KKF5A6B1IAwO8RaU9VTkQl5CKRpmASOUHSnyxGP89fFQYshTe6DCAL/QXVvRyDCYoJ7+Ekct/hD0ZDxQ+lPTh/9mCzt3dt1DMKOYPHDmB0TkMyyAVszj2X9f3gRKkpe5smYU0LIBLb4lNQdMyWvhRSE5YrUK3Pm2ijV2/zZIFfzjk+TErvSUZFkll7oLQ46P8PRZHD66yE7cy0isYbmpf9hN7GP40GLtjlFLBrdz+gmlj3AAQ7KsK1UF7GrD+bK9UKEBZMZTCW+6T7kxvOqmU67ZO0f3OkhJsuSZ53JNEOGwi/1s0zjAeNZrLQbsNK8SFFyP4t7ycErWTjCh37FAw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mnc5THNnT0pxaVBBOUFCR3hON3BCaVRQeXVKMlBIQmVHOVYxRzUySzVtOHNJ?=
 =?utf-8?B?QjVTVlZtZ2V3Qm5Mang4a0lxSHlTQTBEcFNTanNsdXBlSVFWaHBzc0hmYVJT?=
 =?utf-8?B?NHo4Z1pybUE2WkRFSXo1OE45NWxhb2t0WUVONVpaT1NEdjlNUDgrUUNGS3dx?=
 =?utf-8?B?ZTJyWVNIY1FmajRsRkl2bTE5Tmw5bHA5TkNkZzd1S0MvYVNKYVpLYU1KTWgr?=
 =?utf-8?B?ZlZnNE1lZHhxMXlyOVRPVGFwMGppQ3hpaS9Fd0hvN2d6NjZyM0RzZjJ4blRn?=
 =?utf-8?B?R0tIU2NQcFZ6UG1qOVF1M2ZIYlpuS0V6cTZzQmRIMzArb3Z6NVRsT2xNbFBQ?=
 =?utf-8?B?OWFObVNibTA2N0I2bXFrWkk0TDJJaWM1eFd2NmtrVkoyTjAwVkdnMG9jclZH?=
 =?utf-8?B?YkRkVWhOdzhUT0NVRWtqTlp2Ymo0bnRhV0NIbGZpSFdHdlM5cjd6UUZvUEtP?=
 =?utf-8?B?b1JZb0d5amdtQmQ5VHJXRUNGeWF0Q2ZJWmJtQ3FvZWc1eklWakhYTmZsWGdO?=
 =?utf-8?B?YVZtekFlL3JKcmRXbDZ5c21nNmRPdzBud2pFdVhobTRrR3ZNK0duM0tyWTA1?=
 =?utf-8?B?ZklDcmNNVWR4Z3RzTGFBclpOVUhuSGlobkJCMzJDYkh1NnJ5emZmSisrcElL?=
 =?utf-8?B?Nk1rZVhYV2wzYnRZbVc5d2NGOEdtTzNFblJQRjk2bnF2KzVnWi95SnBhR1Nv?=
 =?utf-8?B?RW5pNVlFWlA2ZXZlQmw5Qk5jekJ6QWxObEFnbTU0OFpaUzhZRVdwbWNWQkR0?=
 =?utf-8?B?VXpZYzBUSlZXT0RlbWtkZzRQSWFkOGZsNisvajlpRXRkL3I4UWtzdkVnakRO?=
 =?utf-8?B?UGdDbXhDOWFHQXJURUoxRlduZS9lbmlVYlhsR2QvZ3Q4Nk9yNkFNUGVxQ2lD?=
 =?utf-8?B?Q0dZV2JMM0VmLzI5YmdmVW1YZWZ1NmtTWGZvODVrT3l3bjlDVDVYV3lQNjhH?=
 =?utf-8?B?Sm1QQ01neG5HRHJJb3NMYzBRYTVnTTFvZDYxQzNDT2xZbnNWWDBCN3k4dTdT?=
 =?utf-8?B?KzhXZ2VvRWdoWWFDWHk4WktmOGZGNjU0QUN5My91UFJ4MDhvSFFoWkN1YkYx?=
 =?utf-8?B?dE00aWVoUG5NNHdRQmFRNGJxcW1TK212bVdpUGVKZjc4TXpvVGc5ZHpOOFV6?=
 =?utf-8?B?V3BEejJabjVyRmhzc0kvTGROU2p3RHJzcC9iT3NyU2J6TTNwb3U2TldEdk5S?=
 =?utf-8?B?eVY4WWVBdTQ2WFZ6bVZTL2hOVHpQL2pEOW9aNGVzbjVQbGdBc1owWXpqbkM5?=
 =?utf-8?B?M0k4NnN2NTVJQUE1L0lrd3RLV0ZRQUNtbTVteGNPMzlBbmlrajRzTkt3Qklx?=
 =?utf-8?B?R2x3TEY4dEJRYVFaUVFjTjF5Y0o5QXY2d283V1Yrdko2cGdvVXlUYWpWRXNi?=
 =?utf-8?B?UmJvQTFrdXpaODU0V3ZLK1dYMUJsYlNlSEoybHRPbTdvcmkyRm1HR0d0QXhl?=
 =?utf-8?B?YVNGY2FXNzlTa3BZWVl6YzJ3UzM3bkdWWFlBT2tpdUFPR25NaVMyamRCV2Vz?=
 =?utf-8?B?WUNBWFVUUGVQdjVTVlJVTG1URVk2dFZoL0N0RjUxYXU4UjhaRmZMWmRNZDAw?=
 =?utf-8?B?MGpWYWdadjFBdTJ6Si9rWU12VlNEU2xBOU5sb09EdUdHNXJwRnkyUWtYT3hi?=
 =?utf-8?B?YlpaUUpjTy9kc0xzN1ErdnB1Tk1kZjdpU1FJSHNiblVJTGs2dHY1S1l6WXpn?=
 =?utf-8?B?SE1HNGoyb05nYVI5dEVMaGw3Nk00Ni9pMmZBdWtzenhnT3Q2UUdjemNGRFBU?=
 =?utf-8?B?WHBtS2tBeEJPcDJjSzhFWHRhd2tKYTVJbVZiaFpKR0svZDlYTk9rcDhFOTRm?=
 =?utf-8?B?UDV5VHhlU0hVUlJYVWNGNG4vNzJ4LzFZYVBlMytkNU1pYzdNZG9sTzYwbW03?=
 =?utf-8?B?eGhTTDFQdDVRNUx2WHpwTUx4b0drcmV6OEpRdE1JWXJEc0tHSDBseVVYcCtm?=
 =?utf-8?B?OEp2V1RXN251MERyVHN1YkR0ZXg2bURQekJkNmUrT2djZUN1VC9RWnF5NE55?=
 =?utf-8?B?bFBHYVRtY3QwdHBLSWVMY0hIeC94V2tPZ2gzRkRBUHkwdURhRko0R29hQUxa?=
 =?utf-8?B?WUhyWlpsd0RMOUNXVnVrcWlSS2Q5QWlpclVkamJJdnp4bG44SG5NU0F5MFM1?=
 =?utf-8?B?Y3VYV1ZNUjd4eHFHTDVxWHVwMmdvdWxML1JMOFNIdm5NbkkrSXA5L3R4VHRU?=
 =?utf-8?B?UEdFZVUwYk9GL2dVWEZEMXVLUERQelJYTlphTVU2Mk9zZ0dSN0hxVUxIeEti?=
 =?utf-8?B?UFNON2JPQVhUUG1heEZoeTlxQ2psVFNqeG9PYm0rM2YvMmNDTkpoYXF3Zk51?=
 =?utf-8?Q?3RnT+s8Vp++PQXMnG6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6825c8ac-623f-404c-3ea0-08def2cc640a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 08:34:40.2080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xbMKOunBksK4MGRSGQXxkACulbmf36wRUs3ZHHLH/NnD63/LyU3LyXk83vhwZdY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7495
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

On 7/29/26 12:26, 2564278112@qq.com wrote:
> From: Wang Jiang <jiangwang@kylinos.cn>
> 
> Commit 9eb00b5f5697b ("drm/radeon: delete radeon_fence_process in
> is_signaled, no deadlock") removed the hardware polling from
> radeon_fence_is_signaled() to fix a self-deadlock caused by
> wake_up_all(&rdev->fence_queue) being called with the fence queue
> lock held.
> 
> However, removing the polling entirely causes significant performance
> regression (e.g. glxgears FPS drop) because the fence signaled check
> becomes purely passive — it only reads the cached last_seq without
> probing the GPU, so completed GPU work is not detected in time,
> causing unnecessary CPU stalls in sync-heavy workloads.
> 
> Fix this by calling radeon_fence_activity() directly instead of
> radeon_fence_process(). radeon_fence_activity() reads the hardware
> fence counter and updates last_seq via atomic ops without calling
> wake_up_all(), thus avoiding the deadlock while restoring timely
> fence detection.

Yeah I already feared that removing this in commit 9eb00b5f5697b could cause issues.

Adding Philip and Danilo since we recently had a discussion about the necessity of this.
> Fixes: 9eb00b5f5697b ("drm/radeon: delete radeon_fence_process in is_signaled, no deadlock")
> Signed-off-by: Wang Jiang <jiangwang@kylinos.cn>

As far as I remember the radeon code the solution should work, but I don't have time to double check.

Acked-by: Christian König <christian.koenig@amd.com>

Thanks,
Christian.

> ---
>  drivers/gpu/drm/radeon/radeon_fence.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
> index 02a40e4750c7..299865569252 100644
> --- a/drivers/gpu/drm/radeon/radeon_fence.c
> +++ b/drivers/gpu/drm/radeon/radeon_fence.c
> @@ -360,6 +360,13 @@ static bool radeon_fence_is_signaled(struct dma_fence *f)
>         if (atomic64_read(&rdev->fence_drv[ring].last_seq) >= seq)
>                 return true;
> 
> +       if (down_read_trylock(&rdev->exclusive_lock)) {
> +               radeon_fence_activity(rdev, ring);
> +               up_read(&rdev->exclusive_lock);
> +
> +               if (atomic64_read(&rdev->fence_drv[ring].last_seq) >= seq)
> +                       return true;
> +       }
>         return false;
>  }
> 
> --
> 2.25.1
> 

