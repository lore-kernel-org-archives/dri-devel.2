Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4100CD5BD2
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 09:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F42510FBA7;
	Fri, 29 May 2026 09:20:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="AGaCOPVK";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EFFB10FBA7
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 09:20:49 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gRdBG1g1Fz9v5S;
 Fri, 29 May 2026 11:20:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1780046446; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=246KX2myjlNcYzwRwcWKy96PrTmzZx2ijjurnCdjG/0=;
 b=AGaCOPVKlp3BHEmYyG4N+p4NHcXc800gFj1gnxEPQLCp8Zu5m8aM6l2EOi5xPgvloJXNM6
 Mf31A3k3jn/VmclNtdwFCsrc8vYHJczKjYt7sxeUbVT6bGpdd25Hu1Hem/xGYGzeRnzq8E
 YwqnTnl8aJ2ysB+POlbla3JGFnMtftvOSB6gvf/bKbREoFwIYzBCJ7cDEj8wdDa7THS7CA
 h0TxpPa/nu67TJMw1zyod5JUwAXC1oFDL+oceJ+hGCT1r4PxAB2g/m1sD2jHq/pheYk25Q
 CMuvGEO2mxvoTEUOyfgme48XeSHKL7sHbguuJnOErrp/FntoERAMjdo7Cd3UvA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of phasta@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=phasta@mailbox.org
Message-ID: <db213e09d23fb2e3315059b9f3c2dd9d3b9bee4e.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Fix clang build warning in kunit tests
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org, 
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, kernel test robot <lkp@intel.com>
Date: Fri, 29 May 2026 11:20:27 +0200
In-Reply-To: <8a65c09e-c03a-43ce-94af-cbf5c4fcef94@igalia.com>
References: <20260522090129.9385-1-tvrtko.ursulin@igalia.com>
 <23df1e8b17c4ba5a9106b84a65e092ebd54fee42.camel@mailbox.org>
 <f01ffd7e-7a20-496e-9a7a-0f75a500be0c@igalia.com>
 <8a65c09e-c03a-43ce-94af-cbf5c4fcef94@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 0cf59a20dd2f122545b
X-MBO-RS-META: dbwufjj7komimjtfrbx7edi44xoq4kdm
X-Rspamd-Queue-Id: 4gRdBG1g1Fz9v5S
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

On Fri, 2026-05-29 at 08:16 +0100, Tvrtko Ursulin wrote:
>=20
> On 28/05/2026 14:38, Tvrtko Ursulin wrote:
> >=20
> > On 28/05/2026 14:03, Philipp Stanner wrote:
> > > Yo Tvrtko,
> > >=20
> > > On Fri, 2026-05-22 at 10:01 +0100, Tvrtko Ursulin wrote:
> > > > Initializing compile time constant struct or arrays from another su=
ch
> > > > variable is a gcc extension, while clang strictly requires a compil=
e=20
> > > > time
> > > > constant literal.
> > > >=20
> > > > As reported by LKP:
> > > >=20
> > > > > > drivers/gpu/drm/scheduler/tests/tests_scheduler.c:675:10: error=
:=20
> > > > > > initializer element is not a compile-time constant
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_sched_schedul=
er_two_clients_attr),
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~
> > > > =C2=A0=C2=A0=C2=A0 include/kunit/test.h:224:13: note: expanded from=
 macro=20
> > > > 'KUNIT_CASE_PARAM_ATTR'
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .attr =3D attr=
ibutes, .module_name =3D KBUILD_MODNAME}
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~
> > > > =C2=A0=C2=A0=C2=A0 1 error generated.
> > >=20
> > > Hmm, is it now a build error, or a build warning? The commit title sa=
ys
> > > "warning".
> > >=20
> > > Depending on what it really is, where should it go, misc-next or misc=
-
> > > fixes?
> >=20
> > Right, warning or error it depends if someone enabled CONFIG_DRM_WERROR=
.
> >=20
> > According to drm-misc commiter guidelines, since we are in -rc5, it can=
=20
> > go to drm-misc-next.
>=20
> Now it's=C2=A0 drm-misc-next-fixes I think since Maarten sent the last=
=20
> drm-misc-next pull request yesterday.

