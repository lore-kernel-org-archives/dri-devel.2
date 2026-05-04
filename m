Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2283CD342F
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 21:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D2BB10E0DE;
	Mon,  4 May 2026 21:51:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NjddVdGr";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013010.outbound.protection.outlook.com
 [40.107.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FC6910E0DE;
 Mon,  4 May 2026 21:51:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUxnu/5eGHjR4aH/ZmKXCbhiWY8xUogxLIC2UHQ0kPl6CJ7IDo0Frb/9ERAKLrMFlxizcNTYgYvuWnIHc8MUQGR43CsLrx69byUeCo/yMda2hBmATswD9ctpjOg+d4oBxxMaPx2WKApPWNqmR6JPc3lpVXRioZxHxUf77Q+9NQjeVBoYJrjLYa10hH0XrbqtVNW47vp239KLJ64nYX28TZtdCqXbnt5O8t3wZijTidq/ZGpc20GJNDsR/6e0tCPTL69DLZ9ruQc0dlLqFxeLieLyrqoTc2qmxuW3maIksAcsvd73OleQ+Ip/qpujz484wEbNDjeTCZdNalr+S+46hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11ns4XcENI15qBmkTisQoRxlFWR7MjQ8Lii7YGnC1Bc=;
 b=VV1kqcZ4PS/FSKBEfu2j6KaXh64+qVR1ZKFmkm4T2NQyczlijdEatMJeXDK0/sd8Ngx/OVJkx4f6cr+p8bjFJCFlwSKlg06BA1hpza4JmGRwRqUPtGy3ljGs57AaHYOwxc9xGpSjlOO5+K75uT26tKZIuu7kuRQg/o0SL3hfLy88afJKiuEvWzJj2xJx0aMIMaUoqatr3CZ8HHhO0KPdZt8l4nlFZYTIUgTMv0WrU/ow4GLwuuy4DaZmpFyO44zfNu1GR/j4KFrOFlspOrpLw+XS8PYDFLqp9dfo47OEatTpTn9yAE40knd4zfGUfZ5qa0WuToglGiO8St/zK+lVfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11ns4XcENI15qBmkTisQoRxlFWR7MjQ8Lii7YGnC1Bc=;
 b=NjddVdGrnpjrKseoC7axetdvXLPx2HfiImWj4u5zQwXgjMqO5OWsGrgeCDy0OGk/EcNnTCt02CRr4XK3YVzlF38yuI+begqGwYJ01ivuhm1LN1f4yG07eP10GDGJvTAW6VADXAYSlvAfX1V+QCOPODgCxUN5X7lLdrnOmMOJFjQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 21:51:32 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 21:51:32 +0000
Message-ID: <1fc38ad0-3d33-44f0-a1a6-f78f7b4776cf@amd.com>
Date: Mon, 4 May 2026 16:51:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] drm/amd/display: add DMU timeout recovery support
Content-Language: en-US
To: Hamza Mahfooz <someguy@effective-light.com>,
 dri-devel@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Hung <alex.hung@amd.com>, Ray Wu <ray.wu@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Ivan Lipski <ivan.lipski@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>, Yussuf Khalil
 <dev@pp3345.net>, Tom Chung <chiahsuan.chung@amd.com>,
 Colin Ian King <colin.i.king@gmail.com>, Charlene Liu
 <charlene.liu@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260501203552.749080-1-someguy@effective-light.com>
 <20260501203552.749080-2-someguy@effective-light.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260501203552.749080-2-someguy@effective-light.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0183.namprd03.prod.outlook.com
 (2603:10b6:408:f9::8) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CY5PR12MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: 02059c95-d317-42a5-d4bd-08deaa274daa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: OqY7BMa7inxYWMWZN0g++/lgXtlIchB3aAkQkyPIHnOip91dn+yRlZ5zMXRoQ+Q/LnQq4yNTdM1HR+RNe3EDamTfZn7iPLWidqw6N3FYR+ONoJBxuNzXS6XzlvrQ8t17YB8gsGfo4Cj6dOJdgugLashk0dKPVAKtbkBkWrX2osu1rwM7TaY+WZPXMDsdO0nqzat0ENanz6rAH4KeYInbxSLxEW49i4PMVZLSk1tPhiXAPkIB9ZrCMjx74xJrViuwtxB1DBmZpssQjOyBqc+8TfaX7/7kw1j2D0b2GcF6UDqfheZfunKaFaXieV4WQUG7PX6SrNpIftGslNrTGPvcUO+x7K1nOCSiw1DK4U+/uEx+DE4GB/C2m1Gy26LjlcbzDILm1nbqaAN+KVWPFzbokZHNaAqgI/UW0lKelwDyMeDvvx0Gr/Ri5LBgbo+eVJ1lN1cDYKZTtTcsX6t9sxTN2EKpP8z2iQ9+KYq50lH8FSjPenCj2bvz24j7gYDFT2TngbQKvRzRmYZSF6D9ZMuAEyiQmiUROwndZeQhS1+VJJ89zTsFi9E6MqEgz15DCIvj/URmd3V3Z3Xt+6iId+pitxl77jEIIPWCKRyib5wNzfG3L9RFqJuYSvFq2MUDw0flhgyRvNYta6qpJZvMJnPd1joNbatjWN6eHZVHEjhbn5WLzeR33GBqLBSHiBZuOpX3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVNQMzFGS2R1d2RnaWNsNFpyOW9CQmVwd2wyUHY5MVFCbm9iREdId1dTZVlU?=
 =?utf-8?B?ekdyQ2tzM2N5R2tUQW9CMEtZdGo4aUN0MXBIRkRFaFF4R1M0L0NVQUVxYWkw?=
 =?utf-8?B?MmZTSEw3dDRUUU9EMCtNZUFtWW9jY3kzVmJDUnhRODRtWURINVh3RDhpaFpK?=
 =?utf-8?B?QjFmdmdvOXgvMndNSDhSMXBaQVZOcFFXTERrd2hpc1o4dnVZWjdwVjllaWs0?=
 =?utf-8?B?cFpZMFJEMXJ3cmtPcGFxTWlRbjdKdTcxUC9ncFRHT05DczBwSXBjZ2x6ZENo?=
 =?utf-8?B?RGtGUWl1RGRKUkxSZHhLUWlYUXZ0Q2F4LzZTS0VuZmpXV1luZklQdmE3UlJQ?=
 =?utf-8?B?ZlJRNWl6eVpIakx6NVB2YWpMZVFkdUxRQWZuK3dMRHRsbVZTM2MyNzJuV2ZR?=
 =?utf-8?B?dERpMjdhaUFwTmY3aTVJRi9DY3RRRW9HK1ZPM1ZOTmt1RDRwWHBpYUsvRnRR?=
 =?utf-8?B?VUYwSFNHUEg1cHBxczcycm5jelplSXc2ZSsvNDZQUlRlUjdEdURHU1NzMFhL?=
 =?utf-8?B?RktzbHphVXZjR0JiOXVqWktNcGFCb0JqZnR1L21UbUsrN3dWeStvT05TdzQy?=
 =?utf-8?B?WGNSaTlTMm94amI4YnRJN3NKSExvbUN3WmNpa3g4aVVjcDRmRGt3aU9DRTl3?=
 =?utf-8?B?a2tLbjZIQUhnbm9YSjBHZHhjUGNUSWlVd1hUZWxIa2Uxa3VpWE1VR01ybVVI?=
 =?utf-8?B?dlc0QUdidUVibWlXWTNObnkxQjdkSEhWc3hYbmVocW9xZkFYNUtZSXI2VjU0?=
 =?utf-8?B?TkZEMFhBOVR6QXZTVWVRVFduUDJoMm5hano1WXFOaHFsR1N3c3ZQRjFwTTg0?=
 =?utf-8?B?NlIxUkJZZWZ3bXNtNUNjNEoxbzhkQlYzM2llbE9NazJVVTkrK0pHYjJrdkNq?=
 =?utf-8?B?ekh0OGFuQTlvQXhiU2NMN1pybFZKWmh3cmFkZ3MwZms5ckNDMnFrenBwQjZ0?=
 =?utf-8?B?cWtDdjN3L1lwSnJUQW94cHBkOUMxRlV6Mnh6aUxTZUFZSXplUWVQcmtBN1dw?=
 =?utf-8?B?ZG5wbm9PbVNHZXpZRWlSU05mZXpJU1JnbDM5RmtCZk1RdU9sTVNVU3d2ZVhy?=
 =?utf-8?B?bTMvVnhlUzFWSktmZTcrMmM5VHhSQnl0NGdHM3BFUjJ5NUJCTUt3SE8rZlhL?=
 =?utf-8?B?MkZ5ajg1T1BSUU9zVDFnWTVXK2tJSDV1RDkvL2JZS0IxbFpJUzFkYTl2TnVH?=
 =?utf-8?B?N1dtd0tMdXBvUUFscDRtUU1Rd1JRUWN3anNTanR1c1lJM1JpM200Zjh6YzFG?=
 =?utf-8?B?YkdnTzFoeTlnT0IwVnVFMFV5N1lSdGxKTDBiOGN6cnZ5dWlYU1dmempUU1dM?=
 =?utf-8?B?d2EwVXVGMXJpbmI5OC9RdDhuNlZTT1MxWkliWmZMWkdFc1dWUXVYZ3grRzhR?=
 =?utf-8?B?aG9sWVJ1RDB3TGN4MWJsVTZIbGpFNlAvb0NpdTlxZ3E0MGFDYUlyd1k5NTFR?=
 =?utf-8?B?LzlHaDlleTNzODQrS29pdDNnK3dkOVRuNk5TeTFmMXI2N3ltVXllZUVFaGhL?=
 =?utf-8?B?Qi9QUXIwUUtMWlBzSWQxMDJSTGlvRnBiM0RDeGhhUDNoOXhUVEpmbVVKZjhz?=
 =?utf-8?B?TDRjUVNXblRlSnIzaGJBdWdET1ZDSkhrNm13eDRiUkxRaDYxYS9RdlgwZWl2?=
 =?utf-8?B?VXF1TUZDc0RScmZWRVhnWUxSMWVuZmxZbjgrUzdEWTI1elVOOEJRTW1YZXUv?=
 =?utf-8?B?NGJvQlZNcXQzcEpVZHJIZnkxdG1IM2UzTHlnR1dCTEdqbDVxUUQ0SVpsTHhI?=
 =?utf-8?B?enFzTEdpdTkxTUlvaXFKRFlXZHkvZmFzbVNKMGorejRsSFB5dE1IK1ZOdVJv?=
 =?utf-8?B?K0VNbG5QT0hidStHOGRMWnN4Yzk5VkNKWlJ6Yno5WUxpbmV2WWpHSDZ0VmhP?=
 =?utf-8?B?WWFraFNqbHdhcVFLNTJpR3U0TmxqVHZRV2hVQkVRaGNkWlVnV1dnVVlacXUw?=
 =?utf-8?B?YTNkVDJ3M1dHdEIveFIrYkMzZ2ZzK0xZdTFDVVpvZEF4V3VoK2UyRDJnaFJY?=
 =?utf-8?B?U1dibjlKdFZtRDVwZ3pSaGZ0Um5FSkw3RkVOQitrZU1iOENyVnY1TjhHL0Vs?=
 =?utf-8?B?OEF1U1JIdDZSNXFneUI5RWFFajFnSkxsUm9rQzAybnhRTzFUSEppU0UvR0dN?=
 =?utf-8?B?a25NdXIvZkNlKzhJd2x3VUxtUEhtY1RMT0ZJTkxyQm02VkRqZzJrelMrbVhz?=
 =?utf-8?B?ZklndDUvMkdRUUdPV093VmtJVG0wRXY1K0RlS3hVeGVjeGE5YXB3ZS9HQmZu?=
 =?utf-8?B?RU9PU0ljK08rVldoRDFwWG1KLzhJU0M2cWF6K3NIWEYyUFZyQWJxeHJiUERo?=
 =?utf-8?B?VG9idjBwWmdPcXMyOTk5UnZ0WFUyUEhpZWQySTloMFNMQ3RlS0Exdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02059c95-d317-42a5-d4bd-08deaa274daa
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 21:51:31.8087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CyyNADR+HzZSoplphTdssvuy5GaiVxK0bP8TJE96FCXIFMmddLQ3xsbOc6JOtaucYPQTsrL2vu2Y3Sy0gmzVKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057
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



