Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A47CCD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 12:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6638A10E0FB;
	Wed, 20 May 2026 12:17:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Vprp3n1L";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 832FC10E0FB
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 12:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779279457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BOsyqvSnsbEyyVQ8FQKJCi5HxKx1SaIi9DZWf/ykA20=;
 b=Vprp3n1LLYJ2/NxbajbHih/2x/hpO3f8ImC+fnhgPH6CbhHYScJbByIqtWsvNiWDL8dfDq
 swxmED9Ub9KQg3Gr5gZhKbzUm53rz0CEKVojoE4IUj45qVDIuSAYxsvM+uRtKk77ztOSBb
 NUyX9wxFrT6X8nm0ECQYAsbPraFhFGQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192--TtGpv24OWeQHHGeu8Kqxw-1; Wed, 20 May 2026 08:17:36 -0400
X-MC-Unique: -TtGpv24OWeQHHGeu8Kqxw-1
X-Mimecast-MFC-AGG-ID: -TtGpv24OWeQHHGeu8Kqxw_1779279455
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-449dcfe8005so3793769f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 05:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779279455; x=1779884255;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BOsyqvSnsbEyyVQ8FQKJCi5HxKx1SaIi9DZWf/ykA20=;
 b=Z4WbgN60b+tyB4QvT1H4ZW++swOOoTxS8pgvyzgmXHnCRX6WwaCS2s8x2ahc/AF7bH
 t1nGr+W83s5CmWebC5wrLq6w1ppJbK9hH1oA7Wuy6GsSDFgpXjjko6wpfUmRRvXU9vX7
 hx+vbfrF4RqDaDRCu1pN9+3enEvtXFEfo+YAEnYkAq4maEYCRYVuH6DgnuSs/EdIZM6F
 tYhzYag1dWesm7SReRB/pn+i2yL826+rLI8plyFWuN6A3noc0sgZPgZSPbI1xbqIOVRQ
 UCIce7AH9XpgVa6r2YunrcAu+G5ohWKPqDSJa5PW5KpAvTD9XLUDDe+7vRe73ICSoGqF
 iGbA==
X-Forwarded-Encrypted: i=1;
 AFNElJ90xBE5gckkOXvmveiTY9sBmAAUSCokdRlR9QKrDrnYJk//6HhJ1nhTP10tkZYJU3xZyJV6fxsUq9k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxG9fXJuh+L8utZNedFAVMJiQq5MVSLYhzL/tbfbX3pS5DV8ZNv
 GGBalRdHyhNGOR+nTLyoi/JXoE7ppnYZ4XVcQnM1YJwaHGtyNRnIqdVcaHGZqEMitklX6bvb+Kc
 hVcPb303SaSBuQHnG9gXijyelIsH+t4hTFg7XnT2D7ImpWv7cIfCg01m+WCKiBgYGO3hljg==
X-Gm-Gg: Acq92OFYRYccLPgSEP4xBsrY20/fy4fOft/d2dgOMG+P+KhpsZIBJse2u3Uw85+VbSD
 Qs5U9M6vLJ+jgcieCcH7uJk93yJP8tw+vjJuDITUutKC5VhdOlZIsk0de7QVtd5CfEt3FRawCSb
 21ejM83+fCtyohfF/AwvGKcMT8d4DD1wGg7UgdGRf++WE+fq5URlfUJHJDzFPm8BA/Yp5vysQzf
 rvavUG6X/L9hOvLYsgpSIb3dgt3I5sYz3bSxXF14Xpju1BVpxvlR7rr0ampCNhrZLsuKp8Nuwt2
 5NvJQT37I/TLEP2ZL45E/ZQIsFx3baoCSqxp1d9aOerqTnMicklKd4kHULDwTeY37VhpPZojBsA
 6xi/OATSzK9xD5CjSdiwJMV+yy8WF2A9brlby3SNir9/ecWTnKHEIrlvVMm2jmGuWDeJK5JSQ/a
 NyeS5g
X-Received: by 2002:a05:6000:22c5:b0:43d:7d24:b510 with SMTP id
 ffacd0b85a97d-45e5c5fd8demr39330709f8f.22.1779279454860; 
 Wed, 20 May 2026 05:17:34 -0700 (PDT)
X-Received: by 2002:a05:6000:22c5:b0:43d:7d24:b510 with SMTP id
 ffacd0b85a97d-45e5c5fd8demr39330657f8f.22.1779279454336; 
 Wed, 20 May 2026 05:17:34 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45e7c22d8b7sm24543112f8f.6.2026.05.20.05.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 05:17:33 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, David
 Airlie <airlied@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Nicolas
 Frattaroli <nicolas.frattaroli@collabora.com>, Simona Vetter
 <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/8] drm/display: hdmi: Add common TMDS character rate
 constants
In-Reply-To: <62ruh7xc5bgv2iifshhnd746nfghzczblsgxrumchuak564zvt@nligwnzsw6pz>
References: <20260519144712.1418302-1-javierm@redhat.com>
 <20260519144712.1418302-2-javierm@redhat.com>
 <62ruh7xc5bgv2iifshhnd746nfghzczblsgxrumchuak564zvt@nligwnzsw6pz>
Date: Wed, 20 May 2026 14:17:32 +0200
Message-ID: <87wlwywa03.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8ViEb0ymnuCaTS_CgPIOHvCPW4DS1Y2lugrM_p6ahmU_1779279455
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

> On Tue, May 19, 2026 at 04:46:57PM +0200, Javier Martinez Canillas wrote:
>> Several DRM drivers already define their own constants for minimum and
>> maximum TMDS character rates.
>> 
>> By defining common rate constants in a shared header, drivers can just use
>> them instead of having driver local define macros or use magic numbers.
>> 
>> The values defined in the <drm/display/drm_hdmi_helper.h> header correspond
>> to maximum TMDS character rates defined by each HDMI specification version:
>> 
>>   - DRM_HDMI_TMDS_CHAR_RATE_MIN:    25 MHz (minimum for all versions)
>>   - DRM_HDMI_TMDS_CHAR_RATE_MAX_1_0: 165 MHz (HDMI 1.0 maximum)
>>   - DRM_HDMI_TMDS_CHAR_RATE_MAX_1_3: 340 MHz (HDMI 1.3 maximum)
>>   - DRM_HDMI_TMDS_CHAR_RATE_MAX_2_0: 600 MHz (HDMI 2.0 maximum)
>
> These values are also used by the HDMI PHY drivers. Would it make sense
> to define them in <linux/hdmi.h> instead?
>

Yes, I think you are correct.

In fact I spotted more HDMI PHY drivers that could also use these defined
constants but just included the most obvious ones in this patch series.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

