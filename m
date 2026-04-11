Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E39F3ED43
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 12:10:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE82110E1D0;
	Sat, 11 Apr 2026 12:10:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oSoou0Ef";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AeeZH7iM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E00910E1CF
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:10:57 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B432ld2736597
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2x5lTfFSzhFGUpvlbYeEl+bXq1HLvTyRTgCgvYE/a3w=; b=oSoou0EfSGTd24/J
 IwuHKdflu8S1MjylbQOgCulzZKwtb7AgIVxc48XyLZ/kMjm1YFnxPlYPBo4ghrEj
 wA0OkQ+g3forAM+/eFZgac2mW9vV6ZByqC2s5KgUqFyNusaCIjzhzfN8dDUO+VKu
 TlQuo8L6MeldkwUmJVDnRv/kvUwNL6yctov3e4EGEnpMSz0hQ0/uulOPCyiAxZst
 dUyvkcGlIodgWZO6H4bII6nR85nVPYc4GlaX1hNqhg75WR87ANyl3rxAnjbQiQab
 nSZrMCB7GW0Fg4uF7mEKWyPFNKwAebRpDl8h886610WyWnwZtU4og5QsX2VNryid
 cqYzow==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfexcrn0a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:10:56 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d58bed44aso91361381cf.3
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 05:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775909456; x=1776514256;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2x5lTfFSzhFGUpvlbYeEl+bXq1HLvTyRTgCgvYE/a3w=;
 b=AeeZH7iMaSOGYpeWC3qnkgE48jLF/JK/xTNHKgHsEYZLI6puDaqqfFu5iShLkyRyCz
 sSgyRFEMDySW64lxnzgRl8rI6ByZGfOqJoC05DKYnJjmrJrn48tUC9OyCNjomm3xWt0P
 C9dnQC4PjEO+cbQej2iJ2MMxpBKVrYmK1XegIO8/qiNOTl2fBMns8w3wgMXCezVoaYvu
 IY4ezYZQpe6lE7h2vr2s4UOV3N/PSezXTJrQfyzfpsdpxZUuPCsUcs2iv3KNfq7ZHHwl
 A8DtQdT8vqxcCjqif6aJgMVRbhvCRFkLZlpMYvt9vdZGOrlPB9QzqJ/1l9Wxkfrc4gTD
 jG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775909456; x=1776514256;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2x5lTfFSzhFGUpvlbYeEl+bXq1HLvTyRTgCgvYE/a3w=;
 b=WKxY/cETcywoutYjpfJTetw2ZD514jRkiyjRmvqQjj0l0u4j8TfvEEZpvbDQBq/OjF
 bCtIJEe3PkHfo3RUs5N/j03iLDw6ebsxFWaE4aA8sax234SxtG7ZzG5fxha7phR5p9sv
 lVWI6kgnTg+uHdOY/jcTeiSRzmSnK7Mcl536PIo4akcA5JoISwOMO/4mPcP7TgZYBnKJ
 Rz9i8+Ys5E4uI31lVrQFxeEW6Fx0Vako5etCUYrtQpBjP24b2b7RytT/xpHJDHSvnhFe
 9fBf/HyQD+MTbQJPWtPJAeUpMJqQAN61fS4IxyOl8ZrEyNC7eln69ihm8v7ULDiDkW0n
 MT+w==
X-Gm-Message-State: AOJu0Yyu8kEnSZBomilDK33FGGps3NvH9/gioVB/SrsOCAfKeO+yNd11
 FS/QTAT2QkLBLTT3OvhJ4d2ACKqiQGF7h39OFuKfv7oZdxpAGPsAnXjjADf2yjq6Mg3HUq2HI9u
 Z5ZccPKRIoetnDJ6ZaQ9G2q3qQpDwHwUpHblw3zOKOZjwI4CiLCMlRbPhytjc9LTgrT5T/w8=
X-Gm-Gg: AeBDietSZ9xde4jhnhp6+WxCThRqCVEp89ovP8WT4UiUxv8lTFHkoNi7ODaarK2n8DL
 okIU3BBz2O2h661DHOJZThgCFe814YejYDqlkg3wirxLCQzgMisn8hN/fabYMXnQuMo1sE+OTTl
 WLRilyRyYj3ZkMStPIAZQtBX6JnuhiH9dAXSsIGV0Hw2JRH53w5bKN09irDTWVIuzefoYg+n4k3
 2d8Xb+ThWWl0TMog0pyqxbHPHusZii9hGFBlxclJB7t5yL6AKvKf9sLxU6KLm0fJYxKfphpz9+z
 2uLp+/cMt7f0M0f6Qa2GnaZotNcgCvFQK+Gl74H5UA8zZGWzB7kr04NryalKq2L0OqZqUxXxPlp
 6g9SKyXXOLsMP5qxHnJobvTLFQpp0pB4ytbpIOnkhOoc3q9Qw4t1pkdt9nmOczhnS3F0kgEiP0P
 +87A5szPQ/gW4TjeV0Db+wMvmwV0wOXi+PStU=
