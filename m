Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D15EC5DF67
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 00:15:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D436B10F408;
	Fri, 14 Aug 2026 00:15:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gMSGPN8S";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 313DD10F408;
 Fri, 14 Aug 2026 00:15:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EE21E42A7E;
 Fri, 14 Aug 2026 00:15:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047071F000E9;
 Fri, 14 Aug 2026 00:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786666525;
 bh=YzPAAS/A9UrNGVNsI/JuS8STP2hnc4Y4oqajK05GBI0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gMSGPN8SgfcqRd8qT0DMAKNyarNqv0FrVpYzcUtooIV711y/vcX66f+uk9h4sGOwJ
 jeQc+LjHKF6StmqcmaVRUtezXMURIp21EKCLkrb9973W4CMBwU7t+rp/uWr108QRHN
 ziL9aEaLatyWoCnN+50mG86ItQsI7Uyi/DwarCDxGpWAbOfOqSBQ9X1R9r8VKizPiG
 boMiER3jTE0fHiG5Ci7LBwKhgmWp19N7yFPsU9gbZKvQ660XwdnxMLzDPcCpk5ylxf
 0HQhRPltkCB2TVftkUh+amnatxoyDgZ9FnEH0DJ0zvrUEeolYdsq3HTNJxhzooi29z
 z1y0yPyZxB/fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 04/12] drm/i915/display: Switch to
 drmm_mode_config_init() and drop manual cleanup
To: "Kory Maincent" <kory.maincent@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260409-feat_link_cap-v1-4-7069e8199ce2@bootlin.com>
References: <20260409-feat_link_cap-v1-4-7069e8199ce2@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 00:15:24 +0000
Message-Id: <20260814001525.047071F000E9@smtp.kernel.org>
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
- [High] Deferring `intel_mode_config_cleanup` to a `drmm` action causes Us=
e-After-Free (UAF) crashes during driver teardown because dependent resourc=
es are prematurely destroyed.
--

--- Patch [4]: [PATCH RFC 04/12] drm/i915/display: Switch to drmm_mode_conf=
ig_init() and drop manual cleanup ---
commit 6ace97a8635ec8a367a634fb62172f65c853696d
Author: Kory Maincent <kory.maincent@bootlin.com>

drm/i915/display: Switch to drmm_mode_config_init() and drop manual cleanup

Replace drm_mode_config_init() with drmm_mode_config_init() in
intel_mode_config_init(). Remove the manual intel_mode_config_cleanup()
calls during teardown since the managed variant registers the cleanup with
devres automatically. Register intel_atomic_global_obj_cleanup() as a devres
action to run before drm_mode_config_cleanup().

> diff --git a/drivers/gpu/drm/i915/display/intel_display_driver.c b/driver=
s/gpu/drm/i915/display/intel_display_driver.c
> index 23bfecc983e8d..d02393053cef4 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_driver.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_driver.c

[ ... ]

> @@ -618,8 +631,6 @@ void intel_display_driver_remove_noirq(struct intel_d=
isplay *display)
> =20
>  	intel_hdcp_component_fini(display);
> =20
> -	intel_mode_config_cleanup(display);
> -
>  	intel_dp_tunnel_mgr_cleanup(display);
> =20
>  	intel_overlay_cleanup(display);

[Severity: High]
Does deferring intel_mode_config_cleanup() here cause a use-after-free duri=
ng
driver teardown?

Because intel_mode_config_cleanup() is removed here, mode config cleanup (w=
hich=20
frees connectors and encoders) is deferred to the asynchronous drmm phase.=
=20
However, intel_dp_tunnel_mgr_cleanup() and the destruction of the display
workqueues (which occur later in this function) still happen synchronously.

This inverts the teardown order so the tunnel manager and workqueues are fr=
eed
before the encoders that depend on them. When the deferred=20
drm_mode_config_cleanup() finally runs, it destroys encoders which triggers
intel_dp_tunnel_destroy(). This dereferences the dangling dp->tunnel pointe=
r and=20
the already freed tunnel->group->mgr.

Additionally, because delayed works (like intel_dp->pps.panel_vdd_work) are=
=20
only cancelled during the deferred encoder cleanup in intel_pps_vdd_off_syn=
c(),=20
their timers may fire after destroy_workqueue() has already freed the workq=
ueue,=20
causing queue_work() to panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260409-feat_link_=
cap-v1-0-7069e8199ce2@bootlin.com?part=3D4
