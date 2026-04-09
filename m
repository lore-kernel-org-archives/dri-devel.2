Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E046E98FC2
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 06:26:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B44E410E71E;
	Thu,  9 Apr 2026 06:26:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BSVzLYry";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SXZX0p8G";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD14610E71E
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 06:26:31 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638NxQWv1072645
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 06:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wFzA2omutyD
 gArQT4+qbnS5naimicpEKr+NS8iMhMfo=; b=BSVzLYryvsrTo/GxIOrH3jOLgjs
 NNZ9jVNo2pl3yNpZMsIEYFt4AsxJ6l2fqN7V6duPE6gnDvLK8mf8xYgwkOldcW7L
 NGVabh5IOKlcG1SRwrIetZojLldQePi5+XyPF/hXOjGHFmCt5xm4e+U1lbZlaRpe
 YR7+ko+p9IIptQeQhfawLcWah2wxOjwx/4Xi3lWyeFCS2iGM/G3xooIRTXX4jea/
 yuQzbmc+skof3xAIE+hgxHsXGqQkZRcYZFfy9TulErtorXzerIZKTl9HA81APUPB
 aREOUhewgrLlADmsEId0KmZixsaeaDmSBj3k6PIj1GyzYoPDLTOQ2uraC/g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddtb3apgu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 06:26:30 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b2523e0299so13486865ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 23:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775715990; x=1776320790;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wFzA2omutyDgArQT4+qbnS5naimicpEKr+NS8iMhMfo=;
 b=SXZX0p8GHVRgutGODGuVg1ZnQp17/VUU34G5H3BWw3JZmHeMDWe2JtySSGXtdWdNRC
 KlVPCt5AP1RRg7RVaEfc1rp9RB1LrNs+fPzrK4hzHxgKWxLNyHoHASH/uBmP2gOC9fYl
 WtnuYw37CKyv1dAuu6rkCL1nPtmL4XzJre9hTAEDzt9nLhHq9hM7CJJkGTd/TjOt4XFY
 OHshVnv7Uujj48yGJPXEqCPQghjsfoCyIfostgh9k9vXR4n6rY8s8nXeEYbzmYbz996q
 MXkxI9M0Q4xLFO7S6pL+DAjzqFDmnC9bqhMSVaX9ToVmn8U+EBNx8+Zqj3F9wiBHirzx
 M1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775715990; x=1776320790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wFzA2omutyDgArQT4+qbnS5naimicpEKr+NS8iMhMfo=;
 b=lwwhi+BJyqA2P8rVdsh2lRoGAeDaRrmSKqCOxG48ykSCqn7P2jDpSRIlwOqF59tlyZ
 trFDLFa+VEqofAVPZXLiTaDNRLdLf4yXMdfSPJf0cH7FarbVB91Az7tPo+9eE8Zbuhfj
 RzRV1BtfGfRVA5moYFv+J7MNgi0VZ5W+qKYfGMQVQyZ5Qhc4MvDZpFuasoc/PQF1TgNz
 PWFDd1V53QAnPUJCHkb53EfLDqWeBQN5olEGQbNYGHqT4+npjbTcCjrXavvEweNymyTf
 0I0clojeGYXpZ/xj+atcH7DXAWTOdb9/JNIclxkRk2alE9ii0saFPJztwI5PqfaTSCh6
 DVug==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9373GwPnUqQca5334g5BUT2UVPSAgLtAuAZvO5kWH1e1vQzLe7PwiXGQqUjl8KhIG7y9ziPZJKPU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1J2nS9ANfwaPJicyKCOsn4d78j2K+qfJxFcRzdMxoOcCWyM7f
 0ZlDUOIUyHfeX7/Zdr23gg3zvHFAHOgosaKOgUCLSLtS1/CUeFMvzTEaVVgTOkDKrovbNZD4nbK
 9TVs6lSrjUqnEoLSHN+/U3TZZPKF1zRTgzMGaK/lP9i1+WVpbm4819u0oK5fxxTCKQBVlPsE=
