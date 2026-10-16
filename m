Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4BDCCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:37:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F075610E1A5;
	Fri, 16 Oct 2026 06:37:08 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FD3010E1A5
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:36:57 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69G6Hk7H2678111
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=q8Z9/44SQcBcx5h/zSBNc6
 T9xEkCG/Pel3ap2KBOJTs=; b=GghQcuj6DT+MkdKFX4twfD47S+2ZXIsxHwss0y
 xFA/olz0732XFMYGhbDSZM4Cs+Dk3U2FFl81gX9FvccJ20RXI+YzsABdTtTiwPH6
 V0igMh1TNZzt0v5LY07hkzEzhLRR2YRrOSabT1d2HXm+Xmk+iiWrJ82kht9Ivsk0
 gI8rZRHGhG1kQEAuXgOdwqDiDtOxmU60eEPRUoSfWnLW7rPQAf+n+gUpxIvpN3QL
 836nqyYSlp1GNvPhI4ris80U9inwPZ4FmAm06UCQoYkNiiwtGp+GtakuRfXakNJc
 oP7ck56S1c1GlhRvzzE3IxuXrq//mBWi4aDNVjAKCMn65pQw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb19tb4ar-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:36:56 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc7e0321ec1so7228863a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 23:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792132615; x=1792737415;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=q8Z9/44SQcBcx5h/zSBNc6T9xEkCG/Pel3ap2KBOJTs=;
 b=SpCkH3I9XauUdzeg/Ih+UTZ7YEM0+Y1Uw9h1g0i5o27w0KR7troK+inqEkAN0v6DZ8
 pE+CQgPbKav8+Hx6YiDpGVsi9QEMj4PZTA/9cuWXl/hxd8Dw42K5foX70gCh+TLnBF19
 ZiRGHLBYq6SXgtwN9bKnKf/69P+aaI3vdeEIWmLE5r3vbNBGn9mXi5W2wj4btHiS5M1F
 9pX5J0fJsxoNed9e6/2+K2avQvDUTMreFN/XitdwqB6QZ2lMX+gX6p1Ra4XSf0u4lGaG
 9Wz3A7RCXne4Muh7n+lPHocPDvyD2mN+/AfZp6soQ15EUZ3M1hpus6Y4Uwxdq8EQf8MW
 8Zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792132615; x=1792737415;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=q8Z9/44SQcBcx5h/zSBNc6T9xEkCG/Pel3ap2KBOJTs=;
 b=e98bnWRKxIJVQDszrum9SIelYDes5Yu6W6R9dyYQRqby8dvk90jG7i7KguBd3Ck4uB
 8ww97p6hzZuVK02aahVxF8taWjNXf1+nX/QAevR2wfH/+Xlu/pJLiSoEKDaN1ZRnnNDt
 3r7bNFcQdjGZxYm0QMi/nK1K7wVL4jPHuTLmHB/5XkQe4QW3bqs00DLtUWt+BRJ+8lhQ
 O62/OAQjKKHzQUCIy4Fm3WyOWd6gh7G7T1VwbtVJBND3Nq41r2ovDLZIbOselXRI1gVu
 OaIi843r0yMDyXZEMyb9AdKzYFlCJ3algxpVjIWrHR+Dp2QKd0cLTpnhmITEuxga6Kqd
 FrHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0y2MPSmtdEMcTTGIxeK/WNo82Z30QClDo7HZUGNF09jUUk/X9S+7YpqNtSK9TcpbU8RXVcK5tN8g=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI9WUZomQ2QQm7sDkgn9UU56+bEpjowLk4kKHS0ruE3NCNn/r/y
 qz2oFRgOaqCARy6uuVYeA+1FG21kQwAo81Q9NiKheqBf8OBGkDHtzAjVksKCMfRfAve7jpGirSm
 tF3mtB1VmcvgUhXG9zbJoxPq0T+ugStRDJoLXYZd4Dq2+G+w7sDKLHYWVvHjJ5lQGV1nHPEY=
X-Gm-Gg: AYBFou3HGDKIOlVw/VrfdAkzqP/TxVMqNiDv+mLaabsd3+eweKUg7dVsy25583U5N/I
 GMBudRWvb1U1XqBXDpL+jUyTkMzc0Wv4wxATAoDKwoZ9YQobdmcjWF7ZVW7vgdawwZDPoKqsQhr
 lL806VwTQue6tsKqa6233cyCqIKAp52+5QP72rUR0eLQnACdgSPs7KUPfq8uS6rUsrjin9KBk4g
 hUGQ4jIUg5gtFg1Z20PTQu2cLvIfuzxtnbBSZct44SVQYklbW3oAaXpLbOckDKTldTv+IcVq5Is
 qItlgD6DMcsS9WCpqixw4a+TRwyii+5/q7bfjwbYvwoi6DKzoNa2TkSgNInE94AK2U1TD4DXP0g
 Xx6oeCTi2e/H6F9lyfous8BObrXQ4WIo=
X-Received: by 2002:a17:90b:384c:b0:3a4:b061:2765 with SMTP id
 98e67ed59e1d1-3ab3a735fd2mr23121501a91.15.1792132615484; 
 Thu, 15 Oct 2026 23:36:55 -0700 (PDT)
X-Received: by 2002:a17:90b:384c:b0:3a4:b061:2765 with SMTP id
 98e67ed59e1d1-3ab3a735fd2mr23121474a91.15.1792132614984; 
 Thu, 15 Oct 2026 23:36:54 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc43a1e1esm2703298a91.1.2026.10.15.23.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 23:36:54 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Subject: [PATCH v5 0/2] arm64: dts: qcom: glymur: Fix fastrpc compute-cb
 reg values for cdsp
