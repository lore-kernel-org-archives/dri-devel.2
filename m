Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39E1CD4F21
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 11:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3225110E146;
	Sat, 16 May 2026 11:53:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ie0T8854";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OdfL9mfX";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B1E210E146
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 11:53:51 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64G3lt6o3573290
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 11:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=+Nopaqt4P/VG1rvKE+IVOo
 VaDtQUdLtKRdO0so13yBE=; b=Ie0T8854wudsdJ4qXSusQPBiQ37uBKioqVfMPS
 By4n47/0lvgq7ttHXx63pjW4rPaS93xMRiX1GInCPKbxzbnYGSmX7ujiXXolr44a
 rG5h7RZS/dRKRu5JfnKq9muqPSZ5mFN2QH95/BY/cA7bZ227/e5YlHLcKKekWm5B
 UWzUTdlY6WRclKjXI/67uAb4e9wGefSjE+hrU8HcaXSvEQ+mVuCVw9mktLvYmwnu
 mtIldpxNwOllvYDhPzxuu6kEdffOVkj7Ky/xtkVoYWVNiSbZgAWMQvlkxYOmZlg6
 XT5wkphfAVrIQSFNvHe/mFsFfCOKxgBjb3mLiD1+3ZfUicTg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6h01gsan-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 11:53:50 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-90fd6eeed3cso205497685a.3
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 04:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778932430; x=1779537230;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+Nopaqt4P/VG1rvKE+IVOoVaDtQUdLtKRdO0so13yBE=;
 b=OdfL9mfX6UkNY/CYiTC30HJGEuVMY/FIvqFGie9j9w53LsX2Cr37XIR5ION7WZ37yo
 ddx6W0UWsmv1thdxirPF531lspgQkGFIXo+vtxM3EujbaaAJK00uH7KvFUphdvCC+GE+
 rcJC2LtpTcPCzDJeMVyAm8MuUfI2XpERQ0y02hP3/sUf2cbdJouzyPPXEDpfAL6v0w4F
 /BQD4gKBNyPZtFpJsok5zcfsn0pbEnD/Wb1xEp8BcT2LpdbrtGNko684W+2vSIDjUZ/S
 m29CpzEQRIeyuoHeQ1APsdzJ+sLerxPqXZi9SaUYhrtu6WISWbqdHgTgQd1SOY+YeBm5
 PP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778932430; x=1779537230;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Nopaqt4P/VG1rvKE+IVOoVaDtQUdLtKRdO0so13yBE=;
 b=Gosss/Nx93LUJO6YFjPlDOkfenGDbZ5UKlwEwmAWmQ6wEUxeJOYYAhGwi/0rz9JJ2T
 S/a64oHUUs0AbdQdE91+9R7V2nv0DcnQo/4tiN8S8+Z2Qi99IISc90n7k/H+DiLQaZEq
 0aUFXHZ5F789fxZcCsCBBEMfh0oy08ukktwTK2TG5B/j3dHZplBO1GjReMgexeNj/cio
 uLbqD7YtgOPVYW8a50xIqi5pNFrcxR/lC3yV+7uJf24fECXI+hQsbKVqJ9QBZvi9Qp0X
 qmx2CiDNY6HTFbVi6OXCZmzGGnN5CKyqPr5HZMdt1d4HU+9AmL4ujUhIkA2OG1FawU2Z
 Vo7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ89TjzL6O6tRlHDZ5E31aWiCjlejgGgKKBPn/hnRFx9cCe7H/U5X6Vb1dhMCLQ1eO6iiCFic0Ym/K0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwzunPX8O6VUpMUS952enJyVmKjWOcygNEqgFOdMvAKzbTJ/FOV
 RuQ+sbBW54xc8KngERP9hqG2rMbvHLeq4dCDQ5ddLFkBS0osKZ/QM14vBSTpxo1dVJJpNCWDW40
 YPG78mFyxtL/V64uVi1t4d8lU6zsQysI7Q1/el/XUOmGVWc9G5CtKtpIO/Oo3QVrA8G31xdE=
X-Gm-Gg: Acq92OHisli3oC2nUUpH4/4TZMx5ZSRAkh+n9Wuj+ASnOE0whVqb2cO3gES/ojyglR1
 PTPbJzpttxXwCLpu+sbq1i093yWcFN9jmhYxrnovXnmN5JqgK3QfiBoFCaKSJKmzyD3plDaCrfE
 +scTuGh1zqxoNeeg6VM1sr7FBseLgr3RWTWGGlw8Vq9Ayr5nsZVdlDYE3mOFnZsDd0Tg0paciJl
 BW8Pf4Da9Fw01sKuhH7AaeRXgdDGNZfOiqLxc+gLuTez/JIP9KkCnNbA6/I9C2VZ9kpOrdCaQal
 V3GgiLolDrcRaGD48d6i+zCS+0dIwbTL2oLh6xq8YHLH4299RTkIP0rlz6+4QxCb/2gEBnS64P/
 uRg3hCT4E0dyRdzYl3qhqgLF8q0q83H25UBh2ccAlsFb2RfC2KnDcCzYbMTqa61TcEQ7la2RJtH
 lgFjDt/bmZpFD8TB+5L1btOPJ7ndSn0z8bC3o=
