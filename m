Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D43C79FA1
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 01:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55E2110EE34;
	Wed,  9 Sep 2026 01:07:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mEuQcFjO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CF5810EE34
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 01:07:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F015340356;
 Wed,  9 Sep 2026 01:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83F51F00A3A;
 Wed,  9 Sep 2026 01:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788916068;
 bh=PbW6JJQAx/8sq8Ngo/d/2vyCHiCgJ2e9HGLMONHrgPs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mEuQcFjO4ZP+IDmOBpYBGbbaK+PFiWx6cOwjXoRhGkHjwQEmS+v0MawVaHq38Q5G/
 IBSNKYAmADPYqWNooXq/WGOLMpXDcTWvhpKXASF83Nul4BC3/sXHMdXZZscs/fGzc3
 z0cYC1+bFt6dTslab3z1EM+GhYXRQfkXMjkEnVqDE8oPLI4Qz9KJ2eEPEd8Ip3zuZM
 uTLyDVgk5hwGVYyFE7KUTG6fL1v2glLUfTry9PIa30wNXPp22naiqL4cbxBK5TEaHU
 58T9Y3cEaCGipYEc419ExkJouBg7Jfef0J35B1xD1HxeMKAM2R0Y4nT3n8oNGBRIXs
 vBZraU22ABssQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 27/39] dyndbg: check
 DYNAMIC_DEBUG_CLASSMAP_{DEFINE,USE_} args at compile-time
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-dd-cmap-part2-clean-v9-27-3a3f621f4a10@gmail.com>
References: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
 <20260908-dd-cmap-part2-clean-v9-27-3a3f621f4a10@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 01:07:48 +0000
Message-Id: <20260909010748.A83F51F00A3A@smtp.kernel.org>
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
- [Low] Typo in the commit message regarding the test macro `DD_MACRO_ARGCH=
ECK`.
--

commit f1639b2e981e61be970216e485857e63c7d27ba2
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: check DYNAMIC_DEBUG_CLASSMAP_{DEFINE,USE_} args at compile-time

This commit adds compile-time checks for dynamic debug classmap macros to
prevent simple misuses. It validates base ranges, array sizes, and map type=
s,
issuing obvious errors during compilation if violated.

> Several bad examples are ifdef DDD_MACRO_ARGCHECK qualified in
> test_dynamic_debug_submod.c and will fail compilation if enabled.

[Severity: Low]
This isn't a bug, but is there a typo in the commit message here?

The code in lib/test_dynamic_debug.c actually checks for DD_MACRO_ARGCHECK
instead of DDD_MACRO_ARGCHECK.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-dd-cmap-pa=
rt2-clean-v9-0-3a3f621f4a10@gmail.com?part=3D27
