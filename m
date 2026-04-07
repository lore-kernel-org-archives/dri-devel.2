Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357F0EDB7D4
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 09:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87CC710E39A;
	Tue,  7 Apr 2026 09:31:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="G0WCVjDU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RumsnqMk";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8A7A10E39B
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 09:31:51 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6376YmYs494121
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 09:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HSBQhnmXvYIy80xyS3AQSG288sQxr/HSk95H/lT9kno=; b=G0WCVjDUAL1pV+8k
 VG85v2CD80fqCz0bNic7LL2/Il0Kd0hyyElJoEqG9Pacvcd/hKsBuLqjNLMTJhLm
 QZHRt96lBTeBERmtSP+oMIjKOXepDH4bMUhZTnQI+GWZtKxWF43MMmx0AIzBcnQE
 qUgsFIWLeV0+9JniJJ2u+V9NYilQbP7O5NVDsgVjJ6mMlp7JIexY+2aPM/RpfuGH
 Hj4gglURXYoq51+IyDb3EXqmSmGKAA6jJkWmrrzifu6GnfC1DwNpV83LUsqahPYq
 ol1Ty4AZ8w8pkTh0rWPn7+Z6rk3jCPyuoKKyjiCtISyrOwC4TJh9fpm04MAu7GmK
 RhR6nQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr8t1hy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 09:31:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b250d3699aso117556055ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 02:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775554311; x=1776159111;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HSBQhnmXvYIy80xyS3AQSG288sQxr/HSk95H/lT9kno=;
 b=RumsnqMkcGgsW9pnVkyP5Vfb0KQBktTLvHwPR7Nx+WHKmcS3GTrZM4lcPAnT8jgr+1
 ihUH2M346slZ9HhU/RrS6jjjtdwy6/YxBhn3mi7UMGRq3XiT9T4HbpK9SMQLlUTPb3Fg
 mjLl7UVJl/MHsZmJ7Y0AZnYM50ruaaW33l3K7azXwpo0awMvPSaOPCBuYWOXm39J/E3o
 +amaQdlqihX+Y6UDe66YptQ42wdfK5mlSyZ8Eq00HDiTpxEmqW5tkd0DWMyPLiVmieKI
 1aH/YKtLwJ4I2P3ljQj2TGBheVRVwBb0ekJRFwp8n+o5ifPvVIw4tkXi/0SKfV7lGpfX
 hWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775554311; x=1776159111;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HSBQhnmXvYIy80xyS3AQSG288sQxr/HSk95H/lT9kno=;
 b=hYoNkUkgHQ0Kxg2QY6gdlyv02QDoLH1qsBF3rkMAh7vzI5Orpm13VAhQhEbH6rzKlE
 bAq4EwIK9b+jgcHleBfAUgAPMLe34CuQ2fS39yOHrVMMjgexoF0Krupi3I3dV873xfOa
 LGCO5jwzCM0My8pt+/lr5n6ARu1hq/85tcswtILGiZFKaCzMv0GrPp6TTVgZUn2aLEFW
 ZU2Vn3hm3GC/YZEkDRvxQ1XzzjvNXSpcNDjt9DlCJTQuerWFLESLKci2cCo9hnlLVMKj
 r91kRrPVl9zq/08qNrBIusafaIbL7s3XAtnjo0tHaBcsG/EjC1jzs4KjhBpgx80A2Uan
 NYEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6cEriqSQ/MgREDO1gtXqi0WVGtoBRIR8q1KHlbSK9FVZYcCiPoRvop/SErSZKDbq5oXCGvjDsyp0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1Ksw5yN55idS9DgQBflMSbpZS1g0O6yV8cmyJ9ibzK2gPpPBI
 lvUcQi/gojB9KKB6Ae0lO+ArT3iJ3Ga2fO8Vkvb6zEoNHIUq8i8V805KbUyD9uYm5KDIZuxW284
 /w1PQlaW1LhHA6atNQd05nL9Y4bZ96e8r4uOTm1RS+MM8LnQ4EVTXtp+p1qCDi70YUBqC8J4=
X-Gm-Gg: AeBDiesDd+hen7bZzn0PObvAYpiygAqEz0O1lfkHYYLIV9Y//91Ah0r75a3RtANN9uL
 vXoHkxP7vNBPf1+UVIiNu9/40AA04zeQ+2tnqxF68ovkDyqt6vpdWreBr41uMqxXMgg/Db8sutc
 rJT7EWlNY4RgL6dKJ7MuNwL8BozrMZq036sJL61+DU6c3VUwzLjal21nS9cO3TV+mVetDqz2Rhg
 PfSGh4ys672LC6b/a1gbgiTCqLlElToByhIanbe2KSoYG4OkjbPErTLI92LVdjkdMpAiVXW9yGS
 gxO/oTtUO0ML/pPAz5/PJ6iqLDud5FCYb7kKWTU5hE29neLHG+qqRZQ0RTD8yl6U1TmFVFs4iF4
 IJbmhdbWoMvoUphO4g6xtmZVyAsehdc5sx4lPATwFZbuZBQ==
