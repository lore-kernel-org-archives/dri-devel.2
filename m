Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF714CD4F54
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 06:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AEB610EAA2;
	Tue, 19 May 2026 06:42:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0UV1oA1N";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012030.outbound.protection.outlook.com
 [40.107.200.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C47D410EAA2
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 06:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEzAVXahcLJlgeVhCt4JIybVAaK5a0h2MOMPnUZdUZilWEX6VmES84tF7tYxKTpnQf3+MWfBAhXe9gMfnoMk67PmcYBgFhRhogyoz7xQnnObpVB5zdWOfUTVzjai5EQVNXqrj5RrOG6EmvgjurPLD0n6JV02Qy7LXaOFirODXL5viNCTpTZkeIIU7lwXSQPuVKUtF/pik08BTejMBFy3M7TmaqA+u7WTB9tYkYuGkWLQWMC6A4udwM1oMq4y0ob/jY2LPgx5oHc4QJjD6pETtgd6b4mcCkRJnRH+AJU6c+TMMSRLVfBLjjJQM16jv5WQRRp2MO8awFEmwk7HzdXNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7sY/foZAH43jstdkkGZNaT7YS+iuWy02Cy+I+1W2FY=;
 b=m+bQka9EVBJG5uEwVOK3/hJ0W2lMHNtvJa6cTZX3K8Oi9DGk7xPEIloYauIyvCPiGaH4PVDv2ABZo4AeQRg7M2DD4HpYz2dzET4f4wr/oyh+l278n1/BZm4690QIwMSsVdEqAWW0RJEqygB2NTTnsFjCc1ZELChtLP+w4vWIbPilhfhcv2/6NISxsu+rRxw/PPnW6rcjpcTdvps3D0nulqWOo6tYCVBk2K2gsqqtZK3zCrX4Ouks525my9rls9zEl0Heyf2CAwy7dpPd32R9E3drSZxZSjqxUkDlLnW1CKBrb20vweVM7Btp6KRHcgjmArG5wG9owaPWYBkiMLR0ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7sY/foZAH43jstdkkGZNaT7YS+iuWy02Cy+I+1W2FY=;
 b=0UV1oA1Nkeo+bgYZ7qWRIFOvevl5b8/2YMcvnENR8nwhIr2RPS6wB+qV4f6UeeLInL3Kt6aWKYEbaFtzDiWxI+VvEQ2w2LFpLdkjY4f0fgmeQYyQlu/LaaDJ+C4m8wCPhlD3ZkDLS42II2kDQACtgP234w9Crb9mTOMsaELPDA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV9PR12MB9806.namprd12.prod.outlook.com (2603:10b6:408:2ea::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 06:42:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 06:42:32 +0000
Message-ID: <a83bfea0-7d3a-40cb-a437-5be09d59660b@amd.com>
Date: Tue, 19 May 2026 08:42:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] accel/amdxdna: Remove mmap and export support for ubuf
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, mario.limonciello@amd.com,
 karol.wachowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 dri-devel@lists.freedesktop.org, simona@ffwll.ch, max.zhen@amd.com,
 sonal.santan@amd.com
References: <20260518155706.937461-1-lizhi.hou@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260518155706.937461-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::14)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV9PR12MB9806:EE_
X-MS-Office365-Filtering-Correlation-Id: 99f05abe-9ab0-4395-a7f7-08deb571cdcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: hGQ9YPaWuMehKah0MV/sN9iyp2hd46/r56ymbDYzmC9MGzuznc6CmJmimO7RLRnbBRUDgYtvF1AooqLzmNC8B5RGp68ZiUIFGcXONSQcTiceVWKrTdfFNbtuPbmOJUvOsHJgiuHVQYbymRRbNClf34sLe5KXFZU+d3LvF2R8FdqM75deqQbNgcj2DGPK3Z45JKi6zDv8XqBsE64DrQ/4RyznCxn/Lf0V6RpYSBIiMBahvo1Nrz37t3cZcXzkdAxma8QBBpP7oD2RDosX4rq+4G9E777AY4drGJG97H7U+6ooiQHdWMETDEXrFqeG3gj3euCKuthHiD+E2u5+vKu2mdbB1qMdm9QrNqCIE6NMlNjCoKWtBmLZGuhlcFnRv6B5BHcX18TqX9V6gdL0nFe6vWWP5O56cOS73AjGE/Yex9prjgLKnrwYqBvteCek7/2yJKM8A+bp0miFO8r5sO7FCm0F5zGQNnxMF4ylsEfP+/qyGMryhqKpcLpAP3xVn3uXrUUX6KcBEmbBNHujuGHJhMYotYjJfhYARPtCg/xU2O/S19PRp0NsIFSfu51MvXadR9t26Gl2gACVTV7N0USCC8hl1apgI/YgkRvR4RsolZIKb5MXOZNf/VaTsNbUaAcrwdk7HxWU3+eg4fAkAcUp2+p5nRfv+XEPpNSyfnrmik0wDkCwQ64sJoynJ0Uk9+c6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2ZKZjRXa1RuVEZFRmkrcFZ1TGJoTkVicVF3OW9HdlVxZ2NRTkJQZlRHaFFP?=
 =?utf-8?B?MEJtZzZJbTRma1did3Vnc1Bwc3RiZlNkK2daRU9FTk84cVloOVBpT1pTR3Ru?=
 =?utf-8?B?R1FkTTRtTWRoWFJRQ0dlekVRU2ZzanFUbkJabkxlL0xmcWoweG1iUDlxa29r?=
 =?utf-8?B?SnRLWmJkdDN6VnhtTXdZYVNocGZORnFRUGdDU2trekl4ckNVUkdncm15ODJt?=
 =?utf-8?B?eXUvRmpEMGpzR2g0ZmRpSmp1Wm1kS3dkU1ZabDVSb1pYc3M1ZEpyTWJZL1F3?=
 =?utf-8?B?T3VMbktpZHJCNXJIMlZHenVRNzVmYnlPcmh0TUVVMXI4OVJhU2pMUFdYRktu?=
 =?utf-8?B?T3VzekRTb3FYR3RXaUR4bnRxVlZUQ0UyUXFqTHpiS2sxRUdOMmpuSGFIRndj?=
 =?utf-8?B?czRCQ0JwWXhreExRZTZEK2RCNllMZTZLRU5VYzRjYXFwSEFHd01PVlNFa2M3?=
 =?utf-8?B?N2hmVXZ2OUYyblQ1d2U1T3h0WGlvUUExK201N0w0WnZkUnRjNWhIM3dHRkRE?=
 =?utf-8?B?OURoTjJhdzBGVFprRDlzREhVeWtpeUJuVXJVTndxMkpvQ2xJMTNsUFRUeGsz?=
 =?utf-8?B?ZS9nUHl5RldnaGJXU1VQWHJQL1FiZ3p1YU9pZEFRaG9INUpPanJzcyt6MlIw?=
 =?utf-8?B?ZUVxLy9rNXQyUVZzMEZDN0JXQWR6Q1o2U0kwbmUwRzkrVjRMUjcyZkNoamhi?=
 =?utf-8?B?NVY5ZC9ZdTh3dXExVEJ1LytJZmRaZkdwK2F3NHkxNk5WbER2ZStNcVZBT0c0?=
 =?utf-8?B?UkNhcE9GMUh2djg3bHVBRzQyM2tsdGNMME5uNDNFbkZBUWlNRFFueVJMb3Jm?=
 =?utf-8?B?VElMRmpBNWV1MTA3L2kxVDJldW0xVVpaaTFyUHFvK05wWVY1V2dzZGhWNStu?=
 =?utf-8?B?QjhYbGQxWXB4cHFhS2txYW5iY2Nnd0k4cldwaEpWYWh5bzlTUjlmMWdMcFpl?=
 =?utf-8?B?L2JOYzFheVVIelFLWG9wcEM2R2tEWmp5b25FRGNCYS9zaFBSS3dFcUlvU2tw?=
 =?utf-8?B?Wm82R3JXTkhaNkZFN1MxWDQvSDU4UnRiQ095Q29MWnhyTGdEWWtwS2plc1NW?=
 =?utf-8?B?Vzc4UXVwdE1kMEc2aWpkeTRYVThaZU1BRnVqRUhIdm1XcXhLbStVekVza0xo?=
 =?utf-8?B?R1NhY0lkUDJIRmE5cWx2N3dZOU1kY0FVSmVpK2FvTEsyMkVlN3FxUkI1VWVI?=
 =?utf-8?B?enhiT3NnajlON1Y2MzYyQUZ4N091dUx6ek9zb09XTEs4TjNua3RMbWJnMDc0?=
 =?utf-8?B?TFlHSGRrUVpRVkQ4WnBhR1RqdGxSTk5CNlFSa3VtcE9FMG1Nam1lMUs0eUgy?=
 =?utf-8?B?eWg2VTdndjhZRzJCTjZPUUo4bGZ0aFdnNUswVi9McmZXQzNNU3FQd0szV2kx?=
 =?utf-8?B?N3YrOUs0L1FrT1ZMVTArRWpIQk1Bb0s0WnRFTkY2TkNnN1ZOWDRvZEtBejJB?=
 =?utf-8?B?RzcyOGtJS0lpaGgxNllTQ3M1NDZVaW5lV0J5UkxPUU0yRmRrdkV0V0J4eVNI?=
 =?utf-8?B?SzZva0drbWZjUzRGODI1SGhIR0xnQTZ2NjU2cXBQOVA0cEo0WmJTZTZqTWxn?=
 =?utf-8?B?b1pEMDY3NDdSWTVud1lDWnEzUEJycHlRbGxzWldGaUJLWWNiVThjakU3cXh6?=
 =?utf-8?B?V2hoZUJuOEJ0UW1XQSs5aVVsWVlsOUNyVFFjSFRLWkJYeXBaTzFSaFB6VkpP?=
 =?utf-8?B?NnZaWmU1dU5XOWhwVUVWQ2NDZEE4RGx1ZnBxVjVUUW0xZ1dkb2RzdnFQZXRx?=
 =?utf-8?B?UkZycER0TkkrN1FuNUkvMXI2L3MrR3RhNUR6emFPSnNNV0gzUk1XS2F4dndX?=
 =?utf-8?B?QklncEJkNWtWMFZaVjBCelFjNFkvYXlYY1FNZjlDcHhQc3RCU2dXcW1LaEd4?=
 =?utf-8?B?dEgrUVJjTjMwME43WkEvMHE0UTVjZ1JlK2F5Q3hQY0dVV3FudWtTYXNCZE5I?=
 =?utf-8?B?U3hnTWFGdVQvYWF3aFpvWTkrV1VKTmZiSXc0QjRPbXFyejlZZTE1MXFXemNF?=
 =?utf-8?B?cmJlSTlta3p6RllIRmpwZVlPUVhLa3FnMkEzWWhUQ25OU0NNcElpeDdJUWhF?=
 =?utf-8?B?TkpYUDZwMDR6TXFCVllEZ2xBdGtrNUhoUXpiUVZXYVVObjI3SFIwWXFBa2kv?=
 =?utf-8?B?QVF2RTBUQU1Rc0JXVUlLVmtvcEpuQWRKenhtTmtBOEJSTkFSN3lUaTI2bUpw?=
 =?utf-8?B?SERuei9jYVpic1kza1hTS0tRK0hETTRGT1ZTNmJCUUxEQTdTZklWdmVTVXQw?=
 =?utf-8?B?Q0pUczU3ZklTZmV1SUlmZEdsVGdZYUd1VlZCeGQ4dXFSd240UFBzU0VWb2R3?=
 =?utf-8?Q?w0frpwGxunKdcPun7P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f05abe-9ab0-4395-a7f7-08deb571cdcf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 06:42:32.4264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFjhA/EeCyvAb0Kl6BpDuKRbKYHo7AMTfXNOM+nvj6jl3lAJNuxVECzyXLTrc5r6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9806
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

