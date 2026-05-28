Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8A7CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 13:03:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D6E410F14C;
	Thu, 28 May 2026 13:03:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="swGu0kab";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2379110F14C
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 13:03:27 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gR69k6K6sz9v5w;
 Thu, 28 May 2026 15:03:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1779973402; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ldWZaB1V0VFmfuVmmY4GBcFyCmTzpt1ZkAIKZBSc/tg=;
 b=swGu0kabwMrmc8/eRy3s8UB7CTMTWxaG83agEj15qcTu5cw/1f86aNRzY/B48XDV+Sds/H
 0rUGieMHhLhVFezM7sPEGDwks4KV9GL0UJYFsEYrP36NyJAp8Dz6S5sisuhS5duMk986C0
 G+R2Gg5Ysx8y0KnEaeo7NWYV4UgSryxoROy7piboVF4T/2ATmEKUIOE82YjyzuFBmkqlMD
 wcRaCaL+Lw9xatQ6z97JUypdKL25Yl2q5USHBk8mcGSxiXl/Coicx7DfttwrVs1u/U9vto
 UJJe4cSIat9zxeLjhoSdb+Z58MIo7S8E4VcX/ds3tO8ZLXGDjHwwBGPCbQ3j+A==
Message-ID: <23df1e8b17c4ba5a9106b84a65e092ebd54fee42.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Fix clang build warning in kunit tests
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, kernel test robot <lkp@intel.com>, Philipp
 Stanner <phasta@kernel.org>
Date: Thu, 28 May 2026 15:03:18 +0200
In-Reply-To: <20260522090129.9385-1-tvrtko.ursulin@igalia.com>
References: <20260522090129.9385-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: pj6six8h95q93rwby9zzhwrpugixq7g7
X-MBO-RS-ID: 6113b225984f0bd0ec5
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

Yo Tvrtko,

On Fri, 2026-05-22 at 10:01 +0100, Tvrtko Ursulin wrote:
> Initializing compile time constant struct or arrays from another such
> variable is a gcc extension, while clang strictly requires a compile time
> constant literal.
>=20
> As reported by LKP:
>=20
> > > drivers/gpu/drm/scheduler/tests/tests_scheduler.c:675:10: error: init=
ializer element is not a compile-time constant
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_sched_scheduler_two_clien=
ts_attr),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
> =C2=A0=C2=A0 include/kunit/test.h:224:13: note: expanded from macro 'KUNI=
T_CASE_PARAM_ATTR'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .attr =3D attributes, .mod=
ule_name =3D KBUILD_MODNAME}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~
> =C2=A0=C2=A0 1 error generated.

Hmm, is it now a build error, or a build warning? The commit title says
"warning".

Depending on what it really is, where should it go, misc-next or misc-
fixes?

P.

>=20
> vim +675 drivers/gpu/drm/scheduler/tests/tests_scheduler.c
>=20
> =C2=A0=C2=A0 671
> =C2=A0=C2=A0 672	static struct kunit_case drm_sched_scheduler_two_clients=
_tests[] =3D {
> =C2=A0=C2=A0 673		KUNIT_CASE_PARAM_ATTR(drm_sched_scheduler_two_clients_t=
est,
> =C2=A0=C2=A0 674				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_sched_scheduler_tw=
o_clients_gen_params,
> =C2=A0> 675				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_sched_scheduler_two_cli=
ents_attr),
> =C2=A0=C2=A0 676		{}
> =C2=A0=C2=A0 677	};
> =C2=A0=C2=A0 678
>=20
> Fix it by using a compound literal as other tests do.
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202605220312.Pu7UO05u-lkp@i=
ntel.com/
> Fixes: 97ef806a5314 ("drm/sched: Add some scheduling quality unit tests")
> Cc: Philipp Stanner <phasta@kernel.org>
> ---
> =C2=A0drivers/gpu/drm/scheduler/tests/tests_scheduler.c | 12 ++----------
> =C2=A01 file changed, 2 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/tests/tests_scheduler.c b/drivers/=
gpu/drm/scheduler/tests/tests_scheduler.c
> index 8b2e4ef9915f..90d31888cf92 100644
> --- a/drivers/gpu/drm/scheduler/tests/tests_scheduler.c
> +++ b/drivers/gpu/drm/scheduler/tests/tests_scheduler.c
> @@ -666,14 +666,10 @@ static void drm_sched_scheduler_two_clients_test(st=
ruct kunit *test)
> =C2=A0	}
> =C2=A0}
> =C2=A0
> -static const struct kunit_attributes drm_sched_scheduler_two_clients_att=
r =3D {
> -	.speed =3D KUNIT_SPEED_SLOW,
> -};
> -
> =C2=A0static struct kunit_case drm_sched_scheduler_two_clients_tests[] =
=3D {
> =C2=A0	KUNIT_CASE_PARAM_ATTR(drm_sched_scheduler_two_clients_test,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_sched_scheduler_two_clients_g=
en_params,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_sched_scheduler_two_clients_attr),
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { .speed =3D KUNIT_SPEED_SLOW }),
> =C2=A0	{}
> =C2=A0};
> =C2=A0
> @@ -858,14 +854,10 @@ static void drm_sched_scheduler_many_clients_test(s=
truct kunit *test)
> =C2=A0		drm_mock_sched_entity_free(client[i].entity);
> =C2=A0}
> =C2=A0
> -static const struct kunit_attributes drm_sched_scheduler_many_clients_at=
tr =3D {
> -	.speed =3D KUNIT_SPEED_SLOW,
> -};
> -
> =C2=A0static struct kunit_case drm_sched_scheduler_many_clients_tests[] =
=3D {
> =C2=A0	KUNIT_CASE_PARAM_ATTR(drm_sched_scheduler_many_clients_test,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_sched_scheduler_many_clients_=
gen_params,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_sched_scheduler_many_clients_attr)=
,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { .speed =3D KUNIT_SPEED_SLOW }),
> =C2=A0	{}
> =C2=A0};
> =C2=A0

