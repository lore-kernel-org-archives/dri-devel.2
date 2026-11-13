Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F51606A895
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 23:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qmfOqo8S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 777C210E173;
	Fri, 13 Nov 2026 23:58:37 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9093A10E156;
 Fri, 13 Nov 2026 23:58:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eviACCwnGJEHZ9L2sc+oD2c1vMHcG1igclTlY/aM+sjCaFAVFIEZXNxuWOZoJ5hjMWH/XPC8NiNF9M0p0NsRKD6a4Foko81AD7WR/uSrpRHBFueS7BqOhDzip8VcI+JS0T5JeujtdbDDZueZ7HsUhNrVV4WiSOxO6B312SBaVcJ0jYd/UjHndHT25jLUtmn/DrKYFOsKfg/oXNbb06PiUslR455bZTDzRZLSAmZHP7m5iuQfAmMKkzCj+OK3lBSQRSOQcIVoUuUEakTqzcvY4OZPa6UFcqFK5Ouab8QdX/MhJDKv3vcDr66z93Q91/XvNCtqxIkqtuq9Uq7ZbXF4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlZgs/chQKA2ikofuGFd9qD/IBZQld761oMwP3ucOuI=;
 b=j1DOwIXmCKbSkdh6WOKvJs1p0s/8+0mQXywnudt/QkX1vfT5dxCenDhrf/AStLHFzljsv772SRFyf7P47byf9uEvCCnejbkeAT/BLcz+S+rpi48p0GwhTipdpXNWxYswSZPuf2wqSIIqSRY4I8rS6/EQxwEsxECha4QxK00t+tFAfIdTmkCLYHXatoqGkpJqIKHKN5BGjn7smGSMOhVL5trFA6CDqSbCmnZFog4k6B+Depg7qr7yv1mng9E6wqUyDWuK8ghVOslNkE7GEVY7RlTU/12hgo+kVrXKj+ej2TVWskFlELDlI7X3Vcb8ptH+oTl5J9RKFKow2fF+Ym+Y+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlZgs/chQKA2ikofuGFd9qD/IBZQld761oMwP3ucOuI=;
 b=qmfOqo8Si4esg36XcMR5WPM4Cob9teWQOstuojggKNCjbRIRnePVpNprphwWFXAqH1qOcUb5D8y/Lq+kjds/3QMrEa9Dr0WsnJU7hKdH2Ju4WGdKjbakT4y9cq12Tb91UUr4nhI7qX1grqAw9eEKkCM8X8qQqt0IYGZC8GKnP1Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d5) by DS0PR12MB8072.namprd12.prod.outlook.com
 (2603:10b6:8:dd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 23:58:26 +0000
Received: from SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 ([fe80::fd82:d106:2d09:2dcc]) by SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 ([fe80::fd82:d106:2d09:2dcc%5]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 23:58:26 +0000
Message-ID: <e2dbed20-e6f7-443c-99af-c7316571aa25@amd.com>
Date: Fri, 13 Nov 2026 18:58:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: preserve the byte address when removing retry
 faults
To: Aveline Noir <jm5905938@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, honghuan@amd.com, honglei1.huang@amd.com,
 linux-kernel@vger.kernel.org, Mikhail Gavrilov
 <mikhail.v.gavrilov@gmail.com>, Natalie Vock <nat@pixelcluster.dev>,
 Philip Yang <Philip.Yang@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Prike Liang <Prike.Liang@amd.com>, psirt@amd.com, sashiko-bot@kernel.org,
 sashiko-reviews@lists.linux.dev, Simona Vetter <simona@ffwll.ch>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>
References: <20261108-kfd-fault-filter-address-20261108-v1-1-ef13f9dd24e4@gmail.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20261108-kfd-fault-filter-address-20261108-v1-1-ef13f9dd24e4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::35) To SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPF8ECEC29A9:EE_|DS0PR12MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e77c133-44bf-4a4b-e9ff-08df41e201c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|18002099003|22082099003|261009223027099003|11063799006|56012099006|10067099003|261102123227099003|261028144727099003|261022105027099003|261026140227099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: NYkcjSg1Q4pAafAIubwiV76K5VeM7qv8WZivPLIB2IzbNHqt0ShojNUSm7wzo5w+YI00UaOaGcmJ/ZTUaI69VNrjxJBQkzc+PbdcYcjPYiLJ3HK3GBijHwHLjL3KxR2zucshGvhtoLqMilutpa49Fl6b83HmzrXaPBd0RWLFSJEFud23DnZKpL6//u/EAz7tlULiLNle6RbB0i/cojA+PYehf5Ay3+VX77XNBUCdX90UaNbeANWK48TfNY0sNTUAUy52IZtZFcH54b58APe4bLQkFODc46qynYEh3zkJsOxFy5HE3x80UCrsNvNcFpOVFyTpJD+g6XDMwFCNEXiMqPu50FvCJaVfllX8dB/AZ0CJgcSd6XnrjYaRnAmgFaSsUfbE7I2AeDdUbJvnE1cSyg2y1/3yqpgc7s/J5PX9qYv85EsTn1NfpwWIA2yMA/72IG4n/IH52XzN55nszDAIwAXlYU52GBGFw4y76/hcKnGhYvanWOsyb26GfZRMztzVpACfOo1yOkfciTxUSGflUXbaRIt7YLaRXVrKqmE3RkYTdPh8+A34JwTtSF4f0HfDjzhKUuGIUwUVpqfqsJFVKvIq+douRnOGns+0ZliP6GeX336MSFeBSr062fpbw4w3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA5PPF8ECEC29A9.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261028144727099003)(261022105027099003)(261026140227099003)(261021123027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3NENWlMekZSbFg3TGdVdmNzSmRqdThGOG9qL2wxbXhHejVhTVJJRjZ0UVhu?=
 =?utf-8?B?S29UdmZ5UExPb1ovMnp6dDlZanNQbitJLytlcEt0MVFWTU9qaTg3RlRNcHpI?=
 =?utf-8?B?R2tCTUFhbHJuc2ZwSDUzelQ0L1JWblZuLzVicFBLcGttaEtieWVVWXh6Vkdt?=
 =?utf-8?B?ZHFVZEVId2FDdTVnbVgwemwvRlVnN0gxSzEyTGx3UUVJSitxWTRkYWJLcngz?=
 =?utf-8?B?QUhKRVVYeGx0Z0MzZUtlSjdRQjJHVnFpZmVlMnZSVmdnRjFNTlRsRHFCdE5x?=
 =?utf-8?B?d2ovaEZPZHp0T05ScmxqUmRIa3YxaVRzaVJpSmRFQWx4d0kxYW5CellORVZt?=
 =?utf-8?B?UlQwQm12ZHFoZnZFMU5QMUNUL3FmMWEyamdsR3ZrRmtVR2NSNXk4bVh4MzBx?=
 =?utf-8?B?dW1EOG9Da0FqSUgwQ2NwUzFENUFpM29GdGl5RHkvNHJZN0IxQ0NpbmhvYVJI?=
 =?utf-8?B?OFhVd2Y5aVB1aU1XSXJscGl2blVyQmNma2YrTE5DM0VpS2kyd2l0VXgwWDZt?=
 =?utf-8?B?enhEZTUzUi9qcGhGcEFld2sxQWVHQ3hydVRGZVJsU21maUNHdGZCNXNYL3Zs?=
 =?utf-8?B?QTB4MjVQT1BUYzA4cDE5NVdHSENwMVZzc2s3WGpZM3IvNTRpTldQa3FLWDBn?=
 =?utf-8?B?WlRJVFdoMHphS0tyeTMyWWhTN2ZGQUhiRGFURmVpYjlaem5laVFqd3k1cnRt?=
 =?utf-8?B?ZFYyMVVOZmYyczJvZC9LQlV6WUVueEFqNDIvQWM2NkF6MGRPaE12NlJRNjZY?=
 =?utf-8?B?Y0pHN2ZEZzNOT0U4aGxoVjB4b0x4amxjU2Y0WWJMSnFmZVlaQ3FQakJVZy9m?=
 =?utf-8?B?RDZ6ZmV5QnRpWjYrb1c3WjFQSlZIcnIvbEFReTZUanhvSThiYW5ZYnlNOVMx?=
 =?utf-8?B?bGVoTnUyTHd5akpwcE41eTV3S3luR2VpU2FRSVlZa3cwQWhiL1k3eGljR1lY?=
 =?utf-8?B?OTNnTDU5cXlPVjJTRzJnQWNXMnprN25OeU03MlNkQzdCRGpWbGl4ZXJaSThi?=
 =?utf-8?B?ZTZjaUlMMG5RNEZhbXdEK2ZFV1ZDazFjVDJqQzNZemgya2VlL2g4TklFWjQ0?=
 =?utf-8?B?VU50QWFTaG9DUEVEbDV6K2x3djJDSEhzdG1EbXR0VGhOQWMvSUZ4WmJEWEZK?=
 =?utf-8?B?Y0lLMitIczhsTTU3RU54c2R6MWg0SUVjYkQvc3BDdGxON0RTQkZGeXJubXJJ?=
 =?utf-8?B?ejVHdEd2eHJJRHJicDVpZXZtQS9vem1SNXQrSnlUWHAwUnhjOHROOG83QWZB?=
 =?utf-8?B?QnpEdWJLK05hWFprd1NGM2JGRWxZeE55SVVCSTIwbGR6Y1dYZVhCQ1V1Mi9F?=
 =?utf-8?B?RnNjSG5wb2ZFb2ptcTlFZjJzY2RqcG1XOTRtbEMxZTM1cUpIY0hpeHEvc1Zt?=
 =?utf-8?B?ekprN3laM2lIdnJJVU9MdStaUXJlZnBEVy9xbXArVS9NY2NsTStQTGtWRUdv?=
 =?utf-8?B?TlVsNUFrNk4weC9EUzB2SjZ4bUNsVU05aDY4a2NDaithSVZIRlZLdVRmdkh4?=
 =?utf-8?B?VkJhZWc5eXZPQy8xQUdONjM1dXNUOUQ2MUViNDFkQmhHSHNXbloyNndLMThY?=
 =?utf-8?B?eTVVV09zR3BVbWszYktGNitBQkNUSHdtdXEzOUV2aCt5ZCtNU0Rld1R2R2xj?=
 =?utf-8?B?RUNSZUREcFVjUWtqNGlhTFBZeU43U3h6RmtpU0svUDZQTjgvQXgwalMxWWNp?=
 =?utf-8?B?dnVDRXZSUFJwZDJjbkJRZzdiYWJZS01QVUwyalRKdm5LemZPVlFxNm9JYlNw?=
 =?utf-8?B?MHZMdW4xcTlQenYxVjFtVzMrVDhFV3BrTWJPUFN5YnFRWC93U1JPbWFzaUxn?=
 =?utf-8?B?VC9JeHVGU3U0SHh2dVY2bnZxcmp6WXhLbFRJbEx1cGF2WXRUY0Jsa0N2Y3Bm?=
 =?utf-8?B?UWkzZXVDQXpJMXpPd1d0ZGQ4Q0Y4YTlhQjJZK3E1SWNJRE9JcUpRaVFTWWlp?=
 =?utf-8?B?c0xzYjd6ejdQYTN4WGlqTjNrY3JOUk1FNEZOa25GeThnd3ZoZVp6a0JNRnNu?=
 =?utf-8?B?MWxuNWIzR1kzUm5jaGF0Y0dJdGZ0MFVTdExUcE52SnpIYzdPbVU0UGpLakJO?=
 =?utf-8?B?bHR2REpwdTlkcEhHbVNVNHI5WGNRQ09icVZDQVo2WkZ4Z2U0b0l5cDlyc2dm?=
 =?utf-8?B?V05SWUVwMTc4WlV4My9Oa3E0TndEUk1iMUhIZWxJTHNORUJGbzF1cndZQmRv?=
 =?utf-8?B?RnVqdHdHaytyRWl3S25IZTltb29IM1RJZERyVVJ1SmtvK29OOHpZTG00MlBo?=
 =?utf-8?B?NTFPamU4WHJ1SVpQK1hwSTVMS1ZBQzc1UUxUZTRNNVJFSWJwTHpKcGtoNlJV?=
 =?utf-8?B?ZzJmWnZqQ2lRTGJzcW1VMDhQZFRGVTI3b1ljSzlHSHFzQTNqRUNnQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e77c133-44bf-4a4b-e9ff-08df41e201c6
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF8ECEC29A9.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 23:58:26.0655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AsgwqvHV2F+L//4z7N8Lig/hbL6o8txEOvwYlycVU0llf7LWnWsqJk39jcKFPcTy38VNavkbf9PUfrJf4Es23g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8072
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-08 04:15, Aveline Noir wrote:
> svm_range_restore_pages() receives a CPU page number, but passes it
> unchanged to amdgpu_gmc_filter_faults_remove() when recovery is deferred
> or returns -EAGAIN. The software fault filter uses a byte address and
> PASID as its key, so this can leave the fault filtered until the entry
> ages out.
>
> Pass the original byte address to svm_range_restore_pages() and derive
> the CPU page number locally for range operations. Use the original
> address for both filter removals. This also preserves the GPU subpage
> offset when CPU pages are larger than the 4 KiB GPU page size.

Good catch. All the addresses in page fault handlers and the filter 
should all be be 4KB page aligned (GPU page size). But 
svm_range_restore_pages works with page numbers based on the CPU page 
size, which may be larger on some architectures. So passing in the byte 
address is the most sane way to keep it straight. The patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

I'm applying it to amd-staging-drm-next.


>
> Fixes: b3dc91f97317 ("drm/amdkfd: enable subsequent retry fault")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/sashiko-outbox-203586@kernel.org
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>
> ---
> No testing on AMD hardware. Any test will be appreciated.
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 7 ++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h   | 4 ++--
>   3 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index c41e9c0916b7..86ef849097fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -3092,7 +3092,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   		drm_exec_fini(&exec);
>   
>   		if (!svm_range_restore_pages(adev, pasid, vmid,
> -					     node_id, addr >> PAGE_SHIFT, ts, write_fault))
> +					     node_id, addr, ts, write_fault))
>   			return true;
>   
>   		/* Re-acquire the VM lock, could be that the VM was freed in between. */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 79455e23a030..c85d6bb73629 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -3130,8 +3130,9 @@ svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
>   int
>   svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   			uint32_t vmid, uint32_t node_id,
> -			uint64_t addr, uint64_t ts, bool write_fault)
> +			uint64_t fault_addr, uint64_t ts, bool write_fault)
>   {
> +	uint64_t addr = fault_addr >> PAGE_SHIFT;
>   	unsigned long start, last, size;
>   	struct mm_struct *mm = NULL;
>   	struct svm_range_list *svms;
> @@ -3249,7 +3250,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	mutex_lock(&prange->migrate_mutex);
>   
>   	if (svm_range_skip_recover(prange)) {
> -		amdgpu_gmc_filter_faults_remove(node->adev, addr, pasid);
> +		amdgpu_gmc_filter_faults_remove(node->adev, fault_addr, pasid);
>   		r = 0;
>   		goto out_unlock_range;
>   	}
> @@ -3353,7 +3354,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   
>   	if (r == -EAGAIN) {
>   		pr_debug("recover vm fault later\n");
> -		amdgpu_gmc_filter_faults_remove(node->adev, addr, pasid);
> +		amdgpu_gmc_filter_faults_remove(node->adev, fault_addr, pasid);
>   		r = 0;
>   	}
>   	return r;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index c7d7adae4476..38744e716f74 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -178,7 +178,7 @@ int svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
>   			    bool clear);
>   void svm_range_vram_node_free(struct svm_range *prange);
>   int svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
> -			    uint32_t vmid, uint32_t node_id, uint64_t addr, uint64_t ts,
> +			    uint32_t vmid, uint32_t node_id, uint64_t fault_addr, uint64_t ts,
>   			    bool write_fault);
>   int svm_range_evict_svm_bo(struct amdgpu_bo *bo);
>   
> @@ -230,7 +230,7 @@ static inline void svm_range_list_fini(struct kfd_process *p)
>   static inline int svm_range_restore_pages(struct amdgpu_device *adev,
>   					  unsigned int pasid,
>   					  uint32_t client_id, uint32_t node_id,
> -					  uint64_t addr, uint64_t ts, bool write_fault)
> +					  uint64_t fault_addr, uint64_t ts, bool write_fault)
>   {
>   	return -EFAULT;
>   }
>
> ---
> base-commit: 403b3d68346d7ba25f474f0686ad1d05feb65b7c
> change-id: 20261108-kfd-fault-filter-address-20261108-4f096f2b2a1a
>
> Best regards,
> --
> Aveline Noir <jm5905938@gmail.com>
