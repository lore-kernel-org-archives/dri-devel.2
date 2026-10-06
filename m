Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D14CA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 10:26:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A322F10E32A;
	Tue,  6 Oct 2026 10:26:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MXqE1E4Y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PgmfgTnn";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B20410E32A
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 10:26:19 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696A5VlE508726
 for <dri-devel@lists.freedesktop.org>; Tue, 6 Oct 2026 10:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=PpJmWjeWUD+Hl6NsU9Ms6A
 ZsYY2nv+kkxy5+VkQkbmI=; b=MXqE1E4YJNC4vv5qnakLepc78Bd6hIl7/E9nvA
 lyFaEm8WWAFFUxSP4d4dyJDv2VjpcIsVLAjK4gl6wYLlLKhNIs9i8rLm0/WdXOiO
 Xch5gOH7BQZACj1er9oURJOMIhWK6JyMxz64oQB3bLE5h+uYMyLKME9pNbwoCDLe
 63MCpmatgJJ6JWuum5LhkRl1GCqBxxU4cJB70eE2c7Rldedacf+hkCPM1VGHNT3q
 8SfmX2j6AhrgH+eVFe33FrcW8nQvdYLb72mpp3h52/saJa49NDYsz44j5WGHkOgU
 kQzGPywlPv6nODeFtUOeEd87S5m0iD1qDDgz+jC0GqDjMu8g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xc9r6rq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 10:26:17 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2db3d832827so29665045ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 03:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791282375; x=1791887175;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PpJmWjeWUD+Hl6NsU9Ms6AZsYY2nv+kkxy5+VkQkbmI=;
 b=PgmfgTnn99REL112rpUYRdLZkGomEdLM7l3sXyW+CW+naPK3wBEAFbQZtsQtwRNiB3
 jSAsm0dHhbcDuSy/TgciQT+VBAauyBkgIxXTYLkedg93B0VnRQZ6jsO2tHqii40tRrQG
 7fbOuaLz34HxUGffaixIGOqOvvjVZcdC5PxRbH3I8G2f97lwS5qsHNYRw8RR7PFMc5p9
 1P8yXyHMfPOBJrfebpT+qkKyny+wyZc4nN9FA7yhaU8YGrZsWnWYCGWMG9lzqmjZY6X8
 VpgZOtCtZ10ZmWxY6/Dny+c7OIse6F1tRbdX1aZehi+vVDKucjdRDfs2dRLkndW+6gTM
 tBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791282375; x=1791887175;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PpJmWjeWUD+Hl6NsU9Ms6AZsYY2nv+kkxy5+VkQkbmI=;
 b=FpghbHsaRfp3bC2FoR4r6cpEI7wgsBWzqLvR4J04SPXzeVnFb6feOCphcGp+VkBrmj
 revjF2vpw/gCMVCfRS5+1Dz0rJd0jB0WYiDnvdUk7XMpYP0dIYZj3zRocTF7AFBw7a2G
 4FU/8F1LqivhXlK+g8rY+RR9EnIq+Wy0SVm8AQTnhk0H+595vriMiU3tp7NbqaxTlhMM
 rkL4VFMOL9yrScf8IGyFNZoIZpMo57DMfkkGwtQHaM4KpDGmiQhUt0EDHcRSCMS4bswi
 mrTHuZHVWUKPkB5CJyykMLd4lz4S5ihkqqIJRPpGvHW9jJjXdAVcexYyk1Ctk/+NFPjf
 EuMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCmcWadKQJOkv/QF/4uTgabW/lpy5jPDHx3TTtXlWx9EsW57RFFHLTXCV8DSkmpHMzBz9UxjQ+yvc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKqpSHtqQVNnn/xpcmCljcpx6DDwFfeKBHbAi+MlkRnQ5zXC1RV
 mE559RFHSEMFWS9MQxPIEfvWluM3YbaX6aHa0BIu0uoU2wJ+D7Il4Pp3VQaSg3ZMOu4j8fJ8VOi
 W/1aIBopZLAmsFS0GPPMGHhFBAOr5lhUKL2Vtv0IX/OvPTfk7ZqEvptlzN0WyXm25oHJDPlc=
