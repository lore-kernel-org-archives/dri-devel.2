Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB027C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 11:42:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35C3710E6E7;
	Tue, 22 Sep 2026 11:42:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="FgqlLnq2";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EED3910EC8F
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 11:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790077347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mdUWuoo29vP9GEST/2B25eDJsnzmLxEZrtfuekwV2RY=;
 b=FgqlLnq2XKGqgF9mS03pcUkkmKSwv3bRpWqFzRIclI85/wi0+FM8+vs9VS+EGPea+Id7qx
 dOkQfvlIi7uFpi2GSBmOAt7wlmfkw/JQ8OXBaECeWDdOsq6qEOBJZqGB+w2WYQiVxmEjie
 UUMmWt5dhqvpB57TBrAYAhurYF2Djro=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-Q-4rU2UeMViO4e25GRGJ1w-1; Tue, 22 Sep 2026 07:42:25 -0400
X-MC-Unique: Q-4rU2UeMViO4e25GRGJ1w-1
X-Mimecast-MFC-AGG-ID: Q-4rU2UeMViO4e25GRGJ1w_1790077345
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49e635a6002so48104665e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 04:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790077344; x=1790682144;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mdUWuoo29vP9GEST/2B25eDJsnzmLxEZrtfuekwV2RY=;
 b=w28z9H/8fT1YBUVyBh4k3e+q6PHxZdFr2Hc4sQAC+gR4EhQA2YjYilgbo/RvZAUtmp
 9uxkit3TmY6hhx4ZcRyvD6dK7xMjfl216I5cutoTkqkm/8RVbzQLTAUGsGZm+m2DWgQY
 nbMhhFKhJncbk9e9SPa29pn+Nuv8QGSTezsGrxr4jb9sEq8S52jv1zllZYDHd40BTMzD
 ZxPjqvr/5TbUBeiuw21xdykHP6G0TUOB1IJPHe6jWzyMPcPTxfJnOBzRHx6fsN32VOfq
 N74OT/Lxrr4RIXkMNJmlrDL7Y9vQcMRF3oXQlPcIlo2A4fVWrZlTDBmWH89ctoJ8clXj
 MDKg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQu6yTbwr+kN+/Zqrp4X5ltQNsZxFbmxnlOQLhOYFUsm4zNgxMwGFfVfYSyiYZPg27baWA/q74S+M=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mOS+AkpMPReTs7izsaNYDM3Gg9bOFPDHXJIt1aoyy20wcmiHrp
 TssQOmWcfQuaBlEviS/csoG24YSRJu+xERbdVELhA9RhIFqPzj8863aeywxdkkFGgF7QL3ryBev
 WrOlpgZSBKRD2dXF/5XhAmpBV09UXgXfhhLdbPECb07S2yL7FmbM0N49HGE7ymDCqOowjXg==
X-Gm-Gg: AYBFou3P9fi3eu0XtZXnlSbXqj8JvX3zJYn/EtEePiGLh/hzdusGyDI9Bxai83/afYc
 ePp1L7askGcrP57zhOjaJHYahWHbv4Kw623H/7rI4erkn+9lPAiVcJsIBs1nzv0L+vi0L7si34C
 r93jjZIQ4K7S+r2CBhBOdQxI9AB4CRSD/G9oKFxj3/XrBPCDa3hOhcuhebsTYItrcniK91MQIz2
 WXIsfUWitj9HRZjL1ek0/ApLwhv3owD8tk7x6VXBQSTTD7lep5+NY9J8WDEqd+HpGTF8lNrMTp1
 ufDd64CF3O5s5KcY6OfKoxImr1d7daoTicG4+r/Zb84uXqufWfAiMIUiN92954D2G3jUT4NTQDf
 2t48m2vbyUvFcr//s5QGdpv2twDuDdiBL0TU=
X-Received: by 2002:a05:600c:3593:b0:49f:dd6d:79a1 with SMTP id
 5b1f17b1804b1-49fdd6d79c2mr4158645e9.26.1790077344622; 
 Tue, 22 Sep 2026 04:42:24 -0700 (PDT)
