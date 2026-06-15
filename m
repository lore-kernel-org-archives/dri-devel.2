Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E707ECD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 09:56:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A2AD10E22E;
	Mon, 15 Jun 2026 09:56:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="Vuixw01c";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020098.outbound.protection.outlook.com [52.101.195.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B75710E22E;
 Mon, 15 Jun 2026 09:56:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvPXr+xyL6MFdjJJakXruha4hO/B4qsSlnGNsRV5y5lQVQgweTBOuTdvy2k+doU9cisldDO8vR1kA9MF3jAzUMtBApw70yT2qmlCacpkPMCFBy4iF2OTuGReLceZV6orAlqWTDlHS8EySlz0OGIFnkb8GpOaJGUzlJK89dZqiz54YokzaDPT6IYrTrKUdH4hLRxWOUmmCSbSBpUi79ajz595HnbMfXI9U3BgOsQXpr+0zdNaNVJkWuuOj0G8dkuMlmxhrC9EqDl3+EaxJkHa67/vL5STL/Ri/eqAWEUoHf2wBQcbPQ/eg2cdIQg1FnzFnaal/Y3BgRoA8FFXFKtbTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuR84foPB0UkKC4uXITgkPuzJyAqZdfBIPrNXCYKo/4=;
 b=NLY/P/DYXBwpTzeXU+zvUPYvbtkiCzO/1BaHKc9UrV78MdO0JLmLHfUPoce0ZYAfCFaA8KEpwP/b3/Tk6K4lJPmcv3F4TmizAK7GzQD00AwslhIEjTixnhow4HbKUbZFqcvnmVukJDzJ3Fva1Q5Mbo83eS3bZiLBSLQr4vKUdFnOohfmgwb1dQtobb4SD/D2wfPP03eAw0+Msc3S/Wdk7WuaYOxbjUU2kuj+c89UF9lVb+PwABXIl3OuKhH4V+HLIAeVhMiZT6V5z3pH1xAK+so8djXPai1DmjFl1GtFIwFgQbeEUBwnsKUxNKKws6FVp0lBRGbGq2W1u8hY/Y17dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuR84foPB0UkKC4uXITgkPuzJyAqZdfBIPrNXCYKo/4=;
 b=Vuixw01ck90MWkrZ/dMdCCiOEVSkEMnioTXKLvPVLuazhhwu6gcq/CKYO7XJMT+XV8cbbcAyiZRW8rpI8f/+PXJJ+97YbZLLr9uh5UUiy3hiBuaOw7GDEyX6BCvT5ywkf9PM+2hHQxI2ZxkfoHwDE0KT/ltEEr5Lp6LOXfN1Hj8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB5022.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:228::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 09:56:37 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 09:56:37 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 10:56:36 +0100
Message-Id: <DJ9J7LOD4NKC.LUC2DF5MC5ZQ@garyguo.net>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [RFC PATCH] dma-buf/dma_fence: Make races for
 dma_fence_is_signaled() less likely
From: "Gary Guo" <gary@garyguo.net>
To: "Philipp Stanner" <phasta@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Sumit Semwal" <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>,
 "Boris Brezillon" <boris.brezillon@collabora.com>, "Paul E . McKenney"
 <paulmck@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260612104251.2264707-2-phasta@kernel.org>
In-Reply-To: <20260612104251.2264707-2-phasta@kernel.org>
X-ClientProxiedBy: LO0P123CA0007.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB5022:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e121bf-7db1-4f2f-2fcc-08decac463e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|10070799003|921020|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7O4vNTJKuvyw34l529IK9kifg0Qo5SSfZV/aKgXTEGOJLirchmCIJPIOtRq61Tb5QQ3BFJM4kku8cN1VOgAxUlcySte+l3fG5K999dQlFTuCCKdeCAdEbMixEpbWHOJblJcCCeaW63jAHZlUL62A/7uSM4/Ag2a4Xt9e8F/n6SOuJERjMtWbpyjQTw2LwoHqyl+GLc8PuDO7tjjqE3MT9BO+dNsMn7pBNGFediY4nOwDeYQSyqjYW7gGWsNjQSWyyB2eqzeOyB76IVmS7PsYAZkiZYzbjgja0iGb+0uDcvLt+zuuYqYZUwrMdzufx7UcmXiiSyQQD6UKMxpkb9bFq5mGk3vhdZmE95l2HuiJSRVH2ev0QZXMNlnDHC8e8vFtuSKRCecyHai7ImE69GFH1ZxAm/o7tLWPBtId8WUnOba6N7v4n/zeT8wSVty8lzYEM/7+UHgxsF9ZMl9wvMN6boy8jR/4YHXeEB9cMpPM587qOITRfFyisYSlEu1Dy7dN7ZZhdpU7jl9X6LoU5uhispqa/BV+YnxAyy0ojE5Ny2mO9RCWX/qwyEj0PD5sKz+z5ToCfCgHndPrz4/w9nb70NtKblHK7RDapp5bngGZv84sFUX7O/u1whF3qyRSELWwlK/Bk9k3lUIZBa3nBcmvIqQl7QmHS3gyUZAlkXRj2Cgcr8Mb9QYtRchp3F8qsFXq1lVP4+zM3GsXPNNxx/vaTwu+NL+gq7SGyHg3ICqFCzY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(10070799003)(921020)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0ZKTXZPRzFLYVZmZERTbyt6TGVsQlRHbW9HT0FxVmVoaXM4U1ZYWXpFOFRl?=
 =?utf-8?B?Y2k0ODdJYXN0eWgySnpBSVhlL1RSWldHTHcrSHBvSjl4aWdDWmU2aWVvRzA5?=
 =?utf-8?B?cW5CdVZMQlNpZW9ZZTNXUE9rdFZBZ0ZOTTdNL242dDR4VUwzUHpRckRwcjM0?=
 =?utf-8?B?R29OQTMzT2JaaEdETk9QTVJDVDJmRE1MbmZnN0NKT3p2ZDNKY3B3MDBQcGR3?=
 =?utf-8?B?dHJaRUpyNXVoSThzbE5ZUzNJdkZoWUJFVHNxN0U0K2c3azk5NitoQUNPTlBi?=
 =?utf-8?B?bnRIa0VjQnhjZ1VPUEo3M1ZaZnNCdlNjSHg4QnNNMVJxSGwrdUp1QjBMc2ZU?=
 =?utf-8?B?ajczblQxOHZUVWJLZE1wRm5UcnFzV2U5d2Z4Nit4a3lhalVnOWcrMUdTbmlM?=
 =?utf-8?B?OWZBZERGa1YwRlZkbSt6ZHdOeWxpZGVLRDZuU0NnQ2NEVkV5elJVcE9zQmlk?=
 =?utf-8?B?djVoT0dIYWxEU0NCQ1pBOVBQdzNHQk5sNDNnMEZFMG1MVDRhdTBlSzFJamw0?=
 =?utf-8?B?bDNmM3JTM0x3WFllNWtlekV1NUNvWEpqNndCU0RFb1FQSGF2MnZ4ZlFjcklU?=
 =?utf-8?B?cVdQeWduTU5iSklkUnJXYUlEWW9ucDllTlZ3U2RHU0pDRXlaSTVXMHNpUVZY?=
 =?utf-8?B?UmxISHRRazhNdEc3aFh4aWd0RnplQmc2L2VzUG9zSWc3Y1F2NXM4dGZieGhq?=
 =?utf-8?B?ZmU4MXlyTmtYUktmTGVBbXRydW8xcW4zeU5jdDBET0hKUG9MbEJMWGxHTE1F?=
 =?utf-8?B?UlF0cFlBdDVWZlF5RHYxTlZIVWtVaGpQSTN2SkFFeGdDYjl6bngvemlqWDU0?=
 =?utf-8?B?UG42YUtyWnFvZEg4QUxyV2crRFlKT2xRVlBBUkFBeGNIZTZYL2ZMY09uNDVE?=
 =?utf-8?B?bXFmeHQ3SUZYNE5ia0d1RFZJQnBkTjNXVjNpRUlnRnhmVG1MU1doUEkzZ2NR?=
 =?utf-8?B?QmFOVUUyVjB1dmpmZVdweXlYWldsK1UwYlFpVHlBb1VrYmFiS2o5UDFGYzJt?=
 =?utf-8?B?OTR3U0xuKzZDekhIdjBZK2dJaGxsZndnQUJwY2NoS1gyNDRRS1VFeEZiNFc3?=
 =?utf-8?B?ZHdBSWJnOElhRGlpZWhVbHNWTkhuaG93OTRpWHZ3VUk1N3Nta0R6TWN2dTAv?=
 =?utf-8?B?ak9LMU1mUWJNOE54bzZYaWNOdjUvZkw1eGtRMzB6cStaSzJ0NW1Pc1o4NXV2?=
 =?utf-8?B?dGg2amFLSFBzMU14SU5VelZTMzc1ZDF0eGxYczR6akx6M2hxTkFpdTNkUEN4?=
 =?utf-8?B?dXp4UmJxNnZDZ2hOZGxIcVJwS1A5NXBaVkJuY0RuOTFjbytDYXFrOHUzb1J3?=
 =?utf-8?B?LzVVYXcyTEpzL2tsSFJJMjZqYSs1N1RQcG1sUmhzcEc4K2lIckFZa3c2R1BX?=
 =?utf-8?B?VnN3WWNlUUpEYjB1WnVIOHQ2TzNFS1RuYnU3d1dCcTVMZnIvMGF4MFQwQ2t4?=
 =?utf-8?B?M0xXaEorRHU4aXdZUFk1d0ZTaE1yb3lSM0lCWmJqa0hBWm1CK3NZQzdPTFFO?=
 =?utf-8?B?aEs0OFFzb0pzMkQ0OXM2VFFoNEkybkJQaDRyTlZnTGpaRHJxeXM3ZkwySVJ4?=
 =?utf-8?B?RE1EcmExR2hsRjg5WS8xZ3lVaXIrbENoZHY4TERkMUJtVnRPSW5rcjVyVWtI?=
 =?utf-8?B?Ri8xSkNUTm9vMTVYRm1LNG1zZ0xmb2o0cjBQc1VNamxnYW9nRldZN2lzcE9X?=
 =?utf-8?B?SUwrVnZsNVNZcDNMWUh4a2daQXEzNkVqbUp3UVg5RXlOOEJ1Z0JRN09xNnF1?=
 =?utf-8?B?dXBOeThObW9xcVZMUHFjT3c3WURnRWNrL3I3ZHhTZUt1eXZlMXB4bUowbytr?=
 =?utf-8?B?TmdsdURkQ01LZU80a0hGS1lZOUFySTM0TlllN05NN0xJdE1SNUYrRGtMOUtq?=
 =?utf-8?B?WWZoVks3UXY4SG1sZ3UrWkJMSDdOU2lSTkJuMTFJNC9qaHNFa2ZwaDBodTFC?=
 =?utf-8?B?L3ZqbVhUaXlWNWNLK0VCaDZUY0NxR1ZIbUFPM0lKRmhqQVlvanl3eGRsMTR6?=
 =?utf-8?B?MTAzeUU1dFNHNFgyOUI1SUdtb0VPM2kxZ2xYalQxU2s1eUpUQWRxd2NHSnVO?=
 =?utf-8?B?d3paSVF5UFNUdnVrL0FVMzFMYkNsM3VDL3dlb1JvMXRGcjlBSTdZVGlmVTVm?=
 =?utf-8?B?aDd6Rld3ZVk2ZlJWalBPZHoxOEhBNjNVeFFNbS93TXpHcVorNWVDeVBpanpX?=
 =?utf-8?B?QzhtTzBKdzllcW9UM1B2VUpzK05aVVBQQWNSUmlYZ2tZRU5rVnF4L05MeWpa?=
 =?utf-8?B?dHZONlpSdGdEM2xzZEIzSVFWRTc2VkRja1hFMW9VZXpmUzNpSGdZWmJYcnpr?=
 =?utf-8?B?KzYrWjZuNlFRdGdJSys1M3IvNUh2OWIrbktXd2Mva0ZMOUhSZEZ1Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e121bf-7db1-4f2f-2fcc-08decac463e7
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 09:56:37.2563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JZTS0sjN6F+ehy4NrsBR0mPhWtm6hjyx6ZBfrIVQ+eTMRpA+sLz7wa49N0qnXDVuzUK8Um6awetlAly6fmOIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5022
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

On Fri Jun 12, 2026 at 11:42 AM BST, Philipp Stanner wrote:
> dma_fence_is_signaled() returns whether a fence has been signaled
> already. That function contains a fast path opportunistic check which is
> not guarded by the lock and, according to Christian, cannot be guarded
> by the lock without causing a massive performance regression.
>
> This now means that dma_fence_is_signaled() can return true WHILE the
> fence callbacks are still being executed. This is razy and has lead to
> at least one bug solved in:
>
> commit c8a5d5ea3ba6 ("nouveau: fix client work fence deletion race")
>
> Make this race impossible, by simply setting the bit only once the
> callbacks are actually completed.
>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>  drivers/dma-buf/dma-fence.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index c7ea1e75d38a..2416cc86ce93 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -359,8 +359,19 @@ void dma_fence_signal_timestamp_locked(struct dma_fe=
nce *fence,
> =20
>  	dma_fence_assert_held(fence);
> =20
> -	if (unlikely(test_and_set_bit(DMA_FENCE_FLAG_SIGNALED_BIT,
> -				      &fence->flags)))
> +	/*
> +	 * First test the bit, so we don't signal an already signaled fence aga=
in.
> +	 * The lock protects against multiple parties setting the bit. The bit
> +	 * is then set at the end of the function.
> +	 *
> +	 * The background is that there is a fast path check in
> +	 * dma_fence_is_signaled() which does not use lock protection and can
> +	 * return true *while* the fence callbacks are still executing.
> +	 *
> +	 * This fast path check supposedly cannot be guarded by the lock becaus=
e
> +	 * of significant performance regressions.
> +	 */
> +	if (unlikely(test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)))
>  		return;
> =20
>  	trace_dma_fence_signaled(fence);
> @@ -384,6 +395,9 @@ void dma_fence_signal_timestamp_locked(struct dma_fen=
ce *fence,
>  		INIT_LIST_HEAD(&cur->node);
>  		cur->func(fence, cur);
>  	}
> +
> +	// TODO: we need some barrier here, don't we?

You want a release barrier here, which we don't have currently, but you can=
 use
`smp_mb__before_atomic`.

However note that barriers must be paired, so in order for the added barrie=
r to
do anything, dma_fence_is_signaled lockless fast path would need to have an
acquire barrier, which we also don't have, so you need a `smp_mb()` there a=
fter
the flag test.

Best,
Gary

> +	set_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
>  }
>  EXPORT_SYMBOL(dma_fence_signal_timestamp_locked);
> =20


