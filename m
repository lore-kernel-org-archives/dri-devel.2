Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A42606D83C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kXxHoCG+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cLE8auJa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A92210F3A3;
	Mon,  9 Nov 2026 14:21:39 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 383E710F394
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 14:21:28 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DEwsW1323043
 for <dri-devel@lists.freedesktop.org>; Mon, 9 Nov 2026 14:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=PPgnV+/icpo
 FhI/kUPr3+TxF1BiCW4u9d+dKLSBISVI=; b=kXxHoCG+Xttwc8hCkIJVvGo7EQs
 w+kN3W/7RVITeOjWsYXS63qrJKHzJlAiYaxsR0w4rhNZaH4QJB5CEaoekDie8Jg1
 qfTnJr8VRfvmEWIKjnlVQuVpecC0vkxJILMS7bYAnRUGfGNP8jmCfvmLtdE4d1eb
 SQvc5LNqmKcoNlYOhsWL69BDdenNWKff4pRBugTBjo6QwY3RmTK76zJrxf2JZndW
 bv0ox3Y6Tih+IGDBimxTcITqmeNg/kJpOdiY44uzUDURkgemlnkKD84O4pP8zGmC
 bxXO3XC7IQYZ7Wl/zRihV7q6/kMiYK0+xKqy768KCxZJHVjdmSy0fjhKXWw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hue0qrdqk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 14:21:27 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3b0ac277beaso845107a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 06:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794234087; x=1794838887;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PPgnV+/icpoFhI/kUPr3+TxF1BiCW4u9d+dKLSBISVI=;
 b=cLE8auJa8ZlpMkURllmvFo3qT91HY4aq/llzDe2jStXQfbx707JORFfMO0laZ593BW
 KyR85aW9Yi5NJFah9PlBKxRR25cN09O+3YGUmFoDQ0IXaIVcFsCjjGZuJz1A7TuGhk1Y
 iWnr6BIb9h9zKvPkNu3mByaAcg8Riq7jIUAe8V1J0kwXhEQ66XAZkaQyvNGlhNPNghXA
 vzdXs0LLOYVpeEkYZuZqKiafv8V7JsqFrbE+A8juujcXSRZnqKWaURUJEK4mcZBxfzhA
 uAxucO4Ko7L8eCCZnTC5GzJgOSdzyzbV7F+B4tPxk+yfRvJJcz96J3k04zsgCczYv6QA
 jKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794234087; x=1794838887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PPgnV+/icpoFhI/kUPr3+TxF1BiCW4u9d+dKLSBISVI=;
 b=ZQrw/JSqQfu1LC9y50/Jy8PreUGz8wATPnOWwnvBlKZJyYHNTLYcWqmIjHNzOU2Mlg
 9G9YWN+Aq2riviS2FNaBIuZ042nDbRxQs253iHnJrH7z2XPgbu+2r0VH+3rCD2c8DhXq
 OptiBHjXQFFt0e5knINj1L4dMSm2rwFGP+75lO6xfuWsvLR+T8CoqmAmFtbXMekiNWMb
 Gs0c7N/Wnz3GOrSVWLoEzkFqjSrUS8uAx81D8hdqYOl+tNld5D9Vk3naiSAbOl7cUCh8
 ZUWU1IIy/F/E4vGOck/UpE04T5bSWBMDQTxWkp+dVze1GOxftLbHlnW380PtDZkYSSVL
 hIiQ==
X-Gm-Message-State: APuU4Z81X1VLJDN38nWx6WD05vOF91i5caG5rr0OgnSeSl5RQ8Oh+sIU
 MBi/H+etRs+5cbhSIjYrjxSk8KvYRImcWwLpVfHg5ZMe76mZlrPkJ/Ovzmr2oazVAgcWMtKunxC
 EZUuA5SSVwhZf0Id7q4CTG1A9l36FUhvfn75QiVyskh4CP6w2B14vYyvyyP3VoHmcRoeRIFzZyt
 OCoUY=
X-Gm-Gg: AYBFou2ARCKH6ei/XmORIM/CpW1e3Uwm+2cKsynsP41qoIBVsW9fSExiRgWPg0efNCb
 P09Nw6WIkoVMSmmjPNHtc7GgVLFg95UADYYdDAfFeBsQ5N0uJ0CzuAfNzxk5rXzz2jk83Ef1i25
 S1qIe4A78itRFfLWsAYgLv2LxfKoSa7InQr+x7FCUrLfNX5S4kv9xuAbDw1NIBu6JQnplNnz8Su
 GjN747TRchoBbNPNYHGiL8AGsFPWNeGz5f9IiWP4gwzHb8F5pkzFC3oL77f/oyBnWdWvAaqPg9j
 mXkGAd+sPW+dgjGwStT132oJVrVqslq6LqojsAeMDrOGVepHww6fOe0GKJalX8YqEn41kpqgemk
 k7JhpmxCqf77Rjls853oxPgHn5eMRzoUpYyp9C5QgrbU6KWniSHWrlYz3Dp6CTVLwUUwuq7MVa7
 8K4UCRs6yXpdeDGuNONbvcO4D5dogvLUIxjpYy6f6VLpvqpLNzeYuetgjMiaML
