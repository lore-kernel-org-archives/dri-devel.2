Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E13C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 11:39:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48DC010E4AC;
	Wed,  2 Sep 2026 11:39:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Dnwhez2W";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A4AA10E4AC
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 11:39:56 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hZgkd3ps7zMlHD;
 Wed, 02 Sep 2026 13:39:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1788349193; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qeioP7kdKjSkEbC9pe1QvQNugDjO5/Ci79J3J4FzbD0=;
 b=Dnwhez2W0X3MWUfGgeBRfg9Jj1zXhk7WZ/xnBicud/yXVF2Vj6aQLzqs8AU1gWVtVBTtmq
 pmOcFdpBY+qT9KATsbhAKBNgKYz5brr8+VFLNkXjxp0BjuHZGdBMECNReeZnPjc6Vn/KFV
 V6VxfdQ4uy69btSsptn7BNrLP0a61aLjuwT+q5OkzBr26IKA2Ve2+XlK8bwndh0wpj45Hk
 tcaNKCxLDW7bDJLR1W4IDsxVEXYFNQTO4Dahjy9Ux2xrmRh3Y0077PttK2brVLdTiBwUR6
 Kavcm6IrHcQDjR6+HqNQPnLwLuGtVhahgTR8/80TxCWf49HqtAm71jQTkXuKzQ==
Message-ID: <95e34a8771fe827e134970a3580ceeb5f661a40d.camel@mailbox.org>
Subject: Re: [PATCH v1 1/2] drm/sched: cache the timeline name to fix a
 use-after-free
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tursulin@ursulin.net>, phasta@kernel.org, 
 =?UTF-8?Q?=EA=B9=80=EC=A2=85=ED=98=81?=
 <malhyuk97@gmail.com>, matthew.brost@intel.com, dakr@kernel.org
Cc: christian.koenig@amd.com, ckoenig.leichtzumerken@gmail.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Wed, 02 Sep 2026 13:39:49 +0200
In-Reply-To: <619669b6-69ea-4aa5-b91e-b29cc788e335@ursulin.net>
References: <8c2a4df5-37a4-414e-81e2-cd97218e5355@ursulin.net>
 <CADQRuqtjBu7wR4kKVDcS42KLKQTr+7SBtRn24mgZ+ApettMr1A@mail.gmail.com>
 <b8f98b9e04c9999008bcdec270b14247e3cd18d0.camel@mailbox.org>
 <619669b6-69ea-4aa5-b91e-b29cc788e335@ursulin.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 5673802fd2592c4cf56
X-MBO-RS-META: 1w5cme4y615edbk8oiwca3ok9w5rubca
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

On Wed, 2026-09-02 at 11:20 +0100, Tvrtko Ursulin wrote:
>=20
> To collate two replies in one:
>=20
> On 02/09/2026 11:07, Philipp Stanner wrote:
>=20
> >=20
> > The issue here IMO is that we are discussing working around an issue
> > that actually stems from dma_fence not being consistently synchronized,
> > notably because of the ops->release callback being implemented.
> >=20
> > ops->release is de facto deprecated, precisely for reasons like these.
> >=20
> > If we could get rid of it for sched_fence, dma_fence would take care of
> > the decoupling of the name callbacks.
> >=20
> > So that appears worth investigating from my POV.
>=20
> I completely agree here but I am just not sure how feasible that would=
=20
> be. We may accept to live with the cross-documentation workaround at=20
> least as a start since even if feasible it could be a lot of work to=20
> change sched_fence like that.


It should be enough to remove ops->release for the finished_fence for
now, since that's the one typically (always?) shared with userspace.

All that release cb does is drop yet another reference.

I think it's worth an investigation. Maybe =EA=B9=80=EC=A2=85=ED=98=81 can =
give it a look?


P.
