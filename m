Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02ADECA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 06:38:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6009610E229;
	Thu,  1 Oct 2026 06:38:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oEIjM5PT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68DDE10E229
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 06:38:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D1695601F6;
 Thu,  1 Oct 2026 06:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7C71F000FF;
 Thu,  1 Oct 2026 06:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790836720;
 bh=d6btj38+HsO2qMSEPqeG6CeLl60eJfnkitB1H/EBGZI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=oEIjM5PTLkJ4ToifqiB2FHwVY1aYXxfoIn9c8BxMIh6PSPsUzH+VYScrg0+nFak9Y
 +at8puaF5ohKGYCBgxnwE/s/zMJZ9RH4sSTpR0/y0YWF7hWgRPi52wsZIa0urs4wxK
 5wWXM8zrJOa3gvdmRhIcfCNkClxQtPfgEMLS5snhgbcQSUnj9qd3Q79Vm6PK9P9599
 6LeAYGKZTzloo7A2NtMwzli3XYHWbIsgAzLvpAJauovmfRfaZZfy44JAV5Vj2a1ooo
 rBGsC9xArNwgotAX4eSAtwEsIk36ArnSYcPdM1y0XH7cSZj74Byg2p90Fsa5WDSIZP
 /Pm75Em4u0eLQ==
Date: Thu, 1 Oct 2026 08:38:36 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, 
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
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Albert Esteve <aesteve@redhat.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Javier Martinez Canillas <javierm@redhat.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, llvm@lists.linux.dev, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
Message-ID: <ar3_tJdoim6in8u0@houat>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <6b80cb97-6706-412a-b013-9423f6f75153@linaro.org>
 <arqhwHiVf00j94J7@beelink>
 <0259fe4b-3118-4ab0-9b62-55101bfd7f33@linaro.org>
 <arrAqg5n87INTHE6@beelink>
 <674314b4-6b80-4b3a-ac15-eefd31cea607@linaro.org>
 <artpBMeM13Dd0lLy@houat>
 <fb7ed8ab-8aea-4731-a5e5-c9476d8bfd38@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="glslsrnv4uyo4fso"
Content-Disposition: inline
In-Reply-To: <fb7ed8ab-8aea-4731-a5e5-c9476d8bfd38@linaro.org>
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


--glslsrnv4uyo4fso
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
MIME-Version: 1.0

On Wed, Sep 30, 2026 at 03:36:36PM +0200, Neil Armstrong wrote:
> On 9/29/26 09:41, Maxime Ripard wrote:
> > On Mon, Sep 28, 2026 at 10:36:18PM +0200, Neil Armstrong wrote:
> > > On 9/28/26 21:48, Benjamin Tissoires wrote:
> > > > On Sep 28 2026, Neil Armstrong wrote:
> > > > > On 9/28/26 19:24, Benjamin Tissoires wrote:
> > > > > > On Sep 28 2026, Neil Armstrong wrote:
> > > > > > > Hi,
> > > > > > >=20
> > > > > > > On 9/28/26 18:22, Maxime Ripard wrote:
> > > > > > > > Hi,
> > > > > > > >=20
> > > > > > > > Panels in general, and MIPI-DSI panels in particular, are p=
retty
> > > > > > > > difficult to support and require pretty much a panel driver=
 for each
> > > > > > > > panel produced. Most of them are pretty simple, and require=
 an opaque
> > > > > > > > initialization sequence that is usually poorly documented.
> > > > > > > >=20
> > > > > > > > This creates a tension between OEMs and distros because OEM=
s will
> > > > > > > > typically get a new panel to react to a sourcing issue duri=
ng
> > > > > > > > production, and thus need some swift turnaround between get=
ting their
> > > > > > > > new panel and it being operational in the OS. Distributions=
 on the other
> > > > > > > > hand can take years to ship a kernel with that new panel dr=
iver.
> > > > > > > >=20
> > > > > > > > To solve this, I followed the example of HID-BPF and wrote =
a panel
> > > > > > > > driver that will rely on BPF programs to perform the panel
> > > > > > > > initialization. That way, we can ship the programs separate=
ly from the
> > > > > > > > kernel, and with a different lifecycle. If this driver is a=
ccepted, the
> > > > > > > > plan is to have a userspace component started by udev to id=
entify and
> > > > > > > > load the right BPF program for the panels found on the devi=
ce.
> > > > > > >=20
> > > > > > > This is kind of late for serious applications except if we ma=
nage to
> > > > > > > solve the bootloader to Linux display engine transition.
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > This driver is fully functional and works with both 5" and =
7" Touch
> > > > > > > > Display 2 panels for the RaspberryPi. However, it breaks aw=
ay from the
> > > > > > > > typical panel driver in multiple ways:
> > > > > > > >=20
> > > > > > > > - BPF programs can only be loaded by userspace. This leaves=
 us with two
