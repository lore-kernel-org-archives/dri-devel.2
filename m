Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9148CA6017
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 13:38:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F53E10E267;
	Sat, 10 Oct 2026 13:38:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aCQgeTtg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XS553H+W";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24FB510E9F2
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 13:38:51 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ACUcPZ1136814
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 13:38:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kHtZNyMSXq0QZGYx+q1LRaidhBCNzKIUHBntx67BFgY=; b=aCQgeTtgIGhdrwiB
 YjmrpND4nMfQ8tj6qPSMv+MKr53DjHmQ162Ihg6mKm+VjodG3/kqXnLAUfcfP4ta
 0P+Bd0gZ2isBAa6RZ3LZNQ9EJbe2wUDJto3MQcFLyg1fkF/ZcLLa+PZgjBXyd6V9
 mrowKOXyl5FiJDd+mkIuMaXLF6TAnJZJZmBfcs/bBc7oZLZATHC879SmRxk5bjoQ
 zEBrmimG8sNJ9D+LxQ6BXiI79r/LpRHWNdQbrr8Gz2FXhhxMGOFzwp72Gzb7O1xf
 tXYyeI3i3tsE79AgOjH0jV6pe60wRn/WX1Imyp7BjuUaHD1uoenIbRGidvsTxT3/
 F1LZXw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7cxxh6c8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 13:38:50 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-34e676375d9so764781eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791639529; x=1792244329;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kHtZNyMSXq0QZGYx+q1LRaidhBCNzKIUHBntx67BFgY=;
 b=XS553H+WeRW1W53j2Wp+KgZj6rqvdr+byozgIf7n8Vuwcvsi8sXuQfBgHvftNZNwcO
 lMoBWZVGxJU4CtiB/MRLt3qfFY1rwccpdig9I0unUut1L9LafE1rLdvq+ud6iILG2UI9
 UnjWdEg8pfrf5xhKcaqMvrj3jLgtCsyhjmVTUH6A4vv5CT2zcj20rGV5L9+GAPVuk8T1
 OT636RVz696vw64KNZeNM4Z8LIY8U7hf0jT1KQdM6LLiYdY6bl9A1mdxadOODHHENKQm
 +/At6CFcjNfhvd3cdWEr14diE8xD4yKZ5uZ0SO9V8u5IzsCp6xlbmv9bm7nSCn9FdbOu
 4nSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791639529; x=1792244329;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kHtZNyMSXq0QZGYx+q1LRaidhBCNzKIUHBntx67BFgY=;
 b=wPYsjE2PRQWzXnAvf+7niqghoKpSPtHD+PQoazBr3l0N7hxz+VPXIYmfiVIpzO8WCf
 M7i+7R5VzfZ+fCGCv2QR9Arm24R1cUpcJmf1E3lMAnZ5FVU8UF/JwOfr7JNPdRKzL2q1
 HwLk7SIRjTil6QP/dXqH2/wJNaVRd2ZTXhQdv8T3CGAoshYZ/BxCwGTcbi20Po5BFHDm
 kXu8miwgbKMaGfwhOqvtRApqu/txddq6If9nbenzYNgcIug9QMUCOyRbeZ4oFDmNBbF+
 lqqg2iTWQzHm6lIdc1IqS32/zYBmUkuzUHekhPnKYbqS3cZBvproX3yA3geL67BJXOSF
 nCfg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw4Ym6/6I9H0Wgtccaa7/CHHQiwEoRhrC+ZUU+9BsHM5k5KXtr2eZAPzI57sxTbYIhZyvrdOcKdl7E=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIvfUMf/LnhaBURt4f5BEbBB3tgW+5eeDg696vYvYQZu+SoBPCL
 iE3rKQzGXL1HFbi91TfmodlbQR6DB5DMa86iC2koz4gN6dpWMqCA7FeQ1fdvxrLZ/al3RW2hV6g
 5JIon5sLrJz6ufOOadVuBV6S1S0xSHFjeHaVEq/OtisNsajTXPmy0a58ZIsslliQ+g9BOg3g=
X-Gm-Gg: AYBFou1JzJ1pKBmEN9ZWiuXiy0WpM4Hm9X4R124FUQqeGdqgjL/0YVRFn8shKcIdbrm
 6C1oTPvZp6lS0cBgQWdNi4jF1HQIhnsxTeWuPtAqGT4jWjaK20MstmkzfX5jAP20SX66P6Yc3UQ
 gH+fnralnAv7jxQPKYIBqr9rQQjd1ogXdSZBRBzSx8mnwkL/fnxzf391LmXLzZIEe8L44OREMsM
 CAfUpR9sZ5dk+kI+YmUdLH7wIrY7nimlH90Ozh8JMuzgERFHaNk6r8FEYpgUcENczTRqtl4QdGR
 xNFf+JG77U2a3a/HJd4DA0VqZLIzonyWMzKS4MOHFeYdR9i11RA92trOnsq8pFLXNEVgD61kRt9
 0CtaPetlJy590d887tQMF10i02g==
X-Received: by 2002:a05:7301:144a:b0:351:7cfd:21d4 with SMTP id
 5a478bee46e88-3537dfb8620mr5914346eec.8.1791639528924; 
 Sat, 10 Oct 2026 06:38:48 -0700 (PDT)
X-Received: by 2002:a05:7301:144a:b0:351:7cfd:21d4 with SMTP id
 5a478bee46e88-3537dfb8620mr5914314eec.8.1791639528375; 
 Sat, 10 Oct 2026 06:38:48 -0700 (PDT)
