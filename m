Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02CBF3ED4D
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 12:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45D9A10E1CF;
	Sat, 11 Apr 2026 12:11:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dy3MeANw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h59D3FPS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34B0D10E1CF
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:10:55 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B43QLx621305
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EJIKpujoigVEaBknrd4/meAnaGYzGS9Xs4bjoKjmIO8=; b=dy3MeANw3hI3AbSb
 fcYONsxn2v6I/PqrtBboINr2TWxkwyRT7QsFD8LtH8pjh3OM4Wvn75kxhhDTQDQn
 P/vmvAePHAqwc07LnF19dfXvqBQMvXEmWT9ws/0A8jw33CAjiifDBt/L2MlzLFVw
 MPT2ER9ugugYJKdDXinSx61OUzLGa1idxSBeA8PokjwyIxqAaFh4Ldum3jhU9RmT
 bB1NTaA9wrR3fVBckibOdxW2jImPCw91eFQwHzUvemv5utmFSzHH/KM9QxatBmpC
 S6hzRHiX+0cAngD17aXNTHIvsLwQoA2Wp6qasE9PC5bQwEsaGEdtkX7oURtQdUnO
 GKBiBQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfexfrna3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:10:54 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50da31af14cso26207081cf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 05:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775909454; x=1776514254;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EJIKpujoigVEaBknrd4/meAnaGYzGS9Xs4bjoKjmIO8=;
 b=h59D3FPSnBmVYZZ5mUpgVriAixjx2KoxLXk1N51EEK1JrU06eW3FQJA9AmjMmjjMw8
 Z1BBx8V4ulrRDCFAHfCdSmcctaxqvysyh/K0tjQhr75TOXcA2QvTN0RI2y2bUNiN4SER
 n1Ij7z32rXmnV0SonZBkNvGhj+8o6YLWxftZceqLeFdHAEx7VQz3pE7CA5ZJdkNM7G+N
 2F2AYhDr27wGD+XnRUfwo5l/3PNs0kkYTcYnBVNRG6zTiMV7vaGFRzrxptx0xarpW5Fg
 TNi5a6bd56iXEkR0nxClECLUVFfBxigZtArWqUbCJJv92DJ7ZWE2DKpdW/P4RtPn1pE9
 dTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775909454; x=1776514254;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EJIKpujoigVEaBknrd4/meAnaGYzGS9Xs4bjoKjmIO8=;
 b=hZMit1mBZBSsrNuReBSK+cSX2Pb6YEOsjW4/wu7XS8L/x4AD4V8zFbi911hBH75/s2
 Kf6lbzcj/ca1paYtxIeadfztOAP1K9A+vrFcnmIGfQ5HHDQlEUDcMIJq2T19gZYURjVw
 Uducvd7WaXWmvsG7+Iz51fJR9LwxFzduI25U4lKqS3YT0RAk6OkMT/pLvuaZkDrEgd9L
 CBqAhcPiJllv2rbCcqdLcnY0/nF3C8CBB64bu+a+n6XgVXu5hBIa2zqYefw17qbZ/+cr
 ykN788KDOYof0fxKhQg0hldmEorg0EosBXLnZFi+PjX5mNFu8a4I98JQHDw9NNh51X4F
 FN4g==
X-Gm-Message-State: AOJu0Yw4cQMtVJ3iJhcmCU2Se0i4eJ7HZP1dNWGDBwIZa4hAcQP217gR
 KtacIvkOR1l3pkzO0NGwvFF5/klXgQukKgL2nPH+rGlx1hovyxQ2sAmZYKCP6w9OR9KOR4PrMyY
 31zWnYv5+8HuRksTZDfmcA0ZzHeHhvVbohkIDBDtqn+ILQGxb6MeptWqLwDb8K7+BKlKH9vc=
X-Gm-Gg: AeBDievN8vIivZLnEi3bmKixNPW3k+1hj1SVWI2Q9BEVhbemuh8Zmg1R08Y6yMHzpzv
 dKvO0Jcwu5ZA2bpAWnfjNOn+z5gZfCsEe36UZ8Sc1ucl5HKVdpwpjuHgCRnYOPzaK3vcnV8LgTZ
 pCmlozHY5+QtGlA9bZlhoLgy3tFktRJTQ3e1pU4ynJvsRMnIDR4AezVq03AYaI83QnXlH+6AVKX
 zyd8ROMsSmDqNtH7zq6MyVAlZGcBSuqv48cgKY44KEcnYye2y7DdYg4geC6QwZFIajURO0hzXUD
 eDXDMbMRfnYn9MteprNtUW0zESjohKx02M4ZP58KSbtmfndQqxw6mylkTIcljcY6FeXqjT8Y+5y
 5IQEh+vLbdtvIdEPeClZ7RqncQkxT9AktNM9sMLQB4Ry1XQzMi5m17As+EdQzZsKbskckX/v8eK
 /NF4L0QHKHZvKIQ5A0odqk8mL7hEl6PqInoDw=
