Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7B0C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:26:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 731BD10E337;
	Mon,  6 Jul 2026 11:26:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J7t72HIJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C1ED10E337
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 11:26:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B0868600BB;
 Mon,  6 Jul 2026 11:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460E81F000E9;
 Mon,  6 Jul 2026 11:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783337171;
 bh=CfG1Zwk+8GITkcZ6x/xOxirD203HEk40ijAtP/aHZ5w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J7t72HIJgCkXSCVZCIw3V9o1KnBOuLMcOJWb8dfY+N7qASi78kPsaZlLQ6O2Dg0aK
 YvwYhyfziAKBGC0GvKzZ2+J6pAV0G9QfzwRjvdO3S6n27D9XF2UQAm0kweizf37glW
 Qg/GcM8627jlrFQEPkOx6ODXcgiuueV19ycGnNUdmoMLkQKIaBQQfVaKK8SuaLLO+W
 AavC8o/IjMtwKnVlX2lmcpdny2u2scEQlQxXAIHnSxFk5ku5oNdii7WzdRs1dFqHJl
 /zi5M6Ngqm1qg9rNxmFtdM7PnY07w042dwsdHmq0eRri20kVdGIvqWKR0UTn3SBSND
 z3jNoI3zgFC9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/guc: Sort multi-lrc engines by logical instance
To: "Linmao Li" <lilinmao@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706111328.618675-1-lilinmao@kylinos.cn>
References: <20260706111328.618675-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 11:26:10 +0000
Message-Id: <20260706112611.460E81F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] On failure to allocate a child request in multi_lrc_nop_reques=
t(), the already-submitted parent request (and possibly some child requests=
) are abandoned without waiting for them to complete. This leads to a Use-A=
fter-Free when the parent context is unpinned and freed by the caller.
--

commit 5b7b11cc22424a0209d44bac64a471f684e9959f
Author: Linmao Li <lilinmao@kylinos.cn>

drm/i915/guc: Sort multi-lrc engines by logical instance
   =20
This commit replaces a custom logical sorting loop with the standard sort()
function for multi-lrc engines. This fixes potential out-of-bounds stack
accesses and corrects the sorting logic to copy pointers rather than the
engine structure data.

> diff --git a/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c b/driver=
s/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c
> index 28e8a092f4e7d..b56768d202b06 100644
> --- a/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c
> +++ b/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c

[ ... ]

While reviewing this code, I noticed a pre-existing issue in the same file:

drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c:multi_lrc_nop_request()
> 		child_rq =3D intel_context_create_request(child);
> 		if (IS_ERR(child_rq))
> 			goto child_error;

[Severity: Critical]
This is a pre-existing issue, but does this error path leave earlier parent
or child requests in flight without waiting for them to complete?

If so, when the caller __intel_guc_multi_lrc_basic() receives this error:

drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c:__intel_guc_multi_lrc_b=
asic()
> out:
> 	multi_lrc_context_unpin(parent);
> 	multi_lrc_context_put(parent);

Could this lead to a use-after-free? The caller forces the unpin and drops
the final creation reference to the context while the stranded in-flight
requests still hold dangling pointers to it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706111328.6186=
75-1-lilinmao@kylinos.cn?part=3D1
