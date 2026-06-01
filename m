Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD157CD6E62
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 10:30:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAEF8113190;
	Mon,  1 Jun 2026 10:30:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ZX6x9eiB";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 422EE113195
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 10:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780309803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wi97KWGdJTdWq3IdYpsAWLx4xopc99EofOMqrefmH9Q=;
 b=ZX6x9eiBPV38y8Bjz6hiGqz3TItoF+lCpb9j6fw+st8riYtmvSsQRYg4OF3YhGc+reI/Xa
 348RIHXwT5aIiala50ZB8/GarJFHxjeF16d22Kpbt/FXc+euOfsA53i0Wfv7rAqYmfVuyB
 eR0zxHGFKuRt8YreH7uy9/zLCDPEbBk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-Op4qeAhCOD-Kzpk3mfR0Vw-1; Mon, 01 Jun 2026 06:30:02 -0400
X-MC-Unique: Op4qeAhCOD-Kzpk3mfR0Vw-1
X-Mimecast-MFC-AGG-ID: Op4qeAhCOD-Kzpk3mfR0Vw_1780309801
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45eebc943bfso1906422f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 03:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780309801; x=1780914601;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wi97KWGdJTdWq3IdYpsAWLx4xopc99EofOMqrefmH9Q=;
 b=CCvk8guUCNqo2ReT5341GB783vqD6k1E87zzW+NvdA8nrGlqH5bz+1RP+5EiB1rs6E
 Tjv3JeiG9eeUobqiYeSfpl/qMq88mSDTIlVCO15c7tEJKW9QMmiZJaB/RIPx9fHNHR1i
 GBZcsMCTfBkBZE/ls31+U+XDDK7Mv9Dqj5vpSXc2VIZv64G7MD53kKsq+jcONpUY9ARV
 IO20Vhcj4Zxbi2v1EyLReDypwkTYq+wDqqJZ+3e1ya7aObPWXQ/o2dTpv7JzWBDm3Ave
 6fBNi9cctU58uu58fdqNg76yibLi3NtG3/YmrC7VCy0bklf6V1D9LE199i2/ecwGJRvX
 yQsQ==
X-Gm-Message-State: AOJu0YxDO0MFHsvjn9pPHzsrz9InUCrF2ooj58ivdKbymzY/3ak124dt
 STxgF7HLl5rffUtsyESIknKdy0pGeBFsfm7e0eYk8VZSpUXnlwEOyOgX5xWWeXwG/3y1xC8W4HE
 dulf5GBRSar4Lo/FC86+5h9UTtATyc3STZvi/J10Zt0okXWNkTZlnQEixwOS8MCqy6t9FZQ==
X-Gm-Gg: Acq92OHCSDAvi/njn8U9oPaupbrRq3GaW1FNz8nwRC4pW9KNjBr80y/gcqam2vXyvaO
 zN0rUjAuyKGoNQzNq3QQ1LLqInNKH2zIIcdYTedphWD0OCR+/XxUEnFQz1y7L5NuS8MQB8tL7W3
 bI41kf0AG9xV8f43+MxKegw2zUYPD8gNWKYBjQ9wUa57nh7jP80IFobpto/LftiVZ2DRHV8ERW3
 9cSb7H2JqvkAXF/6zonbJNO4VLFVH8Fg7DF5O92CQ6DEC24MJ8CMI2fd20/MK8236L2NZ4eid2U
 f8SV/RNWDk23hYb5IiKDLYjUdJndnSQFoNoyY+7/Lxjap9FVxdTL/ImlyvsqeiCHr1+Q/DT+vH7
 FCApcgsFPyb9O7P+FGCb0k55lA9Drh6Qa2+22bWgYMSSXp9ZZxandwKU/r18hMxHqbFOkagP0H/
 N4YB/3re1KIySq6Z4=
X-Received: by 2002:a05:600c:1d0f:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-490a2a22bb4mr148349615e9.6.1780309800957; 
 Mon, 01 Jun 2026 03:30:00 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0f:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-490a2a22bb4mr148349225e9.6.1780309800553; 
 Mon, 01 Jun 2026 03:30:00 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490af0babdcsm4375085e9.0.2026.06.01.03.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 03:30:00 -0700 (PDT)
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
Subject: Re: [PATCH v4 09/10] drm/damage-helper: Rename state parameters in
 damage helpers
In-Reply-To: <20260530185716.65688-10-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-10-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:29:59 +0200
Message-ID: <87bjdulfiw.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 37nzCovq2Jf5wd6AaAmrIU3d0ZQwTzcq2OIreRj8DIc_1780309801
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

> Rename some of the state parameters of the damage-helper functions to
> align them with each other and other helpers. No functional changes.
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

