Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92262FA1FE8
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 19:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF71010EAA4;
	Wed, 22 Apr 2026 19:25:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gD2H7eDz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WLN6VTU6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6860910EAA4
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:25:18 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MFfONY2956213
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=kKk/DlpVJ5i/ibai9sI917sW
 Kqlx4p1Hvn1dsjbUlxQ=; b=gD2H7eDzW3e3MO0vPYTPse3oRH8XytQr2WLW9Q5G
 fP3i5aDX9D9zv0V0LThcZFp3RuuJ1LS3r2Uy0axklStnAjkni6zOlg7nPTe8JW9y
 VnpmBWDNcUE+beKFKsnEPFZdmvDyyegU8Eqj5eCj5QhtjkszbC9qjLgjf16IsPJZ
 q7Y8S4kh0o4vHUm4Vkul6GzTEsp/s172duNwwFgFWU+3a/d1qE/RVVMDqJiixM1y
 rWztJ396guzZQl+viSGt5Ny7WKRTQEAjzKTZqCBxjq7Clo6Bp5CTI7YVGQ5ViwKQ
 y5pacAvIuaYwQ0DthHuiaHTkmOwb4OG7pQY88XDA+xm2TQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq16q0snb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:25:17 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-94ad0ada31bso11782449241.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 12:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776885916; x=1777490716;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kKk/DlpVJ5i/ibai9sI917sWKqlx4p1Hvn1dsjbUlxQ=;
 b=WLN6VTU63oyOeAqfcMPm//LDm1x6RTdgdCYA01Q4IV6VaG39DE/+6Hgi32iRnzfQ/H
 GqAJzqqStSmlhepiWHB8NKCGFiNqMgDbWRttbY1iQrxab85YV+ZAGysYUd1MkI7ZXZQW
 SgwFzOlcpatGuMdWR9/pmxYlNw1pELizppCeCmOSJDDoY/Ig4UhTjXN3EFGYv3soGW7m
 lj8c2vzS080yVFnh1SfBuYiBdfeECg4puS0Zwa1qRzOlveFQVQgOONgcTBnH9AtsssAZ
 sCSiW1HdHTaqwSMnb3GGDu24bWJm0eF1Us4K3uIarU2B2s+0dBOA+p0Z9xor1WYE9hhQ
 Y37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776885916; x=1777490716;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kKk/DlpVJ5i/ibai9sI917sWKqlx4p1Hvn1dsjbUlxQ=;
 b=bBM7tft6yY+QDjyEhV4EPw/e/djE60xPcxK4PLJcJszbg3XC88A5Me1rmfABLKfKF3
 eM2XcnNT/l2o3WQbaitKuIcMINa4eGCk1lb6tTuchsaVigjn7Ze8uYcWK1Z4OiwARHdl
 RvQhoYmI8kce5NfUmFxxXdz/oc4Jslfcvn7iKt+Mxvy1hu/y0fcQgdza0r0ybpg6NhCG
 UNFDM83fGQndj6HCoVXhyBayGwvjkJDJqxtRVOVkC4kTFfHMg7er9hph7rQMDG7YfDmk
 jPBG+hn3nxVWvvVlC6m48rWrAXVzo4U/7c9ejBEgr7/T9S2vCkv5l9xJWe37Gl0E2J6S
 6aGg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8CSL4pywwimApkGHfucxpj/b5zvoSOAR4+nV0/Zzn8MBo+X8vjuwZD4tiQJpvtQqGSHRR2bur3dQI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwapE75etLctyjoS4Ndv6CyW8fqsXOIJ2Jut9fc6FNhinlimGQ6
 z1HfU0RikDA4pL25LJMFSyyGQj3lZHoJzsHr049+zztwhWf3K6Re0TOo3LZcZb7h0anH3yRc6Mb
 o7nCO+YbbihqjW5cY5yeftPau9dYTAHm4jvCZxkQq/dHSesJEta5KXLmj5q6s4JJlw1Yb2iY=
