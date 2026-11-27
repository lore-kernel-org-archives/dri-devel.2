Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C49A606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ecDp2Akh;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W77C3wBz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14F3D112D76;
	Fri, 27 Nov 2026 20:16:09 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2859D112D78
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:15:51 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJAtPF3038734
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zf4MCgV25Xzk454J9ButugmWv3++ZMym7a/D1rsCAe0=; b=ecDp2AkhlC3Ho5gN
 CKLdzVlH54v70kSmVhgEaW1HWPiFlyCFwqTjN8CI8hMrSe0ym6221eZykkmC+0kF
 07a/cbEqMLkbchj3WcVnkoHdMbVvoiXbKIVy6T5WgIZk6Bb7/tPL7vcsvxl/BDRr
 YvOxiCRsZr5iZYv0WEKVj5Emd1VfabDjSvguJ7/bxn8jUgQX8/cQhOM15qGuDojc
 RPH6pKk7k7PV4boV+UmHnV/86oMrPwVHpOm6oF1jY8qNQKYsjBbWVwSMC1KR5mC0
 MDdsDzRN1liKrJFexRGFKAS30olD/URnL/U6I+tWURK2zbnm8mQfC4wxXik/IYp/
 yvtmgw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j7e4nge27-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:15:50 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5ece7f075c4so2233378e0c.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795810550; x=1796415350;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zf4MCgV25Xzk454J9ButugmWv3++ZMym7a/D1rsCAe0=;
 b=W77C3wBzAaeaNkbQuRlmLPKvOrPVOITQHp9PphhHweiOtsuvJaKJkg3jLNG6k0rF5B
 CMXkpTzI0+M3OkndU1xLUwCIKQfiPbsSRg2VEgaVDklEa9Hg8tcABndrqD2Vfhox1TNX
 AxaQF69wCq+9eBrN6xQRFQiq4ryZxwob25tMG7O+GMl8hxZWVm4igIi672ZcaLKwAWOP
 7qHfxAl7Z+Vk2QKol2paxyInhQIPZ+iCP5HFu34vEWXpC5CQBukI5OTGe8JdZ9jTZuI1
 zpAnwvqPMxspw2hn6h6GZFNmdnwmsqWEKUV2WqX2XT8DEpH+W4kl2lgWt7673o9inXn+
 eXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795810550; x=1796415350;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zf4MCgV25Xzk454J9ButugmWv3++ZMym7a/D1rsCAe0=;
 b=V60hmiKqm+5tIKXjyIq09bKXf0yloXEQdhd/bbdbGOPNnqC5OMTMOCi4hXbpzRHPeD
 daXQCivHHrLKKa9VseSMqonjhEqBiGptRwTgj2SL79rUcEa7mvswNv3EHY5n8ZBcablf
 /FClA+KeDyNY1FaeU0HxMH/MxJT5t+OTWDQNyl15HimM+Nh0pOkZ/SFJh8urDxgpnKc7
 UXnHKW77uov0mpW1DM/WCLk/TjvHnwdXJ4LORaTXN2RtRVHF2Ei7RwQahw75DRwaF7mr
 0kIT9ARj3Z+EJ1xQerrKwEZHFwHRNY5SA345s77vRDY9dsjbY+hYliejS6xwi46eUxpC
 2Kiw==
X-Forwarded-Encrypted: i=1;
 AL+hErGm9kcF+vYay4fkJUtM6cnqejBycQSzPoteu5kvmeffwkgKLO/lEfDUTkBDX40j+rJ8lsYb2FPdxhA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/OSPZKyghbd5WGBL/u1NaJQK5x5XUjXzCGkss32SUfj1zg624Q
 Tr1aQUhS1vEMKVbWCxVumLlk30X1i3STjTg/Qdml6Zo4ll5p22TgvZcqFFPKWiWmy4hxo1IRf+/
 ovYiF8N8tAXr0tX+bPv1usUkhXo73XOyqX+3k/t3i1TZH3GC5vhqUr7mSIsPUC/512gFN8/M=
