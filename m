Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58252C624D3
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 13:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 524BE10F1FD;
	Wed,  2 Sep 2026 13:41:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NfYfC0kw";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CEBA10E616;
 Wed,  2 Sep 2026 13:41:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmVaCi7R/aOvcP9RfpKcTTRfhP6EwU+301E59Dxp2uWhorfp9v23huxkGejPfZvEiUozLLeWTTOur4aDZ5TrlU2JzR/kQzPng2m6HNctNXV3v5oRCKNFXfSJQt12ndf4y5NZ8OufP2zbWX4DBfDBDK0OqtZuoWtMOJmpSMg8AbR2vAAy5qZkkBhBB1zqCtKTneptjx/40kp7kgUgVJY5vHZw7Hq4BFjbevH09p947AbL7wUgDPyk5ts+Zr7DuGANEbvZP9xiqlmgV/AprqXVT887vEEVxFJQZQuuMeqNhN+OmI/FGRzEWMV/QF0oQMaewSE+eqnkqh5v6ydBFOnKLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xfoSt0sy7cTD+smdM64fYXGcM4ZatinZ0UGj5tiiPc=;
 b=pu/ssChnF7GLLatVpYI3x353PljIacVAub8jZ7T30632OI1gs8YP0XV/9WMfw9is24Vv7pa7tM5uDcIVqdlEI5W0BJBOJ0MpEKG0wJNTsrC6EWh4WLvlOSuDvCiP+wdi+H3r8/uBjCmcyVusflT66+WO2Y1klJTvL/Q7tsBrtKRUqp73nYpf4M256fdI+P6JocqwVyB/MRBGXp583612y0iImTgkm2b59w+JMWBWziXhR+X6j36RpbNhHIx4QRlte0mH23k+EPEHzpS1/U9XSVZSWu/8mFlU4d4u7OCVhS2VLc53UshR2na2bFNee0sgiR8IVT7T0FKRFkm1Rl4TXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xfoSt0sy7cTD+smdM64fYXGcM4ZatinZ0UGj5tiiPc=;
 b=NfYfC0kwdiK8XAJYQ+fXmL62hwQLEY6qH5E0AMSynm7HjF/H3k1SPC+70p0v31xHlhu1gSOFLi/6FcBb3rJrNWe0CDG0jbc3JPxk0DFVskSRfNy+lWsrWxHJ7S1CVhbozu+bDIZoX+tnJ3OAeQSoqFm2EcpXvx1ve1/k6/djEqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:41:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Wed, 2 Sep 2026
 13:41:44 +0000
Message-ID: <da43b0e3-5bd9-4aa1-86d3-b733f3bad108@amd.com>
Date: Wed, 2 Sep 2026 15:41:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: reject out of range PFNs in
 amdgpu_vm_update_range()
