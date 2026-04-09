Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9A2E98FCD
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 06:26:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C06AD10E722;
	Thu,  9 Apr 2026 06:26:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="awwcLrJt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iyYV3Cd9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB20A10E721
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 06:26:35 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63958KTO3712896
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 06:26:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=pX4/CzTEsQ9
 azlafCB2t1IsspVCg3AMoDjZdlkJJoE4=; b=awwcLrJtHXQ5tfoHcotTtyGJOSD
 0MeLxKwccPj+SJ06MoxJ8ZK1K938h61GWnCehkSek+qUwHMrc6phwRSg7wEc89L8
 mFNeo3JSVqk5E/QxBjHFcKkNTnPj/AoLKpHEKZFPy5l8WgPsB4Rifo1ixZ75X7P2
 2U0I11c81EkV3DuHbAPN62L5WhlbG/hD8Vs5+H81h5g8BMyANOKG1T71AbgohLbb
 u7PUi/TrP1uIMzAszl4Pn7OxSfehD7xCvyd5xLpBi+MyFuLFb9XfbUWZxOPH8s5V
 VHO+9B7eyRg/tY943OGRzHz1X1F6atcUbHKGTymz8LSx9TeAweoQuctj7bg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddt74anjc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 06:26:35 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b0f4e632caso11277585ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 23:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775715995; x=1776320795;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pX4/CzTEsQ9azlafCB2t1IsspVCg3AMoDjZdlkJJoE4=;
 b=iyYV3Cd974lxeoI6IAwy8sBt9Uj8qvlV8jDQtxRnbUUXc4KM3eD9E/BRGxy1/iSlHR
 BaCNXn3PZSGoGo08wW3ZhEqxtPOPrL8bG7kjTgujDG+mKmv8HO+vUBpf4xmg8rxSjIgZ
 ENA1ejFCHrYXhJZVe7iwLJ8c48+31FwcwJNmlHhQ3fTf0utOceRx00xANBEEXmj5ZV5s
 9n8auIVFuxlNhfCDda5n3Rmoiy4LiCs5/AyyPsAT9scaw7+5j9Ki3I3rOlHIvlekmB+n
 YxWFnjbdLHFnyQq5t9Sfgz4wuzoWf2b0Au4fig5ceCOakHWZmpB3ozsbxc/+XcCox3rF
 v0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775715995; x=1776320795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pX4/CzTEsQ9azlafCB2t1IsspVCg3AMoDjZdlkJJoE4=;
 b=Ad7VdwKAKLwJ3lAHaZtS4fm+y7FlDTTs5MCmxiWyW9xLDu9wtYc8HZKDNSZva4LBJx
 4TwjN2XbYyWSqgPdG/ugWaJ84I4+dj0xaXTG0Ijoidt3MiUK/SPmRKUkgWwUBrH0rJxY
 QvNYtnvmbsDfS93DsD1lJZLRHUvBrt/H52PlWOdgmk2T997FPrcrWdxRqVrPCeUI5w9k
 9H3fnABSggiIYLyw8+2DFq0328bhuLAOPpsKwdVOO5Fk6fVPqcI8M/GqQlldMGIMUbSZ
 16luZ6/Vug9hhIP+W8XzTvuM6WKa6K4L7R9mI6od6LhsDwAI3fG/PNbjHSnRJCIl84Kl
 3fmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZwDHsCJKI7QpvNkytwtseGfSBQZzanq181se3PL8vp9MgAN5Op1CFRimPdWuCrkK2prkDzmpxyh8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YymYVVQ6K/2OOTQGHoxlfDQ2a76sEXbKlk5li/sLeddEFaquY0r
 fTnkW2Ow+jQDNrn6SlL2m5n8z2X30H8y2z0WxeyS6mBxErwxdgoTm6FqGsVXP72y9yTLzFMgzQb
 T7jahORuviYL/NK/7Vukxxrs4Qs6rpaULY38ogbvSai6O6iBwFPi/Id81LjWJcZ3m16qQOdo=
