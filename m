Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DAFF34C54
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:05:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61FB810E4C2;
	Mon, 13 Apr 2026 14:05:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YYFzsybg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hw3yq7zU";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C62B010E4A9
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:51 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DDwkeL3569141
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EacYV252Ylxyrr9FQ/70zKkziBbfMroxAzrIkM+nfi0=; b=YYFzsybgKNPrvJTp
 5QTY6XU6xJbyYcZi2la+y5A/nzC8IurfThkGTG76iSEsCD1i6ef2iVc2Thx9ZQ//
 Ab7eFPy8Io8+/Rwr+Dx3TMTjGssvVjtzok5DnbiyzzmmBX4OYrJXca6bRykELa2L
 LJaxXdJbzta0AEMMRp9fVYYMKPNNMrvl8dq1xTqfz4a7W3FEq2U0HHLs1jPnZGkl
 +rudsyXpPEGx0Q0qlYn+p7WNAlLNv8a+p11d0PaWDlezv4SqeZTnrlxTIo3pK7tg
 qEvRLAj6dXifnS9tLe5AOC9x2t2uoAFI4QGibKpxK75iV/HqdVxZAVyPLDB5TMpW
 240LEA==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh1uf018g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:51 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-4232f8d6092so3739322fac.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776089150; x=1776693950;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EacYV252Ylxyrr9FQ/70zKkziBbfMroxAzrIkM+nfi0=;
 b=hw3yq7zUM6N1bbm1zkmTfMBW6c+hD0fqKYfNGrjeSHGX4X8UG1atRUKG2jNjH2CCjK
 7wvs4Em3cnXv1p9CnJ2sq1erUt4tpMgYOp2/yFZutnX8Hlpcy2A4aNAVcKSd54l4QVLE
 dHl5vbUDfiX65sX4Hn9hZ2X3Tpk8nVCG7AFX+hUo07q8aJp8Aud3Dh0GxtCVweIOFSUe
 fCrQeVW03bIDAgA773CZJY/QI4atUt2t/1bva5RAbNktEPrPdIT/9aVnmsiTYlQARvwG
 WxKNCEekk9f53EI2vcdGYO+YSZBYimnrMrI4oPEj12Sn1/KVEjrE6uiALWN9lhg04oar
 YCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776089150; x=1776693950;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EacYV252Ylxyrr9FQ/70zKkziBbfMroxAzrIkM+nfi0=;
 b=bIwbNp74ib0u7mjqF6s6kqQJWgiIc0PIOL0WH8XPe2DZKVcsuBL5upZDHROKwv1y7z
 XVWaKZrClC1NA860ZUbZwmXdAIfRGar4qovz1TBJA84bwpN8l2klSMLvrryqjL2ey4i0
 +/u4hYeBi1WqICzoBqn7t5GmQtzBQFWzWLxjCufYVpKE/gFKLfcd0wAosEWEi2Nq5KQS
 Wk5Ld4o8JxRFi9dOLFL7yfdICrVacQk4v0TcPOuhHHi0MaoyTtuElkmlFG2dtj+Xae3b
 3F4Y6lvmS6DYRmGuyCtexhMdueNuyr15WBhp++9zSK/QtPIqrpt/qEnqqx7nwn8ht4xe
 Qoog==
X-Gm-Message-State: AOJu0Yz47a2Q75XPFBRt36Z615XwtGp63faZlykfL/fR8SMrmMxbBOZc
 IQO4G5T3iVOk74RfaotGpcz5F3c1eH6IQDYmJUu5xaL369/ZA4cw11aaEuXhLnGINY3guiHnz0K
 5hqL/7UATvNuUPY78SCVRdoopwuuzwsOFKL8CRzAH25egyP8+AjVerUC+emD0k+nShLIMyMc=
X-Gm-Gg: AeBDieuvDUcD/F1qbnCGuLebuB0DLUVQymZTjx0yGkN7gjJXASuKsIZnIaiwUAc/DvX
 copSB6U68JIJbVAX5MEHoTr8E8JyRtpGsN1wLaHOwAKqBUoeeKq4JaZv0TRq3yiPVRFv6DFHEzs
 RzErNFeUthibHjCt8vd2mdm55sEECdiyLJjB+zo87Vxp9NN3tft3eJahAflKAkfxUz/b4GVCbA7
 TNru17OoUd8ON4sUs32bPZ6HxZYEbyMxnNR09HD/el1V+rKa7+RxvxgwOWPbtUn6zCS3/q4PxdO
 Bo5AJWRSwXeO7NliwQ1iYnEmdcSJayXAb3MhV6qJzpn4CDtDjN6Cg7sH/JnftNICAwicQB/MGRD
 wzT1kDEKf5XzE0rfGX/H//9oYG8/6SqWBefEF2PkUcdmeIKShm85EgPzJDdGHCxgdIDk4OTTkiz
 l6G03RAkUuOCXuS/NN4AVDHB9gRZOUg+XNS5Q=
