Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1D1606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WH5RzY1j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1236410E9F5;
	Fri, 27 Nov 2026 10:36:28 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBC3910E9F5
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:36:21 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so61658325e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 02:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795775780; x=1796380580; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iCTbyzZob8FXKeEZRFMgEo/F2TymOMg6sLKTzhBxgFI=;
 b=WH5RzY1jUkmWeHxnoMlR06YE2Z4gYmS2gqXxHXAzY9r2SeV6hYEaAtEQ4NuzwcOZQJ
 gAVi+j/FM+85o1dL3AqI+wslvvZkjXVNmCLAvDiEW0Pnmdk83C/aAUNhKUnrvla3AaWw
 8wDzJGVA4uccGbp7c4AwubUKSBIFuysgKJIe/odEhQnUkBuk5wV60C1PiL9SPoIPyxmW
 lt7KqhxxA2w4lngFtxcVokjr2CPbh2xun5Blfq0KE65ZN7MHSB8px4Yih6I5y+CJa5WS
 mGWRSt82ia+GeKeZngNGXMyIfgvyxkD3IHgjvr4X47mNN3diykSWeYJN4/VmEmW4U02e
 jnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795775780; x=1796380580;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iCTbyzZob8FXKeEZRFMgEo/F2TymOMg6sLKTzhBxgFI=;
 b=K4cw+Ir2gLsANJNU3yJoJ1k/U+1F2y+NSwg1wutbDtGqV/yfLBR/3pkJD9ogkBO35x
 epjZ+hRjlLxVWoYbJ3y+FDA3Qdavo1OITRdZY29OUZe5QveO6AnYGJd+R0LRPsqwCGVF
 8X3j5qh8l536nz/WYARnApm8R/E2FkKhw/s8jYIR9yc+351JgEsMaLvz0r4jGTOqFVet
 5NITBfWiqTp6xnBe53srxYMg8fBpX5oV998pxj4UL/cydLAW5/63uX5E239QBcEYflPp
 cCT0mBMuIfgqUL6O6gSwVzv4x4vVv36dqliv4kv+dOVefIa1ud6czTP4TnIPdQGje5+R
 pRog==
X-Forwarded-Encrypted: i=1;
 AL+hErG2Jz3RLj8mkMPKhjdvvtxoR0wSLYLHRHCdjjBY8iA2alc/zJbHM4hbLOWwBnWDbMy0xwHOBt/oVjk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z85K1cCRBiuBYFHk6M/RQSW79Ruw2acXkM5er1qv3ey6huGW/av
 X7WCHZj6PPKcwObBCP0AOeJSo/GGCodJPVcg145ZJe6ifN4UARn+6Q77
X-Gm-Gg: AZFdTZc3DMAAVl0uxP6cQtuhP3fPNh5J8gnIZTzBTr9uAPu0Q96AtLe8KToWvfMqsw6
 YXruyPVC5TVWwxiaP4cJRL9FZOTdvczehdAeqRiPh7Dx+M4gXnqdNZohdGY0oSt+kkxpX3Ty/vs
 W35Wudzt1q0nPm4JdvZx5MSQYWrhv6X2+3Ced/p0drX6xAKKnRdwF/oxSM1Q9wW6ypIn66AEKaZ
 EDq0jT1tFMFLKIA3JE5orfyQnrS3QSY99S7vFG0AIWt8pPGiiPxtpnCVLhMWgKXTcm/5mgjhNf5
 DLQx3lxNcrXjWOz1PyMWZqws+HHx/qnMKTYj3d51D3zzvJ1LYYnjmbgd8AQ/kxGRyVgD7D6/dSg
 JBVSv0TTZKLmm/BuFHT+1dkcm0XC3rzTKXsVs8HyET7Jp96WxGTcucnhaL2aUpxNcM6ArMT5NR6
 zRr7XsQQw2fN1oFkfCkScVqI7RcUs9JohdPN0M9c7Gz3biTm/nFkHMOcr/K9O9HpV1cd/0CAGQc
 x03ftyCx2IfXAP17NSCekGNTrAt5/Q8EdfsVGPACOrNF9TlxCZOyp1IsbBhThqNd27eMQBEoiYU
 2AGbItpR2+fNqvXp3MHUcl8xnx6Rw14=
X-Received: by 2002:a05:600c:8b76:b0:4bb:b796:66f8 with SMTP id
 5b1f17b1804b1-4bbb7966874mr14558915e9.21.1795775780152; 
 Fri, 27 Nov 2026 02:36:20 -0800 (PST)
Received: from ArchOarora ([95.179.249.152]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a3a3dsm670160975e9.10.2026.11.27.02.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:36:19 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 jose.exposito89@gmail.com, Jonathan Corbet <corbet@lwn.net>,
 Harry Wentland <harry.wentland@amd.com>,
 Lucas De Marchi <demarchi@kernel.org>,
 Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>, sebastian.wick@redhat.com,
 victoria@system76.com, thomas.petazzoni@bootlin.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v7 13/43] drm/vkms: Add error handling in plane config
 creation
Date: Fri, 27 Nov 2026 11:36:00 +0100
Message-ID: <awldBcp6Ci4FoQX5@Oarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126-vkms-all-config-v7-13-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-13-21194cda2468@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 12:28:56PM +0100, Louis Chauvet wrote:
> Properly route the error path of vkms_config_create_plane() through a
> fail label to simplify future work.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_config.c | 12 +++++++++---
>  drivers/gpu/drm/vkms/vkms_config.h |  2 +-
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
> index 8cd4fe6551fb..c5d90f7e934a 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -421,13 +421,16 @@ void vkms_config_register_debugfs(struct vkms_device *vkms_device)
>  			      ARRAY_SIZE(vkms_config_debugfs_list));
>  }
>  
> -struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *config)
> +struct vkms_config_plane __must_check *vkms_config_create_plane(struct vkms_config *config)
>  {
>  	struct vkms_config_plane *plane_cfg;
> +	int ret;
>  
>  	plane_cfg = kzalloc_obj(*plane_cfg);
> -	if (!plane_cfg)
> -		return ERR_PTR(-ENOMEM);
> +	if (!plane_cfg) {
> +		ret = -ENOMEM;
> +		goto fail;
> +	}
>  
>  	plane_cfg->config = config;
>  	plane_cfg->default_pipeline = false;
> @@ -437,6 +440,9 @@ struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *config)
>  	list_add_tail_rcu(&plane_cfg->link, &config->planes);
>  
>  	return plane_cfg;
> +
> +fail:
> +	return ERR_PTR(ret);
>  }
>  EXPORT_SYMBOL_IF_KUNIT(vkms_config_create_plane);
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
> index 95e5c3694742..8f038562afd4 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -314,7 +314,7 @@ void vkms_config_register_debugfs(struct vkms_device *vkms_device);
>   * The new plane configuration or an error. Call vkms_config_destroy_plane() to
>   * free the returned plane configuration.
>   */
> -struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *config);
> +struct vkms_config_plane __must_check *vkms_config_create_plane(struct vkms_config *config);
>  
>  /**
>   * vkms_config_destroy_plane() - Remove and free a plane configuration
> 
> -- 
> 2.56.0
> 

Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>
