Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4539A606D837
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QNdcmrZT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCBE310E2A6;
	Thu,  5 Nov 2026 15:57:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C73F10E2A6
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793894237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lv8cRUHuiU9C4GMAsbBFqGhkFidlsHv0u4cxxxR1f/w=;
 b=QNdcmrZTiSIl4QImhweh/il3luC2hdX8WKD68nXqMZhAo1u046HJAe4Q+paBDIkbdtG/5O
 YIV0JzuVr+cFaCVwSSnmdy+7rOkfznXxrlcnPiU88lnhZfBP2QlMVMRYmHqF+n2LfRHILE
 IYTW/BkbboD/zi28W2GABeazISs0nQ8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-dQX4rvpqPOutBbtH4EhRkg-1; Thu, 05 Nov 2026 10:57:16 -0500
X-MC-Unique: dQX4rvpqPOutBbtH4EhRkg-1
X-Mimecast-MFC-AGG-ID: dQX4rvpqPOutBbtH4EhRkg_1793894235
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a16dc2323cso22841525e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 07:57:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793894235; x=1794499035;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lv8cRUHuiU9C4GMAsbBFqGhkFidlsHv0u4cxxxR1f/w=;
 b=UOS6lsS2Mal7gIHbRE+XPlXJagTA0zeTwrYmhKOA3JXsTGvwDdqQNlyv9KIVfBNArV
 af36uXkdzplCdpzbZ8QdX6A9riRin0B+37iuQtePs2d7i3g8XhnG3UGg+M53zhxs6DqU
 dcQE8rRGgcM8jYy9LeRKqTkGL5yTgNOz9GPNh6bfIFYBBYMz+yaAelJ0TlZVx+6gvPwV
 /C/6vSDl0jZJ41lbq6SKZPAnlWBujErp24F1yycge0Xki/Hy/6TWz9VwTH0lUaszIyNE
 frde1GSUoBoTSTJQn8Om0lqjSRBLbVbksBsIWD4duQNYXABaRSpZqp4nFCTFaUbIhSPZ
 wFTQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxsy86VgSJBrqu7KbmDUaZOQkNNsvSAZu2uBD3NAqTbdCIKmqXTXguoavt7yda2tv5xagmp084yEps=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/WYQyzwnQlXuf76CZUiH/PwZJKFe2XZXwGXjq3AxaAI6wAMbL5
 4Bl4PA1omeZziU181gRl2ZJV18D4BjxuMNICmjVTrj2A252Fa8e6mEkRBBXIH/17P94S39+IctJ
 Fpm4eVqgi0GDJvYr5xdtBvav6Q24JUX+a2q1zWnzOUhtxxo0f2aMvbVML9Zp9jOLQxD57Dg==
X-Gm-Gg: AYBFou3TKazHrBIvoeFAosaRNZEaOH2gmI5Bf0GUjAkHBfLxhRDPWLAuRQ2vSiob23E
 ubYINIAMjRzlb2s8l2D+MJpuoWCFS7z/5UET69tHnkpDVFBpT5+YFrjf1fgOSzdmJ7d0UGdJIzb
 Duddfpd+r6d4RZHBdtPpHXdrtyQFJf0DAu5DxZm2PUHrtzpk1WjJzYjDUoAv+jqZ+TD124mDGZ0
 lRpPldjy88+TtX/TQ55W3GV+2t7ZNGQR2GFLqH/V2aJNNs9lNtJBXSy9mvZVYS1i/HBXK3lNi1u
 qMDYgFBSAVrDid1dCuMPzgZdkmhAHRsQzSKAwXiqttGo6JtrzrYd+xhNfTuEFcmyzqgzkJlagOR
 C7MbnFpDq+b//fdhbhg1pIZcIq7r3uVuMVMDD0WKjuHfOK2Uu22LUpa5lDiG4F69U1qmT2fUtBr
 vd53bmknEaP0X/2//uaJh3CjkCs/shO4xLsijgChA=
X-Received: by 2002:a05:600c:34d4:b0:4a2:d7e:5ccb with SMTP id
 5b1f17b1804b1-4ac182dca99mr476978665e9.15.1793894234824; 
 Thu, 05 Nov 2026 07:57:14 -0800 (PST)
X-Received: by 2002:a05:600c:34d4:b0:4a2:d7e:5ccb with SMTP id
 5b1f17b1804b1-4ac182dca99mr476978185e9.15.1793894234230; 
 Thu, 05 Nov 2026 07:57:14 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda1fb0esm10762648f8f.49.2026.11.05.07.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 07:57:13 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Simona Vetter
 <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH RESEND 52/83] drm/vesadrm: Switch to
 drm_mode_config_create_initial_state
In-Reply-To: <20261105-drm-no-more-config-reset-v1-52-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-52-1f58d1e33380@kernel.org>
Date: Thu, 05 Nov 2026 16:57:12 +0100
Message-ID: <xlv1v76be0fb.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VEU8rELBNPrdWQqGaZQNldGHxOiaNGCAaX8GAI5d83Y_1793894235
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Maxime Ripard <mripard@kernel.org> writes:

> drm_mode_config_reset() has a dual role: it creates the initial KMS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles.
>
> Since the two roles need different behaviors (notably for objects like
> drm_private_obj that must persist across suspend/resume),
> drm_mode_config_create_initial_state() was introduced to handle only
> the initial state creation at probe time.
>
> Switch to drm_mode_config_create_initial_state().
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> ---
>  drivers/gpu/drm/sysfb/vesadrm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

