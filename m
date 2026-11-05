Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007F8606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=U3XFfRbT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63E5110E0EB;
	Thu,  5 Nov 2026 18:16:50 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5923210E0EB
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 18:16:44 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-8b2382bf051so545995b3a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 10:16:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793902604; cv=none;
 d=google.com; s=arc-20260327;
 b=CbLH8wXlmC+se6fkFGMZAGLeMb2WDbcH0103+Klb2W/ILfD/HYjG0hgi8034AY9LZD
 NG2KDwb1OEjzu5rR8qpQeHQD54Aye0+62RESw5njae0HaWqBxfzgStBSmXezYNtQdP43
 PC8npMNKwol9hHivTyx+ytnKpWliu8maZzNL6dIwHypMHUrgmjl6aFRl47TyJmRfAKn6
 yCM1pE4li7gmO6EEY1o0UkngiIgDJSK3wX6CR9GU8rP1e8beDSqK3ahD9mGtPI37xPVl
 VhZAsMewsLpQiaLVih5jvJL5NMSd5poMGZvoLT6hLHKlxEFYE7a06hAAui7SMjlvpTPn
 EPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FRuHktTDVKwo5RvXXcGGk8C8OZkIyyUELpQy8s7GxcI=;
 fh=T6Wn8nru657PTsC/U67WJvvmBSZjWJNsG9tLARltAqU=;
 b=kETax752kXJGNhITNeC77OKa6DTNYOdlL8jOCD7YX9FF6H4XmBXN2xKGd0zAhTHon7
 IVm8uEI6ZI6hNHgvqytWoROmFnyfk3C6prTUG16ZueUY1EcK5eA6J16DvZv9i55lI9QJ
 4HRTgL5PEu7W6PfecPvpbVlSpbEBnUSnhs4dNlkg/DxjhC2DCYZEh8N0PsRHgY4bg0m9
 qF9ZSA/CVWPhSEXk1lH+VMdr2XuWNvdf/sP95Q5knUttYRS81KUPlSiS8QF1kMQPFDID
 mJDkC/6OCI0OIZe2In3FmjSyiaic9PknDH7198X0RUiMFamSJ9MrX5kspJs75SWLL3sG
 xfjA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1793902604; x=1794507404;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FRuHktTDVKwo5RvXXcGGk8C8OZkIyyUELpQy8s7GxcI=;
 b=U3XFfRbTYr7bZzwTc5X99pr53jnust5+391KUMJgK1Pk7nN5y4HDw42pyO9TMQuZbu
 Q6tCqaxd6MmZ/k0z8/haG88/gA0zvJuLiHuVN2oW3zUQm+KYn14syCXQHeZ/8W8g3Y6G
 aKTXECpnYXJ4V+ZaPKwmUzkJ+SC/2aHfphdDaaDYCz90pvp6dqvib+lWUTpEr2IdrR3X
 5U9llXjxQyTx2VAJ8a7BjfKKAv6E0TdJDfok3JkoVDvdcWWBiEZ8ZjtbzNo3XspR6imf
 QsDL/F5rG47dRxrXpOt6/edfTw4p0NGV++EjPjdeLG8G/jPO5xGhSF7/QDLEncbnvukX
 QcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793902604; x=1794507404;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FRuHktTDVKwo5RvXXcGGk8C8OZkIyyUELpQy8s7GxcI=;
 b=Win/Ayx1a9N6cMBFLO+pyRyqyQ1vvcEzssZ7iOhYAZNujuGHfAfhWKgPiiiUolQvKA
 s52xPzmnBK5bks+F1vMUfEZ5DpQBLp8GHEMryIgRbO7mdNpUpBKu+7Y7bo1f3KlcQfxR
 JnAHVmQD69OLYl8R1spOGlraN3y08CwUaJU8ewp8jPy+ZnOpxZr/plHmyF6NQZZePd+L
 GpU30AfqRzW+KS8KoFrQCl/42IXTvO0k64rKs6wCMxhQKwBJzLQcNf4Vlyg8qxOOELV1
 7Fg4nI8AB9jD2JqsBcU7eyFYs6Kveel3LWsw4DKqxvs7ZUxCAIkaPceQDJeIaNbGkwbh
 d/5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwrUGvGI8Zh/d6pgDSfZOC89f4vDg61Rzu+JvxCLOBhuBdI4Ns3gQYhLeRMfKlX+jUApoWWgqGob4A=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z854mN7gw8NArwJdiSb2cwtKjbehu/QRwOj8n96/KOmYwFmOo9d
 ug3jm8BwJs94+ykq4f/adzBtuN1Uj/OZIN/c+VgknrK7JYQp1PYi7rYXbV6hzwYgNXjaAYPnx5i
 WI+1vp+WIfFK2w/6AkxdBHybfuRi58CtMfnu5xKcXRQ==
