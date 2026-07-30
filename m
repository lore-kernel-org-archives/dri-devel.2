Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C18C54FDF
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 08:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16A2910EE09;
	Thu, 30 Jul 2026 08:01:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="GSL41a4X";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDE7710EE09
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 08:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785398513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZRhh55uRwcmRO5vd0NulUAwd0U4XXcDtVd9jnzUnDak=;
 b=GSL41a4XgdiCoGHE2TBf/c+l51X9mYqjovgzwbCPt20MMZfErDNmDrIH9FuXtenWRqdvDQ
 K6QawZwYlQVn+AmgvEl4oq5RLP3Z/UWficsk9wp9RdAvr0FxmgYzSdz4XMyJUG2xt7olv7
 J4iP1sgm4jTFqhp8TB0AkjZBHLrUzl4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-YtwlMbjpMxWMR6eKouJuRQ-1; Thu, 30 Jul 2026 04:01:51 -0400
X-MC-Unique: YtwlMbjpMxWMR6eKouJuRQ-1
X-Mimecast-MFC-AGG-ID: YtwlMbjpMxWMR6eKouJuRQ_1785398510
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4955fd77c18so11967835e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 01:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785398510; x=1786003310;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZRhh55uRwcmRO5vd0NulUAwd0U4XXcDtVd9jnzUnDak=;
 b=MWnK6wn8hbiNmN7BfAg3NbNyY2evtOduo5Om5QujkCBSdnWFVj2zzpGOHHAB2EFA1m
 nPwLnirct+XEyYhLMhcm28rNpoNiSqYbeKutHktW7CzFAeMOV1JRjG80jRXQsAU/UHZV
 5DgzEOqQp70D5I/zqTRjJ4peP7RiS14X3OYnokky+e+txBhj46N3eNVB4tTCXmMbJLUE
 jSLELspBn7GJgvhCxkrpf5tDfTLyKrVmsKdSv50PeXwV6eARkKl0gq7565/dsPgmsuLn
 eHz/zpLfaCDEczY9+L1+P/9DAc6CCFbYb/vryRzzOi9w7bntK3Z2dBcH7yz/NRD3Dt5/
 epOw==
X-Gm-Message-State: AOJu0YxMfrI+hEWPhs7wrUcgoL5vJU6pXVB/mwB9cnc2uTzc1dd9AiLG
 eiRyr56qQVI5VUdFOZGry/JoqmwqLj0F9OZN3Lq2O8yxOwyHSg96HIzD/EIPkSym/knm/v5mzVt
 PfDQYpOt7EUEgIaEnUSvPzION70fWjxrUDekpq3XnIMbJGMo1OK47rTuSh16sfKXhB8nJWA==
X-Gm-Gg: AR+sD13rM2oeUZCkAJtdx7y7B+R/e1HVuHg3POlsL+gQMwnprlnaduIq4V34EWPqGBx
 20BhvuQOqTyPDPkpWGtQTDgehZlVJOPn/l5M4CCGGW1NW9z676VWe45OBrk87T8VcxvLYMadbLa
 c7oBpgYhWBCj+fhZ1mvT8k8i53inCaphbEBn/Msos8IgoKZgNwMT90h+6IfJ/R3Z9kpmfsk5J8Y
 1fdTedSXZfIRflphAU8oSoDXGSIng6leQh3+uvyhECZg1ANRzYJYysIRVIKY7oJblaLIiay/WYl
 Nz0Tx0DLWbOw+DGkmBWTwiVPCsWLEbFjjKvekC87AND/dYRMLeBrpEK61bs4ZwAD02gM4T1cEJU
 pj9VixE1o93LRcDdOH5y1nhQHSIERfnNBVJV0A0YAgcQfEEG1du2RET8Jyus=
X-Received: by 2002:a05:600c:5248:b0:495:5e86:4e59 with SMTP id
 5b1f17b1804b1-49800ead9c0mr18856285e9.22.1785398509863; 
 Thu, 30 Jul 2026 01:01:49 -0700 (PDT)
X-Received: by 2002:a05:600c:5248:b0:495:5e86:4e59 with SMTP id
 5b1f17b1804b1-49800ead9c0mr18854415e9.22.1785398507984; 
 Thu, 30 Jul 2026 01:01:47 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-498010bb0e7sm37393845e9.15.2026.07.30.01.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 01:01:46 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Amit
 Barzilai <amit.barzilai22@gmail.com>
Subject: Re: [PATCH 1/2] drm/ssd130x: Scale ssd133x per-channel contrast by
 brightness on init
In-Reply-To: <20260729053054.29374-2-amit.barzilai22@gmail.com>
References: <20260729053054.29374-1-amit.barzilai22@gmail.com>
 <20260729053054.29374-2-amit.barzilai22@gmail.com>
Date: Thu, 30 Jul 2026 10:01:45 +0200
Message-ID: <87a4r8ewie.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZHXvmVESN0PJQIGsbxbWWbd2Tk63YWLSw8gtr_Wm99I_1785398510
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

Amit Barzilai <amit.barzilai22@gmail.com> writes:

Hello Amit,

Thanks for your patch.

> ssd133x_init() wrote the SSD133X_CONTRAST_A/B/C commands with magic hex
> values (0x91/0x50/0x7d).  These are a per-channel white-balance
> calibration: the A/B/C channels drive sub-pixels whose OLED materials
> differ in luminous efficiency, so the values set the white point at full
> brightness.
>
> Extract them into ssd133x_set_contrast(), which scales each channel by a
> requested brightness via ssd130x_scale_contrast(), instead of writing the
> calibration unconditionally.  This makes the sequence readable, avoids
> repetition, and is a prerequisite for wiring up an ssd133x backlight
> controller that dims while preserving the white point.
>
> Note this changes the ssd133x power-on brightness.  Previously the init
> wrote the calibration unscaled and ignored ssd130x->contrast, so the
> panel always booted at full brightness.  It now scales by the shared
> default contrast of 127, i.e. half of MAX_CONTRAST (255).  This is
> intentional and matches ssd130x, whose contrast register also defaults
> to 127 (mid-scale), so all families now power on at ~50% and report
> props.brightness = 127 / max_brightness = 255 to userspace.
>
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
> ---

Looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

