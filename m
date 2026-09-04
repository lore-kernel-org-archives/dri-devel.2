Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186E7C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:09:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4117910FB02;
	Fri,  4 Sep 2026 12:09:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FUFq+aFe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFA7710FB02
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 12:09:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E0B236020C;
 Fri,  4 Sep 2026 12:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807571F00A3E;
 Fri,  4 Sep 2026 12:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788523785;
 bh=HFafFqv4p2v02MXt+SA5HLqpdPpawf3Ony/lHTwlupw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FUFq+aFeRZdmomG7gK4e9vvlz5AOY3GdZE+ULy3UpiwKTpWrxp4XLTR8iWiVHgUjt
 KBb4FBR+UW8mIXWtoHrvacvtKC85ilSlWsqoIgkKlw16Yp0zhCTwXBxC1V2RauTgLv
 3tRfUgT0kVlK7rR03+fQWgrIlSy8r8qwA7XOYAVXzZQ8XE8h4B+DR1aKntm6N619tE
 45mj/zydfY0xz0NGd6eVMpFeW4nsx8lZeflvushNW6RIgg5knNggxokU9zAUh3FJVq
 oE4H3UM9gE+/t/vLA4HPUaJDNYDBNBqgg0NBgCZUe10EatxhctlFCPzzfqykWr3EXj
 6dwUrXHOo34zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm: fix repeated words in comments
To: "Hemanth Selam" <hemanth.selam@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260904120430.17224-3-hemanth.selam@gmail.com>
References: <20260904120430.17224-1-hemanth.selam@gmail.com>
 <20260904120430.17224-3-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 12:09:45 +0000
Message-Id: <20260904120945.807571F00A3E@smtp.kernel.org>
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
- [Low] Incorrect grammar correction altering comment meaning.
--

commit a1ccb2e6474d515b1b000ccef6e3cfcb3d32f358
Author: Hemanth Selam <hemanth.selam@gmail.com>

drm: fix repeated words in comments

This commit addresses warnings from checkpatch.pl by dropping words that ap=
pear
to be accidentally repeated in comments. The changes are intended to only t=
ouch
comments without affecting code execution.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vm=
wgfx/vmwgfx_execbuf.c
> index 6dfb45592d747..be3c3c074e75d 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
[ ... ]
> @@ -339,7 +339,7 @@ static int vmw_execbuf_res_val_add(struct vmw_sw_cont=
ext *sw_context,
>  }
> =20
>  /**
> - * vmw_view_res_val_add - Add a view and the surface it's pointing to to=
 the
> + * vmw_view_res_val_add - Add a view and the surface it's pointing to the
>   * validation list
>   *

[Severity: Low]
Does this grammar correction alter the intended meaning of the comment?

The original phrase in vmw_view_res_val_add() uses the first "to" as part of
"pointing to", and the second "to" as part of "to the validation list".
By removing one, the sentence now implies the surface is pointing to the
validation list, rather than adding the surface to the validation list.

>   * @sw_context: The software context holding the validation list.
[ ... ]
> @@ -367,7 +367,7 @@ static int vmw_view_res_val_add(struct vmw_sw_context=
 *sw_context,
> =20
>  /**
>   * vmw_view_id_val_add - Look up a view and add it and the surface it's =
pointing
> - * to to the validation list.
> + * to the validation list.
>   *
>   * @sw_context: The software context holding the validation list.

[Severity: Low]
Does this change have the same issue as above?

It changes the sentence structure in vmw_view_id_val_add() such that it no
longer means adding the surface (that the view points to) to the validation
list.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904120430.1722=
4-1-hemanth.selam@gmail.com?part=3D2
