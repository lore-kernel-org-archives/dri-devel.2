Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B7A606A322
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 06:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dRS16m5m;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dqLjEITA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48F5D10EBD4;
	Mon, 26 Oct 2026 06:24:12 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E9010EBD9
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:24:00 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4b8Za1908167
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UOR+3mQqNWrrLiobLgmkq+PeJAutB1Cemy1/2B3AOYo=; b=dRS16m5ms665/YuJ
 Br6BSa25BglOaVUYMDaXlJ/uSX/QpV0mpRKD61oClP+LUpAWEYxStU4EwUO7hnkJ
 jxgYutwnPits5c143mX5LemV7XGVjloM3+tGUkMa0S+tttGEGrpl9b0Hmkw4B1x/
 HanNbhsCSlJw1Dz0s6337gsZcwUhSYBISHXwmxkSyAIK1vX4ZmvtOt87m/f9Pn39
 cQt2Zyszk5Up+EJ0jQX3eHeWNiY+7txu6jGXuvTAXvdpEbreH4HLdrMZExPIZGah
 ICAmXeMImI+QRzO59OTo4WHTRxgArfTxwokNbh+7tN/i8mO1L6xLhj2+Ny887pCa
 KRgLxg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm0gn4ft-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:23:59 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cd68b8579f2so1014297a12.3
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 23:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792995839; x=1793600639;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UOR+3mQqNWrrLiobLgmkq+PeJAutB1Cemy1/2B3AOYo=;
 b=dqLjEITAWxqSZGartjCH0pVoKYYpUckvL1WR/YJhHKU8z9VOAonXXtEhUdT73xmDrN
 F4oaWvdj6gd9WodeNKF9QlIOpy5Nz0F6TVi5RBFQIfp2fTQuOLcdqU3nLedyOzspaspi
 fDHBz2NRWLh9QEnCdQNlnT35fScszXWoJOPPedr3PVQ5y9ZOSrLakiD89eIgMBrgSqp9
 WtL8nF1w/gHw1ovdcpqS1g6CvQnWXZ77zdnoL0ejhVK+Kw/1VGHCI9RiPYrkNfLTtAPk
 c01xWqCAf/C6K3/cczA/UkpE4TEeZfUnXPGUdGrpENh5kHw9dfOS9T3Lh/fkc0Fva+JC
 /3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792995839; x=1793600639;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UOR+3mQqNWrrLiobLgmkq+PeJAutB1Cemy1/2B3AOYo=;
 b=oYBYK+tYLJmdDZwcdKF5lESabblDjL6aiXAb4D3Xh6UVPBx/TpAX2+leIUiZ4QyHvk
 ucL9zRa3nwQlcqUFvg8zv9kILTL21rOPZuwUdNRVwRC84FPnwaZyUjDGMUui0DmQoQCy
 dMdwSR4LJqNrqp7n6wWNhlhnI2kpUztijm2eTGGvoD5ccCGh9dOLVmYQ5TAElded98Ls
 QB5tLai6roSEKl7x10MaAC9oumWwTr++5VPSubALZir6EMKJFLIUt6pn/KV2OuoO2/LW
 sYG+DMW9+r6GOJ24QpMwXg5SFVaR6KkWWBvLSeV78tDQVs6nhiyVzs1i3n945C5ciGv7
 TkqA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwoiH9HLlfshFc+Yeg+vcfBBpSPMY+XkmGCeKvL9MYQpFUD755MZIFOH4uRsAK1I5ASM5bKJrOmvDA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKh+FSJnIXM9va7xaZVzeBAxCsg7L8PlTVop/9AXLVJS1vMQ7Ei
 zntH66mLbSwR9PEFKILJTJK/5PeW2jOOofl3mPfXt9/C1o/FtWYfxYsgjXlFokfmuw4ZKtWwQtv
 pGJyntCaLRF/dpbCDCXvoycjvyL2v+tdeQlpyWzx2i+NTesOo3jiznr+keLvGs7iD270V0Hc=
X-Gm-Gg: AYBFou0xe4pBHHiQzAlHe5qNEHEQgZDHkHEKUwklpyyMwPaThajfpdwCTs6X1HCEqsN
 WTyu1XaMIVQ3G8kz9dYWxtgcfw2v9LjuRxlADkGQ+TY0lyf/QNM2wRK5TtshQUcC/A79r5I/Ajw
 33npxN5yhIAJGwbTYtF5SglQsdclVkdpCeBtgw3FNEc4NvWZ9XYPu2EJklmy67EqQOwcEhJG5tT
 v9RJUTqnez23yH8nrlSPrqwvyFzzZ7KhEZEaJagnmVLNeGHAiR7/0FKHuQ9RmpEbIqjW9mIS5ZH
 gb7MfMXTJ0QGW1D/Zfn5V49vvf99hu5d1zad1a1u+1zOftZ8SoSnKYD+ceDIh/ZYWZrq5tnK6/U
 FtktHKjMt7kQPnRO8BmjWW8+kvM9ElS+1+g==
X-Received: by 2002:a17:903:3c6e:b0:2e9:6645:e9ab with SMTP id
 d9443c01a7336-2ea9c6c246amr54738275ad.16.1792995838588; 
 Sun, 25 Oct 2026 23:23:58 -0700 (PDT)
X-Received: by 2002:a17:903:3c6e:b0:2e9:6645:e9ab with SMTP id
 d9443c01a7336-2ea9c6c246amr54737865ad.16.1792995838107; 
 Sun, 25 Oct 2026 23:23:58 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 23:23:57 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:51:23 +0530
