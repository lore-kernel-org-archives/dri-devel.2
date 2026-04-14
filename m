Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C37BF9D0CD
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A66210E592;
	Tue, 14 Apr 2026 13:31:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cTfu9EDE";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012028.outbound.protection.outlook.com
 [40.93.195.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4944B10E592;
 Tue, 14 Apr 2026 13:31:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfIq9Aa6dyrZhWPZz/WHE/tTvGiHNbGJigZcsZMQ4+FfehKvJH3B16ywrpWA4zR71k2bAWqH+PBSIIQtogD59/RdZ4JI9nTMUT/oXiuFC2M/QhC9i+HXev4VBkxnfn3U1CGE2LkxFXIKpIx+ki0ozb2jiWgpbGaIB2ZEjxTtXHagr9vwfK1ioEJTB3V7fx7MuxDQM5WY8LEPfBV9Ri1DSoF53l5ILybqn/eypCv5PwZT31nRZc9Iq+nstjqHI7shoxYtjCfMT+SRbaiTHybsOoPb+TCeSKtieT+a6Mlxi/jkjiDr7I7uHh6pONLondU6YqyQsxkcikLtLATMWp3l7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdGHHMEgLvb/l2pbrg26mMusQHZwY5RoeuTrxwNKkZg=;
 b=zHPcKNEqOhtatcRUBK+oteYs+G6jjbKH3TIKARylOcSL99R9q3kB9RybJoRUoww82vOb74BoI3mBIxXfc3eTUkciSG/+rLXmOEp4ms7JVFbCpEI1O5Ty3MxlnSHAi0GN23VpFOsFF0pWeMJxnbRWU7S/vPcWOkBX9zjZSRWxIOag+/ZeoB48N9ZQT8/BCxDQ2ebLdlvL/XUG+zjU873cqXbpFbZUr91OxpudRIQDYkuHKDkgDYPyj6Z82iwvdR+31qWL6oQWS6aD4Ls6qV+uTecppgHM1cxQbNj9IqVOYDxFm62d3GTiGtUjzmldGyguRgvT77rWtL2bUGjTKoGm5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdGHHMEgLvb/l2pbrg26mMusQHZwY5RoeuTrxwNKkZg=;
 b=cTfu9EDEQWP5UCDnsImrLqOxJN/Zk9tjhziFoj2m4jroI52bKLCJ1nQDQQjgncyu+NCCPN48Ptpj4lWWHGIF59DDTvJYv2ZMxHwNuQ3n8MD6lrx8+dzIj2ZfBSxXdsfvkj4zf6VtQXQSjfh/JpZnW5vxAvCcAVQq885P9NtD4e4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9156.namprd12.prod.outlook.com (2603:10b6:408:181::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 13:30:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 13:30:54 +0000
Message-ID: <2990351b-f3d8-4a6f-9902-9d558c444449@amd.com>
Date: Tue, 14 Apr 2026 15:30:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: fix root reservation in
 amdgpu_vm_handle_fault
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260414122523.3645-1-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260414122523.3645-1-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0253.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: d3999e83-48dd-42ec-ff3d-08de9a2a0df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: gTyfFiXxu6/s6CJoACrOcbTIbOm6pbIbx3WxzVMzDJ59HeUPTt3FOA5HzDJ36QuISJfZdd6Kvb4atOCpqVbnJDd9SFaUxOQpah6qln8jsCzuQz70XLM3VmdpAe91030MOim7iALPFaKj7v4R40x/+0k1YWgrQ1CdRNQd63u+du3KYsE57qxf4EyL2ptnoo6rCDjx3f3UGSTJgbQAgAxq9rwhYB1H5bBUvw0isDgAKzLgkizhSrR/iajBFuh0d/pgvYP/Jqt1EDcwJ8Q7rhYsgzi7k3iQT9jopJfy19cMzrX0vMM7WL13l6lz0kiJGOmadIhDidSPx5BMlyZzA9bzqrL3M2uUONrnVvF7BiYyA9XutOzkCnTsL9K7RmUqDjUw90t6/nCFkcsOpOE00fQaIdEXq4Y17MxCMbuPfc/FqjnB80LG8cba9tgAooCQ90pXG2/38czGma/NWwrY1tZ2Hph1aDlYGNwfBs+GjuusdQV0LZbxcaNINI5AWsIyL9BCGfzMOLhFHCB9vZpFCX6wCttWRYRu6/lUmnJTaIIIErYdUCfdHnLnCEWN5mFpUulnFnJGrlY83iynFsiYvrWaQkcjqp4qPn7VQuqygQSV/lmd7z2pQ1hAn11mk+1dFB+4envYphMv6P/RNL+PFwoDPO0TmK8SydweWbzLIGUE7cOYpbzA2Uy9uEaydflzkhq67stZC5Xk75t4lB2uoc3EvT8HqMHWxXB5HJAaVEuOS8I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEIxYlRVcDBIZ1VLOXBGVEhYdm0vSS9BZVFKTnJVYktZQjNnZklFSDBpYkZD?=
 =?utf-8?B?a2ZKV1lrNysweEdud1ZtU0RwYkZOc1RtRlZWcXMxU3pWeWJyUHkrYk9nNkdJ?=
 =?utf-8?B?OUtOY3lLUE5hSGFkUlpPZXBIQ3N5RitrRm03UjVvSDVtSEZEcGpsVEZ1T0lo?=
 =?utf-8?B?eVFlQ1IxUm9OaHVkVzBNRDI1RFBsZXBqbC9pOWQycENpZjB6VXNLWkFPNTBN?=
 =?utf-8?B?SkI0MjY5K0xhZDNRWUVkbVJtdU9xVVl0aUJjTVYrejhnRHFjZFVkS2s0QkZi?=
 =?utf-8?B?VXlxTTBRSURHakIzbXUxMExrVHY3ZUFFem9jSGdNcWRxNmV6TCsxUXZXbDBS?=
 =?utf-8?B?THRsV3NqU1k5c2ZhSGZDSjZmblhZeFFXL29LSGl3Z0ZYNFhQT3YxcWdHSi9S?=
 =?utf-8?B?ci9mdG8vWjNtQWQwMU5jVDNjRjBMVFliUXAvTzkwdWxKRjJNRnQ4ZEVPMkhP?=
 =?utf-8?B?VDRGcU5zaVdFK2w0M0FJQWVtN3F3bXRLaFRWOVErQ1lQeElLLzhTNGlISlJu?=
 =?utf-8?B?aTVvQkExRWt5QzcvZ0Jna3p5RE9QeFlPc2ZnTEt1MUtJZWRtSWsxM3p3SDRU?=
 =?utf-8?B?MFlsNy9QSDFUTWw2bXVHb0VNeGxBU1ZzbVNIK0JwWEp2MDlBVi9PVFFLSndR?=
 =?utf-8?B?bGlpd1kvZnFQcml5bzBBQzdxNTBmd1FjT3k5QXZtRkhOVWxTaUJMcmpZU0Yz?=
 =?utf-8?B?S0hBZ0g4K1ZCZ2JHTktVUDFiTWp0dVpnb2N6L3VEdTVVOVFxQkY3Q3UrRHIw?=
 =?utf-8?B?VnYxQmhjYzFJZG5PYnIyL1pjT3V4NkZoZk9sUEY1ZGxuanVrZVFHenZ4enFD?=
 =?utf-8?B?U1RwSEN6b1hTYXFzaC9BOU85Qnd5YTI4WmZ4Y3VmQnRZQ3c4L28yanpOY2kz?=
 =?utf-8?B?cnV6WFBIL0drOHJpUG9PNEJreWhFbGpkbFNSQ28rNkJHRy9XNVZMOEgyeklm?=
 =?utf-8?B?NEZCOHRJbTNGWG5RazJGSlovNmcrdm9UQUVZUjNvREVBOFJGWkU0WlA1STJW?=
 =?utf-8?B?azU3U2pQOFkxVFEzVGdpcHFUTXhSMVBUZU4wSkNlRS9BWGt5ZURpcGtCWWN3?=
 =?utf-8?B?RmpJZDhiVW96djc1NmZLVVUxTE1pQUVFditqT1ZCUXEwUTFCSUdGeStIcy8y?=
 =?utf-8?B?c0NBcVFHU04rRlB2ZU9oc1pQcjQrelFUcFFkWDVTM3JLaml3VUZKVm80UjBp?=
 =?utf-8?B?elppR0kwYXBqTHMvUTZOeE0ra29kL2xNRVpIQzhMMWhFTk5MZU5oQmFpay91?=
 =?utf-8?B?dVF4U1IvVmFHeW1peTNXbFNjekNpdUg5dGNMbkRSN0NrcFlQckpXdFZCN3hl?=
 =?utf-8?B?dlVDNGgxY0EyQW0xZVBnMUNqSEMwNUxsZGpHYVdpUGU2eHNiVWo5SXVGL2Jy?=
 =?utf-8?B?QzBNNURvaGE2dkJQck9mT2RXMlhSSTRkUlhpYmgwRFBNT3NHcmYrSy9FYUtS?=
 =?utf-8?B?bThmNXNkUlh6TGJFZzNJUXhqUEpCMTFMUDhLRER3bXNNb0xRVkFWK3NKdFZs?=
 =?utf-8?B?VkxPQy9ra1E0U1hhVHR6Y09kZm85QW5YU3BMTm45elpIZXk3bzJuT0Q5cWtu?=
 =?utf-8?B?eUdXSlVHRVZLaENpeS8wTjFWdVV1UUYvQ3FCMGhWbVhoZVpiS3lJenl1QTFO?=
 =?utf-8?B?UTRaY2tsQXpJVUFlc0Fha0Y2Y0ljSG52Zkp5cTlSazJqNmlsZkJWbzNNQ1NT?=
 =?utf-8?B?NEgxZnpGSUZIWnJZYmJMakF3OXZDcnlXclVzL3BGVTRTZjBwVjFkaTJTRURO?=
 =?utf-8?B?N3JkTWtLN3dCRE9rZ2xpVzdTek8xd0NXSUc0TURMcVp6NzVHb2Yyb281R3Va?=
 =?utf-8?B?TlNYSTErWHM2azlyS3YvR1BZNTA3dFdsYWgwY3A0YUNmSkVDTXQzb0hYY09B?=
 =?utf-8?B?UlZQUHc0UUNwcEpSMWhoT2YveVdDSzRadk4rdngzU0cxYkpvRzB3ZnJIK1g2?=
 =?utf-8?B?UitvNE9iRU9PTUZmcCtoSE9Ya3NsdDZIa25HV2J5clZPU0Z4Sjlxcy91cmV5?=
 =?utf-8?B?SnhWYkhhNEFqamdHQnhpU1gwM2dreGFqcXJEUXVHZzZHQ21Xa3Zabk80MUxz?=
 =?utf-8?B?bEVGc2V4Um03VGtrQ1J2S0RRYkFmOGdHYmFYTmlZT1lPaHk3UTg1TTFtMktY?=
 =?utf-8?B?NTA0OCs0TWRTdm96OFhNd3RjUEVNTGNCdFp0VHBTYllhYi9sUzRwdTRBUFk5?=
 =?utf-8?B?RVFiUlp3RG9nODdIbzV4OE05YVRYaGNSWWFaU2djZkUycnJRVmlCNUVDTVNJ?=
 =?utf-8?B?TjV1eWREWU8zMnlEaGI4UjhucUNuTFQ3ZnZNb0JFdkZTd3o5alJrSkJpSEJw?=
 =?utf-8?Q?cnBpiUIuSOLJS5UjXF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3999e83-48dd-42ec-ff3d-08de9a2a0df3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 13:30:54.7734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uj4YburTmmrV0QS8n/8S86VJu7iNSN3AdBNwP61i8eEOsjD79EJ175hROkwok0lP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9156
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

On 4/14/26 14:25, Pierre-Eric Pelloux-Prayer wrote:
> svm_range_restore_pages might reserve the root bo so it must
> be called after unreserving it.
> 
> The code checking that the VM still exists can be moved in the
> "if" block, since the VM can only be removed when the root bo
> is not reserved.

That won't work like this. Dropping and reacquiring the root BO lock is a pretty big nono.

I think we need to fix svm_range_restore_pages() instead.

Regards,
Christian.

> 
> Fixes: 32b486e8541c ("drm/amdgpu: extract amdgpu_vm_lock_by_pasid from amdgpu_vm_handle_fault")
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 35 +++++++++++---------------
>  1 file changed, 15 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 63156289ae7f..d86be0108913 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2975,25 +2975,12 @@ struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
>  		return NULL;
>  
>  	r = amdgpu_bo_reserve(*root, true);
> -	if (r)
> -		goto error_unref;
> -
> -	/* Double check that the VM still exists */
> -	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
> -	vm = xa_load(&adev->vm_manager.pasids, pasid);
> -	if (vm && vm->root.bo != *root)
> -		vm = NULL;
> -	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
> -	if (!vm)
> -		goto error_unlock;
> +	if (r) {
> +		amdgpu_bo_unref(root);
> +		return NULL;
> +	}
>  
>  	return vm;
> -error_unlock:
> -	amdgpu_bo_unreserve(*root);
> -
> -error_unref:
> -	amdgpu_bo_unref(root);
> -	return NULL;
>  }
>  
>  /**
> @@ -3026,11 +3013,19 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>  
>  	is_compute_context = vm->is_compute_context;
>  
> -	if (is_compute_context && !svm_range_restore_pages(adev, pasid, vmid,
> -	    node_id, addr >> PAGE_SHIFT, ts, write_fault)) {
> +	if (is_compute_context) {
> +		/* Unreserve root since svm_range_restore_pages might try to reserve it. */
>  		amdgpu_bo_unreserve(root);
>  		amdgpu_bo_unref(&root);
> -		return true;
> +
> +		if (!svm_range_restore_pages(adev, pasid, vmid,
> +					     node_id, addr >> PAGE_SHIFT, ts, write_fault))
> +			return true;
> +
> +		/* Double check that the VM still exists. */
> +		vm = amdgpu_vm_lock_by_pasid(adev, &root, pasid);
> +		if (!vm)
> +			return false;
>  	}
>  
>  	addr /= AMDGPU_GPU_PAGE_SIZE;

