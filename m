Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA59C44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 16:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEB7710E4C3;
	Fri, 17 Jul 2026 16:30:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ouz9BMCE";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 351A210E4C3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 16:30:55 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2ceb096e675so75618655ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 09:30:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784305855; cv=none;
 d=google.com; s=arc-20260327;
 b=U4nbKILc7ZpGCgJ/S4m3RyhNS+xjcRvicnA0quGcaR+6z64UcxfKUzNEBzarfb8Z9U
 f1S0yIANhqyfngTm1pZnERKoZ9rq6nfj/JyLRFqxnjSTJz2t6B5aVhzaLAzI7/knT3Xs
 mBK5y1FAnVPWrnur7QPp1mdLKA8UF8Ku9Goz+pXqTo/0A+oetdeiBi3ia3YfBXNXVfh/
 55ogM6zFbDSwCINDrnIOCOk3lTVPAyQxkWBb5q3mFL73HWmSR+nlQZKeeuRvkecCxE6v
 H6kBoM0UQ4kOozzMgK4H15KxDksKXQ8FxiLeVPG3uHMbZOPTEu0rz89P1y9Kwf7piM3S
 os/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mEFacLIneOp/QmtLUJi4Z80V3TBrQh57oZzZOS5MMp4=;
 fh=50Ba64BhvxlXKbuXYiPnPOqjucn5xBo7qUNhPwKnj2A=;
 b=Cw8yymZ/1fJ+Hmn2BC/ceSP9DkPBSFSOO2uPf6gdsfIAmJc3jEubJP2t8nep1cFl/U
 sm4T8DXiRzwl1u/T0yl9uNAY/W/gDYX/tMEaiwJoyYJ9p6Lftdzs+ZrtbAgP26m7GJGO
 NwLCJu1AMmArC9rdXMir9Vi+fMiEZrE4DTVe5Zit18gn5xWy1iboloXrWOiybWg+2reF
 TNSh/M8dfJ5VNIcAmb6cKLlX5+S9KWP8ak4dDxOvh+s94mcOXzMqW/au/Ne299e5c7Xg
 nZHu/VPXfSC6J8fKEUxQ7dS40zs2nqT75YtcDa/bEu9yxl50wfFXcVfdbM11fYbVOLHC
 4rQw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1784305855; x=1784910655;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mEFacLIneOp/QmtLUJi4Z80V3TBrQh57oZzZOS5MMp4=;
 b=ouz9BMCE+z6/EpgknfHGCEB9bjCTiqzH0ulSMg0tkle4duS8BFCWNyUbjeVcldWKkP
 6icxid2/TxI18eDbsPva6NFVkmzzzwQ6GZduKp3aOLiJFvO8Urq/1U/tvNumD4WRr7BB
 Mo3msc1+IE63gGhetg+HBu9kaoWIobW081TMHvqVj9AQpFjvNdwiGFdtVRlk8oc/Xdsm
 8a9kTZQkEDmzi/hA1zKyAbWIG1xEuaPm5YUES9FLizImrnoORdmbkZoEx6dzXXoN7u+f
 euoHVdW9U2o5DvUekUNZ1uFBCp+prP9rL7NnZj6Byt/8nqesgPefBQJn5ZSU8hKwr6/N
 6IIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784305855; x=1784910655;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mEFacLIneOp/QmtLUJi4Z80V3TBrQh57oZzZOS5MMp4=;
 b=L6GRbmA4VlFZhz1l9fx3/6j8+tczJvJRooFwtXsDJwNpv+37Sf0qaExAYTQ2l+k61f
 dKAfNkHaXZMEVBhcEdqGDviCcDsFh7/wAapmUNf8Goo6vnhPvWav+1ZLu2lsLeWvDeSE
 zPW1gsEXFQYC9rZxVP4DHwZM7ZtupfySnpzabiA66T2b7dRRZPKHhFHKXPcKbCXCsMoO
 qAlpPhPKL837E6tH7e74E6/xnULeuyfB9E/chGKlm/QsoeNLNN1GXviqaEZ7CbIHxFZS
 Ohcopr1dnHESi4YV+pcQEyNHaiFVI73t2we01Kw8UmQRY9MYaOq3tmDVRJ0hJDHOmWLe
 suNA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq8ReJN8ln6Qk0uCE/Sv5dS2qcepADZbhJETc+mSN0ow7rT0GAkvIofuSpY6T8LK0ENBUD183DIQcU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyBu2Cl7/vKqfa4D8VjpVjmkgOCF9+H+Y9E88AkqpKznxj+cOTw
 e3DcPT42i3s639aWXnyhiU+Sx/TKlYQ3hyxIaBCCLtdu30Psuy9Yjn8y50eGngmwpyUvfZ9l75J
 vl/n5OuESoUjw2Ubmplh51v8rZDct7dVnBIKPv/MX
