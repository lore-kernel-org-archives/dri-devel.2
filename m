Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8544A606A334
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cMmhkvdg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF77B10E8A3;
	Tue, 24 Nov 2026 13:56:58 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7C8D10E8A3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 13:56:52 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-497614c95f0so2545133f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 05:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795528611; x=1796133411; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=anD5m1AxXBnKPgg8ZQZ0gwUoffnh9QZT8UfPtY8eE3c=;
 b=cMmhkvdgAGPJWckkh+KJxPjfolQOirNyxSTzX1Wgp67bUZDg3iN0HUIfHOHsO7dXCy
 w4bM124iqdwwlRlpzYHzKWolMZ1G8lfQKy8Q1puVxiwM9yW+s2Wf63eMW14PsPI8yDr9
 FYYLLAGhUYItvc/peYAmQtZhQdao3QQhAgB28TSmzNSpydF4mRGgk/m263PMup0xYTkU
 CdFwvR0XvoUWy3GuPo3n0IHJVqi6N7ifiGZc9SJQr8eM2RbokPk5iW549OSAeNq8lO9/
 M/IzhlVjVTyOnDjDf7MYRwSsRyv4NOKZ+AHLS6o5UU+tE2cIjTc+avaAk0D4nCqQYCW1
 CmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795528611; x=1796133411;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=anD5m1AxXBnKPgg8ZQZ0gwUoffnh9QZT8UfPtY8eE3c=;
 b=D2Q0k2fvj0GKJcIQblyWNxZtvBipmM9qsiYhWGd3SUmWGYLZXwEVZCihZew1TaqlJu
 yTrWo/yKcL3CM2DIjm/26JuJHwUHOz2ayUltXpRbGGIMhsE0i3/D5aopwuWS9iuCtQaV
 nQIa24njdLWImDBvSxPd8b67Xozo5JWb3jh3s3q6t8z05k3iQ4fMs8h1bky9MQ5SCwq2
 304wI67YKcwEAG89q+JxQTQn1SretHdyJ3C/XARKXjGDriJtf2w/CYk3+FtaJ2PEiFgM
 V+8RUbZyukAcY4N26EEOX0AqISW8HZqnd0cXRJ61g41yR0SPkDYThd28h7lsUtjHSTJH
 FljA==
X-Forwarded-Encrypted: i=1;
 AL+hErELXfMdMqeasPyGDarxchQn3iRbGpH7/LaDvLWrWMzv/zOMffy7FVu2R+5gZpLcB284SZFRePGHgwE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+3z1Pd+YzkhMJJUMScN9jtFictJCGD8unUsXrI7VjUTwJgD9HH
 fV/HYpw2B/nnJ60JqPTCEdGMAxvo40s4zWOmcRo50qRfWJTouLrqz1hg
X-Gm-Gg: AZFdTZev607QXFXrgGxFiFKSv1029dOfaPHj8FsVMZnv7ZkYK9LoHFEofgAOgdHIAKr
 Cd3XEBXbsa7Rz44qHjLr3PUkK3k+OQHI0vxC7WWuCtrSFkd/h6by1ujbxSdB+MGW0oKV26seFEP
 ZXmiGva8VUyAUyMn9rrdqDvPOzURI1GMIPY8J20CU6c00rK+GlyyDZ4np5bOnz/UYxRUQPn8wqn
 P778lEdP3X4j3bFGaANWQb+PTiGmZFBI5VQDQf1mIQyy2q5v/12P3NqgLovVODc07jE45A8aGbd
 2j29UyZbl8zHIWSS8zjYt3GhjqWq3w2FhG03vHZXkv+NckyZiI7jf0A+gFATS9A1/iUR5iasBhP
 cRlss6DMdFoxlPPJzgIVKfnMQFpDQqcwgTTGRRVK+VmpsoqEPdEw0mC8k6SSxMiYQ/w2ZVqRW4r
 vg4PJ72uLiany07D96OVOwAmY6ahSDpU7//MvJlJ+YwK4rpxooFJ3HisDSL16Ca90AyX0SQyYjb
 WX1ctwewrasyNk7VsuQ6AyhMjDrPlBlk8/GNfda2rT2DE8yJz96aan4kYNUGVt/zioe3X+fwcTy
 g8cX2+bXgyypdbmiqhBJGO83zcO0NeU=
X-Received: by 2002:adf:e197:0:b0:492:b5d9:feb9 with SMTP id
 ffacd0b85a97d-4abb3a4d8f7mr26010339f8f.30.1795528611263; 
 Tue, 24 Nov 2026 05:56:51 -0800 (PST)
Received: from ArchOarora ([95.179.249.152]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6baa397asm28936616f8f.48.2026.11.24.05.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 05:56:50 -0800 (PST)
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
Subject: Re: [PATCH v6 09/43] drm/connector: Export drm_get_colorspace_name
Date: Tue, 24 Nov 2026 14:56:38 +0100
Message-ID: <awWXgzY_0Q2Wtn7n@Oarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120-vkms-all-config-v6-9-78ace90f4fc1@bootlin.com>
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
 <20261120-vkms-all-config-v6-9-78ace90f4fc1@bootlin.com>
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 06:58:51PM +0100, Louis Chauvet wrote:
> Export drm_get_colorspace_name so it could be used by VKMS
> 
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/drm_connector.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index d66188521881..fbff5871355d 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -1528,6 +1528,7 @@ const char *drm_get_colorspace_name(enum drm_colorspace colorspace)
>  	else
>  		return "(null)";
>  }
> +EXPORT_SYMBOL(drm_get_colorspace_name);
>  
>  static const u32 hdmi_colorspaces =
>  	BIT(DRM_MODE_COLORIMETRY_SMPTE_170M_YCC) |
> 
> -- 
> 2.56.0
> 

Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>
