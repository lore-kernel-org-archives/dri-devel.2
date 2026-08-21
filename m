Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478BFC5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 418D610F32D;
	Fri, 21 Aug 2026 15:41:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EkSc2oWF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 463EF89130
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:41:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1BB5A4358F
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40521F000E9;
 Fri, 21 Aug 2026 15:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787326884;
 bh=VP3tZtY2JYmLtx1C/6MGSj2ZN/QY609h8APIkNMHUp0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EkSc2oWF/fd9qlemazZTr5OnFld5zNXtNS0L/kuE6gafZKYLGyiunfUlh2rXsRwul
 OQT2iiFtwjQftFwcHYqOsj3E2wuHYm+8MOERXCWdB1rWSAfcYFwsxnS0yBWkEICPtV
 GUBTbQ8cCCoX0tNbICsM9mga7Imv0YOhWs/oljhWZg+xC2+fMxI2lL5YDgIcvs+/ot
 Cmo2e27FVmyEsixmaPWmJ4hUKTda8SD5A2nqHL7KIWMY1MmNKFwqg0ipJ6Tr0jstUr
 j9sgTxhO3O55PXsHCBEznrnd/N6u93lmUt0DkXllRREicnA6dn/EVgdeqOYwfe3cC4
 YP+1jfo+81cjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 63/70] drm/sitronix: st7920: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-63-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-63-fb793475c05a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 15:41:23 +0000
Message-Id: <20260821154123.D40521F000E9@smtp.kernel.org>
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
- [Medium] The commit message falsely claims that the old `st7920_crtc_rese=
t` freed the previous state.
--

--- Patch [63]: [PATCH 63/70] drm/sitronix: st7920: Convert to atomic_creat=
e_state ---
commit 51126b7e2261e0176cf52ba6e5a5273dcbb0592e
Author: Maxime Ripard <mripard@kernel.org>
drm/sitronix: st7920: Convert to atomic_create_state

This commit converts the st7920 CRTC implementation to use the
atomic_create_state hook rather than a custom reset hook.

> The st7920 crtc implementation provides a custom reset hook. However,
> this hook only allocates the state, initializes it with
> __drm_atomic_helper_crtc_reset(), and frees the previous state. It
> does not perform any hardware reset.

[Severity: Medium]
Is this description accurate regarding the previous state being freed?

Looking at the original st7920_crtc_reset() implementation before this
patch, it warns if crtc->state is non-NULL but does not appear to free
the old state memory:

	drm_WARN_ON_ONCE(crtc->dev, crtc->state);

	st7920_state =3D kzalloc_obj(*st7920_state);
	if (!st7920_state)
		return;

	__drm_atomic_helper_crtc_reset(crtc, &st7920_state->base);

Could the commit message be updated to clarify that the old hook was not
actually freeing the previous state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-drm-no-mor=
e-crtc-reset-v1-0-fb793475c05a@kernel.org?part=3D63
