Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1F5606A32E
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CspEEKjA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD8E310F525;
	Fri,  6 Nov 2026 13:16:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E2E210EE4D
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:16:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0939B4236A
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:16:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21C21F008A4
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793970977;
 bh=OHv8wBQR1sl+/gEsacIETCLjNGFE0bEZB+I80oi6Of4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=CspEEKjAFDT31ihmOVN1rGF/l9Cw2cD2kQzcL6UdVDi795w9LvytmgT5bPKv1Iicu
 6c78LEbS6X9GO3+i5Nv6SMXgMnBV+TTUpImwrYgq64FKpDqgJP52kyRxCox0NMZLWe
 zwMXwjAPd5IJJm2EkAD8TKeQMKKIPU/NyPSgf7RCV3QtuXVdmLH2gRU7KIZSFBkQzc
 +/yLjxZvB766m39rQUL/1CUpU9xGgcFFX55U5Pcv9HZ4EFoy7LjvktVLoJQBtEPPE8
 D0kW8JhBiKf7ieiy9+nFzGjcSYzaviVFRA1Kf77l6a07HspIf17QpaxWanv2cb6f69
 gKnRLeX3e3yGw==
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-5be3ea5a7adso480996e87.2
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 05:16:17 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AKwUvBx12FnQDwvMrwNS4bWEQNWTocb3wcZJkZ4qr6z1GpSvurlDTO2ycnkvJGlx3QDV8P+jHcNuzA1Nt/M=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8NHMeguB8CdQk/idfjUjM+jRZ/x1J2YfMzqi4e7E3fLwyCQgD1
 sKbQ0EUSKYXkiScMBYMqE0ewA4HvtxZglf7+Tps7X8FutzQi4OZIkTgI/iG4oKcvFzBjOpsBCUV
 vNX0PibnVDDmiYzwHIzUWxaYPSEcG3LQ=
X-Received: by 2002:a05:6512:6603:b0:5c0:8dc:f2ed with SMTP id
 2adb3069b0e04-5c008dcf55cmr224183e87.18.1793970976663; Fri, 06 Nov 2026
 05:16:16 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-74-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-74-1f58d1e33380@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 6 Nov 2026 14:16:03 +0100
X-Gmail-Original-Message-ID: <CAD++jLmzyjqELsFmasdMJ0wauoQcEctC19NVOiFCNK=YNEcruA@mail.gmail.com>
X-Gm-Features: AclHuK_tutAcYOahM8ZImdda5qXNlbb60wyUx-HYZYIQe1ykl0gAvp-tr9oTDUE
Message-ID: <CAD++jLmzyjqELsFmasdMJ0wauoQcEctC19NVOiFCNK=YNEcruA@mail.gmail.com>
Subject: Re: [PATCH RESEND 74/83] drm/tve200: Switch to
 drm_mode_config_create_initial_state
To: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 4:34=E2=80=AFPM Maxime Ripard <mripard@kernel.org> w=
rote:

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

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
