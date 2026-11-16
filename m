Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8A1606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VVAnmS5H
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED3AF10F180;
	Mon, 16 Nov 2026 13:29:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D99410F1B4
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:29:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3A523456C8;
 Mon, 16 Nov 2026 13:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989CB1F000C4;
 Mon, 16 Nov 2026 13:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794835783;
 bh=ssAcmNAZ6RN1gnXKQZLC1kAwUmpHr5/zWN4C19jJBZM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VVAnmS5HucW555DGB0cnlLirQxX5V21JVSm76suMJtSGcBCCBtFY8iJQ3ffjH51ut
 2eObnuk99y7Q6LJw3pLygVqKHj0EXSRsjzWW9uyaygIFgDKqpgI3vIpdHRTwdI7AHt
 ilBpDZm99vZ2K4YGGQhxuvjqQyrNMytihC7kDSXzEq1FuzJ5Ul5E+qhSBNWqc8Br66
 ZII9/ThWX5SqmEFLy63bvifnPF12r5fU837+TJXaZqQK/Hr1NwEaOcQiBOvMQN3RY8
 MmnDeVciWx1iVhHwyoXTpCbspwfZSq+PcJA5pYOJBkEuFYkSEg4z3SID7xhVzfjQIC
 eaUzubUIY3Snw==
Message-ID: <sashiko-outbox-217078@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/11] drm/msm/dpu: Fix DSI tear interrupts broken by
 adding INTF_9 and INTF_10
To: "Nabige Aala" <nabige.aala@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261116-nord-drv-dt-v3-6-e3d3bf0e2c49@oss.qualcomm.com>
References: <20261116-nord-drv-dt-v3-0-e3d3bf0e2c49@oss.qualcomm.com>
 <20261116-nord-drv-dt-v3-6-e3d3bf0e2c49@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 13:29:42 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/msm/dpu: INTF_9 and INTF_10 added after use in Nord
  catalog
--

commit c5bdfb09c207793f3155b346b39bc8a0210ff8f2
Author: Nabige Aala <nabige.aala@oss.qualcomm.com>

> drm/msm/dpu: Fix DSI tear interrupts broken by adding INTF_9 and INTF_10
>
> Nord requires INTF_9 and INTF_10. However, enum dpu_hw_intr_reg relies
> on all MDP_INTFn_INTR entries being sequential =E2=80=94 MDP_INTFn_INTR()=
 macro
> computes the interrupt index as MDP_INTF0_INTR + (intf - INTF_0).
> Appending INTF_9 and INTF_10 after the tear entries would break this
> assumption, causing DSI tear interrupts on existing platforms to map to
> wrong interrupt registers.
>
> Fix this by inserting MDP_INTF9_INTR and MDP_INTF10_INTR before
> MDP_INTF1_TEAR_INTR and MDP_INTF2_TEAR_INTR, keeping the sequential
> block intact. Add the corresponding register entries to
> dpu_intr_set_7xxx and dpu_intr_set_13xx.
>
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>

[ ... ]

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/dr=
m/msm/disp/dpu1/dpu_hw_mdss.h
> index 0e65bf5ddc4a6..7eccb4d2c65ef 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> @@ -226,6 +226,8 @@ enum dpu_intf {
>  	INTF_6,
>  	INTF_7,
>  	INTF_8,
> +	INTF_9,
> +	INTF_10,
>  	INTF_MAX
>  };

[Severity: Medium]
Should this patch come before commit "drm/msm/dpu: Add support for DPU 12.1
on Nord"?

That earlier commit uses INTF_9 and INTF_10 in nord_intf[] before they are
defined here, which breaks the build and git bisect at that point in the
series.

Also, the commit subject and message describe this change as fixing a prior
addition of INTF_9 and INTF_10, whereas this patch introduces INTF_9,
INTF_10, MDP_INTF9_INTR, and MDP_INTF10_INTR for the first time.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-nord-drv-d=
t-v3-0-e3d3bf0e2c49@oss.qualcomm.com?part=3D6