Subject: [PATCH v2 13/23] drm/msm/dcp: Route HFI display events
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-jshekhar-dcp-hlos-v2-13-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Mahadevan P <mahap@oss.qualcomm.com>
Cc: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
 virtualization@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=2412;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=BFTr4Q+ZfwwET6V0CyDqzPQcI8MwpqQ9e75s1Un7OM8=;
 b=SKN800pVbhcnvPWsUmrNznlIDbT64GT7gmpps6ZTh83CJvMF8drOdSRqgxsHIH2Rhkat9HE0L
 quOBQpd8NsHD9Z9IG6TzeX9xiSU8vrxzzp9OkSE6Nv19uQp+UAa/FHQ
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-ORIG-GUID: Stg0VSJkBBnqV3r-IrPjGqX_GlEKOsWj
X-Authority-Analysis: v=2.4 cv=UfTE26SN c=1 sm=1 tr=0 ts=6adef1ff cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=dkYgh42podB0RqWQ9ZQA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: Stg0VSJkBBnqV3r-IrPjGqX_GlEKOsWj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX4h5xUKuuAGFn
 srfj6KncpEALUZcyyLf6ouqFEGyMUTdQBLbuJvpTasCtFKhf51D1XyNZlvLvjl6R1/dmtT+a7MK
 Fxt/5psCbRLHuYU9ZIopW6k6qNoOX7Nsz7EuhxQV97og5317Iipxs2BpYZLTnm8IM8cvXays/1g
 aYr4bNRgB+4kyXb8TIwUDZwzBlIDyrxU7/DypWATANQFRt/QXxzUmdpKPs0XJykpTh0pBFg0aLN
 UJNN0rfVNhqphMskff4HPtbEeiVQWgJFZTzItlLnqg4fE4PgQ3HULvO2ItwmOXs276B4OkhxwFj
 ft59EisHndB3bf6t3QAeJCpi7jjnXJ6K1KjnhLVDkjhFPVDmNAUe7rmcTMYjKBPxM2+ZpEiuh7q
 Wuz+/lG5M59IywqKxZfIC1WHDS+NzR870eW9+pRvVG7uJqQ2RnlGEjuB2UdYPUKvZoblmY4Hzck
 vs9jUTv7kj51rWUNWMg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX6jqVezVtig3s
 Zt1FfKj8jFrlWYqAdZYZxo6teQBxjqLZg87OYLx4nUtTKEEiTsXGzyNEoawItdycVLHhh9b2kAH
 /CZCWx74kiWRmxmaJrmIJo6yNCVoEAg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260025
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

Route asynchronous display events from DCP firmware into the DRM CRTC
objects. Without this mapping, VSYNC and frame-scan completion cannot
drive DRM vblank and page-flip completion.

Match firmware display events to the corresponding CRTC session and
deliver VSYNC and frame-scan completion notifications through the
MSM DRM callbacks.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dcp/dcp_hfi_core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c b/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c
index 774a5afac0f0..e54ccfafdae0 100644
--- a/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c
+++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c
@@ -19,6 +19,7 @@
 #include "dcp_hfi.h"
 #include "dcp_hfi_priv.h"
 #include "dcp_drv.h"
+#include "dcp_crtc.h"
 #include "hfi/hfi_packet.h"
 #include "hfi/hfi_packer.h"
 #include "hfi/hfi_unpacker.h"
@@ -260,18 +261,35 @@ static void dcp_hfi_store_caps_payload(struct dcp_hfi *hfi,
 	dev_dbg(hfi->dev, "%s: stored %u bytes\n", name, n);
 }
 
+static void dcp_hfi_dispatch_frame_done(struct dcp_hfi *hfi,
+					const struct hfi_packet_info *pkt_info)
+{
+	const struct hfi_display_frame_event_data *frame = NULL;
+	u32 sequence_id = 0;
+
+	if (pkt_info->payload_ptr &&
+	    pkt_info->payload_size >= sizeof(*frame)) {
+		frame = pkt_info->payload_ptr;
+		sequence_id = frame->bufferflip_index;
+	}
+	dcp_crtc_hfi_frame_done_cb(hfi->drv, pkt_info->id & 0xFFFF,
+				   sequence_id);
+}
+
 /* Route asynchronous events and capability packets before flag handling. */
 static bool dcp_hfi_dispatch_event(struct dcp_hfi *hfi,
 				   const struct hfi_packet_info *pkt_info)
 {
 	switch (pkt_info->cmd) {
 	case HFI_COMMAND_DISPLAY_EVENT_VSYNC:
+		dcp_crtc_hfi_vblank_cb(hfi->drv, pkt_info->id & 0xFFFF);
 		return true;
 
 	case HFI_COMMAND_DISPLAY_EVENT_FRAME_SCAN_START:
 		return true;
 
 	case HFI_COMMAND_DISPLAY_EVENT_FRAME_SCAN_COMPLETE:
+		dcp_hfi_dispatch_frame_done(hfi, pkt_info);
 		return true;
 
 	case HFI_COMMAND_DISPLAY_EVENT_HPD_STATUS:
@@ -975,6 +993,9 @@ int dcp_hfi_init(struct dcp_drv *drv,
 	struct dcp_hfi *hfi;
 	int i, ret;
 
+	if (!dma_dev)
+		return -ENODEV;
+
 	hfi = devm_kzalloc(&vdev->dev, sizeof(*hfi), GFP_KERNEL);
 	if (!hfi)
 		return -ENOMEM;

-- 
2.43.0

