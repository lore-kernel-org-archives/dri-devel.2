Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AF8CC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 307C710ECFC;
	Thu, 15 Oct 2026 16:14:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9AC210ECFC
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 16:14:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 09ED160200
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 16:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B761F000C4;
 Thu, 15 Oct 2026 16:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792080878;
 bh=yWqE0A9vqRkd5H88T918LNjKTjsTy0DaQmTd7rg0Ipw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bf/YQ4DXZSoj6x1EaYGbvv3ewk2dyjnVxJ61le2RgGeqbZcK2SFeOWf3XrMrh1+T2
 ck/Ego9OGohYOvLLfRL8f4/r+WJ10w9TywIgxsxfEXdoXt1cbGC2xQesFj5Ayewawd
 0EAlXhELTCQ7RDwJMjAXw00gncm6GcpmLsrqbjEaH+sXVSKcpp014HLXcGrSxJa/+P
 swA8ybuWccQMHHMwqJvkY3c+VguuHF2/xwznicMuJ1+dsofCBpX1U2KiUbko5DgDdM
 L1n0rYQ7IJuQoJO/SD3ucrRRIG/HEv1SQcd+0nOPtM9i/3N+AY5FR1CTShRRUszJb1
 G07Q63rlbHVWg==
Message-ID: <sashiko-outbox-173153@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/28] drm/mode-config: Read out hardware state in
 drm_mode_config_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-drm-state-readout-v6-12-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
 <20261015-drm-state-readout-v6-12-6cc02cd10998@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 16:14:38 +0000
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
- [High] drm: missing state initialization fallback after successful SRO re=
adout
--

commit 82595be49b2239429ccad442f233b1b0663939a4
Author: Maxime Ripard <mripard@kernel.org>

drm/mode-config: Read out hardware state in drm_mode_config_create_state

This commit updates drm_mode_config_create_initial_state() to populate
initial state from hardware using the atomic_sro_readout_state hook when
available, falling back to creating a pristine state otherwise.

> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode=
_config.c
> index 48a56f23dadbb..80d3fc511db5a 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c

[ ... ]

> +int drm_mode_config_create_initial_state(struct drm_device *dev)
> +{
> +	int ret;
> +
> +	if (dev->mode_config.funcs->atomic_sro_readout_state) {
> +		ret =3D dev->mode_config.funcs->atomic_sro_readout_state(dev);
> +		if (!ret)
> +			return 0;

[Severity: High]
Does this early return bypass fallback state creation for objects not
handled by the SRO readout?

If atomic_sro_readout_state() succeeds and returns 0, the function returns
immediately and skips the subsequent call to drm_mode_config_create_state().

Any registered KMS objects that aren't populated by the driver's SRO
readout hook (such as drm_colorop objects or dormant planes) will be left
with a NULL state pointer. Because the DRM atomic framework strictly requir=
es
a non-NULL state for all registered objects, won't this lead to a NULL
pointer dereference when operations like drm_atomic_helper_colorop_duplicat=
e_state()
are called during the first atomic commit?

> +	}
> +
> +	return drm_mode_config_create_state(dev);
> +}
>  EXPORT_SYMBOL(drm_mode_config_create_initial_state);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-drm-state-=
readout-v6-0-6cc02cd10998@kernel.org?part=3D12
