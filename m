Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2E6CD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 08:53:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B61C210E5FE;
	Mon, 25 May 2026 08:53:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KS83IpjL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YlP1QrQE";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09F5E10E5FE
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:53:47 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64P7c2E61889308
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=0h/mhahRgaE2Bh/5+3ts6a5CZf5wPc0/y4q
 da4eF7uw=; b=KS83IpjLOibDwQEkZZFc9OXI4lIvCWu2K6cCWbpElKDGmK+UkM/
 j3O6Nh/aHzOuYwUEdMR8GrftbKlsH9TIp2FKdb0WeKatUA+/eddxq2lC+/3TsPtX
 rnZLlbs564vqoZizSMJCYEpe9tkL6tP9xJYQTm4NwxDi+PLea8qdxf95PdA+hIuh
 Cmh+VgGk5r2cpqgUf2p8BJ0EvaHnNNs/p8YLNkZ/mt1qi2kGT2BpKFVmDaBAO5cD
 gobyWGCTKVSPFGFozOFcELP44HWP6WqOO/Oc24zVrM0A9wu0u0ECXeBxu3aEgVsh
 +Ga6WXecMsJo2zFpT9fY2taAAOTpt6wWC0Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ebba0w3n9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:53:46 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-368b68a33adso13624505a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 01:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779699226; x=1780304026;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0h/mhahRgaE2Bh/5+3ts6a5CZf5wPc0/y4qda4eF7uw=;
 b=YlP1QrQEj8bOhfYqZlM4G6aqMNmx4v+UIkYr9tRW0Uqg7ru7SytFKZw7gssOTPVxCQ
 +I1uZWSE9oH/wFaaIcfJNoDZajhiUu07JP5oBHY6H67uhpGqcHqFTALW3mCU4w+IfMIs
 MP2y7EJQWodsJD2GxUKDYL3QDMA8qVy/yQ57MH1wo5ifHfBeUh6Fjx4t56xbaMfcTZoS
 h308be1V1EAlXBmOIz82kyiP3VYWMdYuwR4OFY+vKe3uEg6Y0MHAA7wCBpnsgY/51/+Z
 K1ByDxMqwobptBRYTHS01pS62dPzHHISsI4CFKRvPYgXaTJZ6qtv/2B/JiKgAzfaaxcj
 XoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779699226; x=1780304026;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0h/mhahRgaE2Bh/5+3ts6a5CZf5wPc0/y4qda4eF7uw=;
 b=rFd1qXLStp9wtXLxQ/O54eIxFsn2WVXIUS6i+/3PhTj4lZ+3VP0roEk6HpLUTUh0F1
 jmVUz89D1mx/a604VjJxuYpk4F+9knUmKthQwQ14suhMW5RgYme+sY1yLeKEAra+JPp1
 FmY2o+ahhZviQxNxtT7gt+iSqPwE6KMKem308o8Q/8D1awMCXwvaMlro9m/lc/MAkrec
 MyP1+iyVARvqizr5wd6ng/G6zeDaSTqFVETj6j6sJfCu5/gsJ3UdpLWnL/3DsX0R0hdT
 K63Ls6SEdM18m4zVP73P9APoyzGvOGQWBEeSHcUPi3HGmRPhQ9rCvhDHgPreDYmzCP/Q
 od6g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0SBzVCaVadQGSZKnmY6HdFf600lfH1/7DQALfJSfota5WKwu3sSe2p8pXV0QwJboYo2FCND/tSo4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxHgKYA6Qv8Y4kDADzBPAdsS5+X7ZA2VebClkBYi2NGypuFODip
 Dp9rBV8hydQNFJKFrytA9yR/jxEFoBBkVuBvw52h2J1QbNSQ2udUwGOr0or8oLsrEcu9p0/DeXs
 ThgJNFj7VZJVmvA4FkP9GnqAPgeXL8PkM9/G50i20mBNiLy2Vh1pkDvSnlRw4wCCCgbeNoVsVM5
 jGBMI=
