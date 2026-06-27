Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1A7C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 20:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6026410E512;
	Sat, 27 Jun 2026 20:44:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YNJPnS2W";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ByzayYD9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 675C610E512
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 20:44:05 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65RHoNjl1718742
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 20:44:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=69xZc20ACjd
 oVCorIZnjNLqjOBLwOLcyGFalXsZvV0M=; b=YNJPnS2Wg15zqO/of3kGJHhq5AI
 S4pZzj1wIuCcJztsuUf1jUzFXEIE5Sq7Ek7eWJU5rvBuRPwb4XaP+roe+A0+i+fE
 h3ylNoJp3VEL0PTspLxM4C1P4tiQyozfLrRnlWdq7De4P0YcG0cJ4CN0qRA4A1Ql
 EcdwrsFGTKkdqW0PMcsp73D3v91gAfegVlPGMDmS/+iefBuJiKL0P2bW1OoklnYr
 wOQWUqs22yqurjH8zre3LdU5Pk/YixNj0bvMtdoaXPSjQZBBoa0h8howK/RJyNCy
 3Vniul0cAJsvehMlPr0VAHT33M6hwKCaOaIvtCiDBBfFXvs3uQ+GoTBNK8A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27081nvh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 20:44:04 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0d568830so9408242eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782593044; x=1783197844;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=69xZc20ACjdoVCorIZnjNLqjOBLwOLcyGFalXsZvV0M=;
 b=ByzayYD9+q80ae08obhT8UCuUJU/gtEK9IgRlz63C27yrbJSwjEUSzNUYxPdy4OGYD
 QgM7I6wAyU4vf0DPIEX4+2vk0NeR2tChFBzkzKMzMY8YCKPQyBqCDWk+2aD0yBYeHYz5
 wonH2DNzhZvrq4r5ycBpoR+1L9Wh5X4YjqghbUQ1iYjlwfwdst1F7iOsbMnc9VkB/a+E
 bCfI7VIEWRXMHciWXaCGUJ8rzORV1UrW5EzkxOJyCbrPefmstkL6yejnNulbUZZp6JG5
 lQGb6Avb3z7SpAw5N1cAo6P/UgFaf8Y7hZd6LtH6DbmgRgL+7JRIgm6er/Jas8R8EXRt
 79LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782593044; x=1783197844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=69xZc20ACjdoVCorIZnjNLqjOBLwOLcyGFalXsZvV0M=;
 b=X7Hlhsb5lWrofyaT77WaQI9eyvJyDiHbQs/m8cYlb96NdvROiN1pnU+RizdH1B+aHQ
 +DxikWiHjBzgV0VbH1ZMNC0yVMhkpIM8o+zKI3oL0VUKA17WMQHbSfdWH1wHzcZAYilN
 vq3d14fRdWF4AJ7sydRSb6TDz+HMWNEZox4HGr4QWdgtHF9xUR/6WXMSihB/o1JgDObk
 nv781CG9OYco8Vy+BxHuB+Vtm065UQaR7cwKf2OrJ4gzXFab+yaTWgtoqgfv7HnOmrmi
 ddQ/2YuG/DcozRmnQVSoqdw7LVtUI6iCFPXnLKiSZfrofQoQA0wEX7c7a29IAkXSZVUP
 clfA==
X-Gm-Message-State: AOJu0YwC4v6L1ZBoEWYAtx58tOSGjLfvX0LRWqQMxCBnUlOGPNwqU8q9
 zpX+75rBT7ia32++rlUjkUtswMD+9ufayKFZjou8CjUJnPja5D5nfGOhcihu7hgjqn0etXrdTlq
 Tc1qjuUz2eE4yKpxvtLUCnyuDb1G1ubweb6jTdCfGd55WR08+uqzveA1oyd/+wK8vSoEH3NeKHg
 LuHT4=
X-Gm-Gg: AfdE7clFX+VfDw0VKOOuXhPUTn3H5xbmxyNq5YuLM8tj4moqBD14o95DbrSGwprYREY
 BhZneWA4OtR8fRgI2nmkme/UFmHZ97e7Jj8Fh2FoqOdmZOjOyv4ASrTcm1PUynrnwpGQtrjC1JC
 +LT9/4thOCQkUzJjwf6ZFeq71DdThU4lbVsJEiZ3PtciZswwDecwrlyssNYCjPxsB+e0TOhyr89
 75CHOUlLJ80Be31gvgearrN+1/NdCQbf5zAgBPz6gLrCxHEXFqX4r71zYhqgMgoaaSUzFHAXPjE
 uSS1vJQN6dTTyn8RYIz46EKHz+6K1Zrl2liF50i12gjpMGxifuBZuj8/4EA0HwKrYb+0AN9eqAi
 5yvU6cGjBr7n7VOf77pZ9J+7FRN35jTo+Xj7b
