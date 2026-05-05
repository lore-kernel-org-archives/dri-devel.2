Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07582FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 09:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6181810EA29;
	Tue,  5 May 2026 09:47:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="JEwtXqh7";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 268A210EA2B
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 09:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777974448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uqp2hsSGqvPbDuohp5kkdOibkhT3t/xFOJLm1OTg2Pc=;
 b=JEwtXqh72QO2S3lHB8Hh8jVdRxSJLZR3XnfYqrUdx06TnfDCCxQVrndDZziIetWSJcdpfl
 /hYvMqk4RHSxEcyp90JlQ6X3gnT9CMfEqdl+0O3hc7v7+UF1gmmkkD3Gnk44dUpTgPLT9M
 jXnkC+1dg2aUugh0x3l0tDMWYHec+1A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-hiW6TCo1PUWJubthE-2Gpg-1; Tue, 05 May 2026 05:47:26 -0400
X-MC-Unique: hiW6TCo1PUWJubthE-2Gpg-1
X-Mimecast-MFC-AGG-ID: hiW6TCo1PUWJubthE-2Gpg_1777974446
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43efc93e4f6so3838369f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 02:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777974445; x=1778579245;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uqp2hsSGqvPbDuohp5kkdOibkhT3t/xFOJLm1OTg2Pc=;
 b=CX3xVq0oKCgmtnmqueYaswK4hDXmRcpD/741TJfiZfts3xRvx3n0h8EjiG87C+CRm6
 8zqYzeoFQhmTk53w85emhx6Hzv9QsZ4k3tnmmruk8nwqa7/XLuIfwHt9S3o3E6nQk/uW
 59zVVj+MQEsSUyV5o/3zOgVjn+XKpkvh3YC1sxgNv8Iv+vLh72PUd3xr7TKKPlFiFwfK
 njTLgmj34elTdu/mnU9e50JJDbpRqZYvYzjddf+1bekM+nx5waGSZ18a92yQDqFCM2xi
 qiCiS+vYOM8wQ8ksaMT2naxRK+Ykbg9ow6HaGCxa8raCKE5TI6XoKxuJP9JPi5Cm/1Ho
 ozag==
X-Gm-Message-State: AOJu0YyfKsrJih5qeLpC02eUeMn/dz6cGiSn2ehPPuITLRO/aGUqzaMw
 sP0GZabNKgwBbhyHHQ6Wvi4ANj4W64ZOqbY5+636A1c8OvU6NCqj2+SXr/eADvVPon1ntnY4I2E
 OARrz/m/cb0u4wfxIripMS7mT1yngM5ydDcwmh7hjQH4UB6JLrI1e0/RWJa7GsXjovmw/hQ==
X-Gm-Gg: AeBDiev2b4+uT/2bB5zyepkT8mZY+J2mG8Kc1u0Z309hfwUayX5NoOQrRtGp/N+sew9
 HOpwyGBPvZs4ONL64z/oc4c8IvvKOqSGCWG8I8q6LCcinVwCnmqDbvX83SgCU9zVHG83CkdyK8p
 5xB3FlUCzTTCnaRuJLTlLYRBqwYvrnBQB0nQRHavROaq12Eq5RmaxsuEmP6H9b9o7vhKEhx2/H+
 F5l2MuBVzYJdWYaMhrjvGEqGT/8vQvwp0jYQNIoG65CrlIUvTGNBL7YC/Ef2qR+JFd9SSZIFtso
 d8WhvISeeJbNvqhFqjS5GqrVWDTqLvfV6mrkwatNmGA0F4oP1VZEZbSxbjhMK+AmCovhWevwtGz
 IdEDIsnUGzYbTyHuQ8qW7J7gN3M3wHMWP+W5l+rF0OlvKvuNXbvrzQTat7oJaW/MT4G6gn+/kXY
 NRW+z1/FKEUAJJths=
X-Received: by 2002:a05:6000:2dc6:b0:448:e182:b7ae with SMTP id
 ffacd0b85a97d-44bb2e2efc5mr21797888f8f.7.1777974445423; 
 Tue, 05 May 2026 02:47:25 -0700 (PDT)
X-Received: by 2002:a05:6000:2dc6:b0:448:e182:b7ae with SMTP id
 ffacd0b85a97d-44bb2e2efc5mr21797825f8f.7.1777974444844; 
 Tue, 05 May 2026 02:47:24 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4505238e6e0sm3151543f8f.6.2026.05.05.02.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 02:47:24 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/5] drm/sysfb: Support basic power management
In-Reply-To: <363f1a6e-e0fb-4a28-b4a1-1f78376ae775@suse.de>
References: <20260408120722.328769-1-tzimmermann@suse.de>
 <87340gq2ey.fsf@ocarina.mail-host-address-is-not-set>
 <e5414c41-85d6-47b4-8372-a51f55bab0e6@suse.de>
 <87fr46kxyf.fsf@ocarina.mail-host-address-is-not-set>
 <363f1a6e-e0fb-4a28-b4a1-1f78376ae775@suse.de>
Date: Tue, 05 May 2026 11:47:23 +0200
Message-ID: <87cxzakx1w.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 04NLsGawBxLP6bayp2-6qDL4lsXrGAGsrnsCnFqT-ss_1777974446
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

> Am 05.05.26 um 11:27 schrieb Javier Martinez Canillas:

[...]

>>>> You tested with vesadrm, do you know if would work for the other drivers
>>>> too ? I guess that there is value in adding these to all these even if it
>>>> might not work outside of emulators.
>>> Agreed. The drivers currently do nothing on suspend/resume, but pretend
>>> that hardware is still running afterwards. Since we haven't heard about
>>> problems with this, we can also try to suspend/resume DRM state
>>> correctly as it won't make things worse.
>>>
>>> However, I only know that it works with vesadrm.
>>>
>> Got it. Are you planning to merge this series then ?
>
> Already done :)
>

Ah, great!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

