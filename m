Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0C1C4452D
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 21:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 013EF10E1D3;
	Tue, 21 Jul 2026 21:05:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JE+2F3s/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D16BC10E1D3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 21:05:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 590D5408F6;
 Tue, 21 Jul 2026 21:05:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062481F00A3A;
 Tue, 21 Jul 2026 21:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784667925;
 bh=UtEUVdcGTMDMgqAOtacQGh7LJpl8Y9P25RZ5RnxNrP4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JE+2F3s/JM4FdsiA0gFN0pS3/iUcdhgqxVsoioBG/VrLp27Etown1UCoGp1gmhKmF
 /tIN1NVMZBAos68ZFInOx/g7dmcpWlYVm0LNR9TFW8KQaterVwO+yh2mtq6v6b+Yng
 XflVdbXJv1v6EZYpkbk4Hxk+HfinGLy88TZhOKin8/yhz1TaNvQoQuCdxSNrl6EwiZ
 V99oHakVYzOd3iOGjATHM+ihd/6OfqXYry1T22jfPujzSetYFtXWwNBt4sswMnd84b
 ED7um8mgUw87IumqOhWu4aey+no7r+Y98EKEjO7RRaBgI5z5IiUYkPi1fm7fRIROok
 r4B8gTTMP4Tzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/29] dyndbg: factor ddebug_match_desc out from
 ddebug_change
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260721-dd-maint-2-v7-11-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
 <20260721-dd-maint-2-v7-11-010fbe73b311@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 21:05:23 +0000
Message-Id: <20260721210525.062481F00A3A@smtp.kernel.org>
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
- [Medium] The newly added NULL format check uses an un-ratelimited, contex=
t-free `pr_info()` inside a globally locked inner loop.
--

--- Patch [11]: [PATCH v7 11/29] dyndbg: factor ddebug_match_desc out from =
ddebug_change ---
commit 47cab4604933a3e3a136a1d101a11ae69fe36598
Author: Jim Cromie <jim.cromie@gmail.com>
Subject: dyndbg: factor ddebug_match_desc out from ddebug_change

This commit factors out the per-descriptor filtering logic from the inner l=
oop
of ddebug_change() into a separate boolean function, ddebug_match_desc(). It
also introduces a check to prevent operating on debug descriptors with a NU=
LL
format string.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 18a71a9108d3e..577a079160727 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
[ ... ]
> @@ -172,6 +172,56 @@ static struct ddebug_class_map *ddebug_find_valid_cl=
ass(struct ddebug_table cons
>   * callsites, normally the same as number of changes.  If verbose,
>   * logs the changes.  Takes ddebug_lock.
>   */
> +static bool ddebug_match_desc(const struct ddebug_query *query,
> +			      struct _ddebug *dp,
> +			      int valid_class)
> +{
[ ... ]
> +	/* match against the format */
> +	if (query->format) {
> +		if (!dp->format) {
> +			pr_info("encountered a NULL format\n");

[Severity: Medium]
Could this un-ratelimited pr_info() spam the kernel log?=20

Since ddebug_match_desc() is executed inside a nested loop holding
ddebug_lock, if there is a malformed descriptor in the system, querying the
format via debugfs could trigger this message repeatedly on every format
query.

Additionally, because the message lacks context, it doesn't provide clues
to help identify which callsite is missing the format string. Would it be
better to include details like dp->filename, dp->function, or dp->lineno
here, and perhaps use pr_info_once() or pr_warn_ratelimited() to avoid
log flooding?

> +			return false;
> +		}
> +		if (*query->format =3D=3D '^') {
> +			char *p;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-dd-maint-2=
-v7-0-010fbe73b311@gmail.com?part=3D11
