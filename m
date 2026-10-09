Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8940ACA9EBE
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 21:25:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E526A1122AE;
	Fri,  9 Oct 2026 21:25:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="GzG2cqAL";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 985CD1122AE
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 21:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791581136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=psL5p8+MFK4U9KNE7OIgkacUcKEzN5U0oHZT0YkzTS0=;
 b=GzG2cqALpnCLp3piNHVtNsJStRQBU+Uk4vK0V90jdc48qvaPd1lTRILWOtpQaLeZa4lI4V
 Ly+z2en3fRUWVaXLaof3GgI58Ck25I82rk6frKvVKauTserY/X2a+xeU2LdNl3OVhC1vuz
 8v0TC5WEVKjFsVjsvtNBcYK2SbbBUtA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-1WZhvGJ9MBCMkO_7eVDWBg-1; Fri, 9 Oct 2026 21:25:35 +0000
X-MC-Unique: 1WZhvGJ9MBCMkO_7eVDWBg-1
X-Mimecast-MFC-AGG-ID: 1WZhvGJ9MBCMkO_7eVDWBg_1791581135
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91b650901a0so5499566d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 14:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791581135; x=1792185935;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4XVeputkPvs6515x7jeBdEMihAqSCocptjoH5SwkFZU=;
 b=OTAX8G3ZIcSqtuLfdWwIOxrfSQKNlitkxx4ng4jzVdHItZYr9rlanr9X0UGru9g50c
 GEP29YTwYAgdUUABinqg8QguOn5q9ZB8tP5/Yy43eAO592+XSf0XsG2iL01+Rtf1alMR
 eFscmn/stCHucocI/ruQ0eWZQPx9guqUUMZ4YxS46I/vGGz9BNEzFuZmxJ4HhICzfBpi
 ZQbX5aQA8knvRpWcG7VT72PI9rblY61mt1gCxRfyD38Bshp8ORjeY33IqaM1LtJU36Tl
 Wtnl0TTteyNkVzIT2NSoyOXPXnv5Egvnbl7JjP6NtkHILQ46EPLy7pSIkGYh/cu2ArjU
 babA==
X-Gm-Message-State: AFq9FYLDoMgWffR5pkBEs4L7Ppc15LgN23AYLklKOtBayMoSF+UNdJUo
 g7ICTypQgckKlM3Ss4X/zA4VKhUHztFyE1FMbRvwqzu57Ey9OWA8yHN0JDbiIUZ9zS4S01ldio7
 6lIdZiVR/L2TEgNvzz57L1LRCQcnFv5jEeSfzHQhpWECpAqDAC3sJFXCoyjKhzYhjZbZIpQ==
X-Gm-Gg: AYBFou0SXxWXro8nE+JmZhVj0CyD3M7Vx7E9PjR8Jwd4niDwnaU/9dL5Z7jyEhRuAw/
 cQYDiq/od+aFh35zpxkWz5caLf+lmSdWTCVdPgYikhUuwnL6wzHu/W4tAusUvCZe0xsmqcPEcjU
 j8ibM2lqiGMGcRiO4TBU2LJf55v07QviwLZRPOpQE2KeXeO0MWwb0LUBjrSTv7/pZthCWWf+Jnr
 xTgTZaW10S9/HC86vWfx4D0rCfGkWb18xwUGMbZorZP7UU3hqmDgMlmajvfRzGk8CO50nV6GGkL
 UzdS8PE/1vaLpyG4MpU3GxZ9lfHShP+a+8Sc2DBiFiawbztABVjvR9oCCej1SNQkiJOUXLY=
X-Received: by 2002:ad4:5deb:0:b0:917:bbf1:5323 with SMTP id
 6a1803df08f44-91b55793527mr54975536d6.38.1791581134776; 
 Fri, 09 Oct 2026 14:25:34 -0700 (PDT)
X-Received: by 2002:ad4:5deb:0:b0:917:bbf1:5323 with SMTP id
 6a1803df08f44-91b55793527mr54975196d6.38.1791581134294; 
 Fri, 09 Oct 2026 14:25:34 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b550175e3sm28273536d6.11.2026.10.09.14.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 14:25:33 -0700 (PDT)
Message-ID: <c2bb04d3fcbfdfe3a92a794800dcb0331cc78a33.camel@redhat.com>
Subject: Re: [PATCH v2 2/3] nouveau: Fix NULL pointer dereference in
 GET_ZCULL_INFO ioctl
