Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F1B606D83E
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kBUkhJbp;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GFh7gwFG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45C5010F394;
	Mon,  9 Nov 2026 14:21:55 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08FA810F383
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 14:21:32 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DEtHx1323026
 for <dri-devel@lists.freedesktop.org>; Mon, 9 Nov 2026 14:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kova2M5LKwq
 QTwo8zCwpaEugv6qTmVtqzP9NdYn1O9Q=; b=kBUkhJbpDw7lULstxLc6Cii4yRX
 xaZEBbleAs51pSqn8KgZN/4xJoVLyZNtPc0Ke6Qpv8drEf5xBkDe4JdDSlFPvhQb
 9QSyQiyiNTftSmg3f6JYMIA2P11S/snjDXkeE1ZqYsnmyX0cFMqcqzpCPToUBzTF
 aAps+CyFGLKoxtUSZfbHg7eUVlBPfAYIE0BfaQZm7nOOeRS4u1g0NDrQxn98ExCw
 GgB1FKHfUO6S2tcmvtdnF8WGO/GQj7XBJUfXLWJCJQNCenmqvPRNmShRp31XB1G4
 HWwkDWEgbV0o67ac4DIdSlxqlxp/wlpe6bvaEECsMaENawJlnioD4HjjuBg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hue0qrdqt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 14:21:31 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3b08aee6b3eso803018a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 06:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794234091; x=1794838891;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kova2M5LKwqQTwo8zCwpaEugv6qTmVtqzP9NdYn1O9Q=;
 b=GFh7gwFG0nWPjhRRRx+EBKjkSPI7WMvrEzI8U/tG7v94dgtnUcaE18FfkmORFSXgDD
 YzGOwpo1Dg+GWLYS3+xYMFNlEjj7FLXqDxEi1Cj4lh6a5X/Pitj2I8nmUST23uDSdwoz
 7oF/XkLSw45KPhlZLLSvtmVBi5ZTANFbe55JuvLCTbbfqtiPdNe4m01QrAX0uhvbasHB
 cb7Ya1gkrOLf7Vk7ndDxFVk4/lmlPYfSFhPf4lxIGjMThRAQeZn6n8cp+QiSp+xdWUof
 W8ymeS0b9zkGGNNDZ6/N8m0zRv8RD3ibS5SJt3kV/aqZddv5V859DP8be6GqmARDR8O6
 29PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794234091; x=1794838891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kova2M5LKwqQTwo8zCwpaEugv6qTmVtqzP9NdYn1O9Q=;
 b=NCbn2PfYLFyy49f3wq8n3y5RZdaaYH00jxTyrUzo3XSe1QXP/pgAlHWqwnHz4WbAu9
 w2Snut0iHBFU5vSp+hqxcVUPe/LEmYqkpTMKXWupwN4TlN/Dy9hmht7PneR53vbPdzDS
 V91PeGoIw1pkWOD7CqqcWnbJ3hDJVzukRBd7mFxvXmXmyJzkYgDWygSWbQHZNBy9dhW6
 S3fNtjgyV0YFKwzPPIDlvLNaDXxHbOcaFvGdSw93At1rvH+buH99QrsvNhya6iJjo/0S
 6pKAdJ1CevXM627p8TPo8wGnm/R5p2N9FiJMozGojC+6dRhoOhpg0Al2mOWfmijjD7FK
 G9IA==
X-Gm-Message-State: APuU4Z/ey0eJn/sbtekS/rzgFoH9AtZwhf7R3jVg50ywXu6D3TzZ7ISZ
 im0j6LJuq76wddG3BB/83s6LTAlMk7F9hlQUzNDH2WVgnBT58Pwv1KBjIM9AayQfJjGdJxblIr6
 r25hfUMVOpEoQ6yb6H+h+H7VUpS+FmVcJz9CaAxInMi/Zb8J13sr1JoplZu95+ESC6CCJwrS/YV
 11pO2AlQ==
