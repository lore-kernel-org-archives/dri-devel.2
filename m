Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06071606CF8B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=T797bohe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AC4110E25F;
	Thu,  5 Nov 2026 16:06:59 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com
 [209.85.161.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DF1810E25F
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 16:06:52 +0000 (UTC)
Received: by mail-oo1-f41.google.com with SMTP id
 006d021491bc7-6fbf1ba31fbso830405eaf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 08:06:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793894811; cv=none;
 d=google.com; s=arc-20260327;
 b=pE7vUu6SCf6mbhvmRn7dknhLBf+5vRBS/7EvW5GHvb9CV6Pt3s9svkgxgqSiK0i5Fo
 +8ZHZLdDdWwyjA8SSeY/nMdaWNzK3cnU0f4ihsmAtax/VR2Pi0bB9bPnBo+IPsBSwgRg
 K2Pyg6eMQLTCBJURpsDSZAUs71+c9bO8ZjIAW+CNg76fMuayDGD/D7SsBiEAK3ncFIRB
 DMycicGKTpoSS1UGOl+033/SF1bdAMrejTxl5gpwn7xsqX/8oUsOp+pGMy4D60Zs0mmN
 IYizZ04dSBWTJA5S8EBSRQ/trW2K7RvYIuyHPmabUjaJvKm81sIMtk0ZCzDB48iKB+KL
 yxbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IrlQx6kiBBEaL2xhjiv+9BP5h8XuF7lHDq6wi1k7A6s=;
 fh=GghklGVFTnGhgDdUS9wFY+pkRBRw+OpIxa44HxJ25Mg=;
 b=DX0bTiRR21sJWyTdSmwMrjfXxZQ5xpEV37BUO5c4tHEGhsax1WC6R0uH8N+/gxT8sT
 VRmq5giYr93U9QyAbw1X7mJ+aRHA1g/KVuQpAJlPzh6gp0nKWWJhLQCeTkXSQZnzyih6
 QPL/ZGSmMdDt0T5AJsYn/vAxS/geDSki2fN6/2Iy9ro6fVVwVlxEsa8i/CtWNKymFBps
 oYscBHlpbghvjnZdEdb94Qtsk6d8Wzm17OVwIDAFLNlMcgMqDszUl6QnfSXLzynj4AQi
 GskQ3+r3CzXSqZSdsHdPFFPCePWIEnqNNf0jLnFx8TFm1WOEMyQfgZ68RKHQcG8bnFQM
 M1Sw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raspberrypi.com; s=google; t=1793894811; x=1794499611;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IrlQx6kiBBEaL2xhjiv+9BP5h8XuF7lHDq6wi1k7A6s=;
 b=T797boheCGonaFnLU10PwUfH6ntrmgZKCfNLLmu1QvX3Q8wqVSH0e0VWVqKOxD6HPz
 9zPkjCuLaGj7l7djEBVpHVJmNQRUJuZKKzCz9lVuqA/U+9BBlOpR6gJ6nYFRsqxFwwJT
 t/eIfqfYqK1TQ52814KMYA5wo6kxR8GVfuVWnnMC6Srq2YAosyCsOZu02aeObPePun+A
 ltE48v1Cxnjw43qgXOKsKaT2PeyoN/vYPTm+Eo/EHLix986kkTipqy6ZmNh0Vvd1Dka9
 J/KH8zCEkM5tPPaghcQT246584yW7PJUc4wVYR/u8vudtLTWsXBwaSWjJAIVC6XouuRC
 0XeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793894811; x=1794499611;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IrlQx6kiBBEaL2xhjiv+9BP5h8XuF7lHDq6wi1k7A6s=;
 b=F9mEs6/zzDI3A+uOjIbkoiqTSg9muqjrRWTGGSSGr/wtkTjUX6j/mJIOQ1D9aOj/NE
 u/VuXdN18CDiTLOHynSVRlKFiZB47qDn8YOZKOTWC48UQWc81q6KRG0FaJwl0BWFhbcY
 NI8Wf40JVeBew5udvCWSiZCxaz8XOpGTZMDMJPHIJVBulzjA4p1/ucEgIuanRZz6BqWi
 0XqbVfO2GYIEWyWJDqDAksEMf5N9ABU5iQZOgxDv4HCh0oIji+EGtyDoNvhURBGTNq4h
 9CPJui9cvP+7AKiQPfb5fMgEZLxuzn3Whs7lKBATNBU28COJOnJLckfqKBvDP2X9Wq5a
 y/Dg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxidDUEe5NL43XG+sYOg1uSmvSLPKFDushqkO2JxaDZvHD3Fp7HBy2zvx8nkq01j4aQGb1OXgDcf+0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8mi3CAXjHIcmOmAgFhDL1/8uRUGeUsjanQFCdULlyVVKhmXqh3
 VId4+M6VzBN7YJFd1o1wCBn6cT8JuF5GJhrGozJlEbpi3ZyC2bztwxBJ0s1R+MGoIZg3Mmh+zAF
 TP5AaM7MDY28ZRTY1075v6tqArVwk3W8iDhIa6tNIQQ==
X-Gm-Gg: AYBFou15UW8sa3TQZeyrV4uXXZ0/22pijSR2866INKuJRpG5PKKjKdPgd4Lm1DZ/ADn
 MEWHgE2DdFG+uf2jFPUPlNLH0Er82OOqCL720fUnMk4URJUM2RaQm9/jTv2dRh17+r9dGoc8bBb
 OmRvW1VeoeHSeGlpJS7UvobB/u18osvF1/B4BzWnRH9hayivGJFdNqblrccqb8rXEJkX/e4zBQs
 jVBmFR/2q7hcTVi8MIrv3QBZPORHVCqLXFsObgVMZ+hKWHQOtTwrYpAKIADz7kuGWQSaFqvefNw
 yRov1/WapVd4C5gZnAy4giRT6NelF/udiXKWDaksajy3TlFVrCMUquYa3L2vmxkCyL7Tlid5z60
 eBHnM++MpPq+TcBeU5eCGusq/HF3Nn2bFbJzZEyqzrIzVOZXndIzNFBLzORQAsV5KX7cRlwBZ/n
 mrhTAyik0Rc0iofU+sJ9CC/WERdVl3jEHv0ISrAcB2o6V+4UhroHrOtr53K61GZ0/9Ifzck18=
X-Received: by 2002:a05:6820:80a:b0:713:6ec9:ab7e with SMTP id
 006d021491bc7-714f24fdc85mr11571230eaf.51.1793894811425; Thu, 05 Nov 2026
 08:06:51 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-77-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-77-1f58d1e33380@kernel.org>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 5 Nov 2026 16:06:35 +0000
X-Gm-Features: AclHuK8UF20NyUsyECYuIQs1L2BIQw0eNZwGjdtNfc2-RJI3CKUbbUGhXexkNdU
Message-ID: <CAPY8ntAh-tiW=MBik9n78NmnNxO1yg+SZX_p-5TBFD9iHf5pdg@mail.gmail.com>
Subject: Re: [PATCH RESEND 77/83] drm/vc4: Switch to
 drm_mode_config_create_initial_state
To: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 5 Nov 2026 at 15:34, 'Maxime Ripard' via kernel-list
<kernel-list@raspberrypi.com> wrote:
>
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

Acked-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
> Cc: "Ma=C3=ADra Canal" <mcanal@igalia.com>
> Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> ---
>  drivers/gpu/drm/vc4/vc4_kms.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.=
c
> index 82a7f2ac4c7e..ab551eb2da50 100644
> --- a/drivers/gpu/drm/vc4/vc4_kms.c
> +++ b/drivers/gpu/drm/vc4/vc4_kms.c
> @@ -1187,5 +1187,7 @@ int vc4_kms_load(struct drm_device *dev)
>                 return ret;
>
> -       drm_mode_config_reset(dev);
> +       ret =3D drm_mode_config_create_initial_state(dev);
> +       if (ret)
> +               return ret;
>
>         drmm_kms_helper_poll_init(dev);
>
> --
> 2.55.0
>
