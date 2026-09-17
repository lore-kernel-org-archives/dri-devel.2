Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74474C982D2
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 22:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B53AB10E4C5;
	Thu, 17 Sep 2026 22:11:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="dlfRg/Dh";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FC3D10E4C5
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 22:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789683101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S6U6C2auesxaluxxDRg42OWIqsobC3AFy0qVLLWaE4A=;
 b=dlfRg/DhRWbOWxbR2i5gWPI80X2TQN643nPuO1fT0cwVAf51opTtZWNWd+2w1Aw/syoVVJ
 WcVYp4EqytHelxbwZvFyjKOXjzSxyC7VEM2I0cn/pErF6PzTK9RiJgjF7PUAbSMMDm+vhc
 aMnYDIB7Wb+HL7wNLstyA3ncJ79HR0g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-37svgeXTNgO_ARsWFXigVQ-1; Thu, 17 Sep 2026 18:11:40 -0400
X-MC-Unique: 37svgeXTNgO_ARsWFXigVQ-1
X-Mimecast-MFC-AGG-ID: 37svgeXTNgO_ARsWFXigVQ_1789683100
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9104c2ce026so4157306d6.3
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 15:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789683100; x=1790287900;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O71094SnvEzOsUSd9r3JWt4fCSADbtCWy3jIsFoSJ/s=;
 b=CYiXX+qEiBntIowmJg5WYQwSamSvRsuuNmq8YP06IlQGFzSsASP75m3bOkFL1YlMOf
 vZjFSNzt/w2NNYgi67bxo66/uqDEbcXQMUWhelk2qQK0hxKbSZmhHMWiA8drVXqlBlUS
 OVw1Hv59y1Lf+1KXE7bjnX4EuQdAyxlCA/snsybt6DzUxqgX3i/bvC/gNoA+f8NTbI76
 y3Ojtba2i+uYh8b0tCpTtoHpd6UGcqC6r1/6pnHViq9cbMammd7qV75wnVgnKurtzHK+
 2INQhAAaugD8CAInnLETFyxLuzL6hWls3N5LClDuaTIX7MCREBhVmt5fcGz2gJUve13B
 Ljyg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzaLVWFGriUDK+gpmGzB3axr2ShwAJemv5hl14l5z082H1V2dAQOcmpJvlcuaUDv3x5XDyneRlFoOw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nbdWCYOx0btOaPUlDpeNa1TomJBf0wZLk5ZJpNmGJg/maWoNpH
 6X1tZiIKvZXHNbqW0KYeiyYTfJqB7KHfgOq0cvgQnJCMkZc84uSVCNS6HZsYqfqyFecwsMp/aZD
 1R/jeBRb8qq99pgUVIXh0cOc9pIGFFsbi1+yAcV9C93hp8fH8kIEBriVkjrQlDc94fAM9qA==
X-Gm-Gg: AYBFou28lwSZzXM0EniEsLq8uVVDgF/u0xKOeaIr/mx23OHYPc4MgTIx8knRFu6LVfg
 JWe8O39r7/wHKvcQ2jeJG8CXwdZ9//ey8MAYi9m3C/uCwkjNcyO4YnznTQ2KW2GDFl45F0I7cLJ
 c6qPw4TypuCpxT8Umf6dwSowgmZ9tHhxqN1mIKV8+MkCkgMhJdq2GW0uEC3hAcoPBZ1kLNrLRLw
 +9mdh7QpqW2VlFedsN7SgBQyxsjGlVCg/eFbjcqHEHBIahx9pkinVQaniBOFqsVlsreXan2FG3/
 6bUUzDjMt88kA7+ojAMzHwtwfWniiTPj36ZJ76pGo5cT0NPlyFMBKqGuMIwT/hO3zD2SKniQ
X-Received: by 2002:a05:6214:6110:b0:912:517b:913 with SMTP id
 6a1803df08f44-91254cd0952mr9605016d6.50.1789683099514; 
 Thu, 17 Sep 2026 15:11:39 -0700 (PDT)
X-Received: by 2002:a05:6214:6110:b0:912:517b:913 with SMTP id
 6a1803df08f44-91254cd0952mr9604356d6.50.1789683098863; 
 Thu, 17 Sep 2026 15:11:38 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-912568b9646sm142846d6.31.2026.09.17.15.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 15:11:37 -0700 (PDT)
Message-ID: <8ae8462fb2f74d0ab1a1d6ac663fa3a90d57ff5d.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: fix autosuspend cleanup during teardown
From: lyude@redhat.com
To: Guangshuo Li <lgs201920130244@gmail.com>, Danilo Krummrich
 <dakr@kernel.org>,  Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann	
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter	
 <simona@ffwll.ch>, Dave Airlie <airlied@redhat.com>, 
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Date: Thu, 17 Sep 2026 18:11:36 -0400
In-Reply-To: <20260808134137.2864847-1-lgs201920130244@gmail.com>
References: <20260808134137.2864847-1-lgs201920130244@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7F87KSpFwsqyLeHwVJqM3XAhBOMkICgxrUUvGUpZ9DQ_1789683100
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

On Sat, 2026-08-08 at 21:41 +0800, Guangshuo Li wrote:
> nouveau_drm_device_init() calls pm_runtime_use_autosuspend(), but
> nouveau_drm_device_fini() does not call the matching
> pm_runtime_dont_use_autosuspend().
>=20
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during teardown, this reference is not dropped and usage_count
> remains
> unbalanced.
>=20
> The documentation for pm_runtime_use_autosuspend() also notes that it
> is important to undo it with pm_runtime_dont_use_autosuspend() at
> driver exit time, unless runtime PM was initially enabled with
> devm_pm_runtime_enable().
>=20
> Add the missing pm_runtime_dont_use_autosuspend() call to the common
> device teardown path.
>=20
> This issue was found by manual code inspection.
>=20
> Fixes: 5addcf0a5f0f ("nouveau: add runtime PM support (v0.9)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_drm.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c
> b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index e16f59b00f6f..1579a4b0785e 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -585,6 +585,7 @@ nouveau_drm_device_fini(struct nouveau_drm *drm)
> =C2=A0=09if (nouveau_pmops_runtime()) {
> =C2=A0=09=09pm_runtime_get_sync(dev->dev);
> =C2=A0=09=09pm_runtime_forbid(dev->dev);
> +=09=09pm_runtime_dont_use_autosuspend(dev->dev);
> =C2=A0=09}
> =C2=A0
> =C2=A0=09nouveau_led_fini(dev);

