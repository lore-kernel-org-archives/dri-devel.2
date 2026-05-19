Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27BCCD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 16:04:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2745410EDB2;
	Tue, 19 May 2026 16:04:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gr1/KBlm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E25F410EDB2
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 16:04:13 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id BD45A408BD;
 Tue, 19 May 2026 16:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3C6C2BCC6;
 Tue, 19 May 2026 16:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779206653;
 bh=ESxNT0QNiRL0PPOO61nmNN7xTNyJHHAm0tK5nlkrSdA=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=gr1/KBlm2AihnXMxWmqJrx+ZdXpck1sa0lBCICgT5EKNxxTwR14PR3vTcs18OYJmj
 JhdoiBY5PFRAAyq8LJL2PPc+HKQZTCTB2MC+b+LxMUR6FvIa0nE5E1h3CPl9bMcFZy
 B1DMLTalmzfUY5EaPW2SvwPM3ouE/vQX3CONmhS32Uoh3PW/xHMNONJ+eriunkDea3
 Z3YnBCO8bWaaqFBH69cJ5famwMeveF2BCvBDQJGsGcOBzQVIvWvEmW4Si/gmvUPOwM
 dxoGGjfqWM9SY37JzcZm8rAq/SYEsWUmDs8gR+aL44LMlzr4zOVsvvlJv0eUtpekG/
 FzRrUOglD0zAw==
From: Srinivas Kandagatla <srini@kernel.org>
To: robh@kernel.org, amahesh@qti.qualcomm.com, krzk+dt@kernel.org, 
 conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260325035338.1393287-1-sibi.sankar@oss.qualcomm.com>
References: <20260325035338.1393287-1-sibi.sankar@oss.qualcomm.com>
Subject: Re: (subset) [PATCH V6 0/5] Enable ADSP and CDSP for Glymur SoC
Message-Id: <177920665154.52067.7621121229285353762.b4-ty@kernel.org>
Date: Tue, 19 May 2026 17:04:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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


On Wed, 25 Mar 2026 09:23:33 +0530, Sibi Sankar wrote:
> From: Sibi Sankar <quic_sibis@quicinc.com>
> 
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

[3/5] arm64: dts: qcom: glymur-crd: Enable ADSP and CDSP
      commit: a24bbef55c3d9a515b05cd168b80115673576104

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

