Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B69606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=c5nf8Ck0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7D4210E86E;
	Thu, 19 Nov 2026 11:07:40 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F5FB10E86E
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 11:07:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RP+JJnCjTbs/MH6s/6p3vp9HEzZ0d3CO2sZtnEW9RHvroe5MfxPueVuh32uxXyXP60Hq00V/kXtzXRluFemTzYCSAsIRPYkHd8m9msalaNDt+gY5vVmlg7YZkDTTa5RuCCgCPJUxvnhAtDQG592LxqVDnc0eMpo+6OUJ0vXFgQZk9UBLdEQgf7AoCV8UPLkgN+nRkzKyr/v0n4MwAH5bLhvBvSFzmsdSZ3JoRHYPpmH57YVOfrYP+JNF2IzQml+Z1CugzQyL5fSMf1xCHdY34ZfXHet67D3z2HMuQq4wDwn+iPdNClZQOydh6pvAgT3NyJgXk08Mh0XbpMGdOpkiEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHuopW2Wxs0hTqo1IXDiFRakpzVAygA5rQl1dSsGQKU=;
 b=Gelr+iiA3CqPGJLpH1qVad9S23litQ4i/X+64HlVp6+qtrkMPHgTaZbkQg6WWr7773Fow+UwBFqFU/0K3ZnYdFMxPOMCmlWZQthlzP0HyHWseZtzOeLToaHUQ6dNsHpuIz1pYv7DHOPLX9sTGCI22V1YE3P+uGrVY23dE3WRzIm1472zpnUXE4qeLSdJVPpr3S0Qj49ZB/PpcpO0CB8cmiw4cUVPUcrW0m9Uwo6anCnImzBLBbqsd7USrLFiQkC5Er6CI9udtY6B7Touwg3q5/NWzK2lAQtSb0RvzmPI3mhi/g3UIhheRgvdA8mlr8xIvZxUmTYq+KbffzKt4ALhxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHuopW2Wxs0hTqo1IXDiFRakpzVAygA5rQl1dSsGQKU=;
 b=c5nf8Ck0RhGZg91zBBb6qlyCHOBeSoSE6wNAHk+rNYsPAbLDGrGDGnqPExdORqM6v85M4BKaz39gi5J5jTJ5cZqP7BE09F6R2MM+8QWTwbDfaMz3NJH/Ar90rP4JANF3iv59oin32dN4f8+QBN9DBQORTaBT/jOvS0bf05U0+QY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DSVPR12MB999174.namprd12.prod.outlook.com (2603:10b6:8:389::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 11:07:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 11:07:31 +0000
Message-ID: <81394c1b-e147-4f5e-ac12-6c9040d60d7a@amd.com>
Date: Thu, 19 Nov 2026 12:07:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dma-buf/dma-fence: Prevent misordering for error checks
To: Philipp Stanner <phasta@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Chris Wilson <chris@chris-wilson.co.uk>, Danilo Krummrich <dakr@kernel.org>,
 Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261119104030.2381685-3-phasta@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261119104030.2381685-3-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:208:52f::26) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DSVPR12MB999174:EE_
