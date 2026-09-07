Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C13C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:00:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27E2B10E7E8;
	Mon,  7 Sep 2026 13:00:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="U0QyZFyb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wp+6TB3K";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7967A10E7FF
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:00:48 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687An1V63230462
 for <dri-devel@lists.freedesktop.org>; Mon, 7 Sep 2026 13:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vizWdKJGFAB1HJu6hwMtO5oQyxT7j0M+cp6kkFJFsqU=; b=U0QyZFyb5KLlWYk8
 y8Ms9NBX7C+Phqwu8Ja23/VESvpzoMvk/JXsL3Oi8uNXNanZvrQBAURcGEln0dhU
 imAGiOxBvNb/EkQcgf5b+PafT+OV/fS4GjbzG0IU4k68ReQbByXmawJTIJrLP1z4
 op2+k7il8TCk4R7rQsUOd9W6EgH7GgtVk5DVcWIDMMBKBcxRjvtBXnlAOII/nzX9
 vaB3S3hSlWAYT+jCsuGDzB8cX6OKU+P+yR/5pv8Vz7yDHbx1Gr95znCsuiphDKEY
 8rW0xgGTs0K29ojscyIzxbq80hyJH701/z3VFhjolYhfdTSXUaEBdu/EStDorqvF
 /xHrNA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghfxktsty-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 13:00:47 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-980b637ed69so15323241.1
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 06:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788786047; x=1789390847;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vizWdKJGFAB1HJu6hwMtO5oQyxT7j0M+cp6kkFJFsqU=;
 b=Wp+6TB3KWLCW6t69746fuYEUcLxbpuvKf0eZ+iYkHjTCddT7hAdwkDv1nYQg9hf69X
 X+2QZycFRN+aMJldDDZyh9rvL+FtcY984YrQBHLbX/M5p/9vFpavcRTaMMQXsqU27HtA
 C7WYuP5ZN9+TqvzqSIZdDoWERq40IEfMcJv8Y4NWCdSNai0G1lcAupyrNJqLHqOixRqv
 EkYJdUaNulEqIsmR3AK51BW1qCv8hkR4jx1EeK/fdl8nZCuabNTqq3T7Ynax3IysoQxk
 /9/Z1DtBFm7c8JT3YlGqI2g1mL+2y2swDwR2yaP93dRYNrOhTzh5RJe/pXOK1UrufHgh
 dgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788786047; x=1789390847;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vizWdKJGFAB1HJu6hwMtO5oQyxT7j0M+cp6kkFJFsqU=;
 b=GtNdJzvPpSkjjIAweQNx6nqQBdb0v0fleF4J9D0CK2yGVZ2Zk+7oGT4tYqZ64Dwi15
 3B7rrb2tIDn7AEA2i9cEx4YqKMnBfdvOf/Gp/p5l/PoWae+A/54/AiDmipYFe/4u3DJT
 ytWzsPjUqIR/OeJlhU23qOmO+8QgP+8gQPcxT9xi2Ni1GCWE8aID4IXSOSSeYUe6nhB7
 lE/ILNRpd95ZvIRvVtUnk539Kg9gEPQWx0N7ExrceeprUMy4ZNWWKEnxtxJ614IMz+L0
 VeI4WkWigVltp4auDNauNQWe3naWKlRuQcF2CXjrNvqeCXUCPNgB3RMMqIqC/4J8wwg8
 wqdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCktuamJwVw/vDJdhQB8NFYjz1YRGX2wiV3GDOhCRVPxFxFgYEQa/lgER1M0hLG8R4XUNgGRvZ/GA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lTQ8JJMe0pOqC2y33mld6X4nhPyIMjJRO9ZYVzEccK/sRNMXbO
 fldT3Die3dRTFmraVBN9AQE5HhBmGL7ufgV45QGwnmcldVqyNoneaIWWJN3m/IIlDwiXKZRsfis
 vTE9sv6Uo0Y+Me/6QWYbilFORv+PSOZ9/bkshVQFnpBMPmj61foR/94/3EnyDDN+Jxo79Cro=
X-Gm-Gg: AYBFou3TVtmJbocf79+N9p/VEVk7BqSEP7QQKsOfb0EOGjRLwJNyWMKEleYW37hHk1Q
 mRuspsGH2GMNmhJ5Y0UOGQlw66tcGMEvJ5TGasnSA+K/ypYVqr1s6U2wm3C8Cady+wxtq0P3G4b
 nR8U98FWC3jjmL6wzqr3609LXscr5UZP8XbU0LMkcmYiVyP/KTRfvfaqWiYhjWMbN6uSyrRwOCH
 jIdtic9I+wN2AdpTKbqeiNyk4J2LtaB//C6DlEOxxCFpaYUGwiDeOB7EUNk6Phff4I/wfiE5Zzj
 H+x/ar1BPpDZCXJfNUqkxzS+JgGJLlEdbRb/vSo7QjpQA87usE24YRtJ647tmL9dc53I1CphMtm
 R1QgUr/l3o8p2ascj+exeO+Y=
X-Received: by 2002:a05:6102:3054:b0:726:cd42:d023 with SMTP id
 ada2fe7eead31-78a4aa3506cmr6713753137.11.1788786046861; 
 Mon, 07 Sep 2026 06:00:46 -0700 (PDT)
