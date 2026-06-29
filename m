Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E102C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8214110E06E;
	Mon, 29 Jun 2026 12:09:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oWOu9XeD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC89F10E06E
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 12:09:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C5BCC434F4;
 Mon, 29 Jun 2026 12:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4571F000E9;
 Mon, 29 Jun 2026 12:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782734974;
 bh=gO7vksODGeA6boCayY1A9JuxqrUFKMw+C8sb90UNlR4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=oWOu9XeDVQ+t70CtakGVe85lb/PYZj8EZ0nVxHUsudH8riLgsWTGW5slBK8YxG1IT
 cLDlvJMBMx0unf7aSdhlDyrzOnid365JQCgqYNY+tIF2V4CCj+59Wqb8dyoRUgCeex
 ud26FgFvxVcbUAS/NaMo0/FrXcpB/ElWZzme1eeLtHXhNiudHAT2bVzBdNgE7kmat8
 bprqA5FulgYfeIp2Pafa8D1NzyKuPWRyuknilFThFPBpAPXtM/JnFprprLGKlPg5Ot
 1RjfeJUvosElCKxgI5fDaXV/qKGRZ2bno9lIHRekpMAyEPP1twH3nc6KnK0ZXpVi0/
 ekI2vZQtgue1g==
Message-ID: <5ed4ecfe-05bb-4bdd-9aa3-155e1d926861@kernel.org>
Date: Mon, 29 Jun 2026 14:09:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/sched: Guard sched->ready with ACCESS_ONCE()
To: Philipp Stanner <phasta@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260629104040.2695163-2-phasta@kernel.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20260629104040.2695163-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

> +	WRITE_ONCE(sched->ready, false);

Don't we need smp_store_release() here and

> +	return READ_ONCE(sched->ready);
smp_load_acquire() here?

Also, what about drm_sched_init()? It also seems that this is accessed from
amdgpu without the drm_sched_wqueue_ready() helper about a million times. :)

	$ grep -Rin "sched\.ready" drivers/gpu/drm/amd | wc
	$     119     544   10320

There may be false positives, but from a quick glance at least most of them seem
to actually come from the scheduler.
