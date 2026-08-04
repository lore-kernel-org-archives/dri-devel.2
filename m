Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D722C5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 14:42:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DA6810EAC1;
	Tue,  4 Aug 2026 14:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="HtH0Ve/V";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BED810EAC2
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 14:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785854530;
 bh=OqhWvtZXhc+G73nSM63Uipt1epzkVmRKYCPHPRJIK0Q=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=HtH0Ve/VLbxeWT20pqClozODac1Dw4+T1z2o+/A49QRdMP7pNhRDg73VMW74+qIo/
 1Myw+x4+SK7EUzokQ2g1afHUPDhju9Zc78F7603PJMDdlCHVA50LZCX+CJXMM0F50p
 UImFSnEFG1TZJLsSL1qLB3UObDnRl70W3kgJHo7UWmMd0HPita46KqAZm8wo2EZGwO
 h8/mYsGf/09/AoX4XceNBuio8K5egqnTVoWrj+vXJTBJLcu8FzHRYu8ek8MNSThce6
 toIGSNV9gvyYoypdleU7GYq4PpCRSsxB6jPAfzCFP4Eqg4S6TGjZci2m/K3t/KuWgn
 d6R35ElJDipgw==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1468917E052F;
 Tue, 04 Aug 2026 16:42:10 +0200 (CEST)
Date: Tue, 4 Aug 2026 16:42:06 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Alex Williamson
 <alex@shazbot.org>, bcm-kernel-feedback-list@broadcom.com, Christian Koenig
 <christian.koenig@amd.com>, David Hildenbrand <david@kernel.org>,
 dri-devel@lists.freedesktop.org, Fei Li <fei1.li@intel.com>, Huang Rui
 <ray.huang@amd.com>, linux-mm@kvack.org, linux-s390@vger.kernel.org, Michal
 Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>, Sergio Lopez
 <slp@redhat.com>, Sean Christopherson <seanjc@google.com>, Thomas
 Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/6] drm/shmem_helper: use vmf_insert_pfn_mkwrite()
Message-ID: <20260804164206.655874ce@fedora-21.home>
In-Reply-To: <CABgObfbAveuhkjXzmemvGtycmcmDePKABr8Q35Y9mZP0den5aA@mail.gmail.com>
References: <20260804120529.1730187-1-pbonzini@redhat.com>
 <20260804120529.1730187-3-pbonzini@redhat.com>
 <20260804161549.4cd9a66f@fedora-21.home>
 <20260804161850.58c55c6e@fedora-21.home>
 <CABgObfbAveuhkjXzmemvGtycmcmDePKABr8Q35Y9mZP0den5aA@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Tue, 4 Aug 2026 16:34:10 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On Tue, Aug 4, 2026 at 4:19=E2=80=AFPM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> > On Tue, 4 Aug 2026 16:15:49 +0200
> > Boris Brezillon <boris.brezillon@collabora.com> wrote: =20
> > > Actually, if we're making the drm_gem_shmem_record_mkwrite() call
> > > unconditional (for PTE and PMD updates) in that path, can't we drop t=
he
> > > drm_gem_shmem_pfn_mkwrite() call living in drm_gem_shmem_pfn_mkwrite(=
)?
> > >
> > > Also, I'm not even sure we can end up with write=3Dtrue for PTE updat=
es,
> > > because our pfn_mkwrite implementation returns zero, not VM_FAULT_ERR=
OR
> > > or VM_FAULT_NOPAGE. This means the default RO -> RW PTE upgrade
> > > implemented in finish_mkwrite_fault() [1] will take place. If we real=
ly
> > > want out try_insert_pfn() to be called for those RO -> RW updgrades, =
we
> > > need to call try_insert_pfn() from drm_gem_shmem_pfn_mkwrite(). =20
> >
> > Nevermind, it's all explained in the comment you've added. Sorry for
> > the noise. I keep wondering if we shouldn't call try_insert_pfn() from
> > pfn_mkwrite() though, like is done in other places. =20
>=20
> No, the .pfn_mkwrite() callback is invoked when a PTE already exists,
> and mm/ already takes care of making it writable. So there's nothing
> to insert, you just have to take note which you do with
> drm_gem_shmem_record_mkwrite().

Okay, I thought I'd ask to be sure, because of all the implementations
of pfn_mkwrite listed here [1], only drm_gem_shmem_helper.c and
kernel/events/core.c do that. The rest have their "generic" fault
handler (by generic I mean a fault handler helper that covers all the
order/WRITE_FLAG combinations) called from pfn_mkwrite(), and return a
non-zero vm_fault_t.

[1]https://elixir.bootlin.com/linux/v7.2-rc5/A/ident/pfn_mkwrite
