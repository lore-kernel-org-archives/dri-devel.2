Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3140C982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:31:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAC8F10E04A;
	Wed, 23 Sep 2026 07:31:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rV6W5+KT";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1899B10E04A
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 07:31:55 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hqTDk6ScQzMlcQ;
 Wed, 23 Sep 2026 09:31:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1790148710; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ewBXp6wIK1XaqYEXypgcFPAi/4Tk0ocznfvqxVjsvA=;
 b=rV6W5+KTK2+79LZdYwyd1E0q2jGIqRSoXUY/P/wa12dWcGjM7V8gZzExu38vzSa7j/6VBW
 g+qBgfryRoM8H2i+BAef3QTLhpt441ZP/Mx9LU/ep3G8sR2x3R6cvs8/kcU2Tz5EHetQ9E
 Qtq/G3KwKw2D4pTimzhkvA9N3PSCchSEvECPocGBR5ES95KsB4IU9+HqiBt6dqD2zL9N39
 bcibPotV/BchSaOcXUFEMA8UGUwLbD/Tbi6lUOT3u7xGtsi/Lz8qnMZZKusToNCr84b//Q
 1g1YvkmRPjYtbO6A4BQ1ZXZd4Q8h9yth2rGMVNL6mkH8Iu8BWAhkhsHiB5ItSQ==
Message-ID: <72697e6a5287439baa161c0c87a87fb1096a31c4.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Free the run queues at the end of
 drm_sched_fini()
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Donggeun Yoo
 <donggeunyoo.kernel@gmail.com>, Matthew Brost <matthew.brost@intel.com>, 
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>
Cc: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Luben Tuikov
 <ltuikov89@gmail.com>, 	dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 09:31:45 +0200
In-Reply-To: <f8ddff14-7800-451d-92c4-3f63ebba275d@igalia.com>
References: <20260910121601.805032-1-donggeunyoo.kernel@gmail.com>
 <f8ddff14-7800-451d-92c4-3f63ebba275d@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 49eddb90ab452209e4a
X-MBO-RS-META: tah16iyaf5j8xmayb69acoinck8kxjzn
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

On Mon, 2026-09-14 at 13:11 +0100, Tvrtko Ursulin wrote:
>=20
> On 10/09/2026 13:16, Donggeun Yoo wrote:
> > drm_sched_fini() frees the run queues at the top of teardown but the ar=
ray
> > holding them at the bottom. The early half is on the wrong side of
> > cancel_delayed_work_sync(&sched->work_tdr), which waits for a timeout
> > handler that can still walk sched->sched_rq[i] through
> > drm_sched_increase_karma().
> >=20
> > No correct driver can be there, since every fence returned from run_job=
()
> > must be signaled before drm_sched_fini() is called. Free the entries ne=
xt
> > to the array anyway, so run-queue teardown happens in one place.
> >=20
> > Link: https://lore.kernel.org/dri-devel/20260910054605.634135-1-donggeu=
nyoo.kernel@gmail.com/
> > Assisted-by: Claude:claude-fable-5
> > Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> > ---
> > Targets drm-misc-next (0878e6053d01).
> >=20

[=E2=80=A6]

>=20
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Applied it. Thx.

P.
