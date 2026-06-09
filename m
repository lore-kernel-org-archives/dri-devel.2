Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B6ACD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 10:04:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6D3710E212;
	Tue,  9 Jun 2026 10:04:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T48p08K8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B058110E212
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 10:04:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2095160172;
 Tue,  9 Jun 2026 10:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A5A1F00893;
 Tue,  9 Jun 2026 10:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780999446;
 bh=VkIUTjHkKgLRNGdL1Gqzrk3CiiB/EE0hieV10JYzm/k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T48p08K8C8mkkjbCnC/1UDDYotWqjJ6sEQbRuXGtGVNWajG762UL78zOU7lyw+P4u
 KPnJ/DMPN0FWvVgKa/cfW9LrqkCBSYWZuUNkKbVDZ04Vt17VCnxQHPsXLydp30kCFK
 2Tu6eB3usdXErl0QhblQN/SGZ8eKjqvfSGnNATGjwEd6hkRTKo+9TDHicOLcIQ8Rm/
 Y10eaDalCe7A7ed2INikv5MpSLGUh752+gLIlk/ZEjAVK0x3am8fa/DvDAwZuHn0kz
 2PWibgo25D6c/Ws9DyiAibg9ezi9eBAwwiIfi5Ubz3cOQrD6T8ru4jqKgGfH6tWBhR
 hg48J0I1OkqYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/15] drm/msm/dp: split dp_ctrl_off() into stream
 and link parts
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609-dp_mstclean-v7-11-ea04113e8233@oss.qualcomm.com>
References: <20260609-dp_mstclean-v7-11-ea04113e8233@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 10:04:05 +0000
Message-Id: <20260609100406.A6A5A1F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] The error code returned by `msm_dp_ctrl_on_pixel_clk()` is ignored=
 in `msm_dp_ctrl_process_phy_test_request()`, allowing execution to proceed=
 even if clock enablement fails.
--

commit 63742fe8cd27d164a8457069750896b0e989b7f3
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: split dp_ctrl_off() into stream and link parts

This commit splits dp_ctrl_off() into stream and link parts so that for
MST cases we can control the link and pixel parts separately.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index 87c3a5517911f..90fba03de7f0b 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c

[ ... ]

> @@ -2240,7 +2240,8 @@ static int msm_dp_ctrl_process_phy_test_request(str=
uct msm_dp_ctrl_private *ctrl
>  	 * running. Add the global reset just before disabling the
>  	 * link clocks and core clocks.
>  	 */
> -	msm_dp_ctrl_off(&ctrl->msm_dp_ctrl, panel);
> +	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl);
> +	msm_dp_ctrl_off_link(&ctrl->msm_dp_ctrl, panel);
> =20
>  	ret =3D msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl, panel);
>  	if (ret) {

[Severity: High]
This isn't a bug introduced by this patch, but while looking at the rest of
msm_dp_ctrl_process_phy_test_request(), the return value from enabling the
pixel clock appears to be completely ignored:

	ret =3D msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate);

	msm_dp_ctrl_send_phy_test_pattern(ctrl);

	return 0;

If msm_dp_ctrl_on_pixel_clk() fails to prepare and enable the clock, it
returns a negative error code, but the code still continues execution. Does
processing the PHY test pattern and commanding the DP controller without a
successfully enabled stream clock leave the hardware in an undefined state?
Should we be checking this return value and exiting early on failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-dp_mstclea=
n-v7-0-ea04113e8233@oss.qualcomm.com?part=3D11
