Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBDF606A324
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LalHbdds
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AE6A10E85F;
	Fri, 30 Oct 2026 09:08:54 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010058.outbound.protection.outlook.com [52.101.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0674B10E85F
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:08:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9lcURQp06rmAS03OatXt/ZJFMDgvp61wHBk+mfR7msHfG1N2I81ooUbYCBZByGZ4bXQSzarPNGYEiTOJmm51qNGjtlT9OxR3D/1Qt2BaqGIZ83521eEgoBu5f65HjIV7IPvIPmQfrFHLeCs/gaLWriVnXKCaIvF/zRkibUHwFTHjnMmzV6YsNRWV3xymAwaa/XQM5HOhWtT4mngi9Yb5qoZav+I3xvxUtA/ikx8wmqY4stxL7rEr1SgJgTj38nV8NR+tXaiOMOBbtwuSrZ90VXNkuppqO56t7074vEF2x9JRcGrbfpV3uvD7OSILKDCjXA0YMEleZgDLGYjA4dRiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdxAKpBPM254fhRamTErSvovMKcL/gYo87U9gWM/Acg=;
 b=p/3N7ZtblOpcrgWZ0f3SsWsccEY/aWN8WBT55rGna+E6hhvkHm6zSVfE1vajdDlaWUWX4GYfmt9yrOGQLVyDlPQjd5pjD/BO1BTfzhKTxFc1BlsnMn+0J+8Gblw6sTYcuRuENp/muQbv7jTqq0Jfnuh+QtYqWpbBcarBJcKJjEv/hqYz50NYubLUU+Su7wuumzvgAz6B8E2p0pV5Y1ACn+hR3rmwvmxOowm4E/w6AmCt1CA9jHKpKLKMrqwdBde61t1SLKOzlzLFGiyNo8nYXxuolTj90iYDyX5vT/XMA3TYed1EBjeidJbEiFxVkPrwTDtOs9Rvrr4uNCiuw0gCwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdxAKpBPM254fhRamTErSvovMKcL/gYo87U9gWM/Acg=;
 b=LalHbddsFMfV4WW94SC4g7qo7bXM2gQaJcogRLjINmvK+m4ROyu0SxxWoFWt9T3/NWFKOIiT2Sq8nnfZQOu2Vl+PI5+++usbzohRbIrEEsM0eUHmZFXrKVdCaVlPvQRpADrO8JZYfVLyvtTc9eyQXE+kKDu8zJ4UQZbdbDXjQcE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV0PR12MB142838.namprd12.prod.outlook.com (2603:10b6:408:3de::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:08:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Fri, 30 Oct 2026
 09:08:44 +0000
Message-ID: <eece89ab-37b7-426a-bba7-32aa1b00ef10@amd.com>
Date: Fri, 30 Oct 2026 10:08:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: f_fs: Remove deprecated dma_fence->ops
To: Philipp Stanner <phasta@kernel.org>, Neill Kapron <nkapron@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Paul Cercueil <paul@crapouillou.net>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Sam Day <me@samcday.com>,
 Michael Bommarito <michael.bommarito@gmail.com>,
 Gabriel Prostitis <prostitisgabriel@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20261029125143.1744481-2-phasta@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261029125143.1744481-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0321.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV0PR12MB142838:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9c2e4c-75fc-4509-a4ad-08df366565d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|921020|11063799006|56012099006|261009223027099003|261026140227099003|261021123027099003|261022105027099003|261028144727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TFlRb5cSfFbphy49/hp8RHvxGPkOV31WdgPlL7og7d6ovJUJJZ9vj89VSj599w1KeURzrKgxUT0AryWFXHA9wOUMbRes0piGmnaP+TaQzPMepd40eb/AG+h8LfTR2mmVWGUz4wQ1VReXxQAmF8Ss8VOnQA2smidLRI+eloOKo4fEcPd0qm/UzboA2zi47M6VhGa/BNm3/N2J9uDHv/itHhEETA2S5CD5O6ULKYgUCaAXdYSPDbPDAwISdQh0IOtsO40dvecTBRnAQbQk8ZZwaxHH5+RDHEWUL9wB2iy9ZqqAxl7fc+8GZANJh+9G7HrTFGdizd8djDVUsoci/GhFIWYmg0rlAY4h75lA6kdrSmF/mO8LJgDSeMw4HXR3CLLMML44bd398DpH9DEaHH4lyAc6BqVwT9cYaWgacx3vVogdZrPPTBHEcCB5ifS1qBYdzjUV5H53U2Ssdn3zfMr6qSBh5b4O33kUW4qrNCSAmexyul72PwSP/+v5zrchtwDw5EW+WfZ9crma1tr/xmyBKe94JQI7rTRczwMrHKubmnMYEo3L9zconFSpWFQ2KDKaqrWW0dIwoaToVq6ZK1pJiTbMoVbzmjRF7vLeq/vu3+TJ6xqO1ynFHVjRaxLdmplMSltE7e6tmwQeP3jhb71bApDZLM6l1f7K7a1bTlPjp2m83GasGx3Ts/D0D6+0j/9quyf6HdSrO4UM+PwnXoRXiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261021123027099003)(261022105027099003)(261028144727099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eklhWmlveFVjUmhiNnR0SVI0VnhFN2dUMllTbWdsNHI4SUNIRm1GMUxWRW4z?=
 =?utf-8?B?M2dXeWV3dkxCdmg5QVB3d1B2V0k0c3BPYzY2c2oyNmxqcEFBd1ZGYmRVWkVJ?=
 =?utf-8?B?VU1rMUJCMGg0MURDQXNDTVRTS2JITWZ0WEtBWlIwNlRXTks4bjdhRDQ5by9z?=
 =?utf-8?B?elNHd1BZc0Vack9YUlFuM3JSckNOa3dxa0d5cEpjaUF0QXAwbHRIMEdXbWZ2?=
 =?utf-8?B?Y1VZL3V3VkZPV1F5aUh3dklMS2E5bUhSVmRnT1ZuVUlGQTBRa1kwS0ZteElQ?=
 =?utf-8?B?bktHQXFBRzQyMm1samU2TlNBQTdCVkpndllYKzVCOWMrWXRuRExUZzNpMnUw?=
 =?utf-8?B?bk5jS2xOdE8xK0RTeTFsQVJRNWF0RTUrV0NkN2YrTnRPZjNpNjRmbk43cG52?=
 =?utf-8?B?UzBkSWJaZnJWdTl5QVRKVnZGZXRlMVJGYkx6aitGWjFQMlZsZHBDczNYNkxB?=
 =?utf-8?B?K25YazRkbFVJN01XNDFscXJ0MEQ3VHNIc3lwK2x6WnU5NWxESFY4LzdJTTNH?=
 =?utf-8?B?dHViTWdCT3ljZm5vVGV0TXZvL1VUcTdUMmp6RHpWWjhjS0R6OUtMaXc2bUlj?=
 =?utf-8?B?NmhjZHdlTG5qMVZQNHRQb0hmNVlXT2k0b010K2llRkszekt6dW1FWXluNU5W?=
 =?utf-8?B?U0tTTldPWVpNNUlXL2VNdHdZL2xqWDJCYWY4cCtUdnAvUWtSRndGQjVqZ1Y0?=
 =?utf-8?B?K2llcGxtK1RkbDlOVWUxcmZxbE1vYVIrbVpiUnFOSVRaUE5ZZVBCaW4xd0xF?=
 =?utf-8?B?SEJnSUNzV1ZMcnFnUGdHcHhJVm9wUUtwamVFS3BzUDVWdXorN2s4WUR3REgy?=
 =?utf-8?B?VnVLRFg4VWZnN1g3WThvVHI4SUFHLzFicHI3dnVPaG56WEFBOGxvaW95M2R4?=
 =?utf-8?B?ZFJTWlFQc1VhWWx0aVN6TFgyNFI4Tmw2UHFOTkE3WHJOUzZMU0E3Z1hIMXBF?=
 =?utf-8?B?SnNUVmpaUmJLSnZMVVA5bXlWUkZmQWppalQxMVpIcWpUdXA4VUY2WHlXUGNh?=
 =?utf-8?B?ODNaZmNxeW0vemxtdENxYTVkRUIvSDR0blBXd3p1bTNtdW16NDFxOHBqOW55?=
 =?utf-8?B?OWFJeko5NXhIUG83T1d2MFRqM05LYzBXUVJET2FBQXcvWTFFYmRJTFUrUU80?=
 =?utf-8?B?WXNkTitLNkRjcmpnVFVoWlRkNkxYa1c3Q3NjYVMxWk5xYUNmaFZqMGFNVkFl?=
 =?utf-8?B?QmkxYWh3enBQc0VsWTdSb3hzeFhIQ3R3aVIwcGtXOExtTjhYVGpQOHRIcm9C?=
 =?utf-8?B?cm1md1FHbjFRNTI4cEZaL2NGRjlsTFN3MTlIZnlwNzB6V0pRMjEzanlSTUlU?=
 =?utf-8?B?aWc0cisyUjE0YThnc2U5VXNPTHN4azVlRExyNWNyUTU0R3o2Mm95V0VaWE1l?=
 =?utf-8?B?a1pCYXBva0xsRUFTT2pkK1QwRUZ1WTk3OEhwVURaNEhzd1AxRXhNSzl6WWpt?=
 =?utf-8?B?Z1gxZ3ZiS1YrSmR1cWdBR3ljYTVTL0YyeTdZNStQYkxyZ1lqdjJYK01yUzlv?=
 =?utf-8?B?WDZJcGpNUDJ3citCbzJGa2l2R3pTdGhzTTVVdWRteDNGbVNkTVdNb3ZwMXFt?=
 =?utf-8?B?UjNXM1JaUlZqcFhyendmbWtaSjFmOFMybjQ4c29TblI2SDQ5dzQxZnVQZStl?=
 =?utf-8?B?UmlLa3VNZEdQTytNZU41WW5lK0tvZ2YwS1ZvLzlFR2MrclJ6ampIMGU1Mi9E?=
 =?utf-8?B?cG5rWTYwb2dXOTIwVzMvT0xGNkFtcngyRExwM1FzeGhBckhpNVluTUZsd1Z6?=
 =?utf-8?B?dWZkK09GdUVQa0hjNkcwYmhUQzhMeGJWV3B0bHc0SHZyNmdnajhxZHRWRTJM?=
 =?utf-8?B?bkZWWXJmRnZ0Y2R6K2Z2WTBIY2Nya3dTVnA3Uk14SnliOGNJemVkSFVLdUJp?=
 =?utf-8?B?ZlpPTFNHUitDRVdZdWNRVndLM3FoTGF1M1lkSnVNZ0xJMG1UU1VvTmVkbFBq?=
 =?utf-8?B?bStPMmdwM0l0T05SQm5DbG9pQVNUMmpBUmxjRVpNcjZpdGZpOTNwMCtCR3Nu?=
 =?utf-8?B?STJSOUJmdlpWYmdUakxZYlNxcFgyenZqRm9zWDNOMjhHaENnT1UyMlp5b0xB?=
 =?utf-8?B?emE2VkQrK240Mi9JWlhnU2ZKRHhuVG8wODE2OVFFN0dCa25yUm9hMGJVZmox?=
 =?utf-8?B?Q2xNbHRybWZiSkdVSTlIOXhqSW15M2QzT1E0Z2dOdVpPTEkvRGVMNkZ5aVBG?=
 =?utf-8?B?T2NMQXBCZnBLamcyVk1ibEtjZC9oS3pLbzZpYUx4aDBxVlorVW1tdzkzNlk0?=
 =?utf-8?B?cHB6WkFQYy9oM0pGblFIblY2dlcvNVJneGN2ajc1MU1IRGptZmh2OEEzVTZu?=
 =?utf-8?Q?BZkqX7qUmr+291H7kP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9c2e4c-75fc-4509-a4ad-08df366565d4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:08:43.9332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epfeNHinRDHeee9S8Mhshytlwmh9aY7Sx1Mm+SsGI8q1jNEgbhIgxvcH7cWO8ZXv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB142838
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

On 10/29/26 13:51, Philipp Stanner wrote:
> The dma_fence_ops function ops->release() has been deprecated because it
> prevents drivers from unloading. f_fs's implementation merely frees the
> fence. The dma_fence backend performs this deallocation automatically in
> the correct manner if ops->release() is not implemented.
> 
> The backend simultaneously correctly frees struct ffs_dma_fence since
> struct dma_fence is its base class.
> 
> Remove ops->release().
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/usb/gadget/function/f_fs.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index c64a268e98a4..e8672b37e890 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -1479,18 +1479,9 @@ static const char *ffs_dmabuf_get_timeline_name(struct dma_fence *fence)
>  	return "";
>  }
>  
> -static void ffs_dmabuf_fence_release(struct dma_fence *fence)
> -{
> -	struct ffs_dma_fence *dma_fence =
> -		container_of(fence, struct ffs_dma_fence, base);
> -
> -	kfree(dma_fence);
> -}
> -
>  static const struct dma_fence_ops ffs_dmabuf_fence_ops = {
>  	.get_driver_name	= ffs_dmabuf_get_driver_name,
>  	.get_timeline_name	= ffs_dmabuf_get_timeline_name,
> -	.release		= ffs_dmabuf_fence_release,
>  };
>  
>  static int ffs_dma_resv_lock(struct dma_buf *dmabuf, bool nonblock)

