Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A451107BCD1
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 00:43:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5C6610E454;
	Sat, 14 Mar 2026 00:43:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PfNDRSOu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YMurtb4v";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73EF510E454
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 00:43:18 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62E0K5OR2108413
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 00:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=EiRh0PeayxZ8NYqGgKn6Jm
 THdsb3BCmaPl1CvKYk1s0=; b=PfNDRSOuLYQo94+jWsLHCOT4F5ZOjddPrjHuuX
 uAV/+3gQk+V1VRaXeo8jR9Svc/XN1Q7CKd+PRFPf3n0lufVLpX//kXAMW2wimYWy
 vhq0hLmupyZcDMADNcSB4/VEblSQ07v93qUeTwtYtMeDfx15NdaD/QnTOAQs9wtE
 X8fF0+midjhTYVrHFayUxbFV5bhgyvzFWSp2dO17WALU4mNU24BmcwNFQe54ePWx
 R9E8PhPIOYaxwfxeG7QkUE27LVkCg9dG+Bnp/gl6r5cJrbEArW/GjNnv8IHBbB1C
 9Hd4FDCr44UC5K4RVvSm5SJBk2T3WuXEd159ZQUlAvuz4LaQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvw1p81u8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 00:43:17 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cdb995a1bfso953665085a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 17:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773448997; x=1774053797;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EiRh0PeayxZ8NYqGgKn6JmTHdsb3BCmaPl1CvKYk1s0=;
 b=YMurtb4v6yImJ7p8L5l/u+bqWWhfnjs3IwMdRRKuM3TZt8ELK4yfu7npEkFf1nd1Ud
 t7cgKtwv/ZBOoqzJQ9TvJ3+8asPACe4l6BvXRO+qZi4Y4+PVqG9sCvfk4GzxOzlmLEtf
 1S3LMt2dl3i/rfR/o0fxWCBxxczvU7rsp5Ubb06NfbBYufGQ1x21USTwkBUcdz3hwotd
 GhgN1t+JiWC1K8ARIiz92aKGmt1qpHHPPnWvHfFWoqIpnrh0CzwKZgIdrx3D8Q+65Ces
 1k1sUkMhQKYQvg8Hk9ylBfDybC9DXDNZ4F5zBflo3hc4pVwjn9kjBEnfMv29N4mOB0KP
 yOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773448997; x=1774053797;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EiRh0PeayxZ8NYqGgKn6JmTHdsb3BCmaPl1CvKYk1s0=;
 b=H8CaDM5JZKTVL/oTVzsVeY51viMuR/9yxtoY1RRUNhoTyLtzKOhVyV41FfCSTm/+q2
 eG1J26YMuc4fkp73h2MTsXNsZlflK0p1iKMOlWxOW1g8xXlrYVCnoyIhdg7B3Ojy3rf7
 aBns1IMxw0Op8Wn08gkW9DlEsEeAxZ5hXtcsdraXCumpo2k2QKJnBCKdqXlK9Y3r/Oit
 hAE1gD0yMQU3LQih2V90pXi+4Hk4B3PPK/uir7Or4jrg2dWn6XNwZ7Zlz42024az8H34
 Cb+aoPyzTh5Vmj0gjMQmEtWhs7mjqrklHRPhPiM4N3m842T9jxb+cCiHFjQR/5QdTcIb
 DiSg==
X-Gm-Message-State: AOJu0Yz5IxD1Oqp0eKW1+QuHu9HRCKOCE/XhNYqloXNMU504aVusGRvv
 gIrq7c5BVRIz7w+9bUsrIuVUuDki0nlV18XS2S0O8xjrX5dq/Mhfa81n9GetTMZuf9nxdsst7O7
 TitXK+3A4gF6heL27gyknT7uYz3qq2Xp2Gs9Ysm6XhUS4tF14Ic+6eQxu3RB7CmJ2SLwYY9Q=
X-Gm-Gg: ATEYQzxgZ3HOfRSawFpxwFOcZembvWAtOCIkFq/P728M8JkSf29YftdEXBKy8JfeBLW
 1gx0SOqnq0gIxTwVvQGVP0n40QzUaPB9Yr+I+Jh8cF5hkzcJDvul7epeNCWd/4BxvlpNo/pfoO3
 4fNnvDyvnNVnp6ntsD0mBS3FALk72eX8FeEWZaBemeubBwVWKUFQG4G2zb1M88+lLB9RKTKVuiK
 NZuyNHXPDGj6Xu+KXYCgF9yVz0UNT2liGhl6SUGedkShEMrd45PwUJnijLsQbBRSkep+9Qrv9WE
 Lgy3L5p2dHqz7vW7aJxJhIkAT3oYJsqKhjKFX8AlKM8ofKF8C4WlqldSAOl4rL48o60vf6HkCRi
 1hcItmzSlNSNlGXNfSWCzrNVRyh4M/+Kgln4vLUaur10FK4RxIMbE+H1QSjcBm+S2H56cIlX/lr
 /p2aQtP5q3NiIY0sxXymiKEVQXzrK5DCV0/u0=
