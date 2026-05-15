Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 590A2CD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 21:40:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2CE210F604;
	Fri, 15 May 2026 21:40:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hsQmukuO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PEPK1MTt";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE1B210F604
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 21:40:13 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FLJYZG2485352
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 21:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=OKkbaykvbXdsB+BNrhh2by
 OrHmUZCxNVjNiczxF+Bwo=; b=hsQmukuObI+/wlN6uVU3a0v0kPWf6HeehB0N/+
 XiLxLxa9ZBq2cnVU6tv00SLfSOIIlgP4G508fRVjy6RzPfcCC/0XAcb6nU9hW6r3
 2U34d7cwnkZXpKHlKoQrow3vEUfdL0Xo8J6dYNEOffAmMk4w24vjXJGh3TOom70m
 7gZyU8dIHGxEAftlm6DaIoKHPybfZV068i4BJtYRJmoHALrANf7fSWnd7rFEGB+M
 Fb2DnHFMqxz+E/TrICL+gjB7IyKIHla6QBfTpwU/dVM57ZjoU0/84ROb5HbqMVch
 sVrZ0GYBdmDV1sy8MG4lO0Kk4bEGG4eVusTICWlkQTW6g9WQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6ba7r1fe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 21:40:12 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d6bf346adso9218311cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 14:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778881212; x=1779486012;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OKkbaykvbXdsB+BNrhh2byOrHmUZCxNVjNiczxF+Bwo=;
 b=PEPK1MTtO/siZvaDbj9wB0eIVUFNPtPx9xRLGs3AuFp2YnsAYtSCjS1ASTPeXMme9B
 8Tj/jd7DE2yENCjRo8wj7gn+QDNB9IIhS2XAHvpVxEx0/Nk9nDYaVj1tW9oYG8ACHxLr
 l2foCXwclXAEftJ7R61wG/KAH6vaF5wOokwymzgQSnZnWd4c7Vwn5YLK6mEMN6gU4fnY
 Z4l2FrqmWI8DFY5CNr2upbhQyuS3vyH4oMXo9CVsjSPu4ZHmLYvU9h59bf+um7iTSUuF
 XNXP8GtOFRYsx0MCnAVE+1Ez8nn392b3kqguMPyEsXrXBXdSWGTixzeKQ/oVhMv3yx4n
 TkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778881212; x=1779486012;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OKkbaykvbXdsB+BNrhh2byOrHmUZCxNVjNiczxF+Bwo=;
 b=ePegFgK+FxWn00BGqUY9S8vxJ+DbcawqoxdrUoVO6N6kbLiBezOKglLjMHR0Ojs6qY
 WwMfhdLvMRiDbF3GNtRS6eBth+p2Rzr6LFCntHKSeYfJTuM4rPNWBS4g8N8ty7HCTJjS
 7OeDGhjtcwYts2yyj9aoQd+868ZZumMLrgxccgtMdnxH5RQZLwwKBgjh1RpuGWuYxQ8e
 J3MFvcxiY8CMFY9qLPEEoLqVhTHZs8shgt3HB6o0R8tv/IV05R5KIuhxP4AiBFd+uYz4
 q3Vx4AVGYb3JyndRXpyqBqoQAFkYQaMwTvfKiJUPcIJksW6P2brbN8QerU9pu+r2xRvV
 KTdQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9XXlKjVZcD30WLxbIXcX+AnQJPETs6mBWj9/vnD12sdsh5Jgg3YAzwMuSqXdt6t8lEiR3PbOfzSC8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwnYd4O+Y+KhcsA30dYqK/beniioleavC67P3sFIsKc0/OpV9rn
 wU+yecdfJBQojLQePAWaWy2uSB5mZhGYM0kDPAQq5m/wYvxuyPY6DFfwQ5MF1w3iMWwtCkPm8Pb
 Xi6LYmBvi3/kwe5b0wTZ2SJE/mXVrIbTxzW4489mXcbkAZIuR53SZBzpDiN2Hgok0rnFw96E=
X-Gm-Gg: Acq92OHCtSdhakOwzow+26i0DwOuzRPkklFfriE9/CHQJUFbZTThApF9WeeeHaPNyJ6
 QErX9L5wKo0A5HP1jz6b+m38GMoqBFqQjlZpnkGC2PK7Drf2CuqfSWxVH1nGltNCI6kXNaU34NS
 ewdUmOJ1bZlsdZs7M4fMMQx+jtt3gSFWaegazdPESFRjAPNcnuffZFSQDA6h1QMXzbM8SLhVFtm
 WvqgK+Zg2qMLSb78RXIxn3qetRkm5THCBGP0T1hyGL02esy83FTpEvidseijeE4Laz0cvSNEHLi
 W6Y67vviipmq5LNF94V2z24okkShlQCgOOQy1Vh/T+OWlEzZVrDQhFPzvHayTH6L9NovM9GX34a
 LULfIUPNN0qnzk9Upp3wGq0ySziH6k9856o5vlH9LKEXjFSpvxdDQfmV6s0tCxx18uWUWjzps1f
 mhGW4gNDS/aLHuE9t6j1Hv3oAutl5tCpZgDks=
