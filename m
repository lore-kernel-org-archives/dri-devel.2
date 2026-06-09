Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0F9CD6E79
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 03:00:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5F5510E05D;
	Tue,  9 Jun 2026 03:00:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QT6cHTm9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e+lKjVii";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A6F510E05D
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 02:59:59 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6590s0JE1092092
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 02:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ElYvFMoGdW9
 Bjq7mp/Mwc7VFbd+iwp1MQ9hRnfKtsl0=; b=QT6cHTm9kd3vTgLWiwXDjrQp42F
 vSktu05K//kW+kT1GQCCh2KF68IvTIaBW/boH+OYex8ZDklrq7be68h2kRVZAryw
 8uKlYYZVneuNsgAWTTwW/5VdEyVUlChbosaPTY+SJOQqYX3A+NQAq19z4tJ8xrWk
 5W+AeN/0tOI8rFqzWDwS4XyT6dpjfkAbxqY1Jt1ywSJo6fmQjKaPfE+frkxRJl+q
 PZ2aTgYrQMSXVLvy1nZw84HI334Mi4LPHv1An6rbNBg8sCsdl64D+3bbna1dX5fe
 aYKpDryfpYyJCKGSviwSrXP0tT6iSYfpq6r4KR3DjnuRiyD0jCt+Vg1I+Qw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun8m3dx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 02:59:58 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-36b7f696b40so2999528a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 19:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780973997; x=1781578797;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ElYvFMoGdW9Bjq7mp/Mwc7VFbd+iwp1MQ9hRnfKtsl0=;
 b=e+lKjViie9AXE02M/tPi3wBBaI3zUIvVbY2PQDK2qRGHOTFTjwR6QUzGUe7mG2Uxo8
 OgcWt2vI9Mz9xL+hr9wEvRgnMCebRzaapYznTZnHlL6Oazy1Ak8WoMG/kRRWqteRXinf
 fNPvN2m85AhnnnOJG8EHtFRBcViuhyjpuU+jXJPLytey+5qHSxSp80DLBNBZfE03MSEA
 ZyA4MUqnT2RDLSKhKGlyn9XDl8tuH1nqXbuk3zn6Tsx6tBdvC95+8xCO9DMNE0Z9rzeR
 JLHxDzHgzcrVU4ZJjmUtxlyWy+q44pDOqhSDyHa2WIMC72pkpbEXb70xUK6j4JiE4mAN
 cBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780973997; x=1781578797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ElYvFMoGdW9Bjq7mp/Mwc7VFbd+iwp1MQ9hRnfKtsl0=;
 b=aL/FpljgIes4iIKJcQDiIJHnEiGxXttmWQDyVvSVZlCHFBfUNaHcmvkaEbTOL4bboU
 QZtiTjY1Q8el4RN7MBR1ewAWCXJbbeYt+FL96cQKVODxlD2HHSOOyLIMpjIh8VA2R/4x
 hw55V+9q8vYyv/npW2ChiJO6rkOnK89+q3LFKiNxeUxlMCtmwQFC/3ojjzFEVaWTe8LG
 ObUntOvk9K0VwyomSvsASBgQ3uPiCoGsE4ScAVQ2hNjkBmQpa+D2UkYMAMkIEGd/7Sam
 K58v7m519ckmhwtMFiBHyfF2cx1JuzXToGFjAWMu4KjO8fly1WTWfV5lCX0ETW4hv7Dx
 U9vw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/fCIyWvtypbhRgUcCXLlheCtLQ91tzsqTkNng8lkZxghcyaAP4aUMKz4dWZo7RRbo1cG6KEKr4fVM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDFExjNOtaIeKvzOiG2vWtjuQrVxpW4GDzXesTobSy9Ma4zuig
 ULSKkY0VBZGod8oZ2VaAO8kbSKuDIAlffNeGvA/s83jSp4TOx5IuvjPaY7bblmMfwae3LcRxotu
 jrxM440bJx9hCGjR4aqfSUWP/TmMWHMBlOgsyq4Ovls27MB7dmPo/rbaXd3ym+YiejV1AE9A=
