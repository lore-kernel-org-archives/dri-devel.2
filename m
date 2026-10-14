Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCBFC3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4E4610EA88;
	Wed, 14 Oct 2026 18:08:29 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76BF910EA88
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 18:08:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2CAEF414C0
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 18:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9301F000C5;
 Wed, 14 Oct 2026 18:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792001303;
 bh=aORF5Paq9pA6RqT6h54XsidXEbg1AOyu/T8W7o94gsU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LNCQPmGn0I3kuQlWMfqj5c+CVQO5VjBo4F1oIFB74bLbYIGh88mvEeZTsIJ+NbrOz
 mHC6KgNSfL8eQzPTaTOalVnbUTegI1b9VpbhHKFI5YdKcBbltHz29UqbV/RO2AC4sY
 pws18GnNSjW9a1yi8vVzHtN+OknR3boFrjlQ9ADVcBb5xZNMmOntJ8fdHm3K/lF73Q
 YSC3MEORSwKYll0O+ZgeCIkdCI/xlO2tPtM7vGKgZPB4g2Qmpw6S7m5G+Jb5aG7xrT
 EXVZWSpyVk7HoaaQbrPEB8Ob5PW20l0phOKt3z0X2gi5NsM4+f5++fbuh3CGmYJnqZ
 nV20hNl7Yk76g==
Message-ID: <sashiko-outbox-171662@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 61/75] drm/sun4i: tv: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-61-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-61-586c9c026823@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 18:08:22 +0000
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
- [High] drm: NULL pointer dereference when initializing TV connector state
--

commit a85a6a0ad13c063d072cdcda87267ea8867cafa3
Author: Maxime Ripard <mripard@kernel.org>

drm/sun4i: tv: Convert to atomic_create_state

The sun4i TV connector reset implementation is converted to an
atomic_create_state hook. It creates the pristine state and initializes
the analog TV properties.

> diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun=
4i_tv.c
> index ea86f8a6a35e7..a68e5f7a03d2c 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
[ ... ]
> -static void sun4i_tv_connector_reset(struct drm_connector *connector)
> +static struct drm_connector_state *
> +sun4i_tv_connector_create_state(struct drm_connector *connector)
>  {
> -	drm_atomic_helper_connector_reset(connector);
> -	drm_atomic_helper_connector_tv_state_init(connector->state, connector);
> +	struct drm_connector_state *connector_state;
> +
> +	connector_state =3D drm_atomic_helper_connector_create_state(connector);
> +	if (IS_ERR(connector_state))
> +		return connector_state;
> +
> +	drm_atomic_helper_connector_tv_state_init(connector_state, connector);

[Severity: High]
Does this trigger a NULL pointer dereference during initialization?

When the DRM core resets the connector state, it explicitly clears the old
state before invoking the .atomic_create_state hook:

drm_mode_config_connector_reset_with_create_state() {
        ...
        if (connector->state) {
                ...
                connector->state =3D NULL;
        }
        return drm_mode_config_connector_create_state(connector);
}

The core helper drm_atomic_helper_connector_tv_state_init() then mistakenly
passes the unassigned connector->state down to the margins initialization
instead of the newly allocated state:

drm_atomic_helper_connector_tv_state_init() {
        ...
        drm_atomic_helper_connector_tv_margins_state_init(connector->state,
                                                          connector);
}

This causes drm_atomic_helper_connector_tv_margins_state_init() to
unconditionally dereference the NULL state pointer:

drm_atomic_helper_connector_tv_margins_state_init(state, ...) {
        ...
        state->tv.margins.left =3D cmdline->tv_margins.left;
        ...
}

The previous .reset hook implementation masked this core helper bug because
it assigned connector->state prior to calling the TV state initialization
helper.

Could we fix the core helper to pass the correct state pointer, or should
this driver handle the initialization differently to avoid the crash?

> +
> +	return connector_state;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-drm-no-mor=
e-connector-reset-v1-0-586c9c026823@kernel.org?part=3D61
