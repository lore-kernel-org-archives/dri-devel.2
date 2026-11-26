Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813C1606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=ALdBvSqu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E017B10E97E;
	Thu, 26 Nov 2026 16:14:18 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6455F10E97E
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:14:12 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jb1ns35trzMlw0;
 Thu, 26 Nov 2026 17:14:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1795709649; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CeZKJVNOA1Gdn53UTRL4wDgsMMGuaOIzj9d0ay6pXt0=;
 b=ALdBvSquWbIkBQxrS1wraDsXHO/nUcShnDA/8WlJIMECZHDqi3XOhOx5R8BGLEsnloQ/2J
 VeaIVDftV1uLqi+kBM36LBFyoLmxM83BCU1NQMPowN+T1bFkIp9uTfTqgzE+fL1lQeK5hc
 5QBhC24QnI17Siz2N+S+MuKWwBtMcLttLZPeNm3X824F+noB8lha7ukNuOlOj8LnxmmZE7
 kOEWDIsCSMIGLvWA84kINpcKAtoLU1E1ehR+LeFyiPfw3DI1gABOJDu24k464tOt/6nO7u
 S3b4UNqMvg7PvQBy8gmbQbKFyDm27tUSL0jL4Mwcb8HEMwq1zzkkAoABzYP/+Q==
Message-ID: <5922ac007b35e54e8b0c60a04cc55fb7fc88d72e.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Extend locking in drm_sched_entity_select_rq()
From: Philipp Stanner <phasta@mailbox.org>
To: Philipp Stanner <phasta@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>,  Danilo Krummrich	 <dakr@kernel.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <ckoenig.leichtzumerken@gmail.com>, Maarten
 Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Thu, 26 Nov 2026 17:14:07 +0100
In-Reply-To: <20261117093708.647488-2-phasta@kernel.org>
References: <20261117093708.647488-2-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 1f26d367046d2c5b33e
X-MBO-RS-META: ntm65iocu3rg66hh8k9mzkzmmegyera1
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: phasta@kernel.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 2026-11-17 at 10:37 +0100, Philipp Stanner wrote:
> drm_sched_entity_select_rq() evaluates entity->sched_list locklessly,
> which is elsewhere always lock-protected. Another lockless check regards
> spsc_queue_count(). spsc_queue is evaluated under lock protection at
> many places already and the plan is to replace it with fully locked
> infrastructure anyways.
>=20
> Move the spin_lock() in drm_sched_entity_select_rq() upwards.

Tvrtko, Christian, objections with merging that for now?

P.
