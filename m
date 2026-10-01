Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9128ACA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 14:38:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E77F410E6BC;
	Thu,  1 Oct 2026 14:38:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="MOGMB4bp";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C1C310E6BC
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 14:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790865528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i4xhRQFt/bWT6UALcOITRzeSEDfb1ACELZHI8/ear74=;
 b=MOGMB4bptmjrAUfsFXwv27H1fZMiLdFytAW6j6JLWvMDQaYF/G8FjP+IE30htHVdFnNovC
 Aki3g2uJ0tnKe5iNLvLMn0ulq8aUexfq2ioxZOkv8Vdut3gXl8AxYt4kaFt5FOoRyd6GSR
 ihjlNtU6Lm5zURsFXQDk9U824s8sRGw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-3lXGUPWaNliuXoN_TZxlxQ-1; Thu, 01 Oct 2026 10:38:47 -0400
X-MC-Unique: 3lXGUPWaNliuXoN_TZxlxQ-1
X-Mimecast-MFC-AGG-ID: 3lXGUPWaNliuXoN_TZxlxQ_1790865526
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a01c621dc2so10880015e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 07:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790865526; x=1791470326;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i4xhRQFt/bWT6UALcOITRzeSEDfb1ACELZHI8/ear74=;
 b=x/JRNhLogrgB1lG8g3FhMpPr6vnC+1adPcZHtrICcE6C/ujLGvKjdtCRzzFNYfviFK
 6Jiue1rTt8i42pd3IFPr5dBE3tfd9K4Mqr0l6s8xSVn6a/Z/FWGLxIdwsEPpQOF+/u/k
 39QHy2Ukk/6mnK/8bVnqFWo6EA0leajnS4TfRKuQPhxwXejxzXGGFjQ6OaIuxVCAQukO
 yMX2Ybv2pNjfTePH4ehCKHcnFITBAMpLioWfAajsRdLgsck0Oz93iZcTE4w130IFTqx6
 0u7GWsr7yVQ5RBN3oO7LZSKBvQuZ1RscFkJ1BYFKzamjldHANfmwzgLfprwIxZwCKIDL
 TOPw==
X-Gm-Message-State: AFuF++kxEVyRkk83QZsDJqqq1b2oz4faMUI9m4zOfOp2nRXdcjROy0oA
 3HOFTMcRDLt/DqnXj3oAquHugWl4lcbKJYKW4vpmLlwHZ6lEyLsNtRaCmq5GCxto1uX3RzEoQ6p
 HfkWUhX4VRkAju+KVU5cEUby8XrLLpW0QZx1P3WYx+G8FM2YTo+eWW53Vdg2Mc4YmAP/7ww==
X-Gm-Gg: AYBFou0ix49njNRiDrVjr+8B7h3Uz9P5GR4MfkU37JNHy1R+98uL/xctynZBldDL7db
 /STZE7XT9xSEwKCFWJv8Vv4M9uCYhgWBkR8zLmhUajewd5lJXOe9iiMK8o0yA8kqo1LtJI/O1OP
 Ipsor5B36jr8t3YtcF7xm8hvf5paMBWy80idVmb96eRQ0gkijIUOaaJKsKtsIkPdC4JU8GtQ/dU
 ZHGS+B7LMnqpijXiGAdPU9tzgn5JV5l0lc81KpHY9UcVUWLgemL4vsBqMDPrBz6sezkk3edGucB
 FLN/pCHc2KAvy3uw2aiTD1fqseOsWuvS6Rur2tHKyazQTKpKbWhKBBjqfzjHVlw4NNv/Hlz5t7X
 T6pfEhFoT2XAzfo7AtAZl02LYZgX5xq2aSbiEUiq6+kXWyg9UvMKGSJsUOHC/iSmzVQ==
X-Received: by 2002:a05:600c:1f86:b0:4a0:13ea:2ec3 with SMTP id
 5b1f17b1804b1-4a01b135eccmr80506985e9.35.1790865526407; 
 Thu, 01 Oct 2026 07:38:46 -0700 (PDT)
X-Received: by 2002:a05:600c:1f86:b0:4a0:13ea:2ec3 with SMTP id
 5b1f17b1804b1-4a01b135eccmr80506425e9.35.1790865525833; 
 Thu, 01 Oct 2026 07:38:45 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a023ebe694sm51117505e9.10.2026.10.01.07.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 07:38:45 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, decui@microsoft.com, longli@microsoft.com,
 ssengar@linux.microsoft.com, andy@kernel.org, gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 2/2] drm/kms-helper: Remove struct
 drm_simple_display_pipe and helpers
In-Reply-To: <20261001133736.802604-3-tzimmermann@suse.de>
References: <20261001133736.802604-1-tzimmermann@suse.de>
 <20261001133736.802604-3-tzimmermann@suse.de>
Date: Thu, 01 Oct 2026 16:38:44 +0200
Message-ID: <xlv1mrsxfpu3.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: B4GPWSjPyz-IPHsQI3EEXegyddz1gDgUq5mu6SGsu7g_1790865526
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

> There are no drivers using struct drm_simple_display_pipe. Remove
> the data type and all related helpers.
>
> The idea behind struct drm_simple_display_pipe was to provide an
> easier way for writing DRM drivers besides regular atomic helpers.
> It turned out to be more complicated. With all drivers being updated
> to use atomic helpers, it's time to remove simple-pipe. Also clean
> up the related TODO items.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

