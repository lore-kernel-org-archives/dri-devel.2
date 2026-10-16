Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90671CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:37:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2F6F10EC4D;
	Fri, 16 Oct 2026 06:37:13 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A79B10EC4D
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:37:03 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69G6BRlI4126406
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uJHfsFVJSJ7+ACt1yGwBSr/SsVtOFErQhNFKlR3rnGI=; b=C3eizn/ftp5Npt00
 0alqYppoxsqeQGUUnymowE0Qb7fUkpeqlboJRQqeoWgTm6JoJnvcjI0iSmP0kRck
 a3tGTkZ2qlYMKyv9XbA8akMQgTACcTJVnIL6XN0UitrC44FJPP4paShEA2gHsSrq
 mMJTFHRZJlmtJaIgHFSYgxnumUlyjpZFiwMVb4o1P5dDeBTx8A/vZhoW6HsShvgw
 uQ+bq1haNbPCpe1p1FXAncScNq+DGCaWT74rj95NK++Vrsd6fK2kTxONZ00RqYwu
 09KISOk7ZKy63ofusDFWar9jwjgpAqMbiGSHBdqqwh3mlC935DZKfRrLZtzmmxxC
 yeBNWw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb19m33qa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:37:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38f97b3f853so3907028a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 23:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792132621; x=1792737421;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uJHfsFVJSJ7+ACt1yGwBSr/SsVtOFErQhNFKlR3rnGI=;
 b=WcsAzoc6rc3y6eWVZH/MCK33xOh+JFnkFeNqqHfx/r6D4ve54s0wF0qMM6Dk5aMwa7
 vpVruIKWDgO1QMZgfWGEKxfIW/M0i453NnVlOOCwWtSlo8i/IdbzSpjNLfEtn+uic5cK
 U1bwLGmiV4aFRoWzeHHSIkjohPWFFyqx8vDt8I3HyVscKhNU9kmfJNvuq2TUT6b8nRt5
 OPVz5CvLsneTRfrAU3T6n77DpSZiP3X6mfPg9kUHHv3hSGLPYqKFSZhF0LgGd+cNLMNN
 uobScu+ll+wdjB2EDTrjENR1dqE+Rh1CiANdWX0h9+8q30Zs9OyrbcB0WQ9MIzRJGsVb
 A4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792132621; x=1792737421;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uJHfsFVJSJ7+ACt1yGwBSr/SsVtOFErQhNFKlR3rnGI=;
 b=KtA53bhRWwMAxbNwb15wFKKvV08tHr6GmJ+ST4c0U8LQ/rwjMz9sfENnhlnJ+cG24X
 ifRp5F8TW6X62JgqKNHVmKBYD3Ysy9EPeYTOG1XFjZUWGeU5izrKYIYv2QG4ZgbL9f3K
 JTSgCg96idbWPZfDsmlmU0GDx+AiE/Fu+UAvMV3c7gRlJXBrCpIQ0dA+dChuk30ibSMq
 Mm5z419JXslnPSP7BQC7DucyA8VPXUrT1uS/q09H2+szDzQ46XxSJmJia7KC4ihDXkrl
 dKU6zB3hJajtDSnLf30sLpChORMvW/GGfc3l/iD5rPOwakjuzxhf+YolCE6D++mOX5lF
 Rdpg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwBhNN6rSD/ShzMW6YF1cE+mS5GIwd/1H939Ky3vWMXgh06TAD0LQ0B+g1Jk/TFnzUgmGdy+7Ie/Us=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKPx3vagTh26e2hB9Fte0jK3L8d06ew/8b3AgemgAYyPrb/Fesf
 aAC3XTQuvHT73t1C97/p/SIJvOvcSYVMXWHaouv1EcUmqCtgYcYJitYqUoHafJQfo0QM6a14Utp
 p0mzENBry0l88QFw+G+cYLcHV7r2BVWMyul9Nm0KArh87JNTuHBjgcKlHNVg7+dRlAlGtIHQ=
