Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0113CD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 06:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A47510E731;
	Wed, 10 Jun 2026 06:23:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SUs+OxQH";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C98210E731
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 06:23:00 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gZwgf4CyHz9tgg;
 Wed, 10 Jun 2026 08:22:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1781072574; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=staPmamH5a6BWVqxoXhLBV6lmny1V4QWstO9mIufvDY=;
 b=SUs+OxQHMhzWfJFR+kRdiyRhKe4ztU1QTLlSgnF0bSmlQPQiO5qOx/HOWiKNNb4ATvKeRG
 a9lA1k2LzikXHldYcwM8tHiCRAp6k+4DwAglVV9qEPLBmrbqfLD5apNZ9GY+QF3LWcw2t7
 YJ+VieSrp5U2qrGJmZc5YL5USLqUN43ucqNjQ5V7JDG4KfXiv6E/d/gBrtKvb4Y8z9zWRQ
 LdvsnuqlaXFmuXwo9qJGgdn0iRLJjkt8YZ69TTuqkHzIUXy9U0qaG4xnOKmt/puSNekSOf
 QemhasGw513mMNKpuymaSVV1/TCuq8M/8VqcNO8mATESt2AVf3c8zAEM63BCeQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of phasta@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=phasta@mailbox.org
Message-ID: <f387fb8296a3bff81389c1c9584ac1d3c9f6dd65.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Remove redundant entity->rq initialization
 and checks
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org, 
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, Matthew
 Brost	 <matthew.brost@intel.com>
Date: Wed, 10 Jun 2026 08:22:47 +0200
In-Reply-To: <3edf041c-e255-4269-8631-7d25b9744fa2@igalia.com>
References: <20260602153339.43453-1-tvrtko.ursulin@igalia.com>
 <4e7e282983939dd64b9303d53302e6806361076c.camel@mailbox.org>
 <1ddf1427-e0ee-4891-9af6-028cd559b161@igalia.com>
 <3edf041c-e255-4269-8631-7d25b9744fa2@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: 399c6wcsqtpdoph5nq3yytwpx3gu6rfb
X-MBO-RS-ID: 09902712b60ce2075e4
X-Rspamd-Queue-Id: 4gZwgf4CyHz9tgg
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

On Tue, 2026-06-09 at 14:39 +0100, Tvrtko Ursulin wrote:
>=20
> On 03/06/2026 10:14, Tvrtko Ursulin wrote:
> >=20
> > On 03/06/2026 09:37, Philipp Stanner wrote:
> > > On Tue, 2026-06-02 at 16:33 +0100, Tvrtko Ursulin wrote:
> > > > Commit
> > > > 28c5bf28763d ("drm/sched: Disallow initializing entities with no=
=20
> > > > schedulers")
> > > > failed to notice clearing of entity->rq in drm_sched_entity_init() =
is=20
> > > > now
> > >=20
> > > By clearing you also mean the setting to NULL?
> > >=20
> > > I'd just use "initialization" consistently, like in the commit title.
> >=20
> > It is initialized properly a bit lower down so clearing is I think more=
=20
> > accurate.
> >=20
> > > > redundant and can be removed.
> > > >=20
> > > > Given that entity->rq can now never be NULL, we also remove two
> > > > impossible
> > > > checks, from drm_sched_entity_kill() and drm_sched_entity_flush()
> > > > respectively.
> > > >=20
> > > > Similarly, we can also remove the !entity->rq check in
> > > > drm_sched_job_init(). And for the better, given that the error=20
> > > > message, if
> > > > it ever triggered, would have dereferenced the yet un-initialized j=
ob->
> > > > sched (only initialized later in drm_sched_job_arm()). This appears=
 to
> > > > have been theoretically broken ever since commit
> > > > 56e449603f0a ("drm/sched: Convert the GPU scheduler to variable
> > > > number of run-queues")
> > > > .
> > > >=20
> > > > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > Cc: Danilo Krummrich <dakr@kernel.org>
> > > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > > Cc: Philipp Stanner <phasta@kernel.org>
> > > >=20
>=20
> Gentle reminder - can we merge this as is or you want me to tweak what=
=20
> specifically?

No, cool cleanup, shoved it into drm-misc-next

Sorry for forgetting, it drowned in all the dma_fence mails <.<


P.
