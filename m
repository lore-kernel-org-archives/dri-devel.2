Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61584606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pz+lfHHp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3B3310EBF6;
	Mon, 23 Nov 2026 13:03:20 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E1F610EBF6
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 13:03:14 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4bb68c197c7so40818595e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 05:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795438993; x=1796043793; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eMLemh30tOFWEd3J1uHpw9ECe4OgdCLjsL6KtAJT/rA=;
 b=Pz+lfHHpnsfZGpZwbbdvzKvhiPpwdA9LSUaMlehm1sGoqsCSfLazr+LgKy7d8GRsse
 LJ72VVhFU6vmj3IgKiIjbQjzDpuqJvG+eCttRGvO6yvMmvju3zkEHfwFbOAs/KwdVO9A
 uFg/xqEmDZsMFU7AWCBPh7llg7pqkNwQM0q83DBsZ97kIpOFz5rdHYWdImMvh10BqqIZ
 UouHbbbJ+ktGoxVb6u9d0IClIgr4Ly0rQGtTmYUVERwLbdxqs1//Le38kiZ8t+S1T5nv
 L1XisO4Jm4nbb7mfyWu7Nan0+vr8n37idxORyRi5QG1HBGEZJk610xEOq9qaanrhKNJf
 t42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795438993; x=1796043793;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eMLemh30tOFWEd3J1uHpw9ECe4OgdCLjsL6KtAJT/rA=;
 b=hgg6hHE/4dgRCAoq+fj3c49ih6nl5vIlrlrLZQJN18PNupKQJP2eP++ryOFw4VEPBa
 qv+BK4455tnnQEPYZOIn6RNQA/qm5rdcneI8omnt0xxMcQjaldJm1JRHmpyfIHZlo7Sj
 z3pIfxEU3FBJ/Fm19o/gqso+dPZqk6+Nt3QSRkJnb7x2AGUAIrI239aC3M4S+dJM0SIo
 lhk2ugeKJ6LxI5qYc+dl1ELlh297b+V8tknTtWuFhgGPJX0lZJYfMi3Zgfg2RQY9JLOI
 xwtrWbhJBtmzRXm4hJ+eiHg/Lw6CcPOW2muhAza1T3eDq20cK6GcZQFyuROLlrth9eyw
 ukgg==
X-Forwarded-Encrypted: i=1;
 AL+hErFmII4Or1XPCJhUo0i2A/iwFHDZvrVB+EsrBgiD5lT5TkpJoqeCXhTXPhFBvE8mg1exVsBxEdeZTT0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/Qa+m573vZpVghFwnPkpf2DSH3e+wa/7idyagJc1tEfKSzt0HC
 ve/6jcwB7CLvWBWfGCIU6pQEwuYYBSTjG2MoAkyNI1m3KNzdWLPz2Ny3
X-Gm-Gg: AZFdTZejSBnQLpSdITG1MJ02MZSLcNbUKX9PHEQuy133XYTTqG/jsgsdFK2+Udw5LNq
 GGyBTQUC4vSehjAEy1u8HKavPnWUc2QBxmHnfUoDOYSwFxj+K4FC3I8+NY3km7mc9bQX4E8zpAY
 xOyilIMwTE8xcEHCL7ow5M4yHee10KaPkPWoIsIkMy05yq6F64WCzPsqVsmKlXSLMwg6JC6NJ1A
 nYRNClviNpUBUs6ddkt2XRY5jx/THVqIYuprtEMkGaAqj6xFpXhRDK27WfDjvbum9E7FJmZDlIi
 XlzW4EQn9V2zcvUfhVTtokRGSD//j0VOl6O/bc6nh9LL3S6GTOIB/vm2uPQaVJo3e64DmwP8N8h
 /lGv+JZkGCg3wcPFixtGwH8PyfRdqMHi6roSagn8KMuODcW+uH0tb8yPncYNzOCug8IGkkTMQYk
 mE3vZj0z2iB8ryjkc97gDnajZcPWSFYP/dfIAPcoMeqMvK5qscW6T+Y/rGqurcd/yMc28/jP7xh
 u7bvFlV8ly8cQdo0lM9Yd7N97Ksng1nsWacYpBcnO0MESWB0DzO6K/V44re18xmjxG3gb02Umi4
 A/cbaa/jvf18JlnntnHiigz5qv+ED4gXfQ==
X-Received: by 2002:a05:600c:a085:b0:49f:e8bf:8f9b with SMTP id
 5b1f17b1804b1-4bb887ca0dfmr253189505e9.4.1795438992240; 
 Mon, 23 Nov 2026 05:03:12 -0800 (PST)
Received: from ArchOarora ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b39b6sm310848795e9.12.2026.11.23.05.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 05:03:11 -0800 (PST)
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
Subject: Re: [PATCH v6 15/43] drm/vkms: Simplify plane_release code
Date: Mon, 23 Nov 2026 13:02:55 +0000
Message-ID: <awQ5FMhggIVxJ4py@ArchOarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120-vkms-all-config-v6-15-78ace90f4fc1@bootlin.com>
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
 <20261120-vkms-all-config-v6-15-78ace90f4fc1@bootlin.com>
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

On Fri, Nov 20, 2026 at 06:58:57PM +0100, Louis Chauvet wrote:
> plane_release  code used multiple intermediate variable, remove those in
> favor of direct access.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_configfs.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
> index 5f5aa0a1812b..a7ddcfd4e86e 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> @@ -331,13 +331,9 @@ static struct configfs_attribute *plane_item_attrs[] = {
>  
>  static void plane_release(struct config_item *item)
>  {
> -	struct vkms_configfs_plane *plane;
> -	struct mutex *lock;
> -
> -	plane = plane_item_to_vkms_configfs_plane(item);
> -	lock = &plane->dev->config->lock;
> +	struct vkms_configfs_plane *plane = plane_item_to_vkms_configfs_plane(item);
>  
> -	scoped_guard(mutex, lock) {
> +	scoped_guard(mutex, &plane->dev->config->lock) {
>  		vkms_config_destroy_plane(plane->config);
>  		kfree(plane);
>  	}
> 
> -- 
> 2.56.0
>

Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>
