Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD647606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=ckO2gDgk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFF7810F8C2;
	Tue, 24 Nov 2026 23:04:21 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C284010E86D
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 23:04:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795561450; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SUe5/Jj/3I9NWOEFXaYcPp9uBrJ8eG9uaepsfhFBqMZ3jZx+2Dxk/mtmYh7Godt6LUxHFcYQOvFOoSvpM8SeDy+F1L4/rCftyKNN28xf95JEcZQ8qHow906Piq7TaoybWjNtXNKHwN3ng37+ynqWivT7jELXT9gtVVqLYUiYmwc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795561450;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=2ZI2PMlWOi8d0sJS2pMmeUrpaerAHWJIYWoUU7w6+Do=; 
 b=ThkirTkKbnMX4YVIkjNmpJzrs66wNSFxHI/RwDH/U79pv5F6s6Wj9aonu6ZKedSIredB5Dxp7pc5jGp3qvHNvDausMNon5sTQdasca/TWjEs/nD9mVDbJF4418abCy4hjVSaJee5N6pgYRAyn3azf8NjXy/rFl8ygeloP/FeZ58=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=ckO2gDgk/gybC1D14RZLNHsaK9ZN9LtGnGUenuNevZI/dRsLZAGycWhE59LCOd5fgnMT276G9zHV7xaZcc7bu8pfKdVk/oaiuFqQCOXZoehNpWtH47w8wSwQrG9Qi8RN4dTe/pn6zuQtVX65zwjOkynNvZ12TNjKZ7LHdTLbioU=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=2ZI2PMlWOi8d0sJS2pMmeUrpaerAHWJIYWoUU7w6+Do=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795561448079315.65968283457187; 
 Tue, 24 Nov 2026 15:04:08 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH 0/4] drm/tyr: use pin-init self-referential support
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DN2ZFO94BZMF.2XTCCKEUDLZSB@kernel.org>
Date: Tue, 24 Nov 2026 20:03:50 -0300
Cc: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 lossin@kernel.org, gary@garyguo.net, ojeda@kernel.org, boqun@kernel.org,
 bjorn3_gh@protonmail.com, a.hindborg@kernel.org, tmgross@umich.edu,
 tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BF029262-22D0-41EB-884B-8C64C6BAEBB8@collabora.com>
References: <20261118233727.3147222-1-dakr@kernel.org>
 <084F476A-BD3F-4FAA-B47C-E875B542AA1B@collabora.com>
 <DN2ZFO94BZMF.2XTCCKEUDLZSB@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-ZohoMailClient: External
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
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 23 Nov 2026, at 20:34, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On Mon Nov 23, 2026 at 11:20 PM CET, Daniel Almeida wrote:
>> Hi Danilo,
>>=20
>> Thanks for doing this.
>>=20
>> I spoke with Gary about this topic at Kangrejos and again a couple of =
weeks
>> ago. What worries me is that we might introduce some restrictions =
that might
>> paint us into a corner. IOW: we have significant downstream work, and =
I wonder
>> whether it will work with this series after whatever refactors are =
needed.
>=20
> The reason for the existence of the converted reference counts hasn't =
been that
> reference counting was needed as an ownership model, it just was that =
we haven't
> had a way to express borrowing from sibling fields that are already =
guaranteed
> to be longer lived in any case.
>=20
> The distinction is between A having an independent owner that keeps it =
alive for
> all B consumers, so the Bs can borrow A, and the Bs collectively =
owning A, so A
> is destroyed when the last B releases it. Reference counting expresses =
the
> latter ownership model. Both can still be subject to lifetime bounds.
>=20
> In the majority of cases, drivers acquire device resources in stages, =
keeping
> earlier resources alive until their dependants have been torn down. =
Where
> ownership follows this hierarchy, borrowing can express those =
relationships
> without reference counting.

Yeah, I understand the premise of self-ref pin init. My worry is =
precisely
whether most/all of the shared resources can indeed be modeled as a =
borrow on a
sibling or parent field. Especially resources created by userspace like =
user VMs
and CSF groups (equivalent to nouveau channels), or deferred work.

For example, your series does not have to consider user VMs because they =
are
not implemented yet. I wonder whether they can work under the proposed =
plan,
since user VMs will borrow the MMU, but struct Mmu is stored in the
registration data. Previously that was trivially solvable with Arc. =
You're
saying this is possible under the code you're proposing? Because at =
first
glance this looks like a shortening of 'iomem to 'a (from =
DriverFile<'a>),
which I assume the compiler would reject due to invariance?

>=20
>> To start with, Alvin's VM_BIND ioctl series [0] will need some =
changes, since
>> it keeps the VM pool in the file data. I think this is doable if we =
move the
>> pool into the registration data and have each file hold only an index =
to its
>> own entry?  i.e.: something like an XArray<Pool<Vm>> indexed by a =
number
>> associated with the drm::File. Same for the group pool later. Is this =
what you
>> had in mind?
>=20
> No, the changes do not force XArray<Pool<Vm>> to be moved into the =
registration
> data; drm::File private data can borrow from DRM registration data. It =
can (and
> should) stay in the drm::File private data.
>=20
> (I'm also working on a generalization of this, as it is a repeating =
pattern in
> drivers. We want driver private data associated with an ioctl, e.g.  =
VM_CREATE,
> which is shorter lived than the drm::File data and hence shorter lived =
than the
> drm::RegistrationData.
>=20
> Concurrent ioctls associated with a handle to this data, i.e. the VM =
in this
> example, need to be drained on either VM_DESTROY or drm::File private =
data
> destruction, e.g.  caused by unregistration through driver unbind.)
>=20
>> Anything storing a KernelBo will also have to be outside of the file =
data,
>> IIUC, since it now stores a &Vm. Also, downstream we defer KernelBo =
drops to a
>> workqueue, because they can happen in the fence signalling path. I =
suppose we
>> can keep doing that using ScopedWork/ScopedQueue?
>=20
> I assume you refer to the Vm that lives in Firmware. If so, drm::File =
private
> data can borrow from it, as Firmware lives in the DRM registration =
data.
>=20
> The teardown has to happen in ScopedWork regardless, as they all =
carried device
> resource induced lifetimes already and hence can't go into unbounded =
work
> anyway.

FWIW I meant both that one and user VMs (WIP), we map KernelBos into =
both
downstream.

This seems like another instance of what I asked above. If you confirm =
this is
indeed possible even with the invariance I mentioned, then fine, I =
guess.

To be honest, however, I must admit that the more I look into it and try =
to
understand the code, the more it looks like an improvement over the =
Devres
approach we have downstream.

=E2=80=94 Daniel

