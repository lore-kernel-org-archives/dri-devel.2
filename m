Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB389CC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 10:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E757610E14B;
	Fri, 16 Oct 2026 10:49:41 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A464F10E14B
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 10:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
 From:Subject:Message-ID:From:Reply-To;
 bh=811WyW3qJgjU2G2IECuo6RCn5vOkeoECJJM8V3lAM3c=; b=eRfzoi5LMygyAhLZvjFebJXCZZ
 ggKbswHyWGBlL4C9OfTYzBxSIyV9wJCBynKN+zMquSsEksW3sAFJe8YQVoxkA1mvSOk2soQWh2hqD
 IkU6Vk6xIevjT6gecondf6VexhiQKgOUupsehTu2QEagXEN+g9G586EgoOPwr0BCb2WbXA16EN791
 kj+FzMPSa9p3DRTrUOwivTzZFRGmLcSOHpMuKRLEnJaznP11rcbS7md4eVJcvbBa1xeq/O/x4kX7d
 QYP+zoV7CNHlmgxhKY5BT+TbkSrLf2pKpzmfu8gEZyIfIDS3hW84caOAUZmIY/Zi7+app3mztbega
 Se5YVnJg==;
Received: from 89.141.155.109.dyn.user.ono.com ([89.141.155.109]
 helo=[192.168.0.17]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xHfVB-0010Po-Uf; Fri, 16 Oct 2026 12:49:29 +0200
Message-ID: <59b211bed3d8256f9ec22f860eabe04bac6be132.camel@igalia.com>
Subject: Re: [PATCH 05/11] drm/vc4: Attach the job fences outside of job_lock
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Maxime Ripard
 <mripard@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Date: Fri, 16 Oct 2026 12:49:19 +0200
In-Reply-To: <d6800fd5-73c8-40e4-9470-0db7e72694fd@igalia.com>
References: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
 <20261004-vc4-misc-fixes-v1-5-b763df9e33e1@igalia.com>
 <ac9b63c893795494d2b2ec128d3974713fdcc70d.camel@igalia.com>
 <d6800fd5-73c8-40e4-9470-0db7e72694fd@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
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

El jue, 15-10-2026 a las 16:45 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> Hi Iago,
>=20
> On 13/10/26 04:28, Iago Toral wrote:
> > El dom, 04-10-2026 a las 12:42 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> > > vc4_attach_fences() adds the job fence to the reservation of
> > > every BO
> > > the
> > > job touches, which is a O(bo_count) walk under job_lock. It was
> > > there
> > > because vc4_exec_info could be freed by the job done worker the
> > > moment the
> > > lock was dropped.
> > >=20
> > > As vc4_exec_info is refcounted now, hand the fences over after
> > > the
> > > unlock.
> > >=20
> > > Note that the render done handler dropped the fence as soon as
> > > the
> > > job
> > > completed, so the walk could find exec->fence already cleared.
> > > Leave
> > > the
> > > fence to be dropped by the release path. The submit path no
> > > longer
> > > needs
> > > a reference of its own to publish the fence through the sync
> > > object
> > > either.
> > >=20
> > > Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> > > ---
> > > =C2=A0=C2=A0drivers/gpu/drm/vc4/vc4_gem.c | 23 ++++++----------------=
-
> > > =C2=A0=C2=A0drivers/gpu/drm/vc4/vc4_irq.c |=C2=A0 5 +----
> > > =C2=A0=C2=A02 files changed, 7 insertions(+), 21 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/vc4/vc4_gem.c
> > > b/drivers/gpu/drm/vc4/vc4_gem.c
> > > index 9cf343297f83..ae76868663ea 100644
> > > --- a/drivers/gpu/drm/vc4/vc4_gem.c
> > > +++ b/drivers/gpu/drm/vc4/vc4_gem.c
> > > @@ -639,14 +639,6 @@ vc4_queue_submit(struct drm_device *dev,
> > > struct
> > > vc4_exec_info *exec,
> > > =C2=A0=20
> > > =C2=A0=C2=A0	kref_get(&exec->refcount);
> > > =C2=A0=20
> > > -	/* The job can complete and drop exec->fence as soon as
> > > job_lock is
> > > -	 * released, so hold our own reference.
> > > -	 */
> > > -	if (out_sync)
> > > -		dma_fence_get(&fence->base);
> > > -
> > > -	vc4_attach_fences(exec);
> > > -
> > > =C2=A0=C2=A0	list_add_tail(&exec->head, &vc4->bin_job_list);
> > > =C2=A0=20
> > > =C2=A0=C2=A0	/* If no bin job was executing and if the render job (if
> > > any) has the
> > > @@ -663,12 +655,12 @@ vc4_queue_submit(struct drm_device *dev,
> > > struct
> > > vc4_exec_info *exec,
> > > =C2=A0=20
> > > =C2=A0=C2=A0	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
> > > =C2=A0=20
> > > +	vc4_attach_fences(exec);
> > > +
> >=20
> > Similar question as before: doesn't this mean we may submit this
> > job
> > before we have installed the fences in the BO reservations?
> > Wouldn't
> > that mean there is a small window where the BOs look idle to other
> > users when they are in fact being used by the GPU?
> >=20
>=20
> In this case, the window exists, but it isn't observable in a way
> that
> actually matters. The reservations stay locked until drm_exec_fini(),
> which runs after the fences are attached, so anyone taking the resv
> lock, including another submit touching the same BOs, waits for them.
> Other drivers, such as V3D and Panfrost, follow the same pattern:
> push
> jobs -> attach fences -> replace the out syncobjs fences.
>=20

Great, thanks, we may want to add small comments in both patches to
make these things explicit since I don't think they are immediately
obvious.

With that, you can add my R-B to both patches too.

Iago
> Best regards,
> - Ma=C3=ADra
>=20
>=20

