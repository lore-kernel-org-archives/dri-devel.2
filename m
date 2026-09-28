Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA325C9833F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:48:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E94210E89A;
	Mon, 28 Sep 2026 10:48:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3PqnNZx7";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011044.outbound.protection.outlook.com
 [40.93.194.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58B7A10E88F;
 Mon, 28 Sep 2026 10:48:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNDgrfX+PWw3B+Xaiw76DNuq+TnpS3jc8Op9higBAZ+ekuODFTdF80F7TKaeKs7MtbjbOB+I3XnS3cfof5C7I4cuYRaxrPssYh1XeZ5zVLiuWrwoCioK6CkTcroB7pbW/xTDlswTNPjThCXDI0ZlmoJE8W0yYwnxlPAVRCibRY3PA1Xg1ILSFiw8oMFhlpfQr8u4SRECjiUxB8cLP7LzH6PX39McG0rLlu9VCy6LI0mCAY+7lhXTBqSZQf3H9k8u302FuTX9+2wXBg3qQ9XoNTlA5soGP9B/JQBkw43Dp6CaEsO4jd068KjGlZ3TBxmt9S1upy9hSVgd50bbcuoFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKqihvh+sko2bCuy/CiQ7QJfOMB+J8dN1bAuSfTDp/E=;
 b=p6dYSV9mVL4BQgs1EceWeaTV7KE0BCrY8K6+J+nGhFQ1wV9p+qdGp2cmz6ei4iBFPdqUG7OaEwM1i7Ynnu0oCyIMEyk5RJWtmL9hkC2Mudapyo8Z6IIgsIiYPSfXjUjfj6K4A7v8ePuHUAU0N5VWa9oWms3LO+R0PYjUodLWYTAkwEbLCqhK+Rb7bosPVWgU4oKzTqTqyvJ9ZjVODSTge2x09aSYbUABzHM5yAQ2oXo7unUwPK88jcJzbWPwIbYa58/QjZPBojTxJhhTWPTuSz/VIs1oIgMw/B094ycWrb1+l+Unqb+nRm4pj5HDPn4kZTw66UjSOIJPHiGbscJS4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKqihvh+sko2bCuy/CiQ7QJfOMB+J8dN1bAuSfTDp/E=;
 b=3PqnNZx762lrS5cabcCm/guuEhH9pCwEuUE9hKoDZPc5XNTX3eWfIbV2I06W1fAnK1/YatCGI2JHSt7XP78rs4nkyUnKCBWWWxV3FW24Wu+pibTI/d5FPGKWVeigkqQyMO1kf1y81H5GirEiNgnJtdcTjIrSMkNeOnkCTM9G3ZE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL4PR12MB9507.namprd12.prod.outlook.com (2603:10b6:208:58d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 10:48:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 10:47:57 +0000
Message-ID: <50a9c1f1-6889-4bd5-b4f7-0500d30d3dd9@amd.com>
Date: Mon, 28 Sep 2026 12:47:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "dma-buf: Make DMABUF_DEBUG default to y on
 DEBUG_KERNEL kernels"
To: rob.clark@oss.qualcomm.com
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
 Bryan O'Donoghue <bod.linux@nxsw.ie>, Dmitry Baryshkov <lumag@kernel.org>,
 Karl Mehltretter <kmehltretter@gmail.com>, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20260926022026.10539-1-liujianfeng1994@gmail.com>
 <17bf71c6-2442-4eaa-847d-29ef625870bd@amd.com>
 <CACSVV02WCQwQy9BpUUqziQTtKV7QyJruiM+iTiLE_SEVKtpVNQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CACSVV02WCQwQy9BpUUqziQTtKV7QyJruiM+iTiLE_SEVKtpVNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL4PR12MB9507:EE_
X-MS-Office365-Filtering-Correlation-Id: ab1f7109-53af-477f-4315-08df1d4df517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|10067099003|11063799006|5023799004|56012099006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: K2Dr/hKSLQSViqnl8EHajzzC+XhUUFrFrx+maJ0s+iey/6ulGfL3n89cNPvubU3jKOskNaJHCBfMyWX8p0i1e1aGXps2Y7mPPG6CUuCizZb8NM8P0BjfIDBA5qe2DTB6w7bwnJMa6VfdAMCGRju4Ij+FZJi30wXoULRu6Bz80MTcQbL8Lorv3RGmqX/n/r/nIH2BmMuPavbl/kO/PdqbWR3Ks1qv6U1eI2D7zcWNd4nCGaTSV5lxYbufqkfNuuHTJHcSxX82uwafM8/4t3xyuV8PaVm7lvMdJlOF79PLU0Wq6Z+6JxZaNpE1JLzMRfpzq5FJrfMbQt/WWFo9ixefoWr4SMKkQyP7z+LpafrPXuqA4ZO4TTBKvco/zhav3oaep9VvcHYF3i/MRYXLB1zJwrp9MDMcyswVrL0bOzMMufyfg2p0U9TGLbD7jlSbfNeBDOxVUfRSersZMLmG3gsH8BNUEZFNNwlcTjLTG3mLBk+fQRwwkt8o+dTaoGVKKvc7unXX5ddvWsWpNtewLcrP/ktbLaPsvUs6HZAuXXzjCMspNpd4PutkBsMrndXT0YqzVEhaEyqmX0WZFamC1I7Okx4kmM9KVVlkyfTnsSwpHP8H1dGXakpvcqUPDNx5HFpA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU15UE9TMkhESkY4eEJHR2FPOXF3ZEJmdDVzTGVTRmorY1FJU0x4d1BiaHVO?=
 =?utf-8?B?aFBtMXY2UFBIS21PWDhLTUVyS1E4NFVBMUxNTTUrUHBxQnNxZVhRQXY3bE56?=
 =?utf-8?B?VDFrd0JrbTVLYVJoUHNUUU5RUUxhY0h3SWdJeWNCRHJ2blVYWlF3Ry9teXVF?=
 =?utf-8?B?cEJHK0M1VkZmdjRRbHo1WTN6OXFUbXkwMHQ1TVpDcVZWc3JMeWJUc3NWQWs1?=
 =?utf-8?B?K0kxNWc4WVowMkVwVFhrdzhDS1FqWkQ0NklNaXRGQlY0eVNZbWlrVFpvcnlO?=
 =?utf-8?B?djhZb1JqcmhCOG1oSnpOdGF4Z2c5MmlYNkIrSGVPVFh5ZU91RFdlUERES0E4?=
 =?utf-8?B?TG9xUlVpa25mT2FWQSsxekxpdmd0dDAzNklFZWdXZExZK2ZGVmxVb1lxd1lF?=
 =?utf-8?B?QklURDVudE5rNEU2dHNsLzNQeG0zVFdrd0drVlVkWGt5L1RnY0o2bDBmUW9s?=
 =?utf-8?B?WGhoRi9lcW9tTjBYUnpES3ZkVWRBTU5Ua1NKMFA2OE5MN0RZKzhFc09ydnBl?=
 =?utf-8?B?Wjg3NXQzZStIaHV2eVo0eXZ1RnhobmppVW1FemVmdHNBSlJFZEozZlVoU2tT?=
 =?utf-8?B?RFBSR1lIVkczdjl0UEZhZ1hVa3RTYnFHUEFoUnc0RjZTRVZyd015OW1tZzUr?=
 =?utf-8?B?c0ttaDZaRFdFMUJwQzQzSEdaY210b1FGbWlWZnhXRmRRTURkS2NOL0lQa2Y5?=
 =?utf-8?B?S3lOeEVxWWU5TzFYdGRmUUQvd01pMnlvT2loYXM5dENXeWlGQUxDRkdDSjRO?=
 =?utf-8?B?T2o3cndnSGN1cDBxd05wUWxMU0x6S0hWQU0vUjk2eVhYalgxV3kwNmdCejRP?=
 =?utf-8?B?K2hrQkZTNGNxWGh4VEo2djFJS1U0L2JuWmN2S0VkYW8rWlc4R3N0cFA4YUVi?=
 =?utf-8?B?SE5ZV2xsVVB1Y0Jld25FcGVtc1UrTlVld2RaWjlrQ0ZoMk9hOVBRcnMwdG1x?=
 =?utf-8?B?RllTWDhuL1orSWJiUjljRDRjRy9tN0xOazd1SkJXT2ljUjJKeDIxeVozMUVE?=
 =?utf-8?B?amxZbTk5ZXk3dVRQZ0FxWDVydUlZSUI4MW8yc3phd3llVVQ3MXZ0OGxycHk4?=
 =?utf-8?B?SVB5RnI3RTJJeTVNdkUzcU5IUENWTzBacm03WGdCZ2VZdHBYbjczSE01UjZq?=
 =?utf-8?B?ekt6a3dUSjdITTlhNEpoZllLdEppMk91bHkyc2NVdklKdGdwbFgwOVVBTlpW?=
 =?utf-8?B?Y215bGZ3YXRzaFJYT2cxb1B2QzYvaUlzYzdYL25NWmJkT2V1ODQ5SytNS3A2?=
 =?utf-8?B?MXlsd0VzL0EwdFRhQW9PV1FPZkxNbGpOWXQ1ZWUzMjV1SThEdnVXSWpGOVRH?=
 =?utf-8?B?bFMrOVloN1dlSUowenE3UGVaL2xYRXlJZVVVWTBETlA3V3FBcXhMUjJ2bkRY?=
 =?utf-8?B?VWxVK0ZSN3R4eHVXVzIwMHpoYndsbVF6Ymd2TzZFZDN4UUdlUDhSSjZBWjRU?=
 =?utf-8?B?UDFHWUszWjZCOCtYWjhPdFBkdEJOTkNWWEFhYlJrK3NScnprV2sxT2g1REdt?=
 =?utf-8?B?SE91K2p4aGdpT3NmcTBidjdLUWRiSlNPRHpIRVI4dEd5eXhGUjVCSS9GNzRB?=
 =?utf-8?B?dkZRZ0d3RkxkbUJsVzNyeGlVOFd6WTRDN0JxZzJzc2NyZmtjK3l2MzJ0RjdQ?=
 =?utf-8?B?R0hJSklBUk1uS21ab2ZXaEQ4S1p5ZVpobEh5ZUZmYVloK1cxZU9TWGZKUDgr?=
 =?utf-8?B?QXdPRFJ2WkRxUlBEbktmS0Y1Nk9wOUkzaUJJSUpnU3JLYmlJaEN5RWMxLytv?=
 =?utf-8?B?UkpHenk5dEt6UXJwbmJqSlMvblVzVDJxYWE0OHF0VU5yUUNrSGRsdlorQ21E?=
 =?utf-8?B?aktWY2ZJMk1vb25WdzhQSEl1cWE3V21PZ0NZWjliVXF1NTRYa01iSk8wSmQv?=
 =?utf-8?B?bU9WcXQ0Mi9Tc1NzemxlY2JjVks0NGVFVVlXdFN6MVRRdjNiY2FOdzB5c0Ns?=
 =?utf-8?B?ckZGTWJMb0tnWVQvdjZ6MVRFMERhc2dsbmIvV1ZUN2pScWRPcE5OcTNDTVFN?=
 =?utf-8?B?aWpSM1Q3d2NxVElGQWU0ZUZPYW5IVi9OYlA1YUhsbmxSRWcvSGhTT1FsdnZH?=
 =?utf-8?B?eWY3SXJvak9vOW5CZ0dPK01VUFkyTldwSFI0QkhPTVZxb3RhWXJmTENqY3oy?=
 =?utf-8?B?N29hRTZ0MVRXRm9pS1Z6MDgyOGs2b2ZNd2dsZ1FnVDE2eWtrMUJsWU1Xa0Vs?=
 =?utf-8?B?KzlCd0ZWblVzMjRHV3c5YXJqb2dERVZIVkFub1RHTVdSVlZHRzhoaGxQWGVk?=
 =?utf-8?B?NWhZNDFsRk9HNTJxYkFxMkZPVytKRmJ1YnZLWENoZ2puNElZajhiRC95ZnpI?=
 =?utf-8?Q?xQ6w1B1lVVibd3mD1B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1f7109-53af-477f-4315-08df1d4df517
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 10:47:57.2602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZAQ61yWn4Ws4gZirh7Kf976t93kEKezT2qhhFFuokEX5x+xoUU4E2wPZVX2y/FD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9507
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

On 9/28/26 12:36, Rob Clark wrote:
> On Mon, Sep 28, 2026 at 1:19 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 9/26/26 04:20, Jianfeng Liu wrote:
>>> That commit fixed a dangling reference in the DMABUF_DEBUG default
>>> and thereby enabled the option - and with it the page-stripping
>>> sg_table wrapper that dma_buf_map_attachment() hands to importers -
>>> on every kernel with DEBUG_KERNEL=y, i.e. virtually every distro
>>> kernel.
>>>
>>> drm/msm is broken by the wrapper.  Both of msm's map paths consume
>>> sg->length and sg_phys() of the attachment sg_table:
>>> msm_iommu_pagetable_map() for the per-process GPU pagetables, and
>>> iommu_map_sg() (via iommu_map_sgtable()) for scanout.  The wrapper
>>> zeroes sg->length and strips the page pointers, so mappings of
>>> imported dma-bufs silently map nothing, and userspace observes
>>> arm-smmu translation faults from UCHE, e.g. during hardware video
>>> decode (clapper, chromium) on Adreno systems:
>>>
>>>   gpu fault: ttbr0=000000088a889000 iova=000000010741c000 dir=READ
>>>   type=TRANSLATION source=UCHE
>>>
>>> Bisected on a Snapdragon X1E78100 laptop as v7.3-rc3 good,
>>> v7.3-rc4 bad, culprit 143755bdabaa9.
>>>
>>> Switching msm to sg_dma_address()/sg_dma_len() is not a trivial fix
>>> either: those fields are only valid for sg_tables that msm has
>>> dma-mapped itself, which native non-MSM_BO_WC objects' sg_tables
>>> are not, so the conversion needs more work.  The msm maintainer has
>>> therefore requested restoring the previous default for v7.3, to be
>>> revisited once msm no longer consumes struct page and sg->length of
>>> imported sg_tables.
>>
>> Yeah as I said before the problematic part is MSM here. We have enforced correct driver behavior for over 5 years now when that option is enabled.
> 
> The problem is bigger than MSM here

Well, so far I have only heard about MSM.

But yes I mean the config option is doing exactly what it is supposed to do, pointing out when driver need some work to get this fixed.

I also agree that we shouldn't have allowed driver to touch that stuff in the first place and better document how to do things but yeah I can't change the past I can only try to fix it now.

>> What we can do is to mark MSM as broken and/or give a warning in MSM when DMABUF_DEBUG is enabled and you try to import a DMA-buf.
> 
> sorry, no, we can't mark MSM as broken.. we can mark DMABUF_DEBUG as BROKEN

As I wrote the debug functionality to enforce not using struct pages has been around for over 5 years now, it was just not enabled by default.

What I can offer is to set it to default N for another few month to give you more time to fix things.

Regards,
Christian.

> 
> BR,
> -R
> 
>> But making the check not default to enable on debug kernels is not an option. This check here is exactly to point out broken drivers and you can manually disable it.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Link: https://lore.kernel.org/linux-arm-msm/20260923074256.9357-1-liujianfeng1994@gmail.com/
>>> Suggested-by: Rob Clark <robin.clark@oss.qualcomm.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: Sumit Semwal <sumit.semwal@linaro.org>
>>> Cc: Karl Mehltretter <kmehltretter@gmail.com>
>>>
>>> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
>>> ---
>>>
>>>  drivers/dma-buf/Kconfig | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
>>> index e4f078a326a41..7efc0f0d07126 100644
>>> --- a/drivers/dma-buf/Kconfig
>>> +++ b/drivers/dma-buf/Kconfig
>>> @@ -43,7 +43,7 @@ config UDMABUF
>>>  config DMABUF_DEBUG
>>>       bool "DMA-BUF debug checks"
>>>       depends on DMA_SHARED_BUFFER
>>> -     default y if DEBUG_KERNEL
>>> +     default y if DEBUG
>>>       help
>>>         This option enables additional checks for DMA-BUF importers and
>>>         exporters. Specifically it validates that importers do not peek at the
>>> ---
>>> base-commit: 93f51579e7df248780214094418f205253383cc5
>>> branch: revert-dmabuf-debug-for-7.3
>>>
>>

