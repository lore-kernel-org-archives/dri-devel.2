Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D22DE9DE76
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:15:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04CB410E733;
	Thu,  9 Apr 2026 09:15:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="F1uAdxIT";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C71E10E733
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 09:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775726121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bKk/qgaXfCtywmbbEPA5j7wB85nwcXgi7ZycM7rdkR4=;
 b=F1uAdxITQW6jX3K70wlROsLhcuh2xR0gkKiFHjoM3wgAg5W+J2irxv3K9XgGZCmeOJtbp1
 A2jwzTL5mqbzBvThRvhD/00OkPqrC9Eglluwhve5WxsMLCZiDztTEPi7/WDw3HDA3ky63M
 eMHvj/X464SGMFS7Mk5mWcVlx45SMGU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-i4yw81ydMzeGagNM2Mq7IQ-1; Thu, 09 Apr 2026 05:15:18 -0400
X-MC-Unique: i4yw81ydMzeGagNM2Mq7IQ-1
X-Mimecast-MFC-AGG-ID: i4yw81ydMzeGagNM2Mq7IQ_1775726117
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-488c2aa6becso5514655e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 02:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775726117; x=1776330917;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bKk/qgaXfCtywmbbEPA5j7wB85nwcXgi7ZycM7rdkR4=;
 b=U+CIeUDgU5S9Qz18DnyGj0b0SxS2FZ4bLpfrw39G3Bs8VSnyLwNnFWL69RGBKqlG5z
 Sgk3josw1Q4j+Inf388NbPlNT1a2hvMu/KsSiPUYaB6W+JTyHHrqZb7POkIqOrvN1XAa
 P9C3Z3DR/kG368TMAsco8zt8sYhxVwWBGantK8nXDXrfNKK0xgzBqo3oQezyAviESiCT
 enRxi9nv6V4ZUtNXM5U5SC6d8enO/yK31+yLZXhwLlWmkZpUYiuoLiPvewHccEVSrtAh
 NzMlWoszUwP0+GR+ksS8VCF1ARkYQlEmWXjTLqOJZyMKQHdLNjpxheR0YTlTs8t57/s/
 CT3Q==
X-Gm-Message-State: AOJu0YxahbVwE0s0yAmppmRWlYnUWVDgTCZL5F+8kELmaF3o91ybo/vY
 8XVCUdmYW9qHREeLtfFbmh1O7JjV56xw4TRKzHyJdt3PqdbAAD2HZVpBGwtpECi8ZirNUZv2O5H
 j0wMeVhRdAroLpeS5GPDeO+PsLuqArDhrdBk8h88RW91+mHhur5Suxu8cSEC7q2SmwiCWrQ==
X-Gm-Gg: AeBDiet0Mny4mdJg2OfhLbS8aNBAQDNJqF8C9JnFgjHQSGEWUaxMH0YSN9MLdLxtbnZ
 hFF94AQu2uq/OMpEN5TohnwVTQxRAFCrDEoEamcbNgBJ9EqZ/j8i0nOyjBUbmBWQjfaggQHmZ6z
 Q3CXJMCZSNGz9aoE98oO+mEm3fCp5CENNhlsbtk+mBGGwH/nNAYPh45RPeLHrNNKXd3fSHCR7jW
 Iq3fgFt/OuZkcqv0/6hGI7CSciKWMKchSpYYoNJa41UjTIak9yBXxW8poktNueccuqocPcv6W72
 auAhyfM3sDfZmRAXLlo93uhKMpjEDKHLwzT8GMEUrzdnzgV3hJHNeqPsKPQj0dhjCkfcn2BX2FP
 sACVzkbfIpkcb3cBdxZeakAb/6EWk4l/XUY5UN//PaKP1FxbAYg==
X-Received: by 2002:a05:600c:c0dc:b0:486:fdba:f5db with SMTP id
 5b1f17b1804b1-488cce7760dmr29725595e9.0.1775726117014; 
 Thu, 09 Apr 2026 02:15:17 -0700 (PDT)
X-Received: by 2002:a05:600c:c0dc:b0:486:fdba:f5db with SMTP id
 5b1f17b1804b1-488cce7760dmr29725145e9.0.1775726116563; 
 Thu, 09 Apr 2026 02:15:16 -0700 (PDT)
Received: from localhost ([37.221.85.123]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d5e969bbfsm2718936f8f.1.2026.04.09.02.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 02:15:15 -0700 (PDT)
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
Subject: Re: [PATCH 06/19] drm/of: add helper to count data-lanes on a
 remote endpoint
In-Reply-To: <20260401-waveshare-dsi-touch-v1-6-5e9119b5a014@oss.qualcomm.com>
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
 <20260401-waveshare-dsi-touch-v1-6-5e9119b5a014@oss.qualcomm.com>
Date: Thu, 09 Apr 2026 11:15:09 +0200
Message-ID: <878qawjy02.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _WpBo4O_aCt8xf7xax36mk1TNV0UFoLWMJVQ_RQ6Jeg_1775726117
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

Hello Dmitry,

> If the DSI panel supports versatile lanes configuration, its driver
> might require determining the number of DSI data lanes, which is usually
> specified on the DSI host side of the OF graph. Add new helper as a
> pair to drm_of_get_data_lanes_count_ep() that lets callers determine
> number of data-lanes on the remote side of the OF graph.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

