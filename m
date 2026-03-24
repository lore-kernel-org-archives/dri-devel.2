Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D96EF532EF
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 08:26:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E241D10E0F7;
	Tue, 24 Mar 2026 08:26:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="WK7FF2vC";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C2A410E0F7
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 08:26:33 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O5KdIe1246547; Tue, 24 Mar 2026 08:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=Z
 eCx4yiHfZEQZF3tML9kt006n7n/sZHXpeN5wfxDeK4=; b=WK7FF2vCekKLB6ooG
 ullo/bRQo7+2fpshXXJVF1O6qxcy3q2J2dD/6gHRob6XolrDsk4GAdujeo26C7uz
 XvHHx9fFlZKBn8x1IVAp1N7jo5tHZ6RHKs/ftP6YOAOupKJyXuXHZivoOVL4+ZuE
 8bFx2+u8QuVAiv6Y80B9On0oZv02IgLIfoPHg8z5oJWnKuc8FGua0atrPOSlpR4+
 y1UQEDdMtPiznd1cBs0Ekj+3Lkm730GyfRAkJp+Ze2X8UcSr2n+T83+UzavOqV6g
 7/XpEwPt2R8fIDbQqOssDHpHeEfnJ/WAQfiJoU5wcKAtzp4B0/O3k9I58q/R9G2I
 ZZUTw==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4d1m9v2fwt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 08:26:21 +0000 (GMT)
Received: from HHMAIL03.hh.imgtec.org (10.44.0.121) by HHMAIL02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 24 Mar
 2026 08:26:20 +0000
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.2.112) by HHMAIL03.hh.imgtec.org (10.44.0.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 08:26:19 +0000
From: Matt Coster <matt.coster@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Alessio
 Belle <alessio.belle@imgtec.com>, Brajesh Gupta <brajesh.gupta@imgtec.com>,
 Sarah Walker <sarah.walker@imgtec.com>
In-Reply-To: <20260323-b4-firmware-context-reset-notification-handling-v3-0-1a66049a9a65@imgtec.com>
References: <20260323-b4-firmware-context-reset-notification-handling-v3-0-1a66049a9a65@imgtec.com>
Subject: Re: [PATCH v3 0/3] drm/imagination: Firmware handling of context
 reset notification
Message-ID: <177434077946.51891.15629076276414317145.b4-ty@b4>
Date: Tue, 24 Mar 2026 08:26:19 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Originating-IP: [172.25.2.112]
X-Authority-Analysis: v=2.4 cv=OeWVzxTY c=1 sm=1 tr=0 ts=69c24aad cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=dzNZb8ZTwNYA:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=QhRLQRg2HGD5HPNRYNsA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA2NyBTYWx0ZWRfX3mmZr2iinUxH
 I6noqEKO40MnW7KiGmun+ePrNFh7LQ5rvgsiwSzPekmt1Ebi1ZfUFM+PGiTfk+B2UOBiGY8JfIM
 +frDOl1ItXydOZIdfiWy4mCG4V4yi7lcHZsP9uRDuYO0OwHGqbempBphyB0Kt+NW3JVQNPE8APS
 DjsMJ2FLNO3olhnUNzC9vnV7dRPeKHJedthuXwdtnpHSCWLz8wptyZsfWECQgXH8vWUpIkYsvnG
 UTiv2undHkfM6kmRWlRqIi76jBeh9wmtj6zA/AMsYEO/U0TaoNXq1l2rpRP2MnUX+tx+ZI9meA5
 WmGMQw8RU1NjWalOdyUOOVc1vf8JTrSfEso29JyflFSnymTOaZRIZXe+qGB5+VS413Ruw7b79sn
 0EgLLkU4nQfqhrW82+dW1IWfRmwOeqaQtaTCFXZ6+KiRA9NXwJ5s8eZ9Q+5AeVhFrF+qX3TFVnW
 PDyiJdWf02Az2Fz4hNw==
X-Proofpoint-GUID: XmmJIU0U4MHBjXJeqQRWlnO6acEDws9O
X-Proofpoint-ORIG-GUID: XmmJIU0U4MHBjXJeqQRWlnO6acEDws9O
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


On Mon, 23 Mar 2026 20:31:27 +0200, Alexandru Dadu wrote:
> - patch 1: Adds missing context reset reasons.
> - patch 2: Fixes the reset_reason from enum to u32 in the fwif.
> - patch 3: Adds the implementation of the context reset notification.

Applied, thanks!

[1/3] drm/imagination: Add missing rogue context reset reasons
      commit: da173557a2b090d7d8c155283ba489a287983ced
[2/3] drm/imagination: Switch reset_reason fields from enum to u32
      commit: d2f83a6cd598bf413f1acf34153bd1d71023fbab
[3/3] drm/imagination: Implement handling of context reset notification
      commit: d994acc526c70d40ec9029cfe03d08ee411083c5

Best regards,
-- 
Matt Coster <matt.coster@imgtec.com>

