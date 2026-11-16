Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E930F606A890
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q1P5lJvN;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OEAb853X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C6D410EA63;
	Mon, 16 Nov 2026 16:22:37 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B3DE10E2CB
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 16:22:25 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGGIaqe1678453
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 16:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=uySENDl4qHK
 LED5Y781UpPB/TLSVGsjWluRr5p+nyD0=; b=Q1P5lJvNIeKfL56TfRIjIR9jsbt
 77bTCWfZSMMnZXthPUTgZCdXpi4O2Zen0smhOrBw2karVbUu/j3OLL7aN8MglY0P
 bGJvdD4H3Xu0ByqdwaJVvWSdqOKH41uHf3VhbLRtzbMKAGEFaCkemwzQjUw8ao3l
 G/Sd6Iu4A7qRqNEwx/uhcR+aDj1Db70ZP1ARRIeLTctUDqzGwpb+fbl7kKjxxiFF
 NMBrW3TMolw/qsJAgwxAN2B3Z625QLgJCPte4FneviTa73W5lH1TVWNjC+j2wOKV
 cHQH4ip5qU2JKos01EIjcSpvU2+6j7Tre8SmYWS9yvw9okcMylQgj1en7gA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0003hc6t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 16:22:24 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1b238436265so1937922c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 08:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794846143; x=1795450943;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uySENDl4qHKLED5Y781UpPB/TLSVGsjWluRr5p+nyD0=;
 b=OEAb853XwuYNnOF/rjVJxLjipGH7LK3EXYPHNF2D7OLpsaQ931GN0Y87el7miaLboH
 X8CMU/jfQ7fayhV/Xztj6TLnJGzDC4jkTREDXmOuY5Y3TMEepwN8QNO10CYlhgGIhydf
 hOsLYX0em7VXSa974kT/v/bp5eFx9k0jYgZkT42Wmoax3un8WBFdpXcKcC6HpzPOfC4g
 BlZZTN8BjUNjTgI4t+iuX2hzwtHR4/k8B3ryheXvwJgRFmcm47m5ErzfUFCRh9Bk/tHF
 TWP8c50ZTbR1pKBlCncU9pAQoP8JEIFtfybDtw3rupdE8p2yff652C2iiRPO7ocPXL8Q
 8xkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794846143; x=1795450943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uySENDl4qHKLED5Y781UpPB/TLSVGsjWluRr5p+nyD0=;
 b=nzrdPnza/dRt51ZKfsLzV6d02PRMOEmu7K9frvMvPjAi2LyNbmWwFCmmfv5wMv4tGc
 ihSQ8rsI9v2yPTx3AWC1sZ/mRxlwE7FsJHic2QRbzGfbEZwx2e0CwgyiUnXVAwMhZWSi
 XUCu138kIZXUJtve7S+moykmPHnAa6q2XdWgd1cfoNTGwHeOh/2IfuzOPKz74t+mIhu/
 0dQl7M11WFkfHcpKz1QTC6vTGs/aaT18vrvGTsc+dNLrVQngzX6MlDcNQBBvpSa7iC93
 9GKGsWSo6jLJ9ZwLBMvtDdB0l7gYrC7rceAElFfNkB1CyfkLlvhiSH1+2afrYHsp0hfs
 8Ncw==
X-Forwarded-Encrypted: i=1;
 AL+hErFKOXgJN3v2wwvu0I+ap57IOb77ptFmaF2Jk+Tc4sx/6wvulIBN0mh0Ssy5Bw4kMPjKvpG/YK2DqM4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9J5UXODDpksrtWijZiznjfrt91pqHxMC3vKnFByJw0ps2FeS8h
 H/06hw3thZdE6Tu+71Bq1h2FrxLAOHTljin8jyhprdpD/s47EqsIXUr2XoBnayuXJ6hEUjsNeKs
 fTe5vIUG7ObxawZuNkJKHSOVyTy7qIrRUu1T4eRlfjrXgptNCRjAiDiqQ/O4FQJhxk3yWRes=
X-Gm-Gg: AYBFou3HTtXfGzGOmBYID200l03WjqnGxrvOFriivAp/hsukQ6qlfrevqxRK7wcs+Mr
 VjPPaMcT0499nkueaUhYH26HYj7tdOotbouAbXO8nn7UasC5EfiASerVOs6Ei3ywUDIgPf5T8nJ
 41o9UoSsLqWcMivLol4tLu5SB52Nh+IMwcfg6fjI+xJnfmFObv8DgFzfuc72IlS2F7tc/dTm+kz
 85pqoguLMyJy4ycjE7rUF9Zx7LuAuPLeCz0Oos2t0yxDYmhqfArogvbBiCUMh5s4OA6Be+18k1x
 Y/BzWadS1q0JB/xZmVlz8cWsv4Ks3B/902oaZ/HiKaw+hpADy2jRIdHlfhs0VVGFJ1+S+JV3N5P
 vcGGHlR8CUgts0zS6j4Zr6bJR4CwMJ9mnNoDUU/dldKXkbA8XBquPJB5eRtx5I0jDPKuV6du3z4
 yF
X-Received: by 2002:a05:7022:7f1a:b0:1b5:23e7:3387 with SMTP id
 a92af1059eb24-1b523e75033mr5758255c88.19.1794846143408; 
 Mon, 16 Nov 2026 08:22:23 -0800 (PST)
