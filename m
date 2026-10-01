Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BB1CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 16:03:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CF9D10F705;
	Thu,  1 Oct 2026 16:03:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K/WOfh/6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BC4910F705
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 16:03:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 49D6E60A68;
 Thu,  1 Oct 2026 16:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D301F000FF;
 Thu,  1 Oct 2026 16:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790870609;
 bh=OSUIn2vvgZY9nja7L+v/qJsWqMEJTAmZepfV/Nzm4+g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=K/WOfh/6qDstRLC9ZRaNs7cNIQQwjOtWjnTQtkFB6PNQpgptrztf0vSZh4DTnZump
 ufgp5zI8dj1FfYTNwcct0yW+pbJ1cnXRsx64fvIJT7k/mTHFbB7QbfmdWqlgA2okEj
 MqOQaSGg/aeB4V2gt+drRL1DnXmxFWq04iX9rTbWvptKsLY/gt1wHPRSKfeVtnuziW
 ICrWJnbBeXEXGsj90XEOLMUTGz++GUwx2BKWLFPOO3CIMQdxaXRTsMjkVK05zO/J+W
 hMhw3abDTOyagZDekqC93G3fX0z6NIHa5uJorfvpgC75831IR/qGvdzjKV+I6P0zg9
 xksO8IEdJu0iw==
Date: Thu, 1 Oct 2026 11:03:27 -0500
From: Rob Herring <robh@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Albert Esteve <aesteve@redhat.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 llvm@lists.linux.dev, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH 1/6] dt-bindings: display: Add panel-mipi-dsi-bpf generic
 panel binding
Message-ID: <20261001160327.GA512699-robh@kernel.org>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <20260928-drm-mipi-dsi-panel-ebpf-v1-1-5244926aace4@kernel.org>
 <20260928204059.GA515872-robh@kernel.org> <artyl8fD3zzng8Uh@houat>
 <20260929222822.GA2933878-robh@kernel.org> <ary8IdL9zVXfS2fA@houat>
 <CAL_JsqJCoWQmdBKEbekXb5LeLn1KcMiP2iG30r+npssJSZB5LA@mail.gmail.com>
 <ar4HOuO-vox9VIKZ@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ar4HOuO-vox9VIKZ@houat>
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

On Thu, Oct 01, 2026 at 09:22:48AM +0200, Maxime Ripard wrote:
> On Wed, Sep 30, 2026 at 02:07:39PM -0500, Rob Herring wrote:
> > On Wed, Sep 30, 2026 at 3:04 AM Maxime Ripard <mripard@kernel.org> wrote:
> > >
> > > On Tue, Sep 29, 2026 at 05:28:22PM -0500, Rob Herring wrote:
> > > > On Tue, Sep 29, 2026 at 10:39:24AM +0200, Maxime Ripard wrote:
> > > > > On Mon, Sep 28, 2026 at 03:40:59PM -0500, Rob Herring wrote:
> > > > > > On Mon, Sep 28, 2026 at 06:22:01PM +0200, Maxime Ripard wrote:
> > > > > > > Most MIPI-DSI panel drivers follow an identical pattern: acquire
> > > > > > > regulators and GPIOs, perform a reset pulse with specific timing,
> > > > > > > send a vendor-supplied sequence of DSI commands, then enable the
> > > > > > > display. The only truly panel-specific part is the init sequence
> > > > > > > and power-on/off timing.
> > 
> > [snip a bunch of irrelevant shit]
> > 
> > > > > So, let's phrase this differently: what's different about the
> > > > > description than panel-mipi-dsi-spi, or any other binding already in
> > > > > tree?
> > > >
> > > > There's all of 3 panels supported. Compared to all the other panels we
> > > > have, hardly the rule over the exception. You can always fine "bad"
> > > > examples or exceptions.
> > > >
> > > > That one defines a single supply. Any other MIPI SPI panel with
> > > > different supplies or GPIO controls probably has its own binding. Trying
> > > > to parameterize that in DT doesn't work. We've rejected trying to do
> > > > that in DT over and over. What's your story here for that?
> > >
> > > Sigh... Look, I really don't care about an argument DT maintainers use
> > > at their discretion for this. We both know full well that it's been and
> > > still is inconsistenly applied, and you also know that it's not like
> > > I've been playing the DT game since pretty much the beginning (on ARM
> > > anyway). So it's not like I don't want to make it work, I do. But what I
> > > care about is enabling that driver to work.
> > >
> > > I reused exactly the same binding than the last major binding that was
> > > merged for panels, and support about the same number of panels. I guess
> > > that was a mistake, so sorry for that.
> > >
> > > I'm fine with reworking the binding any way you want as long as it still
> > > allows for the same use-case, but I would have hoped for a better
> > > feedback on how to do so than "oh what a huge pile of shit this is".
> > 
> > When you can answer my question above rather than make up shit I
> > didn't say, maybe I'll reply again on this thread. Otherwise I'm done
> > here. I don't need this abuse for the thankless job of DT
> > maintainership.
> 
> It's been the whole tone of the reviews, so I'm sorry if you were caught
> in the crossfire and you didn't mean that. And I'm sorry it made your DT
> maintainership work harder than it already is.
> 
> I do mean what I said before though. I have no problem changing the
> binding the way you want, but I need to know what to change in the first
> place, otherwise it's really no better than a NAK, or we're bound to
> have the same exchange for the v2, and I'd rather not.
> 
> I indeed missed your question, but now I'm not sure I understand what
> you mean by "paremeterize that in DT"? The supplies in the binding are
> an aggregate of all the possible supplies a panel can take. They are not
> a wildcard, but they all have their own semantics that are used by
> panels right now.

I read a bit more of the series and understand it a bit better now.

> I don't expect any new supply to be introduced, unless there's a major
> panel technology change such as the one we had with the introduction of
> OLED.
> 
> Would you prefer to reduce the number of supplies to the minimum we need
> right now, and extend it as needed?

No. You've defined some arbitrary list of supply names not just in the 
binding, but in the kernel. I think both are a mistake. Can't the BPF 
prog define the supply names and pass those to the kernel? Then when you 
have a panel with 'foo' and 'bar' supplies, you don't need a kernel 
change or some remapping to the existing set of names. The only real 
exception we have there is if it's a single supply, just use 
'power-supply'. It's the same issue with GPIOs, but there's generally 
less variability with them.

The whole point of requiring specific compatibles and not doing "generic 
bindings" is that's the only way the OS implementation can evolve 
without changing the DT. You can have a specific driver or a generic 
driver or a generic driver using BPF and which one can change over time 
if needed, but from a DT perspective we don't care.

So first, make this BPF stuff work with any existing panels (or some 
defined set). I'm not saying convert everything, only that you could. 
Otherwise you've failed the test of if the driver implementation 
changes, does the binding have to change.

After that, the remaining problem is only how do you make it 
work with unknown panels (only unknown to the kernel as any new panel 
still needs a binding). There's 2 ways we can solve that. Either make 
the kernel be able to bind to a generic driver without a compatible 
match or have a fallback compatible. The former could be done by 
userspace (though I saw gregkh added a taint for userspace bind 
recently) or we could somehow make the kernel bind to any DSI child 
devices without a match.

Rob
