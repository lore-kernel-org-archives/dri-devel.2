Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CE2606A32A
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 00:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h3UGOLWO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B252112819;
	Fri, 20 Nov 2026 00:19:18 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB37B112819
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 00:19:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A9DF8600BC;
 Fri, 20 Nov 2026 00:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3881C1F000CF;
 Fri, 20 Nov 2026 00:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795133950;
 bh=Duk5GOpQAfHv4RAkgFrY+zGDFG/T+3iehyRfUGvIiEw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h3UGOLWOI0i9zUCl4Ngc7Ci3DC7/802BpiOA33XacgHITlqX/nBv6+9N03wGztJNc
 g3e5j6PgNUtseEz103XZ7jhLm0vXHQSYF9QgHGuqRvBq3qCw70NYlIJ/kxFzJRDoby
 ieagX4OGvsTQmaV31553XT4meoAUQWorDV3VaSTjffADXg8DWtG14e9zVr7RjjO3Yf
 EurcFnBnbINBIyoT7TKYiRWot59g5zj2f3ERowC7M8oLvBKrPjh9FTdV5ZLFrgBwlL
 2Lg5E6EYxZtqK/sVhdkCsXSXpVDb9c8JWxaqcDzkbB86fij532LA+QEVCqQFq4P3Hv
 Y6Ebe8p0WKU6g==
Message-ID: <sashiko-outbox-224263@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 02/14] drm/bridge: it6505: quiesce work items before
 powering off
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <4578349476dde314604b9b65670d7545a01ab3c9.1795132452.git.daniel@makrotopia.org>
References: <cover.1795132452.git.daniel@makrotopia.org>
 <4578349476dde314604b9b65670d7545a01ab3c9.1795132452.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 00:19:09 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/bridge: it6505: missing IRQ sync in it6505_poweroff()
  allows work requeue
--

commit 047992d501bf36c86f72d05d9e0cb5d26d252fa0
Author: Daniel Golle <daniel@makrotopia.org>

drm/bridge: it6505: quiesce work items before powering off

This commit cancels link_works, hdcp_wait_ksv_list, and hdcp_work in
it6505_poweroff() before asserting reset and disabling the power rails.

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index e980cc6d5760c..52d7d818a5ea3 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -2804,6 +2804,9 @@ static int it6505_poweroff(struct it6505 *it6505)
>  	}
> =20
>  	disable_irq_nosync(it6505->irq);
> +	cancel_work_sync(&it6505->link_works);
> +	cancel_work_sync(&it6505->hdcp_wait_ksv_list);
> +	cancel_delayed_work_sync(&it6505->hdcp_work);
> =20
>  	if (pdata->gpiod_reset)
>  		gpiod_set_value_cansleep(pdata->gpiod_reset, 1);

[Severity: Medium]
Can an in-flight it6505_int_threaded_handler() requeue these work items
right after cancel_work_sync() and cancel_delayed_work_sync() return?

During system suspend, pm_runtime_force_suspend() disables runtime PM
and calls it6505_bridge_suspend() -> it6505_poweroff() without waiting
for a running threaded IRQ handler. Because it6505_poweroff() uses
disable_irq_nosync(), an already-running handler can schedule work
after the synchronous cancels finish:

CPU0                                  CPU1 (irq/it6505-int)
it6505_int_threaded_handler()
  regmap_bulk_read(INT_STATUS_01..03)
  it6505_irq_scdt()
    it6505_calc_video_info()
pm_runtime_force_suspend()
  it6505_poweroff()
    disable_irq_nosync(it6505->irq)
    cancel_work_sync(&link_works)
    ...
    gpiod_set_value_cansleep(reset, 1)
                                      schedule_work(&link_works)
                                        <-- runs against powered-off chip
    regulator_disable(...)
    it6505->powered =3D false;

Since it6505->powered is cleared last, the requeued work can issue I2C
and DP AUX transactions while the chip is held in reset or powering
down, or leave hdcp_work pending across poweroff. Using disable_irq()
(or synchronize_irq() when called from outside the IRQ thread) before
canceling the work items would ensure the handler has finished.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795132452.gi=
t.daniel@makrotopia.org?part=3D2
