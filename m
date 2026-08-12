Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC73C5B567
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B29D510EE9C;
	Wed, 12 Aug 2026 07:36:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ahaOaeuj";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC45510EE9C;
 Wed, 12 Aug 2026 07:36:27 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hKgKC2bJzzMlKq;
 Wed, 12 Aug 2026 09:36:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1786520182; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7UtIRYxm8TUl+aWiJtE4ZvgFUyRqXk4tQehg0VI2a8Q=;
 b=ahaOaeujFT2lqHUF91N0J2nuw+IDdpZHzMHMsRulOxxlkgkhBboAvSL0/Mr16iR9C9YTQQ
 hYrJl/NaL1tmNfCTSVtxMILcFnScHFJI4FwVzIPcmSiGlrCCXU0nzPVhHIfM9JY8RAz8iZ
 rZXSdHcBecO6WYypwG+j0G9f15koC5G9ZChEi54fUPhhffX5elCLjpL3aXvBH024v/5sIn
 3WIybJATV5PHi51IUhGXNOBZB755F9BjC50VYXKeZXVBI5gZ8JxW62vGLOYqbZSMjIYfBe
 B8FN72G5gyiG7zfcRmKlk17rJgPFE+CS58xBiFHaI+KmumF5KCOlHs2v1RwcXg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of phasta@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=phasta@mailbox.org
Message-ID: <9a349d1e5999fff97d6bada0a23273bf56a44240.camel@mailbox.org>
Subject: Re: [PATCH v2 00/20] Revert switching default DRM scheduler policy
 to fair
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Luke.Wildhardt@proton.me, Matthew Brost	
 <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard	
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Date: Wed, 12 Aug 2026 09:36:04 +0200
In-Reply-To: <bbe573b2-cee8-4647-bb75-662ced57b2d3@igalia.com>
References: <20260811140738.96974-1-tvrtko.ursulin@igalia.com>
 <c8f1e84b8ee1b51e6927c8252d28ef89d26cecb8.camel@mailbox.org>
 <bbe573b2-cee8-4647-bb75-662ced57b2d3@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: s6a3djfzco167zc5bnp4mkrd5zzs5ejj
X-MBO-RS-ID: eab0e299b0f94658499
X-Rspamd-Queue-Id: 4hKgKC2bJzzMlKq
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

On Tue, 2026-08-11 at 18:14 +0100, Tvrtko Ursulin wrote:
>=20
> On 11/08/2026 15:42, Philipp Stanner wrote:
> >=20

[=E2=80=A6]

> > Acked-by: Philipp Stanner <phasta@kernel.org>
> >=20
> >=20
> > Doesn't yet apply to drm-misc-fixes, I suppose because of the merge
> > yesterday.
> >=20
> >=20
> > =C2=A0From my POV you can push this to misc-fixes if you can make it ap=
ply;
> > hopefully it's not too late for v7.2
>=20
> I've rebased against drm-misc-fixes, posted v3 and pushed it. I wanted=
=20
> to prioritise getting the reverts in quickly to not miss the fixes pull=
=20
> rq so I did not log the acks against all patches since there is a lot of=
=20
> them. There were two small conflicts while building drm-tip so fingers=
=20
> crossed that's all good. I compile re-tested both drm-misc-fixes with
> all affected drivers, and drm-tip for x86 only.

Only saw this now. I think the Acks are not optional and adding them
would have taken 3 minutes; but it is now what it is.

Thanks for reacting quickly.

Assuming we run into no further problems, we can continue with CFS
slow-paced throughout the next cycles


P.