X-Received: by 2002:a05:622a:8d0f:b0:50d:81c4:4c85 with SMTP id
 d75a77b69052e-50dd5cc1268mr88395231cf.36.1775909456049; 
 Sat, 11 Apr 2026 05:10:56 -0700 (PDT)
X-Received: by 2002:a05:622a:8d0f:b0:50d:81c4:4c85 with SMTP id
 d75a77b69052e-50dd5cc1268mr88394831cf.36.1775909455668; 
 Sat, 11 Apr 2026 05:10:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e495b4e73sm11906291fa.41.2026.04.11.05.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 05:10:54 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 15:10:23 +0300
Subject: [PATCH v2 03/21] dt-bindings: display/panel: jadard,jd9365da-h3:
 describe Waveshare panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-waveshare-dsi-touch-v2-3-75cdbeac5156@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1144;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=N8CKm/X1r0MFwLfZruus26Jh9rArudtbcfuT15AgEuo=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ+YtK9eEx0ut3khnZb7PE7VhEMlQFN+ww9pIp1635Owz9
 8dqtzo6GY1ZGBi5GGTFFFl8ClqmxmxKDvuwY2o9zCBWJpApDFycAjCRM3rs/8Mypx9e83f27+VT
 Xv76rX717vFL8rLFBw74rJn5yzJRbWuT8vrqJxUB2g/KGjZe2iF140auW3HpZdX/iqaMJ3n3NZx
 2iA5+23Qxqk2z1DVIo1J+0csXvgyecjJ+gXdKgp287mocqc1katK8sCpvXaVszwmLm4VLDsQXid
 46+Dt23sOMo6Zp+bpvxVhOP/c1NrPfKRgpoOgm9U3r6T4hFpWJC9T3uk4qszxTXrR7u+y7VfIhM
 u7h2paCl6Ib10526PNhNl5y4zSb8m4xljodbfODEnJ/CrqXHX5SMX1Zr5t4d8uvil8s4gYaJUYf
 ai9XdEcZeAX5xi0O3Vfj+u+6+LO4+qKHwUoHdF6ozPkMAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDEwMiBTYWx0ZWRfX2cix2YS4rQfH
 E83cFJCSr5M0RgerT6+54cekWgGas1XZI6QImKvenkx52iFSW+gcqEaGhmfEBNu2KbbFYZG9HVg
 Ncog2MMMl6f5Cd4qSAAarBDcaBw8ZC8d1Ni2BKG/W2MXoVkpBTNOnj6LPWAigI0x76R5lRsnnNX
 2HeT7sySZiJnMuHEKdCVvHGbqZJX6LIMEvQSzJuPtv15pFlJS+zmEFSq9cblFI/Qx82fhzW85DO
 XKjXTDhPV8ehm5PlP8UYZ6XxgGapAJdbaJRu0CLVQavQvpszjIBfsr+j/OF8a1wfYEpNemQY6Ya
 Jfx8w146EwP6A+DpsCncPfTdoezEfMORxm2epRMs9YpOjOSJe8lSZyVPkVB4HLRJxhPAvX0SIZ/
 ceBSnIbfh2rVn+01g58YSpV4rzKUTcYilYXMfMARXpNMWGHrjfErg0/0fEsz+x4lfL6S+vWPKyx
 123EW+LddHQuRLM7b1w==
X-Proofpoint-GUID: sHBeJyV0XEZweXU-ytJII3I9DEx0M7KW
X-Authority-Analysis: v=2.4 cv=MqliLWae c=1 sm=1 tr=0 ts=69da3a50 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=3ozaZGYpt45I3yT0zMEA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: sHBeJyV0XEZweXU-ytJII3I9DEx0M7KW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
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

Describe Waveshare DSI panels which use JD9365 as a panel controller.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml b/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
index e39efb44ed42..4eae802de9fd 100644
--- a/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
+++ b/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
@@ -24,6 +24,12 @@ properties:
           - radxa,display-10hd-ad001
           - radxa,display-8hd-ad002
           - taiguanck,xti05101-01a
+          - waveshare,3.4-dsi-touch-c
+          - waveshare,4.0-dsi-touch-c
+          - waveshare,8.0-dsi-touch-a
+          - waveshare,9.0-dsi-touch-b
+          - waveshare,10.1-dsi-touch-a
+          - waveshare,10.1-dsi-touch-b
       - const: jadard,jd9365da-h3
 
   reg:

-- 
2.47.3

