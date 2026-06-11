Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8705CCD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D85EE10E0F8;
	Thu, 11 Jun 2026 09:45:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="PH1Eipba";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1821310E0F8
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 09:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781171151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4ty/4n6l1g5FwMH6wZXov57APeLPygvD8X6jtVzY5k0=;
 b=PH1Eipba8sj2e8zESJJiqOTpAo/C/XCFVBImnEyVHU2pMMyMr5lnZydTNeF1+kYWwSUkz9
 ZrZuK9gcZqzj0u0MR9s/md+IBRWGy7Ec7d+QzK5VejAeKeL2nRN6rQw9I4bUc2kiWNEOLb
 Q8kiOxGxR8WzmrvKt4FFrUzI86YT3+o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-jCcz_fliODet_WRaA_kRnQ-1; Thu, 11 Jun 2026 05:45:49 -0400
X-MC-Unique: jCcz_fliODet_WRaA_kRnQ-1
X-Mimecast-MFC-AGG-ID: jCcz_fliODet_WRaA_kRnQ_1781171149
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45eee3f9f03so7437217f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 02:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781171149; x=1781775949;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4ty/4n6l1g5FwMH6wZXov57APeLPygvD8X6jtVzY5k0=;
 b=YZn4BvRg1mxx/P27VESr4yOhdaDyQD3GTpVykXewj+2tIj3WUyC1wAU2TzOKZjzk9h
 YpujKHxhzLKP0eafM8IH/sTgGKFIVpdBuAKFzBrQL/YrN0lC+kMK+PoBLKTnbIFLBr+K
 1zyWGG9wXYKLV3umc2vXyiRgni9MNYjIJSO2KXjL6IWqhWwcmqSFI49idTp31LJ/86Lu
 gunxPvRbD7Hy7fprIFZ5ZG3xHIdNQgG0d9/MWvG3ejoqyUJm0u4/Yd0lGDfmy/8iH03G
 IxTRsbmVksHvkR6JMcvCA4EcpY3hOmvcYptucVFCRCW96La83uZQZwM47Setwen+SpuT
 A6EQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+98C9Mls6gRaNjd40IMX/YHvkxNg4O1vA8xxLS542bIZZYaABqtdJphRRaVM9tGqOoQHD3oWNk8UY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNsChEUYCZ+rqvXr/V1jkHNIdByYdIgCeehChQN/v7inRNz++C
 BJxyOOmshWXU5kVDS25vBihSTQigs6DBN40l1GL3NlWIyWDg1TOZegK5T898XmjapxnhuY3+4tP
 RMkXvYVJBvpg7O+bZiGS/tN+YsdPKUenfHxi7R2DOmE5sj7g8Hroh92Pn4NFF3KdceBX11A==
X-Gm-Gg: Acq92OHGCgaUQENiB2KCSBiaEX5dAdm+ke1eQMSS5IW+6A1TuOaSNG5yiYliNo7sU/p
 dGrQj3yVOlC4kHKKoeZPGQHWM3AD15cmzGHzRTzGBIh5YfpkYHRySn9ydM9UX/OuSPNrnKQ5s/A
 qpHXawCI5vSndnPRcIRiNGLsIs4uXIVJHR4D3taExKnU/W8AjPfsn2HkHcqHk15PqNLNUZ8M5gh
 fs6WosJGxrdDLRJ7BiDJFwduSh/rV9O/R4lKLwjJjkdURmJX/tFhPhdJaquQETIO+/GY6t5f6ZB
 ENn435yueovHl8lXB12PHa27ANWQxciiIgeO1BKs4p7TiZ1S5NgP5R9BNb9+fm6z22TNp4EC2Cj
 5cLMk4YctnVh/qQEMzc1CzfNf3gWFSgzQLAMUt+fRgyhfC93j1hqk1Hi/fVO4wmKzeKcJCDUWhQ
 9ziGsN4pt2LRUujQE=
X-Received: by 2002:a05:600c:3104:b0:490:bad9:de43 with SMTP id
 5b1f17b1804b1-490e537bf76mr24986065e9.0.1781171148707; 
 Thu, 11 Jun 2026 02:45:48 -0700 (PDT)
X-Received: by 2002:a05:600c:3104:b0:490:bad9:de43 with SMTP id
 5b1f17b1804b1-490e537bf76mr24985515e9.0.1781171148210; 
 Thu, 11 Jun 2026 02:45:48 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2d046d5sm50817795e9.13.2026.06.11.02.45.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 02:45:47 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: Add Solomon SSD1351 OLED
 controller
In-Reply-To: <20260610164428.180091-2-amit.barzilai22@gmail.com>
References: <20260610164428.180091-1-amit.barzilai22@gmail.com>
 <20260610164428.180091-2-amit.barzilai22@gmail.com>
Date: Thu, 11 Jun 2026 11:45:46 +0200
Message-ID: <874ij976lx.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pBYuyte54JX5g2rH0jBtk3nGRX_WddA2K3hwQT6O_D4_1781171149
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

> Add a device tree binding for the Solomon SSD1351, a 128x128 65k-color
> RGB OLED display controller driven over a 4-wire SPI bus. The binding
> builds on the shared solomon,ssd-common.yaml properties already used by
> the other Solomon display controllers.
>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
> ---

The binding schema looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

