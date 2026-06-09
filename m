Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5CBCD8CAE
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 06:51:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55CAD10E0EF;
	Tue,  9 Jun 2026 06:51:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dpU0X0QG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DECD10E0EF
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 06:51:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 28B33601E1;
 Tue,  9 Jun 2026 06:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E531F00893;
 Tue,  9 Jun 2026 06:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780987880;
 bh=0+YkzFwuosu5P+7/g1ZS5sl/JtadLqAIJ1LhEif2i0s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dpU0X0QGWYh4HouVMdpzFFMoaY+fiFlI08GXz/HWJyzcLclxZaUpofQaixe44K2/r
 MoLQcJN+M7ChxF+JUvdn4ZPVr5+RtkaQEnyKRGFZS6djXaZ6hArzOJaYX3WIp7OSVK
 TCK+Xg6VKVPHK96iXvnqRG08rV/tCn2gIh5tgSgLNu51DzLFUD1r5ZCWCz3fPIZVY7
 4m3mM6aPMZycYazzkN3IOrKF19bjC3hXjaUTreMcPum88rzbAX4r2DpJzFH4UZx1KJ
 32Gz8Vy2Llq4ynAXpLUZDvjBQX2ql1Uf/2NR1G2zQWpvId5iZz3szazNU2uSZ4sR1U
 XQf5en21OnJ6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/14] drm/ttm: Open-code reservation list walk
To: "Kaitao Cheng" <kaitao.cheng@linux.dev>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609062526.94907-4-kaitao.cheng@linux.dev>
References: <20260609062526.94907-4-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 06:51:19 +0000
Message-Id: <20260609065120.74E531F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing lock release when `dma_resv_reserve_fences()` fails, leavi=
ng the current buffer object permanently locked.
--

commit 4a941c2e22e18c4c60dbeb3162fc85117e45e7a8
Author: Kaitao Cheng <chengkaitao@kylinos.cn>

drm/ttm: Open-code reservation list walk

This patch modifies ttm_eu_reserve_buffers() to open-code the
list_for_each_entry() loop. This prepares the code for future list iterator
updates while preserving the existing traversal semantics where the cursor
can be rewound during duplicate handling.

> diff --git a/drivers/gpu/drm/ttm/ttm_execbuf_util.c b/drivers/gpu/drm/ttm=
/ttm_execbuf_util.c
> index bc7a83a9fe443..8072f07d55579 100644
> --- a/drivers/gpu/drm/ttm/ttm_execbuf_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
> @@ -86,7 +86,9 @@ int ttm_eu_reserve_buffers(struct ww_acquire_ctx *ticke=
t,
>  	if (ticket)
>  		ww_acquire_init(ticket, &reservation_ww_class);
> =20
> -	list_for_each_entry(entry, list, head) {
> +	for (entry =3D list_first_entry(list, typeof(*entry), head);
> +	     !list_entry_is_head(entry, list, head);
> +	     entry =3D list_next_entry(entry, head)) {

[Severity: High]
This is a pre-existing issue, but does the error path in this loop leak
the lock on entry->bo when dma_resv_reserve_fences() fails?

If ttm_bo_reserve() successfully acquires the lock on the current entry->bo,
and then dma_resv_reserve_fences() fails (for example, returning -ENOMEM),
the code cleans up using ttm_eu_backoff_reservation_reverse():

ttm_eu_reserve_buffers() {
    ...
    if (!ret) {
        ret =3D dma_resv_reserve_fences(bo->base.resv, num_fences);
        if (!ret)
            continue;
    }

    /* uh oh, we lost out, drop every reservation and try... */
    ttm_eu_backoff_reservation_reverse(list, entry);
    ...
}

However, ttm_eu_backoff_reservation_reverse() explicitly skips unlocking the
current entry itself because it uses list_for_each_entry_continue_reverse().

The code then bypasses the slowpath because ret is -ENOMEM (not -EDEADLK)
and returns without unlocking entry->bo:

ttm_eu_reserve_buffers() {
    ...
    if (ret =3D=3D -EDEADLK) {
        ret =3D ttm_bo_reserve_slowpath(bo, intr, ticket);
    }
    ...
    if (unlikely(ret !=3D 0)) {
        if (ticket) {
            ww_acquire_done(ticket);
            ww_acquire_fini(ticket);
        }
        return ret;
    }
    ...
}

Could this sequence leave the ww_mutex for entry->bo permanently locked?

>  		struct ttm_buffer_object *bo =3D entry->bo;
>  		unsigned int num_fences;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609064122.9582=
5-1-kaitao.cheng@linux.dev?part=3D6