X-Received: by 2002:a05:600c:3593:b0:49f:dd6d:79a1 with SMTP id
 5b1f17b1804b1-49fdd6d79c2mr4158065e9.26.1790077344206; 
 Tue, 22 Sep 2026 04:42:24 -0700 (PDT)
Received: from localhost ([90.167.86.28]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdad40c03sm52647185e9.11.2026.09.22.04.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 04:42:23 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, harry.wentland@amd.com, Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>
Cc: Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, "open list:INTEL DRM DISPLAY FOR XE AND
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, Hans de Goede
 <hansg@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, David
 Herrmann <dh.herrmann@gmail.com>, Mario Limonciello <superm1@kernel.org>
Subject: Re: [PATCH v8 04/14] drm: add connector backlight (LUMINANCE)
 infrastructure
In-Reply-To: <20260908044035.62093-5-mario.limonciello@amd.com>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <20260908044035.62093-5-mario.limonciello@amd.com>
Date: Tue, 22 Sep 2026 13:42:22 +0200
Message-ID: <xlv1ecelecm9.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GeQiJJJdg6p7hJ2el_PfK0IOJDLKmYxUxNhhlssdzqI_1790077345
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

Mario Limonciello <mario.limonciello@amd.com> writes:

> Backlight brightness is a property of a display, and thus of a DRM
> connector, yet it has historically only been controllable through the
> separate backlight sysfs interface. Add a generic, backend-agnostic
> per-connector LUMINANCE range property so brightness can be driven
> through the atomic modeset path like any other connector state.
>
> A struct drm_backlight is embedded in every connector and initialized by
> the core; drivers do not allocate it. A driver links a backend (today a
> backlight_device, in the future DDC/CI, MIPI-DCS, ...) with
> drm_backlight_link(), which creates the connector's LUMINANCE property

The infrastructure is meant to be backend-agnostic but drm_backlight_link()
which creates the connector's LUMINANCE property is backend specific. Maybe
would be better to not call drm_backlight to the DRM core helpers since it
conflates the backlight subsystem specific helpers, and the ones that are
supposed to be backend-agnostic.

Maybe drm_brightness or drm_luminance would be more suitable? That way would
be clear what is generic infra to handle the LUMINANCE property and what is
specific to drivers using a backlight device.

In fact, I think that would be better if you split this patch in the DRM core
helpers and another patch that adds the backlight specific helpers on top. It
would also be useful to have an example of a "native" backend, for drivers that
have a trivial brightness management.

For example, many small I2C or SPI display panels just send a few commands over 
the bus to change the backlight brightness. Those may have their own get/set
luminance callbacks and register their own struct drm_backlight_funcs.

Because right now seems to me that this drm_backlight infrastructure is mixing
the two layers and we have a leaky abstraction.

> with the backend's range. The property value is staged into the atomic
> connector state and only pushed to the hardware from the commit/enable
> path, via a workqueue so that slow backends never stall a commit. DPMS
> off drives the backlight to 0 and DPMS on restores the committed value.
>
> The property range is per-connector (created from the backend's
> max_brightness), so multiple panels no longer share and corrupt a single
> device-wide range. drm_backlight_link() also carries the legacy-sysfs
> takeover accounting used by the client capability added in a later patch.
>
> The whole feature is guarded by CONFIG_DRM_BACKLIGHT (which depends on,
> rather than selects, BACKLIGHT_CLASS_DEVICE) so DRM does not pull the
> backlight subsystem into the kernel when it is not wanted.
>

If we had a good separation between the drm_backlight core helpers and the
backlight subsystem then this dependency wouldn't be needed. Drivers would
use depend on CONFIG_DRM_BACKLIGHT to use the drm_backlight helpers and use
BACKLIGHT_CLASS_DEVICE dependent helpers, to be used as set/get callbacks.

Since DRM drivers that register a backlight device already depend on this
Kconfig symbol, no additional dependencies will be needed. And drivers that
only use the CONFIG_DRM_BACKLIGHT (with a different backend), won't need to
depend on CONFIG_DRM_BACKLIGHT.

In general, I think is preferable to have good helper functions that could
be reused by drivers, instead of having mid-layers such as drm_backlight_link().

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

