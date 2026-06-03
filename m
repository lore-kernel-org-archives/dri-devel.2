Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13E8CD6E4A
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 07:07:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1569310F939;
	Wed,  3 Jun 2026 07:07:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SsRsJR5b";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2B9410F939
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 07:07:23 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gVf081b29z9v4F;
 Wed,  3 Jun 2026 09:07:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1780470440; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Dj473r8+nD5Oi27Vywbuz8L7F2XHEyD7F9mjk3vQU4=;
 b=SsRsJR5b8vzYktQIkiqRziO3bwm4PhLXb8A6qwXm+5M5IUWqs76eM6R1nAkgiLeFc96q2x
 YTVaZv675qeuuPDkUrFFedW6Xfiw8lTuX5XBYHwDcDjU77kD2dK5F8UqIzja0P5ifqlBu8
 yfQb2C48iS3VjHPdQ4yGND+6D5Cvtgw6wGcePLnHMskGleUDmIzNh5t9jzGIouqVQVGZcA
 KyUMUD94hARt58Uxaw3vjWLf+O93AA1m4Dq3J8Rt6hYfWLmkOMV9Tzx8vxK5CO+zemTfA1
 E/0T891pq6XWBeMCojv7GXWswxDm5SeYh/C9j3JjbRryQHqqQfTAzrCwWOXIjw==
Message-ID: <2f036bd31f8047c140644aae106084d46bcb50a1.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: fix NULL deref when logging missing entity
 runqueue
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Candice
 Li	 <candice.li@amd.com>, dri-devel@lists.freedesktop.org, Philipp Stanner	
 <phasta@kernel.org>
Cc: Alexander Deucher <alexander.deucher@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>
Date: Wed, 03 Jun 2026 09:06:55 +0200
In-Reply-To: <fbac6fc1-9efe-4b62-8352-b231879cf64d@amd.com>
References: <20260603025636.1301481-1-candice.li@amd.com>
 <fbac6fc1-9efe-4b62-8352-b231879cf64d@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 6c7b5a773e42d2bf526
X-MBO-RS-META: bsonbugpkhbqzrzc8pppcqn1osetuu76
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

On Wed, 2026-06-03 at 09:00 +0200, Christian K=C3=B6nig wrote:
> On 6/3/26 04:56, Candice Li wrote:
> > job->sched is not initialized until drm_sched_job_arm(), so use
> > pr_err() instead of dev_err(job->sched->dev, ...) when entity->rq
> > is NULL.
>=20
> You need to CC the designated maintainer on stuff like that! Please use g=
et_maintainer.pl script.

Thx, Christian

>=20
> Regards,
> Christian.
>=20
> >=20
> > Signed-off-by: Candice Li <candice.li@amd.com>
> > ---
> > =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/s=
cheduler/sched_main.c
> > index bd7936c03da2aa..d21eada76cedf1 100644
> > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > @@ -806,7 +806,7 @@ int drm_sched_job_init(struct drm_sched_job *job,
> > =C2=A0		 * or worse--a blank screen--leave a trail in the
> > =C2=A0		 * logs, so this can be debugged easier.
> > =C2=A0		 */
> > -		dev_err(job->sched->dev, "%s: entity has no rq!\n", __func__);
> > +		pr_err("*ERROR* %s: entity has no rq!\n", __func__);

I think while at it you want to remove '*ERROR*' =E2=80=93 the pr_err etc.
markers contain the qualifiers like _err, _warn etc. so that the level
is already included for free.

Regards
P.

> > =C2=A0		return -ENOENT;
> > =C2=A0	}
> > =C2=A0
