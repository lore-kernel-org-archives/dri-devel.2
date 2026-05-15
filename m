Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF76FCD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 09:35:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B36810F4B5;
	Fri, 15 May 2026 09:35:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="e7ksZWVh";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A850A10F4B5
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 09:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778837750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tK4K+HoEFodeqj4ZSnIg/mlD1eHHL0CKGkFwFzadqEc=;
 b=e7ksZWVhTHK98u5ZScLVi4ws2fkVTvpng0C/80z3ge3OU6sYW0HOcrRYahyxv8BqUEly+2
 +HLLrqBTTemLsJ9k2WM0itfQ+fd3MvXbS5yJCpU8AhhYhnZJ4mefKAswtJ7wSNQRmIpcRO
 nxXvbq5HDG09pr3vhrNFtL42j6OsC54=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-aTdO3dk2OP69L7m5Z-qlGg-1; Fri, 15 May 2026 05:35:47 -0400
X-MC-Unique: aTdO3dk2OP69L7m5Z-qlGg-1
X-Mimecast-MFC-AGG-ID: aTdO3dk2OP69L7m5Z-qlGg_1778837746
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44b186b715aso5574667f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 02:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778837746; x=1779442546;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tK4K+HoEFodeqj4ZSnIg/mlD1eHHL0CKGkFwFzadqEc=;
 b=Nj1um7QoIH9i3mtSxfiefzXJrvdhp5OARtMK31jEDZLCjqVE82ZWKWzHtm+hLQty2e
 OAnafG5VvKe1zKTLvXBFHua4srSH1TVCsOSe2vnvgCikr/kd8Q/SIpJ8GsdayUkZf2Mc
 b6JROn0sBPmcDrHatynB6VNkY9K/EdriTDHuUOD/yIsgEHST7OiMkG+wafxSxDcWpzo8
 vYl29PYumzfA6GEfA+25kxPkP28x6XrY5/eFAfIOQvE5qk/FsoO3fDlnR6t13OJHsQH+
 dBqC/dWZfrl5iZ+nEEMrxGBFXajeH1kOV1fBbCw9TFr7dbrxsLE0/S65QPMqrztPU3Zu
 b7jA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9H8qZxY+cYo/xuixSbgGo5TmU297m1DHim0NVm7wkx5G8GdPQ2YYuJgZdSoH0GJGHP3Dpzxsf0oYg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwK+aFlkkldm7sld/xaHbRp/rvRo7dqyJ3bZiIBQ44fML/5Zd6C
 uUDQzmxpeNDvrHWmHgjY/Wc7hGxVzdZV5Pu/v2YzNdnkruLhgzhtqyUA4re3s0MK2GZ/MvwwWWf
 +Xgbnpm9Ftw0jvi18bUVLcHZEfva07BALy5NlCahm+V3QWcBfESbTCWubCcEym+nrdxgmnQ==
X-Gm-Gg: Acq92OE/G+SrC36321Jp2n8vmhiOq5SlilxR+sfcVvKnPhmmgDZ5xpYNuQomENBobIa
 k32tJ4/4RFvcLNyhc1zn7IWgNxVvuD4CvWyYRZuD0WYKueZoDNzQXQ3mCbieHSNZnjHMvQv4vD/
 aD8L4vedxpfdzuYSfvZY6IBsI57xMRSlqIlGCEPetyJ5lbQuBao1vs67KVWRjld9ZprA+VGdQBN
 +hI90DvVdwNrtVOyExzvT58CBKE0Fy5vE658+NMliyuKdpqAJu2qq7uaeLIKAuoLcknswCb9GEw
 iir2lMloafImHrW/vpKgZTZwr7uncTyyoVStvU1CNlX2Yhs8YubK214GB64voWJYMV1f/Y2VRp8
 EIUSkfbGLl49LEz/xLv2MNfC7J1x4oM1XJMYSkGmNp4aiyUnYgtF20A0eolp5cWKONF4ynrYcOF
 J/fduQB0YsgZMJaWE=
X-Received: by 2002:a05:6000:401e:b0:43c:d665:3830 with SMTP id
 ffacd0b85a97d-45e5c59540bmr3873668f8f.32.1778837746008; 
 Fri, 15 May 2026 02:35:46 -0700 (PDT)
X-Received: by 2002:a05:6000:401e:b0:43c:d665:3830 with SMTP id
 ffacd0b85a97d-45e5c59540bmr3873596f8f.32.1778837745483; 
 Fri, 15 May 2026 02:35:45 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a6454sm12934912f8f.34.2026.05.15.02.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 02:35:44 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 David Airlie <airlied@gmail.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Phong LE <ple@baylibre.com>, Robert Foss
 <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann
 <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 1/3] drm/bridge: ite-it66121: Switch to the HDMI
 connector helpers
In-Reply-To: <20260515-magnificent-boisterous-dragonfly-2560d4@houat>
References: <20260515090220.809830-1-javierm@redhat.com>
 <20260515090220.809830-2-javierm@redhat.com>
 <20260515-magnificent-boisterous-dragonfly-2560d4@houat>
Date: Fri, 15 May 2026 11:35:43 +0200
Message-ID: <87o6ihxbf4.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YQgTvHiAsb6zcXYvF9xm-5eQDaIDZgl3C6IHOjJoEB0_1778837746
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

Hello Maxime,

> On Fri, May 15, 2026 at 11:02:09AM +0200, Javier Martinez Canillas wrote:

[...]

>> +static int it66121_bridge_hdmi_write_hdmi_infoframe(struct drm_bridge *bridge,
>> +						    const u8 *buffer, size_t len)
>> +{
>> +	return 0;
>> +}
>> +
>
> When the code says it's mandatory, it means "it needs to be implemented" ;)
>

Fair. The driver currently is only implenting AVI infoframes, but I agree
that needs to implement these too. I'll tackle that in the next iteration.

> Looks good otherwise

Thanks again for all your feedback and patience reviewing this series.

> Maxime

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

