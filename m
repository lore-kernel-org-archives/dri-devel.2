Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE37606A32C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 07:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vUa0DF6o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11360112341;
	Fri, 27 Nov 2026 07:21:54 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEE41112341
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 07:21:47 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso55438695e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 23:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795764106; x=1796368906; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RFWIIK5B2bXDOJcKTvFKiX1dOLs0oT0s7HmTLBjeOw8=;
 b=vUa0DF6oQvbpX3AygKYdxAa9BmjsnjD7TlWt55yDmBCIhLzPcCQfXOsw2t6wmhUUMH
 kDcJmMmOF4vSQc61SV14kkcXz2JMXzkVus5EnAnUHP1XwxAJO9bXiSNg7TXX7N02BQVR
 1iDDkw2ITLy0dneoEOzPiJ8LeIJ69c0+FgCe9d/FD1GJMbdz7MPNTS8bm2wwKVVX3dji
 NAX1kqW60Ty4d/PPzQNcTU95yMT3EG0mUAsqnUw4MSRxd4dj/89cP2C69aYth5H4Qm52
 vEd6u8ZoC0IW06KYTeIGTb/PnhD+05UEj2pteDWQ3FVYJ8SFIyYcwjPffhEYo+OR4mPs
 FKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795764106; x=1796368906;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RFWIIK5B2bXDOJcKTvFKiX1dOLs0oT0s7HmTLBjeOw8=;
 b=C0YS2f5r9cWXH0tmT5YN68R9+JnX3ai/ZTqDU4zPCZyzVjsr4pJgfyePnTprwFWug0
 tI0iK68poGLvUL5TUyw24xNDJFHb961zKmVHW256L+w8e0PHCscvrH3VLFEdwanfmaOQ
 GsH4ux03oKz4E0IzdhRZIlHsCGlxQR9FlgIm6dh10i2UQ2AxujsGU9ftc+lMkMhtWYsd
 fTRyzVZ8cdwr6xEDGt2JA54rJbCvBeTSyv5+p3HW6Hi4bQVKr92Z358Sf6IVYpv/eQL8
 Y9l07Qo5Ot5SaeUEsLA/BgQc6mZ6z/5YLixER7xK4+vG+Z6Zn4KY4LOKerTb2db1cWbF
 bOlg==
X-Forwarded-Encrypted: i=1;
 AL+hErG/cXW2w9Ekgj+J92T3tiLPmh7kMdjxFiK8NNLy3ayVSC+7FWjhtgB9n6f/v/7bgb/rUkhRz5xC9oo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+1BpvLF4U+IjLQh2SqI7oYJCTpjGr17UBUvOkrFcwj/S4OehU5
 AtKnwscapV6BgL5MLc7tjcBMI+sSnFilF0Gny77S2dlpDkX/FKj14THW
X-Gm-Gg: AZFdTZfpxYav7J9ekCNJqp+mM+DTv9l3SJOZcGpx5JkE98+QeEiuWZCb3we6X9mamUe
 q1DxK5XlmFbndvPczqM6Dkvnb4YSSn91kxTtZlPCcDAiPmxm3jo7EQc84ZMJuSHgE6FntwoP0Oo
 gABacAxQkAOybIwQpBfQmqkJxmCoJFittyr1wB0LhXhlbi/BoLcOt8a5VOXeQ2AtPGCA38pPpIp
 KRsAqHGxLk54MhiFvDDcf2dxI4G/Zq3Ou9c+2tJaiiMwjy4Sh+QnnMLlfH/RfX6NizUSeMumWpK
 RyZyanHoyMVaOiiQdVjFN59huNTjJwGZ82zfNJOXASUk2ekgjCBpDy5RJZp5RC/nisGGuD274YU
 n3XByG7w3TpF251uC+h4DZn0EcBe+X3QdDhnqutIqUIoc3zVzLv0TMdsoZBPCBX7k9mHmLjc2Bn
 FKiYxajL0y3Z7l1p61EViHJMVCnumvBt87kKm5YaOuFRv+EZXzWQ2ezP6l85EoSKbHT6cdknPFC
 CDL8Jllj+nrIbKOjl2Mo7Km3njmabaXiNjsJgW6CHfAa8U680Wubq6NQdZhxOHp8587TJbInW6R
 ybbLQrgnzbUEoWW4wKC+9ghSjyi5bX8=
X-Received: by 2002:a05:600c:1d09:b0:4bb:73d5:ab33 with SMTP id
 5b1f17b1804b1-4bb88816acemr509462955e9.22.1795764106011; 
 Thu, 26 Nov 2026 23:21:46 -0800 (PST)
Received: from ArchOarora ([95.179.249.152]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8526cbd0sm885577375e9.0.2026.11.26.23.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 23:21:45 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
To: 
Cc: Oarora Etimis <oaroraetimis@gmail.com>,
 "To : Louis Chauvet" <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
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
Subject: Re: [PATCH v7 10/43] drm/vkms: Reset config->dev when the device
 creation fails
Date: Fri, 27 Nov 2026 08:21:30 +0100
Message-ID: <awkvQvRhbFLBKy8q@Oarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126-vkms-all-config-v7-10-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-10-21194cda2468@bootlin.com>
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

From: Oarora Etimis <oaroraetimis@gmail.com>, To:  Louis Chauvet <louis.chauvet@bootlin.com>

On Thu, Nov 26, 2026 at 12:28:53PM +0100, Louis Chauvet wrote:
> vkms_create() stores the vkms_device in config->dev, but the error paths
> after that point free the device (through devres_release_group()) without
> clearing the pointer. The configuration then keeps a dangling pointer,
> which can be dereferenced later (for example by vkms_destroy() or by the
> configfs disable path) once the device is already gone.
> 
> Clear config->dev in the out_devres error path so the configuration stays
> consistent when the device creation fails.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 28b99511f186..4cbb1173fcc6 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -215,6 +215,7 @@ int vkms_create(struct vkms_config *config)
>  
>  out_devres:
>  	devres_release_group(&fdev->dev, NULL);
> +	config->dev = NULL;
>  out_unregister:
>  	faux_device_destroy(fdev);
>  	return ret;
> 
> -- 
> 2.56.0
> 

Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>