X-Received: by 2002:a05:6808:4f29:b0:467:fb9b:9818 with SMTP id
 5614622812f47-478a0f18fddmr6046757b6e.40.1776089150302; 
 Mon, 13 Apr 2026 07:05:50 -0700 (PDT)
X-Received: by 2002:a05:6808:4f29:b0:467:fb9b:9818 with SMTP id
 5614622812f47-478a0f18fddmr6046700b6e.40.1776089149735; 
 Mon, 13 Apr 2026 07:05:49 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee8c91csm2687521e87.19.2026.04.13.07.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 07:05:47 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 17:05:31 +0300
Subject: [PATCH v3 08/21] drm/panel: himax-hx8394: set prepare_prev_first
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-waveshare-dsi-touch-v3-8-3aeb53022c32@oss.qualcomm.com>
References: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
In-Reply-To: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>,
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Jie Gan <jie.gan@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=DoendjqYMNCpaNDLx5nJc92Y8UtuCTST95sXT4ei12s=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp3Pgn18hIWmMRBJH77hbN0nEy2AN7HiG9Wx+pK
 kM48SmCVmmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCadz4JwAKCRCLPIo+Aiko
 1d4PB/43iCoGV/XPHUY+LTdEOriQxtRXRqWo0WE7dOyI1sgHpDIIc5Xb4xOmgDn9sQaqDo7hYnM
 Mu0SIMUpakh6NGnaA+3O4SqgzeZBufPT9R30GGkHmqx2G5UBf9uxemus2YKiTbKuHfwP4KliY5I
 hutN7+y7vsN4vTfDhK5Fwq3fM3vATeevkRefyzcKASTSWuNdfme6f0obHPK4mirZVJT+vFLT03v
 aJsE14N5TLnnRuMxJTUdhsdpvlIDlrfUOB0NYk5B8zUyF8faTHrbMtEMG2rO1mBIFv+uj3frVym
 Y2IZ1jPuAJXj21WzV1dHtNWQsXiCLbHZ/q0Hsw4xsRd/YVOK
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=Dc4nbPtW c=1 sm=1 tr=0 ts=69dcf83f cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=ic6V0yA_i5s2A4o5CdYA:9 a=QEXdDO2ut3YA:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-ORIG-GUID: 7RPNUM-KjkW5KdjPmjSlI9vOi7iWDEU_
X-Proofpoint-GUID: 7RPNUM-KjkW5KdjPmjSlI9vOi7iWDEU_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEzNyBTYWx0ZWRfX21MUt0Iim68o
 cySiaCuHB36hb5471VTbq/GofFlcH6u5ut2+5/BZ1Kje9NbjFlhMJ8SA8W4v1Z7uo5C+wdapXnq
 RZm6Z/3kBDk2RG6nzt3Z8JN8h9okWzXbmHVaP4a+ed6NlAbbyRA1hxkK7Jt7dzu2kfT9s+kJyy5
 WKgvLF/sh7GeoGn3v7MH1KspAcpBPAgabGCXlZe/3fqqWKkIdabEF1GEmc19SwE4O2eQnRTpGHC
 5rwGNy49p/miKjtixXeuiDcjT7gMyUIbvei9KGenzKxFEJ7iK5A4jM9HQbzFAktQTrSXAtbJzlA
 ztRWk4Px+13Bh+3RrP1iJHfBUWO1STTbcURdOpxcEVNFAUXePzYeZHBtVDRCXSCjVXDDZ3lAgYu
 NOr1u4aWfpaWbvxZHGVi0WuPQ/4v9mmt0pQhaphu8tyspW/A2KcX0a4zf8ltkJxfOmYVy203M+d
 xq1RUm6Y27R7mniI3UQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130137
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

Sending DSI commands from the prepare() callback requires DSI link to be
up at that point. For DSI hosts is guaranteed only if the panel driver
sets the .prepare_prev_first flag. Set it to let these panels work with
the DSI hosts which don't power on the link in their .mode_set callback.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-himax-hx8394.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx8394.c b/drivers/gpu/drm/panel/panel-himax-hx8394.c
index c4d3e09a228d..d64f3521eb15 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx8394.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx8394.c
@@ -792,6 +792,8 @@ static int hx8394_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
+	ctx->panel.prepare_prev_first = true;
+
 	drm_panel_add(&ctx->panel);
 
 	ret = mipi_dsi_attach(dsi);

-- 
2.47.3

