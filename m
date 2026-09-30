Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D54CA5FAC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0EEB10F374;
	Wed, 30 Sep 2026 12:14:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="GY03ptDM";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2061610F374
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 12:14:45 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hvv9t0CQPz8v1y;
 Wed, 30 Sep 2026 14:14:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1790770482; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nWt4+mOnl4l6Yj23ltsIz8mR5DZl9PFyDnezgWo4IXA=;
 b=GY03ptDMzalgEbRAj1q6q/LZaO2Myb8HtYK2fnrh4/DkTW3WL1J1AqvyyS+U4ZrYNHJwOI
 djOeXYH7GPKRf9I0p/hRbZXW0O6u2p4IiwtzJZEyKVmEQOD5I5/nS/6SsfnST4sqjARAtv
 FXmhbR/L+2txmOfutGbeiTCE+NLt/ky0A42g8dkxq6nwathMtClW85KmVZWphPYmf1+1O3
 drIOooUsQtko7WKnIwF5kXph1PrwRSGuiF0uYL49n/KT0818ahRAvOhvcjXrQeN4osjjW1
 d423y+6rB97t7/nUUZtb5kDBHvSzS1843yKlLWeAGUCWiVuG4Qg6ECYuKRFQzQ==
Message-ID: <102995397e5c5ca19027b7acc75ff7205f57e871.camel@mailbox.org>
Subject: Re: [PATCH v4] drm/sched: Protect entity->last_scheduled with spinlock
From: Philipp Stanner <phasta@mailbox.org>
To: Philipp Stanner <phasta@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>,  Danilo Krummrich	 <dakr@kernel.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <ckoenig.leichtzumerken@gmail.com>, Maarten
 Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sumit Semwal
 <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>
Date: Wed, 30 Sep 2026 14:14:37 +0200
In-Reply-To: <20260922145441.619097-2-phasta@kernel.org>
References: <20260922145441.619097-2-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
MIME-Version: 1.0
X-MBO-RS-META: dtionoohoakxj9iawxahyuqmsi3d6c93
X-MBO-RS-ID: d3922876b93727a5916
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

On Tue, 2026-09-22 at 16:54 +0200, Philipp Stanner wrote:
> The entity->last_scheduled field has always been set and read with
> special RCU functions in addition to memory barriers.
>=20
> This was added in
>=20
> commit 70102d77ff22 ("drm/scheduler: add drm_sched_entity_error and use r=
cu for last_scheduled")
>=20
> however, no proper justification for that mechanism was provided. There
> seems to be no obvious reason, since the entity lock is available and
> taken at all places that evaluate the last_scheduled field. The only
> exception is drm_sched_entity_error(), which is not performance critical
> in any way.
>=20
> Improve robustness, readability and maintainability by replacing RCU and
> barriers with the lock.
>=20
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Applied that to misc-next.

P.
