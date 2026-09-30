Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A0DCA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 06:52:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC59810E1C2;
	Thu,  1 Oct 2026 06:52:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LUlR86nN";
	dkim-atps=neutral
Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com
 [74.125.225.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 059FD10E128
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 21:00:10 +0000 (UTC)
Received: by mail-wr2-f11.google.com with SMTP id
 ffacd0b85a97d-48b05d75172so135609f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 14:00:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790802008; cv=none;
 d=google.com; s=arc-20260327;
 b=ooG8mDVg1Sgbvr3qXdt+xEQHGizd2uGCOMOy7r6BWLLMFmpRINgQhxd246KsmPC6uv
 w7R6B/VR1Ol1XhMqMs4wYPygH2K9O3QWNeXDJjvYut3nXNu0UKLkbbxLx5+l8e66fAmM
 F9AXAGV+b2XpWzGqD/rHAwLql7Eh+MfceuVP0As2pXJ2vmkBcesdTCm/l/7+vM+i7RxM
 CxYsFwtVlUZHkHKqdai81Gy3GOSTA8MyNhAmASduEaiOHtMx3BsH1FpPc0VZYdeUuQEI
 a6s+orRV7/5X++PLYqChbC1r7NACqmbaZvkSA+l6wlripTSJqNdMArip97LCDJ9ITDis
 v8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BdHV7DMCXxsggz4//I4AlWe1QoSNzGSaCcBE0kpC5j4=;
 fh=Yvp4eg0+szSt+okyvWHs+wN5TwUCKI/dRyEBpT4/S28=;
 b=cF6+C88VIIJy7uep1fTPsCv49pWke5sIr2+JW4i1hgf+oREQimt39PvN8Y2HU7xC2Y
 IqaZbURUvP7ORjDcM5IdE+DWXqpHORdXdo1RTFp8DWDZ/0evfybnbJW9Mzhm+AAhCSTg
 mbLUqU4M7UBFtENj0+ztR3Mujh9MuL6tmCXm0gEy8w0FIBfW6Qc5MRdN6enS2NPZ/+5f
 djTsbglb+SMdI5fxhXYjJ2/yb8b/h9DqOy1dw3+Nq39ZgS6GKRcixvQLxSyU9qC2Z/Iz
 vrqJWqJ/hJ/B+VtlA+eu7aRpY0Uiu4Tkr+n6UAah387YLz2d9XDQcb+yL2VLTJ88uDk9
 IRuQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790802008; x=1791406808; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BdHV7DMCXxsggz4//I4AlWe1QoSNzGSaCcBE0kpC5j4=;
 b=LUlR86nN6EvIxBGfJ3ZcmR6p+CeiCtHcd1iOJj8bkMp5wpo6XYl2d81py9F0QAaLeV
 /OP5zrL2L9jnFwT8649IlOBDrHRC7trKsG2Heoqo7m3oQ5vzmTat5/X6h1f+yD25OZ1M
 Gjt3vof4Wf5Os+QaRmebMDduWKVrruQDZBMCXmzTk5baU2XDJUK7eTdnxE461z3bGJnt
 /vmLbxccunfo2gbOEHpZat5/acl0qh6bxuSvYH5L+g3U2FEfG3PFBHoSEa1VFF0KDsNP
 c1fnDRxedQee4SI2MW7vht741NUtZ3VgFqIjynaSTd4LG4BWErLGcxG9sxRt7zfXnSTe
 ZQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790802008; x=1791406808;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BdHV7DMCXxsggz4//I4AlWe1QoSNzGSaCcBE0kpC5j4=;
 b=t8lsGpIISQfEBTKE1Pn9wsEm0fRnoLu1wNL8qtXHek3GECAhgf9LzGXYf41rBxWuCz
 uXEeQkQGrvQkhXW0cTOlZ+wTNNrxiBysAyh+q4grnmgWK19CzcgZwIy3tinh0T1UC8vw
 os9we2Sk+8BMTPHjz5d+Dgt7w3XadrhS0GDciXkS/hEgCQkD4txtpv1yGcab3ZjQ20UZ
 YzUzXLdAvlKHWVvpy8xnSedpq6vzwEGLwYuVKc+sCjMwtBVgNynxFkz+hBOcZB8eY+JF
 1nIK56VewWXtuTB7QkYwbLEFDIziN4fWopcR9OpSNEvI8F6rTU4pvshjEuaEsJrggwcD
 eD8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHx7qYr8bbcI8A7mTyU3Etptpz/0lpcMaX/1041QMmMpXaFAfKEg1yd1nU0aAIGg9DDAqqLyFYWmE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKaBDT15kgQzdAyTJ/mo4qieidC+HG5Ei2GVwkdh6GYDD4oW4zH
 mxVFDX6u7XUVqXuy0IXAVIyP4Rn8L+FAncFg0HSGghvPJv1S3wzdy16br9wimFdL9vkSXrRcYll
 BQStdJh8FW+48glKfnMmSLHsycNqMt0o=
X-Gm-Gg: AYBFou21e91vEOFdOm+fvU7UkVoCJAxmXtfpVxPp7sYU321lFk8LTI1/MxGvkg+uGOu
 Tfba68JM9wEI9DV4KdEgMeelHU1n5k/mRDraSAA13d8sKlLCDupSuglZJNiTka/gEwTdUTXzkoU
 /qYymdhoRDs7X9LPg/AMC7ahqzaDvt3ujxj0kBMp8MijMbgBjTQiGVC/jhsFEezHewlM1akKE+K
 MLcJPaReOAPinDrj/TAwtw3xyXBnmDjSa9S3Stt9NBVk5iI4gNY7eXQL3UsukZa6YBTbW95ddgg
 mSjueUJeaifpGCeBJdJSA861DJ9EqrwGNBSH8PsDkNIzJMPDS6QGIohl48QoQR4eHm8UmMIAMRw
 1Askhmz5Byw30DeR+Px16LhsPAt9Crv85hUZYKdJkU5LujnrBpUtr/tre2AaaxpFHNZDmmA/A+E
 arbieHkW7rFIEOZ2v+VA==
X-Received: by 2002:a05:6000:2dc6:b0:48b:68:594a with SMTP id
 ffacd0b85a97d-48b024c5716mr5289021f8f.12.1790802008034; Wed, 30 Sep 2026
 14:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <6b80cb97-6706-412a-b013-9423f6f75153@linaro.org> <arqhwHiVf00j94J7@beelink>
 <0259fe4b-3118-4ab0-9b62-55101bfd7f33@linaro.org> <arrAqg5n87INTHE6@beelink>
 <674314b4-6b80-4b3a-ac15-eefd31cea607@linaro.org> <artpBMeM13Dd0lLy@houat>
 <fb7ed8ab-8aea-4731-a5e5-c9476d8bfd38@linaro.org>
In-Reply-To: <fb7ed8ab-8aea-4731-a5e5-c9476d8bfd38@linaro.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 30 Sep 2026 22:59:30 +0200
X-Gm-Features: AclHuK-U6pulImpn0m_SQCkcJ5kAgToTplTEZZASDrUoYoF9BUdVXxkuuMMc3Rg
Message-ID: <CAP01T772Vgc4=ShFHQ5bFBAF0PYuQ07xe3h+biT7LST-tahHhg@mail.gmail.com>
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Maxime Ripard <mripard@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
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
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 01 Oct 2026 06:52:04 +0000
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

On Wed, 30 Sept 2026 at 15:57, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> [...]
> >>>
> >>> Changing the mindset is the hardest part of it. But once you are making
> >>> the shift, it's actually much better to work with. It doesn't mean you
> >>> can go yolo. You still need to be careful in your choices knowing the
> >>> impact on your users. But the API at version 0 is not frozen and you
> >>> don't need to maintain it forever, especially if you control the loader
> >>> and the headers used to compile the BPFs.
> >>
> >> It's really impressive, but there's no way this would become the de-facto
> >> way to program the panels
> >
> > Nobody said it would? And like I said in my previous mail, I actually
> > expect us to keep merging panel drivers. Do I think it should become the
> > go-to solution for simple panels? yes. But we can always make
> > exceptions, and for more complex panels we should totally do a more
> > complex driver. Like HID has been doing.
> >
> >> and if the motivation is to make it simpler this implementation
> >> requires adding bindings and bpf programs which that are the same as
> >> native panel drivers, but won't be able to work until user-space
> >> starts and will require to be in initramfs or rootfs to have
> >> functional display.
> >>
> >> Not sure to understand what are the positive features here except
> >> isolating the panel code in a safe bpf program (is this really needed
> >> ?).
> >
> >  From the cover letter:
> >
> > """
> > Panels in general, and MIPI-DSI panels in particular, are pretty
> > difficult to support and require pretty much a panel driver for each
> > panel produced. Most of them are pretty simple, and require an opaque
> > initialization sequence that is usually poorly documented.
> >
> > This creates a tension between OEMs and distros because OEMs will
> > typically get a new panel to react to a sourcing issue during
> > production, and thus need some swift turnaround between getting their
> > new panel and it being operational in the OS. Distributions on the other
> > hand can take years to ship a kernel with that new panel driver.
> >
> > To solve this, I followed the example of HID-BPF and wrote a panel
> > driver that will rely on BPF programs to perform the panel
> > initialization. That way, we can ship the programs separately from the
> > kernel, and with a different lifecycle.
> > """
> >
> > You can disagree with the solution, that's fair, we can also discuss on
> > how to solve this problem, but I'd appreciate it if you weren't claiming
> > it's all useless.
>
> I did read the cover-letter and I got the arguments from Benjamin, and
> while in theory it could indeed solve the issue described, in reality
> it won't for the reasons I exposed.
>
> And since it's basically allowing to accept out-of-tree downstream
> driver instead of upstreaming, I'm kind against TBH.
>
> But I'm open to discussion, and I'll talk about display Panel in
> XDC today, Plumbers and ELC next week so I hope we'll find time to
> discuss about this in person!
>

Hi Neil, Maxime, Benjamin, and others,

I've been following the patch set over the past couple of days, mostly
out of curiosity. You folks understand the details of your subsystem
best, therefore I trust you with that, but I've seen a lot of
misunderstandings which feed into unjustified worries about how some
of this will work.

For clarity, as several people have already pointed out:
1) BPF programs ship with complete bytecode and line information from
the source, so I don't think the concern about the program being a
binary blob is justified in any sense. The verifier has to verify it
after all, before it gets loaded into the kernel. They also must be
licensed as GPL to have access to any kernel functionality.
2) Adding BPF interfaces does not lock the kernel side ABI into a
perpetual stability contract. There have been several thriving
communities (sched_ext, HID-BPF) which have used BPF successfully in
practice and have never had to make suboptimal technical choices
because they support BPF-based customization. The interfaces have
changed and in some cases completely rewritten without breaking users.
Of course, you might decide to be less or more graceful w.r.t.
backwards compatibility, but this is a choice left in the hands of
subsystem maintainers.
3) On top of all this, there are several mechanisms in BPF programs to
detect availability of APIs and adapt it during load to allow programs
to work across kernel versions, both for functions the program can
call and data it can access.

As far as people being able to carry downstream changes, I think, at
this point, that is already trivial with or without BPF (esp. with
LLMs), the only thing you change is how easy it is for users to avoid
being tied to kernel release cycles.

With the right incentives people will end up sharing their BPF
programs with the rest of the community. sched_ext and HID-BPF are two
strong examples of this. All programs get developed in the open with
community involvement, even when several companies make use of them
internally for their production use cases. The theoretical worries are
fine, but as far as practical evidence goes it has worked out
positively for everyone involved (not once, but twice).

The only valid concern I saw was the dependency on user space to load
these programs. We have had a bpf_preload mechanism in the tree since
forever, it has not found much traction since existing use cases
didn't often need the ability to load programs early. We'd be happy to
explore how it could be adjusted, or reworked to better support
whatever requirements emerge from this work.

In any case, I am not equipped to decide what is best for your
subsystem, but at least from the BPF side, I saw several
misconceptions which I hope the above can address.

Thanks

> Neil
>
> >
> > Maxime
>
>
