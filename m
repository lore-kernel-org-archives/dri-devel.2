Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE09CD98CF
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 08:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C377D10E882;
	Tue, 16 Jun 2026 08:39:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="UIgmhiZq";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A966810E8FD
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 08:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781599148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rWhHVjmNBxttchA8qHW+tZDgQHHXjvRil6qjeh9Uq5k=;
 b=UIgmhiZqnjjIOxU3+Hp18GP4nhFEAbgzL0m48KHbwi7DS+EnW61uf8MI4vQhskHhrKfo/T
 Y4S7+zF8sYLPD5IloMLUOXxQ+x2WfEFw6XjMNJhY+yTsSoelvBbbGI75USaQ674kGqmR+C
 eOoeO4cgCiLdvoG4+aIdHrS2tEvZoWA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-aYYGROAaMluqmKi8_LDtkw-1; Tue, 16 Jun 2026 04:39:07 -0400
X-MC-Unique: aYYGROAaMluqmKi8_LDtkw-1
X-Mimecast-MFC-AGG-ID: aYYGROAaMluqmKi8_LDtkw_1781599146
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45efa7755faso1776458f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 01:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781599146; x=1782203946;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rWhHVjmNBxttchA8qHW+tZDgQHHXjvRil6qjeh9Uq5k=;
 b=q1hpXc5KZJvBOlnw7B7YlMvepq/MRWr81B3XQCSszUUfbRrUYZkTQWhuCIblHBy1Ah
 CRIXL4mcHcGNzzRaXqFCICh962SdA69EzXMaacxZgXvdE91HyYj+mv2LICKU/Ua/frH9
 VYVIQAlzukpYLl2lg795qqQztxEb2f1C5AMJt06vX2gYlPGXAOosv4LHLbF9H5tOm6dh
 3+/sTPlFlA8ZhCofJv8KYMt2B0duYJ6sxJ5VOfK1hvDyZ8gcbpTLB4UxIW/Wt5XbLxhr
 J6MKkJGK8cWa9mFBy9oSgdRHU+ZtzSJgVdsTlgYwwwTEIQ6w0JzJnd3TvOoJ5Twioez/
 P0oQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Wac1AEpH48MeBD0ZR0ojlUtxx61zYU3KVPMzwLYTr4uwjxzZBnPF1MdgaMk+gtW26aGJH6ut3uOU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywhv9jhaU51ed/C9B8BHOeSQsmIrNBhKWXiY598Ya2G8j/cbp9w
 fPMDOfzpMTbL09OxTpu2PwSVXbbf0OTIXwFWtzAyWHbWrsECKcuA7wnGHvxMErNN8iHmTWP7NBS
 3PXIQkLhpDaC5jk8pYw6zW9BG4M/tPquwJUXPaFta4Wnn7Su6cSU/N+ru+GY6TkIIxIiEwQ==
X-Gm-Gg: Acq92OHHNtuAZCLEu39JNBv8g/TSUHpYHHQFz7cXc9LDwknywyeUW2N7XYcA1mZxWpK
 YcsDszuTBnZ7NgptnmDpZgv3gDCotTR24ehT6d5NcbaTYyreLMhc7sVDJ3WKBY63iA5B24ZA59N
 4CeIx2ktzdZVyMAQOrUbD1gxpAvRobrh8XUKzxedvJYwSQipEAkz1UW9qa3TtsTz/fG23+JCz55
 NBEf6UtXTjkrVpIPt9JGBg0/y8RBrPz7zjLAr5zjZgNfqMphaNo3YSSKPMOpsR2JDdsnRo8b5Cs
 CJSW5tZNpT7H6g9ZEGF5870H04VA1IS6IhhUdT1UdnaQclt7ThnapY6O6r3agDI9+AM9REOkYkV
 1tjMfbdBJWnxkaJHEa0O+PHmSzXP7D7UhzEEhdyje9qCHEcSjpKT2NXOdoIYXKhx2ZVCUhEFRub
 GwXgts
X-Received: by 2002:a05:6000:2584:b0:45f:f142:d563 with SMTP id
 ffacd0b85a97d-46074a62560mr19589172f8f.16.1781599145932; 
 Tue, 16 Jun 2026 01:39:05 -0700 (PDT)
X-Received: by 2002:a05:6000:2584:b0:45f:f142:d563 with SMTP id
 ffacd0b85a97d-46074a62560mr19589127f8f.16.1781599145498; 
 Tue, 16 Jun 2026 01:39:05 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f263945sm43464472f8f.8.2026.06.16.01.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 01:39:04 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 tzimmermann@suse.de, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: display: Add Solomon SSD1351 OLED
 controller
In-Reply-To: <20260615175620.88828-1-amit.barzilai22@gmail.com>
References: <20260615175620.88828-1-amit.barzilai22@gmail.com>
Date: Tue, 16 Jun 2026 10:39:03 +0200
Message-ID: <87jyryzxp4.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: atyMcJ8h4boIVbJ9xCHtPrQY7sSPXyl9q7xWAplo2TM_1781599146
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

Hello Amit,

> Add a device tree binding for the Solomon SSD1351, a 128x128 65k-color
> RGB OLED display controller driven over a 4-wire SPI bus. The binding
> builds on the shared solomon,ssd-common.yaml properties already used by
> the other Solomon display controllers.
>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
> ---
> Changes since v1:
> - Drop solomon,width / solomon,height: both are deducible from the
>   compatible and are already declared (as optional) by the referenced
>   solomon,ssd-common.yaml, so a local override is unnecessary.
> - Drop the rotation property: it has no consumer (rotation is being removed from the driver).
> - Use dt-bindings/gpio/gpio.h flag defines in the example
>   (reset-gpios active-low, dc-gpios active-high).
>
>  .../bindings/display/solomon,ssd1351.yaml     | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd1351.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1351.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1351.yaml
> new file mode 100644
> index 000000000000..39622d74a41d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd1351.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/solomon,ssd1351.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Solomon SSD1351 OLED Display Controller
> +
> +maintainers:
> +  - Amit Barzilai <amit.barzilai22@gmail.com>
> +

Feel free to add me as a maintainer of this binding too since I
maintain the ssd130x driver.

It looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