X-Received: by 2002:a05:7022:7f1a:b0:1b5:23e7:3387 with SMTP id
 a92af1059eb24-1b523e75033mr5758228c88.19.1794846142809; 
 Mon, 16 Nov 2026 08:22:22 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031468b7sm38623826c88.5.2026.11.16.08.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 08:22:22 -0800 (PST)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 "Bryan O'Donoghue" <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Abel Vesa <abelvesa@kernel.org>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v3 2/9] remoteproc: qcom_wcnss: migrate to qcom_mdt_pas_load()
 and qcom_pas_prepare_and_auth_reset()
Date: Mon, 16 Nov 2026 21:51:41 +0530
Message-ID: <20261116162148.2864501-3-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com>
References: <20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: B_LjctDxz-FgJsQFFtWpgo0DQ1SI6E3Y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfXwp1ujPn4ibKk
 pBtjZPfYibVsQAdCd1G6iz2xn85ilSs1cctkIWjR6Ybhj6f9js5U87ApzE29qZeyk76RmlP2v8s
 rYsMzvEjN95saUahNy9L0h0nLdYDjgo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX6vQpzrOJEFYr
 NBH6RCNdRN24TqEnQ8Z8nbwmsY6Xm1CW56yCjCEv4JiuKqosxU7tpT32JUtdzMkz3th4GE0KM0/
 /9RbAaa0oce8yp0hacrKnnoMvvewhCFZE0CZkIA6MSWzjKpwN+nXkdYeffTB2RVoNAseL3uwhlq
 +AnmQn2Zr7jAGVC7w0AmYLXuUAs5IZiA3DPoQ4+sxbqKv9mZJLZt/1MFu4KUWPjcQQZdoxyAMfc
 6lYGLzEVvuAKjp/vGjPpHZIckw3LL+rMAKbFbPhF1mQPNDUZj/59aZQlR1vtpCbBllBCnsjOnrd
 ZNQUDq41+v/yD+0euzFKCg2iZ7BfbzMPr8qPjHorQKN26gPvyLOxdkzX/grA+aqSL2T8mGI0b22
 5t2ctn1ZM/2W6BmRF/pAM/JdAvdLqvb+TXuFE2malXMhFVp3WtzOuNul6584x8myhVf9TnZsalM
 SJ1rQjDPrxqeooZj/Xw==
X-Authority-Analysis: v=2.4 cv=Z4N5j3RA c=1 sm=1 tr=0 ts=6afb2dc0 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=BENypEIf3hN4rM3MEzYA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: B_LjctDxz-FgJsQFFtWpgo0DQ1SI6E3Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160064
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

wcnss_load() calls qcom_mdt_load(), which bundles metadata init,
memory setup, and segment loading into a single API that does not
expose a PAS context, and wcnss_start() calls
qcom_pas_auth_and_reset() for TrustZone authentication, which is
the intended behaviour. However, a new qcom_mdt_pas_load() has
recently been introduced that works with a PAS context and can
handle everything qcom_mdt_load() provides, along with additional
functionality such as shmbridge creation and retrieving memory
from the shmbridge buffer when the same remote processor needs to
run while Linux runs at EL2.

Allocate a qcom_pas_context in wcnss_probe() via
devm_qcom_pas_context_alloc() and store it in struct qcom_wcnss.
Replace qcom_mdt_load() with qcom_mdt_pas_load() in wcnss_load()
and replace qcom_pas_auth_and_reset() with
qcom_pas_prepare_and_auth_reset() in wcnss_start(). The existing
devm_ioremap_wc() mapping is retained for wcnss_da_to_va()
address translation.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/remoteproc/qcom_wcnss.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index 02f38fe29f20..840fa67a6928 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -96,6 +96,7 @@ struct qcom_wcnss {
 	phys_addr_t mem_reloc;
 	void __iomem *mem_region;
 	size_t mem_size;
+	struct qcom_pas_context *pas_ctx;
 
 	struct qcom_rproc_subdev smd_subdev;
 	struct qcom_sysmon *sysmon;
@@ -157,9 +158,7 @@ static int wcnss_load(struct rproc *rproc, const struct firmware *fw)
 	struct qcom_wcnss *wcnss = rproc->priv;
 	int ret;
 
-	ret = qcom_mdt_load(wcnss->dev, fw, rproc->firmware, WCNSS_PAS_ID,
-			    (__force void *)wcnss->mem_region, wcnss->mem_phys,
-			    wcnss->mem_size, &wcnss->mem_reloc);
+	ret = qcom_mdt_pas_load(wcnss->pas_ctx, fw, rproc->firmware, &wcnss->mem_reloc);
 	if (ret)
 		return ret;
 
@@ -257,7 +256,7 @@ static int wcnss_start(struct rproc *rproc)
 	wcnss_indicate_nv_download(wcnss);
 	wcnss_configure_iris(wcnss);
 
-	ret = qcom_pas_auth_and_reset(WCNSS_PAS_ID);
+	ret = qcom_pas_prepare_and_auth_reset(wcnss->pas_ctx);
 	if (ret) {
 		dev_err(wcnss->dev,
 			"failed to authenticate image and release reset\n");
@@ -599,6 +598,11 @@ static int wcnss_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	wcnss->pas_ctx = devm_qcom_pas_context_alloc(wcnss->dev, WCNSS_PAS_ID,
+						     wcnss->mem_phys, wcnss->mem_size);
+	if (IS_ERR(wcnss->pas_ctx))
+		return PTR_ERR(wcnss->pas_ctx);
+
 	wcnss->pmu_cfg = mmio + data->pmu_offset;
 	wcnss->spare_out = mmio + data->spare_offset;
 
-- 
2.55.0

