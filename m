Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C038C5DF9C
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:49:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EF7310E6FC;
	Mon, 24 Aug 2026 10:49:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gdx2D6s0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d3r2Z2EH";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A4B210E6FC
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 10:49:38 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O99BZl2900594
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 10:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7WU/VM3Bj2X/8OfKuOyPEmSZ4TMRuASXVohpmslL+1w=; b=gdx2D6s0AgHa5gpJ
 FHt2e9cLpJa1eT8hIKmdS+MDHfoMZIjr8CLDRpGio+Pd3Ll8PlAW0OyEoUHRiei+
 JCZ8/lockj8DVQLZJax+LF6fd8nX2FJ21LNKC6d4cK7IXTL+kAGIybN22q2ADahH
 GdpPj3X2NJAjJ48YogqCwHd5yC/yxqpykq176471Th71dvlAwjAsAi+Cgap5uIdt
 VrWODHROI+espcLui9/DtlLunliiiVr9yvHRTazucN0NV8RugL/f4hs9Zsa6sRI6
 wSQ03FoeaQenz/YW7GuEI0jUj8d3dFHrX3kGbqwYciQc3Yg+/T7JMJc8NGK6Lyvq
 qtijKg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8hjgrv3k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 10:49:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-388cfc4848dso3327669a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 03:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787568576; x=1788173376;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7WU/VM3Bj2X/8OfKuOyPEmSZ4TMRuASXVohpmslL+1w=;
 b=d3r2Z2EH44pVF8qQ5bIYtpB7Pc53tO6p/fWbos3yPkl4GqAyaZMlDVk9y8cds8X2oa
 I7W5wyI3l3bt9krFx/J0wIxjwzi8e0EY6gw3/1fQFVOLLKySWqNf28OJxqxPzg4d9iCN
 t4zZEtEcWfdD8rrRL5ng4dMn7sZqCGQXgcvAA54KyczXdTdexfg7lIy0Jo2Er7Q9CJ0d
 6i9nqSYaBLSy9VJARRSmLgA4ezZm1IJSKg2zEJ/oAAfvhBAljf/LqzRHFLuNv+tlHlFk
 HR/HBwp1uZIiWvPIK4wiyHObnndml+Moy2IbFefnwBzms2z14mDDt7Ldn0FzH4BmJXlk
 QXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787568576; x=1788173376;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7WU/VM3Bj2X/8OfKuOyPEmSZ4TMRuASXVohpmslL+1w=;
 b=N5dJO0StwnGyYoYDZt23UKpVu+y3nDE5PU51h4GUOX1jsOH6qYnYdEOxHJE3mnlOGb
 kKdDBvDY9vm4aVxB34iZwCxgVKvqbYMPWXbi+l1zaFKw3l3ugNfUDLqK5RmaPTFm8U+O
 MgBPFU1oZbWdz9Q+eYeKtM9bCgf19BsccuGcUs1a9VeYb7atjlrivrt6dtux+6TetLbx
 rJ53vz/kw1tEVu+qaGp3DbSV4MnYSdEbNrwvymfzjCRddXSn+JNZJVs7qk1JALpLvkAw
 2wV44i15tBfoQ3EMBJM/DdCzleqJmKZZpA4rrhfsQxJwl30eok7p/B8MlTJGIC4js2Sm
 dXCg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3K8NMzIlueOrHICdjXjDeYGcJkonlXnGbNiEmGGiLeY3aIk/7+J+PEQC4JIWu7RKfkcEuPEIG4TA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nnLaEVlAtRNxwODlVb+k75Br4UkjZpv7dXe3lw9gmMrbIcRk3u
 pVufO+QofYVXuxcO7xFFCe9LVwYvTkGQUg1a+D0s69wn3M247kP+hpA4E8czH8eq7wcd9iZHjPj
 9FJhKI6pomu+xCEXOWCep+D9iprNLesGUE2LyN3eo0Qh9pNcd+2uevc8vPwvk1+LTiNya4zA=
