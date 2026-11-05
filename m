Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60804606A329
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XbrF9JOh;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BVQSMqmj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C45B710E85D;
	Thu,  5 Nov 2026 19:23:23 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4739110E3B2
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 19:23:12 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5JLk2D2293987
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 19:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=9UxqS9kNYAc/XjDgiepIFU
 l21FdPci60CYUccT8jiLg=; b=XbrF9JOh10sKSRLtLlW4Ww6QhXyNK35O8JFfiY
 ScKh43+KfeFbZ3fHztuDMRLeGgfM5mDwdsIfE+did1zkiwr++zwL0Ly26KxIGYcY
 YvL+77lkM207S1yQVVwPQzqzvIBt7L5qWqksv4r8cG5sx9JIvRAjgrbrsIdRjuxP
 0vHho/GP0CL2D2Q1G6to2fBPcaWfib8QNez7VUvq2hpOQypxMjkeXe1eOeZa74DB
 H+kFA6SP57/FRUw2loGrDYgf9TJF6JLFOgDpThdvLVbD3NmnWfBNSw5JcBZlUjwK
 2OL3FGRcbXKMiSyDVuqaqxw4Pd7G559XMoho5zCY3rRFtDVg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hryw1807a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 19:23:10 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33713e5e6daso2608829eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 11:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793906590; x=1794511390;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9UxqS9kNYAc/XjDgiepIFUl21FdPci60CYUccT8jiLg=;
 b=BVQSMqmjxHNPuptd22iy2qf05+hFfhJuwzUNIMXI+3/N5fwAX0ulGgPAXMR2D1AgrO
 NE2bi/KZeYBJy1ixuQ4Q4qC/Tn8wlaS7uPnUnCfTWqUWR2hHZ9Q0Yqc1Meb9a+/jXEfE
 1OwU0iXdKvupuGg4G+xatthX6bywuBbCZdqeOYhwlOyS6GX/nMraSoTf44TTvIO8JNOY
 EZ567u9Am6w4E5XgZhMcITKjwnm1/6QLSaAvBGNU2o4EEfsS/3hN525XwD3WwbxUHEBi
 fDR4n78Cb5v0M1p3vtfm1gBkjeTm/93y/CplmzzhpJAt1gyehxJFkTPOE7qL5vj+KVM5
 va8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793906590; x=1794511390;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9UxqS9kNYAc/XjDgiepIFUl21FdPci60CYUccT8jiLg=;
 b=ofXQxbvIVJsk82AZo/079hiTvg8nbxtMpHi/ln5OBfUdg9pMd2uJvjtQenFxDEZuhn
 pYZRcxbIZuybFLW9Y4pZzrKdzL5mUdSw3rzgH7Fr7sz16RdIuN6brdfb74EosT/dsMc7
 mR9zZ87rsX/Q8dlIIYEQVUsPp5x1oQo/3hT3AaSDEpTN8Om4uFFHBvPPfJMFWuXZt91w
 EUJfQ9pYQamzLxRRvNjfqCxHpfhK9yqXJ8CTGAHecZeWH9L1dNmG6EHCR/rHoRE1NZuK
 P0LjwCYTf8cOChs7evEZsm3Y8d4qw8K4PYT6ZUItxzAslk7cgOjac1ONuw4I+B1/Fs5R
 AIJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYP6QA/sUJcBvg+0MhIF+//k1V9gAF87NumOHkApgX0PvmaGmkU4hgNkKSkSQKd4h/dku8W02WRWc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/tdqVBEpYUNaxtVpdEHfEZwM/b7ftlDCYZmamOuEialBDGNllQ
 wlvlGYmv89f4pmUvs5+IdtF0vnH9U4zq2xAAdj6zrbmW/VN7qWq4NErC1zbXeoRg8MXbibjhzEx
 xaqONNfrO4pZwDZ9YQKLAHoeI35f8vo8G+lMyzCj2OmOLX7Wfy9zWKaJvQwCmFtY3PZEv/8w=
