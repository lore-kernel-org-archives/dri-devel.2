Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81743606A322
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N05eLqnO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDE0610EE66;
	Tue, 24 Nov 2026 07:38:46 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE1DA10EE66
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:38:40 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so23435225e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 23:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795505919; x=1796110719; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YsrbWXbneAhmlRMenrVJ4CAefsGYSIi01YHG77kZWSE=;
 b=N05eLqnOlVn1mVeZm7UB7B952A2zyfJfIDjoQK9O2KRew9on6yyVVi8OnjGZ9nzI4Q
 tZEOMvQvdEYCw9ae9vhy7+L9lZD0RgrmIjvwrFqwtRLhKC1lKMoJF5kXo9glP5NvbHy9
 8zSRvqS+FYOWrAcX9KFqxZkFXJctrgMnxBZhUgB0KichuzaznWcFaAPazm6mes1W9M0q
 mJV+bdTBrqDlwi5NBWN2QjiUnVF+4ATLEbhsKQJZJjswZR+wqnEbRw85/jEpLzLcHMNk
 tu0JBQV6OXuCmwMElq11M3aijiOvKR5a8Tmy2xCZHJqC13QJd5Gg8NwrojYrBqLbKH3S
 r0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795505919; x=1796110719;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YsrbWXbneAhmlRMenrVJ4CAefsGYSIi01YHG77kZWSE=;
 b=umHrNIaSe/F63YoGLqr67OEmlzvWexjXCVLajhMm7plB7WLKPODtnvA3eSubRzoZ2p
 AB0ecqNx1Au06MRWzz1TtDerWSXXvEaepePtfZOs2bNU59wWB73y3vE0PQCSK2GI/DkN
 nCFBlxYmCtsCFn2TwnE7w/nsJztAfXdAf+mbZ7POcpKFzPA/CZD+glwhuE/e7GdtdLmS
 e7oOeXVCyJSoxCClzEhVyCXrLLDfOhM0gu9t2v5U9qNoAm5DUGslpRJM9h/TGA9JFxAn
 kFfxhQ9HSxA3Ei8nhmwPr/UTLdCblLDKYO9qUPNzPu7xxVh4Gn2Yj7RwmIjbH26WDZp1
 2d0w==
X-Forwarded-Encrypted: i=1;
 AL+hErGMO0rHsDWipUlM1ryV1MUTIKJzZs919UFIMqTg7G06GlnIzcCrC51ZnWLMbuwTtl7fr5SDrgb3naE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/Dj3IWgonyUrZTuBapr4iZ1PqeHVi8utX6YNleYtMyrMjgPKbF
 lADgYqeg7v2y88kPuyoIbnlv0GvXqUE15VMSOmONpmiEnOYQwJV+3ooC
X-Gm-Gg: AZFdTZe0J9WrF8NpaEvGSVxk5PTrs7qx1kNrTLM8UxUz1XgvB/woGz/ul6dkBB9yvNl
 GM5eUKMRxlLfg9I174Xq/ByiXz/ec0nYbu19nTqluXqgpGueiIe6+cXf75p5HDQ6r98PitY1DxX
 o/Wki94n9C420nOtXH2bsjlJUSpdegj+0UGGeidBvQkCUTmzlb5lmrW+49EtqDkIg9Eh4ix02SI
 08MpovybcuUFF+OQAEimcf/bejlfIh5Vqmb7t4EmtDwbDVmrmJcDlKc6Mi8Sae7Yo7ap1YvdU0h
 H7rcevc/y9Og8DZAtS3OJytYm9wXnlQ2NQkvK5PjjT+0GkZ8vsnEhjS3yKnaEIWeiokq9DEiP7s
 6i3/FuP4Cy8ADzo7wsaes9A/skg7nG3FvZKU6MyO/2ADzFYcLAly8tAhoQT6YOj6VodqZriaQQX
 x5yRVnephsXHfRw4pzQZaj0aNxAuK9JkZRu1xS4091BkxUngWQUGCgmXmAJMc2fZljnoVT7XgDB
 sr5J/7wStCHJVMWUE3R3OkvU+ZzWRtrZDRIEfVQygOqiVwgD5i5GrZBX2OKGSzj1fNMld135ziX
 o1wEdIF++n8/dugHACAfUJlfFWakNdT+Yw==
X-Received: by 2002:a05:600c:190d:b0:4ba:2bfc:c8b5 with SMTP id
 5b1f17b1804b1-4bb888267aemr276593835e9.10.1795505919009; 
 Mon, 23 Nov 2026 23:38:39 -0800 (PST)
Received: from ArchOarora ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf6804sm25975635f8f.10.2026.11.23.23.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 23:38:38 -0800 (PST)
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
Subject: Re: [PATCH v6 18/43] drm/vkms: Introduce config for plane name
Date: Tue, 24 Nov 2026 08:38:23 +0100
Message-ID: <awU9pNtc2l0JXLzs@Oarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120-vkms-all-config-v6-18-78ace90f4fc1@bootlin.com>
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
 <20261120-vkms-all-config-v6-18-78ace90f4fc1@bootlin.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

 index 49510a0957c7..8704b6f71000 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -44,6 +44,7 @@ struct vkms_config {
>   *
>   * @link: Link to the others planes in vkms_config
>   * @config: The vkms_config this plane belongs to
> + * @name: Name of the plane
>   * @type: Type of the plane. The creator of configuration needs to ensures that
>   *        at least one primary plane is present.
>   * @possible_crtcs: Array of CRTCs that can be used with this plane
> @@ -56,6 +57,7 @@ struct vkms_config_plane {
>  	struct list_head link;
>  	struct vkms_config *config;
>  
> +	const char *name;
>  	enum drm_plane_type type;
>  	struct xarray possible_crtcs;
>  	bool default_pipeline;
> @@ -342,6 +344,39 @@ vkms_config_plane_set_default_pipeline(struct vkms_config_plane *plane_cfg,
>  	plane_cfg->default_pipeline = default_pipeline;
>  }
>  
> +/**
> + * vkms_config_plane_set_name() - Set the plane name
> + * @plane_cfg: Plane to set the name to
> + * @name: New plane name. The name is copied.
> + *
> + * Returns: -ENOMEM if the memory allocation failed, 0 in case of success
> + */
> +static inline int __must_check
> +vkms_config_plane_set_name(struct vkms_config_plane *plane_cfg,
> +			   const char *name, size_t name_len)
> +{
> +	char *new_name;
> +
> +	new_name = kmemdup_nul(name, name_len, GFP_KERNEL);
> +	if (name && !new_name)
> +		return -ENOMEM;
> +
> +	kfree(plane_cfg->name);
> +	plane_cfg->name = new_name;
> +
> +	return 0;
> +}
> +
> +/**
> + * vkms_config_plane_get_name - Get the plane name
> + * @plane_cfg: Plane to get the name from
> + */
> +static inline const char *
> +vkms_config_plane_get_name(const struct vkms_config_plane *plane_cfg)
> +{
> +	return plane_cfg->name;
> +}
> +
>  /**
>   * vkms_config_plane_attach_crtc - Attach a plane to a CRTC
>   * @plane_cfg: Plane to attach
 
Sorry, only noticed this now --one tiny things: this helper is ten lines with an allocation, sitting in a header. coding-style keeps inline under~3 lines, so maybe vkms_config.c is a better home for it? :)
