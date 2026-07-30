Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9BBC531D0
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 07:20:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8EA310EDE5;
	Thu, 30 Jul 2026 07:20:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F7RtElkV";
	dkim-atps=neutral
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD79410E101
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 05:28:40 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-7e9ecb1e13cso1848269a34.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 22:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785389320; x=1785994120; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a04MbFqiZgBuv1mG9X7XMb82OXMMktPjmh4vGJJeJn4=;
 b=F7RtElkVc2D1jw32yEuKGLm75IP+nDqKPDmIkbCLbNOTpysNB5YzW1Noo08/fO0yDN
 71ZoIiNJCNfqa3mcNBzzGTWlKU6q17kBd2Z30c5i7apm3ZJQ8Q6i6LWFHB9jAkVyjZst
 yJ0Aq5wVbS65nbmhjD8abPcSrJ+MLZfg9u6JCccUKDcvk0TTgVjUKOCQZ5vIeQkXo+4P
 Wusf8MTDuMfrW0WYXS634rjOB8rxaqEKWlrFpj3WanQ6w/gywQjjjN50dAXzsRPeW2M8
 ImErTrmUoXv14Uw2FYEFruMFk0kfVyQJALV3/+z6wAhSksjhmtU6JRA+rhlTh7OSJAto
 9sow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785389320; x=1785994120;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a04MbFqiZgBuv1mG9X7XMb82OXMMktPjmh4vGJJeJn4=;
 b=WKOphBsH7hA2m2mj02z11MwuW4AGSKE1r9Dv7zcZOCU/tHDcLLILSxccsCvxs2YCLR
 eCNOzi31pU4wCkQ4U1fChpssihkoRayCRL/GituRQTsFZsIpzJ3M+KJNUOC/TLu9vJGJ
 CgbKGsyz0BdU+LzljTfLK2k9Etm5uRb+sXwGMM+y8ysHrlvFTCHkM5zibDMdMudSGR1b
 z9qbMyv4ModMGyD4JrTckgSJFNbFCWU3wzEvCPxHYqgj9naNazUvV1jX8NDk7mTyO09q
 Lj1sZeYOhuWvWQ6iAvYGV9zfVmjwsCRjE/9BEqy8b2SAUWvhSzXK+2z9r4sljZ4+QkvH
 3aqg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp/PLm3xw5RdLrK94hMaX+Du2TyCxlUQsub4gb0h+JvWpCsuIKpRBQ1MNP2E9wCpKSke5LRDUxlweY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwlN5WPMU2+dCkawY2DmGYaX2oHNXdm2vY2RcSoVGnECL/UH+Q8
 TfXBtX2C3h/yjibYLHpJiZaZZpoIvknhZkmRfTCeC5Q8ga2R4fMpEW3Z
X-Gm-Gg: AR+sD11zOBCE1MTpFwquJBTJXSlTjyrnwgdW7XJemfyNnWYvL6T/FcfRzFLehpCVq6A
 obetfhcstda7AQRabomsoC7okEsvn0CW2ZV6/gZCgp85qXNA5xcpErXTEGwmZ78W/W06lL+Zt7T
 Beanyg4mPtiKWh6U3A67Gfg40p1YamVRZkcWUKiRcN481AEO9A6PhAvVnTVDQbcj4rYpnUpsev5
 Fvcqq+tuKg24PjQhl+duq/MDYgDv2bV1145dK864JCxyHwwCQ6x679YauX0hQWYDq1HzUj+YZng
 Q9bxJFwXduFwLl/Je1sdwNzM3+OevfbTnEDPr5niag+EqYiHzcByyW7MyVbCF+OZMVzUQKFPOfG
 ACpwAeYgkpKO4F+7rnllW1L6jDdgfkoIQfTipmzuoKQg01B1dToXBKxcQIW9HcSRPmDLNLA3OIf
 2Kd1/B9bjs+pox+P3yuoXZKXk+mhNM4vuouMS+0b63YqlgTcbRMYaw9+6PySaCIse3RQ==
X-Received: by 2002:a05:6830:2695:b0:7dc:c7aa:22bd with SMTP id
 46e09a7af769-7f02bedd9e5mr667636a34.6.1785389319804; 
 Wed, 29 Jul 2026 22:28:39 -0700 (PDT)
Received: from gmail.com ([108.243.219.47]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d591d97sm3984143a34.3.2026.07.29.22.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 22:28:39 -0700 (PDT)
Date: Thu, 30 Jul 2026 00:28:37 -0500
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
To: Doug Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/panel: tdo-tl070wsh30: Use mipi_dsi_*_multi()
 functions
Message-ID: <amrfZMfThEWbHIjh@gmail.com>
References: <20260727-mipi-dsi-tl070wsh30-multi-v2-1-f47b937631d3@gmail.com>
 <CAD=FV=VvM22hHY7aMT116WOHSje-iiX8ins=AERBDX6Wjmct9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=VvM22hHY7aMT116WOHSje-iiX8ins=AERBDX6Wjmct9w@mail.gmail.com>
X-Mailman-Approved-At: Thu, 30 Jul 2026 07:19:56 +0000
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

On Wed, Jul 29, 2026 at 06:55:53PM -0700, Doug Anderson wrote:
> Style nit: in general, there are way too many blank lines. You don't
> need a blank line between every statement.

Will pack them in v3.

> However, I think the Sashiko bot had a point [2] when it noted that
> the old code used to still sleep for ~10ms and try to enter sleep mode
> even if the "display off" failed. That behavior is probably worth
> preserving.

Understood. I will preserve the behaviour in v3.
-- 
Thanks,
Akash
