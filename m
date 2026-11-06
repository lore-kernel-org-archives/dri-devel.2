Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B2A606A329
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6Q0r7hl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A228210EA85;
	Fri,  6 Nov 2026 13:15:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63F2110EA20
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:15:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DB795609F5
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960401F008A2
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793970941;
 bh=PH+V+UUTFtmAFGfpboIZDmCpwyqIyHQilX8b/TmtTVY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=n6Q0r7hl8yF8V8oEXe412uVMO5DXETWVXnge4l/oK7KeJIN4qrJnSs4ECKmBf7iUZ
 vtt4cosHCrCTYcy1qk/UdQKHIXGgMnmHH0orIdxyclTrA6w6X9s844NPHg6XFa1Ke/
 MmEwyg/fvS6DAbv6hPSWfUjpr96ZUFItNlPwYFawkuMbOq+myP8NQvgxjOvZgmzo3O
 8dqDb3xyWxdfWdXsQhMx+Wnv3uWY95U4eRA1D2d1M+aI4YzKinE/jenU2A8zv4Wvms
 BAf9bccmFm/rAg1xVyIfuZByN8H16Po5JrcItRMepfGfJxanJjIn08RULvoucHBqjE
 ViBMM/Kp6dMuw==
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5bcdae234ecso478630e87.3
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 05:15:41 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AKwUvBw0azqQPDVsBxpvrzDk7dtGe+sX0xX0kJ/7uy39FJoUdxjrkyGkvrtYBFsiLT1LVAEwmvgNUhxw3Ck=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8zmenGhe/cSOB3htKq2b53Z6qPjgb/LCfi4OWnl/2XvqRXC36Y
 /koAs4Wpc8sTAz8axD5MH5bcfqtRZdbQMthrE/CW1m5vvYeImA9AxYxKV7rLbVotUwlB1+ZAzgs
 3OpG7GFp+qomIHAfaNsKhSYhWeev0/bc=
X-Received: by 2002:a05:6512:1315:b0:5bf:b952:e57f with SMTP id
 2adb3069b0e04-5c003ad5782mr844789e87.59.1793970940404; Fri, 06 Nov 2026
 05:15:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-24-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-24-1f58d1e33380@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 6 Nov 2026 14:15:26 +0100
X-Gmail-Original-Message-ID: <CAD++jLm7RfccF5cCTSmjWBwT+cWHEZmfExHV35Sozax=bp4jrg@mail.gmail.com>
X-Gm-Features: AclHuK8C5WOmRZdGXq8DLEZLtjZ3AzzlMEngY-TJFok9-5U8_uLq23Pxa7Szemg
Message-ID: <CAD++jLm7RfccF5cCTSmjWBwT+cWHEZmfExHV35Sozax=bp4jrg@mail.gmail.com>
Subject: Re: [PATCH RESEND 24/83] drm/mcde: Switch to
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

On Thu, Nov 5, 2026 at 4:31=E2=80=AFPM Maxime Ripard <mripard@kernel.org> w=
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
