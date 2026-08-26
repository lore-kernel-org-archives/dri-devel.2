Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F64C61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 04:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 412B310E254;
	Wed, 26 Aug 2026 04:55:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VkwIXuWg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1998810E241;
 Wed, 26 Aug 2026 04:55:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1A1DE600C4;
 Wed, 26 Aug 2026 04:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964831F000E9;
 Wed, 26 Aug 2026 04:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787720099;
 bh=inq/tJggElvtcHZcx3BQoc+hoZBzVPxpXcV9xQqp9PM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VkwIXuWgcf+TH1muhMcE5PTKyZH/4uMoHfUgPoPDG4czHI65m8NfzdNNTIamuS/kL
 3JPFo/MWaebSJrFo4EirNYrwF5ELrvbEGf0Wb7w5gkRVqXoxOMCVaDjeLAf2R9Kv6i
 Yoe7WFc7l+FKZQUdKhhvwHZF4suPTxXMj5xApZWjjtDWLWlB2zn1Q3jW98CNvrWlcm
 CMTLR//zS+2DLc3cbuxMHRcWLSyfexsiOUHrjAxxx3f+GMsvEOvSuGqhEnT86q5i+a
 HdiL8m8dQ0G7yKtb7d6BNfKVnuVhPDnmElSJC8oGecxuuRDPUpdHU38BquD/9DcYPn
 4YE/1K9ZlCqNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/dp: remove redundant link state check
To: tarund18303@gmail.com
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20260826044533.9292-1-tarund18303@gmail.com>
References: <20260826044533.9292-1-tarund18303@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 04:54:59 +0000
Message-Id: <20260826045459.964831F000E9@smtp.kernel.org>
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
- [Medium] Removing the DP link state check from `intel_dp_detect()` breaks=
 recovery for monitors that drop link synchronization silently (without sen=
ding an HPD IRQ).
--

commit 26b9e2acc7df07dcc2e2026421a5c54d7a72b52e
Author: tarun-tarun143 <tarund18303@gmail.com>

drm/i915/dp: remove redundant link state check

This commit removes the DP link state check from intel_dp_detect(), relying
instead on the link recovery paths after modesets and hotplug events.

> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i9=
15/display/intel_dp.c
> index 113d767e62e9c..ffd39206b958e 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -6379,18 +6379,6 @@ intel_dp_detect(struct drm_connector *_connector,
>  		status =3D connector_status_disconnected;
>  		goto out_unset_edid;
>  	}
> -
> -	/*
> -	 * Some external monitors do not signal loss of link synchronization
> -	 * with an IRQ_HPD, so force a link status check.
> -	 *
> -	 * TODO: this probably became redundant, so remove it: the link state
> -	 * is rechecked/recovered now after modesets, where the loss of
> -	 * synchronization tends to occur.
> -	 */
> -	if (!intel_dp_is_edp(intel_dp))
> -		intel_dp_check_link_state(intel_dp);
> -

[Severity: Medium]
Does removing this check break recovery for monitors that drop link
synchronization silently?

While the link state is recovered after modesets and hotplug events, some
non-compliant monitors fail to assert an HPD IRQ when the main link drops
due to issues like EMI. When this hardware failure happens, a user or
desktop environment running a probe calls intel_dp_detect().

Before this patch, intel_dp_detect() would read the DPCD link status and
queue a link retrain, acting as a manual fallback. By removing this check,
intel_dp_detect() succeeds via the independent AUX channel but ignores the
broken main link. Will this leave users with a permanent blank screen until
a full modeset or physical replug is performed?

>  	/*
>  	 * Clearing NACK and defer counts to get their exact values
>  	 * while reading EDID which are required by Compliance tests

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826044533.9292=
-1-tarund18303@gmail.com?part=3D1
