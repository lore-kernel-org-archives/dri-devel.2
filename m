Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C19CD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 07:18:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 016EF10EC8B;
	Tue,  2 Jun 2026 07:18:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BuP1B37t";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bpp2eWQj";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94DC610EC8B
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 07:18:10 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65245l6M2692219
 for <dri-devel@lists.freedesktop.org>; Tue, 2 Jun 2026 07:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=h2rbBUksZJT
 YcjdAJliGesa3QsJPl7wEGaGM4JyELQc=; b=BuP1B37tHS7VbrwU9/VUo/TUYKT
 oAul/jxN2jFUzdSURUIKGp7AdxAaCZlWpjYlpJ4nY8mjli7ovWe777Ehxp54ElP8
 pQlvNLGlKDYZpQrWAaXFI5qYGvb7wNBelhJaoAlG6G/Yk/KL/KvLXU0NP0MUcEGD
 IPxURgaiTerzEemUfalIlgl/BHdWzbmeIb8w1/mSlEDVx1RpnUjhpsWWIXht5ine
 G6V5TC5aovy90kPxlOpL2VkcVqNRtA+2DhU62KSAdKfy+6J11D/885T5vM4qOzt6
 EETyxofzjM69kl3Xn3hEcWihbLSVS/oe1Q5TwkmJ5Vfp40SDZXpaK1NaQnA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehqumgq08-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 07:18:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-36d98b5a68fso4279782a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 00:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780384689; x=1780989489;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h2rbBUksZJTYcjdAJliGesa3QsJPl7wEGaGM4JyELQc=;
 b=bpp2eWQjK9/F0HTsB3fRuLlRi1JIZmlTGrnZSBpmAGj2rRsew0dBwfAUvYuxUrpI33
 OSiaClJUMdVZgI1wvsrEYCkxhNLDzEeqap5gs3iOwG9L0kWupFZl/D22lf1Ukd3Vj2Ny
 /Tp8HmLc93hSjka0Kbn6eB/J9xO5iD5RvJd3INGfw3llSXaotLznr6K1JJgzSZrhqTCL
 nd9ckK9PBho3uo/515eLGimBQfuCwuUi8tEuZkOyN7p+Cm+4DwidwDrL4mar/E8P0nQA
 T5xzaZDBYn+6opJM1fz7mu2x4y/UgCWU8OxVzOV6pFtJdG7qItqXU6QRH+vCT7r4e+2C
 Db9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780384689; x=1780989489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h2rbBUksZJTYcjdAJliGesa3QsJPl7wEGaGM4JyELQc=;
 b=HslMXQL121YyBJ0CnA9sVMtueT/Wb8dG2y1XjuU26y/NGcJ+iW/dpDZRNz1WAGtVsZ
 oZoTOPTzzuI4VGfHMpR9NfNjqaZ7DnVnQtu7mEkCHTBYunJr/YeXNbd7fPi6sRhm+eTc
 QujIb5qvEeJfRQqbd8PF1pQe5nXTqZllEvZRee382gOiSX5pNB2hNS2g1SCCzTnmDHH1
 uEP1mrqK4jiQl7lCxRjm35UZyZtFKlz/uC+z/BtWbEZZacdT5ttt87JA35Jaqq5PayKe
 5w8Dwl6S2VvXPDdGflje3KMvNuO6pi8m2xIPdjDKrN4hC6uTiPCVmpo1LQ9zK/vrxsUF
 5mYw==
X-Forwarded-Encrypted: i=1;
 AFNElJ//OcS5cEcr4+GNmg2Pv6/Mxcmvsi7c4PLwsU1uBM1UsdmykmKaEG7WPtrk96AUg+AotGg6vF5K35A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwML/qBmzjFrpivY2+pQHfYg9y+OTX/wMpVapmudv8DE2/niJaP
 iaBMq5EodY1pH+1CZZI0eIHyIq3xX5O4YEL/WF3Wevzb/GtTqHqIgln/bV3vJXpiORtOqk+4B2b
 +ZRwokMqQ/n3hrzfn7aNTZNZkYFeQ4ggfgjzRFJC7E/a+eYQgW5YcKOf9obgicLuHUSmFgVo=
X-Gm-Gg: Acq92OFQxQVQhuYHesmhpC9Dw9+ATd8uhbsJBXuHW6h65X5Yc1lb7yV1OjJqmTN2iGV
 wTSgaNpOiGX3XIchPJMzgu+HGUXi80UQc7p8Ov5Ud1qblAqhdlb7LsGqutEV8UVegcN0RqdV1MX
 YUW+AIUDwUxMea5DU8dIffWWHG4iMnXY37bRvfMqcdzPk6Z1BqirV30Cnn86WdVpARCtHz/yDCn
 io21ess5Es0m6etUI/0atVISBbf93mf/+/dIdz6DmfciCZ8WEjqiToJqgwf9nEOaWTjQgH/Zzlm
 4bRxNfspOsKSSEfoLbHrm3AGNR/tGU8PTvzfEO7zOxlVDBgs8m/SZNWRBxjSa5iXd3NSmLEkVCb
 h3h1v3itcYKeaWcHlwyUNSDncDh+AcUtaaPBemYf/GSRCC/73CJiQ5kt0XiNNyibI9S0UeHgjIg
 hdTUj5d0rPIkIcWniVSF7BAixjhp8c9w==