X-Gm-Gg: AZFdTZev4bPh6dXFNXGLtrSPfk38qgPwCtE6fUYcAaKxT+KRp8y5VfMZojlMPVx3L3w
 suhsgk6tMRqi8x/8KpAp1OBSj4ROQNamDKaA2VMQYLnCuKxtizzS406+FNnpd7uE9jGqF/HQBan
 epSxSWQ8CvcRFH7leQS8sMFTLObVvEG8AHd09mBC+2d7UtNBSHN+Dpc4o/9ebEbH05BKmVEVjBF
 HRUtEazrQ7l2eezEuj962Jk+dAB6dFkxgY4nLlDUNUlmp9vfAo3B660D3WdJegVRdib6ijTYA6W
 xNlEKRIfSB8sjS9zd+ARWb2qtbrbYMfteO2cOoJ08eNJ+Y+IeoousRfRFOQn2GKf+MlsQiN2Dng
 sy9RKHuGBpusEku9g6EDyn8mnEydKMYgj1/eEhudyJ/Tagv3GUvou8F5XnasJP3XdFfI95qemXf
 2BmQCzSpKO+s7CtQS8R3MGJl4nAYzlI/6qgAW+SIBFMMT1oS7/58OTrjAZwih+xg==
X-Received: by 2002:a05:6122:4307:b0:5ee:9f4:e329 with SMTP id
 71dfb90a1353d-5ee8aedb9b1mr15797452e0c.9.1795810549484; 
 Fri, 27 Nov 2026 12:15:49 -0800 (PST)
X-Received: by 2002:a05:6122:4307:b0:5ee:9f4:e329 with SMTP id
 71dfb90a1353d-5ee8aedb9b1mr15797387e0c.9.1795810548772; 
 Fri, 27 Nov 2026 12:15:48 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae8050fddfsm64591511fa.16.2026.11.27.12.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 12:15:47 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 22:15:26 +0200
Subject: [PATCH v2 2/3] drm/msm/a3xx: update the CP protected register ranges
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-a3xx-fix-me-v2-2-839408d293ed@oss.qualcomm.com>
References: <20261127-a3xx-fix-me-v2-0-839408d293ed@oss.qualcomm.com>
In-Reply-To: <20261127-a3xx-fix-me-v2-0-839408d293ed@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2566;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=DFPI2L45u4oeaZLXWc3gaFnF3XyyMFzyyM7xHVl7fj4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBrCeTqySKzbLWyHD8jrjH8XklT2NtijcfHpo0s4
 Gh0rY0JKQ6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCawnk6gAKCRCLPIo+Aiko
 1fHgB/0WtDn05oOeM6hZu/GTe/PDgzLUFl3c7F0Z+9ryG+NGjzMMfp0BRbkJ2e0F253KW8scQzw
 cVRKagu/IxlmB2JVhSMS8rNHkFoBXtRfFdZqSc/uN1UvkmsqyGfIPp/YuAJM/aZ8KolngRn+Emb
 gebc8Vzm+ns8ZBuPB1yJYGcMfO32+SUVjHXOfSRsEtcBGfW8dXtAZlP5AxYn1hmiQHRMSrrZIoT
 Ugxj1VlxG2dReGV8nXWBHDwYTDCrBlQ+mwmpPRNsrsc/RBxZ9eHotgExhG77bnvunoiuoMfP9Xt
 6T4Kg1K+vejGX834xbzrcB7kEiju4hIIcgg2x0MDunzVrDqB
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4MCBTYWx0ZWRfX5XEtEH7ffRlj
 /S6a1Ss1CXLA0xCl0GdfN9jQTFQcQz/9N5jIHCGGQPfU/JwHKdes1d/MJjHEbjdmaFSBusY4oMj
 RuBKuOENppiftfZmVFEzETInJahDu7Q=