X-Gm-Gg: AYBFou0bQuqhz/eysSEw5m1bd/rpdRFGXlAhP0L9h+yRCve5T2z2JkmOz0uK5Fwy0ti
 8LROeSW7px2z3gq/0wM2Hzt/4UiOkIQv2GUr6eutjhbSNQwl2zvKZ7Nw6HU/iS0E5ENqLedyCP/
 3z0AuZuKd/f0Uggwa57wEEalBAy1lXjgbXGRnhq/6j6p5/Zt9/rthmfT/YDhonvogS1FFKdnIjv
 NNJShEOmipXZsoLGDrh5NTRfSfkYQ4wqFOEzUZQQ3Obx2TdoRbYIjZZFZPFxhNhegQbSIT698+C
 AI6YcmQFO4+2GCoYqyMuUGLKzXQhr/ZFvUavnL+ezo8stlprcNEC0+q6ck9cLUv8hYE664ZmcP1
 UWeZRXA1I6SS2PN319C35Rsy4VEEHlVY=
X-Received: by 2002:a17:90b:3cd0:b0:3ac:7377:fd4b with SMTP id
 98e67ed59e1d1-3ac73780774mr6795833a91.45.1792132621342; 
 Thu, 15 Oct 2026 23:37:01 -0700 (PDT)
X-Received: by 2002:a17:90b:3cd0:b0:3ac:7377:fd4b with SMTP id
 98e67ed59e1d1-3ac73780774mr6795818a91.45.1792132620784; 
 Thu, 15 Oct 2026 23:37:00 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc43a1e1esm2703298a91.1.2026.10.15.23.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 23:37:00 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 12:06:46 +0530
Subject: [PATCH v5 1/2] dt-bindings: misc: qcom,fastrpc: Allow hex digits
 in compute-cb node names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-glymur-dtfix-v5-1-f56a8b94b4a9@oss.qualcomm.com>
References: <20261016-glymur-dtfix-v5-0-f56a8b94b4a9@oss.qualcomm.com>
In-Reply-To: <20261016-glymur-dtfix-v5-0-f56a8b94b4a9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792132608; l=1379;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=WTQqvgd5qbzY9TUSBvUH2oDxa2Jq+JX02wLUEi1lOPE=;
 b=Mrc9IOZWEdpsXnqQNzy20+D0ruDEPXdge5U634vqEFW/HR+Ap3DGPiVwYsvFOtQdBfRLWY4DE
 GaUdeR/eXxwBviLDC0RB45dDWECj6K4dLSB3+VS/R9t6s59ZRwVTuu4
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Authority-Analysis: v=2.4 cv=aLdlOr9m c=1 sm=1 tr=0 ts=6ad1c60e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=C3F15k_13UMA7PaxDcEA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: O-o1aC7YgEqXvE8Wd3giUVVLLT2AvpzG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyNiBTYWx0ZWRfXxsiWQQi/DmJ7
 sxgmVY3ZTB+aNvzqxpxWffO7yFhxMjQuT6skGfPQQkU2F1xHPFhXPlp1s7z5nlAktS5nPkGHHqi
 0an3LtpToPW5ykiyRjhs4HKRUfBqwW0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyNiBTYWx0ZWRfX2YziAQtuH436
 IF2Zf3+sYvUoCPMsJp+AVZxI9LjYK8dPdXIOiJnA3oImkdYtMKHKzK6xP9ZvbheuPn6AW0wmj6e
 ywWeh66ofBGLkXHVOm4P4cCpkpBJg5P0ts4ofgggGWEMb798smYugoPtDaHuPsqcjRzYtc9OwF5
 pUgqTglm5stnHe7VqRKPprHKqwnw/d/SBT7XukyDGHbyc4aEzoem8guAU+DSiMBOWF+01An+iOV
 NVjYa1KflJvJ5sL5DZXithPsiqorGcp0UES1nmL9bC3GeHV6kveLfxk6+CBI8iUXuPf8hEIPIOB
 1Veqr5iUYlguKPaLCFq9759xOyUK9/70N/wILlUtFGl2NsR4qsKaFVOCEfADX+7WFpfNsuRrbaa
 F4MbTgYDyaq5BGQ1X+2K7kJdfsuICo9SQRPpNM25QHpxaZWHLyfRTYx397TDhynVKEERrn6FdCk
 pCY6VC5TugsLv6Z8Haw==
X-Proofpoint-GUID: O-o1aC7YgEqXvE8Wd3giUVVLLT2AvpzG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
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
Acked-by: Rob Herring (Arm) <robh@kernel.org>
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

