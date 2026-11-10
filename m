Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5AF60A2607
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 21:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xzvsi7K+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0961910F068;
	Tue, 10 Nov 2026 21:50:03 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C90C410E33B
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 21:49:56 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-36dc4797082so360693eec.2
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 13:49:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794347396; cv=none;
 d=google.com; s=arc-20260327;
 b=RT/uwkw8p3jvWSi8oW7OxqhHs1r9qjmEoB16di4tBJaohCuggoEbZUlye0eT2yFn+H
 o4pgR4Iu2FNFglm9rNsDGzybLQjZ+T3eK8lyGJZ6Er3zLVJ+brXfb4VgRJphPhXAm9MQ
 RdePrlYt+OygJM5bUv7t/KYzbNEqcFsOKXsLKih9LWnkbVHdin6wYzJLak0W/znvgBEF
 yLY3sq10a2MQsZmQ5RfcCEPstxE9x/3IJBP/TgaAb0KqPMGA/jJ0L6QDz+RGdjNsv3+8
 muWIzWkRylGw8cFHAAaR+dZK+Dcwl1jt55Q1D91Mg/arx50qfw35iGH9bFJZ4E5m/k6T
 Hf3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lc2d75OL7aQ19NWtHaPUWdOA/U+qQ69pXWLu70/x14s=;
 fh=Ak5/++zjkTSrPBtaoF0DHweHoik9aqhMe2gz5bOIz7I=;
 b=JoAjBlyLveVBJ9Q6hiQ6XaB1g9b9tZXixGQo+xotJpsqgn1WzRP3VYMzppMjp3JA6A
 fWAYblHW6fWIepLAFVYYH1ivc0Fj/5UBjhVB7ZFR18CX9aTxkV7x7VvE3Fpla6XIV8QG
 UATte2E9B/5r3hMTZy5r54nrtXyE6bPiE5Og4gmEV1a1UuP4rB6Rf7ZND2akQoX+vlBh
 ipwWFqCVzKwFXCWJcTCVrZFbenepIgHKD+8Tzdko5zzC9NsD9BeRP8QAyswCU88jwNUm
 cz6hMdEOnm62CxBm2QYLnc8MoWWEZ/Tkozi+P2svahX5k8/p68yjHyRnS5JECsyiTLdO
 xx7w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794347396; x=1794952196; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lc2d75OL7aQ19NWtHaPUWdOA/U+qQ69pXWLu70/x14s=;
 b=xzvsi7K+Rxx1yTTQAbCLSkkRBIbkgyRzJKujahpc8PaT8Vapym4zYDm2BV0aDxxS4M
 49qkWCzWsbZewo7sMhrgMxkKnQWVDw2ywGBxR4M0dd50s1R7jMIfGhIfvphoqOS4M+U1
 WfYV6XduF+G73yuQABpAQDEOcquhiS41Xs1EnIDlclpacuLgolCPJvTmjxuJmJg0Zo9U
 Uw4Aso70xfOM6JVBzdY7lJhgTPcITIaRIt0TLqsHUV7eKTZT1NpzYeiudt1HNEZRuz5h
 PHUMj/U+3rIFgaEm5wRoCpZTHhdBP7oAA14+784ddpmjYg1W//NZo+19xhbfSVj8ceGr
 1BoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794347396; x=1794952196;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lc2d75OL7aQ19NWtHaPUWdOA/U+qQ69pXWLu70/x14s=;
 b=ii206kISRuxG7hIYXgpSAmDBOPLIXTw38ucc62kqp+ql9ppDRImFYwwUJo103SMlgB
 /IVn05KncJvyqUhs0WqeYxAIOthXRaq9CtJbSIqQsl3u/rslRMSKdUZscFq03hnLFVQk
 jMv9+Kn5XSR1czhxBc1n1yS/mVuWCYNwZzAXB9AQZODdrWVIv+255eq5t3jgpWG08Em0
 Xaym0ntmtcpWCwQixI63Fz46J7X0JhSqWNmR6+GmelNZ4zxRqInplaQpjsPeUaPOOidr
 wir14rKcmNeQxlIzL7jN0i5HpczMW8yMXWNCwq+umTaMxI8nTR7yezP3VMMaXYKwyVS2
 H1hw==
