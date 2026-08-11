Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D00FC5B572
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 15:27:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B47B10E2CF;
	Tue, 11 Aug 2026 15:27:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="boCXwWeY";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3A5F10E2CF
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 15:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786462075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6kwd0bEG7+XhPxSy7B5DvZm3DqbYegYdcfaB0byDAlo=;
 b=boCXwWeYWkvlDpkQ45MNHOoOZgtEz1v67bB/aEPaFQy1cSpmGYFsOey4H1wPGE0zgLVVug
 7+iP6M1iqhm8DaYg8EZoQVcLyarAM2ydaL0evw3yPkZbu8oPAbKwCUwQ2MizRJO9GGwm8M
 REGGh/b+2fJsjRzePHsXSRU4/W1F3Es=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-yxHsiexnMTOeCh7cmnvrCQ-1; Tue, 11 Aug 2026 11:27:54 -0400
X-MC-Unique: yxHsiexnMTOeCh7cmnvrCQ-1
X-Mimecast-MFC-AGG-ID: yxHsiexnMTOeCh7cmnvrCQ_1786462073
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e475f83a2so5297638a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 08:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786462073; x=1787066873;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6kwd0bEG7+XhPxSy7B5DvZm3DqbYegYdcfaB0byDAlo=;
 b=U3wvFn5upBIcaJSnbGBG0jlyJOhZYQleR1bAyztgO1RWIRMXy92DCp+lZrFlqsIpSP
 c+zbrv0Et2EXJdsAqQVOMlIVkXsUUA20OLt1eNPMnVA6gWgUYLhVxamlwqOhciT3e8Ie
 wNUPb6WdQ4n6EZdNe7rTnW95tHV0me6jk64dXN6/Y3bt13c5DeAGsuWTZf5r12dgTpKX
 EDyojb3BdpJ4mnk9z8hfNAlJ9AJch6QADnPEv139cEWTNi/IcT0URljfeQwvqV5kO+UD
 fx/TqRuMnHoDJ7xHL5mEM35gUZ5xEdxb4Bajmx61ovbX1InUOaL88Lagtm8zC5Ma/bDy
 Lnag==
X-Forwarded-Encrypted: i=1;
 AHgh+RqubkeDGSB1RJNB1UyUEdHZZ2aOhTG0YpDGCKF50cE78rFTKzbIhC7PS0X6Z5jB3nHP8RD337DO0NU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxOsLAfaylOHk/hy2ZktrJOb7uFoT4guSg3fPudapbfku7zcYy
 mZ9IrYvu1ZYrqVrqMx01qqdC0Yvr97QW0pXOJvG+Mo+7+COLN2XyE/P7/6FQBDefDJLh/HaISym
 gcwOOxpUhsAGbfX4/OOlVe5pz1bAxLSjTO6s8JAk3Hf8p5sy67kDv7fHNyinM3wJpa1DaGQ==
X-Gm-Gg: AR+sD10ydss5pFndezO24AXPxYAC+DISXRLzDhyZd4NUUgX2HIkirBWBQJVaoLlYgN7
 m0BSsL5i2O65HF2Nmdby5n/gcMKdEWc0M7wTtU6OjEBlkJgGp+v8XHD/8qvkoWKWTTWukI7L8C6
 5xDoXo0YJxI6WQcPlYjK/GI0+wIuNLamu7odPGhFfx1WFQTm89ala4d+pvOdkqM3AIp644vzpGw
 K9gA6HSFwYV5OqY/vci2rkc+4gw1tJkSSyKNM8QB3RxN1ZOBRP6Xoo8/iscP/aHk/3o5oY9pq01
 485BTzwx47fHbixnXqb+nC6vaAQEhM1xzfzpdCJvf07CmuAT6Xfs68GCIDTt0FHx3lXDjq2Nk2T
 OYF+suwXQeJGEZN5cCuIhjCmHRxR0Xg==
X-Received: by 2002:a17:90b:498f:b0:38e:4114:d8c7 with SMTP id
 98e67ed59e1d1-392ec0ee846mr4700865a91.0.1786462073256; 
 Tue, 11 Aug 2026 08:27:53 -0700 (PDT)
X-Received: by 2002:a17:90b:498f:b0:38e:4114:d8c7 with SMTP id
 98e67ed59e1d1-392ec0ee846mr4700800a91.0.1786462072747; 
 Tue, 11 Aug 2026 08:27:52 -0700 (PDT)
Received: from localhost ([181.122.135.46]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14124451180sm541021c88.1.2026.08.11.08.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 08:27:52 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Ondrej Jirman
 <megi@xff.cz>, Michael Trimarchi <michael@amarulasolutions.com>, Michael
 Walle <mwalle@kernel.org>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: Re: [PATCH 4/6] drm/panel: Use devm_mipi_dsi_attach in Himax and
 Ilitek panels
In-Reply-To: <20260811151000.75038-5-osama.abdelkader@gmail.com>
References: <20260811151000.75038-1-osama.abdelkader@gmail.com>
 <20260811151000.75038-5-osama.abdelkader@gmail.com>
Date: Tue, 11 Aug 2026 17:27:49 +0200
Message-ID: <8733wkpthm.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HyfDm5edzzCoK_RVIzP9eRoDRDBcg_RXCgPzCwmlmzE_1786462073
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

Osama Abdelkader <osama.abdelkader@gmail.com> writes:

Hello Osama,

> Use the managed MIPI DSI attach helper in Himax and Ilitek panel drivers and drop the corresponding manual detach calls from remove paths.

Please break these at 74 characters max.

> ---
>  drivers/gpu/drm/panel/panel-himax-hx83102.c       | 7 +------
>  drivers/gpu/drm/panel/panel-himax-hx83112a.c      | 8 +-------

You are missing a Signed-off-by tag.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

