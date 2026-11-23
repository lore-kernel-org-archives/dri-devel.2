Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B863C606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d6NJpRb6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24F9410EDA9;
	Mon, 23 Nov 2026 12:41:17 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3FA110EDB6
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 12:41:10 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4bb6886d30aso31416385e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 04:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795437669; x=1796042469; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=n3T4SwHjmz2olFUDLYwHC6yLLAFa2tC0UOBRI/f1adc=;
 b=d6NJpRb6wbxrUfbj+uuo1Thz6LZeV0EhuSIOpL2z/NKTwCIqr63XSDDO7URWPw+sPV
 ZqKWmXDLj8p+rE/zW6VFtUNE1FSiPucL9qqWh3YS312PSFWftaZpVWfzfpgvkfnii3/1
 9GUUR9+w18OzePwgMuvkLGSxHJbUMJr1zTV2uiJzZnSFyNhbAHNzS+NeheNiu771+rsJ
 I+KkH+OjQ1Wn5i+VRCxcu8UQDIJUMppxlzXM3+nWUF7ttjoO0fvO14a/M7x+7Gr9PHmU
 kMmtKLkdILxtcZbyXSjae3JFhpi/zFyvj2BaWOaThGEGEphtZ0V5yuGb6USnh5C+PkaK
 PtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795437669; x=1796042469;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=n3T4SwHjmz2olFUDLYwHC6yLLAFa2tC0UOBRI/f1adc=;
 b=01IebZNV4P2uGM3iY0tAsytfJ7PFeZP3jO/eU1mJFb+Zf7eU6FheYbzlpV6o/xuzQA
 M8JXITem77dsQZMgeDeX5R86KUs6Vh6wDvWO77PHIENQyRMymf5ZdvlQZ4eu7D9tynyI
 VNyFd3QawoN5MUROPtCipcESG71ntK1ryvBcEA+tc+tQ51nJqPf/5ljlW7o3lH6/N7Jy
 vzZMUNvpD1Ok5KO0BBgTPy0NsFiz68VILLi7lvYizMVOq8vplHReB/jNaGIrf/0ENVqd
 aj4yftCSbjf4lBS/UdfxakLB/KthZH3IFupifi/PyKbGgQ3PB02gj1MHmHZnDP0RMxlb
 dThA==
X-Forwarded-Encrypted: i=1;
 AL+hErFasdHgIvOheVnIM7/VKR2+Mvk0VUurcaw7Mvwx+1tR2eqV13R0if22wToiqbqBSNtgUvSjdlEeMmQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Ki+RNPBvrW6f7+NtkLTstoRqlPfBd8A0j2bbV5iR9iNIpoYkQ
 93EL4WECwMXrILnLXJaXdtVSlC1fOjyPCxHi2otwmYnP27v+4YcaVYVG
X-Gm-Gg: AZFdTZdz+CEPt4MgKs49/3+IDsuWYlmy954gZwwiwwx7yPBmWp6f7sDZP+zKuJHKyyr
 rVOzQGA4Vq9Rk9G7iN7dCDo8FjQXqzv+lsesrMuvISvED8rLRe6hXrp3ui199fgWZ8b0/zgL3R4
 QuORktm9JnKjbFJKdgA22TAkJbiJQI5HsnHsWP1Jvg29n5ME8ZKaNqYb+f5TMYjBPbmBIuskW4i
 nQMOEpHu5+F4Z5NxRGCJ1Lngy8tLJ3OnqWIvGEAvzxTZJvh+BCxac+F4apyNJH4dN1sKYBiBRgT
 JMJuGnUMHQVZRdw6quKiw6c/jeBXuVeigGkdcKy8HhqpsIrgvECVkcsekShHnv40BIoH2Tj9RkA
 Zn/qiMlXM1zHIFT3yiJL22yhvcbiN4MC41lijux+zwPXdybxohLwhA9Ro823uhLB5c0pOwY7mbH
 tcZdXkrOvjHgNRcjr0/LnF4D4QWW+gS1DWGCc1/Oit2kIo2C03YAziYD9SVt/5V9xieBry3bRLj
 RXvQH6P9iE/NxiNzVt/VIrfZbY9qDV91FIG0GR4LCoYJAeKzgrSoqd+a98SdXJp8hVTyiGpj6G8
 N0dnsyBUXgoSl+34GdinuuoTOLrTW061jA==
X-Received: by 2002:a05:600c:3b84:b0:4bb:6f45:2a6d with SMTP id
 5b1f17b1804b1-4bb888074bbmr277880715e9.12.1795437669058; 
 Mon, 23 Nov 2026 04:41:09 -0800 (PST)
Received: from ArchOarora ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb90660cb4sm269127865e9.2.2026.11.23.04.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 04:41:08 -0800 (PST)
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
 linux-doc@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>,
 llvm@lists.linux.dev
Subject: Re: [PATCH v6 14/43] drm/vkms: Add error handling in plane config
 creation
Date: Mon, 23 Nov 2026 12:40:53 +0000
Message-ID: <awQzMoSQfHO47QgQ@ArchOarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120-vkms-all-config-v6-14-78ace90f4fc1@bootlin.com>
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
 <20261120-vkms-all-config-v6-14-78ace90f4fc1@bootlin.com>
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

On Fri, Nov 20, 2026 at 06:58:56PM +0100, Louis Chauvet wrote:
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
> index 50cde689f482..03f2d0f0e327 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -424,13 +424,16 @@ void vkms_config_register_debugfs(struct vkms_device *vkms_device)
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
> @@ -440,6 +443,9 @@ struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *config)
>  	list_add_tail(&plane_cfg->link, &config->planes);
>  
>  	return plane_cfg;
> +
> +fail:
> +	return ERR_PTR(ret);
>  }
>  EXPORT_SYMBOL_IF_KUNIT(vkms_config_create_plane);
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
> index de6a89819daf..49510a0957c7 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -288,7 +288,7 @@ void vkms_config_register_debugfs(struct vkms_device *vkms_device);
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
