Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A999C79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:11:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6E5310EA6C;
	Tue,  8 Sep 2026 07:11:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YWd3/x6x";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YV1OZyND";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA7F610EA71
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 07:11:12 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886LnVO1645958
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 07:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vizWdKJGFAB1HJu6hwMtO5oQyxT7j0M+cp6kkFJFsqU=; b=YWd3/x6x6QElHoo/
 Rq8maYDdWwher25gq8UvsH8W3wFuQa2RmH2XzDMv7K+tGRdHf+h/8twJl+GHU9iX
 0wo+M0BLuKh4ph1BU/Cs535nTfu/LPvk9838UwAuthFsajWrjnoFr0xnyJufpRbb
 lNLcmkcFHzsE9um+ZgFk3o0Gf3sFU1USjsx66LObA3v4XL3Q1LtlZboRnN1pbpc2
 iBNI+ptIRh+kST4EOJksRqykPVxq4Vbc7QwPYQOdbjzNcYaw4UUFmW9s2m11Mi9n
 OB+zwPv6s/G0Rb4U0J6u79i7zHLwu0cfLolmLYHeSrvBvhX/FiK8QF49ajPvmwh4
 VKWIkw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjcvug7qb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 07:11:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-933023a5980so315440885a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 00:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788851471; x=1789456271;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vizWdKJGFAB1HJu6hwMtO5oQyxT7j0M+cp6kkFJFsqU=;
 b=YV1OZyNDRGgBtO5RSlaSl3jna53zIL9sKw6BvEQnJxIs+8RnL0kURvBjBdmL3tbVR6
 6s3I3Ujxcqog4huKpy3Pm2M1vksSgmOMH9pe1YMA3SJXrSsRj4BsrSekf7ILJGG91pB7
 9cABy4j+SgQA55lDsK9qQCpuklRSx9F40D1W2JlxuTbFiyXHhrdLyAZXcsYZTznzN6Kc
 6CjEC62vrvqBLixYjYNsNhu0v0S1riiiHd+Z7vF92xXZ43pA7YxHFyqJl/A7+XFJSgID
 CpqS3OLkmzI4n8Op1cxvom+DLKeOQ3Jqv+rMea+K00fmj7X8LrTmkmmbMCy2EQOF0ZMs
 DStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788851471; x=1789456271;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vizWdKJGFAB1HJu6hwMtO5oQyxT7j0M+cp6kkFJFsqU=;
 b=LBqw2lUQGi3TnkXNY5oOdSAZlud6CFHJ75LlwmTtpZT39lUIoqMPUFgn+WTe8X21fz
 i4unTW3nC4Di9LBMgWV3hOnosz0A2V3NaWF+sAPQ1Gzy2qSpSajTor0cwcgs2XUlV6o7
 Y3mrLk8qBEE+mF0hmpvFqxJfgdrcrWi59kBUdxy8YcerqC1C1U3bS9aDS1ocQqeu06zZ
 z5NhfntPJumE0O2UR+xvUSlc3VO30PfeDnaIvjLGyIJlgN39rV47jr7DBdaDcTMh+6Xi
 s76vv5mCWmbzPRE/vGu8QJQKCyJJiraYyXiSnmRXkqSM33z/TWqXZ3IXn71TzLgspvOJ
 4edw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYPWyZi1Kqy+xpCH2shA4OKCJecP5F4Mqex95iKQ5Rq+OyHT8WgiVr/SACAFMwJtKl8fvLE9F4+uI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kVRNLz5+nVTMUYJy38nLQnYk74nhad44gWVjz+EoUoyoEpEco/
 odvnj801ysxKvMIlomEScJKMG2aCEF0mIDxlwJVf3uXLjNMg7oqqH1EHEoVvknPdzqz14ZrdSyj
 5u+K87sOdQPlHDnWG9zXXmmNEvVu1OEz3SAnpViJ2WPxQkdUZZf+MwBthexUmHGRCsB2Kj/0=
X-Gm-Gg: AYBFou1bCDRmNMwXTkji6NabY1lpD7Gs9vVbDicIOPv8KAcbrKmPv+JLACPKG0fXeeN
 V2lI4qc/OYnnrjZNOWiBTr3U3Rk2diIPlIXKnwxLP9cEKfoO2wO84gRPYQUAVCoGqcLl8pTsPkv
 g/mEYTeqFTB5fNZtB/PpsGM4Fcr7lhEMqKih6jTYcKg95b256Pp+dLO2eBhqJXACvu/l82KWY6q
 9bL+EHDmlOTCItDVuF1fARLCb3Cg1K5atMCixejyOmEKHWItCekVdt/l2iBUUtEqaGuMcPNuSTJ
 dKQT2g3oCYVU9sCV11cruZ7B46Zr/Zq+qUbRDoqOB5aM0tXhcSKrP7PAhN7Vzh229mex/aouWBy
 6yvnVuGyE3FuM9+R7iDrWbnA=
