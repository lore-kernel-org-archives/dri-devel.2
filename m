Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0237C624DB
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:27:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFD0010E3C0;
	Sat,  5 Sep 2026 18:27:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W1uY4Czx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F86310E3C0
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 18:27:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4B552601FB;
 Sat,  5 Sep 2026 18:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60E51F00A3A;
 Sat,  5 Sep 2026 18:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788632852;
 bh=Xp0kplDdhzxWwvCIQGaWxozFuvSQldF+jSBnW9K3rKU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W1uY4CzxQyW/qY618oAVlakJBf9/4wNJTVnPXhjUYPYbE2TYLYgxea78eJX9vBHcX
 wJJxrUTcR6TbtIFuzcDlAXcDL/0hMc4dWV0Vc3FbujG0E6NfK+JaN6RTynhXf+d/yo
 SH8TMOTku9ho/PRe7SIsD/7/YBqGgiuGriMsjAKatsLnW0XYhIzBfYuebMLFGYQ/27
 rE418V6cMSt49rL+XWX+sNPG0sKRzqURRgUpQqsUEfKBMdUpkGj/uyDjTT7Ep+FvUw
 vijYkM8Y1XC7ljOgIYVGCwJiFk+SZARtRvoIjn79sGU8mfUD9Tt9Ts+DStgfXdb37L
 jN4PWplEbjJbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 43/43] selftests/dynamic_debug: Prime params module
 with +p in FT_comma_terminators
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260905-dd-cmap-part2-clean-v8-43-a4cc0674f6fd@gmail.com>
References: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
 <20260905-dd-cmap-part2-clean-v8-43-a4cc0674f6fd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:27:30 +0000
Message-Id: <20260905182731.C60E51F00A3A@smtp.kernel.org>
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
- [Medium] Replacing `module params =3D_` with `+p` removes the guarantee o=
f a clean initial state, making the test brittle and susceptible to failure=
s if run out of order or if prior tests leave a dirty state.
--

commit 6253b17c937a384cba6edea98690f6a2ac1a30bb
Author: Jim Cromie <jim.cromie@gmail.com>

selftests/dynamic_debug: Prime params module with +p in FT_comma_terminators

This commit alters the test initialization in FT_comma_terminators from cle=
aring
flags to appending the 'p' flag to avoid a zero-length diff in the next
command. It also updates the expected fingerprint for the test.

> diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/t=
ools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> index eeb5018d6f82c..d581b4e1cc80c 100755
> --- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> +++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> @@ -479,7 +479,7 @@ function FT_comma_terminators {
>  	echo "SKIP - test requires params, which is a builtin module"
>  	return
>      fi
> -    ddcmd "module params =3D_"
> +    ddcmd "module params +p"

[Severity: Medium]
Does replacing the absolute assignment =3D_ with the relative modifier +p r=
emove
the guarantee of a clean initial state for this test?

If the dynamic debug flags for kernel/params.c are not completely empty bef=
ore
FT_comma_terminators runs, +p will append p to any residual flags (resulting
in a state like pmf).

When the subsequent command (ddcmd "module,params,=3D_") clears all flags, =
the
resulting diff will include the removal of those unknown residual flags.

Will this cause a fingerprint mismatch against the expected 3dbf... string =
and
fail the test suite if tests are run out of order or if a prior test leaves=
 a
dirty state?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-dd-cmap-pa=
rt2-clean-v8-0-a4cc0674f6fd@gmail.com?part=3D43
