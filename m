Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C965606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QjnELi6f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA40310EA3C;
	Mon, 16 Nov 2026 08:21:12 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E83F10EA3C
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 08:21:06 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4bb68c197c7so13839115e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 00:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794817265; x=1795422065; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=z9bQTpwK1xouu5c7EOhgogV8k6o3pDM23RLUDx1Lvvc=;
 b=QjnELi6fg2lVv5karPeyID3GMQR6EzvaQdWiOfY5h9LlQuRbGFiYJTGGamBLgE/++D
 VSxhlp+Lfp6TJndgUcHcQf74U0WoLS6ZN6oCPFOdcFYAJv4rl07sfPcHQ6vO3GE0Y212
 c3VQnPyOStA+m/anCpW+lW/D/O/a0XKheheHx7zIymeB+SMjgULpvw6TzJeZTD5Cn/oD
 5OxXpBd6WMIGNszgvG71F/q3Un6l1Z7WzqajX+f3rvRZ7RgRBT+4G6QzRqUVzXe8H9H/
 WNqRtz+qFa9i2LJgb2+rLco3cZR5zeIrX5upsIP8XRySy4d4+JJWK7YCXmPqnTfFG7NM
 ku4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794817265; x=1795422065;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z9bQTpwK1xouu5c7EOhgogV8k6o3pDM23RLUDx1Lvvc=;
 b=rw0yZASHnuzoXFYoUPJe9Jrt/zPZBn+t/rTppx2xUpoFq5Hq06g+4if/RLKKJVS3iH
 Gw7pFGGgkjpZZJ1/lRRbeCrfjXJSl7mc/N9SDO0nWQNX3BYqoNF77hD08KjHAbkFHiu1
 ono+TaEDUdm4nwiaKJaTGtQ2bo7lYeGZr1swhPE0mjZwKaEcRy0nQ4oit5gkBrQsiDxK
 982RJy57/x3l1p8DbI9ogN00npr/KUxXZqfoAU3KaaAypln2Is4lbx4J6gev3RCtlb/3
 oKCXUODtcslBRcNlKlewsJ9TORjd8bRErBgijbL1D3lWSD7nYQSAJwInlKwirhdAbaei
 YeSQ==
X-Gm-Message-State: APuU4Z/Z66D5Hs2C/qk6VYYz3Q5eh2wje3GcSa4Ou7RmZ63s9/aVM72s
 ejQiQPjvGLpRlfhVS9U8aFcTy0cAmaPsHqfocBO+xydOeXdY7u1nUvwc
X-Gm-Gg: AYBFou3v6oAVTDL5kHkWqCHLRKy76MBo724kBMKTC88+ImTY58lBZvxSGj+L0rIdaEX
 Ea1O4tnWP/zxINshq8MwnA135L1MOdsLCuAfAB2uFdW67yKzVvu5pKpc53NqAKdHFpqDAy3o5Gq
 tcytKBhrbYbA8Qr8sGoMq9w/xuQIC/aQ5wlo0jFkbwK8dt/+jZUMH1XNvYmy6CQHE2PruI+laPx
 URPjgiZhVj/fz744mjZm6k33+YStSQlKBP+I4sahyQ/wKNsdgofcnXJ5xIdYKqEsHJJuVgTBD8P
 EzH2jrLiQzPwkfiB9OFtMVJrrz5r4LXH28zAaXHZT10F7PpOnaEqPoyA5TADr6Qe8jS858S8pEZ
 CYGIXO7NkOMOyvrzoBD4uLG0SN3E/DtgMCr8u2voVVVNxZKTXZWQHTvV2qLAwuyxqp7oBUwMIBs
 ElKy7BVudo6pI8lt8OdgKK6AbWGvFQyUd1s55OszrVVWA1Z2OCiw6iQ+Uae9/WD5DNN6p/F46qb
 SlbbwLMuL5ainf1Cl8y2Anrpf/B07GJjERIB15rvX1//yu99I7PkZYfHlFvpjMNDO7XAPSBCgCe
 k7yoZju9mCBwTsQF/+nWTRR713189/EIFfb6Jh5rXR9iMoNwf8GmrHLoc5h+0tcBuCHPAD/P3BR
 r
X-Received: by 2002:a05:600c:a46:b0:4bb:694e:496c with SMTP id
 5b1f17b1804b1-4bb694e4c2bmr94516795e9.22.1794817264712; 
 Mon, 16 Nov 2026 00:21:04 -0800 (PST)
Received: from ?IPV6:2001:861:3385:e20:f99c:d6cf:27e6:2b03?
 ([2001:861:3385:e20:f99c:d6cf:27e6:2b03])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c8a77sm21060129f8f.49.2026.11.16.00.21.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 00:21:04 -0800 (PST)
Message-ID: <07d94965-8227-4837-ba25-9099e2951f73@gmail.com>
Date: Mon, 16 Nov 2026 09:20:01 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 45/83] drm/sti: Switch to
 drm_mode_config_create_initial_state
To: Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, Alain Volmat <alain.volmat@foss.st.com>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-45-1f58d1e33380@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-45-1f58d1e33380@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 05/11/2026 à 16:29, Maxime Ripard a écrit :
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
> Cc: Alain Volmat <alain.volmat@foss.st.com>
> Cc: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>   drivers/gpu/drm/sti/sti_drv.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
Hi Maxime,

Acked-by: Raphaël Gallais-Pou <rgallaispou@gmail.com>

Thanks,
Best regards,
Raphaël
