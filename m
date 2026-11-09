Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4E1606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WpnMokxA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AA7110F21E;
	Mon,  9 Nov 2026 12:26:26 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E72110E279;
 Mon,  9 Nov 2026 12:26:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8755043A80;
 Mon,  9 Nov 2026 12:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A629F1F008A1;
 Mon,  9 Nov 2026 12:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794227179;
 bh=+5RXFrprDX6bYA9uikypLOOJeAzhlU0oKTvBTPFxlAo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WpnMokxAAWsX3nLHIFakp0L01J/+UsB6nujtp9RSRqsNc2vncK8X6H51UOZTbTsHn
 ce9sNPVjF3aUUdDRbt79I5i8sCuTLiQvDC0jTPg3APMNOpJQytl6Sx7SYLEJxiAbkA
 a88Tet/lE6v7s99DL6mHGFRBSLmzI/+T+gc/3UM6adQIlMIbSXki3ZS8i7OpUltmSK
 pzdbPQU1613DTIrI2G4p11t4iVCsZDbPgk8pbcth6Jn/WVMMnf9s4m4Ukb2n2dOT9v
 wLE9hvsa5GoR6Y/EzrgLxS5cFINdzJXl7b/h6tlJ1wOzDkgjmxCdbzAHOEs35EA2++
 uJeIDeB5JCGDA==
Date: Mon, 9 Nov 2026 13:26:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Abel Vesa <abelvesa@kernel.org>, Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>, 
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Joonhoe Kim <26rote@gmail.com>
Subject: Re: [PATCH v5 2/3] drm/msm/dpu: Attach CORE and INT2 power domains
 on Kaanapali
Message-ID: <20261109-industrious-impetuous-slug-a8e4ce@quoll>
References: <20261109-msm_gdsc2-v5-0-4a3159b5e4b8@oss.qualcomm.com>
 <20261109-msm_gdsc2-v5-2-4a3159b5e4b8@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261109-msm_gdsc2-v5-2-4a3159b5e4b8@oss.qualcomm.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 04:36:36PM +0800, Yongxing Mou wrote:
> Kaanapali's DPU is supplied by both CORE and INT2 GDSCs. The
> power-domain core only auto-attaches a single domain; with multiple
> domains the device is left unattached, so both domains must be attached
> explicitly.
> 
> The DPU OPP table also needs to continue controlling the MMCX
> performance state. Mark CORE as the required OPP domain so its vote is
> propagated through the genpd hierarchy to MMCX. INT2 has no OPP of its
> own and is attached as a regular runtime-PM supplier.
> 
> Platforms with a single power domain remain unaffected and continue to
> use the existing automatic attachment.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Tested-by: Joonhoe Kim <26rote@gmail.com>

Where? No tests were at v3 and v4.

Best regards,
Krzysztof

