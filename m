Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81933C982CC
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3EE110E050;
	Wed, 16 Sep 2026 15:47:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KORdjHVe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FC1010E050
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 15:47:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EEAAF602CB;
 Wed, 16 Sep 2026 15:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773B31F000FF;
 Wed, 16 Sep 2026 15:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789573623;
 bh=Mx/WdcnA9WUEs1IOuBH8MMQKjCutHAhuRSPiR/QCDG0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KORdjHVeZS85a9QsDJtgywzaolW56TBjQbU8ODrI5WJw/efsNmmpv6WI9IKHH6Cn0
 C8zH9RHpKg+KD3aw5HL0zg5dFnUJLxENDjUwVwasUTC0cfhh1LQFzvcDuaA/vJpMAk
 RjekycoxblGBtYG0zJpPsUpxjIyjw7nT9i41AZxPgEXaPNp7ZDLl1llVXVaBeDS9n4
 32onC30tuvMqJ47M1IxteMaZCJcbDFukycY2zVSd0JnfsaS6nyOFe1vBMvbIeHzXo2
 p+/wI1O4/WtELcJuH77r7J3JFqJgklJobjtNy52ZuwPUEMHQDsIggMgwjwSmGolKG1
 SHel84/+F4snA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 07/38] dyndbg: factor ddebug_match_desc out from
 ddebug_change
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260916-dd-cmap-part2-clean-v10-7-af4cf4767707@gmail.com>
References: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
 <20260916-dd-cmap-part2-clean-v10-7-af4cf4767707@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 15:47:02 +0000
Message-Id: <20260916154703.773B31F000FF@smtp.kernel.org>
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
- [Low] dyndbg: orphaned comment for ddebug_change applied to ddebug_match_=
desc
--

commit 09e57b269ce55ff151c63cc7e5d0dc659c6f52d5
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: factor ddebug_match_desc out from ddebug_change

This commit factors out the per-descriptor matching logic from
ddebug_change into a new boolean function, ddebug_match_desc,
to simplify the inner loop.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 49334d1aa4b3a..5187516c57a93 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -172,6 +172,60 @@ static struct ddebug_class_map *ddebug_find_valid_cl=
ass(struct ddebug_table cons
>   * callsites, normally the same as number of changes.  If verbose,
>   * logs the changes.  Takes ddebug_lock.
>   */
> +static bool ddebug_match_desc(const struct ddebug_query *query,
> +			      struct _ddebug *dp,
> +			      int valid_class)

[Severity: Low]
Does this placement separate the block comment from its intended target?

The comment describes a function that returns the number of matching callsi=
tes
and takes ddebug_lock, which accurately describes ddebug_change().

However, by inserting ddebug_match_desc() immediately after this comment,
does it leave ddebug_change() undocumented and make the comment falsely app=
ly
to ddebug_match_desc() (which returns a bool and takes no locks)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-dd-cmap-pa=
rt2-clean-v10-0-af4cf4767707@gmail.com?part=3D7