Date: Fri, 16 Oct 2026 12:06:45 +0530
Message-Id: <20261016-glymur-dtfix-v5-0-f56a8b94b4a9@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP7F0WoC/3XM3YrCMBAF4FeRXG/KZPK32at9D/GiSUcNWLuba
 FGk7+7oxVLKloGBc+B8D1GpZKria/MQhcZc83DmYD82Ih3b84Fk7jgLBHQQEOXhdO+vRXaXfb5
 Jp5Wx6KKJgIInP4W4fnPbHedjrpeh3N/6qF7tCjQqyWdD17oIRF34Hmptfq/tKQ193/ATL2/Eu
 aEXBrLRmqgCfhIkjyuG/jMUgFsYWoI0hjAmqz2kNcPMDb8wDBta7b0ymrwN8R9jmqYnavV0eXs
 BAAA=
X-Change-ID: 20260922-glymur-dtfix-6314526b4b02
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>
Cc: Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
 Mahima Bhattaram <mbhattar@qti.qualcomm.com>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792132608; l=2079;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=SbBWi7rAu2d4dqKIgQF1wHBrOqOAZBnCc5ssmW97zPc=;
 b=VS1o8OFndnIWvmaRgXEEgPFHVS3EFhV4lUdzNEP8pErkH18I4Bsx9tmaHsYIA7VqGoV6Gtht1
 BIye6BW1sAJDeaf7z6Irp2xiIqOAOQLhD6L5umNOrSke39THQpys3ti
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-GUID: gnSz8AWkbK2-9GRz6kt4NaDUq8tPGJt-
X-Proofpoint-ORIG-GUID: gnSz8AWkbK2-9GRz6kt4NaDUq8tPGJt-
X-Authority-Analysis: v=2.4 cv=NqZE4MdJ c=1 sm=1 tr=0 ts=6ad1c608 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8BLdeznasY9QL0IlsjIA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyNiBTYWx0ZWRfX5+LzTLA0zJqs
 uEks+wu8qHTB5FuZO5B6msOQ+KY2o68hN5ojTLTkVf0Pm7nlifopfmsUli0JoKanblBYJDXeHla
 0ZhU1WDCQZ311SRczRuo3bpe1AzPMO0K7VfTNTOWssM0QUzRtTmpNZPNj67Ow0kcK3r8No9O4yq
 gySaPYRHW1VPQcte7PeOmnOMVgc91lGj/F0QUPVq8/TkqDNsbCISPDLgZH/+2xjcuw9LYn3r5z0
 aL/+7R/JHlV+9h8/v3QoQqxWesQF1ACG1+cw6/Scg4ee+SuI9mzOpNmRcKG3pBAWpPGUn61/iCU
 egCiZiqKM1s1dxkkmz6DqfYNcIf1DB4WCtnwNA2j8DQNCWTQKr48ae2odLj9hNsi6i/EfhCJMNH
 kseF7rvD164V6oVz83kmcOd6DgL9CY+Gl//MIB68VXkh+xxHkpSB1jroYzUNiwVpJch5BxkmnbO
 d47F2hgXEMOBVqoMKmA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyNiBTYWx0ZWRfX+Y2fophqZg8c
 DmXO3TbBsrdTXrCHdh0Ksb8ZOntYH9wPhl7l8avwW0te07pIUcBF3ViK32o8d5s4wjGLfDbMAiM
 Aaj1SsbtcJpfv9kXsNxNAKR0JN31G2g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160026
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

The reg value of a compute-cb node must match the SID (the lower nibble
of its IOMMU stream ID) it is associated with. In the cdsp fastrpc node
of the Glymur SoC, three compute-cb nodes had incorrect reg values that
did not match their SIDs, leading to SMMU translation errors.

The fix renames the nodes to use correct lowercase hex unit addresses
(per DTS convention) and corrects the reg values. Since the fastrpc
binding's patternProperties only allowed decimal digits in node names,
a binding update is included first to allow hex digits.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
Changes in v5:
- Write reg values in hex notation: <0xc>, <0xd>, <0xe> instead of
  <12>, <13>, <14>.
- Link to v4: https://lore.kernel.org/r/20261007-glymur-dtfix-v4-0-31f7143e759b@oss.qualcomm.com

Changes in v4:
- Change [0-9a-f]* to [0-9a-f]+ in the binding pattern to require at
  least one digit in the compute-cb unit address.
- Link to v3: https://lore.kernel.org/r/20261006-glymur-dtfix-v3-0-44e2bc5370c2@oss.qualcomm.com

Changes in v3:
- Add binding update to allow hex digits in compute-cb node names
  (required since unit addresses must be lowercase hex per DTS
  convention, and the corrected reg values >= 10 require hex names)
- Link to v2: https://lore.kernel.org/r/20260923-glymur-dtfix-v2-1-a4b1928e0c72@oss.qualcomm.com

Changes in v2:
- Change unit adress to hex.
- Link to v1: https://lore.kernel.org/r/20260922-glymur-dtfix-v1-1-159da6b0eed9@oss.qualcomm.com

---
Ekansh Gupta (2):
      dt-bindings: misc: qcom,fastrpc: Allow hex digits in compute-cb node names
      arm64: dts: qcom: glymur: Fix fastrpc compute-cb reg values for cdsp

 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml |  2 +-
 arch/arm64/boot/dts/qcom/glymur.dtsi                     | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)
---
base-commit: 5c4d4169604b335c38bbc79bc1fc03042981fc6f
change-id: 20260922-glymur-dtfix-6314526b4b02

Best regards,
-- 
Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

