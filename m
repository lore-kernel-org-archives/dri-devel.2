Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EE8C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:37:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4C8F10ED09;
	Wed, 19 Aug 2026 06:37:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="Eb8+/amy";
	dkim-atps=neutral
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com
 [74.125.224.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2778E10E3CA
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 21:34:33 +0000 (UTC)
Received: by mail-yx1-f54.google.com with SMTP id
 956f58d0204a3-66c67a73eb7so547549d50.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:34:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787002472; cv=none;
 d=google.com; s=arc-20260327;
 b=Ltzcg29dTw/FvnRrnnT8qPnhkjJyXVp642ZHmOMvUaNkhob6p28Hb/atyuGXMA2X9Y
 aAsfPDd7EXcZjKCD22b3vHDHjJQGh0y9NOYmOMQnuI+7ynE8J6O3uf/Kt59OXUwsQoGs
 KudhF5dtARs1L0rcMqXmdOUU97O/t1SfB0h17ZySeVixm3Ls69BdD9ebltqPospA/NR1
 7Pu1lzFiehhiEr/EhCwekYBQEOKMHXbxfbZyiCX4KA18Qhc84qQUqiLcSqgm7AWfPBkE
 oIWyWFBhLv+HDUPEMAgRfGB/OpN5FHdCHP0+kot+TD/OLTkoOy3DUscpWhae0Z5i5V2e
 JezA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=epwU7jREk7vRi+ttZATQY88mwFXUAqQ//0r/cT3c4p8=;
 fh=X/CioH1563EVfK3RTUgzuXrvKEqLJjT7c1gUFny+bCA=;
 b=bsRTpP9WupU7iyZgGWeR93X/cnm1bT9mpqXjVWAIhPC1Vh+DbXmwy5IW2CPxu7gMLw
 qcv1rbiY0dB06FHHzZiQEqjplB1krvJgPbkRFg1JiPuioZCAn4BQ1y5Il2v+JfMjGXqR
 2g0S+Sg3vGUovrfPekmJBpIi++BkuiBDRtuWbybHA650w9vzy3yW0p+rv7cuW0tkKdgf
 SRNoYwnp4UB5kqfV23LkLYwvcYCpKhxv804oriWLej75ElcaSLimTIEwpBBq/ck+vVbr
 cN6/txNN70j7o1Vg13LaIu6O6qmIRX9kpD4PLk863VMNbaE3QLLOVToZAKR1DKeSvcYw
 DsdQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1787002472;
 x=1787607272; darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=epwU7jREk7vRi+ttZATQY88mwFXUAqQ//0r/cT3c4p8=;
 b=Eb8+/amyfw7YaD6Bhvqjjq31JQunRXkFXdDkAdpPn6nQ0zMJMXKSYAZO5uNQF9VDsz
 iSD/P4o66pKtFMDsBAGIz7W53HIan8vcxXU9ednZKeIJ7BnZUH1d743P981XPYvWPsLK
 ZzbbzaR1JnX9F6LxNd/Kvz2FK80OFkTtmFtinNm6tTiGb3gcG8ZFgn5Tr4puhU7aa/8S
 4jJm/InA99oSvqQgeMKbB3Syu4/0OTw4XVAQ0r59eoeMDJxw47aAQ0DbV/8oaxcO3w84
 rOv1Q7a5JSV3CnpXmsmsZZPaPkC1wRJTewxLv6viB/C4liVypSX8yCjVG7yYi+ssk3U5
 kotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787002472; x=1787607272;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=epwU7jREk7vRi+ttZATQY88mwFXUAqQ//0r/cT3c4p8=;
 b=kyeeaJw7VOOnTv4R2Gs2GexTtF5e4zWNQkEoS3CjLKoBpHvGCBJQ3QrX92Q5ZWRAY7
 ERL1Q1ovqOTuW7IVWiVyGJIcotSuBD8PkFJR1Y3Kc52kvcntAuKOVrqxpxj+SEY9Va2h
 phRpyHteFU+5a5a1pvMoyZXd4AYRIDraMsX2ERuljryhVrDeD24/O16rf3Q86erFgAFS
 x05fzjerJ2rsNdsVWekBwre5JWx8m3/mbRMi3n0256E3tJpofyq2i7DK4tzL9cuS51Nb
 6/GYLMEJ9whXtj4xSazt8KL5S275KB5m89BGD0O93YiwZamkyfPhnU+AtszHFiSFjLYm
 S1Ug==
X-Forwarded-Encrypted: i=1;
 AHgh+RrjvObDTE3PiKTPp454yoxjQUPapWzD/5sBKly/eVyLZ0/+QjzG1SCVMWcHYzVs0J+3LZUQkq6LZbI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRgo9TBzq7ylfK6BcHQZN9nl0sW4cnV9PZYbi6cPSFsL/A7M2F
 rZuUvts4LinSCYuaNeMmEPobPl98VWfCs4A/8ZRLmT1SqM5ywE85Rbhi1O7I/avcW7MZmHkrKDQ
 GhlifVM9OAdU/ZiBQBjXc1Ghrj8ZpT3RYcUcSMn+r
X-Gm-Gg: AR+sD13U6nO4dtKnDvcRPPYGRdSMgT/VJot09g/IUrfs+2X+pxhuGta8uvuqQfVRMvm
 /24zVBEbhxmnFkOj2hBuyYW+vnuPNMS70VHcG/ybrGYfD59HBV+u7k5HKAZhcvXoeFYOyAwNaVD
 /KQI8eYl9ZxKbSt2lt8WsvK+ICRejXPG0MhuE57QQiSxribcvY0GaAG0nne9GTAqJetSU8lMR06
 xbfat3QCSYpkBBP6mvW86oJi5Xv/nDProodi9/DE8RkxzmVWcJloN0amU8/g23LM2MdSmz9gEwg
 vaVcqBr9AYHqmfHJCozx9vSajZDmAB/QxrDCjJT3gMbU0X+CLE+h5wyQB8HnYR9LCvhsTCTe
X-Received: by 2002:a53:4903:0:b0:66c:72e8:c224 with SMTP id
 956f58d0204a3-66cbc0dc3e3mr563068d50.5.1787002472110; Mon, 17 Aug 2026
 14:34:32 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 17 Aug 2026 14:34:31 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 17 Aug 2026 14:34:31 -0700
MIME-Version: 1.0
In-Reply-To: <CABtds-0YAuFxEOUREOCOB2HErVp8h+dkhMwTj2ZrQqh_dGHMTw@mail.gmail.com>
References: <CABtds-0YAuFxEOUREOCOB2HErVp8h+dkhMwTj2ZrQqh_dGHMTw@mail.gmail.com>
From: Sean Rhodes <sean@starlabs.systems>
Date: Mon, 17 Aug 2026 14:34:31 -0700
X-Gm-Features: AcwNN1WvdC1G44iZL28Kx9gAhqGc2MgHY5_ATU13fLffGtrrj5IDQreS1lxgkL8
Message-ID: <CABtds-3HCx6Z5whZ+T5F=5CwxkcKze-WhS_t3qA3Bmy99i79Jg@mail.gmail.com>
Subject: Re: [PATCH v13 0/5] coreboot CFR firmware attributes
To: chrome-platform@lists.linux.dev
Cc: corentin.chary@gmail.com, luke@ljones.dev, denis.benato@linux.dev, 
 hansg@kernel.org, ilpo.jarvinen@linux.intel.com, prasanth.ksr@dell.com, 
 jorge.lopez2@hp.com, mpearson-lenovo@squebb.ca, derekjohn.clark@gmail.com, 
 josh@joshuagrisham.com, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 florian.fainelli@broadcom.com, chenhuacai@kernel.org, mst@redhat.com, 
 wenst@chromium.org, tzungbi@kernel.org, briannorris@chromium.org, 
 jwerner@chromium.org, tzimmermann@suse.de, javierm@redhat.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com, 
 simona@ffwll.ch, krzysztof.kozlowski@oss.qualcomm.com, andersson@kernel.org, 
 geert@linux-m68k.org, dmitry.baryshkov@oss.qualcomm.com, arnd@arndb.de, 
 ebiggers@kernel.org, luca.weiss@fairphone.com, michal.simek@amd.com, 
 sven@kernel.org, u.kleine-koenig@baylibre.com, bhelgaas@google.com, 
 dakr@kernel.org, o-takashi@sakamocchi.jp, titouan.ameline@gmail.com, 
 kees@kernel.org, dri-devel@lists.freedesktop.org, oliver@liuxiaozhen.dev
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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

Please ignore this v13 thread. The send path corrupted several inline
patch bodies.

I will resend the same patch content as [PATCH v13 RESEND] once I have
a working patch-safe SMTP path.
