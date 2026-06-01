Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07CDCD6E55
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 10:29:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C22111316F;
	Mon,  1 Jun 2026 10:29:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Ya46cfdP";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09FAF113171
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 10:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780309743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rR3vdJBAgyYpZ/mB0zSfLOFP8KAbUlqalAgRbWXUhZ4=;
 b=Ya46cfdPCpfK3KOJatoUvbcW6GqOT7VEuVcn8wDVFsHmfrxCb8XC20CKiRpmKxPv1G3FGt
 b7UQHfhJpPFYZRmGLGoRkshCtAFjP4kREH0YH8f/vKRxUZg8Zi5oHnyYlu7UbWWzCBtcW5
 BhZzCXCsJR4y+M/q1NQeWb4d2XojD5M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-3NdSLqRDPlOuXtPfoiSRZQ-1; Mon, 01 Jun 2026 06:28:59 -0400
X-MC-Unique: 3NdSLqRDPlOuXtPfoiSRZQ-1
X-Mimecast-MFC-AGG-ID: 3NdSLqRDPlOuXtPfoiSRZQ_1780309739
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45ef6417092so1569018f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 03:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780309738; x=1780914538;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rR3vdJBAgyYpZ/mB0zSfLOFP8KAbUlqalAgRbWXUhZ4=;
 b=KIGj7ll0BHxkMyQnbn9pO0sMlwiw++lCZ1gtqzlAr863apZh9unKee7atmYuoDhZZT
 Dmk0w/wjiLeNF3ud/frJVo7vdKwF0HqpnMr3mQs1O2ZW+Z/nzpflg+RRV78j3Yl5qpT6
 /erWLzJPcwZq0D0hmv2n5IHEWUUzlV4iweXe9E+e+2hiZHX7S8KNT7j0mU80WUgoebQx
 35qfwWeTaq1g6AkiYk9VC6/QJLUVgJJXSrid/AWDcS+z9OV9C8l/QRj/HAIpnn/ZYC9g
 GQIB9dKjkSsoMtOcW1t6Mkre1cCkiMXROyIuLEqV5CO7BYZBSNPPB/e6eQIycbZvPtYX
 1dNg==
X-Gm-Message-State: AOJu0YyA+roMK9b5m3FuN97N8VbVP3kY7wnLhIe8DYemzAQf8pU6jw5+
 9hoTgAIGhICRWqLjfzBixz7WUN9NO7tBg8QLV5Qms9qYpxeESk5DgLokWfmo1nnkLHmCTcwgH1S
 8jGIDYu1dFxvaBBnFP7xg24QrBP10HCS689+04aC/ovRyL0TBOUvJloAMRl+EhOOAklIOmQ==
X-Gm-Gg: Acq92OFsvjSGYS4Api7ZhH2SsUj3hbrNPP7uL9IvzBFYFGywUrDddWHbxoWbXAfIKsE
 6PeLdLWwkk/Wfi7+VoWTBVJdSUv2oeAxmGuI4P7XRLrWfGmlruRtt5fcD3VFpOL+iwvmWIY1s3Z
 LJX/4StI0cgotag99Y8aQB6ruKYlmQwO6GdnOTvr28w+hmqVRqXSgJQqIfZnBPcJdAuf9Qm6YNQ
 Yu3tCUuqQHTjpDAlSOpBgHsVN8YymZ2NIv5JL0ww0ezx6asmmaiAOfOhIfWbiCsJeAOCJzpOD9q
 zUSgS3k1Twi1vK+9hnjlfFwhT79KdHruzoZDy1JX7RZUpuZ3zTt1FzSOOkLSR6p4dpOHcNbtDhW
 eN1pRkdxT94v+0h+OvpHOcSIgxYhPVxRXAlXOUWyJ7i87Y2ajVljK00FO5njeiiDmLoWfYJQLL9
 IGtp4HFujQYvpC9lI=
X-Received: by 2002:a05:600c:a214:b0:490:9782:3eb8 with SMTP id
 5b1f17b1804b1-490a2948f0cmr117371235e9.25.1780309738522; 
 Mon, 01 Jun 2026 03:28:58 -0700 (PDT)
X-Received: by 2002:a05:600c:a214:b0:490:9782:3eb8 with SMTP id
 5b1f17b1804b1-490a2948f0cmr117370965e9.25.1780309738117; 
 Mon, 01 Jun 2026 03:28:58 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ae3901cesm8445615e9.7.2026.06.01.03.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 03:28:57 -0700 (PDT)
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
Subject: Re: [PATCH v4 07/10] drm/damage-helper: Remove old state from
 drm_atomic_helper_damage_iter_init()
In-Reply-To: <20260530185716.65688-8-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-8-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:28:56 +0200
Message-ID: <87h5nmlfkn.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6ODH8W8sJ0EQbPsliiQi-3O1NsF3cXt7qZd8tyLBdqU_1780309739
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

> Nothing in drm_atomic_helper_damage_iter_init() requires the old
> plane state. Remove the parameter and mass-convert callers.
>
> Most callers now no longer require the old plane state in their plane's
> atomic_update helper. Remove it as well.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Zack Rusin <zack.rusin@broadcom.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