X-Forwarded-Encrypted: i=1;
 AL+hErFcRMpSocvt9OpiA5qEMe5BMOkGWaTD0x08sOdUgvClE8gF/9wtQy5dcLC/UoFhf3c2OdxgGUHjHO4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+qYjL3TIg52KxEr1Pb6K18tQrQmAwuYfoF3dLtbNkStUJn/Z4p
 O01MOHXS125U7ozjqAHkQEJS+rwl3pdmIChWgn1ZnN6PDdNDl8RGoqIOB2ThSXVq4zYu6ShDY3e
 m2Q+YdJ0ne0xcW7YLtGWxjUitZeRVm7g=
X-Gm-Gg: AYBFou3JdEpgTAdoNTsOoCPr+nmO0UZ6WV61zH26X9N/ZvIYuRblUIQ8m28ukdkLnSK
 Rgc0iQ12DDWSes3QSe9heOwu0CmNUPG0GP2hyDX0F1BohfQEO5bIqLGwor7sFf6PLuVG/yMDYu9
 p7cBIfmHuV7jIZ3sMjJO9/aruxIFwvM1T5NHo/AMeBK9hT8PAozIK42KDoumkLW/NVOgu7znAL+
 7WRh5E1/aP/uEeqgPa0MWG93L8s/4fGQd3Ke3aaZ5+v9KChihr2sfWfEkAkZ9YDxzeysfIBgi2s
 aZWp3mIHM8bOnYg0Q+3Z5u7dYP+9mvGXpOeOAeqLewZ9blX5aqmtrmLLMleYe7ZQ/murWvcyv0S
 Ih/IqMRg/P/tbs9dM5YNTds5CgcfDUmEcxWH+JTcLSce+CP3IozYynu3z3OOpwvZ2mwX9k4CtZq
 sWoy2g44ebcAawTremlC+r1S0+ztJVVeYLItpNX2kLMMEvtg3QDuFv7a1ha2s=
X-Received: by 2002:a05:693c:41cb:20b0:36e:66d8:1424 with SMTP id
 5a478bee46e88-37680a60bbdmr1218085eec.0.1794347395773; Tue, 10 Nov 2026
 13:49:55 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110120326.538252-1-tzimmermann@suse.de>
In-Reply-To: <20261110120326.538252-1-tzimmermann@suse.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Nov 2026 16:49:43 -0500
X-Gm-Features: AclHuK_r02Bf4QXu75VAdsauSxMk2WkxkkNGMymOSn-A5ONgkHUPX0j_0Ud49DY
Message-ID: <CADnq5_NCF2J0Dzea5swubs+eEKBLq+8ontc5n=kihYZVA3A1aw@mail.gmail.com>
Subject: Re: [PATCH 0/5] drm/amdgpu,radeon: Inline drm_crtc_init()
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 sashiko-reviews@lists.linux.dev
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 7:11=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> The helper drm_crtc_init() sets up a CRTC with a primary plane for
> non-atomic mode setting. Only drivers for some AMD hardware still
> use it.
>
> Inline drm_crtc_init() into amdgpu and radeon and remove it from
> DRM. All new code implements atomic mode setting, which does not
> use drm_crtc_init().
>

I'd like to drop all of the old amdgpu non-DC code since DC is now the
default, and we have an LTS kernel now.  I'm planning to send these
out in the near future:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/remove-non-dc-display?=
ref_type=3Dheads
So that just leaves radeon.

Alex

> DRM support for kernel panic is only implemented in amdgpu. Take
> the panic helpers from drm_crtc_init() in amdgpu, but clean it up
> in radeon.
>
> With this series in place, DRM's helpers for drawing panic screens
> can be further integrated with other drawing helpers, as outlined
> in [1].
>
> Tested on radeon with a Radeon HD 6570.
>
> [1] https://lore.kernel.org/dri-devel/20261019154612.777074-1-tzimmermann=
@suse.de/
>
> Thomas Zimmermann (5):
>   drm/amdgpu: dce_v6_0: Inline drm_crtc_init()
>   drm/amdgpu: dce_v8_0: Inline drm_crtc_init()
>   drm/amdgpu: dce_v10_0: Inline drm_crtc_init()
>   drm/radeon: Inline drm_crtc_init()
>   drm: Remove drm_crtc_init()
>
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c  | 44 ++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c   | 44 ++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c   | 44 ++++++++++++++-
>  drivers/gpu/drm/drm_crtc.c              | 26 +++------
>  drivers/gpu/drm/drm_modeset_helper.c    | 74 -------------------------
>  drivers/gpu/drm/radeon/radeon_display.c | 47 +++++++++++++---
>  include/drm/drm_modeset_helper.h        |  3 -
>  include/drm/drm_plane.h                 |  5 --
>  8 files changed, 170 insertions(+), 117 deletions(-)
>
> --
> 2.56.0
>