X-Received: by 2002:a17:90b:28c3:b0:3ab:2ad1:f10a with SMTP id
 98e67ed59e1d1-3b12cb3ecffmr3221578a91.0.1794234086937; 
 Mon, 09 Nov 2026 06:21:26 -0800 (PST)
X-Received: by 2002:a17:90b:28c3:b0:3ab:2ad1:f10a with SMTP id
 98e67ed59e1d1-3b12cb3ecffmr3221535a91.0.1794234086356; 
 Mon, 09 Nov 2026 06:21:26 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1058a7b29sm11045249a91.10.2026.11.09.06.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:21:25 -0800 (PST)
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
Subject: [PATCH v8 05/15] drm/msm/a8xx: Add missing a850 ifpc reglist entries
Date: Mon,  9 Nov 2026 06:19:51 -0800
Message-ID: <20261109142111.256630-6-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109142111.256630-1-robin.clark@oss.qualcomm.com>
References: <20261109142111.256630-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfX+uY2z/5ZZkLR
 A4OIbuMHRjF1RprwZlONQcP+2ozJMrou6954HOWD8eVIrp9Wu3Z9WEzP23kyv8AJDPGhQahMa/9
 hLAJKYAqGXFK/Ys8XEtLFw4XhATQKkCYocxEYoV26hOTlKzD463h27Ay80Kq+A2+nLQCtPKC1DC
 7MjobNNLBZqL80Yk345excrAlzPY9+CcjLqjGO24rMCKgEY78t6DiqqrnoZKm7gKIjHRqMoBvkV
 bLkCtscawoKnMJIzFvhsEZ00p3ZFVeGncDyXaOXcntChpldwVwED/c563I9YAEXzt7RWXaR/aQR
 ukWtFzBK2nvmaWsdMzFUS+SDcfOY1XWMZlO2unzviGVmO+SEgKM0sO4Opsgs4V3Tc6BuiYs9IfJ
 rWGZfoLjn6xe6mxvhBFH3rMscAO/VwJuZiZxjz3RnF4SWSpeoZ7LhtHcUNyJvjyLWc515tcFJBZ
 SlwVu3hbrT3rj7W5qPg==
X-Authority-Analysis: v=2.4 cv=DZuCOftW c=1 sm=1 tr=0 ts=6af1d6e7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=vdKEjRuvQ9rlgTdWijoA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: Q4KTbiw03kAXtAyyn47w-M-kdzJNYehB
X-Proofpoint-ORIG-GUID: Q4KTbiw03kAXtAyyn47w-M-kdzJNYehB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfXzJsRJ6BRH+tE
 iVmxIfhfigeSwPtRZLerXvhus9Ycqq+ZmRuQ5Swb24mIXlcMUmRHZMEdYHFsxOFzVB9AAWVoP/3
 lYV1HWGbWE+83aLHLrSmNBDq2TuFT2E=
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

We want to save/restore all of the CP_PROTECT regs across IFPC.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
index a3eab0307529..dd1a5ca91812 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
@@ -1393,6 +1393,13 @@ static const u32 a850_ifpc_reglist_regs[] = {
 	REG_A8XX_CP_PROTECT_GLOBAL(53),
 	REG_A8XX_CP_PROTECT_GLOBAL(54),
 	REG_A8XX_CP_PROTECT_GLOBAL(55),
+	REG_A8XX_CP_PROTECT_GLOBAL(56),
+	REG_A8XX_CP_PROTECT_GLOBAL(57),
+	REG_A8XX_CP_PROTECT_GLOBAL(58),
+	REG_A8XX_CP_PROTECT_GLOBAL(59),
+	REG_A8XX_CP_PROTECT_GLOBAL(60),
+	REG_A8XX_CP_PROTECT_GLOBAL(61),
+	REG_A8XX_CP_PROTECT_GLOBAL(62),
 	REG_A8XX_CP_PROTECT_GLOBAL(63),
 };
 DECLARE_ADRENO_REGLIST_LIST(a850_ifpc_reglist);
-- 
2.56.0

