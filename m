Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBCDCD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 19:28:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A68F110E1EC;
	Thu, 21 May 2026 19:28:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C7XUtvhp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0538510E1EC;
 Thu, 21 May 2026 19:28:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DCD8040D8A;
 Thu, 21 May 2026 19:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184BC1F000E9;
 Thu, 21 May 2026 19:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779391717;
 bh=WGkA5lXoVjlzSIZoeQLMLfIwbdSnbcmaBdnP/E1bVlA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=C7XUtvhpGoeeWmo+Zuzl0EaBzOUy6zQ2TeyiqDiBznoZNiqEADgShlFQ19vN6f//4
 Jwr91LxgBIAKC13YBF2yo+HE2sIBoF2WJ4+AEYUGDQM0nlMCM+cyNe69xqLzsU2pKE
 hjWgpCkYOWohouHCJf3Ur6w9Y+oijYytnX3887XGcZbIAYBQOy5xi6K+wkrndpU6l3
 Ziz5KFZ4iNBf6tjdQOkTkeK7cZb/P7obJQD6aIuRWngSMNHqeHfKtNFqMgRHGfShon
 SnCEP8nGkuz7ctLIWRBg9DsKvAydFvG2E0Ptjc+coF6vMOQ4H7sYNEryXh7+jglIUX
 ZkcCpFSJ6Q+5A==
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
Subject: Re: (subset) [PATCH v4 00/29] soc/qcom/ubwc: rework UBWC
 configuration database
Date: Thu, 21 May 2026 14:28:26 -0500
Message-ID: <177939170564.182385.14385611507235354897.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
References: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
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


On Thu, 07 May 2026 16:02:56 +0300, Dmitry Baryshkov wrote:
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

[02/29] soc: qcom: ubwc: define UBWC 3.1
        commit: ab7e4d7cf6f8efd37a675a85eb0aef3d6a4954ba
[03/29] soc: qcom: ubwc: define helper for MDSS and Adreno drivers
        commit: b5f7365c44d8fd58ef0224bf4111805c4fea0a1e
[04/29] soc: qcom: ubwc: add helper controlling AMSBC enablement
        commit: c5e3f2a3abcb925f0364df09abfd759ff0590454

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
