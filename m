Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6AE109B47A
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 14:33:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D65810E951;
	Tue, 31 Mar 2026 14:33:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="ksWxvPs/";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AA9710E951
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 14:33:09 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260331143307euoutp0195a6c858bc79c538308e02437e441f5f~h853z8WmA0630306303euoutp01R
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 14:33:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260331143307euoutp0195a6c858bc79c538308e02437e441f5f~h853z8WmA0630306303euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1774967587;
 bh=72m2TIJKvAyvCq88CEBugebJ+antOx8xqwjTjQMwlk0=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=ksWxvPs/Dly6b7y+DUwodk+Vybgd+L/DjbVikwd5somba1ZLQC1qYUkv1WTZjWDRq
 DxL+3o4ylLqE4Wsfael/BjoI8x3gHUrENiFF6g2r2kE+NgSyTGg9fALsEWbntVesbH
 Ax/ip9vCeR+4LgRJX9i0YrV+dl7FnvFGnHxHNGj8=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20260331143307eucas1p10710d28fbb1407571cce7f29547133df~h853mCCVw0263502635eucas1p1A;
 Tue, 31 Mar 2026 14:33:07 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260331143306eusmtip19f8a3609e5a023afe620e4c1c98035cb~h852vSnAr0271202712eusmtip1G;
 Tue, 31 Mar 2026 14:33:06 +0000 (GMT)
Message-ID: <52a26d5b-67ec-4a99-98f6-6216e930cdb7@samsung.com>
Date: Tue, 31 Mar 2026 16:33:06 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 0/4] drm/exynos: Random cleanups
To: Chen-Yu Tsai <wenst@chromium.org>, Inki Dae <inki.dae@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park
 <kyungmin.park@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Alim
 Akhtar <alim.akhtar@samsung.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAGXv+5G2H3CSic5hCSd2g6RrfGyNSbpYS7Z9uo-XUn6No3a4Rw@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260331143307eucas1p10710d28fbb1407571cce7f29547133df
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260327054445eucas1p2d1ac645faccf16272c3a12406400a364
X-EPHeader: CA
X-CMS-RootMailID: 20260327054445eucas1p2d1ac645faccf16272c3a12406400a364
References: <20260326094308.1161335-1-wenst@chromium.org>
 <CGME20260327054445eucas1p2d1ac645faccf16272c3a12406400a364@eucas1p2.samsung.com>
 <CAGXv+5G2H3CSic5hCSd2g6RrfGyNSbpYS7Z9uo-XUn6No3a4Rw@mail.gmail.com>
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

On 27.03.2026 06:44, Chen-Yu Tsai wrote:
> On Thu, Mar 26, 2026 at 5:43 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>> Here are some cleanups for the exynos drm driver. This was done as part
>> of the conversion of the driver to GEM DMA helpers. These patches have
>> no dependency, unlike the actual conversion, so I am sending them
>> separately for inclusion now.
>>
>> Please take a look.
> I should add that these patches were only compile tested.

I've tested this on the real hardware and it works fine.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

