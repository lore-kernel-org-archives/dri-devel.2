Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F61BCD3427
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 03:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBC5D10E456;
	Mon, 11 May 2026 03:21:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="bPdMvDO1";
	dkim-atps=neutral
X-Greylist: delayed 507 seconds by postgrey-1.36 at gabe;
 Mon, 11 May 2026 03:21:47 UTC
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com
 [95.215.58.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FF0910E45D
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 03:21:47 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1778469188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WJwzTm0YuwLSMaDyoiRRuNCPG1gC1nH+cV5+Agd31+M=;
 b=bPdMvDO16rGgWRyRR7cJMPbbIe6IEhY1XvNMcAvEwUBMmyrqloWqG1Yl99vSS0uUgQKLpM
 tIVHkqFwefoWez8FtOF2a+kxuP2/7OZlOsNddG6nHYyqNlurcYpZLOueSTAxCZwIjiaq/c
 BYmQwwQzQYwICDyv0YTiS9rXGhWcsWM=
From: Junjie Cao <junjie.cao@linux.dev>
To: akoskovich@pm.me
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robin.clark@oss.qualcomm.com,
 lumag@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, konrad.dybcio@oss.qualcomm.com,
 jonathan@marek.ca, neil.armstrong@linaro.org, thierry.reding@gmail.com,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] drm/msm/dsi: support multiple DSC slices per packet
Date: Mon, 11 May 2026 11:12:55 +0800
Message-ID: <20260511031255.8630-1-junjie.cao@linux.dev>
In-Reply-To: <20260318-dsi-dsc-slice-per-pkt-v2-0-0a1b316f8250@pm.me>
References: <20260318-dsi-dsc-slice-per-pkt-v2-0-0a1b316f8250@pm.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

On Wed, Mar 18, 2026 at 09:53:59AM +0000, Alexander Koskovich wrote:
> This series adds support for sending multiple DSC slices in a single
> DSI packet, which is required by some panels such as the JDI LPM026M648C.

Tested on OnePlus Pad 2 (SM8650) with a Novatek NT36532 based CSOT
PPC100HB1-1 panel (dual-DSI, DSC v1.2, slice_count=2). With
MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT set by the panel driver, the panel
comes up and renders without artifacts.

I'll be posting an NT36532 panel driver on top of this series.

Tested-by: Junjie Cao <junjie.cao@linux.dev>
