Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2B2CD6E61
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 10:21:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2374A11314F;
	Mon,  1 Jun 2026 10:21:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="KjmeKrGG";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A592113150
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 10:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780309263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PtraVy72eIuUfdejQSU7WTEFINXM3tMuzrGKzIN4pEs=;
 b=KjmeKrGGw7lCPtuu1rnGdzMUPgKy2f2dJWDyJRQvO2Qcob2rE3wCN9KBPzScyaqZDSDukK
 fW/merYuxFsAevobcb/5p2NiUfM/kxTUf2cRr/Rj70M87ETVIBvpMGpEr0qMT+8D9Y3c0A
 O/uLLz37fsgO+OEZQzbulU52S8utcTk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-srCopS_9NXKbpEpQb2JvNw-1; Mon, 01 Jun 2026 06:21:00 -0400
X-MC-Unique: srCopS_9NXKbpEpQb2JvNw-1
X-Mimecast-MFC-AGG-ID: srCopS_9NXKbpEpQb2JvNw_1780309259
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490a762e646so11692805e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 03:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780309259; x=1780914059;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PtraVy72eIuUfdejQSU7WTEFINXM3tMuzrGKzIN4pEs=;
 b=HqRHpYG+SEFE/GTb49XFZcRKM3uFhf4zb82aKjSzqdGcM4TEfi0vwx5nOggGB6P024
 lhtfFt5sw2yukjTcunf2kgLgv2DrYrzUa+fFCxE4AqaCnsPI60ohoKEou91WVNpb3Plc
 9MjN/28JRZWw/anZqrJtukyVBAO7anL7rx7DWrUIVVhKfLCAzAGOWDaHG5D4TgpoAmVk
 T1BRd07NDjITNIzdXhxgyZss0yPMrGyjae7t6PlSx3/U0oQdWNWs8fhDzkJZjoVV81aZ
 XTD3O1oCEayk002qqi4NYRT1P6hJ3XAgLF5z/8HtMnA6JRdyF8qkkK0mPbnkcPz0kQF1
 mt3g==
X-Gm-Message-State: AOJu0Yy60prbYi7UHKw/r6pMOAD1j8496ImLvxjtqvt7qCtrjLrL9dsO
 mv95Oip0PZunTeE6xIJzLGW33wBfMOF7qqLP/Uym8MvkNbirQ6oDW/qVTyLfePt4NjykRmTDHjC
 oVMKofhgYww2yJ0JwL6ELvVXw9rqye8NJ6ZFiLXAyVKFwoGmhxOjoIh7igLb/BJ3uUMneWQ==
X-Gm-Gg: Acq92OEb/adzpXzz/B/CVfJ42yHdga4qag5AAR21d/AR1nnsQaoy9wdprJ4QC5s982d
 lUMAosGdZS5I/LhQ3Sfv2RuqTWerBIFDUd/c1gP3pNtZ3hV7lymYjk+Wy+pKAMbn9UCQ9x/F1Lu
 8/d6edeH+t9bm4F8Lq6jiGf3YMx+H4pa5l+h80HZzcFaEG8R0t0Xu+5jRX77z9SCbSax4N6WFQL
 usWSyltqQ+eNvnvn4xkOK23iTl5gzAggmiQivR94LjCyw3sSWnDdwIf8iQRXK/pq9Z2dIf4d89h
 k16DJyhR4sjg2J5l8fpIKR0qVaRlp5Qi48doKg1m/FBYznN+TvGLcgEfkxnoxpmhzn9+K9xpsM9
 ipW5K7rGYkGL1ophCLvy9JLwf62hM+tiMdZm4GRkICT73gJffUMfFijPOe57/+/UBQdxNggNtKg
 MKSipL5X52Y9/3KR4=
X-Received: by 2002:a05:600c:1992:b0:490:adb6:793d with SMTP id
 5b1f17b1804b1-490adb67fc0mr29782685e9.26.1780309258844; 
 Mon, 01 Jun 2026 03:20:58 -0700 (PDT)
X-Received: by 2002:a05:600c:1992:b0:490:adb6:793d with SMTP id
 5b1f17b1804b1-490adb67fc0mr29781855e9.26.1780309258391; 
 Mon, 01 Jun 2026 03:20:58 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490aeacecfasm19237985e9.4.2026.06.01.03.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 03:20:57 -0700 (PDT)
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
Subject: Re: [PATCH v4 03/10] drm/ingenic: Remove calls to
 drm_atomic_helper_check_plane_damage()
In-Reply-To: <20260530185716.65688-4-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-4-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:20:56 +0200
Message-ID: <87se76lfxz.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IYpIWGQsqy7v2hvjC7BMVFE1Xx1lUKNMatBb-PlsAMA_1780309259
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

> Atomic helpers call drm_atomic_helper_check_plane_damage() after the
> atomic_check anyway. See atomic_helper_check_planes(). Remove the calls
> from the planes' atomic_check.
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

