Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D042CCA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F9F210F3AE;
	Wed, 30 Sep 2026 19:07:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WGTKgsCU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4199B10F3AE
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:07:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 47795601FA
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D091F0089A
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790795273;
 bh=bxJY6r7hmtQQbaUp+jGo9ojcTYyECOaox7wsG7JzNr0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=WGTKgsCU+/7tSbH0RgCXBxO0ozmDxYzlLDwec2n1uK5vKG2u+Di5y2WS6iaRioeHA
 2HQe+XnO1uJ4CYhwINzo8cjLvNqjNXCxbsf3+JY7DHNsj5meQBk7iK2fww7Th4TV6i
 kkU7y7Et3fGZqOvDiMtxgUEgFwaPoRwmgHaXCfNEC2tlCG2i5It8RQNIVw5uvFKrUC
 XChF332jlPqD8AXn0mXF0TdpqcDviisUqsmHyxFw/K52bPBpJEZyqZkDAJcx9W9Ctx
 wNhktvmN49L3hqx5qTmfX02sCiNCyjvFtFvqmwbcNor4vRdzJXOT4Q1zfnuuJSa4ri
 xPBPjhV5LjBFA==
Received: by mail-ed2-f35.google.com with SMTP id
 4fb4d7f45d1cf-6a6056ac81fso8697112a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 12:07:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBxIU5Yn+cmJBiQQ6bZSxb9FS+cxZ0sfSFKKjo2E6yVNcmPclcUDZWM4sEEtg0s0DLJfN48myPJYwEU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nWoXhMt9w6b/OnNqbnxdnsUNHbAjtIyIODdTdOps0sIqk8dWGE
 VfzReY8D5lzqGcdnJZl+PoQBD7SbelDWJ2sruupCB/m0QA/Zl5ACeIrQ+bsN5Yqj52kdSiwIzEo
 8pZbnPgtUAAc0IGYO65ETra04Pjx4yg==
X-Received: by 2002:a17:906:7308:b0:c29:566f:531c with SMTP id
 a640c23a62f3a-c2e23d64e23mr209463766b.31.1790795271560; Wed, 30 Sep 2026
 12:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <20260928-drm-mipi-dsi-panel-ebpf-v1-1-5244926aace4@kernel.org>
 <20260928204059.GA515872-robh@kernel.org> <artyl8fD3zzng8Uh@houat>
 <20260929222822.GA2933878-robh@kernel.org> <ary8IdL9zVXfS2fA@houat>
In-Reply-To: <ary8IdL9zVXfS2fA@houat>
From: Rob Herring <robh@kernel.org>
Date: Wed, 30 Sep 2026 14:07:39 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJCoWQmdBKEbekXb5LeLn1KcMiP2iG30r+npssJSZB5LA@mail.gmail.com>
X-Gm-Features: AclHuK_KrCZYndoX88-SUyUMhWpLte5mG0GRB_AK8DozaFWQdrOZypWv12h1FtM
Message-ID: <CAL_JsqJCoWQmdBKEbekXb5LeLn1KcMiP2iG30r+npssJSZB5LA@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: display: Add panel-mipi-dsi-bpf generic
 panel binding
To: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Albert Esteve <aesteve@redhat.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 llvm@lists.linux.dev, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Benjamin Tissoires <bentiss@kernel.org>
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

On Wed, Sep 30, 2026 at 3:04=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> On Tue, Sep 29, 2026 at 05:28:22PM -0500, Rob Herring wrote:
> > On Tue, Sep 29, 2026 at 10:39:24AM +0200, Maxime Ripard wrote:
> > > On Mon, Sep 28, 2026 at 03:40:59PM -0500, Rob Herring wrote:
> > > > On Mon, Sep 28, 2026 at 06:22:01PM +0200, Maxime Ripard wrote:
> > > > > Most MIPI-DSI panel drivers follow an identical pattern: acquire
> > > > > regulators and GPIOs, perform a reset pulse with specific timing,
> > > > > send a vendor-supplied sequence of DSI commands, then enable the
> > > > > display. The only truly panel-specific part is the init sequence
> > > > > and power-on/off timing.

[snip a bunch of irrelevant shit]

> > > So, let's phrase this differently: what's different about the
> > > description than panel-mipi-dsi-spi, or any other binding already in
> > > tree?
> >
> > There's all of 3 panels supported. Compared to all the other panels we
> > have, hardly the rule over the exception. You can always fine "bad"
> > examples or exceptions.
> >
> > That one defines a single supply. Any other MIPI SPI panel with
> > different supplies or GPIO controls probably has its own binding. Tryin=
g
> > to parameterize that in DT doesn't work. We've rejected trying to do
> > that in DT over and over. What's your story here for that?
>
> Sigh... Look, I really don't care about an argument DT maintainers use
> at their discretion for this. We both know full well that it's been and
> still is inconsistenly applied, and you also know that it's not like
> I've been playing the DT game since pretty much the beginning (on ARM
> anyway). So it's not like I don't want to make it work, I do. But what I
> care about is enabling that driver to work.
>
> I reused exactly the same binding than the last major binding that was
> merged for panels, and support about the same number of panels. I guess
> that was a mistake, so sorry for that.
>
> I'm fine with reworking the binding any way you want as long as it still
> allows for the same use-case, but I would have hoped for a better
> feedback on how to do so than "oh what a huge pile of shit this is".

When you can answer my question above rather than make up shit I
didn't say, maybe I'll reply again on this thread. Otherwise I'm done
here. I don't need this abuse for the thankless job of DT
maintainership.

Rob
