Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BD4606A323
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MXr2Lfj/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C2010E698;
	Fri, 27 Nov 2026 11:41:06 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FE6E10E470
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:41:00 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4bb606491faso42250715e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 03:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795779658; x=1796384458; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bp/KRA36N8EH7qPrylVQjtX79x1i14QeIGDoVR7yhis=;
 b=MXr2Lfj/Q6xFffIcotj8/arD4rOtAmFYJot5GyJlUKProNDHrWrcQa64E2NWLM/xl/
 TIGN/pYUce6ERnkOfXFc57Xb8XbPGj+d4Z+FPmP2cig/XJNL4/oVRF14gKVwQyIpOaT3
 C7rV1ypkyxPFPod4mC+LQcU6eg1YcQoGM2aTE2LoWJCnFgtONI/TXbho/ocJ9dItgoY/
 R8zPhcTqzMba+LjQ14zs40SL+96XkfSRY5p4u9/k/JZmilRpqi0z+WnO30iSvHBxOQF4
 RalZDA/p5xKbbj0dMi0AJ1eBdUlk9i0fMmZdevMPTwMlnxN9kUxHVXKVKuIMVDzU84f9
 w+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795779658; x=1796384458;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bp/KRA36N8EH7qPrylVQjtX79x1i14QeIGDoVR7yhis=;
 b=PGKRT6UMOBaHhM/FU3+syoq6zCYsysbrPNxXrQ6sGhEcUN8uMuidZCV6GnF5ii9o35
 ZoOjZ/GCw6HZC0YABFMA4i9UXr84sLzxqOABFxypNRUxwMs+2NOVU/2SP8A7Z8AEPPR0
 YE3gwJxGr8g1hbavdp7RSbRv4xZ6pi6c/7gv/GGs8EqxXPN+1yACdg5baO/Wly5oZSZD
 UFsk25mXDSR7+kvIWVla4uclcZBP/Qy6GEqbtG7cyieEWu9/jYiKBhSpvCTjZW2Omyrb
 mAnkJnNAuxpeQ6NMuNxhai9G1wg2NM47BvHep3hrWJICt76+LzDsdnRLRKYdUTNutoov
 MnHA==
X-Forwarded-Encrypted: i=1;
 AL+hErEY6Ng4DibrHBq0jO7x2KWddGuDkkm3TsBeaOs3Jrj4WRciw+4y4wfgItVmJuDFDYaXBHgvipA1nKc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8SdXgCRQ9gYb9MDg8UzDRhUEDd6wlPmY2fu2iodpqG5anZhXr/
 unnfjsZz/RDoWoD/td4KhgT43IRMMhWFUH36m2FiHVgW9FNcBQXzLii1
X-Gm-Gg: AZFdTZcXvKwQYc58HKo2erWGf/nvPDjQohliOp3FLxFLr8C5YPnoAIjUaQ3HidJTryh
 Nf6EMUsNArgLVu9U4epcJg9+iBSORXI09wDrP3QTmuQzt4c4TxOvMI71Ct8cG2tZPhP817/x49C
 O72cHP0ALdAJP7KpuISDZwFezt5RmljxF0rbg5NGP73leH/8RlJE8Ayco4L3JYp5Lk4NnmYLDXK
 NnCL1fGarcllpMQzWiEzYA+ft3TxsxmSxvnhXLunhuwrDRJIKGyhdtGC7pM/5uDAYz1Ki79Tw7m
 jL6rRgMht8zoobTvYxw+WT0bdaOakvt/AdNNDrTm8wizWECEvrpdigIY+z6VDfTwLyvVhcH0wNh
 5Zp+yVjf8hOaXzpTDN+fuyOQSdkom1yxnvXKlLkkKw3OnTvY4s550vTdCKUMa6J2hzvzBgt3gTI
 /VRDxTCQSvVC1fiMwj9W3piDOQwrzRy3aL3yvDxbG2p1WaA5lzt8S+d9+0REIYL049fpXjPQOgT
 W/hkz7m9HFd/5oSjtSOo010z900TDRSkEkFI7v0yDrvxMMLU5hkKk70RdtjgjAWQA8dEzBFl6ES
 WlDd5FTInQypyt0cNzvCgATuij/KKTU=
X-Received: by 2002:a05:600c:5246:b0:4bb:6de4:2f7c with SMTP id
 5b1f17b1804b1-4bb8881c5bdmr504767125e9.20.1795779658410; 
 Fri, 27 Nov 2026 03:40:58 -0800 (PST)
Received: from ArchOarora ([95.179.249.152]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d60sm47752163f8f.3.2026.11.27.03.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 03:40:57 -0800 (PST)
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
Subject: Re: [PATCH v7 18/43] drm/vkms: Use plane folder name as plane name
Date: Fri, 27 Nov 2026 12:40:44 +0100
Message-ID: <awlsJLmNiJhyZH6Y@Oarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126-vkms-all-config-v7-18-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-18-21194cda2468@bootlin.com>
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

On Thu, Nov 26, 2026 at 12:29:01PM +0100, Louis Chauvet wrote:
> The plane name is now directly derived from the configfs folder
> name. When a plane directory is created under
> /config/vkms/<device>/planes/, the folder name is used as the
> plane name via vkms_config_plane_set_name.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  Documentation/ABI/testing/configfs-vkms | 3 ++-
>  drivers/gpu/drm/vkms/vkms_configfs.c    | 7 +++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/configfs-vkms b/Documentation/ABI/testing/configfs-vkms
> index 26e7f81b5b7d..55e4183046ec 100644
> --- a/Documentation/ABI/testing/configfs-vkms
> +++ b/Documentation/ABI/testing/configfs-vkms
> @@ -98,7 +98,8 @@ Date:		Nov 2025
>  Contact:	dri-devel@lists.freedesktop.org
>  Description:
>  	This group contains attributes corresponding to the
> -	plane <plane> of the VKMS device <device>.
> +	plane <plane> of the VKMS device <device>. The name of
> +	the directory becomes the name of the DRM plane.
>  
>  What:		/sys/kernel/config/vkms/<device>/planes/<plane>/type
>  Date:		Nov 2025
> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
> index c57791df72cb..bbfc0c8a922c 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> @@ -375,6 +375,13 @@ static struct config_group *make_plane_group(struct config_group *group,
>  			return ERR_PTR(ret);
>  		}
>  
> +		ret = vkms_config_plane_set_name(plane->config, name, strlen(name));
> +		if (ret) {
> +			vkms_config_destroy_plane(plane->config);
> +			kfree(plane);
> +			return ERR_PTR(ret);
> +		}
> +
>  		config_group_init_type_name(&plane->group, name, &plane_item_type);
>  
>  		config_group_init_type_name(&plane->possible_crtcs_group,
> 
> -- 
> 2.56.0
> 

Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>
