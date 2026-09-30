Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02A7CA5FC1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 20:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DDD310E7B7;
	Wed, 30 Sep 2026 20:23:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jqkZIfSv";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 184A710E0E6;
 Wed, 30 Sep 2026 20:23:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3QTbNRl19pUCwscrQOJMaWc2quDZGPuRE0AVid9D2VlQJyb6ojvYM4R0M/KEGgEawdss/Td2JCSuHyrEJVbKXDcACFBn5qMaq1lCXtW2PAPFwwg2C/755HkccO7ThJHmeqhFYkD63xrNlN/WrF78WYp7advTdR7TatbP/WISzD/D/u+kZZNxUo7JVHBSFHkRdObkQX2XlKrh60XXyzA61zdrv/QLMYGd/meRlqVGs/q3gxFo6eOZzwwPo+wQgN/HSry96c/PdziErVShUCGJDFOv0aI2QXq9bBRpYy+s2vrD/vtxjpUXCMEAX9WOCG85bI/n1yQAytnGfuhL/nfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Gj+INULE9nl2GH9ztnQnKZbZpZmqz1qWfAEtrWFKCQ=;
 b=eE8gAVdJndK/rXqVEsM1rDl22pI+lk3AMtnQOnzebuLEPrGhjuYxvkhbQ9aRisjH4YvIkX1IzvA3YT8cVDAcX3BrFCye2wdAZ+etiWhUT/oMysZ9SCdQkIAfIakLq76NgyLhhHCpgVcTpw3O+K7zInrlZkqPggP0Eg9qLKFFO+V+GzcyF69s94AIxccuVIZA5YTD0JSy2WmLHG/uJBeSDH59fYWMjYsPz5qqdOvTWxF10mVF8zmkz7UKZNRmUqLrdajV8QbHYdmXpa8y5QzmsykZRePmnLJW4F27KceHZmo/WsMRQW/A3piv9mUnsMXqne2RiuszjalzEBmzSNtOwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Gj+INULE9nl2GH9ztnQnKZbZpZmqz1qWfAEtrWFKCQ=;
 b=jqkZIfSvh9Mw04zu1Y9JSDW8ems4yOxYWdWP0Lq/cMTp1ueUlIqO1QIatFGPxfyF76O4gRzWDblqg0+cWc706F72VLYLP3FGZfVsuIA9ceDEVBARzEYSDqifdgA/7dq45eiqT7uFRCGDl6tnnGXG1H5pJIJsxeNvX2R2I2cMRWM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by EAYPR12MB923140.namprd12.prod.outlook.com (2603:10b6:303:2fd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 20:23:18 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 20:23:18 +0000
Message-ID: <17e7178a-e5d0-4a3a-b8a5-10255fca2a33@amd.com>
Date: Wed, 30 Sep 2026 16:23:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/11] drm/amd/display: distinguish colorop setup error
 from no colorop support
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, alex.hung@amd.com, aurabindo.pillai@amd.com,
 christian.koenig@amd.com, contact@emersion.fr, daniels@collabora.com,
 louis.chauvet@bootlin.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, sebastian.wick@redhat.com, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260811171011.184964-1-mwen@igalia.com>
 <20260811171011.184964-12-mwen@igalia.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260811171011.184964-12-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0388.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::29) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|EAYPR12MB923140:EE_
