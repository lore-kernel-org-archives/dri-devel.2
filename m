Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC55C44524
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBE3E10E826;
	Mon, 20 Jul 2026 08:58:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GYDYIwSJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10E6F10E826
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:58:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2937960A77;
 Mon, 20 Jul 2026 08:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1221F000E9;
 Mon, 20 Jul 2026 08:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784537924;
 bh=Iijv4ZpqfnV0aD7drMae5ETUPImumQ+IgL5SHeKN1hE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GYDYIwSJYBw+av0ZrMJdQZzCXYPg4IoFB+5piq2pCnLuDVsjUBlN79OOxS4BUVSyc
 if4BvZF3YOCmBxsYLfZiLxt+xdy0k1ePXvkOEm3qGD5+AoOZ7RcbOvJZQYBmFBq1QE
 vtN1JgI8N0V0XZ7+oGthCIRTBY88NptQRYO7GXcLB6r9k92ivEonYSy58+5rYfewte
 m1u3c3oZe+c+iKkMVgi2L3WMglwbe6NT6m7Z74dWxsXLaBdnlYGcT2J57TWqPAiroN
 EblBLoaUIGbcpPAePxU1Jj3iHF3H8IHkiGwd5lA42n0rqHSR0Akux2ee/e6CPwcEE+
 3QBpLFsIQMkUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/msm/mdss: Enable INT2_GDSC alongside CORE_GDSC
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260720-msm_gdsc2-v1-2-4687866d6cb0@oss.qualcomm.com>
References: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
 <20260720-msm_gdsc2-v1-2-4687866d6cb0@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 08:58:44 +0000
Message-Id: <20260720085844.9B1221F000E9@smtp.kernel.org>
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
- [High] Missing cleanup for IRQ domain and chained handler on power domain=
 attach failure.
--

--- Patch [2]: [PATCH 2/3] drm/msm/mdss: Enable INT2_GDSC alongside CORE_GD=
SC ---
commit 9d271e868146fa30f583363d709a200283bfe76e
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/mdss: Enable INT2_GDSC alongside CORE_GDSC

This patch explicitly attaches and manages the secondary INT2_GDSC power
domain for platforms that use it. It also ensures both power domains are
enabled during MDSS runtime PM activation.

> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mds=
s.c
> index 9087c4b290dba..63ece55c4f2ec 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c

[ ... ]

> @@ -421,6 +451,27 @@ static struct msm_mdss *msm_mdss_init(struct platfor=
m_device *pdev, bool is_mdp5
>  	irq_set_chained_handler_and_data(irq, msm_mdss_irq,
>  					 msm_mdss);
> =20
> +	/*
> +	 * When two power domains are listed in DT, the core framework does not
> +	 * auto-attach either of them.  Attach and manage both explicitly so
> +	 * that INT2_GDSC (needed for VIG2/VIG3) is enabled alongside the main
> +	 * CORE_GDSC.  Single-domain platforms are unaffected.
> +	 */
> +	if (of_count_phandle_with_args(pdev->dev.of_node, "power-domains",
> +				       "#power-domain-cells") > 1) {
> +		static const char * const mdss_pd_names[] =3D { "core", "int2" };
> +		static const struct dev_pm_domain_attach_data pd_data =3D {
> +			.pd_names =3D mdss_pd_names,
> +			.num_pd_names =3D ARRAY_SIZE(mdss_pd_names),
> +			.pd_flags =3D PD_FLAG_NO_DEV_LINK,
> +		};
> +
> +		ret =3D devm_pm_domain_attach_list(&pdev->dev, &pd_data,
> +						 &msm_mdss->pd_list);
> +		if (ret < 0)
> +			return ERR_PTR(ret);

[Severity: High]
If devm_pm_domain_attach_list() fails here, we return directly with an error
pointer. Since the msm_mdss structure is allocated with devm_kzalloc(), it
will be automatically freed by the devres subsystem when the probe fails.

However, irq_set_chained_handler_and_data() was already called just above to
register msm_mdss_irq() with msm_mdss as its data pointer.

Could this leave a dangling pointer in the active chained handler, resulting
in a use-after-free if an interrupt fires? Also, do we need to clean up the
IRQ domain created by _msm_mdss_irq_domain_add() before returning on this
error path?

> +	}
> +
>  	pm_runtime_enable(&pdev->dev);
> =20
>  	return msm_mdss;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-msm_gdsc2-=
v1-0-4687866d6cb0@oss.qualcomm.com?part=3D2
