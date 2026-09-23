Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7009AC9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:13:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A10C110E652;
	Wed, 23 Sep 2026 15:13:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S57fkodu";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010051.outbound.protection.outlook.com [52.101.56.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 250CD10E652
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:13:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPUPFi8YoeHv4Wx+KpKg77/bksQtZU2orgOUZAmWJropxmMgGdBIA8dpbZIkT/T3I3JY06+Jc1Ei/R12eL+ONWrXw829eMIsDWqrAuLq8D1ukPHwFpTqBmR3KXZMfEmWWWNqdrZVEG8VdzSGevMU1MnlJguLwDCLXm4GuNYH4PneV3I/7J3LCfsAP2+Th3++E4K4YMTtY8zv9MVH1S+8H1A0PR9Wzpl/3K/N0y192kaFlaslpkxCOxsEG6xCwGZrgPSRGXXOSYrCKmMP+A9ydM1Pu+/YMEFaVxr+ub6Y+ujhXiHqC8c9He7sV8xfMhnBsVaaoVyIUy6kH0Klv7Xzxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGmc9ja9eE+nKc1AAAjOS0z8bs0sn0vl/URD1jHcjIg=;
 b=cTppukBBjbjRkicYT1hXxPyaMdXNo6uPwCNcogf2LyZroZqs5Hgx5VjBEDaiVT8SuNwNSeiSxQxe487TwObOHitff1EtFof0WTnhaVW4tFOWLWKoJBuHBsaM7Tq/2xqafPmQo/0qLM2g8rGy0AS6SvsjzFr8oGuE1v4PRMlA4sOp3G9/+4sKt4z+LHRoYGV1BeaAKXZLAA6z6/Sbr+btTagnCJBoqHucDz2GQSHDF1MFpDhRX1jJnz6cUY1G6521dVwGWbmxjGhyi1/PVsTxk4E9Uh1cX0ROwFxoY0ji9da+DDQ3x4bxAfVhbxBp84ze3BZGH3A42lkO0bbCupDJXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGmc9ja9eE+nKc1AAAjOS0z8bs0sn0vl/URD1jHcjIg=;
 b=S57fkoduWJcvKgJ4XOrmZ121EcAj6AxGeSY58uZhYEB+UvZXg/gkrcOGt/PSiN0A6sRr7w2KYAwODjB4ClQ0xk9WGEP0KH0UFRmlXvi79No9+3WvH2H7Q0tcoswqMX4rd9dwkpNYyUrqnNUdAOFSA4wyYXAH9jifvqSV1mgxE0s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB9074.namprd12.prod.outlook.com (2603:10b6:510:2f4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 15:13:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 15:13:36 +0000
Message-ID: <3983b2de-b6ee-4674-be22-9ecb2525a055@amd.com>
Date: Wed, 23 Sep 2026 17:13:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf/dma-fence: Mark two callbacks as deprecated
To: Philipp Stanner <phasta@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260923150308.1294592-2-phasta@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260923150308.1294592-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB9074:EE_
X-MS-Office365-Filtering-Correlation-Id: a215a30e-d9d4-4e7b-f0e6-08df19853d83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: bHfIYy50V27m4/cW6oaeJcuHA+WBQ0CvQPL+ogIE3DBPSxzEb9Y4W3rQumQHeZeoSRCJm1R++TKVfL+Ou5WXUy72Oh3NSOCZZbK5H4lb9Uq4IRbcHy625ebU0MyTwlJ6wAEoS0LPKI9bOwYi0NwAYdcRoRvtQeFgrqBMJmIuHZ15b4RWL6W16LhOZfR9d6qXLQKUIsaJS+U6G2hxDJOyumzzSgl836TpSLQ3zD5vfF2pcbN6KHbsDGiknpOUJkvOBcP2qQzC+Ty75NGk4KARpOl2y+jbY34HtSn9H7l9YCa9lpljbNb9bLXJwULa5v/Ulreg51t6nOSI4l4U71cM49YFvKcscq3GpfBDc8e6ieJDdM7SBr7q6BCbDf0/8/FUM3nAc0/J1eeoPQ601C3PFaOlOGh64OmnqD6RiyPWCenoUmg8rlQiNFZqygP2/MRWqiN2z743c32Y1ny+tENoD9Ta6F0h2hTPHKo+NUg74MfS+r+Vd3/qKr7Fbae0z09B4U56Z9DBDqpPsl+oyUDtwOUPq/mRfsB/PSxCghaA8vlxi8SmykhVWsTLD6hFVEIUjgx4BvjWISjX/wzBG36NvXP3Xg7ZiwdA4wM5+tdEQdf2oIE5kspi1WyNSdU33gMw9jg5MPX1DnQGknYGQmggIs/Mj3EYcDG+9+Sjv1+VFBY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWs4UlNDN0VLMHowMDlISUJ0THNnZHZoelhReHB0dG5mU25Ra3loZnpLeThY?=
 =?utf-8?B?SEJQSDgyQWNHZFpRSXd1cm1PenpUdWdpQmkrSzdpUmlZckJlVDBPS3oraDZs?=
 =?utf-8?B?cHFNSTVsOHJySUZ2K2d0dk8vMWMwQmJjMlNnVmRURld4UmxxaXBnczhqWThI?=
 =?utf-8?B?SFYyenM3ZjBGKyt5UituMDFHTHNCZXFaZFlneUtCRG41bG9aQzhkK2hwNmtQ?=
 =?utf-8?B?dmp2Q3luZFdWMG5aaCs0dUdlck9ISTFYanF2QmVKamFBTFhHOXJTQ2h1aSty?=
 =?utf-8?B?TG5tdklHY3lQRlNpK1BCMU9IVksrcWN3VnhuREF4bnJic0VXZGYyTUVMbWlx?=
 =?utf-8?B?dFM0cTFBdmd1UC9hLzNwbFZPMlZJVmgrSDFObnJVb0hOT1NsTDQ4aGkvWUY3?=
 =?utf-8?B?WVFSVDBkMklLZTZBVHBSNVArQXFDeGhrYUlDT0EzYlBrMXMvb3h5R2xudFh1?=
 =?utf-8?B?aWxOeE5WczF3ZHp2eVR1eE9OeXJ4VU05cUpCbm9HUTFHSVo3Q3hIbDUxVFlJ?=
 =?utf-8?B?TE1xWE9LUEk4YXRJNjBlc2lrUDBPUkVUZi8wK0tlOHlKNHRSWm1IL1ZhVGtk?=
 =?utf-8?B?dk9vaVVSaVhoNjZiYmRxZDFLM01BRVpsbHhOQU1WSHB2cHIzT0pxeWk5Um9U?=
 =?utf-8?B?dFRPMitxcWxqV1BMM2xDM3hQbzFsR3FQVE9oZzArL0xFbWJiLzFzdTNLcXhL?=
 =?utf-8?B?bDZZcG04bTBvOHh6TUJGVGZ2SVJwdGpMWVJ3OGZmQkJUQVdjV3YwdTgvMEpI?=
 =?utf-8?B?dXJzeUR5SjBlZzA2MWx6QVByQlA2VnBmME84NDhiZERXY3F2UzdzaGlES1pK?=
 =?utf-8?B?OHNkd3Nib0pqMzcvditBRVFrQUk0alNmbjFRRDl4M1dXeUt2SDBpOGczdEhE?=
 =?utf-8?B?UkZKaGExL0w1eXRQLzhjYmh1RTV3L01LdWdtWWpxVDd4RVFEd3ZQRytDVU5q?=
 =?utf-8?B?bndmdTUwSmF2S21KRGlUQ3h2QmlHZnpveGptMkJjQUh0dTZTZUE4ai96cGww?=
 =?utf-8?B?djd4TE9sVXVyRkV4UFZiWk5JRHRUdHVBcG5RRno5c0xGYUJOOUtLdDZMSVlK?=
 =?utf-8?B?VDd4RzZxZzJWMURNQ0JPbEdZb3FqbWh2Z2twYSszbHZRSkZyL3VDZHE1V29o?=
 =?utf-8?B?OVJOYnRjYkpxOUNzVjk2YUdMYVFjNXltWGJVc3FuVUNvSTErcmZSanVoM21F?=
 =?utf-8?B?OEFnNlpFSGE2R094Q05rNUM0VGJQdXZ6cXVTWDM0SENjeUR5Mm9iVnlvdzhP?=
 =?utf-8?B?R1RBMTBNRTR3ak5rVlRsZjAxZ2lGY0tDL2pCN1laY29NVU9VblR2LzdVeGl3?=
 =?utf-8?B?MXJZMEs4cVUweFRsWGtFOWptZ0Z0ejhpQWhJTy9zbUk1bGJIU3BZRy93cmhT?=
 =?utf-8?B?NWJVQTZFck9JV1hiOGlhb2d6bk5jYktqbHVaVlpOOEVkMjZ4a2dEZ3dqeHNI?=
 =?utf-8?B?bWhZOWVEMjV4YTFhcGVrYUl6bFB0bVNRU0dNQ0MvdEJZYUdLZVZKZUNTMDBT?=
 =?utf-8?B?UFA4RFlnZkkxcGFQdW9GZVJ1ekhJaVRzRHpDUGM3SmozMDNjVFNidWNuUnl4?=
 =?utf-8?B?SkFtQzYvU3JUb2Zwb0hWbEp3b2kxUVRuaEdmZjFGZUgxWHZqaWt1TDRFd3ly?=
 =?utf-8?B?dVZ3N0dXaTBwN3ZCUmNZNXlpTnhwaGlRdm5iMTB3M0wzcWpGT2lOSEN5a0pk?=
 =?utf-8?B?RmhaYVhWWndWV1FhSm4xYkd4VGFsK3lGclZ4N1ArWDVkTjBTcUhlZ3hvWTNW?=
 =?utf-8?B?MTVwdUtmOEgwNmwzSlc1aDhwSG10Q1pWUWtUV281WGErSG83ZFdaZ1cxdE03?=
 =?utf-8?B?YjFTV240VXppcG92Z1ZkQisxbkc2ZXVOQ2NaVGNYd0RxL25yK0FkVGp6bmEy?=
 =?utf-8?B?TUQ5aW9kSGM2YURmQXJ6b0xRTXc1cHR6bXlmN2JIL1NoMW1NQ1ZLeWw3cGJX?=
 =?utf-8?B?Nk1zaGNjL1RzK0htTlJYR3VwU2hTSnBwS0JXWlFuYkE4MHpub1RwNlp2Q2Na?=
 =?utf-8?B?OUtQcUNpdUJqWGFqUWh3bU95QWdCTE81SjhOZm9UWkh5ZUZqQlowRGNGd1p0?=
 =?utf-8?B?RGgyU3JjQUZpRGVjU1J6QVVjSEh0dkRSSWd6OG9Mdm9kWWR3NUt5b3EyKzlp?=
 =?utf-8?B?RUtrVzlJUW1Ia2ZhME00MFg1dzJYMjNOSWkwcWxBKzlxTGYwbjJLSnhxTXRV?=
 =?utf-8?B?MUdtM2pXNitpR1Rmd1RIQkJTb250VTQyelRjSHNNNnlUVElaUS9FelhQMkg3?=
 =?utf-8?B?MEY4UjNxTWZiZGJLc3Y0U3ErdldJcGxnaUJaVE5pamVoOUwwNUxSeW1tWnIy?=
 =?utf-8?Q?IxpAGHm3UNgHMTCHAy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a215a30e-d9d4-4e7b-f0e6-08df19853d83
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:13:36.4531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w56SV1KVMWjosZa7yTQo/+1fHjDgmWpdmUfRNArjY7iAy970/0ztyBs+COywZ3qu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9074
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

On 9/23/26 17:03, Philipp Stanner wrote:
> dma_fence's backend_ops functions ops->wait() and ops->release() are
> problematic because they prevent fence producers from unloading.
> Moreover, they can easily be implemented through simpler means more
> aligned with the dma_fence contract.
> 
> Since the declared goal of dma_fence is to move towards an
> implementation that supports driver-unload in all circumstances, we must
> prevent more parties from implementing those callbacks.
> 
> Deprecate ops->release() and ops->wait() and document what users should
> do instead.
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>  include/linux/dma-fence.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index dd07d128adc3..59af0159cd25 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -220,6 +220,8 @@ struct dma_fence_ops {
>  	/**
>  	 * @wait:
>  	 *
> +	 * DEPRECATED!
> +	 *
>  	 * Custom wait implementation, defaults to dma_fence_default_wait() if
>  	 * not set.
>  	 *
> @@ -236,6 +238,10 @@ struct dma_fence_ops {
>  	 * Implementing this callback prevents the fence from detaching after
>  	 * signaling and so it is necessary for the module providing the
>  	 * dma_fence_ops to stay loaded as long as the dma_fence exists.
> +	 *
> +	 * Deprecated for the reason mentioned above. No new users must be
> +	 * implemented.

>	Consumers of a fence can instead notify themselves by
> +	 * registering a callback on the fence.

Mhm, the wait callback is transparent to consumers it's just that implementations used it for quite a number of different hacks.

I would just drop that sentence.

>  	 */
>  	signed long (*wait)(struct dma_fence *fence,
>  			    bool intr, signed long timeout);
> @@ -243,6 +249,8 @@ struct dma_fence_ops {
>  	/**
>  	 * @release:
>  	 *
> +	 * DEPRECATED!
> +	 *
>  	 * Called on destruction of fence to release additional resources.
>  	 * Can be called from irq context.  This callback is optional. If it is
>  	 * NULL, then dma_fence_free() is instead called as the default
> @@ -254,6 +262,12 @@ struct dma_fence_ops {
>  	 *
>  	 * If the callback is implemented the memory backing the dma_fence
>  	 * object must be freed RCU safe.
> +	 *
> +	 * Deprecated because it prevents the producer of a fence from
> +	 * unloading. No new users must be implemented. Parties with a
> +	 * hypothetical need for this callback can instead simply and directly
> +	 * perform their custom release operations one RCU grace period after
> +	 * they have signaled the fence.

Yeah that is a bit problematic.

We need my patch set to explicit signal fences instead of returning true/false from callback for that so that a backend can properly implement this.

It's on my TODO list, but not the highest priority at the moment.

Regards,
Christian.
>  	 */
>  	void (*release)(struct dma_fence *fence);
>  
> 
> base-commit: 2302669bb4b52d581cc2589b90b3af7bb3783a28

