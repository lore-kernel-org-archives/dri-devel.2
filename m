Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B42CA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 12:05:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CF7D10E0D4;
	Thu,  8 Oct 2026 12:05:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="YBYNi6Yv";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAC1610E0D4
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 12:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
 From:Subject:Message-ID:From:Reply-To;
 bh=yOs+iWcseqY4KbNaq0+0T4jueAz2DpXNYN+w1w1HsAE=; b=YBYNi6YvWXiTBxuK8K6P4fgCJd
 hxhDNcNU/ql13dG3JHkCE5pdJMNu21Ki7p61sukB3LiC4jUwfPtiu43kSHebT1iHtIG+0pXF8T4tI
 wcPUdVqQEJom+e4ibPhHWJVS6y2ndKWVCO8qn0alGUdF+98JoPgpeDWdyc9+anboNM266yRs63gZ/
 i/vFRiJBvqXsBvkyVkPl1lFmj+w9gDohutIgkbO8/vhVOWB7DrJA8l5kaVO5eQjuQBFq6f9/hZdZp
 2AExM5oGgHpWVZzYaPpwvfzy3vLD1WbRoG+K3e5Xq24o8BBd8Pmp5ee8iPHuNDVFwgt+gjN52TFjw
 rTpZZcrg==;
Received: from [148.56.135.230] (helo=[192.168.0.17])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xEmsb-00ESSx-21; Thu, 08 Oct 2026 14:05:45 +0200
Message-ID: <21aefdf82522c9e4ca8fb187ef0f4565a89fd665.camel@igalia.com>
Subject: Re: [PATCH] drm/vc4: Disable the V3D interrupt across runtime suspend
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Maxime Ripard
 <mripard@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
Date: Thu, 08 Oct 2026 14:05:34 +0200
In-Reply-To: <5f934e82-62e6-4be3-9ace-f591fd95f7b7@igalia.com>
References: <20260925191318.541938-1-mcanal@igalia.com>
 <749f58993b891f756cde15e1408b1e98b861ce54.camel@igalia.com>
 <5f934e82-62e6-4be3-9ace-f591fd95f7b7@igalia.com>
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

Thanks, this is:

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

El jue, 08-10-2026 a las 08:50 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> Hi Iago,
>=20
> On 08/10/26 08:21, Iago Toral wrote:
> > Looks good to me, I have a couple of questions below:
> >=20
> > El vie, 25-09-2026 a las 16:10 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> > (...)
> > > diff --git a/drivers/gpu/drm/vc4/vc4_irq.c
> > > b/drivers/gpu/drm/vc4/vc4_irq.c
> > > index 7877d493d80e..98a8db720091 100644
> > > --- a/drivers/gpu/drm/vc4/vc4_irq.c
> > > +++ b/drivers/gpu/drm/vc4/vc4_irq.c
> > > @@ -276,7 +276,7 @@ vc4_irq_disable(struct drm_device *dev)
> > > =C2=A0=C2=A0	V3D_WRITE(V3D_INTCTL, V3D_DRIVER_IRQS);
> > > =C2=A0=20
> > > =C2=A0=C2=A0	/* Finish any interrupt handler still in flight. */
> > > -	synchronize_irq(vc4->irq);
> > > +	disable_irq(vc4->irq);
> >=20
> > With this change, do we still need the 2 V3D_WRITEs above this?
>=20
> Yes, because, before disabling the IRQ, we must make sure that the
> V3D interface is quiet.
>=20
> > >=20
> > >=20
> > > =C2=A0=C2=A0	cancel_work_sync(&vc4->overflow_mem_work);
> > > =C2=A0=C2=A0}
> > > @@ -284,7 +284,6 @@ vc4_irq_disable(struct drm_device *dev)
> > > =C2=A0=C2=A0int vc4_irq_install(struct drm_device *dev, int irq)
> > > =C2=A0=C2=A0{
> > > =C2=A0=C2=A0	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
> > > -	int ret;
> > > =C2=A0=20
> > > =C2=A0=C2=A0	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
> > > =C2=A0=C2=A0		return -ENODEV;
> > > @@ -298,19 +297,8 @@ int vc4_irq_install(struct drm_device *dev,
> > > int
> > > irq)
> > > =C2=A0=C2=A0	init_waitqueue_head(&vc4->job_wait_queue);
> > > =C2=A0=C2=A0	INIT_WORK(&vc4->overflow_mem_work,
> > > vc4_overflow_mem_work);
> > > =C2=A0=20
> > > -	/* Clear any pending interrupts someone might have left
> > > around
> > > -	 * for us.
> > > -	 */
> > > -	V3D_WRITE(V3D_INTCTL, V3D_DRIVER_IRQS);
> >=20
> > Why this change?
>=20
> vc4_irq_install() is now called before PM resume, so it can't access
> HW
> registers and that's okay, because cleaning pending interrupts is
> done
> during resume.
>=20
> Best regards,
> - Ma=C3=ADra
>=20
> >=20
> > > -
> > > -	ret =3D devm_request_irq(dev->dev, irq, vc4_irq, 0,
> > > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_name(dev->dev), dev);
> > > -	if (ret)
> > > -		return ret;
> > > -
> > > -	vc4_irq_enable(dev);
> > > -
> > > -	return 0;
> > > +	return devm_request_irq(dev->dev, irq, vc4_irq,
> > > IRQF_NO_AUTOEN,
> > > +				dev_name(dev->dev), dev);
> > > =C2=A0=C2=A0}
>=20
>=20

