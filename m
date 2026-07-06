Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FB8C43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 433A110E829;
	Mon,  6 Jul 2026 08:44:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nHdbQ+TY";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F1F110E829
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 08:44:10 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gtyZb1XD5z9v61;
 Mon,  6 Jul 2026 10:44:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1783327447; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AJ4aIxUgiP3Han22qbWvtyR/5nktUXTajUoFRGnUIuM=;
 b=nHdbQ+TYBc8++q/8niqrcENirbMbTlSZR0togWnPdh+B+INioK16OhZIQfLIt6ybWCFspH
 8vGDLogqCVMuZzSl5ddkG7LV7H3PLL1p3/86cR6szsxqUDZpAb+HdnvBMNXttC1uc037ha
 FdLqdpGQjuqBFTAhLq1qhX1d/SZ51lmu18m0vAXx8FlgFvHp8pTHwq0xF1Qq5/xR9QweCn
 ge037iqFTvC1AjDPjwzSdvnBdnXD7jmGmjK/aHGMxrD977orV/ZhOrjU9HKsKT/EizSJh9
 Hr9td1z+OVrDZWbpgfV8F3XhdbAfJRhcwrwecQ29/zyGtUljz0PtrQ9siT7t0w==
Message-ID: <2abbd54a7908f5ee82bcffb22bf0dccc05734bbe.camel@mailbox.org>
Subject: Re: [PATCH 1/2] drm/sched: Guard sched->ready with ACCESS_ONCE()
From: Philipp Stanner <phasta@mailbox.org>
To: Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard	
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Mon, 06 Jul 2026 10:44:01 +0200
In-Reply-To: <5ed4ecfe-05bb-4bdd-9aa3-155e1d926861@kernel.org>
References: <20260629104040.2695163-2-phasta@kernel.org>
 <5ed4ecfe-05bb-4bdd-9aa3-155e1d926861@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: gys5d9w4oaf7ftmzx7ugo6qq4ep7be9w
X-MBO-RS-ID: 416adebaaf09519aabc
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

On Mon, 2026-06-29 at 14:09 +0200, Danilo Krummrich wrote:
> > +	WRITE_ONCE(sched->ready, false);
>=20
> Don't we need smp_store_release() here and
>=20
> > +	return READ_ONCE(sched->ready);
> smp_load_acquire() here?

Maybe. Not sure what the precise access rules would be. To really get
correctness, all counter-parties you found in amdgpu would have to
remove their layering violations anyways, which is beyond my scope.

>=20
> Also, what about drm_sched_init()? It also seems that this is accessed fr=
om
> amdgpu without the drm_sched_wqueue_ready() helper about a million times.=
 :)
>=20
> 	$ grep -Rin "sched\.ready" drivers/gpu/drm/amd | wc
> 	$=C2=A0=C2=A0=C2=A0=C2=A0 119=C2=A0=C2=A0=C2=A0=C2=A0 544=C2=A0=C2=A0 10=
320
>=20
> There may be false positives, but from a quick glance at least most of th=
em seem
> to actually come from the scheduler.

Correct.

Your ordering comment hints at me that you would rather see the ready-
flag be left as is, if it can't be made right 100% (which it can't).

My idea was more to at least document the UB / race and make it
slightly less broken with a reasonable cost-benefit-ratio


P.
