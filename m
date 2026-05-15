Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398CDCD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 12:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9757A10F52E;
	Fri, 15 May 2026 12:42:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gqvvgGEv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dsl1abgY";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80EE910F51B
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 12:42:42 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FBUBK43219668
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 12:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qVx3dP68cn2
 vag91UBEub6zPiFFjytB60mI7WrNd8p0=; b=gqvvgGEvQH8OtqlE2V3ymt9iJJc
 QcAIX9x+IlqWg42sQJ6tIclOSrU51vVsc+hCH3kWOnAe7PWdW8A19jq0gvSGOyZx
 DnelgxEmGBvGyTMooy54xHhvvRMGCSmFLa1lPL9vkBOLL5F6ZH/UbAMpJd/gUhhV
 zYcf/GOzADOmBd2zoy1dkpNX6BP83OFn4IzVotOcRW+rcvuEsVeBQsyUcLcdZOuo
 tbYDjbf2Ht5shZD0APfni/c2MEnY+H8PhPIQKlo1yE+WtbWxGOMTvQn0PKpYt3Fj
 0Nd6WcT8Eq3HTW3BVfN/FaXkBA9jC7O68qznUiAcWzcJxFO0d9bHgqvajkA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1s38fk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 12:42:41 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3692f395339so2309479a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 05:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778848961; x=1779453761;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qVx3dP68cn2vag91UBEub6zPiFFjytB60mI7WrNd8p0=;
 b=Dsl1abgYwZt83khew9ZgIXoz/Cj8TAXkmKyVvuxZcc4A9+TrcYrrFMmB4+V0kuWA7n
 2BLcx6M4E/tWKo48XgO0MS5uq382ix5ZebIt5NcS4m2FFhs30U4MH/CAkMOVMXXFi8r7
 5XayVVGVzhv8kpT39eX3Xkfs6jSEbDBFqQHeVRwXAaq7hzpqlwnW4EGgn76a7blS60Dl
 wa1qIbwgK8J+jDmIUOBX1g5aJdFmQSxD6+CkM7xC6NDh/2eUigDVKys1PpPpWsBQubye
 wo4nBTIRmFbLKCv3Hgu7mLj3jmTunhQlognGAuwqdLQovGIqdvIvF4j4FogszEwv689J
 zT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778848961; x=1779453761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qVx3dP68cn2vag91UBEub6zPiFFjytB60mI7WrNd8p0=;
 b=U+KIiDJnuDEligarzf3iZupgKGCtFtdkg3rkW9SmzO6aQIHeGWDhIkttkxuN7dfmyL
 kOCj2/bIaydMvNb9YGiOD49vMe2HzgOBv8hO2yZBS4CZTfSfD/L3+BdQcT6viEz5D7FH
 WceWh91JEf2WCuxJTUJb/xmC4WoQ/ehZmt0RYJHZGRpOiFpUCxo3ioxl08ysry3EfyUD
 63AyKQhfMru52xaK2YF9LI5XcI44ZAhL8NgbMTTn300Bw9uxRGf0vCWsiQfdd4iABLNC
 XuSnU1rdv4zSuI12gcL0lF4G3bhC+19jf+BJjLS1mfnurvCb6sDl3E4pbw/dORENh/Mq
 ZByg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9F+qMrZc3fBCUkwOBm3ME8/WhIuvVeXj28K3TY8Lfy6+uR0tAsHKGXkqKvAha8XpE35HHBNUgJfOE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZqMK6oEOYwG735YjDSxfW9QjCVKmY4KORU8WxVU0P/Eue1GRQ
 jYBx1dN6I1LVAjDiNBmGAisFkMVbB7ow4g7LmTl0XwCakokSpHZaUv2pwHdXRslEkJATyyT4HRp
 TBkc+qFGyBbQ7lTpoDQcWX60+HtxrobdsE0OraC/DKNMpXFM+L2qLtVbdFjMcLThqjZ5yJj4=
X-Gm-Gg: Acq92OFhy8LFWwqyHCO/U2OYYaBdS9WJm0NMVDXVg6uMTn3UPJR0fXL18X208DL/BVH
 t2ATrIDVgfDQz5cByGXPVcvbw/3t97XaC+3XytKVXnzPYskDWvSG2Cg19K574gjtjFtJsBxA4kg
 mUy37XMbsiN057NjLiL+RkXhfbnb96mkcOa0l0YMUg+m3mqNAu8AmdpGnRca3DZFDJeZFvOHa0r
 gUt7DPjGm/0I+TF5t2jkx60w3I8RukCfAp7qgId8ipSYM8cITZfy/psYuxHUV6J76Eg4MUiPw1J
 MxgZfy/jeWpA1BuYb3w8wLJmo96nzUDkObMAdMIRxI5kC4X0dq1wFxwM5SB/SYhXAp7FYBU/hQQ
 J+zKiIkG6vYrMLRvUZ9TVPljZJ1aW9Ta2MP3UeYPjZAkVcQ3KSt2SbwnscgEaXh5BVwWBiIFrlq
 8uegE4yutEibCse+W6EkaJ0Cf/daiDoQ==
