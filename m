Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73596C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 07:04:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 987CC10F31B;
	Thu, 10 Sep 2026 07:04:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WEpoZJ0z";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C02C710F31B
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 07:04:18 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hgTDt63lJzMlD7;
 Thu, 10 Sep 2026 09:04:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1789023854; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2pw+cFzWylXc1t9DdCQFMkJIJVRd9uJb1RAqvFs//bg=;
 b=WEpoZJ0ziX8vWvG9r0emck2JOBAEJ3gtqmK1XnxwLmL52IHKGKzoKVXtA/3aH/YMKk6sFH
 gyT/9Ka6ImzdUo7r0n/FFn2olPOyzAzPXS+iwY+H8Xy9qWjTwpEnnj98RKVFfIYaBBotJu
 6abzFpVU9hUqEz0VC/pE99CBhYe5lrI7mGPZ2f/2jpL55yfAG7mLqAg/qEokcIEV4TVQ2t
 zgXYbLiUeerLLeGQB6KqlkoAq2gyqfitgwza2DB5x4NNoIe8ZznIY3tl9bq6mYT3Yoh4Lu
 gEApTlFeQUAQHbGnhW3CPkW0XSROajB2dTkhS3DlvkMIUYKWREVmWw5iG5yVqw==
Message-ID: <244eb4448b937b8d9d3b2965a03b5c49f11c47a2.camel@mailbox.org>
Subject: Re: drm/sched: run queues freed before the TDR that
 drm_sched_fini() waits for
From: Philipp Stanner <phasta@mailbox.org>
To: phasta@kernel.org, Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Luben Tuikov <ltuikov89@gmail.com>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Matthew Brost <matthew.brost@intel.com>, Danilo
 Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Date: Thu, 10 Sep 2026 09:04:08 +0200
In-Reply-To: <6f52dcbb040b8ba796b56311e9a77465d111c868.camel@mailbox.org>
References: <20260910054605.634135-1-donggeunyoo.kernel@gmail.com>
 <6f52dcbb040b8ba796b56311e9a77465d111c868.camel@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: 6dnwf8u4jkdeou8gicw4o87hxhcxd6su
X-MBO-RS-ID: 8fb6520db9279f7f595
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

On Thu, 2026-09-10 at 08:52 +0200, Philipp Stanner wrote:
>=20
>=20
> long drm_sched_entity_flush(struct drm_sched_entity *entity, long timeout=
) { struct drm_gpu_scheduler *sched; struct task_struct *last_user; long re=
t =3D timeout; if (!entity->rq) return 0; sched =3D entity->rq->sched;
>=20
> =C2=A0/** * @rq: * * Runqueue on which this entity is currently scheduled=
. * * FIXME: Locking is very unclear for this. Writers are protected by * @=
lock, but readers are generally lockless and seem to just race with * not e=
ven a READ_ONCE. */ struct drm_sched_rq *rq;
>=20

Sorry for the formatting horror. No idea why that happens,  layouts
correctly for me before sending.

I've had enough of this now and will setup Mutt or Aerc.


P.
