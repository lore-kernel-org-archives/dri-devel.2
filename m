Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19977C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AF1410E746;
	Mon, 24 Aug 2026 11:28:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DrsQ/At1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bc9swk7/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5BCE10E746
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:28:38 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OBMeGt3194990
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vYF8IMeScLS8uXOagtGPkjVovyxJMz305NPZ1OMf6D0=; b=DrsQ/At1BkqIW5SJ
 1Ug2h1z697x60kZ6pcWAdp9YIBS5SGu6qE3ugXMp74AS3EgTMN/sF24/6uTy7KGL
 noFUjjLxKbeLlVCvd5sJ8FFz6NlRHQE3pYoqAP81BkpKfEigkosbAkAuqYFrRvVW
 R1YvaDvey9yItrInIh8CITS6W1pbtgdf7WeR8tVXB8cPF5HH+FEzawFXLthNSMZJ
 N1BeLda4Ppo9P8J7leRZHlxXu5QvMl4Y3wsOBlPy/gDC3DznjamJx47gT+21tPXx
 /uOiI4caUKOhh6r0l+ZP/Ty174Lbsa9ZQCR1Us7Z16cICtj9phkbABlfZagFXLdm
 mgVdJQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8hjgs00f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:28:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so7321284a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 04:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787570916; x=1788175716;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vYF8IMeScLS8uXOagtGPkjVovyxJMz305NPZ1OMf6D0=;
 b=Bc9swk7/l5aSv+kWI5Te4tz0Aj4NAO9CwCSWrj4xjqIlGXOq/uBvB9xyX5aLdQJ7PJ
 vPbxvyhMSCjfkywRCCM5TpTX7+5sOF180R3emVhQndBs3b/JE3sN5zImDO1ce2ZUbqlb
 Z8FRjPwRl3B7cUQylN9HKaooeAosdK3Fs9JbV+QJwGEBP2BW43sLYHkHp5LU7n5LiIiA
 4wiRUbooye6kItDK50TFF6Kb3aaEdhTVryKnZn2g009Z/ZjY2NWxg+u0UiQ4Rn3NX8Jv
 vKF5HSSVkNPcQ8+fT5tUkv/TFGTz0f71RUDltr7IVjrNvMkpCXEy2BKaQG27BNZ+kSpp
 PnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570916; x=1788175716;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vYF8IMeScLS8uXOagtGPkjVovyxJMz305NPZ1OMf6D0=;
 b=jXsOOviTRZrJBGXdLXY2SKK00+6A9UcdQtvWOZ2J7IeypFD6IE826TLuWU1p93TVLn
 nX1XFfiA1QCPel3HyR5YubvsWp+O4tqeZtVkX8PVwPtkfy7DXpmr7fTbc2UMpILPIzVk
 /Xqj1M+UZOJrG6MdZdRUocRsxVHb3doZYsOVsRGFmVQ6O7ZZzxSQgOSCie5+acazOcHh
 FPf49pWpjJ7lniovmhXnbzlO9ts+DA3M7CQ/n8hq12oNd6FVerwfCZ/9rdYQYW97nvjL
 23gsFK02CJqG2twhYRqgyIdTlTBgNuBJ/SpZqheuE5r/qGe13xoaHKUGzWXa2ZMCNLvW
 5U0g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpBt/yPQF7+l69zGG2Az+ZUxJU16GLFRGJPHrGdkZrSpa4THSk3CF6fChw9sSgtpLs3lTDq3x6ZWqI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nu2vqTAOZ0i6vWZHSiCXmg4TPNQF7ocROwqXcQdrzrYrIX1hOm
 2ZXsntnUwZU0lyGPBZK3u7g7A4AkASOIqpFKgTzCy9lDFO/us9Z88/1nDxeMdRDSUFq5tOUqtqf
 szVYQ9eix1A4ZIrMILDYk9v2W8SROiLKFyrTR49EwoTJCxMozVzUBlMlzelJvlrF5oEdmbaQ=
X-Gm-Gg: AR+sD10BnBI+LfKQZ2OevnxyGS1Zw8NnpAY9QHKRq8cAuIIHuli2KgPJWE22J1VjU81
 nNpcSf2CnqRW6StzN7YQWV7+w6rk9YFYYG6AgGXutbvs+ohz8IbYlO1aODphsRiIP1tjAZ9A7+6
 Pkc/laBlsfUdJ54PHUjq7xdT0KD3qeuCwzaUTzlXyWm9VcwCOg5cwJ2kJlINS9t4FsWSeR7Jgnb
 RGGLg7tuxBPF7eiN2n8fR+6qsj0k9126OMpRUBlVwxP26Ms5g4qWRr8NxPX80upTiemvKTtjX/z
 Wkw8sWxBo1VJ+Cl/9dMRiecTbMtL4EWu8ojxgf8NjCvuaUkp9MPHu9ORniaO2wyeGbsKEPqfz50
 d0cSAMrc5lUrKsYuC
X-Received: by 2002:a17:90b:580d:b0:38f:5869:387b with SMTP id
 98e67ed59e1d1-395df24e757mr34344874a91.9.1787570916270; 
 Mon, 24 Aug 2026 04:28:36 -0700 (PDT)
