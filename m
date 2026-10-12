Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF87BCA9ED2
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:46:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EE4F10EF03;
	Mon, 12 Oct 2026 07:46:18 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010068.outbound.protection.outlook.com [52.101.61.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDDCA10EF03
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 07:46:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0iNK6CUd16Xjz6OeBqMFxXqzbOsBZlVuRk+pSE3RfTDVkIkmb9GM/zaBK1tcNneY5MEAwPaAf5OeAy6pKKqQj0Sd231mRDI2KW/wv8FLVeZ1zWt8SxpXFX2Zj9eAyRvZz16ySPAXcpyiLg7OyhDVKtaz5KH9bILrM2Tx4ZfHkqbRMcQ/IztUnv/sFLMr92PG2bjauZYfI0g+saAwzyB5joLWst2nVAWujjXoRIEeDj35UXkgFp5btaALiwZk5MPnbLlMprDLAMlL/ZHHmPHJ4iTHBL9wGKP4E+SYewnPsf99EOdkAIQnyjaPE2uLKFhSPqIYldZ6EzFO6+LSB1D4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvxbsG4Ah6ys6s8c0sfOCtK93SEUbedeGFP+sxzHJv0=;
 b=IumADnIV2hMft/L9JAtPRZCb1VqtaBrtXI5B/4u3LFcHoqJclN9omOtMN3xf0D2xr3rwJtn8IqdC86MX6+kf7gDMwbdblSC+sTS17aHCNxkQU7l4j3NTj/hKOU0/aDz7waWTBipJGuxT/rZjymndw9Od2FAzWyTLoG1D/8hnzyBeZtDhaUQQPXUTaiJecEcS8IJ+C9ltd+UgFV3m9svDmgSPtBlRvrOa98S2GVBhrp72HnhgpA2vZplYl2wvHQXSO4o9CZ5aMlVP1k2GHb0FHRgq67A7c9iAgnGHDIykJVuhzZ3l4ygnyfuNi+dFfde+ziIF8PpIj+JATzD/L22csw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvxbsG4Ah6ys6s8c0sfOCtK93SEUbedeGFP+sxzHJv0=;
 b=rUzwqx/xic2ZiLHcTjf5CW73B//g1ngk+3swDwBabIVzX3CqBzxPHlI4/Talnnl0iJSN43t0G4TYWL73PcBbmhxbr5P4Bqk1IBfq3iKijCAKpxKwjXkMxbCEZE4srS9QC4SfvDpw9a51ZGSJINzwLcIUIgHL38i/OBX/WHR2In4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB9164.namprd12.prod.outlook.com (2603:10b6:a03:556::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 07:45:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 07:45:50 +0000
Message-ID: <49d4f34d-6d27-4a70-88ad-a5e939eef084@amd.com>
Date: Mon, 12 Oct 2026 09:45:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/syncobj: fix fence and syncobj leak in
 drm_syncobj_import_sync_file_fence
To: Julian Orth <ju.orth@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20261010180711.1548333-1-ju.orth@gmail.com>
 <20261010180711.1548333-2-ju.orth@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261010180711.1548333-2-ju.orth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0110.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB9164:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f076a09-172d-492b-112c-08df2834d60b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|10067099003|261009221227099003|261009223027099003|4143699003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 0OD9uSfJIy21P83+UpYidQ/4gzSvNN8C0oYTowr9vX87DxV1bvhBdGMwJhYsaFEk1vhmYYih93P8X+emBHGxA3/q2loGFP64ENthTZaq+onRMoiaIdOj96J3xD6Y4RbCzVw4Xb45/63psNfLfj4kZ7cKQZeZqaFrmvIduhIcflRtz+ZQ7eMaqTSYV7wcxvSbgw27d+vSXLV48+P+XJO+RgM4IKsll5UKwfblmDTxA77nEv+HsKymGuuCBd34iOLzP7DCPlXvpu8MM8SRYwprP0msZTRP3Qewzg9Ih+fvzCw7qvqzUKE+bdM4IIa4Ra2HOZwiJ0sI1dmpdPSDJfwHPRCqJ2bi77Mi3BI34GujZ5PQ1sfpjTZib2FhwbL3kxmU0jDlrwAWhTlyvJ5dhslbs6YzJ3oMczEzoLKuUOFMqIYbGLukA0NBu8W5lJ1uYrhvDE1fv0Y6bic4NUmO4DsR7qYS7lLLpsnWi/IFD0njZdwmXgWWDMzQdV3p3j/sP0coxtI7V1izLbC+eReerGXS29HfQlU8T/mhZF7tnkhQp1mxcOcFr0uIYNVxSnwdGm1AQ4td4T2FBtj/cwXYtr56GGgED+g8LtqYq+pisk1Id+IaKUbYDMw6hNKEyN8kt96giYAzMGGPCwCfT4KU+mEdANAd9LTDIYmt9brk3TzyJM4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(10067099003)(261009221227099003)(261009223027099003)(4143699003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzlEZzVuUmJYL1J4a3M0SmZ5TGQwUWdGUUJaZFB0NVBDcEtnMEJ4ZDhTN2t0?=
 =?utf-8?B?VUE3NE8rVU9zb2Ztc1RxNmxxQnhiMHgxT0NiVm9PNUIrdG9sT2RuREdqK1NS?=
 =?utf-8?B?NnVZL2wzejQ2Ulo1TzNGODlGS05mL0xISXQ2VFpKSUZpL1EyZFpKYWZON28w?=
 =?utf-8?B?THFoVEovMW9yS0NQcGkwcFU1cjQvdlRIYXZreWVXb0RobWZ1UE5kbUNhM1R4?=
 =?utf-8?B?V29CUVhoNC9ta0d2SnVjL2F5bzY0aDhNNElPejRHb3RpNTVYMlk4aW5SK0lH?=
 =?utf-8?B?N3ppU2ZrcEwwdURZVnpQcG9WSElrMHVUMkd6VXVaN0Y3Kys1QnJnVzBOWUZp?=
 =?utf-8?B?S3FWb0FLdkRsMmlwSXAvQXcxZ3BQemlHbjd0TkY1Mnl3RHhrb0JIU2pJamdS?=
 =?utf-8?B?RWdPNGp3ZGI0aHVQTFliT0QzK0JWc2dQZ3Y3b09sSXZpcnJseXJiYk15NUgw?=
 =?utf-8?B?LzRnbmNpRTR0NC9ubWJDckpwMzl2VE5DZG53cFROL2g3U0N0TGQ0cmJUblVE?=
 =?utf-8?B?MXIrR2ZrdXY4MGtjRnkyYnJKNkdjZHBkMkRSVzNLMElPY1V2d0xsb0ZIa3FW?=
 =?utf-8?B?NUZpdXJjbHFZR0ZLeWxwcVV5MXlUT3FFQTlGWlljMjM4a1MxMXBWOU9VVTM1?=
 =?utf-8?B?WDZpSlhZMDJUYzhMNjhSRWdpVmtoZ0c3WFR0U085RkgybVoveitiVFJTcDBR?=
 =?utf-8?B?UVlGb3dhSmd6SVJJNnVEL00vTmVHWDU2M2EwclVTSlFXTVJia3FNK0Z0ZEg5?=
 =?utf-8?B?SjIrS0hpc0RpSFI3Q1VtU2xrNDJFV2lqRURubFZpU0hFOExHMjRrZnQ0bits?=
 =?utf-8?B?TTdoZkdISFkraWFVWjlXdUIwYmR6c2gwQmxlK0wyUWt5aVNFSDZLMmZiL0dB?=
 =?utf-8?B?cEpVRHZmRlFwV1JYMHZkN2hpTW5zT296bjJZYW84NkhOVzB2QUVkcDBraXZM?=
 =?utf-8?B?dDlRWitDMTU1QW5yZzZIQlRYbVRyTWRTUVVPWTU0MEJ3TFpFQ0hkaERrQnoz?=
 =?utf-8?B?U0dHblNsTlMxMDBVYzc2cmtTMHN4SjZsRjNSS3U1V2Z2WTdLYjFjS0dOODVi?=
 =?utf-8?B?Qm55QUxpR1A3VUxUbWNaYWtiU0cvQVhTT3hoMU1keHFoMHFOOWd0SndVclAw?=
 =?utf-8?B?TFl3RzNCdTdMbjYwRVBaQTBMMkNpQzhNajgzeXZReFd0SVdaZzdQM3Q2WmZw?=
 =?utf-8?B?bnYrSVRHRzJKdHZLR1RIcG5hWW1Hc0xUeTlOVkpwRmt4ZHBUL05TS0E2RE92?=
 =?utf-8?B?dDJ3REc2UEgxcmxoL21QM2J0OXJMb3RzQWhTVkVVMkErKy95NDkwZXprMWEy?=
 =?utf-8?B?cXBOS2h3a3o2a21WY0N2TTRqaksrS3I3WldoWFh5NW9lUEhxQmJrVTAwRVBi?=
 =?utf-8?B?UlNkaHNtb1JuR1crWUlYd1RVTElmS3IrR2xWM2VsSmZ2bTJUNjlXZWtNcUgy?=
 =?utf-8?B?UnJDWCtCUjdzMU1idDBwVkVxdCtqUHg1R3Y3TjVkMXJDYXFKQnhwOHZsSUN5?=
 =?utf-8?B?WGI2cW5Kc056SGhEWTRmbVdabUk2L2NNSmZZNjBRbVo1SU5sN1dwTGVkZHNh?=
 =?utf-8?B?aWNDRy9KRHp0NTBZQlJqUXM4OFRhc1BNSDc2MEJPR0JmM0Z2alpHNm1EUTRj?=
 =?utf-8?B?aEZNY3kyRWw0OG15SHNod2hVRXZwNlVSU3BXU0hVSFZtemh1aHZTZllYandn?=
 =?utf-8?B?emdpVnlaV3ozcGhIN1o0YkFjVUlQUVRLVUE4bW80d0doR0k0d25mOFZWSzg0?=
 =?utf-8?B?QUpGdjBWaXZ3RDhKbFR0WjhnVkJpWUpZNlEwZ1IxaEk0QnMvdG8vWFlGK0pq?=
 =?utf-8?B?U29MbWRFdjcvQ2lteWo1R3lkUG5DQ1JMK0FOaG5kd2xkZU5GVS9MTVRKbzhF?=
 =?utf-8?B?dDBUNmxtcFZCV0N5UnozdnNHNnVpcnNsTDdqTFZBVjdoTXJoK3JZaEp2SCs3?=
 =?utf-8?B?RWtPQlk5b0tXZEFXTUVVeFNIVTcwVXJSMjhCM2tvdW5uTnB6SFZiaytNTDds?=
 =?utf-8?B?d0krU0lwZXgyR1RTdzJlQ2h1K0RDTW52V0xieTYydVlEYVdFRGJzd2ZkRzFV?=
 =?utf-8?B?NFhPYWZGcmVYd0M4ckhZUGhsbHdpTFc5YUxVS1hORzBGdEpsNmJlQ1JGOHZY?=
 =?utf-8?B?MnNDc1pWSFhVN1dtb2J1bWJXZi9TZVIyMG15YVJFZm1uOXNlbzg1c1RnMXJx?=
 =?utf-8?B?NWxBb1g3UDN3Smdsc3VrTW14RGljSVNLNWl3WmpsS3lmUnhHRXlCbUMxRlJo?=
 =?utf-8?B?UVZsaUMyLzVBUm8vcEt2V1JRVjdZNExPS1gwRVV2TEN4a3hxcGNZWE1kaDhn?=
 =?utf-8?Q?1TpaEWKGmJMd5aLF5Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f076a09-172d-492b-112c-08df2834d60b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 07:45:50.6254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jV67xmw12HnQribCEsLpSqAaWIITKReH8C4dhiqniZnm9kcijz33Im2wQ0CLR6ae
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9164
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



On 10/10/26 20:07, Julian Orth wrote:
> If dma_fence_chain_alloc() fails, the function returns -ENOMEM without
> dropping the references to the imported fence and the syncobj.
> 
> Fixes: c2d3a7300695 ("drm/syncobj: Extend EXPORT_SYNC_FILE for timeline syncobjs")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Julian Orth <ju.orth@gmail.com>
> ---
>  drivers/gpu/drm/drm_syncobj.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index c23a5de27..5ca5163d0 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -730,6 +730,7 @@ static int drm_syncobj_import_sync_file_fence(struct drm_file *file_private,
>  {
>  	struct dma_fence *fence = sync_file_get_fence(fd);
>  	struct drm_syncobj *syncobj;
> +	int ret = 0;

Please don't initialize return values on declaration that is often considered bad coding style.

>  
>  	if (!fence)
>  		return -EINVAL;
> @@ -743,17 +744,20 @@ static int drm_syncobj_import_sync_file_fence(struct drm_file *file_private,
>  	if (point) {

>  		struct dma_fence_chain *chain = dma_fence_chain_alloc();
>  
> -		if (!chain)
> -			return -ENOMEM;
> +		if (!chain) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
>  
>  		drm_syncobj_add_point(syncobj, chain, fence, point);

Allocation and adding the point is intentionally separated so that dma_fence_chain_alloc() can be called before looking up the syncobj or previous fence.

I suggest to make use of that.

Regards,
Christian.

>  	} else {
>  		drm_syncobj_replace_fence(syncobj, fence);
>  	}
>  
> +out:
>  	dma_fence_put(fence);
>  	drm_syncobj_put(syncobj);
> -	return 0;
> +	return ret;
>  }
>  
>  static int drm_syncobj_export_sync_file(struct drm_file *file_private,