X-Received: by 2002:a05:7300:8b15:b0:304:e72a:d4d9 with SMTP id
 5a478bee46e88-30c84d0d612mr11758192eec.19.1782593044238; 
 Sat, 27 Jun 2026 13:44:04 -0700 (PDT)
X-Received: by 2002:a05:7300:8b15:b0:304:e72a:d4d9 with SMTP id
 5a478bee46e88-30c84d0d612mr11758178eec.19.1782593043693; 
 Sat, 27 Jun 2026 13:44:03 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ca5f14f8asm16882963eec.6.2026.06.27.13.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 13:44:03 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, boss@oss.qualcomm.com,
 qc-display-maintainer@oss.qualcomm.com
Subject: [PATCH 1/5] drm/bridge: lt9611c: fallback to cached HPD status on
 read failure
Date: Sun, 28 Jun 2026 02:13:53 +0530
Message-Id: <20260627204357.3336040-2-mohit.dsor@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260627204357.3336040-1-mohit.dsor@oss.qualcomm.com>
References: <20260627204357.3336040-1-mohit.dsor@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ObKoyBTY c=1 sm=1 tr=0 ts=6a403614 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=pIV2PmIDnMgX7T2c1DwA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI3MDE4MyBTYWx0ZWRfX5L9g34dGc4kE
 1O9DqJQEcgcDq0AYfYAQWb8GzqzDlXBbWt62OjJRbKPp5aRZs4ez10DTJsbz6YS3BCWF2yZtSwd
 xCBqTjeW4MnIRnjkw6d3Ej1uMS4YtWN6YKktWAZOH5tT/dKizZUVqkDL0VlEoRIrDtnqdBh/2Y5
 VOalhXC8m0HWDRs8k3s0DAzHAkRtKU+9l1w+Q6Orq9WppgSEvYS0siJj9QMyCbsAhNwAFvskanj
 uG2f5IOVUUF9CDGoG5rKYvy8aO3cl+jSeW3SWMQ2/MtUVnngApecCI5qVw+lut8DVutmwNVRs47
 ZpDUkjuJO0YxyTuCRnwvuxJs81w4gDuRRDihcBbjig88bbo3GNpcS+i49LZsqIXnOcKGJzk7y1Q
 ObYMMlvP/OhECVJ9UtpYoLHNy9v7yIGCIIue9ox7CwZxRQeC04iGwvZFBP0jZhWPqqaRb8Qbp6O
 Qo4t3Uu7sE5OD6WUvFw==
X-Proofpoint-ORIG-GUID: zLX9mwIMkePjJosPdt9I1iBcQCLq1USO
X-Proofpoint-GUID: zLX9mwIMkePjJosPdt9I1iBcQCLq1USO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI3MDE4MyBTYWx0ZWRfX9xr4SWvW8Ud9
 SPZy2ozq6eNOb6ePEt6w6TfxF5ASU+K1MtjYIUCUVJOoQfVdbe/mmn4vlk9QvJwqHmDKKgGeA1V
 FeldImMctfrgp4zL3ysDfM+JQWYT4wQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-27_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606270183
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

From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>

HPD status is retrieved via an MCU command. In some cases the
command may fail, for example when the MCU is not yet ready,
leading to incorrect disconnect reporting.

Instead of returning an error state, fall back to the last known
HPD status to provide a more stable detection result.

This avoids spurious disconnect events during initialization.

Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611c.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/bridge/lontium-lt9611c.c
index 5d67bb7391fb..81ca9d62eae3 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611c.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
@@ -711,10 +711,12 @@ lt9611c_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector
 	guard(mutex)(&lt9611c->ocm_lock);
 
 	ret = lt9611c_read_write_flow(lt9611c, cmd, ARRAY_SIZE(cmd), data, ARRAY_SIZE(data));
-	if (ret)
+	if (ret) {
 		dev_err(dev, "failed to read HPD status (err=%d)\n", ret);
-	else
+		connected = lt9611c->hdmi_connected;
+	} else {
 		connected = (data[4] == 0x02);
+	}
 
 	lt9611c->hdmi_connected = connected;
 
-- 
2.34.1