X-Gm-Gg: AYBFou0dDlA9iIM7HHXH3PWvwqS5I8jDWLEySvTcKerlZB4rfyv7q+vjLgXIvA24RsG
 oB3IxxiA9RrrtWLuJHXU35el919MQ6yQ8BHeCZ/YJvaXDvSBgw0MKKdUK5LYwnqOmA7o5Aq7Ck6
 oNuwbwOLVt0q0S0LieSXECrlhs/QCOFLP1117j1dHx69LcFFhzfDlHCu+wVSSKVRUDYrhcmZdW9
 hp0TWup6HCrsNKfwA0VHrrQIpfZtdrBFxeeQfcEwIcbn4y46WeWA2HI+b/4dCFRJYqY6zNGo5NE
 yfLu6t79TNrxEmlgl41svtC+FvzI3LjXhYi1hMt2U0pGPyTDDx3zqc2gomdJ3r3GUobIR4k9o4Y
 Y+bkZp6j1qNyITS/0hdC0Al7ifuVP4PU=
X-Received: by 2002:a17:90b:5623:b0:3a8:d1c:8e67 with SMTP id
 98e67ed59e1d1-3a8736cd466mr668284a91.35.1791282374740; 
 Tue, 06 Oct 2026 03:26:14 -0700 (PDT)
X-Received: by 2002:a17:90b:5623:b0:3a8:d1c:8e67 with SMTP id
 98e67ed59e1d1-3a8736cd466mr668213a91.35.1791282374259; 
 Tue, 06 Oct 2026 03:26:14 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a853e66d7fsm4088289a91.5.2026.10.06.03.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 03:26:13 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Subject: [PATCH v3 0/2] arm64: dts: qcom: glymur: Fix fastrpc compute-cb
 reg values for cdsp
Date: Tue, 06 Oct 2026 15:56:05 +0530
Message-Id: <20261006-glymur-dtfix-v3-0-44e2bc5370c2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL3MxGoC/3XM0QqCMBQG4FeRXTfZjrpaV71HdLG5kw7U1aYjE
 d+96VVEceDA/8P/LSSgtxjIOVuIx2iDdUMKxSEjdauGBqk1KRNgIJgEoE0395OnZrzbFxUFLys
 QutQMSJo8PKZ65663lFsbRufnXY98a/9AkdN0lTRKaIZo5MWFkD8n1dWu7/P0yOZF+DSKLwOSo
 UrNJZyQ1Uf4Yazr+gaf0MKd8wAAAA==
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
 Mahima Bhattaram <mbhattar@qti.qualcomm.com>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791282367; l=1637;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=Bgtu1G/xKsT1poLg0m9/dTlyXn/OoGnutYJksLEo250=;
 b=ReUh1Z/fMl/E8ea/pc8f0LBd5t/4CDU32Z4x0O0CfmVerzz1p8xzdkcVhGP42K+qH6JBbFpIA
 PBaulU2cVkDCZi3hQw32ob7LIrhQ7Y7xCXjXn4lRNRY3IxTBFm8cq0M
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Authority-Analysis: v=2.4 cv=ctMOAF4i c=1 sm=1 tr=0 ts=6ac4ccc9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=p04a6VuR7GaqaFzguDYA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0MSBTYWx0ZWRfX0oItG08/buyf
 MrFXBLu4sT+96yHteMToMhofbNkbv7Bp0g/POHHC3yie/qouVeSFyF9k0HWntRy1R9nxufV2m11
 EfOH6bavdmbFRulYOgBz4Nv7R1QLwrY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0MSBTYWx0ZWRfX0m2krrGUi0Vt
 3bRkHbTlIv7WL+ixKIcXvbM8brw7LVigy+C+tU8rsf+qPbxVWxOd6Z7ssK8hapVcIKPok6vdgx2
 k4KC+0azhS2Gh6lAXVOTnenLOsHw7qEGOrfNpNordKWyK9WPuiGz12vslQdb333V75hw4WcGbKc
 dKO6G7jET0RJD0qgJedj/zZ/e5iCqPTHfKZB1iDzjT7JUQFKbbtctdT0C1wPii0ouxNhnq3Tplt
 tSGXXKXnLkwWHNmmsrplqcZS8PTeZfMGy+xBDFnNAJqZOe1AdPnbh80SvRN6Ice45eNLXDsQTIX
 PBTKXDARyYk21vLmyHDbNxx+4NsV7HVyDmOapBpvuqOUxr25vhZfLvhrYPBovyLmETtLAx4h/x+
 P6YZ3P2xySi19exphEl8bJMdMPeixc68OwzV6tTpaindlBu+d0TfNDvpwnzp6mgiX5yrIe+NCkB
 Xg/nssoaOznitDStrPA==
X-Proofpoint-ORIG-GUID: fghM7fcGUfZu4vN5ctoeGHmntlswo33-
X-Proofpoint-GUID: fghM7fcGUfZu4vN5ctoeGHmntlswo33-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060041
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

