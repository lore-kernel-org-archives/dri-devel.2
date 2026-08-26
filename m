Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C4EC61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B13810ECF3;
	Wed, 26 Aug 2026 13:46:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RVOLDpnk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QxIFnFMy";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02FFB10ECF3
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:46:10 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCCHdB374872
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s4UvypWfe9nt7mL/wvOboSE124gWnEVIXlimAS2FGrQ=; b=RVOLDpnkM5HuLEoJ
 wg2SZGwMT+A/5zeZXVgxnZH8c9P1nhHsst/MpyMHDx1NPvc13hKzK9cK6o3VRsJt
 6O8EsVlIkQbUjXNWui+Sq5vMNy2WOLiyjj8NSdVHEdgUi4HMUHXe/2aQL3j5jshi
 aEOQxTEOptfAtQ18Yh2voRXI2TYkgVsXeiEBTdVmVSDCO9JV+JLeOZe6paYYV3Fs
 am6ykJJ4j32aBDRTz7cThujPz6OojdUpPKrIDSWnj0mlQupz+T+ahhcomDlFoA3L
 WYo2rKw1oXjHUZAhBVSjiidKg8FiPulNJr+zBs6cuUFCPTPXQJCMr09tOjg1gWpN
 Ush1xQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9smxa2ua-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:46:10 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39533bb224cso1867450a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 06:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787751970; x=1788356770;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s4UvypWfe9nt7mL/wvOboSE124gWnEVIXlimAS2FGrQ=;
 b=QxIFnFMyFClMe3F+t8yy19IRhdfzRtuqxruFbrE7Sm6JKMcJdmcS0VNPWf2FOch/4e
 c1WOgvE+Pmp9iNc9tPomdzJDydPg11EL4gw0XVvy2Bmow2Ghsc1tVi948YrWMM0u19oo
 mqOiw+MMSDcnf6FiVueox3og11ae6sTXikbQuaDtHIgizYy2JeJABwyxiyWhENcdEZJG
 EPi/cQy9GidVdIJo1p9uG5JfHsDrx/gIDImnrFcQSHNiA5qXOKxbm14nWB7gyBAHYB1c
 VS+39t22tS0w4ROvbBy3j2akwuEhtq+lALEDP2bQU1mDxbcsmwzRd5mlNE8JjvkT40bu
 Dqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787751970; x=1788356770;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s4UvypWfe9nt7mL/wvOboSE124gWnEVIXlimAS2FGrQ=;
 b=enV67KaN1greyMOO2vB55sbQPbDMFJlBqwORtmqb7SyFO8b9zrAzWZcAx77NT/F+W7
 AYlRTAgOAsq/8rMd+eJ9V2t9+gIgI10zMlD8PTORintYkaddEFcnpt1NpTwbQ31enDhV
 V/DGDsRVLQcEQHV54iKdzTWXXAK1/IMMGOy3pynJBMTDmhw4e4olv82OXplzHpBdWy23
 uDR72cDIbbBFQxZtpSJA5tzsT4aMhYbinSzPM7Aw/pO2rULURCbqLbu2MyWu5v+4NUrF
 fq2Ejd8rEWGSJ40SForhkOEzUs4HrnDh32a4u0aq4nUB2Y1OA5isCxOHyPXdIXNgG09H
 AcOA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp3QgUj9DMDuVS1wKEY8yMQ06i+8jYlO/Vegit02UYwbFkllPJBWb50IV7nCJRkbDoqO2xBJEGh2vI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m+3u/RzTCN5bHH2jUKfqkXVMHnCWlcjoj0CYhBaMbcyY+vCayO
 JFIJJRIFGLZpwa7cyxbv9vFgvf6Badi5qECxzfWpq96NUyrZWZKYhhy8w1DxVm5qQnZ59vzj0+B
 Nsfh577Yc5V90KcNsePOKd3mvvs0/MLkNK4e3pz6eN5IHh7VxjB2+vXWjGNdiAw3LhOLl8JE=
X-Gm-Gg: AR+sD12FbvV48nC3EIxXSARNIafT+rPrmeN2shSdAE/iKqoimrIss4YBXNkLkPjj23O
 XxBWlumIyFDWVf3G3GlNLxd1+KISaCefl17K0UorXPIjW5tGnkr7zsNJogbrcBMN8K4wsPselC7
 nMFDV6p/QDj/Pk2tw6585g6JweVw9w19/ntzrfUiF+7LpDqiNUNNcJY/PVjQ+fk+PMMJGnchRtj
 mxNSPI5j12teWa0OsC/PyDSuOPlGOhovA6cKGroPeZZdlBCLQzDhBoqIsH2BBGY4Q+j++nw7wMO
 2YJ4xpFFu0obCSNMLr4ZEzORaAMhiMkUz4pmflBsXIMKtWrOtQhoK5q1cd6QfDBZO59QWJAavBS
 0D0cqb8FflLAdBjVLXmw/BkPWBk++73vZvQ==
