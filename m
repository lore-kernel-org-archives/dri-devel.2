Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82411C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 08:01:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C225E10E151;
	Sun,  5 Jul 2026 08:01:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BezB4TOk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AAfxwBTg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D21910E151
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 08:01:07 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6651sjR8255002
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 08:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1GLzbMavJcBjpxSXBuazEchU/ZHqzUf3tHtHLBksp2U=; b=BezB4TOkjvnOWtYw
 UkpcpbynKs/qu3POkRXnKFaGwJevrfu+kK/8Zu1sks6qnMGiD1WDvPTEGF7ZAAkH
 iA47ybIsJHYT7bgr27fVi1RV8SB+2OH+tYgooo+dsBdXi/4VcXmXesOT1skFK4gg
 2WMWz9oiq0fYfd2fO3cIjgCB3AONBBvQWYq+f9yxFqMLglGeZcJGVXYujWq0o5+O
 XQ2k5sWsADvSPN0Gfj9OL7FnWRpGmdHPgXuPXzKVQrA6vrSLrNwPYcRYuqfNpMJt
 KRqQfDRMCJghmhrTux9jVCys5W7L5gJ+vnLofnW8BWwJUALtSAbf84UTU5h+OtqS
 Vxn6sg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6tj8j8u0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 08:01:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-380c178acfbso1639575a91.1
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 01:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783238465; x=1783843265;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1GLzbMavJcBjpxSXBuazEchU/ZHqzUf3tHtHLBksp2U=;
 b=AAfxwBTg74Xl8vtFYYbNTq6wYM22Pu84StW+RODi7izjKub1MDnvoncvlcdNZsuUkw
 0qMUQnIyidyxmWYzBh7yDkM2IaocQRBLC1De/A6dqfdjPJhEzITFFYZayJ388a4TscRh
 p6suhLscv4iKyYsTbi/SgGOhOm3BPCsoIYP60U4q38Wh1CrqfWvsFdSLR7pt+P/J7LuO
 3wBGAl6YovzO8GTRyjpJ3bWEETOWY7nn378j28jobMG2KXJWvPDTGkZbPSL7tDnDYc2o
 nlADqF+PSKCgjUNESiGOVa2W8iG63kwmFCRGZkhIjhnP5rYUyqjjA295mhOlkxPB2sE4
 6fKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783238465; x=1783843265;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1GLzbMavJcBjpxSXBuazEchU/ZHqzUf3tHtHLBksp2U=;
 b=sAEzOuSlY6WEGJyYcheIFA3cZU5W+GCRuYR2VdsN9++j9ynfiA9Y4FWqXqXmm5SI+N
 JKA3VJ/nRs3Pv2dRSZeoyadZ9FS2WydmlaHs8TOqRFP98qoqEctEw3SfspA4VysH/cVT
 W+YJijXqhnF5/+eujbCVHCaza8SMFoXnYRZPVSImN8yn570CkFqDYOZk0lxf30Gl5Z/3
 mMENYuEFSt9iGUunzZr/NjkvGSrbsLQnPUtTkz/pSnji6Gzuc8o4MiHZzgaOZ7eCQE9H
 nQuEI42XlR/2nJF9fnNv81ABFJIm5Exfh/YnHeZFP2YOYEqp8O+8TA8UKRNuwr92gLcI
 jQGQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMzjlh48c+FfDqdBCC63i0yU9I6w9QYWKXSK8xZh4k2R8xV1nnKJFvD65QPRkp8Ofmtgs3fbapX14=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzg81bZ/oJ1caiRaI3Cw41L+BEpb1Dx9suv3mwICs1T35VSuTKR
 PdQuhg7sDYhGAAIMWLnf3KSHKN6y90WGk708cgqIU64/tp8v+ktCafzg18A/lSUJWwV4CBWDknw
 zGk0Vv7mwqa8ujKn/toJjJtE9T1fkIDCLMgU5K2aBm/fUX7y7PI6QekC5WUW85aqslOP3zvQ=
X-Gm-Gg: AfdE7ckN1e73s3MImcxoQNPf8TVf2/tmP4XReSoekgZVSUlkpdOwTxkxIYEkC7y+QKM
 4C3/znjvuGrNS2Mew5xIrfaedmQT7N60zzAmxma2+SpeGc2jih96MQVTV3J55CodWf31bQfWHPH
 H9o25401fXxGFWTGIyar1pog4f32E7R3a3KucMqH9bMG6D86xpDnwYuTcVxdBE1afX7+xVLz3RT
 frAJyRlOSKc+OYWm2mkQ/sO1tFAxOXAhZltRzh53PpCAbC7FK8Ue22Qu95Cg982YsjGQGIsNOBb
 SSXhdgmCjW1emwO/I+VIFFJjNFjyNW0qbdMl4RMA2CKF7/WYt3dmN3sFow5iThdWlZ2vdXxv+rh
 UQbZbIN64ai8dGAYkCird0MWpN9Helgdp6dE=
