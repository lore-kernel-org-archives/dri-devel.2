Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F282C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 07:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4B7410E7B4;
	Mon, 28 Sep 2026 07:13:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fBDPuxqI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38D1210E7B4
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 07:13:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D1AAB40F2D;
 Mon, 28 Sep 2026 07:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827801F00893;
 Mon, 28 Sep 2026 07:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790579626;
 bh=C4hAXQBzMSzIZRn+CjFkwYZ5HJrXyifI8X4XhFJqspU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fBDPuxqIDhAkeMb2toGIydWlGMmn6MznVnweKSpzeWWqDnBDJtSMYJAjb+5hqwgzI
 KcsF4FOw9cLRBtKYXp6lI4MO07+cmXQLY/3z6J+LtoNrnS7aewdX4T3jUbbtcfgkrf
 o2IKasNffYr578zSRNlFn9RL9fwZA8uM6vK6Ab3QUAzAfaQQbBmFfl/KqKliZdSTlt
 xTqC8mksd7uW2BJUmlaq+dvIBmIqU/kIPDiGmO2l+RkUaurpjW0y7Z7TRp2Pv2pUfL
 5VOwk0KLFAnKyN+dRyHB2VoH1GH3pZ4+KbzJ8NDDbKytKAN/nzJ7esIXhmbr5epsXP
 SRqffeH2PSj+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drm/msm: default separate_gpu_kms to auto selection
To: "Mahadevan P" <mahadevan.p@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260928-separate_gpu_kms-v4-1-3f33175de133@oss.qualcomm.com>
References: <20260928-separate_gpu_kms-v4-1-3f33175de133@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 07:13:45 +0000
Message-Id: <20260928071346.827801F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/msm: headless topologies incorrectly default to bound DRM devi=
ce
- [Medium] drm/msm: repeated unknown GPU revision warnings during boot
--

commit 5b897e6c5890fde498e8d0fce3fbe51de1f1b4fc
Author: Mahadevan P <mahadevan.p@oss.qualcomm.com>

drm/msm: default separate_gpu_kms to auto selection

On platforms with multiple display subsystems, such as SA8775P, the GPU
binds to the first display subsystem that probes. This implicit binding
prevents subsequent display subsystems from probing successfully,
breaking multi-display support.

Link: https://lore.kernel.org/r/20260330-separate_gpu_kms-v3-1-a3e54b9c9417=
@oss.qualcomm.com

> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index f3d2eaa04f142..2ac7fcd468d3b 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
[ ... ]
> +static int msm_count_gpus(void)
>  {
> -	return separate_gpu_kms;
> +	struct device_node *np;
> +	int count =3D 0;
> +
> +	for_each_matching_node(np, msm_gpu_match) {
> +		if (msm_gpu_node_present(np))
> +			count++;
[Severity: Medium]
Does this code cause repeated warnings on boot for unsupported hardware?

msm_gpu_node_present() calls adreno_has_gpu(), which prints a warning for
unknown GPU revisions. Because msm_separate_gpu_kms_components() calls
msm_count_gpus() multiple times during component probing (e.g., in
adreno_probe(), msm_drv_probe(), msm_drm_bind()), the side-effecting
adreno_has_gpu() will be evaluated several times per boot.

> +	}
> +
> +	return count;
> +}
> +
> +static bool msm_separate_gpu_kms_auto(void)
> +{
> +	int gpus =3D msm_count_gpus();
> +	int display_subsystems =3D msm_count_mdss() + msm_count_mdp4();
> +
> +	if (gpus <=3D 0 || display_subsystems <=3D 0)
> +		return false;
[Severity: High]
Does this force headless platforms (with 0 display subsystems) to use
component binding?

If display_subsystems <=3D 0, the function returns false. This causes
msm_separate_gpu_kms_components() to return false, directing adreno_probe()
to call component_add() instead of msm_gpu_probe(). Without a display master
to complete the component binding, won't the GPU remain indefinitely unbound
on compute-only platforms when using the default auto configuration?

> +
> +	/* Single card if there is exactly one GPU and one display subsystem */
> +	return gpus > 1 || display_subsystems > 1;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-separate_g=
pu_kms-v4-1-3f33175de133@oss.qualcomm.com?part=3D1
