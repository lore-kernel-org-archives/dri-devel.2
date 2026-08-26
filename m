Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D784C61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 09:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4026510E29B;
	Wed, 26 Aug 2026 09:41:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F6d695eE";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011059.outbound.protection.outlook.com
 [40.93.194.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50CC010E29B;
 Wed, 26 Aug 2026 09:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6wjYIRE09ovameSJOnBBRDpqOrq2EnApyWz+C+iUa1yxejEqCdVqdWZwT5hZIb3UPKzuM1EdSK1NTJKX+KM721CCAP7FfMO9TrM+Bcn4Afxv9yMOVql0AmAX269LpsdiRD5EEs/iT/Khn3xveUuF5mB7HmTrkpSxwkvOgqGEJAs96P/tQYJIza0GVU6dj+DJonb+9OP92nMPf9AD44gEyxSX8uLEpA/C9qRLhAb+zkmzNL/9Ts//VRmLY++nYWniGVs6K7n2Pyd6yZDrtuPTsfszQIcFLTd/No4Q7PtJmGi72OqneWo+JHuU9dRIZbP5dmsnF1fQ3oRZZDem8DY7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHtnsEtYeNFSMf++TObNeKrfBXYnOOPajae4wdFzSHc=;
 b=H3m+Opp2S8itdwfcyeXNZ8M3/jtlh5fagxU5rvEXf5/jWUKE7fdzUeZ8cop+4NAVDMHFd58EARu+rKb031jsq5lmifRiWWSBtqBAOBl5OsPgeYZz0BLyaV+j1kIHIZmx3hxTGm/Q8PgpwqNzbtGQ4rIyzKJGOg2MP6EL/qnPz/lWoHeUoP3zEVZnrUVttFwrTRgvH4u+CGiRB6aaTHHpIcgKCJxr53xb+znjNJWX9ghJmoZ8xDI1ZY/3FpZqFq3orTLQii6Jg8WLd4lIqkuVJNO8UfaCTvW37qbtckIye4MkUVaWdv7Ff4Ezklw/OM0brfCe4R+qQZ0d0p5MfZAteA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHtnsEtYeNFSMf++TObNeKrfBXYnOOPajae4wdFzSHc=;
 b=F6d695eEnJlzCtG9RyGlTiLiDQRClhQv3cUiCOA4NQqcIwKadGjgUh4tYf4v9ceXnffs9E7x/o972HC5Eq+CSDCiJJ0giVBpXkRYeEMmY5CN8djlkhY7yv8CauR9GvwijwJQtxsLRqo2KIi8GRNVXWiTJc4c4P9bxXhmKlykzvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 09:41:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Wed, 26 Aug 2026
 09:41:50 +0000
Message-ID: <f2e876c6-640b-4572-9c7e-cb9961f986e4@amd.com>
Date: Wed, 26 Aug 2026 11:41:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer dereference in
 amdgpu_vm_init error path
To: Yang Zi <2959243019@qq.com>, alexander.deucher@amd.com
Cc: airlied@gmail.com, Simona Vetter <simona@ffwll.ch>,
 Sunil Khatri <sunil.khatri@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Natalie Vock <nat@pixelcluster.dev>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <tencent_FA0B5EEC37B4CAFBE12C77A63D352E5BDD05@qq.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <tencent_FA0B5EEC37B4CAFBE12C77A63D352E5BDD05@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0377.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: d2fda8be-821f-43e0-6df3-08df03564135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jyJoWRjT+ZUWW4kgA3ddUFbcrQJL3gBQv0aWM/SrIvT6VANQiKq7Ih7bqrTweC+99zNktP6LMW4C8wnkGGP6wY8KNy3hdBkFDhK3yhfvZE6WNyBfX3TOf7ONUhTNaLnKLe4G3AW1mGRtU/j1yHH7I7XcRQbFVzVO9w+4jlO/5WLXqKUMhDBiDRoCjA5HYXoOO7MzfFHw1NTIEu9X4G7BB4CSbovx7uuKKoO8+LdrcixYLvkg2eaMeUbu9k3kOL8CnuyM4N4Jxqa2yAKVaoFk5vhLa3/gIwivaqKFglLbsa38MddxhUNCzIjXNW92T3fSOU24wAOYiE/Gm5PidLe0EagwSH00lWzml2gf5meBlrbDP2Xmxtj/9Ie8/htWNyVDYLS67e8iZ1PH6W1zpiW5e8Tw8wILtb9tl5VcdFZSyC4+n6qEISefwGwTj0uBjZbteNDTOjamK0iubxy7rxwQETYdcj9J00dlFKRKAexDpqewFI/cvoRICSVndLzMEMLo6NHnAWtUP/risc4jupgUWKgWryU31GuFVdfIk4W0LN2lNztQSK95y/dMgGbiQrveBCSoaBvdFUP9D1knP4bmhJeUiF8/dBqXPunGApH9Ce+xFSnJ8KqishJGLhrMVGGEkB6kciUzzUvQtH9yDX4ISmkKMDukK9kDqixJQkLBA6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWk3djlMQ1B6bTlkNDlVczdOd1RIUjQ1TzRnTnQwbnRVOFI2VmdnTTE3eVlz?=
 =?utf-8?B?aTBPSGVLd0orNlhUQ05iTmdjMzhiYlhWMDZaam9OMXR0cDBjRHRtckszWnFX?=
 =?utf-8?B?NHVJTkhTaTlKUmtMTWxnVitwVlp5c1lVeGFvOVh6eXRJWlZHUnRnS3V2bWcv?=
 =?utf-8?B?bFlMZS9CU2hBZExVa2NRQWpMU3FsVHIycXVlcUVtRmc2b3RBZ0NvdGJjOVFs?=
 =?utf-8?B?MU5xKzQ5c1dveU1GK2s2OWdvbmRTV2dpc2p1KzRlVW9UZjlmS1hZTTBWZk1m?=
 =?utf-8?B?a2I4aG14TGt1VWFKaEhMRit5QTBkdkJFdWpxTXR3ZzEvNFZNWS9PcGRCdVBB?=
 =?utf-8?B?dDJiNWRZbkZZeGpPSTNZTCt5dXRSVFFkd2dua3ozUFk3dnhucnVYdDJNUEJ0?=
 =?utf-8?B?dWhOQ1dPM1k0K2s4Q3NTNENSeHZHYWRXNnRJc0MwZTFWQ1VwMFVKNGh6SzJq?=
 =?utf-8?B?QTE4dHhuOGdUZE1rWW5ndHlPVEs2dWhOSEhYcVFNOTVnc0FSVHZ5T0NCYk5L?=
 =?utf-8?B?NldmUnNicittU3lXR3FUaHRPcURSZFJwYjFQeWNPdVN3Y1JmQ2E3RDJRdlpu?=
 =?utf-8?B?cE4xYXBxUXVuSFp5bXFBS0NRQTdkUDg5U0FFdmVXMmp0T1VnZTcwZnZNUjNn?=
 =?utf-8?B?TzRDSFhScFhWM2haeWpTMmlETUxXNGs3bktlK3hhTGhHU3kxczRPWFh6MERM?=
 =?utf-8?B?YUNIM3N0NWdyZ25VRVkzODRnelM0QWxFVnBYUkQrbVdKK2M3NXRRbkZTYTZN?=
 =?utf-8?B?QUU4bngxbit6VVdyYkJzQVFTaDY0SGE5ckFqdy84ZkJ5QmJzZUpoTllpdXlV?=
 =?utf-8?B?VHhPRVd2MFkwbWx4aXZOL0JyNXBQanlMdW9jaUQ0R2dIK1BZL1lrMmpyd1pB?=
 =?utf-8?B?cWJENzBTS1JudTQxbWVrNXBQSDBGRWF2OHBhQTc0OWRFeW80UCtpSDFPWnRq?=
 =?utf-8?B?VFNkL0tKS3pUL2c3QkpvRFdtdE13WmFVT25hUkFlblo1clhGejMxZzBWRUFG?=
 =?utf-8?B?UTkrZyszeVdCU0JENGVucE9hNFU0OXlUTW9waW5seHpScGMvU3BUL2JRaHoz?=
 =?utf-8?B?Nk9xa1ROQWdFYlhVR0lxSWtqYlBQUzd2dzlmM3dpYlphLzBGRUJmYTFHSUQ5?=
 =?utf-8?B?THdNNytmc3ltV3VYTWdzckR0T1hiNzZyVTM2SW1ycnJZT1JrT1hjYzhLZlJ4?=
 =?utf-8?B?am1xZE9vMVg3Rk1OWTNYUVpVMWMyUVhyYW1QRElvdEl0WWJpR0p2Nm9OZ2Jm?=
 =?utf-8?B?MjlTSHVWamVWU3IweXJINUJRdjRqK1R5VU5GSmNaNUpCR2JmOEQ1RXhCYkpF?=
 =?utf-8?B?RjFSN1F4SUh2Y1hXdXpDMTBZYjdQUnhkR1BhckcvM0VMNVVxUnBPNG9mbEtl?=
 =?utf-8?B?Qy84a2FFZ24ycWNyRVhmS3gzS3BQQTJRUlR6U0hheHBuSjNEM0FaZVo1QlR0?=
 =?utf-8?B?clZFYzJpb3Y1bDhzMTJYdlJ3ZFN6TWxyU29EL2txV0NKaENvWDNqWURWMVBz?=
 =?utf-8?B?eU9pWHNTZllHeVNLdXh5QTcxYjdOV3U0aTNxeXUzSEk0dExndElhVEI1VEhj?=
 =?utf-8?B?Sys3ZWlrWlA5STBuNzdKRUNMK2wzV0tmR0JTb3BGQ01lM1IrVExYV0hRVFI1?=
 =?utf-8?B?dkNZMnB4SmY3Y3lLYk15TEVycklKc1MvenNieWN5dkFOU1dDZVA2c3UySCtt?=
 =?utf-8?B?V1hVbUJNaFdCWjdhbUFBSkFqMzJDOGpZT1ZjYzlkbmhCemlsVTFlQ0duRlR5?=
 =?utf-8?B?NFk4N3NnZkd0bXhEc0FIeC9naHZNeTlHTkpVZkxXcEhXRFd2Ui85TGlOQW9L?=
 =?utf-8?B?d283SlZsN04wRm1mQy9iSjhnNkQ2d3JlRHliK0c4bkM2d09PMHJSYUpZc1Zs?=
 =?utf-8?B?Tm55S1VPUEcvcWhhd3Nwb01aazFBd3lZVklnTGRETXphVXIxVFNlTndiOWtB?=
 =?utf-8?B?dGFkTEUrZmZ1TzJaaGVFNmFMVHJHbENXSWRoK3IvbEpZNkhvdERzRzYvMmRx?=
 =?utf-8?B?WEFVL1BuVEtIekdkK0hsL1BqcEdHb1JDUW5TdS80dGh1bUlnNkpPWHIrQk5N?=
 =?utf-8?B?bHd4MTdLR3BsTWx3aVVKWVgreTA2dThPUU1TZHRKSmJITHdOWE9kWWpsSWtR?=
 =?utf-8?B?aWJMWVc5ckx6YnNtK1UvS1JvdjFIWU9SUktUenRxOElQSkpVNlhGb2FrS2Zv?=
 =?utf-8?B?RTFvVUtJTXFnTFQ1cXRteldYSUlNeVVJYWRMZEUzQUZJTHd6NmFIN0VwS1Nw?=
 =?utf-8?B?ZTY0cmc4NEhQLzdIM2FkbTRkWHlLbjBtOUFxWnlmak1ieXJFU2hQMithYm91?=
 =?utf-8?Q?2ywNzBr70SSLQiRUKH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fda8be-821f-43e0-6df3-08df03564135
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 09:41:50.8635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l38I65Og60+iXjdkj2vy8x/rp0Hlwy+/8zpQP0L6sAFPPAZw5wqV4HlnxP4sHeFy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950
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

On 8/25/26 11:29, Yang Zi wrote:
> In amdgpu_vm_init(), the error_free_root cleanup label runs
> amdgpu_vm_pt_free_root() before amdgpu_bo_unreserve(). However,
> amdgpu_vm_pt_free_root() walks the page table tree and frees each
> entry via amdgpu_vm_pt_free(), which calls amdgpu_bo_unref() on the
> root BO and clears vm->root.bo to NULL. The subsequent
> amdgpu_bo_unreserve(vm->root.bo) then dereferences a NULL pointer.
> 
> Swap the two statements so that the root BO is unreserved before it is
> freed. This mirrors the success path at the end of the function, which
> unreserves before releasing its reference.
> 
> Found by static analysis of the error handling path; the failure cases
> (dma_resv_reserve_fences() or amdgpu_vm_pt_clear() returning an error)
> trigger this path.
> 
> Signed-off-by: Yang Zi <2959243019@qq.com>
> ---
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index d2ad5b0e8759..dc72181ea0fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2672,8 +2672,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>      return 0;
> 
>  error_free_root:
> -    amdgpu_vm_pt_free_root(adev, vm);
>      amdgpu_bo_unreserve(vm->root.bo);
> +    amdgpu_vm_pt_free_root(adev, vm);

Clear NAK, that is just nonsense and will potentially trigger tons of warnings.

The amdgpu_bo_unreserve(() call just needs to use the local variable root_bo instead.

Regards,
Christian.

>      amdgpu_bo_unref(&root_bo);
> 
>  error_free_delayed:
> 