X-Received: by 2002:a17:90b:38c8:b0:37f:9cdf:f03c with SMTP id
 98e67ed59e1d1-3829f7ece33mr5155165a91.31.1783238465343; 
 Sun, 05 Jul 2026 01:01:05 -0700 (PDT)
X-Received: by 2002:a17:90b:38c8:b0:37f:9cdf:f03c with SMTP id
 98e67ed59e1d1-3829f7ece33mr5155121a91.31.1783238464724; 
 Sun, 05 Jul 2026 01:01:04 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3113c88041fsm7759179eec.15.2026.07.05.01.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 01:01:04 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 13:30:06 +0530
Subject: [PATCH v2 2/8] dt-bindings: display/msm: gpu: Document Adreno 840
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-kaana-gpu-dt-v2-2-6ac53de56314@oss.qualcomm.com>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
In-Reply-To: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783238440; l=1293;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=rEVRE6tS8OEt2bDdC+eNcX3SJvvj+nz8Z0ZGM3xZAcU=;
 b=GAsTe5la0ufNmjlUop0lHQSJGg7ejUO8suiNPoqkpIJfG+V5N92J7e6DKYQWZC8idtEXAlIcA
 yq80BjmwnsvBgjoxZvpwNTPTexaH1YVNCh0nbT5Gn+LBYJAXWitzzKO
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfX+ef88V9VU2/q
 9/4PyUFV71pUChGunsIEU9LB6vUMWyUhH1PQxxpCYNZsAX3ijT7jADNqa29w4rmQG/DWqWF74Sp
 G2+YqOdk4XDjFVRWFSH1vsmevhf4DpS+agk48UF1shnJg6koTJ2+MvnkqJ5tnP7RDof0ddrTA0P
 uSeZrqwkDT+HfjFx/PK20BSE17mxri6tMNEPP3yef8xayLRkXoYU4OyH8+cfWEpmECBwBHy33CP
 uQb5MQbSf1xi6hpAFcA8WqEzC6DbxmDgE4em8nv/+uq7Vu/Xly7mnl7V7qfMk4MdBwa8EjCqPnA
 nQr7st1kGV4gCIygw+l4pOrNN31svMOU/xl5QdogazBxKQ/RlQgt0lONw0xJbQmu1oXjfi7HyUt
 QS/EN8dSYbfRMtuHL2JJx2Om6RdQPyo2k7GvzFUd9VxHrhMYMINUg15FC7+9vwJ5rTAIzpCIkIt
 WHaft9WL/MSJ8z2pybg==
X-Proofpoint-ORIG-GUID: _qNbkZTVgIRWVufbDp4plVhnMeXGRxdQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfX5UNjZcPMzGnS
 8/vWJ2/AZfLkTiI9zlpPkhDCEk/AmRoQ9BtMdezafR/obWaeRkyamf6VnNBiMJpRz/0xvDO76mb
 tesLsvXREnMqtod6MbGvvWoqkgSQnAw=
X-Proofpoint-GUID: _qNbkZTVgIRWVufbDp4plVhnMeXGRxdQ
X-Authority-Analysis: v=2.4 cv=H6TrBeYi c=1 sm=1 tr=0 ts=6a4a0f42 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=2rxQ3qtc42-NlUa7jS8A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607050081
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

Adreno 840 GPU found in Kaanapali chipsets belongs to the A8x family.
It is a new IP which features the new slice architecture with 3 slices,
raytracing support, and the highest GMEM size seen so far on a Snapdragon
mobile chipsets. Update the dt bindings documentation to describe this GPU.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index dbbd8b814189..d0b7304c17af 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -413,6 +413,7 @@ allOf:
           contains:
             enum:
               - qcom,adreno-44010000
+              - qcom,adreno-44050a01
               - qcom,adreno-44070001
     then:
       properties:
@@ -448,6 +449,7 @@ allOf:
               - qcom,adreno-43050c01
               - qcom,adreno-43051401
               - qcom,adreno-44010000
+              - qcom,adreno-44050a01
               - qcom,adreno-44070001
 
     then: # Starting with A6xx, the clocks are usually defined in the GMU node

-- 
2.54.0