X-Gm-Gg: AfdE7cl3qanoVD9+1BwqT3JfQjumrqFjYpJi89kWIb2OmAdnlFnViG0c8CQwvBKHmzV
 tQ8NOzNwR282849brdk64o4PFH4ppsbEY/6CSzIrH1FgvfojzYwFgDDbhq2xYPq/bI58jQed+gY
 o0R3s54tQ+My+Blfsshi1qjiXH7uQjQ1upLr5JOZ6rRAYLHljhBjtkgPkpUdv9Yhx9GaGkKZ+Bs
 aMjXRDbbobYrvKHucWmktSDCrFuLTbMni77Ra8edMbi0togop7JMxLlgfWpTA==
X-Received: by 2002:a17:903:19cc:b0:2cc:db71:4db5 with SMTP id
 d9443c01a7336-2cf349d3ee3mr39097735ad.37.1784305853798; Fri, 17 Jul 2026
 09:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260715174737.15287-1-matt@ozlabs.org>
 <CALzav=fH7N+ionUnELqw5ZaGrPmgp_w6kxoCtoY8fMmZY_S4zw@mail.gmail.com>
 <65ba06e7-4c54-437d-9fbd-632c0468f66d@ozlabs.org>
 <allLypOmtbnPrgbw@google.com> <20260717094230.21829508@pumpkin>
In-Reply-To: <20260717094230.21829508@pumpkin>
From: David Matlack <dmatlack@google.com>
Date: Fri, 17 Jul 2026 09:30:25 -0700
X-Gm-Features: AUfX_mwhrL8yyMXeQp2wwPQntVuYsbostLm0_QgQevpUJ-QTbHpefGc5UhWYaLU
Message-ID: <CALzav=fx2i1ONLjBTheHpdOQqQJJ05OP9b4-D3HkK6NumKi=pg@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] vfio/pci: Add mmap() for DMABUFs
To: David Laight <david.laight.linux@gmail.com>
Cc: Matt Evans <matt@ozlabs.org>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, 
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
 Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>, 
 Longfang Liu <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>, 
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 kvm@vger.kernel.org, linux-pci@vger.kernel.org
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

