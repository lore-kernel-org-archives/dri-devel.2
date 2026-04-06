Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EBEEF4ECC
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 11:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07EB210E243;
	Mon,  6 Apr 2026 11:43:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uEwkjpkg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8EA810E241;
 Mon,  6 Apr 2026 11:43:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D1A8C600AC;
 Mon,  6 Apr 2026 11:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716F7C4CEF7;
 Mon,  6 Apr 2026 11:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775475779;
 bh=FGRHUXyR+0IYeCGEAzCaangJ4UIXGFGgJFbwE4z892Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uEwkjpkgZJJUgzLAMipZqb7S3m6PFvmEe1MRqsi12pNbrWPbTPr+/ozV0WB4e3kwc
 wUFFUuEvlco8X0oM3WIbq9yPqBJEUoDRTdYVLYUFB2rLHKjh8gNzdqJKD/ZZA+/iG9
 1xttCsrneXaxcIrBL9n1jqQndgGGSU6R9UiOuHMqxrC6g8cjPDhBpYAasm+A5RKcHR
 nV9r4Cclk4K062pas6X6TeGAxUgQ9hdOz1Jzos5uBp1OPKQb3IZujuUKw/GO3+cLck
 va/Idz0NKezYCEsD/GzpcK2QssI9WrYqRPMFymOo9jE/73sGxbCzQuYHAdNKM1hmip
 dP8d3gB/fbK0A==
Date: Mon, 6 Apr 2026 17:12:42 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>,
 vikash.garodia@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch,
 dikshita.agarwal@oss.qualcomm.com, bod@kernel.org,
 mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
 pavan.kondeti@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, harshal.dev@oss.qualcomm.com,
 linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v3 11/15] media: qcom: Switch to generic PAS TZ APIs
Message-ID: <adOcMsk8a_Clb4WZ@sumit-xelite>
References: <20260327131043.627120-1-sumit.garg@kernel.org>
 <20260327131043.627120-12-sumit.garg@kernel.org>
 <ac-KQ7e8-syph1Zl@trex>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac-KQ7e8-syph1Zl@trex>
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

Hi Jorge,

On Fri, Apr 03, 2026 at 11:37:07AM +0200, Jorge Ramirez wrote:
> On 27/03/26 18:40:39, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
> > TZ service allows to support multiple TZ implementation backends like QTEE
> > based SCM PAS service, OP-TEE based PAS service and any further future TZ
> > backend service.
> 
> OP-TEE based PAS service relies on the linux driver to configure the
> iommu (just as it is done on the no_tz case). This generic patch does
> not cover that requirement.

That's exactly the reason why the kodiak EL2 dtso disables venus by
default in patch #1 due to missing IOMMU configuration.

> 
> Because of that, it is probably better if the commit message doesnt
> mention OP-TEE and instead maybe indicate that PAS wll support TEEs that
> implement the same restrictions that QTEE (ie, iommu configuration).

The scope for this patch is to just adopt the generic PAS layer without
affecting the client functionality.

> 
> I can send an RFC for OP-TEE support based on the integration work being
> carried out here [1]

@Vikash may know better details about support for IOMMU configuration
for venus since it's a generic functionality missing when Linux runs in
EL2 whether it's with QTEE or OP-TEE.

However, feel free to propose your work to initiate discussions again.

> 
> [1] https://github.com/OP-TEE/optee_os/pull/7721#discussion_r3016923507

-Sumit
