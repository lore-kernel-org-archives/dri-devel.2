Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E842CA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:31:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F72F10E034;
	Fri,  9 Oct 2026 07:31:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ivrp3+sI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A375C10E034;
 Fri,  9 Oct 2026 07:31:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A76C460DBA;
 Fri,  9 Oct 2026 07:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC421F000FF;
 Fri,  9 Oct 2026 07:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791531111;
 bh=YHy5Qdd4cgHMlDZ5zJjisbdghCpc7FCrqgKqil513d4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Ivrp3+sIo3zCm6ZN7eQkO8mm1YBw8Xdu3KIGgqbgz3yXG2asUX6B5KSkW3Y8rrzN0
 qJTkEkIPiZ1+GZaxvgck1uCXxVqFpGcpPeyo48NY7s64jzqvJSBtywf4o8ZDmSBjzR
 ex+dm+K5CjCQpRd+cq1Sxjl1b8Q1I7ZmkfI41fPSEq0gsd50rHOmTuamh7KUv4rly9
 kdAZNVPkt9yb8YTQ/tNKLhrwXJxKQoWccqFvLfxY6efGJ7QL3N9QvyP6iEJLvtQki5
 nKT/81odtfSP6L5fZOrNVwk0JbDXXA6PArmaT9F14uXLmO9XtBnPWkiKaeWcNY/cwX
 V1b7grk9a3M1w==
Date: Fri, 9 Oct 2026 09:31:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>, 
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Mahadevan P <mahadevan.p@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: display/msm: dp-controller: Add Kaanapali
Message-ID: <20261009-subtle-tricky-locust-b09108@quoll>
References: <20261005-kaanapali_dp-v1-0-6faeac3a6d59@oss.qualcomm.com>
 <20261005-kaanapali_dp-v1-1-6faeac3a6d59@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261005-kaanapali_dp-v1-1-6faeac3a6d59@oss.qualcomm.com>
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

On Mon, Oct 05, 2026 at 12:54:26PM +0530, Balaji Kalkonda wrote:
> Add DisplayPort controller for Qualcomm Kaanapali SoC which so far looks
> fully compatible with earlier SM8650 variant.
> 
> Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
> ---

Dropping, unanswered comments.

Best regards,
Krzysztof

