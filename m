Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB38606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mcUuyBi1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D51F810E04F;
	Tue,  3 Nov 2026 19:45:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A79B10E04F
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 19:45:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4843342A19;
 Tue,  3 Nov 2026 19:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057521F000C1;
 Tue,  3 Nov 2026 19:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793735131;
 bh=v+NOLSdV+a7ZklaPBhMdx7f8LfEOMRoCQO8f0/UxI+0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mcUuyBi1ClkJFX7pKtS6B9WWOHVnh19ZUyk4GG+sANdts6Cle9ef5o8S0oELmzJKK
 PW87EyQ2et4SAn91Tho/TOI0d1wydQKbrdWsFxZmtXLyJA2FW7/aM62Na0Qlu/gsq4
 pMgPla1oXsBfejtc13l97YO4/I/fgwWqJvBifRVfDPqGrhb8dwgEmCCyRp0PvKZf62
 kkH2EpeW7AiK0Gzow1Oqj1cZD0JpUJ8Ut0g1a0NFPlf1+ZR26OGqIL6HjoMhrBW72y
 X9rr7n+HLTdnhDL0X+T9k3Km9ucoRihjs2aYOlrv++f3iibqHprVyzFt2MtF72qJul
 GhKGSbOMRFWJw==
Message-ID: <sashiko-outbox-195933@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] drm/nouveau: don't let an IRQ_HPD hide a plug or
 unplug event
To: "David R. Hedges" <linuxdev844@thelittleman.net>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261103-nouveau-dp-fixes-v1-5-892f4bd357cd@thelittleman.net>
References: <20261103-nouveau-dp-fixes-v1-0-892f4bd357cd@thelittleman.net>
 <20261103-nouveau-dp-fixes-v1-5-892f4bd357cd@thelittleman.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 19:45:30 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm/nouveau: lost plug/unplug bits in nouveau_connector_hpd() wh=
en pending
- [Medium] drm/nouveau: nouveau_display_hpd_work() skips link check on IRQ =
with plug
--

commit 8aa36f0d839e814a361fc038f601698183c285f9
Author: David R. Hedges <linuxdev844@thelittleman.net>

drm/nouveau: don't let an IRQ_HPD hide a plug or unplug event

This commit updates nouveau_display_hpd_work() so that the
nouveau_dp_link_check() shortcut is only taken when NVIF_CONN_EVENT_V0_IRQ =
is
set without NVIF_CONN_EVENT_V0_PLUG or NVIF_CONN_EVENT_V0_UNPLUG. This
prevents plug or unplug events queued alongside an IRQ_HPD from skipping
connector detection.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/=
nouveau/nouveau_display.c
> index d71dcfc6ee66b..4398cf0fc541c 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_display.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_display.c
> @@ -462,7 +462,12 @@ nouveau_display_hpd_work(struct work_struct *work)
>  			    !!(bits & NVIF_CONN_EVENT_V0_UNPLUG),
>  			    !!(bits & NVIF_CONN_EVENT_V0_IRQ));
> =20
> -		if (bits & NVIF_CONN_EVENT_V0_IRQ) {
> +		/* A plug or unplug event pending alongside the IRQ, such as a
> +		 * sink count change reported by nouveau_dp_irq(), still needs
> +		 * connector detection.
> +		 */
> +		if ((bits & NVIF_CONN_EVENT_V0_IRQ) &&
> +		    !(bits & (NVIF_CONN_EVENT_V0_PLUG | NVIF_CONN_EVENT_V0_UNPLUG))) {

[Severity: Medium]
Can a separate plug or unplug event still be dropped if it arrives while an
earlier NVIF_CONN_EVENT_V0_IRQ is already pending for the same connector?

In drivers/gpu/drm/nouveau/nouveau_connector.c:nouveau_connector_hpd(),
updating nv_connector->hpd_pending is guarded by the drm->hpd_pending check:

	spin_lock_irqsave(&drm->hpd_lock, flags);
	if (!(drm->hpd_pending & mask)) {
		nv_connector->hpd_pending |=3D bits;
		drm->hpd_pending |=3D mask;
		schedule_work(&drm->hpd_work);
	}
	spin_unlock_irqrestore(&drm->hpd_lock, flags);

If nouveau_connector_irq() -> nouveau_dp_irq() first queues
NVIF_CONN_EVENT_V0_IRQ (before a sink count change is visible), and a plug =
or
unplug event then arrives via nouveau_connector_hotplug() or a follow-up
nouveau_dp_irq() before nouveau_display_hpd_work() finishes
pm_runtime_get_sync() and clears drm->hpd_pending, drm->hpd_pending & mask =
is
already set. The new NVIF_CONN_EVENT_V0_PLUG or NVIF_CONN_EVENT_V0_UNPLUG b=
it
is never ORed into nv_connector->hpd_pending.

When nouveau_display_hpd_work() then reads nv_connector->hpd_pending, bits
still only contains NVIF_CONN_EVENT_V0_IRQ, so nouveau_dp_link_check() retu=
rns
true when no link is trained and connector detection is still skipped.

Should nv_connector->hpd_pending |=3D bits be moved outside the
if (!(drm->hpd_pending & mask)) check in nouveau_connector_hpd()?

>  			if (nouveau_dp_link_check(nv_connector))
>  				continue;
>  		}

[Severity: Medium]
Does guarding the outer if statement instead of the continue statement skip
DP link retraining when NVIF_CONN_EVENT_V0_IRQ is set alongside
NVIF_CONN_EVENT_V0_PLUG or NVIF_CONN_EVENT_V0_UNPLUG?

In drivers/gpu/drm/nouveau/nouveau_dp.c, nouveau_dp_link_check() ->
nouveau_dp_link_check_locked() is the only HPD path that checks channel
equalization on an active link (outp->dp.lt.nr !=3D 0) and retrains it via
nouveau_dp_train_link(outp, true):

	if (drm_dp_dpcd_read_phy_link_status(&outp->conn->aux, DP_PHY_DPRX, link_s=
tatus) < 0)
		return false;

	if (drm_dp_channel_eq_ok(link_status, outp->dp.lt.nr))
		return true;

	return nouveau_dp_train_link(outp, true);

If a plug event runs first and nouveau_display_hpd_work() clears
drm->hpd_pending =3D 0 before acquiring dev->mode_config.mutex, a subsequent
IRQ_HPD in nouveau_dp_irq() -> nouveau_connector_hpd() sees
!(drm->hpd_pending & mask), ORs NVIF_CONN_EVENT_V0_IRQ into
nv_connector->hpd_pending alongside NVIF_CONN_EVENT_V0_PLUG, and reschedules
drm->hpd_work. The same combination also occurs directly when nouveau_dp_ir=
q()
observes a sink count change on an active SST branch device while the link
needs retraining.

The first worker run sees both NVIF_CONN_EVENT_V0_IRQ and
NVIF_CONN_EVENT_V0_PLUG in bits, clears nv_connector->hpd_pending =3D 0, and
skips nouveau_dp_link_check(). Because drm_helper_probe_detect() ->
nouveau_connector_detect() -> nouveau_dp_detect() does not check link status
or retrain the link, and any rescheduled worker run sees bits =3D=3D 0, the=
 link
check is lost.

Would it be better to always run nouveau_dp_link_check(nv_connector) when
NVIF_CONN_EVENT_V0_IRQ is set, and only guard the continue statement with
!(bits & (NVIF_CONN_EVENT_V0_PLUG | NVIF_CONN_EVENT_V0_UNPLUG))?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-nouveau-dp=
-fixes-v1-0-892f4bd357cd@thelittleman.net?part=3D5