On 5/18/26 17:57, Lizhi Hou wrote:
> Ubuf pages should not be mmaped or exported. Remove the ubuf mmap callback
> and return -EOPNOTSUPP when exporting ubuf objects.
> 
> ubuf vmap is also removed for there is not a real use case yet.
> 
> Fixes: bd72d4acda10 ("accel/amdxdna: Support user space allocated buffer")
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> v2:
>   Remove dead code amdxdna_ubuf_vm_ops structure and amdxdna_ubuf_vm_fault
>   function.
>   Rename Non-exportable buffer flag from 'pri' to 'private_buffer'
> 
>  drivers/accel/amdxdna/amdxdna_gem.c  |  9 ++++-
>  drivers/accel/amdxdna/amdxdna_gem.h  |  2 ++
>  drivers/accel/amdxdna/amdxdna_ubuf.c | 50 ----------------------------
>  3 files changed, 10 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 319d2064fafa..6b9b556de555 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -492,6 +492,9 @@ static struct dma_buf *amdxdna_gem_prime_export(struct drm_gem_object *gobj, int
>  	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
>  	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>  
> +	if (abo->private_buffer)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>  	if (abo->dma_buf) {
>  		get_dma_buf(abo->dma_buf);
>  		return abo->dma_buf;
> @@ -716,6 +719,7 @@ amdxdna_gem_create_ubuf_object(struct drm_device *dev, struct amdxdna_drm_create
>  {
>  	struct amdxdna_dev *xdna = to_xdna_dev(dev);
>  	struct amdxdna_drm_va_tbl va_tbl;
> +	struct amdxdna_gem_obj *abo;
>  	struct drm_gem_object *gobj;
>  	struct dma_buf *dma_buf;
>  
> @@ -742,7 +746,10 @@ amdxdna_gem_create_ubuf_object(struct drm_device *dev, struct amdxdna_drm_create
>  
>  	dma_buf_put(dma_buf);
>  
> -	return to_xdna_obj(gobj);
> +	abo = to_xdna_obj(gobj);
> +	abo->private_buffer = true;
> +
> +	return abo;
>  }
>  
>  static struct amdxdna_gem_obj *
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
> index 4fc48a1189d2..957305ccb485 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.h
> +++ b/drivers/accel/amdxdna/amdxdna_gem.h
> @@ -54,6 +54,8 @@ struct amdxdna_gem_obj {
>  
>  	/* True, if BO is managed by XRT, not application */
>  	bool				internal;
> +	/* True, if BO is not exportable */
> +	bool				private_buffer;
>  };
>  
>  #define to_gobj(obj)    (&(obj)->base.base)
> diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
> index 3769210c55cc..bb60fb80467e 100644
> --- a/drivers/accel/amdxdna/amdxdna_ubuf.c
> +++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
> @@ -69,60 +69,10 @@ static void amdxdna_ubuf_release(struct dma_buf *dbuf)
>  	kfree(ubuf);
>  }
>  
> -static vm_fault_t amdxdna_ubuf_vm_fault(struct vm_fault *vmf)
> -{
> -	struct vm_area_struct *vma = vmf->vma;
> -	struct amdxdna_ubuf_priv *ubuf;
> -	unsigned long pfn;
> -	pgoff_t pgoff;
> -
> -	ubuf = vma->vm_private_data;
> -	pgoff = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
> -
> -	pfn = page_to_pfn(ubuf->pages[pgoff]);
> -	return vmf_insert_pfn(vma, vmf->address, pfn);
> -}
> -
> -static const struct vm_operations_struct amdxdna_ubuf_vm_ops = {
> -	.fault = amdxdna_ubuf_vm_fault,
> -};
> -
> -static int amdxdna_ubuf_mmap(struct dma_buf *dbuf, struct vm_area_struct *vma)
> -{
> -	struct amdxdna_ubuf_priv *ubuf = dbuf->priv;
> -
> -	vma->vm_ops = &amdxdna_ubuf_vm_ops;
> -	vma->vm_private_data = ubuf;
> -	vm_flags_set(vma, VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
> -
> -	return 0;
> -}
> -
> -static int amdxdna_ubuf_vmap(struct dma_buf *dbuf, struct iosys_map *map)
> -{
> -	struct amdxdna_ubuf_priv *ubuf = dbuf->priv;
> -	void *kva;
> -
> -	kva = vmap(ubuf->pages, ubuf->nr_pages, VM_MAP, PAGE_KERNEL);
> -	if (!kva)
> -		return -EINVAL;
> -
> -	iosys_map_set_vaddr(map, kva);
> -	return 0;
> -}
> -
> -static void amdxdna_ubuf_vunmap(struct dma_buf *dbuf, struct iosys_map *map)
> -{
> -	vunmap(map->vaddr);
> -}
> -
>  static const struct dma_buf_ops amdxdna_ubuf_dmabuf_ops = {
>  	.map_dma_buf = amdxdna_ubuf_map,
>  	.unmap_dma_buf = amdxdna_ubuf_unmap,
>  	.release = amdxdna_ubuf_release,
> -	.mmap = amdxdna_ubuf_mmap,
> -	.vmap = amdxdna_ubuf_vmap,
> -	.vunmap = amdxdna_ubuf_vunmap,
>  };
>  
>  static int readonly_va_entry(struct amdxdna_drm_va_entry *va_ent)

