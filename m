Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B517CA6015
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EA7810EA53;
	Thu,  8 Oct 2026 21:50:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="H1+MF2zh";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8421A10EA40
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 21:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791496227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ePp3hoeNmkrVt/U9bUUOKdQrBVXEc7uic6P8CJcGdks=;
 b=H1+MF2zhNraAhcEsiX2hkdDngnEYuErcdVw8gTuKse5zhzOF3yTR1V+hOer2K7mQt3P1br
 oyF+WP1eJVtXb4Etm7FLwtDpt2D9982q/whVWLg+IXXNIk4yQvkMsAka/f7yn5k1hysOVh
 eEmLx9+4MrEMFlW0XBpmxE6RLxXhsnw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-hXY5Wi05NvWDU_b_ctEr-A-1; Thu, 08 Oct 2026 17:50:24 -0400
X-MC-Unique: hXY5Wi05NvWDU_b_ctEr-A-1
X-Mimecast-MFC-AGG-ID: hXY5Wi05NvWDU_b_ctEr-A_1791496224
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-917a3c27c9bso95636476d6.0
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 14:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791496224; x=1792101024;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Yj5+6LkgWgCIxY4tLK8pHE/X0tclHYwKwnVGo/2N7mk=;
 b=Ljn+j5wmF7HKd/HIHAFNjUtxNvxmygPup1BK3pgEfidBPN6zvKTu8/1/r/AEmPD8NI
 ohHu7iUGT8n/VWhT7bCTXcN4LbG4z1KOFCdsJ1x+x3V58iy5iejGgSDz8kQdeLRwZX/x
 XbcLv9ZJ8CpHO8uE+eDGw7/L7XR/byIXCiTvillkpNEWMC+UADshtVa4Lg8PJuBu/Nf+
 4MNDiW7MSe2/dJ0q1ELAyVvJIg2bnduxzgmCgTq4cM+y5B+q5Bm0qPy36J4wGs3Ez9lE
 gSNaYmHvyt9sLMxmzWzFvTt/pn026jmOaMPLXoESVo5dYNtrdM7DBVbWBiM1SSgtwiwm
 f7Bw==
X-Gm-Message-State: AFq9FYJgx1gz/ac51RoqiJPGZ3ZS73fKOGsdO2gZCXWxldpH7dD51H8z
 fdKDZsovTsdEPDmYQbRrTKAy/1K26HKCnL/gCpoq3R1WEQG+FArhpjfLx1JKYWLARF/jWEXAPu+
 kIzlT5+JWfBn7zYgtEbJVo+HBtYnmmqX4bSoVx3BXFpfbKHYX3p6CZnHnZSuGadCGSPUuJg==
X-Gm-Gg: AYBFou0y5vt1Livxd4iX7vensYZz097N6mtZW91gy/sedfQj0exfn0J8ky9ZeFDtOGs
 TWE1JexFPwid1EabqAtlH4zj0DofjOBuyXkstrKMKKpkoNEKgf0a5iH0pxiOA5HwdJailwosJpX
 W+vLm42BNVY/Kpxy/ET44uAeKOC6O2k6pdNz0QC1Nt+2xTgxm1myl5YLG1bqLk6V5g5nnl/TF4F
 TlGsJwVUT7CrVJ5v6ty104THk8AdkpVeTTj4EEIsV7Wtc092A+1XWlq3WTUXuNHmoMYKtjsxlkE
 gwg+80W/LKNBgXFxMcn8SI/n3J5xkVhqDXAB4BtxWyE1zc0ZcNkHacKf0K62xLvax9rzCg0=
X-Received: by 2002:a05:6214:4497:b0:917:edd4:d1d5 with SMTP id
 6a1803df08f44-91b557bd604mr849506d6.42.1791496223809; 
 Thu, 08 Oct 2026 14:50:23 -0700 (PDT)
X-Received: by 2002:a05:6214:4497:b0:917:edd4:d1d5 with SMTP id
 6a1803df08f44-91b557bd604mr849236d6.42.1791496223367; 
 Thu, 08 Oct 2026 14:50:23 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b55120027sm1006706d6.49.2026.10.08.14.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 14:50:22 -0700 (PDT)
Message-ID: <728a8ff2bea09d6e35446bb13ac663f2c3a63ea8.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: Skip the Turing CE workaround object for
 non-GR channels
From: lyude@redhat.com
To: Mary Guillemard <mary@mary.zone>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 08 Oct 2026 17:50:22 -0400
In-Reply-To: <20261007-turing-async-ce-fix-v1-1-12ee6ccd1a3c@mary.zone>
References: <20261007-turing-async-ce-fix-v1-1-12ee6ccd1a3c@mary.zone>
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CQiB2cy3bvwM4NUbTRSYi65i_jN71yEc49_9KYY0GoY_1791496224
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

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to drm-misc-fixes in just a moment

On Wed, 2026-10-07 at 16:30 +0200, Mary Guillemard wrote:
> This workaround is here for the old Gallium driver and predate async
> CE
> and NVDEC.=C2=A0 Instead of only skipping it for NVDEC, let's only apply
> it
> in case of GR channels.
>=20
> This should make async CE work properly on Turing by stopping the
> assign
> of a GRCE. (here CE0)
>=20
> Signed-off-by: Mary Guillemard <mary@mary.zone>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_abi16.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c
> b/drivers/gpu/drm/nouveau/nouveau_abi16.c
> index e907c1d07887..e876f154963d 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
> @@ -488,7 +488,7 @@
> nouveau_abi16_ioctl_channel_alloc(ABI16_IOCTL_ARGS)
> =C2=A0=09=09=09goto done;
> =C2=A0=09=09break;
> =C2=A0=09case NV_DEVICE_INFO_V0_TURING:
> -=09=09if (engine !=3D NV_DEVICE_HOST_RUNLIST_ENGINES_NVDEC)
> {
> +=09=09if (engine =3D=3D NV_DEVICE_HOST_RUNLIST_ENGINES_GR) {
> =C2=A0=09=09=09ret =3D nvif_object_ctor(&chan->chan->user,
> "abi16CeWar",
> =C2=A0=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, TURING_DMA_C=
OPY_A,
> NULL, 0,
> =C2=A0=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &chan->ce);
>=20
> ---
> base-commit: 70456f05d4b6396b22048c4b8cd3cb98ecf9f9e3
> change-id: 20261007-turing-async-ce-fix-42e179e27d4a
>=20
> Best regards,

