Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48F7606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 06:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B1f+FXkv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YmbRrsLS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 027BB10E222;
	Sun, 25 Oct 2026 06:48:43 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74E8C10E222
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 06:48:31 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69P4suYl3577485
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 06:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=X4mro5Ju+0/OZNa6+ydVcS
 k0tnNUNnmhCi4geW3t7cw=; b=B1f+FXkv7WIc1WX7NfQd2k+7LDtBtPw6hPcMIt
 uW6H1dkF9SaIWgTkE1hA1ujDe4uygBWA7cvg29F0TU8Jere/U8kuMwWnDmT8bn9Z
 Qgzv/LAYC1sK7SMYsfAirdS37PjPbqRDVDxB0bTAQ+iQeV/ubg17HQcLJqZ8oz3W
 oxiOcLFgsrGKc9PHZ8QIoU9QqI5yx6IC0MHF/KHXh5Jvm1TQ2yZ06G5RrAbiHgJY
 g3+wUL9kDSAGxZ3X/m2Zgwbn0SjsW3iXJ6G++7baLJD0jPtEwj7zVAlRJuFXt0WG
 TH7Qot5Mgqz7AAYrXC3hpIbo7lMY5vYWiSA/zNv2x+uFg4EQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmw3jjw2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 06:48:30 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3663d3547a0so230665eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 23:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792910910; x=1793515710;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=X4mro5Ju+0/OZNa6+ydVcSk0tnNUNnmhCi4geW3t7cw=;
 b=YmbRrsLSIzesBXPIfXqMIyuLXS6GlfEzm+Mhy1wPJoTj9Qg9JFPK1YSen7e7jnxMzh
 rq+jc+cfy+VOPs9JAHJLKHnnW75Q/Q7V373abdPvYRgQi07g4tVwbc13dpPwhE6rMh87
 NkKzLGYID99wDcWu0R3zXEmnLuDN7E9UJyFMEJaSavEhfEPItBKXn1AHZIKm0txU4evs
 c96/trR0narMznZtedtohoS65hp47SgVnTYVyMWWfYEKBL0PQ75VMamOKn3Hd1IgShPk
 gB1SrBrq5nAb9sWV9xF+L5fwcIvGu8fpDk6Z+vfZzqSphL5zEKEe+qrQ5Vr0LsvsVrQH
 t3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792910910; x=1793515710;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=X4mro5Ju+0/OZNa6+ydVcSk0tnNUNnmhCi4geW3t7cw=;
 b=MXN410l3QPbi2XKDVKxOZl9+ezW0HZoEyzc0942NN2IDV4B/9sWTngLhMVk3dpLWyw
 hnfqRmUOGwwgygLqLcHByDN5PUrGlT1fYaifeB5UcwQSihxlG1DlA/R/y+gyr6WdKSBs
 REQWXs0CrvM4puwNSEqHOkT7zkMiFIqth7aPjYnY+dAuhRn2pkn+NuGFRA+TNPFM3x8x
 N8eFOgpEeoOku/X1TckWGq98vGf9moPzONQTSEgiI0/uP4+ehavJjSOhyy2TjoP4riyj
 wy9SFjBWY3nxII7aJg/RORXYxy48/LXXILoknt5Ixjd84bCKETO/FAl0xpLD1Mqn5sif
 z9lQ==
X-Gm-Message-State: AFq9FYI6m6Bi7sRGnBy0IquUGKiNevlOisumTPnyK08bas6x0xkP4Y6A
 elDF097inhxPFbQYv7DPiKtRjiHZsgi4coxCT/i0hd5fJXhu750rrKdVjPSFVGMcwXA7lSaBH7c
 6lKfbuuw8Syoyb5btDgQPnYeFuZSWTa4dIykonKVcIm8BVV6IrZmOQjGPzkwhPsmxfJhqL6w=
X-Gm-Gg: AYBFou3W2rdO+1+lYVwHBBMSccD/5+1zbAPhm4n98qSfo8VID7aOdcjYextQBDwTBOJ
 HzLJJR4FFqXseFFcY4Fm+2topP1i91Yg3i6rg+262/X4QRLw1WdmVVsR3YHEV2MDiJAfwuoB7EP
 h8sp4cTZYH4FAKyjsWQQwuOqOe4dCicmFNrqPsPx+xlp6iXomSeYYug6m6LTCix4NKGSiFj//YH
 6Kbi+QtxFqK9FHre8Kol3OrZL66PyvakCqXEzYnETx53jVdIA2Lf1gijr0/nmr4ORphU3KzmfXo
 WilghPIOi+1YPRm48vDsarPpqzmp40eKnaofsGmaMDgUJ2mzJmDICMV7zYLUVJztiHJzUy1rdCD
 01Yl3tHQajaMPo+Dm20Cd4KSClljHBPV3M13rBjbvWIdqxjVLYGgqtsgO9j/3qZx2C5j1nqUY2e
 8LHJtZS5rH8bXkKsa9FJqXYl8YEOmt27olDRMKf1wjucQXJaU40zHh