X-Received: by 2002:a05:622a:9012:b0:50e:a1ab:114c with SMTP id
 d75a77b69052e-5165a1eb7e4mr72271501cf.32.1778881211924; 
 Fri, 15 May 2026 14:40:11 -0700 (PDT)
X-Received: by 2002:a05:622a:9012:b0:50e:a1ab:114c with SMTP id
 d75a77b69052e-5165a1eb7e4mr72271161cf.32.1778881211521; 
 Fri, 15 May 2026 14:40:11 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3945c8859e6sm18274001fa.9.2026.05.15.14.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:40:10 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 16 May 2026 00:40:10 +0300
Subject: [PATCH] drm/msm/snapshot: fix dumping of the unaligned regions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-msm-fix-dsi-dump-2-v1-1-43928094d25b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALmSB2oC/yXMQQqEMAyF4atI1gbaql14lcFFbaNGqCONDgPi3
 a26/OC9/wChxCTQFgck+rHwd8nQZQF+cstIyCEbjDJWNbrBKBEH/mMQxrDHFQ3a2lW911YFZyE
 f10R58UQ/3WvZ+5n8dpfgPC8nE9lHdgAAAA==
X-Change-ID: 20260515-msm-fix-dsi-dump-2-64a3bc160da6
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Salendarsingh Gaud <sgaud@qti.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3707;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=mSBe1ewrkuZ1aPgknwAsTonJHEuKfOujavbWoGjO4AA=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQxb7pF2XTjo6pqZVHWkLLztrePa3jpZ6/Avh1/MCDN8cD
 1vmFXGjk9GYhYGRi0FWTJHFp6Blasym5LAPO6bWwwxiZQKZwsDFKQATmXif/X/QhPsXWA43bncL
 WT3hTeCtl4wKEe8mKmpKxU5yLkjftyzh9PYNwhcO8NWUtjJ2G1zsLiifJn9SJMwoMHSlXFzwW4E
 fvqUrwmp155s/EI9bsKOkX4G1htdkh/uXSRMS/Thvl1yV8tZfLLn8pffb99c2RE3UmP37Qchl0a
 yjE3ZJKD3o3r64u/7WMn2lX6fcXH5sf7Qzi+UR7xmpYEvLspNBqaWb828KWBoXxHSlLG2U8VHZ8
 dhQxPRXiv7DfKPPF7IYni/l9lZmPm/2UiP9rskR8cbJgR9Tl2r7poRrKU5IWGZluNv7gJrB8whf
 U9UTevqmDA/Z17flOvfv3+EbcK16Y7HOXG4DqWjZn0+9AQ==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=DeYnbPtW c=1 sm=1 tr=0 ts=6a0792bc cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=ohjMCsGq1aJjNZ5JAMoA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: q3cosLAPrQMM5UthUQpi_MhZ5Py_rfBY
X-Proofpoint-ORIG-GUID: q3cosLAPrQMM5UthUQpi_MhZ5Py_rfBY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDIxNiBTYWx0ZWRfXx8fVqTBdbmU9
 /4wmi+M7IrK8zQqOm0n37cx7Sn+bHPWsJW6F42DG4OFyfCWWjdqFIIbD9fi6mtWnGioAV2k9HXe
 JfqbsXXzU+QMXdn9pYtn0VN4seiOwMM8EL5fdXNptg3IXdDAf1mkO2+42ZMyI7WDbX13+L8kmmu
 16I72cuy6m6yXGvBr5iL+MgrFAIbv7GUL8OkO3hPUxGwhb6LdUX8KbwW3gx2yVINd2s0m7asQpH
 A1mUXaS4oIDSdqzKYCH/dCc9LLHW5cr1BGMbyuW/4fRFQ7sHJzbD3vHUZ06SnGMfGonMPndVOqY
 pQqTUK47WOLNukNpceUK/+XVyF9BaybHHHw2CLaXSyRCs/jqjKhjABr9OLfytW3+X1x5eXQJTmg
 fgV5KM+TdlLvhsQOQp0abUNmkbUhGxDWGkEyhj2zQoYcZwBnMoHSK19aYuQxdGI7ZMtUwC0uLU9
 8S1bA392e+QmLpLWdqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_05,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150216
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

