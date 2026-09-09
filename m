Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6222C79F82
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 01:13:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24EF610EE45;
	Wed,  9 Sep 2026 01:13:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Hgc6qOo/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6B9E10EE45
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 01:13:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6C1544131D;
 Wed,  9 Sep 2026 01:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233FE1F00A3A;
 Wed,  9 Sep 2026 01:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788916410;
 bh=9HlxQvjuct+JtCobiJ7NsGHeoLVT0QEcYijnXw6yfnQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Hgc6qOo/6Es/j/C/I3S14MRrV5tzwpycEyhX0fdDKDOIV1cvS5ZqQbai/wpHb34KY
 ibfbfWWFwNishp+RhR4FZ8XJKfSNPn1sFPXOvMUBkASoAbIRkQKbOS0HnZMCd7oTVh
 aGmKUzyqN5H16j7nRqom0Kcll7yxLcPBYdQ14yF9OeNgGXR5kxlc7W2ZadMamwK8ME
 09Okzgiji1pNZCgBBcs4T+MmcYhFJUFj1zjmWzfccfMgTTk8J9txhqz9LLCgAl26Kw
 S7ZjW+oT08J3WVB/y73UYoOR17/8Z6QazvP74/6DwLuMDDC5wYjJ9CkkZlwx5frMD3
 MMfufHW6I3IPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 34/39] dyndbg: harden classmap and descriptor validation
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260908-dd-cmap-part2-clean-v9-34-3a3f621f4a10@gmail.com>
References: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
 <20260908-dd-cmap-part2-clean-v9-34-3a3f621f4a10@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 01:13:29 +0000
Message-Id: <20260909011330.233FE1F00A3A@smtp.kernel.org>
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
- [Medium] Missing implementation: The commit message claims to add a `stat=
ic_assert` to `DYNAMIC_DEBUG_CLASSMAP_USE_`, but this change is entirely ab=
sent from the patch diff.
--

commit 9e868ca8748038075020ceae45f58600f28f51b4
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: harden classmap and descriptor validation

This commit improves dynamic debug classmap and descriptor validation by
adding run-time overlap checks for used classmaps and scanning module
descriptors at load time to warn about missing class IDs. It also adjusts
the reporting of unknown class IDs.

>     - Mirror the compile-time limits of _DEFINE by adding a static_assert
>       to validate the _offset value passed to DYNAMIC_DEBUG_CLASSMAP_USE_.

[Severity: Medium]
The commit message explicitly claims this patch mirrors compile-time limits=
 by
adding a static_assert for the _offset passed to DYNAMIC_DEBUG_CLASSMAP_USE=
_.
However, this change to include/linux/dynamic_debug.h is entirely missing f=
rom
the patch diff.

It appears this change may have been introduced in an earlier patch in the
series (commit ed72477b68f823). Should the commit message be updated to rem=
ove
this bullet point and avoid confusion?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-dd-cmap-pa=
rt2-clean-v9-0-3a3f621f4a10@gmail.com?part=3D34
