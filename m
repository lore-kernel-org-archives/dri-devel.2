Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75A7CA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 344C310E6D9;
	Tue, 29 Sep 2026 07:56:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="QFe/6gBz";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC4FA10E6D9
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 07:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790668558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RTJ7TuOM9LkPJunaWpeCcattfbluIgbJm2Adgvc46zA=;
 b=QFe/6gBzFuc+XqWjyQ4UHHj5MNYd5nY1wwrGFbHxJsdZPswNvKMSawZxnvfzIYOYnf4KKS
 TzQhxl23NVbrGV9ykJyF8GDZW0ZZjlczmgNvB4jRDIGhIfnAvZ1QouwKXLbNpOVrcnQJxG
 j9SR8GGnpnIIWDxT5k8rjuBI794u7ZM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-4zjMKT5XM7qBWz4EZQRR4Q-1; Tue, 29 Sep 2026 03:55:57 -0400
X-MC-Unique: 4zjMKT5XM7qBWz4EZQRR4Q-1
X-Mimecast-MFC-AGG-ID: 4zjMKT5XM7qBWz4EZQRR4Q_1790668556
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-486f9d150c3so2169676f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 00:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790668556; x=1791273356;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RTJ7TuOM9LkPJunaWpeCcattfbluIgbJm2Adgvc46zA=;
 b=x5eUvN+C/5Ag5ZIJDEvoPcvU+hW4IiTmHo5/HRjQBwRLBzo+NaVba2B6dhOt0qWQug
 dzkMjzYt5a/HfsvYJgZzePp5FWqUA7iUhr5EtK9jfOpiVkztLVSQcopZtRoqAWYpLsX1
 cP86X7mSK8PKyCeYsbt/e4jVHT4dJ0yDu/5bXsND+MRoTWZ9T6ADj4pvy37+YyT5ci4v
 erGW9CcE/MUkbSgiVOkJOAEL79vEWxGtY+t0hMo/3Khd9I2UUuz1HRhZThYzB3ZowQ19
 VRwivdtnp2X/Q6yXB7/Xo6e5jZdwtkUFhOm6/6HTzyBfAU0486buULdlZ5U8vzgDMWoN
 5qUg==
X-Forwarded-Encrypted: i=1;
 AKwUvBye9V3h8x9rzEV1aNiD8LHixMq2BBU2/XMauRLw4vrdZATMAoJc1dGZ+ThMeCATvPYPagiwoaAhX4s=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL8hzqunwZRQfDfU+NqCk+Em8tiiccSg44ryxWpIHcs61Gm+hqz
 Ze9Y7cjU+JEuiFvRqAi3j7YCxwcJvsxgjcp9/e5AyibWNlShx4m2HUyMcgEJLTfhTCqUtumXGod
 nnc9rEwR2x7zcdmPYK8yg4C3bAMAgWvuQD11rfEWHlgSCkADSGcps27JVNTKfLrZc+OTwGw==
X-Gm-Gg: AYBFou3MF7RLMfXDGXgIcOFogqffCeChSWNYYmkCGGcr0oJwP4F8tOaDaDFQeN83yXi
 A9ELGe2aZVWQPPJ0wcgLojXkvfu9Ftn/rfJJ4JE8JWxtz+wisv1rUH5HOfiUaLpPPluQZm/u6k7
 2TE0HPicJTnyxKzuxrU7fcfe1Zmr4kUBaRbvGRD0rIsmE3O8kKpjEvSubZfAcpTVKJoX9vuNHk1
 EbcLbit2csVEt3Ic3Li7uhNgwcRPsSUSr49Ay3p4/jRada6OyfOCxYfn9aW+1KmSlFFeoSe5BoD
 aALVr22mnETBjkQwFjm38RbpOR7vrt/6zmJbcgRchxnNdZeAmHAgoyZPLGBBc5IWvqPv6IwzU7d
 PKsuEht0q85e27wKBrwm1bTpd4o1vLouMEYfSmmxQZTqnEYZsy7kgpd3zyGa25FvVTg==
X-Received: by 2002:a05:6000:614:b0:487:22c6:a623 with SMTP id
 ffacd0b85a97d-4887166d7eemr27549838f8f.8.1790668555910; 
 Tue, 29 Sep 2026 00:55:55 -0700 (PDT)
X-Received: by 2002:a05:6000:614:b0:487:22c6:a623 with SMTP id
 ffacd0b85a97d-4887166d7eemr27549769f8f.8.1790668555384; 
 Tue, 29 Sep 2026 00:55:55 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88352sm2268962f8f.4.2026.09.29.00.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:55:54 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Maxime Ripard <mripard@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jessica Zhang
 <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, Albert Esteve <aesteve@redhat.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
In-Reply-To: <artpBMeM13Dd0lLy@houat>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <6b80cb97-6706-412a-b013-9423f6f75153@linaro.org>
 <arqhwHiVf00j94J7@beelink>
 <0259fe4b-3118-4ab0-9b62-55101bfd7f33@linaro.org>
 <arrAqg5n87INTHE6@beelink>
 <674314b4-6b80-4b3a-ac15-eefd31cea607@linaro.org> <artpBMeM13Dd0lLy@houat>
Date: Tue, 29 Sep 2026 09:55:53 +0200
Message-ID: <xlv1wls4ebjq.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WpqySQ0Kehx_PyIt59VqPZLvbczjdGCpEiBKtm6rFHk_1790668556
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

> On Mon, Sep 28, 2026 at 10:36:18PM +0200, Neil Armstrong wrote:
>> On 9/28/26 21:48, Benjamin Tissoires wrote:
>> > On Sep 28 2026, Neil Armstrong wrote:
>> > > On 9/28/26 19:24, Benjamin Tissoires wrote:
>> > > > On Sep 28 2026, Neil Armstrong wrote:
>> > > > > Hi,
>> > > > > 
>> > > > > On 9/28/26 18:22, Maxime Ripard wrote:
>> > > > > > Hi,
>> > > > > > 
>> > > > > > Panels in general, and MIPI-DSI panels in particular, are pretty
>> > > > > > difficult to support and require pretty much a panel driver for each
>> > > > > > panel produced. Most of them are pretty simple, and require an opaque
>> > > > > > initialization sequence that is usually poorly documented.
>> > > > > > 
>> > > > > > This creates a tension between OEMs and distros because OEMs will
>> > > > > > typically get a new panel to react to a sourcing issue during
>> > > > > > production, and thus need some swift turnaround between getting their
>> > > > > > new panel and it being operational in the OS. Distributions on the other
>> > > > > > hand can take years to ship a kernel with that new panel driver.
>> > > > > > 
>> > > > > > To solve this, I followed the example of HID-BPF and wrote a panel
>> > > > > > driver that will rely on BPF programs to perform the panel
>> > > > > > initialization. That way, we can ship the programs separately from the
>> > > > > > kernel, and with a different lifecycle. If this driver is accepted, the
>> > > > > > plan is to have a userspace component started by udev to identify and
>> > > > > > load the right BPF program for the panels found on the device.
>> > > > > 
>> > > > > This is kind of late for serious applications except if we manage to
>> > > > > solve the bootloader to Linux display engine transition.
>> > > > > 

Besides what Maxime already mentioned (that most general purpose Linux distributions
built the drivers as modules anyways), it doesn't have to be mutually exclusive.

A simple panel could be supported using this BPF-based driver and then a panel driver
added to the kernel, if is found that some applications need to have it built-in and
earlier in the boot path.

I don't see why this would be any different than HDI-BPF or other BPF-based infra,
such as sched_ext.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

