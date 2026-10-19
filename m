Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA332CCF2E3
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 11:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 386E510EBF9;
	Mon, 19 Oct 2026 11:26:21 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07FA410EAF3
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:26:05 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8Oqm23256584
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f+pC6oEHMspVu+VNo8HMZcCwsNZGyw7oBC0aS0Ct3Os=; b=lyDi0r4HMJq2W7KL
 AtWTcVrV3xrBuJMST0C0Vam5Rt3oRjCNOOOVwAkBN+tb1IYyrg011pvsQx2BMLra
 xrltTuSiomk2ARr499rSnO9gdiXbli98XchqYpHhkvs849msrt0DTVMfV2YsjcQx
 kvAkDVhGwlNx1qXrh1yYqKzYpFtKHshKxfMr8stTEy9LLSzjI7TMw3n3FdJEVPEr
 jZCaHJL6NvUvxp4EgSZbXWQLn69t0I/yu0GfaFgCy3cR2Gvky3rw9cHgw2F6syXa
 psa45iPGm9mrOa0OM2xQj1Tq9kGctJ8vLWvMwhZKv/KqdwzHD6q3dgRvYtIZAv31
 ow4t1Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3f8tkr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:26:04 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-939c30aa9a0so211420885a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 04:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792409163; x=1793013963;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f+pC6oEHMspVu+VNo8HMZcCwsNZGyw7oBC0aS0Ct3Os=;
 b=O6UopPl5fXp8eopdkFY0hH+9d0M0RLYtRE+MagSaYFKERfebZA3l7bnoivg5hYEM0Y
 KtJGWGRNT3pwrz6e/08IC242tz5A8wdi0Jt9nzWf3UPuuDfsd0ztxLNNa5rt0F+NxREa
 qHRSv0UN2GyHIcZU11Pwhl0s0Rlmufy5mP9cIaIiMofF4f5VUMiOuHfFw20FvJfan3qX
 uwb4VmJ9SG32uq0JjGblCStL3uYY8K3yKcQ5VZGTlhkKvwBSOTnr+5oBMoyIVCx4UW3y
 0/o+/v6wPvw+wJIe/haVWHA1qk2quhSYyxBzxezrjfHgCSJoETz2Thq4igUk3uWb6dpD
 oNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792409163; x=1793013963;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f+pC6oEHMspVu+VNo8HMZcCwsNZGyw7oBC0aS0Ct3Os=;
 b=DmdzSS/+rfpPSiCr4inMMnAao9iKrrYiV+oDdr+SphfPTBPu9A3IjK+KcPv8Hcg5ok
 CJmK1cJDUm2Mo/dcA8MjoZarZX+E2ctSFA5R5L00BxeGMeXXwzJ/I1IGV4VrU39GUVQq
 dXHQibZtsQXRSOEXto97QDkXpNxDNQun/7Cv7BZYb+xsNT7Pn4+L9qVEpcJmbPDFqUg/
 mKfzK9lz+fc0PP2soGIHD/LyyeEzBQp1MIqPdvQU5jcjGBPH2+gsFHWrqR4+FSQhmMZX
 m68X8GrEVYHicNAEa8dy0HIuTCzBdV4FGkT6uSt91tatDeJkGxpUMJHFwB9I6Fe/Qled
 YBfw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzAljCUGt7qFFFxSoHchdt8wBx+KRkEdrifTDDaGleWu0PRloy3ydJGosZ5O338t2vRthc+rU90XH4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJAkMpGd4wFVIeojt2Hke6zAr6GCSPLMuC0ivBYbw0p9N6byXKT
 Q1yZjzIl8kxIENRIDiKzm67d04ZzoKLWdAOjn+0h/ByxFiOzy5R2DDVcKDHU2qWMk+Lc/Q8+De6
 ln5CPFirchu3pPqK8RHG4BPHjfYr6LChOpRVk+Bh32ZBgMAW1+3C3eeCceO72ymo8dv5uOOc=
X-Gm-Gg: AYBFou2/x87V6Hb2AGUG4RbClmsPig4lRTmgbWikiC/BRVdW/rmm2jPc6t3NdQlN/Wd
 TPa9qq+1cud1PFGr//CGfnsbvTalxcF/Eu/ZekxGunlVa6Yvx6wOCXczRXOOEl8CTRmq3AJPZrn
 t8buvukhcqgzdK2LO2TBV/wVtdOfYEaWyUWt73+hZZIqmYpqQYO/1xLWYMO1G0jYWnyQ3R3Bpv1
 lsUuPkuRfH3gmRboJSkP38fzyUEwPDss3vsZvGYMl6QTXYeveq6esL5PLHsyXNYU7dRVTEmz1Dq
 qmHlqz1a81xUm7qnngb+h95lZBpHpyBm0RBgb3CthK5mPEOh+scoOK9SW7pLjzz3YaTZbACsSHu
 ZAYUD4e0CHzn6NsPR6iS/0VnLnaORJU1fpP59kDwmsK2ATaYAk9zsT2pa7gvr657EvY5aYgfdrB
 dr0XPuGo3ofY69
