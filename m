Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FCFCD3427
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 17:17:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B6A710E3E8;
	Mon,  4 May 2026 17:17:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="K4PzJiCq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WimEJgkD";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEEC810E7A3
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 17:17:13 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644B40cn748887
 for <dri-devel@lists.freedesktop.org>; Mon, 4 May 2026 17:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=UNH5pQ64r4nUU60TyQ3qC8KKJDFPHI4UC0Z
 WJhC9M4M=; b=K4PzJiCqUXOxQjn4FY8LftTo7Rvym/4Ac1ivVvd7+3M0ma0MQtI
 r4hYCNcVNv/rrypPSiCIf/XFooALCtVXLK9zLcclJemHzefVJc4OGvL/1A0+R3K0
 +tbH1qALjwMid22pPlbjkZykE6ZEXTTRcgIm5mCT1jGwsRMPRUp/IsypULnmhw1z
 2WgVB/lP/O3NLORw4RIT7GZDnKcDtO+pIlv2fpP6Enk+5Hr++qyHd/WClOFixBH9
 4Y/WqMa1l8Owc0vdyaOnI6huZpiQDoveiqF6FMhHjB5B1TO4Y7YpNcXdIXB0BrqB
 mN68C2ChS4d3ckzadCEX03wwZifSU3idykg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxscf1fa6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 17:17:12 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c822ebaa40dso435733a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 10:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777915032; x=1778519832;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UNH5pQ64r4nUU60TyQ3qC8KKJDFPHI4UC0ZWJhC9M4M=;
 b=WimEJgkDMbal1bfd5FpoMUZ16XZDUfYxLaDxIAdKWiPHcRAhWS3/CpFrNF24ZMyuwo
 dOOgBL79D/H92ItnS6oAX+bbjKqVY2g5N8aHESORpYeI0usCcDaoLGX9d0HoFtfu0bkh
 c85LXSBQYVdEJnw7WUwJEM1szqydLnD0D+C/vV81+Xd/f8UKsx7v3nph3uLxS41yLtyC
 8Xmnv6onzDspvO5GCtZ/NZefQtqsMminoGAQyoa/DwHdOML20p7qGbuBNmEQg0FcbcAN
 9wOyByrAwKfAjzoeAGNGHkN+PGQwhTN+YnEF9JNM0/TkbDktADYLNbe2cmem/HeBKCXM
 CIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777915032; x=1778519832;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UNH5pQ64r4nUU60TyQ3qC8KKJDFPHI4UC0ZWJhC9M4M=;
 b=fIqec9aCMDm5GTshZfnfT9T32KCMgXkcgQH7iAKhuWp9ffEMuGB2Cf3UVPXHZKxb6d
 DHVQYqvM9dAgyWCtrjFzSgs0TUUgLgxOMuCZX+Mr6mpod5xN/De/Ot3PoNJ4WbCw478a
 g9sNdjJxvuvtOukPFtvNEg73MWHSqtKcn1eevoHRJlC3XZiUKQq+MAKQNnV9PQb9bmgE
 wD+ktYUT36giwBQDz6XBQeEgXY6JXl835gi4SxBgYbWX0hIVbhiay086akAgwVw2vho9
 3bvOBtVO1eAGrZA/ZPtUJPnePmPuNSYiY4fQFnK/8zuGogxRvk1/yL75zpY6Gx41oWZc
 jRgw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8t/yaYsmXO7P1Wl+Gt1QsLbJvrh4eBdU3F8FSn8oze2TWgzYvE2nQKvFQffeLB0HiZwH2axoqcy+c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxfE6wZAECvPS2MAYWDus8xTQEBBwQAJq3XRyulBlc55dJjZkyS
 jHh6tNaFWzPa6BIl3cYcR1xl7Q//pN9668sSO50s/qELy8S7Alkr07R7RPUL5WBIgf4oBaW6pw5
 +/9GnUvSU/A6E7fmrHuzKxh2D724y4SNY1rc7DD0alzdC9jgv2Ppn3VeqgFMBwyQ//r+Hzvg=
X-Gm-Gg: AeBDiev0mNRmHwEnuUs1fG9y2RMmaHD02FRrW7r95NKGmseld4Og8WXaagZtlu2cD7U
 oE3BrCNNtOIjN5w7nQVdGtwC2wGpQcSanf5PdHkCNqddfwuTK3F7saAVYEvEg8tSMKifipPwtj7
 dprT/DuwHDd1AqSgzSaxzZn9o3w9veBK7aInAJygsKU3Cn11q5pJVNNQmqOqgHkgKh1E+MywhzH
 Tj1Ke/eGBBdZvHyAK88T5pUiAwcTEHiTXBrFrAhKrBjKtSyTdgv3rqaKRTXC78fCZ4w/7/DHLGx
 biXdJmVQ9SMUoOGY9lPJLkTMVs6K7oBhq1Unvx3KByR3PHVL3Z9BGotFuAw7idq+H1JrjByNEHQ
 wSbh1I1rOPfjdIKxNBn9Bs24kIygyLsBh04u9RxU9NDSO7g2CSDez5ljBa/s=
