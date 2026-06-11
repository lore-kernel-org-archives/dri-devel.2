Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3B7CD98D2
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E4BF10E739;
	Thu, 11 Jun 2026 09:22:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pR6DQiab";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G0l3BmWC";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A63A410E739
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 09:22:34 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GCFp3843629
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 09:22:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=lRkZOp3iPYfQpAbFXsal39
 p3C4jzKAkopk1z5GMHzKg=; b=pR6DQiabb5dCwvywGX0y7Gf6KnTUbRYrcypq8l
 ZHmuh0d+Eu71BVn1PnZ8C3cozG1dkeGUnbIcOwQ9g5nKMISewtOYBjOQxB36IRDJ
 G1c/r1/Eq9kkaFTjOAUzku5Tdq8FwePWNXVMUmRtXOgJ0QyWvm2BX6CIS9ldBLbu
 juP8d9wJei0IhWv8DktpnxwI4KSeD0mSVEvt8l2/jw/9jFDMDQEbp7kmsb8m1Bkt
 YNIf25gX8BgFFxbqXtOEzjkCs0Di76M8aLmmiOEZargdEp9i0bE99LeLAiHbd6Mq
 6WTa/KsB6MVYkZbvx/+ZK9QRHngO++oHQBy0n4oK6ljQY9JQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe702nqm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 09:22:33 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3080bb0267dso269969eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 02:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781169752; x=1781774552;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lRkZOp3iPYfQpAbFXsal39p3C4jzKAkopk1z5GMHzKg=;
 b=G0l3BmWC2R947ubrUHwuVaWy3URF66efeH1YlL6bOwDJZdHjqgyDmUpXJxrBM10q8O
 vmwUivSKtQMYGTLeYYF+LdVlIFAMkvRAobXlsQM2GX5ftytSpOJZnU9YpKcekoLlzefN
 TEm6njPSStmdVIKhnWyPhCZcGdb6xrTm1ZYxsKZBQgVNwwCOh4KDAf2KZrhgLW6eourk
 BDRtLc6Kg6EXvQfpQ1poZQIYNxTRgm465zhmLprBVMeWsvfKxJ/0IIyiXXZr7BI+Ep4D
 ZJKs8qc05yWDmOYtZYIB4P3ZBgIz49Yi+aGHtUgPzLU/mIKVJpMUIpZuvvmz8CwliO6O
 G6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781169752; x=1781774552;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lRkZOp3iPYfQpAbFXsal39p3C4jzKAkopk1z5GMHzKg=;
 b=jXUDA/HA4Df0QgqnVg+rAEnbqu/6uSeKq1bUgfhgSw0allKG229AOeGE+YHZzYpMrg
 u3pFNaSd9yJ+oou7fEKHGB6UB79uPu9DMt/hi2gA5OzX3Eydq4CjxeLh8o/3i8E9wpci
 LG4IA6TDgLsCMAGBbJgwkpjLFWVkPgahIVatnPEJH00NuYz7AYPXXQPfGzMbtxc/J29o
 foXFmcdckv+MxIiWyNVh2gwKmU98886lf60cKpHpgK69o2pnYEpoaJ8NPfqKxIvdg2Pw
 NVMyX6cD9nF9xMUJbG0A92mRKXkqPD3VWsfak7oohqTaykmoAIz06h4dHOnepguSfMT6
 DrOw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9bZogys7qr2E8eBKEfjUEjiNa3iEGtJFijXVFz7oXW2vh260IM+NjNeYN3aiUCC4zdbLq7JDX75do=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzpYdr37eBkf9oodkwnmWk07kKyCNBmgJIuqr+SYuMD5n30vo4L
 /b5q9duV7EGZdJyiw3Wb9kwBuxklppaEBeOxLRLZf9lN0vcFmqy4sfPZHU2FpH4lEqOryVDw1Q/
 1oblotqp6X8DQh86RjdTS069AQwgT2kO7HuYvvZsrcAK3F5XWffkv4oq9VyYRW64vzp/aB3M=
X-Gm-Gg: Acq92OELPcrNwZlZaymSspNJ7d8n/+1yZAEtXluVG67FkvRhzbk1jVRJtr2+A+p72dm
 xOkANdHWOtBSDf9v5C+W1piwLDdMs5AoU2IBBH5qcKWQfiMcgTGljBZi1WT5D3PFqmk4oL2qG/s
 9798AhApE1MqvfCyoobRXahHnM8pTif2LkN/0S5oCwIUEwb05kj/azL/mPcUqRWeGcckYuFmcas
 Oz7Ax9ofbyTEBJ4KKDjy31M2/p1jDmy2V4KPfbgUF6quKUTixKMTEJolk6kiH6Mt2KPsvWtDFGI
 y/J1Qb5PEYDerA8P1OTO8B2bdN2IWuzZPfy1SJmJ3fJz1yh03FJSBje7JO25XCCN0yGQXxnESHy
 5CeG+pGl3OvDB4qMqmYaD/36fx7BMjWepHYYJU4LainrkvrN4PjR0mWd9/jZjlS1rbcAtyorYlK
 ETFV9D
