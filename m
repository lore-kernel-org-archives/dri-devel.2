Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74785C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE4D910F26D;
	Thu,  2 Jul 2026 09:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="i1QQYMQx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QRFb/YP3";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 764CC10F268
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 09:36:53 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6628KUEH3049525
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Jul 2026 09:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=hWNsTDwKnB0nQjRuBjtpdR
 mOjat4eE37McGVk/KSLto=; b=i1QQYMQx1WqpIO/nb6nJ61tdqzMjSp9ab4dAhs
 pcfbe9WV3n7roLacoCvkpQe5VgfgBJNiXg1PQN8e2A4tV3oIys7pW1/6XlwQqtLK
 YdYkwm58AXh8TxUEaEC8jSMpdRTd6kqHicTPsCJqSsNsBXzKtj/dbk4YIM/8fWiV
 WVDflycizXvaDR/TJAoEBRh/N8m/S8usL/WqSylEa0MlSSUwNgUoh1FhwLBRDo2C
 P09yLbjD35D0TVvp70owEqErSpipWoo0TiArhUypdVG8+7PC5OydhHjkkIskeAcl
 aWy60wriy1eKwT7HQVJRWF2v1h+UjTZBo1HZPNU3ez6eXPyQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5541v1ct-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 09:36:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e663c29f2so48596485a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 02:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782985012; x=1783589812;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hWNsTDwKnB0nQjRuBjtpdRmOjat4eE37McGVk/KSLto=;
 b=QRFb/YP3omUEY8V9q0QSVDmUtDWLSja3NY6s3syYo4ND84kLn2PM4Ex6YSs9TK04U3
 uy+tJa9xl0hbBqoxFkVUdBdj2UZezob1rfwfqcI/kmyDP3Cc0cMyJIxlsjLJM7huTy5P
 94N+ELEdYteOZuS7ICmR7clisCp3w6rC2xDfa6tU2sXyiud7zctaLBCDfEk1hNU7DPGX
 mV1N39OanduAyqGvHUCeIP7dfYTtnBZ3vEUieheUaQFjvMPlK0nmQKcI31QkBE1ZtOe2
 y6mc+iwD+fknzTTZYIbou5DCcyTWQblL+N02EQ6JbPqufDt6fNwjXZV30R/ntyPmEqER
 UK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782985012; x=1783589812;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hWNsTDwKnB0nQjRuBjtpdRmOjat4eE37McGVk/KSLto=;
 b=gJ3lBbhlaQp3VeKd3fF+rrhi5zztToFq9K8qeQqvz+ChmQWXw4GP/+95VVoGMVR/p0
 BGUR3Q7XbBBGQKx1p0HTHS5S5O7+IPcaUEkyp3/xSSvzku+g5EttfwkP78kL653VUTZG
 iuA0h3nwFmS6641T+/vnvDzSoj8kZnhjIRfigHN022txMZ9FKmOH6vnvOBw82sbFBQIf
 5CoA2hHreeLcrOJiJltDHNGgeHdpdQ1cG+XuJAMhRfiZlsG+K/ArPzBQ1E+86bhfhhm0
 Gszeb19uym9J3p5e+JqsKbStmwb0+Q1zDnc4YxZHvn0ndjlwCXKN7X1mMeDKdsDR7ovx
 IiRA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+tyzftjTC4DCFMF8zxpEuX700uP/S3+0oCR48gqBIVjXvli5NueosxR3usDMiKAmEYr8SRZaIu/js=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzv3MrjCK9osXWFjKkXsLwEDLewyM17GSDwjnhKdBfPrpGpOr8T
 PUeLkcNavup2o08GB0g44Ah8wlwdYZqndBuywntaUXKZA8zLBS8w/Le5Njfyxn9M0TrWWxg6D7E
 MozjeQB/dn1gtB6OLfXbBwIbro1KXRgi1iZLEQqtgQ8TNdevq1A6tOpu0t5MPTT4AqugqW+c=
X-Gm-Gg: AfdE7cnQaVZIakgKYoKuBTmYq+604aVoxNLdP0kAZrLuw2qt9r1ESmT44Lf5JidjlWf
 DlzvhsHmyJ4ufXpsoZVvPAzFvS/6gOu7y3AkwjNlWvBKXlj7E5KkyPOwcVfLNbchrZdD3DGf3oC
 k+eZeS8yZbOiBCYDqNDikXJk/0MySPo0Nm2PhxXnFdrQeuOMUjqWdXxUpdqkcDM5MkjApvLtaY6
 SBdE1+TKO1pEk26XMEkpOHD7z/qtwRC/Ajuk3HcpnV4SjQmE+hfcZ3Qnf7kQk2z7VKAyQvd6zoV
 NpzFPPsG8lcYURx4vvdu1OPBCTsx7t3N4a4UmTW0lX5IM/h82hH6tWBRJe+XcipuNGBVWWUKO7g
 H8LAXfhrIVQmb++Jxy6z6MJcj7evanx5+4sU=
X-Received: by 2002:a05:620a:4550:b0:92e:61f7:5687 with SMTP id
 af79cd13be357-92e697f1e67mr1220755685a.29.1782985011743; 
 Thu, 02 Jul 2026 02:36:51 -0700 (PDT)
X-Received: by 2002:a05:620a:4550:b0:92e:61f7:5687 with SMTP id
 af79cd13be357-92e697f1e67mr1220752485a.29.1782985011322; 
 Thu, 02 Jul 2026 02:36:51 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.174])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3db964sm7101335f8f.8.2026.07.02.02.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 02:36:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 0/2] drm/msm/hdmi: Simplify the code
