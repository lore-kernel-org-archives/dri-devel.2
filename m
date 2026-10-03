Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1F7CA5FE3
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 10:39:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33E1D10FB12;
	Sat,  3 Oct 2026 10:39:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="f4wk1eEo";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EAEC10FB14
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 10:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791023994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yEazttUDpzXlqXpxwJlMZPomrWiWdlvAhL9J6+CU2p8=;
 b=f4wk1eEo9CdHqGaXqMDH9jtMslhTckkoTa4SmXzHlKiJey5wUWIth/AW9/JkuZnjSPJ8xF
 QrfKHQfjm29QywYBf622wzsSU6KDFT0wGi5oymqMeOKFsnPD0mBR3iebzPDPjs9lIm3iYN
 YRFjGjFSjvnQdY8fombqnJuG65U613A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-gKIvh6QBPBeNtwg57FX7ew-1; Sat, 03 Oct 2026 06:39:51 -0400
X-MC-Unique: gKIvh6QBPBeNtwg57FX7ew-1
X-Mimecast-MFC-AGG-ID: gKIvh6QBPBeNtwg57FX7ew_1791023990
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a028616bebso4317815e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 03:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791023990; x=1791628790;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yEazttUDpzXlqXpxwJlMZPomrWiWdlvAhL9J6+CU2p8=;
 b=vxVy2Kt48ldLn2pQ/sDwqXEh0m4nESOqaAmh3OdiNnUAkCDWm5JT0r03LWpqCQqDWM
 /ju4geGNY5/6QaoHgGW6ybI88d+M6dvdqF1wmKbLqo0kKmraMDyeT/baUQ7ZGvPAiaTh
 d5kxWx2l4MzubDgYaj/jSl9F5j/5P4QjUOFA8VrSjiNg+eKU0JBShbhGD9/HRZ0ismkl
 xotKYf0lkPSCVt1W3rN1HOQetFSUwB62WDB37C9tGPf4gs6Y5z9tX1UNBdEQ4x49Egcm
 JT8ApsYi7o33TLK6Re2T/tHbxpdyUaAuhpHsIVvHvIUio+Zky98lnNk5G1i4tB+8MCH7
 w3Mg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzTp5/1XB1ZsBb1iKMiU4nhuZnI9m2GXQLU/KT2zmFN0cB4hg+EIEatupZDESdA263PPbutXJVlNJs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n7YwvItgZP/xJN4Y1+8YV2+CxRBCCokDO2W0KuRfXkQPtxI6Tx
 PHnqJGea6tIuOQ3FZXlXbJjIJjXtxwV2BSPxChzUSx2iJOR5Mewf4kXv+0dT3own30CoU3x4pQb
 N4Di+6DrA9gl4OCC/IHuiXTORWAqqPw9cIv0O08IW/PVRHAmrZV65H1kkUkGOXj0fwy7+HJ0j/J
 hodg==
X-Gm-Gg: AYBFou3Q3h96/iuTK5QStcZdDh6xXgZKJWzQARbGcXtqk2VhI3HlJiIfWRQMhFSvstY
 6GwCOx9fse6DKj6J19LHfP3zu8x32+0gQD5rRrelbL9qGgBiNs4/qm57tfhkMjB+bVIMaU+Q++O
 6Cy6V2DZUQRrnrSFUvUkxVYao9ltwxXkQqiXPAcxc7XcWMr1iAg6LJOYgiI4yxpJV4D0zDGSuub
 BZc6gI0EeSPP+IaI2Dz3G2vLPRLKY22BGWgOK6oCcGP/YJIcm9LUwTwGtLEsBwQI2jMe6whDIpk
 qQqHsYQh+1RHpBla1tgAEbr3W0Vw1Q09/F4ZDWITtv9/ht0xZeU7nTFm5HNPulZbedn2cM6D+E/
 JXPWpJ6BpHX6r3ef9HAYXETCQRE+SAmLQLGfjLkMUWyKI1CDaQd8HsOx8u1vH8uYylQ==
X-Received: by 2002:a05:600c:5392:b0:4a1:6991:36d7 with SMTP id
 5b1f17b1804b1-4a1699137bfmr23376215e9.10.1791023989727; 
 Sat, 03 Oct 2026 03:39:49 -0700 (PDT)
X-Received: by 2002:a05:600c:5392:b0:4a1:6991:36d7 with SMTP id
 5b1f17b1804b1-4a1699137bfmr23376055e9.10.1791023989341; 
 Sat, 03 Oct 2026 03:39:49 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a02770fe4csm168249935e9.7.2026.10.03.03.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 03:39:48 -0700 (PDT)
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
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: Re: [PATCH v9 21/21] drm/solomon: add SSD130x connector luminance
 support
In-Reply-To: <20261002190030.211356-22-mario.limonciello@amd.com>
References: <20261002190030.211356-1-mario.limonciello@amd.com>
 <20261002190030.211356-22-mario.limonciello@amd.com>
Date: Sat, 03 Oct 2026 12:39:47 +0200
Message-ID: <xlv1wlrz5aq4.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IGtHDUZrJfBy8ohZZEyAH-Xs7RpdnOaufUKLdBDzAZM_1791023990
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

> Expose SSD130x contrast through the connector LUMINANCE property when
> DRM_LUMINANCE is enabled. Program contrast directly and retain the
> backlight class interface otherwise.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

Actually, one more comment:

>  
> -static const struct backlight_ops ssd130xfb_bl_ops[] = {
> +static const struct backlight_ops ssd130xfb_bl_ops[] __maybe_unused = {
>  	[SSD130X_FAMILY] = {
>  		.update_status	= ssd130x_update_bl,
>  	},

I think that instead of __maybe_unused, this definition could also
be guarded by IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE).

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

