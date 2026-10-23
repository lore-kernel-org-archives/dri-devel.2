Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79E7606A32D
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eEwgp8Dr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Nmf51nDS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43EFA10E5ED;
	Fri, 23 Oct 2026 09:03:51 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3FD9112A57
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:03:39 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7FEiE1767242
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=A+8sjnjyCG/
 D5KCtBy1/qNiT6sKxNkDnINIvcENVECE=; b=eEwgp8Drg+K8WQqaGVgHPFoYH7m
 ZelowxguDuOG10m6kMBEkuwf1fTuo3DJ2HCfMaWYxJzvm3fs3BpIvTHw8w91OAyZ
 CHS5i7cuf6KUCmEB3uwdR7N+xei4rlA8Qx1nTZwb0gPsDzNj+QqbBnaH1lyl/8xD
 44M5sbQN4LSSU818uZPd1ciynhIcNw1tF6caBwXgA09/zxJaeoNIgZ2OlUoQH/oy
 zQBLxsc+d8O0OR/0Pp5EJl34TrOC8kTcmYk9VUZ3X92cgx8uWexF/WFpZTPRstZC
 NYonkur4H1s3tMnmGOXxnXFiA3zArRbcnX56HyJ8jdp7Vj3hNoU4e/FVO8g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfpahua9j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:03:38 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cd67d4bbdffso535615a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 02:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792746218; x=1793351018;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A+8sjnjyCG/D5KCtBy1/qNiT6sKxNkDnINIvcENVECE=;
 b=Nmf51nDSdULptz1ml93oU+LJi/wU56E4iQ3YYNxty46IlcRhO4lFgKow/JKWR4BZsU
 T5/DKeMXPD5FJwtARzrxBG+2cAYDiqbUbnN8eMP6pBF4GgE/Y2LhCpst2weFUPnfwplf
 hh0RZvKnG9sniVLwfbEaIuNsdLtT8x+5+Ixpkh1UB+Cm0NrHst/zqsF0cnsn1ibcH4Lz
 LjYrWiA8QiSaATydjQkwXWIzMFEy3HIcQ/uBYHFCyHpHCl4VVOor8JfNkfSjM8Y/fwTP
 2mnK8fMZf4G3zWN3niNjBnJRgMjuVXqKmtF5iLK96zoNd0P0D1qnWJG1G2ixMKMYS85j
 9nqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792746218; x=1793351018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A+8sjnjyCG/D5KCtBy1/qNiT6sKxNkDnINIvcENVECE=;
 b=lfPzkkEv99fVWQe9hR3r683U6sHMD43Q3k//aJpAb8JNIVkJFYwDI0vJ4WYgzAnpKO
 xXnK27IyMI47K0VhaHCe7OHoxHIub5G8icIFpwW78J24DppG108Tgse48clbLuOP4lmD
 L2kyMvdkWDDHoT05IDDD3B7LptgfJIXzJoGkDG4ZM9bOh6D7KI5D3Ha9zQyVAdl/4PVu
 dHLOdbfj0cl1Jy/yS+SwkI77L0Mu4h8zDr5Kui+/s65s2CVYkFJ+JvLlitoGP3FN816G
 2inid2uF4SIbpk/uahe6gDRhYU0ZsLRIvWg5kkyvLHtgJOKg13/WXim+7ddLvmvbA0vB
 Tldw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDOYqaaRhIYjp8pS3VvnpU3hwltyJ/GPLN0ziwsgiLvSOSdD9ci/IrigiHJ1HH5yLvm6BLmsFfvTI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLgfhUIpu0oNoMEaHuFARgu4j9ZTlZT0jcKK24+NcmM50VuZKmd
 yQBJtH6Kwj0qYutXqVMq+k+EEK6pQgN6XyyzoaPCcUkp3UVN+H5nq/Oz0pVPHBT2UJeg88JOSe/
 HmFlU4u8gpcPTfdGTh+sQxtUrvVeOe4QmH1nHinBSqa5CDAZV10Dz23xC/9jQoNd2TABswpU=
