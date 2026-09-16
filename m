Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EB6C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 12:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0548410E648;
	Wed, 16 Sep 2026 12:54:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xzJE9iCp";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAAB010E648
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 12:54:11 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hlJjr4MRRz8v0L;
 Wed, 16 Sep 2026 14:54:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1789563248; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=moYMiM1SjomqweNe0uspuutzEKMU9N6KeLKEX2Q1sc0=;
 b=xzJE9iCpUdo3/pSwwrNkdTAuMI3OLMS6Qn6CJWOO259NfijuwM0oun5M3Rw71QXUZjlctQ
 9HTwETLM8WcSwZhTwOhdiB5/xtQaYC47XiRF6Pv2tyGBZaAaxv7DRczICTQqPMpxwVMpQW
 1EJzw5jyWYQfpyMXPfgQLK+FSmx4GwhJA5w1nqpF2SdEnazaXmglEzfdP4HAS9AjOQb4FG
 EExSkZUfE2+zir4oqTFP6ggNZIKIN3/p1wx9khuJqjFLGl2czT3rY7Vy6I3JsY/gu5lZZk
 wFggP1IUcDhFMOp/KSrmXNCOlJ1FJHyAEQoQ9sU0k2TV56hkc/aUB3vlemyL7Q==
Message-ID: <47731da478e8801dc9823ecf286e941020e30963.camel@mailbox.org>
Subject: Re: [PATCH v3 3/3] drm/sched: Protect entity->last_scheduled with
 spinlock
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tursulin@ursulin.net>, Philipp Stanner
 <phasta@kernel.org>,  Danilo Krummrich	 <dakr@kernel.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <ckoenig.leichtzumerken@gmail.com>, Maarten
 Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Wed, 16 Sep 2026 14:54:00 +0200
In-Reply-To: <f186f871-064a-4f45-8987-fe9f2fb3fa1c@ursulin.net>
References: <20260910075942.2000338-2-phasta@kernel.org>
 <20260910075942.2000338-5-phasta@kernel.org>
 <f186f871-064a-4f45-8987-fe9f2fb3fa1c@ursulin.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 8312574d89f7fefc5c4
X-MBO-RS-META: 8f6gaz4kg16okow1qcgy7fnnh7e3io8n
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

On Fri, 2026-09-11 at 09:17 +0100, Tvrtko Ursulin wrote:
> Also, to repeat what I said before, I benchmarked this a bit under=20
> extreme circumstances (4x non vsynced vkgears) and did not find a=20
> regression in fps.

Does that mean you give this an official Tested-by: =E2=80=A6
?

>=20
> Here you can compact with the idiomatic:
>=20
> =C2=A0 prev =3D dma_fence_get(entity->last_scheduled);

Good idea, will do.

Thx,
P.
