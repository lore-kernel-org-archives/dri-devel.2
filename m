Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9695C79F82
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 01:09:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 367EF10EE39;
	Wed,  9 Sep 2026 01:09:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Xd7QWK6t";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50D3E10EE39
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 01:09:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 39AF943D5F;
 Wed,  9 Sep 2026 01:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F031F00A3A;
 Wed,  9 Sep 2026 01:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788916151;
 bh=6ohbYelpQ0LkGpwAo04dFsXvnvvu80H8rrh5WfYpcqM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Xd7QWK6tM+zho8WfKdHsFM7SIV7BB4JdHSmZjisD8imEpUleEeBOMgaaJ40OyTSup
 OAKYQmR4Q+4FeVuulTNT9V1VM9tDbXtWcW4qtikV6+zTd8auYiDLXOmjcKWt7DucM1
 XKTAm8nCyI6RgXUr4bVNAs2+IL1wNkjJkEZKRtRoLzchtoMqI0FznvHmBdVo1yTbNj
 3PUiWrereceHUHl1vnz0cqbS7c7ZMW+zUTKliDzhqaQNLgAapPIfJRUPA0vKCNvJFh
 39qW4MkgMhR8UqIP3bq4TlvJjEkENK1s3O0AFODlGie202yNoMgf7ZyvO2x1OZguZ8
 ymm6WCW3P5MzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 37/39] dyndbg: add epilogue to dynamic_debug/control
 file
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260908-dd-cmap-part2-clean-v9-37-3a3f621f4a10@gmail.com>
References: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
 <20260908-dd-cmap-part2-clean-v9-37-3a3f621f4a10@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 01:09:10 +0000
Message-Id: <20260909010910.E5F031F00A3A@smtp.kernel.org>
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
- [Medium] ddebug_proc_start() incorrectly returns NULL instead of EPILOGUE=
_TOKEN when seeking directly to the epilogue, permanently dropping the epil=
ogue across read boundaries.
--

commit 8d7d04473261000fac111cefcff6378b277391c2
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: add epilogue to dynamic_debug/control file

This commit adds an epilogue token to the dynamic_debug control file
seq_operations to allow displaying statistics after iterating through all
debug entries.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index afde13a2121fe..77976e7b264ca 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
[ ... ]
> @@ -1174,7 +1177,9 @@ static void *ddebug_proc_start(struct seq_file *m, =
loff_t *pos)
>  	dp =3D ddebug_iter_first(iter);
>  	while (dp !=3D NULL && --n > 0)
>  		dp =3D ddebug_iter_next(iter);
> -	return dp;
> +	if (dp)
> +		return dp;
> +	return n =3D=3D 0 ? EPILOGUE_TOKEN : NULL;
>  }

[Severity: Medium]
When a seq_file read boundary happens to fall exactly on the epilogue token,
will this condition cause the epilogue to be permanently dropped?

If ddebug_proc_start() is called with pos pointing precisely to the epilogu=
e,
the preceding while loop short-circuits when dp becomes NULL. Because of th=
is
short-circuit, the final --n > 0 check is never evaluated, leaving n at=20
exactly 1, not 0.

As a result, checking n =3D=3D 0 evaluates to false, causing the function to
return NULL (EOF) instead of EPILOGUE_TOKEN, which drops the epilogue from
the output. Would accounting for this short-circuit prevent the missing
epilogue across read boundaries?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-dd-cmap-pa=
rt2-clean-v9-0-3a3f621f4a10@gmail.com?part=3D37
