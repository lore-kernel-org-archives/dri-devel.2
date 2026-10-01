Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EFCCA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 14:46:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF82310EDC5;
	Thu,  1 Oct 2026 14:46:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="bnu0cgts";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41C6B10EDC5
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 14:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790865984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CuGmcOB5B7OU7vPcQ5Kxs9sP8F6GWHF+e8A0rz6DPVU=;
 b=bnu0cgtsDC7TTD+g9P2qdakhJ4ghf9AvIsR9zUYcPjpjlwY2dDe0IKvPlsR5FUZhmJ63hv
 DnN8QkTzQSCNKun2TwM0RzXrbKx+rwLmDAWpM61ah0Ycp5UdIHfHsRZ9UkSOsjVebobEQo
 2D+cBp6+Ec2871uYcMyi0tfZOeuzeqA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-5vxh-MXjOlq5_i0FBMTMwg-1; Thu, 01 Oct 2026 10:46:23 -0400
X-MC-Unique: 5vxh-MXjOlq5_i0FBMTMwg-1
X-Mimecast-MFC-AGG-ID: 5vxh-MXjOlq5_i0FBMTMwg_1790865982
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a022fee32fso6260155e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 07:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790865982; x=1791470782;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CuGmcOB5B7OU7vPcQ5Kxs9sP8F6GWHF+e8A0rz6DPVU=;
 b=GOwA7MR7ZwTOr7HwxsivDSNGFsHtrivuxOCxzYgkFwk+y25UeM9F6S6E8+53OQ8MWD
 1VgxHIB2azr9DtlprisTAohZ0wOSTXT3ydCw5BsVW72xN0D7YJyndFAgjfX0vB1W3elV
 NwEFNAw1JVyBsTHEjo9NG+pj9Vtf/SfXxpu+QgdEB0yIOSKnqIqpGKPP6pLKqBxsi5qP
 sw6BR0bzYoyG3d+EFKY5aOJqua02z+PMjCP3fY6SnJg0Kzf9ypy/iAOqDVLf+Nsbr2Wb
 FMtPDHjYde0i4PIgUl02AyUCecdLXbln5Ghx/i7bwND72Sd2LS9g0WIsnQYZOa1bBXSu
 U8lw==
X-Gm-Message-State: AFuF++nQhO1qy42OKCJRVTMQ4yEmziguQt/RfBBkDs7cQtzWvRa2188m
 YGo/wZgmC9JISN8zXTFXFtq5ZkqMxvSeFKaDEgvpGko0E32GHHg3fviIIRI5AteJ8fwgoCg0Jsu
 A8mMEFRpQG+VTQVFjqay76lC1c8lbxgCbi4eNF/wqU+DkVrbPsLzfmQbGAPd3fhQkLD4MMw==
X-Gm-Gg: AYBFou1mhT962bOx/OGCgh8hlPbvNlIPZw5F6uJREMOuhqMRalv3rtG4W038LconsmC
 LzgwhYPOlNKy4uF/w5IYWOgyQEiGz3Ll6YVwwoQoO35Cdc5bplHO8iS30yn+IAbTgNPBF/NSnwS
 tZhDF7ZaLcnQkEiU2raisF3ZgiFOclxgof9QLYGMJviPE5YfU3ssdmHmxZwu+DOAz5b7ysx7cQ+
 AQWcp3R25f4EsEug04JiJ4CsN1zYNXHuZbzflAGjPupKtWtPjPhsnXZ+x3E97tBQBwpPKI8u8oQ
 vh9/xLs8mW2pLgPonV9yqjvW4pY/IZFT6yp6coRtvkb63dPTTZ0cnxEZEuJgIKx9oESsjrBHVrv
 nXEgNHyX/xyxwiGtCsk6230RAFu+lgLKANPdyePSQvM/12pvm39yb5i1zVfpzBac9yw==
X-Received: by 2002:a05:600c:4e41:b0:4a0:c01:1902 with SMTP id
 5b1f17b1804b1-4a01ad9e5d2mr78126215e9.2.1790865981668; 
 Thu, 01 Oct 2026 07:46:21 -0700 (PDT)
X-Received: by 2002:a05:600c:4e41:b0:4a0:c01:1902 with SMTP id
 5b1f17b1804b1-4a01ad9e5d2mr78125495e9.2.1790865981098; 
 Thu, 01 Oct 2026 07:46:21 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0226201aasm59955425e9.6.2026.10.01.07.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 07:46:20 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, decui@microsoft.com, longli@microsoft.com,
 ssengar@linux.microsoft.com, andy@kernel.org, gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 2/2] drm/kms-helper: Remove struct
 drm_simple_display_pipe and helpers
In-Reply-To: <20261001133736.802604-3-tzimmermann@suse.de>
References: <20261001133736.802604-1-tzimmermann@suse.de>
 <20261001133736.802604-3-tzimmermann@suse.de>
Date: Thu, 01 Oct 2026 16:46:19 +0200
Message-ID: <xlv1jyo1fphg.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -jF0FL1qdBXFK2kZLlRbq1nfda94eCI2a5PEBeXvAYc_1790865982
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

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> There are no drivers using struct drm_simple_display_pipe. Remove
> the data type and all related helpers.
>
> The idea behind struct drm_simple_display_pipe was to provide an
> easier way for writing DRM drivers besides regular atomic helpers.
> It turned out to be more complicated. With all drivers being updated
> to use atomic helpers, it's time to remove simple-pipe. Also clean
> up the related TODO items.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  Documentation/gpu/todo.rst              |  17 --
>  drivers/gpu/drm/drm_gem_atomic_helper.c |  92 -------
>  drivers/gpu/drm/drm_simple_kms_helper.c | 328 ------------------------
>  drivers/staging/fbtft/TODO              |   6 +-
>  include/drm/drm_gem_atomic_helper.h     |  28 --
>  include/drm/drm_simple_kms_helper.h     |  56 +---

There are no more users of struct drm_simple_display_pipe but still some
drivers include the drm_simple_kms_helper.h header. Latest drm-misc-next: 

git grep "drm_simple_kms_helper.h" -- drivers/gpu/drm/*/ | wc -l
21

So it seems you need more  preparatory patches. For this patch though:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

