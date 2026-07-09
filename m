Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA211C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09B1510E55B;
	Thu,  9 Jul 2026 10:36:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="tFae9DUV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z29gMTuQ";
	dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C8A710E55B;
 Thu,  9 Jul 2026 10:36:53 +0000 (UTC)
Date: Thu, 9 Jul 2026 12:36:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1783593411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aeYVkDXbtSM1dfv57a5zyvpbgCuNmt8hZyk+ddryLsw=;
 b=tFae9DUVxDfeCfGJObLEeT8zCTCaQbRSeQiGjk6PNykJ5CvyNqBoZTVmSPjzm72LoMROuZ
 loTpCsUbp5RowSzaaw2o378BQbiKyWJAamd9rntqZaKeiD0L6wL9Yb3Wp1HGg/+gsLykZi
 R6FaKhPagdaqFw+1iIB8OjNUYgqfOyA0NY2/rm1GyKWxCqktj/rRcv1OkRtNhkw8CbeY7V
 HdcImlpf8YrNdBU2sFQNgxDFAfbtMAKD2ziYCK0uc9q5LDPrh9B7no1CRYSWzXlMjzn2ZX
 hmILgxYNUXu/KHijhF+/d3QRR3Ak/WFmA/SSCAiOks6p6YMnh8NhfbZIHCV5lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1783593411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aeYVkDXbtSM1dfv57a5zyvpbgCuNmt8hZyk+ddryLsw=;
 b=z29gMTuQSJ84uETZONIxOxF2wIw8/IgpRSUwyuOfKxrUWppnqY1zJGwhHElCWeJOOotrIh
 /Wf6xrXa7IS8ymDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 4/7] drm/i915/gt: Fix selftests on PREEMPT_RT
Message-ID: <20260709103650.VxAAiEnx@linutronix.de>
References: <20260706114823.752313-1-dev@lankhorst.se>
 <20260706114823.752313-5-dev@lankhorst.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260706114823.752313-5-dev@lankhorst.se>
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

On 2026-07-06 13:48:20 [+0200], Maarten Lankhorst wrote:
> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
> ---
>  drivers/gpu/drm/i915/gt/selftest_engine_pm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_pm.c b/drivers/gpu/d=
rm/i915/gt/selftest_engine_pm.c
> index 10e556a7eac45..c1eff9edd8a5e 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_engine_pm.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_engine_pm.c
> @@ -277,11 +277,11 @@ static int live_engine_busy_stats(void *arg)
>  		st_engine_heartbeat_disable(engine);
> =20
>  		ENGINE_TRACE(engine, "measuring idle time\n");
> -		preempt_disable();
> +		migrate_disable();
>  		de =3D intel_engine_get_busy_time(engine, &t[0]);

this change has been made probably due to guc_engine_busyness(). Looking
at execlists_engine_busyness() then there is a seqcount_t and the writer
side does local_irq_disable() during the update so this should work.
The comment says the writer is serialized but I don't see how (maybe
there is just one). So=E2=80=A6

Sebastian
