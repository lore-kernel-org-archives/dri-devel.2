Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72E9C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EDAC10E09A;
	Wed, 16 Sep 2026 07:23:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uDVhELxM";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C59C10E09A;
 Wed, 16 Sep 2026 07:23:01 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hl9Mk4CvxzKp4h;
 Wed, 16 Sep 2026 09:22:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1789543378; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=enXKx7Hs6kAeb6eftCq6yc1nHOzd5D+PNTY9rTPv1hM=;
 b=uDVhELxMnPG9PuTwD/vxA52OIDDa3G1qh2sc1DdSCIotIjs2gOjwjI9nvxMWtX/HSI3hSv
 xUbDMqyr05F1FE3uZVZlfm2SAmxWkqrzr6P5LpYHnfVBUJR5LEZfRdY5WC5K8RmH24zhQ4
 nx1re/IxD/izT+ZRDVVjs18PT/iCS+rgq+CF1bIq5Km97t91EueirGknvcRTFjpjK05NgD
 BDc3in1NQiwxxMSP8EB9AmxvEYDfholNEYsB1bcgKKxIONuRmMjurMILXiVyddFeL75aC9
 6M7xytKhoHo/nLGYiWdmabYUlxJbqY4jFsKmCpo6beLrUc3y8IpNC82dj1j4Cw==
Message-ID: <166cf2ef60079cb1598db6687ee9395d447ba8e5.camel@mailbox.org>
Subject: Re: [PATCH v2] drm/sched: Do not restore unsaved virtual runtime
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 amd-gfx@lists.freedesktop.org, 	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Luke.Wildhardt@proton.me, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Danilo Krummrich
 <dakr@kernel.org>, Philipp Stanner	 <phasta@kernel.org>, Pierre-Eric
 Pelloux-Prayer	 <pierre-eric.pelloux-prayer@amd.com>, Matthew Brost
 <matthew.brost@intel.com>,  Vitaly Prosyak <vitaly.prosyak@amd.com>,
 stable@vger.kernel.org
Date: Wed, 16 Sep 2026 09:22:52 +0200
In-Reply-To: <20260915150557.62847-1-tvrtko.ursulin@igalia.com>
References: <20260915150557.62847-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: 4mc338tpkdujkpseogqzxpj41o8waqwx
X-MBO-RS-ID: 5a6222f57c809116da5
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

On Tue, 2026-09-15 at 16:05 +0100, Tvrtko Ursulin wrote:
> Prevent pushing a new job to an entity seeing it being the first in the
> queue, and hence entering the drm_sched_rq_add_entity() path, if the pop
> side in drm_sched_entity_pop_job() has just de-queued the job but not yet
> updated the saved virtual time.
>=20
> Restoring the unsaved virtual time, which is at this point not a delta bu=
t
> still an absolute value, pushes the said entity to the rear of the run qu=
eue
> for a potentially very long time.
>=20
> We close this race by pulling the locked sections out to encompass both
> the queue push/pop and corresponding rbtree management.
>=20
> This is aligned with the future direction to replace the current lockless
> job queue with one of the fully locked standard list primitives.
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: 2fa4d8e2c109 ("drm/sched: Add fair scheduling policy")
> Suggested-by: Luke.Wildhardt@proton.me=C2=A0# via Claude Opus
> Tested-by: Luke.Wildhardt@proton.me

Shoved it to misc-fixes, thx guys

P.
