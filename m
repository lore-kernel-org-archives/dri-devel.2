Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87801606A327
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 09:26:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC90389149;
	Mon, 23 Nov 2026 09:26:49 +0000 (UTC)
X-Greylist: delayed 476 seconds by postgrey-1.36 at gabe;
 Mon, 23 Nov 2026 09:26:48 UTC
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
 by gabe.freedesktop.org (Postfix) with ESMTP id 01E4E10E76A;
 Mon, 23 Nov 2026 09:26:47 +0000 (UTC)
Received: from 8bytes.org (p549216fa.dip0.t-ipconnect.de [84.146.22.250])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id 3E0042436B3;
 Mon, 23 Nov 2026 10:18:50 +0100 (CET)
Date: Mon, 23 Nov 2026 10:18:49 +0100
From: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: iommu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iommu/msm: Use identity domain for GPU and display
Message-ID: <awQE5aSSdXv9rTrv@8bytes.org>
References: <20261029212344.346069-1-robin.clark@oss.qualcomm.com>
 <20261029212344.346069-3-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029212344.346069-3-robin.clark@oss.qualcomm.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 02:23:43PM -0700, Rob Clark wrote:
> Similar to commit 0e764a01015d ("iommu/arm-smmu: Allow client devices to
> select direct mapping") for arm-smmu-qcom, match GPU and display compat
> strings to pick identity domain time.
> 
> The drm/msm driver attaches it's own domain, which it manages directly,
> so we don't want an iommu managed domain interfering.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/iommu/msm_iommu.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Applied, thanks. Patch 1 needs to go through Will.

