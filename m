Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3385ACDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:52:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BD5F10EA1D;
	Tue, 23 Jun 2026 08:52:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iQ+Q+nD8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E56F310EA1D
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 08:52:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9058F407DC;
 Tue, 23 Jun 2026 08:52:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0541F000E9;
 Tue, 23 Jun 2026 08:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782204759;
 bh=SR7y9zjY2X7bKbXVXslijODaxEcMlpVezWMrHgajkak=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iQ+Q+nD8UxQv3UPm/0987yDKqlKRO6eZs8lia6xBhiEJ8LKShGQvG9WELJPzDBubT
 bSDevKIKQv4tKIhOtYsfgFOQIVaNkPeHyawRD//0OiPThQcYhugfne27eD8pw3lFQD
 Yl0Ij2/srW1U66rdHlk0kAx+or36hAzAS4/i1BbVjKgIdt3jciDlzjF0iSPQ6BwlLM
 NcCuSGS+04421meDLc92I03P25jI2KHFY8dqPv5MXAWxVYpIrcFmD29/NwsCI93+3F
 3Y5MkLhnoJiyDsxPKqI7F9M9rtuEhAvlKmLvj61y6R04GT7Zm/wF8bQMmn2X6P//DB
 5vLMED1wD2gpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/psr: Skip PSR exit for legacy cursor updates
 on LNL
To: "Aaron Ma" <aaron.ma@canonical.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260623084137.3421894-1-aaron.ma@canonical.com>
References: <20260623084137.3421894-1-aaron.ma@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 08:52:38 +0000
Message-Id: <20260623085239.5A0541F000E9@smtp.kernel.org>
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
- [Medium] Unconditionally skipping PSR flush/exit for legacy cursor update=
s reintroduces cursor trailing artifacts on pre-LNL platforms with PSR2 sel=
ective fetch.
--

commit 2fb445d4d3ce6ed075913638e7c06b17876c62bb
Author: Aaron Ma <aaron.ma@canonical.com>
drm/i915/psr: Skip PSR exit for legacy cursor updates on LNL

This commit modifies the PSR flush handler to unconditionally skip the
PSR exit path for legacy cursor updates. It removes the selective fetch
check to resolve visual artifacts during exit/re-enable transitions on LNL.

> diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i=
915/display/intel_psr.c
> index e138982dc91f6..32bee6c03b754 100644
> --- a/drivers/gpu/drm/i915/display/intel_psr.c
> +++ b/drivers/gpu/drm/i915/display/intel_psr.c
> @@ -3771,8 +3771,7 @@ void intel_psr_flush(struct intel_display *display,
>  			goto unlock;
> =20
>  		if (origin =3D=3D ORIGIN_FLIP ||
> -		    (origin =3D=3D ORIGIN_CURSOR_UPDATE &&
> -		     !intel_dp->psr.psr2_sel_fetch_enabled)) {
> +		    origin =3D=3D ORIGIN_CURSOR_UPDATE) {

[Severity: Medium]
Will unconditionally removing the !intel_dp->psr.psr2_sel_fetch_enabled
guard reintroduce cursor trailing artifacts on pre-LNL platforms?

The commit message mentions skipping PSR exit for LNL, but the change appli=
es
to all platforms.

Any legacy cursor update on pre-LNL platforms with PSR2 selective fetch
enabled will now trigger intel_legacy_cursor_update(), which issues
ORIGIN_CURSOR_UPDATE and bypasses the full-frame fallback update in
_psr_flush_handle().

Could this revert the behavior introduced in commit ef39826c12b4 for older
platforms?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623084137.3421=
894-1-aaron.ma@canonical.com?part=3D1
