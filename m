Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866B2CD4851
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 12:40:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E646A10E404;
	Thu, 14 May 2026 12:40:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aX870/BR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 786A210E404
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 12:40:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9482A6012B;
 Thu, 14 May 2026 12:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A76AC2BCB3;
 Thu, 14 May 2026 12:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778762446;
 bh=iWCSZhdPb+8cBMuEmy8gSvTQVeilWYLmuEzyouzd7YI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aX870/BR4AkM531xo6QouLrnsue0uIXWdlOfArk/WJtHsanCKyTM2w9zXR28xVImI
 aR1ocP432CLGhdFFPANZ2zxuptdM6K4VLf6i9Ku61mNVNhnCi1OxvyG6QZsbxTgtz/
 k+TrwGz1rJ2PnAItjV2X6NpSsPFw0BwtEgIddkekqyUdA1cT+b/48EbhV4Dnh5Ff+F
 l4gysj8udrc7yx7I+I4SOFbO1zqwGK5j5nxHfAPzLQi4V6OqqS9IEaTTq1vfxaRbI8
 sZ055fcAAnQbZClSRkkMy80vdQdMAopGR7BxGlvCJ2QbKHk3kq+7ZbEwpra5IycTF9
 BybhmCNHu4eIw==
Date: Thu, 14 May 2026 13:40:40 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>, linux-arm-msm@vger.kernel.org,
 Sudeep Holla <sudeep.holla@kernel.org>, andersson@kernel.org,
 konradybcio@kernel.org, myungjoo.ham@samsung.com,
 kyungmin.park@samsung.com, cw00.choi@samsung.com,
 cristian.marussi@arm.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-pm@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 jonathanh@nvidia.com, thierry.reding@kernel.org, digetx@gmail.com,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org
Subject: Re: [RFC V6 0/8] arm_scmi: vendors: Qualcomm Generic Vendor Extensions
Message-ID: <20260514-towering-heavenly-earwig-b18feb@sudeepholla>
References: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
 <436ce846-bd9e-45bb-bdc2-d2a0fd00dc25@arm.com>
 <5494a379-1e49-4551-a5f0-50d0bd7cd7d0@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5494a379-1e49-4551-a5f0-50d0bd7cd7d0@oss.qualcomm.com>
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

On Thu, May 14, 2026 at 05:11:41PM +0530, Sibi Sankar wrote:
> 
> On 5/13/2026 10:30 PM, Lukasz Luba wrote:
> > 
> > 

[...]

> 
> > Based on this description I have a few questions:
> > 1. Why we don't use SCMI notifications for this purpose?
> 
> 
> This is an attempt to retrofit firmware, that is already out in the wild
> running on X1E laptops and Glymur which continues to use the same firmware, into
> generic linux frameworks, so that it provides some useful information to
> user rather than it being a complete black box.

We cannot accept changes that rely on firmware interfaces that are not well
defined. This is not a comment on any specific interface, but if an interface
is not specified with the same level of rigor as a standard specification, it
should not be expected to receive mainline support.

> We already have a ton of firmware changes suggested by Sudeep/Cristian that
> will be taken into account for the next generation of SoCs, will make sure
> this is accounted for as well :)

It is helpful to know this but also unfortunate as we have only just begun
reviewing the interface and refining its shape. Please do not rely solely on
the review completed so far, as the interface may still evolve. Until it is
merged, it should not be considered accepted. This is why I am insisting that
the interface document be reviewed and accepted before any driver changes are
made.

-- 
Regards,
Sudeep
