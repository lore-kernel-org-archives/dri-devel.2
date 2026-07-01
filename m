Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85C3C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F00B110EEDB;
	Wed,  1 Jul 2026 10:48:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aSt7NKha";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jknu29eY";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2646810EEDB
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 10:48:30 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661A8R3f761262
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Jul 2026 10:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=rtdfjn6wXasVp2+MzPUAaUEwkTUjgFP+l15
 5HST+Nlc=; b=aSt7NKha1HJSenXBkJMu50NAtk4sNCna0S+aQMJb1rPBKKL1RTp
 wvX0fE2te+flL/uNHQiv6XH5i2gUBVM1PuNy1h95bdUfAXuwfUEW2zaIQToQiEpH
 7+sKOm5z8IG5vCxR0kfZHuEeN1n/pHWe3WkhNi2dqimwDJiofM8N+4aCNgUc7gDk
 2b9aYZTEvciMrcVdcG+9UdabxAGjLTL9mkIoZHVKZn7fcIRFOiJOs7o+uzzjOhg5
 7Ii4SJWrzhWb68I4PXouCMha1JscteWXYqeeJ5oGlTYpJgDe3qNdBJqaTskrOI8w
 Rvqmy1O9rk9JCoAjNSuq6ZaCPSkGMIZfNRA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4kgw3mkv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 10:48:29 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e68cb7a3eso103930685a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 03:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782902908; x=1783507708;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rtdfjn6wXasVp2+MzPUAaUEwkTUjgFP+l155HST+Nlc=;
 b=jknu29eYR8qgCdpEcY+eUiq89VF6rhwOJERY+TmjD0VZ8JvM8DaoVppePlIvXYEsN5
 U1P85YsGD+/1KRikn4xCuQTY6k0G9UbyOaQUzl1X+pHKY79OEDprA7N1F6YU6fb0CBjM
 yGgC4xxCJ6Wz6FVEOuTeArCstCSs7/sBFo7mAWITu63lm70KQKYWTN27kWtBq6QD7y0v
 d7rifUed6VCFffHIlCBmA2+SBe8dMu0SFMPlHDA+4RaWqTXZWELnJwKji/KkkR/3KlXB
 hoTTZ9AeiRhuNlMsmv1lgriwbzGgBtSkCgP76MsmnpV7fBxxCEVKZyT2ZN0Xok1589Zx
 0EUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782902908; x=1783507708;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rtdfjn6wXasVp2+MzPUAaUEwkTUjgFP+l155HST+Nlc=;
 b=dtFprQAD+gs5md/D3flfBgY5px/g2laVFeP9iuWrzN/6VGtk4UovhLbxi+LL7eAU6p
 IsRCTbsKFeEEeBptMqqk/jtLUXrOyH6d8V219bfUVjglULAxgg6JYOYwMB807cqjCcce
 mt9/vQVH/ManxhopGNRyuvkz9VyTnQGcEPDGhwpq/rD1kptEcouVvUeEPJ6zmepnGEUB
 1VPdUTrtwJD9/oO2qnJIMeHn3ZOgujHJHX6AbxDY2SmWVa9Dtjv4Zcn2IEtOiv09YUyh
 DIrqscjBF6mE2PTByoIGOMRlh0SC8NWRlv/gI3NYk+eFIlXNsE2pt31ZIdZF+V0OYGac
 R9FQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+F0LeHXghBOYPreQ1FlG+Ug1VGY4OCuzvFq+tZ/95lSD76e06gM1DL7WeWDmkrAQ5X1GUuqxclOzk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz57+8hhq5QAQ1fF2QAAGahfpX46k4whQXQsXQhsAXU+tBmqmbO
 q0WMEu+jZHAk2rwGt0VJd27QV3NBVeGnKIlTKUAdaIVV+N6/8cRdP5c1XRmvrzpTUF90RgINU8A
 /Ly3ZCMKjXc4gmHzcmi8e5Ywa9MOy4QWybctIntvtdgFkEwAz7YvgHhQY+v8P8CU4iFielsk=