To: Andrei Rusu de Castro <arc@empyreal.works>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, airlied@gmail.com, simona@ffwll.ch,
 sunil.khatri@amd.com, Prike.Liang@amd.com, timur.kristof@gmail.com,
 nat@pixelcluster.dev, mikhail.v.gavrilov@gmail.com,
 pierre-eric.pelloux-prayer@amd.com, srinivasan.shanmugam@amd.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260902-vm-4f19ee6f@empyreal.works>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260902-vm-4f19ee6f@empyreal.works>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7dc54c-f288-44c2-0ecc-08df08f7ed9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|3023799007|10067099003|5023799004|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ozL97/semYRkaG29DLdSUJVMmKCcatPYD4WvhN6g6lK0kMWp9k5+wEzQUgggt7ie6nEo68vDnHNRrW04EY2jaRY/4y9HJBfW1h16PoRhmMcesVBtlgNunAMf1U4SCPb+IKlZCZBMh+sQM2o/h2405/UH74ETRCCJyyaTMGpBaCrbVBJ4OGesvdem5rWa5Vy6VP8O5AjTBlzsWsPuyB4Qum2HBOTDjfMhRcsQstO1KRsLLutWstkTnnyB+nCS8Z0+Rws2xnb5E04mXpg4Gbz4SymZYP1xE7Uy9ovbXroUO6RArtt5OSLCn7d0uKWdet1UBsrOlea3KHrhi7TDrLrltp4enaCa0Yk66QCSCPFZ70g6XedbTN3u97cUfgjEcjbRjdb5WANUPPG7Bg9f4jTMp+Cjj+L82wbJgL/ufb6n5llaEwfmsIRzPg634l2ANxIDk7e9S9sDgFoDzYDaJxP3eEt/DBbGLK41zR/FlE4VDCtkh6pObmIE83kZSCugX7Orh1B3eJtkq3AeVA95JodUZMuF3+fWeAMvTce4uCFoXDWvV5MaRAjdateM6jTBrV2xFOcMpDub7+Gi1pjvOmuDVtBPPb8M5Rq/ISiOmtA7ZFaq3a9eRZdUbqsvHiRsqiD4w7cO5vujaNoSDziSrfAQ26m+KhijRvp5OFnpDoYh4RE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(3023799007)(10067099003)(5023799004)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDlqK2dJaWV4c0FFanBxZW1RMGMxNXNuUExWK3B1a2VGbXhUOFFPYUtFeXcz?=
 =?utf-8?B?QmRMVEFNUEVlRDRHOFVnek9lV2NYYzZNYWdPS3J5bzhQMGYxTS9FenFHRzlx?=
 =?utf-8?B?MFJCV0d2WVZxMW9mNXczMGNZNlRMeFlvR1FsdDBZZXIvd3MxSEprZkJNWnh5?=
 =?utf-8?B?dklNaHJXeVFTYVBaTGQxaktITFExSkFweG4vVjdBbWIzaEdIR1V5VjVxMUVU?=
 =?utf-8?B?bTJZUXVyQzA5MHNIWVZUK0tlUjUwdDIxMFNzUTB1ZHlrSGRFdGR4WFF4cTls?=
 =?utf-8?B?SUVNR0d1TCtESHRVUEMxNWFVTkkycXEyVnBkYy84NWVNbVhJbUpOSnQ1L3hv?=
 =?utf-8?B?dnIxSGM1OGNIdkxubURtekxjZGozcEJnVlQwRnlDUkU5azZtNE4rOUNmSkFI?=
 =?utf-8?B?QWRHeTM5QnhkVEMyWlRpSGhCL3RNTkh1eWF2dzBoenYrallVT2F3VTdUbE5N?=
 =?utf-8?B?cDh6MVVFTktDS1VzZEdSTHIxQno2cTNRTHlUTm9OWHFSTFQ5amFKa04rM2hu?=
 =?utf-8?B?MWZjdzBUbGoyTDFXYkRlN252R1paUmNjUWUvZHdvM1hvamwycWlxRDFqdFd3?=
 =?utf-8?B?ZFA5VVNtcjZGa080QURkRE52YjRMWlppU1lnbm9XSjlKRkxaRWxrU0FVNHFz?=
 =?utf-8?B?ZUJGR1M3RjNDd1hRWEptZVVxRzBPd21XODUzS081b3N4SGlhMGlvQi9HODd5?=
 =?utf-8?B?TkR1VHBHUndxWkdLMFFkaFloelBIQjFRQmw1S05VN2ZYNDZwT1BiTGxmVWdl?=
 =?utf-8?B?REk5OFNGYUVWTCtUNm1HeDVIRXo4NXdrdkpBZFg3ZENWWE9GeWNFNVJoT3pS?=
 =?utf-8?B?SE9OOUVaOVVtdkl4RFVZRGcweW1QSkloRGhRbUJyaUtodE14RW5uamFXYisw?=
 =?utf-8?B?eXZDVXI1M1RnR1Y4TWVLQStuSWdsUktVbDRsRCtkSmF2WncraWRIMjdmRFJJ?=
 =?utf-8?B?L1VWMkI3Z0tWbXdwOHF0dHhERjkvNmJIYW53MjdBY0lvY2tQVkFWZWtqTUVP?=
 =?utf-8?B?aFFRMHFKVHNibk1HanVVYkN2L1prS2dlVmF6ekVrTk10MytxOFlmT2xnVGVx?=
 =?utf-8?B?YnpndXlFejRsdDNFUHFqTmlwcWs0TWZGWlRORENXUkRrcE9yblN5bUtBOURJ?=
 =?utf-8?B?eGI0MU81WjRyQ1ljQUVsTGVnNUwySlhqSVFWN254dHF0enhvR2tnMlg1T3hh?=
 =?utf-8?B?Q3pwZEZCOGZkakJlQzFGT2ttanF1UUZmM1k5UXZNU2hqYnZZbEg2Um5MMjdL?=
 =?utf-8?B?alhJeFVGWmdUVk51b0x3VWxrdCt6cE5FOFhRcCtqUmtXQVIvREV0cnhiZG9U?=
 =?utf-8?B?WXpKVUlSNmc1ZjcvS0JtSmxMYTJlTTMzVHhiRWM5TUZhZDQrSkZMOGtobXhv?=
 =?utf-8?B?c1ZlY1Y1RGpKeHkrTXkySE1OUWQzNTQyK3pnVHg4QXJCS2oyNk02TERucURr?=
 =?utf-8?B?bXI2Z3RrOFZMNnh5Wm15MFlHQ3R0cVA1STFqWmhYV1FUWnB1ZGFvT2dEMlRl?=
 =?utf-8?B?TER1RWIvNVNaTGZFTVNsVFZwVUxPU21jbUxaWkR4WTNsTjNkQjZzNFkzTFdu?=
 =?utf-8?B?dkNSNGU5MGZCVXB0c1FrV3hFOXJEMGJPelpiN2xheXlyNXZzbHRxRThVL3lv?=
 =?utf-8?B?OGF3UWJiaHpPWUNjNEVSOWdLakwzNlBWTUM3ampXQXNRcWlmWXlMaFdGOUtT?=
 =?utf-8?B?eHJudkMzT0hDYzYxSHdvNUZ1ZzVQNWNiYzRWck1YZjdhUDAvK09aalQvS0tv?=
 =?utf-8?B?THpPOWNFTlVyL2Fnd09CbjhJbHVGa0FQMEZpeGdYMmp5MlRSZXJvc0cwSWdI?=
 =?utf-8?B?TzRvT0dyTnRBaTByNDBYVlA4L3ZjSS9aR3ZMaytrOER0U0YzQ1p3MTUwcndQ?=
 =?utf-8?B?a2tLREdkRjU4Qm8vbUdpNU1uMUxZQ0hnS0tmRlNKQmNFNGhHaE1iNjJ1T3ZD?=
 =?utf-8?B?cXVoYWsvTEpvNVBtNFc0SGE2cldWM2hLWnNvaTltZ1hxVFFmdlVkZUlwNjAw?=
 =?utf-8?B?UXo2dHo1NGdoVWpKclUrck5JaDkvR1RHeVJub2FxZmtmblc2cVIxalNzL3ph?=
 =?utf-8?B?ZFJlNU52SldtVCs0d2lUM2NaZUFLQUdHRDdGdi9yZFdxenZmWXZsZFpZWVQ2?=
 =?utf-8?B?L3dick1iYllrcXo0TTAzeWVBVm9GZFZNT2M5d0R5dENiS1NURVg0NnF5SHJD?=
 =?utf-8?B?eGYvTnBoTXI2RFF5RHlwU0FJVkVobTc2YW05ck9UV05lODJoVTVkOUZ2T1Br?=
 =?utf-8?B?K1pxUDhQR0FnTytUWDhMUEJQNW1HUytFRTdyQlRrc1BoYTFRNk9oa1dFWHZ3?=
 =?utf-8?Q?74/NyEvoXKG8EMAkma?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7dc54c-f288-44c2-0ecc-08df08f7ed9f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:41:44.7946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXRVr7soA10MQVzFaW4mgjmd6zN7sjWpN/1wP0u9FVa84iNe/fELfF/SH8G9LL1Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294
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

