Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE66CCA5FFF
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:28:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1EA210E924;
	Wed,  7 Oct 2026 10:28:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y6ErBFSf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zh04VuEc";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69F1510E924
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 10:28:44 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jsTa2312942
 for <dri-devel@lists.freedesktop.org>; Wed, 7 Oct 2026 10:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FOTCBGC4OyDLSs0CtP8qztEcifk/SFN1zH0nwoPSTH8=; b=Y6ErBFSf6xe3ZE/2
 gPDCFeu1EbCn5iZUcmbwT60fVFH7HJFpVk5G16Pjl4WD//LhQwXu7TJ0AJpo9qoO
 NICO1rZfV3jQYXfQZF4wNwEKhCvwsDydw+qTP2bJFReeELO/AHNSy1BZ5j4SYT87
 YqoNOuOF4RohzL8+ehdprDNRC1mDuRwQD7TDwx31f8S2Z0Xv6nb3EyLH4sHLTCum
 cghHLcgbB8X8aU59H24DnJ5a944QJh8H/BZ6Q16zNDq2KwcUZcvgpLO59Ss0BlmN
 OWnjoI2eT5pCFziJEbYlSXZrfjVCyV7atCbaumkXVE0md/4EsSLtNhO92dK2YIXX
 f1u+cQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h53asky04-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 10:28:43 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e8fee6af3so4478824a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 03:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791368922; x=1791973722;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FOTCBGC4OyDLSs0CtP8qztEcifk/SFN1zH0nwoPSTH8=;
 b=Zh04VuEcCTtRIHocNJAoK3pIU+aiN1vjPF12PSAQM6VilKEvDlqyczoP6v+PJbbayD
 724Y0r1wHESgyfnRdCJja5p2ZguXYWYmKWcFSclX9nMt/3HQxwQFQAfJBdHXO22LPIOH
 +9lvaRx9ZL6Y4TAYr097TD/DxbyoAkUbmtKTmliK2Sw4mF3sNN/tNDjP3pik87/l8n8H
 I8+US+w/+VxkhEjPb43KEd7jon2ra3SeRR45t4EXVnGoXsJCkEPGCmixAPW2f+6lFixb
 siv0buJyGLpwKFRNSPMkh3Z7T6qetJnHdIZh+yGV7zAguVI499dwaW4wGkFQKEdKhuEI
 rEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791368922; x=1791973722;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FOTCBGC4OyDLSs0CtP8qztEcifk/SFN1zH0nwoPSTH8=;
 b=hbqKCxUNoqT90h3CQAX+U+4pceLAnAHaDQayv6Ts6/4Dxx2YQCKVCkdBTUNooDyobF
 SHXFeenVnrRMKNPIgdLhhHAwem3d1D/vDLTo3CqRPPv+s+p1kqPwmR3v8nwfBZjDK2Rf
 kaI68KSH9u5IgoXJrYCcyTiusq1rnwSn047kZZDFYC/l2PvIp28nC6Y1U3HuaAHR5RNc
 dJ1eRjSQQhgAw9nI0yPNYP1ZuCXb2EvaipJB4pqb7fniQFzUq2w6XPSyGo6BnGpOVFIv
 qKnK/0wvionl2ONybk0m4XIs0lfpInoSn4hCdGxB69vnycfWqjYmfsl/dENJ1sjJz0Oz
 DXtg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxd4a9UZz7KWY1SZCsrMZ2yYZWfxIMpEewykPCLDr08X/7sqO3qTctA12IixwsANli+kXAoezW3VNY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLWDaV5axUtLy3NWGS7IJPJLylOvBTn9JVqJ/ub13/38yutSl6J
 6bJcwftqYX3gjBG7LF52wqvuBK8Q9nuGBbNdcaNsLT5wyYsmI8I1Dgm4bEWDWm7uq06Ud9YTmOs
 ca0zAAGzS4ujExzGtkQLGysKJXbBOiDeNrZiBkdWVvqijLyy/sg8Qv+0l5q+vC/IYJI9cO1E=
X-Gm-Gg: AYBFou2xKVcMvSvhxnzu1ABMVSYf3mrNKa24KwgLn0cdC/L15lEC3C4aPU1bTtexxev
 jFJj2Lr1HnLCtdevXzASSZtMkVZi4h6ec07qsHU+OgK8qzg/3wJoar2WJpgKzgF/09J64lrOb64
 3GtupK8H570nQ+jd6OXUnbMYJsZE+fNhfa+5spDa7nGgu/Jpw/nWnm0TDSMq35J1qEi90htxELc
 JkS1q3kg6DG5VSQej96e3XWxiUDnHhZLTiqSiE6+R3meIULsPqXsmfVSVB8KNG88LfNRN2nz7m+
 wYMY7cNqwopUmLn3OYI8ZqBSeFBk8kk1g9CYwl3xDcSoqFuZLjwgGpJrg3HwZ7bahhmKOrG/TS5
 LPOy00ud0PHvUjxXLgYrn5M9GLDguENUE
