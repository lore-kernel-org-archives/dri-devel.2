Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21752CC6B30
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 787981122C8;
	Thu, 15 Oct 2026 10:48:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 481671122C4
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792061320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0vP2T14fdZ9XceyUCbSqZEpcWzH3VTeyPfkjXOwntFs=;
 b=L48KIk6kfaSzjn+3Bi6ys16usgiqXMsSNH47RRyKO/S/ksH87ois7a2hNhVPrersTwl7Nj
 xbP+uFliFfuzTDW4VlhuifO+7Iyu9acJLV5AOgjEYy6glrl4BDt8xZx6yjZASnzJnDfXTn
 6Qa5UYQTf002GAN7HDhyfo7hffBtL70=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-_Hx_cXgaPueW_C_7TJMSig-1; Thu, 15 Oct 2026 10:48:37 +0000
X-MC-Unique: _Hx_cXgaPueW_C_7TJMSig-1
X-Mimecast-MFC-AGG-ID: _Hx_cXgaPueW_C_7TJMSig_1792061316
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a1813fea7dso75847605e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 03:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061316; x=1792666116;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0vP2T14fdZ9XceyUCbSqZEpcWzH3VTeyPfkjXOwntFs=;
 b=biC1Oyv8Pl4cUpR/4L/nI6gBqTZkTnadXAanIeaYjwumCMrWAdMKlj6axNb4R4eDHE
 B53am6kKrq/N5IyWJFydp1aKtEYeT63vaR1/bopTl/PwB8Vrq+SlLf/JJta8/b1lhd3+
 kcG3uC9v5aUwoa7FsD/YyEymRMspJbWOh+ROnr9eK7wM1CmP2/k45MufCIq0VtXUfXx4
 GXijWiFJzVvO4W+PXNO4bP2MKqYdSRuvnKBYW4h8nrFIgwiYVqoHcXp9nZh5u4kAijY5
 6HES1Gg2ipYzk8LImtPatT6TphHIdczej7K151b+MbGZD2xpwVE8msjQYwv1SE90It3V
 LqRA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwX+PBQ46ZXkco2MjNj9DVM8iSm2jcdrOqZKyKfpov7r62SIZxX6ukQCi/FvWoWbbT26M7qTUpWzmI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLiqxLV3aC2KOTOiYvyI0hfeBDfOldOKCIOJLtDYHCYhSnxS8dE
 O4EV82k7HQ9n44HHIQg1JHn5Wm/xCZHtF2X1KEqMGoBuRIHlz8f+8CWVudSFhSpIEnsirmCX7Fx
 /7zb8woiS6jSAp7N+Qbt+YfhBFuad+sdKOrehxdENjIxlmE6JLLsjprDGx2cqGsUYN7wkcg==
X-Gm-Gg: AYBFou2BU7yu8SvJ++IEI4cVn3TGElS/hpxsdlpaWKXW8UvZ4QD22Bdm+9PCPSQ1zLl
 y/lr17KeT2DyvGktIzXXh7ul4SHZCfnxDqpT+IQNV17KEx3oR2uvw/Qy2r+SIEatOnoNVrF7iLi
 +A9DNN3dEMKWo0l4Z2KmH1LJB0OF3S13FzM0FS9rI9yUpw5HAXLm0kB91K4B9WSlGddfzRLbXHR
 97z3jtJBhuf9dN94ADKxb/ToUBMUA5lP12Bv3XdQmiiWO/x3UaSmDdENtfWnys5s2p6nRAJGZCs
 cS4f7LiHDMzUt5oFxdWtuP6sNMoSf+ZBXxBQ1axVN2U53OVPFPbJSDgHMp5C+vm7ZSTfBl7opDd
 xKeXx7pZqvYc2D48On/8m5rcYKjDLygyBOaB7Mr0+Yd25lSYtgUSDrusNbnps4rb6Dg==
X-Received: by 2002:a05:600c:6285:b0:4a1:70da:3350 with SMTP id
 5b1f17b1804b1-4a18e4b8c6emr349772725e9.32.1792061315938; 
 Thu, 15 Oct 2026 03:48:35 -0700 (PDT)
X-Received: by 2002:a05:600c:6285:b0:4a1:70da:3350 with SMTP id
 5b1f17b1804b1-4a18e4b8c6emr349772275e9.32.1792061315579; 
 Thu, 15 Oct 2026 03:48:35 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9b303csm58389045e9.8.2026.10.15.03.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:48:34 -0700 (PDT)
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
Subject: Re: [PATCH 2/3] drm/bridge: ite-it66121: log an error if the IDs do
 not match
In-Reply-To: <20261015-drm-ite-it66121-log-probe-errors-v1-2-7fd6994e0be0@bootlin.com>
References: <20261015-drm-ite-it66121-log-probe-errors-v1-0-7fd6994e0be0@bootlin.com>
 <20261015-drm-ite-it66121-log-probe-errors-v1-2-7fd6994e0be0@bootlin.com>
Date: Thu, 15 Oct 2026 12:48:33 +0200
Message-ID: <xlv1v773fddq.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZHC8-kCzg1ZH1pX8KBc2AWogsTXUF8kHtdTXCmrkMSM_1792061316
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

> If the IDs read from the chip do not match any of the known models,
> it66121_probe() fails silently, making troubleshooting unnecessarily
> difficult. Log an error to clarify the failure reason, showing the IDs read
> from the hardware.
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

