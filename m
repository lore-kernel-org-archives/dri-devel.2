Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D0ECA5FC3
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85A5210F213;
	Wed, 30 Sep 2026 07:46:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KEKsWVYP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62C7D10F213
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 07:46:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 903E960252;
 Wed, 30 Sep 2026 07:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0CC1F000FF;
 Wed, 30 Sep 2026 07:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790754369;
 bh=NEZLRfJEE2yMEeE/pnBEK97HeFezwmJM+lGHnGQ637w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KEKsWVYP7mjgWJ47nXn/927/Hwaqv7suFlvWXQDw3CVH5uR/weeyO7QOd/6aIDt/F
 tRZqkNmFpnXnFmVG9Khhm2aRq0OkPAEEc1CjanGbaikZrw/6NgxoiNdkXhKrYeoE12
 C5fjlUX4ZUyMNBGYDX4cN1z7L2bzLb6mFsbM2CCraudQXdEwQXiv9Q4VRLI3Cb6BkR
 i+GcFmx/5QhcWZpLEmQGY8QeU/rsyLfmlT2bqOlcoWgpmjzyV8fbug7SI0HWCZvsCH
 SuKsZvD400mm2TniP8LileIXuTfzVbOaMnWiioVFax8EVWir3SHGH0hZkFwbRUoh2l
 vVgKviC+cF4fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] misc: fastrpc: Fix double free and races in
 fastrpc_req_mmap() error path
To: "Yao Yiqi" <yaoyiqi3@huawei.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260930071340.2969948-1-yaoyiqi3@huawei.com>
References: <20260930071340.2969948-1-yaoyiqi3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 07:46:08 +0000
Message-Id: <20260930074609.1C0CC1F000FF@smtp.kernel.org>
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
- [Critical] fastrpc: DMA use-after-free by DSP due to missed invoke_interr=
upted_mmaps transfer
--

commit 77b5628f93f366d6c2407907756d94941e50a6f7
Author: Yao Yiqi <yaoyiqi3@huawei.com>

misc: fastrpc: Fix double free and races in fastrpc_req_mmap() error path

This commit defers adding the newly allocated buffer to the fl->mmaps list
until after copy_to_user() succeeds. If the copy fails and the subsequent
unmap operation also fails, the buffer is re-added to the list to prevent
a leak.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
[ ... ]
> @@ -2153,22 +2153,26 @@ static int fastrpc_req_mmap(struct fastrpc_user *=
fl, char __user *argp)
[ ... ]
>  err_assign:
> -	fastrpc_req_munmap_impl(fl, buf);
> +	if (fastrpc_req_munmap_impl(fl, buf)) {
> +		spin_lock(&fl->lock);
> +		list_add_tail(&buf->node, &fl->mmaps);
> +		spin_unlock(&fl->lock);
> +	}
> =20
>  	return err;
>  }

[Severity: Critical]
Is there a risk of a DMA use-after-free if the unmap operation is
interrupted by a signal?

When fastrpc_req_munmap_impl() is interrupted, fastrpc_internal_invoke()
handles this by moving the buffer to the invoke_interrupted_mmaps list to
intentionally leak it and prevent the DSP from accessing freed memory:

drivers/misc/fastrpc.c:fastrpc_internal_invoke() {
    ...
    if (err =3D=3D -ERESTARTSYS) {
        spin_lock(&fl->lock);
        list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
            list_del(&buf->node);
            list_add_tail(&buf->node, &fl->cctx->invoke_interrupted_mmaps);
        }
        spin_unlock(&fl->lock);
    }
    ...
}

Because this patch defers adding the buffer to fl->mmaps until after
copy_to_user(), fastrpc_internal_invoke() will not find the buffer in
fl->mmaps when called from this error path, missing the transfer to the
interrupted list.

If fastrpc_req_munmap_impl() returns -ERESTARTSYS, this err_assign path
then manually adds the buffer back to fl->mmaps. When the process later
exits, fastrpc_user_free() will reclaim this buffer while the DSP may still
be using it, which could corrupt newly allocated kernel memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930071340.2969=
948-1-yaoyiqi3@huawei.com?part=3D1
