Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965CDCC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52538112232;
	Thu, 15 Oct 2026 08:59:21 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82CB6112223
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:59:07 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F3xBA91640485
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SN5oCd+hB1kN6I2RUJR2/JZbM+ngr/PeEqa7S6xoQS0=; b=cf6dno0ecdLTK9C5
 A9+Xyr6WvOyg4SDyK5jrG8l6nCbmLIrxkT4PaHQ9Qogaiq4Orr3F3GXJoRU2MUWv
 f0ia+l61o/NzIyDL91yxDby5fVZlV+MneZA0ZUq6+N3IRDEw7nAURV5mcw9ODL62
 iiFdugaMtjEOFXHhS0QDoe5rUUSqoetFPJev9gJ8dhz6KNLPhZ6WiGMDpApngRp5
 ebl+O6j2b64DGNetsYads+vF8RSpc5Hk9tqPiacO+xGJnVNon4tZvYBD291tbg7A
 Lp/R/+VGZuneoQQTf0D+dJGpSkrbEHOXelcipNb8Kl6WYqbi/RdWiF6dhObq3653
 t7p8GQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqdhh5vh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:59:06 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93e46b4b700so224093585a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 01:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792054746; x=1792659546;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SN5oCd+hB1kN6I2RUJR2/JZbM+ngr/PeEqa7S6xoQS0=;
 b=ADFTtMku10xkRcLlpa4Ty6beJs9X2J98q4+eTBvkNMXFZjva6P+PK4xxAgY6zLdCpR
 /M1jztGZxlnWDaT2n6SiN3JzWvdlbDy1GB+doxUBYloIeEBDlUes4jIBJY0z8bk7gMBm
 fCh8f+L2W1nD7fGjh/jJ5Jmi/w46/v0emDj9iQ370CtmtboMsCQM4ozfbI66jToxOcHi
 8bHyF9FZHxEHOuC4tN+CZQ0ka92/Hi443mdL6wWgZlr8kMCY0tIRJpLnLMRDWK+nPyfz
 +zBO2gRIFtBeyqsGiYWU/qCnGgYKAR1kfF8HBZbufw7eC6lYI9hWWgyTjshyxF4xi/SD
 Ietw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792054746; x=1792659546;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SN5oCd+hB1kN6I2RUJR2/JZbM+ngr/PeEqa7S6xoQS0=;
 b=SwUAKvhhBJZSRIub+tBW9lH3dIYZRtcGfjeNwqyOROIWNN61P+gfCs74Y0W6R9x6kS
 /b/7uExYZTSUxFi349IE/oDaVgzxvhB4C/WDx26TtetjFgPug5uo0gwF2+8l5MXVPszZ
 mnKiOL4rPfyj/SnmeGw3KM3S1ls/om7Lr4JnINR9kV/CekHexDC+cZdjIwl6WzoLRcep
 E5TyAKNP/srS6b5avWLVir6xCTt6oxvI1e4co/2P0bm1i1YM5G1UF7aV01vM5aqlMZTH
 CsKG46lxFGybbuLOMw9pGZP53ycI9NZx8soZamw8zztD+ssCSWO2kjnlFlfg2kAnVM9/
 4BkQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBydz9jXpheaJrPlevSfwLMvwT5+LOpwcfuqCW442k8aj8MtEaQ+dPxNpdtQuK9mvfSQdHGWonQT0vo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKZaS6HQTDitScfmNHNiLkGfXaCgYBe4j+xzdPskrDo8L1oVeqb
 mUr+x2U8K3IIo1idV0ui831z9GYl8VY0XFExp8xsyTybwPRADuvBxeHf2CjuJxf2wJMcik69onQ
 tQFJ5P7UAjbeJkUZek835fANmr+BnQ4Dqpvt1kogBWxohteUXXGggzN1eVFYht1ruQJsOyxc=
X-Gm-Gg: AYBFou0TGzbVEQ0goh41sa484aKzTWlAA490CtMUB/KxUCGJJsOIpoyXwEIH5/6soln
 88MMREWnTaiDXrGcmiihbyEN7fPlwg2c3pFopJVocFRZPt9ijXgRxt836CkxybYdgvj0Ac529dG
 5lSoXUVcSdDHYPKcJnUSDupWyvDjyuj0tCiSw2QT5qKOv6gWDlqTfqQoghi/xhzXv6wKjkM4OyJ
 u3ec+lAhpIgPdBogScay0jYe5NKcjEseKtPIZ5cK621Q/oJXr20hVJ5LNfXKR49KC27xBzI7PxQ
 keMClqgJDwiHNt3mWi72fO3Nw2IZY7XoXibrEa64FbJXA7V5W1kzGnrccncAqA+db2yAZwWTZ+w
 +alf2GgHZ5aYVpEeRVVEYr3AxsSKVAdP+6gQyS93CxJp+SG5+gZrAXmnzVhBIZz9cNU4hsStbje
 CllLrlU38B5TW5