Date: Thu, 02 Jul 2026 11:36:39 +0200
Message-Id: <20260702-drm-msm-hdmi-cleanup-v2-0-a4a4f0e8895b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNwQqDMBBEf0X23JUkNkJ76n8UDyFZa8AYzaq0i
 P/e1B567GXgDcy8DZiSJ4ZrsUGi1bOPQwZ1KsB2ZngQepcZlFC1qKRElwIGDti54NH2ZIZlRFF
 pJ6zRtb20kKdjotY/j9t78+VE05Lf51/ZeZ5jeh3qVX7aP5ZVokCrdaXVWbe1o1tkLqfF9DaGU
 OaAZt/3N/Mm5UvUAAAA
X-Change-ID: 20260311-drm-msm-hdmi-cleanup-035d0ca56c9f
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=921;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ha9fWLnbP01/VrndnLaB1lXP36wWzxUY3v/qBBHW+KU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqRjErWIym2Fh7Huid6TbyoC9GZP9fOKccezf8I
 43Uaue8fuOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCakYxKwAKCRDBN2bmhouD
 11a3D/4+AtzUox1wG9dcBo0TVCXnxW0eTcd9APyNwpbMG1mxzkrNIWhdF4JaN/vwc6Gz94jkoul
 fXzCHxAW5rEoGKS9rhRnCoeqiK9SNUl0Ej0Ny0qbechpcAOhESx9BJ8x86FHpYL3dtqr0L/D40o
 11liCTboIHgnvIpj0hGoCnep2hIM9rLmOZ+ejKACJcxcY+Iyaf6TZvNV4S3aZEkLB4x3vmd/dg+
 U7cDi15hjz2cCxjL9D3TY/3dZsJylk+7qp5yDISN9c0SWbYqPnG3jZNc7iaE57ZKt9NGjLFXxlx
 L1ThEc366iVZUVk/r2/UQb02wEPyv6TXgLEcufSbzUKM2evhC2IfbTomg3fRMVoaGBTKYbXZG5d
 BzKkv+Y7DKGX6UKnBghX/T3pFk36yIgRxfw9XPghub3V59oAEa7v0+aKXgxuaJozMek4rIhFTcA
 BqZNqsuzapg5lZSsOLIAJJJsU67iC76p0VmkA/nuZkU2pAmAJZ42ePsU2MWCzGnuVapSVO4aszE
 v+mmb0YWoz2p8EKVr7EQcvv5I2GA/f9dTH+6No1DZxmwV3VG+uxCGESr2Y2uAHLDXa5lr1/OvGU
 CvDZOiVlqcp8dibVudZ3JkuLkthcBQWnPl7Y4FpgO8jx2wbkNFPOK7rX/tguAG3v9zXKw8QgZ6S
 q8TiwnO0cIdArkg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: gD_UPczrWrzR07JkWI5EMQUdzrer5Daa
X-Proofpoint-ORIG-GUID: gD_UPczrWrzR07JkWI5EMQUdzrer5Daa
X-Authority-Analysis: v=2.4 cv=Xbm5Co55 c=1 sm=1 tr=0 ts=6a463134 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=kI3vywTxrR2MwHqzhFcA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA5OCBTYWx0ZWRfX2p61WhebxmoZ
 UaGZym1gZ2wDWLhYpIgfyQYXSDnG2N049QNPORkHrF7bMmt+765iM1o7xeqPmyB+ciILqDY6aNT
 CAwDGjm1qsISUha2c2jYp46LitErSt6ZCzSATzbptOUtTToaURZS5ITiiGNwe9kbxxVKGPSw5fq
 UqfeDs7AIvbpJimyi9pDcDD2uO6zxdi5SZ73Ol/afqiB8/LYg+rt6AsCSqMhodC4793kDu3wxt1
 MG+j9sFgEYZQUg8m3fauGLdREiOjnVeCmYhgu0IkaXHdVFMTxcYmhfjTgahM8RuLUMaWHrTKHf7
 yn0JeMo6fRLiKAb62dQNhkFRKTTOLlO0VZZOFIMnNsJ7Rc51+w0jPZgY9/cYLQLvp4nRtdFFK6U
 AWjk/jARowZZXpReWYS75V8kG1C8GIZHo3BimMNIQNA/f582ibPtumCsjuqgVYi+YkW/C1H3LBs
 LX0Slgk9EkRei5oPluw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA5OCBTYWx0ZWRfX8hYC1QVjjGt4
 o/ld38RcidBnjXyFM4IBjHxP4GmYOme6OcdVp+Hh4UuvO1ceMI7/dRNr7GwSs7ONML2SkPdCPNN
 YRfNcJDxP7Jn9XIiFs/mJ+xJdzcE0f4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020098
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

Changes in v2:
- Drop all applied patches (1-5).
- Add Rb to remaining two ones. Rebase, but no changes in the code.
- Link to v1: https://patch.msgid.link/20260311-drm-msm-hdmi-cleanup-v1-0-c5535245f6de@oss.qualcomm.com

Few code simplifications, without functional impact.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (2):
      drm/msm/hdmi_bridge: Simplify register bit updates
      drm/msm/hdmi_hdcp: Simplify register bit updates

 drivers/gpu/drm/msm/hdmi/hdmi.h        | 19 +++++++
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 98 ++++++++++++++--------------------
 drivers/gpu/drm/msm/hdmi/hdmi_hdcp.c   | 85 ++++++++++-------------------
 3 files changed, 88 insertions(+), 114 deletions(-)
---
base-commit: 7de6ae9e12207ec146f2f3f1e58d1a99317e88bc
change-id: 20260311-drm-msm-hdmi-cleanup-035d0ca56c9f

Best regards,
--  
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

