Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA9DC61CE2
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:40:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A395D10E756;
	Mon, 24 Aug 2026 11:40:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fGo38Ekg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63FE610E756
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:40:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0A3A4412CB;
 Mon, 24 Aug 2026 11:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA021F000E9;
 Mon, 24 Aug 2026 11:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787571645;
 bh=abkoSPlNA/2tyVeA4AK9TVBNqiexJLdZyqZaGlsFMd4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fGo38EkgtEBMKaMMRmyjYXXKyT1wp7m6EvCipnJiQP2F+QXH1zHna86JCEhJzUA7e
 YIkAkQspl/Z+sOMWDPv4rXL4pdZ+A91qMKBuTeDVuKU00RMdg9YP1d6Q50Ptw10K0b
 R7+4MLG4gaButR6siAWB0O+dz53nxvLxBPnPAs38dvMdYvvy+a/vbYPSpZdzVYg0hy
 3w6vQ4hjAg11/Bb+XZ+87RNl/Yd+PhdJtEXGcoaiIOOFrDtIHP54WUk2NuP4r/W5GH
 ZlNSOUiGXlPoabqGNj3nP0ZCyUHRQQXpqGg3sYTU/REcCBO5W9Rf5g4DrJ8bHTy7D5
 16FsAaSO1+JGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] drm/msm/dp: clear force_link_train flag when link
 training succeeds
To: "Saurabh Anand" <saurabh.anand@oss.qualcomm.com>
Cc: vkoul@kernel.org, olteanv@gmail.com, dri-devel@lists.freedesktop.org,
 neil.armstrong@linaro.org, linux-phy@lists.infradead.org
In-Reply-To: <20260824-qcom-dp-typec-reconnect-fixes-v1-2-2825e5bf8a96@oss.qualcomm.com>
References: <20260824-qcom-dp-typec-reconnect-fixes-v1-0-2825e5bf8a96@oss.qualcomm.com>
 <20260824-qcom-dp-typec-reconnect-fixes-v1-2-2825e5bf8a96@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 11:40:45 +0000
Message-Id: <20260824114045.ADA021F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] Dead store of `force_link_train` introduced by the patch.

Pre-existing issues:
- [High] Failure in `pm_runtime_resume_and_get()` leads to a PM runtime usa=
ge count underflow.
- [High] Uninitialized stack memory read in `msm_dp_ctrl_channel_eq_ok()`.
--

--- Patch [2]: [PATCH 2/4] drm/msm/dp: clear force_link_train flag when lin=
k training succeeds ---
commit 03a67937ce09f7bc428c5c9c18503745e41c62f6
Author: Saurabh Anand <saurabh.anand@oss.qualcomm.com>

drm/msm/dp: clear force_link_train flag when link training succeeds

msm_dp_display_prepare_link() sets force_link_train =3D true before calling
msm_dp_ctrl_on_link(). On success the flag was never cleared, so
msm_dp_ctrl_prepare_stream_on() would unconditionally trigger a second
link retrain even though the link was already trained. Clear
force_link_train on the success path so that
msm_dp_ctrl_prepare_stream_on() only retrains when the channel EQ check
fails, as intended.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index bc646d172abe0..40e19d506a450 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -649,6 +649,8 @@ static int msm_dp_display_prepare_link(struct msm_dp_=
display_private *dp)

[Severity: High]
This isn't a bug introduced by this patch, but does the pm_runtime error
handling cause a usage count underflow?

If pm_runtime_resume_and_get() fails earlier in msm_dp_display_prepare_link=
(),
it returns an error without acquiring a PM runtime reference:

	rc =3D pm_runtime_resume_and_get(&msm_dp_display->pdev->dev);
	if (rc) {
		DRM_ERROR("failed to pm_runtime_resume\n");
		return rc;
	}

Since the DRM core atomic_enable callback returns void, the framework
considers the device enabled and will later call the atomic_post_disable
hook. This routes to msm_dp_display_unprepare(), which unconditionally
drops the reference:

	pm_runtime_put_sync(&msm_dp_display->pdev->dev);

Will this drop a reference that was never acquired and lead to possible
device lockups?

>  		return rc;
>  	}
> =20
> +	force_link_train =3D false;
> +

[Severity: Low]
Does this unconditionally overwrite the previous assignment?

Earlier in msm_dp_display_prepare_link(), force_link_train is set to true:

	if (!msm_dp_display->power_on) {
		msm_dp_display_host_phy_init(dp);
		force_link_train =3D true;
		dp->ctrl->plugged =3D dp->plugged;
	}

By setting it to false here unconditionally, does the prior assignment beco=
me
dead code? Could this parameter just be removed or passed as false directly?

>  	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_tr=
ain);

[Severity: High]
This is a pre-existing issue, but by clearing force_link_train on the
success path here, this patch makes msm_dp_ctrl_prepare_stream_on() evaluate
the channel EQ check. Does this lead to an uninitialized stack memory read?

When force_link_train is false, it eventually calls
msm_dp_ctrl_channel_eq_ok() which passes an uninitialized stack buffer to
drm_dp_dpcd_read_link_status():

	u8 link_status[DP_LINK_STATUS_SIZE];
	...
	drm_dp_dpcd_read_link_status(ctrl->aux, link_status);
	return drm_dp_channel_eq_ok(link_status, num_lanes);

If drm_dp_dpcd_read_link_status() fails (e.g., if the AUX channel fails), it
returns an error without initializing the buffer. Its return value is ignor=
ed,
and the uninitialized stack buffer is then read by drm_dp_channel_eq_ok(),
which might cause unpredictable behavior depending on stack garbage.

Can we check the return value of drm_dp_dpcd_read_link_status() before using
the buffer?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-qcom-dp-ty=
pec-reconnect-fixes-v1-0-2825e5bf8a96@oss.qualcomm.com?part=3D2
