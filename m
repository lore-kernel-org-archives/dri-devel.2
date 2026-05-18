Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C3BCD4F52
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 10:29:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9728310E30C;
	Mon, 18 May 2026 10:29:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="bFm55wE8";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4C6110E30C
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 10:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779100185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=06m9OVWKqpnsGVT1SKIUZ2m40GcgZTxTHQ+S3N+VJ20=;
 b=bFm55wE8xTHzepczvD8wGF5Fe04LPl6b6kAJBHiPumdrQK9upLHCmolxZ8QC948iCn8o0L
 Eam/U0vIWXgMHOmqeBjnQCRtKrcOoLSk5IH2uiTG4aQwfoXaVmsDdjeEBOTnux1A78FTyR
 VmHS/EzUfzruipkFXoyzLRwk7ytMl2U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-9nL8yYZ4M36atYjFjPFSQA-1; Mon, 18 May 2026 06:29:44 -0400
X-MC-Unique: 9nL8yYZ4M36atYjFjPFSQA-1
X-Mimecast-MFC-AGG-ID: 9nL8yYZ4M36atYjFjPFSQA_1779100182
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-44d9ace59efso1404087f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 03:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779100182; x=1779704982;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=06m9OVWKqpnsGVT1SKIUZ2m40GcgZTxTHQ+S3N+VJ20=;
 b=aVQlXR1xqvoLpLCLoL0iPI5GXmYHZarGSEMqjOY9rOOV5H90wbfCGX7dwmspyK5QNE
 X8xQmTsGQEo+jdoxPgNN4FBmzOH9BxpNscVeT3XWN5+5qA6rsWJiFWD44a2y6DVjVixj
 dBBsSlv4pejzwwqj/UW3k9RlUn4yKnn9Q9EnDth3D2/H9WSmRb1n3TTYGIK/3OzK2wC8
 XTCxb/lwA1bp6kOUR+6Q4DblkR1lbdn0mUPQT+vKxcamzUB1T+wL7/BIyAnGfGNaAQeN
 OcaxnE+nNOt6LGAUe9eG/HNQTAFmNuWTuau+VbffRs/m7SNHqmrVEpWGMUUIeVNWlQoU
 Hn+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8FYD23JbHn07ifXaXjP7tjTW/dBUn0sNBgalCwxGA/WCKpOci0YiGAPu1acwYXLXDaL3eCDZBOyvU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzzKrlqmxgVFvievBoLhoQ6RyEuZnYq9hx7sWoH7GOE8PhX4JFW
 VkB3DjI825xk0qsqVCKCyOMaiUO+J5RY4Fz2uP8OsFYd05/ScwF3zeJG9I+6vLX6dDZ5jGiIiJM
 r4lqCm+xB05+OeKkYbBYnBWCeRW432FSAnM0+odzbfP+sENt0g2IHe+48ojBxvZkaVYWdiA==
X-Gm-Gg: Acq92OEx+J/BaFvowgeIhDieZaNPZ22W5zX8Khvgh9l8bcgoNfPOOqqZpz/gFHkBdAJ
 vMgm1n5QxxnyNaOpaYRTNwDX4W9xnAD8hKsSJdMvPXZl6kK4ek6DpYZFWcokYZwRwHV4MWO/Sxn
 3KlKh18qYVzSVTphj/oTmnuyQKELfSQtdgH/2671cH+HcbLc8SqzQ/9vuw1TRYEYLe7dWcqlFce
 V73J9gC2a9GuoZralmKQRKPNEghWcZy0iBT+xxsNgPC4jH6ocB67ym1wWFcpOAdU+0lhGMhhhje
 LWqDzx46/sQgjXPUo71MPbFy7VZbD4oFVhJpNXc9mp/fwFgnbMoS8zv7uE5aLTSi0nzhV9+LXq4
 xRYeJoOiTuwzaxmrrL26p54JyP8bGdYIki/Z1bUS23FCPcNm5hl4cTRdwJffWw7yBOshWmXa6tS
 kRytv1
X-Received: by 2002:a05:600c:c10b:b0:48f:d1b8:9aa4 with SMTP id
 5b1f17b1804b1-48fe5fcdef4mr168629535e9.7.1779100181766; 
 Mon, 18 May 2026 03:29:41 -0700 (PDT)
X-Received: by 2002:a05:600c:c10b:b0:48f:d1b8:9aa4 with SMTP id
 5b1f17b1804b1-48fe5fcdef4mr168629045e9.7.1779100181295; 
 Mon, 18 May 2026 03:29:41 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe537c516sm267101625e9.13.2026.05.18.03.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 03:29:40 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Sen Wang <sen@ti.com>, ple@baylibre.com, neil.armstrong@linaro.org,
 dmitry.baryshkov@oss.qualcomm.com
Cc: andrzej.hajda@intel.com, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, devarsht@ti.com, s-jain1@ti.com, j-sahu@ti.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Sen Wang
 <sen@ti.com>
Subject: Re: [PATCH v2] drm/bridge: ite-it66121: Convert to DRM HDMI Audio
 Helper
In-Reply-To: <20260318154636.3230454-1-sen@ti.com>
References: <20260318154636.3230454-1-sen@ti.com>
Date: Mon, 18 May 2026 12:29:39 +0200
Message-ID: <87ecj9xb70.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 50ck-gXPwhNKLPlZ5nzyfq0TZdtBYkfdUgQ-gFPbIeM_1779100182
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

Sen Wang <sen@ti.com> writes:

Hello Sen,

> Convert the IT66121 HDMI bridge driver from manually registering an
> hdmi-codec platform device to using the DRM HDMI Audio Helper framework
> via DRM_BRIDGE_OP_HDMI_AUDIO instead.
>
> The previous implementation manually allocated hdmi_codec_pdata,
> registered the platform device, and implemented hdmi_codec_ops callbacks
> including get_eld. The new approach sets DRM_BRIDGE_OP_HDMI_AUDIO on the
> bridge, letting the framework handle the codec registration. This also
> resolves some non-compliance issues with the current audio implementation,
> such as HDMI audio advertising a non-functional capture stream to userspace.
>
> The audio callbacks are converted from hdmi_codec_ops signatures to
> drm_bridge_funcs hdmi_audio callbacks:
>   - it66121_audio_hw_params   -> it66121_hdmi_audio_prepare
>   - it66121_audio_startup     -> it66121_hdmi_audio_startup
>   - it66121_audio_shutdown    -> it66121_hdmi_audio_shutdown
>   - it66121_audio_mute        -> it66121_hdmi_audio_mute_stream
>
> The it66121_audio_get_eld, it66121_audio_codec_ops, and
> it66121_audio_codec_init functions are removed as the framework handles
> these responsibilities.
>
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Sen Wang <sen@ti.com>
> ---

The patch looks correct to me but I'm not that familiar with the HDMI
helpers, so it would be great if either Dmitry or Maxime could take a
look to the changes before merging it.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

