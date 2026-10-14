Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3490ECC6B2C
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:21:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8823810EB30;
	Wed, 14 Oct 2026 20:21:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CF4B10EB30
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 20:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792009294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ok6NdgLf05b7IRXunkY4Z9DoaTee64m/SEUOjmJzvEU=;
 b=CxBmJeG0KwwPIIMbWCG7ecW7Izy+VR069iums6bKabsnGTM5DNIe/+YGFSuwIUfcMsKxGv
 q3A7aqDT+32wLoGcKGXIG8G8WKDbKqexmGp4opSGdPKNnLAQ5J6Myl8cjELZLRcFh6IjOh
 lZqizRxbxTO1IIIJ9O0yeKnWgFUv+cg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-hLhqQMitMD-RNmqQS9kSTg-1; Wed, 14 Oct 2026 20:21:32 +0000
X-MC-Unique: hLhqQMitMD-RNmqQS9kSTg-1
X-Mimecast-MFC-AGG-ID: hLhqQMitMD-RNmqQS9kSTg_1792009292
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a009f82bedso37808795e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 13:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792009291; x=1792614091;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ok6NdgLf05b7IRXunkY4Z9DoaTee64m/SEUOjmJzvEU=;
 b=ieFmraldikCeKWe7LrQzJnwBGL/I95lRhGRlOEuluHVVG7DaVRv9shiVV2vRZnSwqB
 /n/5CgD3VWSOOuflRAFpr6NBAyT/7IhQB3g1uJ2esJY3Acc9OuhVKBuFt1GIVcvthmdq
 ElBT3bMNnc8DRBmtt47baa1xguU3tHEDoe01O2b7llsM0PY+bPXtl8Gat97k76/Gn7ml
 WfCzBmP5/YbBpuV04utObi+cPjt1Ov4L9QRxGv40Ykq3zB63OyKZHGNRuF/vNbLIYlf+
 qzTkMxGz40t7hQenKb1lZwdvjZnQDJaX7bp+DiX7wEQGG11gyGCyd8WYn7Bs0e9o7E87
 xmZQ==
X-Gm-Message-State: AFq9FYLfcs84QHRdCLwZ8Dw9TQfkBbzKB7/1MgKGJ+eljRf8Bd4JR8b9
 xcwVG+2Wrg73337KgpK94avSzwj8Q2kJkEmhjHY/QbAal79XE+LFaSzEY9oP0YpKJEYvDy/dRPt
 b9LwDAp3ZdVwiuDoiUjtohmCO23Yqnc2dl1PMNlaVW+u/B1fafyLvkdlsb4j63fgw3grr2Q==
X-Gm-Gg: AYBFou1qYULnH5DMVZLgBxtPv3b1qs8nJxfMZagNcZeMOALZzQge+Bep+lo3tlDgkOT
 3DdzSstgYLmPkvLAG6V0Yiigin1usEOiSLtSfSb5+wygT48vZlGKuKtyatNUU1cOBmPhTBWOVnE
 PnoDXR2DnIK/2WGkj1GwsBBRYZyB+FWGuAF9OkUnVCB2pyCygJSTsNva3u8nhGD8Y8XtQGf6cet
 nUAgHhs4lwu1dnGrknJQ3WZsmB2SW5l4BmDpZSEraqswlHGnq/4/q3kCQw4rG7ZxlM4wa1sF8zE
 in2S7s2QB8YMxLD7jCFpjQi0SiGYp/HHmuXwSeyVB294V2W0O04QPnyB6p29iyhKMNBL6S7lFP/
 AKk+Ddg6vjyktCua6tmYXeJWRTERMCF/l1jL5O2HohW83dwXUevH7+Tu/QvBbH1PQ8w==
X-Received: by 2002:a05:600c:6990:b0:4a1:80d8:aed5 with SMTP id
 5b1f17b1804b1-4a18e49c43bmr340441695e9.6.1792009291549; 
 Wed, 14 Oct 2026 13:21:31 -0700 (PDT)
X-Received: by 2002:a05:600c:6990:b0:4a1:80d8:aed5 with SMTP id
 5b1f17b1804b1-4a18e49c43bmr340441385e9.6.1792009291257; 
 Wed, 14 Oct 2026 13:21:31 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9b8b5fsm16434505e9.9.2026.10.14.13.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 13:21:30 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH 39/75] drm/sysfb: Switch to
 drm_atomic_helper_connector_create_state
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-39-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-39-586c9c026823@kernel.org>
Date: Wed, 14 Oct 2026 22:21:29 +0200
Message-ID: <xlv17bjkghiu.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rvFRbAO_SemHm1WDiwuDYl0IVOMw-awXnB_TsZYsbSE_1792009292
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Maxime Ripard <mripard@kernel.org> writes:

> The sysfb connector implementation uses the deprecated
> drm_atomic_helper_connector_reset() as its reset hook.
>
> Switch to drm_atomic_helper_connector_create_state() instead.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> ---
>  drivers/gpu/drm/sysfb/drm_sysfb_helper.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