X-Received: by 2002:a05:6a20:7d8a:b0:3a0:cd5:82a6 with SMTP id
 adf61e73a8af0-3a7f1c6759amr10124026637.46.1777915031192; 
 Mon, 04 May 2026 10:17:11 -0700 (PDT)
X-Received: by 2002:a05:6a20:7d8a:b0:3a0:cd5:82a6 with SMTP id
 adf61e73a8af0-3a7f1c6759amr10123981637.46.1777915030474; 
 Mon, 04 May 2026 10:17:10 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7ffbc6f063sm10398240a12.20.2026.05.04.10.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 10:17:10 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, stable@vger.kernel.org
Subject: [PATCH v2 1/2] misc: fastrpc: Fix NULL pointer dereference in rpmsg
 callback
Date: Mon,  4 May 2026 22:47:00 +0530
Message-ID: <20260504171701.18164-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BcvoFLt2 c=1 sm=1 tr=0 ts=69f8d498 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=MnYYGAq_QTRuFDU830wA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE1NyBTYWx0ZWRfX2aflCzZvw6yT
 AeGaTuDYGhW4m+dYKqJSlC9EQHmMneQKLYphr44ZaXbEQ/LijNQaabQn+xT/hyxiUDDv3vjJpXI
 URMIHlIOsulZLPjq6nRIjsLfKS2Uu8TdMYIcLWa6sA9tCcWdRlWEY+2e1zJrtiMPp7hDjI11vW0
 Rmo7e7ZnIDuvaDXwtbJpgArUU+S0WPdNROJ8F1M4SDAElhNAeqUvOmz00MNiz7CcCTiCxwd0M3U
 p/AbXdkxi0RRMVq0Hjh3XU8iWbkCkJHKwBWB7d4PCSnFC9zoyyvovuBgIXtwbx9pAjlNpCx9Rip
 U2vo+i3b/pAkN01nvW0myJjoCRcY+S1IkGr4/xuD3e94gC70o7ZMJ6FRVyzW/beuovVKqfuesAX
 h31cIYhRDyo98TV/G+yYTjGouWbgnwMtIN0OlgiTSX4u0TWlGtESV+X9JTDgXUILTPO31Zpuovm
 88ZeYyPDtJA0NKbJgrA==
X-Proofpoint-ORIG-GUID: 1Ma3ThtiecZcSlZ9evwwhj_ZHIdiDOHK
X-Proofpoint-GUID: 1Ma3ThtiecZcSlZ9evwwhj_ZHIdiDOHK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040157
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

A NULL pointer dereference was observed on Hawi at boot when the DSP
sends a glink message before fastrpc_rpmsg_probe() has completed
initialization:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000178
  pc : _raw_spin_lock_irqsave+0x34/0x8c
  lr : fastrpc_rpmsg_callback+0x3c/0xcc [fastrpc]
  ...
  Call trace:
   _raw_spin_lock_irqsave+0x34/0x8c (P)
   fastrpc_rpmsg_callback+0x3c/0xcc [fastrpc]
   qcom_glink_native_rx+0x538/0x6a4
   qcom_glink_smem_intr+0x14/0x24 [qcom_glink_smem]

The faulting address 0x178 corresponds to the lock variable inside
struct fastrpc_channel_ctx, confirming that cctx is NULL when
fastrpc_rpmsg_callback() attempts to take the spinlock.

There are two issues here. First, dev_set_drvdata() is called before
spin_lock_init() and idr_init(), leaving a window where the callback
can retrieve a valid cctx pointer but operate on an uninitialized
spinlock. Second, the rpmsg channel becomes live as soon as the driver
is bound, so fastrpc_rpmsg_callback() can fire before dev_set_drvdata()
is called at all, resulting in dev_get_drvdata() returning NULL.

Fix both issues by moving all cctx initialization ahead of
dev_set_drvdata() so the structure is fully initialized before it
becomes visible to the callback, and add a NULL check in
fastrpc_rpmsg_callback() as a guard against any remaining window.

Fixes: f6f9279f2bf0 ("misc: fastrpc: Add Qualcomm fastrpc basic driver model")
Cc: stable@vger.kernel.org
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
Changes in v2: https://lore.kernel.org/lkml/20260417200146.184425-1-mukesh.ojha@oss.qualcomm.com/
 - Added stable mailing list and fixes tag.

 drivers/misc/fastrpc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1080f9acf70a..a1a54453bb7e 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2431,7 +2431,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 
 	kref_init(&data->refcount);
 
-	dev_set_drvdata(&rpdev->dev, data);
 	rdev->dma_mask = &data->dma_mask;
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
@@ -2440,6 +2439,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	idr_init(&data->ctx_idr);
 	data->domain_id = domain_id;
 	data->rpdev = rpdev;
+	dev_set_drvdata(&rpdev->dev, data);
 
 	err = of_platform_populate(rdev->of_node, NULL, NULL, rdev);
 	if (err)
@@ -2513,6 +2513,9 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	if (len < sizeof(*rsp))
 		return -EINVAL;
 
+	if (!cctx)
+		return -ENODEV;
+
 	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
 
 	spin_lock_irqsave(&cctx->lock, flags);
-- 
2.53.0

