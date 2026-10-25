Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6868760A2616
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 19:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WsPTDYDB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F98D10E00D;
	Sun, 25 Oct 2026 19:23:34 +0000 (UTC)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5A1C10E00D
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 19:23:27 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-3535a54bed9so3752035eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 12:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792956207; cv=none;
 d=google.com; s=arc-20260327;
 b=cUVdJQne7HWQ5phaN0jbBjQNG4Dlu+OIFB+PHLnrTMiUoQ95O3figWtgittGDraD+w
 lGFYVO/dNma60yYEddltBb/uqro+tktY5JM6LqvYhVT8/lwDABJbVBqWHPqK6MahyzPM
 sQS6AfdCfwxluY95FKd0waBBCjNaDWssTf9VcS2/0GMZcbmPt/QeMXLiIboEanM87tid
 Bdian23VbWzcl5MYfYtTJhhUE5+RsO2SGzaSIbwFQfrthGLPn0zNkT8+AoLmQ0G6KiNy
 MNuIvSMInxmm8Dm6EPRfagxOd5kgdUUU7IlDQj2J2y9AjIoqQpRqclK/f4sHgPDAGRgw
 NxvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dEEx0Z8e0R8jOgmV0CzML93QklpW+Wd99NpO3WBEWOI=;
 fh=nTsYxMyt1+6HFcjOnBlI6MjsUqpSuDRRVPpd0AdmAvo=;
 b=feCsMrTqh2PvfmcO3gn2MxhUwQUihWaKqtufRBcQNB93FGsV3vSPnLtKKfBi47MDou
 GNPR+KwEsx76moRXS62wQLep2dn0V7v/vdkB5HxpIgvAFmf6E3rxFx14bMR7vfEXopcY
 MRTxpEZyX7sttrC4Qmvz16hfL1w9Z1DuJrkMb6u8cnUCBkcrkoZBjWFnSgYtkhCLXMxC
 dHk2GnGYF+k020RGiOPIdcZVqNd+3NrogVx5/1c4A50iSRO8vQdiMR6w5NhVIt1w/iMw
 3/01KLvr2LWdmQuOHbSnbUwKvoZsAEpcxrwYd0dhsn+CrTQC1YjPfXd+frVz1vy1zxHM
 lZYw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792956207; x=1793561007; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dEEx0Z8e0R8jOgmV0CzML93QklpW+Wd99NpO3WBEWOI=;
 b=WsPTDYDB4a3iu6EMaagmCuln8qNMH3nzgkVV2CATb7lvynHR5E8rD+mBR23ysl9vaE
 rsG2BJHAwnQVyBPTUrUptTOIrk5TEgyHUsZ19jr9z9aLtex5tdTfrfM0tVBkA9/HxPJq
 xM2khS+YHkUHHLDqPEzlI8tWwJY1t35Bwk9kEU0GICQ1bh0MjfvkW5Y3VV7t6Z6ouXus
 eQij2tHTAN7yKpw4o71YpfPZ8wW0TX0VEtmLUeyEnJQ37dHDRDX1DCNo+WBZjnsBu97Q
 NH+ciBAJKwwFik9jdkEh8seLL+brrR94jj3t+bbEQRCrCa9P8qGThi0hFyxn407FE5G/
 pnnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792956207; x=1793561007;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dEEx0Z8e0R8jOgmV0CzML93QklpW+Wd99NpO3WBEWOI=;
 b=X7fAKlpsiKcMnxguqo0HtpbZpoCifj/MzvyNkzD+bF6a4l45XvH2EQlOrKeHM/0NXs
 fYghdW0xwgnEqBaiGdlYRLK0wTf3r67RtOzxrXnWES0lcnSJ2tmXgIZJPRQW1O9HRL0k
 BPfGj978xYX63SbBbgaez+7sx9Rcl3QowVHnIh8wy5rN+Jaohj/7pkSKFXdUx4DS0b7R
 9LBqzh9pD3jhJQT0emkS9ujkr75Dba7MuuUG8GuiMu3JZ9UsToiUS3hqv/AD4lsO4u2A
 2DjIY+IeM6Rk8uxGI+12RFZ5/1T0X0PH4l9OLhbPswT0KjwvzR1fze4yYEmuhMNYryqJ
 k4/A==
X-Forwarded-Encrypted: i=1;
 AKwUvByCqfhW0eVBtj1f+mWTVakHrzSOlI6SAu7F+bXcVBD4BwknvWu2tlynwzirCrGfKWHFBreL18Sd0vc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJYICU32gJfAV85pah83l4Pv3AgWuOXWQoUSHWEAVUfkIWZHWDy
 aaJN2JxxUApR4dyk/0wmMHrnSUf7nBCEjdiVNGboMUB2S0dZAMjEXMRiP+quFuKl3+NfGvdfyk4
 HVPhHorbSeTNK2MGKSaY3oKXOfdTo2wE=
