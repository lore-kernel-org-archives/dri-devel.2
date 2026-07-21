Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B918C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 652C410E08B;
	Tue, 21 Jul 2026 20:08:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="chJgMWMM";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A1A810E3B6
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784664530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kAHPDe7ybewGiUFEcOR2l6oFJvAxNe2N1MZePQ+DsrM=;
 b=chJgMWMMF8V8ROuZHaKIrCeDRY0fFyWRVmhU8IWqrRhzFBMObcIzhGV7cHSEenY3EctIaS
 P9gvzpUtGpS5otbsC/dGwjkjdd5WFA0oQ8sYqEVo+mBoGzPK8o+hjRzxchTmiVp0DQjd43
 +mN9eprrmEs0KSo0atq26lnMpLkiDG4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-CkLHRiOLPLiN91vYxU-9hg-1; Tue, 21 Jul 2026 16:08:49 -0400
X-MC-Unique: CkLHRiOLPLiN91vYxU-9hg-1
X-Mimecast-MFC-AGG-ID: CkLHRiOLPLiN91vYxU-9hg_1784664528
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8f0867a75ecso132713446d6.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784664528; x=1785269328;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YoOouUI2xFyBZQ4n8b5UEgP4pMR5eMIkpQq69XgErXE=;
 b=jMoT0U+FSopKVbEyWItHKJQF2pcisaJn9imbpLrgJZ1yj1w8x1loeo3/3Ncczbaoxh
 tdWF5ts0mc3vISCUxzM9Tlf5kVUfUjbyUTzi9jEcCn0Q+S/BlIfjQgZyjHG4sGY08Rzv
 XPV1qVQrP7bnnXCiGJP19zBGF9uw2sjAFzTIBryNUKmGKpYQQGAt1f42dYAzjXjz0x04
 9mDX5Cit/SU0gQ8dxwb4bAVC7evt9bSA2M5qBAjdVxn3UsRsXwYuA3XWsViEBt767L/O
 evWGZrp0o+5lwgoK90MszBuZBmdK5bS3xXS7EZVJsL+rw9HK2fY4zamAnpxvb1pS3u6T
 lpFg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rof8obxkK7IzVs9BV4iGxnLAll5e9ZsOgcLgw2ZV/jD+3umcwOCiGHb8qB2InMp/NfHeZJXyE5rlOg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzy/9XbW8OdYTQO1vLE5b1XFRPSBxEv9jZ02xgGpmZkxieqD+4D
 eR+Yqsg902WR4kQKVxyRIUqQH/jx6U0wLu48Ngwl16aohjM0cfrb8vg8JFE5bAfnuG0fzCGSK+L
 v4ucVU+PaFChjGVZYhQtJxXVW1qb7hDJ+ymJWgShWU+Dpznk6VSA8sihW5yX7OQIZnNmQZQ==
X-Gm-Gg: AR+sD11kSLKwFcTa3M++xMfGe62S1OE7I083HImDqrc4jHDzbceoPVn9kk/Odi5oY6e
 c/JD6BOaeBM9QOOFJZ+mqe+dZq1ogM7/n8viWJqn8yswU45oT5K+U6swNXWZIeeqJL/aHHNIfLe
 48Soyvhh651zg89ISpi3RgxPA/CUreFl7+A1BiX78Sh0VtymwpIiPiLezOCuP21ab7h+haorGYh
 YowSvYuPy7fBvtoTT7iYjsbG81sIp7JGVLfInkDbRMIT8tgE4xdkzfttcZUBfpRe5UYZS9NaMi1
 FqpJBzQ1GiNYdUd9jzf5inKhdvl2vU27lFMalm2Je3NTEQSlEuyFu2V5wCkCJjPO6d1XgISh
X-Received: by 2002:a05:6214:e87:b0:904:546a:1c47 with SMTP id
 6a1803df08f44-907783dbe63mr224352336d6.53.1784664528510; 
 Tue, 21 Jul 2026 13:08:48 -0700 (PDT)
