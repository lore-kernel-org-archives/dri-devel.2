Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EFCCD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 09:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8231D10E9E4;
	Tue, 12 May 2026 09:24:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="G5T4Ec5T";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42D4510E9EA
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 09:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778577868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M2jTkG6krSvGgEmmvUb0pId6kP5wDNo5oVW+s4FpOVw=;
 b=G5T4Ec5TZEFkuuHsl9o1RBN615KD7HoJuvXXzJPW4hd69X5BrPjivkDJfR79DCBiDGAhVc
 7rSB292nEYNh2ZFZWqTjhxqoaqYEgKjts5s8J/poQEVmQ2MeVXwN8pGcwUTfPTyGSmNKoh
 k2YtpRNusmRFSbWSp5eYIGsQIXhJvkM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-ERfF-tbHO--ahf8Ge1n0pw-1; Tue, 12 May 2026 05:24:26 -0400
X-MC-Unique: ERfF-tbHO--ahf8Ge1n0pw-1
X-Mimecast-MFC-AGG-ID: ERfF-tbHO--ahf8Ge1n0pw_1778577864
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48d121738feso45889375e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 02:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778577863; x=1779182663;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M2jTkG6krSvGgEmmvUb0pId6kP5wDNo5oVW+s4FpOVw=;
 b=tOF2ZOhjrt6rZvHk7iQFZIUDo9lAfR46xkX7W82MUb2qXkfE+Yn1GvzK8xmttcRekx
 RBHYwhJlaCzyn2rnleUJAwSgFkFpvC0SX8vTmLGc82RAppGwvPf9KASGB2m3xlHrVKwq
 Eolkf2OUTKXUXL43rw6BSNggZix/IYpb9Ob2T500UQ9UjQQMWycpqkCV6Zt6BsnmEnny
 3Q3iUaqmPKwMAEGnrFJKkykQeGJ30oA9pVy7ZrYcB3h0+mo6uuRM7wu20RGGY4FyQwlk
 ZLPnvkgddjeX9e5oISfIUSBKaLNJ5rulfw4xg6XsHyYmXho4vOpjfm2g4QrY24LsOrT4
 bjnQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+XHudfwrNhnjm6y/XlbqdmT9zxWEv+lGoN97tsUYZCwgaU9PAG+i5vJnC93xeoJwzRy8SXt3MTPxw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGr1/hFZHkMEFEOzRKarmHl76gnnUmNeZwST1D7i1aVmSwFuEl
 mbo+RZLVsaNDEvbFGTYy4x7xnIR5mNulZXRqm7A84eY731EMb1s/gRWZTXO4JNdtakbbfZwITl7
 wzuR7i/pvKYE5vp+LD8TilIrh+lxlToVn9k7gAxOhbleqmOTp2OWyydq3sIfa4Pe01RrjqQ==
X-Gm-Gg: Acq92OGTUS6G77F0qS2/MgYo88jWlDN1xka4AmIpk1krmQsSPyJiLbyiXL22/Zwu62F
 hFRgNB2/shZuqL+R6Lq9ghMLJNzl2cK8Z5naoh77YQmbVaL2f4pjzLS8g5j+kknvpbqMEXjhZkx
 h9Zg5Mm/AKX0eSBWiIESYqEM2x66Cko0w6ltIJRw8SnAMeox/ug+WKkuiyMZ5vRoBBExvZD9s8x
 Bejw1EQgVHe4U6KNX4XGJBrgR2wXvkLu0Uv56gfbP2Uc5V9Agd2xt/qXzPPn7FmJepycx9oS7sV
 xTAsxgmxFUdHDnzxypK19L/gktqrNxo8fmxL23NRe/5vT1Go+uRTWoTRzZ4Up3ExyELWrdZZ8Tm
 Oj1CEx6cBIYOkOpm26V8539tWmM3WXdNfdWzTCb1Vj7hcISdt1mQd1E3RzvDpVK5DfbP8jRi3Y5
 il0BLN
X-Received: by 2002:a05:600c:6299:b0:486:d76c:fa57 with SMTP id
 5b1f17b1804b1-48e706f11d0mr217927895e9.17.1778577863497; 
 Tue, 12 May 2026 02:24:23 -0700 (PDT)
X-Received: by 2002:a05:600c:6299:b0:486:d76c:fa57 with SMTP id
 5b1f17b1804b1-48e706f11d0mr217927445e9.17.1778577863063; 
 Tue, 12 May 2026 02:24:23 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e90536122sm35232405e9.4.2026.05.12.02.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 02:24:22 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 David Airlie <airlied@gmail.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Phong LE <ple@baylibre.com>, Robert Foss
 <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann
 <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/3] drm/bridge: it66121: Select HDMI or DVI mode based
 on sink type
In-Reply-To: <20260511-gentle-grouse-of-growth-3ac263@houat>
References: <20260510191459.90769-1-javierm@redhat.com>
 <20260510191459.90769-4-javierm@redhat.com>
 <20260511-spiritual-unique-uakari-5ffce7@houat>
 <877bpayuw7.fsf@ocarina.mail-host-address-is-not-set>
 <20260511-gentle-grouse-of-growth-3ac263@houat>
Date: Tue, 12 May 2026 11:24:20 +0200
Message-ID: <87zf25x9ob.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5zs5TQ-Gc_mG5y4NT9ElhazkC9xXPX-zjFgK7Q_lm5w_1778577864
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

Maxime Ripard <mripard@kernel.org> writes:

Hello Maxime,

> Hi,
>
> On Mon, May 11, 2026 at 02:48:24PM +0200, Javier Martinez Canillas wrote:

[...]

>> 
>> I wrongly thought that couldn't get that info from it66121_bridge_mode_set()
>> so I thought about making it a property of the bridge atomic state.
>> 
>> But I see now that the connector is already stored in struct it66121_ctx *ctx
>> so the fix indeed becomes even more trivial.
>
> Actually, there's something super fishy there.
>
> ctx->connector is stored only at atomic_enable time, but you'd be using
> ctx->it at modeset time which is kind of decorelated to atomic_enable,
> ctx->can be called multiple times, etc.
>

Your intuition was correct! The driver has a bug and ctx->connector seems
to always be NULL because .mode_set is called before .atomic_enable, which
is where the ctx->connector is being set.

> It seems to be already used, so it probably works, but I don't think the
> framework provides that guarantee.
>

It seems to work just because drm_hdmi_avi_infoframe_from_display_mode()
allows the connector argument to be NULL, is just that the VIC data is not
sent in the AVI infoframes if I understood correctly.

I'll work on a v3 that moves the TX mode and AVI infoframes enable/disable
to the .atomic_enable callback which I see is what other bridge drivers do
(e.g,: sii902x).

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

