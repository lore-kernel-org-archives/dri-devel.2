Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AB2C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 11:18:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A31DF10F439;
	Thu, 10 Sep 2026 11:18:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Il88TLOb";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F142210F439
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 11:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789039084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FZ/vaABJSYubFY5BrcerrZEm/i8qZMA36SfngBUQr7w=;
 b=Il88TLObVbEDKjil8KGHkTXiZ1MeiBuIEBz1KKsi6QC0g6wtLrhvej5olHp5PLWFUbWGiC
 nx7luCrgHeka23O9hJZ6lonxB+u1EjCdxRx7UmJthwVw1vmPWNtDIvT/T12CIxozAyL6up
 YrT4VY82SKUjZcmcUQwXpdCreLTybUU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-aImLwZ8wPlWTZ4zKttijRg-1; Thu, 10 Sep 2026 07:18:03 -0400
X-MC-Unique: aImLwZ8wPlWTZ4zKttijRg-1
X-Mimecast-MFC-AGG-ID: aImLwZ8wPlWTZ4zKttijRg_1789039082
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4859233a9a4so3705547f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 04:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789039082; x=1789643882;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FZ/vaABJSYubFY5BrcerrZEm/i8qZMA36SfngBUQr7w=;
 b=kcloV1RUSRz3fSQL/jMwluyKZgkbZ51dzdsCR0UtZ2VmE+ekzesPbN1wQV+klL9uAg
 PtQ4BwdaGiwbS9mrl8gkzTaqmIV/GbJvPIzPTpuvFReZwbGwA8AmkaViuL00qg3S+Y2c
 QkpOv49VU8HzBLC00YOHA4cQifZbb4eESi3s51OkCeWrb5OF9cc4Q/AbNpEMpcc2sxGD
 SgNAGelb1VxOcKu3qc0Myz62BiFU91VClNrd9hEDWF3QaHhp29cgfx4LtHERt8bMD7gr
 l7SMU59/zfFOFzASZ1Z8bR0Ss4yWw47367sy0fGQ4U2UtK3kb4yUuAc3w+7OyCJ1FhXV
 0dWA==
X-Forwarded-Encrypted: i=1;
 AKwUvByACzW4b3ROThcVU2CZvV8wni0PE3zYbGYhmRtuOsPwWQW7qjwDL4S5b6UeEMC0zMpZkqnBBDerL88=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kfzCPk36xZfo6J8vWOX2JQ95ZwyiWhWedAiHP3vWDhw1MvLnKq
 2QWYkAvCzf4n3z/QmUDKS8pqSUo/9ztIEP4GlzD9CLtyDBucIdwlghMKOH1SFf2Hlk7/4IxnzIK
 rNosjdgL3EkRg/VVNvF4ZZRlYY+hgBTBAQhM2NBMQ4FiP9HObkXpjLCKvwQUG4JxdX2y40g==
X-Gm-Gg: AYBFou10PHtITc0Pn6U4//1zcoH+8tN73SOP7DuiWwntQNpFkIodbz2Qv+R0rYU/+uN
 0NCUYBUtbSl6r79RLuds9s9O9IAtkC0/++rJdhUiLhikMiQnpXzXXgtcxp6caa9XZtAfq0N8wjs
 I1rRw+ccxJOSHx7jI2jbtIrb77epP0kSuLia3mW4l+r7Hdb4iFyJlAtaAcbBbNgXnHSK0Lcmzg9
 teWsQ6RiQr/Hg+i/jRxO1/YJ8l/Ni6KXFF7G4YPZY2t98RpR0fqcXhVNaeZ1q89KN3CWeah3bjU
 0wDwz7UKf2vm4G0wUO8N7F+VKmeWUFwCARYfgPd6wSQG8xKB3PQZymKI0JwIhow6DJq3EmQiN8l
 oLcvfzqkXe+LWYx1jhkPM1k9eIWorDFazXZ3c7mi2QM4=
X-Received: by 2002:a05:6000:4911:b0:484:3310:710c with SMTP id
 ffacd0b85a97d-485aae0e2d0mr24817767f8f.24.1789039082096; 
 Thu, 10 Sep 2026 04:18:02 -0700 (PDT)
X-Received: by 2002:a05:6000:4911:b0:484:3310:710c with SMTP id
 ffacd0b85a97d-485aae0e2d0mr24817200f8f.24.1789039079463; 
 Thu, 10 Sep 2026 04:17:59 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885bbb51sm52829680f8f.30.2026.09.10.04.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 04:17:58 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>, airlied@gmail.com,
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: andriy.shevchenko@intel.com, holofermes@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: Re: [PATCH v5 4/6] drm/ssd130x: Replace positional ssd130x_spi_id[]
 initialization with C99
In-Reply-To: <20260823111959.17029-5-amit.barzilai22@gmail.com>
References: <20260823111959.17029-1-amit.barzilai22@gmail.com>
 <20260823111959.17029-5-amit.barzilai22@gmail.com>
Date: Thu, 10 Sep 2026 13:17:58 +0200
Message-ID: <87zexpl5i1.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UMDUTaT3kfIJZRGdQbqRclZhsHHefXDgSelqakyGaPU_1789039082
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

> ssd130x_spi_id[] is initialized with positional initializers, which
> easily create easy-to-miss bugs when changing the members of the target
> struct (struct spi_device_id in this example).
>
> Change this to C99 initializers to guarantee each member is initialized
> with the correct value.
>
> Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

