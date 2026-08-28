Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED016C61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5022410F3C9;
	Fri, 28 Aug 2026 14:05:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZBfhaVaC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LCEOWF8W";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 264A010F3C3
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:31 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SDkilL038259
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wwJXfsloAAB2Apjdz82YrMfdU41yJCnHm61R07l03yk=; b=ZBfhaVaCZEfk2qYq
 ML9UNTOdC1dOx8kAWqDYk00AixzNQGD6WaOideeHLuvOI+h9hHSKgOxxbfOFi23e
 8otwA5vS15tbgp6/A27Kbi7DWKX7poeM/Du7MkppzH6mQNXlP0Z7SawzXujUMv+w
 WV3Uh/63GjdLkDtVGDE86Lm0E0afZlpRNup6hEngXMDZiFKowvTgU1EAxfK8utke
 f/HhGfcie1DePr5yxCiInJzP/NxENG1LnWZ9S5TCdZw7wBwmw/JNA9WfjMAwI9pB
 RIQRpS9eAfuyGpp/0qOsivnDYxPuTERyepcB9uyDDunjISGuuI54RUkO2JrE3VgZ
 1xbqAg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb8afgtmg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:30 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-97c176d45a2so50058241.3
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 07:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787925929; x=1788530729;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wwJXfsloAAB2Apjdz82YrMfdU41yJCnHm61R07l03yk=;
 b=LCEOWF8WuygcW5o+o/DQhJDnjTGyV4r0Sk+HuhoW0vlsDMbSRngSgQn4U83deBWzmW
 Qyl9JSZHItFVB4cXgkxbiNFaNUhMwDXOW1mVrrU9lgp4crMVeNxYAloYJl37PX/+5GVx
 7EpiNLA4Nuk27+q4qW2bkAt/FkzKEub1Nni/Wqw4NPE3gD3Zo1nVLTqd6tgu6Q5xsVEA
 fr4ifAkPC2K9rprp9lelYAJoATh6s/Zf9ie3Cop5xT2WZ/UU/mlAAnbimDhS8UpHEYaa
 7tihr5mC2cW6sbukjKqkp44vknnjAjEannENF+iH4HsLHfpAyJwBpEOwn9dPypuxFFTp
 v+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787925929; x=1788530729;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wwJXfsloAAB2Apjdz82YrMfdU41yJCnHm61R07l03yk=;
 b=pas0cBxsJHsTVIJ3hhhMPsVCnlmB5sexhgypOL4npl0tcFX8/aKj1jzThMA5MnIyBi
 oZoUHzfK5fg6WKgY5YAI1cFPbGMFHTpHuBdk9M7udVtvU+xxZZEDpkXwPgX7wofT0aEe
 FVSIyBEhjPwe3F+9BHWuh1hJdlkO85uVBvNqniYac75pYUb0sZHT5EKv4EXz/p7GItX7
 zpIKyxI+p0qsbS5/L9OZnKi1JpoYTTvxVFkIhWxoHmTaIvAswXnMeqhTDk7L5meB50R8
 7v/HlQI6fp3euY3a4DVJpZw6ygRfXR5rPMXOBp8ohxYS/S4lAsLI+KsHSEJqZpmcg6Xz
 t+vw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrgMvy+Ds9WZRaQWzEMSVKZF68wwqSHYAWvEzbOkgOz9xXNo6SEYchANboM7xndN+m+y8B9Fvt6Fj0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lvEq84u5/w88kcC/7oYH0katjM+DX/AXWC+sMqxy3UFrGUuY6F
 Swy9oH4R0xNduZZ5xwmDIJDS/DTetGGB/VZM5yqmg65NLyb9DtSTNEXGiy9tGDJ5gJVR68O/mpl
 GXk3lL55tg5wbEselkDk7od2pd2g8Tswl+aJYMCju70GM/+EoA0EhDERdnggNlLeEzyn7c1M=
X-Gm-Gg: AR+sD124TOOcw/cRe/5oJwUhY3J4aB2jtem8jkPdqws/cYzI9ZXXlGK01nyZ9CXQ7Q5
 k9h4IKRD27GkUdQ4whxMu6w4RGzgT3f1UQBJDTLmYZn9H+6gYYstWe59jE+ffC1qktwpYZpNe/j
 4dkRiTgbpMPdercUixHr3ZGFyJVhc2WECfTanfIEiKPioY/BLpvZLSGNWGmz+O52PhfMSKGqHmg
 md5YzZTkLRlXXcufWykDjSEfku7YusxymKJkDCAmb8R1e/EN8L4M0LFwhF2IvZzOJhXtzkug59y
 DTIgrUQgudLdFx1L0FsoUI5CSu/emT2HcRdLkGduVjtsIrc75yqaiAzYfRTrFgNV1D8EYmIs3Dw
 jvllxWd9bv/7StZ6wSs/uRLc=
X-Received: by 2002:a05:6102:14a0:b0:779:e75e:63c6 with SMTP id
 ada2fe7eead31-7859946ad68mr2106164137.12.1787925929620; 
 Fri, 28 Aug 2026 07:05:29 -0700 (PDT)
