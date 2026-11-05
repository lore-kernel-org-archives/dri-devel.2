Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D005E606F943
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bI81wahP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B859A1128F8;
	Thu,  5 Nov 2026 15:54:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58E0A1128E4
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793894085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e2AwBFO4JiuQ/FV/CMMmSCfjX/nAyzoMuTgXb5GZYKk=;
 b=bI81wahPuVHugPaHe+LsRfoJwdaUKqGuui8YyZ1ijsHJ7nF4+xwsa+OIbK/ezi0cuvmnH4
 l7QLsuynGnTUgLx6ZMe3jagYcfXrq1N1de7SRBN5pmXEd5u7JwYe12if69mWdpau5BGV1g
 ZKue54/xeE9wBp3MvnCBbD0GR7T8bR4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-5OUhpKPiNhudco-b6dcPmA-1; Thu, 05 Nov 2026 10:54:42 -0500
X-MC-Unique: 5OUhpKPiNhudco-b6dcPmA-1
X-Mimecast-MFC-AGG-ID: 5OUhpKPiNhudco-b6dcPmA_1793894081
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a20fd059ddso16225355e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 07:54:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793894081; x=1794498881;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e2AwBFO4JiuQ/FV/CMMmSCfjX/nAyzoMuTgXb5GZYKk=;
 b=rSpQGVn/NaXKlL/UqV9Wkyz0x6yG9DDcRFqG91joJs8KMeLqJiaPNl44gqTYL8Fw0m
 t0Yhp6HKVnGjrOJOS2GJ94s/7ASzj6VZtn4JPz4kRrVybs9TsI85XDpyykIGGI1AQxIW
 7LSdzjLbEr6IVQ5VhOOWOnDkuEM4to7vHboVbD/7TYZg95C5SL1XnHj6D1BEa3CArNV4
 Wn/NiNaTo5o5eVR1puw0q5Go3IjlIiz62WyfhK9ZLnAU79ATBRccSS4KRyNx/yDtHTd5
 kPLjMX3GEyFh7dApM/HLL7Vr9to/JJxbkdBNy35J9ALAJ9cWTRxXfnRZqVVs3F88+Wuj
 K3gA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlCj5qFSMu9z79I3h16neRTtCyZPYrQSc2PHCn4u7xTutXSEhpoW73WIP1ZQAFOT+zZIib//wzIYU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9h8wdudHbfPEUJ6Up4Q9/B/z3/lRpiyWCroh7ia83KsjXSHrNQ
 XlXFmOZSxjarFcIM7hQ/XJMbDMYbPz7tUNelWSBUJ0GlGEHNgzUWKsvQRlBM8NaGlv38N4iuZAD
 mD5olz5/h+3hKqMsDNJlUzPIyW5G9Nh3NC5YvPbfJF9c0F4fk8oZ+AtUK+EhbZWwHgdQT9Q==
X-Gm-Gg: AYBFou2VVjHIzh3bVRd7ZGpSS1tmI3SuCnYr56CmOHe16O+n3tFOPyjzPtyZEcKaqHw
 DgoWIY5EMv1M7PjE/AI2xWZyV8vdd8UGjGo1yXfLBpdB6idFJjlhHrA6aaPoDGz+yXuyE59l254
 1otJzKD78VGNEEI7eL5/A0QPRe+iyQxmCPf74zl+d0kwZEiogZgigIZNk9+js5kRXrG1IBVM1oQ
 WnT7DrHruPEr1ai1JBk+OkGlnS0iNkJ7/D9kmlq8jNUH2sJNj+SFYvhBbwOoLMtrKwFfBOs/wsy
 MHLiVclGjg5LYRHyl47rOCq9x1JldQDH2IbgYNMs+FFKl+FQxg7uxAXI6oNbXvLlwyaR+NqFXST
 lPuCmknZ9d327q0J39MfMlcdhH211p2ctH63ITgAs/T3pK9kK3BYpAUFI++4DMnKcW5WfDosZ3+
 4MSAFYiJZic+OPeXWst5Hs6BgIFBCZuvV4j5ujl9I=
X-Received: by 2002:a05:600c:a00b:b0:4a7:b304:253e with SMTP id
 5b1f17b1804b1-4ac1765d8abmr427961265e9.22.1793894080574; 
 Thu, 05 Nov 2026 07:54:40 -0800 (PST)
X-Received: by 2002:a05:600c:a00b:b0:4a7:b304:253e with SMTP id
 5b1f17b1804b1-4ac1765d8abmr427960895e9.22.1793894080101; 
 Thu, 05 Nov 2026 07:54:40 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56e58fcb8sm71523545e9.1.2026.11.05.07.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 07:54:38 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Simona Vetter
 <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH RESEND 48/83] drm/corebootdrm: Switch to
 drm_mode_config_create_initial_state
In-Reply-To: <20261105-drm-no-more-config-reset-v1-48-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-48-1f58d1e33380@kernel.org>
Date: Thu, 05 Nov 2026 16:54:38 +0100
Message-ID: <xlv17birff41.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HmMiVEROzQIfZgbqPI45wntG_k6PRZu8fYfan9xklfA_1793894081
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
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

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

