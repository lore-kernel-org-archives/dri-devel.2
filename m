Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A5FF589D4
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33B9510E33D;
	Thu, 23 Apr 2026 13:40:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d51b2ao5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6211A10E33D
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:40:30 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8431660132;
 Thu, 23 Apr 2026 13:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DEBC2BCAF;
 Thu, 23 Apr 2026 13:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1776951629;
 bh=3KP4UVdXkAjUCLuoO/Zngx5JujLIt1ZAmsr3rv4yp5M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d51b2ao5sf7XgHmfz7iMq57cj2OZF6xGfimWjCfRuSY0cxJxIeeynX8T6+uuCsAwQ
 QelMwuEkg4FlvKEstXscM6rkCKvWKSJS/rsmkYU1wU7PB/pRdg3xHq5U1ViGvA+c5o
 2ESF5wtWpLmggMSwRMhFBfaffFSNbnd27dGEbD6o=
Date: Thu, 23 Apr 2026 15:40:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Subject: Re: [PATCH v2 03/13] gpu: host1x: Migrate to generic dma context bus
Message-ID: <2026042330-recopy-corner-07d9@gregkh>
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
 <20260423-glymur-v2-3-0296bccb9f4e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423-glymur-v2-3-0296bccb9f4e@oss.qualcomm.com>
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

On Thu, Apr 23, 2026 at 06:59:32PM +0530, Vishnu Reddy wrote:
> --- a/include/linux/host1x.h
> +++ b/include/linux/host1x.h
> @@ -462,7 +462,7 @@ struct host1x_memory_context {
>  	struct pid *owner;
>  
>  	struct device_dma_parameters dma_parms;
> -	struct device dev;
> +	struct device *dev;

Ah, nice try, but no.  You can't use a "generic" device for this type of
thing (i.e. your dma context bus device), as that's not what this device
really is.  Add the needed logic to the bus this real device lives on,
don't try to work around it.

thanks,

greg k-h
