Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2492CC6B0E
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 06:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C67510E746;
	Tue, 13 Oct 2026 06:50:22 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010043.outbound.protection.outlook.com [52.101.85.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B47EE10E746
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 06:50:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mb7SsSnovGqauuDmu5/ydqsTfViRwOsdLZcLZ6uQ+bJp4wRKNsSXJn3TtLTKQ9G5wTw94vQPWek89T+GBkn9rZctggRXYGcitERAx9KFYMb4slHyjzL/0/1kcBIDaau0T4yWR9sxkQaydYNHovoulZf9nwjLrxmJCb+JNjo/4CAzot02ZlERabnp563Jflp3sZ68t71d3KZPV+7EDRBa6HjnnfSRphWnnx1Kr8lpHN+joe5ElBy4tjbz+yQXEUmxSpxjoudjpIrzLMpANhNUmdE80Kjhs/JC4CWWhRvQ7cd5BlF67WHwAaHedzux4glXTu9kBoOlxPBvnJ+pIlKW7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bN59amqIJkMSXXpaKA3S6q3EqImK6L0Af0J38AV2bRg=;
 b=Cvmy4QgnGMdx0qzPhCl3I/7JTGtjBehv50UmcgJXSAXfxLK+ZvXNSpX9zzBc85hJWUmkrYkQv3ET5JIudiONEiKhg+qUq9r104SRPbJNM/9LLJ6iqaP3TsWRKfYg1ANIU6wI1KS/6V3YrBIRbeIBkEZ3PEDUUQY0ic9CSE2kR+lslbtc3OXLhCFw5zyCtbiv/ue6eSNb4XnwxLLJpPkT7Pw0y6GFQdCT3JnXUjZ4u8cT0yQ3g2dJGc5/gRy+uE69mX154a+2uak95zfTKmObm5NVB+dhXYIRLUBqF/aW2Fl2rdlByhXKvkkuqdKELjFyn8WCDLwlArpVF9S8/hZZPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bN59amqIJkMSXXpaKA3S6q3EqImK6L0Af0J38AV2bRg=;
 b=s8yovVFWHVAnAGPD5xy4cmhOefX3vdlUF7jxltH1rl9zJ5M1nJaHx5RtTwE/xCf1UuS8555oWuHSega23lE3PywuVD7JMl/9ltETLLMbWULiHBibwCahtXS6zXWrdReYmXWvAphTsyaeY5klGRHTZEX0r7SbaaTBtFmP7ML52YA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by IA1PR12MB8493.namprd12.prod.outlook.com (2603:10b6:208:447::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 06:50:12 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 06:50:11 +0000
Message-ID: <c783ded7-7d87-433b-814e-0631b0418bcc@amd.com>
Date: Tue, 13 Oct 2026 08:50:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma-buf/dma-fence: Mark two callbacks as deprecated
To: Philipp Stanner <phasta@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, dakr@kernel.org
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261012171939.390365-2-phasta@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261012171939.390365-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0355.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::8) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|IA1PR12MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: b0888d1f-9135-4937-b27b-08df28f63a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: YTKr3QcsDb3VCT01C77wIEyqGKWDFg9z1P+Bz1KSX32fnqA4w/0CvXs5gTsF3i7BW2W3ElKy8XZQ+Cuc3li9f1lpR1mNRKwpTacEqRe1jPEPvIRnLjQ3YIJSwLfq2rqndHGzDQgsspu8HiMCTP5BRPPpKv2OHQYctZoWzk83uG+MYiDENgQyhoeUlUZWpz4+utMTQdcsutcWXmm5LreKA47OWtro3Jl1dTf1BzDFRTll4anZNbUo1UCvwdApgG8nNCWqmUsW7m3N7CQLovnPNXuheq5HWcLo+qUCq7u+KJ6HpAFeTS33AM+dCDBV7fi+ZprjytKW1UsLcUN1ic2n9wko2fqm+7kdx8dGptcoV7/UVEHTFf8QBTqf6wnFAx7IKROCUvQfGHP+IjMry98SK97sqfZO13rhvb5hsMXvY8qahJQ3KFTh3PXsW3V8aHVX0lHILLSixvYYoasKUQbRPqPGDxEct7q6HuhMHSJFJFe/WQsnL5xOawIMGZ3Y2amq09M/TkX0YDjluWayjaoDMsMurE6iHCYyO7IEczZVqjq0MmxSxhbZR7f8hSUnYqo91C0gUkGRF0YJAPc/XLULGWip96It/BjcFSepmAtNdehvdcoS3dTngey9xxdFUstj0gW40YUbMVYn2uIz7/eE6NgRxqEAlokqAdUfGPCPkRQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VytOZWJOY1kzQTE5TmJYRXh1SkhnaHlVYmROTHNyZG50TkY1THBoUk9GOTJa?=
 =?utf-8?B?ZHlvMytkNGZidlozWFhHK1FQZXppMlJsYW43RjhHQk0yb01OSFFkMEZPa04y?=
 =?utf-8?B?NW82MDI1NHc0bW9VTi9vQmVIU1p2QjhLZml6cmg2OGJHd0pUT3JZRTZGZnY5?=
 =?utf-8?B?SHEvclo4SVExRXhRUnNNY0lYeTlZYXhMdG5MMTBhK2RxWktsMzUyRXhROU1R?=
 =?utf-8?B?bVk2TlZuWjJKbUxINHFKeGFnUVZFRlNmMnhRdEV2R2hPVEZwNjdFQW52ZjFx?=
 =?utf-8?B?eitZUjlOQ0NRbzVKN3dGMFBnZUI2UUVzaUJLUXBiY3ZndHJXSjltbmNaaUta?=
 =?utf-8?B?Zm1PMm5ORElUcnAvRVlwRGxCL01CVi8wNjE0VmVzQmJpVUw3bmptOEpKcUFH?=
 =?utf-8?B?YzZPQXV1TDV4TDlYalpHUnhCbmQxVkhLak5ROU9SQW5aMjcyL21CNTlqMm1J?=
 =?utf-8?B?VDJueUw2c2FURXp5S2c2cStQWTQ1QVpEUFp1ODYvR0NyRG4rcC9nbnJxQjFB?=
 =?utf-8?B?MmYzVS83bXFNVldqTWF0enh6S2t3Tk5GVWlqRkZ2a1NGSzRLb3RHVnBqNjRh?=
 =?utf-8?B?RWphSTdYTjZMSjgwaWtaRTVneDNyaitKYUNPT3E2U2Vza01WcG9wcko4Nm14?=
 =?utf-8?B?bGlERU40NjN5NDVWWGRiUjluc0hPb2Ftb1JqajhSSHo1Y1hiMkdnUXRSc2V2?=
 =?utf-8?B?V2tvelZ1dU42RWhJN1IxQjhFcDd5K0dPbDh5cGtERC9ERll1aHRTRVpSOGND?=
 =?utf-8?B?UEFWOEpUUCthZ1VkaVNVbVVBcGQ5NlYvZlNqejRONHNFYlNYQzQ1MnRRcEtV?=
 =?utf-8?B?bEhZMnZsSWFNUFhsS1EzVGMwSmZjK1kvZVVyVU81LzZON0hwU3NxTnVUSWFr?=
 =?utf-8?B?NkZvcWVPcFFNOWhqalVvUGdFdDhVNUhnTUhJQWx0a2xTa3RzOVhOMXE1ejBJ?=
 =?utf-8?B?YlZ1ZWxHSktFTTFkMVFiSmZaVHQzMDdJZWtIRElESTVwcXE3bUFKdEJVcmlV?=
 =?utf-8?B?VndiZ3VVZ2MxTFNCbWRZSzhlZk9jbnlzZGRFWlk5Nmw4eDZ3NG95NFN4dkVZ?=
 =?utf-8?B?ejlYQksvU3NFaUxZS3Z3cS9LRjlFcEhCdHU2M09HM0RkOFk4Tmdhc1k4MG54?=
 =?utf-8?B?ajRzRGVNZWc0WEJabmZPK2hJYS9vbWR4QTQ3YXZkOHJvNmYwL01maENUUmZs?=
 =?utf-8?B?eFhRbXZIMU44NXlhdjI1clhmYkl2YTQzM1VUYjM0TTJnbysvZ2pNcHdMelF6?=
 =?utf-8?B?aUVqUFcyeFRRMXNNNnhFenVDd1ZUaGFhQTFWazhSSzZTZkp3VTlld2tsU0to?=
 =?utf-8?B?R2puMWlIWWhJcjVxcmVybU9kTUtSc041dTUzSFJuc2FjR0NkQnhDNml0bTNr?=
 =?utf-8?B?U3lzd2w4c2d5YTF6ZmVyS0RKejQ0c3ZoZEZFQ29MNWI0eVZab3ZYVHNLSjF5?=
 =?utf-8?B?d21GdGNEVXZzMnFzc1NheTViQ1JZQWkwSjMyL05Rak5sV3E2Y0E1MUVHMTRW?=
 =?utf-8?B?V0FBN2ViNXlYTzVBK1lQbEdaTzhQdlB5UE8xRnl4UENJQXcrL0ZHUlFBZW9G?=
 =?utf-8?B?ZXc1S1d0RGtUZ01wY3hzYm5kRkJIT3FNdndxRk13WWlZaVBFMXZXUXAySU5X?=
 =?utf-8?B?aDQ3cWRoUmIxTFdJRWx6OGx6R1BQdlJITy9PVC9lTy85ekJHR09QNEZQZnJZ?=
 =?utf-8?B?M2loNDU0OXg2MW9tMURKVGFsckRGYVN5M2RnV0FuWUlOYkprbUtiM3ZTOVFY?=
 =?utf-8?B?ekZsaEJrMFNjMkttd0JaT2JMRHZKMnRSOU92cE94OGljVGVZcUdkRW5PQTdn?=
 =?utf-8?B?dGIrV0x3c3gxSWtidzF5NUppeGlRRC9NZncyd2MzVnB5QlhOVTlyQ3BrMVpC?=
 =?utf-8?B?bVFzTXVVMEwrZnNNWjQ2cnF1QWs3NVlpWFMzTlVwcHJCUGl5RjdEeTFLT0Fs?=
 =?utf-8?B?d0grTWh5SXk4UzU5Wi9ueXNxTFRBNGgrRXdHNVo0eHZ3SWhzQW41MkorbXln?=
 =?utf-8?B?RGdkQnhaVlRjOGdHOTdZQ3Q1K0IvdUZ5Snh5U2pMb0RzSmZ2VGZJaVhjQ3Ri?=
 =?utf-8?B?blhzaXRPT1o1T2dmRkYyZUJ3V3dkbC9vOFk2all1Qjh1WGdqYnpxK09CaC9T?=
 =?utf-8?B?NjUyNU9uckJrTlJnalhhZ2ZaZmtWSTN4RU9lbHFRaitVQ1hNMFpiL0UxTW9M?=
 =?utf-8?B?eHFjb2E1TmIzQ2NjaEYzb3VyNG1uVGk2emlCNllJVyt3SVppMHMzcWZQd3I0?=
 =?utf-8?B?L2xVUGtXRWUwbWNFZGpGT2dXZHFETjJmTklXUGRTcm9ZdEFmQjRVWTQvU3hK?=
 =?utf-8?Q?rOvnh8vbJf/IKHdtr1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0888d1f-9135-4937-b27b-08df28f63a5f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 06:50:11.8259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S52PF5I2t0/2mO0TdMz/b0j2tHpK2AzDrVJbSGdlwnbIGi/v/RVEjhQ+Ugynupff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8493
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

On 10/12/26 19:19, Philipp Stanner wrote:
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

Reviewed-by: Christian König <christian.koenig@amd.com>

Going to push it to drm-misc-next later today.

> ---
> Changes in v2:
>   - Drop confusing sentence (Christian).
> ---
>  include/linux/dma-fence.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index dd07d128adc3..388c07d11e70 100644
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
> @@ -243,6 +245,8 @@ struct dma_fence_ops {
>  	/**
>  	 * @release:
>  	 *
> +	 * DEPRECATED!
> +	 *
>  	 * Called on destruction of fence to release additional resources.
>  	 * Can be called from irq context.  This callback is optional. If it is
>  	 * NULL, then dma_fence_free() is instead called as the default
> @@ -254,6 +258,12 @@ struct dma_fence_ops {
>  	 *
>  	 * If the callback is implemented the memory backing the dma_fence
>  	 * object must be freed RCU safe.
> +	 *
> +	 * Deprecated because it prevents the producer of a fence from
> +	 * unloading. No new users must be implemented. Parties with a
> +	 * hypothetical need for this callback can instead simply and directly
> +	 * perform their custom release operations one RCU grace period after
> +	 * they have signaled the fence.
>  	 */
>  	void (*release)(struct dma_fence *fence);
>  
> 
> base-commit: 3e32932d3626d0279f9b3531bd648f8c0a16cb08