X-Received: by 2002:a17:90b:580d:b0:38f:5869:387b with SMTP id
 98e67ed59e1d1-395df24e757mr34344681a91.9.1787570915598; 
 Mon, 24 Aug 2026 04:28:35 -0700 (PDT)
Received: from [10.213.109.15] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e4af750esm9825643a91.11.2026.08.24.04.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 04:28:33 -0700 (PDT)
From: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 16:58:04 +0530
Subject: [PATCH 1/4] phy: qcom: qmp-combo: delay Type-C mux switch while DP
 PHY is initializing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-qcom-dp-typec-reconnect-fixes-v1-1-2825e5bf8a96@oss.qualcomm.com>
References: <20260824-qcom-dp-typec-reconnect-fixes-v1-0-2825e5bf8a96@oss.qualcomm.com>
In-Reply-To: <20260824-qcom-dp-typec-reconnect-fixes-v1-0-2825e5bf8a96@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Ritesh Kumar <quic_riteshk@quicinc.com>,
 Vishnuvardhan Prodduturi <quic_vproddut@quicinc.com>,
 Mani Chandana Kuntumalla <quic_mkuntuma@quicinc.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Saurabh Anand <saurabh.anand@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787570901; l=1390;
 i=saurabh.anand@oss.qualcomm.com; s=20260824; h=from:subject:message-id;
 bh=y2k61bLaxakC11xmIND99HCevfgEkScpEhGzbvIkkXg=;
 b=YnnBPYMDGOpuT28P13YjgvNgaUOm0REayyFOl+w9n1bbmuJYRSC7ZPy5YJYHSEBYNFN1d8YLv
 Rc8x5As6KkpDsdlwWZrEpgf+gGmLjqagkMCGtUsW2tIEzhikWNOlVr7
X-Developer-Key: i=saurabh.anand@oss.qualcomm.com; a=ed25519;
 pk=AzGwbGUPO11yi5XTeGyJKOJWLfzXp5Dru4z+PCg/uXs=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NiBTYWx0ZWRfX2lxYs2huh6gr
 xnZHCCOoASgM4FSQYbH9SA9nfYJYi1VuNZBq7yFmHRPHqfkyI2KfKSZbhadxscPEyc2G5S3uN39
 bEUYVpOCegeSPtlfE0ROQdMYObcC9ow=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NiBTYWx0ZWRfX9MjMB9gbYOJh
 pkvNLQasMSurNYiUR7BNVEJM1u+9EHxfHnFH7U+wNC2UuHJ9z7BVVDRJroMASHKidM5bsuAjKqr
 YdsfesDhMFoERPU9c0KIgaWFT0tJDXjyPHvYtw7B+kE1ixtQo95byuWF5/TGoas6HhK35Qq0Jdb
 W3pQcRECFuJ0m+AXn9h93XGpp8n5WI2MhltlOQOsMTxEC1aLVnOVIqEPBldojPaIJ3oTmJQ8DCa
 Q5bHJt3vTE+zU/zgLsnED8Oq//F4p/1Qnk+LPj0rHnD0OG+Gt25aYapqxzxuNUPkPkSeTBoiBbv
 o33VxUhVz5MMzcezBGJcRWgeJ9UGyIpFOSS4uTSn6S8PJnA68zAA8ghDkuDc+Uk62ZIvejUshXZ
 Q4F3XXF36VcoxuWMXEpkwMAZdFrJ/lKLBRK+dBe4cqTNrfCqwVvuD00003aqprdDy/ikkLx/Q4d
 G0pophbh3AER6tvJPFg==
X-Proofpoint-ORIG-GUID: ycXxzPMylhQPUYXOVBgXX9qe11tYrCcu
X-Authority-Analysis: v=2.4 cv=CoCPtH4D c=1 sm=1 tr=0 ts=6a8c2ae5 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=HxeoS3nH6iSbXD-5zs0A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: ycXxzPMylhQPUYXOVBgXX9qe11tYrCcu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240096
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

The Type-C mux switch guard only checked dp_powered_on, which is set in
qmp_combo_dp_power_on(). However there is a race window between
qmp_combo_dp_init() and qmp_combo_dp_power_on() during which dp_init_count
is non-zero but dp_powered_on is still false. A Type-C orientation change
arriving in this window would proceed with the mux switch while the DP PHY
is mid-initialization, corrupting the PHY state.

Extend the guard to also block the mux switch when dp_init_count is
non-zero, covering the full period from dp_init through dp_power_on.

Signed-off-by: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index c39ced168d03..f23aff79ca08 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -4842,7 +4842,8 @@ static int qmp_combo_typec_mux_set(struct typec_mux_dev *mux, struct typec_mux_s
 		return 0;
 	}
 
-	if (qmp->qmpphy_mode != QMPPHY_MODE_USB3_ONLY && qmp->dp_powered_on) {
+	if (qmp->qmpphy_mode != QMPPHY_MODE_USB3_ONLY &&
+	    (qmp->dp_powered_on || qmp->dp_init_count)) {
 		dev_dbg(qmp->dev, "typec_mux_set: DP PHY is still in use, delaying switch\n");
 		return 0;
 	}

-- 
2.34.1