X-Received: by 2002:a05:620a:404c:b0:939:df5:977c with SMTP id
 af79cd13be357-93980361c84mr2939058985a.19.1788851470965; 
 Tue, 08 Sep 2026 00:11:10 -0700 (PDT)
X-Received: by 2002:a05:620a:404c:b0:939:df5:977c with SMTP id
 af79cd13be357-93980361c84mr2939053485a.19.1788851470435; 
 Tue, 08 Sep 2026 00:11:10 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5927b68sm453173805e9.1.2026.09.08.00.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 00:11:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 09:10:46 +0200
Subject: [PATCH v3 6/7] drm/msm/dsi: Fix indentation of if block in
 dsi_mgr_bridge_mode_valid()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-6-dcf8956878ca@oss.qualcomm.com>
References: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
In-Reply-To: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
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
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqn7T83kk1ueDOHgN3MC+5UmBLJIc9NjJCJ5Y7N
 DmU5EQiskSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCap+0/AAKCRDBN2bmhouD
 18SDEACK4ZXwaPj6vlMd2riLCLR4YgeaRdhNMnQter3mdIFjzJ9Fx0TqmUYCGzTgr9rOlk0jNSQ
 Hnx7vAlVwuwbioeZsA5bjMNPXGw3VwhJeJoAuc37uDcKqyQSo3RLX4GSBkpA8HO/SBrmUfyZEXb
 IdSq7wjCudqZpP6sQk5pphUO+LkYKjmpe6N0GgEfIc33FuG321rOGZR5ArA+9dnIX4k3QbBAmcG
 rW5KiumnjA1tjnisiypPgxRV7b2bkRc68jBTjOGd3TIYSNp9+qZfhDzCRFJfrOCCPQ/1749e/eC
 FT76z4ygQB7IujEvsVO4qMDYmb+orXblx0lD8pYiO0tdT9DmwldC8gfSuzLocovqOMQrQM+pET2
 LsXzK8WiB0DzeBhbYBDBUqgUILlNI2pMEofo0XIE8nhZfw8SOBCY5sLjBjP74fWjXWbaZPsdksc
 X53CyPj+sPfLrwbXuhwYfPuSC7WPhEfMxMQQPEdfRUvJZxBq1L9MkgKSBLTK2yJNsQMOe36I+Yj
 EAcBpdz73gLIY+KaBK2MwfDTWuF2LRQPKUrwmBCLFG4URcm+mvgAf1azEw72xvq7nu7MxjLcxi2
 m2GopMOFMiJ0O/vjEu23P6XqZMKPPkqQYFd417E5C2PTlmSSalZxeQ19mkh+iARDvS9e4V90XpG
 2Bl4iljfW42V8DA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=ePkjSnp1 c=1 sm=1 tr=0 ts=6a9fb510 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=mamL7KDpJlut8y4y1IgA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 27XBpHQ5vDUPRdGnLMteZUzYu1ei_MDM
X-Proofpoint-ORIG-GUID: 27XBpHQ5vDUPRdGnLMteZUzYu1ei_MDM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA3MiBTYWx0ZWRfX0lNy9NE3ltd/
 ZOXO0qXM31cRPusD9hqnsIXx5G8vnND7Cm5zdcFGf0g2jH8oZnB28fa/hSlz3OjWgPZGR5EWL7Q
 nXmf5WRYkD5O0D7RpExg7C46NQwizSmDJr85M6XIxhB4u2of/ZupzBAFKY7Pv4PGRLroA4npjoX
 0COGuF6r7GHT+pCnieOcKwFbd6c0iWl0mnhEMKKRAZruviuNboqWeiWwiUuttq31fD5X9llx1Xg
 8EJ8IJemVJZCNucevF3pohQ4Je0ZHHrnQSVgw+b3lIEFWTit/XIzfbIYIP5BXbl3ENj36dEThcF
 0fmVkT4jlgxGU9Wp6uCtN5AQfSv6geIhDnMWk9cH9gJE4JgVGLrkjrgtVQ2RJMp+j+LL0gL3BNU
 416Z6bOYpX9PSNlXZAFDAMR4gVDBvgV+WBcn6TGVHZ400JX6GbdyzlqlqFU2NnMGVDDMKZW+2ff
 pC8tzFHrm9xk7/aQHug==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA3MiBTYWx0ZWRfXxSsfxzXXR2nK
 GHu8k1/zMbMcFHyiFiMGTAwJIlbmYEeDP7/2jRgeIqstr0XIYji2T5x2orfptrd/5trFgzvYn2l
 XepmcslGiErIvK6ogJgjKA63c0G0W+M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080072
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