X-Gm-Gg: AeBDiet1BU+41sYMPvoAijmT9BXZitbG3ZD215dnwZUEC5/xoder0U9b92zzxrEMKv+
 JPD18koRqC6vrAuiZzWUD88dBkkTps916Z62HTv+wSR84M5SmwZCzPBHSvlToxloj3ZXvjw6GuS
 0wtI3NoE2XPccapWh9Sf2QhyL5Zp8inv4pGd5XUbHUNhG8oTJlzDLP2TkqGy57wr0L65cBA1uHy
 VvgWhGn5js7Y6mt/2+earMC64SxIJzm+w5QH/GZ9ckuzADCKQlkgV4hI+moyLgqS6EJfIy4xRgj
 K7gz8Vj9Z7sj0bcmUIAU1kLB09jGg82tTlmO76La0xkH2k8OsRQ9cYSy8sy9XkdMaQTF96EaE8R
 K+zlNadGf5vZtO0H16vDsa79mTf4hdsS575DRH9VK96Vpw69U83xpKAMJ6n2AY4khZCEpTtLINa
 Pbf7D7OSxGH+smkE/gyg==
X-Received: by 2002:a17:902:da83:b0:2ae:5163:c2aa with SMTP id
 d9443c01a7336-2b2817add40mr242580435ad.20.1775715994550; 
 Wed, 08 Apr 2026 23:26:34 -0700 (PDT)
X-Received: by 2002:a17:902:da83:b0:2ae:5163:c2aa with SMTP id
 d9443c01a7336-2b2817add40mr242580075ad.20.1775715994073; 
 Wed, 08 Apr 2026 23:26:34 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749cbd4dsm220786795ad.76.2026.04.08.23.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 23:26:33 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abelvesa@kernel.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, ekansh.gupta@oss.qualcomm.com,
 quic_chennak@quicinc.com, stable@kernel.org,
 Jianping Li <jianping.li@oss.qualcomm.com>
Subject: [PATCH v4 2/4] misc: fastrpc: Remove buffer from list prior to unmap
 operation
Date: Thu,  9 Apr 2026 14:26:15 +0800
Message-Id: <20260409062617.1182-3-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260409062617.1182-1-jianping.li@oss.qualcomm.com>
References: <20260409062617.1182-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TL51jVla c=1 sm=1 tr=0 ts=69d7469b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=ZnmZ8TzD_GdZzTgawW0A:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: cXNm2KCrwUSd-nYWh5N05EKzT1YO_TxB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA1NSBTYWx0ZWRfX/25oNRFbmQkQ
 CpcIjgnhgK1NiSdjjAhlWTOEZzhY0PfI2BATcE0iHMmtjZGYwdEn56zOuZGuIcvvmkWFhB45FWX
 CVifewmZYkeK/DoNx7kpLFE6LijAX1drvkospz75HQCEFLT30ovoYXvJDj0mbB/7eO0+CxfSRN1
 7C/Cnxf4pYH8WnWPKgeYncCguEvC8T6pFcfhyDjpkYh4m+WcXExlvbLDWq8TpLTp2nfMMCUHsx6
 JKWHW3/Qq/DkpxyuZbgzvfpCzSsYDA9+XHfs1Itr9E+6eJ9g8N6YQOkPJ+P3fUx+H1qiAxKDh2H
 RUwF06lAZUoIBwY2ZSoBbv/8QTEmWSAhzCA0J3CHNM1FP/PBA5J+VbkY4bLNhjaT9K7lcbE+p9v
 /d88H3rgLK/sCmmIyyrbT5drbSYPQy6DWpUZOEFboNiARCW7WkRBbyzhQ6VUQy0TTuB74UXX2jU
 b5mAnAGlVbPUdvnCuXw==
X-Proofpoint-GUID: cXNm2KCrwUSd-nYWh5N05EKzT1YO_TxB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_01,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 adultscore=0
 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090055
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
index b87a5f97c96f..148085c3b61a 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1862,9 +1862,6 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *
 				      &args[0]);
 	if (!err) {
 		dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf->raddr);
-		spin_lock(&fl->lock);
-		list_del(&buf->node);
-		spin_unlock(&fl->lock);
 		fastrpc_buf_free(buf);
 	} else {
 		dev_err(dev, "unmmap\tpt 0x%09lx ERROR\n", buf->raddr);
@@ -1878,6 +1875,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	struct fastrpc_buf *buf = NULL, *iter, *b;
 	struct fastrpc_req_munmap req;
 	struct device *dev = fl->sctx->dev;
+	int err;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -1885,6 +1883,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	spin_lock(&fl->lock);
 	list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
 		if ((iter->raddr == req.vaddrout) && (iter->size == req.size)) {
+			list_del(&iter->node);
 			buf = iter;
 			break;
 		}
@@ -1897,7 +1896,14 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
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
@@ -1988,14 +1994,17 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 
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

