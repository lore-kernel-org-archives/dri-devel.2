Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3231C606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TSgJLCeF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D15410ED97;
	Mon, 16 Nov 2026 09:39:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5905410ED97
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 09:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794821948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vfDtkcqPvV+2k9dyjsvEmJCR0/Gq1KXbglEhzSUqmq4=;
 b=TSgJLCeFDC+7XOHzSGCuBkK1Tffv4W6F0ZOw1rXgig+s3ADuWPrHqktz/3DfCJIliwG9uw
 JBw/I/KcpFSC6vSjyE2PGbH6TlwOR1fj8BVSNwiUTnhHZH5vyDCcqzY1clhfR+qbeMQWfW
 ruIGC/X78G0LIVGL+GgO6wPBFykJ+P8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-cEIz35JhOiKEz_yaPeZEeg-1; Mon, 16 Nov 2026 04:39:07 -0500
X-MC-Unique: cEIz35JhOiKEz_yaPeZEeg-1
X-Mimecast-MFC-AGG-ID: cEIz35JhOiKEz_yaPeZEeg_1794821946
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48e4d1e29f3so3085390f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 01:39:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794821946; x=1795426746;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vfDtkcqPvV+2k9dyjsvEmJCR0/Gq1KXbglEhzSUqmq4=;
 b=Opoa6vpJNJSqejV0H/vq5aYA/5HdZwdEx9FWG0SQKaE2w9QksZ9zdvL8vmdgVxATwG
 AfdJ6Q5P85HJRgslGYUOqh1WnC1rvEqDXljfPm4HmIWHBpzDWdcQunv7gvGnIfoMq2rx
 j6VL/gzdhArUJqLHiabZk1K27dDuj7VLqyQi8RdGt1o/SaZD2aOGEU4V4VMDgfNrAj7y
 SVr5z8QHmxfdYqaPoKNacy70k+nzT20s6MpDTgDQbTQPAj7p4E8WHsxVXYKrYcTrjaWM
 c0EjaRBhmNzBvLA1brGYUaBON/KrpIhJcTwjBy46+rrfrjQjCKphSNFj+D8U9F0wHA5q
 +qtA==
X-Forwarded-Encrypted: i=1;
 AL+hErHdYZktDNtY+e1EElyhi7aDNhU/2BgVVut0TzvF03xxsFU5crbVdaFucTZBtrVJuc6omS9v9Y9t5tg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+J2v5tGPoUneEJnFD47G54GudlpaMNI89sTcASxgfPJerhnm5U
 A0mP9Cz037M1IPgwpYt6fveiSOgydto+A0RtNQ8/wPT6NoksCqsoLkc3oM/YSpGs4HEG3mEi1Q1
 V4ob+a8STANyH3+O6NFs1WfFAgk7LrQxknjNg0R6HOP9PG4YiOEXBqLOtNJZKajUDPxWuwQ==
X-Gm-Gg: AZFdTZdmoKExW5h81unErGUZ8m7XYIhEkzBg13OUXa5xrR1IEXQaFzy9/34mSkFUam0
 x9ENzmH0LNye7R9mD632AkYyUbA41wBecnyLtLCca5gEbGjwYX6KzAfRJUyWIZSh0eeDsJf3oMS
 sOFXtmHrAo4Vr+7kvIskhvhC+u1dn8XZrrEffh0sV3zS9UFPDVGnnAWNIWoFcBAQA2NIs5+VwJm
 a9aUz29lfSFXN2cb9opWsPFI9hCTC0h5OxgBLS6oBO0SKG/EKihyChmRXzjLUfRe70FdtgopEKP
 FiO1W6O1z2O03cVuFlrlWb62SxxR438MkduTXYP6StlATxtCyQSGbC93FZJNXQXmSrFq5zQwh4D
 /zdKnLxjJPXjsI49jY0dt5dsZLGT3HR8mg80XwHY3+hSixzndHFFcwgMrfIu5AFfplLiQFaYFtA
 qWFPBPuYQHAkD5pva86UPfnAWGAmtmhyFcnt40V6o=
X-Received: by 2002:a05:6000:25c1:b0:4a1:486b:4eb9 with SMTP id
 ffacd0b85a97d-4a1486b53eemr6359112f8f.40.1794821945602; 
 Mon, 16 Nov 2026 01:39:05 -0800 (PST)
X-Received: by 2002:a05:6000:25c1:b0:4a1:486b:4eb9 with SMTP id
 ffacd0b85a97d-4a1486b53eemr6359053f8f.40.1794821945065; 
 Mon, 16 Nov 2026 01:39:05 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c7da37b19sm21564920f8f.5.2026.11.16.01.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 01:39:04 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>, Maxime Ripard
 <mripard@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Jani
 Nikula <jani.nikula@linux.intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>, Leo Li
 <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>
Cc: Mario Limonciello <superm1@kernel.org>, Xaver Hugl
 <xaver.hugl@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: Re: [PATCH v11 12/12] drm/solomon: add SSD130x connector luminance
 support
In-Reply-To: <20261103-superm1-backlight-property-v11-12-00cce7b2ba22@kernel.org>
References: <20261103-superm1-backlight-property-v11-0-00cce7b2ba22@kernel.org>
 <20261103-superm1-backlight-property-v11-12-00cce7b2ba22@kernel.org>
Date: Mon, 16 Nov 2026 10:39:03 +0100
Message-ID: <xlv1ik1xru88.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CQpdqd8Hi-GtxnAh6y_iia9mNc51T4Cdvc3PoqM6KsI_1794821946
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

"Mario Limonciello (AMD)" <superm1@kernel.org> writes:

Hello Mario,

> From: Mario Limonciello <mario.limonciello@amd.com>
>
> Expose SSD130x contrast through the connector LUMINANCE property when
> DRM_LUMINANCE is enabled. Program contrast directly and register the
> backlight class device only when DRM_LUMINANCE is disabled, so contrast
> has a single owner.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v11:
>  * Keep selecting BACKLIGHT_CLASS_DEVICE and drop the guards (Sashiko)
>  * Register the backlight device only without DRM_LUMINANCE (Sashiko)
>  * Initialise the controller with the committed luminance and don't
>    clobber the saved contrast on disable (Sashiko)
>  * Skip contrast writes while the controller is powered down (Sashiko)
>  * Unify contrast dispatch and backlight ops (Sashiko)
>  * Drop Reviewed-by due to the rework
> v10:
>  * Guard the backlight operations and registration with
>    BACKLIGHT_CLASS_DEVICE
>  * Fix Kconfig recursive issue
>  * Add the Reviewed-by tag
> ---
>  drivers/gpu/drm/solomon/ssd130x.c | 149 ++++++++++++++++++++++++--------------
>  drivers/gpu/drm/solomon/ssd130x.h |   2 +
>  2 files changed, 98 insertions(+), 53 deletions(-)

[...]

> +static void ssd130x_connector_set_luminance(const struct drm_connector_state *conn_state)
> +{
> +	struct ssd130x_device *ssd130x = drm_to_ssd130x(conn_state->connector->dev);
> +
> +	/*
> +	 * The encoder enable already initialized the controller with the
> +	 * committed luminance. Skip if it failed to power up the controller.
> +	 */
> +	if (!ssd130x->enabled || ssd130x->contrast == conn_state->luminance)
> +		return;
> +

Is not clear to me why you need this enabled field? I would prefer to not
keep that state if possible.

The changes look good to me though:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