X-Received: by 2002:a05:7301:19c:b0:368:1f8c:5f23 with SMTP id
 5a478bee46e88-369e821311amr8345556eec.0.1792910909978; 
 Sat, 24 Oct 2026 23:48:29 -0700 (PDT)
X-Received: by 2002:a05:7301:19c:b0:368:1f8c:5f23 with SMTP id
 5a478bee46e88-369e821311amr8345520eec.0.1792910909428; 
 Sat, 24 Oct 2026 23:48:29 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8db7e73sm13649886eec.20.2026.10.24.23.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 23:48:28 -0700 (PDT)
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
Date: Sun, 25 Oct 2026 12:18:17 +0530
Subject: [PATCH] dt-bindings: display: panel: ilitek,ili7807s: Allow
 backlight property
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-dlc_backlight-v1-1-1d1c49c3e101@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADCm3WoC/x3MQQqAIBBA0avIrBMmoYiuEhE2TjkkFRoRhHdPW
 r7F/y8kjsIJevVC5FuSHHtBXSkgb/eVtbhiMGjaGk2jXaBptrQFWf2lCdEhMnVLa6A0Z+RFnv8
 3jDl//RLYNl8AAAA=
X-Change-ID: 20261025-dlc_backlight-c00d00ec8f62
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Arpit Saini <arpit.saini@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Vishnu Saini <vishnu.saini@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792910904; l=1110;
 i=vishnu.saini@oss.qualcomm.com; s=20251113; h=from:subject:message-id;
 bh=KEjEjjiW+qz2CFMhiqwDXwGVoBcaGxFwtK5Yh/btD6w=;
 b=ylj8Su/xsVS1c7l08nNRZ+V2yiouVkhZg1jT7eGaGd1z+hATN4BsRBfwWI817ktPIOmaDohGF
 AVCrKxZAdVVB8JVubT0YZ2dpuDFX2fRBC/RFywHiADGjoX/5Coo8lAz
X-Developer-Key: i=vishnu.saini@oss.qualcomm.com; a=ed25519;
 pk=8hlXlF8j/3GeOaDK3w2LYhkv9FanCQru0c7kRH/It7k=
X-Proofpoint-GUID: UM3xkxIBTDAPQMogfTFgBT4BcWBC94Ez
X-Proofpoint-ORIG-GUID: UM3xkxIBTDAPQMogfTFgBT4BcWBC94Ez
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDAyNiBTYWx0ZWRfX8L8KxP4a2N+q
 fdC5NxNJiVwNLqFLfj0pTk1a+k0kc2kzLZU/wC9MTY/GHkyE25kzHMe5V4v/T7pxvhC/BpUHG2+
 fXQU8E7/m/4XL/0Q94dV3dQPcId8dbE=
X-Authority-Analysis: v=2.4 cv=HqHjiETS c=1 sm=1 tr=0 ts=6adda63e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=In323_k3SEhDHscflrYA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDAyNiBTYWx0ZWRfXwBohHhZfQDoY
 lT/rf47PeL24jfj12ctg62sFuvItHaa/BnFifrZn7XhBe/zYfBJZrlml4nS2ih55zOeHgIIqMTM
 0PDof3IXsHu0nIxrCeIOGfIhJf8R7rhgmjhI4wC0DczPJiF30uEdBv8kBPxFn6ZrNk8oC57rxur
 j15ETu4zzk3LtOH7BOx+feJBDgZYiWX8nf0sfaW5Nhfg8pfN1IPUBt6dkOW4e9/BxcqI7WCB35b
 +sNbl6bAis1pDnfjju9NKyTRcd9NFv444UI1ME11xJy3Wz0rxfAkTPmdhag37M2gWt/kQFWw7w9
 5JvKyqzb4LD033UWIlS0IGLoXFZSmR23pvGuBAgl7JXm63u8sd2U0bx+gG6nmi7uLlYCitEe7NW
 AoViRWyln5E55ZIdhzyLElNr5Hn4envAcEcEiY35AqLpjxosIegTho4FQU60btcVBLMbi2BvHZm
 DKyccEglXlPo9TgTWPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610250026
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DLC0697 panel is lit by a separate backlight device, which is
referenced from the panel node through the common 'backlight'
property.

Declare 'backlight: true' so the property is explicitly allowed by the
schema.

Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml
index ba8c5bbf8ffc..46b941c18565 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml
@@ -23,6 +23,8 @@ properties:
     maxItems: 1
     description: DSI virtual channel
 
+  backlight: true
+
   vddi-supply:
     description: I/O voltage supply (1.8V)
 

---
base-commit: cf61bef3801c3c9d0d8c39026b7b2fb242898a3a
change-id: 20261025-dlc_backlight-c00d00ec8f62

Best regards,
-- 
Vishnu Saini <vishnu.saini@oss.qualcomm.com>

