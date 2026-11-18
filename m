Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4DC606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=WHdDeupJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16B7910FC88;
	Wed, 18 Nov 2026 13:39:36 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CA2A10FC70
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:39:29 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 1AB164E41627;
 Wed, 18 Nov 2026 13:39:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D53D45FE9B;
 Wed, 18 Nov 2026 13:39:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A8A6911BC2080; Wed, 18 Nov 2026 14:39:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795009167; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=UYheKWtp9ceu0m9C97La2wNZeKnq9E4m0XVAUZBrWyc=;
 b=WHdDeupJqVzoJu1N90QVyaxIrqgSmzz7YqRIgmDKkayL346mdHdKXGn064I8Phu+Z2/C11
 vfmde1P+FgQuYWMFCfZs7g1vjNKjqumEeYLN5rKKmUD6X5psoGvqd7NtSpxmVLqt4Gnn8J
 R2RyiGDXgCXzCZTRDIDNFeedLywoT+KA/xpTxaupmLG6L1SOO2CtcKaCs2gz1FBKr4VT2o
 Ug89G817I2jkzGV4RlpmWdi5qolDjO+VllZ25nO/GUebeQ7NgC8wqJNc2odTB040B/QKxJ
 6GoIUJDK2tqVHkHcxLYWefhCowj2nvHOPZx5M9OCLx6cZS/ZOKUGpjxWsAzPeA==
Message-ID: <68a50773-886e-47fc-a56a-714ce244439f@bootlin.com>
Date: Wed, 18 Nov 2026 14:39:23 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 80/83] drm/vkms: Switch to
 drm_mode_config_create_initial_state
To: Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, Haneen Mohammed
 <hamohammed.sa@gmail.com>, Melissa Wen <melissa.srw@gmail.com>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-80-1f58d1e33380@kernel.org>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261105-drm-no-more-config-reset-v1-80-1f58d1e33380@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/5/26 16:30, Maxime Ripard wrote:
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

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
> Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> Cc: Louis Chauvet <louis.chauvet@bootlin.com>
> Cc: Melissa Wen <melissa.srw@gmail.com>
> ---
>   drivers/gpu/drm/vkms/vkms_output.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 86ce07a617f5..982c6cd5fcc7 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -116,6 +116,4 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>   	}
>   
> -	drm_mode_config_reset(dev);
> -
> -	return 0;
> +	return drm_mode_config_create_initial_state(dev);
>   }
> 