X-Gm-Gg: AYBFou1s7Xt5DmhlA/yzYQZI79MFtHd7iCvRMfZgAn2aLBzF45uZuD0MIPIoBHArqKD
 iRw/ZLqWqc2lW75icop0XUJ4/wgD18iIMm3rnkJzOqavTy86nrY1YBXz4bcJ2jIx7gn/wtZIRQG
 d7QjJke6kIZ/OWUOMtohjdUj+hGE2+GQC/YgsorFe8AYRaYuJ+i5SInH0RYvqYeVneZEznIDFWJ
 4PmJ2WHCBxdE9BvaJ4mqr+/NjSFgeyIakRgbhl2+NYF+OMGLqEDJoxFZ903BFR9Usi1Pdy2w5qv
 j1m7jtLY18KDSnjUjfxQ0Wrm390+rtFL1HQN8tQtAyJwSQ2RjGnWDtmKZQYmfesjz6iqNcVer9v
 dCMb5pXU0m2iQ6NA1+3KNxtyq05aFNPCcvGDqY54sviVCi7uSUcXj639vPt6q3xePrn5hsj4hmH
 aov3QEnuCNNjLL2FA7AigBO/vmUOKa4/r4CYX/SK8VNfTc3EyqPZVQy91ZH+iqhA==
X-Received: by 2002:a17:90b:564f:b0:39e:4c80:f67b with SMTP id
 98e67ed59e1d1-3b12d496560mr3864982a91.26.1794234090670; 
 Mon, 09 Nov 2026 06:21:30 -0800 (PST)
X-Received: by 2002:a17:90b:564f:b0:39e:4c80:f67b with SMTP id
 98e67ed59e1d1-3b12d496560mr3864950a91.26.1794234090151; 
 Mon, 09 Nov 2026 06:21:30 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b127712abcsm7261337a91.1.2026.11.09.06.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:21:29 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 08/15] drm/msm/adreno: Fix PROTECT span length
Date: Mon,  9 Nov 2026 06:19:54 -0800
Message-ID: <20261109142111.256630-9-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109142111.256630-1-robin.clark@oss.qualcomm.com>
References: <20261109142111.256630-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfX2buK6nxL0cYK
 wXop3X3YAMQRUsa5hBiP64qgU8mBRmAswrictNOrO5BIvr2bFEGEfQYvB2sNWxLT5FsQULifoTp
 xu9DVWgadTnd2lMFek1HFexhWWHosZJgJQkQcqx9vz7akNj7NHT+Fc2HRYFI0CSThoqchHOvV0K
 dSq+slRFsMdEQYgNDSsF6XPBlOj74bK3FC8/8+urv34eVc3dkmcRXRxPmxp5GSVY00HnO1nZRyq
 5eg1fquF/nch/D9AeH39GQsfQn1YaBBf8/VX+qsTUsx1Xsx4OSGwDB0Npa0Gyr4oKP+Ts5cbIdK
 WrIp48og0wA2twLEpwsqqZMj659eDVc4T5n7EvkSFoFlst6UXdbuIEWxtk0eVe2ZpJXOB1h4o0M
 loENEIiybYR1w/hpjJt9CbiHUaz+XcF85G9MlBrsK2OHdHypa0i1dDmnhbJAsPftdfJdVRxRaNd
 wF7K5iZfU7bnQ26yvFg==
X-Authority-Analysis: v=2.4 cv=DZuCOftW c=1 sm=1 tr=0 ts=6af1d6eb cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=MJDCpJTP__1aPQla-tsA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 2NseL7foVzwJWVwlqjj4kw9pUIRr5v3m
X-Proofpoint-ORIG-GUID: 2NseL7foVzwJWVwlqjj4kw9pUIRr5v3m
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfX+f0b140kBxzx
 dpYK4gkxq8Q3pAspwQhguEmuW1nDv0fQJHXRXuwXz0nksMGa8EhkIyqoPa2y9GeO8nwuYsByO8e
 ZorFwgGTEFnjhj0QbVVej5eEXTk0tUQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090057
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

Don't let the length bleed into b31.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 4a3898e58aee..cfe7a3ed44c4 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -244,7 +244,7 @@ struct a7xx_cp_smmu_info {
  */
 #define A6XX_PROTECT_NORDWR(_reg, _len) \
 	((1 << 31) | \
-	(((_len) & 0x3FFF) << 18) | ((_reg) & 0x3FFFF))
+	(((_len) & 0x1FFF) << 18) | ((_reg) & 0x3FFFF))
 
 /*
  * Same as above, but allow reads over the range. For areas of mixed use (such
@@ -252,7 +252,7 @@ struct a7xx_cp_smmu_info {
  * single register
  */
 #define A6XX_PROTECT_RDONLY(_reg, _len) \
-	((((_len) & 0x3FFF) << 18) | ((_reg) & 0x3FFFF))
+	((((_len) & 0x1FFF) << 18) | ((_reg) & 0x3FFFF))
 
 extern const struct adreno_gpu_funcs a6xx_gpu_funcs;
 extern const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs;
-- 
2.56.0

