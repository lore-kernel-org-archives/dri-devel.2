Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8DDCD342F
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 18:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0A3610F5B7;
	Fri,  8 May 2026 18:29:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="AuY18KS1";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8295F10F5B7
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 18:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778264988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3YM2yIxFZng8udCyyxfJNqN2OWJuimyAwuqVc1zr66I=;
 b=AuY18KS1/wtMYVqJcghbKKi9RT7YLfQeuMgdz9fcScS4r5LeirS3YFDP3gk/2vmDERiv1w
 nIdp4Xj69YgE6B8XdZL4u/3rzv+ub9eS3JS4ZDzbY0xeI0CzRz22l82LPyG+2oF4hau19q
 yCoisNAe2kjjZy/UnUyaevVtFtTPF2Y=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-sYoIF1Z-PU-01TERi6bgFw-1; Fri, 08 May 2026 14:29:45 -0400
X-MC-Unique: sYoIF1Z-PU-01TERi6bgFw-1
X-Mimecast-MFC-AGG-ID: sYoIF1Z-PU-01TERi6bgFw_1778264985
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8f461b583acso235585185a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 11:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778264985; x=1778869785;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ts89bXnsydMC3S8XTyf/KWj9UES6R504LBZEUkz/MQM=;
 b=YLGnJNXHf+AbFQxf5NDeCGQQpVsArHR/X+ckBV3A5sKsv2LRxYpGWd9q4raxTdeJ6E
 6txhBuT68T6bYYzwEA6e/L99US+gFPAJVlxoZyrfL+KPKlpy7qKyMAk6HR1ZS0p3vMU2
 rhouYOAA8adk3t0+iGG5dPaaRlXQDKhZXpA/t6BKL7GeQN6YalfiL4Q4O2N5BrsuwTzl
 x9JMqVnQtNa93WUQ+3FwaujNrpnqp2y43cK+YmkJeyyThtnBOVjC7z+l/pc288Iv6cp5
 5ju8TLXyTdpZ/pLii2WgscBNHpUJVWOaMDBlm/qy/XgMb3Up6o2lQ0WTN9je0Ma/KACZ
 zRew==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+eFpNzZZzlbj8IKTmP1tFty3uS2GB4U1wdNtbeRmnMeAh7L9UOFclriBIUltFrkFHp6/ZCKUXuTw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxHwTWiH1w0LK9d4V0gQGJ++akDqkUk46Q7j99UQLno2qDoCwuu
 inHFDy//F4jSpC+1MGQTAJvKTH/DHYuBW7vAGC7KxR1cQvXSyILGZXORjMMOVm33x69BnlLrcOy
 T6rqoFpuFuTYqkLezk7agR/wFct0mHBFoAdl2b4L5wkbOpJIVu7oYsJMv+/SyIoKRGbPJLg==
X-Gm-Gg: AeBDieuUowULvP8VTSRsJE/WWH2GT632AMcBN5voGCkTFFR6C9jEm+ZNRNjQfhZm2YU
 JevJR5AWcNlTrRYyt5ua2Xt0iotCVF9alIkha/7CtOCmSJs8rg3lYEw5bt9fWQH7feypXuFpLUx
 hINUoc5Tvkqd9aL0LpWUpgF2QwnNhqeheaRyCocfDdnN8t9p2QG2kdFFQOv9pT3eqBwIoo+Xf6T
 Tez+MB5eQPrKorSSo9b9Nng829oJCcCy2ceEJ+Cz0g7AJRFgcuMR4mbe47agUFnzaC1kCNFOwgC
 CjfFWj4ldxf9W3dzUxQhFnDkYMPGhLe/8OyQtWHBwojvjo/UK7oNH5BAXO4h4I11Gb72gjhs9I7
 qyx7zKq/fGGtb1prJ5g==
X-Received: by 2002:a05:620a:2586:b0:8ec:7323:9361 with SMTP id
 af79cd13be357-904d72b9151mr1971901185a.55.1778264985002; 
 Fri, 08 May 2026 11:29:45 -0700 (PDT)
X-Received: by 2002:a05:620a:2586:b0:8ec:7323:9361 with SMTP id
 af79cd13be357-904d72b9151mr1971895885a.55.1778264984558; 
 Fri, 08 May 2026 11:29:44 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-907b8e98521sm278551985a.17.2026.05.08.11.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 11:29:43 -0700 (PDT)
Message-ID: <3b324ccebe4ce6f49f6ff7c9558408b9484589a4.camel@redhat.com>
Subject: Re: [PATCH] nouveau/vmm: use kzalloc_flex
From: lyude@redhat.com
To: Rosen Penev <rosenp@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, "open list:DRM DRIVER FOR NVIDIA
 GEFORCE/QUADRO GPUS"	 <nouveau@lists.freedesktop.org>, open list
 <linux-kernel@vger.kernel.org>
Date: Fri, 08 May 2026 14:29:42 -0400
In-Reply-To: <20260312195529.13002-1-rosenp@gmail.com>
References: <20260312195529.13002-1-rosenp@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pOhODs3709FuMhVYvXWD3Dt5PnBlzRT-WA4DK-zgvRE_1778264985
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

Sorry I didn't notice this patch until now!

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push it to drm-misc-next in just a moment

On Thu, 2026-03-12 at 12:55 -0700, Rosen Penev wrote:
> Use the proper macro do to these sizeof calculations.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> index 958fd78080bd..b9648290dffb 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> @@ -53,7 +53,7 @@ nvkm_vmm_pt_new(const struct nvkm_vmm_desc *desc,
> bool sparse,
> =C2=A0=09=09}
> =C2=A0=09}
> =C2=A0
> -=09if (!(pgt =3D kzalloc(sizeof(*pgt) + (sizeof(pgt->pte[0]) *
> lpte), GFP_KERNEL)))
> +=09if (!(pgt =3D kzalloc_flex(*pgt, pte, lpte)))
> =C2=A0=09=09return NULL;
> =C2=A0=09pgt->page =3D page ? page->shift : 0;
> =C2=A0=09pgt->sparse =3D sparse;