X-Received: by 2002:a05:6102:14a0:b0:779:e75e:63c6 with SMTP id
 ada2fe7eead31-7859946ad68mr2106111137.12.1787925929014; 
 Fri, 28 Aug 2026 07:05:29 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb20122sm3908633f8f.20.2026.08.28.07.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 07:05:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 16:04:59 +0200
Subject: [PATCH RFC/DO NOT MERGE 01/12] drm/msm/hdmi_bridge: Drop redundant
 initialization in msm_hdmi_bridge_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-drm-msm-hdmi-eliza-v1-1-67843277de17@oss.qualcomm.com>
References: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
In-Reply-To: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 linux-phy@lists.infradead.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=848;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=6C7io++CE3SQq6sBfunNn7UU9vPIt0aJqSBWy3h4kY0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqkZWYBkZ3ElfHZH7luw4aONZGG1TFyP5WiPuVu
 rrHWEkjimOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCapGVmAAKCRDBN2bmhouD
 180qD/9agwFhWzbkDBY+PenlIgFa5fGuW8FDEGsNfrdhd+XlCkdbjDBPnllkZ/J09DczYm/Iy1a
 ++lWEeRO/Y49aWzDmYBf4gD3Ip0bIippizJHnyNMqkoNpBasveavJAwgAuexR0831QPXoRq1XlW
 8VWJexZlqap6O+juK5mOzyEoZtKrmAT7/H6xQK2hz67hJ2UdKwON8qPfnKMjhKi/H2qTVL9oE53
 4GruP9zO4d7Yx5oDDZYH5i39GdKPJc1qfkNNio/8F3RYxrIh7aMHcvcz6m/P7BnJ26IK6ycJDQG
 B5wKuX/lC4T1qL3ADyrwJMWOQBl5Mz2+/Er7SkQP8gpaLVoIUjNp1i/SzTSKpAsqfkXzCyy6T4p
 UEIJLA1GZ6dPdth9R7+0ygwkjQCfqhQM5DSc7bCZDJUC6cKxk7fu5EZR2/TeEP2XXP0wYU5JTwv
 Bcl05VsOqAOhyVoFBwizr8azvUSsq0ags4CeNfemlmsQ9ySNACLsODUu6ln4NELyzp3nCFRfmkI
 HoItvt6InCDWoQNHjjmogmfD4CuUf51QImgUg6AVKjTj3CateCkHuamAM+dgaBUVwb3MqZFUqPf
 h1Y+kaRm+FZF8gxrczhzedIPxqaY5tykIAMYOGoN7GP1qN7m+sbybYAIoaN40lKVSvWlkBiIleF
 zoX0vZjN29TY/CA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: FS0hLJjVHr8EKJzxvldNogJV2RUumT_1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEyMiBTYWx0ZWRfXy/QHpgxrayPt
 vdKVwOUyUywXkj6tRlrkOwt0BkPu9AlavGwpoDlYoUp+BMbtG4Y+jtFtkdlX7sJrShBj5SM4zh6
 BRyJAS20gfojgrRIP3wnTd/U2h5G+Ko=
X-Authority-Analysis: v=2.4 cv=IPoyzAvG c=1 sm=1 tr=0 ts=6a9195aa cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=qMQyP1WGGgURt2cF8gsA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEyMiBTYWx0ZWRfXx2YjvEV61bAI
 7HIG+H+jySl4BwuAc3HITHSxcTi8FGOZg1RQXewJZot54hKMwjRErVd8GqRKLOsDlAyyKJ1UpD2
 uHjJz+HMoFEYcVFpLDclEAQhYykpI5AlliMD/0uCN0hFCFHSetMRlvduRMS5bM67HF9HeKF4XE5
 AsQ6LxkZN53pmL6yjWvXxpi0atqjQ4pO2skaYEU347eTOpa0qb43b7jalQf+1YMInHQ4AlfW9ZZ
 vRBQhGtPzGGPjeHVpRNFtSNYETmCU7783NQMmaj1FqqXgoSckA+2UVvdZ1ZRA4lCCcOg7HPd1kI
 lXwdLF571/KlQnInpNb81+qlkKAV898ZyAOtH8EEykvj+g6pMg12rMTY0zvFBiNKpokSaRoX20z
 k5pcPh1tzmPrmXI9R8Un9D6BlK0C0oT5cTIu5vHLU+b1R3jZIBZcv7opf9BzXfmw73tG7qZYEan
 UVSl1u6Ar4vQPVgO6ng==
X-Proofpoint-ORIG-GUID: FS0hLJjVHr8EKJzxvldNogJV2RUumT_1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280122
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

Local 'struct drm_bridge *bridge' variable is assigned in ~13th line of
the function, before any first use, thus explicit NULL initialization is
not necessary.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 157f19bd90b4..a5f891661ea3 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -472,7 +472,7 @@ msm_hdmi_hotplug_work(struct work_struct *work)
 /* initialize bridge */
 int msm_hdmi_bridge_init(struct hdmi *hdmi)
 {
-	struct drm_bridge *bridge = NULL;
+	struct drm_bridge *bridge;
 	struct hdmi_bridge *hdmi_bridge;
 	int ret;
 

-- 
2.53.0

