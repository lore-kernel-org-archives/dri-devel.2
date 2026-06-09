Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD57CD6E79
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 02:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB80B10E059;
	Tue,  9 Jun 2026 02:59:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dGE99MM/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PqsnaOw6";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ADFA10E059
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 02:59:53 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6590sAHK591928
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 02:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IJDGglN97rh
 Rw4+XmxNVKbWIstzQQy65lHqMCInbHtI=; b=dGE99MM/oChVybdXdmUi7Nz0qDk
 90aaTHO3oDtMpnhajzqDa5znAJXJBHqZKr0UdoSmeXJ0rQGzkaOJ5rC9kVJZfaEV
 xn8HY21OVj0Eeq12oKe+cgtSZOr3t/WoJZAr5bLekqMIJEo5yrwlI9h4fk3jBvOV
 B/GxHST5SJNu3tWY02gBB+6BLMu8ZVlUwFxRiXOnah776zhsQNxwwJMTe2tEiZwG
 Soz6y6xlr0cudwaFtT0pAYLy/BY8OD2q1TaqCmUur/QFfoEXK87cPGgxgTTjqxJB
 SV2AivpCZoqN6dIIQoEoCvjf4k+8tKZVto6CJQWlncUfV4hMmPhboNoNUUg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4entrkvc0y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 02:59:52 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c85c530ddebso2972537a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 19:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780973992; x=1781578792;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJDGglN97rhRw4+XmxNVKbWIstzQQy65lHqMCInbHtI=;
 b=PqsnaOw6moUNuyUkZKvCwwnUI67cAR1SisPsfraBTZWzr3/qF4VtGcBdysGpnBxe6x
 uhLe1X+tuliL5TU1MxNZ4YuDnwFJ0hw8HVCghw1Nv6bDcr6mH9/JgiGYUVSOuz/Z2ws6
 Z65X3F20Ktb+sKsNZhtzRWghfuPXrSTds5ysYuc4H3X72YzQ2E5EGyPRqioJIYHky6MN
 2WeArgE/2Rfs5E7Dq4/mKsI95toA7EKZiS7OMJmmLNen37SGsQxh7hD0IDZrhvW7X4h4
 eOZ5RrFRB6aJgoNXjnMd0EEDSbHuAkmFsRPswSYaNXHvYhw9lLWhInsl+0WfEYDAfIGJ
 9MVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780973992; x=1781578792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IJDGglN97rhRw4+XmxNVKbWIstzQQy65lHqMCInbHtI=;
 b=qrQibnewnWVRQkX0eap3YeCS1qBn/pB9b+MddTIVRAvkR3qljKZnkowzrXJ5awmzhm
 8Z6pp/YI4N4RkF3298tJEmEDacANTISZ8g39HkKdroreA7fJPDLNZHqVZ4+b17W7bbfN
 EW74lAKD3eTlomtCrHPDrwcr4SHHkry+ckAU9OG2w/CYU3HdNUNSRGigojv04qBSnFvJ
 g/+rHxA404kZ1b9hSmr98cYt8cjV3/Bd7v9xqJqsjez/o6IWV+RYtdGIIHxu2anHL8Xt
 1Mxr0RwQNjciADTQze5eFA4KZHOkV+C+almj51pbE4ToV2IIyostUK3OSOF0o050gMZN
 OLVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8qd9QYqETfXsfBldf7YxoQ7Jbi5i5FgZV9yD7loCPDIc6y0/cusa0GjWDPa7KinaJO2Bd6xLJcxlk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywc+R2r46EjK+S7UKi35BeH1ljAeC+zyll1mm4s4SJPm7SSe5xz
 S6er42P54CNcqXmHg+Y9ZaGCDTuCrF9/idePHgsFxv4XiTKTWKdWup8AnEHgE3e4LGG2XhSZISK
 3uIJSIi9tYgAiiM1nIDOq1pUoHrjKVLGR6C09Lj5f+k8G+D9kivv/QymXI/0O3J1OrNEmNmY=
