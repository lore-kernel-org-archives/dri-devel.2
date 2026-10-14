Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8BCCC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1D4010E99C;
	Wed, 14 Oct 2026 11:21:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 640CA10E99C
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 11:21:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5DB88601F9;
 Wed, 14 Oct 2026 11:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EF71F00893;
 Wed, 14 Oct 2026 11:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791976883;
 bh=r3409Lr+FS0I0WLlXMYOrKbDcsmwS1R6trRHLVGpQH4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=apFNEBP8RSzEvV2bRZ4GUNDXuuhVc/l/HbmZjfVtBfa68AbFvnQrCfDWti21MtCyA
 4JNv2gpr8Wt+pA56W4gMqwB2NmO6z8SaaGIj61UjBBOzRNgz/vn4FWYsr4Gba+3r8y
 EUC+SdUdF0hbHl+SQ36REJmtckc1DCgxOYODv3lNgjD3cLYZ6ZFfFfkLw8kxmUsdjR
 dh1BLADVFZ77bmo4NQR0keV4YCiL49yhw2xnz6etCMfWdCkKfeF+0pwUEXEL9qU+Lv
 82y/NnM5/+YbzUpHX/DMkMtfPyMGQEU/Cz6obo8U7I+KpT/rhr+i7aRFRS2lXSbHll
 5abY75PtqCZ9g==
Message-ID: <sashiko-outbox-171194@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 04/13] block: introduce dma map backed bio type
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <39b964cf7510f42755188563da63d3d5acaf2aa9.1791975048.git.asml.silence@gmail.com>
References: <cover.1791975048.git.asml.silence@gmail.com>
 <39b964cf7510f42755188563da63d3d5acaf2aa9.1791975048.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 11:21:22 +0000
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
- [High] block: type confusion in blk_rq_cur_bytes() due to bio_has_data() =
including REQ_DMABUF
--

commit 338a7d60f029eb7fdd6fca422f1d54a04222c016
Author: Pavel Begunkov <asml.silence@gmail.com>

block: introduce dma map backed bio type

This patch introduces a dma map backed bio type to support pre-mapped
buffers without requiring a generic bio_vec. It repurposes the bi_io_vec
space in struct bio to store a dma_buf_io_map when the REQ_DMABUF flag
is set. It also adds specific splitting logic based on the minimum
segment size provided by the map.

[ ... ]

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
Does this union introduce type confusion when existing block layer helpers
check bio_has_data()?

Because REQ_DMABUF is a flag rather than an operation type, bio_has_data() =
in
include/linux/bio.h will still return true for read/write requests carrying
this flag.

When a driver partially completes a REQ_DMABUF request, blk_update_request()
calls blk_rq_cur_bytes() in include/linux/blk-mq.h to verify the size of the
remaining segment:

include/linux/blk-mq.h:blk_rq_cur_bytes() {
    ...
    if (!bio_has_data(rq->bio))
        return rq->bio->bi_iter.bi_size;
    return bio_iovec(rq->bio).bv_len;
}

Since bio_has_data() is true, blk_rq_cur_bytes() invokes
bio_iovec(rq->bio).bv_len. This macro treats the bio->bi_dmabuf_map pointer
as an array of struct bio_vec, reading bv_len from the overlapping bytes of
the dma_buf_io_map struct.

If this garbage value is larger than the remaining blk_rq_bytes(req), it
corrupts req->__data_len and can trigger out-of-bounds memory access or
panics when the request resumes. Should bio_has_data() be updated to
exclude REQ_DMABUF, or is there another way to prevent blk_rq_cur_bytes()
from blindly dereferencing the dma map as a bio_vec?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791975048.gi=
t.asml.silence@gmail.com?part=3D4
