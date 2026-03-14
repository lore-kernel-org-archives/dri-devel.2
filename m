Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A942E107BCEF
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 02:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E182610E09A;
	Sat, 14 Mar 2026 02:10:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="F1JxTVw1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="REYFBPML";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A84110E09A
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 02:10:04 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DNGsjL1435699
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 02:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zkwHP9ceUQy3uJlb2Qy9ZoM9IQMMlgfHIckJWUulXX8=; b=F1JxTVw1ul0gMUYZ
 VQVmjF6b+9ik2zHjfpH1KrNymRhMiixacY/kIqsotqawoQxs1T06N1kG/6BGPDef
 ahDgyJpmaascvrfVbQeBM82NRGO/R3zfBYLSKE0wfUO/DAweumqbgFVtQmAJgVba
 MNzu/CM2OrJgccBn1sOQJGX/4ZfoD6WxLoeMjBBNtRpphTq/zowcIXVDBIs8cL3+
 Gjfk+uHRa9E+Z8QQoPLOOGjHM2N+nGeQ9R3CQ4I8pz4tSJRNTh4aq14t5uPkDQWZ
 wdRr/3pKRp1ZzVz+uy5R6MQhwblHzVtFMbiL7fZPTWEZTV3caSQUcqRvTId6O1OO
 imjLcQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvnax9pwr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 02:10:02 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-948df60cec6so5148138241.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 19:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773454202; x=1774059002;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zkwHP9ceUQy3uJlb2Qy9ZoM9IQMMlgfHIckJWUulXX8=;
 b=REYFBPMLR9swMzg6v53EwRbG0kjm3JLwULGA7r4Yz6TX8QFlob8JQfou999BXqIWsh
 fHYBpAUn7U4DqtNFqSPwEvEhKjwJVwomoR3jTTC/al9DqOR92sc1uumZptC2+K1oRXLf
 JpwW62M9mJ++sehF2PkUWbJmHgnVtIVG6K0td97tBT2M2vTER4RG8jDFS5xaBj97nEv0
 ftMlvs4iAuyMl1gt6wD1ap7tbfEIZL0XenjFG11lkeb2qcBreyFkYXUijALKqbruGQ4H
 44RjoxOAAhzY7RZpy7Uzs2zbRURXKVk7+1fF6zBVD+9foY31o1uU6KqfK7zZzRq50kH8
 wMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773454202; x=1774059002;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zkwHP9ceUQy3uJlb2Qy9ZoM9IQMMlgfHIckJWUulXX8=;
 b=pBbXe9ssZz+ll1Zf5UjeYc+OH2P3IeRUSK0tIUDUWQ+t2777fAncUa1uz+9vn5imQ9
 ICv2fa8Iu1xh6/CQHyupQaURFfofxTGT3U+RZmona8sghLIHbB15evzXlqp3XJfkmNiM
 OVJ4j5/rMEsGUv3S+tl5Q8sg/BcR3MULXzmKlIm/oZDuq7dTcAbGcA3iugrWOgVwHfP/
 5C0VdGAOrIZ1HtDS2YAf4qFlh3UWsF+u40XIMfaSYYsqUAuctC/4LyV4fpwmOgwKLLgm
 aKi5HMebYvJ8/8/4+B6vQwMn58A9uOqiR1K9ooqtj6fN0pkltlpvW3GbY6sljRTQtA9c
 R7Eg==
X-Gm-Message-State: AOJu0Yx4YntvG/jQjyxBAtvkGJS+dR7pkOlUPX9ks9WvfQmi7cFKOrD9
 JE6GKwjC+1I1tFOcAmBPodG7JmItFJfV1/kYQE1KrjrbDSXt+HIbGM6wJwhRRAZANPMD2KwLFr2
 RLZRl3RnDJFYzn63Y01uZDdqHHZ/aAwn6a4rJ0l+cTbPPN29DrLIfDJ5QmW92U/ZfZq137yM=