Acked-by: Philipp Stanner <phasta@kernel.org>

Feel free to do that as you see fit

Thx
P.

>=20
> Regards,
>=20
> Tvrtko
>=20
> > > > vim +675 drivers/gpu/drm/scheduler/tests/tests_scheduler.c
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 671
> > > > =C2=A0=C2=A0=C2=A0 672=C2=A0=C2=A0=C2=A0 static struct kunit_case=
=20
> > > > drm_sched_scheduler_two_clients_tests[] =3D {
> > > > =C2=A0=C2=A0=C2=A0 673=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=20
> > > > KUNIT_CASE_PARAM_ATTR(drm_sched_scheduler_two_clients_test,
> > > > =C2=A0=C2=A0=C2=A0 674=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 drm_sched_scheduler_two_clients_gen_params,
> > > > =C2=A0=C2=A0> 675=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=
rm_sched_scheduler_two_clients_attr),
> > > > =C2=A0=C2=A0=C2=A0 676=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {}
> > > > =C2=A0=C2=A0=C2=A0 677=C2=A0=C2=A0=C2=A0 };
> > > > =C2=A0=C2=A0=C2=A0 678
> > > >=20
> > > > Fix it by using a compound literal as other tests do.
> > > >=20
> > > > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes: https://lore.kernel.org/oe-kbuild-all/202605220312.Pu7UO05u=
-=20
> > > > lkp@intel.com/
> > > > Fixes: 97ef806a5314 ("drm/sched: Add some scheduling quality unit=
=20
> > > > tests")
> > > > Cc: Philipp Stanner <phasta@kernel.org>
> > > > ---
> > > > =C2=A0=C2=A0drivers/gpu/drm/scheduler/tests/tests_scheduler.c | 12 =
++----------
> > > > =C2=A0=C2=A01 file changed, 2 insertions(+), 10 deletions(-)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/scheduler/tests/tests_scheduler.c b/=
=20
> > > > drivers/gpu/drm/scheduler/tests/tests_scheduler.c
> > > > index 8b2e4ef9915f..90d31888cf92 100644
> > > > --- a/drivers/gpu/drm/scheduler/tests/tests_scheduler.c
> > > > +++ b/drivers/gpu/drm/scheduler/tests/tests_scheduler.c
> > > > @@ -666,14 +666,10 @@ static void=20
> > > > drm_sched_scheduler_two_clients_test(struct kunit *test)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > =C2=A0=C2=A0}
> > > > -static const struct kunit_attributes=20
> > > > drm_sched_scheduler_two_clients_attr =3D {
> > > > -=C2=A0=C2=A0=C2=A0 .speed =3D KUNIT_SPEED_SLOW,
> > > > -};
> > > > -
> > > > =C2=A0=C2=A0static struct kunit_case drm_sched_scheduler_two_client=
s_tests[] =3D {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KUNIT_CASE_PARAM_ATTR(drm_sched_sche=
duler_two_clients_test,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_sched_scheduler_two_clients=
_gen_params,
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_sched_scheduler_two_clients_attr),
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { .speed =3D KUNIT_SPEED_SLOW }),
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {}
> > > > =C2=A0=C2=A0};
> > > > @@ -858,14 +854,10 @@ static void=20
> > > > drm_sched_scheduler_many_clients_test(struct kunit *test)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_mock_sch=
ed_entity_free(client[i].entity);
> > > > =C2=A0=C2=A0}
> > > > -static const struct kunit_attributes=20
> > > > drm_sched_scheduler_many_clients_attr =3D {
> > > > -=C2=A0=C2=A0=C2=A0 .speed =3D KUNIT_SPEED_SLOW,
> > > > -};
> > > > -
> > > > =C2=A0=C2=A0static struct kunit_case drm_sched_scheduler_many_clien=
ts_tests[] =3D {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KUNIT_CASE_PARAM_ATTR(drm_sched_sche=
duler_many_clients_test,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_sched_scheduler_many_client=
s_gen_params,
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_sched_scheduler_many_clients_attr),
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { .speed =3D KUNIT_SPEED_SLOW }),
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {}
> > > > =C2=A0=C2=A0};
> > >=20
> >=20
>=20

