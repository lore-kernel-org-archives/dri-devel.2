Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2FBCA6017
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 22:19:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCB4E10FD9C;
	Thu,  8 Oct 2026 22:19:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="HGyACWWa";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A247610EA43
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 22:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791497956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pudxvFGTr2pB6xfMIe99TlxTGdnfY6LwYZPysrmQyfo=;
 b=HGyACWWak+fhQ1ycRGcybgTAH7z++RStQgn2rJVpidQx3CYyFJh1y+PFHy+Usq1uw603Dk
 uHKiESNlsXcZNKQJURKFSUbqCt8zjbiRzm/URZVat2BfNiuOaDnBo6ZDFDkoGCLll2KQx+
 BP07fCH2964xVzOdiCUgI6vkUPeRduA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-s5nAC53CNkGD4jV-QjS3Sw-1; Thu, 8 Oct 2026 22:19:13 +0000
X-MC-Unique: s5nAC53CNkGD4jV-QjS3Sw-1
X-Mimecast-MFC-AGG-ID: s5nAC53CNkGD4jV-QjS3Sw_1791497953
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e82060977so303329685a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 15:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791497953; x=1792102753;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xivNdc/2GIXbbGG/+ABdmEro/TPM8rs2SiF4VzboSZQ=;
 b=YE2dhS3ZbqY9IUeZKMAyrnGIsN5D6dsp/LFrJFWu0RuOOKbU/ADBj/F6P8H6IVXO8+
 mkCSJ24FDOI+S6U4HlX2Fi60st4/ulgLILE2X5kiJDPbG9zvHRhNKPxLDJW73IqJHcZr
 T5ZwqRPZTM5coTWgCBtBHK3MQRKYCJoavNBNVuGJ4pQMfjL3KDzEUy/GC3jAMIJ+CLJl
 LvGdCs8yZFaD0ae6jZtIgwXFoApk7fpCU3D3DfJvQZ16aPTmFtmpsqtluqN1SYdWGq9R
 uJ5DhdXdduyysx07zAeCg3oUMb+QFoR9XNs3/wrYgRhRl48qrUNKlXpv1+iszJJlPilD
 iMwg==
X-Gm-Message-State: AFuF++mt25AEyX2kTtPuJDRzseMzPdZaAcqsBWwZznFtrIgwlHUhqE0K
 GcdDQ/bB5ZzJwNNe6HJj+nwCOr5NK+8bWQGg7u6EVLp1M8OuZQyHjVYNfJmGka+QNJezTIysWW3
 l6jFJwa3zyArao0hHy4ZF8xmJXOMh8EVOTj7aQAUfx81VWGZ40wxFDf7hTyEOdou+oYSYeQ==
X-Gm-Gg: AYBFou0vMunoYdCXj3H8Jhqqg87ynYl5Z0o13mOxzHwdYMyyRoS7l3wOd3kFve5QKVt
 oLOUtRXet6+MydBwirIFFUDO78KPUUavzLYVPmPxcy1/TITgm1IWHAIAxwaEh9YUSpuD6FKDW7l
 M+0VKfI5fgcR3sOXI+vHYMy6t0kyScyjoTb9Bzt2flpl/0dxfUb00+yyXvCl3D5J9exMB9Gqcdd
 QkxHaa+aF4cj2p5wJStqdIVkwzT5OOMX93FOyAQnWguPtnF2jG09GNtUnQ5sGHdA5SptSCpl/zA
 n/rroqtkquDB1CwksU4Q/NkcXNVV1iMcWM7hOxEBHP4a3rdr4McqKR6/N3dxbxr8enPQRqs=
X-Received: by 2002:a05:620a:8389:b0:93e:9808:2e1f with SMTP id
 af79cd13be357-93eb96ef267mr79425185a.44.1791497952866; 
 Thu, 08 Oct 2026 15:19:12 -0700 (PDT)
X-Received: by 2002:a05:620a:8389:b0:93e:9808:2e1f with SMTP id
 af79cd13be357-93eb96ef267mr79420785a.44.1791497952277; 
 Thu, 08 Oct 2026 15:19:12 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93eb9847f9dsm38714285a.8.2026.10.08.15.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 15:19:11 -0700 (PDT)
Message-ID: <4e16aa7b2a6bba489326428a4fc7650ae8adcfcb.camel@redhat.com>
Subject: Re: [PATCH 2/3] drm/nouveau: Fix NULL pointer dereference in
 GET_ZCULL_INFO ioctl
From: lyude@redhat.com
To: jim.cromie@gmail.com, Danilo Krummrich <dakr@kernel.org>, Maarten
 Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Dave Airlie	
 <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 08 Oct 2026 18:19:10 -0400
In-Reply-To: <20261002-my-fixups-v1-2-a83d20f9d3fe@gmail.com>
References: <20261002-my-fixups-v1-0-a83d20f9d3fe@gmail.com>
 <20261002-my-fixups-v1-2-a83d20f9d3fe@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e7905qtI3n9f91lDGh4bhMQSUSR_7z9m2FvRZh-PssE_1791497953
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

On Fri, 2026-10-02 at 12:09 -0600, Jim Cromie via B4 Relay wrote:
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
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_abi16.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c
> b/drivers/gpu/drm/nouveau/nouveau_abi16.c
> index cb1810dee8e5..0871ac025ace 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
> @@ -357,7 +357,7 @@
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

