Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC92CCD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 13:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4526510E178;
	Tue, 19 May 2026 13:17:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="QWOddI+r";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B5D410ECD9
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 13:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779196620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/LOovjAZT4lRgdqKgiBX8lchnRmwSyGi/qnxwGppx/I=;
 b=QWOddI+rQwCdkMChkBr3ZnRhAOKiAvYJDHX8aWJ3FkidnwXOgmJHbDaLFDgLBoBQ7aKd6r
 HjU47rdBwOA5BW4T0mfUa0RJ87x8R0ckeP5upR3xWu9tg+Z8bV01Kx0BXTJ2W4OCevbwVP
 V8/HkOMEY3q2ZmoD5dw/RuXFkp50SRo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-DXU4sZ8iM9qgc2axgXujvQ-1; Tue, 19 May 2026 09:16:58 -0400
X-MC-Unique: DXU4sZ8iM9qgc2axgXujvQ-1
X-Mimecast-MFC-AGG-ID: DXU4sZ8iM9qgc2axgXujvQ_1779196617
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48fe24773c8so18424735e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 06:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779196617; x=1779801417;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/LOovjAZT4lRgdqKgiBX8lchnRmwSyGi/qnxwGppx/I=;
 b=PCoW+UPFfoqIlnE/ujFi6L9+mjHOCwT5zHymOtLGWsmdhkWaSiyU6aNb8MrD+9zLKY
 g1AF3alPBHo7q0dcsLNRpd7x+1izeSg74pTXDAE2r+1yjQTblsD0XlHq9K8sCGlmb+2t
 htvhQ/r8sqZaOi3XLwU9SubCnz5hM6RHAYqVLeSaPghsxrsSCFAVs7DLoL2hU3cV+DHF
 7gRhZr7suZi+FJCyppFEVECBKllj/gPxznisc/arf5C03nQqFbr9gfqG6Xj3MQuK6BK+
 b4MLzl7clh44or/Y8I3oOkvGo6P9RVX5d+hiwbRqt/JgKJO/WppfXhzwrtOunz7Bsl2r
 aaBw==
X-Gm-Message-State: AOJu0Yz+0tEHXHtw9HSVD2xIX1Hr+vWVmk/YKKgHWCX25R7qXG3stDpc
 UX/Dbtz6heDD/9DzGi5K3r/zVt8J7v0Vb1FYvHAplqBAWdnB03UFqClRVEusM2wTvlr4pee2oN3
 GhnE/j29gysLb6aVCXoaT9zl1OCpNbVexyDHvKMqX3sQGEkgpbha6SXPas74SbCFTH4VoJg==
X-Gm-Gg: Acq92OHPGrfwq4n/TGM3fvp43nTpi5F/KpFOVYLpOAAwAzd+4KrStOFqUqYyWwiMAyX
 vByGsWFUwKufVkYZTQrkYxuz6oqTU0p5DHXXyU2q3bekfUl6pyDXYJWAqy30PjH2RY10t76NItN
 VF1Y82ZQLmysO4IAdF7d9A8bl7a0WIpwJUx5K+aXHh90jEyVuCteEQjSv9zO6gC/dRRF9Qx6Y+6
 YEuvKrmPaVng97Ia3+qddaQ80UMAsLzhMcO1BqGTkzozARbao8CMV19fROZ9OZUGRlKMjIgWLGO
 Z7D6zzhr4oZaArYHMi5+NrVRfOJU1do5pvIM/JjeAChNJustwZ8ZSSTdXWuLeRBGuoAQmcFyQFy
 9MQgeet9KfFwxqVxVQ8KrVFEJPw+doSopVIK1tPvKAs1x4iSfB29Lc58pQVVLuLz4dMAhH/L74n
 mMAfIV
X-Received: by 2002:a05:600c:a11c:b0:48a:5970:2003 with SMTP id
 5b1f17b1804b1-48fe5fd483amr232122045e9.3.1779196617225; 
 Tue, 19 May 2026 06:16:57 -0700 (PDT)
X-Received: by 2002:a05:600c:a11c:b0:48a:5970:2003 with SMTP id
 5b1f17b1804b1-48fe5fd483amr232121455e9.3.1779196616677; 
 Tue, 19 May 2026 06:16:56 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe661e1sm107915015e9.22.2026.05.19.06.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 06:16:56 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Brajesh Gupta <brajesh.gupta@imgtec.com>, Frank Binns
 <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, Alessio
 Belle <alessio.belle@imgtec.com>, Alexandru Dadu
 <alexandru.dadu@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Brajesh
 Gupta <brajesh.gupta@imgtec.com>
Subject: Re: [PATCH v2 3/4] drm/imagination: Rename FW booted to FW initialised
In-Reply-To: <20260519-b4-context_reset-v2-3-931018a7131d@imgtec.com>
References: <20260519-b4-context_reset-v2-0-931018a7131d@imgtec.com>
 <20260519-b4-context_reset-v2-3-931018a7131d@imgtec.com>
Date: Tue, 19 May 2026 15:16:55 +0200
Message-ID: <878q9fy1x4.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u4eyI40C8sKhRBWfouYdKO-HkGEesvfNxNEeqNr_tvE_1779196617
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

Brajesh Gupta <brajesh.gupta@imgtec.com> writes:

Hello Brajesh and Matt,

> Rename the variable from 'booted' to 'initialised' to align with the
> driver's expectations and state, indicating that FW boot initialisation
> is complete and the firmware is fully initialised.
>
> Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
> ---
>  drivers/gpu/drm/imagination/pvr_device.c |  2 +-
>  drivers/gpu/drm/imagination/pvr_fw.c     |  4 ++--
>  drivers/gpu/drm/imagination/pvr_fw.h     |  7 +++++--
>  drivers/gpu/drm/imagination/pvr_mmu.c    |  4 ++--
>  drivers/gpu/drm/imagination/pvr_power.c  | 14 +++++++-------
>  5 files changed, 17 insertions(+), 14 deletions(-)
>

[...]

> -	if (pvr_dev->fw_dev.booted) {
> -		err = pvr_power_fw_disable(pvr_dev, false, true);
> +	if (pvr_dev->fw_dev.initialised) {
> +		err = pvr_power_fw_disable(pvr_dev, false);
>  		if (err)

This broke the build because it incorrectly changed the pvr_power_fw_disable()
and pvr_power_fw_enable() function calls, dropping the third argument.

I've just posted a patch to fix this.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

