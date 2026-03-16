Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D4AF4644B
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09A2210E3BF;
	Mon, 16 Mar 2026 10:42:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="hg/W6llx";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65C3C10E3B6
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 10:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1773657736;
 bh=ceW70cFZ9Tuf9jzdHR9cUAipzhtkxyzpP9JZGb3Xphc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=hg/W6llx6zg3IO6CsM4WAREG141CSmZ0pJRG5y7qi7Dg8LOkiYj1c6G+M3YWEsQgH
 6o4oUES9qyzrvdIaSkUodKd9Ht4ft0GotjSwR0BnUKD9y3Z6YkY8X3B2k1Fw/vzQkW
 46Lk1njR+AwI6ge1LUXs8z1CNs92ceYE+Xcnd/pyZRQUfGHISfxl/U5n03SojyzDvQ
 sGSPUxRuKLBr2W3RORjDPcu/LLAGFTDqvCqlhztELM3KAluwnT4Yi9sQQ8y3tTY0p2
 f07OHDyMhhWQDJbxmDjpluNCb7E9lUETsbYT7KAQk6IbSYekAbP+UrjYdt3rqeZNxg
 8XzsnL1RwRkcg==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B21CA17E0E4C;
 Mon, 16 Mar 2026 11:42:15 +0100 (CET)
Date: Mon, 16 Mar 2026 11:42:11 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/shmem-helper: Fix Map huge page mapping in fault
 handler
Message-ID: <20260316114211.4d2f0a71@fedora>
In-Reply-To: <f162dafb-4282-41db-a696-b993de875736@suse.de>
References: <20260316002649.211819-1-pedrodemargomes@gmail.com>
 <004c48cb-196a-4aac-bfc4-c440c9fd74d2@suse.de>
 <20260316102810.7b26c5ec@fedora>
 <f162dafb-4282-41db-a696-b993de875736@suse.de>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
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

On Mon, 16 Mar 2026 11:12:45 +0100
Thomas Zimmermann <tzimmermann@suse.de> wrote:

> Hi
>=20
> Am 16.03.26 um 10:28 schrieb Boris Brezillon:
> [...]
> >>> -static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
> >>> +static vm_fault_t drm_gem_shmem_any_fault(struct vm_fault *vmf, bool=
 try_pmd) =20
> >> Please write two functions. One for huge pages and one for regular page
> >> faults. =20
> > That's actually what the first version of the patch was doing, and I
> > strongly disagree with that. In my opinion, it's more error-prone to
> > have two distinct implementations duplicating most of the logic
> > (locking, bookkeeping, ...) than having both handled in the same
> > function and have dummy wrappers to decide the kind of vmf_insert_pfn
> > to do (_pmd vs regular). Think about the folio_mark_accessed() you
> > recently added, and how easy it would have been to add it to
> > drm_gem_shmem_fault() and forget it in the huge_fault handler. =20
>=20
> But that would be a _simple_ one-time fix.=C2=A0 All these branching any=
=20
> parameterization will stay for _all_ later changes to that code.

But you'll have to deal with these two distinct fault cases in the long
run anyway. Again, look at the access tracking you've added, it has to
apply to huge folios too, so why have two completely distinct functions
that do exactly the same except for the kind of page they insert into
the page table.

>=20
> There's little to be gained from cramming things into single functions.=20
> I'd say that we have two distinct fault callbacks for huge pages and=20
> regular ones already support this point.

The bulk of the code is the same, the only bits that differ are the
function we use to insert the pfn. Again, if we were to duplicate it'd
be more error-prone, because then you have to update two places every
time you fix/add something. And it's not like we'd be the only ones to
do this sort of multiplexing, see [1][2]. So I'm still very much in
favor of this common drm_gem_shmem_any_fault(), and then have
fault/huge_fault implementation call that thing with the proper
parameters.

[1]https://elixir.bootlin.com/linux/v6.19.8/source/fs/xfs/xfs_file.c#L1889
[2]https://elixir.bootlin.com/linux/v6.19.8/source/fs/fuse/dax.c#L796
