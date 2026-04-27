Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346F9FF8862
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9724910E152;
	Mon, 27 Apr 2026 08:06:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="LIWYMMWb";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E38AB10E152
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 08:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777277182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I8486OD3ZJY6rIVx7zUJLtX+rKcwNjOX8BkGm66VEmk=;
 b=LIWYMMWbhFTaWv6+cOcrqYqUlJ6xfpTPxIdey1h1nICL6yzRmZGndG0eqXxrRlb+1CrC4R
 l6FWftyGzVZ9kxvFWcBAmS2D3S/NW1IvAfmTm49uLF+O/e6fQsTmgYVPM/BF4NPALEFkgE
 uuEViktB4pDBwuxutW4J4+DDAk/KHV4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-fC_6ZnInNXSZUKEIhlGlLg-1; Mon, 27 Apr 2026 04:06:21 -0400
X-MC-Unique: fC_6ZnInNXSZUKEIhlGlLg-1
X-Mimecast-MFC-AGG-ID: fC_6ZnInNXSZUKEIhlGlLg_1777277181
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-358df8fbd1cso12636829a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 01:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277180; x=1777881980;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I8486OD3ZJY6rIVx7zUJLtX+rKcwNjOX8BkGm66VEmk=;
 b=JFvU7XBuMZ+gy732KDJsDwTxbwaAnjsNnf8a+tjmk1R+kGk+MFlJ86RRUonqLqYGR7
 eTy0GGWpbvm8iGu49VrxS7OtmplGToOtYWoXMnPbmbZ/uNgvEIIsqweTPnYYAWhZiIP+
 pUBBfsRgBVjTaQ8DZ5Lf0JtuDaF5EFv44wxSwRDLNE9Ez4pD3f5OIl7ZEeZts3YowZ03
 WWpHfreOkp679l+iUMufyLU3D5kmS9MXyJp8glrUKd3+LUPOsMW35tzgC65umnh0Ue/X
 weGaQ0+D8g2VC3RFtqXkDt3kWdQZOiDEi1DEQngEws9ISp/3++H8gyIB82UXDDMf1wTo
 oHng==
X-Gm-Message-State: AOJu0Yw7ak3oIGLNhx5EDAhsG9FJXGOCyHrEj3+fw4gBlrKfjYhHYV3B
 iYE4K86pqpJFO2/arQNEoGBBuprfNeiox18SeRt88Pj2AJrI5cRXp4m0ZpT5J/z4ctisoloACfI
 qP5sizlL0hK0WOdMgU1sealPIs6S6y3XBNzsBIDtmin6H/HyDyYEDeIUcjynAwuvHRLo6KAkoiZ
 Q9Ig==
X-Gm-Gg: AeBDietphiMg+HPi3/wse8D4dGtur0p0TimAF0Cbw0DiWy8Qt44mVonhfhIxOkBGU0t
 x2KW0CH64OksXMhZ1EK2OeyXKg/2caex7ijGLCCEmEzVdeBX7u6aI3nV0e1r93uKFFgLpP6SstF
 eGqIoNStRwrCm2THx7j5tXUVNJG3Z5C/WLrZBtqGrpsoFQPfV7B5eDe9b+L2tjqKsatE9GXPrra
 cFLWk8mEgQqT97heyjUxsAjLExBvm+bOJzOHO1TvV9Ztk+Y1jSfF6B30xFCvZFkVTXWbQX4cUn0
 NB/2jW784+LDAmB79B95P+Oq4HVO5mbn0Nw6SirXmzkaaR6RFyO7p5q9LAS9Hemlt9BV+mcTSMU
 wRJTnGG5nwN3/hbD2DFJI5MN1yaJfaLXdp0yeZRkUh/11hj5QEkVZ2sahi2I=
X-Received: by 2002:a17:90b:52cf:b0:35e:577c:c9f with SMTP id
 98e67ed59e1d1-361403fb305mr41315120a91.9.1777277180283; 
 Mon, 27 Apr 2026 01:06:20 -0700 (PDT)
X-Received: by 2002:a17:90b:52cf:b0:35e:577c:c9f with SMTP id
 98e67ed59e1d1-361403fb305mr41315086a91.9.1777277179716; 
 Mon, 27 Apr 2026 01:06:19 -0700 (PDT)
Received: from localhost ([149.6.131.75]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361418c3944sm39051115a91.8.2026.04.27.01.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 01:06:19 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 3/5] drm/sysfb: ofdrm: Support power management
In-Reply-To: <20260408120722.328769-4-tzimmermann@suse.de>
References: <20260408120722.328769-1-tzimmermann@suse.de>
 <20260408120722.328769-4-tzimmermann@suse.de>
Date: Mon, 27 Apr 2026 10:06:13 +0200
Message-ID: <87wlxsomiy.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j1OX6eJFhp6WGBvR5stVgssi-fWbq52teSUW3U6r5wQ_1777277181
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

> Set PM ops for the ofdrm driver. Suspend and resume the DRM state
> on systems that support it.
>
> Many systems lose the hardware's framebuffer settings on suspend,
> hence resuming doesn't work there. Yet some systems, most notably
> emulators, keep the hardware state across suspend/resume cycles.
> There, DRM's suspend and resume helpers bring back the display on
> resume.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

