Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39492F4613C
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 15:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DE0310E3CF;
	Mon, 23 Mar 2026 15:48:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="mgU9aFrC";
	dkim-atps=neutral
X-Greylist: delayed 597 seconds by postgrey-1.36 at gabe;
 Mon, 23 Mar 2026 15:48:04 UTC
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05B0810E3CF
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 15:48:04 +0000 (UTC)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20260323153802epoutp01e5a07acb06373d75865a02c7d1d3b88d~fgoQ2dhkn0275802758epoutp011
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 15:38:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20260323153802epoutp01e5a07acb06373d75865a02c7d1d3b88d~fgoQ2dhkn0275802758epoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1774280282;
 bh=MYU9K1BczlLtBMfJPDu28QIk9pzoA+hXl3yf17nC2HI=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=mgU9aFrC+5Kx+21CCBQ48vtUtevP0XGV5aHjupTGFTw7s0wbx2FYZ7piHu2gEGNx9
 7FiJ9iRzTsn7N6OtZVcQFwqx9+/yRy1FbPgDJReQh76dJWCUi3xQdbS9llr9OgF8ia
 3KFTDuksHm5/ZDwJUU6SICm8wW+RY1yai4quNiMM=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
 20260323153802epcas5p1bb1e979594c5257c037cdf6411e7a177~fgoQZrLX82373723737epcas5p1t;
 Mon, 23 Mar 2026 15:38:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4ffckf0KMvz3hhT4; Mon, 23 Mar
 2026 15:38:02 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20260323123542epcas5p349d0e7c45d02ccaa06c84dbdf1777126~feJElRtj12139221392epcas5p34;
 Mon, 23 Mar 2026 12:35:42 +0000 (GMT)
Received: from INBRO002756 (unknown [107.122.3.168]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20260323123538epsmtip2099c850de3b514ee4ac3f5a0092dd02a~feJAkDKG92361023610epsmtip2P;
 Mon, 23 Mar 2026 12:35:38 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Vladimir Oltean'" <vladimir.oltean@nxp.com>, "'Martin K. Petersen'"
 <martin.petersen@oracle.com>
Cc: <linux-phy@lists.infradead.org>, "'Vinod Koul'" <vkoul@kernel.org>,
 "'Neil	Armstrong'" <neil.armstrong@linaro.org>,
 <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-can@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-renesas-soc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>,
 <linux-scsi@vger.kernel.org>, <linux-sunxi@lists.linux.dev>,
 <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
 <netdev@vger.kernel.org>, <spacemit@lists.linux.dev>,
 <UNGLinuxDriver@microchip.com>, "'Bart Van Assche'" <bvanassche@acm.org>,
 "'Peter Griffin'" <peter.griffin@linaro.org>, "'James E.J. Bottomley'"
 <James.Bottomley@HansenPartnership.com>, "'Krzysztof	Kozlowski'"
 <krzk@kernel.org>, "'Chanho Park'" <chanho61.park@samsung.com>
In-Reply-To: <20260323115848.ghdu4sbk75tvggfb@skbuf>
Subject: RE: [PATCH v5 phy-next 09/27] scsi: ufs: exynos: stop poking into
 struct phy guts
Date: Mon, 23 Mar 2026 18:05:36 +0530
Message-ID: <1891546521.01774280282025.JavaMail.epsvc@epcpadp2new>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJoz1sM+EbPjkyDopxrfJVWkMJWdwI9AyWpAaSC6pgB9ZOp/gJXIgBltGJxFXA=
Content-Language: en-us
X-CMS-MailID: 20260323123542epcas5p349d0e7c45d02ccaa06c84dbdf1777126
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260323115859epcas5p10177db12a2e8aee9578271ff1411137b
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
 <20260319223241.1351137-10-vladimir.oltean@nxp.com>
 <yq1a4w3l04g.fsf@ca-mkp.ca.oracle.com>
 <CGME20260323115859epcas5p10177db12a2e8aee9578271ff1411137b@epcas5p1.samsung.com>
 <20260323115848.ghdu4sbk75tvggfb@skbuf>
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

Hi Vladimir

> -----Original Message-----
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Sent: Monday, March 23, 2026 5:29 PM
> To: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: linux-phy@lists.infradead.org; Vinod Koul <vkoul@kernel.org>; Neil
> Armstrong <neil.armstrong@linaro.org>; dri-devel@lists.freedesktop.org;
> freedreno@lists.freedesktop.org; linux-arm-kernel@lists.infradead.org;
> linux-arm-msm@vger.kernel.org; linux-can@vger.kernel.org; linux-
> gpio@vger.kernel.org; linux-ide@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-media@vger.kernel.org; linux-
> pci@vger.kernel.org; linux-renesas-soc@vger.kernel.org; linux-
> riscv@lists.infradead.org; linux-rockchip@lists.infradead.org;
linux-samsung-
> soc@vger.kernel.org; linux-scsi@vger.kernel.org;
linux-sunxi@lists.linux.dev;
> linux-tegra@vger.kernel.org; linux-usb@vger.kernel.org;
> netdev@vger.kernel.org; spacemit@lists.linux.dev;
> UNGLinuxDriver@microchip.com; Bart Van Assche <bvanassche@acm.org>;
> Alim Akhtar <alim.akhtar@samsung.com>; Peter Griffin
> <peter.griffin@linaro.org>; James E.J. Bottomley
> <James.Bottomley@HansenPartnership.com>; Krzysztof Kozlowski
> <krzk@kernel.org>; Chanho Park <chanho61.park@samsung.com>
> Subject: Re: [PATCH v5 phy-next 09/27] scsi: ufs: exynos: stop poking into
> struct phy guts
> 
> On Thu, Mar 19, 2026 at 10:15:17PM -0400, Martin K. Petersen wrote:
> > Vladimir,
> >
> > > The Exynos host controller driver is clearly a PHY consumer (gets
> > > the
> > > ufs->phy using devm_phy_get()), but pokes into the guts of struct
> > > ufs->phy
> > > to get the generic_phy->power_count.
> >
> > Ah, newer version. Would still like an ack from Samsung.
> >
> > And I hit the wrong key, I did not actually apply this...
> 
> I will have to resend v6 because of an armv7 build error I've caused for
ufs-
> qcom.c (which doesn't #include <linux/interrupt.h>, and relies on a
transitive
> inclusion from <linux/phy/phy.h>). It would be nice to get the ack from
> Samsung, but I'll send the next version in the upcoming hours regardless.
Will review and possibly test on one of the board later tonight



