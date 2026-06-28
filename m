Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E548BC43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 18:25:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B1FE10E66A;
	Sun, 28 Jun 2026 18:25:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hWe7bG0B";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CCMUeCWK";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9498910E675
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 18:25:32 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65SHis94439983
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 18:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1yFPVvQy+nbJ2ioSTODUoUgdioi73DC3iCTsISkzqNU=; b=hWe7bG0Blx3TxZKG
 /3NGF7L60JZiZv7jEdJ4S58RdujNMuqzXO1DdXy/pWSeSzUweKBPn4ZUio5YnVS4
 c+gukrkN97b1o29twJ/aoJtuGuNqJpaItu3bW8H/ne72D2Fn8AGFFbTRwwVQOBEI
 flY2RxtqnY0iBxGkENK9F2qPN/9E+NZ48uVSV0FYR2Kt/TfriENoviYYZsmZUMaC
 R0LgTzqy4vuFf5DjQl6zodJXTj4+CcBMMZQRgQvYEDEZaYIMihVAhcT0rboBvBv/
 M/qIf3FxptGh4XX6A6otiuFuXjxclgugTP/FZtrxKJyHkazbtJ+5F6UBWVQ0jK/5
 tS0olg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f270a3ee9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 18:25:31 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c0a27ad86so5675555eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 11:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782671131; x=1783275931;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1yFPVvQy+nbJ2ioSTODUoUgdioi73DC3iCTsISkzqNU=;
 b=CCMUeCWKBQ/5ZddnF7I5CNN/BR2ebSTSUy3AJ++g23LR9gVQqzqBvcVuBfoDKoEUVu
 xmIxt/xKTXdRmKcLpqcp+giSTBpDrynBcimgRoI72QBc7KAEnjQ2i1Fntn0dau+1mmNK
 glXnzJx0XrlfHsEWtjVccE2d2Imbndfueb/8CZESnQdKn5We0w5Koj/jDuYMhODAM8nw
 sV84vQkWAzvXDOL+h1udMHP6uALHSD3Quwb2vRrfbsorcd5pBAL7HMR+odIjnYm88QHN
 A2aH/0UJdVbGgSO/JZFf/rvphYWRDJM4+4gk48LtIy7AhRPj9jeVfVUinDGTcqFX53gK
 +DJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782671131; x=1783275931;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1yFPVvQy+nbJ2ioSTODUoUgdioi73DC3iCTsISkzqNU=;
 b=jseet/i2qaqc8Ea0nHsv/k2A1RkS2JXw41ypw2I1+SwrnpX0x8Bu6n87WktnCJQ8rW
 e8A4sOZwJnAPFSXIXSmM2JYsqtQ5XWSHne1CW/QVkx3RxzTBjBEV2AH09TgGOnySEk02
 97GlZATAYp99q96CEqts3nNZUXndlEdVWLFqk80jp1W8JYpbcGV7JC87oLkhHsMs0ICj
 aGLWP6SJVAwSQYUwV92Q5GOlfAuOa+2efqG89uE5dk9LMSeZ5oxtZfXq9v/zbO4OwtOE
 rjh8QeKt8GsfzmPjry+ORY7Z1ktbA0rXuxUfqbcB762aHvZt5iZA4CylGGyN6pHxoYLo
 8s6w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrWJB0aPboa3FAwE+Es4WS1NqFUrwQASonc6sQTWMartD8gH2v6EdrokWtlTNWZyL+7M3dEaYlivY8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzwKZSSyttiqfN0n4z5fpA3sSclLwqP64f1TmB3FzXksJ2aUZ5U
 VA0GE0CbZF7kJq22jAJgvhUszNsnCyHEhR3NvknN+5EZGNIN38/FOvhM7G8GXj3ENx7NLWLktuf
 BoxZEE5oBYRdx65KYr6hAd4BIBEb40/e1yC/i1VXzjcM1YDouKM+TN76I0JNNhRM+62r/pHdM9A
 I6GOY=