X-Gm-Gg: AYBFou3OXgFdcRxkMWnppHct7nTKmexbt8iylMfs7sguTzpfw4UzGFMYkm1QR6L8oit
 +d4sf/JHiFOrLaSrFMrfLKt3wyIuX41I+JtLhlVrNSa63i9Bdk28nI+j05cwJ/CU+FHb29gHYwL
 iGztqKhOwXpB5SB6kJ+R74Gfd/l6Ym6TLFjYztPncDf4Jl0xzn0m4LtqyWRI5DmHZ0ZEVyFa09Z
 xwiOuDmF4xAF8kwOz/Zm1a+pElie+14XhSItAYAl9s0fiWoEfQCkkbCs41cBI5KpM06Ecw7HPNA
 EFR8HsmxFFxQAnBSIGMjVJMU12R7WXWLrAU34RKBnf4K906KR5WECdTOB8xdaSDF6cD5O4xj3nt
 D3MYibHcKIEKd2GwJoM3Zpcu3bNRZeLvO2aoNNvKc24H6DzdQe/6328OHV+eJsbuyRlrRPw==
X-Received: by 2002:a05:693c:20c7:20b0:366:83dd:4713 with SMTP id
 5a478bee46e88-369e84a7306mr6781233eec.30.1792956207049; Sun, 25 Oct 2026
 12:23:27 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261025-upstream-host1x-mipi-clk-v1-1-6bc6e755b4cb@tsv-stahl-riesa.de>
In-Reply-To: <20261025-upstream-host1x-mipi-clk-v1-1-6bc6e755b4cb@tsv-stahl-riesa.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 25 Oct 2026 21:23:15 +0200
X-Gm-Features: AclHuK-K26bDtKlF8TK70dmoPQF0DUHOztv0f_rqJCZ78HeF95UHjNUfbNmTXk4
Message-ID: <CAPVz0n2+Gbjm21Px-wexG6atRt=Pzi0VJ+fyK_EhKxV88Bj2Ew@mail.gmail.com>
Subject: Re: [PATCH] gpu: host1x: mipi: Disable clock again after powering
 down the pads
To: admin@tsv-stahl-riesa.de
Cc: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Thierry Reding <treding@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BD=D0=B4, 25 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 19:1=
3 Patrick Fischer via B4 Relay
<devnull+admin.tsv-stahl-riesa.de@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
>
> tegra114_mipi_power_down() enables the MIPI calibration clock to access
> the bias pad registers but never disables it. Every disable/enable cycle
> of a DSI or CSI user therefore leaks one enable count, and the clock
> stays on for good after the first power down.
>
> Add the missing clk_disable(), matching tegra114_mipi_power_up().
>
> The leak gets more costly with "clk: tegra: Fix Tegra114 MIPI
> calibration clock parent", which makes PLL_P_OUT3 the parent of
> mipi-cal: without this fix PLL_P_OUT3 would then stay on as well.
>
> On a Tegra Note 7 (P1640) the enable count of mipi-cal in clk_summary
> grew by one with each DPMS off/on cycle of the DSI panel. With this
> patch it returns to 0 after each cycle.
>
> Fixes: 15372d4be7f0 ("gpu: host1x: mipi: Power down regulators when unuse=
d")
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
> ---
> Mikko's "clk: tegra: Fix Tegra114 MIPI calibration clock parent" [1]
> fixes the MIPI calibration timeouts on Tegra114. While testing the same
> change on a Tegra Note 7 (P1640) I noticed that
> tegra114_mipi_power_down() leaks the clock enable it takes. With [1]
> applied that leak keeps PLL_P_OUT3 on after the first DPMS off, so the
> two belong together, although this patch applies and makes sense on
> its own.
>
> [1] https://lore.kernel.org/all/20260930-b4-dalmore-fixes-mipical-clk-v1-=
1-0518be6c7979@nvidia.com/
>
> Tool use (see Documentation/process/generated-content.rst): this patch,
> its changelog and this note were prepared with an LLM coding assistant
> (Claude Code). It traced the clock enable counts from my clk_summary
> dumps and wrote the code change and the texts from my measurements and
> instructions. I reviewed the change and ran the test on the device.
> ---
>  drivers/gpu/host1x/tegra114-mipi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/host1x/tegra114-mipi.c b/drivers/gpu/host1x/tegr=
a114-mipi.c
> index c084a09784d1..83a43a5e33af 100644
> --- a/drivers/gpu/host1x/tegra114-mipi.c
> +++ b/drivers/gpu/host1x/tegra114-mipi.c
> @@ -197,6 +197,8 @@ static int tegra114_mipi_power_down(struct tegra_mipi=
 *mipi)
>         value |=3D MIPI_CAL_BIAS_PAD_PDVCLAMP;
>         tegra_mipi_writel(mipi, value, MIPI_CAL_BIAS_PAD_CFG0);
>
> +       clk_disable(mipi->clk);
> +
>         return 0;
>  }
>
>
> ---
> base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
> change-id: 20261025-upstream-host1x-mipi-clk-867edad177b0
>
> Best regards,
> --
> Patrick Fischer <admin@tsv-stahl-riesa.de>
>

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Tegratab (P1988)
and ASUS TF701T
Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
