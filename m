Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F418E9DE78
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE6B310E792;
	Thu,  9 Apr 2026 09:16:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="aZJKFtal";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 687F410E788
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 09:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775726200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TgulYGZEezauT5N2y6RRbPYOtNJoV6tHbCggzEseWxk=;
 b=aZJKFtalTrmaUvvCzIU8rMunRJ9q1bY2F8yC0T5UBzgAYb3FcvvDXaFX4PzM3xzRq0/9U0
 /UsuB/Px/hsZHTYtNISadycEUYcDqQU7RuNFjpagmdPqocWEGmWSTzJVV5DyPJYkojbE3B
 kvySC+72VlCMApnG/YGmJWbn9u6igF8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-R7Ws68VjPTeMt1TWXdmyEA-1; Thu, 09 Apr 2026 05:16:39 -0400
X-MC-Unique: R7Ws68VjPTeMt1TWXdmyEA-1
X-Mimecast-MFC-AGG-ID: R7Ws68VjPTeMt1TWXdmyEA_1775726198
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-488a75d674fso4903315e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 02:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775726198; x=1776330998;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TgulYGZEezauT5N2y6RRbPYOtNJoV6tHbCggzEseWxk=;
 b=nqz9ybgTKr3uPsj946H59yVJJOWpOLZnIYUUhJTGPQSPdJTv+4JAwL3FvgRkdwP/Bc
 fSmRp2H68K4B5Jse6gAAt4OsATfkyLkHT0VleNW1hZvH8y+qUA7DhFT+jyMQ4U17Jp8V
 x0n7v0rf0x9NiCJVV0KIZFSm9TakpbN9oOnwNoi2wUVbIa4/1Hs9+4BVUdTkORBfz1ep
 x9l+X70ly3/p7y4yypUOAnBaAe5B4HqE651OrsMfMV6qKzK8GEUKtF/GjgpTCDjf6Ynq
 K2B9nwdDLUBAt3U8Fprq6WJzJmr/HdXUDwRrNDcx8QZv4+EZpxYjs7e4Yc6pkk340HG2
 zLDQ==
X-Gm-Message-State: AOJu0Yz40VEMHCkf4LXlEEU2x1TeI+urXWF/PsEBSt8buXpL7pHTVf63
 riCYgkhFlHpMj+q/KOv8kM0jZGlblIXZ/d2/UAPb+34bagY+q9eyGe/FRnJrgujqq0lnWf3TsEi
 RTSVOV3WcDBnl04NSKzzbwpt0RPZXRcvuQLkXeLps6eqQ2SsyQGZF06TyqXZpkPS3eBfA6w==
X-Gm-Gg: AeBDieuUWGpJo9CUB+J5lWpfPM43yHSMY4ezpX9lqo0iqQTXq5FbZmc3mpo0gp21GIJ
 ayvUavvOzyyBHH4dWZe70eytXUzPs79tKeOIOfAuc5cfaRLR3CBOWS2vmITUOc32nTXOVhMAK5F
 DbzzRGotIvP0I/6g3yg//miYrfi/Bf+H7k+a4L/DKX+H1D5MUJBsy93jJ3tv/F/PkU94DGrzUyA
 w2JVAjxkdPRo7d9EqtP71oWT6hG20oolnGPpkeKz/158yyZVvr6bSyHManfzwmjp4+fnG5uyxQ5
 emEGKEdvpEmnNAs1EnG4DeYIP3phX3cgYeLs/JPhexRof+loOK9Ycz2aWP5J+EAaK7ast0alqGw
 VUrQvakcxfCtlJ2jRJXZW4P2vwFG6HRJ2qGPZ0o+/KzHgVlWrWg==
X-Received: by 2002:a05:600c:a47:b0:485:4eaf:eb53 with SMTP id
 5b1f17b1804b1-48899781357mr360437525e9.19.1775726197768; 
 Thu, 09 Apr 2026 02:16:37 -0700 (PDT)
X-Received: by 2002:a05:600c:a47:b0:485:4eaf:eb53 with SMTP id
 5b1f17b1804b1-48899781357mr360437115e9.19.1775726197287; 
 Thu, 09 Apr 2026 02:16:37 -0700 (PDT)
Received: from localhost ([37.221.85.123]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488cd19f3f1sm18879355e9.34.2026.04.09.02.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 02:16:36 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jessica Zhang <jesszhan0024@gmail.com>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Cong Yang
 <yangcong5@huaqin.corp-partner.google.com>, Ondrej Jirman <megi@xff.cz>,
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 08/19] drm/panel: himax-hx8394: set prepare_prev_first
In-Reply-To: <20260401-waveshare-dsi-touch-v1-8-5e9119b5a014@oss.qualcomm.com>
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
 <20260401-waveshare-dsi-touch-v1-8-5e9119b5a014@oss.qualcomm.com>
Date: Thu, 09 Apr 2026 11:16:35 +0200
Message-ID: <875x60jxxo.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fufij8GN_nn5Kis4S8N-ViXrytFwwuY6k8avwcMQAQA_1775726198
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

Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> writes:

> Sending DSI commands from the prepare() callback requires DSI link to be
> up at that point. For DSI hosts is guaranteed only if the panel driver
> sets the .prepare_prev_first flag. Set it to let these panels work with
> the DSI hosts which don't power on the link in their .mode_set callback.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