X-MS-Office365-Filtering-Correlation-Id: e24e6d25-a8ad-4b8f-e3a4-08df462d4e39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|18002099003|22082099003|921020|11063799006|10067099003|56012099006|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: ipf654GJY0jKlteeIZbmY+6WKN4AQkj3pg8pN3N6rQTkxG/Jj7Dch9QxTj0DyHleao+YJwjiAUw6kVPcdIppggoVPNfzD42gV/LpEM/uCX8OVdV58jRYIUocGAcjO87CP3N0v1nNu9a107hlQizDhMEXsuiy21kvExZ/4M7pYOlkMJRq2rVldWYIU2fyJQwsiMhqU0HqUFQWQRmAZwMRskqqzrw+pw65ywNfMWfNSO5BVd6ALN38lpZEVgl6mtE494y9Wxv7aCGPyEA44DTcJEDDOT+zwgRFAKRC016hW3n7T2leegs2poz+ENw6KnVBEeAkTjxau4m3GZspI/QLnvUKI//AfOyTjsYDwbGfIG2h016h38A2rJljluXUZWrOyqqMaDT0kxEzXFHP32ju/n1g5ocil+AvFOiNJHfFJSN1ifLRoEGYAgGiSb4Hi30GOjKntUgU0VdqpXdie07c3iXc1EMFNXIci6c/A6+C3CHNB26Hzh27BYka9ZYqki4+vlHZKpcJ9cRKqI4h8fo9mY202I0L6mfz/VacFG2OGuRGLT7uhwwSdJK3e0KwXACPbMJwdvt/EI2AFbzCxZQqcjR+BMDFdOGSATcQnxNM/ThT+mB+r20S9kaUmj5YwgtrWS4RLveqOTssb3c6jgxo1Xu6+9Ex01Gwlb1mtCk31sHc0tSekaPTzNIHz9V1OjOxv3s6m0g49RrozfewUAvT3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(921020)(11063799006)(10067099003)(56012099006)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QStxWDRYN3dDOGdIWEJJU2VPZW9vQnFZT2VrYlY2U29ZY3RwNS91dkxoenJx?=
 =?utf-8?B?TytsdElySGptSkRCRXVwT2prNmpnTWlWVVN6TW1qM0lkaVNLYTVsZ1Aybkl6?=
 =?utf-8?B?L2FFaFI4SklHSjRudm81Y2pXSUZrRVBSemhyYnFQYS84cU1IZVFGNVJuS2tn?=
 =?utf-8?B?WGhPL1RqM1E3RmF4OGUzNlpwVzBqc2VSVmhrWlNqSkxwNDR3ZjNvZzN6cUxX?=
 =?utf-8?B?NUpoNzZ5MGZZSmVUZnI2c1Z4NUJaODZSYmRDb0g2SzVMSUJjd2FnM3hzVjd1?=
 =?utf-8?B?UEt2ZkZoelA0cWJaSktoMUFjK2VXR0Q2WW0yRFQ5SHEyZjN0Q2FtTm42ODVr?=
 =?utf-8?B?bDg5UHp2Q3dZZ2ZCbThqclVUZ3Bxak1zN09vUEp5OUx1dEN0TUNINzRXSS9O?=
 =?utf-8?B?ZmNueDh3b2RTMzRNQUpjV2w4aEZMSUlwZEsyNGNqL2VRdm5iMkhTVkMrQnU2?=
 =?utf-8?B?YThnSkkvWVVnc0tmMm1PNWFPQ3Q1ZXl0akxmMUxKLzh2dklucXdQR2NGM1h3?=
 =?utf-8?B?Wi9NcVowVjBUZ1NXTWU0a2ZCS2JaOThaZkl1VERkY3BueVIvSDZnVnMxWVNH?=
 =?utf-8?B?S3NZVTJDd3NYK1JtVm1Sem14MWdIa21PSjRkTDNrWUNUb0wxSkJYMTczYzhS?=
 =?utf-8?B?Q2xGMVlCU3RXQW5uelkrcVE3YXlxcHhzcmxUV0pwc3NadUE4cVJOSDJCTXBT?=
 =?utf-8?B?c3VJZ1ZudURRY0hoL1ZYS2c5empLNitJZmlaTnV6dXFlenBDN0pOYzN0c2pK?=
 =?utf-8?B?OUllSmYySk1RQ1dWKzY0R3pvaDExNDQ4Yy9wRml2VFNURS9vYm5ZZXR3aGpX?=
 =?utf-8?B?azMzdlkxOXpIRjFBTy9HRExWaXQzRDBBZlIzc3dUendDVEhRdUxMMnZjUjRI?=
 =?utf-8?B?WUU5OEZMRHQwVVcreUIxWTh1dkl1L1ROaG44b291b1dYRlRHR0xBZ0hpeTRq?=
 =?utf-8?B?eXJhSTQwUDlOdFhLNFd3VHlRQU5qcnE5NHBkaVRWbU1FRzI5UFFhVnJxSWs3?=
 =?utf-8?B?UUlnRUVzbm5PZjNRSXErRk1CRWM0MTMva1lGYXNEdThMb3lWcEFzM3pXUEND?=
 =?utf-8?B?M2FucEJhV3JEY1FrQWRSWnJ2c2Nad0daNXdFZHM5eWZEb0tKYjl4SmFTTWMw?=
 =?utf-8?B?algxT2N4STVWeUdJck83eHNpY2psdjhaTkpib3lCR0d0RExkYXlrQ20vdFMv?=
 =?utf-8?B?ZWJFOTV0ZThNNnIvYkk3RGJ3dis4Tjc3TGxubTlJQmJ4YmlDRWxmQldKMU45?=
 =?utf-8?B?Vk1SYnNqK3U1NXhEYVdtMkZmL1NFZEM3aXVuUWhHaVRHYkk2NUpoZUZna29s?=
 =?utf-8?B?ZTdKV1Q1eVlTb3hPdm9vL3Uzdm1iQy9iQVpCVlRGaDYxS0h3bEo3SXg2SWl1?=
 =?utf-8?B?VHRIVU14eXVmRGFhemdIUC9EN3dGSmc5VUNJMGIvOUJJTHFzdGFENDBtQ05C?=
 =?utf-8?B?cTZwWjAvZGQxT1ZMSkhBNUlzNThJTjRsMWh1RUVBUjM0OFRkeXVLMG1mQ1dr?=
 =?utf-8?B?ZUpDb1AzVWV0Zi9aS3hVQ3BkV0ZENDVCL1IrVFdRdXBDV0oyRFNqdjlOcmNp?=
 =?utf-8?B?dW56L05jd1M4Zk9xMzFJeVBsTXRmSjJUdDdJMkZYRGxCWk9jTDBmYXZmMGRN?=
 =?utf-8?B?dElPTWVJZ0IwYVkxMFBhQjRqVzEwNWhCVGFjeTFrcXBKTlpDZjRva2tQc2hp?=
 =?utf-8?B?K3ZTV0JYbmg3UkloaTJXS3V0QW81T1FWbE9KT1BUdmZYb0ZMVTg4V2tRZDZn?=
 =?utf-8?B?Q2NjbjY1cGJSUkpJRFFxM0prK0tEMjE5NEMxV2RxT1J6SzBIaFpWQ01ad2RS?=
 =?utf-8?B?Y3AxU2d0WUUvTHBJVXVUUWtod3NFaGpvSzNjRWZUOG9obVZEUmdxSENqbnR6?=
 =?utf-8?B?OThNd0NZZzhWSUxpbVpGd3VlbUpRNGQ1MEQvaXdhbFJEWC9tYm1CeVlKUUp1?=
 =?utf-8?B?VUlnc21tQmRtQlBUb213bm52Z1hlbDBMbDZ4c0xYRCtWbHgrd0phRkJzSHM5?=
 =?utf-8?B?UnloSG5HQklpUnBXTFlCaEJGVm1RWDl0bzlvdStKTTMyV2c2WmMrMEN0aWxu?=
 =?utf-8?B?VDJybzVWNU1zUldjVjBIU1lJdzVZb3NBK1BGL2pUbmRJcktDWlVzbkJZU0o4?=
 =?utf-8?B?RjZRZ1Qxc2Yxb3VyMFc3L1JQRzRSdTVlSEV6UjdETFI5YlhKdm9id1QrYVhx?=
 =?utf-8?B?MzBXUnBKNnBueC82dzQ1TzhNNm56NEVYV0pDN1RESEphVElYdGNzbGxZSTN2?=
 =?utf-8?B?WmVVazRJUWpCcDV4UmJsU0o5RGhrazdoVklZODQ4N1NGTWVqSm9NY3c0M2Ix?=
 =?utf-8?Q?gI3vGmm4VGVX/hpmfj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24e6d25-a8ad-4b8f-e3a4-08df462d4e39
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 11:07:31.1184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MyVssDxLSXu896+s3RSYuhzzh5rm0mpM7xr7C74BRgoP1hjBAuGEd7D6t5n5k0tl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999174
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



