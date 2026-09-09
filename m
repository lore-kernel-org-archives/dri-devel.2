Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BDDC79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:55:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EFE48825E;
	Wed,  9 Sep 2026 07:55:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UOFcV+Hr";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57D3010EFB3
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 07:55:51 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hftQr35lTzMlHP;
 Wed, 09 Sep 2026 09:55:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1788940548; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uzWjEF3Y/+POUbo0/oHWUn1lZJuW/vcA5xGPl105Tis=;
 b=UOFcV+Hr/8Es2aWxRrZdMiWgcBrvjhi3CVkE9EeaSqJ7yrm6wgbgDuLsaCDqLZSFhwplUW
 gne7wLwE2K1Rpjin/A1zAKuiOxtU4MhSs2ouxVf9RMeiAzfeeq9PEdzhziSia/ggC0kT34
 uVdFyokGBPfz6IIZS3WensfuivXHko6ZCqxw4dfBadzu4ClcK/J4K6vY9q2KJNGeyCAi+p
 MZACsVzCKKiBqNffvuKW1ehKhNnc58Q5rPDg5yrDZKGnizyzMIaS/QDDIyFYg/OntTg1Di
 jA/hizvPUVT1w4F2UUJHllbr1btUz04ot/cO9GYyY9mj6b9ikRYNcTRHdkrmLw==
Message-ID: <8b6fd69a00e844b391850b4041e399c10084c378.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: drop the unused entity argument from
 drm_sched_fence_alloc()
From: Philipp Stanner <phasta@mailbox.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>, Matthew Brost	
 <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, Philipp
 Stanner	 <phasta@kernel.org>
Cc: Christian =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Wed, 09 Sep 2026 09:55:45 +0200
In-Reply-To: <20260909005112.278538-1-donggeunyoo.kernel@gmail.com>
References: <20260909005112.278538-1-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 80f9cd215699884db75
X-MBO-RS-META: ahg5b41gttgdcf141xgh59utwo8t7bqk
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

On Wed, 2026-09-09 at 09:51 +0900, Donggeun Yoo wrote:
> drm_sched_fence_alloc() takes a struct drm_sched_entity *entity but
> never uses it. Its only use, fence->sched =3D entity->rq->sched, moved
> into drm_sched_fence_init() by commit dbe48d030b28 ("drm/sched: Split
> drm_sched_job_init"), which separated fence allocation in
> drm_sched_job_init() from arming in drm_sched_job_arm(). The deref
> belongs at arm: drm_sched_job_arm() selects the run-queue via
> drm_sched_entity_select_rq(), so for an entity with more than one
> scheduler, entity->rq need not yet point at the scheduler the job lands
> on. Reading it at allocation time could bind the fence to the wrong
> scheduler.

I think that paragraph is a bit overkill ;)

Especially the last sentence reads a bit like you're addressing a bug,
but it's just about removing an unused parameter.

I think saying "In commit dbe48d030b28 ("=E2=80=A6 =E2=80=A6 it was forgott=
en to remove
a now unused function argument" is enough. Who's interested in details
can then look at the commit.

>=20
> Drop the argument. The sole caller still passes the entity to
> drm_sched_fence_init() at arm time, so behavior is unchanged. This also
> removes the parameter-name mismatch between the declaration (s_entity)
> and the definition (entity).

This paragraph is good.


P.
