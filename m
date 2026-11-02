Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626B5606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 07:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=WHk7qfp1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A42E010E554;
	Mon,  2 Nov 2026 07:31:15 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0D9610E554
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 07:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
 From:Subject:Message-ID:From:Reply-To;
 bh=IzxFenk2G7VefJKCYkyvqMIK7vNzaeYCCl7lHKySqeY=; b=WHk7qfp1pQYFR16LwBuP1BdPrV
 bO+zIkDYXOY/48NsWDmt2lT/HkODjJJIWKcXQH1gnhmJKc/CC1IanQjJbIfsU9d6FciA1mAyuHRjA
 JzK++EvqC0lbyMIEI+UGfa2dDbzGuzoyaqX/OOKN8J7StZjW6lHRMN9ttmLl3tcnt9G3XjAEZ3J1j
 TTBPAJOVYq6VfvLjL3x2aG1ieeMVacA5BCV5HSPr1R7LfDEP/FeJSqldTJrP8qvDGNXVNckK+YDsI
 zILrpUTIT9JZ+gAaINjOoP2cWZgGairKelJoIbghrUMzR3WlyT3+zXPir4BhD2Vf4b3DUGa8wtq7O
 oLdYvI0g==;
Received: from 84.124.56.23.static.user.ono.com ([84.124.56.23]
 helo=[192.168.0.17]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xNmVX-00HUXo-Gv; Mon, 02 Nov 2026 08:31:07 +0100
Message-ID: <eb5603b15e2154d07b5dc3574026a466b0988877.camel@igalia.com>
Subject: Re: [PATCH 1/2] drm/v3d: Initialize timedout_batches when running a
 CSD job
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Jose Maria
 Casanova Crespo <jmcasanova@igalia.com>, Melissa Wen <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com, 
 stable@vger.kernel.org
Date: Mon, 02 Nov 2026 08:30:56 +0100
In-Reply-To: <20261101125619.2465064-1-mcanal@igalia.com>
References: <20261101125619.2465064-1-mcanal@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Good catch, both patches are:

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

El dom, 01-11-2026 a las 09:53 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> From: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
>=20
> v3d_csd_job_timedout() decides whether a compute job made progress by
> comparing CSD_CURRENT_CFG4, the number of batches the dispatcher
> still
> has to start, against the value saved at the previous timeout. That
> saved value is never initialized, so it is zero on the first timeout.
>=20
> On V3D 7.1.6 and later, CFG4 counts down to zero once the dispatcher
> has
> started the last batch, but the dispatch keeps running until the
> batches
> in flight complete. If the first timeout fires in that window, the
> handler sees no change and resets the GPU while the job is about to
> complete. For example, this happens with long dispatches that only
> keep a
> single supergroup in flight.
>=20
> Initialize timedout_batches to the value programmed in CFG4 when the
> job
> is started. The register does not return to it once a batch has
> started:
> it counts down to zero on V3D 7.1.6 and later (CFG4 holds the number
> of
> batches), and to 0xffffffff on V3D 4.2 (CFG4 holds the number of
> batches
> minus one).
>=20
> Cc: stable@vger.kernel.org
> Fixes: d223f98f0209 ("drm/v3d: Add support for compute shader
> dispatch.")
> Signed-off-by: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---
> =C2=A0drivers/gpu/drm/v3d/v3d_sched.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c
> b/drivers/gpu/drm/v3d/v3d_sched.c
> index e6283a75bcdf..002116efc874 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -360,6 +360,8 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
> =C2=A0		dma_fence_put(job->base.irq_fence);
> =C2=A0	job->base.irq_fence =3D dma_fence_get(fence);
> =C2=A0
> +	job->timedout_batches =3D job->args.cfg[4];
> +
> =C2=A0	trace_v3d_submit_csd(dev, to_v3d_fence(fence)->seqno);
> =C2=A0
> =C2=A0	v3d_job_start_stats(&job->base);