X-MS-Office365-Filtering-Correlation-Id: f7bf50a2-8e6b-4f6d-8971-08df1f30aa05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|23010399003|10067099003|56012099006|260925021911599003|260925022911599003|260925021311599003|4143699003|921020|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fvsTIElWMK/jH/bhNqjJaVUSkNlX8dQZmEzs91RFcoaKDf3eHImsTOSbK0tCiWp9Wp9K0M7FvA5IMik0Mm0xAHDe3Ovd2x5cFVM+LLz0qIaPdAObXTFqrhDty/HzWJW/Yy9VTtyFWIdSiFHh4Jrb8z7jMa3NkixU7CJStuwXeom/nc6axcrz5EQ2esrefvKftxaQdL1dd3wvI+UP9vFiUhaUatWvQtfUFH2QzKlDoUf45MhxbSMVQ91x+RDXgr5z7JZ4zQAxerKa0MGMQyBQaAuEycnC6pN1dVxrGKLje04jNnB+VT+DUCunXN5h14FvXtXWfsP7Pgxos32/W21eiLy/Rg17sSz9/JjcOAmaCeJK7lVJctTPP8euiUtEdvlyNN3dYfLkt7xwrU5puZfltQr8ZtSIVcZA1bkiCutQcPwf9sd5UGlkGiNUEvpOPkb8szFOk/11WC1jlMlV2YBfz1NR8UcRdTsYntEtRQrS0kvq9lU/Ft9HH1Cwxv3rY/hom5hP0E2nqOU7bJ97WrsW5naV3gGfS6fzLKt11J9f/zaf/AESxfw/DdGOrJoMphHzhCGLST2E8t6S7UtAS0l2RazY0I19jfLJDjD0y66K+qbaK++XOd9WG9c7CWHbB+3kt9ZrdHy2CmlahYiuVD0C6fp/+ibQw02tMiUSioA+/sdOSpQtFE9NFBmZbR+XaXSxX8iZCMwNTa45kakNzCKPOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(10067099003)(56012099006)(260925021911599003)(260925022911599003)(260925021311599003)(4143699003)(921020)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1VNWFc5Z2FoR3ltM0RybzhKMC9kbUZKbGNoUzg5ZzVzYUtQcVhWQVFMcDl1?=
 =?utf-8?B?TlZ4NzQ4NTRIdXBWTjdrVUxPUGl1MXJFcEdQVk5pUEx3MitnN2JMMlp1WUdN?=
 =?utf-8?B?ZDF0dmszbmwxWUxxcmhqb0lYdDRMYnhOUVVhV3ZuVkVzbXpSNit6N3NxeDVG?=
 =?utf-8?B?UVhMclMzMXg1N1JZSGZTcDI3Q0JyQnd4YUpZN3prNzhxUERpbHgyRW9jVk9x?=
 =?utf-8?B?NWdmVmxlWllRbTBpWEgxaGtaclAyTlgyRzVJUTNRbkV0cUgzVmpjUVBtZEk2?=
 =?utf-8?B?WUIxQUZ6Q2lva3NjN04rRFRMQkVwUXovWjkzQXNnU3ZLNk9yMkhDZXgrelhV?=
 =?utf-8?B?MzBRTnA2K2p5R2JVMm9nZjVHaTNNR2ZDSXhCMHU2Vlo5aFNsMEZSbnVkN0gz?=
 =?utf-8?B?N2pmY0dnUzJaMHFBYVpUd29hUkl4MHZiOFEyRGhESTE4Z3pzblhqb0JmSTRU?=
 =?utf-8?B?RjBENWZMdmtQN3V6TDlQdnl2VUtZdGkxalFvL203NDVLOUkzYitTNi93d0V1?=
 =?utf-8?B?dS9Bc290Wk9lNlYzRTk1RktrNE50MmpkQ2VEQ2pXMk9PQ1p1WDFSa3l3S1Fw?=
 =?utf-8?B?UWhOU1JCU2RLRVZ1VHo0VC9uRmwzSXZwbXpoM3o0QUhRZjR1RVVSNEROQmZ0?=
 =?utf-8?B?azREOGF3cU5VdEJ0Z2RRaFZWNDl4UDc5bWRSbU9sQ2NCaStFdGtDOTVMMTdP?=
 =?utf-8?B?YVFxRldPMExJdWZXQkExV1hrdUxRSm5uUnF2eG1GT1NBM3VsMXZ5MGduNGxL?=
 =?utf-8?B?VXZBMGIrSzcvN0daczF5MHk4SmEyVitWTVRLVVRDM0tOTFBWVUtlVzBrS1pk?=
 =?utf-8?B?QWcrUW1pZEhQR2IwTmpIV0lzc3BBUGpOdGRsQTl3Vm82VTNQNndWVC9tRWtW?=
 =?utf-8?B?S0RLdXdkQUEzd3J6dURGa2gzWHB1Z1ZZRGN0YXRITTE3L1VmTXFkOWQyMlZP?=
 =?utf-8?B?V0tuTlMveUZiVSsrbjJLT0ZuQjdHYXZBbUVqZE5xdzNuaFUrcjBlelR1RExx?=
 =?utf-8?B?OUN2TXdSR1dZMkVGbUhlUWVvN0dDbWZNQ2RPRkk3LzQxS3g4S2lJckxsZFgz?=
 =?utf-8?B?NDBJdXM4eHBmZmF0NXNIT1o1ZzA5czU3VnpxOFVtRDFYbVV3OU1ZeW8vSjNk?=
 =?utf-8?B?SVdMZlhYamZkUW1DMmU1TEh1TTlBWXF2UUFINk5rSmw5cFY4TVd2QVlFbXlR?=
 =?utf-8?B?NCtRZHRPS2RXbW1WM3YycGhzWlRrSmRtR0NPRENyOEQ0NkhsL3pxei9iNnkr?=
 =?utf-8?B?L0Uwbmx1VkFGYlVpS1FleHY4Q3FFN3A1VWU5NGVtTXBxTlNpa1VJZ1JQU3Fj?=
 =?utf-8?B?dHVqQkErSDFhWVZ4QXhYQ05kcEFKZnd2MGd3bVEwQlZlN3VkcDEwbjBqOTVH?=
 =?utf-8?B?bVpjWlZQbGhhODNsYzNEWDU3cm9CUGxhajJPdTJCQXZJSmFpWkpGMHJ2OFk2?=
 =?utf-8?B?V0h4V0FkSWg2Qy9POG8vcnhqeWl5dGUxeEk2S3VlNjRHZjYyaU8wVk9iMGc4?=
 =?utf-8?B?aDI4TjRwNGNvVStiS3lEdVBLSG1XQktoR3N1TjdTRjJ5Y3JGbnBlM0JyUXN2?=
 =?utf-8?B?MlRkcnQ5aVNhck9LajZJb0xOQ1hCV3Fvc3djN281KytYRlFDTS9TekJaZUVO?=
 =?utf-8?B?TkhGRW4wQjdsMVBrcTVmNStYa0doNmZ1ck5KdVl4UXo0Lzd4ZEJETmJzRmUx?=
 =?utf-8?B?Q0NrT0paSHJIVFdIZzRiT3h4U08wM3hXNUJkTVN1VXl1SHpaYzdmam9EVkZ3?=
 =?utf-8?B?MEVDaGhrYUdnN3BnbUZ4NmN4UWJqczJvNlR3Q0p0YVdQYXFKVmprSGJoQ00z?=
 =?utf-8?B?d3BJOFcvTEhmV1N6c3NlSzBhYmpjbUpleVlXelNKVW9INFhLSmloWndjQTE2?=
 =?utf-8?B?S3NXTHBBdmkvekN1N1lOeGZ5a2xzYVBXb2l6Mkk5ejU3UWQvV0tIbGpHd2dC?=
 =?utf-8?B?VHVTME9mVndMZytJS2xpOE9tZGZGeUVlenFrQUFkODJ2ZmljZ2VOejRzdHNK?=
 =?utf-8?B?VjR3SWR6S1FSNDBUSEczcDJodGFnM1k4VmtiVG1ENUYyVDY1QXlMbnZ3L0w3?=
 =?utf-8?B?b09LZ05ZR0NJcmNFellibTVDR1ZkdDFmM1BCSkg5aDNzQ3NHK3hYcUl5dlpP?=
 =?utf-8?B?K25nTlI5Rzl4ZlFFVk5Cby9FaENrMmFWVWM4VWNrTEV6VGdYR2YvV1ZsT1NQ?=
 =?utf-8?B?QTB3aHdHUjZsSHE3Vk9HNFI4N2k1b3UrT3lpL3Zna0djbEJ6Z0pXNnA4ZHlE?=
 =?utf-8?B?NWFZRTk5ODhzdkt0NFcycXBqdmt4UktoT2JBQUNSMGNCekFFTVZuV1V1UnBs?=
 =?utf-8?B?aHM3UG8weWl6MlQ2V2tKNHRBc1JDdHNGRzFYYXRBOHArQjc1cU1Zdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7bf50a2-8e6b-4f6d-8971-08df1f30aa05
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 20:23:18.3006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MoppP6SZAueZt/jnCNZo7JUmcdhQehOpEKAITrG4NWPcGcJIYQe+qrj/rTsFxZQUPpPs2gvVE47TEDZHA8raYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB923140
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

