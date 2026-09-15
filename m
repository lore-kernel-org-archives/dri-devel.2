Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20873C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 09:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51AE610FAB2;
	Tue, 15 Sep 2026 09:29:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="S77wop7s";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C27510FAB2
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 09:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789464596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JxQVVIN2vgNGlG34iIszUNjCMcsm+xG11qyEVEg3u8k=;
 b=S77wop7sxWic2TqkMyJFC55KhMJ0ysr9XJL3MB3O8e1IWgGzOfO+mAejynq9rMVSGTPQtk
 GfaajNXsHYNNaRzHC/ofGD7WXYRupDz0wVkkYrac4GnBBR7XwLNIP0SZhNqWcS3/FU4EHm
 g56Ne+u+cMpNF2XocEPVVaJEGOpotBc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-eaR24sNYPnq4MOZOvMVUXQ-1; Tue, 15 Sep 2026 05:29:54 -0400
X-MC-Unique: eaR24sNYPnq4MOZOvMVUXQ-1
X-Mimecast-MFC-AGG-ID: eaR24sNYPnq4MOZOvMVUXQ_1789464593
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2db87f759c5so74243585ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 02:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789464593; x=1790069393;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JxQVVIN2vgNGlG34iIszUNjCMcsm+xG11qyEVEg3u8k=;
 b=PE4lMwQpz+jk0jMgBaLPkNfahGM8YSbTQtMJwPbkc59/+snDLEy6Sqxq4BEXpM+vOy
 /vMxjUoGUr3QNFdTB5bvuHSfOhrI97tiGBjnPFlvN1NuW+6VVo1O2r3maT7kgGrQh5Da
 1cLvl5INZ3u6T1A3yRgZQJ+q0OtdEw7a7TwfYRz/rA3cXEr2zDTkBXOxlUgDC7F6XbV0
 GDgNsfF26GdTENI18tPkMXgXgbDaHAK0ttWbBdPNv+cbjKRhRCbUX6EjPbSxdm7KL/dO
 3CjPSoRQxHoEwpUuEFCJgacg864Vv8sZLndKUJnb8XL+RuYCpSZQEBmg9hd41oMq6IcP
 CP/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFtfxXaM9BXxuoDQV5WZcjAtheRtb66CO+vSG/6gsXWiydBFRBKOR/uCr3ebVfZxhaQkpUcUsEt94=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nKf06RKBfsSOMWBLEPb93oSCiZ6d/QM4XYAzBKdgOOeXP/3+lr
 jPkz1F3Wy02wrYCwhEVdSTsuXYmBnzVVYwVAWNwG5G02rv5QbjBvmwQkEyZDPMR8B9S9crUisWZ
 QncoTper0/fZ4rtPSP8wfdpCIzcky7KRrqIl5nYuE4bIqo1YrkBn/uraYuadXxsWUlefSeMjH6D
 2lIXf1zBH/p4RXErmNnCGf34kuVGhGaSUYGx0fesL714KK
X-Gm-Gg: AYBFou3SAZkxc0MAZ6aB1OwAAFahVdux81U4w82kI3BilKskdNsQx87OKne3GADvQmy
 FMrRUpNzxgZL1s2YCsCq3ISFlgxKp4PPT98tVPmhoWmgB/5px1+FC4/MGjT+Z2jqGlYg63CFKlo
 r81QhYxVyurbcC99goLaN6Xn0L7JfNb1Lv+uSunKXnozbspfDs8kDALPzu
X-Received: by 2002:a17:902:f712:b0:2db:20fa:9443 with SMTP id
 d9443c01a7336-2dd6c6db8c2mr129948165ad.13.1789464593186; 
 Tue, 15 Sep 2026 02:29:53 -0700 (PDT)
X-Received: by 2002:a17:902:f712:b0:2db:20fa:9443 with SMTP id
 d9443c01a7336-2dd6c6db8c2mr129947705ad.13.1789464592762; Tue, 15 Sep 2026
 02:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
 <20260907-drm-state-readout-v5-3-5fa1ac7a5148@kernel.org>
In-Reply-To: <20260907-drm-state-readout-v5-3-5fa1ac7a5148@kernel.org>
From: Javier Martinez Canillas <javierm@redhat.com>
Date: Tue, 15 Sep 2026 11:29:41 +0200
X-Gm-Features: AcwNN1WokIm0tvX7l7jim_s7gTEWEuYZjHFv7hn9sDMmg1QKJuIOA8RTz6Zp58s
Message-ID: <CAFOAJEeoMO7V9xnnby0MFVNpH1ymaCDwGCOcJAGjpe2AfEtLqQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/33] drm/atomic: Convert drm_priv_to_bridge_state to
 container_of_const
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MwVHoMMBvEoFB3EHPOnw7oo2cxj-4G0lWqNYLIFU5t0_1789464593
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hello Maxime,

On Mon, Sep 7, 2026 at 3:24=E2=80=AFPM Maxime Ripard <mripard@kernel.org> w=
rote:
>
> container_of_const is more flexible than container_of when
> it comes to mixing pointers constness. Switch to it.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

