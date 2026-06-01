Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3633CD6E62
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 10:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16812113155;
	Mon,  1 Jun 2026 10:22:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="CaQVv14w";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B436910E75A
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 10:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780309348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UYSWdrjn4aqQxQd0Cf2jKHSTVgv+zTIrZalUlPmgVOc=;
 b=CaQVv14wRdxlJkibxmWhSACvsqIjgObNYqQ7nWJbZWRNQi/9GUIrfryQIQ2kfhTKbumXA/
 ALV+UOQ8MKUGH0DNogkqJbcv+Ub3Kw17tfJaUIbK4Ch7U/W0t0Z1nQe8IuudVKIAZ3lM2a
 xfx3HIbdemwneie7PxKe57nWEh9UAmo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-82N-j0l7NZqr6LfZoqONdg-1; Mon, 01 Jun 2026 06:22:27 -0400
X-MC-Unique: 82N-j0l7NZqr6LfZoqONdg-1
X-Mimecast-MFC-AGG-ID: 82N-j0l7NZqr6LfZoqONdg_1780309347
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490af284fd8so1141605e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 03:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780309346; x=1780914146;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UYSWdrjn4aqQxQd0Cf2jKHSTVgv+zTIrZalUlPmgVOc=;
 b=fKoL8N5MvqRV4IsZGxZbh5jNcTP+1Vk+l0HKqPfjrNClbTP0D1r4oyUeZhvHoVZade
 YMU9sZ9elwT7bvbJC0vI6VGPt7VlotJLF9EvAF86KucB14fLiz7fo+Q70JKbSJNwPqbs
 Hl0KNu1fe6QpJe8bqO8pnrvK+IV0UurMgs0XGRpLgPg0n1kIORzFrgPer7TI76+3u9og
 NSNO//Ou0Ux06ZTYAqggBcISPa/QSLpxPzG11+4oRRHsD9n1wSb65EFrFn1Kk7Nws/0t
 OrpAQdtjli85Nmg4UV83E033flRdVTggyPyBDX2ZXLxlbhM9hppzuc2mgP6YuHrIfSUG
 74mQ==
X-Gm-Message-State: AOJu0YxpmeeHnVOLwxYqloe5oj66kh+ph7M48TqQg2HtsZCxYdZ/pePR
 h0pwxmPOMMYhB2XMvu79p6WhY7mfLsh+3MphEISPxqIekCjFnThSlPoBFfxjSO40V68MdPI9ktS
 Szm5lbe7dw/tXvGRHyvkWzSf9/hYIs1fCsTRUjSngEDBZglftIJnV8VQcg7PUcXoHfDjodA==
X-Gm-Gg: Acq92OHllCKFVAFRKzwhhDy9ktqCSdT5opCWs6NL3YrLhkQe2tZ7HRSPUuAh8k4ER0a
 0XOc1yKrLpKEHBa+Acl4h3I23+ik7HI28TtWFpT7rkx1vTY/30KFK+MgObU9fa8tapmxda4WpQ+
 4/PvPafdFGIBGq2l1/8GOE3lkpPwkxsycTz9jQAuGiuBq1QANTM3nDqvt54PlRvPfzCL5CGpMC2
 TbVd/xYw435+6mVw2A2BoKk7t6STXJGGyB6eqikT6BvEh2YwprDl9NdT9fo5MMbSFD4zuUp1UpA
 By92oc/cXDBdV6IcGvE2mBU45XrknSo9PTgtPpvweF9gYxrgLV80E6ve2xcQ4U4bwydLVFl69ES
 LIxv041T83EtsMiPgKSzCuwPLJOsXHR6m7lx9C2BFaBI2r3waDeOF9E2VCYD/e+9rnH33uRikGS
 jCUPbueques0nW9OA=
X-Received: by 2002:a05:600d:848c:10b0:490:a1a9:4ffe with SMTP id
 5b1f17b1804b1-490a291197bmr137427785e9.12.1780309346510; 
 Mon, 01 Jun 2026 03:22:26 -0700 (PDT)
X-Received: by 2002:a05:600d:848c:10b0:490:a1a9:4ffe with SMTP id
 5b1f17b1804b1-490a291197bmr137427265e9.12.1780309346037; 
 Mon, 01 Jun 2026 03:22:26 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490aaebf4f1sm74962075e9.12.2026.06.01.03.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 03:22:25 -0700 (PDT)
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
Subject: Re: [PATCH v4 05/10] drm/atomic_helper: Do not evaluate plane
 damage before atomic_check
In-Reply-To: <20260530185716.65688-6-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-6-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:22:24 +0200
Message-ID: <87mrxelfvj.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aZgxWkAyOOyv89pMweEMdYu7a6frT-wVBNu-VNx7lTE_1780309347
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

> Remove the call to drm_atomic_helper_check_plane_damage() from before
> calling the atomic_check helpers. The call has no longer any purpose,
> as the actual evaluation happens after running atomic_check.
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