On 2026-08-11 12:46, Melissa Wen wrote:
> amdgpu_dm_plane_set_colorop_properties() returns -EINVAL both when the
> plane has no color pipeline selected, where falling back to the legacy
> color properties is correct, and when programming an active pipeline
> fails, so the caller treats every failure as the former and silently
> programs the plane from the legacy properties, leaving it in a mixed
> state and userspace with no error. Check if plane_state->color_pipeline
> is set instead, so the legacy path is only taken when no pipeline is set
> and any other failure is propagated out of the atomic check.
> 
> Signed-off-by: Melissa Wen <mwen@igalia.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index f6a2af5d2e96..f2731989499c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -1906,10 +1906,10 @@ amdgpu_dm_plane_set_colorop_properties(struct drm_plane_state *plane_state,
>   	bool has_3dlut = adev->dm.dc->caps.color.dpp.hw_3d_lut || adev->dm.dc->caps.color.mpc.preblend;
>   	int ret;
>   
> -	/* 1D Curve - DEGAM TF */
> -	if (!colorop)
> +	if (drm_WARN_ON(dev, !colorop))
>   		return -EINVAL;
>   
> +	/* 1D Curve - DEGAM TF */
>   	ret = __set_dm_plane_colorop_degamma(plane_state, dc_plane_state, colorop);
>   	if (ret)
>   		return ret;
> @@ -2080,8 +2080,8 @@ int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
>   		dc_plane_state->input_csc_color_matrix.enable_adjustment = false;
>   	}
>   
> -	if (!amdgpu_dm_plane_set_colorop_properties(plane_state, dc_plane_state))
> -		return 0;
> +	if (plane_state->color_pipeline)
> +		return amdgpu_dm_plane_set_colorop_properties(plane_state, dc_plane_state);
>   
>   	return amdgpu_dm_plane_set_color_properties(plane_state, dc_plane_state);
>   }

