Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D1BC9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55B3F10ECD7;
	Tue, 29 Sep 2026 04:55:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NXPVdDyI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0937A10ECD7
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:55:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 99DE143D3B;
 Tue, 29 Sep 2026 04:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53AF11F000FF;
 Tue, 29 Sep 2026 04:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790657726;
 bh=OrF8cTNeM+ZMqq9vVrWuGsoI1nZYeXFppF/ELmbHExg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NXPVdDyIGRFDxSc/RZaRSIXwkzqdhc1RTgzPLMQHLIt6e/VyvMz7lN19uKv9wd2tn
 kcHz/6/Wq6ZNbT1MO+stuJiNdByLOL2FSu9t0YeVVlbLGyfWqRS5/4vFk8hYXJgvvL
 KdTW/Z6NFMVZhxJ9QjJvBbh3JP+UepVllYrxDAjxEZqTHTQeKiSuIawwxRRoQWA89t
 iMsz+Kzy6mZH3flYv/F/9MSpG/dqW3JV5HEExm5t1EHgfwWLGmuJqilxOrQh5hIore
 SJpcbzqmdcke14+p5nszIWtKjFWPB+HSJZ4cQdunhHBFqdKGjgc5wHKC0nUxCoJB4I
 1fes5mRijnDjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 35/35] soc: qcom: pmic-glink-altmode: skip retimer
 reset on DP IRQ
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929-msm-dp-mst-v7-35-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-35-4b81473185e7@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:55:25 +0000
Message-Id: <20260929045526.53AF11F000FF@smtp.kernel.org>
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
- [High] soc: qcom: pmic-glink-altmode: destructive retimer reset on non-IR=
Q updates
--

commit 040403d2f53703bec3a8c1b6f7b327a08f248957
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

soc: qcom: pmic-glink-altmode: skip retimer reset on DP IRQ

A DP HPD IRQ reports a sink-side event and does not imply a Type-C routing
change. Reprogramming the retimer for every IRQ can reset or disturb its
datapath while link training or video transmission is in progress, causing
intermittent DisplayPort link failures.

> diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmi=
c_glink_altmode.c
> index e903d4910e9c8..5ae554dc01d9a 100644
> --- a/drivers/soc/qcom/pmic_glink_altmode.c
> +++ b/drivers/soc/qcom/pmic_glink_altmode.c
[ ... ]
> @@ -200,10 +207,31 @@ static void pmic_glink_altmode_enable_dp(struct pmi=
c_glink_altmode *altmode,
>  	port->retimer_state.alt =3D &port->dp_alt;
>  	port->retimer_state.data =3D &dp_data;
>  	port->retimer_state.mode =3D TYPEC_MODAL_STATE(mode);
> +	retimer_state_unchanged =3D port->retimer_dp_valid &&
> +		port->retimer_dp_mode =3D=3D mode &&
> +		port->retimer_dp_hpd_state =3D=3D hpd_state &&
> +		port->retimer_dp_orientation =3D=3D port->orientation;
> +
> +	/*
> +	 * An HPD IRQ is a sink-side DP interrupt, not a Type-C routing change.
> +	 * Avoid rewriting an already configured retimer while DP link training=
 or
> +	 * video transmission is in progress. The DRM HPD IRQ notification below
> +	 * is deliberately still delivered.
> +	 */
> +	if (hpd_irq && retimer_state_unchanged)
> +		return;

[Severity: High]
Does this code unnecessarily reprogram the DP retimer when the IRQ status
is cleared or when redundant state notifications arrive?

The retimer datapath is initially programmed with hpd_irq =3D 0. When an HP=
D IRQ
occurs (hpd_irq =3D 1), typec_retimer_set() is correctly skipped.

However, when the IRQ status is subsequently cleared (or a redundant state
notification arrives) with hpd_irq =3D 0, the condition if (hpd_irq &&
retimer_state_unchanged) evaluates to false. This circumvents the cache che=
ck
and forces a call to typec_retimer_set() with the exact same DP state.

As noted in the commit message, reprogramming the retimer disrupts the acti=
ve
link, which seems to defeat the core purpose of this patch.

> =20
>  	ret =3D typec_retimer_set(port->typec_retimer, &port->retimer_state);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-msm-dp-mst=
-v7-0-4b81473185e7@oss.qualcomm.com?part=3D35
