Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56814CD6E60
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 10:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1B00113173;
	Mon,  1 Jun 2026 10:29:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Qlw8b3A/";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7F23113173
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 10:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780309778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NR4sOBYtM0bZ0iqX/XjOc3nz+SGcL1hWjzs/0wJdl4Y=;
 b=Qlw8b3A/dyMNtwjUtT2EeM0hwpaXtbeIj3w1susS90xIQ5dG74BA2ZOv7fXivBHuf+VXcI
 oHtuAJFwH8Ilksv5iHjf6eeh8UHUjql5qAY2D7H6n+vIrZ0x8twVewonyrhgocyeinydyw
 AsRYhDa5UJ3NeI1c21iZFphlbWrIdBE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-khZNp5lFN-yy-rVF16iYjg-1; Mon, 01 Jun 2026 06:29:34 -0400
X-MC-Unique: khZNp5lFN-yy-rVF16iYjg-1
X-Mimecast-MFC-AGG-ID: khZNp5lFN-yy-rVF16iYjg_1780309774
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45efa12a788so1030397f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 03:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780309773; x=1780914573;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NR4sOBYtM0bZ0iqX/XjOc3nz+SGcL1hWjzs/0wJdl4Y=;
 b=AwonpyZF3JTZybUwQnPAALY5+Z1nWUMiOzVcyYXc+bhcQq6T+c/BKCl2BzV7sCHVKp
 gszQkmlHuiWzAEum7S0T/YI2Hs8P8JU9ijxP2BPzoaTZIesczG+gv6O8RuTlU+0eiwTC
 cDAmaFgPnoJ5tES9+RO6k0pjf0tuKQooW97wdtJmg8r8tc7io2BjFKwd6hl6QZVaigy6
 ptEjuDVLFeWay8sTWnGfn/UysllJP51Ul7oiSyFc2UeaY0s4ORYMWGjtvZpGroPBCmBf
 IvM3lcCPj4VpWXqRy/BGTCkTReCoWV/OTQlUieV5yfc1k5KyxqCQrn296UCsywl1K7Q3
 e9qA==
X-Gm-Message-State: AOJu0Yx67QHF2DyY1NZUby/HRsknl9Bu5YSXw6QAF1i74HQAoOD3sncc
 psmnWPiYdNkCcl3wj3jlqUrjeVM+vkc5JNae6epx428j7eblNR4r0g7W8Xe/lDxq2ZffjNev15z
 U5jNSmr68sgJuIp1yMwcaVBg6HajSKU+aLM32/jodMxIv/FtVCj2y12zg9tnUgr/48Gz8Hw==
X-Gm-Gg: Acq92OGqptTthPfu9NxiwRW/KrvYOf10X8v28pr1p/X3FdI7rOzFnPCYaEFDN4zbVmI
 a/YLyww2+GE/WQB9aDneqiwWaizgxv6uFisV/JkDMmpBQBfkb2CVpjl2Mw84q+rt6VAcl8Ith8r
 b5t1aaP20o98fiHuwaQONNgXKURyRWuhgaq3JLnzj3N0F95THKccKzHNMoeGDGMzh2TDjSCCoKt
 LI9sxgG5JLnjZnv/wrZMdIuK+KtLx00OO61gqbH/kFswHZ2pB4nzR0AvXQEUEADN1VbcKXLrRQc
 TYtBc5h47J+OsfvNQYOUUIFgjxE6zsp/8J/WRUCz7o6BrNTd/6bBKKd4RdFSXvsh5bb/C7+ilCj
 8xSULI1q4t8ExGKKrZRy16+OomuwGTw5l2FhxRJpzzWlOF1hPxa7XT985P+QJVV9DQUpZQ0sSU2
 2R3xRRiSryKK166yk=
X-Received: by 2002:a05:600d:8444:20b0:490:44eb:c1d9 with SMTP id
 5b1f17b1804b1-490a2947c86mr142088475e9.28.1780309773584; 
 Mon, 01 Jun 2026 03:29:33 -0700 (PDT)
X-Received: by 2002:a05:600d:8444:20b0:490:44eb:c1d9 with SMTP id
 5b1f17b1804b1-490a2947c86mr142087935e9.28.1780309773155; 
 Mon, 01 Jun 2026 03:29:33 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34a037fsm25007994f8f.4.2026.06.01.03.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 03:29:32 -0700 (PDT)
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
Subject: Re: [PATCH v4 08/10] drm/damage-helper: Remove old state from
 drm_atomic_helper_damage_merged()
In-Reply-To: <20260530185716.65688-9-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-9-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:29:31 +0200
Message-ID: <87eciqlfjo.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FbGsqI8wYLo4vUGkSINfLSJD_Gt2-rWZuqpabe9f2PM_1780309774
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

> Nothing in drm_atomic_helper_damage_merged() requires the old
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

