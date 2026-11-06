Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2561606A329
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFd3XOby
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1C8210EA46;
	Fri,  6 Nov 2026 13:16:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41B1610EA20
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:15:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2BC5843668
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8B41F008A5
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793970959;
 bh=12x3nodZZWNzeKZiz9QY7qJpKesFLteFUhefJbdIQKE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=mFd3XObyCANI3D5H7Y2SxJoyEf3m3TaA4Np5oL9vGuWTylCaHytZcrBlZ3XcEosZk
 U+3+/+x6xeX8QlKvhj0hrEeESknCQ9GVATTfIXD6/YTsY+0s4b+PQDoVKgESGeo823
 2uV/4SrXC4zZS+WXCUQ4ZM1l9dXCA7X+IW23NHioEtAevlJnkNCv9fmpjtpmHjNYci
 rKbGey+2FdfVn/664x43m94s352cpy4w/3CSaIjzlM6C5jbhvgUHhyJiT5rJeCONaB
 7+8bQc9q6DN0KvKJRFmdCt+lC8bbnxrn9w9sg99s0Rasqj1aHRzvc4PnY5fS6qEXHr
 zI+joYTTU+35w==
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5be53e5fce1so541335e87.1
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 05:15:58 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AKwUvByVg9KaVlCo3C4uh8Y3D0ktPtrT6Nd4TAouhkNmW58maEcDokA9+vxeQYXna0couBLKOr9Regb3buo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/ZlrQMO/iaiBKJxVXllbfILl2CLWEudBvZo+E6gpCCfWKnRSbK
 Acw6G6fDduBFDk7tCDyAb9QWFr8o4rqcEpS+CJcK0lLYrVRb98H1seepYOs+LD/ob6T5Mp7gQ3Y
 P2Pgc726buExPfOi+Wd3o3kODm06y+OE=
X-Received: by 2002:a05:6512:31cd:b0:5be:4e1b:5f96 with SMTP id
 2adb3069b0e04-5c003c3dd3dmr642680e87.58.1793970957746; Fri, 06 Nov 2026
 05:15:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-33-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-33-1f58d1e33380@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 6 Nov 2026 14:15:46 +0100
X-Gmail-Original-Message-ID: <CAD++jLnVb39y8O8Y4jsz++F0P=fw5DRbT6kQ=SZRT57J7rMoKg@mail.gmail.com>
X-Gm-Features: AclHuK-p5RRlmyTOkBtUJ4IUoK3aDNHet4pIKl1tAcjpSoorKvXlBRyuobOjw1A
Message-ID: <CAD++jLnVb39y8O8Y4jsz++F0P=fw5DRbT6kQ=SZRT57J7rMoKg@mail.gmail.com>
Subject: Re: [PATCH RESEND 33/83] drm/pl111: Switch to
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

On Thu, Nov 5, 2026 at 4:32=E2=80=AFPM Maxime Ripard <mripard@kernel.org> w=
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
