Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD90606A327
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aJZPEXEB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADDD01124EA;
	Fri, 27 Nov 2026 10:40:24 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3989A1124EA
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:40:18 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso56838075e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 02:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795776016; x=1796380816; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1AjK2nvlqvf8IJCDZeqJhDHtg4Ek4fFwEyf2Q1hpYQA=;
 b=aJZPEXEBwy1Dc92UYvul3mi9NR6Z1QIUPqV7Oho9SY/XMs1hoEqciCu939YJ7UKdH7
 BU3FNS3eRqQdBm6kRP4WWM0huS8Dqk0QXzwCJCo3gyWzeUeeWZ5shZ7KtlOFxOYwTjHF
 CTZuX3Wk+wdsphuiv9hjfvuo+PDBIzYXGjgwpCutaRP0/dkufTe1XAVKzQZnYBYXOodr
 CUAluHMqnVbXbkulkoeSgKq1e0yMM6orFuPH2J132oJ2ZS9+o2ECnZ77jKJgvly9ouT6
 BoPsBsGa4mpTESdLXrE4xJZSxrk3vXSmmO527pSkTpBCP2PLBVMHv7teMvsWt6NxAY3P
 nRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795776016; x=1796380816;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1AjK2nvlqvf8IJCDZeqJhDHtg4Ek4fFwEyf2Q1hpYQA=;
 b=TXuKqPKPNRlJZJRO+Y/8h3in6Abjz6iw56cOfdQT95Dc6vv0Ak8OJoScD0oVXl7vPt
 tJW0Dr/18XVoQTS8vDsaar/pauEhvRE3W12xj81HIFqTtZI/4iIekz2mm+o39J41ESKs
 wgbfb63nUfQhaqHFkeLi3pUvOTUoUwR/Jw8KVDb34Fj0QHcQ7VUFhyRbexXWIu+gPSMZ
 qGpvCVsaASkscTPgmX6nBL4unBAydGZkLEBi6EQc4ew8Dn57IaCqjIkyII93zjfNVmtO
 jouazpCCu2Uuxaq1IpPTys86FzGs3+Q9LAJPyVnpKGi4VXMCSihG9bFsX+dzNURlD1JP
 QvOw==
X-Forwarded-Encrypted: i=1;
 AL+hErEyCA/VbYtGiLD2mtAGZwfoWc5Pf36bBncMEsys9MSuuEYpV1j/8Xf2pLPRqUJp6OfeB9xIg0rKzhk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z90s0I6BDPIEWRamMPZzu34N8PXFbgA4kR69jIa+G47TOYe0wOU
 +iv9onWEcty/DlmaR45ZUTLeuOiW/V/YENdND1pH/Kga3RQeq3Rvz1NZ
X-Gm-Gg: AZFdTZccOOBCwZwDn4iQR63A34pREWpyNfXAYDmcxhVkiV1WHpv9/571WGUhGBl8cls
 R7QeJjB1H9qa92zdf2fc7o1jr+bDgwkbgGupp1iROgIPuDibEF8DSSglkAaMVCWyO4rsvJsX0YK
 0DBbLMSxmzKZ9Eqiwml4lqP5d06G324QiUCvxkiam9B/elu07XabyCeksOA2XS37J141nQC9iuv
 S9CZOo7+Y5ZGfs/yGA252MW8LkFBsWSSK88AXV+K3121og8luazsqqHYJu98Mx7h2lFZPj05klW
 VrhtRAZ1HzuxBtJ9S5ee399Ks/PbcM/nlR7hxMGF/sGt5bEqzTYlvQfWbhMzH4GhisgijJkNzXM
 yU+vefRxUNmV3vp4vjtG/7hPSLcFgygiJUdXjt3iV8S4o+uIUkkjji3c9M1Vw80b+svfiyjy6jw
 gVxQ5xI2FuxfbGEO/JoksWnyAl0yf7XNd0rr7gtYgViw/uNOml/FNgwbT3HSj9pkcCa2QM/lMv0
 teX8sU2Y+wVlpeCNfj8bRSSasSKzmBU636Dx6+QxMF1GxmIS8AVsN8rPXyBZP2v0BmitlxLgIFh
 ToAyGE/XgL0VLaHU7LmuCSHIbdL/fSw=
X-Received: by 2002:a05:600c:4584:b0:4bb:6c71:b269 with SMTP id
 5b1f17b1804b1-4bb8881fbd2mr479775985e9.28.1795776016441; 
 Fri, 27 Nov 2026 02:40:16 -0800 (PST)
Received: from ArchOarora ([95.179.249.152]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab65cb4341sm46259273f8f.4.2026.11.27.02.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:40:15 -0800 (PST)
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
 linux-doc@vger.kernel.org, llvm@lists.linux.dev,
 =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito@redhat.com>
Subject: Re: [PATCH v7 15/43] drm/vkms: Explicitly display plane type
Date: Fri, 27 Nov 2026 11:40:01 +0100
Message-ID: <awld6GvGP5acwJxu@Oarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126-vkms-all-config-v7-15-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-15-21194cda2468@bootlin.com>
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

On Thu, Nov 26, 2026 at 12:28:58PM +0100, Louis Chauvet wrote:
> Debug information are mainly read by human, so use full name instead
> of values.
> 
> Reviewed-by: José Expósito <jose.exposito@redhat.com>
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_config.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
> index c5d90f7e934a..e933d61cb526 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -388,8 +388,8 @@ static int vkms_config_show(struct seq_file *m, void *data)
>  
>  		vkms_config_for_each_plane(vkmsdev->config, plane_cfg) {
>  			seq_puts(m, "plane:\n");
> -			seq_printf(m, "\ttype=%d\n",
> -				   vkms_config_plane_get_type(plane_cfg));
> +			seq_printf(m, "\ttype=%s\n",
> +				   drm_get_plane_type_name(vkms_config_plane_get_type(plane_cfg)));
>  		}
>  
>  		vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
> 
> -- 
> 2.56.0
>

Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>