X-Gm-Gg: AR+sD13/MA6XLEjybjp0lBgIW8EXS1wn8pGmkf3Q8uufLK0VxX5m7YuodlchbHPOFUx
 JRbcmVtYMryDRBtji1HBH7LNjRyjFF6AB247DcMC9domgXvsjcA/VPmKL4UU+UU+LoET4iKvVbb
 51I6agpLR525YS1jcQQUA9g/sxCosQGXCkI3Jk5nMOgIuk9+vw+C2HRKf4kTusCTcD9QkU1HVBl
 dTiG6NXkrVZsA5WRg0bCiAtDM1zl6AtYIG0+hpiGJJUgPMaCyinnWvakHxFytSm5FAUDCfAFW7G
 Z4bEEd2EQ0SD4VYP6E3x6trzrlHndLOQ6LA+gzmU6n48pjxSFTuRYKJxc5VexKAonWxDEuIYkKZ
 jeWMtOEOOBBbF/vlFshQJfoTiH5SA0JKcUA==
X-Received: by 2002:a17:90b:57e5:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-395c35f0a79mr46724259a91.14.1787568576108; 
 Mon, 24 Aug 2026 03:49:36 -0700 (PDT)
X-Received: by 2002:a17:90b:57e5:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-395c35f0a79mr46724212a91.14.1787568575679; 
 Mon, 24 Aug 2026 03:49:35 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c91ce453sm4125829a91.4.2026.08.24.03.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 03:49:35 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 16:19:07 +0530
Subject: [PATCH v3 3/3] dt-bindings: misc: qcom,fastrpc: deprecate
 qcom,nsessions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-dup-sessions-v3-3-4b019def4e0b@oss.qualcomm.com>
References: <20260824-dup-sessions-v3-0-4b019def4e0b@oss.qualcomm.com>
In-Reply-To: <20260824-dup-sessions-v3-0-4b019def4e0b@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, devicetree@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787568554; l=1158;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=rNneJT7obxjP1X1Bry3YcWYR3YdUEBRbf48fYw9g3dc=;
 b=UajvJt99Ve5CBv8s1vmGRXSwD6/pIsPjTMZPuuM5ulxQajMLTGSypjoe2PoSZ7onOB+az7WrS
 x86SR5EPYqECTHubX3g4BkIT9Df/XGR35WVFvO9m33LzsxoEblQ2/2F
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5MCBTYWx0ZWRfX+N/MKY19UM4d
 gXuAHu/jFIwPNSxn5OtU6bSJZlavCaDSlN5FgoSDILaZjjEybvJbBbdSZscNjk/ILQ17J3Ylr8Z
 UWdIBgy+4Swtbc5glFP0di3cAwU9VU4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5MCBTYWx0ZWRfXxXzysvhYU6b7
 RtJtfLxoaFx6V7PxNpv0t7dnOeGI2fp/3HgxCYpPKAdXvGAI+sv3e5Bf6I/pl1TUJGVMFPs7TYb
 nAvsCw1Ucd3eUW+J7sc64KembwOIWI1d4a9OAeKLXhFzUL7aByd1D3iGqjtyRlC2ZX+Z3SlJht7
 tpEHr6jpWfaHSR7XnPXidJHAiCaULjyyPO78cLg+XDPfG9MMDVXQHmcdwY3IQxnA4KRThgR3fhu
 Hqztylko9LCdhbOXdQcyRHDOfzyzoADOPRMtbeLRPPVEbxZeaDtxJIrXU3QIwnNQFS3VcFnWcMO
 Y/PUStxuKMZttnWebDRO8pnU5wnwcDMvMtVLIFCjjVXL4OlYfhMKCwc6Dul27PpAR77w8OFvx0C
 FYHPOfIbgkpNst8nJ7O1sqaY2SOlKIO0KidtP+kG6TgAH1knvtqF32bMpe/e4+q9r7uIGzyjV0j
 EhJRcqpAnLVvbP+edPA==
X-Proofpoint-ORIG-GUID: 6yRz5_kOrOJ8WfFRfmW-U3_GPSVSLUA0
X-Authority-Analysis: v=2.4 cv=CoCPtH4D c=1 sm=1 tr=0 ts=6a8c21c1 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=e51zU0WOd6sbzzcJbsAA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 6yRz5_kOrOJ8WfFRfmW-U3_GPSVSLUA0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240090
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

The qcom,nsessions property was used to duplicate FastRPC sessions
inline during context bank initialisation. Session duplication is now
handled at the driver level, making this DT property redundant. Mark
it deprecated.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index ca830dd06de2..683989c468cf 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -96,8 +96,10 @@ patternProperties:
       qcom,nsessions:
         $ref: /schemas/types.yaml#/definitions/uint32
         default: 1
+        deprecated: true
         description: >
           A value indicating how many sessions can share this context bank.
+          Session duplication is now handled by the driver.
 
     required:
       - compatible

-- 
2.34.1

