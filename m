Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3317C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 09:38:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDAE210EE80;
	Wed,  1 Jul 2026 09:38:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lr1yvTGC";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFF8D10EE80
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 09:38:53 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gqw2138s3z9tyS;
 Wed,  1 Jul 2026 11:38:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1782898729; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6lLxWwm2ec6TjhN1sKZlPI0XtM2PK8Ut5JL5Jjbj3qs=;
 b=lr1yvTGCneGTgWvHzocgbEa3X9Cc+RSxPIv1QRAjU5QfhiiLMQt/FrTiOUpAAdBCy8a0ms
 88FPTilhuyKAvQepybbnQZBTcq0Mg3JU5zu8QwxJF8I8M7o6gchNXdLRmkca23arQW1IoT
 +K5ztSNyzhtTkcV8xvZ/8+lNvFa5aYJRyo1jxvgMQRBg0KzEutK1zHGcb/Q5iKQkvjJdb9
 Q7dfVzoMZb8ylqmUEEdAf8UqNIW+ropTFymGXSLTPz/b/pb7GUFN14EyEbHoyMoblFawlk
 nFQPmFkmtqoDXElUGbbsRC+lyQomb0ToqhpCwyqXbUb5JzyHc7COZjzl+dYp0A==
Message-ID: <5ea5741e6cb618f6c66adeaaae9565f8debd796e.camel@mailbox.org>
Subject: Re: [PATCH 5/5] drm/sched: Remove entity->entity_idle
From: Philipp Stanner <phasta@mailbox.org>
To: Philipp Stanner <phasta@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>,  Danilo Krummrich	 <dakr@kernel.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <ckoenig.leichtzumerken@gmail.com>, Maarten
 Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sumit Semwal
 <sumit.semwal@linaro.org>, Marco Pagani <marco.pagani@linux.dev>, Tvrtko
 Ursulin	 <tvrtko.ursulin@igalia.com>, Boris Brezillon
 <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Date: Wed, 01 Jul 2026 11:38:40 +0200
In-Reply-To: <20260701085920.3253248-7-phasta@kernel.org>
References: <20260701085920.3253248-2-phasta@kernel.org>
 <20260701085920.3253248-7-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: on3uiyyneea4wy3tajn8aazoxccnp7rp
X-MBO-RS-ID: ca2de0c17790b5f71d5
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

On Wed, 2026-07-01 at 10:59 +0200, Philipp Stanner wrote:
> The completion entity->entity_idle only existed because the entity was
> not properly locked through it's spinlock. The completion served to
> inform waiters about whether the entity is actually idle, which is
> something locking (previously added to drm_sched_entity_is_idle()) can
> fully achieve.
>=20
> Remove the surplus completion.
>=20

[=E2=80=A6]

> -	/* Make sure this entity is not used by the scheduler at the moment */
> -	wait_for_completion(&entity->entity_idle);


Alright, my bad, turns out I had a bit too much steam on the kettle and
we cannot remove it because of the drm_sched_entity_flush() being able
to perform an asynchronous kill while the scheduler work item is still
running.


But I think we could probably put Tvrtko's flush_work() [1] here to get
the same result.

Opinions?

P.


[1] https://lore.kernel.org/dri-devel/20260611123423.39819-1-tvrtko.ursulin=
@igalia.com/
