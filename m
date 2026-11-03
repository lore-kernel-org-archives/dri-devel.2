Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D57606D81C
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bIsWUus/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4732810F6D3;
	Tue,  3 Nov 2026 16:14:56 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E6D610F6D3
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 16:14:49 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so33050405e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 08:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793722488; x=1794327288; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RqgKOvUc0lsw73NwDA3YxCNWSPfGQRTkcWNoeJzwXQg=;
 b=bIsWUus/HmChAh8iLt8CUToxLwEkA9kG9a736b4MXc4c+98/1ZftDMfxAvQfoxfGZq
 NXkUQK8/F09KwcwOjLbr8Dp5vsVMVPH6QaB3MTXa3+x4u8amaXfOIwKDKNuj4GSnvaXW
 rUznTlKXWk2MXXKwsl00FHX4BhUNpMKVilSjwH8nn5GXTD7hkQrvyEbcYkRKT9zlvxu7
 Xyht4R9hCYtThLF8XOBLgRNnWtFKzHWW/OX6w+7QkfK5GdHCmnoUzqzn0g6oHDgUN6vf
 hGVbfUnjw5EOPcsIuY/S1FR/mvXC8bRoNrMS4GciytetG2tSidJIhwGgwXWjiuFgz9TB
 Bu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793722488; x=1794327288;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RqgKOvUc0lsw73NwDA3YxCNWSPfGQRTkcWNoeJzwXQg=;
 b=tQ4LL6/oEpbq8ogMRQfqdr5rQgXpSkYLK3Y2C8BlIxxAgFVo4Oenb4X2qENItrdlyH
 mVRDHGvFIHPJUy62Cw4NhxSTfk7hn1fkLRK2a7vnExlsNquvw9nBNsyzpHB1M/m5TMlP
 cTaiE6kusA3pz9k8OVRyaC0eAdUt9EV0ts/qhmsMH0WsavhWdQMaIdRyS0YgNER5Iycj
 fxvfZLmOzBSfu28uiEg1LDGCHjofXa93yEihzO0ndkVfMfBBXGKHkbZNiT7GeognFxoR
 DQk1tlQ41bflsvFik4s6p3w3oVuAzHciqLD/kPbOX4R0pWMLxPHhjpXOr/B/zXfHnwKH
 gIfw==
X-Forwarded-Encrypted: i=1;
 AKwUvByM34Uvk7My2eIOYWnD34vr1qKwryi3Yt0hWd7kD2qZ0I02XyhBg//pJIYL2rOGwh45vu/WGHE1eBA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+Nyiw+NyL6GNI8x1tB+r2jD3uANpi6wAyhqb8t5/SG+vCrdBXr
 eBeGruI7Oxd8d2rRG/7X6suFpvbfp4m3ySCxu7ZGXOrcmP+CpoHPwbzo
X-Gm-Gg: AYBFou2Lv7vwk5eW9VXIKddQy4sbMCJ4jmTICsnsWsVITbjcYvyDgdIygNt68ZsTEJ4
 VDMkulyZk2zrWR0eNbfcEdeWxvrgaKQ5r9qYDEFaSjvHFGMyAcwKSxlHHjRDwnqFjqbH2UtEBS4
 +c8CqUllP3z0rhGOpNeFiypIBE4KiOdOFQ6qQGpWP5t2f+UC7MNIsrpU5qVMO0bJWWZFliNaq6G
 zP3c/nh4+iy/xBNG1adn0OJmfe+w/rU/pKh2cYb2E16MMQIzXeovFVTxvLC1c862Lhx4xia/wpF
 OcykNuXBex67N1yHyY5gox9VjwXO9bqEAHDUc4yjHzR8lLzRJrdbhlS8wqaCLmIRT7Yg9WFUO9x
 tzHGKGcw9yDD2Rq/XLjoR7y+Wl7D6Oarv/85voB4e44EwKB6gKgkiOv2C5cJbZSPYN06xbEPL7F
 zc2NLdqGje6BIg6+eyI7c5yFB6LdFUR/zJ4u10SKgFqW2LSN77Lj+ZJMK8jgW0CzhoTxml3zZkH
 4e2MOcl4OKDMINUYpeLPWmXzLxH/2XZJpsNuNGWdW+o8gp8R34DuoIVfCul4C1uKFDERzfV1tPe
 EXy2vqKjuGZDrn+Oz9sS6gYpzRiR6fSP+44VM45h1+StUrM/88KiovUmc+nCMIE1S5LngpZyGyu
 Cvno=
X-Received: by 2002:a05:600c:8b2c:b0:4a2:5267:3cd4 with SMTP id
 5b1f17b1804b1-4ac151a8c26mr326782435e9.3.1793722487761; 
 Tue, 03 Nov 2026 08:14:47 -0800 (PST)
Received: from ?IPV6:240e:47c:50e8:6a2a:3e80:5afd:fac0:93a7?
 ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d5dfsm30433803f8f.3.2026.11.03.08.14.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 08:14:47 -0800 (PST)
Message-ID: <78210b8b-818f-44c1-84c8-c013120375ec@gmail.com>
Date: Wed, 4 Nov 2026 00:14:36 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 15/16] drm/vkms: Switch container_of helpers to
 container_of_const
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>
Cc: Daniel Stone <daniels@collabora.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, =?UTF-8?Q?Jonas_=C3=85dahl?=
 <jadahl@redhat.com>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Sebastian Wick <sebastian.wick@redhat.com>, Simon Ser <contact@emersion.fr>,
 Victoria Brekenfeld <victoria@system76.com>, Xaver Hugl
 <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261030-drm-reset-state-flag-v7-0-4e55eaeae683@kernel.org>
 <20261030-drm-reset-state-flag-v7-15-4e55eaeae683@kernel.org>
Content-Language: en-US
From: Oarora Etimis <oaroraetimis@gmail.com>
In-Reply-To: <20261030-drm-reset-state-flag-v7-15-4e55eaeae683@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>

On 10/30/26 6:27 PM, Maxime Ripard wrote:
> The vkms container_of helpers use container_of() which discards the
> const qualifier from the input pointer. This prevents passing a const
> state pointer to to_vkms_plane_state() without a cast, for instance
> in atomic_get_property which receives a const drm_plane_state.
>
> Switch all four helpers to container_of_const() so the const qualifier
> is properly propagated to the result type.
>
> Reviewed-by: Daniel Stone <daniels@collabora.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/vkms/vkms_drv.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 381483aa4fb0..dea6cad3f1b9 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -251,14 +251,14 @@ struct vkms_device {
>   
>   #define drm_crtc_to_vkms_output(target) \
> -	container_of(target, struct vkms_output, crtc)
> +	container_of_const(target, struct vkms_output, crtc)
>   
>   #define drm_device_to_vkms_device(target) \
> -	container_of(target, struct vkms_device, drm)
> +	container_of_const(target, struct vkms_device, drm)
>   
>   #define to_vkms_crtc_state(target)\
> -	container_of(target, struct vkms_crtc_state, base)
> +	container_of_const(target, struct vkms_crtc_state, base)
>   
>   #define to_vkms_plane_state(target)\
> -	container_of(target, struct vkms_plane_state, base.base)
> +	container_of_const(target, struct vkms_plane_state, base.base)
>   
>   /**
>
