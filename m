Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593F3CDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 08:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4A3F10E892;
	Thu, 25 Jun 2026 08:08:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="c1AYtYZs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DNpj41WG";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F4AA10E6DE
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 08:08:41 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P7SPQ72762965
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 08:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=sb+3siK+bp3PKyAROTwDlHIQzDF1Ozu9V1v
 6eRxHPHs=; b=c1AYtYZsA5L6JLazbZ0GHTuR3U/9PQ+N5i+ft17sh3hgufBUOgi
 2Qvo0TE3TETJwTsPU9lbIaKTvnqB4ZZjOBX6M91tdSnQPrzoEQY6hF9tecN06PG3
 U7OI3my9GCTr4H7mghOYUU877iaeoUcVoDuuTl+tOcuHS7vRkQdOM1AbTqziKqkD
 SA7I0tbfiAiCx21lE9RehRwYKKzHcb9ojJLQyHQc7RehT1LHcPI8jDyAS6oZAD00
 6GrvwIRfiv0JC2Wfr2BNNHqWywX8SG9bIJvpvnb2UmMxYlZ3cM25XmpaJsiH5FaS
 8qltYuktOFUHyaY2RnJ1FYw3rLrsgM4TwxQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0yynr507-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 08:08:40 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c894c1c4aa9so1216931a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 01:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782374920; x=1782979720;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sb+3siK+bp3PKyAROTwDlHIQzDF1Ozu9V1v6eRxHPHs=;
 b=DNpj41WGTCgjN4hpaS5dN1Di6lZVOnpreTTNAeVU91UdvjbYCHs/demCY6sma7JpC+
 B9CvpVu6vu58abz/PyD2t3Krg9Y+mdL73Gq+z5DLgCyr/KiTTKtAZwaArW9wI68Dz85m
 hHElTHU5ltPWRC/xkck5oyG3bu6G8C95G+NoReDDMhAMUPIgiRXOFaxSWMg/i4n0RDCX
 v+uIx15zplbN6Wx3IwfetXrUymI4HzG9IupJwJs/YPLa0rqOmL4w+dgtqDipVJL1KQor
 FCRSNq5nZIoxCwQiCErTNHTaqV7o7kvgRIxz4eQthAxKZsic5iBCJoJWyXonf+K5vo4l
 ohxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782374920; x=1782979720;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sb+3siK+bp3PKyAROTwDlHIQzDF1Ozu9V1v6eRxHPHs=;
 b=rXEPQRFcjSJdmmGh2NRSZwE7BQPMJ21+2b/Ax/Jalil6wbtDOvtKC+7yUSx/KONdQA
 NhVibKGS+Zv21aWW5f5/JJf9+VK2Qgt3+oKPPIoXW7iumQsFwOogshsl7xEP+E5PmcCY
 WCcVe/4vyPiku6rEGTI6bFAUeiAc847SnJnHd9QjEYe+s4eSRyrqFBrjOg9mrVh9DpZE
 xIPYeFNFAb3ZNnaCAybr5jd87J/kpZBUzY0hJ/u6or5gcn3dNBAOMEpE9zfgLvMYoLQi
 k6N37tXlckGd/RWLegrxB99qIZMEVEZM3tlltHXOMyKUBPFXL9IwcJbHC1B6OeKVOCs1
 5LJw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqeKcXI4lpZmCgcVpXPUDB/wj4761uo0CWjbqIxSCz/AadXlWC9EDJio5e2zHUFUAPBQ8naE22QL/4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzkmzxHQ/2y87Zn/lDUGeY1BifcXy68K+lnPPrezEeiEpFBIv8G
 VHMDWwNVWkrooe5eKfBawpYXDalviBkwHtYNi5aB5J2NAxuZbZZhwEgJwZuuoPkqWnpQtfBdq6N
 n/tfq4Ub4+BzPy0E5TiOJIb+jNuEn9wFkMLYePI/R+S0emPmpXkD7f7DLMPxXSnbn24E9DQo=
X-Gm-Gg: AfdE7cn0PMku4bZAa3hLcX6aheqWhxuxkRXKdv246shANe55qVbnFBbIRaUq61ikpeQ
 Y/fZEeSQhrhVA6sXs4atUmEPTTmykudVeLSOrn4yAU+3N4u1jjP4F0po0iOh6AYg3agQcHcUQFy
 eVKSSnqC6nbvTaMEEmKcxGQaAjC8tNxbw4C6EsCxhWVZH1KWCI0Qe7GR35j7Rh2q1L5jMxUQ2cQ
 QiRPhsBzzH8v84uW6wCzTEtizoLV03we+5P5TT8v64b/n+miSGtnKubje7ucnYm3RHTweTvRHG5
 ++Eoh1OCb8LipOBUb3lOksIH6/sHWF2RrcdUA0rvH2is/ZD7+gyD79uLf1Y4ZJFgZJuO61lHuE3
 jZWv1sb2fFXiv8y7pMg8DypOF8G2a/zFoHAMIrRreXceqOHxgJOEQCxBKWZ12unts1Uwe0tLju1
 fXmNQLSmUX
X-Received: by 2002:a05:6a00:14cd:b0:842:4387:34c2 with SMTP id
 d2e1a72fcca58-845b39f2224mr1854508b3a.10.1782374919824; 
 Thu, 25 Jun 2026 01:08:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:14cd:b0:842:4387:34c2 with SMTP id
 d2e1a72fcca58-845b39f2224mr1854476b3a.10.1782374919366; 
 Thu, 25 Jun 2026 01:08:39 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845b927cc0bsm495077b3a.21.2026.06.25.01.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 01:08:39 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Ling Xu <quic_lxu5@quicinc.com>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org
