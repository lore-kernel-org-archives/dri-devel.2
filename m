Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C34103E17D
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 13:51:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC01410E528;
	Wed, 18 Mar 2026 13:51:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iuaCdyCS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9718710E528;
 Wed, 18 Mar 2026 13:51:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D5FE4073C;
 Wed, 18 Mar 2026 13:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB9AC19424;
 Wed, 18 Mar 2026 13:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773841863;
 bh=QBgmPOxk+0qXhIYdcKT5w9xflL+wT4LVz36mjivnjUE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iuaCdyCSEXxn6rl/jCDnLw1LBCXjlFl+dwMARbjCY4r1iwCtfsaa8SWKpCg6+AYRy
 Rm0i/5bHaDR4O/2v6QMwwxuAfvMRMs9uxI1zy5BIlQlLAQCOK1ZUkORPe+XBTrPFeJ
 luWR4MefLhTl8UJRyDTzP/r/s5LgZP7nii/b2fb6pgvyy3f/3dPVw9sJK6dgtpSuKE
 BoqmqAepu5or2u6lqdtBhcCkwgd1/9ORF0Yuf3/cC7GT9e/kutJpkmsv6fzl7QOjXu
 eB3QS9du0OHEThxk1i8PwEAw4C6qNngbZ8MIPAyw61NWDYPGHPAbJYPgjaFufR4k3+
 vZli2PDAZgmjg==
From: Bjorn Andersson <andersson@kernel.org>
To: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ayushi Makhija <quic_amakhija@quicinc.com>
Cc: dmitry.baryshkov@oss.qualcomm.com, sean@poorly.run,
 marijn.suijten@somainline.org, robh@kernel.org, robh+dt@kernel.org,
 krzk+dt@kernel.org, konradybcio@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonathan@marek.ca, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, quic_rajeevny@quicinc.com,
 quic_vproddut@quicinc.com, Rob Clark <robin.clark@oss.qualcomm.com>
Subject: Re: [PATCH v7 0/2] Add DSI display support for QCS8300 target
Date: Wed, 18 Mar 2026 08:50:19 -0500
Message-ID: <177384182912.14526.10589372231190433996.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217090955.2446470-1-quic_amakhija@quicinc.com>
References: <20260217090955.2446470-1-quic_amakhija@quicinc.com>
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


On Tue, 17 Feb 2026 14:39:53 +0530, Ayushi Makhija wrote:
> This series enables the support for DSI to DP bridge port
> (labeled as DSI0) of the Qualcomm's QCS8300 Ride platform.
> 
> QCS8300 SoC has DSI controller v2.5.1 and DSI PHY v4.2.
> The Ride platform is having ANX7625 DSI to DP bridge chip from Analogix.
> 

Applied, thanks!

[1/2] arm64: dts: qcom: qcs8300: add Display Serial Interface device nodes
      commit: a5a3b6977ab7a42681f297a74ac49779a82328c7
[2/2] arm64: dts: qcom: qcs8300-ride: add anx7625 DSI to DP bridge node
      commit: 20eedeaa4fa04d059e5c054ca37bc34b1089c43a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