On 9/2/26 14:25, Andrei Rusu de Castro wrote:
> amdgpu_vm_update_range() walks the page tables for the inclusive PFN
> range [@start, @last] without validating it. Two properties have to
> hold for that walk to be well defined, and both are currently left to
> caller convention.
> 
> The range must not be reversed. The resource cursor is initialized with
> a size of (last - start + 1) * AMDGPU_GPU_PAGE_SIZE in unsigned
> arithmetic, so a @last below @start - 1 wraps to a multi-terabyte size
> and the update runs past the intended end.
> 
> @last must also stay below vm_manager.max_pfn. Unlike the lower levels,
> the root level uses a mask wide enough to be ineffective. The page-table
> walker derives an index from the PFN and applies a 0xffffffff root mask,
> while amdgpu_vm_pt_num_entries() allocates the root directory with only
> 
>         round_up(max_pfn, 1ULL << shift) >> shift
> 
> entries. A PFN at or above max_pfn therefore indexes past the root entry
> array on the first descent.
> 
> The buffer-object mapping path enforces both properties in
> amdgpu_vm_verify_parameters(), which rejects a zero size "which also
> leads to end < begin" and an lpfn >= max_pfn. Ranges reaching
> amdgpu_vm_update_range() from amdgpu_vm_bo_update() and
> amdgpu_vm_clear_freed() come from mappings validated there. The retry
> fault handler instead forwards one hardware-reported PFN without
> checking it against the configured aperture.
> 
> The KFD SVM path is not covered either. This has been possible since
> commit f80fe9d3c114 ("drm/amdkfd: map svm range to GPUs"), which first
> mapped SVM ranges into the GPUVM page tables without an equivalent bound
> check. svm_range_map_to_gpu() and svm_range_unmap_from_gpu() check only
> amdgpu_vm_ready(). Their callers guard against reversed ranges, but
> nothing compares the result against max_pfn.
> 
> When amdgpu.vm_size configures a GPU virtual address space smaller than
> the CPU address space, a process can register memory whose PFN exceeds
> max_pfn. A range near 113 TiB against a 256-entry root produced index
> 116128 and oopsed in amdgpu_vm_ptes_update().
> 
> Validate the shared page-table-walk primitive rather than relying on
> every caller to duplicate its root-array precondition. Reject invalid
> ranges before device entry, allocation, or locking. Two in-tree paths
> can reach an out-of-range PFN once the aperture is smaller than an
> address a process can touch: KFD SVM and the retry fault handler. The
> fault handler will now log -EINVAL and return the fault as unhandled.
> The validated buffer-object callers are unaffected.
> 
> Source and call-chain analysis identified the missing
> shared precondition. The amdgpu VM and KFD SVM objects and the complete
> amdgpu object were built with W=1. No runtime test was performed.
> 
> Fixes: f80fe9d3c114 ("drm/amdkfd: map svm range to GPUs")
> 
> Signed-off-by: Andrei Rusu de Castro <arc@empyreal.works>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index aedf72c2333e..f9a46d706340 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1140,6 +1140,14 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>         struct amdgpu_res_cursor cursor;
>         int r, idx;
> 
> +       /*
> +        * The page table walk indexes the root PD without masking, so an
> +        * out of range PFN would index past the end of its entry array.
> +        * A reversed range would additionally underflow the cursor size.
> +        */
> +       if (start > last || last >= adev->vm_manager.max_pfn)
> +               return -EINVAL;
> +

That is certainly not something which should be checked here.

The SVM subsystem must fail to initialize if we can't represent the addresses in the GPUVM.

If we end up here that is way to late to check.

Regards,
Christian.

>         if (!drm_dev_enter(adev_to_drm(adev), &idx))
>                 return -ENODEV;
> 
> 

