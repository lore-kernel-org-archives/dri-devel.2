Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E26CD6E51
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 11:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A255C10FDC4;
	Fri, 29 May 2026 11:40:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="TFo/d8B8";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E2C210FDB6
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 11:40:36 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49039a8851fso82195915e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 04:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780054835; x=1780659635;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UdoH9v2264a88kp9dYn9Bs+q1THx8Q+a+wHVLI7diCc=;
 b=TFo/d8B8IeUDELVONWJqT8pgFLpaP6yfvQJbMwjRni1cNFVvQvcEpwzDfXRlEHR+Qt
 JmSrxv+2GDCgalL6PE+bz4E/7DXnZ8aKGeYGdiHcaNLNlRtbYTDzou3n5VNBRCGPjjWI
 mA6dsDRiXRXKiWvUH3X9eXJeu65cFc3hX+SSvT+Bf5xG3OizGZYgTDwP3lXDDrrh1kEt
 aRIZL40zfir45ODgj1k3g/7FgtvGHmDznVYPffwVvoXLiqBTHUTPGqXGJd7qOY+6tBwO
 4gN4pqYtLMhMCcAVTi5ODlqsokjhlHTx8Os0sdoSnEN0IIyJLqcCILrVT+VNt599J5+m
 vbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780054835; x=1780659635;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UdoH9v2264a88kp9dYn9Bs+q1THx8Q+a+wHVLI7diCc=;
 b=kMCI4Yfg1vhjp5uoeiimwWLc0XgAkeZBjKboWJvF7Na9i3AKgBywX2lfhCcXZAo0wH
 mf2bOhHQbxt7ppTXGeFSrQSTD2v4pvPQG2kBbiT7ZsBHTf+358UeeFb+K7T7EtzzlKH2
 RRSAo27pgZXPRD4jR/jFh6fg17LZKC/SdNHXOMie9T8DqnXeojGVBOJC6XaAlqjvxLfJ
 aVOLJ7UU28vKIgzl+enI2TMPITgSe09W40G8KfNLaJrGJg+5lNCL0Vp+IEklXEgh7esl
 436niumSqpO3cmuNGHUz5+JER1k2z9tf8U+npc+LeLgau2hMeuj/h2k5UY8m8lLjBe5U
 +8+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Lij6f1bPn+wb3g/lFHrZSxXygpLM8k4SHvtqlD5BMa35Y/qtm+hGJ5gSUZrLrWr5EQdfKu7oV5VM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+7WgRbZC1ySokV9jXYXiGQumXJQGx3QEW7RBh4Jlqor2HTe4f
 efD5cLc0Fte4LqxeHNv1vqzvyfgIdXS+e/ZSKVFYZ7A+KD0B38sWdR/CG7m+vc2EgoY=
X-Gm-Gg: Acq92OGCQlYSOp5uFfjAAqmgOstZduoDN62Fy0PuseoD8PuU4N8d3X23v7QDhkbDdUp
 2vocXJ+d8iemIOlOMRGLRp4m4Qsk+z4wvSWgJ0+eAbUP6Jlzs6EGWmWbe61viW3b+vz6z9BDl0H
 krBac48Jr2vcGWEY8QJPkGpCKSZfqGvUJsYEIM/WPgFO0akFj42TFVuMKnzfPp2RFSSAHmWKzdx
 B0FiMlpuEvHercpIen4kTJdlaK1krbWK1SQQzorosTusipCRPqWLj8L+Acz1/4X+TPp19ahOqZl
 EZYucfHGDHPAAZU8aDCu/yd24J4otwVK5o+q7IbGOPlleHRQx9fXlVLHmgedXx9sXg9WizFTeaX
 2g9cYQltaj60Vbi1ahdmf71y/r971hlS2sPA/ufMDnH1ouRF5vbAbcxg/rrzl55KFEvOPkaJ7Hc
 GU3eJxvq1lpMvFLMTRyyFjrzyLMPsGXVZvVyIXf3Tb39VbTmpBVqncRJvNoAy6a1ssbOAohSZyG
 Ph7TNTCySoE8kaVuOqUrJEjD0/f+0E7oRxi83yDGHq+/6lhvfVmEzPRx7A/w7f7wlRs/LLnm6Zn
 cgp7dqvxXt6YR2GpPmo=
X-Received: by 2002:a05:600c:1d0f:b0:490:3d2e:b67d with SMTP id
 5b1f17b1804b1-4909c0c598cmr48050845e9.30.1780054834629; 
 Fri, 29 May 2026 04:40:34 -0700 (PDT)
Received: from aspen.lan
 (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c6319ddsm41281115e9.0.2026.05.29.04.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:40:34 -0700 (PDT)
Date: Fri, 29 May 2026 12:40:32 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 5/6] video: backlight: lm3533_bl: Set initial mapping
 mode from DT
Message-ID: <ahl7MKBzUhmgdj8b@aspen.lan>
References: <20260528135123.103745-1-clamor95@gmail.com>
 <20260528135123.103745-6-clamor95@gmail.com>
 <ahl0La8OQHXAlV3m@aspen.lan>
 <CAPVz0n0kpYBACOo=YyNk31KGwBEoyrf+dii8V6QY4iRCGd2PNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n0kpYBACOo=YyNk31KGwBEoyrf+dii8V6QY4iRCGd2PNQ@mail.gmail.com>
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

On Fri, May 29, 2026 at 02:17:00PM +0300, Svyatoslav Ryhel wrote:
> пт, 29 трав. 2026 р. о 14:10 Daniel Thompson <daniel@riscstar.com> пише:
> >
> > On Thu, May 28, 2026 at 04:51:22PM +0300, Svyatoslav Ryhel wrote:
> > > Add support to obtain the initial mapping mode from DT instead of leaving
> > > it unconfigured. Additionally, update the linear sysfs code, which uses a
> > > similar coding pattern.
> >
> > Words like "additionally" in a patch description can be a sign the patch
> > should actually be two patches. In this case the patch would be a lot
> > easier to read if you cleaned up the linear sysfs code (patch N) and then
> > added the new DT logic (patch N+1).
> >
>
> I looked into this in reverse. My goal was to add DT logic I don't
> case how sysfs works. My code matched with what sysfs does I just
> included sysfs change as well. I might better drop sysfs changes
> entirely since with such pace this patchset will inflate from 6 to 15
> and beyond.

Not sure about that. The clean up is good and introducing the new
BIT(2 * n + 1) macro does need to be used pervasively or there's no
point in adding it.


Daniel.