From: lyude@redhat.com
To: jim.cromie@gmail.com, Danilo Krummrich <dakr@kernel.org>, Maarten
 Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Dave Airlie	
 <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Daniel Campos Ramos <Capitain_Jack@yahoo.com>
Date: Fri, 09 Oct 2026 17:25:32 -0400
In-Reply-To: <20261009-my-fixups-v2-2-839e2bbe514d@gmail.com>
References: <20261009-my-fixups-v2-0-839e2bbe514d@gmail.com>
 <20261009-my-fixups-v2-2-839e2bbe514d@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YXMM4DSMAPwn5JOHNMCo1fyNdXFs3PzHNkSIOZ-9GJ8_1791581135
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

Just for patchwork's sake, since the tags got stuck below the ---

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Fri, 2026-10-09 at 11:44 -0600, Jim Cromie via B4 Relay wrote:
> From: Jim Cromie <jim.cromie@gmail.com>
>=20
> When graphics engine firmware fails to load or initialization aborts
> early, nvxx_gr(drm) returns NULL. Calling
> DRM_IOCTL_NOUVEAU_GET_ZCULL_INFO
> causes nouveau_abi16_ioctl_get_zcull_info() to dereference gr at
> offset
> 0xf0 without checking for NULL, triggering a kernel page fault.
>=20
> Validate that gr is non-NULL before inspecting gr->has_zcull_info.
>=20
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
> Aug 14 09:21:52 frodo kernel: BUG: kernel NULL pointer dereference,
> address: 00000000000000f0
> Aug 14 09:21:52 frodo kernel: #PF: error_code(0x0000) - not-present
> page
> Aug 14 09:21:52 frodo kernel: Oops: Oops: 0000 [#1] SMP NOPTI
> Aug 14 09:21:52 frodo kernel: RIP:
> 0010:nouveau_abi16_ioctl_get_zcull_info+0x17/0xa0 [nouveau]
> Aug 14 09:21:52 frodo kernel: Code: 00 00 00 90 90 90 90 90 90 90 90
> 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 48 8b 47 40 48 8b
> 00 48 8b 80 70 02 00 00 <80> b8 f0 00 00 00 00 74 72 8b 90 c0 00 00
> 00 89 16 8b 90 c4 00 00
> Aug 14 09:21:52 frodo kernel: Call Trace:
> Aug 14 09:21:52 frodo kernel:=C2=A0 <TASK>
> Aug 14 09:21:52 frodo kernel:=C2=A0 drm_ioctl_kernel+0xae/0x100
> Aug 14 09:21:52 frodo kernel:=C2=A0 drm_ioctl+0x2e0/0x560
> Aug 14 09:21:52 frodo kernel:=C2=A0 ?
> __pfx_nouveau_abi16_ioctl_get_zcull_info+0x10/0x10 [nouveau]
> Aug 14 09:21:52 frodo kernel:=C2=A0 nouveau_drm_ioctl+0x58/0xc0 [nouveau]
> Aug 14 09:21:52 frodo kernel:=C2=A0 __x64_sys_ioctl+0xb9/0x100
> Aug 14 09:21:52 frodo kernel:=C2=A0 do_syscall_64+0xe2/0x560
> Aug 14 09:21:52 frodo kernel:=C2=A0
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Aug 14 09:21:52 frodo kernel:=C2=A0 </TASK>
>=20
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Tested-by: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_abi16.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c
> b/drivers/gpu/drm/nouveau/nouveau_abi16.c
> index 3f130cd4fbcd..c7ddc54a3c4d 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
> @@ -358,7 +358,7 @@
> nouveau_abi16_ioctl_get_zcull_info(ABI16_IOCTL_ARGS)
> =C2=A0=09struct nvkm_gr *gr =3D nvxx_gr(drm);
> =C2=A0=09struct drm_nouveau_get_zcull_info *out =3D data;
> =C2=A0
> -=09if (gr->has_zcull_info) {
> +=09if (gr && gr->has_zcull_info) {
> =C2=A0=09=09const struct nvkm_gr_zcull_info *i =3D &gr-
> >zcull_info;
> =C2=A0
> =C2=A0=09=09out->width_align_pixels =3D i->width_align_pixels;

