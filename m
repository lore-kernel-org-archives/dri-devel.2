Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAF9E9DE7A
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5791210E6E1;
	Thu,  9 Apr 2026 09:27:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="fHibRR0d";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34B7710E77E
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 09:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775726848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RMBBLjrw2ltVt20QSl0hxzy34EXIjg14ZZ40oAl0/6E=;
 b=fHibRR0dbr6L4JlYdzHHghpB4iYmn43MeWc+63FWNA1H8K2K2Eeh4BJ7rRuVJyRh/H6lTM
 oiFGop78UeC8aLXjpN72+tQ3oUZrLFMdbM5caB0jRaEMUaTDco1C0GJ+V0DBU03nz8mPCq
 Kmq5wJY0uM3E68xBmk2VBmyN93xa+00=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-42KkGzm_Mc2vpOEOOPXFYA-1; Thu, 09 Apr 2026 05:27:24 -0400
X-MC-Unique: 42KkGzm_Mc2vpOEOOPXFYA-1
X-Mimecast-MFC-AGG-ID: 42KkGzm_Mc2vpOEOOPXFYA_1775726843
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-488ac1434f0so3589365e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 02:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775726843; x=1776331643;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RMBBLjrw2ltVt20QSl0hxzy34EXIjg14ZZ40oAl0/6E=;
 b=Ky6AZLIc13YPO1AzByeeVTWMw3Pw/4oRDFuJ/c8/UD1bjgQBjrFPSGHXtnMgZjTvGC
 s8Blmhi4J+R5DCbyPknfQP2SYFPq2kPzyVNbwGskJw8JZdfy6F7YVpCgzsFNcK9X3tm8
 +9Vdb2H/4GurDS+GXyq4iiNm2P1HVid4t9Bc6+cTitf7yO62zZWOv8IJQTgfP6kfzTyt
 3JXprFh49IiAu+OYC0oiyXPRy4UCsyiUKsbv0UNzGS2fABsKCeB8aWk9DUcLInwGrCL7
 6XT+ykk0qe5++IJHbLe910b9Jl7Sz0c0plMA+LAqQDpTeFwpnzJxFz41Ckx1848ZByj2
 UPWA==
X-Gm-Message-State: AOJu0Yzfw4oN5rUI2hHfocqrdxXj8G7noa7XGkC++18w/6vJPRl2VNWv
 7JnhFl3hq0FTlVX1RdEtDd2aT/R45INnFt435m6HgwNTbPbsFruuSKIktijp5x7Kdrc207Iq4GE
 IyKFaTEuIw1XmL8UyMpcH0Ik3nDHUTJz3LcC/Mza5LuYgNVMdmQtg04VFBuo2RQpY/s5MYw==
X-Gm-Gg: AeBDies538JBG/VFHcH8syXpkFDxIXIAM8a6xdYVd+x4EwdT0PIOPW79lF17Ua6haZ6
 ZbJEGZ1tlaDCC+pt4XddjhzD8wLipAbPqcDpOoirwPD6JuBX3OucgVF4+bWnQ5nQVf1VR60tPFQ
 3/TG25ffyzYyfwQ/JJryYjxUFUfOH79RnQtBTvMC/OrR6UshDU4Vjmmf8He+DSCYJ5Hv/El7Ppb
 QG0LXPSR3+1ljFqUpHz4oXgP7uTZlYpOwWkK6q4cv7crpCMrxGgihEO707sairlhSnrje9wSYl/
 9001m+OAul5ZxO8OTAuVON7rS/f1SPpwZtlIPzX4R2NJZeVhCslHqBVdr5ZKduTJ0BROu+6STQz
 gk7wpej5m96axwHPaWFvGMk8cBmfdV2FDViMDy2ShCrMBp22uxA==
X-Received: by 2002:a05:600c:c056:b0:485:40fd:8390 with SMTP id
 5b1f17b1804b1-488998ef198mr233647925e9.26.1775726843301; 
 Thu, 09 Apr 2026 02:27:23 -0700 (PDT)
X-Received: by 2002:a05:600c:c056:b0:485:40fd:8390 with SMTP id
 5b1f17b1804b1-488998ef198mr233647625e9.26.1775726842874; 
 Thu, 09 Apr 2026 02:27:22 -0700 (PDT)
Received: from localhost ([37.221.85.123]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488cd1bb76dsm65282105e9.8.2026.04.09.02.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 02:27:22 -0700 (PDT)
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
Subject: Re: [PATCH 10/19] drm/panel: himax-hx8394: support Waveshare DSI
 panels
In-Reply-To: <20260401-waveshare-dsi-touch-v1-10-5e9119b5a014@oss.qualcomm.com>
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
 <20260401-waveshare-dsi-touch-v1-10-5e9119b5a014@oss.qualcomm.com>
Date: Thu, 09 Apr 2026 11:27:21 +0200
Message-ID: <87zf3ciiva.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3Ri9eEM92nYoUhe5ABWCzMsCqkjA1QuchU_PM0ThkyU_1775726843
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

> Enable support for Waveshare 5.0" and 5.5" DSI TOUCH-A panels.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

