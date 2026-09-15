Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A7FC982C1
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 127CD10EF26;
	Tue, 15 Sep 2026 18:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HXIKGTPx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6EBF10E884;
 Tue, 15 Sep 2026 18:58:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D3E8418B0;
 Tue, 15 Sep 2026 18:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9684D1F00893;
 Tue, 15 Sep 2026 18:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789498681;
 bh=IQbb0F7YkfTZArpY6cOHWblguSe1t6f3l8mHFxFtMb8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HXIKGTPx/a0eF303wbGwNj4E6iyNJS7cqkJcod3JHvQ829XAi4V2wpjy0b4/xWabi
 +irBm/46EGTkAjnFlOeIPVEusqAPOR2z7MghW2sEuwLdINRQuzM8VvvpEUE2QPhHTR
 Y9Xijey6F1tbDAHXOfCOck1KYUZlrPXvDCkB1C7NeqEtAfa1iW+oHl2LxJzgfXwAEM
 LpsTc0s9qz9KcLlZn5pacnD+n61ZhgqS7ZMEpHhm2paB6XTqH5aTrY7BGLKPvtelP5
 nl5i3IDQaivDnOkOwlyw+wr+NVNEDRgMOYqRE3YtVoPtxZPr5AXuJh8p0AZ7gP2/ct
 qu8y/QXWe20tQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/18] drm/i915/alpm: alpm_init() for DP2.1
To: "Animesh Manna" <animesh.manna@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260915180449.277933-4-animesh.manna@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-4-animesh.manna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 18:57:58 +0000
Message-Id: <20260915185800.9684D1F00893@smtp.kernel.org>
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
- [Medium] drm/i915/alpm: hardware state leak on hot-unplug due to prematur=
e capability reset
--

commit b6800420511819216ede410fb998491c8d931411
Author: Animesh Manna <animesh.manna@intel.com>

drm/i915/alpm: alpm_init() for DP2.1

This commit initializes ALPM for DP2.1 and separates out ALPM mutex-init
from alpm-init.

> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i9=
15/display/intel_dp.c
> index 650c8b39270be..b4742bd33cb42 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -6354,6 +6354,7 @@ intel_dp_detect(struct drm_connector *_connector,
>  		connector->dp.panel_replay_caps.su_support =3D false;
>  		connector->dp.panel_replay_caps.dsc_support =3D
>  			INTEL_DP_PANEL_REPLAY_DSC_NOT_SUPPORTED;
> +		intel_dp->alpm_dpcd =3D 0;

[Severity: Medium]
Does clearing this capability flag during the detect callback cause a=20
hardware state leak on hot-unplug?

When an active display is hot-unplugged, intel_dp_detect() runs and zeroes=
=20
intel_dp->alpm_dpcd here. However, userspace will subsequently issue an=20
atomic commit to disable the CRTC.=20

During that disable sequence, intel_alpm_disable() in intel_alpm.c checks=20
intel_dp->alpm_dpcd to see if it should proceed. Since the capability was=20
already cleared, the check evaluates to false and the function exits early.=
=20
This skips the register cleanup, leaving the transcoder's ALPM_CTL hardware=
=20
registers enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915180449.2779=
33-1-animesh.manna@intel.com?part=3D3
