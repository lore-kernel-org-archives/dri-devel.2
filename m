Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29389C79F99
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0286B10E1D7;
	Mon,  7 Sep 2026 10:47:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZFtCqAmp";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81BC210E1D7
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 10:47:40 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hdkKz6B2WzKmV7;
 Mon, 07 Sep 2026 12:47:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1788778055; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x15LdgpTFc5zE5Z+SeSohYa28vznrjxqruda6OdaY/c=;
 b=ZFtCqAmpMIbXbhAKJ8eDocrnVCqylv0svszCU0MvYjM/8atZDH4smqwZfhm5N9BER7vfqu
 YT44QdF3F9Z51XElWw70wZv+hGFOyXI8RmLqwOnUHsseEJU1a2Y2Bjd/meGhhuM4sQ2p1d
 lJ/c993As5atJ2Ui26q3XfveSe1sav+khZBK0TdRkuVIoeGHALksTePP9BoYuiihyFSYtD
 biWvidKSHIGmJtwpZC8WMXGc42ZeJke9aV997MxiiU+Lo06fCIooVDfNRkubltUn3QtBRB
 41jykraIB2luq4oWBoDYzzzxyT+n3Ut8ByQH++gjtDGGRcBp13ARJ25LyasDXA==
Message-ID: <c3434f0a80318390d183a3a2f8f8fb3ae71c9906.camel@mailbox.org>
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tursulin@ursulin.net>, phasta@kernel.org, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, "Jonghyuk
 Kim(MalHyuk)" <malhyuk97@gmail.com>, 	matthew.brost@intel.com,
 dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 stable@vger.kernel.org
Date: Mon, 07 Sep 2026 12:47:29 +0200
In-Reply-To: <47464619-890d-484f-986b-9a6c06cd89b0@ursulin.net>
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
 <20260904080618.2098450-2-malhyuk97@gmail.com>
 <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com>
 <ee27d37269f609192cdfd7a217d9731d7dca04c8.camel@mailbox.org>
 <a41a35b8-c78b-4c18-af11-26374918f222@amd.com>
 <7e4497506bb051fd1c25ed54f88a8036084e779c.camel@mailbox.org>
 <81e51d72-d608-46d0-a986-390ecd6f468a@ursulin.net>
 <d3d2ae0ae55fb07780f643de9517f3668484575a.camel@mailbox.org>
 <47464619-890d-484f-986b-9a6c06cd89b0@ursulin.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: xj9eaef5uoqgm8zxtoqw3zj73zhf6run
X-MBO-RS-ID: a2d0d3af454ae34fb4a
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

On Mon, 2026-09-07 at 11:28 +0100, Tvrtko Ursulin wrote:
> >=20

[=E2=80=A6]

> > How did the others fix that?
>=20
> Combination of kfree_rcu, synchronize_rcu and storing the name in an=20
> object protected by those:

[=E2=80=A6]

> For the scheduler (nouveau_sched_destroy()) the same, kfree_rcu.
>=20
> That makes scheduler timeline name vfunc safe:
>=20
> static const char *drm_sched_fence_get_timeline_name(struct dma_fence *f)
> {
> 	struct drm_sched_fence *fence =3D to_drm_sched_fence(f);
> 	return (const char *)fence->sched->name;
>=20
> sched is then RCU protected. sched->name is already static so not a conce=
rn.
>=20
> As you say nouveau_sched_fini() only tears down the scheduler after=20
> fences have been signaled it seems adding two new kfree_rcu make is safe.


I don't see how any RCU mechanism would make anything here safe.

As long as ops->release is implemented, ops will never be set to NULL,
(with or without RCU) =E2=80=93 so everyone who holds a reference to finish=
ed-
fence can still run into drm_sched_fence_get_timeline_name() and cause
UAF on the sched pointer *and* the name pointer.

Moreover, all of this falls apart should the driver unload.

So I maintain the position that we only get it right by having the
signaled-bit be the decoupling point.

Or am I missing something?


P.
