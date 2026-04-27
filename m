Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA19FFF886C
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 18:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A2F910E8D7;
	Mon, 27 Apr 2026 18:43:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4dxKZYls";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012021.outbound.protection.outlook.com
 [40.93.195.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24BFD10E8D4;
 Mon, 27 Apr 2026 18:43:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGER4bJQL2LuVvKSnqXSjsTmyzoh4SPK6uGRrCbSyemij1ZpIraIb3/ynXamTPXXJ4JU6Us5hIZMAuFRpka2m6ggAof7r2hym25niha1NPaNvOp7G3IOYHk/Z07AmjFHI8/v6IxBl9zvi8KnpGKKtrgUOrQOiQnSPUfHy/vgupGUEacUWuy+u3uV1AAnX2rQmZkcCPvdbWOuw53eMrc+pWYJLeFcCS3YNOsHl48gAlKYvK8I+B2tmd37hMSJCq9ZWXvj8b5WdnlGjmT4x2NL8M8d8vSyjv0b1fVsofEXtSXTUp0KItBLZ/TS1vfExRKO+Z0g+HXpeJpyBTmRIkgd6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w54Cx1XWezmHtdCmaOr3hwoY0NeBQuPdujegigQEUwU=;
 b=Vl4yy4SeTByeGAKWcVPu992aQouh6skHt8u/+N/uGHOvc5V9X4/Pm12vqMULPcRuueOp+4Km6K2Wk7oi3AwpgixUKnQSdBLI1F+OmELwSnVzOEh0TW6ueekRkAsrm6/miCA7cgyN1g8Fnr9OLVk9BeX6d/c6za0lmL4jPPz4QxvrGiUxJJrzjx9qdowVAlqfDTDkwvwvd9bGl6pnO2M1biTMcZTEH8ga/J716zKGkScm05oRpEgCCxKVjpIbmJyFcpiGfExzOdeWH0bHDgH4SkyZwyzY4Ial7jCOn12b5nWBVqdcEFds+JmBoUiZ+M9lg/QrcX3uHJdrs1FuqqOY3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w54Cx1XWezmHtdCmaOr3hwoY0NeBQuPdujegigQEUwU=;
 b=4dxKZYlstj49Huw5efZ93PU5HbTCY/dGIz07OE0l+4vbrpp7Q+4VIMrSdUp1DwV4XKKWb2H13mUoUDNlmrEm9FDgylxO/JdGdNH4/P6ida/phE83U8ARNZWPZI8HdAym8ttzsZDEqvnHe22iYkM7hssDxvEnqWMl+NRgFjZg0E0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB6850.namprd12.prod.outlook.com (2603:10b6:303:1ed::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 18:43:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 18:43:36 +0000
Message-ID: <9ad1c4bd-6f12-41b6-b6a0-979a0de32e16@amd.com>
Date: Mon, 27 Apr 2026 20:43:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: amdgpu{_reset}.h: fix all kernel-doc
 warnings
To: Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260427183854.672967-1-rdunlap@infradead.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260427183854.672967-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: 76975576-03f8-43b1-6938-08dea48ce43b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: TZ4BmXe6sKLOPzchFq+85HOODucdMng40MKUPnZmnms9X7p579WtAstaA7q9Z3U4YBF5OMiEkrdpjLljDZydCBHqp3XGwD360Z82xXJ0J+iailXZIUQGR3mkvxv20tRQ+RthrhZN1fSouZAmx/pojrnPH77whoX+hxUefHBFP9YZqo7ePqv90t/pDZCgoGbvIRNdHEZ3FIZ83UtzZCA5O1QVZOL70zG/Ypn3RBSWuezC0Ql5r45JMeifGv88MNm+ly5a9ZCS/jWuuZwziRnh1nvxOuBudr7KjrZTO3APzd1bDDhM5EMElk/jiTfUYGJ4diSb7FnzTmEESNyBdkr+eShAF5ySqVHvEdYQ0moy/PbGt6RIlJ9EhGtIHbRa5OE2Y56WHwco0jQT/fMqDaV/1Pxveda64I4+Ow0lMxEXnJQqixpj5URz3muFcGq8zjhwazaXnqtKZLof/ZGwBnZTczKmaRYfqxuPZxbIy6JvDiq+wMc7d4puacxki6ykaTuJrN4+097J6dhNZytGjm/SXzwMyzQ1TREB9ReHi42S/hdnVPlJk/J5ZIW97T8ls5AkjpMhoVE8fuU6sgA10MQhD9QpZGK1vo6quOsqn7tPmbKlyPfvHcFOFRytMh3893lOTr/rz6jKvrY09wYjRxruNdHz289t39N9RpCKbaSicUf5VlwQA2Alfb1iDuIeYuro
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2FGaHZOVU9KK3VmQ1ZwU3dwMjlqVWsvc2lKbGpYT0dqaFJXTEptbUFLNUUr?=
 =?utf-8?B?dzFlWS9EdVNIcW1LeGt6NnJrRFh1V1ZSMlpoT01xMTQ2enJQRzZRYzg2NGNS?=
 =?utf-8?B?clZEOTV6aE9EZG1YL3Z6aDJvMWE3MGs1OTRtU1g2TFJCV0V3UDhUYzBpRlBr?=
 =?utf-8?B?YTNubnNuZnVBSXRLY1ZVUWNCT2xOZEJITkpHMXZRbFRUV2ZCV0FPMnV0cUNI?=
 =?utf-8?B?UHlaWEhQQ3ZCaHpFQTIvNzE3VFYybHdjTHNOYnZ2NVgwVktycFhVUHF3bjM0?=
 =?utf-8?B?bGhXajNIU2xHY1FyYStuRlJqRjEzOFVEUlpGbXprbGlPcE5zblM0NVJMcWZX?=
 =?utf-8?B?YitRVSs4QXcvL1R4YmZpSE93OXpOUzdpZTJiaHI0U21kMlU1NlNzYlp3WFc3?=
 =?utf-8?B?aUViQ0d6Mm0ydm5jZ1dOOFhoYkJEZVNVNTJ1MWVwWEV2N2RUMXlHUnhLUldz?=
 =?utf-8?B?cmt5OTZheVRqSjNSNjhNOXR1TVhhMVNHR1FZSmMvVzZqYUVnd3llRk1sZUZ6?=
 =?utf-8?B?NFhGWW1pbmRNeFdDNmd2TTMzY1QxUXZWYzRyeUQxZDY5Vk5DSHNjdS9iRHE4?=
 =?utf-8?B?RzFLVTZkcHpjSk50TFV1a3ozSnB1dWk2TUNMazZDVHE5VFl0QmhuZzFuQ20v?=
 =?utf-8?B?Ym9OK1BFRlU4bUlZZU1SMDNOK0laZ3lRQVBCV0ZtRng5QWRWblhYUm1tWm1L?=
 =?utf-8?B?OEQ1Mnp1dGNWdTJDVlk1ZFBSM3pyMkRtT0ZLNTQ4bUExUEpXejg3Qi9qdEN1?=
 =?utf-8?B?UTRzMTA5LzRaRVRlWVZHNG9CSS9xUDBBeTgxemJDV3FoU1EvdkprTXdLa1RI?=
 =?utf-8?B?ZEpNbUxibHNnUGtxQ2hNRDhXQlk2emNjZjNBUXd3dk9yWkdId3VSa0NBTmFv?=
 =?utf-8?B?ckF4emhsRnQwdVlHSWNpVzNNaXFuUGNtUDJ3NU9ITkFpQ2NKY2ZlRHZScUZu?=
 =?utf-8?B?MU02OWVoUmEyRnU0aTB5S2ZBNS9jQ3hSWjU1Y29uNzhhUmZMMU9jTUQ1Qklr?=
 =?utf-8?B?K3dBdjE5dlA4RjRzOVB5eDlkcnRtanZNSmhmVjJPeXBvWUJXRE91NmgrM1lJ?=
 =?utf-8?B?ckp1WnlZNjJ4RWRFVUVkTjFWdWQ0OTIzam9lMTIxZGQrS3ZJa0JpcU42Ny9F?=
 =?utf-8?B?RDVCbVA5M3BhMnJXclBOL2ZnUHVaZzR2U213RkNFcVU3TExFQVpmUnovQlRE?=
 =?utf-8?B?TmtPbnJGcWQ0bCtGTGtjblZBV3djaUdlQTFub3kxQnk4QWhFN1BBK2R6QkJl?=
 =?utf-8?B?OGgxencybzFBSEtQRTc2ZTh4Mm9aUEozWERucUN0OWVkdHlHbjZyM2l6RUtZ?=
 =?utf-8?B?VElua2wrT01PYmRFZWcrazZMclVkQzgvZXZxcUViTHhMWndGb3B5Y0F0TkI2?=
 =?utf-8?B?S0NlT3ViQTVIS3JnR281bjdMakJpYmowQ1BLV04reTlBdlNzK3lxZXJPbXYy?=
 =?utf-8?B?NTZncXNwUmlRTVROcnZBVWZSUTZQbWhVTS9MS1Z1K2pZdjNnVTdGZ0J5UUVl?=
 =?utf-8?B?S01jQmpRbGVydDZSRDJSblFDSktYTWdmeTVkM0JtY3dOZ1pFR3VXbHliVlh3?=
 =?utf-8?B?ZTF0S3FRVEZHWG5pVEdqczZBeTVCQ2k0TW9WUTNSRU5GZ3FEaTkycDQ5cGZo?=
 =?utf-8?B?MWxmVDJuc1E2MkN4SGVXRHFkOE9OOEpORWk1aDB2S2JWbktmS0pVNkQ0TWY0?=
 =?utf-8?B?d0xNa080RWhMbGovTUl2Q2wwclBkVWNuUS9nWjRUa3FTYmRiMmdxcGNHMG1K?=
 =?utf-8?B?VGp3cFJ4N3VHL2lkczBPdTYyeUVqcjdZZFJQcUlNY0xSU1QyZ1NvaW92QURu?=
 =?utf-8?B?cGVxTWVxWldvRkR3VWZ3V3d4U0Ziek55UHAzRU0zcXJBajFKL2tzZUJYWmdU?=
 =?utf-8?B?N2JtWTFSNzFYWUtWblh4MHd0VjU5NGtrbDgzeFNqdHpveHo5S3dFZHpNMFVq?=
 =?utf-8?B?dnJwMVF3Q3ZnNTF1NUNJUW1RUDNaay8xNVRnZmY1R0NMRWsyM2NLNUZNU3Bs?=
 =?utf-8?B?aTg3dlV5OTZDT0E4Wis2RmFscy9hTm8rNGxGaEFUVG9PamZrSFRRZGFTZldE?=
 =?utf-8?B?R0VEU0JqUWMzQlQwT2pRWmhaV3BkN2lRUFI3QllWZFBhUVhnalhIWW0wYk1O?=
 =?utf-8?B?K3hQc3Q5dm5uTllzVlhobytwaTlialBjMERON0VnM1NmcVBiTldYQjJhS2py?=
 =?utf-8?B?QUdETE1vamhtaEJtc0lvMkZQSEhOSEZpcHpuS2tHbDIybytzOWhiemJSUExU?=
 =?utf-8?B?aStGSGVVbzBPSjJuTjQ0QUVBK3Q0OUs5Rk1mM1MyY3NiM0x5NUpCNjc3ZkFt?=
 =?utf-8?Q?a56dhy1JFEZeyRW6ZS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76975576-03f8-43b1-6938-08dea48ce43b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 18:43:36.7231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VgqtJTtx332pb8RvE02DP2K/xsR3plXULmCci0rLStQBj96d+SMqQ+6s5lDyaA6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6850
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



On 4/27/26 20:38, Randy Dunlap wrote:
> Fix all kernel-doc warnings in amdgpu.h and amdgpu_reset.h:
> - Use the struct keyword for kernel-doc struct comments.
> - Use the correct enum names in enum amd_reset_method.
> 
> This eliminates these warnings:
> 
> Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:477 cannot understand
>  function prototype: 'struct amdgpu_wb'
> Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Enum value
>  'AMD_RESET_METHOD_LEGACY' not described in enum 'amd_reset_method'
> Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Enum value
>  'AMD_RESET_METHOD_MODE0' not described in enum 'amd_reset_method'
> Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Enum value
>  'AMD_RESET_METHOD_MODE1' not described in enum 'amd_reset_method'
> Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Enum value
>  'AMD_RESET_METHOD_MODE2' not described in enum 'amd_reset_method'
> Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Enum value
>  'AMD_RESET_METHOD_LINK' not described in enum 'amd_reset_method'
> Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Enum value
>  'AMD_RESET_METHOD_BACO' not described in enum 'amd_reset_method'
> Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Enum value
>  'AMD_RESET_METHOD_PCI' not described in enum 'amd_reset_method'
> Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Enum value
>  'AMD_RESET_METHOD_ON_INIT' not described in enum 'amd_reset_method'
> Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Excess enum value
>  '@AMD_RESET_LEGACY' description in 'amd_reset_method'
> Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Excess enum value
>  '@AMD_RESET_MODE0' description in 'amd_reset_method'
> Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Excess enum value
>  '@AMD_RESET_MODE1' description in 'amd_reset_method'
> Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Excess enum value
>  '@AMD_RESET_MODE2' description in 'amd_reset_method'
> Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Excess enum value
>  '@AMD_RESET_LINK' description in 'amd_reset_method'
> Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Excess enum value
>  '@AMD_RESET_BACO' description in 'amd_reset_method'
> Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Excess enum value
>  '@AMD_RESET_PCI' description in 'amd_reset_method'
> 
> Also move the enum to amdgpu_reset.h and eventually only forward declare
> it in amdgpu.h. (Christian)
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
> v2: I moved the enum to amdgpu_reset.h and then #included amdgpu_reset.h
>     in amdgpu.h. The simpler method causes build errors.
> v3: rebase and resend
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h       |   42 ------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h |   69 +++++++++++++++-----
>  2 files changed, 58 insertions(+), 53 deletions(-)
> 
> --- linux-next-20260427.orig/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ linux-next-20260427/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -464,7 +464,7 @@ int amdgpu_file_to_fpriv(struct file *fi
>  #define AMDGPU_MAX_WB 1024	/* Reserve at most 1024 WB slots for amdgpu-owned rings. */
>  
>  /**
> - * amdgpu_wb - This struct is used for small GPU memory allocation.
> + * struct amdgpu_wb - This struct is used for small GPU memory allocation.
>   *
>   * This struct is used to allocate a small amount of GPU memory that can be
>   * used to shadow certain states into the memory. This is especially useful for
> @@ -538,44 +538,6 @@ struct amdgpu_allowed_register_entry {
>  	bool grbm_indexed;
>  };
>  
> -/**
> - * enum amd_reset_method - Methods for resetting AMD GPU devices
> - *
> - * @AMD_RESET_METHOD_NONE: The device will not be reset.
> - * @AMD_RESET_LEGACY: Method reserved for SI, CIK and VI ASICs.
> - * @AMD_RESET_MODE0: Reset the entire ASIC. Not currently available for the
> - *                   any device.
> - * @AMD_RESET_MODE1: Resets all IP blocks on the ASIC (SDMA, GFX, VCN, etc.)
> - *                   individually. Suitable only for some discrete GPU, not
> - *                   available for all ASICs.
> - * @AMD_RESET_MODE2: Resets a lesser level of IPs compared to MODE1. Which IPs
> - *                   are reset depends on the ASIC. Notably doesn't reset IPs
> - *                   shared with the CPU on APUs or the memory controllers (so
> - *                   VRAM is not lost). Not available on all ASICs.
> - * @AMD_RESET_LINK: Triggers SW-UP link reset on other GPUs
> - * @AMD_RESET_BACO: BACO (Bus Alive, Chip Off) method powers off and on the card
> - *                  but without powering off the PCI bus. Suitable only for
> - *                  discrete GPUs.
> - * @AMD_RESET_PCI: Does a full bus reset using core Linux subsystem PCI reset
> - *                 and does a secondary bus reset or FLR, depending on what the
> - *                 underlying hardware supports.
> - *
> - * Methods available for AMD GPU driver for resetting the device. Not all
> - * methods are suitable for every device. User can override the method using
> - * module parameter `reset_method`.
> - */
> -enum amd_reset_method {
> -	AMD_RESET_METHOD_NONE = -1,
> -	AMD_RESET_METHOD_LEGACY = 0,
> -	AMD_RESET_METHOD_MODE0,
> -	AMD_RESET_METHOD_MODE1,
> -	AMD_RESET_METHOD_MODE2,
> -	AMD_RESET_METHOD_LINK,
> -	AMD_RESET_METHOD_BACO,
> -	AMD_RESET_METHOD_PCI,
> -	AMD_RESET_METHOD_ON_INIT,
> -};
> -
>  struct amdgpu_video_codec_info {
>  	u32 codec_type;
>  	u32 max_width;
> @@ -1373,6 +1335,8 @@ int emu_soc_asic_init(struct amdgpu_devi
>  #define RBIOS16(i) (RBIOS8(i) | (RBIOS8((i)+1) << 8))
>  #define RBIOS32(i) ((RBIOS16(i)) | (RBIOS16((i)+2) << 16))
>  
> +#include "amdgpu_reset.h"
> +
>  /*
>   * ASICs macro.
>   */
> --- linux-next-20260427.orig/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ linux-next-20260427/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -46,6 +46,47 @@ enum AMDGPU_RESET_SRCS {
>  	AMDGPU_RESET_SRC_USERQ,
>  };
>  
> +/**
> + * enum amd_reset_method - Methods for resetting AMD GPU devices
> + *
> + * @AMD_RESET_METHOD_NONE: The device will not be reset.
> + * @AMD_RESET_METHOD_LEGACY: Method reserved for SI, CIK and VI ASICs.
> + * @AMD_RESET_METHOD_MODE0: Reset the entire ASIC. Not currently available for
> + *                          the any device.
> + * @AMD_RESET_METHOD_MODE1: Resets all IP blocks on the ASIC (SDMA, GFX, VCN,
> + *                   etc.) individually. Suitable only for some discrete GPU,
> + *                   not available for all ASICs.
> + * @AMD_RESET_METHOD_MODE2: Resets a lesser level of IPs compared to MODE1.
> + *                   Which IPs are reset depends on the ASIC. Notably doesn't
> + *                   reset IPs shared with the CPU on APUs or the memory
> + *                   controllers (so VRAM is not lost). Not available on all
> + *                   ASICs.
> + * @AMD_RESET_METHOD_LINK: Triggers SW-UP link reset on other GPUs
> + * @AMD_RESET_METHOD_BACO: BACO (Bus Alive, Chip Off) method powers off and on
> + *                   the card but without powering off the PCI bus. Suitable
> + *                   only for discrete GPUs.
> + * @AMD_RESET_METHOD_PCI: Does a full bus reset using core Linux subsystem
> + *                   PCI reset and does a secondary bus reset or FLR,
> + *                   depending on what the underlying hardware supports.
> + * @AMD_RESET_METHOD_ON_INIT: Does a device reset during the driver init
> + *                   sequence.
> + *
> + * Methods available for AMD GPU driver for resetting the device. Not all
> + * methods are suitable for every device. User can override the method using
> + * module parameter `reset_method`.
> + */
> +enum amd_reset_method {
> +	AMD_RESET_METHOD_NONE = -1,
> +	AMD_RESET_METHOD_LEGACY = 0,
> +	AMD_RESET_METHOD_MODE0,
> +	AMD_RESET_METHOD_MODE1,
> +	AMD_RESET_METHOD_MODE2,
> +	AMD_RESET_METHOD_LINK,
> +	AMD_RESET_METHOD_BACO,
> +	AMD_RESET_METHOD_PCI,
> +	AMD_RESET_METHOD_ON_INIT,
> +};
> +
>  struct amdgpu_reset_context {
>  	enum amd_reset_method method;
>  	struct amdgpu_device *reset_req_dev;
> @@ -56,6 +97,20 @@ struct amdgpu_reset_context {
>  	enum AMDGPU_RESET_SRCS src;
>  };
>  
> +struct amdgpu_reset_control {
> +	void *handle;
> +	struct work_struct reset_work;
> +	struct mutex reset_lock;
> +	struct amdgpu_reset_handler *(
> +		*reset_handlers)[AMDGPU_RESET_MAX_HANDLERS];
> +	atomic_t in_reset;
> +	enum amd_reset_method active_reset;
> +	struct amdgpu_reset_handler *(*get_reset_handler)(
> +		struct amdgpu_reset_control *reset_ctl,
> +		struct amdgpu_reset_context *context);
> +	void (*async_reset)(struct work_struct *work);
> +};
> +
>  struct amdgpu_reset_handler {
>  	enum amd_reset_method reset_method;
>  	int (*prepare_env)(struct amdgpu_reset_control *reset_ctl,
> @@ -72,20 +127,6 @@ struct amdgpu_reset_handler {
>  	int (*do_reset)(struct amdgpu_device *adev);
>  };
>  
> -struct amdgpu_reset_control {
> -	void *handle;
> -	struct work_struct reset_work;
> -	struct mutex reset_lock;
> -	struct amdgpu_reset_handler *(
> -		*reset_handlers)[AMDGPU_RESET_MAX_HANDLERS];
> -	atomic_t in_reset;
> -	enum amd_reset_method active_reset;
> -	struct amdgpu_reset_handler *(*get_reset_handler)(
> -		struct amdgpu_reset_control *reset_ctl,
> -		struct amdgpu_reset_context *context);
> -	void (*async_reset)(struct work_struct *work);
> -};
> -
>  
>  enum amdgpu_reset_domain_type {
>  	SINGLE_DEVICE,

