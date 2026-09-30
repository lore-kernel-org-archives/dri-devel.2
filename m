Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02D6C9830E
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 03:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25F5110E16D;
	Wed, 30 Sep 2026 03:57:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="keApswuq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0775710E16D
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:57:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CCBA643B73;
 Wed, 30 Sep 2026 03:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922821F000FF;
 Wed, 30 Sep 2026 03:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790740634;
 bh=rI1Qq5iUL9K8B7aYto3uHxF++3cNICgULmRMZU2Ndos=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=keApswuqkuEln7uOfu/wa7EyIWAn3FMxHNvNrjwzihyxioeqWJhBbPPRuxrkgkRex
 unvceBiR8EEcRhcuDMzF6/wO/ErzOjBbS7egQ3WNFlEY9mX5BY4smCJuu2zCYKBG63
 gxSu2vZCiceMRkJ207bh+WrjRbdhOg5l4aNQYJ4ZKgUsK8eX2GFPPA3VJmysMBFR3t
 0gbF4hXnSqtwykeoJ8Z2pSclYx/hsnC62H6Mepv8jSfWoch8PnNTg4rrh+kcFAAWbe
 D+ngC4zdul3uyt68cRYguLTUv1d9qMM3MwF4cr33PQlb83vHw2Zdjb8VoeejJ1tcnd
 V8iAa59YUktKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] misc: fastrpc: Fix double free in fastrpc_req_mmap()
 error path
To: "Yao Yiqi" <yaoyiqi3@huawei.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260930032022.2957082-1-yaoyiqi3@huawei.com>
References: <20260930032022.2957082-1-yaoyiqi3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 03:57:14 +0000
Message-Id: <20260930035714.922821F000FF@smtp.kernel.org>
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
- [Critical] misc: fastrpc: unconditional list_del in error path races with=
 concurrent unmap
--

commit 03236356a22d5b8fc33413026fac2ff46d3f8883
Author: Yao Yiqi <yaoyiqi3@huawei.com>

misc: fastrpc: Fix double free in fastrpc_req_mmap() error path

This commit aims to fix a double free and use-after-free in the
fastrpc_req_mmap() error path. It modifies the error handling when
copy_to_user() fails to remove the buffer from the mmaps list before
unmapping, matching patterns introduced in prior patches.

Cc: stable@vger.kernel.org

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index af18ff1992eed..436e046ed1cc0 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2129,6 +2129,9 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl=
, char __user *argp)
> =20
>  	if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
>  		err =3D -EFAULT;
> +		spin_lock(&fl->lock);
> +		list_del(&buf->node);
> +		spin_unlock(&fl->lock);

[Severity: Critical]
Does this unconditionally remove the buffer from the list even if a concurr=
ent
thread has already removed it?

If copy_to_user() blocks or is delayed (for example, via userfaultfd), a
concurrent thread could call FASTRPC_IOCTL_MUNMAP, predicting or reading the
partially copied address. This thread can extract the buffer from the list =
and
free it while the first thread is still suspended:

drivers/misc/fastrpc.c:fastrpc_req_munmap() {
    ...
			list_del(&iter->node);
			buf =3D iter;
			break;
    ...
}

If the suspended copy_to_user() then fails, the first thread will resume
and execute this newly added list_del(&buf->node). Because the concurrent
unmap already unlinked the buffer, its list pointers will have been set to
LIST_POISON1 and LIST_POISON2.=20

Could this trigger an immediate kernel oops due to a poisoned pointer
dereference?

>  		goto err_assign;
>  	}
> =20
> @@ -2138,7 +2141,11 @@ static int fastrpc_req_mmap(struct fastrpc_user *f=
l, char __user *argp)
>  	return 0;
> =20
>  err_assign:
> -	fastrpc_req_munmap_impl(fl, buf);
> +	if (fastrpc_req_munmap_impl(fl, buf)) {

[Severity: Critical]
Following the race sequence described above, if the concurrent unmap thread
has already freed this buffer, does passing it to fastrpc_req_munmap_impl()
here lead to a use-after-free and a subsequent double free?

> +		spin_lock(&fl->lock);
> +		list_add_tail(&buf->node, &fl->mmaps);
> +		spin_unlock(&fl->lock);
> +	}
> =20
>  	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930032022.2957=
082-1-yaoyiqi3@huawei.com?part=3D1
