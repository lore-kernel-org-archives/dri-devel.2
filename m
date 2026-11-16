Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B0B606A888
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E9I352bd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9985510E5EA;
	Mon, 16 Nov 2026 13:47:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B8E210E5EA
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:47:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1F74162C08;
 Mon, 16 Nov 2026 13:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565381F000C9;
 Mon, 16 Nov 2026 13:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794836854;
 bh=2winabVpaM77ETlKEcvhcxQYA9iyVxIX98gUumohxek=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=E9I352bdxOVGz1bbCSomh0jG1MPe2WyunjGCj/dqH5fLaRu4sJ2ebF1oWpDF1HBSo
 ybDaYXhniwOrLFGc4w0x+pvwo6zjzCgaMaVSIjkxsKZu0gvRtDZg/r9cttPJUnGpVq
 xGVZR/aU7i0HGAxnOeFdQwqBxc3zSr75OLOfhm4exw4CBbHmt2KUIV4oPlRb5P2eL+
 7T2v65oqKnpYMOFk+21Ko7rihtda0ppBK5gmyRCC6PM76+jSrXvkmOzKMSC4G9YoWp
 hN7a//mzblHnjVyrO19v2SFk0SdSSZKUWl6Ba0mbk4QRQoLRTyaboQN8sjtIbDfNtJ
 fS6fEjMCdWrFQ==
Message-ID: <sashiko-outbox-217109@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/11] drm/msm/dpu: Add support for DPU 12.1 on Nord
To: "Nabige Aala" <nabige.aala@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261116-nord-drv-dt-v3-5-e3d3bf0e2c49@oss.qualcomm.com>
References: <20261116-nord-drv-dt-v3-0-e3d3bf0e2c49@oss.qualcomm.com>
 <20261116-nord-drv-dt-v3-5-e3d3bf0e2c49@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 13:47:33 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/msm/dpu: undeclared INTF_9 and INTF_10 in nord_intf break
  build
- [Medium] drm/msm/dpu: wrong interrupt bit assignments for
  intf_6..intf_10 on Nord
--

commit 26c8821f9a7d74ed713c34eb7d82f28a0037edd5
Author: Mahadevan P <mahadevan.p@oss.qualcomm.com>

drm/msm/dpu: Add support for DPU 12.1 on Nord

This commit adds the DPU 12.1 hardware catalog configuration and device tree
match entry for the Qualcomm Nord SoC.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_1_nord.h b/driv=
ers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_1_nord.h
> new file mode 100644
> index 0000000000000..333eccb5c603a
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_1_nord.h
> @@ -0,0 +1,544 @@

[ ... ]

