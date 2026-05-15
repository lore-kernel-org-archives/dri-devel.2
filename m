Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA10CD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 12:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CC3910F51A;
	Fri, 15 May 2026 12:42:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="F4D8EOar";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EtAz42ig";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39B1D10F51A
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 12:42:37 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FAxbra1848041
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 12:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=pqILH36+bPj
 XkI9bIGyaDvTximt2bkQbgl3RjerBI7A=; b=F4D8EOar1wz9Cj7mkw+2d9ACo/r
 ywk8pbZWNUkSxPQXUiCA7VcD33E6W9PKqAsnwyvOiUz5IdB8iM5O/hclhcV8xTsb
 lW15qLgY+BtYFYNVC0UYroc/N+DQuGXGpK1uT3K/8OU08kN8LgHNhbBj8cDMoQfi
 eBqjsg9ui7eCtdQQHZntGdl4DwaSzAvDFGsmPfA/OYT4CI/WDEIzgCAu+cFsWFqv
 JEWsbZIcBnAYVN0MnvA9khMG2Dv6Agylzz9m+lckFF8Qzj+mLXQEhrmrZFCTAycu
 DdtLBanQApIywH8p2rIahUBX8FlPsKtlxTh6VaVKxXSR2YoHlPkbeS/FxCA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1t37d4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 12:42:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b4678c6171so97777015ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 05:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778848955; x=1779453755;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pqILH36+bPjXkI9bIGyaDvTximt2bkQbgl3RjerBI7A=;
 b=EtAz42igNxCg1Akcwz8Xz7XC7Ao0T61YSFRr0BWPSkgTdd5j0JEMSkLdRBweq8RexK
 2+bMsiRdGOy3XKu0aGVvLJY1qwahUCcf+5h9nzf+FT80MbsNmfu8EeBoArn3HJodox32
 yJCieMd1dS8NmnMZSOIqj56S8VlAMX2fXQ2DPNTC6W+JeCoF3y9wp4L1rOwGvtNRaouo
 LqcbuR10E7Qg8ZYYEWW+gssyJUSN/yFlKgusSZAiX1Hr5sKMqwMkpMzNp3YaUdbG2dNt
 2qPAVNrhG4i3TEN/l+W+zp6i4tYp5l4hE1CTErZ7a2fQ9xTKLgX+H7NbGyAWvSUylMy5
 m0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778848955; x=1779453755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pqILH36+bPjXkI9bIGyaDvTximt2bkQbgl3RjerBI7A=;
 b=Vq509kH2I4qC6g14Xq9BjF5hOURHjHLzopRSBrpq++DU8qhp0ZCV/xOZvjBtoyBVeI
 AQRx23BF2l1uMSvhAwqNaObfkztt/aZ4NMa9h5YJ4GqlWRFRYXY2HXqalB33syIiwtGH
 P06xyTFEXWrGketOlxPNFCjcChNuxC4sBDP1w00R5DGeB396wJhxdhXTyhrN23ZYAFI4
 m+wQhUHLQkrYD1KeJuGzl7ReT//WxByyq6nvA+T8yFWt7A9Yl16qHP/37dhGXV/exAjM
 LrnL5Sf/kRL+DRWoU3Mccxbfk3qlLaffaFi79Sqkgn7cxoffZsr9WtTvnXCrhCLx2TrZ
 AeHg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ve8dZs8akdnz1nzEImskFd2PSIWeJq1itVtJsIBPNOSHyGY4aJ4EspmJ9MGngcPByMluXgkgKCco=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQADotPvv8YqDOXjjdNjC03SyQ0g1Ujbouf2b8EVosk9p3qrno
 OfvzLgAJmPuMPsXSo74tAiUH/Kuloiw+K7Bs5Hfni3Yv1Ydx0OnjK5lRr7PPenRP60pkP3o0skt
 mkyZPas/+XBmP5FQHiyu7PQLP9h4vJ2DkQPoc1RAoWa5dNh1sL1k0J6fv3jvxlb4Pl4+hgZqXk8
 g+1kbXXQ==
