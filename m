Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCF4CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 12:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 614A210F084;
	Thu,  7 May 2026 12:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RbaIPUDj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFF4810F084
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 12:36:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7302F40109;
 Thu,  7 May 2026 12:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA14AC2BCB2;
 Thu,  7 May 2026 12:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778157391;
 bh=t2FvFDrp9DlGESeahtlxW757S/4S7ucRFLPdAT++9jc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RbaIPUDj0OS761XR87i7NHCbgO2GWpMDxEt2U+gcIXAJHMzPi1ShYY+/e9pCySRhV
 IoW7OnLi62lBI39TisMHauWHsi/vuKQLPpiw1WPnoUIxaV9Ydv3IXGbx/sNEsUzMWm
 GrL9n5m3cSGirMLxmrKTaShWhsNbDTXc6BMztrG51ifH8o9avPlQBXBvc+JkKUbXBy
 yB8EjFpx4+fxJVSExuic9OdthmJkeDdMrjOEHgf7KPSPOqJneapAixgrHXub/unS+v
 8ZR+F4kEQtBC7GprQTaQeJ6INUPi48HUhbEoH5PQRkQe3et6AlGIaKDZKtPWW+gA57
 95U+pTy5SHM+Q==
Date: Thu, 7 May 2026 13:36:25 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: cristian.marussi@arm.com, cw00.choi@samsung.com,
 Sudeep Holla <sudeep.holla@kernel.org>, kyungmin.park@samsung.com,
 myungjoo.ham@samsung.com, konradybcio@kernel.org,
 andersson@kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
 dmitry.baryshkov@oss.qualcomm.com, jonathanh@nvidia.com,
 thierry.reding@kernel.org, digetx@gmail.com, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org
Subject: Re: [RFC V6 1/8] firmware: arm_scmi: Add QCOM Generic Vendor
 Protocol documentation
Message-ID: <20260507-misty-neon-trout-7a3ada@sudeepholla>
References: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
 <20260507062237.78051-2-sibi.sankar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507062237.78051-2-sibi.sankar@oss.qualcomm.com>
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

On Thu, May 07, 2026 at 11:52:30AM +0530, Sibi Sankar wrote:
> Add QCOM System Control Management Interface (SCMI) Generic Vendor
> Extensions Protocol documentation.
> 
> Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> ---
> 
> @Sudeep/@Christian, Just moving the series back in RFC mode to get feedback
> on the devfreq part of the series. Will add a lot more documentation in the
> next re-spin, so definitely not ignoring your earlier comments :).
> 

Thanks for letting us know. We must settle the specification first before
moving on to any implementation details. I will therefore skip reviewing this
version, as requested.

-- 
Regards,
Sudeep