> +static const struct dpu_intf_cfg nord_intf[] =3D {
> +	{
> +		.name =3D "intf_0", .id =3D INTF_0,
> +		.base =3D 0x34000, .len =3D 0x4bc,
> +		.type =3D INTF_DP,
> +		.controller_id =3D MSM_DP_CONTROLLER_0,
> +		.prog_fetch_lines_worst_case =3D 24,
> +		.intr_underrun =3D DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 24),
> +		.intr_vsync =3D DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 25),
> +	}, {
> +		.name =3D "intf_3", .id =3D INTF_3,
> +		.base =3D 0x37000, .len =3D 0x4bc,
> +		.type =3D INTF_DP,
> +		.controller_id =3D MSM_DP_CONTROLLER_0,
> +		.prog_fetch_lines_worst_case =3D 24,
> +		.intr_underrun =3D DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 30),
> +		.intr_vsync =3D DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 31),
> +	}, {
> +		.name =3D "intf_4", .id =3D INTF_4,
> +		.base =3D 0x38000, .len =3D 0x4bc,
> +		.type =3D INTF_DP,
> +		.controller_id =3D MSM_DP_CONTROLLER_1,
> +		.prog_fetch_lines_worst_case =3D 24,
> +		.intr_underrun =3D DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 20),
> +		.intr_vsync =3D DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 21),
> +	}, {
> +		.name =3D "intf_6", .id =3D INTF_6,
> +		.base =3D 0x3a000, .len =3D 0x4bc,
> +		.type =3D INTF_DP,
> +		.controller_id =3D MSM_DP_CONTROLLER_0,
> +		.prog_fetch_lines_worst_case =3D 24,
> +		.intr_underrun =3D DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 22),
> +		.intr_vsync =3D DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 23),
> +	}, {
> +		.name =3D "intf_7", .id =3D INTF_7,
> +		.base =3D 0x3b000, .len =3D 0x4bc,
> +		.type =3D INTF_DP,
> +		.controller_id =3D MSM_DP_CONTROLLER_0,
> +		.prog_fetch_lines_worst_case =3D 24,
> +		.intr_underrun =3D DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 0),
> +		.intr_vsync =3D DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 1),
> +	}, {
> +		.name =3D "intf_8", .id =3D INTF_8,
> +		.base =3D 0x3c000, .len =3D 0x4bc,
> +		.type =3D INTF_DP,
> +		.controller_id =3D MSM_DP_CONTROLLER_1,
> +		.prog_fetch_lines_worst_case =3D 24,
> +		.intr_underrun =3D DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 2),
> +		.intr_vsync =3D DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 3),
> +	}, {
> +		.name =3D "intf_9", .id =3D INTF_9,
> +		.base =3D 0x3d000, .len =3D 0x4bc,
> +		.type =3D INTF_DP,
> +		.controller_id =3D MSM_DP_CONTROLLER_1,
> +		.prog_fetch_lines_worst_case =3D 24,
> +		.intr_underrun =3D DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 4),
> +		.intr_vsync =3D DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 5),
> +	}, {
> +		.name =3D "intf_10", .id =3D INTF_10,
> +		.base =3D 0x3e000, .len =3D 0x4bc,
> +		.type =3D INTF_DP,
> +		.controller_id =3D MSM_DP_CONTROLLER_1,
> +		.prog_fetch_lines_worst_case =3D 24,
> +		.intr_underrun =3D DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 6),
> +		.intr_vsync =3D DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 7),
> +	},
> +};

[Severity: High]
As reported by Dmitry Baryshkov on v1 [1], does referencing INTF_9 and INTF=
_10
in nord_intf break the build at this commit?

At this point in the series, enum dpu_intf only defines INTF_0 through INTF=
_8,
and enum dpu_hw_intr_reg and dpu_intr_set_7xxx lack MDP_INTF9_INTR and
MDP_INTF10_INTR, so MDP_INTFn_INTR(intf->id) in dpu_hw_intr_init() also
aliases MDP_INTF1_TEAR_INTR and MDP_INTF2_TEAR_INTR.  These definitions are
added later in the series by commit "drm/msm/dpu: Fix DSI tear interrupts
broken by adding INTF_9 and INTF_10", which should be ordered before this
patch to keep the series bisectable.

[Severity: Medium]
Are the intr_underrun and intr_vsync bit indices for intf_6 through intf_10=
 in
nord_intf shifted onto the wrong interrupt bits?

On DPU 12.x (such as glymur_intf in dpu_12_2_glymur.h), MDP_SSPP_TOP0_INTR
bits 22 and 23 belong to INTF_5, while INTF_6 uses bits 16 and 17, INTF_7 u=
ses
bits 18 and 19, and INTF_8 uses bits 12 and 13.  Because INTF_5 is omitted =
on
Nord, intf_6 appears to have been assigned INTF_5's bits (22 and 23) and
intf_7 through intf_10 were sequentially assigned bits 0 through 7 in
MDP_SSPP_TOP0_INTR2, which will cause vblank and underrun interrupts to nev=
er
fire and dpu_encoder_phys_vid_wait_for_tx_complete() to time out when any of
these interfaces are used.

[1] https://lore.kernel.org/r/bqoezyuyrjiawudbwxybvjpdun5f3fmhhzukdeg2holuc=
2mykq@oa5mhoylopz7

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-nord-drv-d=
t-v3-0-e3d3bf0e2c49@oss.qualcomm.com?part=3D5
