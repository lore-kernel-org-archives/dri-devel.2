Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93D3CD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 07:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C8F510F940;
	Wed,  3 Jun 2026 07:10:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="VfzF952H";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA71510F940
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 07:10:42 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gVf3z0rJcz9tsV;
 Wed,  3 Jun 2026 09:10:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1780470639; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3xTRblSttu6zwDnID4yfE/KJlAJ0qemUkg7n5y6NR3M=;
 b=VfzF952HVSra5GVkObVcEEANz0HarwcqkhHbBgTBKv2R514r8CRo/a3a3OgzXFa5iTVX5S
 jY41s/ZreVbbp4AMtYSxl0CYOTnw1b3+n8tVJfokAm83iihzD402R9ofvqEp17P+XX7idh
 IK9C886FX48QH8zejzYEJ5LqGHH/g3uK/mL72UttwVpHKE5PdU/DxV9UxSD4r4aCGNf6YN
 nlr0ENXNnaUxFItYFG1S9ro0ViOYWsGy8p6Eoomb+8oxW97soNz1lm3BpaAKqlBa/GlnV4
 3jti+EEcUoWH3aq2lVhTxe2eKltVHINs3IEXiCSpj5573rBe/ctaGSR73m+dMw==
Message-ID: <b065b85e15ade7a6e470745ba72c9381f3567ece.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: fix NULL deref when logging missing entity
 runqueue
From: Philipp Stanner <phasta@mailbox.org>
To: phasta@kernel.org, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Candice Li <candice.li@amd.com>, 
 dri-devel@lists.freedesktop.org
Cc: Alexander Deucher <alexander.deucher@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Date: Wed, 03 Jun 2026 09:10:34 +0200
In-Reply-To: <2f036bd31f8047c140644aae106084d46bcb50a1.camel@mailbox.org>
References: <20260603025636.1301481-1-candice.li@amd.com>
 <fbac6fc1-9efe-4b62-8352-b231879cf64d@amd.com>
 <2f036bd31f8047c140644aae106084d46bcb50a1.camel@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: rosjrf5ezp44kzng8wpssyryk1jkrmdq
X-MBO-RS-ID: 0b2475934bd70154eec
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

+Cc Tvrtko

On Wed, 2026-06-03 at 09:06 +0200, Philipp Stanner wrote:
> On Wed, 2026-06-03 at 09:00 +0200, Christian K=C3=B6nig wrote:
> > On 6/3/26 04:56, Candice Li wrote:
> > > job->sched is not initialized until drm_sched_job_arm(), so use
> > > pr_err() instead of dev_err(job->sched->dev, ...) when entity->rq
> > > is NULL.
> >=20
> > You need to CC the designated maintainer on stuff like that! Please use=
 get_maintainer.pl script.
>=20
> Thx, Christian
>=20
> >=20
> > Regards,
> > Christian.
> >=20
> > >=20
> > > Signed-off-by: Candice Li <candice.li@amd.com>
> > > ---
> > > =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 2 +-
> > > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm=
/scheduler/sched_main.c
> > > index bd7936c03da2aa..d21eada76cedf1 100644
> > > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > > @@ -806,7 +806,7 @@ int drm_sched_job_init(struct drm_sched_job *job,
> > > =C2=A0		 * or worse--a blank screen--leave a trail in the
> > > =C2=A0		 * logs, so this can be debugged easier.
> > > =C2=A0		 */
> > > -		dev_err(job->sched->dev, "%s: entity has no rq!\n", __func__);
> > > +		pr_err("*ERROR* %s: entity has no rq!\n", __func__);
>=20
> I think while at it you want to remove '*ERROR*' =E2=80=93 the pr_err etc=
.
> markers contain the qualifiers like _err, _warn etc. so that the level
> is already included for free.

OK, I couldn't see that Tvrtko already jumped in because of his other
patch.

https://lore.kernel.org/dri-devel/20260602153339.43453-1-tvrtko.ursulin@iga=
lia.com/T/#u

I think Tvrtko's patch looks not very controversial and allows us to
get rid of that code, so let's opt for that.

Thx
P.

>=20
> Regards
> P.
>=20
> > > =C2=A0		return -ENOENT;
> > > =C2=A0	}
> > > =C2=A0
