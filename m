Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ADE606A326
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=LPIX6KOw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F10D10F9EF;
	Wed, 11 Nov 2026 09:13:35 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AA1210F9EB
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794388406;
 bh=J9GiVRQ83i6i/AYh9VW9zIfQz9HNAXKKGw4ZG9KmoAY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=LPIX6KOwIg6Idk6daVeq9ZN+u/J5Cv2XjdoBYAex+rb55g6SANkElYYU6iEfnh0fM
 zmppvMMaiT/i+DP//SSEtHCH+6YJc26V4cqcAROdCL1hCY3cit2YzuNPFkWNV437nc
 2VCaTP3depWQcm6dfJDdiXvA/a40L7wAsBF6IwklE1ah7i5goXWDy4odjPcN+sYl1W
 4uYYQNiwq06XQSe6fM6RoEWGPUOUem+EBM1ZCb8b+0RLU2akAh+4Rqpe7aRpfQ9noe
 R1xmNoZm12XeSjeq+DpozBkUKyUStH2PEXCIpdyIlXelBVMOdBfentdBM7m7Q+mxph
 LuwoR8wLPjojg==
Received: from fedora1.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 6087517E0564;
 Wed, 11 Nov 2026 10:13:26 +0100 (CET)
Date: Wed, 11 Nov 2026 10:13:22 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Igor Torrente <igor.torrente@collabora.com>
Cc: "Daniel Stone" <daniel@fooishbar.org>, "steven.price"
 <steven.price@arm.com>, "liviu.dudau" <liviu.dudau@arm.com>,
 "maarten.lankhorst" <maarten.lankhorst@linux.intel.com>, "mripard"
 <mripard@kernel.org>, "tzimmermann" <tzimmermann@suse.de>, "airlied"
 <airlied@gmail.com>, "simona" <simona@ffwll.ch>, "dri-devel"
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/panthor: Allow exporting BOs with an exclusive VM
Message-ID: <20261111101322.1f8ad691@fedora1.home>
In-Reply-To: <1a1c7afd214.86b85fab5104718.5707465917195522525@collabora.com>
References: <20261109105652.7114-1-igor.torrente@collabora.com>
 <CAPj87rM3_MCFMGSAL1P6hBzLsLNP0hNL58whe1AeegtxMvgBhA@mail.gmail.com>
 <20261110091006.60c88c61@fedora1.home>
 <1a1c7afd214.86b85fab5104718.5707465917195522525@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 10 Nov 2026 19:59:10 -0300
Igor Torrente <igor.torrente@collabora.com> wrote:

> De: Boris Brezillon <boris.brezillon@collabora.com>
> Para: "Daniel Stone"<daniel@fooishbar.org>
> Cc: "Igor Torrente"<igor.torrente@collabora.com>, <steven.price@arm.com>,=
 <liviu.dudau@arm.com>, <maarten.lankhorst@linux.intel.com>, <mripard@kerne=
l.org>, <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>, <dri=
-devel@lists.freedesktop.org>
> Fecha: mar, 10 nov. 2026 05:10:06 -0300
> Asunto: Re: [PATCH] drm/panthor: Allow exporting BOs with an exclusive VM
>=20
>  > On Mon, 9 Nov 2026 17:38:57 +0000
>  > Daniel Stone <daniel@fooishbar.org> wrote:
>  >  =20
>  > > Hi Igor,
>  > >=20
>  > > On Mon, 9 Nov 2026 at 10:57, Igor Torrente <igor.torrente@collabora.=
com> wrote: =20
>  > > > Panthor currently does not allow exporting BOs with an exclusive V=
M.
>  > > > However, VDRM (native context) drivers export BOs for import by th=
e guest
>  > > > VM, which does not attempt to bind them to any GPU VM.
>  > > >
>  > > > Allow these BOs to be exported and rely on
>  > > > panthor_vm_prepare_map_op_ctx() to reject attempts to bind them to=
 a
>  > > > different GPU VM.   =20
>  > >=20
>  > > I'm having a little trouble parsing this.
>  > >=20
>  > > Is the problem that:
>  > > - the guest requests allocation of a BO with exclusive_vm_root_gem =
=3D guest_vm
>  > > - the host passes that allocation through
>  > > - the host exports a dmabuf from the allocation (which fails)
>  > > - the host imports a dmabuf from the allocation (?)
>  > > - the guest requests the BO be attached to guest_vm
>  > >=20
>  > > i.e. is the problem that some host implementations (virglrenderer)
>  > > handle BO allocation exclusively via an export/import interface?
>  > >=20
>  > > If that is the problem, it seems like it would be cleaner to have the
>  > > host implementation strip the exclusive VM ID from the request, until
>  > > they can be fixed to not require the export/import dance. =20
>  >=20
>  > Dropping the exclusive_vm assignment is indeed an option. The big issue
>  > comes from the overhead incurred by BO access tracking when the BO is
>  > shared:
>  >=20
>  > - bo_wait() has to do a HANDLE_TO_FD + EXPORT_SYNC dance
>  > - attach_sync_point() has to do an EXPORT_SYNC_FILE + HANDLE_TO_FD +
>  >   IMPORT_SYNC_FILE dance
>  > - the locking of shared BOs in the GROUP_SUBMIT path is more costly
>  >   (one lock per shared BO instead of one lock for all private BOs)
>  >=20
>  > I don't have numbers, but I suspect lowering all private BOs to
>  > shared ones will have a noticeable impact on perfs.
>  >  =20
>=20
> Continuing from the previous response:
>=20
> Changing Vpipe won=E2=80=99t work. We still need to import the exclusive-=
VM blob
> to the Vpipe client, and the only way I=E2=80=99m aware of is by exportin=
g the BO.
>=20
> This leaves us with two possibilities: continue with this patch or strip
> the exclusive-VM.
>=20
> I ran benchmarks, and to my surprise, the results were very similar.
>=20
> ### Virtio_gpu
>=20
> | Exclusive-vm | Masked | Masked[1]       | Non-masked |
> |--------------|--------|-----------------|------------|
> | vkmark       | 1689   | 1702            | 1760       |
> | glmark       | 874    | black screen[2] | 909        |
> | paraview     | 13.04  | 13.29           | 13.44      |
>=20
> [1] Setting `exclusive_vm_id` as 0, but initializing `pan_kmod_bo_init`
>     with the `exclusive_vm_id`
> [2] `GROUP_SUBMIT failed: 22` (probably fixable)
>=20
> ### Vpipe
>=20
> | Exclusive-vm | Masked | Masked[1] | Non-masked |
> |--------------|--------|-----------|------------|
> | vkmark       | 999    | 1003      | 1033       |
> | glmark       | 768    | 867       | 869        |
> | paraview     | 13.87  | 14        | 13.73      |
>=20
> If these results are correct and representative, stripping `exclusive_vm`
> seems like a viable option.
>=20

Well, yeah, if it's doesn't make a difference, I'd go for the second
option (making all BOs shared by dropping the `exclusive_vm`).
