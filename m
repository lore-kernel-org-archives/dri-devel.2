Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DEACC6B03
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 05:49:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D707410F08B;
	Thu,  2 Apr 2026 05:49:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wa2GWInY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZqeqP0T4";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65EE310F08B
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 05:49:44 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631M4M073044352
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Apr 2026 05:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=c9KwVpO67WV
 x6EkOZYSJykEVM2NVlk46JFPzeGImNfQ=; b=Wa2GWInYmj6Sq/K7Q2dnbkVFAeS
 jztO22SyUfCCAWXoo7dmciJnXxq1/HGkfv81uU2bQDTZPc5sNeXgWZDLf/Wymfeo
 6Xxgs3OONaYqKVVkqdQdc8/07Vu9hOSZdOEzVVibwCNpTbPk60Neobg5Hf2m9TbZ
 lD98koylv4eGOC56KBjIf22bH3XrPjWUak2V1W/QSHZ+UeGDLeW6ab1w6M7N4HBN
 yxVXtn6CB8qNc94SuQ2RBvWTmx7ZMhjcOdy/RfhSoSpn6sTxcbNXgI9T7y6xeSeL
 Mqvoya5DRN6IZxUHi8GwBvH6tu7PY5KAnO6qIrhWZ1gDywHgM055HikSXfg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9483u6cn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 05:49:43 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82cdaf0f934so808916b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 22:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775108983; x=1775713783;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9KwVpO67WVx6EkOZYSJykEVM2NVlk46JFPzeGImNfQ=;
 b=ZqeqP0T48Pq6XqFQHoCEvZS3IZPNWyvSu2EpI9qTGO5hXy5HpkO3gI7wGgtx6TWWD2
 eC6yHprmw46Uo6qSE63BZbMCnVWNOCfRjxm/3hbTns/QmAd9Y9lbJDI+3a9LTgBa+YLo
 mvEXvczQnguJBsIcJQLxsSQ04W6hWJHgymE31Dh3dysdJzh1HvJN7JNG1jrmxL8hPYeA
 bgjfPnjmv3IJAuBd+E6t9Y0a26ddyqiTBzgFJ3/0/d8BG2nSwDDhpNi9HnGIb5T5sjcl
 PbSMq2asixVuNoPlcU/vqiDreQmDPuqj2ReCuT4VjPI4ZBfXMuwDHQBqdRI4MJG57cPu
 7zvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775108983; x=1775713783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c9KwVpO67WVx6EkOZYSJykEVM2NVlk46JFPzeGImNfQ=;
 b=o1mvegpqBUICxL9tBFbQ8CJLwhTLZcgRcXHwLHtjzTiXCfnq0TTeUA75hGvrgkLiT0
 PvjkSdppYieJWEI6tXIKr8eZFOitqUeqmkxVMU8NAZUQHJUPdy7G0E2qKxsAzkxgt9IN
 OFqO76LxffjchjmklggF6lf6OM3ViBEfJ9zacNduLNeqGRr8JOc5ky+Ksu8YRpEOWH+Y
 XKQgG+C9XrRE90UFIek2jMma0CJGFmevKQR4YbyZCnnGmpfwN7v32Vv0jsdSYgQkCfvi
 V7FiAZ6Cl26XdbjXbFNQd9aWoPzDpAsaJjzqn7xaIUCc3sWeW00sOox+2u6RdDGr9t0O
 rd9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpzp6F9MgBqEGobxkWdsJP73LeVgvZiiAyb46SShTnLZN0OkFsr4P0FLiGT9GOy2XdGuyktJzm5MI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxnbPcOocKbTzaeBcUsZhZOtatUj+CvOZZAWYzn/iasdyaqUuPT
 g4wdQfeQulYPRJr0X0tJsGMuJ0E/l9kFA1wxh6WM8FMhh/57ZrVvnxt2XPSYa6VdMJENhHF3g/E
 /xwvNacS3p35/Hs6WfOvdlfXgSmxqNfaHTJsI/eKXd26SpCZQKWHB8Vx10adLsjl2oxKxc4k=
X-Gm-Gg: ATEYQzxFmDhN1utgiE4Zv18Nou+l3OuDk0zUNEWpo8x6AIMrdobVe79bRt9anMQZmY7
 XIsklp0W0BzrcNly+QOckGvzZg2wO8o365/+xUWvjY2xjvK8ilL8wMUB4jgnK7Gw/mt63BYLTZt
 0pFpnQmO/o6SFInYdhe8iKgd3IBiJVHjmCqkW4V6hNRQZQUxJmEl5n0ekJ/aZFu2UUWOc9PxCAX
 VLSPkaeVc3S+cnmHB3hAgZdxDrqSNoa2bN8p0eaYpW/5MXkNlGa6W2tqEmN7bK7ZOzaCvblzYfC
 /+8ImfL4h6zgL93ztxPlPy8mgXQjyAlk4a4iWx03Z1Exun+U0JFMPDIPZrZ1azmA/cHrm1VoVYS
 HZhLO4iDzH5SNHF7WE2PcDG21loJFaJ6PM7Y8z+XYKrMvPjt/J1IIUQ==
