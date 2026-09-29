Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D322CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 14:25:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DE8F10E0C5;
	Tue, 29 Sep 2026 14:25:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="BdUlK/hG";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4780910E0C5
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 14:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790691907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pu7oPNmHjtmqs+iRKMrkvvCNESbJDKqdyDR6B0f2918=;
 b=BdUlK/hG9qLoVp6afBvCGcMbaYPRsOI8H5vNXDGyaWovunGOxl7wHXzEaxxYudg8EkCtc5
 qXnjIQNCXbw8tYYI0t3RwOylL6jbgpMP2ljAFggUVGx4FUD0PXjP5f+jCGMpjomsgJgofd
 hfCph+AqaHlbq9j4n3Z59aeWxPl9avI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-v3mlzPZEOEe1-W8bZSof7g-1; Tue, 29 Sep 2026 10:25:06 -0400
X-MC-Unique: v3mlzPZEOEe1-W8bZSof7g-1
X-Mimecast-MFC-AGG-ID: v3mlzPZEOEe1-W8bZSof7g_1790691905
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49e735659b7so31964245e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 07:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790691904; x=1791296704;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pu7oPNmHjtmqs+iRKMrkvvCNESbJDKqdyDR6B0f2918=;
 b=UG1+Q+A910VCQg1XssazCjG+4L1M6MQ9338L6AErdNX/LzsxrEYoAyg8Xiz6/9zHTV
 JYtSYRXjVaellNYQ5PO5VUkjuvueIbdNFEcaP6hU1Aqhj8bv+Wyo4bOx+LxCnY4K+y5s
 Uvyt0LpwGXSRON55bhVUSBcD9eanZEtOW0PKIn1TNlmlTf/amEMyli9LfRP2HSJ8IR3x
 m+0pBxJmf1p2MRROVRgYfm6iIZLaGjz5+hI0dRjuU6tM+4izToBxPs1hmlUToal1mkmG
 qaAdrq9t+g8HgSDaBYRURwJAErvIZFcB5fvG8QPQm1SbnBJGmtciDqCIjIweUMWongME
 OIog==
X-Forwarded-Encrypted: i=1;
 AKwUvBzggqKzOCQH0B8YKVhq6u+MNinjS4kI7LZ01e5xpiATGuS19RBxxTwudz+E6P5oK/CSaI12aeHow3A=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kuDCYjM7d/sqCn2O4XYieQwOQJjoVjdG5MUJmlytiBU7a+tfRR
 UUZ8VSjzLheEP3yg2AeF7rWmMcSpEUhxMBvYrytBofBafGu4L5iCsfMLGUepGX9bejIjea9sGv5
 LXeTRO6or/lTR1xjmfNA1RcCuA6yreBYHEJ+suxTBwwPPADzuP6/FPZqgV1hUZACJWLASlQ==
X-Gm-Gg: AYBFou2ydSz/thRpvGVJltgRwhx4sK+hAxEt3Zkl2d5sCyEO5hnMH/Xq6buFYVMPxpv
 ESGyM3crF1ZPGOUl3jxj1hytQMz6bNPR+Jtf0kZI8jcYNrOwVIofZ+AUNGdJ72ZY9nwuFxwB9N/
 cd6ocs2RHpD+nhOLm6pbCwEKb7+mj5sUl67Y3Mi+UFG/Sm8GThuVlYUsdhpI2rOILrFsSru37vh
 ENjqi7BVGfm3Qxtc2cX/PE2eg3IdVAfOWtomIXS1fIodnbWWRYFsL9tc22NFpADD/mY0GD54qi+
 wj1AmZ3K0dGhZoHfCbaL9hD6B5trI8qm1QVByF81CmWyhBmFP9C77WHEzcPIwO2DSfWQXcdtP3w
 Z2fQ26VqGUGM/zcBT7y1FGVma+/SyZLfxTfk+Cj2FH6Gc2kohjs0cjIVliXH2apSfWg==
X-Received: by 2002:a05:600c:8719:b0:49d:15b9:2a2a with SMTP id
 5b1f17b1804b1-49fe66c6373mr304983475e9.10.1790691904569; 
 Tue, 29 Sep 2026 07:25:04 -0700 (PDT)
X-Received: by 2002:a05:600c:8719:b0:49d:15b9:2a2a with SMTP id
 5b1f17b1804b1-49fe66c6373mr304982775e9.10.1790691904159; 
 Tue, 29 Sep 2026 07:25:04 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00ebcd353sm101132985e9.3.2026.09.29.07.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:25:03 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Fabio Piparo <holofermes@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Amit Barzilai
 <amit.barzilai22@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Fabio Piparo <holofermes@gmail.com>
Subject: Re: [PATCH v2] drm/ssd130x: Set the address window in
 ssd132x_clear_screen()
In-Reply-To: <20260922225445.1525837-1-holofermes@gmail.com>
References: <20260922225445.1525837-1-holofermes@gmail.com>
Date: Tue, 29 Sep 2026 16:25:02 +0200
Message-ID: <xlv1se2sdtj5.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2eY1w14jRF4e2oAJMdaK4rQs6kO_aCovROh42e-QEJU_1790691905
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

Fabio Piparo <holofermes@gmail.com> writes:

Hello Fabio,

> ssd132x_clear_screen() writes a full screen of data without setting
> the column and row ranges first, unlike ssd130x_clear_screen(). The
> clear is not reachable today: the plane disable returns before it,
> and the encoder is powered down by then.
>
> Factor the range commands into ssd132x_set_col_range() and
> ssd132x_set_row_range() and use them from ssd132x_update_rect() and
> ssd132x_clear_screen().
>
> Assisted-by: LLM
> Signed-off-by: Fabio Piparo <holofermes@gmail.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

I'll push to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

