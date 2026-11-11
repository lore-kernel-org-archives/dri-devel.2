Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B20B606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J69cEcXE;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RB9QlD1p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF7E010F473;
	Wed, 11 Nov 2026 13:05:56 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0447610E639
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:05:37 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABCYmwW1358959
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f0yLKNDnww3+SWei9W0wFF0Lyh5I9mQALCn1s9fx8XQ=; b=J69cEcXEocePinNp
 ktr5ECqTOG0reESmo9WM3Mp/rDX9ndBwh+XcJwIdhZZMTURQ9j4KO9i8LtA0YoVx
 HzsyTJDImNCl1X1ntReEAD6SiYAp+3gI532HRqWiThEzNwxJIS5HHrrvGXh86hhY
 tJBKyDSRpnIh/E5Q/Jnc2j73MK8ATjspY4SE8KgBHh7AM2KH3GgcrEDHe/YuDtfz
 IoCoYXFoQWXXXKfEqiLrYQDYLKk+DfgGnIEiSi8EOZND/5P139+L4CgPSsE1EsMj
 eY0O+lNFZzhPtQSv0Z+NbR3p48su5ALQjsrU+wAibhkbOM/QzohCA4u7Fb+QYg/i
 NSzd3Q==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvk7psbur-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:05:37 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5eae356241fso771789e0c.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 05:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794402336; x=1795007136;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f0yLKNDnww3+SWei9W0wFF0Lyh5I9mQALCn1s9fx8XQ=;
 b=RB9QlD1pfpMT3RS8Y1LJKCblYo378Q4/+ZVzQozdKEFT1T+xetM7hw56Yf9TK1kg54
 GHsGjFMwUAb3LAS/QVYHXmfeWjUYkFmef+rRthICDAKB0IZCLCeF1brdohMForijXOBN
 7COJYqllvhMrRZmmpU7AHpgZw08l0szzO3mB246Pbfn9p+ehfQW5HuioBzibRlLF9Ewz
 DXVDAAmA6Dfb5pQ2i3hIXzvb8py7utsX7sItvHpaHtSM7bQ8GluY/zSAM5nO2bjJtUb4
 ItHBT5VPm4d7OjHDboWOTEA687sBrRx80/2nWhcugjxq5WyvODs54QLOAU2H0jqKawLu
 QXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794402336; x=1795007136;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f0yLKNDnww3+SWei9W0wFF0Lyh5I9mQALCn1s9fx8XQ=;
 b=jvUv8P3c7+2COmO6JfuejKi2db5NJjX/D0yWRpzuX9krRkUPPNFoe0cQsthC0ZF3xZ
 lM0nCcrtX/2kQnFpNGmDXJF9JjARkRNPkfzVduwoW4Aur1m5zuBh7NopeKHLBA7L+4bi
 f6/QvDM1CMfZyq91YWyU5aMOrPkLabmi0xOpSQFt3gLDjb0uFQ9SW/BgSYX7LE+y+y+e
 y/QmfKn3z5hmnomN3GgdNBOsnBsaATNCYNWmTt1SwydkhWguQ7W6VSce7OAF19viQHgq
 YTrrenikM7PIA43heqJ6qn0E4WGszykEsoVMKJAjIpM8yCQUrv/8R93goXdtKETacsMj
 aBfA==
X-Forwarded-Encrypted: i=1;
 AL+hErFeOcbIemNFhcH8VAzbxKT3NW5z9y8j3p3e6JEX5jzh7sU5zzSTKggTcYKK4G8aPv895wlF3FcV+GU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9vIr53h2KTaVcM2XEtwVB7cgAu9yDShywqA+9cxCYIerM8nMpI
 DYOa95v9HUnnFmwb7PS827RgmNoB5F5isnNLDMcR7qePqlh1aYgl51nvXWM5vGbOWcKK7J/ZpX6
 2JSt0hkphTo017+rLEy01dE9RwSBwpMAzsuAFx3C2TG3xytousuk4Euc/+jJYRKPv5SQmSa0=
X-Gm-Gg: AYBFou0qgEC8inth4pesWORr689BsDO390eYfsOM+YrOyuAkX51WjPp6nmvcEpjAmQW
 /cJG6Rg7kUT0n/vpNPQ2TRRJP0R06Q7x45WIHmgQBLqx2nyb1daR8y/Y4l7ls5nzUmuTQ7TLRX7
 4uunCc8RUzSmiFgCOaQmrSpcMYm4OU1CSmxkXqrcqC1NnJb6v7NjLGDJQo5o/lLasmDviLXaUUk
 dkRRV0/hFBBGW53jEnZ+dj/6QC9Rz7Wnfx2UpkiSig1tYg4399H+pzQRjGpNHqDDjSzEkTXNsfW
 0vRe1Cr0ftVx8P9Icifeo9h3ccyxAsVTO+UC0UtFP337ydFUw+Z0jkxddKwNL4VeDiEKLgyT6gr
 P3kb5gA7+qNyUZjqkefmHoXCtjq2Q9NpGNXM1iJWFLo0jmZtLXpBI/BLXObDSdqMoHWYnrOf/p2
 shBgfs2iFhb9UUgyEPYWKfX3bRH2XGink7eWnSBA+bmH7qj4BSNREscfdgzK4azg==
