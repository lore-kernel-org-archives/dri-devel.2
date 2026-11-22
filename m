Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDCE606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eo4HcbdH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97EAB10E03D;
	Sun, 22 Nov 2026 17:54:17 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F56610E03D
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 17:54:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2C7B9448C4
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 17:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B1D1F000EB
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 17:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795370050;
 bh=Lqr2my7RK1rlIMbBVQfce1d8JLq0RXfqlMr2oVJYgIw=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
 b=eo4HcbdHgBVpemzOYf6oy5CgelFnR8d3OVCpLJNniLJk3xN5NwmFhvCdpciT8oVDI
 C/FQPq6UA1SqdiAZZToK/b4nxVBiYpEVtfnAifv8JTeIXmz6On0l5/WsJl9oNsP3P6
 awxA/khgreVTcq/A6tSEnSKw/daJ01cXNa6wmeYGMEiBKudPvDi/ooy20J+ntFPt58
 dKMhLWld7BcM/bIjhoA3dcZ0xMdgMAEJCR6kmKkc1XlhqPbmbRvS52TN00TcoGvZTx
 tJ3xd+3I3s35BMT2Il98iyTwjjuUwysNC/5nQAWLziGHUCfTAOaY/TWGXLvyb33Pjq
 nb449gghN/cHg==
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-3ae25d9e2fdso25090941fa.0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 09:54:10 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErHTAKC59CGA6uLrB9rxL5C8Vf7HMccfrgH7a6plylenlg6GDwpN9BPVxsB1gYLDg1r1BefDUdNykRc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+jIIbN7M2/MdkR17aPE37Fy3df2E39OOvv2jshe5SuMfCgv1ai
 q68QFO3++jy2Ytb0SFX/16eCCX2sW3BI2pcC58zyTnOhMJALP0d2JkZqK8WHKqPo42vLSvVWqj3
 dMfhGAc0Kj4XgVxYedwdYj89T+4QBcGo=
X-Received: by 2002:a05:651c:1593:b0:3ab:4eb4:5ef5 with SMTP id
 38308e7fff4ca-3ae7f9d5e95mr25703721fa.9.1795370049024; Sun, 22 Nov 2026
 09:54:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119175437.2520400-1-jernej.skrabec@gmail.com>
 <20261119175437.2520400-2-jernej.skrabec@gmail.com>
In-Reply-To: <20261119175437.2520400-2-jernej.skrabec@gmail.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 23 Nov 2026 01:53:55 +0800
X-Gmail-Original-Message-ID: <CAGb2v66dXR=Z9FEcudG8NL_miWWH4uRvwg-RYpkTJnSrx3NKwA@mail.gmail.com>
X-Gm-Features: Aa3M54o38aETzb2mUkHD0BeP41inxjrl5JHrW3hwDkzzKCE5Y7QgUCWC98J_8iU
Message-ID: <CAGb2v66dXR=Z9FEcudG8NL_miWWH4uRvwg-RYpkTJnSrx3NKwA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] drm/sun4i: Reject fractional source coordinates
 without scaler
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>, mripard@kernel.org, 
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, 
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 Andre Przywara <andre.przywara@arm.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 1:54=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gmai=
l.com> wrote:
>
> The layer code programs the scaler whenever the source rectangle has a
> fractional offset, since only the scaler can apply a sub-pixel phase.
> drm_atomic_helper_check_plane_state() with DRM_PLANE_NO_SCALING doesn't
> catch that: it only compares the scaling factor, which may still be
> exactly 1.0 with fractional source coordinates.
>
> Channels without a scaler would thus have the non-existent scaler
> programmed instead of an error being returned. Reject fractional source
> coordinates on such channels.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