X-Received: by 2002:a05:620a:4044:b0:8b2:ea5a:4149 with SMTP id
 af79cd13be357-8cdb5b7a64bmr730140385a.65.1773448996970; 
 Fri, 13 Mar 2026 17:43:16 -0700 (PDT)
X-Received: by 2002:a05:620a:4044:b0:8b2:ea5a:4149 with SMTP id
 af79cd13be357-8cdb5b7a64bmr730137585a.65.1773448996509; 
 Fri, 13 Mar 2026 17:43:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a156366a74sm1843556e87.75.2026.03.13.17.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 17:43:14 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/2] drm/bridge: display-connector: detect DP state if
 cable is plugged on boot
Date: Sat, 14 Mar 2026 02:43:10 +0200
Message-Id: <20260314-dp-connector-hpd-v1-0-786044cedc17@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB6vtGkC/x3MTQqAIBBA4avErBuwHwbqKtGidMzZqGhEIN49a
 fkt3iuQOQlnWLsCiR/JEnzD0Heg3eEvRjHNMKqR1DTMaCLq4D3rOyR00aBVtDDRqemw0LKY2Mr
 7L7e91g9sROJOYgAAAA==
X-Change-ID: 20260314-dp-connector-hpd-f069e66bc6af
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Sam Ravnborg <sam@ravnborg.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1092;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=AzG4tybW9c5dexxKKqngLGPODj3vAIps3J9PzES9njg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBptK8gUm/juPxR7fDpSHZu8IOYkY7MH2+G45qNi
 ryL0aADoy2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCabSvIAAKCRCLPIo+Aiko
 1QOxCACEqVkUSl3oiLUb5vl/lOfRTH4F7rV1rfoK1O/DwuVxqkJ5LdJ64qcy3f27aCVXRJ81xkT
 UVdHu5R9hcoXAby7AWsUtvP3TXpkiFlcvpfkdeb47REEseGgtv6U7PKW5736uWZr8WPiXz/3zu/
 Aq49CyOuMQxJ9wJBeHSbyeKoHS/9FKK2xk7Rt48qfr7y9Al7wRVMO6w2s/Qxyr0EMlmvJnjRQ9l
 iJ9NZSt/+mThOyD41k0V4ypsryc3Qbt8YEkZNM0N+j++pEqFTnrja1f3xiFM7uoF/CrFIg6D4GS
 8rwurjmLyqTvjVchYwJtpIfow8jup2djHRqQuyvSsK3M5oud
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: iGeuGXjAqacSZ-V-5zcO5BAXgUyfh87Z
X-Proofpoint-ORIG-GUID: iGeuGXjAqacSZ-V-5zcO5BAXgUyfh87Z
X-Authority-Analysis: v=2.4 cv=auK/yCZV c=1 sm=1 tr=0 ts=69b4af25 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=QdDM1--rjLhOk84JmKIA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDAwMyBTYWx0ZWRfX8D+fRr/bBKkx
 dJJAHEHplNaIxyFSqlsibfZJkN3AM4gyX4jQgxf+0AWKf1L1yNZibvcVa+S2jBvRXAkLswMAQA/
 AdnuTiy7Jk6Y/GWUf50Phc0Jfw7HUJ2ROcUAAV3nw49vxOB7ObY+8k7OOcFz2Eafpa0M7zihvl4
 HdnlKA3iNvXT8GNdkj0M4SjRJI/XbxB4um4A13k0sApqr13vT41Fhp5ukQN+zEw5ruPHgHZOLGX
 aYSCjHEB6lAjXCq6TjU4PTu/pd9E8lndQO42sV67xtaEKAf7h3etFKjv/UzLfbvF0rt0NEhM6Tp
 fx0Mp7ZlIZKhFZWyguP3b0azSMe3tfqUvR9xCVG0diG5NTb6u0CqpO4xCP4zdYeqdcBDZRbTWDq
 bxU3zlL85mY42mffnHIF932tXcYwbA7pIL4D0R0ktsK1qplNJhI/0f7Qk6BBUgoot4uzMBtdMC7
 HKJsvuf3CO9Fs9Uh5Cg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_05,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603140003
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

Unlike the USB-C AltMode handling and unlike the DP controller handling
the HPD on its own, if the display-connector is being used to handle the
HPD pin, DP controller might not be able to get either the HPD
notification nor detect the cable state if the cable is plugged in
before the system has booted.

Make the display-connector send the HPD notifications during system
startup for DisplayPort connectors.

It's typically not a problem for other types of display connectors since
there is no special procedure to detect if the monitor is actually
plugged in or not.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (2):
      drm/bridge: display-connector: don't autoenable HPD IRQ
      drm/bridge: display-connector: trigger initial HPD event for DP

 drivers/gpu/drm/bridge/display-connector.c | 36 ++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
---
base-commit: 5c9e55fecf9365890c64f14761a80f9413a3b1d1
change-id: 20260314-dp-connector-hpd-f069e66bc6af

Best regards,
-- 
With best wishes
Dmitry

