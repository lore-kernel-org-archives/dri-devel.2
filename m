Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE00E9DE7A
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:20:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DF9310E2AE;
	Thu,  9 Apr 2026 09:20:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="O+veXf/D";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB90C10E2AE
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 09:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775726444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CbQigwl8IDMuLzMPbB7/RspCPqzOVDhQuvXsBUa4ins=;
 b=O+veXf/DWqeTczS0t3bLH105RyV02KiZnzo1Gt+QEBmEnFXQUqtNlGJV/TKGPBk598jKiI
 7QyjH3uG1tCQOtgFXR9JxLmsrccU5UCk+DGnDLbKYQkmO+c/mmYDVWLXqaB8u/EMd1TDSr
 cCCzMFcTFJMNXgSjk/yHtSw1781EDcI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-ar2jQjZ0OsuL-1ztl2KCEQ-1; Thu, 09 Apr 2026 05:20:42 -0400
X-MC-Unique: ar2jQjZ0OsuL-1ztl2KCEQ-1
X-Mimecast-MFC-AGG-ID: ar2jQjZ0OsuL-1ztl2KCEQ_1775726442
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43b8f9374dfso330511f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 02:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775726441; x=1776331241;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CbQigwl8IDMuLzMPbB7/RspCPqzOVDhQuvXsBUa4ins=;
 b=IM2QmyWEgWkLT60v+tKi9aCqR1TtbNKDmhIU0uXuXe/1PEotTxe5U1XBNOKRsPHwuq
 B321GanARMQhZd98FE1C/I89YSIvf0sO2kQxpteRNC5MKvRKFRvPcKVTxTMf5hwWXXZQ
 TVmn4peutH0Zpe1BlB6k25U3LjZzU2VHnx6Bqm682pyVUFKQ0U96a8RwNl0Zo5KhaqHX
 FPwEATOTKQ4c7si6NukwUhyWA1fhNFh7ZC3chnkh3P4XgG2BxCCqKB/c2igCrfephB8v
 +ox05iO2E+9bfMh7fso7o81mnfCEWNPYN9QGwSr4L/pwizRa+9mjs1lp+Gz0Ll2VBCMY
 TZ2g==
X-Gm-Message-State: AOJu0Yxuvz7udDqhVr4BOhfG5/ZLd2baieeFZL0QGyiOvZsZVUqB49kM
 d2bD7iZpCYIeapOw6YhmOHpwp5d5W2y8zPiNi0JpyvMRzbwv2mh+AvKa7gFmvsy6doE8WK3qBSD
 0RJdHw+TnpptdzUI2xZuZs5qoGti2vD1tmvh6TQ0yGZj/eiWgNrOPODTE0NbtMS2B8me7ew==
X-Gm-Gg: AeBDievXeEOykrYa9JZ1SHuvV+99HuQ9cvTJooest/siccouSJVU9c2xjUkzzYK+mYw
 wjIavFwyT2qroYtsXqJaNDFRLWI165rnLnMon2CMVQB0r8ZuSbAxjMr8CRyuHDopKm2truABojo
 UTV2VONWRxnG1127sXFvmG96yTeelhzNsfF6QgvFWGjA02o2njVvoX5PITdAMVHu4ThRoGTjlfo
 ZDxeYfNl9wwi1053F0l63/itHrcHsjG5PwTe2khibWgsPDqpVqdOn7OPAt69JpT2gZFoc2JYy08
 0/gm1em12Fdqa5R5YMfgghC3517huo0EQjLRpFwWf2eCQoiyh3EnCsZ4MIUVhSSiROgQcAqToQU
 pcxqSrrv67+1SwMrwpJtuN7dcdHX1ne78f5T1ka2E+bR3RVbtlQ==
X-Received: by 2002:a05:6000:4014:b0:43c:a352:c366 with SMTP id
 ffacd0b85a97d-43d595c4f98mr4111488f8f.25.1775726441508; 
 Thu, 09 Apr 2026 02:20:41 -0700 (PDT)
X-Received: by 2002:a05:6000:4014:b0:43c:a352:c366 with SMTP id
 ffacd0b85a97d-43d595c4f98mr4111430f8f.25.1775726441069; 
 Thu, 09 Apr 2026 02:20:41 -0700 (PDT)
Received: from localhost ([37.221.85.123]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4e221bsm62963480f8f.29.2026.04.09.02.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 02:20:40 -0700 (PDT)
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
Subject: Re: [PATCH 09/19] drm/panel: himax-hx8394: simplify hx8394_enable()
In-Reply-To: <20260401-waveshare-dsi-touch-v1-9-5e9119b5a014@oss.qualcomm.com>
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
 <20260401-waveshare-dsi-touch-v1-9-5e9119b5a014@oss.qualcomm.com>
Date: Thu, 09 Apr 2026 11:20:33 +0200
Message-ID: <873414jxr2.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VabH_7w4RGHZC2V9EQRtmu5Qrdx2FBKtnhHHXbiQ914_1775726442
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

> Simplify hx8394_enable() function by using hx8394_disable() instead of
> open-coding it and mipi_dsi_msleep() instead of manual checks.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Nice cleanup.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

