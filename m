Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C470CD4F52
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 11:46:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 799A910E30D;
	Mon, 18 May 2026 11:46:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JbA2dZh7";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010004.outbound.protection.outlook.com
 [40.93.198.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABD4710E30D
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 11:46:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmqGKh1Z8xSL9syJuZpId1lfYhMpkgrYBvGJYxZJYskmZBK9313ZlNEE8Ks4tlhNNW/QtUfzJcAX/v74npOfWBQJZyEvVL5bpJcssAqZwDOEJVPOkqV8iP8YdPMw+H5RV3KUJiLEB2DOyVAir+RKENhwXivUkDesYEKrEe/8ZvvPkAm8PkA4wmLtgNRPj/AWq0J+Q2n1z9Awoq8h9YYX/6WjiQa4ez4mjsjwzROlYxvLfGO0TfemCzCD3LgSPgDlWPx4XIOwXgLDBoR1aPPb/01CJBLwxqPuVqVkA6PB17uAHvVhDQqn+IYwI0RVjHyZgY8FL5FwjFWKUHfTr0CUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylJtmKODLmLOW18m9di61xBhGZM93vXaOgrCbTdeWjc=;
 b=bo6awUnU81hX+cRLIyOt+6+YHuF0zB8tbbg5zgENudWa4LqMT8Em/dYpXJdnKGIx9DLkgX4UQShbzDW8Qnsn2JTnfdXyS5bGF37YkCw2s/wHjSlmJr0h2ZRIpTYh+Z2QtdiUzR/H+d3Ml55HvvQLDevJsy3xOb9O23ZXHCaF+ACllEOqc02vESm1TpVDNEyPaOpoEr8MBBOn9OF/6ELUXVgZTemLSVH+9Zsk7P2pawzHL9KgpPvKX30nvTIH33W4VsQP4jA4Qwa5UVHZrXC/dONM2uSzcM9ZpIQ94iFH7CLGXtbXPF5qx4rkYEWsqJ90X+5N5F6/oiE8yXGsKtdROw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylJtmKODLmLOW18m9di61xBhGZM93vXaOgrCbTdeWjc=;
 b=JbA2dZh78MdaXrsQL7t6BPvVfFPLvFqRieplXpurPW4c2YqxS0BUpKwwDVTRlP3DG/sOKWVxLzyqMgeP+/zWRfqsUXqtMEyd/xQNJv8oF3q9xVAPd+6d+HcbU1Gend+csavsZM8aJlE0oPUwWE9j1714p13Lwa9dck374SfoMH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV2PR12MB999072.namprd12.prod.outlook.com (2603:10b6:408:354::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Mon, 18 May
 2026 11:46:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 11:46:52 +0000
Message-ID: <2a5cfc68-61ae-4399-86b3-3e16dfd1e42a@amd.com>
Date: Mon, 18 May 2026 13:46:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Remove mmap and export support for ubuf
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, mario.limonciello@amd.com,
 karol.wachowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 dri-devel@lists.freedesktop.org, simona@ffwll.ch, max.zhen@amd.com,
 sonal.santan@amd.com
References: <20260515155332.743097-1-lizhi.hou@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260515155332.743097-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0163.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV2PR12MB999072:EE_
X-MS-Office365-Filtering-Correlation-Id: c78e863f-496e-439b-7184-08deb4d32716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: w6v8jFcU/Lf7wFkQKrr5yB9ghXMa+seKJganZOab6Xga0liZ94+OumJXBw+7jduXtwdS6dp3yGMadRAKf/BwgWxvfRdroHNI5kSaMlqEtnJWykEHSIeJ0wPyOl6m5Sbznvm2mNzvLN9VoScCagluEiK3HX6Q9NJy0EeOsv4BUyO+UG0UBjxxyydIJRSSYGBopcA/ILBDwRbfA9T+mZr4rqgDInb+qX7d8YJaAyEzTQDewgbytr48XfGPPmkoGarrWb1K0hj1LmWzugU3HHOmDRA22WZeoAmTrfEoWOtOA9IVA6I3mQnguCjHRPeEq+6FFrFYnigR5RVMezq9ggu0MB1ZkxMo5mDuM+m2GIbwHYfVxGfNnNAnVud2f0UOUn1g516wsrJc/+FCk4zNPv5w85jvdjBip1YGgs4E4D/B47GHUORDUvk9qXfTp30sp+vFrLzhOkP932iH4eq78jRWVbLrCNdjOFji0dx2W4AlGSukbhMSYOUNJJ+ijNHVP4+oRhsSMiLMrgnjOcAOMYmUTzXx6Dg7i5WOpeQRfbobd4JQpCJw7y2zBAYmJS4Gy9c+y7W4RaCalsX1Rx8eT56lR6xGhrmPq0mOBskrQ35j+4nD03cZhSMU+1oD6uwX6VdphdJFvoC+SEJzj9aKvcxl9L19X3hUUuQDvyomvqd5sPEI4R8lemSJjfx2skgmPskX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXVSeVNjQkx2ZGN5YmdxSDJlMXo0djJTZ1NlemFicDU3Zi9vOGt1eTVvdXVN?=
 =?utf-8?B?NFFST0xDZTFBNFh5UmZoQTNOcE5aRjcrcnQvZEp6RmFDdHo1RThjWE9aTHpq?=
 =?utf-8?B?S1JZczFDV29KS0hWd3FKcE9ldmJTa3JTRWVjb0JJa0Y1VmtIZC84eEYrQmJ1?=
 =?utf-8?B?azQzYnpKL0NPU01YY2gvUjVYOTRqWWJBaDY2NUFoYmJta2sxcE53ZzBSUWtG?=
 =?utf-8?B?QUJnQ1BXbGtCa0NuSGxCdHZZZzJGU3JDL2gzQmxCU1JtN3JuZHRlbHk5bkkx?=
 =?utf-8?B?QUlyUGNUUWh6WDlHZVk0UWxFMmJGUXZ1dnRmM29VbnhjNVk0Z0I3WXhTMnJD?=
 =?utf-8?B?MTUwM1pEVk1KTUJCekR5dmVRUGw2NytRZkJtYXRiRHRRUXkyc1VjLzdRWjMz?=
 =?utf-8?B?U1lXQVU5SDcydFQrVEZZZXF0L2FCSEg2TEU0V0s2RUtDWlpuaSt5VnhROHhH?=
 =?utf-8?B?cnEra2xPbWFsVUowdU1ESW5sY213Z0kvNWpUc3NRNVZQdjdGU2I3UnBUTkIv?=
 =?utf-8?B?RllJeGZzczNBUWRCd2FnMm9hVXZkbU5YNjRwTUtGZDJobXVpeVhxdnhNb3dR?=
 =?utf-8?B?aW1weVgra1NOVzFzM2Ixa25xTjVFdVdLZ3Z6NnRneDlUKzFLK1VCdFVpWURw?=
 =?utf-8?B?OE5rNUkwSnB1N2M2OXBkaVNmSUlRM0hNelZFQ3Y5ZWxJN2NqS0RUdkl4dURy?=
 =?utf-8?B?Z0xDWmV0V2pEQWlxd0pFbmF2YThxdlZQYm9Oblh3bVdtSlRFYTVkVzgyZEc2?=
 =?utf-8?B?TUc0OHlSTEpYcHVob3dwN3BjWVdHRmRrVXhheDlMQzc4ZmJxSFJJS0NxaFZj?=
 =?utf-8?B?Y3BRaWtDajBkQXZHZzJTdE9rTXVDTlhSVmJ0SDBibDg0OFZST2lIUVZlTUlr?=
 =?utf-8?B?L00wYmd2MHB2TmpTQWNGb0w1eTBmL2ZVV2l2VUFld0VXNThtUThWTlhhOWJ5?=
 =?utf-8?B?ZGJRaUFadUZYTkxzZ3h2V3JCWjZHdFhNS0sxaEtUOC82UjQzTmMrNzNnME81?=
 =?utf-8?B?eE5KOUd1N1NzeEhJUWFJUW1xbGdMT3JueUVGTnhBbjdTK3AxR011YUZmbFhu?=
 =?utf-8?B?VGRxVC9KbTBVbVBCSDdwL0Y3ZXlPLysveGRpaW9jRTlnY05SOXpTbmRCRzlE?=
 =?utf-8?B?ZzJ4UWdJTjdvQzBEUzl5NmIzNW1xSGlwNFBWYXlUSEtuaUxHTng2QWdESTVH?=
 =?utf-8?B?RHdoOFRLL25MaHF3QWV1SDhHUDlOTUtIUlVuS0JyVUFFcnQzdlpVc1FXaUZp?=
 =?utf-8?B?Y29FdHRHYTVUOWorL3kwOFdwU1FVeE1EbWVkWXExWlhYK0pxVW9Ya3VoTDdD?=
 =?utf-8?B?OUtjR21icHFGbUhJU3FJdlFYMzh6MFhUd0tuOW9QaGpVdTk5NHltSWg2cm1W?=
 =?utf-8?B?S3dKbHptUGpCVlc4bUo0bmRUcHlOYTFzU0NzbHRoaEtNVmpRTVQ4bXRpWDZq?=
 =?utf-8?B?YkdEMER3WWRqVTVLN1Y0UFdEVDNkbVI3TXdUVlFCUzI1MmlUZmxkQlFwWUtR?=
 =?utf-8?B?V1hsZXZEMlEzbGE1ai82ZnE5RmZKb3VTNGtaamhDckNrQ2UzU01Bb0pCK1g1?=
 =?utf-8?B?RHEvak44cEFMNkI4bGVEY2FqdUVHUGk5TkFXQXRiQzV6a3dhM0o1eWJCcXdN?=
 =?utf-8?B?Q09xNUc1S3ExZndOaWtMOUxwb0gvWmpEaElmRDIya2E2QTFUVk12M3poMEdB?=
 =?utf-8?B?TloxQTVNYzZFVTZhemhOQXNJOUhpTFhQV28xNWU2WTRKbU1UYkExd0lraWl5?=
 =?utf-8?B?NURlcEc4eWlRWmM0ZjJuUlJ5V0E5QkM0UlBITDFPZnhaMVJqc3YwM0RDRmtw?=
 =?utf-8?B?SktESm5nS21CM3FuWUpGSXNPQVlIUEEvRHlGbi9FS3RKZi9Ba1RsVzc0QS9J?=
 =?utf-8?B?R2s2SGw2amtIVUt6cTVnaHBhM0w3ZUpPaEJjS25DZ0hkSFpFeGZ6MFNuRncr?=
 =?utf-8?B?UjljbzVESnRjMzRIWGlheWZzTDBnSHlZVnFIbVNJQnBXRzhycCsraEliVzBu?=
 =?utf-8?B?MTRHMVBVWWNEUjF5dUJ1QVVudGJsbzNycDlNVDhTOFBiazM3Mmg1V1NrNkNt?=
 =?utf-8?B?V1R1YlpUTzZMeFRER0pOVEl3djllcXNlSzNzdUZRMGNlNzZuZHJqNjZIbmlP?=
 =?utf-8?B?cDJJMnRPbFc0bXl6a2hiTnJhb2o1RFhZc01SbkhtNFI0UWhiTnNzS1kxZTFY?=
 =?utf-8?B?YjVIS3JTVmxaTlR5ejZSV0JkVDhnNkFwSFVlVWY3c0dEN2ZuVDU4Rzhtc0ha?=
 =?utf-8?B?aEIycXJBVGx4MjFyNzhtUTRjVDdXZ252eE5NR2NXaEk1OVlOWEhXWlpqdEdS?=
 =?utf-8?Q?UPARiElvQ0caek1ouC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c78e863f-496e-439b-7184-08deb4d32716
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 11:46:52.2282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pr69L+D0vsu/IBivOEShVurejA4IlETrAWaMfLgtRcizscxlPNPqezHETWhLnfEk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999072
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



On 5/15/26 17:53, Lizhi Hou wrote:
> Ubuf pages should not be mmaped or exported. Remove the ubuf mmap callback
> and return -EOPNOTSUPP when exporting ubuf objects.
> 
> ubuf vmap is also removed for there is not a real use case yet.
> 
> Fixes: bd72d4acda10 ("accel/amdxdna: Support user space allocated buffer")
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>  drivers/accel/amdxdna/amdxdna_gem.c  |  9 +++++++-
>  drivers/accel/amdxdna/amdxdna_gem.h  |  2 ++
>  drivers/accel/amdxdna/amdxdna_ubuf.c | 32 ----------------------------
>  3 files changed, 10 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 319d2064fafa..6087264ba1b5 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -492,6 +492,9 @@ static struct dma_buf *amdxdna_gem_prime_export(struct drm_gem_object *gobj, int
>  	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
>  	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>  
> +	if (abo->pri)
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
> +	abo->pri = true;
> +
> +	return abo;
>  }
>  
>  static struct amdxdna_gem_obj *
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
> index 4fc48a1189d2..162e5499f5e0 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.h
> +++ b/drivers/accel/amdxdna/amdxdna_gem.h
> @@ -54,6 +54,8 @@ struct amdxdna_gem_obj {
>  
>  	/* True, if BO is managed by XRT, not application */
>  	bool				internal;
> +	/* True, if BO is not exportable */
> +	bool				pri;

That member name could be improved.

>  };
>  
>  #define to_gobj(obj)    (&(obj)->base.base)
> diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
> index 3769210c55cc..df4ab225fbf9 100644
> --- a/drivers/accel/amdxdna/amdxdna_ubuf.c
> +++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
> @@ -87,42 +87,10 @@ static const struct vm_operations_struct amdxdna_ubuf_vm_ops = {
>  	.fault = amdxdna_ubuf_vm_fault,
>  };

As pointed out by the kernel test robot the amdxdna_ubuf_vm_ops structure and amdxdna_ubuf_vm_fault function is now dead code, please remove as well.

Apart from that looks good to me,
Christian.

>  
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