X-Received: by 2002:ac8:590a:0:b0:50b:4537:2e21 with SMTP id
 d75a77b69052e-50dd5c10684mr97349221cf.45.1775909453442; 
 Sat, 11 Apr 2026 05:10:53 -0700 (PDT)
X-Received: by 2002:ac8:590a:0:b0:50b:4537:2e21 with SMTP id
 d75a77b69052e-50dd5c10684mr97348571cf.45.1775909452897; 
 Sat, 11 Apr 2026 05:10:52 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e495b4e73sm11906291fa.41.2026.04.11.05.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 05:10:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 15:10:22 +0300
Subject: [PATCH v2 02/21] dt-bindings: display/panel: himax,hx8394:
 describe Waveshare panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-waveshare-dsi-touch-v2-2-75cdbeac5156@oss.qualcomm.com>
References: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
In-Reply-To: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
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
 Bartosz Golaszewski <brgl@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1004;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=b6lJFQy4133z0QDWI8Z8xZQHGNeBu8+YH/BZ7Z2AGmc=;
 b=owEBbAGT/pANAwAKAYs8ij4CKSjVAcsmYgBp2jpEcItG6KM6cL2R/Xo5i5wx+vf7QMNN5yAHq
 4hBuRPZ3MKJATIEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCado6RAAKCRCLPIo+Aiko
 1U5yB/dePBkcIcpr6fn0iGCcsez44HsTKognR53WcdondMJIJDoCJ5fvEllYXUxOm7kLDrL9NtH
 MHbH6HmbUAGNMN8N3qgYZ8pFBktNKhqzU+7DMHoikwFcPNxc+UZOsxB5sGJ/wTi5S1TAPI24l6M
 lxVfJF9e1/9QZOA1Q0C4xLXPm/7wxOcNtG66VhjjTPh1fmtJdcrHcET61wHs3MayTcUkfW3Nke5
 K+FwQ5jSPCIpqQHoVaD83SGFCAfE+iL0slowEETtY/PrOehYA1jMthgcFVDfuz2FQuSFb/b3yPx
 NijpdzfYJdmRR1Fhe2JhHfy0/prsK/0HM/0QQ5D4z5EKX0Q=
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: XUeoKHercsnNYUmu92kOIegB2yNxeNIe
X-Authority-Analysis: v=2.4 cv=OpZ/DS/t c=1 sm=1 tr=0 ts=69da3a4e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=0AHfZW8JlnlOAyLNbMwA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: XUeoKHercsnNYUmu92kOIegB2yNxeNIe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDEwMiBTYWx0ZWRfX4LLFYd2YsdKT
 W8I7VE8YWh/+J+FQf4QwoaJkyyBv4Bf8p9XWOKCGItV+QHS9hqyUBKjobvvCRtIimPMjlpxDQ/v
 NZXz+uAHnvm62zENSBZzIvh8Muz8+HygFQF/dgmFGn8KoC3jJjG5J7XNkwAQrG26qxAwNjyOrGx
 6nEIL910mcu9pwFYFyS1X/hlaT2Ti/llbXlyQ5r04lTbj2oSlpwyIdkSpVYKvwk/cvqtMw/SqbA
 m8z3CBTkxlUXPpIdHlnF8zbmcHjuIxyE0uQ0doWkJmoyutoq6XWgv8RkEOcBcxi41Ou9oN/X+pQ
 msFJIVaU5/3wJntU4ImQYubmLcWnqdEKIuY8wjtsz1OhkmmPBLw4hy8caar4qRJp0ihpsaalHR+
 GPF30BnZi3SHlwvWsXaiX3Jjh/46++q57M6xVhq3CffH4nc7PC3GowdDSIDXW2j36eeX2zG9umL
 ls3X6smcbM9V7YpYKag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110102
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

Describe Waveshare 5" and 5" DSI panels which use HX9365-E as a panel
controller.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
index 84e840e0224f..83c343b02835 100644
--- a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
@@ -23,6 +23,8 @@ properties:
               - hannstar,hsd060bhw4
               - microchip,ac40t08a-mipi-panel
               - powkiddy,x55-panel
+              - waveshare,5.0-dsi-touch-a
+              - waveshare,5.5-dsi-touch-a
           - const: himax,hx8394
       - items:
           - enum:

-- 
2.47.3