Received: from hu-mahap-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841579sm15232827eec.4.2026.10.10.06.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 06:38:47 -0700 (PDT)
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Date: Sat, 10 Oct 2026 19:08:24 +0530
Subject: [PATCH 4/4] drm/msm/dpu: add source split order op for DPU 13.x
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-pipe_order-v1-4-9d8bd29fd78a@oss.qualcomm.com>
References: <20261010-pipe_order-v1-0-9d8bd29fd78a@oss.qualcomm.com>
In-Reply-To: <20261010-pipe_order-v1-0-9d8bd29fd78a@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791639504; l=1736;
 i=mahadevan.p@oss.qualcomm.com; s=20250923; h=from:subject:message-id;
 bh=XUyNTEFcipgH+2wGah1ib1FvGFg+4/irpgIv/e8LCDM=;
 b=3iBVoMZ9oxmiDYlnLQzzE0n7Sdih9UpAJ/RQKw3pfJS0uwuZ7bnHGlVsXZ3DKcX5B86KKw9Kr
 ySwU6rpIqkyCS2JgoInLJ19uO1oHzobR+C4UMv7KI+E0N/SoeuVoEhQ
X-Developer-Key: i=mahadevan.p@oss.qualcomm.com; a=ed25519;
 pk=wed9wuAek0VbCYfkANx7ujIG4VY0XfCYrffFKPN2p0Y=
X-Proofpoint-ORIG-GUID: 3iDpXV2-fRE9RY5aseUCS7xUtGqbbdaI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDA1NCBTYWx0ZWRfX3An8CZpI4Apq
 4l7nDLVGdIwPa2BJRnGaoL9Al1Lk39abuWUKbkrdz7vZtpsZClFYnHiXVRE4SughW4+Wp5xe000
 j1RKm/Fo4IErrIeTPsMDTcBLs450mW0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDA1NCBTYWx0ZWRfX76cvdvQsFyFw
 0pl06R6m1b7W8nTg95bOaLISrPN3CJz3xGzK7FcmlcbBvL1izM/C6HWWCcKt16g06/2oYR0O48l
 bR+AI4j9GMd4QF1K574JfgCVNsZ15lowz2WYSEwHQoM89a/z7WUo8ZgyQo6BzEHPWPmdDfyCfdZ
 hqyDX0aG33tnddzAsrPihF0xmV2Be+x2waS7HQhD1rQ6sMBy0Etj70/hLW3BgsmkG6oYAnXheV7
 LfrtxxTylKpE3dXU0+UprXfOjrMFpICqZy5v1zGbOZZYQ5iXl+kGgqckjewtyfcikbVApFehGWA
 scMGK6RD/5vUGy9L+Zdj9AZbq03GSm4imOEsSmRVAqce7UDs+Y4N7lQShGzxxmePKImzUTeJMwA
 CsKX4x2XLDAXO8QCUC6f3HZqoMWOEGg41XCLbbw9B3cr0fH0tg7ZV5Q1MQJdvRW5gv2thm/wQCT
 f6tpv7MfRAW30BHxDVQ==
X-Authority-Analysis: v=2.4 cv=AsJ7T+9P c=1 sm=1 tr=0 ts=6aca3fea cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=mI-fRwl2AojlbmlKxQgA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: 3iDpXV2-fRE9RY5aseUCS7xUtGqbbdaI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-10_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610100054
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

DPU 13.x places the SSPP op-mode register in separate REC0 and REC1
banks. Add the source split order operation for this layout, using
the shared helper to update SRC_SPLIT_ORDER in the selected bank.

Assisted-by: LLM
Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp_v13.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp_v13.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp_v13.c
index f8f96ad971d7..bdf1201d8134 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp_v13.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp_v13.c
@@ -149,6 +149,19 @@ static void dpu_hw_sspp_setup_format_v13(struct dpu_sw_pipe *pipe,
 				 unpack_pat_off, format_off, ubwc_ctrl_off, ubwc_err_off);
 }
 
+static void dpu_hw_sspp_setup_src_split_order_v13(struct dpu_sw_pipe *pipe,
+						  bool right)
+{
+	struct dpu_hw_sspp *ctx = pipe->sspp;
+	u32 offset;
+
+	if (!ctx)
+		return;
+
+	offset = dpu_hw_sspp_calculate_rect_off(pipe->multirect_index, ctx);
+	dpu_hw_setup_src_split_order_impl(ctx, offset + SSPP_REC_SRC_OP_MODE, right);
+}
+
 static void dpu_hw_sspp_setup_pe_config_v13(struct dpu_hw_sspp *ctx,
 					    struct dpu_hw_pixel_ext *pe_ext)
 {
@@ -299,6 +312,7 @@ void dpu_hw_sspp_init_v13(struct dpu_hw_sspp *c,
 	c->ops.setup_sourceaddress = dpu_hw_sspp_setup_sourceaddress_v13;
 	c->ops.setup_solidfill = dpu_hw_sspp_setup_solidfill_v13;
 	c->ops.setup_pe = dpu_hw_sspp_setup_pe_config_v13;
+	c->ops.setup_src_split_order = dpu_hw_sspp_setup_src_split_order_v13;
 
 	if (test_bit(DPU_SSPP_QOS, &features)) {
 		c->ops.setup_qos_lut = dpu_hw_sspp_setup_qos_lut_v13;

-- 
2.34.1

