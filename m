Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C10F606A323
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IdfGlUQL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98F6A10E630;
	Wed, 25 Nov 2026 12:43:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 069F010E630
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 12:43:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B48BA45B5E
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 12:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E65E1F01561
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 12:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795610593;
 bh=Soe9AbyJje/CanHZy+BPUS7HyCw3W/h9mWpxWG3+h70=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=IdfGlUQLVdZd+HqGeJmpnmm6ZOvD2DCF88z9GcmsjUrKh5xMoOWAGEOagnXAmAYta
 k5dXwiF8fnMKU/56Us9yLAAPPjZbLDyyIyN4SJwaz6ZYK/x07tMrfYIXK6AieI6mSB
 d1AdCCTdQcqGyELTARAP/FzRjeNQGlDxqnuOgdfoKJ9MFiO7BSIcyxarVyn4QpJp5/
 Te6SJK2tPRq87NZfNEoUCKt9Lc9PfZf9imw1XgFkYesMHxgV5ZIhH3PFZPEcykyjTn
 BdRChy9Mk6ypZdqC9qPqHPRw/g6YkI8qu84PKcwRhIcA1Rxl6OclJCgqXskhY5I66W
 DQPweoAUVnWBw==
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5c14f3dab66so5384636e87.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 04:43:13 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErHvsuot2E0fOugq6MwwWOGoOs0crwWFid0GLVfifDAV0YE0PzjBRw+9vdK3bN7FhyL1Q5hVPJipv3k=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9gNiCQm61QLVjRaYVYYH66fMDDV4zFb1BWl+iDsE6VuVdwAaeX
 Pdq8liBoKbiSBLp744u/DVv1iEokxEU4z6gr8IAqjSkiNXm2dT7UZ+a/kBXn5qi5XaK7w5Fc81d
 IBuE2vaKhPxb6h3QPyHC/IH29YytdHGg=
X-Received: by 2002:a05:6512:3e1a:b0:5c1:4d49:cd84 with SMTP id
 2adb3069b0e04-5c1bc89a84emr4500196e87.17.1795610592062; Wed, 25 Nov 2026
 04:43:12 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015142552.4128028-1-ryan.roberts@arm.com>
 <20261015142552.4128028-16-ryan.roberts@arm.com>
In-Reply-To: <20261015142552.4128028-16-ryan.roberts@arm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 25 Nov 2026 13:42:59 +0100
X-Gmail-Original-Message-ID: <CAD++jL=h8iMU1sxjopoGBuniv_vsi2uhggJNQiyoWaTsOV+-Tw@mail.gmail.com>
X-Gm-Features: Aa3M54pGhuvz2evFxcjQ_z7LSxF4iu4SVrSPElv7BkwMOHJcq9BoFVwsp0UZH2I
Message-ID: <CAD++jL=h8iMU1sxjopoGBuniv_vsi2uhggJNQiyoWaTsOV+-Tw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 15/15] misc/arm-cla: Add vfio-mdev user interface
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oupton@kernel.org>, 
 Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Oded Gabbay <ogabbay@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, kvm@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ryan, Jean-Philippe,

this patch series now moves into the virtualization stratosphere where
my knowledge doesn't even reach the level of "a little knowledge
is dangerous", people versed with virtualization need to review this.

A few general remarks though:

On Thu, Oct 15, 2026 at 4:27=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:

> From: Jean-Philippe Brucker <jpb@kernel.org>
>
> Implement an interface to assign CLA devices to KVM guests. To creates a
> CLA instance:
>
>     uuid=3D$(uuidgen)
>     echo $uuid > /sys/class/mdev_bus/<pdev>/mdev_supported_types/arm-cla-=
pl1/create
>     cla_cpu=3D$(< /sys/bus/mdev/devices/$uuid/cpu)
>
> This creates a user interface in /dev/vfio: a VFIO group in
> /dev/vfio/<n>, discoverable by reading the symlink
> /sys/bus/mdev/devices/$uuid/iommu_group. Although CLA does not use an
> IOMMU, VFIO relies on IOMMU groups as an assignable unit. Here they
> correspond to CLA domains, whose devices communicate through a private
> bus.
>
> The CLA device gets assigned exclusively to the first VMM that opens the
> VFIO group and device. To launch a VM with a CLA attached to vCPU #4,
> with kvmtool:
>
>     lkvm run -k Image --console virtio -c 8
>         --vfio-platform $uuid,type=3Darm-cla,vcpu=3D4
>         --vcpu-affinity 4=3D$cla_cpu      # Bind vCPU 4 to the CLA's CPU
>
> Opens the group, gets the device fd, mmaps the frame, and launches the
> guest. The given vCPU thread is pinned to the CLA's CPU.
>
> Pinning vCPUs is not guaranteed. If the host decides to power off the
> CPUs with assigned CLAs, the guest application can't access the assigned
> device anymore. It would now access a RAZ/WI memory region.
>
> For DMA, because the TLB entries tagged with VMID+ASID are shared
> between CPU and accelerator, we pin the VMID. The stage 2 page tables
> are shared between CPU and CLA. CLA reports DMA page faults directly to
> the user, who performs the access from the CPU to handle both stage 1
> and stage 2 faults.
>
> Signed-off-by: Jean-Philippe Brucker <jpb@kernel.org>

I understand the patch as this:

The CLA register window of the CLA attached to one certain CPU
can be exposed to a virtual machine by way of VFIO, that is, this
virtual machine can see that memory as if was its own.

This makes me ask the following questions:

1. Is the intended user of that VFIO window a kernel driver or
"some userspace mockery", i.e. a plain old userspace driver just
using the hardware from userspace. This is something I have
seen in code trees from the likes of SpaceX, where VFIO is
used for antenna array hardware and handled with userspace
drivers (and the userspace driver
is run with realtime priorities for high responsivity usecases).
The use case matters for the design of the VFIO exposure,
because if in-kernel users of the same hardware from the
host can be expected this could become less than elegant.
I don't know for sure, it may make perfect sense if the user
is some userspace process doing some computation I need
not worry my head about.

2.The affinity story again: certainly this VM must be pinned to
the CPU exposing the CLA and the VM will see *one* CPU
in its world, or this would never work, right? We are not doing
any multicore virtualized machines because then you would
need each to expose a different VFIO window for each CPU?
(I think I saw the kvm usecase only allowing for one instance,
no domains, so I guess yes.)

I don't know how much VMs migrate on a running system.
But if a "normal" VFIO window pertains to the "normal"
physical address space I suppose this is not a problem, you
can move the VM to another CPU and everything else
remains the same. But not so with CLA! So how do you
intend to impose this restriction?

Yours,
Linus Walleij
