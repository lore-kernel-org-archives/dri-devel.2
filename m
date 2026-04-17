Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A110F99C62
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 20:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 916D610E07E;
	Fri, 17 Apr 2026 20:02:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oY6yALLu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cS4IhX4z";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF01210E07E
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 20:02:03 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63HIRgr02433695
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 20:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=ViS/wJuo28OBwDkXiCvAvSC5Eff3JISAuPv
 NKYCjY2M=; b=oY6yALLuOkd80Bfm00nUxAPQz/Arhfus7PEHCCESMgIxTYM9oo1
 h0lLLdN7JN3Pe+Jgb9G6XWAuVzfSN9tIupOxOl8PBBgdDnf0OFOuomRFg8AVYM0t
 tG5stVobHbsw8uS8CEZZRPpar//BYlggxqbHPWowJXX1snHzQ2Au7VTkOwed8ic7
 XlCbLEicybarFxujyIzrXIeCocEw4s1syZmuY/KbrZfBoMtZ7V5KB/nnLUyJyHu0
 jdHLGNh8yPpTomodsViDQ3GKytusqGOkuvyo2kjVCznu+o067rG85JhIohGSJWYG
 iHoQQWcvFg3wraTAvw13bNIiydwvl+Cm3Nw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkt5mr7tp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 20:02:03 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b241be0126so21928965ad.3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 13:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776456122; x=1777060922;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ViS/wJuo28OBwDkXiCvAvSC5Eff3JISAuPvNKYCjY2M=;
 b=cS4IhX4zi10DuM8VNAHgYTiMVhmUEdF/LinpfTm98MX7lH6oPxLX78qn919Ay2m66c
 N9Vva6sucY7z1ZsKsygTAQ0lfD992x6M0mbiEN6fVQCRTerj4f4Sbjrxd/GBrfwMOmpQ
 0Lg5Gl1h+4ggKrCTchlvGAlOUSpA8KZ1m7EOvl0lPZMrYYBrozZuMCRg5hJLgAwCcs6+
 LjVAYoSgYea0h5oEOzxq8TZPtyEhx/lrCGlXWS7PAxZ6jX57EX9mTZzHhR0zupnOYsZa
 M6AFDg0oSzbommm3KqXgX8yEVOS2qlQ/0LDmzhuhEQfkpxePKy3Xn7JQM7xjQ9hcME3h
 C4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776456122; x=1777060922;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ViS/wJuo28OBwDkXiCvAvSC5Eff3JISAuPvNKYCjY2M=;
 b=b9FWoWF7ImYULUfuCl7wUPuSci3UgP6tNY/xsKBb2nuf1DTMGoFie/dw8zULDXcXjr
 pvEFRemeL4lHrX9wyJrWiXN1hIISBGdJqWPeFCwAEUCtcmoDDj1RRORNzxuybAteZ3SH
 zRMr/Ft4CAMvxLCLNn1sNDtQrb167RLAeKwUaqqZt3FoQ4Cs4BhQ7XhT3QnAWUXITOxY
 RFPjo4gItb+QJKaLm67EtdTEYPNJwX8e4sIYrs+MDQ1T3h74sVpZpc84tjtlSf+NepsV
 s1bu17g6uAk6L8b55hWaNtHuyMdKPrUJvAaepCwaTWuVTdBjQ95C5fjZ9Xi2TpIMDRBB
 Os4w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9sxZ2mvrjWb3R9Ym0AcpZFm7N0CCoLHHh7184TKaogZF+iatrQ2j9z2kzDHz9Wv6cDHuNp3Zio2g8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzoYSRFFGmUrZ4dZfoI0eXxOB525wkblWsb/VXerCrE1VQuEYs2
 qfMqC5Fx+GSsr62MLJNsaBcZEDXz5RUA49JFgG9Tf50d7LQpuukm5R8FdxG3B4LeiEVUM8D668j
 51SA43ZUGjjhiXDlrRHcM6Ojhe8/IBLI6l8paVQww2Auyz2Onlw82xFsLO0nUNUBu9+nL64M=
X-Gm-Gg: AeBDievOs1F6OaleaMGLDwz5kcvxs9ANO/PfzaK72AFHBa5rtucArxpgdX8XuZ27R45
 tRvF3DuAkqpdFh0pn1+ij5XahzYLoZPl7OLB9s4PAq/n+p+AE/nfS+u/HMtLhLYogOUDyRlJcj2
 8rU2p+pDOeFxmLSh0CP5SB4zgwGt7EHK51ncywEOwLdOKA2OcT7YQADsQjCVweaI+coO/SZx0tx
 Nk9bCkTWzSohPc5NfnbpsoQp19qHlMyVg3AyyqqZpZc1cVouWB6XhtFHqk6gva4Gu73Keeq8IB0
 TUgzaR2Q9/C9rPMM6pnVZj197OjaD8FBprv9ZQ2JzkOJ2k3MOFpSsTLyDsZZuGphPkioyJ7j3wo
 EMTYzZc5RgCFpzzhfqfHqgLtg6kSZIEYq2ghNOsBeNfpB08NdMywOhkIZ8eY=
X-Received: by 2002:a17:902:cece:b0:2b5:f105:52b2 with SMTP id
 d9443c01a7336-2b5f9eceba5mr46078165ad.9.1776456122215; 
 Fri, 17 Apr 2026 13:02:02 -0700 (PDT)
X-Received: by 2002:a17:902:cece:b0:2b5:f105:52b2 with SMTP id
 d9443c01a7336-2b5f9eceba5mr46077745ad.9.1776456121556; 
 Fri, 17 Apr 2026 13:02:01 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab3ad18sm28953315ad.71.2026.04.17.13.01.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 13:02:01 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH] misc: fastrpc: Fix NULL pointer dereference in rpmsg callback
Date: Sat, 18 Apr 2026 01:31:46 +0530
Message-ID: <20260417200146.184425-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AOj9hFqm c=1 sm=1 tr=0 ts=69e291bb cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=MnYYGAq_QTRuFDU830wA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: hPi035r4K1YTC-jkGP3FpD1ROR3hSnyT
X-Proofpoint-ORIG-GUID: hPi035r4K1YTC-jkGP3FpD1ROR3hSnyT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDIwMSBTYWx0ZWRfXwFGSoaDN2vo0
 QV1/528yxUkXBcdkyaUOuFFssZhwfJ7o/0hifzLzNU4oqV18R3NkrcPcsNM6H6LNKb66rYVRvuL
 eLa3eGGu0cFvqB8d2cT/4KoE80iO09bwJU/zjUuGixNz57yiynojTmuIDlS8faEdbivY648JSD6
 ZVI5XXyzpe7iG3UnvTGw/z5NiQGRwEPYxepCRCvby2Bi7jKIN/VhJ8e4VAVg3r3/2j694za2+XR
 YKk6YTuDoKXwBRC/iMDgtkqcyQgG+eHGZleQScLu3sSQoGCtCIZQiQHsKrDA2Yodm60EcgOzcY0
 9RBiVqsWykW/40iod4pFQP9wb1BTVJCYbyGy1BMmP2GDhU7fWK+woVJIvfeK6LnzY3WfJthEVkJ
 EDBre6BhAYbWlIKFsWdDzE+LYBUc6vupd6rxYXzTm2/qT6U/pT2YuadJDl/sjDVMevUaGvmx/q+
 cl6SFMRgWkdbFcYSqww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170201
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

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
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

