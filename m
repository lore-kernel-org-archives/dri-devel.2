Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B661C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 20:44:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF57010E518;
	Sat, 27 Jun 2026 20:44:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hDF/Rkte";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Cf0eEJ1p";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA7EA10E512
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 20:44:09 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65RHnaFX1726430
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 20:44:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BrwzP5kaMTZ
 SpvTPdQ8PZsDiaXHhhpAob/6J5qUSorM=; b=hDF/Rktez0dbkLTP9LYiggG5WdP
 PltllndGjNKwe6fDBNHDFOzlBpGytHeSHNebzlwc1Pf+y5W/6+9KlYbI3SLR3ctt
 B1JkGMpPiRTcbGWJzWltNMqY0APoRGjSsm5rIbmFSWZKclTtb5IZpz52YO9kGiVa
 T4pKzgF+Q4Q7Js6UDY/kvU05JYYRLkbBqMRbFyVJaYyGN9zssZRawzooMoHEIVNl
 E61oHX5l/EjuqTc349mWz18dHyepjbYxDWa75WXx/GxKTQ4XSCCKmRGS6HcVnKyZ
 Kpt8D0LBY4Elv5LRX/XgyVyqNbmZPw9RmZxRC/6/Bj86C18XesIPZT/QqBw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27t7sjfj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 20:44:09 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bccca5620so3026370eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782593049; x=1783197849;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BrwzP5kaMTZSpvTPdQ8PZsDiaXHhhpAob/6J5qUSorM=;
 b=Cf0eEJ1p4EIb1U1d6HWIvsf6gDut1ndISdtD+hAlcZbcfPHcmzyClzrXTg8MQdE8E4
 xZ6SfqBz6OjTKF0jLNITZwjYiuP33QlZ+SoVgC+BqdU6iZlLvQVxWROL0uc9fJIZWj5A
 rpvzBOGf5Q6VNUVeT4nzuZh3WoKBtg3H8KnPuzscxSwdCXPVBi4qtnOJ9Mrg15wQkUFE
 4kJpMKMxzGVmyicOkaADfx7t4kI8fCQi2JhtIGIFW1L1fOB74Q3RV9nIwY8ksAIx9jXe
 AE4eBmQdyIjFcw4nMPXrqmIDa+Dd4wKL1v1eAGE5nUbFN8baoeqoOWVnCT7xTZEGjDTm
 MNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782593049; x=1783197849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BrwzP5kaMTZSpvTPdQ8PZsDiaXHhhpAob/6J5qUSorM=;
 b=g/F4K1aEfye3xua6TfjmlHXHERi1a9raNgLEvE32o1wKfCR/bOsvd6ilt7lt+3aBIA
 fXUqzgTCYQh2Hm8qkVHDY8OzuF7B2AOcY3a9d/9wsv7iZjcscb9vbzKZhYcl4+S8Fz+s
 BbszWJias+tPvZGjas5i5uxPk2k/O9i/yRNrvfNd4e3YiJ/GpFnbNDI3uDGzdoon3esn
 8WZAM2ghiC3WYdbRH9ylKihIh9wZZNWKJydvi+VYEGuoQ8DC562jyZrDXyedrtVNYtlf
 VWkHVxDbPbsyG/OsHypyJHMQHqnAZcWBO+JOLt+pt/G2OQUVVxVpZrINQG3DgGWMXmQn
 R2AQ==
X-Gm-Message-State: AOJu0Yy13/6eg0KVciLY0D64sAquY3aGKTJFzmzXLKIpxU+QGSWsoDuY
 91Ep+cwVxjVpVS7T8c2gS89DcwHE/bdgDzCThUzKG1CUDsTKObe93YMVxKnQ4NC5x84Bcxxx11I
 eyTTkrhKbbX6TxO37rUQQzvMWegifjS7lGRavoJCug7m3UIB9cn5h90ri6JnKM9KUTB0FfhiUec
 czXBI=
X-Gm-Gg: AfdE7cm/GyKjFAohAIRRxtCADyhDAlkv4Eg5zMHlbf02i520doHxuqOeV4/83e2mwOK
 HxQrme1dK0fPK6bp4Bb06pKqSa4e8aQSYQjzR3QHLN+y4/Mbxv8Hs83oNH0r0s+wbI+xo9I1ti3
 uRW1gWysLdGsYWwlFIYOE2O4AJvIEXnkvtaF5pIgjAP7sKXqqI9/kdKAGuWAP0YHmsAPepAzcEu
 SAlHwa/reRq2cwugeXjbYDBDIyjZZBdyeKU8vgIhon1ojTVuFIXgay1Htdxml+v8cWdzJBS9snJ
 l+rD45MXipqv7ouoE/5Ifxlwg28/WjdPigBISFAi19u7JyEpxxG6V9SHrgIWCFxrTv2SqSucCJ3
 YnUgk275TsF0x9TRrhdJIEVZDfcYhw5nrMIZm