X-Gm-Gg: AeBDievJQ4nLDoihxKy+P7e5Mgw2Gs+CXDuEKJ3Tlp6LOG0hEFugWbqcH9oKgIokFlf
 bnDstqgWcoQHJlloQke3fUZy0wy1UCo0+3xBT2KKcqm0jivXnMKB6/mTjIDPIenzyJ6BunI4IPb
 SNMbvXDcyHFnB+MA+md4oF2fX8Gtzm+xwkcnplETxtuvOESHPx7BUYVBapTGOxLTYR7c1eZRWGv
 lulq08jvWPgKWseQ3uzJYNzHdlsv+n1OM3HmjL4q0apK6JAn3I50pSXo5K45YpuaxOTiVC6GoI6
 w/kXROtw2lhGWbN9gFTdYgNO2Jg/O4WEtMfFHYNJMfDw6yEur1drhFoTkcTz2/9JkMhImng77D7
 ALCOqsETp9QcU3lSerTZSkOMB1tgIVhiDhBQFZIWH/bPCzSzo2S1+7DMtCis7OJ8qmxtrlkyVo7
 7jbGpvOuWlTjblFCyuhg==
X-Received: by 2002:a17:903:1a90:b0:2ae:8272:deb0 with SMTP id
 d9443c01a7336-2b2c726c892mr25970565ad.15.1775715989734; 
 Wed, 08 Apr 2026 23:26:29 -0700 (PDT)
X-Received: by 2002:a17:903:1a90:b0:2ae:8272:deb0 with SMTP id
 d9443c01a7336-2b2c726c892mr25970285ad.15.1775715989234; 
 Wed, 08 Apr 2026 23:26:29 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749cbd4dsm220786795ad.76.2026.04.08.23.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 23:26:28 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abelvesa@kernel.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, ekansh.gupta@oss.qualcomm.com,
 quic_chennak@quicinc.com, stable@kernel.org,
 Jianping Li <jianping.li@oss.qualcomm.com>
Subject: [PATCH v4 1/4] misc: fastrpc: Fix initial memory allocation for Audio
 PD memory pool
Date: Thu,  9 Apr 2026 14:26:14 +0800
Message-Id: <20260409062617.1182-2-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260409062617.1182-1-jianping.li@oss.qualcomm.com>
References: <20260409062617.1182-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA1NSBTYWx0ZWRfX4KDmbyDWss7q
 qx0O4M5Z5sLz3YD3EdeOmbHbh7LMIWHJ8/7oWsTUZZ036JVf8d4lkmkx1dStJZpajEzE6dc3Bzt
 qmUIlGWS3NXOuMA6kM/6G5rZ5JNX6suhOEWrCFrNCz+KUyQQlyYYZjZRD6qGQgve9qX/NWQtsrX
 C80MwwRZspb5caiSR2ggBUNHWge81I+hnrc1q3XWnfOO/9eVF1O0OQjV7NxFvOd2uxRpORhQsGl
 Kz6axO82KipiMZTLMpdzm+cSZwDyr++Mi6ohLRnWnf1MpWKLL9WDcSGZ5vCIidYs0BeLCd71g/+
 IFp19QMxQUBGBdE8w0aMmXw523QItYS7vC8Ayhi+GNDxoMuvWD625F2lra2Xz8k3fi+wwXqS5Bd
 Nzr2vVe844p+mTOlgynoUS6Kbl8NR61yUizRBPEIga+4h6oez/RWM18c8DgDluuXDOQoQAeggvq
 Dfz6eLlIOK7gXDvmGvA==
X-Authority-Analysis: v=2.4 cv=eKIjSnp1 c=1 sm=1 tr=0 ts=69d74696 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=Op9FgWJ_R3wbKKMAuNAA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: ZxCpCAzBh9hJr7FLjUNTz61xmTunRNG8
X-Proofpoint-ORIG-GUID: ZxCpCAzBh9hJr7FLjUNTz61xmTunRNG8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_01,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090055
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
Co-developed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 47356a5d5804..b87a5f97c96f 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1324,7 +1324,9 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
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
@@ -1347,12 +1349,10 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
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

