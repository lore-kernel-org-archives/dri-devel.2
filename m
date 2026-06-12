Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B77CD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 12:11:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9B0310F49E;
	Fri, 12 Jun 2026 12:11:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PsWvUSG3";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012028.outbound.protection.outlook.com
 [40.93.195.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD3F010EA24;
 Fri, 12 Jun 2026 12:11:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVGOhWb1LKdvm986Di5GHZAfFF3V+071ilHnSJjJ51v6WK8Hwrou+vuT+yTs3drsQI3nxwAWrnx6OhyBX4yKBLSX2WuVoaUHfRrX7Nwz/ggke1v5RxOSd2lvZ2QwO3/b8JcMN1gVTpryrqhGPVtFZhNl8W862gLz5GnBJokxFBXMD4ud4aMhlPA/J1q8QABjXHH7XYGP4TT4QpzmuonMM5zVccyubxhMucW0NY5vhSpZf2BewxEiPtSD5SmVcDOxFHPLQ3C4C6vBLBI52AUQKtTfs2t9G6q9jNf5EeRERiuQ95o/reZNiSa2QkUfoNDr+Ib8aIEA3lSmxgmg+Hmeng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9SUIpuKuctI9jkPjztT66Nr5Qt61gqBCMScKhSdvUs=;
 b=Dg43h2Hgnn2rMWyh9beSNvoG0p69kEZCUercFcpocvlvXnsSFgFWz4plVA6AHQCD0h38hPmzfHucsEkH8cJFInBJFlF+WOlNqnhrIO3MIyroysi4Tdn2RtRtffE1aF4kRNmvimGi8ib9xLTIyngOR2cwZTt/3F3fVxMTJSrmdywilh8kGNK3l+YbzDBEuxUru8TedQzUzQKMMgeA/kTmYfUtDN7Gb0hLjBOLWyk3TTK1XxyNFpqjoIQTxFehzQjSbJKqYa5xLIxcoBpDS/8AOob4Xqg5/TX4rYhd8KilNWM16VWAHeWMyoPrn/N9oJGSwPNZxx/lHfXlhtRBe2hSlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9SUIpuKuctI9jkPjztT66Nr5Qt61gqBCMScKhSdvUs=;
 b=PsWvUSG3hnfKgwNewIk4xUono6puCb0O3NL2WykO9npJSMPoV/FwnaPEqLAiE6EEFmAl16xJEurrQo5z06lJ45iC+2QOPZYwCkhekoCnrwHrPYN7unMuyqrje3FF3FdARS432nyl+m4nm0v57kJaZXqfazo37Engl2yKOPSbYrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY5PR12MB4084.namprd12.prod.outlook.com (2603:10b6:a03:205::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 12 Jun
 2026 12:11:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Fri, 12 Jun 2026
 12:11:05 +0000
Message-ID: <32a43737-d2cc-4b8a-9f9e-6b7d0fdabf67@amd.com>
Date: Fri, 12 Jun 2026 14:10:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/18] drm/amdgpu: implement SVM attribute
 set/get/clear operations
To: Huang Rui <ray.huang@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Honglei Huang <honghuan@amd.com>
References: <20260612090928.29682-1-ray.huang@amd.com>
 <20260612090928.29682-6-ray.huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260612090928.29682-6-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY5PR12MB4084:EE_
X-MS-Office365-Filtering-Correlation-Id: 51051084-2056-4761-ad98-08dec87bad45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|6133799003|22082099003|921020|56012099006|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: oeRhqKL3WlOMHIxP0481et+XLtMFESIWSl1UGKxNqpBMgyvg+5bMP5gLXGpjVti3ROVJGId59+e1W2Ne/hNYOa+/ulx0MtBVf7oQRbwlHC+EA2U7C+pxpGiQeWu4D9GCXmQPfF9OzlFvKerEf7MLqD7lsiNRpxU3zmz/u0A+UKmJXvPghR/RNGQSJBhkd078yX7qaE+HBGH+445jKQrTCBpdHZPnsEj05JXJKOx6DPj131KK2YFq7wpELz8ridNmejCXSl58Ivk8aijEJF+qDFMLCg6d/9pHT0SYYwozXV5Mqw3Y4KT7oj6XnAzOiJ2paqycU9zRg7wx53YCeWAyE1L+J96O6HfFgUomNLb1Yqe9peMKpHPtfY9U3qJQkgNJW+d8oJ+ARacaP69S3YnzriLM2pDYbNX1FbfyqJZVJMrRrvMF7PNH/WyZiALoijUAERQYqiBAEbuwUqa2zrfFtxhWcCfxXeihwTAf5/cMLjW/+yDLLlY2CpmvS6ik/U8GAuD5En5LkjsHGrQhpT3wu25CxGKV6J/RmsPvmGCjAmtvcqnnLxAjfug0/H9lpUbAkoeFS5CAFtrRfFKSEGjtfwUn6NECqsF/N+fvmNOUkeLq+mTNpOTilVrAma4DCDGDvHmK6GzDQ+fUP3iDEnBLNg+2Ejk92FiwexagRRhwYVjefet1xFMklZuS9ckp5qIofjMvSbHVdgLMGD3bIxLalIs9DkLijDaW3WzaJxjOgVc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(22082099003)(921020)(56012099006)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0hHY3ZYWDJ2SzY0Y05KTDZzY3JkOElmYkpVeEVzNVhpNXEvckE4SUltMWZl?=
 =?utf-8?B?ajdsZU9ISWQvS3JMdmVhU2hPSE54TzlCdDN0VHRQSHA0WWJoUUx5VG5sSlZ5?=
 =?utf-8?B?VjluWmFBc2ZPemh3dkFOaklBTFV1d0pvVGRpSmMycG5KVkIvSEN4eDZVYXJC?=
 =?utf-8?B?cmszcEJiakc0Q1VXUUZwU0F3a3VVb1VZTzRYTUJ3Vmd4RzV2am1ma2ltQUp3?=
 =?utf-8?B?NEFsN2djZzMxSURCMjg2MlFXaXBJWGhJZDUxVmx6N2E2OTVjODd5T3RxK2JH?=
 =?utf-8?B?UmY2NTBtd1RxRVJqSTBUMmlOVnlSZFhMUFhlWlZpelQ3QXl1N2JWZlZDRy9p?=
 =?utf-8?B?OEdqdTVrdThCcDdETVRoTElvWlF1Y3R5dWQ4OFhaUmRzdWtYSzBVUHBMUEhJ?=
 =?utf-8?B?UDBlU3ZmSEhWRUp1SlByYmxXaGU0MEhwNW40bGc0YUpBLzExVHd3T3NyNXY4?=
 =?utf-8?B?OE81VzZQVjBmNkdqNWFvWEVmQTZ0Z0hGTEJmM09mUWsrbVc5QmhxOW9TUXZv?=
 =?utf-8?B?SVNqbUVDSGZqWHlJQ2M3anZCbUpETmc2UmRJQzhvV0xFRklJVktEenBjampB?=
 =?utf-8?B?d0R6ckI5c3RyNlJicjlyTStqL3hOSGx5Qjh0eStTVmxYYUt5MGZhQk5ISWZ2?=
 =?utf-8?B?WGJXTE16bGdnS0VEK0dnMFcvZjJPVGtrUzJVdUl5S2ZiZkc2azFrUldpaC9O?=
 =?utf-8?B?NTBpUVRJcmd1aXc3UUp0aWZDaDk3OU1JeWdOR2ViTXFxdENLV2kxZFNrWHJa?=
 =?utf-8?B?dHowVEphendOUEJyakEvQTd6bXR4aG1IenVrZld2QTVabG53MWRBZGRvdFB2?=
 =?utf-8?B?OEtaQ2IzOTFWWWJPNDFoZE9sS3k4MzRla0pPSmNiLzg0eURtOVJjOW80bHF4?=
 =?utf-8?B?eXlva3ppRmFYZmNzV1ZZdGVWS3I3OENXVHV5eUhNYkpmaUtSVUdpZ3krd0V0?=
 =?utf-8?B?UnV0c2NROHk0aFpTajd4RE9DSjR6d3U2RG5OQTlITEl1bnJCTkN0d2sxZXdW?=
 =?utf-8?B?RVQ5bURXZHBvYWFweU1hd280QVB6VTVCQjRZQ1FqblJPdm1LNTk5ZElYZ3NM?=
 =?utf-8?B?djZEdENEN0p3MU9FQVkzM2taanQ4RWVnQUtzSDN0UmhNcnUyVnROK3I3UWRo?=
 =?utf-8?B?MXYvYkQ3QlBiMnFmb2tIMzZHRHZlTy9JNnpzYjd3UUhta3FDSGtnYXBVVldQ?=
 =?utf-8?B?azZOT20wMGMzYzVlbFViamxpM1Q4RDZhMmxrbnNlZCs5SDhNVG1sb1BwWXln?=
 =?utf-8?B?MHIrSGpWUnJiaktxVDBOVWw4RHJ6MStYUVU0Qzg1MytRMFV1ZFMzd0tkVjh1?=
 =?utf-8?B?RlBLSTBuWXpPYW5BR3hUWElTb285WjlmUmZqVWZrMTBQK0tRbkNmS0hFODJN?=
 =?utf-8?B?RnlDT1d4aEFrR3lqNWlQMEE4OGJxTlRiMm9VU2hUc1RTKzN5M0xzNGtKWHBl?=
 =?utf-8?B?RUo4MHI0YWJ6d0tJU0hkcWREeWROc2tITFhwSXNOT21MTk8vRG9pYzhKeGd2?=
 =?utf-8?B?RVpvUGQ0Ujl4M2h6eHdFUEtTdFBzcjRvcjJPZm10aE1RK1J2dVA4NWhBam9T?=
 =?utf-8?B?Z0l1WG1qeFZRdDRtdjVGbU9jb1J3bXlsOVFlalErNnFXeWc2c2tjNmRFV2Vs?=
 =?utf-8?B?N2U2d21sZ3F5Zk82S3g5RG9pQThIUkUwSkI5SGFHbXJKSG9adGw4TXF1eU5O?=
 =?utf-8?B?S1c2SnRnaVVSYUtVcGU4ZnVSazEreTVRUENnQm9qNmVRalV3NWhuUlFKRTFr?=
 =?utf-8?B?K2pWYk9UNi9yeWwwMEtqQjYyUXl2Z0FKRWt6bUs4Sk1UV003VWNDc0pTWUFj?=
 =?utf-8?B?Ti9qd3VqQkpaQUV4Q3B5aHpZSU5hYjRFQTM4NHh5KzJOd09xNFRmdjg2RHpP?=
 =?utf-8?B?K0xBN1lGTGRqSHcwWEt4SElyZTRwZUFZc0N5bm9iNGs4MUd0V05MZ3NFVjBU?=
 =?utf-8?B?WXhQWk5PMjFGamQ0b1ZDMDVXWWhDenJSQkJmK1NFenlvNGZVb0dOa1dJdDNp?=
 =?utf-8?B?aldsSUpQUmVwcFVqQlByUWMzRnlPV1pYTTlnbkdqM2JoZWRhaUpaTFhhdzJk?=
 =?utf-8?B?aGpldXVNSVZEV3BaeXVQUGNtTnNtV3pjSVlsWElGWEJSUkpWYjFKS2VQeGJt?=
 =?utf-8?B?MlFGczZCdVh3c2tzWE9JV3dpY3FKWThFSEJYbUV5R2VPb3BKYjRJRlRCTkd4?=
 =?utf-8?B?ZHVzYlZoOU5DQzY1aWh5b1RDRi9ZeWc2ZkNybjkxT0l5RmlPY0svdEVOK1Y2?=
 =?utf-8?B?Qi9KbFErSmxxbk50UXE1VXZOL29GaTRsRUp0YWtxTHR3QjAxbU94OC9jV1kz?=
 =?utf-8?Q?nqAORFcV6cr7vwsHH6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51051084-2056-4761-ad98-08dec87bad45
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 12:11:05.1252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSZf9vKzzPQOGfvQArYDte9GcMTpqKIH8Qn02wIjwl4E/GXXFtctKT40SPqiO3JU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4084
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

On 6/12/26 11:09, Huang Rui wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> Complete attribute subsystem with validation, tree modification, and
> public API:
> - Attribute validation: per-type checks for preferred_loc, prefetch_loc,
>   access, flags, granularity
> - Flag application: attr_apply_flag, amdgpu_svm_attr_apply
> - VMA range validation: amdgpu_svm_attr_validate_range_vma
> - VM BO overlap detection: amdgpu_svm_attr_check_vm_bo
> - Tree modification with gap/overlap handling:
>   amdgpu_svm_attr_set_hole (new range in gap),
>   amdgpu_svm_attr_set_existing (split/update existing range)
> - amdgpu_svm_attr_set_range: cursor based iteration with per segment
> - Lifecycle: amdgpu_svm_attr_tree_create/destroy
> - Public API: amdgpu_svm_attr_set (validate, set_range with retry),
>   amdgpu_svm_attr_get (aggregate attrs across interval),
>   amdgpu_svm_attr_clear (interval removal with split),
>   amdgpu_svm_attr_reset
> 
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c | 738 +++++++++++++++++++
>  1 file changed, 738 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
> index ba09aa3c3fe4d..26e33defb8b9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
> @@ -232,3 +232,741 @@ static void attr_remove_range_locked(struct amdgpu_svm_attr_tree *attr_tree,
>  	if (free_range)
>  		kmem_cache_free(amdgpu_svm_attr_range_cache, range);
>  }
> +
> +static void attr_change_ctx_set(
> +		struct attr_set_ctx *change,
> +		const struct amdgpu_svm_attrs *old_attrs,
> +		const struct amdgpu_svm_attrs *new_attrs,
> +		unsigned long start_page,
> +		unsigned long last_page)
> +{
> +	change->old_attrs = *old_attrs;
> +	change->new_attrs = *new_attrs;
> +	change->start_page = start_page;
> +	change->last_page = last_page;
> +}
> +
> +static inline int attr_check_preferred_loc(uint32_t value)
> +{
> +	/* cause one svm one gpu so value > 0 then means preferred loc is this GPU */
> +	if (value == AMDGPU_SVM_LOCATION_SYSMEM || value == AMDGPU_SVM_LOCATION_UNDEFINED)
> +		return 0;
> +
> +	return 0;
> +}
> +
> +static inline int attr_check_prefetch_loc(uint32_t value)
> +{
> +	/* cause one svm one gpu so value > 0 then means prefetch loc is this GPU
> +	 * keep prefetch loc to adapt to KFD API
> +	 */
> +	if (value == AMDGPU_SVM_LOCATION_SYSMEM)
> +		return 0;
> +
> +	if (value == AMDGPU_SVM_LOCATION_UNDEFINED)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static inline int attr_check_access(uint32_t value)
> +{
> +	switch (value) {
> +	case AMDGPU_SVM_ACCESS_INACCESSIBLE:
> +	case AMDGPU_SVM_ACCESS_IN_PLACE:
> +	case AMDGPU_SVM_ACCESS_ALLOW_MIGRATE:
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static bool attr_flag_type_to_bit(uint32_t type, uint32_t *flag_bit)
> +{
> +	if (type < AMDGPU_SVM_ATTR_HOST_ACCESS ||
> +	    type > AMDGPU_SVM_ATTR_GPU_READ_MOSTLY)
> +		return false;
> +
> +	*flag_bit = 1u << (type - AMDGPU_SVM_ATTR_HOST_ACCESS);
> +	return true;
> +}
> +
> +static inline int attr_check_flag_value(uint32_t value)
> +{
> +	if (value > 1)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static inline int attr_check_flag_attr(uint32_t type, uint32_t value)
> +{
> +	uint32_t flag_bit;
> +	int ret;
> +
> +	if (!attr_flag_type_to_bit(type, &flag_bit))
> +		return -EINVAL;
> +
> +	ret = attr_check_flag_value(value);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static inline int attr_check_granularity(uint32_t value)
> +{
> +	return 0;
> +}
> +
> +int
> +amdgpu_svm_attr_check_vm_bo(struct amdgpu_svm_attr_tree *attr_tree,
> +			    unsigned long start_page,
> +			    unsigned long last_page,
> +			    unsigned long *bo_start, unsigned long *bo_last)
> +{
> +	struct amdgpu_svm *svm = attr_tree->svm;
> +	struct amdgpu_vm *vm = svm->vm;
> +	struct interval_tree_node *node;
> +	int r;
> +
> +	r = amdgpu_bo_reserve(vm->root.bo, false);
> +	if (r)
> +		return r;
> +
> +	node = interval_tree_iter_first(&vm->va, start_page, last_page);
> +	if (node) {
> +		AMDGPU_SVM_ERR("SVM range [0x%lx 0x%lx] overlaps with BO mapping [0x%lx 0x%lx]\n",
> +			       start_page, last_page, node->start, node->last);

Yeah that approach is a clear NAK.

We must enforce that based on the range I think.

> +		if (bo_start)
> +			*bo_start = node->start;
> +		if (bo_last)
> +			*bo_last = node->last;
> +		amdgpu_bo_unreserve(vm->root.bo);
> +		return -EADDRINUSE;
> +	}
> +
> +	amdgpu_bo_unreserve(vm->root.bo);
> +	return 0;
> +}
> +
> +static int
> +amdgpu_svm_attr_validate_range_vma(struct amdgpu_svm_attr_tree *attr_tree,
> +				   unsigned long start_page,
> +				   unsigned long last_page)
> +{
> +	struct vm_area_struct *vma;
> +	struct mm_struct *mm;
> +	unsigned long start, end;
> +	int ret = 0;
> +
> +	if (start_page > last_page)
> +		return -EINVAL;
> +
> +	if (last_page == ULONG_MAX)
> +		return -EINVAL;
> +
> +	start = start_page << PAGE_SHIFT;
> +	end = (last_page + 1) << PAGE_SHIFT;
> +	mm = attr_tree->svm->gpusvm.mm;
> +	if (!mm)
> +		return -EFAULT;
> +
> +	mmap_read_lock(mm);
> +	while (start < end) {
> +		vma = amdgpu_svm_check_vma(mm, start);
> +		if (IS_ERR(vma)) {
> +			ret = PTR_ERR(vma);
> +			break;
> +		}
> +
> +		start = min(end, vma->vm_end);
> +	}

That's complete nonsense as well.

The result becomes invalid as soon as you drop the lock again, so just completely drop the check.

hmm_range fault will tell us if the fault was succesful or not.

Regards,
Christian.

> +	mmap_read_unlock(mm);
> +
> +	return ret;
> +}
> +
> +static int attr_set_validate(const struct drm_amdgpu_svm_attribute *attr)
> +{
> +	switch (attr->type) {
> +	case AMDGPU_SVM_ATTR_PREFERRED_LOC:
> +		return attr_check_preferred_loc(attr->value);
> +	case AMDGPU_SVM_ATTR_PREFETCH_LOC:
> +		return attr_check_prefetch_loc(attr->value);
> +	case AMDGPU_SVM_ATTR_ACCESS:
> +		return attr_check_access(attr->value);
> +	case AMDGPU_SVM_ATTR_GRANULARITY:
> +		return attr_check_granularity(attr->value);
> +	case AMDGPU_SVM_ATTR_HOST_ACCESS:
> +	case AMDGPU_SVM_ATTR_COHERENT:
> +	case AMDGPU_SVM_ATTR_HIVE_LOCAL:
> +	case AMDGPU_SVM_ATTR_GPU_RO:
> +	case AMDGPU_SVM_ATTR_GPU_EXEC:
> +	case AMDGPU_SVM_ATTR_GPU_READ_MOSTLY:
> +	case AMDGPU_SVM_ATTR_EXT_COHERENT:
> +		return attr_check_flag_attr(attr->type, attr->value);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static void attr_apply_flag(struct amdgpu_svm_attrs *attrs,
> +			    uint32_t type, uint32_t value)
> +{
> +	uint32_t flag_bit;
> +
> +	if (!attr_flag_type_to_bit(type, &flag_bit))
> +		return;
> +
> +	if (value)
> +		attrs->flags |= flag_bit;
> +	else
> +		attrs->flags &= ~flag_bit;
> +}
> +
> +static void attr_apply(struct amdgpu_svm_attrs *attrs,
> +					uint32_t nattr,
> +					const struct drm_amdgpu_svm_attribute *pattrs)
> +{
> +	const struct drm_amdgpu_svm_attribute *attr;
> +
> +	for (attr = pattrs; nattr--; attr++) {
> +		switch (attr->type) {
> +		case AMDGPU_SVM_ATTR_PREFERRED_LOC:
> +			attrs->preferred_loc = (int32_t)attr->value;
> +			break;
> +		case AMDGPU_SVM_ATTR_PREFETCH_LOC:
> +			attrs->prefetch_loc = (int32_t)attr->value;
> +			break;
> +		case AMDGPU_SVM_ATTR_ACCESS:
> +			attrs->access = (enum amdgpu_ioctl_svm_access)attr->value;
> +			break;
> +		case AMDGPU_SVM_ATTR_HOST_ACCESS:
> +		case AMDGPU_SVM_ATTR_COHERENT:
> +		case AMDGPU_SVM_ATTR_HIVE_LOCAL:
> +		case AMDGPU_SVM_ATTR_GPU_RO:
> +		case AMDGPU_SVM_ATTR_GPU_EXEC:
> +		case AMDGPU_SVM_ATTR_GPU_READ_MOSTLY:
> +		case AMDGPU_SVM_ATTR_EXT_COHERENT:
> +			attr_apply_flag(attrs, attr->type, attr->value);
> +			break;
> +		case AMDGPU_SVM_ATTR_GRANULARITY:
> +			attrs->granularity = min_t(uint32_t, attr->value, 0x3f);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +}
> +
> +static bool attr_same_attrs(const struct amdgpu_svm_attr_range *range,
> +			    uint32_t nattr,
> +			    const struct drm_amdgpu_svm_attribute *attrs)
> +{
> +	struct amdgpu_svm_attrs target;
> +
> +	target = range->attrs;
> +	attr_apply(&target, nattr, attrs);
> +	return attr_equal(&range->attrs, &target);
> +}
> +
> +static int
> +amdgpu_svm_attr_set_hole(struct amdgpu_svm_attr_tree *attr_tree,
> +			  const struct amdgpu_svm_attrs *default_attrs,
> +			  unsigned long start_page, unsigned long last_page,
> +			  uint32_t nattr,
> +			  const struct drm_amdgpu_svm_attribute *attrs,
> +			  struct attr_set_ctx *change)
> +{
> +	struct amdgpu_svm_attrs new_attrs;
> +	struct amdgpu_svm_attr_range *range;
> +
> +	lockdep_assert_held(&attr_tree->lock);
> +
> +	if (start_page > last_page)
> +		return 0;
> +
> +	new_attrs = *default_attrs;
> +	attr_apply(&new_attrs, nattr, attrs);
> +
> +	/* Always create a range entry even when attrs equal defaults */
> +	range = amdgpu_svm_attr_range_alloc(start_page, last_page, &new_attrs);
> +	if (!range)
> +		return -ENOMEM;
> +
> +	amdgpu_svm_attr_range_insert_locked(attr_tree, range);
> +
> +	attr_change_ctx_set(change, default_attrs,
> +				       &new_attrs, start_page, last_page);
> +	return 0;
> +}
> +
> +static int
> +amdgpu_svm_attr_set_existing(struct amdgpu_svm_attr_tree *attr_tree,
> +			     struct amdgpu_svm_attr_range *range,
> +			     unsigned long start_page, unsigned long last_page,
> +			     uint32_t nattr,
> +			     const struct drm_amdgpu_svm_attribute *attrs,
> +			     struct attr_set_ctx *change)
> +{
> +	unsigned long range_start = amdgpu_svm_attr_start_page(range);
> +	unsigned long range_last = amdgpu_svm_attr_last_page(range);
> +	struct amdgpu_svm_attr_range *left = NULL;
> +	struct amdgpu_svm_attr_range *right = NULL;
> +	struct amdgpu_svm_attrs old_attrs;
> +	struct amdgpu_svm_attrs new_attrs;
> +
> +	lockdep_assert_held(&attr_tree->lock);
> +
> +	old_attrs = range->attrs;
> +
> +	if (attr_same_attrs(range, nattr, attrs)) {
> +		/* Report old==new so apply_attr_change can decide */
> +		attr_change_ctx_set(change, &old_attrs,
> +					       &old_attrs,
> +					       start_page, last_page);
> +		return 0;
> +	}
> +
> +	new_attrs = old_attrs;
> +	attr_apply(&new_attrs, nattr, attrs);
> +
> +	/* only need to update attr */
> +	if (start_page == range_start && last_page == range_last) {
> +		range->attrs = new_attrs;
> +		attr_change_ctx_set(change, &old_attrs,
> +					       &new_attrs, start_page, last_page);
> +		return 0;
> +	}
> +
> +	/* split head */
> +	if (start_page > range_start) {
> +		left = amdgpu_svm_attr_range_alloc(range_start, start_page - 1, &old_attrs);
> +		if (!left)
> +			return -ENOMEM;
> +	}
> +
> +	/* split tail */
> +	if (last_page < range_last) {
> +		right = amdgpu_svm_attr_range_alloc(last_page + 1, range_last, &old_attrs);
> +		if (!right) {
> +			if (left)
> +				kmem_cache_free(amdgpu_svm_attr_range_cache, left);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	attr_remove_range_locked(attr_tree, range, false);
> +	if (left)
> +		amdgpu_svm_attr_range_insert_locked(attr_tree, left);
> +	attr_set_interval(range, start_page, last_page);
> +	range->attrs = new_attrs;
> +	amdgpu_svm_attr_range_insert_locked(attr_tree, range);
> +	if (right)
> +		amdgpu_svm_attr_range_insert_locked(attr_tree, right);
> +
> +	attr_change_ctx_set(change, &old_attrs,
> +				       &new_attrs, start_page, last_page);
> +	return 0;
> +}
> +
> +static int
> +amdgpu_svm_attr_set_range(struct amdgpu_svm_attr_tree *attr_tree,
> +			  const struct amdgpu_svm_attrs *default_attrs,
> +			  unsigned long start_page, unsigned long last_page,
> +			  uint32_t nattr,
> +			  const struct drm_amdgpu_svm_attribute *attrs)
> +{
> +	struct amdgpu_svm *svm = attr_tree->svm;
> +	unsigned long cursor = start_page;
> +	bool need_retry = false;
> +
> +	while (cursor <= last_page) {
> +		struct interval_tree_node *node;
> +		unsigned long seg_last;
> +		struct attr_set_ctx change = { 0 };
> +		int ret;
> +
> +		amdgpu_svm_lock(svm);
> +		mutex_lock(&attr_tree->lock);
> +		node = interval_tree_iter_first(&attr_tree->tree, cursor, cursor);
> +		if (node) {
> +			struct amdgpu_svm_attr_range *range;
> +
> +			range = container_of(node, struct amdgpu_svm_attr_range, it_node);
> +			seg_last = min(last_page, amdgpu_svm_attr_last_page(range));
> +			ret = amdgpu_svm_attr_set_existing(attr_tree, range,
> +								   cursor, seg_last,
> +								   nattr, attrs, &change);
> +		} else {
> +			struct interval_tree_node *next;
> +
> +			seg_last = last_page;
> +			if (cursor != ULONG_MAX) {
> +				next = interval_tree_iter_first(&attr_tree->tree,
> +								cursor + 1,
> +								ULONG_MAX);
> +				if (next) {
> +					struct amdgpu_svm_attr_range *next_range;
> +
> +					next_range = container_of(next,
> +						struct amdgpu_svm_attr_range,
> +						it_node);
> +					seg_last = min(last_page,
> +						       amdgpu_svm_attr_start_page(next_range) - 1);
> +				}
> +			}
> +			ret = amdgpu_svm_attr_set_hole(attr_tree,
> +							       default_attrs,
> +							       cursor, seg_last,
> +							       nattr, attrs,
> +							       &change);
> +		}
> +		mutex_unlock(&attr_tree->lock);
> +
> +		if (ret) {
> +			amdgpu_svm_unlock(svm);
> +			return ret;
> +		}
> +
> +		ret = amdgpu_svm_apply_attr_change(svm,
> +						   &change.old_attrs,
> +						   &change.new_attrs,
> +						   change.start_page,
> +						   change.last_page);
> +		amdgpu_svm_unlock(svm);
> +
> +		if (ret == -EAGAIN) {
> +			need_retry = true;
> +			ret = 0;
> +		}
> +
> +		if (ret)
> +			return ret;
> +
> +		if (seg_last == ULONG_MAX || seg_last == last_page)
> +			break;
> +
> +		cursor = seg_last + 1;
> +	}
> +
> +	return need_retry ? -EAGAIN : 0;
> +}
> +
> +struct amdgpu_svm_attr_tree *
> +amdgpu_svm_attr_tree_create(struct amdgpu_svm *svm)
> +{
> +	struct amdgpu_svm_attr_tree *attr_tree;
> +
> +	attr_tree = kzalloc(sizeof(*attr_tree), GFP_KERNEL);
> +	if (!attr_tree)
> +		return NULL;
> +
> +	mutex_init(&attr_tree->lock);
> +	attr_tree->tree = RB_ROOT_CACHED;
> +	INIT_LIST_HEAD(&attr_tree->range_list);
> +	attr_tree->svm = svm;
> +	return attr_tree;
> +}
> +
> +void amdgpu_svm_attr_tree_destroy(struct amdgpu_svm_attr_tree *attr_tree)
> +{
> +	struct amdgpu_svm_attr_range *range, *tmp;
> +
> +	if (!attr_tree)
> +		return;
> +
> +	mutex_lock(&attr_tree->lock);
> +	list_for_each_entry_safe(range, tmp, &attr_tree->range_list, list) {
> +		interval_tree_remove(&range->it_node, &attr_tree->tree);
> +		list_del_init(&range->list);
> +		kmem_cache_free(amdgpu_svm_attr_range_cache, range);
> +	}
> +	mutex_unlock(&attr_tree->lock);
> +
> +	mutex_destroy(&attr_tree->lock);
> +	kfree(attr_tree);
> +}
> +
> +int amdgpu_svm_attr_set(struct amdgpu_svm_attr_tree *attr_tree,
> +			uint64_t start,
> +			uint64_t size,
> +			uint32_t nattr,
> +			const struct drm_amdgpu_svm_attribute *attrs)
> +{
> +	struct amdgpu_svm *svm = attr_tree->svm;
> +	struct amdgpu_svm_attrs default_attrs;
> +	unsigned long start_page, last_page;
> +	uint32_t i;
> +	int r;
> +
> +	start_page = start >> PAGE_SHIFT;
> +	last_page = (start + size - 1) >> PAGE_SHIFT;
> +
> +	for (i = 0; i < nattr; i++) {
> +		AMDGPU_SVM_TRACE("set attr type %u value 0x%08x range [0x%lx-0x%lx] xnack:%d",
> +			 attrs[i].type, attrs[i].value, start_page, last_page,
> +			 svm->xnack_enabled ? 1 : 0);
> +		r = attr_set_validate(&attrs[i]);
> +		if (r) {
> +			AMDGPU_SVM_TRACE("invalid attribute %u value 0x%08x",
> +					 attrs[i].type, attrs[i].value);
> +			return r;
> +		}
> +	}
> +
> +	r = amdgpu_svm_attr_validate_range_vma(attr_tree, start_page, last_page);
> +	if (r)
> +		return r;
> +
> +	r = amdgpu_svm_attr_check_vm_bo(attr_tree, start_page, last_page,
> +					NULL, NULL);
> +	if (r)
> +		return r;
> +
> +	amdgpu_svm_attr_set_default(attr_tree->svm, &default_attrs);
> +
> +retry:
> +	r = amdgpu_svm_attr_set_range(attr_tree, &default_attrs,
> +					       start_page, last_page,
> +					       nattr, attrs);
> +	if (r == -EAGAIN) {
> +		AMDGPU_SVM_TRACE("attr_set retry [0x%lx-0x%lx]\n",
> +				 start_page, last_page);
> +		amdgpu_svm_sync_work(svm);
> +		cond_resched();
> +		goto retry;
> +	}
> +
> +	return r;
> +}
> +
> +int amdgpu_svm_attr_clear(struct amdgpu_svm_attr_tree *attr_tree,
> +			  unsigned long start_page,
> +			  unsigned long last_page)
> +{
> +	struct interval_tree_node *node;
> +	int r = 0;
> +
> +	if (start_page > last_page)
> +		return -EINVAL;
> +
> +	mutex_lock(&attr_tree->lock);
> +
> +	node = interval_tree_iter_first(&attr_tree->tree, start_page, last_page);
> +	while (node) {
> +		struct interval_tree_node *next;
> +		struct amdgpu_svm_attr_range *range;
> +		unsigned long range_start;
> +		unsigned long range_last;
> +
> +		range = container_of(node, struct amdgpu_svm_attr_range, it_node);
> +		next = interval_tree_iter_next(node, start_page, last_page);
> +		range_start = amdgpu_svm_attr_start_page(range);
> +		range_last = amdgpu_svm_attr_last_page(range);
> +
> +		if (range_start < start_page && range_last > last_page) {
> +			struct amdgpu_svm_attr_range *tail;
> +
> +			tail = amdgpu_svm_attr_range_alloc(last_page + 1, range_last,
> +							   &range->attrs);
> +			if (!tail) {
> +				r = -ENOMEM;
> +				break;
> +			}
> +
> +			attr_remove_range_locked(attr_tree, range, false);
> +			attr_set_interval(range, range_start, start_page - 1);
> +			amdgpu_svm_attr_range_insert_locked(attr_tree, range);
> +			amdgpu_svm_attr_range_insert_locked(attr_tree, tail);
> +		} else if (range_start < start_page) {
> +			attr_remove_range_locked(attr_tree, range, false);
> +			attr_set_interval(range, range_start, start_page - 1);
> +			amdgpu_svm_attr_range_insert_locked(attr_tree, range);
> +		} else if (range_last > last_page) {
> +			attr_remove_range_locked(attr_tree, range, false);
> +			attr_set_interval(range, last_page + 1, range_last);
> +			amdgpu_svm_attr_range_insert_locked(attr_tree, range);
> +		} else {
> +			attr_remove_range_locked(attr_tree, range, true);
> +		}
> +
> +		node = next;
> +	}
> +
> +	mutex_unlock(&attr_tree->lock);
> +	return r;
> +}
> +
> +int amdgpu_svm_attr_reset(struct amdgpu_svm_attr_tree *attr_tree,
> +			  unsigned long start_page,
> +			  unsigned long last_page)
> +{
> +	/*
> +	 * Range with no attr node in this implementation is treated the
> +	 * same as one that explicitly stores default attrs. So clear
> +	 * the attribute ranges when user wants to reset the attrs.
> +	 *
> +	 * - GET_ATTR: return default_attrs to userspace when there is no attr
> +	 *   range.
> +	 * - SET_ATTR: holes are treated as having default_attrs when
> +	 *   computing the change trigger.
> +	 * - Fault: attr lookup falls back to defaults when no attr range exists,
> +	 *   so migration and PTE flag decisions are unchanged.
> +	 *
> +	 * This approach simplifies the implementation and avoids redundant
> +	 * attribute maintenance. This ioctl operation is for attribute only,
> +	 * so do not invalidate the GPU mapping here.
> +	 */
> +	return amdgpu_svm_attr_clear(attr_tree, start_page, last_page);
> +}
> +
> +static void attr_get_ctx_add(struct attr_get_ctx *ctx,
> +			       const struct amdgpu_svm_attrs *attrs)
> +{
> +	if (!ctx->has_range) {
> +		ctx->preferred_loc = attrs->preferred_loc;
> +		ctx->prefetch_loc = attrs->prefetch_loc;
> +		ctx->granularity = attrs->granularity;
> +		ctx->access = attrs->access;
> +		ctx->flags_and = attrs->flags;
> +		ctx->has_range = true;
> +		return;
> +	}
> +
> +	if (ctx->preferred_loc != attrs->preferred_loc)
> +		ctx->preferred_loc = AMDGPU_SVM_LOCATION_UNDEFINED;
> +	if (ctx->prefetch_loc != attrs->prefetch_loc)
> +		ctx->prefetch_loc = AMDGPU_SVM_LOCATION_UNDEFINED;
> +	if (attrs->granularity < ctx->granularity)
> +		ctx->granularity = attrs->granularity;
> +	if (ctx->access != attrs->access)
> +		ctx->access = AMDGPU_SVM_ACCESS_INACCESSIBLE;
> +	ctx->flags_and &= attrs->flags;
> +}
> +
> +static int attr_get_ctx_to_result(const struct attr_get_ctx *ctx,
> +				uint32_t nattr,
> +				struct drm_amdgpu_svm_attribute *attrs)
> +{
> +	uint32_t i;
> +
> +	for (i = 0; i < nattr; i++) {
> +		switch (attrs[i].type) {
> +		case AMDGPU_SVM_ATTR_PREFERRED_LOC:
> +			attrs[i].value = ctx->preferred_loc;
> +			break;
> +		case AMDGPU_SVM_ATTR_PREFETCH_LOC:
> +			attrs[i].value = ctx->prefetch_loc;
> +			break;
> +		case AMDGPU_SVM_ATTR_ACCESS:
> +			attrs[i].value = (uint32_t)ctx->access;
> +			break;
> +		case AMDGPU_SVM_ATTR_HOST_ACCESS:
> +		case AMDGPU_SVM_ATTR_COHERENT:
> +		case AMDGPU_SVM_ATTR_HIVE_LOCAL:
> +		case AMDGPU_SVM_ATTR_GPU_RO:
> +		case AMDGPU_SVM_ATTR_GPU_EXEC:
> +		case AMDGPU_SVM_ATTR_GPU_READ_MOSTLY:
> +		case AMDGPU_SVM_ATTR_EXT_COHERENT: {
> +			uint32_t flag_bit;
> +
> +			if (!attr_flag_type_to_bit(attrs[i].type, &flag_bit))
> +				return -EINVAL;
> +
> +			attrs[i].value = (ctx->flags_and & flag_bit) ? 1 : 0;
> +			break;
> +		}
> +		case AMDGPU_SVM_ATTR_GRANULARITY:
> +			attrs[i].value = ctx->granularity;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int amdgpu_svm_attr_get(struct amdgpu_svm_attr_tree *attr_tree,
> +			uint64_t start, uint64_t size,
> +			uint32_t nattr,
> +			struct drm_amdgpu_svm_attribute *attrs)
> +{
> +	struct amdgpu_svm_attrs default_attrs;
> +	struct attr_get_ctx ctx = { 0 };
> +	struct interval_tree_node *node;
> +	unsigned long start_page, last_page, cursor;
> +	int r;
> +
> +	start_page = start >> PAGE_SHIFT;
> +	last_page = (start + size - 1) >> PAGE_SHIFT;
> +
> +	r = amdgpu_svm_attr_validate_range_vma(attr_tree, start_page, last_page);
> +	if (r)
> +		return r;
> +
> +	r = amdgpu_svm_attr_check_vm_bo(attr_tree, start_page, last_page,
> +					NULL, NULL);
> +	if (r)
> +		return r;
> +
> +	mutex_lock(&attr_tree->lock);
> +	amdgpu_svm_attr_set_default(attr_tree->svm, &default_attrs);
> +	node = interval_tree_iter_first(&attr_tree->tree, start_page, last_page);
> +
> +	if (!node) {
> +		attr_get_ctx_add(&ctx, &default_attrs);
> +		r = attr_get_ctx_to_result(&ctx, nattr, attrs);
> +		mutex_unlock(&attr_tree->lock);
> +		return r;
> +	}
> +
> +	cursor = start_page;
> +	while (cursor <= last_page) {
> +		const struct amdgpu_svm_attrs *range_attrs;
> +		unsigned long range_last = last_page;
> +		struct amdgpu_svm_attr_range *range = NULL;
> +		unsigned long next;
> +
> +		if (node) {
> +			range = container_of(node, struct amdgpu_svm_attr_range,
> +					     it_node);
> +
> +			if (amdgpu_svm_attr_last_page(range) < cursor) {
> +				node = interval_tree_iter_next(node, start_page,
> +							      last_page);
> +				continue;
> +			}
> +
> +			if (amdgpu_svm_attr_start_page(range) <= cursor) {
> +				range_last = min(last_page, amdgpu_svm_attr_last_page(range));
> +				node = interval_tree_iter_next(node, start_page,
> +							      last_page);
> +			} else {
> +				range_last = min(last_page,
> +						 amdgpu_svm_attr_start_page(range) - 1);
> +				range = NULL;
> +			}
> +		}
> +
> +		range_attrs = range ? &range->attrs : &default_attrs;
> +		attr_get_ctx_add(&ctx, range_attrs);
> +
> +		if (range_last == ULONG_MAX)
> +			break;
> +
> +		next = range_last + 1;
> +		if (next <= cursor)
> +			break;
> +		cursor = next;
> +	}
> +
> +	if (!ctx.has_range)
> +		attr_get_ctx_add(&ctx, &default_attrs);
> +
> +	r = attr_get_ctx_to_result(&ctx, nattr, attrs);
> +	mutex_unlock(&attr_tree->lock);
> +	return r;
> +}

