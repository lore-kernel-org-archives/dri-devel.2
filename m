Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858AF606A686
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o4VgiSc+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cz27bAgq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB85810FA28;
	Thu, 26 Nov 2026 06:31:22 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1731E10FA18
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:31:12 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ36XLX1647654
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C5GGOc8oVOwQL1zracf4Aiccz2TVlZ/+5Eg07kzdJm8=; b=o4VgiSc+IjlJBprL
 P1sydzFuapof3HtAGtCTN12IU/F8MpSEk/tEuOel+FQ1pyS7Qs9I0WFKkTTZYW4g
 eb3q40OKbXW+Wa/scO1nAUfQZZOJIIFLuVjWyl6dQGcPG9S3GZ7NYsuAzm2lRx/O
 rUT2vtAISAOGdcX5b+VWVRosf64Vd8gx7qU6+1dVjF031GO2JQHka98WedSzhtac
 QalGctf2NGvDpkIe4eFmLXaKYvfPdOjhzuwWvN5pjL6qkJkzLOD0pTZjdW4nBGvl
 McE60gJxTkCqREBrnhYxtmy+GxPBMUxECOCRbFSlDCiFGjCO7uK5PZ+dY9fYf3P5
 /EttZw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j61ahu291-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:31:11 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2f04580de55so35877925ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795674671; x=1796279471;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C5GGOc8oVOwQL1zracf4Aiccz2TVlZ/+5Eg07kzdJm8=;
 b=cz27bAgqUwGDN+9GSDqWuUItrdRODQoObn7i85nHcn4kHiPwdfnnrCbSMg+dWu4+sN
 eJ4oVD+wy4iC4SulVBPssIO6u5TYOqWAM33MfWH7GDmVO7RHZBVlv4pUkUlojKqQYbFD
 tO1KoYQlA6q3OAfBE7636RoNBPNlQ+KWvTszUqp+BxR+GOPnOZaL6jjTQOBCWMKRyqte
 O0CuxD/XJt/f1e1YvYoXunjb/WzTYXeNfiih+fWuYMRMES74fqLdGW7kkLkkDiPbJYcc
 zguy471W3sKL+LFNDxO7pRoCneMARiksSiui9wjh/OBiUUZEAic454foOOXkhN40Kt7B
 9Org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674671; x=1796279471;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C5GGOc8oVOwQL1zracf4Aiccz2TVlZ/+5Eg07kzdJm8=;
 b=q6RwslPG9tPXDGU0nxUPIDV/+4QJgt3y+DPLEMB+zFDTmdn1bTYFkUYcIkLDRWtVAg
 XTdEgmfqTYxXUqrQUEwwD1esSC3NTO7e7pzuIrjulVWIrt4z2fkpXAkeO3wfX7vz4hQf
 JJuDXH/9QB7rIB/xAtpsatTlPYnNJPmLySA6CP5SHzC9uPfr5Y3Y4sXu1bw6F93yQTKe
 TPp38cGq3vq1yt25ZpaBuH+XNCc3CpDRbDU1amLu4bewzaBD0qYH1fHYYkECVAU/FpqS
 y1ATKpipJguAXwwXX6npBXIhdXVbYCSuVMrkoYcKOzMutFxGDdkM1RbU5ziRWy11pXfI
 n8hQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHvo3rOvN/fag22BKXE1/dqwh0qdIN1BeiIorwmgUSqwpbQn5o2e4JC60BJAhez3UDnc1hcA1G+Ucw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8+7kF3uP1IA6p+6TouZO64qackX/aCpmGaQB/2470AD1yr4jjj
 UPFdekPUsD4s1zGIqFCiGM9b7pUle6UzrZgNopRsKPrf99cIMqvsukYTCgjMcsH2OM+JUnhvtNZ
 LJoJPMhINF+v0BQlYRk6ikZsR9bpOYi1EtSYnbZIR8FkiBOZcAsVV5a0Cb1AbuYrbWbGJbxo=
X-Gm-Gg: AZFdTZfUXcSZs+2dZxBXz15lPXtSVxdNHjBB9XUXDnMWMLr+x6vwkLXasaqZPXwnpWh
 tsY9cXtZTHlMUgIR13fcwT3McAoIfFDsQw140ltzCYJUlPizDU84+IBM8ue16arlyWEa7Ar5ahB
 pIVOSoG8wbo/PCuPwHC9cIvPbsK4Urltjvwlyn9Vx9uebalUFD24666Eje7r/HmMFxReWbMjNmK
 ZiX07PUMw2sDLHHOmz2sN+lKoR3jEuuN8EFhJtXEmHX2OXRG2BYvSXsPknftYeQzXFIcajw5jqd
 Qw3vXWtbJt5Wv2j/JqCGUT93UWZB3d3AJ+6l0kUbaDiZhw3snT9o+PguVvvqzLhg043oWlp5Sgr
 skFmtDbA12Rs8K5luF7UqAexPW9gIpv/6hF+Z0iUOHWalJ5VIzde2jDF8YeaIbk7yIiHHWiIzYw
 rpxqGkw49s
X-Received: by 2002:a17:902:d2cf:b0:2dd:b6e7:ac1b with SMTP id
 d9443c01a7336-2f03ef3d3b0mr219979575ad.2.1795674670386; 
 Wed, 25 Nov 2026 22:31:10 -0800 (PST)