X-Received: by 2002:a05:7022:7a0:b0:138:30b1:4bfc with SMTP id
 a92af1059eb24-138421355f7mr1223014c88.9.1781169752457; 
 Thu, 11 Jun 2026 02:22:32 -0700 (PDT)
X-Received: by 2002:a05:7022:7a0:b0:138:30b1:4bfc with SMTP id
 a92af1059eb24-138421355f7mr1223005c88.9.1781169751981; 
 Thu, 11 Jun 2026 02:22:31 -0700 (PDT)
Received: from hu-yutlin-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-138430536ccsm1333005c88.15.2026.06.11.02.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 02:22:31 -0700 (PDT)
From: Eddie Lin <eddie.lin@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 02:21:44 -0700
Subject: [PATCH] misc: fastrpc: fix memory leak in fastrpc_channel_ctx_free
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-fastrpc-cctx-cleanup-v1-1-28097444116c@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIACd+KmoC/yXMwQrCMAyA4VcZORtoe9jEVxEPaZbOiNTSdDIYe
 3erHr/D/+9gUlUMLsMOVd5q+sod/jQA3ykvgjp3Q3BhdKP3mMhaLYzMbUN+CuW1YExzcERTPJO
 DnpYqSbff9nr729b4EG7fFxzHB4FP+zh4AAAA
X-Change-ID: 20260611-fastrpc-cctx-cleanup-bfd20aa7b8a0
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Eddie Lin <eddie.lin@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: bPBgKTihBTAF5g3-5r3BB1wjXFVKx451
X-Authority-Analysis: v=2.4 cv=B9eJFutM c=1 sm=1 tr=0 ts=6a2a7e59 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=TEyi4pTYuxprMEVdLL4A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA5MiBTYWx0ZWRfX1spDB8SgL8Uz
 zK05Rb0tKNyoZAovpQ6BYsJkCdUYFCBsdflw8RCvYTJRU5VU8io5PwmB3T4jL2X3bOFzcunUSIQ
 7oZiFwUhsvhv83yBB4fWmwQEbOIBzhKl4MluRH1zzq3J2C+WQTD+66tzVqXZGMuq4WqJP8u/N2G
 HrEFqpfXydUlqgHGbt3QU1MeC64/kE/UNXKtAaa+GBx3JgE67FBoCEVtnlsmZXK4M4Aw/zenGgl
 DtyLSxxD9I7KaqgbucpN9/Yen/W5DG/pnMFTQcbE5typP0Ysd1qLlltIlun55Zgu40OleXDU0CV
 vioFl5GsRfR8VMVVogwHUjtFrqbFTMCmlXKkztA7LZIcZxyrNFRypQa9OhSJDx5U65Z8XXinqsb
 9av/J6S0Cc7am/F2gXmXu0TTAyXuYm4Ex808kkRmdiqBbB274CMe5u23F6XVfek2417mGETuTLM
 FRRo1xPOufSFhXIPA4w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA5MiBTYWx0ZWRfX4hNwfOFM8dxL
 p5GzLdoGytj+S0F7xqnBVyedI1F+gG+3+wmY71ohyzR9VOwGEppa/FDryIzaZ9YGW7WlcI3djCh
 aBSq35bAJqiwfcq/deQZInKST16+5Uo=
X-Proofpoint-ORIG-GUID: bPBgKTihBTAF5g3-5r3BB1wjXFVKx451
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110092
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

The 'ctx_idr' is initialized but never destroyed when
the channel context is freed, leading to a memory leak.
Add idr_destroy() to properly clean up the IDR resources.

Signed-off-by: Eddie Lin <eddie.lin@oss.qualcomm.com>
---
This patch series fixes a memory leak in the FastRPC driver.
The channel context's IDR was not being destroyed during cleanup.
---
 drivers/misc/fastrpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a9b2ae44c06f..7727850e9240 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -492,6 +492,7 @@ static void fastrpc_channel_ctx_free(struct kref *ref)
 
 	cctx = container_of(ref, struct fastrpc_channel_ctx, refcount);
 
+	idr_destroy(&cctx->ctx_idr);
 	kfree(cctx);
 }
 

---
base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
change-id: 20260611-fastrpc-cctx-cleanup-bfd20aa7b8a0

Best regards,
--  
Eddie Lin <eddie.lin@oss.qualcomm.com>

