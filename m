Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A291606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=aSCjSXAF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B354510E9E7;
	Mon, 16 Nov 2026 14:18:11 +0000 (UTC)
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022073.outbound.protection.outlook.com [52.101.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D01EA10E9E7
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 14:18:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImQhibKxoZ7jGZ0/rIJBZXDkiaCssPvEIQcZEL2LAE8Lmvh/rTDvSPcuE2hqnbB8oeVvJZ4F8zIW1xODMnFACDxbArXw311o6jtdHiuMnCKeFOKyxAEdy+pJwjnlGA8CguJMcuOEVN3BngXEcqXGYcU4D/ltW6izhbJzvgjGmd81ExO/F+ku/Cs/3TNkJOnY6IMmDu4i4KhrwHXLhdMCPb6Zkitiql2fBXkWDIgTZUDFE87k6+T/QCq+H00PBWGF8I+G17CdiOnvAUXpnPXLyrx9eBwUIJ1JvfH/pp7l9HqlKwo785MxvRpGeaX2vf77I+cBzN4kyiq3Rh2wbAdv5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXqdS3vHKMdw+Kuiy9axg4q8QYSFnppNEYwrc8Ia5u4=;
 b=sGtPgVH//b01uVLWHuX7lkLbYQIM6HFT0VwsaXdfMZBUE9YjRtQMNmOXclyfC0MfpWXSCa5zhh4SZ7aproJUpk9GrcwKQn1KIjX4yLoBIUcIhPTfe3hgJe5mTKJQI1bu0Pu1b9InCi80Q1u+KHs2lGjYybPV0YpbcJIO+lEQVOaBcAMBg06xSJgR0K+oXu4iNVq8REyqkbexCNxcAdAV6suYwL4+zRtB9twXaU4UxiZqWh2owD11wr0VXXE1LCj2k+ArhhpFq2QPevnZ/I626ZDeE4yd2//sZZeZ6cy/6medKzIRt0QBNZ7Q3/uX5wt+rAwZu57rP7QFMODRmgHCgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXqdS3vHKMdw+Kuiy9axg4q8QYSFnppNEYwrc8Ia5u4=;
 b=aSCjSXAF624PwHdXBGVqXx96L/H+hp7m4k5XoWPJwtLG+rlvDhr9Tn8W4orXQsWi0dc53iHGznGyh+LELY2jDHJpJs6gv0nd34WN9zRpUxYqzF89dP/fFu9EiJDyhfqTH5mSJphuHLue9wlgbzdXKhGQ0tpHMyYGgQalnbLRFTU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by CWLP265MB1763.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Mon, 16 Nov
 2026 14:17:59 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 14:17:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 14:17:58 +0000
Message-Id: <DMWP7M7IEDOY.QQVE3HOMWFIP@garyguo.net>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] dma-buf/dma-fence: Close race window against error
 checks
From: "Gary Guo" <gary@garyguo.net>
To: "Philipp Stanner" <phasta@kernel.org>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Simona
 Vetter" <simona.vetter@ffwll.ch>, "Paul E . McKenney" <paulmck@kernel.org>