X-Gm-Gg: AfdE7cnVC97dWYecTOL/WdsvC4ZogXSnoNOOhRytqamSyMIrt0dnWCJPpeLpb2l+mM+
 W3vFEx2dZl6YZUZiM8usXHZT52Me+RnMq1gecvZ02ZDyaklWWBW6kXOcpVOWHoosC7gdclLiv3d
 AywlCs2633OfaSq+PmKU8wHe1QW3TEroL678pXQVWyEQaTZtEj4GJ+Wn+BrrrOGUA4kZ3cV0AYj
 6l0rWwGKwlXfhskHNLwKSghHLfV6UvJG5AycD5JQc3aKbxrY8alvF92eij624V3Yq+JUtqtFpe3
 8vEqHS32zqkZi0sJntZIM0QlUhwywtUOQvOhhkUelkJ9mtyCjiicwBXz7NE48C7NKijR70QriMf
 clYqj3iFbuRls7R1E/avSqQ6jr3RjGXJi8WY=
X-Received: by 2002:a05:7300:7308:b0:2dd:c066:bf7 with SMTP id
 5a478bee46e88-30c84e2074cmr14238228eec.11.1782671131357; 
 Sun, 28 Jun 2026 11:25:31 -0700 (PDT)
X-Received: by 2002:a05:7300:7308:b0:2dd:c066:bf7 with SMTP id
 5a478bee46e88-30c84e2074cmr14238195eec.11.1782671130794; 
 Sun, 28 Jun 2026 11:25:30 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1a75sm37508218eec.19.2026.06.28.11.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 11:25:30 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 23:54:01 +0530
Subject: [PATCH v3 8/8] arm64: dts: qcom: shikra-iqs-evk: Enable A704 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-shikra-gpu-v3-8-9b28a3b167e1@oss.qualcomm.com>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
In-Reply-To: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Aditya Sherawat <asherawa@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782671052; l=802;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=tzXgoMGOkByneCJ+ZG1Kzo6D2yqiTmTiTrurOKuJQ0A=;
 b=vOMsC+RkFWKODgCcMX87UqVP576wC8O1KhQFPbBpZ2NKXQ8EKjv/Q1fMsAlmqzi1jvMj/Q46a
 9dFJbo/MADYBvWrmlNIu1gp4R7A4AWiByduT+jS6FwKt2dNf5omb2ZF
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfX8uFQJyGOTaOg
 0KjpEzLyxvxv0tyCsnSFgH54xQlZ7+IybQwXkG4ae/eHR8fr7RZ7/v1PmeadS4ZIf0vjTu1V8Ub
 LQ/x3DV7l3p2Z5OyLu2NXhfcsk1KSjAwiPOgZr0k1dKTNWao9n1F/hjEIfPsFlBivfarkDLV3Jh
 7yQKjuKg5NthnYgKssQEp7pUDbfyG4h/CCaj/3hn+eI4vzv93NNlbYe73RhBvviZ8HaMHfM3Gu1
 omfUVhbripKepbtbkP8J435UkWYuEca5wAOBvcmddRgrPIu+LuKAyTqQIumdNpFRuhghJQCV7IU
 D3YQmDyV+xixSuwAr61Z3Yt2tErIZVJWSahlpp9lZfAGNazUq/a1iUSiam8hGrMSsfz4ji8LbhW
 vlAfOR6mAJTtfjQqoBvW10JxPg5S1sVtvLE8oqCmOhqBUFmFxe0cUQRe6l/ughFTYqIBpjOWo5C
 DzSBYa4oZwDzRzWgmyw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfX4FLO0TR3+EXV
 2QZPoSDKkPrb3f+i9Zd65j/cew2Hqpt+2kEo/p/ULZlqQbZjvYFLbs5os5OneLScV7NKMZ5qXA+
 CdZx9MSXdmtLFNzmie9UPhqxV7BfWZo=
X-Proofpoint-GUID: mpfiSLF_Uk9sf5lIwaNhQY4ply4d44ZG
X-Proofpoint-ORIG-GUID: mpfiSLF_Uk9sf5lIwaNhQY4ply4d44ZG
X-Authority-Analysis: v=2.4 cv=Fe4HAp+6 c=1 sm=1 tr=0 ts=6a41671c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=e7-BAW4puXiLW4xK5oIA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280165
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

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Enable the A704 GPU and configure its zap-shader firmware on the
Shikra IQS EVK board.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
index 3003a47bd759..0918bcb4b1ea 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
@@ -23,6 +23,14 @@ chosen {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/shikra/a704_zap.mbn";
+};
+
 &sdhc_1 {
 	vmmc-supply = <&pm8150_l17>;
 	vqmmc-supply = <&pm8150_s4>;

-- 
2.51.0

