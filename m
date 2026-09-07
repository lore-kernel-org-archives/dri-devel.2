Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93DDC79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED8EE10E68A;
	Mon,  7 Sep 2026 07:04:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AKqq5TlG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IG0IdDR0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEF6E10E68F
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 07:04:04 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6873kwt12219308
 for <dri-devel@lists.freedesktop.org>; Mon, 7 Sep 2026 07:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=6dv1pUUWz6N92r1bDb3rB4bKkCRSNB0fggx
 uIRingaY=; b=AKqq5TlGrVvdiPCmnW0Mq/ufxC/rIn4VPMMFf5wUk6/8GaGrnbM
 C5XdCRbrqKfwkypt25M8lroj5IlzVFO6QEpOHup6DblsX4R5T2Byy2oqcMU+cGjp
 CEinPhgig+lqlFey4+UK9B2dgDN0A5Z7fj5g5D/NbuHHXp6lKmyn4AqwfFhVleNm
 lJDhWJvBpA9fxhWUjxQAVDO4MpN6Kjr8B2Sy5ZMyQZBnzzLGTbWl63Y0COuTOeRz
 028H0Xh4WQud3JcAxr1OC6q0QXM7YKH0EqTgHBlVtNJS1Yp2IvOIRvAXgomlVTtT
 HoG4vabGKUtQqSHVFa5EIDvL0XMdPVi/dnA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggcca5ada-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 07:04:04 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbee6bb8408so4142650a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 00:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788764643; x=1789369443;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6dv1pUUWz6N92r1bDb3rB4bKkCRSNB0fggxuIRingaY=;
 b=IG0IdDR0D8OFevxd2oQluvdJoMUMHA/xvs/3xjK84SRvvVGW0JYyOzLttmYQnR3bsu
 xfXFO3tXyk1ROrvXhmd0ak35dneL6w+fO/YKnom/qDEnUwuRqaqqTpWCj909XNWVGeI2
 QyAgI7R/KD6GZkj2T+Ln1+UYkutbir1yFmG9TsW2VtxmMaZw5ZY0PJFChshH/FOK+B2w
 c2gQizlHRtMNLi5OYM/0jn4AnWwYQu3/F4hOdA84r/Su6ECawI9ZvsPvmre3zajYlaN0
 g25twudWesKzEaVK5bn7/HV6IPfuPvL77hFRPUV5KdEmGG+b3BMHIQxRKINLoeW76Y27
 T7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788764643; x=1789369443;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6dv1pUUWz6N92r1bDb3rB4bKkCRSNB0fggxuIRingaY=;
 b=Zm4v+d8Dh2Z+NKxWhAHCeiTSyoTcwIpa6aTk4ItCrEIXnLFz2ZQYLjk+SmAN2cs8nx
 McY2Eeey54qKZQWOuNrMtfxbTLDONPW428SQxVaObkk/ibH9D72w1jbYz6blHB4uur6B
 UgF0o4R4v9gh/InX6xxqj4U5Qgixq2eLeFtAzEnd1UAGI1O9p5alnE4OkBWWDV8tIV7u
 XpLZuZ1FFNynWN7bXjr62v68cUBbbTvgVK2iY2dqS0D2mIRMfUbqp/P/uFFIMc/Q6mvs
 CW25dGkksWTFvTy89D510+xN7W6XtOCWigwwXEepw6NSYUKLPKJIrDPLpsHS6m4s7kDd
 SA6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3pInM1FkIx0ySRzVo/lH46FBLRK8IEZfgU0rbTI47zX52ruEsyZCuHOtfcX1SQTfKbpICGq+fLQs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nwY7Ocb4ny+rp/w+Bee4dEWxmPRnLQU9q8k0QTs+0269/svfb4
 X6xmcRGCAdpcQD+bvp9IAz9HPzjUmm3jZWZOuaY4FWfKvvMb+rsGWftuan2RnrgZOGoCvkkV4HH
 4HgGiDYb7+GCoqrpCGORFGPoAfD1G8bqSaN2tIJ8wS1HTGpM8T9W3QER0OjyemgoWR6rnCYg=
X-Gm-Gg: AYBFou0FaQIL2DKQuBJVuuuw/p0+KjbQ5CWm5H8AcVZTYKdZW54WzbT5cSVM6OLVaq7
 T9YALE6NYi2tyiaghbQpmwGId6Pd+DEAgE5ogzMyfZP4oTGJLyjIgFsKKfMom4UZUBJZ7lFFGCf
 MwhAMS4SXZVlZItrdy6qc1Do75DF2CnXX2OcVfNR7hnVEi6Q9yR/oYqGiKhAxisjBbMEGPetoOp
 7DfmtiD/7l/HW/PeX/80m9Uz12cm/vfHdf57yvO12P97S4HkTlOVjhKwwQkOpNRaeDirTfpIb7u
 8IhOvPt3Zci9OeHYiwN7TixyrIwfRYm45C7O/wBsgNIwLOecM1tAlaqQFOhIS9MHx9MnTfwUkgS
 /3PwIuWARFjKWYOpS7ouCFGLAKY7+RWoNrS/2UK3C9nv15hJbB2QXm0E5cRrkrOWJy62qg1sDyA
 ==
X-Received: by 2002:a17:90b:5844:b0:38f:5869:387b with SMTP id
 98e67ed59e1d1-39b26101c20mr32080547a91.9.1788764643326; 
 Mon, 07 Sep 2026 00:04:03 -0700 (PDT)
