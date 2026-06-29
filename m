Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A051FC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 06:59:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5DF510E035;
	Mon, 29 Jun 2026 06:59:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OpZpETnl";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E013710E035
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 06:59:54 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gpcbW4kVfz9tv4;
 Mon, 29 Jun 2026 08:59:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1782716391; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3hbzEnZLAxVe7ov2oMC76sAGhhFWZLnsRyY/MSpvDoM=;
 b=OpZpETnl2QbkF2dT5mnB5Yni7iy5P50niEkB/W2TSRxOOM32j7izTnQjyiENXcbK26PltS
 v3NslQjcrwoKez3ZUrZeKNsdYHpJHIyjJ/W/Yo0Bmqa5kWhPS3uachHQX+TLXQMJ4mLHI9
 Nm6hQ4d3/UPJEIxR56wmEXB4WubGN9NYpyDKIQq6m5x28UeyHv2dLCXaiKWeywrWktbL5K
 OQOuuge2wOLZ9QiSbbvZ2p3dfhWJDa7/lqSexq1rdxFq1+2mt40I5JgScnzON9FQ1TLjxb
 qiTOtHvA+Jgak4v64ATZwUhVlPVFSugA0cHre/RSPjKxRu3SQNTIjPILaeL/BA==
Message-ID: <e5b833e4c3764efa84f57e1b9691b946e0d3b1cd.camel@mailbox.org>
Subject: Re: [PATCH] dma-fence: Make dma_fence_dedup_array() robust against
 0-count input
From: Philipp Stanner <phasta@mailbox.org>
To: Baineng Shou <shoubaineng@gmail.com>, Sumit Semwal
 <sumit.semwal@linaro.org>,  Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, Philipp Stanner
 <phasta@kernel.org>,  Akash Goel <akash.goel@arm.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Date: Mon, 29 Jun 2026 08:59:47 +0200
In-Reply-To: <20260629031346.3875683-1-shoubaineng@gmail.com>
References: <20260629031346.3875683-1-shoubaineng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: bbk6f6twdq8kmn36mzidwpfnhkk5qc61
X-MBO-RS-ID: 236d4085a3bc31e8aaf
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon, 2026-06-29 at 11:13 +0800, Baineng Shou wrote:
> dma_fence_dedup_array() returns 1 when called with num_fences =3D=3D 0:
> the for-loop body never executes, j stays at 0, and the final
> `return ++j` yields 1. This contradicts both the kernel-doc ("Return:
> Number of unique fences remaining in the array") and the natural
> expectation that 0 input gives 0 output.
>=20
> All in-tree callers currently filter num_fences =3D=3D 0 before invoking
> this helper (__dma_fence_unwrap_merge() bails out via the
> `if (count =3D=3D 0 || count =3D=3D 1)` fast path; amdgpu_userq_wait_*()
> cannot reach the dedup call with a zero local count because the
> amdgpu_userq_wait_add_fence() helper guarantees num_fences stays in
> [0, wait_info->num_fences], and wait_info->num_fences > 0 is enforced
> at the ioctl entry).
>=20
> However, dma_fence_dedup_array() is EXPORT_SYMBOL_GPL, so any future
> caller that forgets to pre-filter the zero case will get a misleading
> return value of 1. Depending on how that caller uses the result, it
> could dereference an uninitialized fence slot in the array, since the
> caller's array may have been allocated but not yet populated.
>=20
> Make the contract match the documentation by returning 0 early. This
> also skips an unnecessary sort() call on an empty array.
>=20
> Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
> ---
> =C2=A0drivers/dma-buf/dma-fence-unwrap.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/dma-buf/dma-fence-unwrap.c b/drivers/dma-buf/dma-fen=
ce-unwrap.c
> index 53bb40e70b27..364cbf79ad73 100644
> --- a/drivers/dma-buf/dma-fence-unwrap.c
> +++ b/drivers/dma-buf/dma-fence-unwrap.c
> @@ -97,6 +97,9 @@ int dma_fence_dedup_array(struct dma_fence **fences, in=
t num_fences)
> =C2=A0{
> =C2=A0	int i, j;
> =C2=A0
> +	if (!num_fences)
> +		return 0;

Hm, since you're adding this, what about num_fences =3D -5 ?


Let me use this opportunity to also highlight that we should, in C, in
general get away from using int for everything.

__dma_fence_unwrap_merge() directly below uses unsigned int, as you
would expect. dma_fence_dedup_array() has almost no users. Probably we
should change that API to unsigned int, too?


Regards
P.

> +
> =C2=A0	sort(fences, num_fences, sizeof(*fences), fence_cmp, NULL);
> =C2=A0
> =C2=A0	/*
