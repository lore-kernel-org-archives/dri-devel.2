Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF18BC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:03:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57D4910E1AD;
	Tue, 30 Jun 2026 08:03:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UjH8imvI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A75D10EB7C
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 08:03:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7C3CA600BB;
 Tue, 30 Jun 2026 08:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099B91F000E9;
 Tue, 30 Jun 2026 08:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782806620;
 bh=0TMtBbAYazRQlFsl4WZg6crqSIKCd3/BXVitsyqGKaA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UjH8imvIP4k9yKzP9S03McTJ22Xp7u6WJtEAV2E8/JLtYD5xgQ3VfA6BqEIJBjBY1
 qDYzsGr6vGHOBItUBAWAcOBpDx+U4ZaDLBgNL3imEm4SYfDq7HKz81umskMhd3Siug
 MEiggUKoAPs+J+tAovoVXfcg9GdFH2REWz4K0NJT1UaAdomUlNhnzA9Ahk8rINnOUU
 gauAnDjcDoJ+rTjroo0cal4TVFT/KIHNPL5y5fJPUM5E92QRZvZsgO1IE3jngs/rrh
 qxosGS+tcPhDboiqOdHgqR8MbQn+uwbEZcGT5W7Hg8U8kkbJCbv639OkPuVFfaj0MR
 ZIGP4QwNeFQaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dma-buf: explicitely forbid exposing pages from
 get_user_pages()
To: =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260630080112.1117341-1-christian.koenig@amd.com>
References: <20260630080112.1117341-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 08:03:39 +0000
Message-Id: <20260630080340.099B91F000E9@smtp.kernel.org>
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
- [Low] Misspelling of the word 'explicitly' as 'explicitely' in both the c=
ommit message and the newly added source code comments. Additionally, 'impo=
rt mechanism' is slightly awkward grammatically and would read better as 'i=
mport mechanisms'.
--

commit d403e672a4ce196480792c8a6cdd1c4a2ffcf542
Author: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>

dma-buf: explicitely forbid exposing pages from get_user_pages()

This commit documents that DMA-buf exporters are forbidden from exposing
pages they do not own, such as those acquired by get_user_pages(). It also
discourages exposing the same backing store through multiple DMA-bufs to
avoid aliasing and cache coherency problems.

> dma-buf: explicitely forbid exposing pages from get_user_pages()

[Severity: Low]
This isn't a bug, but there is a typo (explicitely) in the subject line.

> Explicitely document that this is not something exporters can do.

[Severity: Low]
This isn't a bug, but there is a typo (Explicitely) in the commit message.

> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index d504c636dc294..b2efc3085e6d6 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -685,6 +685,14 @@ static struct file *dma_buf_getfile(size_t size, int=
 flags)
>   *
>   * For the detailed semantics exporters are expected to implement see
>   * &dma_buf_ops.
> + *
> + * It is explicitely forbidden for exporters to expose buffers they don'=
t "own"
> + * as DMA-buf. This includes pages acquired by get_user_pages() or other=
 import
> + * mechanism. Not following this rule can create numerous security probl=
ems.

[Severity: Low]
This isn't a bug, but there is a typo (explicitely) in the new comment.
Additionally, would it read better to use the plural "mechanisms" here
instead of "mechanism"?

> + *
> + * It is also strongly discouraged to expose the same backing store thro=
ugh
> + * multiple DMA-bufs at the same time. This eventually creates aliasing =
and
> + * cache coherency problems which are extremely hard to debug and fix.
>   */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630080112.1117=
341-1-christian.koenig@amd.com?part=3D1
