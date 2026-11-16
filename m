Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A5E606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eyEHU2yf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QcU32WWn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A894110EF8E;
	Mon, 16 Nov 2026 11:35:19 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 887E010EF8E
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:35:07 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGBLfkY918722
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:35:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A/1SV1MxSZ8LEB+jUbrljc+qxkLslb4ZlD6gjwnwhJg=; b=eyEHU2yf3na2RhgC
 zBGWYyi1hbO5ftFunLalAMAcb9qmCmqj7nBaYUt7RVVVVa/iytA8A5NEznMYqXJn
 2tV70Qbny2L15v0IXqF2CrwDpJnR3DMBvY+CG7x9vbK+BSKLsfOUMqTW3CpWdjUV
 JK10awuN6MznRdIjoplOYie7mwXG9JbIkMVg0QAq4PCxwFynQjizLEtJUuuw63m6
 CQrysqwfx57/zictEzYYK0tyUk+AKA0DSpggjoN7KnvIlVcoRFf7vLT2jOuC9ZNH
 YSJNkqLhMgk0aW712RFr/NuO9TFzhmXzWrjtIjHWsdbnOw34tPxEQ6LJV0mxWtdS
 1AEnrw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j000g08du-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:35:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2e942b1cc86so30473405ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 03:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794828904; x=1795433704;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A/1SV1MxSZ8LEB+jUbrljc+qxkLslb4ZlD6gjwnwhJg=;
 b=QcU32WWnr77cvkN1i9edknK51qJ86cOiwGYANGVNEfSSyNmhP4PFKvAOguQtm5pa1Y
 p9hnnOJeUL5Oy3DYtz7Sv1SYw4thBaEd3McbeiZByGtsUB8ATvd8/M8impl1okXQnK6V
 TYMJpxXSb/VJUCRcOFr64Gje6hUMfj7uzBjYgYbVSB6VRJlrtSku6UUDSvuuw/LZuvwy
 TuUkoeRMDg/LoE11m53hSUQLEkx/wDIRA+AojamWWjyq6gww36Gea7HLazIZi8zSKl21
 qLKmYvoN3vGFxYVws63HcOH9k2hvwYcY1UzTRqe2EiY4k+VUTReTKX6yHSvDmnutpVRf
 tVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794828904; x=1795433704;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A/1SV1MxSZ8LEB+jUbrljc+qxkLslb4ZlD6gjwnwhJg=;
 b=TLWUmW09NA+WpfPGMj5NMCLyIwxOHT+hjY0/u9CLPZcaATCXSShH9m7cKo4gXy3XQ4
 78BymblHHrPmXzV/LlCNdcHn3woQN7bNL4O22q89Ygu6ENuU2MTqx3x41YwLs8DU/npG
 79xTO8phYWM7PpuBx3DEaJKZr/3li0Via3McE9YkqMAf6vKKcXPAvrUHkNRmB94YZw7l
 SxxkoSiWVLc6SZ5Y3aHj9m1Pog864dPbr8PEjCh85hAQ4DgAUEvN8UBECsGzbdsXCjlu
 vy3JmcIAzGcnoHPaoZW+2h+G2w2lnipbUD4OM6jtxEFufe44ZACMuMIGhQXxd2bIAPiC
 HW8A==
X-Gm-Message-State: APuU4Z8a3SwRNaMVGTtETrQuHwGL+H+H9N9a8o5KPolgWfGei02K7LTw
 Dk8O8B6XxEizAGQ1CDlmD0ruqB1OkoYO3JmpU2MVBkFWxnArngpCryYiLrNAh7XF60Vi/ptscpd
 PJg+58jaSt6/fMCVRWL0CErk2qiUmPT5NeJlGJ58y5WJUyaM+PDy1Z9QRYXtNWQ/d3rIcqChex9
 NGGJY=
X-Gm-Gg: AZFdTZeuZXlJE8U6U+raBh5Slfe4Fi9ElgvItJ7L42GaEBrezPYSjmni5NUjv3aJnBT
 tHJHm93/WY/pG2130uzzKte8N4ACayCf2cwJKmFXM42LOOKxWuTpRhskXMlGJSSlM3u9fDpzsys
 ZiZpt95TG0ijr1ySAYX7AE8M/sJzfXxnAU2ugXFVRzk0UFodxFqKrFcs1hje8TJBoehlRqycqjP
 eM05JLc0lfpnxHCvst8KmGDHPPq4O5Xt62XVRD7jh4+xBZBTOVy+W/vB9D4/LikmodlMwM1Zgcc
 dF/ytKZyAIfaYMU5M9MmbPQMpeEq8wZO7FFyDz2OtAj6+8s/373BW0g7UsuQRwcg5/+N9KJ3yMB
 rsethmfJLThuDkwmqKfyQP97IWYEnHok4Lf6O4L4O4aB7CJZ/lr5kBDyZwbUezfGjO2j6xzRPUR
 Jy