On 11/19/26 11:40, Philipp Stanner wrote:
> Many users of dma_fence do things like:
> 
> // Thread A
> dma_fence_set_error(f, -EINVAL);
> dma_fence_signal(f); // <- test_and_set_bit() orders against the above.
> 
> // Thread B
> if (dma_fence_is_signaled(f)) // <- Does test_bit(), no ordering.
> 	pr_info("err: %i\n", f->error); // <- Can be loaded first.
> 
> There is no memory ordering between reading of the signaled-bit and
> reading of the error code. This can result in outdated, wrong error
> codes being evaluated by the user. That's a significant bug when we
> consider that fences' purpose is to propagate the state of jobs running
> on hardware.
> 
> dma_fence_get_status() does take the fence lock, presumably to ensure
> ordering, but it is broken, too, because the read misordering can simply
> happen within the critical section.
> 
> It's not entirely clear since when this bug exists, but at least since
> dma_fence_get_status() was added, which is why its birth commit is
> marked as the Fixes commit here.
> 
> Ensure ordering for everyone evaluating the error code centrally by
> using test_bit_acquire() in dma_fence_test_signaled_flag().
> 
> Cc: stable@vger.kernel.org
> Fixes: d6c99f4bf093 ("dma-fence: Wrap querying the fence->status")
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
> Let's go with Gary's proposal for now, and have this patch here remain
> simple so that it can be trivially be backported, since this is a
> severe potential bug.
> 
> Changes in v3:
>   - Be more precise in code comments and commit message about how the
>     ordering works. (Gary)
>   - Update the function's documentation to inform about ordering
>     semantics.
> ---
>  include/linux/dma-fence.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index dd07d128adc3..a41b9a7792e1 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -487,16 +487,20 @@ const char __rcu *dma_fence_timeline_name(struct dma_fence *fence);
>   * with the fence in any way. The user must, therefore, ensure through other
>   * means that fences get signaled eventually.
>   *
> - * This function uses test_bit(), which is thread-safe. Naturally, this function
> - * should be used opportunistically; a fence could get signaled at any moment
> - * after the check is done.

Please keep the note that this function is opportunistically, e.g. that the fence can be signaled at any moment after the check is done.

Regards,
Christian.

> + * This function provides acquire ordering. This means that all stores
> + * preceding signaling a fence are visible in correct order to users of this
> + * function.
>   *
>   * Return: true if signaled, false otherwise.
>   */
>  static inline bool
>  dma_fence_test_signaled_flag(struct dma_fence *fence)
>  {
> -	return test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
> +	/*
> +	 * The release counterpart is the test_and_set_bit() in
> +	 * dma_fence_signal_timestamp_locked().
> +	 */
> +	return test_bit_acquire(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
>  }
>  
>  /**

