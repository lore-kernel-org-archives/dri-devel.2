Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACA6CC6B30
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BE121122CA;
	Thu, 15 Oct 2026 10:49:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC3441122C9
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792061333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cdVLMAZy6yX+rhcPQgA+e1xHnyjEu1yIo4gqZ1n+w9E=;
 b=QfoNsspfJ9srtkjjI5NlZWv4AAax3ZjfVlWLJMyf47lDoOpY7VP3a499JbZXlNhW+w4+B6
 4ZT0urqMOZkQbS35uyWMcEs09o1CwVUyf9t9GyxhER2r+0HkzgwOwfAaOkN5ZXkSa10P9I
 elmdVulVzXWLii8r00M7ZG3jgwZEM90=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-lHgfhiooM4WKQkjusHtLIw-1; Thu, 15 Oct 2026 10:48:51 +0000
X-MC-Unique: lHgfhiooM4WKQkjusHtLIw-1
X-Mimecast-MFC-AGG-ID: lHgfhiooM4WKQkjusHtLIw_1792061330
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48c437ae81eso1032183f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 03:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061330; x=1792666130;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cdVLMAZy6yX+rhcPQgA+e1xHnyjEu1yIo4gqZ1n+w9E=;
 b=irNfrn45G7qyMaGG4UHktUoVO+hrUIHS9Ya1/bdfH/FOe615shFdT8C0lRAFRZnxmu
 YrbxoIO44MTezCfTZIYlsUZOmuR9VaoBx46N1DdiEF1mJgnr94h4SYbvC2zfwLtEkV5+
 LexBUZsbbkGBSxRPkaoiuPpf2cJI0rkBoTIE1Qnuv75QOS0Dq7b99g7/FBIM7aU85fEF
 piZrFMQ6SPZcS7ufR/Be/+kzWGvMyixAKUsJoXyImT1VrNRNnrqIMDUUtx1GMd1OFbYF
 K6toBSExf1+2fTWHshjwwYWfh/tG6grSmNTe8djwIzIlbis28gFcYFKfkvPkCeyOvZg8
 9O1g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGdI2z0Bzox1ocPVAqqSaBVS/cU/6KIXn4rj3fr2ONL5iZ/28DS7b7O2nY7cNgaji5v93pqcL8yvY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLq0HofmboiiS4dVlc6S1DaLN+cgTY8AAnNGWQMcc8g9OidGdFB
 9iy9XhEmY35tokQu4Ihb7IarhH5HgvOZBT4bCLCzNflvcxLx3/oEUJjpfmO9ZQA5KmmsnMxxc8X
 IQMYrhGiei7wSkFkhyLJGe/wkyjiwPKvC3fiKxU42lbPBTRDx9J88KH3Q1FrjmtU5r5vUTw==
X-Gm-Gg: AYBFou1Z/asYOPFVnDg03WX57KzDg2Az4wDYutxVdDgt+LL6MxmZdS3R2LX6lrXZP16
 k1OToSk7/jEI8LGI6c3X3o4J088eocDmlpx+Y24dA2K/RUP3DP5rd4medzoK1/D0HGHTSTq6Os3
 C99HZMPDHYrI+FIVPI8TbMVS5bz1O1GtqcmRctB5ZaBLZTtOkJZX6aewyOW7d7dp/qi06bc4v3X
 zgvAjVGM1mn/pp+B0ezJ0IaHxA6P/RVirP8l5rZPTPtqOMLUHNIKjI6zxbywFk5t8aKVNpnxWdL
 pRZoMMGpDg4817O8XtBqJrHQG+/7wPWxQFhthPcsjGT5xDBew/uuN9UXPCcoVNzxJwrU6Zy5NDC
 WriCppKgWS7RB8i75d7LbFQaHfbv88zQj6kDyxGjObC6JZGWfHWi2tx8rOWoLZc5VCA==
X-Received: by 2002:a05:6000:26c7:b0:48d:f851:ee5f with SMTP id
 ffacd0b85a97d-48df851f00dmr1880331f8f.24.1792061330376; 
 Thu, 15 Oct 2026 03:48:50 -0700 (PDT)
X-Received: by 2002:a05:6000:26c7:b0:48d:f851:ee5f with SMTP id
 ffacd0b85a97d-48df851f00dmr1880255f8f.24.1792061329842; 
 Thu, 15 Oct 2026 03:48:49 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df50bd11asm3806219f8f.8.2026.10.15.03.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:48:48 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Phong LE <ple@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Julien
 Chauveau <chauveau.julien@gmail.com>
Cc: Paul Cercueil <paul.cercueil@bootlin.com>, Nishanth Menon <nm@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Luca
 Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 3/3] drm/bridge: ite-it66121: make successful probe quiet
In-Reply-To: <20261015-drm-ite-it66121-log-probe-errors-v1-3-7fd6994e0be0@bootlin.com>
References: <20261015-drm-ite-it66121-log-probe-errors-v1-0-7fd6994e0be0@bootlin.com>
 <20261015-drm-ite-it66121-log-probe-errors-v1-3-7fd6994e0be0@bootlin.com>
Date: Thu, 15 Oct 2026 12:48:47 +0200
Message-ID: <xlv1se27fddc.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UA1QEBIuAFAKHdtk0QddUBHvIUNZsF6e8tKnYA-ph44_1792061330
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

Luca Ceresoli <luca.ceresoli@bootlin.com> writes:

> When drivers are working properly they should be quiet. Turn the dev_info()
> into a dev_dbg(). While there, also make it more informative.
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---



-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