X-Gm-Gg: AYBFou0+M0+XgKBRGtWp3qHHyZGsNsyf11RY+BCifLnM/SZ2oVG9UayN3ku6Hbv7H24
 S9kBmevLLvhE8WsnI/QsAXz4Zk6sJXuTfofp+qL/MyJDUP5zGYkyCLsluFpuk0Z7zOSTgjtwSPB
 D+7KY0t8CoGDvjKRbYBohb3UuHnYeCStmhQWVtgNwCEnBE7WzzkoHMeZf2YhGLMp6aYo3BZUIBQ
 PjNg7WM2tV7mcnp9UNIuoLW55UjONIENfoRHDIitmWHoFG8eq2x8T0oD9APiWXK3m18UTWLIQZa
 UET5HqD0VS25mNrMix8qMXZyQoi7HH19nFjxY/iO7ONoA9vaVqrtWzjVxpAetS2IrkZKSWHIT1Q
 eR2Y9nzOs4auWvlsxNNgHRJruPtetxS70K1Na3EFJ/LU54LncR4BTMqfEwGHtucY7GC6Rse9GI0
 box5y/qu2PGDlUI+Wh++voX3B+xxM=
X-Received: by 2002:a05:693c:2a0b:b0:36d:8798:fac8 with SMTP id
 5a478bee46e88-36f75b2bdb6mr100055eec.26.1793906589573; 
 Thu, 05 Nov 2026 11:23:09 -0800 (PST)
X-Received: by 2002:a05:693c:2a0b:b0:36d:8798:fac8 with SMTP id
 5a478bee46e88-36f75b2bdb6mr100022eec.26.1793906588818; 
 Thu, 05 Nov 2026 11:23:08 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36f722ea913sm234468eec.21.2026.11.05.11.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 11:23:08 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 11:23:04 -0800
Subject: [PATCH] drm/amd/display: use include guards instead of #pragma
 once in Core 2 headers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-amdgpu-local-fix-v1-1-4af7abf820d0@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJjX7GoC/yWMQQ6CMBBFr0Jm7SQtolSvYlxM2xHGQCGtEBLC3
 W11+V7+fzskjsIJ7tUOkVdJMoUM+lSB6yl0jOIzQ63qq9bqgjT6bl5wmBwN+JINb8qotjHn1jc
 G8m2OnPUv+Xj+OS32ze5TOmVhKTHaSMH1RY0kAY7jC6Oepf6LAAAA
X-Change-ID: 20261105-amdgpu-local-fix-908074837d48
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Jun Lei <jun.lei@amd.com>,
 "Cheng, Tony" <Tony.Cheng@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Proofpoint-ORIG-GUID: hCyZ9gNE3qCE4k_mEyFdSkfR7qp0n647
