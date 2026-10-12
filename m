Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4A9CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0501F10E3CA;
	Mon, 12 Oct 2026 07:51:24 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013032.outbound.protection.outlook.com
 [40.93.196.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F07E10E3CA
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 07:51:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c38qzwaUUTiXHU9uRyk2AHOQ0VcZ+702hk0/00CS85HqNyVoEF/ayC1YL3ppuDsE7FF+ze229ptoq/vPaYtncyMMU2bi0Oy+pVZmWSHK/SwKI7/2qBP4fggVUARiWzqtbQdBrViPyetrUusZlTjZquOLYQzjPuUfCmuBLoKYy1kWvMBHjpO1dhgfiiKTQmt+qhFapXIsAGqqNgiM9OgJOIpJfPFHNrmUyNsg1OsQWz70Qx1h/Euef3NpJ8vwvY7V5i46mn8H0OxQtQRC6kcELz25aWNDsQSMJ54isgodZEJa+mPwZhLSVc6ZpB3BNqGWQt2RNgSB1CzFRt+CfY2kmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uO/LsM90vHJ9EP7bsceinIU4AJdSnqLnJKYeOKx/Kw0=;
 b=W97A43wTqb659vVV989dd44O5JBHlsv4XzGy+INWg1weKubPs6Z3NkVdaZPaXwxgSk1xS3nSYdOZkrOQVJ25BsyAYP5kjftZQhvp8O7zO+/DJU9KGtacXmZzrgRNCLIqoJ297aaCOr1rRtnclacuRv4Rggvb9kkXE5HPz2VExXUYDLUnhuaEUdWXQycsRqNZqwDnakySr6+CeL+sNB0ThVhiyuGMuwBp5mqcT5/wuQ7e7MqEEcLgkawxrYHPLPMVeUNikoWIeJnJJXS1rDI3zbaQHhDJho9iFDvDeJIYQ8rs6tLFUOK8lb4jWzmhlaWqBkkVQGYFV06cE2ilarfBKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uO/LsM90vHJ9EP7bsceinIU4AJdSnqLnJKYeOKx/Kw0=;
 b=mxTxad+e/Pbr8+JMahjd3YI5/XInavjHXLPSNfAMcgu/rmXIlAFUUowTRikojV3PinvY84bPYO4h5FcZiXGlu5cqQrF2Hmd+Wq2jzM+3ATDYdGbjEYvxHSic+qn4VGfVcQfiAHnUtU4CBJw3aSIT/0tQcHpEvpaOkA/Lu3pku3U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Mon, 12 Oct
 2026 07:51:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 07:51:13 +0000
Message-ID: <f70c39c0-3754-4a18-8ad9-eaaf8a307b8f@amd.com>
Date: Mon, 12 Oct 2026 09:51:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/syncobj: flatten chains when importing sync_file
 into timeline point
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
 <20261010180711.1548333-3-ju.orth@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261010180711.1548333-3-ju.orth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0171.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::26) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: c6203cdd-f57a-4c68-b2b5-08df2835966c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|56012099006|261009221227099003|4143699003|11063799006|6133799003|10067099003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: f2eea8olq6VwQuNN5AE3XI9xYEMzcdZXYIvNpShkHrYbMdfFR/9ud0lEnBhCUf4xSJhlCeJ8YeBYurjgTM0AMg7hoebcza9eOnOU0AEhqYnJYxeIebJwDGDdf87WdUf8BnnUr/PbeQe+ugRkUfGXi9ah1HcDCfnTsNdrTiTU9s0pklvLMmm03iF1d3M0+4hl5k7UQOL7rXyNhBn4FyDKToegN/ilzIBE7/XWqaqdnG61A6Pjho1bt8YtqWkE1Vfou/3HC2h3tC4fRmloHbdkf44RxVVNojLcepXmMHKO7tkth+mDbIiDVVwZavIoHxXLk73Gke326SvpmhTaF8BKPbGtuuhHbzD+YFKc8BtT4QPJ2juqha3X9NBRBSfZ0VGn7uyOAN6GMU7pMYmjiVQ9JYyjyYV8iD15fAjFmbCHXL7TUyCIXm/XPsf4VMbOXw803IUgkH6ZR1xCdwsPlbuf9CdDRB6cWcCqJbFa+a1rJ40cHNRdPHCLZwd4akA5NRLjGGM42O5GyUNdvD12k+0JLs57aSPCR7wZf90gI/UYT4p6urD31BVQGtQPzvJ4rMVfMhcGi4em1oIdsY3ems+ytFHdXQkNXkQ/7tj7p6Sw/KOAAlQIITCjYXJDOv/CkizUHz6osWf6QiIGgyKbXfCzqQTWAqXEPwvx3Y/scUbCco0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(56012099006)(261009221227099003)(4143699003)(11063799006)(6133799003)(10067099003)(22082099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3AzSkJtaWlhWnJxZVNCRkVnS3Q2MnhBRUE2c2hwRWNGcjYrVXBrQWJmQm8z?=
 =?utf-8?B?R2h3azRDd016MEVPaUorcFpUWVNFdXNRSXp6VmxaL1llSGhpSXBIMitZQVl1?=
 =?utf-8?B?dHdOWEZ5WXFYYXA3UlBaVk5tdWpGMDVuZnBXdkJmZnI5MnFaL2g3Y253ZzVJ?=
 =?utf-8?B?UmQrWndpZEJubHQyc3BkOTN4bGVMMVg4WHJmeWtNODlzWlQ5R0lnOTg2UzdV?=
 =?utf-8?B?UmphcEw0RDF5RWxTbjNiMWRDTGxtaUJNSFNnTjlDc1JseXpDRjA0dllPOWs5?=
 =?utf-8?B?ODkzaDZpakptRjlZcnJkK29kdk96VzhLRkFzWlh0WWxtbGd3YWtJUFRSZVYz?=
 =?utf-8?B?VnlaYkJjanhMUXdtVENDNXYzakpFbzZ0TmdLdmVlTzdJQ1ZFYXlOSEgwZ1VY?=
 =?utf-8?B?M1pSM3FXR0lrUWlHUUp2VDdEYXg4cmI2d3hpVVZUdkZMeEtyMXVUeTlrYTdW?=
 =?utf-8?B?NEpmc0lVWDRqUm1PTTRuS0o0NkVHN3BBVnlGaUdQVkJSK1UySURuYnZBamNs?=
 =?utf-8?B?a3QxdXp5VHBmNEh0Zzh2cE90R29ZSjRReFBYMjZkK3J2enY3MHcxUjlncXpR?=
 =?utf-8?B?aW5ydnNHUGkzbzhSNkdydDE2UHN1bHFZNHQyeGc5N1YwRm1NT3lKeTgxRFlJ?=
 =?utf-8?B?WnFkZWtHNUJNWWt0NnJlL3Z4cDZtcE12RWxFdDZaa0NaQnJNOHNOcHFkVlFT?=
 =?utf-8?B?Ukl6UHhPeDdLeFA2ZU80NFNNTDhzYTdITTJObDR3VzNRd1pHUVdHVFNHV2p5?=
 =?utf-8?B?eVcwSTI3c3p5TlRtYkZSWFZWcC8rVlAxNWhvS0t1OWs3czdYK3Bjei9GUStr?=
 =?utf-8?B?ZExNVkt6UzlYUHpEUEhtRGYrb1ByMWROcjdySzBNV0RpbkFCV0p4WnczT3ZB?=
 =?utf-8?B?N0JEcG04K29nU3Z2Um1lWFhpYjVvS0hrZDBLVENDMDhZQjFEanFqOEhEVzJV?=
 =?utf-8?B?Mk04MzhrOTlycVdiamxkczZ4TXRwY3lPc1EvWmZvbUYwajNTU3FBYWdWdFU3?=
 =?utf-8?B?VnhZWUs4VUNLK2cwVk5OQ3JpbVQ1bm16UkRac2VTOGptcnp0QWo3dHpJQjZp?=
 =?utf-8?B?NldvclFRZDBrNWNJYWRMOEVram1saldsVG9zTytiMlErK1IzcHpOYmFERDZQ?=
 =?utf-8?B?OXBKZnBXaXlKaW91VVZpeTFnTStybmpOSkt5SGVnL3hSNE5qZWtLYmZUT3RU?=
 =?utf-8?B?ZGoxRVNQcnk0aG5pWWRrUDB3a1pYbzcwdUt3bkxVUDB4aXA0ZThLd1Z3VG0v?=
 =?utf-8?B?aEw1Wm9QbytGUWthOFVvdkx5U1o4ZkJjcFBFQXlLc05veUw2TjdJWmNOWFRD?=
 =?utf-8?B?am1OMmp6VFlncVhpQ0lUTDZ5OVZtWkMrSjh6bkpQYkFlZkRKWEhvcEpNRVY3?=
 =?utf-8?B?MGZKSEZjNTlXbncxc3N2RHRuK0tuWGI2U0JYUndUKzc5UnRZaWdBdHh1OHYv?=
 =?utf-8?B?TDR3emd6N3Yrcnp3QUdTQUp1anBhOW1oaEFUejNDQzY0MU9NTU5ZOUJZNm5k?=
 =?utf-8?B?WjJZM1ZhL1FlUEIzUDhOOUVGYUtLYzhXT1dvVGwyUkpnM2JNclpQNWM0MW5h?=
 =?utf-8?B?dERYWHo2RHFzL3RXRUpyWGZ4bHZGbWpOVFA0RzhoVDJlcmhPR3R5Snd4Qnlw?=
 =?utf-8?B?ME01S1VqUTh3aVN1bkdxR0Q2eXB2WkRUS1VsNUFmTk9JNzRCMWVnRFF6T2Vu?=
 =?utf-8?B?czJieEZuVWpvb1p1N2ExOTBCdFpBKy9LMm8zZ0poVGZZQkppeW5wWUFOdDFZ?=
 =?utf-8?B?dlJ1ZVJFWnVQcmJBTE41ZzlmamQ0UVhHZTJOMmNMRDNpYmhaTGVja0dhNzZi?=
 =?utf-8?B?QkRKdnZ0YUJoRTc5RmI2Nm1uWVRudTZ3Z3Y1Y3VmVnNMTWRKak9HWXgrOG1K?=
 =?utf-8?B?dXVNa1kxUVowVjliQnJESWRPQnk5bTdiVS9vc3hPMm52cFZ5aXYyM1JnK2tj?=
 =?utf-8?B?RG85dXhWZ3J3SGdoVjQ5RlJzVGVOVzBxUFFtREUrRXV2dnBMRSs2aDZGaGFK?=
 =?utf-8?B?ZUp3YlB6Z3hNTDhJUFUxK1BJU0NkYXdlUEMremdUZi9IaTNQUVdGZkF0VFJB?=
 =?utf-8?B?RHl6bm53eHBkcnpkUWY4bTVzaWN1OWNmMURDRjB4NnZjY2h2U3ZBYnd2VUdq?=
 =?utf-8?B?NklDL1ZYOWJJUTFOSlh0VDZJTUtoVHFVYWlWNjA3V21pZzRBbk9ON2tFaHc3?=
 =?utf-8?B?akE1VXVETlc1b1lvQWJzQmYzNjlkM0dacHJXWkFXL2pITW1JOHhnbDhHdGh4?=
 =?utf-8?B?K0tjakJIek8rMWN4RGVvYituZEJMeFh2SWVudElxbUNnNHNDYUlDelpQUG5q?=
 =?utf-8?Q?lLoZfovliMRZWQ+C+5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6203cdd-f57a-4c68-b2b5-08df2835966c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 07:51:13.3277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rv15xwFXyHbeFZa3lHkI5bG4172QgXhKWQNFDdpCgzHoXpgwtRzzoj5seUw1xRVA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8750
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
> A sync_file exported from a timeline point can contain a dma_fence_chain.

No it can't, IIRC sync files are only supposed to contain raw fences or dma_fence_array containers.

I think we never documented that and that's why this issue here leaked in.

I'm not sure if that doesn't break anywhere else as well, so I think we should fix the exporting side instead.

Alternatively we need to audit everywhere where fences from syncfiles can be imported somewhere else.

Regards,
Christian.

> Importing such a sync_file into a timeline point with
> DRM_SYNCOBJ_FD_TO_HANDLE_FLAGS_IMPORT_SYNC_FILE |
> DRM_SYNCOBJ_FD_TO_HANDLE_FLAGS_TIMELINE passes the chain directly to
> dma_fence_chain_init() and triggers
> 
>   WARNING: drivers/dma-buf/dma-fence-chain.c:286 at dma_fence_chain_init
> 
> because chain fences must not be wrapped in other chain fences.
> 
> Flatten the fence with dma_fence_unwrap_merge() before adding it to the
> timeline, as drm_syncobj_transfer_to_timeline() already does.
> 
> Reproducer:
> 
> 1. Export a sync_file from a point > 0 of a timeline syncobj with
>    DRM_IOCTL_SYNCOBJ_HANDLE_TO_FD.
> 2. Import it into a point > 0 of another timeline syncobj with
>    DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE.
> 
> Fixes: c2d3a7300695 ("drm/syncobj: Extend EXPORT_SYNC_FILE for timeline syncobjs")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Julian Orth <ju.orth@gmail.com>
> ---
>  drivers/gpu/drm/drm_syncobj.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index 5ca5163d0..c545af77e 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -742,8 +742,18 @@ static int drm_syncobj_import_sync_file_fence(struct drm_file *file_private,
>  	}
>  
>  	if (point) {
> -		struct dma_fence_chain *chain = dma_fence_chain_alloc();
> +		struct dma_fence_chain *chain;
> +		struct dma_fence *tmp;
> +
> +		tmp = dma_fence_unwrap_merge(fence);
> +		dma_fence_put(fence);
> +		fence = tmp;
> +		if (!fence) {
> +			drm_syncobj_put(syncobj);
> +			return -ENOMEM;
> +		}
>  
> +		chain = dma_fence_chain_alloc();
>  		if (!chain) {
>  			ret = -ENOMEM;
>  			goto out;