X-Received: by 2002:a05:620a:6489:b0:93c:6f06:8f7 with SMTP id
 af79cd13be357-93ebd20830bmr2693240185a.36.1792054745922; 
 Thu, 15 Oct 2026 01:59:05 -0700 (PDT)
X-Received: by 2002:a05:620a:6489:b0:93c:6f06:8f7 with SMTP id
 af79cd13be357-93ebd20830bmr2693238285a.36.1792054745505; 
 Thu, 15 Oct 2026 01:59:05 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be3b51fd1dsm371590e87.58.2026.10.15.01.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 01:59:04 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:58:45 +0300
Subject: [PATCH 8/9] arm64: dts: qcom: sm8150-hdk: fix FSA4480 address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-sm8150-display-card-v1-8-5c14928cef29@oss.qualcomm.com>
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
In-Reply-To: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=993;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=xBbaNwaZ04U9vu5xMLAzqewhXtCtgpwBmq9365lh0RI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq0JXHgIL+ILyWEGstfQf8V4lw5nKNfZbOlQ6Ls
 JoUbd46i3yJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatCVxwAKCRCLPIo+Aiko
 1VJaB/9k5Pu4lNZ5NrTjERYf0kQUmOOugVGCg+f56hXaS9WyML/RdJFoZSw1QgeWJdCZU206QDn
 TEmCrYkOuwLEFluHrqIzBvAZXz/Fs935E0zcQHI/E3uR3ISKlqR+urAmffPXe5Yb2kVytPoGLfz
 WNz/6sJJ8FHkVKmYSiGECHcfOVbvoR0FnJfwB2bSUBpqScPulDIKRQqsy2r7sRaSrMuwEfoZH2o
 LCSMuO3uBfZzwtmMIirwn4v3lLlHY01VYpGnxf65IOu+KBbqpyyb3hxnLwtpZYQEnguJ9eAXq1f
 fgsVo5CWGYYnPYNKZ9s5OLZztUyf9lJY0mi6Otj8qWRp5/QY
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfXyUpawlILNr6j
 9LG0ZiW0HQW0AFTmY17sVzuaAKKmZ5ZJHWQS33n5K/8RPmRBkEO2qhNlqyMyqXXKeRbxieN8nzl
 uThm2PqlRyi5pRF3IfHmhs/SEwpltXA2Bk5Alf49fGpcnmACGpSP91cZM18EqNkPPUl/Sk/VkhT
 X9VzZCOM6tVoUREB5pHOdewjNBrjhbzITUblXb4Da7H7hLF9plL97/v3NH8xLJVeHZk+r3AvIIg
 CoEjQJraSljPDzn3JD9AnmtiM8bYMDgTi47tMXICbgZVbNvsAqzTZnT5e2bZmyRqwFrjrS42PvR
 aAD1JVfyZskeUH/hLlnG9KgaEfRlbNoMrMAvIQH/T9WdgZ8bZk7WI2u1zqQT31nJ4FQTG9JEiaz
 GcD3YCQWVcTmMwFmMJgH33kjMAqP111W0CZBgv4YOXnz4aYNVNSUD+1eqWQ7/2zsMwEyUqBYvgv
 tbLMVR5F86vguy+cGMQ==
X-Proofpoint-GUID: 5n7UwLQbLBEw_wztW-8KgUK1fv3ByFOr
X-Authority-Analysis: v=2.4 cv=DeeCOftW c=1 sm=1 tr=0 ts=6ad095da cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=LxeP0AzRrgEWglGlbvkA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfX10dOhgWFkeuw
 v0SrM3Lrw5HdZzoq8NQBzhpj2yOTvpvkToH+uSQ07rgPB+TUKeWptc3iHYH+lvVNYK+d7qeeCT7
 GcFch/Czv0sRPqbdkzZxe9bByGDHrsI=
X-Proofpoint-ORIG-GUID: 5n7UwLQbLBEw_wztW-8KgUK1fv3ByFOr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150035
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

The FSA4480 on the SM8150 HDK responds at 0x43 rather than 0x42. With
the wrong address the mux driver fails to probe, the Type-C controller
and the DisplayPort controller keep waiting for it and the display
subsystem never binds.

Fixes: ba712fd55c7b ("arm64: dts: qcom: sm8150-hdk: enable DisplayPort and USB-C altmode")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
index cdced5c848d3..8f4ea981bb89 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
@@ -434,9 +434,9 @@ &i2c4 {
 
 	status = "okay";
 
-	typec-mux@42 {
+	typec-mux@43 {
 		compatible = "fcs,fsa4480";
-		reg = <0x42>;
+		reg = <0x43>;
 
 		interrupts-extended = <&tlmm 152 IRQ_TYPE_LEVEL_LOW>;
 

-- 
2.47.3

