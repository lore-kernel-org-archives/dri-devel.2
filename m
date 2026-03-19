Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EF7FB5EAA
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 03:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D261410E008;
	Thu, 19 Mar 2026 03:33:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RBJ+8j4N";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B529010E008
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 03:33:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6887D433D7;
 Thu, 19 Mar 2026 03:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB93C19425;
 Thu, 19 Mar 2026 03:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773891192;
 bh=uHQRSWsh9XSBxn6ij5HMYn6/ZU1VX+9DmSeJcS2Qq0M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RBJ+8j4Nxg5Qvt1EP0q1LrCS1oZ6WEfe2jWNkYcTS2YFoQMpMjgZ7VaIzmSip6TOD
 SzrUhVnv1mDx3v0xR9tJNXwz6LANvrmknq5DS6xLSUzWPo7EV1oTwtRVndqT6NXWle
 5KvliRUccRxUIfdV8cZIArQXnrPdbfVDGJJqHeUIJlTXgnaflt2s4T5FyFF2jrHOQD
 e0526ChOwCtTykS90RHAUSpleTHBME0MAAaviqRjbzzuHIfyxdwZ7jNVgrJac3beq/
 zDG9+FGvegIgK8Qu8bvcRAy/WHxOqUmS8o+cJr5R+zWvvaEu4QUP/ux2F9ILMjrh67
 mCh7gwnQG7+cg==
From: Bjorn Andersson <andersson@kernel.org>
To: robh@kernel.org, srini@kernel.org, amahesh@qti.qualcomm.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: mathieu.poirier@linaro.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 mani@kernel.org
Subject: Re: (subset) [PATCH V5 0/5] Enable ADSP and CDSP for Glymur SoC
Date: Wed, 18 Mar 2026 22:33:06 -0500
Message-ID: <177389118147.17526.2779528206757878821.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313120814.1312410-1-sibi.sankar@oss.qualcomm.com>
References: <20260313120814.1312410-1-sibi.sankar@oss.qualcomm.com>
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


On Fri, 13 Mar 2026 17:38:09 +0530, Sibi Sankar wrote:
> Qualcomm Glymur SoC variants predominantly boot Linux at EL2. This means
> that the firmware streams of the remote processors are managed in kernel
> and not in Gunyah hypervisor. Given that the Peripheral Image Loader for
> Qualcomm SoCs now support running Linux Host at EL2 [1], this series
> documents and enables ADSP and CDSP on Qualcomm Glymur SoCs with its
> fastrpc nodes. A few variants of the SoC are expected to run Linux at EL1
> hence the iommus properties are left optional.
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: remoteproc: qcom,sm8550-pas: Add Glymur ADSP
      commit: 217fb074eb108075c26ddf96f3456c47e279fc15
[2/5] dt-bindings: remoteproc: qcom,sm8550-pas: Add Glymur CDSP
      commit: 46fcbcaa72885e814fa0e4cc306f13af41d086e2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