X-Gm-Gg: AYBFou3sjeSb34UppkmXVb3qkS77TxBIX5AbZ2gZiSdK0HBz1QLj38envGnCNjkVEwK
 M2JNj5hSO6xiYxYnp9Awzj3lD7bHUhxwufKlctb+jupVlq9JsByXfuMqRClilZ9Ty0DS+uwA6L2
 S71I3XKBqtk4drlU4b9IJ9AW2gOrYhycYaYSVAyixNxuhsyrNSoMTyqAjyCpG6sOYeusRLCuNps
 3hEyxO7v5qrh+SfNjA/lgr/im7ggmhL4s5C2mKWx4syS9FsQwWjPk61G0XWAla/1Vd5Fhs3haNs
 dVauOmNRU+vFMET9vGfJLCa2Rq2XvHsiNHLC8hcnqzNF9UjmM9/82zrgGL4oijgBHg6H+O4uF7u
 gCjJvSPSOnZBQKqMzFOlesebBhH9tA6splA==
X-Received: by 2002:a05:6a20:a11a:b0:3e0:b937:883d with SMTP id
 adf61e73a8af0-3e3692274c5mr1250212637.25.1792746217674; 
 Fri, 23 Oct 2026 02:03:37 -0700 (PDT)
X-Received: by 2002:a05:6a20:a11a:b0:3e0:b937:883d with SMTP id
 adf61e73a8af0-3e3692274c5mr1250183637.25.1792746217241; 
 Fri, 23 Oct 2026 02:03:37 -0700 (PDT)
Received: from hu-parihar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd8ba69ca4dsm586273a12.0.2026.10.23.02.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 02:03:36 -0700 (PDT)
From: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
To: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
 gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
 arnd@arndb.de, stable@vger.kernel.org
Subject: [PATCH v2 4/6] arm64: dts: qcom: sdm660: Remove FastRPC compute CB9
 entry
Date: Fri, 23 Oct 2026 14:33:06 +0530
Message-Id: <20261023090308.2898683-5-abhinav.parihar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfXwXf1pMUuO/Bp
 +8Des03Mth2GvYDseNn06d5DxNA0mHpfs1dybt9JSGzKdCjd8EtHPI+gHVJ8/POXTv7FMzBopz1
 je3jr2206EehdZNCfh7fdCGS5rS2b5Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfX0eLOqEHsymnY
 s8UoRvO6VT4NNoHteUbD5yOxWC16LkkHA5KeTiCbhbsOZo/SLzQJjNN4i+6UEnrNzFXog9YigBB
 KRFLk10//mubixJ/E14T22mOFmXv5R0BDTTo/jDfMekfVFJymljTZWTAvK/6IGIvmvTnQTPUPxs
 +to/0FY1ydYOu3H25jLWmu6Cs0pDNNHOWMEJuwDd0oQl35WmRcmoPIqXgiDHyMVpi7fzrNTBenC
 quf7XkuCKENlKZ/QZi+/ZKBCTyqSIVBE3u184qAS4rO7L8aCr3DSjrL/VON3RXPpxLqgw3XXlEJ
 8RQpNrAMLH7+D/FXpARqI2EHdsJR6t6fJPw7A6PpxXRtcHATvhIoMWgobgyxP+S0/Iyiv1IILEG
 LU02n+YuE2NW0WmQweA2e2TLqr556Lez8pSbxXYfQFMWvx/5tSJbrk3JYO9N6cd48tniMqA62Bm
 INViEySWKxR4aqzAemg==
X-Proofpoint-GUID: 4fS6V76U2Owqoc6CMHqFm56W_64Nkd7P
X-Authority-Analysis: v=2.4 cv=YIMKWhGx c=1 sm=1 tr=0 ts=6adb22ea cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Bp0rkiFJIKxNgHgNeN4A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: 4fS6V76U2Owqoc6CMHqFm56W_64Nkd7P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230035
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Remove the compute-cb@9 nodes from sdm660 device tree to
prevent clients from selecting a secure context bank for normal FastRPC
workloads.

Secure use case support is not currently implemented upstream.

Fixes: 708ab9d3bc5b ("arm64: dts: qcom: sdm660: set cdsp compute-cbs' regs properly")
Cc: stable@vger.kernel.org
Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sdm660.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm660.dtsi b/arch/arm64/boot/dts/qcom/sdm660.dtsi
index 0fca9662c64a..723bffc99b67 100644
--- a/arch/arm64/boot/dts/qcom/sdm660.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm660.dtsi
@@ -386,12 +386,6 @@ compute-cb@8 {
 					iommus = <&cdsp_smmu 8>;
 				};
 
-				compute-cb@9 {
-					compatible = "qcom,fastrpc-compute-cb";
-					reg = <9>;
-					iommus = <&cdsp_smmu 9>;
-				};
-
 				compute-cb@10 {
 					compatible = "qcom,fastrpc-compute-cb";
 					reg = <10>;
-- 
2.34.1

