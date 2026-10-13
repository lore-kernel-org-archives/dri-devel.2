Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A98CA9ED2
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DBB910F71E;
	Tue, 13 Oct 2026 10:45:19 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3223A10F71E
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:45:13 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j3rZZ1pSjzMlRf;
 Tue, 13 Oct 2026 12:45:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1791888310; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jmn/xW5iGD8yCRxYTVI6Hm78eB9QipXWRBqQ6APWABw=;
 b=u+WD2b96qcUGSi1fn3K7aAbmTzkQq+u9oAWdPf3WK8PYwvKS+EONC1Lefc6Q+wogIc1nWk
 09VygvzwFT/l6cCNA+UIJ52IazmC38pts+jBUFHgwNpFoYibvKrIwfkdnuOfBvlKs3KATi
 FUQMTmR6X5NVEPGFIriieDOSBgi6SFYiFDkGlLUV86w05VPpBRRLFBdAq8lCrtPOBKnEFv
 tLEohCiF7LwRJjjvBc+Q0GikN49QYIe+wLJO521TVBJAhMX43fUUbVPT+58F1ruGFnCl2V
 mqxQ/q07S7x7uc9I4ZP4lMt4xXVCxiTe38yI5TRNchnJBHuiL+uyG6LjuepWTw==
Message-ID: <c4072b932f874bc1fc1bf60a0ead4948eff2b530.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Document entity->stopped is protect by
 entity->lock
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org, 
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, Matthew
 Brost	 <matthew.brost@intel.com>
Date: Tue, 13 Oct 2026 12:45:07 +0200
In-Reply-To: <103fba2b-c47f-4b17-a8a6-804ca00ff15a@igalia.com>
References: <20261002124655.74716-1-tvrtko.ursulin@igalia.com>
 <c7a17c258ae39abe74e7abe270aaee1daf31258d.camel@mailbox.org>
 <103fba2b-c47f-4b17-a8a6-804ca00ff15a@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
MIME-Version: 1.0
X-MBO-RS-META: 97kfmkbe3r3oyyrmg8mgub4hj83to8t4
X-MBO-RS-ID: 8ba5e6dab018773b195
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

On Mon, 2026-10-12 at 09:05 +0100, Tvrtko Ursulin wrote:
>=20
> On 08/10/2026 11:10, Philipp Stanner wrote:
> > On Fri, 2026-10-02 at 13:46 +0100, Tvrtko Ursulin wrote:
> > > Commit
> > > 0e118b936dc5 ("drm/sched: Lock drm_sched_entity_is_idle()")
> > > has removed the last unlocked entity->stopped access so lets official=
ly
> > > document it in kerneldoc as locked with the entity lock.
> >=20
> > Ah nice, I overlooked that. Thx for fixing.
> >=20
> > Nit: typo in the commit title, "protectED". I can fix that at applying
> > if you want.
>=20
> Ah yes, best not to spam the list for that. If you want I can push and=
=20
> tweak as well.

fine by me

Acked-by: Philipp Stanner <phasta@kernel.org>

>=20
> Tvrtko
> > >=20
> > > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > Cc: Danilo Krummrich <dakr@kernel.org>
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > Cc: Philipp Stanner <phasta@kernel.org>
> > > ---
> > > =C2=A0=C2=A0include/drm/gpu_scheduler.h | 2 +-
> > > =C2=A0=C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.=
h
> > > index 563d7fb88a6d..3b0978fa8cf0 100644
> > > --- a/include/drm/gpu_scheduler.h
> > > +++ b/include/drm/gpu_scheduler.h
> > > @@ -101,7 +101,7 @@ struct drm_sched_entity {
> > > =C2=A0=C2=A0	 *
> > > =C2=A0=C2=A0	 * Lock protecting the run-queue (@rq) to which this ent=
ity belongs,
> > > =C2=A0=C2=A0	 * @priority, @last_scheduled and the list of schedulers=
 (@sched_list,
> > > -	 * @num_sched_list) and @rr_ts.
> > > +	 * @num_sched_list), @rr_ts and @stopped.
> > > =C2=A0=C2=A0	 */
> > > =C2=A0=C2=A0	spinlock_t			lock;
> > > =C2=A0=20
