Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04CE105F79F
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 12:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44C5010EBC7;
	Fri, 13 Mar 2026 12:08:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="U46QA9vv";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aWnpMD2P";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC01210EBC6
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:08:46 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D9TiDI1498953
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=RWK211jG41Q
 SnlsskvL2jGr76sZdiXtZyotsC2UXfIo=; b=U46QA9vvomxNe2DWJaNI6jnPKM9
 JeYasePFDnTZM3OmzT6sn83YA1ijbCj6WYXOlu6mlyC0K7tyMmbQerbwcnuO1kXa
 owuV8QEvl634Vz+YeuWSd+4Tl5IywPys4kJ3giCA56AvynkqurfqSv/p3NCXm4N+
 YONaIWMHZGyeU7Sj9NbBKjDqKNl5hEx9JSKjqpPBXmRoYRD7pAq9nfXBF8E4SXQt
 aaYHPVJ+3nawbjTNjw35bNx3NFieTpKVav0ndVI3YJkbPN+mZylhe503bW2SwxDP
 I1osSFq2huckyoHi+bI1aAhHX2LL4fq4JptJbMCH+UQuKEhXY+MzX+B5lrw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvg0hgfb7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:08:45 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-354490889b6so9002624a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 05:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773403725; x=1774008525;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RWK211jG41QSnlsskvL2jGr76sZdiXtZyotsC2UXfIo=;
 b=aWnpMD2P7EWEYdTUtcoK0a4X4I5evNyMbw3NUQk/pzLI0vFQJiHzDe+askW46YPZ+2
 d2zF3sqYoB3Jrbn/Lvlj/3zv8Xw/I4azjZOMH3R7jQ/amZEAIwZTXIv0+rj/GxZr4oqQ
 e5ZnuuvcidqspH1rdXgl6RZlZoLpxQemD/pUo0wK5/9okjP4QN+3oA38IqspyEz2HXLp
 svOePcHxi2oo5ay9YM2g7k5L80wrddpZXtirk8aJcsyCSN1DALwh1C5HANE8x+zdPkGz
 mctIOa1HG2R4V1Qj4aMVygLmOtuOy+dYqzZGBtLwq3igOHEEP8gH43MQHSelWb5/fqc9
 qLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773403725; x=1774008525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RWK211jG41QSnlsskvL2jGr76sZdiXtZyotsC2UXfIo=;
 b=Pkf2Cvb8yQ4K6NN4rCpGqB74Qu8j5Up0oq4fCDXVeqKosZLhvNaq0UrDG//2emv9CM
 44ceQOyTMOiJ9HS7soZZJOvW7U5lYTIvvpS5FrDfrtMpPuwvYxrVN5lhULaMogfs5/0g
 ppLVrNO0+HsP4sjck/xfqNdUYUt2MCTL42nEoI0k4iuMAaU2vlzcPKz30t53/wxiKOjI
 AhY7LoiGdFuSW+aHXOw1uJd9xSlZb0IABZhpCOse0TTJN+oKHIaGES7a63y5UO3RzqWM
 5ixoDc54reaUIoStALf/JK+FIaoq330TOnCXng+wvXOJHkwNf0NJDjPc8+hgqRKDJCae
 2ydw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyJ93bTMFTe+WbN3olIx7hvia+u9EwG4MOE4uTSim5kt7oeRMIhPW8mkvNivKA/yF9qQLB+xAGjZc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzkWflPtN7wEts49xz8zIDQVLoJoVM1NvcxWamhGhGukPpDm/Uh
 gB8r5+K2BRqqjBwNfqv6x/PGZi5unfgVzjY6YsF7aW4be5GNyhO8mg/MAEUrkRUd+JaBUbz29/l
 XCFCbuENsXxnQ+kL81Xh4BrzPQnBJRU6W5nUt6EWgKvVT3lI4WodiEzed2JkZHsRj3wHhgtE=
