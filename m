Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A883C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 11:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C330410EDE6;
	Thu, 10 Sep 2026 11:22:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="OCNMzlHb";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 733E910EDE6
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 11:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789039348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VW7WG5gI3vGojP7Xj/wxG4Oo1lstFTv7nlO/pfTslGk=;
 b=OCNMzlHb7CLIbNldHDIx+qQeP0fCgpfAz0AW0BCEu4PlMNUh04R8KS/Bq13L6PsivVEkni
 lB6SCZXySXVdpyKc/CqOIhoTnJhi/gIddaqEvQZk4oWzdaOCGzppvcekYr2GP5aHggo35S
 qwWGmJfygh48ibVrVp396I7Lmt4zykw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-2t855gBPOLKNoD6lKLE27Q-1; Thu, 10 Sep 2026 07:22:27 -0400
X-MC-Unique: 2t855gBPOLKNoD6lKLE27Q-1
X-Mimecast-MFC-AGG-ID: 2t855gBPOLKNoD6lKLE27Q_1789039346
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49d156c917cso5106875e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 04:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789039346; x=1789644146;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VW7WG5gI3vGojP7Xj/wxG4Oo1lstFTv7nlO/pfTslGk=;
 b=ge9DoyYtSLLh9BDVrGkALaOUscADCi55xJpdNjdQVh5YblEujws+no7mWFOAllCDzw
 9rTohzHzEDIRoYQe5AJtu+kFLrK0rtI87xK3ehQsXdzl9+zvu2XOz2cOQ06Bp78z4mZE
 ViRUDOq2LFte0Ne7fHYMKqnlYBfRZiuaxqh4/vHPvklQrYI/S5RORtpMJgd/dKezFeI6
 4a4JVTdIumLqiKaXx+Jfo9dIrFs2/984PxiGkhUWZywrirjCwwzE9hRbd7OpaoejgaEq
 mdjgOfJ15PEVixt898S8GXRu9e90o/i5sGaRNOVLKyRywcrgM9RiactfzGZFIa8sgrxd
 3qhg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHuFcQ5jrWJAvWH/3NiI+iRZmYlOq8uuPv9vign9pRmGKifkRnkuQpzEDcC6lVNtaAr2KA2hwzjwc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l4XxQKA+7/zPemV7vNB/PqC0CXib+JXyUf+lWOw/yMRjTmVfBW
 9AM2e9EEocFcmjc2hMhq/eFG4+jtZxFFD0O0dSJh4W66UkzS4YODNCzmBqtgIzUc80nkIBKEnWs
 6HCPPQkc1Wp+A9nggn4wmQ9vCF/SQxRSoLlUGlIb/eVdcEO9/3HxbWu2SBW3lJQJLZghOJw==
X-Gm-Gg: AYBFou0nWTfBnDeo/+wullUko+zJXmUwnP1i7SZJB0S38XnI+R9BgAWM3MufGxWoaiA
 qxP62x6dCvE6mJH4Pmj4GAXH7EEeCXPk9+8LGUHlwhg223ioojfWa7zRNOHCq3FSNB7DMiV2F17
 asBSAqcfFpldbjoqfFHumkXJCmhYt4DCbF55fwtM2MVczThIVFysgZ9ze9gadzCtbLqGOuZF1dS
 nMhfuWtmQZDlWLhZLMUMjhw0nwWu6NdnC3jMffyNKUDXlWmL+EmY1ZmT4CyphSS02+mtvWD2H7D
 7XrcZCJv68jM+vn087QzElelFS6o1rukyOu+5cN8J6+ZGlkGrsHCh4ypOvyf+mWWL7ngmbv8Te+
 XT19jxX/9TbdoORQXCwdUd8txnRvLyoPlJRJUAZQwH1NTewpIDvYAe+4vfA==
X-Received: by 2002:a05:600c:164a:b0:49b:8f5e:51fb with SMTP id
 5b1f17b1804b1-49d26d863e3mr29452445e9.3.1789039346110; 
 Thu, 10 Sep 2026 04:22:26 -0700 (PDT)
X-Received: by 2002:a05:600c:164a:b0:49b:8f5e:51fb with SMTP id
 5b1f17b1804b1-49d26d863e3mr29452165e9.3.1789039345750; 
 Thu, 10 Sep 2026 04:22:25 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26be3e35sm65309185e9.2.2026.09.10.04.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 04:22:25 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>, airlied@gmail.com,
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: andriy.shevchenko@intel.com, holofermes@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: Re: [PATCH v5 5/6] drm/ssd130x: Implement ssd130x_write_cmd() on
 top of ssd130x_write_cmds()
In-Reply-To: <20260823111959.17029-6-amit.barzilai22@gmail.com>
References: <20260823111959.17029-1-amit.barzilai22@gmail.com>
 <20260823111959.17029-6-amit.barzilai22@gmail.com>
Date: Thu, 10 Sep 2026 13:22:24 +0200
Message-ID: <87wlstl5an.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _BCBiSxv4mea8gzsIYQtRPy9lnuglTftYE0AX63eFWw_1789039346
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

> ssd130x_write_cmd() and ssd130x_write_cmds() each carried their own
> regmap_write() loop over SSD13XX_COMMAND, differing only in how the caller
> supplies the bytes.
>
> Turn ssd130x_write_cmd() into a thin variadic wrapper that collects its
> arguments into a small stack buffer and defers to ssd130x_write_cmds(), and
> move the protocol comment onto the latter, which is where the loop now
> lives.
>
> No functional change: the bytes sent and the bus transactions used to send
> them are identical for every chip on both the I2C and SPI transports.
>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

