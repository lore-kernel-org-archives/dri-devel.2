Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641DFCD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 20:35:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9DC910F26B;
	Thu,  7 May 2026 20:35:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qGlsqKZA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55EAA10F26B;
 Thu,  7 May 2026 20:35:14 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E2AA40304;
 Thu,  7 May 2026 20:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75CBC2BCB8;
 Thu,  7 May 2026 20:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778186114;
 bh=HILlO92SW0znJjse5gzT1MtszGLFwhctmq0VpKqP2ys=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qGlsqKZA1KlBsAHUd49GRZdVlrNae7YNtkTdd3WArm0Q/g989C8iv5y0Sl4yKUZyJ
 B8zBdXhynXDjhTk3wx3GMOxwxqIuvSRDf5INdw1Vx0wsOrbyC/rivhvGHZf5AflsGd
 hUz/OGck7kEVxUye8PwjgCA6PL9XG+6M20zTlOTO9vEIkzgPIZiHm2Y+0UZdoFeZlH
 2IRRfacVK1ik82yN7ZJxpWVHV5kWhhiVObv96nqOVtESkgMvA9Y6ftcHcJiWrCOIML
 h9nY5c1nlI9ecEVYjbb7gFKg8al07/WHxLYSWRRv4OOxZQNEKr6aUz7N69AKd75H2M
 mKKXKfzo/Ts0Q==
From: Bjorn Andersson <andersson@kernel.org>
To: dmitry.baryshkov@oss.qualcomm.com, marijn.suijten@somainline.org,
 swboyd@chromium.org, mripard@kernel.org, konradybcio@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 robin.clark@oss.qualcomm.com, abhinav.kumar@linux.dev, sean@poorly.run,
 airlied@gmail.com, simona@ffwll.ch, alex.vinarskis@gmail.com,
 Abel Vesa <abelvesa@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com,
 quic_riteshk@quicinc.com
Subject: Re: [PATCH v5 0/3] Enable mdss1 Display Port for Qualcomm lemans-ride
 platform
Date: Thu,  7 May 2026 15:34:29 -0500
Message-ID: <177818606044.73000.3306386577026904945.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402095003.3758176-1-quic_mkuntuma@quicinc.com>
References: <20260402095003.3758176-1-quic_mkuntuma@quicinc.com>
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


On Thu, 02 Apr 2026 15:20:00 +0530, Mani Chandana Ballary Kuntumalla wrote:
> This series adds the DPTX0 and DPTX1 nodes, as a part of mdss1
> on Qualcomm lemans SoC. It also enables Display Port on Qualcomm
> lemans-ride and lemans-evk-ifp-mezzanine platforms.
> 

Applied, thanks!

[1/3] arm64: dts: qcom: lemans: add mdss1 display device nodes
      commit: 3e6cd0c43cdf678622c19210bd1a70b04c8a79af
[2/3] arm64: dts: qcom: lemans-ride: Enable mdss1 display Port
      commit: fcc1a19f5bd5623c448e54b2ea6d50249abea77a
[3/3] arm64: dts: qcom: lemans-evk-ifp-mezzanine: Enable mdss1 display Port
      commit: f0b64466e2896020ff2bcaa512bbcc4fea847635

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
