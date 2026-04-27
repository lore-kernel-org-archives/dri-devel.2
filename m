Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBD2FF8862
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:13:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C58A10E5A9;
	Mon, 27 Apr 2026 07:13:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z/2sAaZu";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010041.outbound.protection.outlook.com
 [52.101.193.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9674A10E5A4;
 Mon, 27 Apr 2026 07:13:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2gTZfzULoc5P+LLukwcNFqa3ZSgKP/oPYT2H0Dapc78C51JjTC3em8taSvse65tf4mh+OV5mPr+3lbHMT29q6Tp4keANYcCZ0KbVZsXUOvuhDQZ6KXx9PBaPkO++HEmxYy3PUxJpiJ/jlfUCHIFXBHuEfwMBoRmrzGDa1J2AWCG/FmIlGjQsuaMRBI5TpKkPs49MYgZr15YNuXC8qyz12uS349h/N+EFWmZYYIbW/SMu+uKZdiSBgrLl9Ek8I516eqqbFmmyfUBFCGtmjQtCRIucl5BQPIZ4sEBhuZ/gwgFYk1YqU2zh/MgssyiPv5KuK9u51iJtNdKStK4JEp8Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1vEels2utEC27ppk3OrdZfvUmxj8AYUD81AxLd6c94=;
 b=bd7SkyjGwOwj7iwxRtbAfwqL3gDcn0Ky1GjFyqbyr5zqFk3dzl0R06Y8C89lmMO6/RVkbmTgCjIx9iB2ui+jkjtbeGOVqGrkwvotEgyHbqeT31LDzz+VtEsZGkxJPU390tLonNmaKFQceUaUjATsZoLgGotKX+cdvKSw6g5wswvurYDVDdNEBvYGEh6BZjBKG/HM8f/VZmwkUd5QiX8h5E6R3dEs01eQHe/e/vSAfJiv3Q0u7w8bYhcWC/c4RQG8NeIa3e7Eg7JRGcfI9UJcX5lluiu28ID2twpKjCVb0i0Wqvq/KkVbwawBTjzw4fOH6w3EebTdujbbKiaGp5xsBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1vEels2utEC27ppk3OrdZfvUmxj8AYUD81AxLd6c94=;
 b=Z/2sAaZujRDKWpZnyIFJAS0yO1U0KsYHeStYvSbs6DcjDg2c7ixYiGIInO9FqwAxbmUxhLZ2UtQQ1Fp7TaQypn0vtTMhYlc0+JhQeXx3EbZBpdk7RxjG8d3bzan0x8OnBMqRtSu/d3wmwoa0rwAcOEkEBmyisFcyLDhlSAne7AA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 07:13:45 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%5]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 07:13:45 +0000
Message-ID: <40b61c46-4ac0-4215-afa0-8d06dda9810a@amd.com>
Date: Mon, 27 Apr 2026 09:13:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu: reject IB addresses with reserved
 byte-swap bits