X-Received: by 2002:a17:90b:4c8d:b0:395:4de4:92c7 with SMTP id
 98e67ed59e1d1-3966d1443a1mr15385563a91.3.1787751969697; 
 Wed, 26 Aug 2026 06:46:09 -0700 (PDT)
X-Received: by 2002:a17:90b:4c8d:b0:395:4de4:92c7 with SMTP id
 98e67ed59e1d1-3966d1443a1mr15385364a91.3.1787751968904; 
 Wed, 26 Aug 2026 06:46:08 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645b64c48sm8179696a91.8.2026.08.26.06.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:46:08 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 19:15:44 +0530
Subject: [PATCH 2/6] misc: fastrpc: Handle multi-cell reg in context bank probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-extended-mapping-v1-2-d046c1cb9a9f@oss.qualcomm.com>
References: <20260826-extended-mapping-v1-0-d046c1cb9a9f@oss.qualcomm.com>
In-Reply-To: <20260826-extended-mapping-v1-0-d046c1cb9a9f@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787751952; l=1169;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=5KtNYFFVry6MjZPWQFGWY4OYvhJcbDcQt2VRTsLJSig=;
 b=Dn/XjaDvVV9cYH+5zOtGZwLTfrP+4+V5CgIH/jrIudFSnEDO5v5jXqK+RlPa+zfCxSI6vzCOC
 xcsDyZd5Df6DO0lqLdMWCd3j2Tue68X3EdlMgKW/E0+vpVcFsx5VVeE
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Authority-Analysis: v=2.4 cv=O/oJeh9W c=1 sm=1 tr=0 ts=6a8eee22 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=OuqQISpc-kSra7OiYdkA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: CcEfk8DZwsrNLwV5IagktVAd7FF7BmQ0
X-Proofpoint-ORIG-GUID: CcEfk8DZwsrNLwV5IagktVAd7FF7BmQ0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDExMyBTYWx0ZWRfX/yV622Lls7Pt
 YaeBu1cXV84a35d3vd4DB92e1hZ+o/VsGbObETfS6AWCEt/BbOjU+F/GIY1Mw0bCMSGM9WeO9RU
 aaVPpwhtQsv1NaM76IgSZiplgFHoW8FFbVRgmdhZT580pkP3pbsdoTgkRnUoshS+n74r9STzBj9
 PnPu0kgtnpIKiQKaKkM8CzSSacMIyGxtRyqC9H0Qz8R+OSNbDO987VL+WfYPMQg+gQXy539QPc5
 kjU/C+xZQbLIwnT/W+TLPQhcjrf40VrjBYo9UwH63CkHnx6FyeKRmcYdu8u0hFgk55ynCNP9v/p
 rtPRtrbKvIHT3St9F6+EUVZzNcvNBU0VkgtDkcVpvurjJWGYVROKVz5CzcL8/Ujm5BhoMDSh3Bu
 iFkM2C4NLf17KWogmhTMh67CbXzOZMTphdY6fCKhnZBmL3dpN43+85Di2veprj7BeEsWUAZIzIJ
 yZ82Mvi/aYxqN0EUtAg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDExMyBTYWx0ZWRfX6Rf1xi7GLQ/y
 vp2yVXHgfLSCGEn6w8ER29LdefXwHIqL1AU7YHjkQvZVUqBoDmE+bZ6XQM6Bkx2F3vkCNMKaVnZ
 nrITu7eF+Zl5gZ4yqaYlK0eidgM3XOI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260113
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

Platforms that use #address-cells = <2> on the fastrpc node encode the
context bank number in cell[1] of the reg property rather than cell[0].
Reading cell[0] on such platforms yields 0 for every context bank,
causing all sessions to share SID 0 and corrupting IOVA address
construction.

Use of_property_read_u32_index() with of_n_addr_cells() - 1 as the
index so the correct cell is read regardless of the parent address cell
width.

Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 98a61b8b9013..07a0f2b229b4 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2378,7 +2378,8 @@ static int fastrpc_cb_init(struct platform_device *pdev)
 	if (!cctx)
 		return -EINVAL;
 
-	if (of_property_read_u32(dev->of_node, "reg", &sid))
+	if (of_property_read_u32_index(dev->of_node, "reg",
+				       of_n_addr_cells(dev->of_node) - 1, &sid))
 		dev_info(dev, "FastRPC Session ID not specified in DT\n");
 
 	spin_lock_irqsave(&cctx->lock, flags);

-- 
2.34.1