X-Received: by 2002:a05:6a00:a111:b0:82a:1044:3563 with SMTP id
 d2e1a72fcca58-82cfb886170mr2551874b3a.23.1775108983191; 
 Wed, 01 Apr 2026 22:49:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:a111:b0:82a:1044:3563 with SMTP id
 d2e1a72fcca58-82cfb886170mr2551846b3a.23.1775108982724; 
 Wed, 01 Apr 2026 22:49:42 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b5fb22sm2167747b3a.26.2026.04.01.22.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 22:49:42 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com, andersson@kernel.org,
 konrad.dybcio@oss.qualcomm.com
Subject: [PATCH v7 3/4] misc: fastrpc: Expand context ID mask for DSP polling
 mode support
Date: Thu,  2 Apr 2026 11:19:22 +0530
Message-Id: <20260402054923.3061925-4-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402054923.3061925-1-ekansh.gupta@oss.qualcomm.com>
References: <20260402054923.3061925-1-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RYydyltv c=1 sm=1 tr=0 ts=69ce0377 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=JTa3dIKMUYn8LlmgGFYA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA0OCBTYWx0ZWRfX5iUIuGoQh1NG
 PW7UZMtHFuxePetzy6qT1EVY9LnSXUKqqys26FgtPmvkdZ+Qa43D45BaZ4Pa5/ojbRaoBOkftmK
 5j7V/xcRQS1W7XzyPqjvu4y23g7Ulm7bXHju2wTVbFpa3eWKkzcKTC7ESJs2DBF02uFjyhk6Qjz
 rBICRI01iRmrpGCYKZzj4vqB4YEErQ1a48NEzLlra8OUlZjTE85QcpSp2QyXhSmr8vGPRyGyRTA
 BsDy+I6DmngyjvCeYQz5Oqh2wfwEjnZP8fptl3t3yk+WS6+hERgC6bPOa5JlwyhInUsucJ9P19P
 kTOchfTzqG+FMg+7yY2dTRLOiaB1P41ihFQCnKnsc0ZiZOgLYOk8EhZN9fgX4rDqTTqMZrWPRWC
 goWIQfeExsUHmUXHMhIYsVxIHNhF9l5ftUgxf2bsD2YlMysSWZk2951WjmYOCij4/2w8iKhYjdG
 v/zNA9GUAShOa+ZL3qg==
X-Proofpoint-ORIG-GUID: -WnMforTpDMYY17e_zmrBi7KnSoNqcX0
X-Proofpoint-GUID: -WnMforTpDMYY17e_zmrBi7KnSoNqcX0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020048
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

Current FastRPC context uses a 12-bit mask:
  [ID(8 bits)][PD type(4 bits)] = GENMASK(11, 4)

This works for normal calls but fails for DSP polling mode.
Polling mode expects a 16-bit layout:
  [15:8] = context ID (8 bits)
  [7:5]  = reserved
  [4]    = async mode bit
  [3:0]  = PD type (4 bits)

If async bit (bit 4) is set, DSP disables polling. With current
mask, odd IDs can set this bit, causing DSP to skip poll updates.

Update FASTRPC_CTXID_MASK to GENMASK(15, 8) so IDs occupy upper
byte and lower byte is left for DSP flags and PD type.

Reserved bits remain unused. This change is compatible with
polling mode and does not break non-polling behavior.

Bit layout:
  [15:8] = CCCCCCCC (context ID)
  [7:5]  = xxx (reserved)
  [4]    = A (async mode)
  [3:0]  = PPPP (PD type)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index ce4874b9480e..4363e0cc296b 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -38,7 +38,7 @@
 #define FASTRPC_CTX_MAX (256)
 #define FASTRPC_INIT_HANDLE	1
 #define FASTRPC_DSP_UTILITIES_HANDLE	2
-#define FASTRPC_CTXID_MASK GENMASK(11, 4)
+#define FASTRPC_CTXID_MASK GENMASK(15, 8)
 #define INIT_FILELEN_MAX (2 * 1024 * 1024)
 #define INIT_FILE_NAMELEN_MAX (128)
 #define FASTRPC_DEVICE_NAME	"fastrpc"
-- 
2.34.1

