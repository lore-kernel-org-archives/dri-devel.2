Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFA1C98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 05:46:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC36310EF07;
	Wed, 23 Sep 2026 05:46:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C7Ajeow1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2536E10EF07
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 05:46:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 42C99600AA;
 Wed, 23 Sep 2026 05:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB42D1F000FF;
 Wed, 23 Sep 2026 05:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790142381;
 bh=yqBptwhhgVgrXy6TPoP9Mz2Gk0XvfaDhSoqOArwMJ2I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=C7Ajeow1c8XbgnZP7xRJpXLk3V5jOHUvzDFNlWRdlY2yYANhbx6w2E+0HMusObBT6
 ZmeOwscLudxJZyOaZsB5+Vzx6RXHfnOoWV4X+Ebe308O553gLs1zx3PXjRDRjn/jZ7
 YORiNMSD2SfsHm2DoDrloqa588VOa4UsksNxKabvqnIcoLfxKKFt5ITaNVe5EWdzy0
 WST5vjnVkVSG8TBG1UmPSNcoXJQ3iez8c4ihbzBjJvyHqwgdEiYFeWoqwl/mv9K/w/
 p4bLDodPNTCQ33kq9gFId84ys3YdQbhOwYKHMZVQs5bPy80TE6/wBuJRPiZcjAGtEk
 gACnrClMVNuXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu/pm/powerplay: factor voltage index bounds
 check into a macro
To: yaolu@kylinos.cn
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260923054111.209370-1-yaolu@kylinos.cn>
References: <20260923054111.209370-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 05:46:20 +0000
Message-Id: <20260923054620.CB42D1F000FF@smtp.kernel.org>
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
- [Low] commit message: macro name mismatch PP_CHECK_VOLTAGE_INDEX vs PP_VO=
LTAGE_INDEX_OOB
--

commit 3d5448c38d3504f9987ca03ae0f6fc0dcde24233
Author: Lu Yao <yaolu@kylinos.cn>

drm/amdgpu/pm/powerplay: factor voltage index bounds check into a macro

This commit refactors duplicate voltage index bounds checking from SMU7 and
Vega10 implementations into a common macro.

>     Move the pattern into PP_CHECK_VOLTAGE_INDEX().

[Severity: Low]
This isn't a bug, but the commit message mentions moving the pattern into
PP_CHECK_VOLTAGE_INDEX(), while the code actually defines the macro as
PP_VOLTAGE_INDEX_OOB in drivers/gpu/drm/amd/pm/powerplay/inc/pp_debug.h at
line 58. Could the commit message be updated to reflect the actual macro
name?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923054111.2093=
70-1-yaolu@kylinos.cn?part=3D1