X-Received: by 2002:a17:90a:fe15:b0:3b3:7759:d2da with SMTP id
 98e67ed59e1d1-3b37759ddeemr3746686a91.5.1794828904518; 
 Mon, 16 Nov 2026 03:35:04 -0800 (PST)
X-Received: by 2002:a17:90a:fe15:b0:3b3:7759:d2da with SMTP id
 98e67ed59e1d1-3b37759ddeemr3746664a91.5.1794828904067; 
 Mon, 16 Nov 2026 03:35:04 -0800 (PST)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197d27d26sm21000719a91.13.2026.11.16.03.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:35:03 -0800 (PST)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 17:04:06 +0530
Subject: [PATCH v2 3/4] arm64: defconfig: Enable the Parade PS195 bridge
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-mahua-hdmi-v2-3-0b5af6bf9e70@oss.qualcomm.com>
References: <20261116-mahua-hdmi-v2-0-0b5af6bf9e70@oss.qualcomm.com>
In-Reply-To: <20261116-mahua-hdmi-v2-0-0b5af6bf9e70@oss.qualcomm.com>
To: Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794828874; l=763;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=fqWr8Q//GUQkrbwoURGIWeM2InxPizQ4dIjubj7qBVY=;
 b=8QPxyxQOJYULHOVcD2ARScmoOhA2lkvadsuW5o6InSmPFE/Ak0Us1rCaI3dQCZ5MRY3f47FNF
 wQnwbBYgAJ4D84Fin48a13qJzMly0DIUOekaXQdAKrSeTsWDdmesn/i
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA0NSBTYWx0ZWRfX5cuImEtlToBi
 KHt+w8ckeYcUYsRYlgU28o0dNQ728q7PQk2GRitgonS0x5Q+IgDLlEYVrg6Y3BH6fkc31lUYE8C
 fcC/4X/uLP+IXjy72uHuMYby8MwoEo116aUGZB2D2WoanyZ0EkpaNnqqGLWoWxieydvt8gFEm2r
 VYO5oa+/kkRBXPaCLh1aKS68IwlTafjG72g/0wBqQUvO2Xm4yUIvm//Tm9Ai8OErGpd5S88AK2V
 baS6kzgD5zHn5XsVDW5nMrzmQfCgmMHQvRnmZczT/2Scy2p/rav04yz4Lc72zZpDs9PvsuAi6IG
 CGhCuLwk7o7oLFlpVWuhoajd1oXL7rUHGKBsuP8X2xyR1qHeimNzC5RqkFA9SkzAxP7m4HnYWI3
 wJL7spX/QPFtH4Uxo8UOS/Bhc/rTyL2QhF+wEaVBUldNUkpHSgpPWC9cusB2MnZMnvMU5VGyuMh
 8L8Ri/7WHj92sXBixiw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA0NSBTYWx0ZWRfX19DH5Yd7CLNW
 Y/3u4ra8hSS0silQTENrGvPt9io1ANAelE+r5eU7EaTG5LHGmW3pi1iyLKMKmbPkm8saxY3IoHi
 WUYbyDV8MbbJ6xktYPHYqwHbri6fyaw=
X-Proofpoint-GUID: Nwke2tBm5kJElEOcNjCcsMuaRjSlBmhb
X-Proofpoint-ORIG-GUID: Nwke2tBm5kJElEOcNjCcsMuaRjSlBmhb
X-Authority-Analysis: v=2.4 cv=Vdtir1p9 c=1 sm=1 tr=0 ts=6afaea69 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=9THlnupo0N1hDek0eNUA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160045
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

From: Mahadevan P <mahadevan.p@oss.qualcomm.com>

Enable the PS195 bridge driver as a module for HDMI output on
Qualcomm Glymur CRDs family (Glymur/Mahua/Kalambo).

Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7b4985b29b21..69db247447c4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -984,6 +984,7 @@ CONFIG_DRM_LONTIUM_LT9611UXC=m
 CONFIG_DRM_LONTIUM_LT8713SX=m
 CONFIG_DRM_ITE_IT66121=m
 CONFIG_DRM_NWL_MIPI_DSI=m
+CONFIG_DRM_PARADE_PS195=m
 CONFIG_DRM_PARADE_PS8640=m
 CONFIG_DRM_SII902X=m
 CONFIG_DRM_SIMPLE_BRIDGE=m

-- 
2.34.1

