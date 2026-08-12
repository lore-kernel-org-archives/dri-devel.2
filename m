Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4527C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08C5C10F006;
	Wed, 12 Aug 2026 13:53:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DsBBYIi4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 065DC10F004;
 Wed, 12 Aug 2026 13:53:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DAB7F41311;
 Wed, 12 Aug 2026 13:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA591F000E9;
 Wed, 12 Aug 2026 13:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786542798;
 bh=lscjbvhu4sZY3Vq6UVhR28UHnVjIyganW1V7Q5v5k50=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=DsBBYIi4YlKKemyZgZt10pE6owlC543boMsGE/3SZ171NrzLYeKNxXJRB8FfTa9W3
 Euae2i4B4rI4SW4nh+JuR8IoIl6iCcgq3dyYPhEgRCQzyZ/s/8K/fHb9l5Zs1La9iu
 UHiG9tE41njuRc2Fc594N6amZOW5JLNzTmUaVYvedBS0eaDbB7OevQnbmuEzSzaR2o
 AEZqtpF9OVX2gnwhXgtvxUhLDCQBrBfn0nh7Bt/PPWeRCdlM/WLdpI2SpwCdcfx9Fk
 0bdAFh75DnI8A9NcHFwTHys5khL9jW/SSnqQkvZX7zf80Zx70n8mq7kpDvpn6hkXnm
 pKulT/tkgPYhw==
Date: Wed, 12 Aug 2026 15:53:09 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-phy@lists.infradead.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v9 4/5] phy: qcom-uniphy: add more registers from display
 PHYs
Message-ID: <bhvd4pv765rbog6wnj5i3log7dzqggtlibjnqeakj7rqibk4bg@wu2asltvxsuu>
References: <20260513-fd-hdmi-phy-v9-0-ca98c72f1f9f@oss.qualcomm.com>
 <20260513-fd-hdmi-phy-v9-4-ca98c72f1f9f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513-fd-hdmi-phy-v9-4-ca98c72f1f9f@oss.qualcomm.com>
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

On Wed, May 13, 2026 at 09:14:07PM +0300, Dmitry Baryshkov wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Import register definitions from 28nm DSI and HDMI PHYs, adding more UNI
> PHY registers.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