X-Received: by 2002:a05:6214:e87:b0:904:546a:1c47 with SMTP id
 6a1803df08f44-907783dbe63mr224351876d6.53.1784664528014; 
 Tue, 21 Jul 2026 13:08:48 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907baa27ce6sm3874066d6.45.2026.07.21.13.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 13:08:47 -0700 (PDT)
Message-ID: <c7176459c23a43167a63ede73d2ba9b0c805445a.camel@redhat.com>
Subject: Re: [PATCH v2 0/3] drm/nouveau: Fix WARN_ON() from missing blend modes
From: lyude@redhat.com
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Cc: Faith Ekstrand <faith.ekstrand@collabora.com>, Dave Airlie	
 <airlied@redhat.com>, Leandro Ribeiro <leandro.ribeiro@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Kees Cook
 <kees@kernel.org>, Marco Crivellari	 <marco.crivellari@suse.com>, Simona
 Vetter <simona@ffwll.ch>, Pekka Paalanen	 <pekka.paalanen@collabora.com>,
 David Airlie <airlied@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Stone <daniels@collabora.com>, James Jones <jajones@nvidia.com>
Date: Tue, 21 Jul 2026 16:08:46 -0400
In-Reply-To: <20260720205541.257781-1-lyude@redhat.com>
References: <20260720205541.257781-1-lyude@redhat.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SPxBZe5iP0B6FG76eJAhrsh5bNzRcpxsbwi0SF3yaNY_1784664528
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

I had thought that testing this on fbcon would be enough, but there is
still more issues with this series I found when adding these to the
kernel I dog food on my desktop. Will figure them out and send another
respin of this series asap

On Mon, 2026-07-20 at 16:43 -0400, Lyude Paul wrote:
> Recently a change went into the kernel to ensure that drivers which
> expose color formats which have alpha channels. This would cause
> nouveau
> to hit a WARN_ON when setting up cursors, since they do support
> blending
> - but we never bothered trying to hook up the controls for it to
> nouveau.
>=20
> This fixes the issue by ensuring that nouveau always exposes a blend
> mode for any planes with alpha channels, regardless of whether or not
> we
> have control of the blend mode hooked up. If someone wants to add
> control for this in the future as well, it should be fairly easy to
> hook
> up with this.
>=20
> Previous version:
> =09https://patchwork.freedesktop.org/patch/741031/
>=20
> Lyude Paul (3):
> =C2=A0 drm/nouveau/kms/nv50-: Add .blend_modes to nv50_wndw_func
> =C2=A0 drm/nouveau/kms/nv50-: Introduce nv50_wndw_default_state()
> =C2=A0 drm/nouveau/kms/nv50-: Unconditionally create blend_mode prop for
> =C2=A0=C2=A0=C2=A0 wndws
>=20
> =C2=A0drivers/gpu/drm/nouveau/dispnv50/curs507a.c |=C2=A0 3 ++
> =C2=A0drivers/gpu/drm/nouveau/dispnv50/disp.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 4 +++
> =C2=A0drivers/gpu/drm/nouveau/dispnv50/wndw.c=C2=A0=C2=A0=C2=A0=C2=A0 | 4=
0 +++++++++++++++++--
> --
> =C2=A0drivers/gpu/drm/nouveau/dispnv50/wndw.h=C2=A0=C2=A0=C2=A0=C2=A0 | 1=
1 ++++++
> =C2=A0drivers/gpu/drm/nouveau/dispnv50/wndwc37e.c |=C2=A0 1 +
> =C2=A0drivers/gpu/drm/nouveau/dispnv50/wndwc57e.c |=C2=A0 1 +
> =C2=A0drivers/gpu/drm/nouveau/dispnv50/wndwc67e.c |=C2=A0 1 +
> =C2=A0drivers/gpu/drm/nouveau/dispnv50/wndwca7e.c |=C2=A0 1 +
> =C2=A08 files changed, 55 insertions(+), 7 deletions(-)
>=20
>=20
> base-commit: b0a652436b892eb9a036a031b33099dca036faaa

