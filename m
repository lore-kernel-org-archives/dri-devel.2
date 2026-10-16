Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C60CC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 15:39:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F9B810E307;
	Fri, 16 Oct 2026 15:39:44 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 778FA10E307
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 15:39:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 79E1E60008;
 Fri, 16 Oct 2026 15:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A8B1F000C4;
 Fri, 16 Oct 2026 15:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792165177;
 bh=DBTfS6GgR2JOYsHytsKaQbGgGzHwHCX9MxhZZB5k5lc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Leed4Rhk7k2sKjAKraXvVR2AHx73ZkQKT52DNG2kxy7LKkl68vAktU1dAi3yItTJI
 nh+mxSI0hiyrHn5YR3NMO3AmDTZRR8WIj6L2ceB6gmopVRSazoYCrwk9+g96tbsG90
 cttM+49YqQFKB4VFyFMTmRrFpTkJ4eD06UiNx9zuh9mj+OimuTM1vf5i5QRdRFC5vF
 9plv/4zCUAdQCfWMLsaCCIvNYU/YIzDMYN35PI0q2Mchkp8vqGlTElXYn6L2ECfpvH
 v9hmaUtaK040LzUFnMIqN1uX86al6pMC38+Ku7inB85rgJnMhCjsBlcSk/adIQp9ot
 OrltrQJ3x2MaA==
Date: Fri, 16 Oct 2026 16:39:28 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Helge Deller <deller@gmx.de>, Kiran Gunda <quic_kgunda@quicinc.com>,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 mfd@lists.linux.dev
Subject: Re: [PATCH 2/9] backlight: qcom-wled: fix string detection
 brightness on WLED5
Message-ID: <atJFMBqrF5uzmMWM@aspen.lan>
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
 <20261015-sm8150-display-card-v1-2-5c14928cef29@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-sm8150-display-card-v1-2-5c14928cef29@oss.qualcomm.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, Oct 15, 2026 at 11:58:39AM +0300, Dmitry Baryshkov wrote:
> The string detection sets the test brightness through
> wled4_set_brightness(). On WLED5 that writes to unrelated registers and
> the detection runs with whatever brightness has been programmed before.
>
> Use the per-version callback and latch the new value on WLED5.
>
> Fixes: 62a1d3f623ac ("backlight: qcom-wled: Add support for WLED5 peripheral that is present on PM8150L PMICs")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
