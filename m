Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1A1C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 01:42:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8045210EF29;
	Wed,  8 Jul 2026 01:42:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="crFilFx8";
	dkim-atps=neutral
Received: from mail-vs1-f97.google.com (mail-vs1-f97.google.com
 [209.85.217.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E715610EF29
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 01:42:09 +0000 (UTC)
Received: by mail-vs1-f97.google.com with SMTP id
 ada2fe7eead31-73be40e5c4cso61222137.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 18:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783474929; x=1784079729;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oWGJMAMsVEI93HlgMZnOI4QQ9qTJSbThhfVSVw6KEYA=;
 b=R9naAk2KdyJ5MuFdnDaXJPEbEqinyhdS4V6MOKqc+MI9jpRWERUWwjakRT7nvC/pmg
 xVEZJgAWPFxF7Ry9zB051+YXmmWo/mn+T3iOv14gQwFoK2o2C6JVOkOCH4dEyr99IG7d
 Iy65lTsae0JjYxGMRX7eFLGVNaebEGRLMdiCQrwgNg2tnoZ/R007P5k+mUU9Vs76zEs8
 7bk6heX3QUcOU3wSpSsBPhGeF6AJaPRvAGKQC4YBQXABIowGh3VdxK/gB5/T3fqAqJSr
 XM1CffjA7hMmfuTjHGayMd6QsBgbDcDYEE93sjfAI0nXX/PS2jb3xEOUMNCrwpf1yZN4
 A8bw==
X-Gm-Message-State: AOJu0YxELIVIwm6dGZC2EgrwncOVGmDdhcf1p0F2i4nehGv8UnZfO9ZC
 DySsWozGNJRtMAb2xcvnjyNmUlLd6ic23/9FHx9iRXlv+jI21QpwXOofOEqomSfIgVr92HGwAZC
 FEWy9O9iy5tDOYHJdLdnIrw8uG/0hUYoiJ2AYW3ps3yx8hFBHJ/+W7t6JHv9W4HZF3/eO8WeuO6
 jMwcsiNUJT7Zn0iDN6og4pq1PXi36sjxCMZ+QqZC8HWLZGzXqdxqFChJ4vgXib5ua9tKDIw0Szb
 Om0YNTta/wC+6VeMZ+vY4cgCQbJ
X-Gm-Gg: AfdE7cmDGfURpXhcegorFaUNghyag4pl7OqOMHShUifJEEgdJpdmdqcf3dr+xCxpIjM
 XkIM+ZPaiM7B3zSB19vRIf8tQnawR600GSbcBKJlLiSqPII2Wg5eoApvjcMQtk5lbpLxf2lh2RI
 jnjSsKO/P+0fmreS5x2uwZr0C+kDgnvDowodSc709e9NsQmhRBf2Izc4MBNN0C+2Z/FqXIxSxXf
 LoVaENFtHA3SiJ+Q2rA6sRxmxNj9BV1wYholwrZXkYzFbTGMcQxcLwCWUzz5wTOKnGlDQZ0T5Uy
 lB8uKNSBtjhEn1PviMcfdiq9vsxgwHLItu8u1QB9L4s0vCVUg1SStAvoTdFo9CX7+pEkIeXI3VR
 +syxKqY9uAnwBo9g7BRPwixL4nz5tpwp/Hqt3PgrtLzoehMguGXcRUIXBEFThIwaQH5ua6Gn6fg
 KnqPB3H3LqM5+Axak6D5o4CspDmiv6y/65QTwZGM49nYB2+8S+md4TfA==
X-Received: by 2002:a05:6102:2d01:b0:73a:128c:4e38 with SMTP id
 ada2fe7eead31-744e03ca77cmr106778137.27.1783474928432; 
 Tue, 07 Jul 2026 18:42:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 ada2fe7eead31-744d6a2f6d1sm73385137.3.2026.07.07.18.42.08
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 07 Jul 2026 18:42:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51a8db414c7so1982091cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 18:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1783474928; x=1784079728;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oWGJMAMsVEI93HlgMZnOI4QQ9qTJSbThhfVSVw6KEYA=;
 b=crFilFx82hOEMwCMyQBlFgeBGvTgv93VcwfLyxTXqZL/2gMNA5811XgliyJC39H4f7
 yDgP7nqJQRLp/sklJDxYUfKtEbQzpbK1xK3s6WHnbTmoEvmy+j141XaNwJ2xIC8Yksjh
 WLma+Ajo7j5kMdP0P7esJ4lxTpCGKjoS94rdk=
X-Received: by 2002:a05:622a:1353:b0:51c:1b22:b84c with SMTP id
 d75a77b69052e-51c8b4c6ef9mr6876251cf.60.1783474927721; 
 Tue, 07 Jul 2026 18:42:07 -0700 (PDT)
X-Received: by 2002:a05:622a:1353:b0:51c:1b22:b84c with SMTP id
 d75a77b69052e-51c8b4c6ef9mr6875951cf.60.1783474927213; 
 Tue, 07 Jul 2026 18:42:07 -0700 (PDT)
Received: from [10.211.247.235] ([192.19.50.250])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c4190e9e0sm123925051cf.0.2026.07.07.18.42.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 18:42:06 -0700 (PDT)
Message-ID: <cf87fcef-2689-41b6-9e0c-3c26253ca278@broadcom.com>
Date: Tue, 7 Jul 2026 18:46:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vmwgfx: Handle MOBs without page-table BOs
To: Ruoyu Wang <ruoyuw560@gmail.com>, zack.rusin@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260707150544.2272933-1-ruoyuw560@gmail.com>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <20260707150544.2272933-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 7/7/26 8:05 AM, Ruoyu Wang wrote:
> Single-page MOBs and small OTable bases use depth-0 page-table entries
> and do not allocate a page-table BO. Their existing teardown paths were
> written to tolerate that by checking a local BO pointer before reserving
> or fencing it.
> 
> Commit 668b206601c5 ("drm/vmwgfx: Stop using raw ttm_buffer_object's")
> changed pt_bo from a raw TTM buffer object pointer to a vmwgfx BO pointer
> and converted those local BO initializers to &pt_bo->tbo. That
> dereferences pt_bo before the existing NULL checks, so depth-0 MOBs can
> crash during OTable teardown or MOB unbind.
> 
> Keep the previous conditional behavior by deriving the TTM BO only when
> the MOB has a page-table BO.
> 
> This issue was found by a static analysis checker and confirmed by
> manual source review.
> 
> Fixes: 668b206601c5 ("drm/vmwgfx: Stop using raw ttm_buffer_object's")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_mob.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_mob.c b/drivers/gpu/drm/vmwgfx/vmwgfx_mob.c
> index de7a504de9ce5..7cfd96e6e3489 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_mob.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_mob.c
> @@ -204,7 +204,9 @@ static void vmw_takedown_otable_base(struct vmw_private *dev_priv,
>  	if (otable->page_table == NULL)
>  		return;
>  
> -	bo = &otable->page_table->pt_bo->tbo;
> +	bo = NULL;

You can initialize bo as NULL, like in vmw_mob_unbind().

> +	if (otable->page_table->pt_bo)
> +		bo = &otable->page_table->pt_bo->tbo;
>  	cmd = VMW_CMD_RESERVE(dev_priv, sizeof(*cmd));
>  	if (unlikely(cmd == NULL))
>  		return;
> @@ -555,7 +557,10 @@ void vmw_mob_unbind(struct vmw_private *dev_priv,
>  		SVGA3dCmdDestroyGBMob body;
>  	} *cmd;
>  	int ret;
> -	struct ttm_buffer_object *bo = &mob->pt_bo->tbo;
> +	struct ttm_buffer_object *bo = NULL;
> +
> +	if (mob->pt_bo)
> +		bo = &mob->pt_bo->tbo;
>  
>  	if (bo) {
>  		ret = ttm_bo_reserve(bo, false, true, NULL);


-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>