On Fri, Jul 17, 2026 at 1:42=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Thu, 16 Jul 2026 21:23:22 +0000
> David Matlack <dmatlack@google.com> wrote:
>
> > On 2026-07-16 03:51 PM, Matt Evans wrote:
> > > Hi David,
> > >
> > > On 15/07/2026 19:12, David Matlack wrote:
> > > > On Wed, Jul 15, 2026 at 10:47=E2=80=AFAM Matt Evans <matt@ozlabs.or=
g> wrote:
> > > >
> > > >> This is based on v7.2-rc3.
> > > >>
> > > >> These commits are on GitHub for easier browsing, along with
> > > >> "[RFC ONLY] selftests: vfio: Add standalone vfio_dmabuf_mmap_test"=
:
> > > >>
> > > >> https://github.com/metamev/linux/compare/v7.2-rc3...dev/mev/vfio-d=
mabuf-mmap-v5
> > > >
> > > > It'd be great to have this test upstream. I'm happy to review it wh=
en
> > > > you're ready. Looks like it just needs to be redone to use the VFIO
> > > > selftests library and kselftests harness. AI could probably do the
> > > > conversion pretty quick :)
> > >
> > > For sure, I'd intended to catch up with you on best approach here. :)
> > >
> > > Aside from the organic structure of the test (the open-coded VFIO
> > > device/group setup/init needs to go), the main issue is that it relie=
s
> > > on a hacked/out of tree QEMU "EDU++" device with a second larger BAR
> > > (containing freely read-writable memory).  A subset of tests run with
> > > the in-tree EDU device, but coverage is too low.
> > >
> > > The desirable properties are:
> > >
> > >  - Having a BAR that is pure memory (all locations present, writable
> > > without disruptive side-effects) so that mapping aliases can be
> > > constructed and detected.  This is good to test things like non-zero
> > > vm_pgoffs and VA space presentation of physically-discontiguous DMABU=
Fs.
> > >
> > >  - BAR >> hugepage size so we can eyeball huge mappings work (or bett=
er,
> > >  mechanically test for them).  At least 32MB would tick this box for =
4K,
> > > 16K page systems.
> > >
> > >  - Something QEMU supports*, so one can run the test in a VM/TCG syst=
em.
> > >
> > > There were some real device models in QEMU that could be used this wa=
y,
> > > but needed a fair bit of setup;  I didn't want to rathole
> > > vfio_dmabuf_mmap_test on including a ton of device-specific code for
> > > some video card or similar.
> > >
> > > I'll dig more for a simple target that provides these properties --
> > > obviously it would be better to point this test at an off-the-shelf
> > > device (including silicon!).  And, proposing EDU extensions to the QE=
MU
> > > folks may be useful (there're uses for a better EDU in other contexts=
 too).
> > >
> > > Since this test uses MMIO for a specific [class of] function, my firs=
t
> > > thought is it should be another VFIO driver-type test sibling of
> > > vfio_pci_driver_test.  For example, we could extend the driver-type
> > > tests' backend struct vfio_pci_driver_ops for functions capable of
> > > providing a Big Memory BAR, like QEMU EDU++.  EDU can also memcpy, so
> > > could also support vfio_pci_driver_test.
> > >
> > > The spirit of the device backends hiding setup of a complex device is
> > > handy, and it's plausible that several backends could provide this "b=
ig
> > > memory BAR" service.  What do you think, any concerns with extending
> > > vfio_pci_driver_ops like that?
> >
> > I wouldn't recommend leveraging the driver framework unless absolutely
> > necessary. It makes the test harder to run.
> >
> > The biggest issue I see with the proposed properties is being able to
> > treat the BAR as memory. That obviously will depend on the device and
> > may require device-specific setup. If we decide that treating the BAR a=
s
> > memory is truly required then using the driver framework is the way to
> > go. But I'm hoping we can avoid that requirement.
>
> Could you run a test where only a known part of the BAR can be treated
> as memory?
> A large BAR is likely to have some areas that can be accessed as memory.

Yeah. But then the test can only run against devices the test knows
about. So we have to update the test every time someone needs to use a
new device.

We could support a command line option to specify the BAR subregion.
But then the user has to figure out what to pass there.

So if we can find a way to get equivalent test coverage with "any
device with a large enough BAR", that would be ideal. Then it's just
matter of the user picking a device, and it's easy enough to look at
BAR sizes via lspci.

> >
> > Instead, I think you can get pretty far by inspecting /proc/pid/pagemap
> > to determine if the mmap() set things up correctly, without actually
> > accessing the BAR. You can use /proc/pid/pagemap to look up the PFN and
> > PAGEMAP_SCAN to detect huge pages.
> >
> > With that requirement gone, then all you really need is a device with a
> > large enough BAR. And even that it not a hard requirement. I'm sure
> > there are plenty of test cases that could work with smaller BARs. The
> > few tests that want to exercise huge mappings can inspect the device BA=
R
> > sizes first, and if they're all too small, SKIP() the test.
> >
> > If you structure the test this way, then it's easy for the test to be
> > used. It can be run against any device for the basic functional
> > coverage, and can be run against a device with a larger BAR for full
> > coverage of huge mappings.
> >
> > Does QEMU emulate any devices that have 32MB or larger BARs?
> >
>
