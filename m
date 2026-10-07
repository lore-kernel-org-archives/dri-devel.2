Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CEFCA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 01:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5C0110F45E;
	Wed,  7 Oct 2026 01:59:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mg63dYcg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16F5610F45E
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 01:59:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 48CE8601FA;
 Wed,  7 Oct 2026 01:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85FE1F0089B;
 Wed,  7 Oct 2026 01:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791338341;
 bh=75JpaSc4nplSkVkbn4s/OC91PELBe1dAb9MJ4a0RmXE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mg63dYcgt58J4hp+nj/PeervqTS7287xLtC/hY+dLnYhyYOgV6s4uF1DZEiSHG8dX
 QDLbaJw+8pxFjfoZ9xs2gCd6DcFYSy3/qTT+G6PmDLmEIHhG0ytUQmkmjjEDjtKZoe
 AG9+i/7LNv/4kHyOBV+PSK2COu1klrhK6sSIK/72IHr6v+MQWT7d38zIoJUw1xZ6QN
 sfxzbaFm7hK+wiiS7osJzJZPTKYfr365RgfX1JSwQss2LB1HKtjcsIgWfXovXHamG5
 XCDJdgqHNbf3os433nOZKEVDZMcBHbQQEkvoWKvkt2Dd74Q9Wh98tt0j7dqNow049v
 TDgFnGnYNfTPg==
Message-ID: <sashiko-outbox-162576@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 04/13] block: introduce dma map backed bio type
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <17dc7954fc8632ca4fb80cd4c892fc0c5ce2d11b.1791336930.git.asml.silence@gmail.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
 <17dc7954fc8632ca4fb80cd4c892fc0c5ce2d11b.1791336930.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 01:59:00 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] block: type confusion in blk_recalc_rq_segments() for REQ_DMABUF b=
ios
--

commit e3ead2f3d194e7e61660e2723f7786a4b6fec3ba
Author: Pavel Begunkov <asml.silence@gmail.com>

block: introduce dma map backed bio type

This patch introduces a dma map backed bio type. It repurposes the bi_io_vec
space in the bio structure to store dmabuf maps, as premapped buffers do not
require a generic bio_vec array.

> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 98e21b4cbf328..0cc09b975d8ff 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -233,7 +233,12 @@ struct bio {
>  	atomic_t		__bi_remaining;
> =20
>  	/* The actual vec list, preserved by bio_reset() */
> -	struct bio_vec		*bi_io_vec;
> +	union {
> +		struct bio_vec		*bi_io_vec;
> +		/* Driver specific dma map, valid IFF REQ_DMABUF is set */
> +		struct dma_buf_io_map	*bi_dmabuf_map;
> +	};
> +

[Severity: High]
Does this memory alias cause a type confusion in existing block layer
functions that don't check for REQ_DMABUF?

For example, if a REQ_DMABUF request completes partially,
blk_update_request() will call blk_recalc_rq_segments(). That function
iterates over the request using rq_for_each_bvec(), which internally uses
bio_for_each_segment() and blindly dereferences bi_io_vec as a bio_vec
array because bio_has_data() evaluates to true for these bios.

This means it reads the memory of struct dma_buf_io_map as bv_page, bv_len,
and bv_offset. When the garbage bv_len is passed to
bio_advance_iter_single(), it subtracts it from iter->bi_size, which can
lead to an infinite loop or wild memory accesses when attempting to process
the segments.

Is there a need to update blk_recalc_rq_segments() or other iterators to
explicitly exclude REQ_DMABUF bios?

>  	struct bvec_iter	bi_iter;
> =20
>  	union {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791336930.gi=
t.asml.silence@gmail.com?part=3D4
