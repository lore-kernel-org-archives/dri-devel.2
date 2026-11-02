Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76EE606B92C
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=ZJfGaKte
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22E6F10F01D;
	Mon,  2 Nov 2026 15:40:20 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4478310F01D;
 Mon,  2 Nov 2026 15:40:14 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jJG9l5Jtfz8t53;
 Mon, 02 Nov 2026 16:40:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1793634011; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dUGqfqfNXJ+NeO+UdV4+i/sAm1iD+FfxTNuQmN5fXq0=;
 b=ZJfGaKteF192khBUuklQ6Xw5liAqkmoqqW286YTqNFHiTpfFVKhU6vHZWBov2skspqFpeL
 mLfoBIlwy61eMvsxsX82pHork/l398irXUM25j+A9vWkcejGFpaQBawPEvRKm1dCUVacI+
 zGmXMusCtsqZd/ZKrq1C68kLF4lfEKuvaLfZ32jmJLFYVb9uMa1Ny9PWjLT5sHnZxIK1Fm
 pSjD6lfRNeLVW/3PUwoot9U0SbkPaMRTdj4+qn4jWWBbx6AzYIfKe6H5ZiVUJvKLggSQ9h
 3av+HfeZfxm2MqF7YW6PvfYr91VF+xPDmwhJZQznfA8bQVy5ObGQi2jHOwljMA==
Message-ID: <72cba5d23a977185696db12ac547174708652bcc.camel@mailbox.org>
Subject: Re: [PATCH v2 2/2] drm/sched: Adjust run-queue when changing
 priority at runtime
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org, 
 dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Danilo Krummrich
 <dakr@kernel.org>, Matthew Brost	 <matthew.brost@intel.com>,
 stable@vger.kernel.org
Date: Mon, 02 Nov 2026 16:40:09 +0100
In-Reply-To: <6e113935-f303-4f49-bc27-e1d85abffa70@igalia.com>
References: <20261021094227.48034-1-tvrtko.ursulin@igalia.com>
 <20261021094227.48034-3-tvrtko.ursulin@igalia.com>
 <84b5777a04dc75c013eb9ac0a44d972cf88db12e.camel@mailbox.org>
 <6e113935-f303-4f49-bc27-e1d85abffa70@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: e456fc94603ff365fc3
X-MBO-RS-META: 9zsm311osryyku1ki34bkx49oi936zaj
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

On Mon, 2026-11-02 at 14:47 +0000, Tvrtko Ursulin wrote:
> With FIFO and RR, on amdgpu, SDMA rings, only if more than one, *if*=20
> there exists userspace which does dynamic priority changes (calls=20
> DRM_IOCTL_AMDGPU_SCHED / AMDGPU_SCHED_OP_*_PRIORITY_OVERRIDE) on=20
> entities using those SDMA engines directly. All clear now? :))


Argh, maybe I should not have asked, but since we are here already=E2=80=A6


It seems that all this is inconsistent already.
Why do we even have both, priority and rq_priority? Both should always
be identical.

I suppose it is because we're in the "transition to CFS" phase where
you will actually need a per-RQ-priority (rq_priority), later phasing
entity->priority out.

Right?

If so, I wonder if we can't leave it be until we are at CFS?


P.
