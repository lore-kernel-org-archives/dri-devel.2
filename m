Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B347CDE00E
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:34:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68D7910E10A;
	Fri, 26 Jun 2026 12:34:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZL68iv5M";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3838C10E61B
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:34:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1095E408BD;
 Fri, 26 Jun 2026 12:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3321F000E9;
 Fri, 26 Jun 2026 12:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782477295;
 bh=sst3p+kyQonD4gz2uY3IzHNXtBbBQKwvtWI/MCVrdko=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZL68iv5MBDLeYJoLxYTTYfv6Arvh42psa25J4XAHO9BPtnFCotte7tYEmVGayU0wJ
 H3MDOOEkwOZkx+uihDk2ZDvlWViINsYUb8VhDNbMW/7U+/rH0/tZDHela9QvJ4w7SO
 eWnuZZwsNUQIh7xL+36OQ3RgrT0Waz2NV8ioncE42m9sZc6DMZorjKmrAe2raTdqCT
 RFWhQx6XL75WXNdjOyM8ZnhM27BAJZePShJaPuwH4ZYxDMh4XkGBsRGXedJz19JKHD
 0mR76FOLB3cJgPL1V8q+aARo8mkrk9V7g09h/FiIt7+hoJrVFCUTroony6eZuFYSkg
 3HAL2aEZT4Ong==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fix: dma-buf: unwrap_merge_complex: dma_fence_get_stub
 reference leaked   on all paths
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626122836.35856-1-vulab@iscas.ac.cn>
References: <20260626122836.35856-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 12:34:55 +0000
Message-Id: <20260626123455.BE3321F000E9@smtp.kernel.org>
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
- [Medium] Double free / refcount underflow on the global static `dma_fence=
_stub` in `unwrap_merge_complex()`.
--

commit 361d06ca0291c480e1aafadac1b89e324d9431ab
Author: WenTao Liang <vulab@iscas.ac.cn>

fix: dma-buf: unwrap_merge_complex: dma_fence_get_stub reference leaked on =
all paths

This commit fixes a reference leak on the global stub fence in
unwrap_merge_complex() by adding dma_fence_put() calls to the success and
error paths.

> diff --git a/drivers/dma-buf/st-dma-fence-unwrap.c b/drivers/dma-buf/st-d=
ma-fence-unwrap.c
> --- a/drivers/dma-buf/st-dma-fence-unwrap.c
> +++ b/drivers/dma-buf/st-dma-fence-unwrap.c
[ ... ]
> @@ -530,8 +531,10 @@ static int unwrap_merge_complex(void *arg)
>  		err =3D -EINVAL;
>  	}
> =20
> +	dma_fence_put(stub);
>  	dma_fence_put(f5);
> -error_put_f4:
> +error_put_stub:
> +	dma_fence_put(stub);

[Severity: Medium]
Does this cause a double-put of the stub on the success path?

When unwrap_merge_complex() successfully completes, it appears execution
will call dma_fence_put(stub) just before putting f5, and then fall right
through into the error_put_stub label where it calls dma_fence_put(stub) a
second time.

Since dma_fence_get_stub() only acquires a single reference, putting it
twice would underflow the refcount and trigger dma_fence_release(). This
could result in an attempt to call kfree_rcu() on the statically allocated
dma_fence_stub global variable, causing a panic during the selftest.

Would it be better to only place dma_fence_put(stub) after the
error_put_stub label, allowing the success path to fall through and clean
it up once naturally along with the other fences?

>  	dma_fence_put(f4);
>  error_put_f3:
>  	dma_fence_put(f3);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626122836.3585=
6-1-vulab@iscas.ac.cn?part=3D1