Subject: [PATCH v1] misc: fastrpc: avoid duplicate DMA mappings in
 fastrpc_create_maps()
Date: Thu, 25 Jun 2026 16:08:32 +0800
Message-Id: <20260625080832.17477-1-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA2OSBTYWx0ZWRfX60/7LQKuHUst
 Gt+l9WvvFu1y/+y2QteR3QxUtVw3n+dsfk7+jyV/Ipxme+o6gjd+PV23ANzg2zOntoWwM1vPBZy
 r6sOZahmPDEmqaDDgxX5Bg1GDW0wXDelbkc6PuYsv7MRobTLZ0Ip/fnWj6NjjKTy+GFMGjT6kHr
 /b7WOT+q+ST7ioW8cS/thF36U51ihjs4VCe7HDOg06aTMqEA7z8F7sHYWDwouVwx5J1cYBOBVrG
 DOogBqMa2YjG+a2yTpn6RzUB9LRnvq4hAAb/rV5CuChqXMIXnki2YvjFalD0AjEO0W2zNe9mBBo
 cTVZfvRJorkscytuEyrKqZcB/BfNbUm1I5sYUBxktrQWjcIz2vGKX2fdDypOfI0gvWttBYN/iYM
 ToaVz8QYMy9eFw7/aHitgXBvUS9A6+iA2vXzxtwkZ/FS8+mDtqGbdToZce/yjZ3D7TsE4maYUIP
 gnZ2Gav4wnkCyEuMrmw==
X-Authority-Analysis: v=2.4 cv=aoyCzyZV c=1 sm=1 tr=0 ts=6a3ce208 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=oQxmpDa7-PQQZ_56PAcA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: dP_jVO2qjHht6A4lj7YeyhZs9Y5f2L1N
X-Proofpoint-GUID: dP_jVO2qjHht6A4lj7YeyhZs9Y5f2L1N
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA2OSBTYWx0ZWRfXxztEOJ/eMviy
 Gu2koYtjMRTqzM0gbEIMR/nO39gxPwvqWuOH4e5GuH8omfKKhyOTsrIRZs84AqE0KTUeeT9vSlR
 kqnuLyCIsFgLtlBUKFBYZhZep+Vd2zM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250069
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

fastrpc_create_maps() performs map lookup only for buffer
arguments (i < ctx->nbufs) via fastrpc_map_create(). For
arguments beyond this range, no lookup is performed, which
can result in duplicate DMA mappings for the same file
descriptor.

Additionally, if the same file descriptor is passed multiple
times within a single invocation, performing lookups with
reference counting would increment the reference multiple
times, while fastrpc_put_args() would release it only once,
leading to an imbalanced reference count.

Fix this by allowing fastrpc_map_create() to control whether
the lookup should take a reference. For arguments beyond
ctx->nbufs, the lookup is performed without taking a
reference, ensuring that existing mappings are reused
without introducing duplicate DMA mappings or reference
count imbalance.

Fixes: 10df039834f84 ("misc: fastrpc: Skip reference for DMA handles")
Cc: stable@kernel.org
Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a9b2ae44c06f..2622a1360a65 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -924,9 +924,9 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 }
 
 static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
-			      u64 len, u32 attr, struct fastrpc_map **ppmap)
+			      u64 len, u32 attr, struct fastrpc_map **ppmap, bool take_ref)
 {
-	if (!fastrpc_map_lookup(fl, fd, ppmap, true))
+	if (!fastrpc_map_lookup(fl, fd, ppmap, take_ref))
 		return 0;
 
 	return fastrpc_map_attach(fl, fd, len, attr, ppmap);
@@ -999,23 +999,23 @@ static int fastrpc_create_maps(struct fastrpc_invoke_ctx *ctx)
 	int i, err;
 
 	for (i = 0; i < ctx->nscalars; ++i) {
+		bool take_ref = true;
 
 		if (ctx->args[i].fd == 0 || ctx->args[i].fd == -1 ||
 		    ctx->args[i].length == 0)
 			continue;
 
-		if (i < ctx->nbufs)
-			err = fastrpc_map_create(ctx->fl, ctx->args[i].fd,
-				 ctx->args[i].length, ctx->args[i].attr, &ctx->maps[i]);
-		else
-			err = fastrpc_map_attach(ctx->fl, ctx->args[i].fd,
-				 ctx->args[i].length, ctx->args[i].attr, &ctx->maps[i]);
+		if (i >= ctx->nbufs)
+			take_ref = false;
+
+		err = fastrpc_map_create(ctx->fl, ctx->args[i].fd, ctx->args[i].length,
+			 ctx->args[i].attr, &ctx->maps[i], take_ref);
 		if (err) {
 			dev_err(dev, "Error Creating map %d\n", err);
 			return -EINVAL;
 		}
-
 	}
+
 	return 0;
 }
 
@@ -1508,7 +1508,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 	fl->pd = USER_PD;
 
 	if (init.filelen && init.filefd) {
-		err = fastrpc_map_create(fl, init.filefd, init.filelen, 0, &map);
+		err = fastrpc_map_create(fl, init.filefd, init.filelen, 0, &map, true);
 		if (err)
 			goto err;
 	}
@@ -2100,7 +2100,7 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 		return -EFAULT;
 
 	/* create SMMU mapping */
-	err = fastrpc_map_create(fl, req.fd, req.length, 0, &map);
+	err = fastrpc_map_create(fl, req.fd, req.length, 0, &map, true);
 	if (err) {
 		dev_err(dev, "failed to map buffer, fd = %d\n", req.fd);
 		return err;
-- 
2.43.0