X-Gm-Gg: Acq92OFQn3rok1sUFuXss/06GccZQ58mVy3ctZZoEi3kiTwDNQpG7oqAXh6/EOAuc99
 zrT3C5zmTSgEzqofGwd4TFj5KmTRT8oUkNxgbdHyErPT1bvpvHNkrtadttZXIcFpZUGzLJcf7/Q
 rsb+3APwSJWupGaNeH0UL7IgayPgbwrxKDHpNdzIpaX0q73vp7Q4cDMn1dPKqepyReKRqedorWM
 LCjXOgBWrmYn+XNCNiOORd6RCy3f0ZNXzv4hmdv7aVM2QI/X5wPXQcDAwOQPdwl2RiSgsb4zdg+
 YcFjAC9qzBEDAfQP/hyUCeDLCHfALOnNK637aLnl8QxTItvMLBbFYvn53o1q4tUZ7I9vvVctb0e
 R7X0FI1nuAn/zzXEwP+HxF2IPRtcf/VCDtoUWqSWuKs/5
X-Received: by 2002:a17:90b:2d44:b0:369:7b04:49d1 with SMTP id
 98e67ed59e1d1-36a674212fdmr12480811a91.1.1779699225722; 
 Mon, 25 May 2026 01:53:45 -0700 (PDT)
X-Received: by 2002:a17:90b:2d44:b0:369:7b04:49d1 with SMTP id
 98e67ed59e1d1-36a674212fdmr12480784a91.1.1779699225277; 
 Mon, 25 May 2026 01:53:45 -0700 (PDT)
Received: from hu-anane-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8520576972sm8062249a12.29.2026.05.25.01.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 01:53:45 -0700 (PDT)
From: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 ekansh.gupta@oss.qualcomm.com, stable@kernel.org
Subject: [PATCH v1] misc: fastrpc: fix channel ctx ref leak when session alloc
 fails
Date: Mon, 25 May 2026 14:23:40 +0530
Message-Id: <20260525085340.2734738-1-anandu.e@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XBHgOazxODEmo25INee3bflR-aSM0oIM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA4OSBTYWx0ZWRfX3EMsdxLandVb
 ETWT9ULhXUHg67xZgaPQAwYmm43bBqno6onsDstetwOz7UIOLe5/co+5JR7QfYtYcVf5PkIHZoi
 EUzKWzNhoXx7cZcjrsAmq8txHA/XSBgpYzJVe/w9UPGpsACNZmjGuUbko20NWwDNO44c8fnywpM
 EbLhQYPhYryG3HgzX8VECdd6xOqKeCSTF+83NUg7N5TEikDOSvn5Ue3PJbbOJaDahJjaw032rK1
 jS4ZZglc90Rul1fkriSY7Hhh6deRoTktTohUHt6geemv/N+R8ZXwCDMwVJi+bRRAHgspAmRuY7y
 eWSmJ6CwklUZ+7gkdy82SGtR4iq9qEsVgkyenvXyVjkOJhtSk1lNRUWTnYF3N6K+tbvFC9nLaQ6
 dpSiQiL4gP2ceMq1/icJUDDOgOVfq6M5wJlAJY57cR3Lg3byldt4+NvM1CZO7iLQnBUFV1YHFhF
 Jx2T435PbMuiH2WFEfg==
X-Proofpoint-GUID: XBHgOazxODEmo25INee3bflR-aSM0oIM
X-Authority-Analysis: v=2.4 cv=Xca5Co55 c=1 sm=1 tr=0 ts=6a140e1a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=2IMaJKnPo4bYYrUu6c0A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250089
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

fastrpc_channel_ctx_get() is called in fastrpc_device_open() before
fastrpc_session_alloc(). If session alloc fails, the error path
returns -EBUSY without calling fastrpc_channel_ctx_put(), leaking
the reference. Fix by adding the missing put.

Fixes: 278d56f970ae ("misc: fastrpc: Reference count channel context")
Cc: stable@kernel.org
Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1080f9acf70a..9442db2c7aec 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1648,7 +1648,7 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 		dev_err(&cctx->rpdev->dev, "No session available\n");
 		mutex_destroy(&fl->mutex);
 		kfree(fl);
-
+		fastrpc_channel_ctx_put(cctx);
 		return -EBUSY;
 	}
 
-- 
2.34.1