> > > > > > > >       choices:
> > > > > > > >=20
> > > > > > > >       * We prevent the driver from loading until the script=
 itself is
> > > > > > > >         loaded. This has the side effect of preventing any =
other output to
> > > > > > > >         be used until the initramfs is ran at the earliest,=
 and possibly
> > > > > > > >         ever if the loader isn't installed for example.
> > > > > > >=20
> > > > > > > This adds a dependency on user-space behavior and if somehow =
the
> > > > > > > initramfs doesn't load for a reason we won't have a way to di=
splay
> > > > > > > an error.
> > > > > > >=20
> > > > > > > >=20
> > > > > > > >       * Or we probe the driver all the time, but only repor=
t it as connected
> > > > > > > >         once a program has been registered. This is somewha=
t unconventional,
> > > > > > > >         but allows the other outputs to be functional, *and=
* allows the user
> > > > > > > >         to force the output if their panel doesn't require =
any
> > > > > > > >         initialization or during debugging. I chose this so=
lution.
> > > > > > >=20
> > > > > > > Both options are not really great...
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > - It's not a panel driver, but a bridge one, which is also =
pretty
> > > > > > > >       unconventional. This is required because panel driver=
s don't have
> > > > > > > >       access to a detect callback that is required for the =
above, but I also
> > > > > > > >       think that the recent work from Luca blurs the line f=
rom panels and
> > > > > > > >       bridges and we'll end up going that road anyway.
> > > > > > >=20
> > > > > > > On this point, DDIC _are_ bridges, but in the current panel A=
PI we blur the line between
> > > > > > > the panel and the DDIC. So being a bridge is fine, but in a g=
eneral way we lack
> > > > > > > a proper way to describe the display/panel/monitor independen=
tly of the DDIC.
> > > > > > >=20
> > > > > > > At first glance it's a nice driver, but moving the timings in=
to a blob moves something
> > > > > > > into possible proprietary binaries with possible closed licen=
ce and distribution
> > > > > > > restriction so it's a downgrade for the same of bringing up a=
 panel faster.
> > > > > >=20
> > > > > > Quick answer on this, because I had the very same questions reg=
arding
> > > > > > HID-BPF:
> > > > > > - in BPF, you can require (and by default it does) that only GPL
> > > > > > 	compatible BPF programs are loaded, closing the argument of "c=
losed
> > > > > > 	licence and distribution restriction"
> > > > > > - also, a BPF program can be disassembled much easier than a bi=
nary
> > > > > > 	blob, and I remember Alexei showing me an example where you ge=
t almost
> > > > > > 	the source code from the BPF object in just one pass.
> > > > >=20
> > > > > Right, it "solve" one of my question, but doesn't really solve th=
e issue
> > > > > of vendors providing "GPL" bpf programs with source available "so=
mewhere".
> > > > >=20
> > > > > Another big issue is the API, I don't want to keep the current AP=
I as-is,
> > > > > we plan to support more advanced panel features and use try to us=
e the
> > > > > atomic states to support rate switching for example, and I'm not =
confident
> > > > > it's a good idea since there's no "simple" and "forever valid" API
> > > > > to initialize panels...
> > > > >=20
> > > >=20
> > > > That's exactly where BPF shines. The simple rule of thumb is: there=
 is
