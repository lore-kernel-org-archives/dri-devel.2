Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F5A606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bh8Id5Ud
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56B8510E1CD;
	Mon, 23 Nov 2026 13:36:16 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43C6710E1CD
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 13:36:10 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6b894a5ce3dso4366909a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 05:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795440969; x=1796045769; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ndp8NPT5TSJ6UFCJr6F45UdWtUB0BU/WIyewS4Od3DQ=;
 b=Bh8Id5UdAXPAgc0OHCPC0M4nKgmSlXF+utUBEMKQ3qTCj8sfREtHxLEMgOzG0PcAIP
 ce2Dvw/miOequNf5B/n5gxFu2p3nHiwMI6Tc1oNQs+eLxUSLo7CDEgv/NfqtrO6eR03I
 76cGTC4FygFP6aLV/Bk+psNSAEb0G0k03EPh+NR+veSfTSceWIEBNun5cHiX/Jo3m/bJ
 9otd6Zeu6T+0jYhy8HcWH01pG203nYNEs/Yokxgz9eiyRgltguX3CprTqADZQaxhHRTH
 eJDMCL7FKwrMzfJvJ7/X2u7Qs4vusKL6OwKVeeb+cvaP9N6M+z6vVNcYqJqAII+doq5l
 rgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795440969; x=1796045769;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ndp8NPT5TSJ6UFCJr6F45UdWtUB0BU/WIyewS4Od3DQ=;
 b=ECfR6loOHayA0lEoQwcDm6D/KfrME/HcmMUta7VBXdsQEf2EsqzTCycP3ncp+W3S5F
 0uZvywjzGQPBbsk+uYXsB6QABCqLo0rjjTNxi3kQJgqBEaO7bZUkAL13vZJnKhp1XJYD
 vWSA6QNp1yAe8/KaXyTihijYhr/ylPl2wcV64i5jITlGaVw9KGBQcvJRg6VI8GuimUrE
 SF9jJSzz2kUuL00RdzvouvvMIFYLZw2NSQvCVr6l3SErQ3hdhisa+O4zCnx96x/CHjcz
 RpuvUgekPTXuJW5XuF8Skh0F95Uxxo/ftqSGcvD8fSEo5rKm12Sl1bEff5a5l0RY/TuF
 QPyg==
X-Forwarded-Encrypted: i=1;
 AL+hErFSxKzbo7z9lDNUVKmcoeTBiBg/3Gpf90zteUbuiYOukEHTKGkoqjhcHQubHtXW3IKVTO1PzyUz07s=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/fDk7x/KmVI/cMtJG5Npfm/mTgWcaRdynmPYuRaYpyxQjVHb+v
 kgmrBR3HLbk9NjPdBFlr5H0ffh6rDnc5B0vx+xBlWxEqO8exkqqwoj6g
X-Gm-Gg: AZFdTZceEInfbAtgsIt6a7FIezkZ5WxAXU4mlLM+EXp1KLD4hZeqQbtKNWDBxKcWOAZ
 U5fiiCwb16ZhyiJOtrqNgheh4aCqxnGf7rUUvrKEIlY1gk6uXaPXU3TI8TyVup2zTwezXxZaWK4
 qod0u1yS/Uh/W59OyU18rvlvOhtaDvV6OLnUq37oOIWeZHOSddlcgP4XRRIUpoe3YiIpv6QE2AY
 uEKzS22r27YpD4ya3pycmkWyGFAfY+D9XE3DrRnRp2JSyv1DsrX9tfoi5AmKRn8nA+xA9haKL0C
 xDFEMyMIN58q2kSe+0/+bUGKz4zGsIpDjcGeUqWMd257cFCXNoT7e54yD7K4f8GxZuwhp63BsBm
 3W9WfFiyso8gWEEGU9M324Z1HFwWyaiVMHqfIycFFusslscn3wBGC7tOdO8OtEjgv0mnRfJUYfE
 tzls/E1GE+CP2G+cDMtveTa3KepJpyGRiWG7Wsoj9nXV1LkZO+npRerdOqQH8e20rxls70iuBiu
 tVcpu3JfZldfyDDRQMYJse0aNaZjZh2nB5mnfmJpYtOfUCaK2nIoZaWe5W1irTbRlbL0CTnByDR
 /ApZoVBsLgH5Dht6jS8l7JU6pjOmyMbUdw==
X-Received: by 2002:a05:6402:210d:b0:6ac:c1fc:8a98 with SMTP id
 4fb4d7f45d1cf-6ba37ec77e3mr8770739a12.42.1795440968562; 
 Mon, 23 Nov 2026 05:36:08 -0800 (PST)
Received: from ArchOarora ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba854bed08sm3275302a12.30.2026.11.23.05.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 05:36:08 -0800 (PST)
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
 llvm@lists.linux.dev,
 =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito@redhat.com>
Subject: Re: [PATCH v6 16/43] drm/vkms: Explicitly display plane type
Date: Mon, 23 Nov 2026 14:35:48 +0100
Message-ID: <awRA6XtJ8O13Enq_@Oarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120-vkms-all-config-v6-16-78ace90f4fc1@bootlin.com>
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
 <20261120-vkms-all-config-v6-16-78ace90f4fc1@bootlin.com>
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

On Fri, Nov 20, 2026 at 06:58:58PM +0100, Louis Chauvet wrote:
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
> index 03f2d0f0e327..44ded8a86a6e 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -391,8 +391,8 @@ static int vkms_config_show(struct seq_file *m, void *data)
>  
>  	vkms_config_for_each_plane(vkmsdev->config, plane_cfg) {
>  		seq_puts(m, "plane:\n");
> -		seq_printf(m, "\ttype=%d\n",
> -			   vkms_config_plane_get_type(plane_cfg));
> +		seq_printf(m, "\ttype=%s\n",
> +			   drm_get_plane_type_name(vkms_config_plane_get_type(plane_cfg)));
>  	}
>  
>  	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
> 
> -- 
> 2.56.0
>

Reviewed-by Oarora Etimis <oaroraetimis@gmail.com>