X-Gm-Gg: Acq92OE9RpX5uwP2LJ4GT7xqRn9CkiCyh3Z6F/e5rN6LkFx/FIAoC5X6YI9d6xmBeOk
 D/S9QVgIa5W4n07xK07OXvuqMAHURhSv55p826RgFH9NmS5t9MJjwWDWjy0k3Z6O683Jvs/KHPu
 TWMBexJL0lIDLqEw6ru5AV0SFvOb0oQQrGiuxEhpbj6ndWjehhxwX1+0GpGlXIaERDsHpbmtDum
 JqVQwHaKFkMw5aNU+izcnTNb1ooYrLO+wYdtcqzMopYWR4Wq/I7gnj9ksBIaHui75SAI67PoujS
 yTgMMkxKRHAEthghacXBwtU43XlrarL8vPKp153cr5xO3jV0x/Dl5tmjSga1bH943fTDb0t2f0B
 +TnFHtVjCRFgzFVfnD/x+euPt5JosWq0fhx5PNZoMN1wJJfmDu2zQd0eT7FmvLenVJsHemRILw6
 aRtqHW8YCh9PBIDAd2yncKoiEVlmL5
X-Received: by 2002:a17:90b:1801:b0:36b:bbee:fb28 with SMTP id
 98e67ed59e1d1-370ee33d0bcmr19282625a91.2.1780973992240; 
 Mon, 08 Jun 2026 19:59:52 -0700 (PDT)
X-Received: by 2002:a17:90b:1801:b0:36b:bbee:fb28 with SMTP id
 98e67ed59e1d1-370ee33d0bcmr19282595a91.2.1780973991684; 
 Mon, 08 Jun 2026 19:59:51 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3712fcb2607sm8713835a91.0.2026.06.08.19.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 19:59:51 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abelvesa@kernel.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jianping Li <jianping.li@oss.qualcomm.com>
Subject: [PATCH v8 1/4] misc: fastrpc: Fix initial memory allocation for Audio
 PD memory pool
Date: Tue,  9 Jun 2026 10:59:35 +0800
Message-Id: <20260609025938.457-2-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609025938.457-1-jianping.li@oss.qualcomm.com>
References: <20260609025938.457-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 48icziWBa4qaxJTPJLuU6PRsfkWRJPpx
X-Authority-Analysis: v=2.4 cv=Z+3c2nRA c=1 sm=1 tr=0 ts=6a2781a8 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=bIEaOLAPTWlh-3IGMggA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 48icziWBa4qaxJTPJLuU6PRsfkWRJPpx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDAyNSBTYWx0ZWRfX0oCKV1n1WY2u
 Lc9gFeM1fl6Nk2vL+1E/nIES+8LEo4w1S9tbZMu9DvVIDew7AmPcjFxEMCrW1DNycLVl6OweH9D
 +KDHJwOGa8HZ9D3+cFA9MRmCtIE0WF7bZy+E+c2WYVWlR5Z/wOz8uRMLUiKIET166Rtyrc2tEhx
 FLf41qCQeIm5Ko334eK4FVMTfrjkitMTdKP4uBSmr2YGZIxlqKWuWT5rD6rs+KuhjkRlWvw9q0U
 ka1T2J3Ch8t2YvY+FBMkbxSKuQIY54MTlqNy8PV45imRGkKAGsENw+2CR27uON7FT/zRCfZOGzF
 UamG7wDaYJmf3yGr3qleDIbAASQurGl/P/JSV5HRNygDGdYRVXdBuY1J/gistX+oSJvFG5zEN6+
 TRxnnGXhJ0Pihv/MVfhSC9ifCX1ocYu0VaUGOaaXFjSAkLffKAPz2FLUjZBrKXyzZak/IZdh1S0
 on0wpsuOAkmh9iogrJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_06,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090025
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

From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

The initial buffer allocated for the Audio PD memory pool is never added
to the pool because pageslen is set to 0. As a result, the buffer is not
registered with Audio PD and is never used, causing a memory leak. Audio
PD immediately falls back to allocating memory from the remote heap since
the pool starts out empty.

Fix this by setting pageslen to 1 so that the initially allocated buffer
is correctly registered and becomes part of the Audio PD memory pool.

Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
Cc: stable@kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a9b2ae44c06f..96961217b856 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1370,7 +1370,9 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 		err = PTR_ERR(name);
 		goto err;
 	}
-
+	inbuf.client_id = fl->client_id;
+	inbuf.namelen = init.namelen;
+	inbuf.pageslen = 0;
 	if (!fl->cctx->remote_heap) {
 		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
 						&fl->cctx->remote_heap);
@@ -1393,12 +1395,10 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 				goto err_map;
 			}
 			scm_done = true;
+			inbuf.pageslen = 1;
 		}
 	}
 
-	inbuf.client_id = fl->client_id;
-	inbuf.namelen = init.namelen;
-	inbuf.pageslen = 0;
 	fl->pd = USER_PD;
 
 	args[0].ptr = (u64)(uintptr_t)&inbuf;
-- 
2.43.0

