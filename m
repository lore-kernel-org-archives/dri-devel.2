Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49741C43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEBA810E2CF;
	Tue,  7 Jul 2026 11:02:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VoDwfDV/";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F72910E2CF
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 11:02:41 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so2518870f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 04:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783422160; x=1784026960; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2+fmtT98uZzQVGA8vxU1FmKdk2jnMlEMMwuI9Mk+cKY=;
 b=VoDwfDV/FuVImbuTqcygPeyBExbAixEqfYeZfUZY0x74951aKDZNfxSEoJ5qIxLwsn
 xWdgNAW7Fdema8YEHhQCCibIlOSOzHtfsgQOuobpodvFOgUhzvxAZDmSfyGG47bQ9dJo
 i9YmEX9ajs+zK779dLZL8OAIK0iLBUbLIyFzA0zLMM5BiaG1ZYvxAoG21LINHZWMApYF
 6PYkj+SxSOT3Y1vuylMZuidhazk+pPvWWrVZmadKuuFQZHjbS5uMF+TsvUAdoETJmLXt
 8jKADk12rrNBYnbK/owowbBPQy6mlbpun7xn5ezE91ITezsnfE4onYBwrixuDnHwJrEl
 Ckvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783422160; x=1784026960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2+fmtT98uZzQVGA8vxU1FmKdk2jnMlEMMwuI9Mk+cKY=;
 b=Bs6qD5K9rsQl/BwPuMSZmEiaAxGlQHGONYdxIxLd2gx6bALTl5V0WYgJ1oEWYjmw79
 BVwgzrHs5HmROzYmfgLmiF4gnfQQrU6ZO+9i+jpYpCRS4LRyLz35+jr3VSZiu0PCYUqj
 N7TjSmwOMS4E4ckcOnDOUAS+xlt9HDY/YhDD892LobCgEtUCsstXKj0+pE3kCANsRJrr
 moDDK+3jWhnSty1tgUP/vGG5Q3nXYJbgukl5qclPgIIWAoXtdqLCGxKX5sgvcyooHgiz
 J+pmy9mpVv+kuOI7I99tme3qyffqfk/W6RX3f0cosfN7G6+4+irDCNJXgaD83ildVYVH
 NVgQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqKTgjwGgF1I6mLXFmWthvqG8RVBZDaKWsyI+IFmD4+iZ653WE5YgxwWYe0BnunZ5PA2cju4Wzg6XI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxmegavSL+E1Pb7mZz4E8vqOQsDI9jmfhWQaDwM9jZ9LeKHX6jB
 O+9OEGOajLiSV6yohjJWKRXMy4SdGhn1hmtd1TA7/BcPtSG2UwDSn7tf
X-Gm-Gg: AfdE7ckuHadvlaHLDfC7Ka5cylus3cW4rGTgp1f24heacUH5ws/OuOEUbM5sVd7QUof
 /Cfe3D7ZlvPitXby4vmN/CtvtNA1td1+NGKG1TlG+vy3wsdoUWy65l6ZTA+JhdnmdCDG8varsSq
 H2wnVcWbvBnINgcKzySzBXGWTPZ7ltePBPuRZZPmUXlnpUrJLo6XSOXNFyBd7MTOelM+He8e+tS
 H8JNurGw4iXCC1Cc8xAZlxS1Ue95jYCktHECYI0w4+9Q97MzwZ8bVVlIozGTraU1ddueYbajNfb
 lNkIKeGAbtk3sosi11owNaTPoPCZC788jJwTrr9BTbupL/iJW6ov7OOtOZo/d/RukILucKmbV2J
 sBsgQsPF+TOzvwZeJdYrQQQvFg7wr6IRm1dkByDjQukbwhLbZzAhelc4eT08OySIO5oJu7wuLuv
 +WJsoTb/EC712RmmaxX/QvQB8S/mYxfasmcKcn9/7coupRw94SvY6cwcSLZRgioQ2zRVTqSUi4H
 Ihbj+bGSCx9zLxhEXk=
X-Received: by 2002:a05:6000:ac8:b0:474:b9d1:321b with SMTP id
 ffacd0b85a97d-47de669bbdemr4084319f8f.6.1783422159661; 
 Tue, 07 Jul 2026 04:02:39 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24D8E500AC9DAEE3E0CDFA47.dsl.pool.telekom.hu.
 [2001:4c4e:24d8:e500:ac9d:aee3:e0cd:fa47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1e6ccsm33426889f8f.5.2026.07.07.04.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 04:02:39 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko <mhocko@suse.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Kees Cook <kees@kernel.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Ce Sun <cesun102@amd.com>,
 Tao Zhou <tao.zhou1@amd.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Change system_unbound_wq with system_dfl_wq
Date: Tue, 07 Jul 2026 13:02:37 +0200
Message-ID: <12766042.8bMQJbFj6T@timur-max>
In-Reply-To: <20260707093812.109176-1-marco.crivellari@suse.com>
References: <20260707093812.109176-1-marco.crivellari@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2026. j=C3=BAlius 7., kedd 11:38:12 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=C3=
=A1ri id=C5=91 Marco Crivellari=20
wrote:
> system_wq (per-CPU) and system_unbound_wq (unbound) are the older
> workqueue name, replaced by system_{percpu|dfl}_wq.
> The new workqueues have been introduced by:
>=20
>   128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
>=20
> Usage of older workqueues will now trigger a pr_warn_once() because they =
are
> marked as deprecated as per commit:
>=20
>   64d8eae3f895 ("workqueue: Add warnings and fallback if system_{unbound}=
_wq
> is used")
>=20
> So change the used workqueue with the newer, keeping the same behavior.
>=20
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Nice catch, thank you Marco!

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c index 53be764968e4..95cceed4e971
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -545,7 +545,7 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev,
>  			 unsigned int num_dw)
>  {
>  	amdgpu_ih_ring_write(adev, &adev->irq.ih_soft, entry->iv_entry,=20
num_dw);
> -	queue_work(system_unbound_wq, &adev->irq.ih_soft_work);
> +	queue_work(system_dfl_wq, &adev->irq.ih_soft_work);
>  }
>=20
>  /**




