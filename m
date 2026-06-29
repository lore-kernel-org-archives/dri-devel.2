Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF2AC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:02:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9871C10E81D;
	Mon, 29 Jun 2026 11:02:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="SNrswBqn";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C68010E063
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 11:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782730954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V08Udq0tZlJLOccj0MLLEN1U44SsQfheARIHuvO4nm0=;
 b=SNrswBqnEknwZk8HZJIplMUuP3dZENJZ3blltZ5F8ZoenM1psfWUTQxaJg9KahD4oLmN9z
 c8U3MeoZjaFVDk2l1URvt707eomqdWtXoP1Eos3Zs7K44WR+bQFADF+SMsoyq6DIc99MSQ
 bvWak7yfEImp2EKjRdG2ltnsIYJ4S8A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-p2Z5URJKPzS7X6MaK5k-lw-1; Mon, 29 Jun 2026 07:02:33 -0400
X-MC-Unique: p2Z5URJKPzS7X6MaK5k-lw-1
X-Mimecast-MFC-AGG-ID: p2Z5URJKPzS7X6MaK5k-lw_1782730952
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4932f0fdcebso20199875e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 04:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782730952; x=1783335752;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V08Udq0tZlJLOccj0MLLEN1U44SsQfheARIHuvO4nm0=;
 b=d40mQjYxm7HsJQAM0EvJ6JDeiXe3CuE7XIdsvLDBAxn9fRMe1cbYAJVSfhHE3DpsZ4
 w8pXqDtNl9aLsire+m9oV7sFrdrbyhhwS6x99iz65yJWvupXGfyVb/xr/MW+2FTOBFTO
 4wAHf/SNlcp1socb1mqUOIsCTVLVpF7wLOaB3Te78O++SemyUnBNaTvIRsYjc2YAIj4b
 4azK/gLWro1OwiwTIPViJSQfGI1b8/gZsJGNf2BN0FERLStkKXqEKZWB9Klr1fqjdgjo
 fM4TT6lmgeFycB85DtchqJ8mn+KGHeuCdDVZI2elbxYQ4HhNz2LjbVuRYYNrr5PEqeea
 iVPg==
X-Gm-Message-State: AOJu0YwISG7A7tAu5G282U5ifiCRAa9zpy/z6N4Xv4P9DSMXdk1YwWMw
 FgxF5x9rkk6HDdnxJV+bsJIZlsY+p3pZTR8q1TsnAlywh6t3pXmPQljVpCZKixwH70VvumCsK5f
 v3feCaE9zx0VtttIbazpPlZfbWlRia+Rx8/Un86bKv45hA/b0DWeCf0Plav5636t/7EoUtQ==
X-Gm-Gg: AfdE7ckX9wxVU9O5t0VvtXEXelP9SaTJLWPtuuKJwEJYtm4UdG/tfQcfuOQkTFcGUFw
 IA0ebjm5wb9lQDohcwlkEPW+vYyuVfXCSLnofkN/blLTHP0I3PQwpuT9sbxwaQSaSJspA2SMk6D
 TiMmAuKRtTsdzxwwm6R4WmvSHMPPHMA57okqnqIObMXfQtdMac0QgG98RhpwGvbLVKW+UuFuA/e
 nEWUVuK63XVD3NBvlzdVq///rae0s0UH6f3dOPO7ZnpzlpZmFiPdZFrrux7V3K5804OZNllRKZF
 kYdccHgowqAq9SFtzMsdhcHPaqF5iTQBqb19nxLNBJ39aH49Cor5JnEHzPL2SUaoZzYl/nHzD40
 yCkTD7lWFBGQfWG/hywkGk6aJQDYjM3J1mV88qzjxBqz8Wbf7CzpP2lswGQ2ptN+Fb6YaOQ==
X-Received: by 2002:a05:600c:3b28:b0:48a:906b:14ca with SMTP id
 5b1f17b1804b1-4926687e77emr234847925e9.20.1782730951768; 
 Mon, 29 Jun 2026 04:02:31 -0700 (PDT)
X-Received: by 2002:a05:600c:3b28:b0:48a:906b:14ca with SMTP id
 5b1f17b1804b1-4926687e77emr234847085e9.20.1782730951162; 
 Mon, 29 Jun 2026 04:02:31 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268f7670bsm300917355e9.0.2026.06.29.04.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 04:02:29 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, treding@nvidia.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, neil.armstrong@linaro.org, jesszhan0024@gmail.com,
 rayyan@ansari.sh
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 0/7] drm/sysfb: simpledrm: Various improvements
In-Reply-To: <20260625094509.157581-1-tzimmermann@suse.de>
References: <20260625094509.157581-1-tzimmermann@suse.de>
Date: Mon, 29 Jun 2026 13:02:28 +0200
Message-ID: <87h5mld2yj.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qHQoEDhLeWHrYG_LJ70dJA3CDp-DXRgumlivEsIerSk_1782730952
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

> Patches 1 to 5 improve validation of the values provided by the
> device firmware.
>
> Patches 6 and 7 improve support for panel orientation. There's a rotation
> property in the DT panel node. Read the value and set the connector's
> orientation property accordingly. To do so, patch 6 moves the existing
> code for parsing the rotation to drm_of.c. This makes it available to
> simpledrm without introducing a dependency on DRM_PANEL.
>
> v3:
> - use shared helper for parsing the panel orentation (Thierry)
> - fix framebuffer size checks (Sashiko)
> - minor improvements
> v2:
> - further improve input validation (Sashiko)
>

The whole series looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

