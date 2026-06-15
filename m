Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD51CD98EF
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:18:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4830810EB7A;
	Tue, 16 Jun 2026 18:18:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O1ctzvOQ";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAB9010E59A
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 18:11:13 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-45eeea039ebso2072700f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 11:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781547072; x=1782151872; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6YhHfYhZ56ymdmxnyjLOGaOGjwnoWlDkDUgcgUvLusk=;
 b=O1ctzvOQcZCIEi54hkQvJC1YBgqwJMuvzJtj2oT2EGe6ZqoXaYf/mAzOrP9Z4g8yBK
 77Qd+BurWuO0XNyhvjQ3B35OqE4m4llJD6zOswDIdKYw24vEhHm0BuqOJ0L20C7xEJit
 MiYbNjqJ5CpXkj4eNIdpKsam2lDl8+VtJnyDcE81aEHBUwLS5QrFKr1x8vKHtvaYVTER
 y4CX4uI2ppYBpbHrHFXSXGU9i2qMJCExqMSJG7WqtOeEe+ZWwRkaY1LTbTIIfrnvWQ+g
 C8agM/VeFhZr3xqaZVsntfURVNaovQpty+KwavEsWSy+9NGCitg8ODX4/RIXoRblAtEJ
 NDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781547072; x=1782151872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6YhHfYhZ56ymdmxnyjLOGaOGjwnoWlDkDUgcgUvLusk=;
 b=g7V941eO/NHS+lN7QV/hEvm93hLlzE+jiLzFtU/j1QVOtaNjfPkBMz/BxRFL4sL612
 nhZwFX5HYYUzT2EuaCuJyOyWnZJ7jar4IjcsHd8rrnUe8i0n3x7ULhdoWqSzZWIdnwTc
 V7BberM++A0CF5azqMDrpIF1sENuKurUQM9rIyEgS/1HMuoRQZ5rfVbd+z7rfKeKs4Pj
 SkVujb3NnOXQdqTujuFt/UTlyJGo5yq2rjFKhxpQjRXNA5qYnr10DdcbfTW1EyPgKnvL
 cZuT1ta31GnLdvwn68Dk8Te97ZKJpXJ7Gm3Xkb2RY3A6LUdq4wczUESxoYxMTyMTmIMJ
 JNJg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/bWZPT1se/91jPtlijma9pe7kaAfKg88b/vQI+Vtb4OwpiGiQrc17a8JKy00r33Jqt05DIe6t5ulc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5BxCMDvCAKs66AFXDXgPTORZ4WUcBQN+7N749PuPpPVTAp5Ei
 ty/Dux1+MD+mpMOLxlpm1kJvqQtmJzV9ziYCnqBRy+h3pAkb5lx3tqiaxxWN3W2Uhzw=
X-Gm-Gg: Acq92OFog3TD5A8T0XxRb97xG6jP83FijYjoo6LeZK+li/bgjfye4KRr3hQpVJ/JIdV
 +oBRpfVullWRXN/+WX5Ay4fWEzDKJEd54Fq0q4Uwb9B53l9BoiNKD3BTjlD6yuWqdfjN3x9ZmwO
 ALTqY+OQTlHYwbUrHoGzHpIFi67Md5Nyozt8rhPtPojjo9KqF+fQJTPxwPX41cg+RkxCqJtJ9Nk
 x1gNOFzVseeSl3dUma9adVROp6Wr7350gkVC4EnXSOiSY864J9kExtwpe2zlaNrB2iqBYWqYjiS
 GrISZ+GTz/8HzH8RGP6WQOhxCybENrBHlFz98FfY6tL42yxV8RQNBfSFeozhv+6D0QPhGZzY1ci
 DUhZDR4A12s9oy/qcmSnvL2Pa4RHbZArYWBaCtlRpX7g2nbriCUdu9hxdbCd4vGp4bgyiF+HovO
 w40YHFxarqFhivT4dCXURS7ysxqYM02MSLGsnB54L/
X-Received: by 2002:a05:6000:4301:b0:446:96b1:f5f with SMTP id
 ffacd0b85a97d-46074a80071mr15768412f8f.8.1781547072261; 
 Mon, 15 Jun 2026 11:11:12 -0700 (PDT)
Received: from anthony ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f263950sm37158556f8f.7.2026.06.15.11.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 11:11:11 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Amit Barzilai <amit.barzilai22@gmail.com>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, javierm@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: Add Solomon SSD1351 OLED
 controller
Date: Mon, 15 Jun 2026 21:10:44 +0300
Message-ID: <20260615181046.96655-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611-psychedelic-funky-foxhound-a8e39d@quoll>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Jun 2026 18:17:58 +0000
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

Hi Krzysztof,

Thanks for the review.

> > +  solomon,width:
> > +    default: 128
> > +
> > +  solomon,height:
> > +    default: 128
>
> Drop both - deducible from the compatible.

Done. Both are dropped in v2; solomon,ssd-common.yaml already declares them
(as optional) and the driver supplies the 128x128 default from its
device_info.

> > +  rotation: true
>
> Either drop or reference panel-common (if this is a panel) or at least
> reference that property:
> $ref: /schemas/display/panel/panel-common.yaml#/properties/rotation

Dropped in v2. Rotation is being removed from the driver, so the property has
no consumer.

> > +            reset-gpios = <&gpio2 7>;
> > +            dc-gpios = <&gpio2 8>;
>
> Use proper defines for GPIO flags

Done. v2 includes <dt-bindings/gpio/gpio.h> and uses GPIO_ACTIVE_LOW for
reset-gpios (the SSD1351 reset is active-low) and GPIO_ACTIVE_HIGH for
dc-gpios.

I'm sending v2 as a standalone binding patch so it can land independently of
the driver, which is being reworked separately. dt_binding_check passes
cleanly.

Thanks,
Amit