To: "John B. Moore" <jbmoore61@gmail.com>, alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, simona@ffwll.ch, stable@vger.kernel.org
References: <20260424140816.43766-1-jbmoore61@gmail.com>
 <20260424140816.43766-2-jbmoore61@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260424140816.43766-2-jbmoore61@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::7) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|BL1PR12MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e032bd-bec7-4c7b-d59e-08dea42c8507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: wTXCliLnVQpGs5sh4TlHEKkd+fbAhjlIeS4fxkaZVq97Rg2omNJcTa/eCwzAQGIq1XZO9WtYHyVjWYbZryCudRSgUfhkF70k1MmcjlYaad1JMtBjte41+F65Kx+VYMiAd9TU4P1e2XJUyKV9XO3YddFtBYmLlmTXwNkSwczS3Sbtp37h8Oxn/FkdNP3Ip2FXkS3HrMB+eEnPmiQX22NndEmQYo7fwno0T+k2vnj9jfTFp9bFQFwD/Wo8roaltBXxYRzUxyEAR/f7+u6Ft+3kXIqI7kuilfbz+fNzxcNAXodoXfM5hUFCRy9JsBOIJhiGf1QNXM3d+fgaMMlXrAeq/yXNvfTwIpH++E4xQN3smlK1hqux1aeC0XHz6V6gfH58FhB3wKEcRgYk3iO/bAMbqfSWrmQ/dHT2RGk4NRMJWMr/bfl/W68GfDfQ2UtkzntFJvlH74niM+D5N+BUw2ZAXhLfJyo5kHCuzzoJ3mlnaE6f3bubMaz7d0ox3Rx/YzAa2mLq+SuSW6/TWnb2M07znw+yYi4Viwkc8Xf9/yHZCNX+UKSPfrM7EW82LI0K+Br/vEl2eIpfjNymg+MyxGQHEC4OBXd2kqLcY54gUfr3HtJaReEEA35DoLh/4QVZzri+rRLmIJcWzc6M7bvrs0u8Apm4otRMfIzCFtZdkTiuNrVy7yviJ+25yLGS3TwhBH5NIlvdIM80l/mZmU2J3VVuclh2+kQI1RrrradRPITI7PQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzhKODVNTlI3UyswL3ZhcWgxakRmWjJFSlVOenVZaFZwZXMvMU1HRlJYOTBQ?=
 =?utf-8?B?SUJDZ1ZhV2Qxdlp5WjVhd2poWDZjU0hkNy9EOFZvTTN6ZUNSdFZKOWJ0cFM0?=
 =?utf-8?B?UUlKZ1BoWDkyeStqVGJUcUVpc1lTYTVURzh1bWtZcDZtVHJDdEV1SVc0Z29l?=
 =?utf-8?B?dzNsb3RKdi9wdE1za1dUdHhidkV1Z3ZublZVQnVhSzJPRk1mT3dkWWltUy9U?=
 =?utf-8?B?TzRzRWZmMFM4N2dIL3ozbi9KcGdZaW9aV251NlFMYzY4QjZsak9FajMwOGh3?=
 =?utf-8?B?ajFzZWoyanNNZThaSTZ2RmNZU1dHakM1TXJwNmVvTkcyUnJ2RmFyUUZ1cUVh?=
 =?utf-8?B?YStrL3ZreHZlUzFPclBLME5BMlJCVllkdlNkTVF3UlhEUVhpOWpvZlkrWW0z?=
 =?utf-8?B?cWhERW5zQmRhelFiQUpsYW5yaVFsbm8rSWlaQVd2VXk0RHd6aTVWWkR0cHR0?=
 =?utf-8?B?dHB2VlhMTHNJN0RzYXptWGRKYjlsS3JzaWEybzYwSXl2TGM2WjZOSmJ0Vjh5?=
 =?utf-8?B?dG1mZXo3MmdaMjgwTkRnYWxrR09JMU10QU5nRmpqckZQK3JnQjhVcGNnaFdN?=
 =?utf-8?B?akJMY2RkYnAvRW15TkdKRjJPQkg4cVBjUWtPZTZRdXRwVVZ4NEZLQ3hkKy9v?=
 =?utf-8?B?NnEyRUJ4b3cycjNFZlBCU1pZUG9aNUdlem80bzVXWkhCNzgxOFBvbmtjL0Nx?=
 =?utf-8?B?N0E2eGQ0RldQVFA4NUxkY0VNYWgzMUtObGRXd3BmYURSSEovUDNtbzNlemdI?=
 =?utf-8?B?UW43ZU81WTZHZ0pua0ZRZjZJRFBZRjRvOSs0Q2Q5ZForL2ZML0kwaWVrWWRm?=
 =?utf-8?B?TUZVQW5Da2wzUFgyeVNOaUYzdjdpZVIwR0R1a2VERmJIKzFQVTIvYXZLK3oz?=
 =?utf-8?B?YkZEMkdTWnVpV3lJK0VCeTFLdWcraThGdmFXRVlTRS9uV2svSXViZzZZVVht?=
 =?utf-8?B?eTQwdUM3eVhFMmt5WEczZXdKNUliR1VPSEFXbUlmMHBTa2xsTG9VTXo2ZzNt?=
 =?utf-8?B?WXhtSVNEdVc1emExYXcvaC9mRS9ZOUJMbzhHUm5tQ2kwTlFreW9FUGZLSEE3?=
 =?utf-8?B?MkFNMDdhSVFmT05oNVVHTFl6S0x0QmdXL1pyZDZWVGFmb1dwNkR3ZElOWFVo?=
 =?utf-8?B?S0JMcUVxSEVHV2NUcllxQVlxUmhnbi9TRGZzMEpIQnovRklGZk9rU1lyNkpC?=
 =?utf-8?B?RzNaV0g1SE1zaTd1VTFLdUp1Q3lYOU04Qjljb3hpS25tZHlmeE81ejI1blJZ?=
 =?utf-8?B?Ym5LdWpUV3A3ekFhS0x4RU1GLzB3azU4WlF2N05xZEJLRTY0YStWUGE4STY1?=
 =?utf-8?B?ZlpKRGJRS3NVUWpaRXJHS0l4eVB5aTFCZVVFNWdxT0NiU3pjM3ZvamFjcGU2?=
 =?utf-8?B?TzhVNE1udytYdjQ2eCtMdXBTeXMrN1UwWkFJL0tmQWZEd0tuNTJxbU95WnpL?=
 =?utf-8?B?ZDd0SFZHbFdvcThyZm0rOVJsR3pqZG9oYUJ2dHMyK0JhWlhzekc3Wnl4U2ZG?=
 =?utf-8?B?ejdqb3JtQmltY3p0WmplTi8vMFBWQ1UwUWl1VlZHcFNyL1hvbm53eXROMjV0?=
 =?utf-8?B?WnYyMkFRaUtxRE1jUHQwZjRwM1haenBEZnBKeHpFaWRUM0luVHdkd083TGh4?=
 =?utf-8?B?M3ZYZXF3ejlQMVViUG13RUZwanN1OStDZ1JJOEViSUMwYzlDa0Yzd2hHNUZn?=
 =?utf-8?B?WGs1a1dxS21aMWQ4VTcrQjd3R2ltTjZpakVYNWNGT1JncXBjMmhwUUh2ZThy?=
 =?utf-8?B?SlFvTzlmeWF2Y2h2V2xPZ0xsdTVveWtWc3E5N0J1ZnFCcERkVkg2amZaSldj?=
 =?utf-8?B?L0g3cHJ5aWNmWnNIbEJ0MjJ4dXYyQnFXbGFGTkcxQmlKQms3OEJGS21BbHEr?=
 =?utf-8?B?a2FvUUhIWCtubFJGdSsxTzBWcVA0MUExNStxMERwNXl5U25LV1R6c0tNT1J5?=
 =?utf-8?B?ZXBrenVMTC91Ym54eEdmNmVCbGMySCtvaUI2VnJ1TEtqL1AwL2NMUjdjNER2?=
 =?utf-8?B?RlVZY0laWjJreFRIQ1ZtWHk0akg0eGw5eFNwZjFnTVVENlBLQnVQT29XR0ZE?=
 =?utf-8?B?Y211c2JGZ1Q5Z0J5ZU5ianlaV1hzSEtkeWw4T2ZmNFVRYmtSWWhHeVZvQjNp?=
 =?utf-8?B?SUhXK0MxOVBBTlV1a01ITG5HY1JHQW5tZnFYYktTSlZCUXFoU0pUY1AzV2JC?=
 =?utf-8?B?RTNLMkU4WUZEZnA1Mi91MFpYRzRqTERMclhYVzFtWkRTejlXRmlLV0M4UXFW?=
 =?utf-8?B?TDNpYXh5eWI2bkxoZ1AxZ1ZkdHVsRUEzaVhnS0VOZW42RnYybmZnUnNWUXpW?=
 =?utf-8?Q?8jPrnhjmuHe7a4w8TE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e032bd-bec7-4c7b-d59e-08dea42c8507
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 07:13:45.3515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dtDYtAcEmPWenDliY2vDfzrqdRdm6avXj4iFd6LXi09wWKzOe/6UqEKTPlVRtrI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802
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

