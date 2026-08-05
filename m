Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F28C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 18:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5FFA10E0F7;
	Wed,  5 Aug 2026 18:49:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="DgMGd6oZ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7A6510E0F7
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 18:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785955780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D/EU9EVSboKco9470bPT/jGMXPeGjUQzJn76uvcSda4=;
 b=DgMGd6oZX+At9VfgYLcI5XlseJvU5vmWzmcX54YI1N+tMCBCUSpzLOx5xV4zsqbyT9Od/8
 4O4eWMeGcN7x2O5jgBr0/XfJcF+g4PvOdDjIWbQmxqdIwVa4nI/cLT7fNHV5aIjwppAtp7
 C/si1AAzCvyKWlTYjfBwRotrMddGlLQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-hKYL_v9oPYe531cTVfwSMA-1; Wed, 05 Aug 2026 14:49:39 -0400
X-MC-Unique: hKYL_v9oPYe531cTVfwSMA-1
X-Mimecast-MFC-AGG-ID: hKYL_v9oPYe531cTVfwSMA_1785955779
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e55721a8cso128650585a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 11:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785955779; x=1786560579;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3hJIV19g7hzV4U2eQYL2xphnDrR3wJqKfXXYljP96rg=;
 b=SczE1NXZFss8+y571I7eIKzOvq7OX/wxRap32b03T3uC7y8GyvnSx7YLfiPsuo8JCD
 ZHpIzmLaEA+RZ/26pUbgqXRbA8vNFKakU4dH0v2AiS+w6prWrwzrC/QtdynsN7TZg51H
 u/IJkzGf3d28e4H2V8+wzLpBdisJ9gW+AdMRUFe5bZxYn8zvlQHtkPrxuXSbEC8l4a5Y
 9wb1fTGu2gFAL5S2cOXJWIJcu7dAX3HPLAHskqTdduCCh377MQ3lsYw+Fq/vfjiVmDf9
 LS7S5t9xGsw5weUSJCP+xWoUvn43YL+XuIyzdgz7TL6OhfbfSHKGTRHvmzjOkMxLGDwG
 K2iA==
X-Gm-Message-State: AOJu0YxnXp9hsPsDW+zZJXC3pEZdWlPsEIyOQvezyXd3ZI+BbuLFZ5IR
 G5jPdzjLbsHA+iZ2xzgLsIH6LMOrD8HPTa8JIS0UfvVcoEoQidBVlVaCIAOLOsdHl+spY6WoNTc
 Is4XSEVJXFMXpL7A6ZK/pa5gLOmBWjtF7d/P3rq+gv+z35UkxoHAjIpKzcFsWmcy9Q5ljOQ==
X-Gm-Gg: AR+sD11vgQwqrK2tCZeI+sBETwSli3dYjgX0E7n8zyeaslgq8hqLC4fEZ16W78HuB0c
 +gGmZoECMiMZuls+E/++ubSvORDQv4rFgdM6gBlBT1uoICZ1OSw5rSxOEcz7Wascd3TedIjX1lu
 KKWsaYuRq1P+PzmmfexilAMYn85hp8R/n166PrHp+mdnvLa1k7bNEfwfJk04gdIOy6vKIhB1KX9
 EeVqL6jzwnYjGk5mSpOyPL1hjHGEHWR9BsfEyCXtwDHUtMJCt+J8kzWNio/YOQw5BkFmJAPM3DW
 vlHTZsCe9oOQmMeDG/IobNmkjupftKc6+SIPa+cJFz2THpF81cTSNn4cxt6ZqSpHx8CZGLHs
X-Received: by 2002:a05:620a:4090:b0:932:dd9a:cdd2 with SMTP id
 af79cd13be357-93649112c98mr804335485a.5.1785955779158; 
 Wed, 05 Aug 2026 11:49:39 -0700 (PDT)
X-Received: by 2002:a05:620a:4090:b0:932:dd9a:cdd2 with SMTP id
 af79cd13be357-93649112c98mr804329385a.5.1785955778639; 
 Wed, 05 Aug 2026 11:49:38 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9364a597e2asm215171585a.43.2026.08.05.11.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 11:49:38 -0700 (PDT)
Message-ID: <46aebd6a4caddf377d61dc251e7b4838f409de6f.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: Wire up dmem cgroups
From: lyude@redhat.com
To: Natalie Vock <natalie.vock@gmx.de>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Date: Wed, 05 Aug 2026 14:49:37 -0400
In-Reply-To: <20260410081322.5577-1-natalie.vock@gmx.de>
References: <20260410081322.5577-1-natalie.vock@gmx.de>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MgWH1e9EcHuFTFcyAb7n5Li9ThrA-jlYEHbh9DnKv_I_1785955779
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

Hi! I'm sorry, I have no clue how this patch got overlooked. Thank you
for the contribution.

Reviewed-by: Lyude Paul <lyude@redhat.com>

I will push this upstream in just a moment

On Fri, 2026-04-10 at 10:13 +0200, Natalie Vock wrote:
> Userspace can now make use of memory protection via dmem cgroups. Let
> nouveau benefit from this as well by registering the vram region with
> the dmem cgroup controller.
>=20
> This patch adapts the approach amdgpu and Xe have taken for enabling
> dmem cgroups.
>=20
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_ttm.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_ttm.c
> b/drivers/gpu/drm/nouveau/nouveau_ttm.c
> index ad01f922aa86a..860bca7e3ce28 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_ttm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_ttm.c
> @@ -188,6 +188,11 @@ nouveau_ttm_init_vram(struct nouveau_drm *drm)
> =C2=A0
> =C2=A0=09=09man->func =3D &nouveau_vram_manager;
> =C2=A0
> +=09=09man->cg =3D drmm_cgroup_register_region(drm->dev,
> "vram",
> +=09=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm-
> >gem.vram_available);
> +=09=09if (IS_ERR(man->cg))
> +=09=09=09return PTR_ERR(man->cg);
> +
> =C2=A0=09=09ttm_resource_manager_init(man, &drm->ttm.bdev,
> =C2=A0=09=09=09=09=09=C2=A0 drm->gem.vram_available >>
> PAGE_SHIFT);
> =C2=A0=09=09ttm_set_driver_manager(&drm->ttm.bdev, TTM_PL_VRAM,
> man);

