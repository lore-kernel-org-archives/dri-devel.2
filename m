Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A20BC5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 13:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F12410E1FE;
	Fri, 31 Jul 2026 13:02:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="anwmx18Q";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 548E110E1FE
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 13:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785502963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=63z+74IiNXo7CtWiuSgL8tkqVXTD4W+l7gvHsFCZ+/I=;
 b=anwmx18Qw8L8a13qXSoIirE9R0iGUZ3EAA2iGG+WawzB3YS8rct2m5A+cmbUV1CRFy3BEG
 DxUmFZQTj6jOwcrrM9BXTN/URqe8QyQlPtHVDhHN8cRNTMQvcpOs3g7RSEC+fYegG3OAve
 J9hiCK+Z3krALqzfPj2Bsxqq+Os+f8A=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-uqkH7888NTOjtQJpuJSIGw-1; Fri, 31 Jul 2026 09:02:41 -0400
X-MC-Unique: uqkH7888NTOjtQJpuJSIGw-1
X-Mimecast-MFC-AGG-ID: uqkH7888NTOjtQJpuJSIGw_1785502961
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c16711b9473so86417566b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785502961; x=1786107761;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=63z+74IiNXo7CtWiuSgL8tkqVXTD4W+l7gvHsFCZ+/I=;
 b=Okm4u2AMVYS2AsBvh7VrQ3Q71aE9ABNKPr/gFKDlLW4dfE8YlVEUqsEN7p9FwHK+72
 oFoojYBAQTnY68N55RFQGzGLRaN3quto1z8ZmQlqk+0rFj4F2ZPo4KhkETXJMlUJS09Z
 DbC6y6jY3hOJ6lnBId40vXeoYqYw5CIyyfr16psvVrtHiIrsmvPrenKhI9BA+DrgjYmp
 fTRLAArylQtnDWUKRAQXSv38B60lRh+SB265UlznYg6DLVXp4aIMqHsSNGMWvxyzaQew
 tceLcnvM77FruclXBGacFa0YFeKoJvy1GdWtGMRX0dfWHJ/Hatq6iKyiZTx8633LGyMk
 AKTA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr7kPF1PZDstKsqeo/v4rXcEgZbVEU5AhLWnLqFvqEfhO6pN4jUvXhxJwyDXI4fixlyiQ83dHp8zKw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy1FKyFgQOmMI816jX3QlGjREapXXvPdiw7UnjbbOp20aamuYEe
 c0dyYn1vzK+G9gTfoCJjSoch4DYGjHc8Zho1ZD9OYL5NVcqFZXh4feN3AFs680K6ZRiEmi0g+MK
 MCpU8gVLaB+V993mjUpY6QJmljXWRfaSpR92W6CRuf/01iIvx1wgmq4fT2DPgDlvcXlR7jg==
X-Gm-Gg: AR+sD12QLJylmmLn0ca18U7qVapfhrw9czEHNQ3z7sI/JAcdmsQKtmLwxazbtMkVT7y
 9tk0JHHJereYPWBof2xpaEx59Mwe3y11BWHENt2NgkRGE4W9AIyay5YjFcRRYQFvwyU2IRawjOh
 cFe2jPV+5TTuj2us8jRJ0q1u7e4gSvChMXC76K1VCjL3tZ+oWqR7YmUnVF8j+T4T78yX1VKg8Gb
 Xei9ZnWoFMle6VXtSyRoHLqD45aixcU8ilv7e+qXxZdqJF3FvrZpxyKTzYMLz/vXgEqkTjn+Klh
 UcHJrjJ9q6/jbtfLx+UhQH2J6q4U8hzoID2voCcztCBeV32TovMAmMk6LexW+mPgWtKyJvgNSxu
 MZGOpxPS8eReTIeuPuNugYSXFCe29f0FWynvFAI4hdgFrufpC1KRlaiRXP8s=
X-Received: by 2002:a17:907:3e90:b0:c16:8adf:f183 with SMTP id
 a640c23a62f3a-c1fd23c59c7mr119264566b.14.1785502960609; 
 Fri, 31 Jul 2026 06:02:40 -0700 (PDT)
X-Received: by 2002:a17:907:3e90:b0:c16:8adf:f183 with SMTP id
 a640c23a62f3a-c1fd23c59c7mr119260966b.14.1785502960034; 
 Fri, 31 Jul 2026 06:02:40 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd4562a38sm4399507f8f.21.2026.07.31.06.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 06:02:38 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jakub Turek <jakub.turek@elsta.tech>, Helge Deller <deller@gmx.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Jakub Turek
 <jakub.turek@elsta.tech>
Subject: Re: [PATCH 1/2] fbdev: ssd1307fb: add support for Sino Wealth
 SH1107 controller
In-Reply-To: <20260731-feat-sh1107-v1-1-e10977f76e6b@elsta.tech>
References: <20260731-feat-sh1107-v1-0-e10977f76e6b@elsta.tech>
 <20260731-feat-sh1107-v1-1-e10977f76e6b@elsta.tech>
Date: Fri, 31 Jul 2026 15:02:36 +0200
Message-ID: <871pcje2hf.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8qgN83E1il3qP54LA4yKJx1ojTS4siMHz5xpT3KE-_8_1785502961
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

Jakub Turek <jakub.turek@elsta.tech> writes:

Hello Jakub,

> The SH1107 display controller is very similar to SSD1307 but the main
> difference is that SH1107 has different memory layout and uses page mode
> adressation only.
>
> The SH1107 relies primarily on vertical page addressing mode where the
> internal 128x128 GDDRAM is split into 16 vertical pages, rather than
> the horizontal/tile addressing modes natively utilized by the
> SSD1306/SSD1307.
>
> Signed-off-by: Jakub Turek  <jakub.turek@elsta.tech>
> ---


The fbdev driver is obsolete and likely to be removed soon. Instead please
use the KMS driver (drivers/gpu/drm/solomon/ssd130x*). This already has
support for the sh1106, so adding ssh1307 support should be trivial

(basically just adding an entry to the device ID tables I believe).

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