> > > > no API stability guaranteed. Basically, thanks to the verifier and =
CORE
> > > > (Compile Once Run Everywhere), you don't need to keep the API stabl=
e and
> > > > available forever. There are multiple ways of dealing with it, but =
the
> > > > gist is that if a BPF is trying to load an "old" API, it will be
> > > > rejected by the verifier.
> > > >=20
> > > > Then it's a matter of being nice enough in the kernel and provide w=
ays
> > > > to deal with those.
> > > >=20
> > > > To give you a few examples:
> > > >=20
> > > > - in HID-BPF, in userspace, we keep old versions of APIs in separate
> > > > 	compiled objects. Each is incremented (by 10 so we have a little b=
it
> > > > 	of room in the middle). Then the loader tries first
> > > > 	0020-device-with-new-api.bpf.o, and if it fails, it tries
> > > > 	0010-device-with-old-api.bpf.o
> > > >=20
> > > > 	I'm not saying we should do the same here, but that's one idea
> > > >=20
> > > > - recently, a BPF commit broke the ABI of a function while removing
> > > > 	implicits: bpf_wq_set_callback_impl() was replaced by
> > > > 	bpf_wq_set_callback() with a different number of arguments. I simp=
ly
> > > > 	had to add a new function in my header which basically does:
> > > >=20
> > > > 	static inline int
> > > > 	hid_bpf_wq_set_callback(struct bpf_wq *wq,
> > > > 	                        int (*callback_fn)(void *, int *, void *),
> > > > 	                        unsigned int flags)
> > > > 	{
> > > >         if (bpf_ksym_exists(bpf_wq_set_callback))
> > > >                 return bpf_wq_set_callback(wq, callback_fn, flags);
> > > >         if (bpf_ksym_exists(bpf_wq_set_callback_impl))
> > > >                 return bpf_wq_set_callback_impl(wq, callback_fn, fl=
ags, NULL);
> > > >     }
> > > >=20
> > > >     And then I changed the bpf.c to use hid_bpf_wq_set_callback() a=
nd the
> > > >     bpf is compatible with both APIs
> > > >=20
> > > > - with CORE, struct fields are relocated on the fly when you load t=
he BPF
> > > >     So for instance, if my BPF only accesses fields .name, .phys an=
d .id
> > > >     in the BPF, I can define:
> > > >     struct hid_device {
> > > >       char                       name[128];
> > > >       char                       phys[64];
> > > >       unsigned int               id;
> > > >     }
> > > >=20
> > > >     Then when loading the bpf, the verifier replaces all offset to =
the
> > > >     ones actually used by the running kernel, and the program loads
> > > >     transparently, even if you add fields before/after or change the
> > > >     fields order in the kernel.
> > > >=20
> > > > Changing the mindset is the hardest part of it. But once you are ma=
king
> > > > the shift, it's actually much better to work with. It doesn't mean =
you
> > > > can go yolo. You still need to be careful in your choices knowing t=
he
> > > > impact on your users. But the API at version 0 is not frozen and you
> > > > don't need to maintain it forever, especially if you control the lo=
ader
> > > > and the headers used to compile the BPFs.
> > >=20
> > > It's really impressive, but there's no way this would become the de-f=
acto
> > > way to program the panels
> >=20
> > Nobody said it would? And like I said in my previous mail, I actually
> > expect us to keep merging panel drivers. Do I think it should become the
> > go-to solution for simple panels? yes. But we can always make
> > exceptions, and for more complex panels we should totally do a more
> > complex driver. Like HID has been doing.
> >=20
> > > and if the motivation is to make it simpler this implementation
> > > requires adding bindings and bpf programs which that are the same as
> > > native panel drivers, but won't be able to work until user-space
> > > starts and will require to be in initramfs or rootfs to have
> > > functional display.
> > >=20
> > > Not sure to understand what are the positive features here except
> > > isolating the panel code in a safe bpf program (is this really needed
> > > ?).
> >=20
> >  From the cover letter:
> >=20
> > """
> > Panels in general, and MIPI-DSI panels in particular, are pretty
> > difficult to support and require pretty much a panel driver for each
> > panel produced. Most of them are pretty simple, and require an opaque
> > initialization sequence that is usually poorly documented.
> >=20
> > This creates a tension between OEMs and distros because OEMs will
> > typically get a new panel to react to a sourcing issue during
> > production, and thus need some swift turnaround between getting their
> > new panel and it being operational in the OS. Distributions on the other
> > hand can take years to ship a kernel with that new panel driver.
> >=20
> > To solve this, I followed the example of HID-BPF and wrote a panel
> > driver that will rely on BPF programs to perform the panel
> > initialization. That way, we can ship the programs separately from the
> > kernel, and with a different lifecycle.
> > """
> >=20
> > You can disagree with the solution, that's fair, we can also discuss on
> > how to solve this problem, but I'd appreciate it if you weren't claiming
> > it's all useless.
>=20
> I did read the cover-letter and I got the arguments from Benjamin, and
> while in theory it could indeed solve the issue described, in reality
> it won't for the reasons I exposed.
>=20
> And since it's basically allowing to accept out-of-tree downstream
> driver instead of upstreaming, I'm kind against TBH.

I'm confused, is it something we do not allow today?

Maxime

--glslsrnv4uyo4fso
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCar3/5QAKCRAnX84Zoj2+
diapAX9Dph3QM+TSAN18B+4v0ve7mNDvhVEz+4CbyQ2u9RlIykyUTfKtE3QeKLhD
Lx5rdRkBgL8PslbTANcIb2FTYpECCxtqcDcicFkkgRrB3KuIap0FkvbwwHwi2Wja
/DZlWJOpCw==
=DFoF
-----END PGP SIGNATURE-----

--glslsrnv4uyo4fso--