X-Proofpoint-GUID: OoY6mzlGnV2m4vo0pDoitxf1kdhdHB2f
X-Authority-Analysis: v=2.4 cv=LPLz05W9 c=1 sm=1 tr=0 ts=6b09e4f6 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=GtkpO-_-v3sBSqm_DCAA:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: OoY6mzlGnV2m4vo0pDoitxf1kdhdHB2f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4MCBTYWx0ZWRfX7SNhdtrKQVmg
 Oe3DSQhqDRqQXmtP3iGtlkhJDm0bfDnmHJVKKCSiFjSWCnwQkfVfBlh5wPW7jclZotUxs/TzOgj
 Y9Dbk8bCtOu438n2DqICBwEzEkOH/acYlrJK75BhQbn1j1875KV/Z/RwLzt+U/rU95o20wB89iO
 wqgK4Dk+nI/j1LP+OVGVB+Tc3h9ASXNmcdGU2LXW08VLsQHuqtPyc+BkAPf7xsDSCsCrHo028mR
 XSW2Y1ZSec0psdzlPY+cytSF9Ury1VOPNzd1dw9XNIHRLlnPXRTp01N49i9R8c45f2eRPtWqq2x
 eKjbrN3XbLdcH2k2HMHsWDeoxD0sVdsDapADMRE+2dyjb6MsWbiYqp2Ij0qtPA78TEyxZLua2eo
 cPX6sREMaLRKtNxOR9sgh/+mbZzYcs5oi7xDYmS92+Zjiumv8tooWX/BXmv/WjtxGk7NveJQ/tV
 NQ3cROeh9f6GBSX6cgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270080
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

The protected register table was taken from the msm-3.4 downstream
driver. Update it to the ranges of the msm-3.10 kgsl driver, keeping the
wider 0x100-0x13f RBBM range and also covering the VBIF QoS and AXI
registers at 0x3040-0x305f that the driver programs.

Fixes: 7198e6b03155 ("drm/msm: add a3xx gpu support")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
index bd4b3ef7bc12..6a9e0e87a8d9 100644
--- a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
@@ -288,25 +288,28 @@ static int a3xx_hw_init(struct msm_gpu *gpu)
 	gpu_write(gpu, REG_A3XX_CP_PROTECT_CTRL, 0x00000007);
 
 	/* RBBM registers */
-	gpu_write(gpu, REG_A3XX_CP_PROTECT(0), 0x63000040);
+	gpu_write(gpu, REG_A3XX_CP_PROTECT(0), 0x60000060);
 	gpu_write(gpu, REG_A3XX_CP_PROTECT(1), 0x62000080);
 	gpu_write(gpu, REG_A3XX_CP_PROTECT(2), 0x600000cc);
 	gpu_write(gpu, REG_A3XX_CP_PROTECT(3), 0x60000108);
 	gpu_write(gpu, REG_A3XX_CP_PROTECT(4), 0x64000140);
-	gpu_write(gpu, REG_A3XX_CP_PROTECT(5), 0x66000400);
+	gpu_write(gpu, REG_A3XX_CP_PROTECT(5), 0x6000018c);
+	gpu_write(gpu, REG_A3XX_CP_PROTECT(6), 0x66000400);
 
 	/* CP registers */
-	gpu_write(gpu, REG_A3XX_CP_PROTECT(6), 0x65000700);
-	gpu_write(gpu, REG_A3XX_CP_PROTECT(7), 0x610007d8);
-	gpu_write(gpu, REG_A3XX_CP_PROTECT(8), 0x620007e0);
-	gpu_write(gpu, REG_A3XX_CP_PROTECT(9), 0x61001178);
-	gpu_write(gpu, REG_A3XX_CP_PROTECT(10), 0x64001180);
+	gpu_write(gpu, REG_A3XX_CP_PROTECT(7), 0x65000700);
+	gpu_write(gpu, REG_A3XX_CP_PROTECT(8), 0x610007b0);
+	gpu_write(gpu, REG_A3XX_CP_PROTECT(9), 0x610007d8);
+	gpu_write(gpu, REG_A3XX_CP_PROTECT(10), 0x620007e0);
+	gpu_write(gpu, REG_A3XX_CP_PROTECT(11), 0x61001178);
+	gpu_write(gpu, REG_A3XX_CP_PROTECT(12), 0x64001180);
 
 	/* RB registers */
-	gpu_write(gpu, REG_A3XX_CP_PROTECT(11), 0x60003300);
+	gpu_write(gpu, REG_A3XX_CP_PROTECT(13), 0x60003300);
 
 	/* VBIF registers */
-	gpu_write(gpu, REG_A3XX_CP_PROTECT(12), 0x6b00c000);
+	gpu_write(gpu, REG_A3XX_CP_PROTECT(14), 0x6600c000);
+	gpu_write(gpu, REG_A3XX_CP_PROTECT(15), 0x6500c100);
 
 	/* NOTE: PM4/micro-engine firmware registers look to be the same
 	 * for a2xx and a3xx.. we could possibly push that part down to

-- 
2.47.3

