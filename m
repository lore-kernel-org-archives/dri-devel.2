Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D260BCA9EDD
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:24:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 242E010E489;
	Mon, 12 Oct 2026 15:24:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDE7710E5DE;
 Mon, 12 Oct 2026 15:24:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8683B4010D;
 Mon, 12 Oct 2026 15:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D271F0089B;
 Mon, 12 Oct 2026 15:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791818642;
 bh=ljXu+caLN0ZorGg/Pm7Yi0Z1ZCl/GuxHTJGiW7mty6I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I3eZIkksZuFkPMv0mc5t8FDrzgWv2Joz9ZFxTSGyC+VUZyW6rBYt4HXzu7vkmpNpD
 vk1qnzOyDQ6AHFjyRpa2GsIngyCUFcLXbI0Du6XqoWCzWQ6xbY3ckQOnvvZzldg4Dm
 KSXoxPPiAPhuaBhlfQiRmYicGACm26WDS39+6Km335mdv7UTK8zNH9Dv82zYqpAPXL
 jl6QUnGENCQtLon+45m0/rM5k/f7RRvS4nklDPDhH9QJ8sM8MZ3FN8IQ9ExlNBQH22
 +GmB6tEH7ZMzoIJowusK+Pdl/NmtCKBlyIJR+zchCokNIPiTzImSdrWtYpW97wbjNz
 8z9kamm0L5u/A==
Message-ID: <sashiko-outbox-168329@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 5/8] drm/i915/display/dp: Use dp_connector
 helpers to expose link training state
To: "Kory Maincent" <kory.maincent@bootlin.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20261012-feat_link_cap-v3-5-7517f4aba0f3@bootlin.com>
References: <20261012-feat_link_cap-v3-0-7517f4aba0f3@bootlin.com>
 <20261012-feat_link_cap-v3-5-7517f4aba0f3@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 15:24:01 +0000
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
- [High] drm/i915: lockdep splat and sleeping in atomic context via intel_d=
p_report_link_train
--

commit a5f66f1f6cf0713414f9ea60cce11fc6b162d6e4
Author: Kory Maincent <kory.maincent@bootlin.com>

drm/i915/display/dp: Use dp_connector helpers to expose link training state

Adopt the new DRM core DisplayPort helpers, which expose source and sink
capabilities along with the maximum and current link parameters to
userspace through the dp_link/ sysfs attributes.

[ ... ]

> diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/driv=
ers/gpu/drm/i915/display/intel_dp_link_training.c
> index cb92cff906146..c77cb124f1419 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c

[ ... ]

> @@ -1787,6 +1799,8 @@ void intel_dp_stop_link_train(struct intel_dp *inte=
l_dp,
>  	intel_dp_program_link_training_pattern(intel_dp, crtc_state, DP_PHY_DPR=
X,
>  					       DP_TRAINING_PATTERN_DISABLE);
> =20
> +	intel_dp_report_link_train(intel_dp);
> +

[Severity: High]
Does this new call introduce a lockdep splat and sleep in an atomic context?

intel_dp_stop_link_train() executes during encoder atomic enable callbacks =
as
part of the intel_atomic_commit_tail() sequence, which runs in an atomic
context.

The new intel_dp_report_link_train() delegates to the DRM core helper
drm_dp_set_cur_link_params():

void drm_dp_set_cur_link_params(...)
{
    ...
    drm_modeset_lock_assert_held(&connector->dev->mode_config.connection_mu=
tex);

    scoped_guard(mutex, &connector->dp.mutex) {
    ...
        _link_rates =3D kzalloc_obj(*_link_rates);
    ...
}

During non-blocking commits, the commit tail runs asynchronously in a worker
thread after the initial IOCTL has dropped all modeset locks. This causes t=
he
drm_modeset_lock_assert_held() to trigger a lockdep splat.

Furthermore, acquiring the sleeping mutex connector->dp.mutex and calling
kzalloc_obj() (which can sleep) in the atomic commit path violates DRM
subsystem invariants. Could this lead to kernel warnings and potential
deadlocks?

>  	if (intel_dp_is_uhbr(crtc_state)) {
>  		ret =3D poll_timeout_us(ret =3D intel_dp_128b132b_intra_hop(intel_dp, =
crtc_state),
>  				      ret =3D=3D 0,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-feat_link_=
cap-v3-0-7517f4aba0f3@bootlin.com?part=3D5
