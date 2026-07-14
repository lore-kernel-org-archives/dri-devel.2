Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A71DC43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 00:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E17210EA62;
	Tue, 14 Jul 2026 00:05:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UvT4XmfH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6B4C10EA62
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 00:05:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4A58860103;
 Tue, 14 Jul 2026 00:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37981F000E9;
 Tue, 14 Jul 2026 00:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783987535;
 bh=KH+PLA2yBDFgXoaLBDsnVJHzGjHFoY6ikH0URSDWkZ8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UvT4XmfHamZUz4jiYwzSHEZtJHt/5KBKBLmY6oCAlrTVumS2M1XP9ZMiUvkGjORPm
 Sql7CFCEeAzIZwCiM9sEDSYjLkXEh18Iy/Nm0WsIgW52U2dC0O3Ugu8GrRO5j4D72D
 W+pBOjlDvZ1IF050Yp8VT3anHZ+L+XYcULHCwlc7NOxWhIdgzg/FlG/q+k5oW8l9dx
 /rEztdjqPWVW6CRUApopvcB6KxLTVKrScSUuNgBemXXIIj+OgJmFqzRl5yHOf3gLxm
 jEpL34vd/HMv4FhvLpVyfr7c+/n972J60RtwQ3VmltxPNAtXC2TXWtUnl4Zf8YGlhC
 LKrX1siRfNafQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/9] drm/komeda: use drmm_writeback_connector_init()
To: "John Harrison" <John.Harrison@Igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713235153.3862650-5-John.Harrison@Igalia.com>
References: <20260713235153.3862650-1-John.Harrison@Igalia.com>
 <20260713235153.3862650-5-John.Harrison@Igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 00:05:34 +0000
Message-Id: <20260714000534.D37981F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Explicitly calling drmm_kfree() on a connector object after drmm_w=
riteback_connector_init() fails causes a Use-After-Free during device teard=
own.
--

--- Patch [4]: [PATCH v7 4/9] drm/komeda: use drmm_writeback_connector_init=
() ---
commit 3173648ea1f2a16e64287bfe2ee141ab88437977
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/komeda: use drmm_writeback_connector_init()

This commit updates the komeda driver to use drmm_writeback_connector_init()
instead of its non-managed counterpart to ensure proper cleanup of the job
queue. It also converts the encoder and connector allocations to use the
drmm_ APIs.

> --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
[ ... ]
> @@ -161,18 +157,29 @@ static int komeda_wb_connector_add(struct komeda_km=
s_dev *kms,
[ ... ]
> +	err =3D drmm_writeback_connector_init(&kms->base, wb_conn,
> +					    &komeda_wb_connector_funcs,
> +					    encoder,
> +					    formats, n_formats);
>  	komeda_put_fourcc_list(formats);
>  	if (err) {
> -		kfree(kwb_conn);
> +		drmm_kfree(&kms->base, kwb_conn);

[Severity: High]
Does explicitly calling drmm_kfree() here in komeda_wb_connector_add() on
the error path cause a use-after-free during device teardown?

If drmm_writeback_connector_init() fails after successfully calling
drmm_connector_init() internally (e.g., if property creation fails in
__drm_writeback_connector_init()), a managed cleanup action
(drm_connector_cleanup_action) will have already been registered.

Calling drmm_kfree() frees the kwb_conn memory, but leaves the cleanup
action registered in the DRM managed resources list. When
drm_managed_release() is later called, won't it execute the cleanup action
with a pointer to the already-freed connector?

>  		return err;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713235153.3862=
650-1-John.Harrison@Igalia.com?part=3D4