The snapshotting code internally aligns data segment to 16 bytes. This
works fine for DPU code (where most of the regions are aligned), but
fails for snapshotting of the DSI data (because DSI data region is
shifted by 4 bytes). Fix the code by removing length alignment and by
accurately printing last registers in the region. While reworking the
code also fix the 16x memory overallocation in
msm_disp_state_dump_regs().

Fixes: 98659487b845 ("drm/msm: add support to take dpu snapshot")
Reported-by: Salendarsingh Gaud <sgaud@qti.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c | 27 ++++++++++++++++++-----
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
index 5e151952dea8..a86c7fc46f68 100644
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
@@ -9,7 +9,7 @@
 
 #include "msm_disp_snapshot.h"
 
-static void msm_disp_state_dump_regs(u32 **reg, u32 aligned_len, void __iomem *base_addr)
+static void msm_disp_state_dump_regs(u32 **reg, u32 len, void __iomem *base_addr)
 {
 	u32 len_padded;
 	u32 num_rows;
@@ -19,11 +19,11 @@ static void msm_disp_state_dump_regs(u32 **reg, u32 aligned_len, void __iomem *b
 	void __iomem *end_addr;
 	int i;
 
-	len_padded = aligned_len * REG_DUMP_ALIGN;
-	num_rows = aligned_len / REG_DUMP_ALIGN;
+	len_padded = round_up(len, REG_DUMP_ALIGN);
+	num_rows = DIV_ROUND_UP(len, REG_DUMP_ALIGN);
 
 	addr = base_addr;
-	end_addr = base_addr + aligned_len;
+	end_addr = base_addr + len;
 
 	*reg = kvzalloc(len_padded, GFP_KERNEL);
 	if (!*reg)
@@ -48,8 +48,8 @@ static void msm_disp_state_dump_regs(u32 **reg, u32 aligned_len, void __iomem *b
 static void msm_disp_state_print_regs(const u32 *dump_addr, u32 len,
 		void __iomem *base_addr, struct drm_printer *p)
 {
+	void __iomem *addr, *end_addr;
 	int i;
-	void __iomem *addr;
 	u32 num_rows;
 
 	if (!dump_addr) {
@@ -58,6 +58,7 @@ static void msm_disp_state_print_regs(const u32 *dump_addr, u32 len,
 	}
 
 	addr = base_addr;
+	end_addr = base_addr + len;
 	num_rows = len / REG_DUMP_ALIGN;
 
 	for (i = 0; i < num_rows; i++) {
@@ -67,6 +68,17 @@ static void msm_disp_state_print_regs(const u32 *dump_addr, u32 len,
 				dump_addr[i * 4 + 2], dump_addr[i * 4 + 3]);
 		addr += REG_DUMP_ALIGN;
 	}
+
+	if (addr != end_addr) {
+		drm_printf(p, "0x%lx : %08x",
+			   (unsigned long)(addr - base_addr),
+			   dump_addr[i * 4]);
+		if (addr + 0x4 < end_addr)
+			drm_printf(p, " %08x", dump_addr[i * 4 + 1]);
+		if (addr + 0x8 < end_addr)
+			drm_printf(p, " %08x", dump_addr[i * 4 + 2]);
+		drm_printf(p, "\n");
+	}
 }
 
 void msm_disp_state_print(struct msm_disp_state *state, struct drm_printer *p)
@@ -172,6 +184,9 @@ void msm_disp_snapshot_add_block(struct msm_disp_state *disp_state, u32 len,
 	struct va_format vaf;
 	va_list va;
 
+	if (strcmp(fmt, "dsi%d_ctrl"))
+		return;
+
 	new_blk = kzalloc_obj(struct msm_disp_state_block);
 	if (!new_blk)
 		return;
@@ -185,7 +200,7 @@ void msm_disp_snapshot_add_block(struct msm_disp_state *disp_state, u32 len,
 	va_end(va);
 
 	INIT_LIST_HEAD(&new_blk->node);
-	new_blk->size = ALIGN(len, REG_DUMP_ALIGN);
+	new_blk->size = len;
 	new_blk->base_addr = base_addr;
 
 	msm_disp_state_dump_regs(&new_blk->state, new_blk->size, base_addr);

---
base-commit: 11ff30385c8ad7de9862f4f1cec424fca15a4f13
change-id: 20260515-msm-fix-dsi-dump-2-64a3bc160da6

Best regards,
--  
With best wishes
Dmitry