X-Gm-Gg: AYBFou1/NQLWm7irO33drBVv5eJPT4Kob7bNfhKPcRfZk4F/0dUEd2mgbUZVlUNRHPC
 XovTfBrv6BF9aMqPgQsKLrtusT/TU7IQVeN36YOu4PIQufg2GfNgTwLKM+BbT394ex2XwqfxZ3y
 s7UXg+7PHPV9nqpTt8ij7fw4vUv/lmXx5zWGukNagdgA4hiQFw5tfXBPE6s4bBTaT0jhW55WXIk
 +xARmRlDT5mclbAbyDMcvt89hS+CUzy53Yq9UEu78IVUq9vZX2s1x3oEu9e7aT5SlrC2OTm/Zyf
 TtExHQEyEB07+gS96yudLx8tYZruCc8ayn7cR32DA8nu9YvIWu5WBGm9ROqEH+jTgVWRCKtrCTi
 LOMQ/3ghd74XRyQNwKJnKel/as4XE+nk7tR7T
X-Received: by 2002:a05:6a00:2e10:b0:89f:600b:610d with SMTP id
 d2e1a72fcca58-8a9bf3371bemr17651793b3a.31.1793902603859; Thu, 05 Nov 2026
 10:16:43 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030-panfrost-rk3399-pm-rt-v1-1-e94437159a9d@iav.lv>
 <autNWETrwrHbD2H9@sobremesa>
In-Reply-To: <autNWETrwrHbD2H9@sobremesa>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 5 Nov 2026 18:16:32 +0000
X-Gm-Features: AclHuK89M2SkDj4GupZYw3Cx5gF7O7bIl48XC-kBSDLQ8-C12o5Bi1k93zrIM-g
Message-ID: <CAPj87rMoGhN6yew4tcGeTjrG87685f2cdrmkHFZ91CwfgXx0fQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Gate the RK3399 GPU clock in runtime suspend
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: iav@iav.lv, Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Wed, 4 Nov 2026 at 15:40, Adri=C3=A1n Larumbe
<adrian.larumbe@collabora.com> wrote:
> On 30.10.2026 06:43, Igor Velkov via B4 Relay wrote:
> > @@ -983,6 +983,7 @@ static const struct of_device_id dt_match[] =3D {
> >         .data =3D &amlogic_data, },
> >       { .compatible =3D "renesas,r9a08g046-mali", .data =3D &default_pm=
_rt_data },
> >       { .compatible =3D "renesas,r9a09g047-mali", .data =3D &default_pm=
_rt_data },
> > +     { .compatible =3D "rockchip,rk3399-mali", .data =3D &default_pm_r=
t_data },
>
> You're effectively adding support to a whole new SoC. This made me
> wonder, are we sure suspension resumption not working is only because of
> GPU_PM_RT? Shouldn't we know first about its supplies and power domains,
> and any potential GPU quirks? I think this goes beyond my knowledge, so
> maybe Steven Price can pitch in.

RK3399 is an extremely known SoC. It was the flagship for Panfrost
development for quite a while, has really wide community usage, and
quite a few products shipped on it. I think doing runtime PM on RK3399
should be absolutely fine.

Cheers,
Daniel
