Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45022606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fnp7A4FP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C3C8112730;
	Fri, 30 Oct 2026 10:39:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3588C112730
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793356779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qu13WNcpY/vZ07q359lLwvt6yOBB5yClJfHy+LokQkQ=;
 b=Fnp7A4FP7cKWqyHN26yrmDSn3V0lVOZG41ziwrWnOAyDZbrouxKbZIxsOQ2oALjp/9f6m9
 ChtbIW0l7NqQBqqB0DPjmvYZH5ExcPfCL4FsHulUTZQra7Jrv+wxzebqJQFsRVX+X7hk24
 bQA1bRuVQV1t8h1l5srE0BdnC4yyl9w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-M2ntACNDMe6T-lIZ1FScNw-1; Fri, 30 Oct 2026 06:39:34 -0400
X-MC-Unique: M2ntACNDMe6T-lIZ1FScNw-1
X-Mimecast-MFC-AGG-ID: M2ntACNDMe6T-lIZ1FScNw_1793356773
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a009f82bedso3799525e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 03:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793356773; x=1793961573;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qu13WNcpY/vZ07q359lLwvt6yOBB5yClJfHy+LokQkQ=;
 b=wGbDxbw+7tdA0u+Kx8xNzbOIGPHFODzBKdJMeAGJPcWh6EEAM7mrnmxJXrabUsPsWX
 ylhNzfJr5xK97sIt7vCkYqlqzs9EviK82GLlAjEIz/7H45X56HZwwYFhs63YilHUu99t
 GaczKcXDGl8OiUFaelYtI2dKSEdMcuJc0al0ly4Bkcq7WfjL002Rf/dVNSZf7CUWJYzK
 EC5lN6zP0bKzmfvtB1B8cJuU1IowRz5+ub/25P2VZ9BCthBV1/JdDlBFTxRfZXxZSv0E
 KadxEOVQD0qk0OodUiqyV7+PsQkI4Or8/iOVAhDKSEukBGzx9BmcN+4o5pCb+sDVnMsw
 M6Mg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0GGCJq/EYdyXglza6ShreqHE0Ta0ikJol9kTMS+gf+VWW/jn/d1G8qj2k9Ef/wUNOKWY0mg/t8nA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIIm+BT3H1UwbVnRUEEbSmvHT6zXLkwVVsChNYEoK2+NF8gCegR
 l3fb9zDND8iKaZ3mNUQlI3VVdNLjymVcesl8btq228VZXh+LlsyCFVHdKHZ8BQqUZQ87v03ug0c
 I42YfIIgB8awKQua0E3m9KOcYsWv5rIFxx5IYuY4WUiU+H7amVHBBqT8VANq08/ziotqyZg==
X-Gm-Gg: AYBFou3cScgucUblLgUqD/m+muWylPENCKIelvvFUboRyZs77q+lMq4kvNjtHstpXX7
 hK9CImpXB38yyrHpdIYEZgHbiRnsoRWuA5va7JLECDN974feY2zFnqiEi4gAkG8i3gqikyOLfaj
 cP/ndswYVhdss8DIkD/orPKYE2yaOCI656+0kfN4LdeiVHqyU1IDx+hJ+toZec0YfgDnPUbUoLm
 hoSpq1N0VVdyqSB8lklZ6bDc64U8+I+jTwvm63Zm0xG0Nquw33IZ7P5c8IJLV5C+7JAukuWAoDy
 qd8138j6FqnI7MvFgLpEQfBna01X618egxMuFPLHS2Qnz8JABsLNteXVhiCrEeKgb34SwB8bQyn
 0vwjq4QEa4xg0jI07cwFH3g4WG6WdDvP/s8sh5Rl602/NzTwPHMiaGac5N6JWOaC/kKf3i481df
 pfcK3XifRn7w8QjvncK2gBS0iupNPnRF8jV24O4ZE=
X-Received: by 2002:a05:600c:8b63:b0:4a2:40:7f35 with SMTP id
 5b1f17b1804b1-4ac18993232mr37255445e9.31.1793356773050; 
 Fri, 30 Oct 2026 03:39:33 -0700 (PDT)
X-Received: by 2002:a05:600c:8b63:b0:4a2:40:7f35 with SMTP id
 5b1f17b1804b1-4ac18993232mr37255005e9.31.1793356772563; 
 Fri, 30 Oct 2026 03:39:32 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa813d2640sm126040245e9.6.2026.10.30.03.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 03:39:31 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Louis Chauvet <louis.chauvet@bootlin.com>, Haneen
 Mohammed <hamohammed.sa@gmail.com>, Melissa Wen <melissa.srw@gmail.com>
Cc: Daniel Stone <daniels@collabora.com>, Harry Wentland
 <harry.wentland@amd.com>, Jocelyn Falempe <jfalempe@redhat.com>, Jonas
 =?utf-8?Q?=C3=85dahl?= <jadahl@redhat.com>, Michel =?utf-8?Q?D=C3=A4nzer?=
 <mdaenzer@redhat.com>, Pekka
 Paalanen <pekka.paalanen@collabora.com>, Sebastian Wick
 <sebastian.wick@redhat.com>, Simon Ser <contact@emersion.fr>, Victoria
 Brekenfeld <victoria@system76.com>, Xaver Hugl <xaver.hugl@kde.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Maxime
 Ripard <mripard@kernel.org>
Subject: Re: [PATCH v7 02/16] drm/solomon: ssd130x: Drop the init-only
 assumption in ssd130x_crtc_create_state()
In-Reply-To: <20261030-drm-reset-state-flag-v7-2-4e55eaeae683@kernel.org>
References: <20261030-drm-reset-state-flag-v7-0-4e55eaeae683@kernel.org>
 <20261030-drm-reset-state-flag-v7-2-4e55eaeae683@kernel.org>
Date: Fri, 30 Oct 2026 11:39:30 +0100
Message-ID: <xlv1ik2jfp5p.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wg3i2lBIJFPSBrbO8pUwpnKMPfHMhCsI7NVbaxTz-tU_1793356773
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Maxime Ripard <mripard@kernel.org> writes:

Hello Maxime,

> The ssd130x_crtc_create_state() implementation warns when the CRTC
> already has a state, assuming that atomic_create_state would only ever
> be called at initialization time to allocate the initial state.
>
> However, atomic_create_state is documented to have no side effect and
> can be called at runtime, so that assumption doesn't hold and the WARN
> is a side effect in itself.
>
> Let's drop the WARN, along with the comment documenting that
> assumption.
>
> Fixes: 1345de7fe9114 ("drm/solomon: ssd130x: Convert to atomic_create_state")
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
>
> ---
>
> To: Javier Martinez Canillas <javierm@redhat.com>
> ---
>  drivers/gpu/drm/solomon/ssd130x.c | 3 ---
>  1 file changed, 3 deletions(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