X-Mailer: aerc 0.22.0
References: <20261110155817.1492359-3-phasta@kernel.org>
In-Reply-To: <20261110155817.1492359-3-phasta@kernel.org>
X-ClientProxiedBy: LO4P123CA0563.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::11) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|CWLP265MB1763:EE_
X-MS-Office365-Filtering-Correlation-Id: 268f3520-fafc-4b29-d559-08df43ec6ae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|7416014|376014|23010399003|366016|18002099003|22082099003|6133799003|261009223027099003|921020|56012099006|10067099003|261028144727099003|261102123227099003|261022105027099003|261021123027099003|261021121427099003|261026140227099003|261026121527099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: DQdo9RVRp6o43iXTTXGT0Jb127PNmse4I4QO6QeNl8SxH75yZTo064HwG9NKHi7VrpzjwbtHVLea5ajDKidJiSfMev18RMX30i4DpTHtFYjskH4OGl6qq3U4smNy6Xi33tNeAIa63NU2yZNWlGjskinX9ytK251Ld3fIzVcPILmM6mJZ4RAo54+TPL5G4+pmMWL/nMShNwy+9S2a1IAXsMs7Nm7U0LFvVnzXCYqD1AxHbPi5ZyD1ROEbAP7kxu+R4SR9LGgS3LrhRwFUMdtWepM/mOd6+NImML9hYhp6NEYCDDxvdh8ULsSsfZVmziXiI2Zkw4tVezc1U1Dwsj1uF7mIjWYZkFF/7xPxiR8ejtkxL0kez3OgTT7iHromiWAZq27dPnNHx0IHHclR3WO0o1URWaAKOkAezdM3XxZDFHEvHhuBHlC72HrZmCCzLMiJ+tjzILR6n3t8n25sd/7GIWRAvVZ92rbnhsGTj2tEFQUwWwyRqq0dAjXvI7SIriAdlmEgazq/D6UnTca3wqzXWEua9ZoIqj2ux9gampUzrWfDhGX2HdCACRrRU4GSFO+kZ3E8NPYz/hJfvrj8d7KRoehkW+rPJL3BQsh9mE9C6pL/GHS3F+fYk8qdAKYjFK26dyksG4h9d5dYgXSPrV6wv9qzuDyfmyJE/eDRGUulwLk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(23010399003)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(921020)(56012099006)(10067099003)(261028144727099003)(261102123227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261022075727099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFJRZ1dWZXFwLzNQU1lFdjUya3hCS25qRjExMFNXMUdNT3JiemcreFhsbzJD?=
 =?utf-8?B?MGNXVmpZMzU2L2xXQlI1bzlPN0RCUzl6QWlWeTY3M2Njd1R2amkvUTJKQy9Z?=
 =?utf-8?B?Q29Eb2pHa3h4SEc3YjE5NWR3SUhXbjJqQkhQTDdYZW9UMFVuZHRCaTBFSnRr?=
 =?utf-8?B?aWV5OTgyQzZ6L1phVmxIdEUwQ3Q2NjluMjB2Z2cxR3VOVnIvOUNDNkV5Z21Q?=
 =?utf-8?B?Y3IwU3dpR0Q3V0hDdU55SklhV0dPU3RPd3F3SGFuZ2MrQytSS1Axa0VBUVpX?=
 =?utf-8?B?OFdjYnBCc0tiWTFoNk9BWU81TllMSEtvZ0dWSmJYY2lPdHpPR01XZGltbndI?=
 =?utf-8?B?eHpwWTJhWFV2SVJNeHFiQ3hFTzQ2bkNRN1QrZ0szU3dkMitBOGk2MVVBYi9B?=
 =?utf-8?B?OTRKSTFpcDVPTldVeUZBMGtJc2xKVDFwdW4zdXhRME1PTlNqcjk5bStGM0dH?=
 =?utf-8?B?NnAwODJxc2NDQkMrOXFVUFRGZGN5eHlRTCtVUE81RUdMalc0dlE0Tzl6blB5?=
 =?utf-8?B?cGpKdzRXdUpzZVF0TTRlcjRqU1pVWHNrcnA2aDBBdWJUT1Vob09zdTdmSnkr?=
 =?utf-8?B?MjFZbE1xUzhoN2w5V2RqWUdaV0Zyc2NJNzlnNVBjN2FPNUFhd0NROUx4ajl2?=
 =?utf-8?B?Vzh6dE4vK3liaG5GWnR5Zk54d1pMSUZEdDlreUMrem5ReVBXYmtHRFR5SE16?=
 =?utf-8?B?cnlObm94cjBidmgvMmx2bytFNTBJNzM5ZjlOdDVWV09QZENXSzRPRHdFNE1S?=
 =?utf-8?B?QWUzeVFVTUNMK1RpcDNZRGFrUFJ0Z0dPVUlpY1NoU3hvanpmRDdVNnpBUWow?=
 =?utf-8?B?c2RGV2hVNFlTRlppYjNZdCtyejJsM255MHkrR0ZGdmJkblEwYndBZ3dCSzZV?=
 =?utf-8?B?cldFbXYvQWd1eG9BcDJSd3JSaTI3bUVVakE0U0xkOVYzdVhiQjRaSEdWOTBD?=
 =?utf-8?B?QVgvaEpBMDlPc1dhRlo0cklOaWRISHJxUkFldU1KZFoybjVKWTZuVndoVTdw?=
 =?utf-8?B?VEt5Qi9kdzUvQmNORklLQTBsR1RQTmdyekFpdlVXVlk1NXU1Wkd2c2h4cUEv?=
 =?utf-8?B?d0x0dG1iVVViK2VMWDZpTjBVVXdpV2thdm9GbUFOMGNDRU5EZ0NsYVQ0b0VJ?=
 =?utf-8?B?U01wMGx3OUZKZ3FzbXlKM2lqN1EzazZPWno3VmVCc3pPekVBUzUrWjVqNFFZ?=
 =?utf-8?B?bGZqMXpLcEdJNnZleEgzQVRUNTlZQy8yRWgyWlRqMHVBV2d5ZVdDZXNTdWx4?=
 =?utf-8?B?U0NlRWk0ZVVQazVQNHVNNTRJK0YycUs5VFV1aTQ4eDc1d0NyZ3N5YTN6b3lV?=
 =?utf-8?B?Q1FMM3ZvRGVlcVh1dU01Mnc5eDdzZlk3WUQrRkVOc1EyUzZlcEFCQTB3QlV3?=
 =?utf-8?B?OFRQR25WMlBRTVNFWW9ESVRpZUFtNDZZRlRrMXQ1T0RsZ1Y3VnByMEZlY2dX?=
 =?utf-8?B?aUxZV2J2TEE5Umw2UzRjcVo0LytBOVR6Yno5YXF2eXRHN0FGbi9yZktBUTJU?=
 =?utf-8?B?bktxakVuZkhIOXRtdHNzYW5iYW5NNFVDN1FVOUVSYXBHUGNVR0Nic1BhWjhT?=
 =?utf-8?B?UlVQd2dJaURzMzV4VGtXVVcyaW1OY1h3TGtWMGJJS2hURlFiWUJtNENyOTYr?=
 =?utf-8?B?Z0JyV1FmNlBvem9wVnFEWGNrR3lZV09HUWNXUWdCWklKUUNuN0tQNzVwMC9u?=
 =?utf-8?B?cGFqNmdTRlVaMHJjeXZzRVU0MUxmTUFaNXF6QnpRYTBHVlpUVzV2TEV5Slpo?=
 =?utf-8?B?Ti9iYVJudDhHTHppUEhNOEZZSG5ZRlUrQjJibUEwbFY4SEMxa0JsQkVmOHQ3?=
 =?utf-8?B?WW9UVEc1eFpyWmI2d2tOODhWdEh4dGxMZ1VzVzhIT3hnaTN3TEdTK2M4Zmtp?=
 =?utf-8?B?MHlQV2kvSWtGUmVRVWhDeEhFeHBvZXJmbDVKMlBVemlRYWd1bk1QNWhWcW51?=
 =?utf-8?B?elRIbkpSNUl2ZzQxNDRGU1dONFM1RHlHZE8yVmh1dnFqMHhIWloxbDdBUkhM?=
 =?utf-8?B?YWhyTzFrZ0NPY0JSWCt4ekN4M2phamozZHlGQjNpbkxrY0QyYXVYRGZXNWtB?=
 =?utf-8?B?bnExeS9lc2xlYnFYSHdmTWUzQUtCK3BxOFRZWkRQaVhoUHVZYnloZ2hvWU5i?=
 =?utf-8?B?OGpuOGcrbzhJODRVc09PMXowR0E1ci9Ma3ZSRWl1SC80dVB6UUVkSDRxKzIv?=
 =?utf-8?B?NWQ5dGNtMVRFUk52TmVNdmpoUys4WmZSTEw4bXl3bE8zbUNMY2I0c0ZtUUwz?=
 =?utf-8?B?TFg0dUlWdVpZQ2ZrNDV4K2licVZMMS9QcGJjVUNpQ1R3VDY5ZFhXZGFvTGRn?=
 =?utf-8?B?VmdhM3V4SEJmYjZoZEliYks2TFVIb1pFcXZOWVNaQWYyT042WWFsdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 268f3520-fafc-4b29-d559-08df43ec6ae3
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 14:17:59.6022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: loyd7R0UNXTtEXv+3L868g9UGqCPE+3+10+KuiDOTjgyE7jo2f5QTG+O2rIYpW9av2kQMFt3v0Jrc5u3GQk/Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB1763
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 10, 2026 at 3:58 PM GMT, Philipp Stanner wrote:
> Many users of dma_fence do things like:
>
> // Thread A
> dma_fence_set_error(f, -EINVAL);
> dma_fence_signal(f); // <- Takes lock, which orders against the above.
>
> // Thread B
> if (dma_fence_is_signaled(f)) // <- Does test_bit(), no ordering.
> 	pr_info("err: %i\n", f->error); // <- Can be loaded first.
>
> There is no memory ordering between reading of the signaled-bit and
> reading of the error code.
>
> Though dma_fence_get_status() does take the fence lock, it is equally
> broken because the misordering can simply happen within the critical
> section I think?
>
> (dma_fence_is_signaled() shouldn't even exist for users btw, a user
> should always only call a working, ordered dma_fence_get_status() so he
> cannot that easily ignore the error code
>
> Likewise, dma_fence_set_error() should not exist since it massively
> incentivizes messing up. I suppose the _locked functions came to be to
> fix that up in hindsight?).
>
> Since I want to work towards a dma_fence implementation where users do
> not take the fence lock manually anymore, the proposed fix is: Order
> dma_fence_is_signaled() with the lock, and
> dma_fence_is_signaled_locked() with a barrier.
>
> In the mid-term, we would deprecate all XXX_locked functions. The
> self-locking fence API can satisfy all user requirements with the
> inline-lock.
>
> Ordering dma_fence_is_signaled() with the spinlock instead of a barrier
> also has the advantage of protecting against frequent bugs where people
> run into UAF because they got their refcounting wrong and rely on the
> fence being freeable once the signaled-bit lights up:
>
> 	commit c8a5d5ea3ba6 ("nouveau: fix client work fence deletion race")
> 	commit 7c703a7d3f2b ("drm/amdgpu: Fix one use-after-free of VM")
>
> This related pattern works:
>
> 	dma_fence_lock_irqsave(f, flags);
> 	dma_fence_set_error(f, -EINVAL);
> 	dma_fence_signal_locked(f); // uses test_and_set_bit(), which is strongl=
y ordered
> 	dma_fence_unlock_irqrestore(f, flags);
>
> This is all very subtle and implicit.
>
> Regardless, I think we really need to establish what the signaled-bit
> really means and who is responsible where for its evaluation semantics.
>
> Lucas recently (rightfully) pointed out that the signaled-bit originally
> was supposed to *only* mean that the hardware is done. But this is just
> not the API reality anymore, where we have to use the signaled-state for
> driver-unload and for correct evaluation of error codes.
>
> Note at this point my proposal to transition fence to a stable state
> where these subtleties disappear. The time window to add this change
> right now is unusually good because the inline_lock is not used by
> anyone yet except for our Rust abstractions, so we can get things right
> without breaking old drivers.
>
> Link: https://lore.kernel.org/dri-devel/20261020100034.759183-2-phasta@ke=
rnel.org/
>
> Fixes: d6c99f4bf093 ("dma-fence: Wrap querying the fence->status")
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
> Regarding ordering between
>
> dma_fence_get_status()
>
> and
>
> dma_fence_set_error() followed by
> dma_fence_signal()
>
> Would probably be good if those highly experienced with ordering (Paul,
> Gary) can share their opinion whether there's actually a problem that
> can occurr in reality.
> ---
>  include/linux/dma-fence.h | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index dd07d128adc3..fe6fbc5a5a35 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -517,8 +517,18 @@ static inline bool
>  dma_fence_is_signaled_locked(struct dma_fence *fence)
>  {
>  	const struct dma_fence_ops *ops;
> +	bool signaled;
> =20
> -	if (dma_fence_test_signaled_flag(fence))
> +	signaled =3D dma_fence_test_signaled_flag(fence);
> +	/*
> +	 * Whoever holds the lock might next try to obtain the fence's error
> +	 * code - but there is no ordering between reading the signaled flag
> +	 * and the reading of the error code.
> +	 *
> +	 * Order properly with rmb() since fences might be involved in IO.
> +	 */
> +	rmb();
> +	if (signaled)
>  		return true;

I see why you're using rmb(): you have control dep to establish LOAD->STORE
ordering and rmb for LOAD->LOAD ordering. However, this this isn't used
correctly.=20

I think this should be:

    if (dma_fence_test_signaled_flag(fence)) {
        smp_acquire__after_ctrl_dep(); // This is smp_rmb, but intent is cl=
ear.
        return true;
    }

Alternatively, just use test_bit_acquire in dma_fence_test_signaled_flag, w=
hich
is better as there's no dependency on control dep.

Best,
Gary

> =20
>  	rcu_read_lock();
> @@ -553,9 +563,17 @@ static inline bool
>  dma_fence_is_signaled(struct dma_fence *fence)
>  {
>  	const struct dma_fence_ops *ops;
> +	unsigned long flags;
> =20
> -	if (dma_fence_test_signaled_flag(fence))
> +	/*
> +	 * Take the lock to order against people reading the fence's error code=
.
> +	 */
> +	dma_fence_lock_irqsave(fence, flags);
> +	if (dma_fence_test_signaled_flag(fence)) {
> +		dma_fence_unlock_irqrestore(fence, flags);
>  		return true;
> +	}
> +	dma_fence_unlock_irqrestore(fence, flags);
> =20
>  	rcu_read_lock();
>  	ops =3D rcu_dereference(fence->ops);