X-Gm-Gg: AfdE7cnxngHX9WSri8kwCyXfskXnIrbJqZY2+WhVyrTEynKmSEcGRDdT8pshrNAv3vC
 xfPZKiWHu9blgz+9vSJf/yGG59R6WXuOPLfLbqZ5usdgHKcBBevgD7kuHBnxtId9YEyKE8Wk8aV
 LUEdooWajyIhzyFZOMvwLKIEOlXT/vZjRkbaQIYO7XagvzSp1Z0ZiJMwKcTp+OuU7d93J9WUK5V
 BYqeLopxZtYAjqwIH9rW66wyeITF9J7m+sisrMSQH+TWEWMpK036gGcD7t1yiwiGx0TCaaDdgf8
 AsSSmSiMpWf0yWAdYATm0eXy8ZvvE4QgBVnZ2RXo7EdDVEQyppaj4wDpDzoAP03FMxNO5cqN7pb
 MjRaNAvHEA0jBNcQ6CVnytBLB
X-Received: by 2002:a05:620a:4109:b0:92b:81fb:87b7 with SMTP id
 af79cd13be357-92e781d35c2mr137635585a.13.1782902908515; 
 Wed, 01 Jul 2026 03:48:28 -0700 (PDT)
X-Received: by 2002:a05:620a:4109:b0:92b:81fb:87b7 with SMTP id
 af79cd13be357-92e781d35c2mr137633385a.13.1782902908111; 
 Wed, 01 Jul 2026 03:48:28 -0700 (PDT)
Received: from debian ([5.133.47.210]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-475641e4cdesm17099115f8f.13.2026.07.01.03.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:48:27 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: srini@kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, ekansh.gupta@oss.qualcomm.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH] MAINTAINERS: fastrpc: remove inactive maintainer and add
 reviewer
Date: Wed,  1 Jul 2026 11:48:21 +0100
Message-ID: <20260701104821.3120719-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Co2PtH4D c=1 sm=1 tr=0 ts=6a44f07d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=e5mUnYsNAAAA:8 a=rxdMid7QtmSFOHtU1qcA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: MZmE09zRxRc4C7wG7A7IYGibjjJQHrp4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDExMyBTYWx0ZWRfX6iMPN9lx4Y5j
 MaaE/gtI3G1z9rbuczulIyyLyRbqEVJ7pZn1gSntfdrcKsXBPbVcgMx0vsmWZKSi40rhS63KQdi
 qYMPHVRW/GUmjjZqRIg/MbV22C8AhGM=
X-Proofpoint-GUID: MZmE09zRxRc4C7wG7A7IYGibjjJQHrp4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDExMyBTYWx0ZWRfX9LCi52mu6sR+
 0WjgDOi4blhzyZSgsMqa7JKUbXL+n6DDNbrZ9qgXQomn4tAk1lExlZcAwPjhGBy41NIy2KleFfA
 9TAWdXIQktoRMq0dcnlbE1nCFeTwcGmn76JIyfj7xiJ83p2NNlAp+J3WRsxxnspPEdVLj6zUJtT
 Z4P1m7HjbQDX0iHuqVLF8xtIzuzZb28w+vR2DklAkfYPdn9ABY3vbI94BxVpxKIvvRDpgYC2FAF
 idiF1FSjQ9C4KgTRPBG/FP0qImPoWsVEfCMeCBv5ekPIiZGCCcDa7F2hMl3Nx5uCuOng/kvDtak
 CT2RebpXwfaLXLSOMSpK5GxzFCt3YLE18JtPSGdXle3hicHBWwQ75GV944UAlYSbAO/3w5ZhMH8
 WJApT/AxDDVsfxr5J9Ucnt0eZhU7N3ENoDIf2FzoziSaibinnAu7kOwSZm1i71A/ni+24Mc4Hen
 mHW4OP6HJ07JSByJdUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010113
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

Amol Maheshwari has not been actively involved in the FASTRPC driver
for some time. Remove him from the maintainer list.

Add Ekansh Gupta as a reviewer to reflect his ongoing involvement and
active contributions to the FASTRPC driver from the Qualcomm side.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5e11dd741d9f..3023fe8464c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22199,7 +22199,7 @@ F:	drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
 
 QUALCOMM FASTRPC DRIVER
 M:	Srinivas Kandagatla <srini@kernel.org>
-M:	Amol Maheshwari <amahesh@qti.qualcomm.com>
+R:	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
 L:	linux-arm-msm@vger.kernel.org
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
-- 
2.53.0