X-Gm-Gg: AeBDieskGK7A7TXke0bDauuhAgsvjg5ptDEGqJ5zq4BsBzbN/Nrm2pG5X8c762U9x/I
 ti9lFTYRw6mvBXEp7ikmIu4gia/fLAEhPgTLSZyP68Kv0nyIe12aU2qJZ2hP4esjCi+1lwo0xe5
 QzGFABliy/gGABfbKcUZNbEbhY4bV04k6HFXW1Rlup5WJh6vEgEvzPBukTlql0Ma74bM5nY7NUK
 FAUYnsGHphDNa9Q3DMmVUGnS7XHhMXbuY+UAlluUH7A/ECtN+2LKw9w6npSFhDHJB0G1SIDpo9D
 OD6kHaBgCS0Fo/W8DzHlyVIkAjE+chXzGzPdFn066C/3jKNxiuzDLXzovvx9MdJZGi5lcdUiNG+
 f0OI11qsxe/0xS6WRHbTr5ztl+z/f8gUVqHsyCOcVOMKUR41zdByoSolyziEZEZGp3H+rxYzlU3
 +CbVMeoB2kgy4Ok426j2M51CrsdPCpB7qOG5jcwr3VVUXOSA==
X-Received: by 2002:a05:6102:c0b:b0:600:ac0:ce33 with SMTP id
 ada2fe7eead31-616fb8a054dmr8531151137.5.1776885916600; 
 Wed, 22 Apr 2026 12:25:16 -0700 (PDT)
X-Received: by 2002:a05:6102:c0b:b0:600:ac0:ce33 with SMTP id
 ada2fe7eead31-616fb8a054dmr8531133137.5.1776885916145; 
 Wed, 22 Apr 2026 12:25:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb6f0b88sm38737061fa.27.2026.04.22.12.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 12:25:15 -0700 (PDT)
Date: Wed, 22 Apr 2026 22:25:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ijae Kim <ae878000@gmail.com>, Taegyu Kim <tmk5904@psu.edu>,
 Yuho Choi <dbgh9129@gmail.com>
Subject: Re: [PATCH] drm/panel: jdi-fhd-r63452: remove panel on DSI attach
 failure
Message-ID: <wdowo2jgsbs2dlz3rgzmufhernybag67vovoyfg66byszseur3@mbqgtbbh2rfi>
References: <20260420065305.8781-1-mhun512@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420065305.8781-1-mhun512@gmail.com>
X-Authority-Analysis: v=2.4 cv=KPNqylFo c=1 sm=1 tr=0 ts=69e9209d cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8
 a=WIO7VZ0TTZtR58lU8PoA:9 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: 9nAgzMbE1KIrGc4KXoCtYChSMkzWevZE
X-Proofpoint-ORIG-GUID: 9nAgzMbE1KIrGc4KXoCtYChSMkzWevZE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE4OCBTYWx0ZWRfX2EtTKufyWFrs
 ItKaGpxCXaPTu6MjTL34CmvUE5H3LsaGPYSuRDq+8s74jCrz2Jw8EjuKMPKENOPW806BSLrTrtT
 Rf07vFk/Pf7FVqtvEkISp1NBpsK8rBiW49L+Qvy0HOrr029miMIgE+uOzP3CC8xhW8ZuEg/nqnn
 G0ZBFo0fF++uhbZleEmdDkvNp3TIFrpijQDLFho/mwu//pi50TSqTB3MF4zoGRjH2s73ZaSRIut
 az3U3yBKHQlu0/qO921IhMrEt4ycMfucRU5LtMv0Maslo/L7Ty/bUuwq3TzY75mMipP6/pz80QN
 TLSmD9VAl7FI1TZulCxWKkcIHZ0x2LbZfisTlEqVtV4xy2PQM5uOEl59AvfY1E628nTwAaDRFIy
 1Y7ilxmUY9URvHpkzLFeKx8N1oMn1XpY53q8iI+QiZftlMrIKJKfJx5ZMhZd6s2wS7qhilLmkay
 7SlI7OUsISTDLDxe3Kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220188
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

On Mon, Apr 20, 2026 at 03:52:15PM +0900, Myeonghun Pak wrote:
> The probe path calls drm_panel_add() before mipi_dsi_attach().
> 
> If mipi_dsi_attach() fails, the driver returns without calling
> 
> drm_panel_remove(), leaving the panel registered in the global DRM
> panel list. The driver's .remove() callback does not handle this case
> because failed probe does not transition through the normal bound-device
> removal path.
> 
> Fix this by unwinding drm_panel_add() when mipi_dsi_attach() fails.
> 
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Co-developed-by: Taegyu Kim <tmk5904@psu.edu>
> Signed-off-by: Taegyu Kim <tmk5904@psu.edu>
> Co-developed-by: Yuho Choi <dbgh9129@gmail.com>
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Please group similar pathces in a single series. There is
devm_drm_panel_add() in drm-misc-next.

-- 
With best wishes
Dmitry
