Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18165CD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AD7910E183;
	Tue,  9 Jun 2026 08:19:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rvckHEWS";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E604010E183
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 08:19:35 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gZMJh6jc9z9trF;
 Tue,  9 Jun 2026 10:19:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1780993173; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PkY1gt9Nl/47kZMtxCPcEsFKk0hBrEqWI+UAe5w8Z1A=;
 b=rvckHEWSCfi5zaHK3WSVlgi8apHETFfNEt+WNo2Bpf1dJGu7lx2RF8SizADVYUgl+68UP8
 1kiEVnyicRlLsh6v1sxsjJ515XJ1WcUX485xsKcZu+UuVWP5GSFM30OZumybPuZkcL4LTZ
 xuA0YBJ15QySKCG+j7F0g1m/GyDWKuYJB2gKzzkMqmRlhcUEvSzW+ILMPGJMKfHesZd99O
 VLR8BUWfQv78FB88czPeabBM73y4kjhDPgJoH09RnEFijzVU1+W0rtqpqlV0YvlpFPhnV1
 +DORfV0YHBcnJ4hiXWkUSZCyApZlpH/Z3/Nvc71wF/sT4ByOoDAaK/OEGlQVLQ==
Message-ID: <a18c75843097322729ead2de6208d4e6924e164d.camel@mailbox.org>
Subject: Re: [PATCH][next] drm/sched: Fix spelling mistake "sumission" ->
 "submission"
From: Philipp Stanner <phasta@mailbox.org>
To: Colin Ian King <colin.i.king@gmail.com>, Matthew Brost	
 <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, Philipp
 Stanner	 <phasta@kernel.org>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <ckoenig.leichtzumerken@gmail.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 09 Jun 2026 10:19:28 +0200
In-Reply-To: <20260608172315.34626-1-colin.i.king@gmail.com>
References: <20260608172315.34626-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 1119736fab8938f5a7c
X-MBO-RS-META: ngg3pqx85xgypwzzadycz53tmg3iwnho
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

On Mon, 2026-06-08 at 18:23 +0100, Colin Ian King wrote:
> There is a spelling mistake in a pr_info message. Fix it.
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied to drm-misc-next, thx.

For the future, drm/sched submissions should also be sent to=20

dri-devel@lists.freedesktop.org


Regards
P.

> ---
> =C2=A0drivers/gpu/drm/scheduler/tests/tests_scheduler.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/tests/tests_scheduler.c b/drivers/=
gpu/drm/scheduler/tests/tests_scheduler.c
> index 90d31888cf92..285546a2218f 100644
> --- a/drivers/gpu/drm/scheduler/tests/tests_scheduler.c
> +++ b/drivers/gpu/drm/scheduler/tests/tests_scheduler.c
> @@ -599,7 +599,7 @@ static void drm_sched_scheduler_two_clients_test(stru=
ct kunit *test)
> =C2=A0	 *=C2=A0 -=C2=A0 qd: Number of outstanding jobs in the client/enti=
ty
> =C2=A0	 */
> =C2=A0
> -	pr_info(" [pct] - Job sumission progress\n"
> +	pr_info(" [pct] - Job submission progress\n"
> =C2=A0" [cps] - Cycles per second\n"
> =C2=A0"=C2=A0 [qd] - Number of outstanding jobs in the client/entity\n");
> =C2=A0	pr_info("%s:\n\t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 pct1 cps1 qd1;=C2=A0 pct2 cps2 qd2\n",
