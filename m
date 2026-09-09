Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA2AC79F82
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 01:03:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBE9210EE33;
	Wed,  9 Sep 2026 01:03:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PBRacGqX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 488E910EE35
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 01:03:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5F857601FB;
 Wed,  9 Sep 2026 01:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03411F00A3A;
 Wed,  9 Sep 2026 01:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788915816;
 bh=sC3v78wFfTmV4KNIA9iqq8HzsBIRQD+k+bkPhvg8uv0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PBRacGqXhVZpODoY5KfYqdmU9/OPaWcp8Nwpq13iXLUm1q5RkPYGpb1Onuo4z/1lQ
 Ov/I9ohlsRhkSSe+Ir4sf1PqsGyWrW29VSg3HgOX6nk/LoUDuFD9z0NeRY7yEZInRm
 v23Q478upEtrFIN5PyQUTtKyenRfiBuwrbktjmTKUDtFritPU2eHVXyJkDKf2HWrq3
 vIG2eww7cMLRbRgNwFgmG+KFSZSfej9ztmOUL4wTJi8p8I2l6Yyvsy69y3PNet9ZiR
 0r/ZBe0HVuypIDxN7wAZ1BrbwiU7x5e/67ca2zvfLm31uGBCsqfff5/dW2qO2mvqbE
 AcT10SHnEbBKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 07/39] dyndbg: factor ddebug_match_desc out from
 ddebug_change
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260908-dd-cmap-part2-clean-v9-7-3a3f621f4a10@gmail.com>
References: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
 <20260908-dd-cmap-part2-clean-v9-7-3a3f621f4a10@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 01:03:35 +0000
Message-Id: <20260909010335.E03411F00A3A@smtp.kernel.org>
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
- [Medium] Incomplete check for NULL `dp->format` bypasses the intended pro=
tection when `query->format` is NULL.
--

commit 6e852d37b2302458d6d8e267b4a7058839bebf01
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: factor ddebug_match_desc out from ddebug_change

This commit factors out the descriptor matching logic from ddebug_change() =
into
a new ddebug_match_desc() boolean function. It replaces inner loop continue
statements with return false to simplify the logic, and elevates a check for
a NULL format string to report an error and skip the descriptor.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 49334d1aa4b3a..46ef31328194e 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
[ ... ]
> @@ -172,6 +172,59 @@ static struct ddebug_class_map *ddebug_find_valid_cl=
ass(struct ddebug_table cons
[ ... ]
> +	/* match against the format */
> +	if (query->format) {
> +		if (!dp->format) {
> +			pr_err_ratelimited("ddebug: NULL format string at %s:%s:%u\n",
> +					   dp->filename ? dp->filename : "?",
> +					   dp->function ? dp->function : "?",
> +					   dp->lineno);
> +			return false;
> +		}

[Severity: Medium]
Does nesting the !dp->format check inside if (query->format) bypass the
intended protection when a query does not filter by format?

If a user issues a query without a format filter (for example,
echo 'module * +p' > control), query->format is NULL. This skips the
evaluation of the inner check entirely.

Can this allow a malformed descriptor to be enabled, leading to the kernel
crashing later in __dynamic_pr_debug() when the missing format is executed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-dd-cmap-pa=
rt2-clean-v9-0-3a3f621f4a10@gmail.com?part=3D7
