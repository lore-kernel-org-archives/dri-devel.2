Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F6F606A6AE
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QjCEaRtS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 298D310E4D6;
	Mon, 23 Nov 2026 15:36:49 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37DEA10EF3E
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:36:42 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4bb6adaf0f1so30257435e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 07:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795448200; x=1796053000; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iMj2t4hUan0LrC5voc+bXHqikDQMoVSMga8MiF5GiH8=;
 b=QjCEaRtSnm8HdP24/T0gKdI8kqlpqeCQRec7ur5mI2UQ+33Jjdcum0awfO5fmne5nE
 XcqPnUfPHowVTVWMU1PppQMTHeUZ2gu6UQYi8dHLNm2FtdHH+cawR8jNkbD/wkFKX9NW
 Q1NmCDOFy7hGNoyLNBsEGf9SR7VcbfkvfXRvkO5uRrD5K/Z/3uczOgW8aae2LyO8mgRK
 Kz6Nc07DcKR5gUxf5gCyMZ/NIINrG2GK8GlgI4W2kCJFgRSDKWw2ZIvNrjg9YkxANy2N
 /nEJFVGHwpQQOs98ySL3UV9H4AysMMcoOrozujWd8jXFhhI0LF9M9xT8iiRhKl3ohLsn
 cF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795448200; x=1796053000;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iMj2t4hUan0LrC5voc+bXHqikDQMoVSMga8MiF5GiH8=;
 b=dvJlFDbovBiypNpImbnY6xhZ8I8ANluipYZfSaVDcDIgmLeneSuV1mhcmA/n/kV2nV
 HWftSebIqFezFT3a899o7ZejRgy0lyhYsE1jvnrpcHPrjutzCnaFVYxm3sEUHE9j6PuD
 LviwpIN/nxSc4QtvtjL3VG3zE4oG1zKs/WBs5g+2v6kCedKVZIhpvNDJD3QYzw/7wPR6
 ggwd48UfqBMf+vrBARDaS0z5kH346ahyhDlYCcW9kfZm3XGb09HXH3kacAbqHnJY5WvF
 0GWsYAKVOxVFQyI/EjzQyN+CAOukyz+FnJnvFICbzo4PXgQ2DqmvXAqnMo9/3sKZaK2M
 BfJQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGC3yOOCxkLF+3yueI+m1guEdG3aJvyhDP1lr9nG3BntuRiXKDVSk3b758NHrTghV+Vdg5ySH+ai3g=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9dwMCHxhkr88BfgwIDwrb7gR8637yrSMENNRvWfM+id3fgOhGH
 4Qp27KaNlJsh+0qFD4MoR14dCjXZJZ2rGDcd9nqXcl/n3pg1NzTWwcEy
X-Gm-Gg: AZFdTZdQRmOQAY6qhRH4HGQkZ31JZT6VDt0UVePoj2pOUIy3GgdcjESa/txmIRW0yh7
 zMB8bUYg/g5mtrGrjiB5GgQ0S+lCQy31n2NILzeAm4Au09hWRZA1Cs3JU6w6HDglSqVP/cAmiD8
 HBL1nDoXnzv565x/rq8rMJ8qaRGH1Ll8ob4FYGrXC1G4KemodIeVPkAvQFRboLmf7jeWAd+pprQ
 zXZyu6I1vqW1okRSVphEK03Qce/0Ayp5YvHsSVjlUrm/C1Cpc6JyhbKyY01gqQ6qAdsP26c/A7z
 H7EOGtti0+OFpDabZNnyzy8aXEoEVVBs0TmFBd25Tywj+49JYZ3f9/xHyMgGKXB0z7KdxidfMhF
 uy1De9YbyJkDs+IzEsZ7NCQ2d9Rji8uld/G87H62Gkm0N41cy+5AfO/0eiok2ReqFAZD0M2ptBY
 ldpdF8PO+ejQW+fon//RKPVkjoRq2odn4ktBclxzB5/yGSmsG0Ra8JrBlnVZwtbckpboYKBtEna
 rb9BwXah/UQUmIFHZwUzQyEJltkXpng0R36sashp1mvPl6odBp1pWr0XrbTd1HX3Xedi9E02LIx
 FoGbnWgPC4R3L/PR4EJRJHEo3NwcVIaRVw==
X-Received: by 2002:a05:600c:3b88:b0:4a2:191f:7cbd with SMTP id
 5b1f17b1804b1-4bb888078a8mr280286605e9.11.1795448200216; 
 Mon, 23 Nov 2026 07:36:40 -0800 (PST)
Received: from ArchOarora ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb90655f5asm193318255e9.1.2026.11.23.07.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 07:36:39 -0800 (PST)
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
Subject: Re: [PATCH v6 19/43] drm/vkms: Use plane folder name as plane name
Date: Mon, 23 Nov 2026 16:36:17 +0100
Message-ID: <awRbCaRRole752Pk@Oarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120-vkms-all-config-v6-19-78ace90f4fc1@bootlin.com>
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
 <20261120-vkms-all-config-v6-19-78ace90f4fc1@bootlin.com>
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

 
> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
> index a7ddcfd4e86e..3a1a34643cce 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> @@ -375,6 +375,12 @@ static struct config_group *make_plane_group(struct config_group *group,
>  			return ERR_PTR(ret);
>  		}
>  
> +		ret = vkms_config_plane_set_name(plane->config, name, strlen(name));
> +		if (ret) {
> +			vkms_config_destroy_plane(plane->config);
> +			return ERR_PTR(ret);
> +		}
> +
>  		config_group_init_type_name(&plane->group, name, &plane_item_type);
>  
>  		config_group_init_type_name(&plane->possible_crtcs_group,
>

Oops, looks like this leaks the plane allocated by kzalloc_obj() above :)