X-Gm-Gg: ATEYQzwQbcC4stk/j9Sx5KSfkvqLJDeRgAXI9Rwt8+8ZlWXefFBrEkNLb+HG+fEBTZE
 cWajUNmP4TYRrRMoo9vyJc7E7AfkT82tjp061lcTBUEhSoThf/6IpL1iKk0wIFMFXCUrUyOk2Z1
 RThQ5BGD9yQjvvhqhqSKlzv57XJUDldeDclJaN7j5zX/f7u6Jqfo9M0YkRW4VSQbCpCXKd1Bxat
 ZH7uk9cJOk+bdoHyHCTRDGWospxyauG1Zq3gCZCubWYx/t0tsO7bEt90IzvCcj688CydkhdUQq8
 w+EbECc0YN1t61uSRc2DAOeJx+W3KNqBe1h5iTnLc/xiNMfcItTgezUaifff6Z+CIEaJYwdH5cy
 SgpbNk4y2mAWB6UzZ+yA7o/3XynILnOBPKMRqCCiNaBIg4KH2kufzvCrNphiaJxyuQ352x4bFK0
 ZDINNCDiUoUmcdO3dkQ3deZaIl7RY7XKcLjzY=
X-Received: by 2002:a05:6102:26d4:b0:5ff:9d74:967b with SMTP id
 ada2fe7eead31-6020e510daamr1986730137.20.1773454201677; 
 Fri, 13 Mar 2026 19:10:01 -0700 (PDT)
X-Received: by 2002:a05:6102:26d4:b0:5ff:9d74:967b with SMTP id
 ada2fe7eead31-6020e510daamr1986700137.20.1773454200768; 
 Fri, 13 Mar 2026 19:10:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38a67d6185csm18479301fa.3.2026.03.13.19.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 19:09:58 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Tony <syyang@lontium.com>,
 Vishnu Saini <vishnu.saini@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, prahlad.valluru@oss.qualcomm.com,
 Prahlad Valluru <vvalluru@qti.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Simon Zhu <xmzhu@lontium.corp-partner.google.com>
In-Reply-To: <20260303-lt8713sx-bridge-driver-v5-0-6cc2a855aafa@oss.qualcomm.com>
References: <20260303-lt8713sx-bridge-driver-v5-0-6cc2a855aafa@oss.qualcomm.com>
Subject: Re: [PATCH v5 0/2] Add lontium lt8713sx bridge driver
Message-Id: <177345419701.98253.11507693763985665579.b4-ty@oss.qualcomm.com>
Date: Sat, 14 Mar 2026 04:09:57 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: 1UoXh6I5veQ1m1lV-i0uCZeoBAew3G8_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDAxNCBTYWx0ZWRfX3oAhEjK34IMB
 mNlmMr9Y9bs1U3qlKT06jxq7ESHdHe5/a4pH+6YS0MjgZTp888bEmB+B6BwZf6QAzEQQeUN0lkn
 31r0NsS2gemAy+1p7VQw3APisL89fHxqMV2r5Fgk17MKF4XkgKO2tgHHJBeQ9RoLy4rc1QXgK3b
 F+m/eXnhqo4l4WpqABDaLc18+m0TnHCLDYUJtYNWuEpWs8fkoNFbI5sn4m1AA1kUxtm+Sxb6aCl
 +m2NODsHGJrA8OBy5HR9/9tvM+35ZNi9c82l6xhO+BQsH1iypPpH4W12FXT+WTJdQgCY+mnqyDd
 Qo4qsYZeh8LVGP7K2XoyNXEZWQKM511r5LpW3oFZTBlmBaeFqnRkhn5iCOM9aSFUMMsWKhDHPlD
 9jAnf5NedceBGzW4h0FPp86NYZilkFSeVamD/V8IK8VM6/vpZOC3cjgUoT/kePJsOSXTFNloc93
 TjAE+JLvsAXVN3odsVg==
X-Authority-Analysis: v=2.4 cv=X5Ff6WTe c=1 sm=1 tr=0 ts=69b4c37a cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=K0yhrkYJGLBofdj1EVwA:9
 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: 1UoXh6I5veQ1m1lV-i0uCZeoBAew3G8_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_05,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603140014
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

On Tue, 03 Mar 2026 22:13:34 +0530, Vishnu Saini wrote:
> The lt8713sx is a Type-C/DP1.4 to Type-C/DP1.4/HDMI2.0 converter,
> with three configurable DP1.4/HDMI2.0/DP++ output interfaces and
> audio output interface.
> 
> This series provides bridge driver and dt bindings for lt8713sx.
> The driver is required for firmware upgrade and enabling the bridge chip.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/2] dt-bindings: bridge: lt8713sx: Add bindings
      commit: 130daea1cb6217fb9b9ad51453e0a06e8111b3b2
[2/2] drm/bridge: add support for lontium lt8713sx bridge driver
      commit: 4037c6adc1f99843b9076e7ced85db0f233e9eeb

Best regards,
-- 
With best wishes
Dmitry


