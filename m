Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1171B606A32E
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=h/UzpO+L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 651F210E02A;
	Tue, 10 Nov 2026 09:02:49 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010018.outbound.protection.outlook.com
 [40.93.198.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A30710E02A;
 Tue, 10 Nov 2026 09:02:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egEp316AEWNkBOlZ6/WU0E477hQW0e8pPnx1e7GrFsbhOkVIsLtYgTJkYXMyJSIiaTbdqh73LAdJ6mBr4ph3y485EKEQX6HltDCTLQENnk+JTxrqXxYIxzi67CqN/mKWiYwi2yOUai6VAmgNzQVbN+ZvXo4M+1qtTXeT9gl2wJsM51uOEyPLj9JlKn3QnvAZQCOecpSnTMA7pUVMr05kD2DLwR97m4PumQBgjzrgpLVJ6Uhn+dRXhXqG2545uK1CgpSGLW0dOCfIOS8z+bXFShaUq8EYsrOVoRidNqhaYMibSXV1B0G4Fj1NITZ3btXjDlPEXGAdz/KtMl4LumoQNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhVES0F8QslaLPw1cnToI5+f8lYqrrPoRFMEFrT0zjY=;
 b=Bx4nnEBCiJZ0+Jwy8QeG4wrsVdC2W1Nt87nufH7AsVGi3kjJWNjn612TsQz/ZBRyOx1ziIJAEkTVOzMqCxWlXHNgVJsmeVy9+smxx2bBwyfLaKQ6xLACXi9HKCSyhfjoStNtXB9HV9xYqakkSrRmAIMPJQI45jDvrnLoq+rAzW5eM8gA9fLySvEW/eBl255gMIa9H+nKkYfoj8ucgI0thj7/uBmLb8JoSaxjlqlxy2nR3z/Jz8cY2I8MTLvq/uZrzxPKrnjSOpce1Sbp9ip5P94Wi9E7Mmm1WPLgZwccfLsXlvfR4tpzTSn2p+Rgf7rMmHxtaINpIfrK8jM8Ihr0WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhVES0F8QslaLPw1cnToI5+f8lYqrrPoRFMEFrT0zjY=;
 b=h/UzpO+LbtSRQ/cK3gvLWA7/UR9sdv1MvlTdYwU0KOv64BbsR2gwjTCAhgd9ZduuZJwaR/M7R26vvGeHBHoyOMb2kr0YQ5YB8FmUZTbpbxvTgKojqHnjATEGkAlGB/chP69rXndEOYajZNLifFOcHhodnOQlBt1FDy+yqIIYaDw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB077728.namprd12.prod.outlook.com (2603:10b6:8:506::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 09:02:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 09:02:41 +0000
Message-ID: <cd8be687-8876-4232-b85b-c1eaca2f0222@amd.com>
Date: Tue, 10 Nov 2026 10:02:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] drm/amdgpu: always clear stable_pstate_ctx in
 amdgpu_ctx_fini
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Sashiko-bot <sashiko-bot@kernel.org>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261109171333.4329-1-pierre-eric.pelloux-prayer@amd.com>
 <20261109171333.4329-3-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261109171333.4329-3-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB077728:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dae92c9-e388-4a40-2ada-08df3f096013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261026140227099003|261021123027099003|261021121427099003|261028144727099003|261009223027099003|261022105027099003|261102123227099003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PNL2uimGSp0uwA4rv300nFsgOyBQKnwLJgED3XZH+Ugiz7w200UVWbQoVYAEwNx4E7OF5a4xqIZ8CNROjLzhkhYmLjQkmCNiPk/O5k9ffmJUSGK7IloSy8uxsgutkb/UoH4JwcIW/BJQyOdHbqYYvTdHCfLMikqPJ9f54veJhd/ykFCvhrnhEHccrUKtPKVI6397snFK1Il0jW6Q1OSS6RMfYs7sXPBJRCzFB5eJ6kj8TnzC2dHijrPkNHAnUXdinbY2z1mD+u2dzvmDrUKJ+hKjK1aIpQjVSnhDd+h/uLyEflBDXbU+TO8VSplRwh1mE2w82Z74sDxuKHYqQzZfbnCtuK6w5WnbSFjvndY9scqiPHw8xZRwuxM7yjaM259jggBS9eT0IUBM1ODL4XzCzF1B/r3hQFILzd/oqC2ZE+8TdnIFYNpprZJumi8QwRsE10BDIF50anqM1a1JTE8mp+t8F+LX1N9qkBpAQMzwcBtJqMouMxWAzCBbNkB6WAFDpLev9WY8stfe3bI9L7Ib371gFogwarqFC54GP4z8/k6OLgpPb4OOw2IUq6o4NkxTRgMSm7vDVj8hfVF/6z5vEQZP7UJiMl7sR0IWv5OmWy4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261026140227099003)(261021123027099003)(261021121427099003)(261028144727099003)(261009223027099003)(261022105027099003)(261102123227099003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dStUbW9HS3NrQmJ6WEdvb3dEdjlpNkg1anJZTjJvenpDRnErd1VJWm5iYjZr?=
 =?utf-8?B?ZmhKVEY5VDd5TmtHVG9TcWJFMmM5aWhNU0ZNYmk0RHh3cmVNNWx0dE9JZkxF?=
 =?utf-8?B?Ym5HS2lGd0pOS3QvaGNDK21UY2RPUjY1dTZQQ1pqeklwYUpXVXppR1YraFJz?=
 =?utf-8?B?MVE4K1dVQTNvYzZCeGFHN1FCVytadDV3dy8zeXZERVZjY0dVVXE0QUgwRkZK?=
 =?utf-8?B?T0RZcWRjWWlLR2djdWkzbmcyeVpLblFjUVpsZTF4S2JtWHJHSXNWS0VBSWlv?=
 =?utf-8?B?R0N3d1FqTXIveXNLRnJlMExzTk1Ed3lvdHBnSGJSb1kzSG1FNUYxa2ZxekI3?=
 =?utf-8?B?ZjRSbmhEZWtNRTVhZGkveFlaZi81UjhvK2VBMWthN1dISnprb25IdVRITnA5?=
 =?utf-8?B?MnFDTXoxYmhvVCtVSEhOZ3hxRWdPbGRXelJDcWlmSTd4dEI4L2RDTUNKMEhm?=
 =?utf-8?B?alFwZnYxckIyRkliY2VBTWxlcWJ1ZkEwZFdxK0ZVSzRGRGZhMzNhb3RBY093?=
 =?utf-8?B?L1pBbjdKcEhYMXpFdWJiVWVqdFl5cm5jUktDSC9TN1F2QytUYlREd05NMFNI?=
 =?utf-8?B?NUZ5S0czK1QvMnhlOUVxRmxKYlJ5MkgrZjgyY2hieDJaYndldUNiWkU1OFp6?=
 =?utf-8?B?Vi9OYWRaQXRBRGhMMlhNYS9VVDJJWm1IaXVNKzRZTU9WeXdyRlhwbG1qeDF3?=
 =?utf-8?B?ajR2bkg5bTVpM0Joc1Q2SFI5QU5laVBSbDAxdVBXcjY0Wk5ScDI2NXJHTEor?=
 =?utf-8?B?YkVPdng2UWJuZlErUzJLUWsxU0lPbTkxazhxTE5SaVpoYkUvckhMVFEzTmM4?=
 =?utf-8?B?R3Q3MUY5aWRTMWFRSGhLRUhYY29KODJHZEYxNWs0TkNRMXF6R1JkR3RER0M3?=
 =?utf-8?B?djgxZFNyc2g5b0UxeGJ0MXBpRFJsVkt3ZmtVOTMxNm54Ym81T0Jud2hId3oy?=
 =?utf-8?B?QVNrZWk2YWRjdEZPcTJkb05UNGR5QUFkN1FXTWZIVGlWVGF0WXpHMk9pYTRt?=
 =?utf-8?B?Sy9lZFFOeDkwMXVwcGZoZjdGcDRBN1RtczZmZkFFQWRCS1drSnpUbUlHM3Uz?=
 =?utf-8?B?TVNMVGlTb1BSQmNWRXZQUTR3amZIWCt0YlNLSUZicE14NXlZWG9yMW9IaHB4?=
 =?utf-8?B?NHRvVENBWWFhbFk0dzd2Q1B0cXlpYURNT2RjOHlzdFRPS0pNV25vcldtRnN1?=
 =?utf-8?B?SEZpRElnU3ppOWE5Qkc1Z1FTYTIrbEt0eVk0WjA5NmVhREljcU5QU0l1RUd0?=
 =?utf-8?B?U0NCV2E0TG5vZWxUbEFuU0RuRWpnVUpzNWhOT1FoQ1MxYVM0eWFhbDRmaDhD?=
 =?utf-8?B?ejFDL0hjakZNbGNrNWhzL0FBY29lV0hUeXhVTWxYQmVtRFEyWW1Ga3ZCd1hm?=
 =?utf-8?B?QXZPNFJlSGlpTHhoaVU0N2E3b2VrVWJMTkU2cUcrMFZObTlNdTNaMEpDdEly?=
 =?utf-8?B?aEc0ODgxalRrdXpHRjBzQlpVazViQXdISFErY3hNbmorVTRpVHFEcExRdU9P?=
 =?utf-8?B?Q214dkFIb21LREV6NEdxdG9IVmJhakx6eC9YK3l4RngwZlB3TFFLWjB5Y0dR?=
 =?utf-8?B?YUN2NTRDL0lPREtYNEpnSThVa2JBdFJRaFI4OTdBWm1Hakd3elN4UWtweWlZ?=
 =?utf-8?B?dTduVDdxMDNnWTVqSUhXcUd6UzFnd2FJdm93YWhabVFzQkxoZXgwaG5zOCt1?=
 =?utf-8?B?Y2xQaEhnblMrWDhIL3VVM2tNZTcxOGpTQ3lnTTYrb2pXTk1ZOXJ3TmEybFZ2?=
 =?utf-8?B?eUs1OFQ3d1BYZm9pTjZ1SjIzdGhtNExQa1UyTFV6eWtIajNSaXc2eis0UXQ3?=
 =?utf-8?B?VzcwdXdaamZNQ2tEU2V4ZHZ0MjRDTzlLOHJvRkgvMmR4Y2dYU09ZUTg4UWsr?=
 =?utf-8?B?L243WU5BR0szVmxleUppelRGV1NMcHVKN2RraVNpS1FIbndFeWpBTkdiaGh3?=
 =?utf-8?B?S0NsR0pHaXo2cGVYZEFxVDEyVnBUV2pIem1vakdFeFZaTGFpNjgwdHhBTlU5?=
 =?utf-8?B?SFlqc3JkdTdXUHBucVM2Z3JkN3BmbDNGSHYxYWVEKzJ5Y0paK3dBU1hvR2kx?=
 =?utf-8?B?MUVaZHZuTE9ydDJBSnZlL2VmNzVrVmRKaTRIVWpPaWw5Wm1KQUlZVklIaVVK?=
 =?utf-8?B?NXlyN0VUTmJ0RTNHbTI1ZjRXa3FYQUMwUEFnZXViYlVtTGMxTFdtdzdUODRK?=
 =?utf-8?B?RXBYY2lJcGZLRHZpamZvOVNmOE5CSXR0WTdmVEp0c1QrOW5vZDcxaVExcmVK?=
 =?utf-8?B?bndRSTFvZ2pjWkpYbVdVU0crck1mbVRET1IyL2JaY2xmUmV1QVFGdnhKNVVZ?=
 =?utf-8?Q?kS26EeUQLojeV+mg+U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dae92c9-e388-4a40-2ada-08df3f096013
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 09:02:41.2831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCjpsrn9+5sLeFe4bFxLgplhbIi/YUIs/pCsLgHmDPecZ9uIOoCT9sMEzfGRRur1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB077728
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/9/26 18:13, Pierre-Eric Pelloux-Prayer wrote:
> Even if the hardware is not available we should clear the pointer when
> the owning context is destroyed, otherwise nobody will be able to
> use this feature again.
> 
> Reported-by: Sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20261029152000.22001-1-pierre-eric.pelloux-prayer@amd.com?part=5
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 25b1cf7dc988..2b318ccc9aa6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -426,15 +426,15 @@ void amdgpu_ctx_fini(struct kref *ref)
>  		}
>  	}
>  
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -		mutex_lock(&adev->pm.stable_pstate_ctx_lock);
> -		if (adev->pm.stable_pstate_ctx == ctx) {
> +	mutex_lock(&adev->pm.stable_pstate_ctx_lock);
> +	if (adev->pm.stable_pstate_ctx == ctx) {
> +		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>  			__amdgpu_ctx_set_stable_pstate(ctx, ctx->stable_pstate);
> -			adev->pm.stable_pstate_ctx = NULL;
> +			drm_dev_exit(idx);
>  		}
> -		mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
> -		drm_dev_exit(idx);
> +		adev->pm.stable_pstate_ctx = NULL;
>  	}
> +	mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
>  
>  	kfree(ctx);
>  }