X-Received: by 2002:a17:903:1984:b0:2b0:72c7:3ed8 with SMTP id
 d9443c01a7336-2b281801499mr167754425ad.25.1775554310574; 
 Tue, 07 Apr 2026 02:31:50 -0700 (PDT)
X-Received: by 2002:a17:903:1984:b0:2b0:72c7:3ed8 with SMTP id
 d9443c01a7336-2b281801499mr167753945ad.25.1775554310009; 
 Tue, 07 Apr 2026 02:31:50 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478bc96sm172888365ad.33.2026.04.07.02.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 02:31:49 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Tue, 07 Apr 2026 15:00:54 +0530
Subject: [PATCH 4/6] clk: qcom: gxclkctl: Remove GX/GMxC rail votes to
 align with IFPC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-gfx-clk-fixes-v1-4-4bb5583a5054@oss.qualcomm.com>
References: <20260407-gfx-clk-fixes-v1-0-4bb5583a5054@oss.qualcomm.com>
In-Reply-To: <20260407-gfx-clk-fixes-v1-0-4bb5583a5054@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
 Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-GUID: B4HJxkGdudQKB6inkD_-g4BgTUQ2zr-8
X-Proofpoint-ORIG-GUID: B4HJxkGdudQKB6inkD_-g4BgTUQ2zr-8
X-Authority-Analysis: v=2.4 cv=c9abhx9l c=1 sm=1 tr=0 ts=69d4cf07 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=TmjMgu7cwLfWQ02JmboA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA4NyBTYWx0ZWRfX6VfngsCrodDI
 pnW4IsfZmkPBua5L69MGOWwlKmz0Uf5IXknknvf1cdIMYmhMljsn6mM7Kc8eZnwbvWLsxJzRcdt
 2/OMtZnamnlXioXwpP/wUQHICsptj87CMWcYaPct78QwbfeduLJHmmMNH2QxLLsn3il2WTWuXfg
 s59jMa1p76GqJ5s4FARJ2OmsKSwLWU6ARdZINIymhkA2p2atU8J7Si+X1axuGpR03UCpZbR9q5Y
 WEqnzcNqBA5lbQiBnFQxAhQB6+9ZOhYq6lUwDnzyxjtnwz6YXDLQ9VnVNxIrM5/iXIzCOmPRxQn
 WuBj+MfEeY2+Xfl6C0IBQrg6UmCA4j3nSHF4YxTY9RR4FyM8/KTe2FTqKhJ0ltJEns+uTfUTKTe
 nq0novrLBpA1OQa5o+FtGgS7pmWsQBjVErKzcnvuqlAWaaa1xTNdZWfbuc8FGIzQssrSbad1GEy
 QEDi6geE5g2dYJ1PkOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070087
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

The GX GDSC control is handled through a dedicated clock controller,
and the enable/disable sequencing depends on correct rail voting.
The driver votes for the GX/GMxC rails and CX GDSC before toggling
the GX GDSC. Currently, during GMU runtime PM resume, rails remain
enabled due to upstream votes propagated via RPM-enabled devlinks
and explicit pm_runtime votes on GX GDSC.

This is not an expected behaviour of IFPC(Inter Frame Power Collapse)
requirements of GPU as GMU firmware is expected to control these rails,
except during the GPU/GMU recovery via the OS and that is where the GX
GDSC should be voting for the rails (GX/GMxC and CX GDSC) before
toggling the GX GDSC.

Thus, disable runtime PM after successfully registering the clock
controller.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 drivers/clk/qcom/gxclkctl-kaanapali.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gxclkctl-kaanapali.c b/drivers/clk/qcom/gxclkctl-kaanapali.c
index d7cf6834dd77c2a5320ffb8548cdb515be237bdc..d470ade11b0d11eb40843fe84c809e71646dce27 100644
--- a/drivers/clk/qcom/gxclkctl-kaanapali.c
+++ b/drivers/clk/qcom/gxclkctl-kaanapali.c
@@ -7,6 +7,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,kaanapali-gxclkctl.h>
@@ -61,7 +62,15 @@ MODULE_DEVICE_TABLE(of, gx_clkctl_kaanapali_match_table);
 
 static int gx_clkctl_kaanapali_probe(struct platform_device *pdev)
 {
-	return qcom_cc_probe(pdev, &gx_clkctl_kaanapali_desc);
+	int ret;
+
+	ret = qcom_cc_probe(pdev, &gx_clkctl_kaanapali_desc);
+	if (ret)
+		return ret;
+
+	pm_runtime_disable(&pdev->dev);
+
+	return ret;
 }
 
 static struct platform_driver gx_clkctl_kaanapali_driver = {

-- 
2.34.1