X-Received: by 2002:a17:90b:1dc2:b0:39e:6c69:f472 with SMTP id
 98e67ed59e1d1-3a8a1d31ea0mr1433393a91.49.1791368922474; 
 Wed, 07 Oct 2026 03:28:42 -0700 (PDT)
X-Received: by 2002:a17:90b:1dc2:b0:39e:6c69:f472 with SMTP id
 98e67ed59e1d1-3a8a1d31ea0mr1433373a91.49.1791368922000; 
 Wed, 07 Oct 2026 03:28:42 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd0a8cf2b69sm1221334a12.8.2026.10.07.03.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 03:28:41 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Wed, 07 Oct 2026 15:51:17 +0530
Subject: [PATCH v4 1/2] dt-bindings: misc: qcom,fastrpc: Allow hex digits
 in compute-cb node names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-glymur-dtfix-v4-1-31f7143e759b@oss.qualcomm.com>
References: <20261007-glymur-dtfix-v4-0-31f7143e759b@oss.qualcomm.com>
In-Reply-To: <20261007-glymur-dtfix-v4-0-31f7143e759b@oss.qualcomm.com>
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
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791368909; l=1332;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=P1VW9qZNU2PO7nWf+4SbkVXbQmsxX5uacMO6IpPd4mw=;
 b=smBQGNatFn9Bxb26aYoMObCnLN/G4HYzky1mfOra2NHk+DqpzZ0ZkhO7kADLXBQGVIZMn2xoe
 EAxmNzYkB9uB/p7hpdDjRO14b/QGtQbVfsi32m5sxVUyPT5GtgGbe18
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-ORIG-GUID: VfZQbjGDTAE5eDY_igQcmDou8C3F9I7L
X-Proofpoint-GUID: VfZQbjGDTAE5eDY_igQcmDou8C3F9I7L
X-Authority-Analysis: v=2.4 cv=Xt5vqlF9 c=1 sm=1 tr=0 ts=6ac61edb cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=C3F15k_13UMA7PaxDcEA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0MSBTYWx0ZWRfX9asnRYcJPIVq
 DH4NIKbyHR2D4nNbdBT/DUabFl/DlO96gT85ImxwXUSB9LxZAXd0PSU2JniI8UIxzm0YQUDcwdp
 IFBQXTn9O/Z8y6XAVY0djf8JRBrrFGGTbINjqbwBm1Ed9ScsRoAmYDUqavkduJmRVm1YU1+t1GZ
 HMTwTWNCLL3BnGweuue7A5WJbO8ZM3ImmBSSR9TV8G/pOlv4BRpkPE2Is/XCuBmcs5thid+m1G7
 tYXuZGRZ4daotcvkOFMv1HOokq+S+2OqhSqqVYp3GfUPUNuZgzWNPnYe7AdMCGvOQezg+/ZSZO3
 lFPr48wfL2Ii4nhtu5Wn83zqhIZ8hA1VoDCICRwW8Tu/6SDVa5bpKVa8Z2OUgBUXwZxr9eCsQiI
 TmbKRZifgSx0beiR1281KqcByy6FHlvHKv5XxWRGV2AJu7xVS42Gy76zcGwSz5/UAMZJk1xP29T
 YSneKe3aFhenY5UFOmg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0MSBTYWx0ZWRfX87h74CXISrOF
 kpm6GDGgopn2OGLzMsxhnO1AidYjpb/tq3X4r1PkZkgawKDmkzPm6DYN9/SRiNU8PGuEsOoJwbi
 gCUIHp22/ZyY8Agl0w3qXEw8ClDN+gU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070041
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

The patternProperties key for compute-cb subnodes used [0-9]* which
only matches decimal digits. However, per DTS convention, node unit
addresses must be the lowercase hexadecimal representation of the reg
value. For compute-cb nodes with reg values >= 10 (e.g. 12, 13, 14),
the correct node names are compute-cb@c, compute-cb@d, compute-cb@e
respectively, which are not matched by the current pattern.

Extend the pattern to [0-9a-f]+ to allow lowercase hex digits, making
it consistent with DTS unit address conventions. Also change * to +
to require at least one digit in the unit address.

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index 49d2a5e8ba39..d9444f452585 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -79,7 +79,7 @@ properties:
     const: 0
 
 patternProperties:
-  "(compute-)?cb@[0-9]*$":
+  "(compute-)?cb@[0-9a-f]+$":
     type: object
 
     description: >

-- 
2.34.1

