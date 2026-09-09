Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8515EC79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC5F310F18D;
	Wed,  9 Sep 2026 13:55:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NtIyIZwG";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D080610F18D
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:55:29 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hg2Pn6f3mzKnP7;
 Wed, 09 Sep 2026 15:55:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1788962125; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9HuOb49my3ANCpYPmIDIpmU8QlJxqy2gxQn/eBQchu4=;
 b=NtIyIZwGfZs/bSz1LfwziDkzXMgjOpkNL/nvDutYipkyfiFUVhMH2izVhbBImuLkPGYhxm
 oovKSEPpXq4pSFoETWdQzkc7YDclRaOFcqoGnP8bz8aPYs4CGp0HV+GJmg/WxVSO3FNSwk
 Pd0hOi2w5XJJK9Jv3p8vg6L3gGrA3y05c/Y3YWJF0g/Zgslmz2Yf0/yh5EKGDTcqKX5ito
 p6/9Pfbcnl8j6BV5tuojTi6IN5CVz8f4ovVXrZ5We2Yle3FY9uNtgpaqwq4QzX3KmZTYBG
 j5NZRE5pK3EUUmV6l7QoEzCYSzUoQONiPbZJVNhGS6xgiUObn0WpMCSl4QPY3Q==
Message-ID: <9dedaa001c468be2afaf6ab19cd4f8cd96d0a8c7.camel@mailbox.org>
Subject: Re: [PATCH 2/2] drm/sched: document the RCU dependency
From: Philipp Stanner <phasta@mailbox.org>
To: christian.koenig@amd.com, malhyuk97@gmail.com, tursulin@ursulin.net, 
 matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com
Date: Wed, 09 Sep 2026 15:55:22 +0200
In-Reply-To: <20260909131808.2201-3-christian.koenig@amd.com>
References: <20260909131808.2201-1-christian.koenig@amd.com>
 <20260909131808.2201-3-christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: y5385w57kgiq1hkrxyodsepte56gnhs6
X-MBO-RS-ID: 7a86e2088934aeb0d8a
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, 2026-09-09 at 15:14 +0200, Christian K=C3=B6nig wrote:
> Tvrkos patches added RCU protection to the returned strings from
> get_timeline_name()/get_driver_name() callbacks of the dma_fence
> backends.
>=20
> This fixed use after free problems for a couple of drivers, but we never
> documented the consequences for the drm_sched_fence.
>=20
> Add a few words on the function documentation to note that we need an
> RCU grace period between signaling the last scheduler fence and
> scheduler teardown.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index 6cb6f9546493..22103cb07782 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -1203,6 +1203,10 @@ static void drm_sched_cancel_remaining_jobs(struct=
 drm_gpu_scheduler *sched)
> =C2=A0 * is implemented, all jobs will be canceled through it and afterwa=
rds cleaned
> =C2=A0 * up through &struct drm_sched_backend_ops.free_job. If cancel_job=
 is not
> =C2=A0 * implemented, memory could leak.
> + *
> + * The scheduler fences timeline name is returned protected by the signa=
led
> + * status and RCU, so an RCU grace period is necessary between signaling=
 the
> + * last scheduler fence and tearing down the scheduler who originated it=
.
> =C2=A0 */

The API user does not signal a "scheduler fence", typically. Are you
referring to the hardware-fence?

The user must signal all hardware-fences, which will cause all
finished-fences (which are at the root of the addressed problem) to be
signaled.

So what you probably want to say is "The user must wait one RCU grace
period between signaling the last hardware-fence and calling this
function because =E2=80=A6".


P.
