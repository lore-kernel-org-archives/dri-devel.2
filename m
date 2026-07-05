Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1D2C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 20:58:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29B2A10E24B;
	Sun,  5 Jul 2026 20:58:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aHxmvhKT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 639DD10E24B;
 Sun,  5 Jul 2026 20:58:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 86DCD600BB;
 Sun,  5 Jul 2026 20:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C9E1F00A3E;
 Sun,  5 Jul 2026 20:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783285097;
 bh=Q1S+qzlIG3wvMl1NLo8aWtt10rEBmCums4Uj0ebABh0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aHxmvhKTNqnoCbPteAQ2rlZNGdox0T3JHxpY+ULbFBi+RT7ZAig7AhUW0slF88Mdh
 GPTosK5jl5S4zk5+5yLAtp6nS+Wqve0EnQtXZFwwRFMrWVrBKmL+Ecm5sy2darrKSD
 aL3StMdelNcEMYnYrjrvNkyEG9Od0d8K8LtmkfgS5/1X99ygHpabT3gi5LYq+87hvC
 t4YghHkC9Ts+64HfD9n7XIt9/Fl7aVkpz47EtwCD/8BCU8emvfaFcRhy2NDVSEmYTP
 SnOJBVsdBE+DKlKaekscnAvTAKEDG792ApXZoRdOfKnCQ6KDhsvBL105QOEySQjAHy
 zUhWqyW3N/OpQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v5 00/28] soc/qcom/ubwc: rework UBWC
 configuration database
Date: Sun,  5 Jul 2026 15:57:55 -0500
Message-ID: <178328508276.1157743.7408067266001474378.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520-ubwc-rework-v5-0-72f2749bc807@oss.qualcomm.com>
References: <20260520-ubwc-rework-v5-0-72f2749bc807@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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


On Wed, 20 May 2026 17:51:07 +0300, Dmitry Baryshkov wrote:
> Currently we store several settings in the configuration database. Some
> of them are incorrect or not completely matching the expected
> configuration settings. Others are directly derivable from the UBWC
> version. Rework how we handle the values in the database, trimming it
> down to the UBWC version, HBB and several flags.
> 
> The series includes patches for drm/msm as well as for the soc/qcom. My
> suggestion would be to either create an immutable tag for the first
> batch of soc/qcom patches, which we can pull into drm/msm or to ack
> merging the first patches through drm/msm tree directly.
> 
> [...]

Applied, thanks!

[22/28] soc: qcom: ubwc: set min_acc length to 64 for all UBWC 1.0 targets
        commit: e21d3b2e5c4387b243424daa0ff2d45c6fbf73e2
[23/28] soc: qcom: ubwc: drop ubwc_dec_version
        commit: e7012ac2fc000fe7ae3e58a7449b80fa955b124a
[24/28] soc: qcom: ubwc: drop ubwc_bank_spread
        commit: 5a9f4c535ae05facd4f6ef116b18062f9f2ad768
[25/28] soc: qcom: ubwc: drop macrotile_mode from the database
        commit: fc54caf87a5a7289502ecbcdc80bb71f7bb5de9c
[26/28] soc: qcom: ubwc: use fixed values for UBWC swizzle for UBWC < 4.0
        commit: 17120525ff070da978effc009877bace3d788698
[27/28] soc: qcom: ubwc: sort out the rest of the UBWC swizzle settings
        commit: 31e1c3248586dcc9aae42539152ab271dcfd37b6
[28/28] soc: qcom: ubwc: deduplicate UBWC configuration data
        commit: d39d5ff3e550393dea28da2fa2afe7fe3cee7f42

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
