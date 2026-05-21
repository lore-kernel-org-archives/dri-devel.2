Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE28CD4F5E
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 09:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D170010E497;
	Thu, 21 May 2026 09:59:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="F1w37Lm8";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E51D10E244
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 09:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779357585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0nHbVXywPYI+m+RM8iHAt2Jum4qcWT4EHlZtaJMwkXs=;
 b=F1w37Lm8o+IREg/in8sb7cU+DPvZa1LfCummFw1SR9Q+z1u00PZu4JBDpzb9D1sl+3TtxE
 +q4/w6J12NvAj3hRMGxnjYkBO3fb2Zu2g1h6bE2ggrP8HsZn3LxRPYdjQcS07Fu5iwDIjM
 Cj0+jzbTIfSc0zs/4rxeBvv11KM8WYo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-C8OS7aSOMgOq9sB5hEuxew-1; Thu, 21 May 2026 05:59:44 -0400
X-MC-Unique: C8OS7aSOMgOq9sB5hEuxew-1
X-Mimecast-MFC-AGG-ID: C8OS7aSOMgOq9sB5hEuxew_1779357583
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45e80183514so3845619f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 02:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779357583; x=1779962383;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0nHbVXywPYI+m+RM8iHAt2Jum4qcWT4EHlZtaJMwkXs=;
 b=TbrUFyTSpDGf2tu/WRS4cJ0MjW7PBWeTRM7XkChjcrAFGV57qRAZ8VGchVviLbrnoH
 odE+dyrufuevrNCiwPPvjsE/i0JAMS1slCvY/EwsvRg6NIX8PY9YT7rPXjwRRVr3Yqcp
 6OeDj+yISiAyuOaAS6hf+PMMw8/92hh5wDZNciCu77iKFzVmv/AJFK4jNgeUXVynbZgx
 tfEEa6taCXV00mULK5TOfFWEG5OqzMn242ZLM/HJm/4nfkqt7d7iYiWh6N5OoEfytu07
 J0GrBFFy67LxCas6acY2TNwHzsY+PrbgXrTPShehIKq77LsLba4pVNmuuwm51ABXbZn/
 65yA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+7eLIDC0xVriS3mByKA1vmoJ1/oxybfgvnm4yycf0/8BEMsdLIqRYICE8O5IuGTvLFzlIa2wusoCo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+nc1IGkCSaAhYpSBlCvS6f/g+9+x7Pt5EfiLjS1TaDB83SGeR
 gTKdEo9OdjTUd6APOZCtN6e8gwpPLv3yV/wdnOEZQaVEjEoJnZulMJPZXOoP/06EVsPispLk7JR
 4y5FU+Sgwdc+bkn5mNN6HndGyFMR8oQqB6PxNgHmlz3PTBslwlG702uEhigTv2EEnfWzCTw==
X-Gm-Gg: Acq92OGGpsey8a2DLelX9TYdoW/k8W1MiO2sgYK9pna4+uMRxI2LD3O1dPBpm5CFD/x
 0Qs5aPtwSUWApyob6lFsTWn8Pvwpei1zmjFaclBW0Y+S+Jm8TWc0nXM/KlR0c7EQf9/UiULVTeb
 FJReLYX4HVE7xw+GKKvUVOR1GdoCqIwhr8TCHsFw/sjxkaIw35JmVFG1pGxM18Jw6v3T71Rln1j
 R8KqSOpQxnajz5zGJEWgYoeskHG34ZBbvweL6XE8R87TUyIvAKJBKLovtRsxuK8G6IGu4UZBsTo
 6u/+gb23nwLQth4JdYSa94LTx7xbFrYi29j+DYSN8r3ASCZGSu6356LaXX8Dz0UAH3n4O1Vbgnt
 PkjWk6Sn3htqMK6+9RKt//znPljurQtTi5ZwMYo8NyaFsNQP47q4mCqwfmQ43Er0j7rOceqlRL3
 tafTD0
X-Received: by 2002:a5d:588a:0:b0:43d:68ad:3b7f with SMTP id
 ffacd0b85a97d-45ea3ae68b3mr3967861f8f.21.1779357582730; 
 Thu, 21 May 2026 02:59:42 -0700 (PDT)
X-Received: by 2002:a5d:588a:0:b0:43d:68ad:3b7f with SMTP id
 ffacd0b85a97d-45ea3ae68b3mr3967757f8f.21.1779357582159; 
 Thu, 21 May 2026 02:59:42 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa7d9e2bsm1634922f8f.10.2026.05.21.02.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 02:59:41 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>, Alain Volmat
 <alain.volmat@foss.st.com>, Andrzej Hajda <andrzej.hajda@intel.com>, Andy
 Yan <andy.yan@rock-chips.com>, Brian Masney <bmasney@redhat.com>, Chen-Yu
 Tsai <wens@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, Cristian
 Ciocaltea <cristian.ciocaltea@collabora.com>, Daniel Stone
 <daniels@collabora.com>, David Airlie <airlied@gmail.com>, Dmitry
 Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Jani Nikula
 <jani.nikula@intel.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Liu Ying <victor.liu@nxp.com>, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Marijn Suijten
 <marijn.suijten@somainline.org>, Maxime Ripard <mripard@kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Raphael Gallais-Pou
 <rgallaispou@gmail.com>, Rob Clark <robin.clark@oss.qualcomm.com>, Robert
 Foss <rfoss@kernel.org>, Samuel Holland <samuel@sholland.org>, Sean Paul
 <sean@poorly.run>, Shengjiu Wang <shengjiu.wang@nxp.com>, Simona Vetter
 <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 0/8] hdmi: Add common TMDS character rate constants
In-Reply-To: <20260520144424.1633354-1-javierm@redhat.com>
References: <20260520144424.1633354-1-javierm@redhat.com>
Date: Thu, 21 May 2026 11:59:40 +0200
Message-ID: <87o6i913sj.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aivMHRbScYtaiGePnDOn2IzplNP3BOpaEJ0DrkVTCMM_1779357583
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

Javier Martinez Canillas <javierm@redhat.com> writes:

> Several DRM drivers define their own local macros or use magic numbers for
> the standard HDMI TMDS character rate limits. Maxime Ripard suggested that
> instead these common rate constants could be included to a shared header.
>
> This series introduces these constants to the <linux/hdmi.h> header and
> replaces the local defined constants or magic numbers in drivers.
>
> I split the changes as one patch per driver, so that these can be reviewed
> individually and merged at their own pace.
>
> This is a version 2 that addresses issues pointed out by Maxime Ripard and
> Dmitry Baryshkov.
>
> Changes in v2:
> - Change naming convention to HDMI_$SPEC_TMDS_CHAR_RATE_MAX_HZ (Maxime).
> - Define the constants in <linux/hdmi.h> (Dmitry).
>
> Javier Martinez Canillas (8):
>   video/hdmi: Add common TMDS character rate constants
>   drm/bridge: dw-hdmi: Use the common TMDS char rate constant
>   drm/bridge: dw-hdmi-qp: Use the common TMDS char rate constant
>   drm/bridge: inno-hdmi: Use the common TMDS char rate constant
>   drm/sti: hdmi: Use the common TMDS char rate constants
>   drm/sun4i: hdmi: Use the common TMDS char rate constant
>   drm/msm/hdmi: Use the common TMDS char rate constants in 8996 PHY
>   drm/msm/hdmi: Use the common TMDS char rate constants in 8998 PHY
>

Pushed to drm-misc (drm-misc-next). Thanks everyone for the feedback and review!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

