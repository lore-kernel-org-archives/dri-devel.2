Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0B9C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 11:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEA5410E5D6;
	Thu, 10 Sep 2026 11:04:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hZkMbrL6";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8695B10E5D6
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 11:04:38 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hgZZC3897zMlK1;
 Thu, 10 Sep 2026 13:04:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1789038275; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3q++fkQISw/DqZy/79hTcf7bnPSwjh/Vc1ryjSPvQTA=;
 b=hZkMbrL6XtJaJoOnMcljhximRCiwm8CN4oRKxPI4Hn24Dc2a+jSPEyh8sOfquutCczPYNM
 KNmj5MO2fuZTmocR+JNC1gf+viriG4PIOqs2gUpQmkyO244fUmMZEib/ilU8R5KtQk0/mg
 4rCnmFq52cbbAp7wPS7WyKfExRY/DKvBcgtsgTENfyzZf5GLPIDjOsVjE2eOBZwqf5t+Bp
 uO2bUudrtVlSrsLO2d0H/YrgIMDWc56s0f1YRxrIp0Z7rkj89dcrPjhdzSfSslAyeq+9CS
 h2noU0RwqW/137XRuycN1pJvVGmOl02newBNdJoXz2d8jrxF3uTLZsKtlVnrEw==
Message-ID: <f47c44133a976532c0831816f776a879dbf3963a.camel@mailbox.org>
Subject: Re: drm/sched: run queues freed before the TDR that
 drm_sched_fini() waits for
From: Philipp Stanner <phasta@mailbox.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, phasta@kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Luben Tuikov	
 <ltuikov89@gmail.com>, Matthew Brost <matthew.brost@intel.com>, Danilo
 Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 13:04:31 +0200
In-Reply-To: <20260910095053.727808-1-donggeunyoo.kernel@gmail.com>
References: <20260910054605.634135-1-donggeunyoo.kernel@gmail.com>
 <6f52dcbb040b8ba796b56311e9a77465d111c868.camel@mailbox.org>
 <df7b0d1e-5a74-445b-90fe-fae30cee4cb3@amd.com>
 <20260910084408.703333-1-donggeunyoo.kernel@gmail.com>
 <608f03824420323f9c9d3bc29cfeb0bed714074e.camel@mailbox.org>
 <20260910095053.727808-1-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: aoxdbofbsfs93fjuw48jj3qxog3659q9
X-MBO-RS-ID: f6a14d98396b2592022
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

On Thu, 2026-09-10 at 18:50 +0900, Donggeun Yoo wrote:
> On 9/10/26 10:51, Philipp Stanner wrote:
> > Which KUnit test case exactly?
>=20
> A local one. It is not in the tree - I wrote it for this, which is why yo=
u
> could not find it. I should have said that explicitly.

OK. For the future please provide the reproducer somehow, for example
through a repo link.

>=20
> It is a mock scheduler whose run_job() returns a hardware fence that is
> never signaled,

Alright, so as we agreed on that's then not a bug fix relevant for
upstream.

>=20
> Right, that's what my patch does: drm_sched_wqueue_stop(), then
> cancel_delayed_work_sync(&sched->work_tdr), then the frees. The report is
> gone and nothing else in the suite fails.
>=20
> As you say, that is closer to a cleanup - or to making the teardown order
> state its intent - than to a fix. Do you still want the reordering patch?

I think it's a good idea. I'd move the deallocations above the related
kfree at the bottom.


What would be more valuable, though, would be a hint in the docu that
the hardware fences must have been signaled before drm_sched_fini() is
called. I thought we had sth like that, but apparently we don't.

@Christian: Could you address this here [1]?


Thanks
P.


[1] https://lore.kernel.org/dri-devel/20260909131808.2201-3-christian.koeni=
g@amd.com/