X-Received: by 2002:a05:7300:3084:b0:30c:ab4d:382a with SMTP id
 5a478bee46e88-30cab4d3cc0mr5053322eec.44.1782593048637; 
 Sat, 27 Jun 2026 13:44:08 -0700 (PDT)
X-Received: by 2002:a05:7300:3084:b0:30c:ab4d:382a with SMTP id
 5a478bee46e88-30cab4d3cc0mr5053305eec.44.1782593048185; 
 Sat, 27 Jun 2026 13:44:08 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ca5f14f8asm16882963eec.6.2026.06.27.13.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 13:44:07 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, boss@oss.qualcomm.com,
 qc-display-maintainer@oss.qualcomm.com
Subject: [PATCH 3/5] drm/bridge: lt9611c: fix DT parsing and bridge refcount
Date: Sun, 28 Jun 2026 02:13:55 +0530
Message-Id: <20260627204357.3336040-4-mohit.dsor@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260627204357.3336040-1-mohit.dsor@oss.qualcomm.com>
References: <20260627204357.3336040-1-mohit.dsor@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI3MDE4MyBTYWx0ZWRfX+zH1U794GEtr
 0N6nnHQSr6y4x0/tNn3qWcbRkRf2rO0Yu3k50rOj7xcMpRKZdj4vVgFCcL95s+rv/iBYFxKO9fL
 Etox9FNSWPs9X8mWfhfsHjCLSNnzuiz3ct1WmYW2FZkxKvpDQF/QYJydrhVDPiSMnrHSyDk96Kf
 iGXMl1DIsvzzbA46nNWmEUcDa3dQzgVt9D0VzWkJJ9vB3A6+O8XPtebcxCn4zjMZ1Q9ttjlHnYu
 7rxhDRD0CuoJmvUaKH8Hj7HqzzVs89bjBD/VgTpm/LQh6HOcsveLkNYTRKjBN75YFGTW4zk8xB4
 vK2ifj9t7POuMGq+7uUnTpZ+rJjXzLOPDq5YmAV1rXJOW/CVs5xKKKNRwntwf+g5PA9jVPnxhgd
 QzFyn8IrlfpnsPO87bgewCaBRZJPa/8kChfA7VWENDDYD8swhF3ify0CMRsuXQ6ZTb7ZiOoHLNV
 8kddRSuEa4JJ1g59Wtg==
X-Proofpoint-GUID: 4T1SNGmAv-H39zhJoU2n2OvZMZgkdv4v
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI3MDE4MyBTYWx0ZWRfX5y+TavVlzZRC
 RS6FjefzwPAKJ7xSVedVvvudB1JdnH9JSQVbxw8S3MDUYKK3o3a3YBcu7KKuWQ/6Z4gP6U1k7Pn
 0sg+KlWHXHSDomMafy5qtDtTKYPUyQo=
X-Proofpoint-ORIG-GUID: 4T1SNGmAv-H39zhJoU2n2OvZMZgkdv4v
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a403619 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=wKAF-K-d-Ge9zTf_WYcA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-27_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606270183
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

Ensure DT nodes are properly released on error and acquire a
reference to next_bridge

Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611c.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/bridge/lontium-lt9611c.c
index 30a07e97626a..4c8a3829a4be 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611c.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
@@ -974,6 +974,8 @@ static const struct drm_bridge_funcs lt9611c_bridge_funcs = {
 static int lt9611c_parse_dt(struct device *dev,
 			    struct lt9611c *lt9611c)
 {
+	int ret;
+
 	lt9611c->dsi0_node = of_graph_get_remote_node(dev->of_node, 0, -1);
 	if (!lt9611c->dsi0_node)
 		return dev_err_probe(dev, -ENODEV, "failed to get remote node for primary dsi\n");
@@ -984,7 +986,14 @@ static int lt9611c_parse_dt(struct device *dev,
 				 &lt9611c->selected_port))
 		lt9611c->selected_port = 0;
 
-	return drm_of_find_panel_or_bridge(dev->of_node, 2, -1, NULL, &lt9611c->bridge.next_bridge);
+	ret = drm_of_find_panel_or_bridge(dev->of_node, 2, -1, NULL, &lt9611c->bridge.next_bridge);
+	if (ret) {
+		of_node_put(lt9611c->dsi1_node);
+		of_node_put(lt9611c->dsi0_node);
+		return ret;
+	}
+	drm_bridge_get(lt9611c->bridge.next_bridge);
+	return 0;
 }
 
 static int lt9611c_gpio_init(struct lt9611c *lt9611c)
-- 
2.34.1

