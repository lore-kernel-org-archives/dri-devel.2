Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71922C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:14:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86DA310F613;
	Thu,  9 Jul 2026 14:14:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="om4PRwHi";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5553D10F610
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 14:14:05 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669DtODF3995896; Thu, 9 Jul 2026 15:13:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=3
 CEQ2DQeqqKos2jw8cWv33P8/KuznAwZ19LOYRdwrdg=; b=om4PRwHiYjYb5fH2o
 NkWPq6MepmKqU2b+dl9SNwYfhhkHZpvPUawB7mClyKgu18v587fn60a1YOCt3TnY
 dO9moiqodzHpA3SmBRCKnIpsOS6WEO6YotPluxPjNFuF8TuGlP3DOuhxGZDCvYkh
 LxFw3Xn1fy5/fkX/aLBTZrbwfuvwU53mWOpjNO2crcZsKxObNJwq2KS6ZzqXT+Kv
 ykcZkwwYYvlXsuaAAaXwvDAjyT+/6ue/+XU9D7Dq9wg6LQWa7+eVnvN6nD6uiKFk
 p7wLD7WHt/rLoHn8OMwzegf6MtAwti8qD/uvZA+mHQ0D1Vi+CDks5TxAHaQY+unj
 lltqw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fa1dw0jmk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 15:13:44 +0100 (BST)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.9) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 9 Jul
 2026 15:13:43 +0100
From: Alessio Belle <alessio.belle@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>
CC: Alessio Belle <Alessio.Belle@imgtec.com>
In-Reply-To: <20260703162338.2848039-1-ben.dooks@codethink.co.uk>
References: <20260703162338.2848039-1-ben.dooks@codethink.co.uk>
Subject: Re: [PATCH v2] drm/imagination: make pvr_fw_trace_init_mask_ops static
Message-ID: <178360642364.200091.9987233516205332240.b4-ty@imgtec.com>
Date: Thu, 9 Jul 2026 15:13:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Originating-IP: [172.25.4.9]
X-Proofpoint-GUID: HYEaQc5QmQveTS49OJRPtgrmAtcESmzh
X-Authority-Analysis: v=2.4 cv=IM8yzAvG c=1 sm=1 tr=0 ts=6a4fac98 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=rvaOABGgyOwA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=lPKyr3o1S3o_Cxp3NwYA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: HYEaQc5QmQveTS49OJRPtgrmAtcESmzh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEzOSBTYWx0ZWRfX+1+Nwe9L0spi
 p+V1Y041h8MbWuPrExBRKR6D847n0ZUFlPMpLoXgsp97jZ7Lg2h2KcIqymFvok+XeMeW34kcHQ9
 8Qs+MMySGXljU8VjYEjdn3ZapPHGVjI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEzOSBTYWx0ZWRfX7gJZSYk2sHnu
 dBBxZ8fOMMTelOa6V+y8oiy11LbFHLehH/mbQN+/Ns3tMCl+2MxLR8p1sRtLF7fv3vMjR29nHv8
 McMDrBvZCJWvr4FxrKWz+UkADicss+rJTBsrSHOJzs1fUGB/VCRu81vvHEmGcTlsgqgn5Hz0jP7
 c86JmPV4H0XH7udHRVvPCWBGj54MKJuKwWRhFrixDiuNSlld1RohBI9A+z4gsvUbo5Z0hDItLSQ
 64msD2vtsEsbvFL6sldrn0KY+XI+bYIP7TZm0rJ/puf8m5C0QW/sq2QrJcBXomeMkr2v+3itV9W
 hrDTqHV1qtH5CWTCNTgQNc5sIzxZsmtvu9KkMgvsXqhYfNHE3nhY6yeyZIGm4M1a91QmlW5BtEM
 f6U2oWj7A+efN58f2HET/XuE3KbMIKO+BwjagqvK7CgKFo9CAPXwCYXXGvjt06NnLoVnDR2VxfW
 iRnMkESiGbyVys8DdWQ==
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


On Fri, 03 Jul 2026 17:23:38 +0100, Ben Dooks wrote:
> The pvr_fw_trace_init_mask_ops is not used outside pvr_fw_trace.c
> so make it static to avoid the following sparse warning:
> 
> drivers/gpu/drm/imagination/pvr_fw_trace.c:74:31: warning: symbol 'pvr_fw_trace_init_mask_ops' was not declared. Should it be static?
> 
> 

Applied, thanks!

[1/1] drm/imagination: make pvr_fw_trace_init_mask_ops static
      commit: c804aadc4ce3dcb34d6f2ecc9a159c148210805a

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

