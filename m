Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF5E606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=w+r1rJX8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEA74112077;
	Thu, 26 Nov 2026 08:09:00 +0000 (UTC)
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D57910E2BA
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 20:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1795638400; x=1795897600;
 bh=dyItsAdwCo4xMj3bus0BCLCIqJPEYeY2E2MYEhkeGY0=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=w+r1rJX8pk6m7kRJ7LnO+M/5aEticPshtEPxzXCH7DoKPTB/igFWWyttAXpehAcyy
 3gzrXEgb1l4yWHYkMvdSTq+Btv2PsRlwgyq2abwyY52SI0be70pgU0nRwDh7XbQrAf
 qLvmCjc9Zl9Sk/wv6nQL8g2MGj8128zNWS1rMN23pxV4ZOLavVzN2s2FC4UIyTJ/FH
 h/7zadZw4alrwMik9AMRrFueJlSase7iaFq2on5bm/4KJUmHWl9kHd0pGxuVHsNO+j
 jIJJmK9nF9lQE14I9EJgONbrGjdQOKcLT6oMIxKfSaDf34qVSs5ZY4BGbuezpX8+qP
 6RUBOCYxpsV0w==
Date: Wed, 25 Nov 2026 20:26:34 +0000
To: nabige.aala@oss.qualcomm.com
From: Victor Mora <vjmoralesmora@protonmail.com>
Cc: abhinav.kumar@linux.dev, airlied@gmail.com, andersson@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 jesszhan0024@gmail.com, krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, lumag@kernel.org,
 maarten.lankhorst@linux.intel.com, mahadevan.p@oss.qualcomm.com,
 mani@kernel.org, marijn.suijten@somainline.org, mripard@kernel.org,
 neil.armstrong@linaro.org, quic_khsieh@quicinc.com,
 ritesh.kumar@oss.qualcomm.com, robh@kernel.org, robin.clark@oss.qualcomm.com,
 sean@poorly.run, shengchao.guo@oss.qualcomm.com, simona@ffwll.ch,
 tzimmermann@suse.de, vkoul@kernel.org
Subject: Re: [PATCH v3 09/11] phy: qcom: edp: Generalize power-on path for
 per-SoC overrides
Message-ID: <20261125202615.74643-1-vjmoralesmora@protonmail.com>
Feedback-ID: 122405522:user:proton
X-Pm-Message-ID: 29c171b79d6c124dc6a3f80b30588bf4c7651e30
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:59 +0000
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Nabige, Ritesh,

On Mon, Nov 16, 2026 at 06:46:48PM +0530, Nabige Aala wrote:
>  static struct qcom_edp_phy_cfg glymur_phy_cfg =3D {
> @@ -1087,6 +1124,8 @@ static struct qcom_edp_phy_cfg glymur_phy_cfg =3D {
>       .dp_swing_pre_emph_cfg =3D &dp_phy_swing_pre_emph_cfg_v8,
>       .edp_swing_pre_emph_cfg =3D &edp_phy_swing_pre_emph_cfg,
>       .ver_ops =3D &qcom_edp_phy_ops_v8,
> +     .phy_status_reg =3D DP_PHY_STATUS,

On my Glymur-based laptop (Lenovo IdeaPad Slim 5 13Q8Y11, X2P-42-100),
the eDP panel only works when the PHY status is read from 0x114
(QSERDES_V8_DP_PHY_STATUS in phy-qcom-qmp-dp-phy-v8.h) instead of
0x0e0. With 0x0e0 the panel stays black.

Could Glymur use 0x114 here? I'm happy to send a follow-up patch on top
of this series if you'd prefer.

This was tested together with a v8 PLL fix I sent separately:
https://lore.kernel.org/r/20261125-glymur-edp-pll-v1-1-068a4d95a12f@protonm=
ail.com

Thanks,
Mora, Victor

