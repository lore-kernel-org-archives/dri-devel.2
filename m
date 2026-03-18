Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F435103E199
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 16:00:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94BE210E0AA;
	Wed, 18 Mar 2026 16:00:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="BQSuC/rs";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5A6710E0AA
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 16:00:07 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62I5gDrH2783940; Wed, 18 Mar 2026 15:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=C
 KtqT9w+PJBtbeeTWC7Zrgj/AtHQG8xGEJZ/Gcw4JO0=; b=BQSuC/rsMNDcKrnwk
 wWIWFu8M+UPf+wtVJa7TWEVZKK9wvPpx++HpGtlGVujN23AsblbqPH5OCrQ+H4nZ
 6LgY54V61fXsXanPhFk+VCLzM5kQmM7wdqOFAit08g80QchWEoZaloBVA+mY5XHy
 MS/6iPI3m5YQBfsuHphh/UfDA2x0X4BNa4GxEwZi78LH2cEluVQZl9tvfbAZL6Sl
 xaGaeJXGJ2rZgx1T3rcnOpDy/ZaNg9sQX4kFBqFbr5LWopjoaXMEOPeN7/Uwaxx9
 rHpoI6ipmIf4W1gerWKQxK7poHrMp8bZeN0aw0i9WVe+1y4ureFbi0aygUYOpWTu
 8ljww==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4cw0mwbr23-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Mar 2026 15:59:49 +0000 (GMT)
Received: from HHMAIL03.hh.imgtec.org (10.44.0.121) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 18 Mar
 2026 15:59:48 +0000
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.4.249) by HHMAIL03.hh.imgtec.org (10.44.0.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 15:59:48 +0000
From: Matt Coster <matt.coster@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Alexandru Dadu <alexandru.dadu@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Alessio Belle
 <alessio.belle@imgtec.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
In-Reply-To: <20260310-drain-irqs-before-suspend-v1-0-bf4f9ed68e75@imgtec.com>
References: <20260310-drain-irqs-before-suspend-v1-0-bf4f9ed68e75@imgtec.com>
Subject: Re: [PATCH 0/2] drm/imagination: Drain interrupts before
 suspending the GPU
Message-ID: <177384958802.4032.4980677899914669609.b4-ty@imgtec.com>
Date: Wed, 18 Mar 2026 15:59:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Originating-IP: [172.25.4.249]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDEzNiBTYWx0ZWRfX5QrfeDV6bSMt
 z1AKA5c9VWoI0SGt1tdaGdNDFKjxn87MA2PUlk17dcF+KqANBKv1omQT5m4o1Mpl/Sea8UhpB4W
 fdZWhMoaSAaEqX/gep6xjTIR1PeQCthH3cRKYBqnKNhU+nhH4r+MMo93ofK91FZ0rVUYznQma9n
 BBctqsa53+oHifDneU9SL3aWfqxsODl815ESS58dz4fQ2BG2dJRyXuvrTxT5vdQ8OyuGBb0lniz
 UTj29CHsn3t41eij4xWXlvyNyPkc68/xbX2DxJqF6ISTuxf6mJltng9SmTblB6mp6w3EmyBzwWF
 be1Vyf0L5KhJFHkrxdtKnN+6gYHsiyG/j4Pv1/yKFaq1VEjNstx4/tW4ICLA2UR6oRNloG03mlI
 R4j17Fub7wOPrJIJS30OTIpJaoKyyZlOrCpde4RDi33HvzkPtj9z99ok8iYd45MxFhmSmy1LqYt
 w08tM4dsT4BFJleSRNg==
X-Authority-Analysis: v=2.4 cv=JaexbEKV c=1 sm=1 tr=0 ts=69bacbf5 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=Ylr_HOfL8O8A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=O4Ma4roi3Vyg64WxJcwA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: QRQ20va9rEFQjwipdhPxsSIjFd5Fbfwu
X-Proofpoint-ORIG-GUID: QRQ20va9rEFQjwipdhPxsSIjFd5Fbfwu
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


On Tue, 10 Mar 2026 11:41:10 +0000, Alessio Belle wrote:
> The first commit is the actual fix and will need backporting to stable
> branches, though some of the code being removed didn't exist prior to
> 6.16 so the patch will need adaptations.
> 
> The second commit tries to prevent similar issues and doesn't need
> backporting.
> 
> [...]

Applied, thanks!

[1/2] drm/imagination: Synchronize interrupts before suspending the GPU
      commit: 2d7f05cddf4c268cc36256a2476946041dbdd36d
[2/2] drm/imagination: Disable interrupts before suspending the GPU
      commit: 74ef7844dd8c27d6b94ebc102bb4677edd3e7696

Best regards,
-- 
Matt Coster <matt.coster@imgtec.com>