X-Received: by 2002:a05:6122:1d12:b0:5ea:bfba:f540 with SMTP id
 71dfb90a1353d-5ee1c2a6763mr633788e0c.1.1794402336465; 
 Wed, 11 Nov 2026 05:05:36 -0800 (PST)
X-Received: by 2002:a05:6122:1d12:b0:5ea:bfba:f540 with SMTP id
 71dfb90a1353d-5ee1c2a6763mr633735e0c.1.1794402335957; 
 Wed, 11 Nov 2026 05:05:35 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c15d368e81sm391858e87.21.2026.11.11.05.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 05:05:34 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 15:05:15 +0200
Subject: [PATCH 2/3] drm/msm/a3xx: update the CP protected register ranges
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-a3xx-fix-me-v1-2-d81f50f1ba1e@oss.qualcomm.com>
References: <20261111-a3xx-fix-me-v1-0-d81f50f1ba1e@oss.qualcomm.com>
In-Reply-To: <20261111-a3xx-fix-me-v1-0-d81f50f1ba1e@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2505;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=yYLTV1UC5d8C9jbVkPGq5PBTKlPR15ETUs1okUVkZbM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq9GgWL3UNkz7B8bvNeikBWcZLqWuj2MuVkKlUq
 fL7BIzn7zyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCavRoFgAKCRCLPIo+Aiko
 1UkLCAClAyTvcxSGuBX8eg0VNRKvnt3YdEdyJzN6NUH60tRNVAdUyU9FgVMmRmRqbgIG4kV2ef4
 9c17D+r+1qj2E2easVWI2qlxqUIAXCp5PAAWUROAQa8k8BiYn4a/rS3MWS81RSkSuoC9DsC34H7
 eWaX8U+rOmx54Xk0+/EkCv0NarrywElwyCYwn5063k1u/8NOYAc3j+PccwfAn2WESbXv9bUhi/f
 V6SaXrFfaZag3VrW2F/j59VNOtyybTFu6jaQVPGDHZG3L/8am6e6tUIxolhZrm93F7S9x2LL8wb
 idfW9vzevmBwKianIvP2Au1ZUpK0sF8kycpEL0MOCzaxkNY2
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MiBTYWx0ZWRfX+lLV3BYtpmY0
 0WYbJu85KZUZZYgpl5ElaB+oEqfDahRlVhq/0IGbEUeo0+YxyzeaWOs/v/YRN6SuJmvcqfyfdaj
 g1rGmAawEvnmjKOSHctCvi9NZE8KtIc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MiBTYWx0ZWRfX37jD42ZtkZjx
 Mwm9rLiakARRb/TPMZH9ZLcNxeBFr/OvfUPihBHAaT0goaxWmpOelGE8oWJA/xPVMCHNGvhwoP/
 bdPXnJ2uyAs3AcK3ziSPDI6VSBM9QzQme12ae4nKbYjWyoh3DA0g51u+1inxDJIBmortmsHnOWT
 PwuXHjI4WTpMlpd2z0zZUMRHWLGRDFeez89plTIRcGpzkNdviaPWZdP8hA88gvLDm6fZ9cPd0Tq
 sSe7OvgEagAsbxIraaDd16lfv9oJBtgoPD1WruPlZkPL6owYYEbGVPuBInf0ue1QcD5SMN7z/Cn
 KZPmZbBXm75hIn51SPRZ4Tstp/gU8TA3qKLq7r25Dr4nSHFhsSN4EieQgnp5kRTu2D4VnP7D79I
 C0uuouGCY50aY1dg9Cv4Oua4DrAK3EQJE6894LCwg2oXkZo6ExAawkeoXDY53COWw9TGBjwt8bG
 M3SJbGiTEFWQjCC+Xew==
X-Proofpoint-GUID: J6EpgWEz6YOmeO04XaXcs754LRYQ8y8K
X-Proofpoint-ORIG-GUID: J6EpgWEz6YOmeO04XaXcs754LRYQ8y8K
X-Authority-Analysis: v=2.4 cv=BpcIUoX5 c=1 sm=1 tr=0 ts=6af46821 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=GtkpO-_-v3sBSqm_DCAA:9 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110052
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
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
index 7e03b7305493..1de4277ebf9a 100644
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