X-Proofpoint-GUID: hCyZ9gNE3qCE4k_mEyFdSkfR7qp0n647
X-Authority-Analysis: v=2.4 cv=RdYFmFtv c=1 sm=1 tr=0 ts=6aecd79e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=xLHI1DaXmMnL26mjVwAA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3NyBTYWx0ZWRfX7/tQtgxCxZnV
 wrL6WjCaDgJHB84jq/bZW4D3oceAHs7b/uwjDj8lB3rEs4dpSDID9MAMMhVwdNy37z7ZxW8CxQN
 UVWqHg/uUrnmGul9XQ3oe/n+ykVir4ZnHRDTN0ZMOZucdZSXET5s9IwTg05fDBPndebqs3LlyjU
 j2+vX1Eci3xXmPIKxz9Ba2BDaga4iwuMj5kLiAgmfb97tGPRiq4yi8ZU2q3AtxIdxPO1EukVcw0
 6uC2gSg9i7n7ywFTLEkwXF6Fcyqq+YjitSyIocNucixHiBQbFky+DOqlgBiT5kQpyrWRDRI9VqX
 tYYdnW+j/Fm8HhmLwY1rHeBw6I8XVIH7WcKBWz5fjUtiSMCdhwRZBP15TQJWdR6/dV98imOfG35
 E0j5TcZ668ngsTIh1vQoiHngNjYy9qUaLnBI3ZGB3qlNl+OB+OR4/Gyw5qwPf5wBF/1Ewza+mmh
 Efk9vUKk251Kq/FGLnA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3NyBTYWx0ZWRfX9BkKsSNKSvXD
 /mWLlhwMyza1szh9vQUPugS5t5UxdyU8HGpyYO4SVHGsIn3s1Gyi2C5wOMmc6483RS8qKkTNr5d
 6galUVeXvQiu6Hx3O89gW6Tu0jWMSl4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1011
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050077
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 9d1a737c3c82 ("drm/amd/display: Keep public DC lifecycle APIs
stable beside Core 2") added four headers that use #pragma once, the
only headers in drivers/gpu/drm/amd/display/ to do so; every other
header in the subsystem uses #ifndef include guards.

dc_core_interface.h is included more than once within a single
translation unit (via dc.h and again via api_shim.h / dc_core2.h). In
the amdgpu build all display include paths are spelled with a
"-I.../amdgpu/../display/..." prefix, so the header is reached through
two paths that differ only by a ".." component.

gcc canonicalizes the ".." and deduplicates the header by its real
path, so the normal CC build is fine. sparse (make C=1/C=2) does not
canonicalize ".." for #pragma once, treats the two spellings as
different files and processes the header twice, which breaks the build:

  dc_core_interface.h:14: error: redefinition of \
      unsigned int enum dc2_selection

This fails the CHECK pass for api_shim.c, dc_core2.c and core/dc.c.

Convert the four new headers to standard #ifndef include guards, which
sparse honors regardless of how the path is spelled, matching the rest
of the subsystem. No functional change for gcc builds.

Fixes: 9d1a737c3c82 ("drm/amd/display: Keep public DC lifecycle APIs stable beside Core 2")
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
Issue debugged and patch generated using Claude Code Opus 4.8.
I have reviewed the patch and have verified a clean W=1 C=1 build.
---
 drivers/gpu/drm/amd/display/dc/core2/dc_core2.h           | 5 ++++-
 drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.h      | 5 ++++-
 drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h | 5 ++++-
 drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h    | 5 ++++-
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.h b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.h
index a761e85a9973..867fe9023fc7 100644
--- a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.h
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.h
@@ -3,7 +3,8 @@
  * Copyright 2026 Advanced Micro Devices, Inc.
  */
 
-#pragma once
+#ifndef DC_CORE2_H_
+#define DC_CORE2_H_
 
 #include "inc/dc_core_interface.h"
 
@@ -17,3 +18,5 @@ struct dc_core2 {
 const struct dc2_funcs *core2_funcs(void);
 void core2_construct(struct dc *dc);
 void core2_destruct(struct dc *dc);
+
+#endif /* DC_CORE2_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.h b/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.h
index a4fa0365cd4f..b081801f664e 100644
--- a/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.h
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.h
@@ -3,8 +3,11 @@
  * Copyright 2026 Advanced Micro Devices, Inc.
  */
 
-#pragma once
+#ifndef DC_CORE2_INIT_H_
+#define DC_CORE2_INIT_H_
 
 struct dc;
 
 void core2_hardware_init(struct dc *dc);
+
+#endif /* DC_CORE2_INIT_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h b/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h
index fee03a5dd596..00cf48b14f53 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h
@@ -3,7 +3,8 @@
  * Copyright 2026 Advanced Micro Devices, Inc.
  */
 
-#pragma once
+#ifndef DC_API_DISPATCH_API_SHIM_H_
+#define DC_API_DISPATCH_API_SHIM_H_
 
 #include "dc.h"
 #include "inc/dc_core_interface.h"
@@ -17,3 +18,5 @@ struct dc2 {
 #define TO_DC2(ptr) ((struct dc2 *)(ptr))
 
 void api_shim_construct(struct dc *dc, const struct dc_init_data *init_params);
+
+#endif /* DC_API_DISPATCH_API_SHIM_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h b/drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h
index 35a6218c1285..264bd8bf3bc0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h
@@ -3,7 +3,8 @@
  * Copyright 2026 Advanced Micro Devices, Inc.
  */
 
-#pragma once
+#ifndef DC_CORE_INTERFACE_H_
+#define DC_CORE_INTERFACE_H_
 
 struct dc;
 
@@ -29,3 +30,5 @@ struct dc2_funcs {
 void legacy_hardware_init(struct dc *dc);
 void legacy_hardware_release(struct dc *dc);
 const struct dc2_funcs *dc2_legacy_funcs(void);
+
+#endif /* DC_CORE_INTERFACE_H_ */

---
base-commit: d7e11a5269dc892cbee8a01dccbdb20bb4f653da
change-id: 20261105-amdgpu-local-fix-908074837d48