X-Gm-Gg: Acq92OFZFUWtNpcbS102rPFLtNZYYOoBJPxycSL6drEGQzRlXMOMXprpK065CIpKxXR
 orWWOPRD9eUqLqqaiIys1Axmorf2OW2M5b3JU+MZ2oY3A4KnStLIzo5v2ik8lGJs1nxIIF8849M
 xVXA7RSN1YHt6V4RYLjR2sJJkKvMvnNqGgUDOU0Z2wdkPHxNP7nG+9xUWmzN2FoWX6PiSalxH6K
 qFMruq4tRVIJnuXlmD44Ll7zey6OkVPrwk69dJtKi0YTPYiKHZIyHyY086V6z9u0Q8whus6z+yz
 un91XgenNj8/P4t0JKaUFh2cJzVFMcjsqIHu58qtXB+XzVN8gW75dYCT5gDwC6FDIR8b4Mvy23f
 4k9xKzUu14VfDy0l4Ebwm7a3F530aHZ9fumWGULWg7yHSunpiCpn13C83jMjFTynGr06Sqj0Uvu
 q6/ImMN0tNq1cjjxYy7Vz+Tx3akTT7
X-Received: by 2002:a17:90b:390e:b0:36b:9835:cf96 with SMTP id
 98e67ed59e1d1-370ee643691mr18535151a91.2.1780973997386; 
 Mon, 08 Jun 2026 19:59:57 -0700 (PDT)
X-Received: by 2002:a17:90b:390e:b0:36b:9835:cf96 with SMTP id
 98e67ed59e1d1-370ee643691mr18535114a91.2.1780973996941; 
 Mon, 08 Jun 2026 19:59:56 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3712fcb2607sm8713835a91.0.2026.06.08.19.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 19:59:56 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abelvesa@kernel.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jianping Li <jianping.li@oss.qualcomm.com>
Subject: [PATCH v8 2/4] misc: fastrpc: Remove buffer from list prior to unmap
 operation
Date: Tue,  9 Jun 2026 10:59:36 +0800
Message-Id: <20260609025938.457-3-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609025938.457-1-jianping.li@oss.qualcomm.com>
References: <20260609025938.457-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDAyNSBTYWx0ZWRfX4TnN3/yXXN0c
 tzJCBnEKg3mm0yFndeDwcmFzoLXAQYCuOmrM2LoSm2KRalwMp9JZ3AggPhaWzirJ3pRG9ynZ3Mj
 CSKiCtYmUTzju3PUbHk1DzvlURhyfiuSGChBugJD7vttgu5r3VSMHS8Y8pp+9HsDRm3xWlVqs7g
 fOqVNp3UuJqRpoahSNpzAULmMugVI/GnFkLbBqkR8WI7Rqhu9MuC/wRpN88z95tL4md4TXuy79O
 Gnv7cPTQ6uI/uOxSnibFFk+QdfrTCen0otLZBClaFTTCFoaFa0FkqQGivLOlIYouZvvIWGzCXwZ
 ru2lVbepTSCmCbgRGrUfJROFdspWQ1I7+VVt66+deoiz6w1RcqD5kvN+o3KacvKgTWTpMXxaAlk
 4CjS2LDZx2IiMvUD1qPzok3Tjm5fYLWwq/WqJxUh6q8IPBGskOC/kNultlaAOUZ3+a5HiNQOcdJ
 QXxCJWlXIqN+705KPjA==
X-Proofpoint-ORIG-GUID: 3SMKRH-9Am52cQSzSsZzP2T1T5e0Axdk
X-Proofpoint-GUID: 3SMKRH-9Am52cQSzSsZzP2T1T5e0Axdk
X-Authority-Analysis: v=2.4 cv=Z7rc2nRA c=1 sm=1 tr=0 ts=6a2781ae cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=8ZZxLbFAX5vHFMKIXQAA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_06,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090025
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 96961217b856..517884000331 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1889,9 +1889,6 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *
 				      &args[0]);
 	if (!err) {
 		dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf->raddr);
-		spin_lock(&fl->lock);
-		list_del(&buf->node);
-		spin_unlock(&fl->lock);
 		fastrpc_buf_free(buf);
 	} else {
 		dev_err(dev, "unmmap\tpt 0x%09lx ERROR\n", buf->raddr);
@@ -1905,6 +1902,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	struct fastrpc_buf *buf = NULL, *iter, *b;
 	struct fastrpc_req_munmap req;
 	struct device *dev = fl->sctx->dev;
+	int err;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -1912,6 +1910,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	spin_lock(&fl->lock);
 	list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
 		if ((iter->raddr == req.vaddrout) && (iter->size == req.size)) {
+			list_del(&iter->node);
 			buf = iter;
 			break;
 		}
@@ -1924,7 +1923,14 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
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

