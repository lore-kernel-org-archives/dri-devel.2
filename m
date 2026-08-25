Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B772BC5DF94
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1823C10E147;
	Tue, 25 Aug 2026 07:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QWYPSP2U";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B59E10E147
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 07:04:17 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hTf0D3xMlzMlGx;
 Tue, 25 Aug 2026 09:04:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1787641452; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uOP/hLg2FQ8M+cMhsdxEmpQUHtNFWueP+7aSMa7zd1c=;
 b=QWYPSP2UO6otNe3YMTN3sCLarwEMbEq+g8J7zz0n0vYHwQqiCTWi6Oqk2v1BRnMnEuBKAk
 9PtZhH3c4l3JJl48W51ojmXhRL/iRWcSRo0Q6DUhR4yDnsFTgXpnuhLiXzyF1eC27ftwTM
 AgOBKPzckx2vS8mGWB8Zy/99eSl2YPRT/PWWOg8vfrNKWZrkttfkw3+cVkcBkq7UuS5ecr
 zKZn+qB8qIkwOpyPnvwg62hj5EfnKvZBYVmX3FLcLX7X/b0yvpmt54gkIszRzbFadIviFc
 /LgTU29hHJ7Von4pdys3taryFvbws1UtBKx4Q79r+/3dGzFFuQDWdgjOENhb3w==
Message-ID: <80fa7da564cc13783063b892d0fa06752ec55bdf.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Fix incorrect test description in
 drm_sched_basic_cases
From: Philipp Stanner <phasta@mailbox.org>
To: oushixiong1025@163.com, Matthew Brost <matthew.brost@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Christian =?ISO-8859-1?Q?K=F6nig?=	 <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Shixiong Ou	
 <oushixiong@kylinos.cn>
Date: Tue, 25 Aug 2026 09:04:01 +0200
In-Reply-To: <20260821084733.541572-1-oushixiong1025@163.com>
References: <20260821084733.541572-1-oushixiong1025@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: e6bh5hazirmez4zhhdujyq646q31qs48
X-MBO-RS-ID: 8e113bed2184f043dbe
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

+Cc Marco, Tvrtko

On Fri, 2026-08-21 at 16:47 +0800, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
>=20
> The second test case in drm_sched_basic_cases[] has num_entities =3D 1
> but its description claims "across multiple entities".=C2=A0 Fix it to
> accurately reflect that the dependency chain operates within a single
> entity.
>=20
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>

Thx for the patch. Applied to drm-misc-next.


Tvrtko, added you for awareness. Maybe this indicates a gap in the test
coverage as you originally envisioned it?

P.

> ---
> =C2=A0drivers/gpu/drm/scheduler/tests/tests_basic.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/tests/tests_basic.c b/drivers/gpu/=
drm/scheduler/tests/tests_basic.c
> index da5c4952780f..34bbb2c27913 100644
> --- a/drivers/gpu/drm/scheduler/tests/tests_basic.c
> +++ b/drivers/gpu/drm/scheduler/tests/tests_basic.c
> @@ -90,7 +90,7 @@ static const struct drm_sched_basic_params drm_sched_ba=
sic_cases[] =3D {
> =C2=A0		.num_entities =3D 1,
> =C2=A0	},
> =C2=A0	{
> -		.description =3D "A chain of dependent jobs across multiple entities",
> +		.description =3D "A chain of dependent jobs in a single entity",
> =C2=A0		.queue_depth =3D 100,
> =C2=A0		.job_us =3D 1000,
> =C2=A0		.num_entities =3D 1,