On 5/1/26 15:35, Hamza Mahfooz wrote:
> DMU already has robust hung state tracking, but timeout recovery
> was never hooked up, so do so now.
> 
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

I think this is a reasonable approach.  But Leo should sign off on it to 
go forward.

> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 ++++++++++++++-----
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
>   .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 12 ++++++++--
>   3 files changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e96a12ff2d31..7be4ebee1cb7 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1246,7 +1246,7 @@ static  void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int pin)
>   	}
>   }
>   
> -static int dm_dmub_hw_init(struct amdgpu_device *adev)
> +int amdgpu_dm_dmub_hw_init(struct amdgpu_device *adev)
>   {
>   	const struct dmcub_firmware_header_v1_0 *hdr;
>   	struct dmub_srv *dmub_srv = adev->dm.dmub_srv;
> @@ -1315,7 +1315,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
>   	/* if adev->firmware.load_type == AMDGPU_FW_LOAD_PSP,
>   	 * amdgpu_ucode_init_single_fw will load dmub firmware
>   	 * fw_inst_const part to cw0; otherwise, the firmware back door load
> -	 * will be done by dm_dmub_hw_init
> +	 * will be done by amdgpu_dm_dmub_hw_init().
>   	 */
>   	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
>   		memcpy(fb_info->fb[DMUB_WINDOW_0_INST_CONST].cpu_addr, fw_inst_const,
> @@ -1457,7 +1457,7 @@ static void dm_dmub_hw_resume(struct amdgpu_device *adev)
>   			drm_warn(adev_to_drm(adev), "Wait for DMUB auto-load failed: %d\n", status);
>   	} else {
>   		/* Perform the full hardware initialization. */
> -		r = dm_dmub_hw_init(adev);
> +		r = amdgpu_dm_dmub_hw_init(adev);
>   		if (r)
>   			drm_err(adev_to_drm(adev), "DMUB interface failed to initialize: status=%d\n", r);
>   	}
> @@ -2041,6 +2041,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   		goto error;
>   	}
>   
> +	adev->dm.dc->debug.enable_dmu_recovery =
> +		amdgpu_device_should_recover_gpu(adev);
> +
>   	if (amdgpu_dc_debug_mask & DC_DISABLE_PIPE_SPLIT) {
>   		adev->dm.dc->debug.force_single_disp_pipe_split = false;
>   		adev->dm.dc->debug.pipe_split_policy = MPC_SPLIT_AVOID;
> @@ -2090,7 +2093,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   	if (adev->dm.dc->caps.dp_hdmi21_pcon_support)
>   		drm_info(adev_to_drm(adev), "DP-HDMI FRL PCON supported\n");
>   
> -	r = dm_dmub_hw_init(adev);
> +	r = amdgpu_dm_dmub_hw_init(adev);
>   	if (r) {
>   		drm_err(adev_to_drm(adev), "DMUB interface failed to initialize: status=%d\n", r);
>   		goto error;
> @@ -3604,7 +3607,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
>   		 */
>   		link_enc_cfg_copy(adev->dm.dc->current_state, dc_state);
>   
> -		r = dm_dmub_hw_init(adev);
> +		r = amdgpu_dm_dmub_hw_init(adev);
>   		if (r) {
>   			drm_err(adev_to_drm(adev), "DMUB interface failed to initialize: status=%d\n", r);
>   			return r;
> @@ -9623,7 +9626,15 @@ static void prepare_flip_isr(struct amdgpu_crtc *acrtc)
>   {
>   
>   	assert_spin_locked(&acrtc->base.dev->event_lock);
> -	WARN_ON(acrtc->event);
> +
> +	/*
> +	 * Compositors will refuse to make forward progress unless we send
> +	 * the previous flip's completion event.
> +	 */
> +	if (WARN_ON(acrtc->event)) {
> +		drm_crtc_send_vblank_event(&acrtc->base, acrtc->event);
> +		drm_crtc_vblank_put(&acrtc->base);
> +	}
>   
>   	acrtc->event = acrtc->base.state->event;
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 74a8fe1a1999..dc808ee83c2a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -1086,6 +1086,7 @@ int amdgpu_dm_verify_lut3d_size(struct amdgpu_device *adev,
>   #define MAX_COLOR_LEGACY_LUT_ENTRIES 256
>   
>   void amdgpu_dm_init_color_mod(void);
> +int amdgpu_dm_dmub_hw_init(struct amdgpu_device *adev);
>   int amdgpu_dm_create_color_properties(struct amdgpu_device *adev);
>   int amdgpu_dm_verify_lut_sizes(const struct drm_crtc_state *crtc_state);
>   int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 3b8ae7798a93..8f10117483e2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -33,6 +33,7 @@
>   #include <drm/drm_atomic.h>
>   #include <drm/drm_probe_helper.h>
>   #include <drm/amdgpu_drm.h>
> +#include <drm/drm_drv.h>
>   #include <drm/drm_edid.h>
>   #include <drm/drm_fixed.h>
>   
> @@ -1165,8 +1166,15 @@ void dm_set_dcn_clocks(struct dc_context *ctx, struct dc_clocks *clks)
>   
>   void dm_helpers_dmu_timeout(struct dc_context *ctx)
>   {
> -	// TODO:
> -	//amdgpu_device_gpu_recover(dc_context->driver-context, NULL);
> +	struct amdgpu_device *adev = ctx->driver_context;
> +
> +	lockdep_assert_held(&adev->dm.dc_lock);
> +
> +	drm_info(adev_to_drm(adev), "attempting firmware reset\n");
> +	if (amdgpu_dm_dmub_hw_init(adev))
> +		drm_dev_wedged_event(adev_to_drm(adev),
> +				     DRM_WEDGE_RECOVERY_REBIND |
> +				     DRM_WEDGE_RECOVERY_BUS_RESET, NULL);
>   }
>   
>   void dm_helpers_smu_timeout(struct dc_context *ctx, unsigned int msg_id, unsigned int param, unsigned int timeout_us)