X-Received: by 2002:a17:902:d2cf:b0:2dd:b6e7:ac1b with SMTP id
 d9443c01a7336-2f03ef3d3b0mr219979215ad.2.1795674669896; 
 Wed, 25 Nov 2026 22:31:09 -0800 (PST)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f147a9esm97159715ad.72.2026.11.25.22.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:31:09 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 11:59:20 +0530
Subject: [PATCH v3 12/21] drm/msm/dcp: Route HFI display events
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-jshekhar-v3-dcp-v3-12-f1e9d7505039@oss.qualcomm.com>
References: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
In-Reply-To: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Mahadevan P <mahap@oss.qualcomm.com>
Cc: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795674555; l=2910;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=VWK4/UwyAvpFlPWiL66iknJDfq5LuqTWaIlitzv+KBg=;
 b=GxHdeYgBOWvxunhh4p7VwZl0lWR2ttSQn8vZyq1yzTIeaSYkODpAOAb/+gXaFjNy8v+Q30EUB
 /Zmw4bxHQArBfPx9XKKJNFWtDQSrtguJh8D4/Bx+2dIwA3sVIJb3w7/
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-GUID: ql5ZbRas8lzBWlQyk3Wjdd8qTBi4w00T
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX6Nmy2mhDiVdC
 61ZsPqLUo5ctD/PauMtPwNeRefi/bL0GcJsRLUr5uVRPIt7nGg749W1dd2loyNX38Ah4MSG5e19
 2zWM00mZJIcyoI3NP0HYNtL9n4sjM7U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX6gLKzEi8IHeV
 bhKOcJObNylRfF/Eoc1HzY2DSb9gqDtopwkiSEvXY0C1Je4+ALyZNgIn7bq21GofOwycOIMOFlX
 aQD7PDSWm7rqvlxRhLy/Xj2oNwZO3GkeggpaK0oHFg6mEPr8e/btvafQXFGJsZOA5FjEh0C0IsU
 n6O8Ybc/0IfPwZty6OAt55rT0lWQ8oU1+CNbSsjIm2gjHM/+u70Hy3GyB7219t0SQ7qMuL+tusb
 0VfO0fqKM8jvwiB2l/wn77+WMhmcPHE8xR7sOB1wxQvP2u/Rn5bD0RJRRj5KX5c4db82fCSaw/l
 3f8sOL+lc/LMh20q8mBVKCHJ2RA7DaGUWeLT4Y/x8JE0Zvhl06kytvRcZYiLFoM75n0HYBaBJ7w
 RQbuUArH1Q/MaWY+dE625KtF0GysrBdU6H4acuFLj1rtYapYNPUNaR37dncG+We2nH5sXO19SA5
 i/rjDmegKz54d7j74Fg==
X-Proofpoint-ORIG-GUID: ql5ZbRas8lzBWlQyk3Wjdd8qTBi4w00T
X-Authority-Analysis: v=2.4 cv=BbxNQbt2 c=1 sm=1 tr=0 ts=6b07d22f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Qn8EL2Lg5JFZapOYTycA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260024
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
 drivers/gpu/drm/msm/dcp/dcp_hfi_core.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c b/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c
index 1a1addd33877..3d0e15cae038 100644
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
@@ -260,12 +261,41 @@ static void dcp_hfi_store_caps_payload(struct dcp_hfi *hfi,
 	dev_dbg(hfi->dev, "%s: stored %u bytes\n", name, n);
 }
 
+static void dcp_hfi_dispatch_frame_done(struct dcp_hfi *hfi,
+					const struct hfi_packet_info *pkt_info)
+{
+	const struct hfi_display_frame_event_data *frame = NULL;
+	u32 sequence_id = 0;
+	u64 timestamp_ns = 0;
+
+	if (pkt_info->payload_ptr &&
+	    pkt_info->payload_size >= sizeof(*frame)) {
+		frame = pkt_info->payload_ptr;
+		sequence_id = frame->bufferflip_index;
+		timestamp_ns = ((u64)frame->timestamp_hi << 32) |
+			       frame->timestamp_lo;
+	}
+	dcp_crtc_hfi_frame_done_cb(hfi->drv, pkt_info->id & 0xFFFF,
+				   sequence_id, timestamp_ns);
+}
+
 /* Route asynchronous events and capability packets before flag handling. */
 static bool dcp_hfi_dispatch_event(struct dcp_hfi *hfi,
 				   const struct hfi_packet_info *pkt_info)
 {
 	switch (pkt_info->cmd) {
 	case HFI_COMMAND_DISPLAY_EVENT_VSYNC: {
+		const struct hfi_display_vsync_data *vsync = NULL;
+		u64 timestamp_ns = 0;
+
+		if (pkt_info->payload_ptr &&
+		    pkt_info->payload_size >= sizeof(*vsync)) {
+			vsync = pkt_info->payload_ptr;
+			timestamp_ns = ((u64)vsync->timestamp_hi << 32) |
+				       vsync->timestamp_lo;
+		}
+		dcp_crtc_hfi_vblank_cb(hfi->drv, pkt_info->id & 0xFFFF,
+				       timestamp_ns);
 		return true;
 	}
 
@@ -273,6 +303,7 @@ static bool dcp_hfi_dispatch_event(struct dcp_hfi *hfi,
 		return true;
 
 	case HFI_COMMAND_DISPLAY_EVENT_FRAME_SCAN_COMPLETE:
+		dcp_hfi_dispatch_frame_done(hfi, pkt_info);
 		return true;
 
 	case HFI_COMMAND_DISPLAY_EVENT_HPD_STATUS:
@@ -950,6 +981,9 @@ int dcp_hfi_init(struct dcp_drv *drv,
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