X-Received: by 2002:a17:90b:5184:b0:36b:8824:d7cc with SMTP id
 98e67ed59e1d1-36c501efef2mr13151235a91.20.1780384689412; 
 Tue, 02 Jun 2026 00:18:09 -0700 (PDT)
X-Received: by 2002:a17:90b:5184:b0:36b:8824:d7cc with SMTP id
 98e67ed59e1d1-36c501efef2mr13151203a91.20.1780384688932; 
 Tue, 02 Jun 2026 00:18:08 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36dd91c9991sm1766279a91.7.2026.06.02.00.18.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 00:18:08 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez@oss.qualcomm.com
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 stable@kernel.org, Jianping Li <jianping.li@oss.qualcomm.com>
Subject: [PATCH v7 2/5] misc: fastrpc: Remove buffer from list prior to unmap
 operation
Date: Tue,  2 Jun 2026 15:17:47 +0800
Message-Id: <20260602071750.526-3-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602071750.526-1-jianping.li@oss.qualcomm.com>
References: <20260602071750.526-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA2NiBTYWx0ZWRfX1LZHyJgFskKt
 psVCahDpuM8WWFHhCuGlhwnn4eLclAbhzP3djBFMbELysBgK/x80HqIDRYIGkOzsiDfTg6lbdlC
 EmfvGGOans5zRh1olNkSPB8jk3zvHfns+YA5PBTZu1HuPN9e/4F7nSOakIDIAlGhyOiiFwjyYCB
 BMDFGjgUfa50ZNAntN9EB47e3YFK/iycCx+pI4GhRgaeNmxaBIuSwq1Vo6sApWzXinFPYevQq4X
 RqvPQPQm5NUYKPOQIt4JVBJ0Mw3oDSgSKH7T0NScZ9KGk0nD7M6kkNi8wk2kZ51aXqdgRHgNLmA
 Ayp4bKqP/jEsb7N+4+mZ7/snwDss4OTNVLGu+I90ch919RxzB+8jwj2/ADJSR8quSuCIeYxv99c
 UH7R4GmMuEVGsinAX76+Niw+gemXT56oAm0n+dGQhS7/UczB6khpR2L+rJTszl/x4SfJebBcNww
 wiGOHLTH6Xc8PpD/95A==
X-Proofpoint-ORIG-GUID: xBjBV5-OsDp-2SIrkQwsFARn8mAC8ypr
X-Proofpoint-GUID: xBjBV5-OsDp-2SIrkQwsFARn8mAC8ypr
X-Authority-Analysis: v=2.4 cv=Rrv16imK c=1 sm=1 tr=0 ts=6a1e83b2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=8ZZxLbFAX5vHFMKIXQAA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020066
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

From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

fastrpc_req_munmap_impl() is called to unmap any buffer. The buffer is
getting removed from the list after it is unmapped from DSP. This can
create potential race conditions if multiple threads invoke unmap
concurrently, where one thread may remove the entry from the list while
another thread's unmap operation is still ongoing.

Fix this by removing the buffer entry from the list before calling the
unmap operation. If the unmap fails, the entry is re-added to the list
so that userspace can retry the unmap, or alternatively, the buffer
will be cleaned up during device release when the DSP process is torn
down and all DSP-side mappings are freed along with remaining buffers
in the list.

Fixes: 2419e55e532de ("misc: fastrpc: add mmap/unmap support")
Cc: stable@kernel.org
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 80a636962357..a8a58f889d07 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1892,9 +1892,6 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *
 				      &args[0]);
 	if (!err) {
 		dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf->raddr);
-		spin_lock(&fl->lock);
-		list_del(&buf->node);
-		spin_unlock(&fl->lock);
 		fastrpc_buf_free(buf);
 	} else {
 		dev_err(dev, "unmmap\tpt 0x%09lx ERROR\n", buf->raddr);
@@ -1908,6 +1905,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	struct fastrpc_buf *buf = NULL, *iter, *b;
 	struct fastrpc_req_munmap req;
 	struct device *dev = fl->sctx->dev;
+	int err;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -1915,6 +1913,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	spin_lock(&fl->lock);
 	list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
 		if ((iter->raddr == req.vaddrout) && (iter->size == req.size)) {
+			list_del(&iter->node);
 			buf = iter;
 			break;
 		}
@@ -1927,7 +1926,14 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 		return -EINVAL;
 	}
 
-	return fastrpc_req_munmap_impl(fl, buf);
+	err = fastrpc_req_munmap_impl(fl, buf);
+	if (err) {
+		spin_lock(&fl->lock);
+		list_add_tail(&buf->node, &fl->mmaps);
+		spin_unlock(&fl->lock);
+	}
+
+	return err;
 }
 
 static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
-- 
2.43.0

