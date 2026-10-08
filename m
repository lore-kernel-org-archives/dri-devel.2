Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9141CA6016
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 22:32:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2320210EA4A;
	Thu,  8 Oct 2026 22:32:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="bWyl+jJ2";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63B7010EA51
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 22:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791498752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SIc4iwA5XrGPQ2J5CyhQjre/d7+7alnceRYs7l0hTO4=;
 b=bWyl+jJ2pB3KHzW6jXVOADPvy6rN8wKXy0QK9P2jYtnjH/lTFjstiq1ZUT7bR4P9etNUnB
 tRz645CCuBbJCqthT9cOsS4Po4QBhrB0uo3VW8+n77NKYGeRwsqg59RhXY6yUn7CNRO3Zq
 2goVOqfJDMLV/Kp5qBWgzL8/nSs2gfU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-dcU3HTNMMF6M3ZSqljEyIQ-1; Thu, 08 Oct 2026 18:32:31 -0400
X-MC-Unique: dcU3HTNMMF6M3ZSqljEyIQ-1
X-Mimecast-MFC-AGG-ID: dcU3HTNMMF6M3ZSqljEyIQ_1791498751
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93909014c85so1031661485a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 15:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791498751; x=1792103551;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SIc4iwA5XrGPQ2J5CyhQjre/d7+7alnceRYs7l0hTO4=;
 b=kU6DlvhgK70XhHTfZE/MHTWWhUAb3LfwlVPV2g4IUd1dZz9GbkDp9rkniA/WdwxJ2e
 zPE9PkLg1Ju1N3peNxw3nGDIUXWq54EtqSu1WmG2zQIv8CIkiZk+z2lIL8QBRQ3TMylC
 i6soYCZoRbxp/Pif/HS9GPtb95N/SDUhKrXQUVTpf7PU2PBQHX6Kk/3phv5f+YyW/qY+
 vRB2eTl/+i7F6vR1uHJY1i/MGcuC2DxI2o37VAlU5jY0zJYI3RgMiz1UnF3RnB8RKRIA
 isxg/MkUIZ5HyCw7J7fyt/AsNnY9bCe0EUTS0OU/chsP17seoa4n5TTOY7XO7ddqiiSI
 KReA==
X-Gm-Message-State: AFuF++m9S2iAVLb12Eipvu33wQj1wnmi4CsgiHPAFV397dVjgtnWRQbP
 pD2jcRRtDyr2zNw+o5wgzKNUrKC3kAh3zFqQ81tfMa7ECzQIKELuZIACnUpnhbib7XO3ezlDUyD
 Czt+pc0FQOUQGhx0Vk94C+HFuzKFtmOtQkTD0a5lK41i1gLj2ZI2fcOu5GSIGfxpWPXmbhA==
X-Gm-Gg: AYBFou39eXr2hLWhm60Sw8fUkgqKnItSYJrgeDpByJjY2R8WMCU5/jV8Ki7/ru0vd9o
 qU88OIJMPCLfnk/jMZ3vXI3TVZ6kAxtGoCq3mkt/eIhg81sQM8Kyt4QdqyyreSHszVGYyp0TFGb
 UjKS39FzsJr7w120WWtuR8Dgbl+sjrqsKhy6vISIYKN6aWnG68ZvkkU0CykYsPrHtJayRtsUaWs
 bUJjWHzygww5px4aDhfB5XmbwMvDExGv2PNcamG2iNCHQtDLunVjwnbJ/+TVqZWhjOzyOz1GUIF
 ypsTNj077cCieEd0Uc4fm9Yr07OwNtEF82IkiRopFbdb60ecs4M3yHjqeY9ykRqpU3WUbq8=
X-Received: by 2002:a05:620a:31a7:b0:93e:739a:7ca0 with SMTP id
 af79cd13be357-93ebd22937cmr7032585a.18.1791498750560; 
 Thu, 08 Oct 2026 15:32:30 -0700 (PDT)
X-Received: by 2002:a05:620a:31a7:b0:93e:739a:7ca0 with SMTP id
 af79cd13be357-93ebd22937cmr7027385a.18.1791498750001; 
 Thu, 08 Oct 2026 15:32:30 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b550d394bsm1890416d6.41.2026.10.08.15.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 15:32:29 -0700 (PDT)
Message-ID: <57528a486e149dc398d0ca443b33b16f805ea4e7.camel@redhat.com>
Subject: Re: [PATCH 0/3] nouveau: fix 3 null-ptr derefs
From: lyude@redhat.com
To: jim.cromie@gmail.com, Danilo Krummrich <dakr@kernel.org>, Maarten
 Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Dave Airlie	
 <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 08 Oct 2026 18:32:28 -0400
In-Reply-To: <20261002-my-fixups-v1-0-a83d20f9d3fe@gmail.com>
References: <20261002-my-fixups-v1-0-a83d20f9d3fe@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CR2ZKc_rjvCtvwMol45fTj65bOiRhWQOdE-AKr9hkxs_1791498751
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

Actually - sorry for going back on a review, but before pushing these I
realized we might want to do a bit more of a concrete fix than just
these patches. Why don't we modify nvkm_gsp_rm() so that it also checks
gsp->rm, and then use coccinelle to convert as many instances of open-
coded `if (!gsp)` as we can find?

Would you be up for handling that? If not, I could just modify these
patches, update nvkm_gsp_rm(), and send out a new series with your
modified work included.

On Fri, 2026-10-02 at 12:09 -0600, Jim Cromie via B4 Relay wrote:
> These 3 patches fix NULL ptr derefs I hit while booting kernels with
> unrelated work (dynamic-debug) on a 2019 amdgpu+noueau laptop.=C2=A0 One
> of
> them is possibly hard to reproduce, the others are "dependable".
>=20
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
> Jim Cromie (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/nouveau: Fix NULL pointer dereferences=
 in GETPARAM ioctl
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/nouveau: Fix NULL pointer dereference =
in GET_ZCULL_INFO
> ioctl
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/nouveau/gsp: Fix NULL dereference in n=
vkm_gsp_gcx_ready()
>=20
> =C2=A0drivers/gpu/drm/nouveau/nouveau_abi16.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 27
> ++++++++++++++++++-----
> =C2=A0drivers/gpu/drm/nouveau/nvkm/engine/device/user.c |=C2=A0 2 +-
> =C2=A0drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c=C2=A0=C2=A0=C2=A0 |=
=C2=A0 2 +-
> =C2=A03 files changed, 24 insertions(+), 7 deletions(-)
> ---
> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
> change-id: 20261002-my-fixups-324d25f3bd05
>=20
> Best regards,