X-Received: by 2002:a17:90b:5844:b0:38f:5869:387b with SMTP id
 98e67ed59e1d1-39b26101c20mr32080494a91.9.1788764642834; 
 Mon, 07 Sep 2026 00:04:02 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b26155324sm18344681a91.17.2026.09.07.00.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 00:04:02 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 quic_chennak@quicinc.com
Subject: [PATCH v2] misc: fastrpc: Reduce console noise from expected DSP info,
 reserved memory and session messages
Date: Mon,  7 Sep 2026 15:03:56 +0800
Message-Id: <20260907070356.509-1-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: REm5Kpw1RHEqDUBlgJgY67cZI-6Kgrk5
X-Authority-Analysis: v=2.4 cv=EJo2FVZC c=1 sm=1 tr=0 ts=6a9e61e4 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=LgK48ucg0MBlhcVu-asA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: REm5Kpw1RHEqDUBlgJgY67cZI-6Kgrk5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA3NCBTYWx0ZWRfX5LcEg02EmaOF
 Y4f6XjuFbKFAdvKUGtt6jTQ1H8QlmjXOMPO7P6+ZsZBD9KFrWInIU7n+ZgbB4GoLJO/RHpAA1Me
 XJvJ4NBjQs1KjtMZX4XuPbmPgN0YOHSoSGxsCU5/gTAoBTQbxbXH+PUF0M9YmkgqHBan1xiqA2w
 x9KJ4MNS9D/lHCEBGHp4px9RJNpRbE+4oOyJqYYoF+Xd22XieOByP4NwLmQj+p4u1OaRzUcTO4c
 0jRfdqTSkEQY/5eYqboW2y1Umf+FMzous9ifNaQiO6LbbMrsloB5JB2UyHWQaznfKToiTT/SXAI
 X1D8afQLzkH7fR2ZgbpgMBf/s4p6UbGft9FFuvnldwCZCuFOLMrrMTScz2/bBZY49tCfCGxEkuU
 WvpfXFzoHemfroudMGa+eEq4Iwll/Zvrg0X4INUFpvRs3Lf35cA5Mcr5SX7XzDep4YZaQhAm/5F
 W6HUy2fGlBHiCt6H89Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA3NCBTYWx0ZWRfX99gXbqgfEXwX
 0yc1oW7tvnbZCiFhnOaIqWMGoy4AcOp3wTUii3yev6I3O921fef4Pzs5EhFiWKUqSUCCNa9OloV
 +xtfxNJZEFOpWpvDkk+Fht15HyVhAUU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070074
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

On some platforms the DSP firmware does not support the fastrpc
capability/attribute query. The DSP side returns an error (err: -1)
while handling the request, so fastrpc_get_info_from_dsp() does not
return DSP_UNSUPPORTED_API but a generic error, and the "else if (err)"
branch in fastrpc_get_info_from_kernel() is taken.

cctx->valid_attributes is therefore never set and every open()/query
re-prints the same "dsp information is incorrect" line. This is not
tied to boot timing: it can be reproduced at any time by manually
starting adsprpcd. On RC builds with metadata flashing enabled several
clients come up and flood the console.

As this is an expected, platform-specific and non-fatal condition,
downgrade the message to dev_dbg. Similarly, the absence of reserved
DMA memory is a valid configuration and does not indicate an error,
so downgrade that message to dev_dbg as well. Also rate-limit the
"No session available" message with dev_err_ratelimited(): it reflects
a genuine failure (open() returns -EBUSY) so it should still be visible,
but must not flood dmesg when the session pool is exhausted.

No functional change intended.

Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
Patch [v1]: https://lore.kernel.org/all/20260514062825.50172-1-jianping.li@oss.qualcomm.com/

Changes in v2:
  - Add "misc: fastrpc:" subject prefix.
  - Reword commit message: drop "temporarily", describe the actual scenario
	and state the errno returned by the DSP.
  - Rate-limit "No session available" with dev_err_ratelimited().
---
 drivers/misc/fastrpc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index d4fac2caca86..1f9531a534b9 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1783,7 +1783,7 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 
 	fl->sctx = fastrpc_session_alloc(fl);
 	if (!fl->sctx) {
-		dev_err(&cctx->rpdev->dev, "No session available\n");
+		dev_err_ratelimited(&cctx->rpdev->dev, "No session available\n");
 		mutex_destroy(&fl->mutex);
 		kfree(fl);
 		fastrpc_channel_ctx_put(cctx);
@@ -1937,7 +1937,7 @@ static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
 		kfree(dsp_attributes);
 		return -EOPNOTSUPP;
 	} else if (err) {
-		dev_err(&cctx->rpdev->dev, "Error: dsp information is incorrect err: %d\n", err);
+		dev_dbg(&cctx->rpdev->dev, "Error: dsp information is incorrect err: %d\n", err);
 		kfree(dsp_attributes);
 		return err;
 	}
@@ -2559,7 +2559,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	}
 
 	if (of_reserved_mem_device_init_by_idx(rdev, rdev->of_node, 0))
-		dev_info(rdev, "no reserved DMA memory for FASTRPC\n");
+		dev_dbg(rdev, "no reserved DMA memory for FASTRPC\n");
 
 	vmcount = of_property_read_variable_u32_array(rdev->of_node,
 				"qcom,vmids", &vmids[0], 0, FASTRPC_MAX_VMIDS);
-- 
2.43.0