X-Received: by 2002:a05:620a:4556:b0:8e8:bedd:14b7 with SMTP id
 af79cd13be357-911cd75d7ebmr1186970985a.22.1778932429923; 
 Sat, 16 May 2026 04:53:49 -0700 (PDT)
X-Received: by 2002:a05:620a:4556:b0:8e8:bedd:14b7 with SMTP id
 af79cd13be357-911cd75d7ebmr1186968085a.22.1778932429417; 
 Sat, 16 May 2026 04:53:49 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164c4b73sm1947270e87.55.2026.05.16.04.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 04:53:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 16 May 2026 14:53:45 +0300
Subject: [PATCH v2] drm/msm/snapshot: fix dumping of the unaligned regions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-msm-fix-dsi-dump-2-v2-1-9e49fb2d240e@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMhaCGoC/22NQQ6CMBBFr0Jm7ZC2QCOuvIdhUdoqNZZiB4iGc
 HcLxp2bSV7y5r8FyEZnCU7ZAtHOjlzoE4hDBrpT/c2iM4lBMCFZxSv05PHqXmjIoZn8gAJlqYp
 Wc8mMkpAeh2iTsY9emi/T1N6tHrelzegcjSG+9+rMN+8XkP8CM0eOZVGLI6tLI6r2HIjy56QeO
 nifpwPNuq4f3hp7Hc0AAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3628;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=T1EcXcxWq0rQvQxiX8jHAnIiOpw0u6XiHh6h8Y5al8M=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqCFrKTbeuaUtQ2yYqRJ15mWPB6rp3wK/V4PG05
 XzVTEWRHGyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaghaygAKCRCLPIo+Aiko
 1WQzCACWO6+MmByjin6N2P2AiqIRhQRQ/faI85C7RppHihUqm5HdCwZDGTmWyeY/8yJOg9Q28rX
 gjNmQMSNY5vnfg5vFYQdMv1t4C3UXGg76qeMGBjsneVxLm7tp4qYQEtmKaIWqaxYDVgt2orc6dS
 MM2dtNfkkr+dqbEW/E4jfzJcpRZdZ27Ziju6d1ohq7F+oZ9KTdtRP0Nq3lGyCImaBPCZ4wMvkCk
 YTQOToCLX1aIAAk/PeqY6Hvq3TsmlB62n+4ZQ+lELd+kuhLP0ehV0DaaZZcGdz61beZkWVqZnoH
 LSIPRlYMYLXq8lfPZ0kl8O4aXcRVpGwRnbRGJR00nXuhsa/O
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: _IkRI8PzCvjSW2y7SocRx_61p2TzjLaf
X-Authority-Analysis: v=2.4 cv=XbG5Co55 c=1 sm=1 tr=0 ts=6a085ace cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=IVn6q5FHpPisWK92jdoA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: _IkRI8PzCvjSW2y7SocRx_61p2TzjLaf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDExNiBTYWx0ZWRfXzIAozHxEYtS8
 wa+RII8XeyAXVFS2X+UiiBqwcI7vb3vLFxxkixZDq29UkVZ+T/bUKWqIcOZ8C6WysS0nMdRRp3S
 bd0BskixuNlNWF19R2CQSfXTHYbMWRLBjUjGd1hlmf1BOd78fgT22eADW8mmJzC+K56RIpYdqzg
 21HnWHuxrmVZhDFBeOP+WFdHVvHL0jx7dx6mxU+kr1okkRediGY7K7LOTP6+W9J+zNOBexJqwg0
 4TK/wu87o4OS7F9SA8kY8u/irVthjSe0t7hLa+dB+x1vF98b0QpMj7NjWwKiOPonCK409NhTxSf
 ZJCzKVCf3ut6DwbgB7DEXA+IuPJY+wuVSuNMXFaIFBQNzj7hFqh2KA+s+j5fylAkpU2IbQeikjk
 +23mdwJrCblKjC2ymUn2wlE7/WCjIEzwjUjAJD48F2KexTo6HaK6nvENjMod5FUCX3fADqC3bUq
 kpMj00VKPZq5IF5bWZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-16_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605160116
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
Changes in v2:
- Drop the debugging clause, limiting dumping to DSI control regions.
- Link to v1: https://patch.msgid.link/20260516-msm-fix-dsi-dump-2-v1-1-43928094d25b@oss.qualcomm.com
---
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c | 24 +++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
index 5e151952dea8..c8a10b1232c2 100644
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
@@ -185,7 +197,7 @@ void msm_disp_snapshot_add_block(struct msm_disp_state *disp_state, u32 len,
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