X-Received: by 2002:a05:6102:3054:b0:726:cd42:d023 with SMTP id
 ada2fe7eead31-78a4aa3506cmr6713717137.11.1788786046373; 
 Mon, 07 Sep 2026 06:00:46 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cff81c9b5sm198751205e9.4.2026.09.07.06.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 06:00:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 07 Sep 2026 15:00:20 +0200
Subject: [PATCH v2 6/7] drm/msm/dsi: Fix indentation of if block in
 dsi_mgr_bridge_mode_valid()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-6-b097cf1eac77@oss.qualcomm.com>
References: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com>
In-Reply-To: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=859;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=/YVh+L5neHC3SlylyZSkY52kedS/7Okrqq86t4o1xdw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqnrVoYKlet5BEdF1OEjdeDKF+CC9/cDNCyhAqO
 C0NL1jHwCGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCap61aAAKCRDBN2bmhouD
 14WZD/4rXDWg0PmMoA6VCJqIYCdWf2B2C385vSgk3FZWplp0SgmTcNpbmjOSPlHGniaeJhHigKY
 5eWv5VAbVWk0RbXURY7nWAjuiT5wQU1BD3TKph93/rCeSYv49y6wMgVF5/n6JgsnwFYsoQcCwCu
 cg4uhPP+nBBnCqS2U5p676DWciFeYK6VSt+CHjXqVbwSKOG03hMlOBOEstfnCMes62cVn0PNRjR
 hNwbWj2uxqiJ0IanXuzipepLUVCtTRkarlTYqknoHut5aWnA8rEKMyrtODemUluLfyO9o/v/Hlv
 CpkkImTeuXnquiiLF4Cifj6awb0uEhNFkCEY+JPEo+/IERu+HJkc9WkX53OhYAmXIWhAnjNZAaB
 UD1C/5I0xX7mNx1bTqgMGyQgO598ksl+yh9kVNPzPUzR8m+W4iemj3IUvonBxSNMPL8F1lCY3vs
 rq0JLcBWX5Be6azuvjAQxPCgthxCMmwBJdRdDemMHCG/gl9gN9R9TwffIZLxQzZaa+X42ZUfURU
 21Kl6OVsZ0fhWUuq85MJxerUaNApLgJ70HKbgGNupaTC8HR0O8eL6kW+60yAZ4Fjc+9YMf5A31G
 mL73oJ7JYyv3a4OwP7gZGFjiZERCRnFiGmDpNyANgLMTgg2ArbPMTjvCuOeipfZySPx+wkb+G2M
 S2sUfT62evsbUpw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE0MyBTYWx0ZWRfX5gvCttw5w5WR
 BQb+JxJqFgx0zEQNxDZiZxLhnDGwy3S6tytj4jfUelF4N/XU+0M1X3SFSvT749tBUgoNwrIy7j3
 uviiJRnwZmRGtZlXtTWHl8lXWRDE/IH1EuKlxn37lJWqETiJx1Mb698rHHzOVVQbrdmi+010CZe
 YU/lTV1s39EVZWr1O0bH3EO88alqbIoSkij7SZY95sC1vsYc3mi8YfLYKfXRHf4dR9VRqu8N3JC
 Ood3+G7UlGr0RxzBRqQVpoQpD9cOs4+XJ/TWrWbilgk8G8tb8/9zIs/2q3mWuGwOLAW/SRf+ftD
 E2MihTsu9eTFiLyLj5SHMojTVNiU7Xy5i4Zpi5CEnUkqspVtHrH0r1aj6IP6ayfb36GCsEeAf5c
 olRhuRurxbJso2AiFkpfUwMKnebqt1Wm9KqEtOFIShsJxsa8Guisdjz9FFrvpOyiQaua2ox1Db/
 N/YIjlTO9FDHI86VvNQ==
X-Proofpoint-GUID: sidUM1ZM8-IDGy3OO7HXIQ9hrU0pVoxi
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE0MyBTYWx0ZWRfXxpEHeTVmF87o
 mINRvkdA4lglfLfDaR4Dl8VoxU4+0tj2YhEe967FMG0GsQFI9fpFll9Rb70ltqWxBk85klKNZtc
 y3SQOnSWkQ8iBn1xIUTySL7uJG/S3XQ=
X-Authority-Analysis: v=2.4 cv=daOwG3Xe c=1 sm=1 tr=0 ts=6a9eb57f cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=mamL7KDpJlut8y4y1IgA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: sidUM1ZM8-IDGy3OO7HXIQ9hrU0pVoxi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070143
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

Correct confusing indentation within else {} block in
dsi_mgr_bridge_mode_valid().

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dsi/dsi_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index 959daa88b1d0..531d4ff78f56 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -429,7 +429,7 @@ static enum drm_mode_status dsi_mgr_bridge_mode_valid(struct drm_bridge *bridge,
 		if (dev_pm_opp_get_opp_count(&pdev->dev) != 0)
 			return MODE_CLOCK_RANGE;
 	} else {
-			return MODE_ERROR;
+		return MODE_ERROR;
 	}
 
 	return msm_dsi_host_check_dsc(host, mode);

-- 
2.53.0