On 4/24/26 16:08, John B. Moore wrote:
> Reject IB GPU addresses with bits [1:0] set early in the CS parser,
> before they reach ring emission callbacks. On legacy AMD hardware
> (pre-amdgpu era), these two bits encoded byte-swap mode for IB memory
> fetches. That feature was dropped on all hardware that amdgpu supports,
> but the ring emission paths still contain BUG_ON(addr & 0x3) assertions
> that crash the kernel if userspace submits a misaligned IB address.
> 
> Add an early check in amdgpu_cs_p2_ib() to reject such submissions
> with -EINVAL before the IB is allocated, and a defense-in-depth
> WARN_ON_ONCE in amdgpu_ib_schedule() to catch any that slip through
> from other code paths.
> 
> Fixes: b0635e808290 ("drm/amdgpu: implement GFX 9.0 support (v2)")
> Cc: stable@vger.kernel.org
> Signed-off-by: John B. Moore <jbmoore61@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |  8 ++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 10 ++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 10d8dcc3a..53f537f3e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -379,6 +379,14 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
>  	if (chunk_ib->flags & AMDGPU_IB_FLAG_PREAMBLE)
>  		job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT;
>  
> +	/* Reject IB addresses with reserved byte-swap bits set.
> +	 * On legacy HW (pre-amdgpu), bits [1:0] encoded byte-swap mode
> +	 * for IB fetches. That feature is deprecated on all HW that
> +	 * amdgpu supports, so these bits must be zero.
> +	 */
> +	if (chunk_ib->va_start & 0x3)
> +		return -EINVAL;
> +
>  	r =  amdgpu_ib_get(p->adev, vm, ring->funcs->parse_cs ?
>  			   chunk_ib->ib_bytes : 0,
>  			   AMDGPU_IB_POOL_DELAYED, ib);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index f1ed4a436..3111d2c7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -272,6 +272,16 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  	for (i = 0; i < num_ibs; ++i) {
>  		ib = &ibs[i];
>  
> +		/* Defense-in-depth: the CS parser rejects misaligned IB
> +		 * addresses, but catch any that slip through before they
> +		 * hit BUG_ON(addr & 0x3) in ring emission callbacks.
> +		 */
> +		if (WARN_ON_ONCE(ib->gpu_addr & 0x3)) {
> +			r = -EINVAL;
> +			amdgpu_ring_undo(ring);
> +			goto free_fence;
> +		}
> +

Please drop that chunk. Apart from that the patch looks good to me.

Regards,
Christian.

>  		if (job && ring->funcs->emit_frame_cntl) {
>  			if (secure != !!(ib->flags & AMDGPU_IB_FLAGS_SECURE)) {
>  				amdgpu_ring_emit_frame_cntl(ring, false, secure);

