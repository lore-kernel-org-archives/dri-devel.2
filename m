Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E3FCD6E55
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 10:30:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2840011317D;
	Mon,  1 Jun 2026 10:30:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="GQm6PenR";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FFFC11317D
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 10:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780309828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m5PnIUHVz9ACSP+/e7SnC4cD1TL+Z3tg4EIuDM06718=;
 b=GQm6PenRqlHE5fwAvh+yBpQ2UAw1QmnxoIow7O6zDOsku8TzYA8QdOyu3j6l42Q8L6yizA
 5a51IR6zIJR1uWwRz+k2MmEajcFk0WuFqy9wnSqKh5LCcXCM5yv89TPmlIFNRY2FRoVaWv
 s6u9HfZ18Lg58gep2XyVg2OvnJBRT1w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-M1AIPUtyO8CTz6ZLvOXBmg-1; Mon, 01 Jun 2026 06:30:27 -0400
X-MC-Unique: M1AIPUtyO8CTz6ZLvOXBmg-1
X-Mimecast-MFC-AGG-ID: M1AIPUtyO8CTz6ZLvOXBmg_1780309826
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49045f93baeso68353425e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 03:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780309826; x=1780914626;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m5PnIUHVz9ACSP+/e7SnC4cD1TL+Z3tg4EIuDM06718=;
 b=OLbL6cv5d+2ghRgDHA/mELtKjwwFv0Byw9lCefOVG1EsBkGLDrnB8Oi+I2dofAxrGg
 XnnyZzOUksBI4tPmplVoZ/mGSg9nyUy+/w2PIQYV13zZGUEM/aFr53atyPVCAByoHFN+
 YhbSrDGmUwk4nhaD9eydQeOPj1RVR/OR23lxUgMWaVcMlifNwCB9ve9ZoCdIZ91YHeiR
 Kje8XheDPf8AnBYN/4AbFwSdP4YY9FR0hGr3nNwg1I+S6rR0c32XH5rGc7zEM4zRwgPN
 Y2WEI4nieZeJmapH08fnjnF/PaGaTPJNo5UxS3WdcoAwtVtx9QVAZ5tiS/GKYk3baojA
 hM7A==
X-Gm-Message-State: AOJu0Yz5q1C+YywgGwga5sBOaJkB3HcXeC2uhqTF1w1XVnd3THe1bjFa
 keUfxIOu9w35p/JJjIC4rf5Ot908/ianqW8OlpihkvJKNKT85I6+bRAYDTxyVocBGMTnQE5urhA
 Bckj6qyKJ0i1AR+e28kpjLTSkBZbAZHX6+7dCMcADdgTxEMU5PD9RApbUMDPXzHF0i39kSQ==
X-Gm-Gg: Acq92OHvpCgpdbhrnwAgtxJpLRBNDXLZ8+NEZ20HYdTuD5djs565OA/LppwDCbqmJW0
 RHqM5cvUA9OxtSrUMmTHFFSdrfL9LOAFdlGWfpi3Iqm5TFLfOhsgbzaJ1xF9cIWhMlS8nqpmo9u
 NIt+7euAAtKEagX6hQAUDqjoLnSxWXn2TiiV34f4YECrl4IIBPbgRP5jaIA3Z3gu3psTyOB4aqt
 0pjOYUnYMJ3Xg5MA3NqhxCZ3lbS6VL3hr3sE7nsz9rmx2nliuYSaO9hX2+OW+csK9uRnm04om5J
 YyEOhJ6AAObMHY7u8hjTW0rFtill3MDH2E1lkqR/B1+PMXmGjxQpTH0z5QKjgM93J7Q8qn1/4uY
 h0nl9O5XGQzoUX0MPLAfV5x2Va9VvUEfDSPF3PQlbDiZxdeoob8ufbh9hr7kZ16cjFsQY3as0sM
 2NglDqEg8yWFcO9/U=
X-Received: by 2002:a05:600c:8582:b0:490:51e9:deba with SMTP id
 5b1f17b1804b1-490a293b7c1mr147144675e9.27.1780309826049; 
 Mon, 01 Jun 2026 03:30:26 -0700 (PDT)
X-Received: by 2002:a05:600c:8582:b0:490:51e9:deba with SMTP id
 5b1f17b1804b1-490a293b7c1mr147143955e9.27.1780309825482; 
 Mon, 01 Jun 2026 03:30:25 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490adb4381csm24027695e9.3.2026.06.01.03.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 03:30:24 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, airlied@redhat.com, airlied@gmail.com,
 simona@ffwll.ch, admin@kodeit.net, gargaditya08@proton.me,
 paul@crapouillou.net, jani.nikula@linux.intel.com, mhklinux@outlook.com,
 zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 10/10] drm/vmwgfx: Remove unused field struct
 vmwgfx_du_update_plane.old_state
In-Reply-To: <20260530185716.65688-11-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-11-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:30:23 +0200
Message-ID: <878q8ylfi8.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5bdHH4z9nQ1SXRabheKuX86xws_fYdd_joIu01fTS_Q_1780309826
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

> Plane updates no longer require the old plane state. Remove the field
> from struct vmwgfx_du_update_plane and fix all callers.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