X-Gm-Gg: Acq92OHp9fdTVrT4syA3SqiGuzDwM1Sr91KvkEvsuSLr9svHbZ/o60WV9e4u0EZIzSE
 8PPNUAWWWgBoUyApWbkzGs7VODwTgy+HyJMkpuHxSTyGHoGu6tDc/dkInnwoNtq6gBRZjyyMalC
 C5+2+zJ1Aah8aD5kqwEfsNtRrm8BZMhCuTanOFSkqQH8cVjgd4JNzyfg3Pp+MnHglEVMSNyyxfR
 /nNhy75zGi6nGcjwNNOh/seclHnk7DvK73GzYDYgJ9AQyOxZbQONgr1p9P7okBLAtp6DRabinGQ
 aYMK7+qGXWCuFgJ2hFhl2ofzmB3xDEqWpeROcYakEmVl90B7GvJ9gx2zeslDMtkbdpo8cn4pVGj
 z0YkGf0b5aS6p5FDU7klknDiThmePWXMDSvSdu44z+ORSp/E+6XIl0+ZKEJ46Z79o8+fJ0yBBnl
 DQCINO9jOc9m7aaUfHZPJmzW27jtMd2Q==
X-Received: by 2002:a17:902:7d96:b0:2b0:bed1:46f7 with SMTP id
 d9443c01a7336-2bd7e910f99mr29585705ad.37.1778848955051; 
 Fri, 15 May 2026 05:42:35 -0700 (PDT)
X-Received: by 2002:a17:902:7d96:b0:2b0:bed1:46f7 with SMTP id
 d9443c01a7336-2bd7e910f99mr29585415ad.37.1778848954432; 
 Fri, 15 May 2026 05:42:34 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c05f27csm56119395ad.25.2026.05.15.05.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 05:42:34 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez-ortiz@linaro.org
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 stable@kernel.org, Jianping Li <jianping.li@oss.qualcomm.com>
Subject: [PATCH v5 1/5] misc: fastrpc: Fix initial memory allocation for Audio
 PD memory pool
Date: Fri, 15 May 2026 20:42:13 +0800
Message-Id: <20260515124217.20723-2-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
References: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=D7Z37PRj c=1 sm=1 tr=0 ts=6a0714bc cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=Op9FgWJ_R3wbKKMAuNAA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEyOSBTYWx0ZWRfX819jX9u92K/8
 pzprVTOJQq3zpNsghVFOM7lT4UOt7Eu+n4qtOJB9/BYRvlXM+mGrQxyBBDDbNt/aXo81+I9Ki1j
 wbs9OoxO33g/0cW7GRSrn1ogKpXHFR2jaZ2ifULYOpiSQCfxgBMomuvxAv8f5ik1cdy9ltocWOt
 CzkIGFzPlQ7BVF7RV+qeBFb7+xxVXVF6yu8d1ZRWwticYqdnM/QGbExl4UPkKOjgwnlRodekUnb
 4LUlJuDHVk62DRlYeDzAdqp3k5s5Id1xm0rcknGuuPFDcHK53wC1micF1Vf8vSu4eGL2sk1h96a
 FZFQmTAEBj26v1EX5G46qlXGzl3OH8bdHFf3Cu7Z/5uAryUi87PuFIDck7yTJFqoM1UIVhE3o2z
 3RwCkgYEsBYwnTmx4GTKvrpytJIcWgamX6a7Y3c1UWVFBgB8guBJnhFq5BWFmHIoexWsA6dXZ27
 kh4eSnFUl+WmM9CB1Zw==
X-Proofpoint-ORIG-GUID: Igj2mtc6DKTvR5SzmjddDBaZFZNy0EWO
X-Proofpoint-GUID: Igj2mtc6DKTvR5SzmjddDBaZFZNy0EWO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150129
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
index 1080f9acf70a..8b21f85cd9f4 100644
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