X-Received: by 2002:a17:90b:5790:b0:368:98c0:8836 with SMTP id
 98e67ed59e1d1-36951a667c3mr3720189a91.18.1778848960331; 
 Fri, 15 May 2026 05:42:40 -0700 (PDT)
X-Received: by 2002:a17:90b:5790:b0:368:98c0:8836 with SMTP id
 98e67ed59e1d1-36951a667c3mr3720158a91.18.1778848959811; 
 Fri, 15 May 2026 05:42:39 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c05f27csm56119395ad.25.2026.05.15.05.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 05:42:39 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez-ortiz@linaro.org
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 stable@kernel.org, Jianping Li <jianping.li@oss.qualcomm.com>
Subject: [PATCH v5 2/5] misc: fastrpc: Remove buffer from list prior to unmap
 operation
Date: Fri, 15 May 2026 20:42:14 +0800
Message-Id: <20260515124217.20723-3-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
References: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEyOSBTYWx0ZWRfX8SLFcouevitN
 mMxaYvgbCVGNLsdpt0RX8g+ngrOiPN1NvuSzJKak+44TY7duE7ZWyIBMYkW/vtO5fBnIEfSesSA
 IBW629d52oa40KhnTMjL/OZsSHT4tatytrmsw2vNe+mVzyfXy6cDkAXYX6dotcfhQdnczp2k873
 ZST42oBANKOoaDcXmxOZO2Wdrrm8MrUg/tc/2XMMA0mJQY2AcsrBKLvwMYuPhiUjWiutieZiNt9
 EDM6UVuXwCtTh+XeQznfDCvGH/8iujqhCT4jnppBqVkhP5SVbMuJ17f1G4BMbmnc4vgWFdYms9o
 5CyBl1w/yjIFd04JrCpygYn2vtYiq1BMFWsL/2Hz1GKk108GuFCCerxa7LQEi5FHGpC88WWUfEw
 LMnuu0nTPjJpCLSNLHAI/bubB/h1lRgbTLohspaf+uaghUmTFDKcQAlpLZq+3SxTEVcTkEME+RW
 Bb3/1STtGF5wOzEjRPQ==
X-Proofpoint-GUID: WqGRkBNqc4HSmzr7CWHwlNicmou_9Grf
X-Proofpoint-ORIG-GUID: WqGRkBNqc4HSmzr7CWHwlNicmou_9Grf
X-Authority-Analysis: v=2.4 cv=HJ7z0Itv c=1 sm=1 tr=0 ts=6a0714c1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=ZnmZ8TzD_GdZzTgawW0A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150129
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
create potential race conditions if any other thread removes the entry
from list while unmap operation is ongoing. Remove the entry before
calling unmap operation.

Fixes: 2419e55e532de ("misc: fastrpc: add mmap/unmap support")
Cc: stable@kernel.org
Co-developed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 8b21f85cd9f4..3c7c3b410d7d 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1863,9 +1863,6 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *
 				      &args[0]);
 	if (!err) {
 		dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf->raddr);
-		spin_lock(&fl->lock);
-		list_del(&buf->node);
-		spin_unlock(&fl->lock);
 		fastrpc_buf_free(buf);
 	} else {
 		dev_err(dev, "unmmap\tpt 0x%09lx ERROR\n", buf->raddr);
@@ -1879,6 +1876,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	struct fastrpc_buf *buf = NULL, *iter, *b;
 	struct fastrpc_req_munmap req;
 	struct device *dev = fl->sctx->dev;
+	int err;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -1886,6 +1884,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	spin_lock(&fl->lock);
 	list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
 		if ((iter->raddr == req.vaddrout) && (iter->size == req.size)) {
+			list_del(&iter->node);
 			buf = iter;
 			break;
 		}
@@ -1898,7 +1897,14 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
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
@@ -1989,14 +1995,17 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 
 	if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
 		err = -EFAULT;
-		goto err_assign;
+		goto err_copy;
 	}
 
 	dev_dbg(dev, "mmap\t\tpt 0x%09lx OK [len 0x%08llx]\n",
 		buf->raddr, buf->size);
 
 	return 0;
-
+err_copy:
+	spin_lock(&fl->lock);
+	list_del(&buf->node);
+	spin_unlock(&fl->lock);
 err_assign:
 	fastrpc_req_munmap_impl(fl, buf);
 
-- 
2.43.0

