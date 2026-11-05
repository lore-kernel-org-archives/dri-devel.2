Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21B6606A339
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Udth0uC0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ED8510E041;
	Thu,  5 Nov 2026 15:37:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10E3C10E041
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:37:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D612F43C6D
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B564A1F00A16
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793893061;
 bh=gTh04bL+xtfTM77EiEDyxaXv+7mzpg3XtmoRfbXmXTE=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
 b=Udth0uC0Gaapc0S3TCcUzHih3F3+sV1SPcONOctrXUB3qu7SB3VuHA/EDg9CsjLQL
 YMTlIzgNnpo5CxWxTzTAPV/vfCj15wg73gOcqBDcLK+wHlstT60dHim5B8D4bBOMbv
 06yNBrjduzKKQGehEkXG/fEBG8L4XzY8hD+8vQdNjyRbHAy2BKje8ghtQCV0u5B6Aj
 h9uLUb0zYH4jhjoGfe2O+s5K8fAAXfUfhCNJ0I59SgIqxNebOnfbXQEhSBPhXwvE+P
 ozIZ+silwerSfBTiO/0Z+H5eMzh6dAQDWJ+NUjvloD8kvNNT1IshLgP7u3zJHP2SWt
 wn9zRt93n0HBA==
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-3ab53a99771so16963101fa.3
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 07:37:41 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AKwUvBxbOXGteGipTfUoLBgOO6Wre8gF/N9ZBGcyKlRt5bm0gAHsxIM40/zvm9N1gD1g7du+SMDE+ofbkb0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+2UyBbbdyXIQxotuvPsEN8alesXj3Z40rfrFAdhjpc54EegmVE
 qoWlCRveJ4Vw1/YuX/Nr8pE5uK++fXR9yrtOOAE0w32bs6tM/bwKSa7c8RcqCt0OUU1Xl/Sl9Ef
 3exSdE9fzP5m9nO4306iHktBniZgETdQ=
X-Received: by 2002:a2e:b896:0:b0:3ac:99c3:7f82 with SMTP id
 38308e7fff4ca-3acb7a65d16mr45343871fa.5.1793893060157; Thu, 05 Nov 2026
 07:37:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-47-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-47-1f58d1e33380@kernel.org>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 5 Nov 2026 23:37:28 +0800
X-Gmail-Original-Message-ID: <CAGb2v64E811JwNT9=eE4DNycrfaV8=U8B5KFOZY-uACVijAOKw@mail.gmail.com>
X-Gm-Features: AclHuK_jjhDmTWb9gl1wRXLLCbElNt6bPu9l2mBBzKY1pQfiuv-NjU8F7dbiWi4
Message-ID: <CAGb2v64E811JwNT9=eE4DNycrfaV8=U8B5KFOZY-uACVijAOKw@mail.gmail.com>
Subject: Re: [PATCH RESEND 47/83] drm/sun4i: Switch to
 drm_mode_config_create_initial_state
To: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: wens@kernel.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 11:33=E2=80=AFPM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> drm_mode_config_reset() has a dual role: it creates the initial KMS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles.
>
> Since the two roles need different behaviors (notably for objects like
> drm_private_obj that must persist across suspend/resume),
> drm_mode_config_create_initial_state() was introduced to handle only
> the initial state creation at probe time.
>
> Switch to drm_mode_config_create_initial_state().
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Acked-by: Chen-Yu Tsai <wens@kernel.org>
