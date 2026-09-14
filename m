Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C831C88E6A
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51D9210E4BE;
	Mon, 14 Sep 2026 09:03:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="c9pmIUPi";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E4A510E4BE
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 09:03:52 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hjzj05KFtzKnDK;
 Mon, 14 Sep 2026 11:03:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1789376628; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9zck38y2xIJ+IIB+3JNZKJWllQdUgDA0y2e2iXTFjUk=;
 b=c9pmIUPiivvJki16hc3cQfbDlKEHVYHMhUQimFxaWDyY77oG4wcGnyxwjVfreUtHR5TxAD
 eynOHTTPjKESREndg77EkJlKKajQJUrtNroXjZrDnlGqwHQ48NpQQxsj/MeJ+YJt7R6/Rx
 qf+vN8QtdDDvdJhnqPjBWC2LzJUN8oQGX8qbqu6ndIY4Bn3IkZ6J4KhAHaMvNcQWxr6KZB
 GLvOSrAeIlfbJxj2MMULp6nZTKLzzIkDwmqQwbNsbbnLgien8HQ/iDm84UU1bb/7XhscOa
 gPXdFHHvDvji1kMq3mtyNeMxUwqUIHiTY06otR5q20zuRqEFsmOUVprkyr3ktQ==
Message-ID: <4357c0bd2a78e88b49b7375bc18d1116df3275b6.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Increase drm_mock_sched_job_wait_finished
 timeout when CONFIG_HZ=100
From: Philipp Stanner <phasta@mailbox.org>
To: David Gow <david@davidgow.net>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Danilo
 Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner	 <phasta@kernel.org>, Pierre-Eric Pelloux-Prayer	
 <pierre-eric.pelloux-prayer@amd.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 kunit-dev@googlegroups.com,  Marco Pagani <marpagan@redhat.com>
Date: Mon, 14 Sep 2026 11:03:41 +0200
In-Reply-To: <20260913084155.520015-2-david@davidgow.net>
References: <20260913084155.520015-2-david@davidgow.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: n4ko38zn5wcxjeye55h196xcbxqqrezj
X-MBO-RS-ID: 1a564bd70a063c5ba6d
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

+Cc Marco

On Sun, 2026-09-13 at 16:41 +0800, David Gow wrote:
> The drm_sched_scheduler_overhead_tests tests hardcode a timeout of 5x
> total_us, and fail if it's exceeded. However, on systems with
> CONFIG_HZ < 250, this tends to fail.
>=20
> As it's possible to configure many architectures to use 100 Hz (and some,
> such as UML, hardcode CONFIG_HZ=3D100), increase the timeout so that the =
test
> doesn't fail on these configurations.
>=20
> Fixes: 97ef806a5314 ("drm/sched: Add some scheduling quality unit tests")
> Signed-off-by: David Gow <david@davidgow.net>
> ---
>=20
> This failure showed up on UML when testing the addition of CONFIG_DRM to
> the KUnit 'alltests' config[1]. Ideally, I'd like to see this test fixed
> (or at least skipped/disabled) on these broken configurations so that the
> alltests run is clean. (I don't actually run any CONFIG_HZ=3D100 configs
> other than UML, but fixing them all is ideal if we can manage it.)
>=20
> If you'd rather a different implementation / magic number, let me know.
> I picked 15 here as it gave me plenty of leeway: 10 worked most, but not
> all, of the time under i386 qemu w/ CONFIG_HZ_100, and was fine with UML
> on this machine.
>=20
> Thanks,
> -- David

Thx for the patch. Where are you running the tests and what for, is it
a CI or other test system?


So one thing about the unit tests is that they were originally not so
much intended for being run on all sorts of CIs, but as a development
tool for the drm_sched devs to have something to move forward with.
That's in part why they contain "scheduling quality tests".

That caused some raised eyebrows already because people run these
lengthy tests in CIs.

Maybe what we actually should have is a split of the test suite into
two parts, where one part covers basic sanity, and the other measures
scheduling behavior. The former could then be run by CI folks, the
latter explicitly be discouraged from being run by anyone who is not a
drm_sched-developer.


P.

>=20
> [1]: https://lore.kernel.org/all/20260911-kunit-drm-v1-1-c5c0f18fc7b0@ker=
nel.org/
> ---
> =C2=A0drivers/gpu/drm/scheduler/tests/tests_scheduler.c | 11 +++++++++--
> =C2=A01 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/tests/tests_scheduler.c b/drivers/=
gpu/drm/scheduler/tests/tests_scheduler.c
> index 285546a2218f..02c83b5c2189 100644
> --- a/drivers/gpu/drm/scheduler/tests/tests_scheduler.c
> +++ b/drivers/gpu/drm/scheduler/tests/tests_scheduler.c
> @@ -13,6 +13,13 @@
> =C2=A0 * logic.
> =C2=A0 */
> =C2=A0
> +/* We need a more generous timeout when CONFIG_HZ=3D100. */
> +#if CONFIG_HZ < 250
> +#define TIMEOUT_MULTIPLIER 15
> +#else
> +#define TIMEOUT_MULTIPLIER 5
> +#endif
> +
> =C2=A0static int drm_sched_scheduler_init(struct kunit *test)
> =C2=A0{
> =C2=A0	struct drm_mock_scheduler *sched;
> @@ -88,7 +95,7 @@ static void drm_sched_scheduler_queue_overhead(struct k=
unit *test)
> =C2=A0
> =C2=A0	/* Wait with a safe margin to avoid every failing. */
> =C2=A0	done =3D drm_mock_sched_job_wait_finished(job,
> -						usecs_to_jiffies(total_us) * 5);
> +						usecs_to_jiffies(total_us) * TIMEOUT_MULTIPLIER);
> =C2=A0	end =3D ktime_get();
> =C2=A0	KUNIT_ASSERT_TRUE(test, done);
> =C2=A0
> @@ -149,7 +156,7 @@ static void drm_sched_scheduler_ping_pong(struct kuni=
t *test)
> =C2=A0
> =C2=A0	/* Wait with a safe margin to avoid every failing. */
> =C2=A0	done =3D drm_mock_sched_job_wait_finished(job,
> -						usecs_to_jiffies(total_us) * 5);
> +						usecs_to_jiffies(total_us) * TIMEOUT_MULTIPLIER);
> =C2=A0	end =3D ktime_get();
> =C2=A0	KUNIT_ASSERT_TRUE(test, done);
> =C2=A0
	=09