X-Received: by 2002:a05:620a:2613:b0:939:b8d6:9b1c with SMTP id
 af79cd13be357-93f29cc8bd1mr1257985985a.19.1792409163408; 
 Mon, 19 Oct 2026 04:26:03 -0700 (PDT)
X-Received: by 2002:a05:620a:2613:b0:939:b8d6:9b1c with SMTP id
 af79cd13be357-93f29cc8bd1mr1257980985a.19.1792409162750; 
 Mon, 19 Oct 2026 04:26:02 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab37ba8851sm12807621fa.22.2026.10.19.04.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 04:26:01 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:25:43 +0300
Subject: [PATCH v2 7/8] arm64: dts: qcom: sm8150-hdk: fix FSA4480 address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-sm8150-display-card-v2-7-86c05068efc5@oss.qualcomm.com>
References: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
In-Reply-To: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
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
 devicetree@vger.kernel.org, mfd@lists.linux.dev,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1054;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=OtPhW13oTkk/vnq0/hqRzt/x1W323smpeKt1P7yBbyU=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ9bVf9aa1sGyKcnvAnxCO1trIi/MeZqoenHTdJMnsk++T
 DtpXH2/k9GYhYGRi0FWTJHFp6Blasym5LAPO6bWwwxiZQKZwsDFKQAT6fVj/+8YNNdXP6E67qzX
 8V3T2w1Nbm7lLEyaP7Nz3oRpFk6Hg1ze5z7qnh7TpJmR4qOtXBCy/aJO83FWtzltO8JMJCyPyNx
 uO1p/X6UqoiqBycJzC7vKh69JDTLCir0TBMXOxL9m8mvN3dwbKhiem6Duwp/x44XBnJre+U36Yc
 7Xb5xI5Zr2ar79vnav3WcXlE6WPu2T3nlC267su5FO2B7FDxync22jDx6dnfalludzrtGHFUcK5
 vPwCx6/aGHjxL5625a65jPfOadZnHCeVzeRT0JkT6+qbDdHZW+98oNPE30kZY/dZtJcf5NNWOFB
 aUsGR7WC/ZLPqRUhs1w+K2qb7C1eK+zx6tcttb1/jmQCAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: vJNCTswNyorLhjD3tuvCPHQkLxuLwqKv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfX9R8rAvhMyLXJ
 ez8e9uns/IG3mD3GLbXcUCifWt9RpjhFVRYlexlp/VMU+8x/3/cJsDiDDSppSm6qLecrxlMI2rq
 s6Zdv1NtkZLuC7h924ni3nYqaFwLAtD7ECZa5AAqW4QjA/F1Qb1+pm9VyWoKoRjDYTfToxMWfjX
 R5O3jvIaQbH6zRSV0k/gZ6FYCvatopjHo8xy2WjeqhrIyQQs3PoW/VKW53oDhvNGDHsQsg+UrPp
 35lG+VX1Voq01meWn1AIjFU75Y66GmWI0SPvnnhI4B1H+jZR+JP17wZPuZWV3w+xjACURh+pZgV
 Lc0M7dr6jeeNB0YBvouIQuL8fkNLLPszESmp8LTho7ytoucaHVC7hJmYibzxVehKxbfB1Dum+K3
 aVZmKycOzqt4m39ifno+ghCsHg0XRf3WbGINk/dP7ed1DDMeZAoUMaXMwDYJDyO4JYMIkpk3HbG
 qvejZuk+ixN3zU3WpVw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfX47xxPkt5x+J9
 P329wyit6QTeJKtikk9q8InkNf7LaAyjRpTq/NlGpEvvbpIfR6grOl7tBwjrXK16kOMi5sm/Kbr
 l+vl2m1/5uMx1Z8KtB6KfW8jRPCqyok=
X-Proofpoint-GUID: vJNCTswNyorLhjD3tuvCPHQkLxuLwqKv
X-Authority-Analysis: v=2.4 cv=OaANnRTY c=1 sm=1 tr=0 ts=6ad5fe4c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=a8YgrFIUZnlsYaPg6kkA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190045
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
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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