X-Gm-Gg: ATEYQzxRNttvevE205Uf0OFVLbnxa/sGQgzpO/vQrrKsOZuswlEwVZcsyVtYGMTAuXb
 Umuk8TvP4K2PUqm8mpDTfc1Cr3zXdPf72hVpT7QdYRUCoOrtu2qNot7nB6oWfXpqeXT5e4i2ogK
 AJoCPQESuay8k1SXaXwcaRGqCbwnokjxYkPLs6AABOQwRcrh4SRnjUzBWmooyHtd827dupsUsIz
 WcuuZ/pSdQ7lfMZzCZB6RSVaMDQI4q3ymE3o37PtDjuda339jIGe9jm0vjMYOpzkb03I9Ruieqe
 DrAGDdshYyTYHAL8IxftVrMOrTqxT/nYcJi6q/PBYxzPd4wwS4AN5Au8LD4oeDMkRdGWIMS4cAc
 4KVyNwXt6D9rd077RCfXHbvaS9IBcqFlkUUDrXoQUc/bRvZ6oIJhGjuld/FhZwVBAmS9SxpccMJ
 vblQpC1gt1SWGh4FKSWyhx6GgaCrlVc3tQZLYm
X-Received: by 2002:a17:90b:3b87:b0:359:9073:c368 with SMTP id
 98e67ed59e1d1-35a22081e73mr2728819a91.28.1773403724784; 
 Fri, 13 Mar 2026 05:08:44 -0700 (PDT)
X-Received: by 2002:a17:90b:3b87:b0:359:9073:c368 with SMTP id
 98e67ed59e1d1-35a22081e73mr2728788a91.28.1773403724362; 
 Fri, 13 Mar 2026 05:08:44 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a02e18f0asm8421945a91.1.2026.03.13.05.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 05:08:44 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: robh@kernel.org, srini@kernel.org, amahesh@qti.qualcomm.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org
Cc: mathieu.poirier@linaro.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 mani@kernel.org
Subject: [PATCH V5 1/5] dt-bindings: remoteproc: qcom,
 sm8550-pas: Add Glymur ADSP
Date: Fri, 13 Mar 2026 17:38:10 +0530
Message-Id: <20260313120814.1312410-2-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313120814.1312410-1-sibi.sankar@oss.qualcomm.com>
References: <20260313120814.1312410-1-sibi.sankar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=T6eBjvKQ c=1 sm=1 tr=0 ts=69b3fe4d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=iOP-JMljhTESenzhlaoA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 1jSVFi687mStwrvwGiXNV5Si2TkhPAu-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5NiBTYWx0ZWRfX233ngQi82i9w
 tv6ZNEoITrpjN1FEArNGBcqJg/uxFmZBxvhItSOCOXyfRIzu2rwRSzHkdeMAOSMh039FiyF2IyZ
 Wu0OV2JNwNLTEQh8lfBzYO8Nh7Ul9t1Krp/VAHH+vbArwP7X3W80AWGlGfBH9zlhCJBqHNkiF0J
 6408cK5UG0Rs+1iU7f8QnTlXS9F4eQqJRKLMYAiRAB8zGgyfnWrjKvhMQP6RkI5bmATPoJ3r3ll
 dfAyED4gRPoovJojtxZwseT+SpBJpeZ9XlcdiYRBK6rCHDXjCWNky7o3t8mR9Cucmgw+Y6M0BSi
 4GUaLDQ+faDAgd2WibV7Jqv+B1br9VvPvkoFzoe2GizVIqEKzmATdxYW9JZfpIdkuVUFFCZNSC0
 2Nn87U1zMCdK5vidgRpneH7Kt4c3xnGSMQHdw5uziGf6Gd4ddEqqcjWBaWHhmRkH0yEmViG4cdR
 F643JTAC50ZGq4e79IQ==
X-Proofpoint-GUID: 1jSVFi687mStwrvwGiXNV5Si2TkhPAu-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130096
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

Document compatible for Qualcomm Glymur ADSP PAS which is compatible
with SM8750, which can fallback to SM8550 except for the one additional
interrupt ("shutdown-ack").

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
---
 .../devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
index b117c82b057b..fb6e0b4f54e8 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
@@ -29,6 +29,7 @@ properties:
           - qcom,x1e80100-cdsp-pas
       - items:
           - enum:
+              - qcom,glymur-adsp-pas
               - qcom,kaanapali-adsp-pas
               - qcom,sm8750-adsp-pas
           - const: qcom,sm8550-adsp-pas
@@ -101,6 +102,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-adsp-pas
               - qcom,kaanapali-adsp-pas
               - qcom,kaanapali-cdsp-pas
               - qcom,sm8750-adsp-pas
-- 
2.34.1

