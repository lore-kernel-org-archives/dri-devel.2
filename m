Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58646CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 12:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A17510F074;
	Mon, 12 Oct 2026 12:29:32 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6384210E55E
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:29:21 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CBxsef1404351
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=eGh3quRT97rZURqNYAwwWrG4
 NLKQwQ2YdFVSfDU8n70=; b=pgD30gk4CvA10MNw+xGeIRxI1MoB3AfjrvELv+EF
 +evXdgoXWkie1VfS9L22Mm4Sicf5Uk1oibMDOseHqHq3pqOf5GKPVTuvwv7JawLn
 wU4xmvsJftYAmjZwkGHowsJWEnS/60U4sJ5p1PSDFXaZqjz+RaQ2ez8bbKUrA3x4
 FwylRmh2+0rHEHql0KC8/ptA+/Z56eZ+XMT1PZRhQrnAJvFzGcvsZ5+pf2d4E3Zp
 tLUcmKL+0PdZsijMbsFFbi72VMnaUgivEX8TV6UJIpvyCojnH8vutT82OBz+l3OO
 IqgWQFqxz/Hs9gFpFPHymqhNy0oa3CyC3UFpYhEp5Wo7Yw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8v7ks259-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:29:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93909014c85so362228185a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 05:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791808160; x=1792412960;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eGh3quRT97rZURqNYAwwWrG4NLKQwQ2YdFVSfDU8n70=;
 b=AidLjmMnlq1T5HeLct/K355ONo9qzUC/1tvKzJqC+W4RR27tkmxdWhur/8WbbDDhKY
 IOYp9YfGHS6Lblmi7vLJYze1+1HYZALJa1JRzsxyXXz0qnSEdYlovyUcHVS78DmKxd7U
 prlfGU62lAbj3iMfuPKK6hrJNM7qil+HFq+qTiP3j90OGgKFZh2ON4L1AfL31doZ7MD8
 SH9pVgroaLbFPxLw5mA09dIqyFv8Gj36MSx0kNzZ2nd6VNAMZ39uGHJDuWFfAWFQJp22
 xGcgqKaaWKJmRDqTahtOEly1BU3tkISIwLl0aqFSiBbG6qNcUYPGQZWSvU9qPkeFZBMJ
 57yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791808160; x=1792412960;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eGh3quRT97rZURqNYAwwWrG4NLKQwQ2YdFVSfDU8n70=;
 b=0gzutMhg7v67YEyOSPrgh5QOpu9Deo8C8oxZ3NzdZiFCSY7kYNHFUqKBoarwGi0EVv
 PDRSXjiRSkbztvHG81f34D/CZj2exV29O88suqIFM5QpBgJZAkKZheeWe1FvyoKzA/Z/
 f8m8tfpfMhAZGkMrHp+L6lUmFsvcwSqAkDsxlmToBe33Ehjm3gZDPm8bmDaaZb8ucDIv
 FdsZcQmaQBsnzNuYHdhyXmyXzBXOYLtugi6b4LBOdTRYVuXs4j6oIOZqca+ZtLqHJ63u
 DLqR4t2wXWNP5KEPlJ/0t/ll2+wZu6HZZ6Zh0/rNKJxZYiTnVvq3TKScDwWlsXfRziXR
 xGGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwfaCZGeYsDbVuAJunK7UpiUMRCWuqXhVxoqPwrhP8FsfI4XepLZcwZGdqypu78X6ABtqMNrWEV9Mc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJCzBXMf+pExrjSpkoxOsxI06qJ5bg+YOvlc8Tb+YsTrhZSPpug
 et+MlJMT6a4+wC/m4oytGCX9l/OtjNA4lNX1oST5hOPTrRlk3XbWx8qWgb6NOffyzIDDFPTB7h6
 pzJeCTJX3U/+CE2LnX3g7QkDCNfqH1XxJgR8SbaOR/sOzzYigxUpa2Oxkd+hm5+4D2YcusOc=
X-Gm-Gg: AYBFou3b9E0EQ9Fu8MrJVQAzvd4jyf0SwdlYAU89vVNnAFL+vQci4RZYddlBc28WcE7
 OHHCvh/Xo6W9Ol0iNXl7+2zxiPMaRCdn7xImlpgdN8QrQHeoEOB9gS5cPIGqlCJ3+zbo+qPpSib
 bieek1+1JBhIaQ2NSUNyvhVbGOViumPfyMp8LJ1LOH2xkWgUqud/Q4ZWq8glrwEQYJyGtSRloIH
 rpLMDiDiRMN0/LrLOd+i4YA3iN1vLjw2ERKAQqqcNF5XLbQu6BdMEvBXj/SmYO5mwmHSiHNn09P
 bqMHF63jL61lrSSvp9oyC58Xq1Mrakoc8FmdXSTA6CmmyOAvkxqIvcD3P+wwyOWuSZwWMr/Vxgj
 f8g6LRyaAhBtN0x7F+flyFvG+DtIJ/tt/p9JTI6Xxdv6u8nPG2oSLE0nIVZcDJuna5+mjd8nOb0
 IfQjLYm9+58OR+
X-Received: by 2002:a05:620a:3728:b0:93e:c12c:f119 with SMTP id
 af79cd13be357-93ec12d0576mr1553333085a.69.1791808159477; 
 Mon, 12 Oct 2026 05:29:19 -0700 (PDT)
X-Received: by 2002:a05:620a:3728:b0:93e:c12c:f119 with SMTP id
 af79cd13be357-93ec12d0576mr1553328585a.69.1791808158899; 
 Mon, 12 Oct 2026 05:29:18 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcdde912b3sm2765948e87.21.2026.10.12.05.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 05:29:17 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:29:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: Add INT2 GDSC to Kaanapali DPU
Message-ID: <tvnmnnneoiibvpvfkrhh4qoffj2vpomdh4jtmccrblylwbrur5@zvrgjapveg72>
References: <20260915-msm_gdsc2-v2-0-9157237b8382@oss.qualcomm.com>
 <20260915-msm_gdsc2-v2-3-9157237b8382@oss.qualcomm.com>
 <epga5fcyf2d3esucs5ulht4s7ixwpwlb35iygz63aqeefruc2m@mwmmkaw2z5r2>
 <d61fe4a4-7101-472f-9202-404de9899ec4@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d61fe4a4-7101-472f-9202-404de9899ec4@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0OSBTYWx0ZWRfX8Kio7DvLPx0+
 jPHQbhN4/lo9yFAf19Mz4i0EVif6fFrjpYDWIR108LCV82rNQAwqOl29bVnV3txzxT5GyiXjR+W
 Tambhry9t5Sz7witC4Og//cBeBVL7fIRotbvTfeNbkDnoOs/7rQdavF9WbongSxiKLEB1uSe/aN
 Q0oxloUYO/duKaaWfqLWpsPTdcBYyVsGSRnwhYhAZkGyNh22fwpoWCEGTB4JBzfeEdtfnOhvXIb
 ZnN0UHKp8O6cdw4HWWSWDkwQjdPJ6UNVw9sgPMS/ieeEY+WkjZlN/hF/W2lmzApBgHBJLK63GT1
 QdySvZmEukaaMK8j9svypzoE8ixiYBhAyid6/LNzw5AVJpTE5JJRqhQjHfRrsZvj7k5uowgruiw
 vtVkYD+LhSUzLLLYNAJUtoVaDWgd5rinK6vjwF9xH/+8TbMilJ2mDf5CwMIgGrgG5SaOvUdlY3v
 v7DcgOS0EVA/vAvXKbQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0OSBTYWx0ZWRfX1kOIyXYNfdEv
 gMCmFQseEgvNVKrb6zYjnjy8WA1zjqB3C7pH9ID0usyReLwxMWZyYJDo2bThsB4hjaolEDfkKrX
 mRGsL4gX1rgn3bGgw8xRFV1mB/WPauE=
X-Authority-Analysis: v=2.4 cv=VOtIDNPX c=1 sm=1 tr=0 ts=6accd2a0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=gfEjnI5v8RykEt6AfOQA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: w1-k2YTpUagdTqB6K6CPfhFrj1T9MDJ1
X-Proofpoint-ORIG-GUID: w1-k2YTpUagdTqB6K6CPfhFrj1T9MDJ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120049
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

On Mon, Oct 12, 2026 at 04:41:21PM +0800, Yongxing Mou wrote:
> 
> 
> On 10/5/2026 9:06 AM, Dmitry Baryshkov wrote:
> > On Tue, Sep 15, 2026 at 05:27:50PM +0800, Yongxing Mou wrote:
> > > The INT2 GDSC on Kaanapali (SM8850) powers a subset of the DPU
> > > source pipes (VIG2/VIG3/DMA5). Add it as a second power domain of
> > > the display-controller (DPU) node, alongside the existing MMCX
> > > performance-state power domain.
> > > 
> > > The MDSS node's CORE_GDSC is unaffected, since it continues to power
> > > the rest of the MDSS hardware on its own.
> > > 
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/kaanapali.dtsi | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> > > index ace19b8b12d7..b3e3cd1d311c 100644
> > > --- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> > > @@ -3619,7 +3619,9 @@ mdss_mdp: display-controller@9801000 {
> > >   				operating-points-v2 = <&mdp_opp_table>;
> > > -				power-domains = <&rpmhpd RPMHPD_MMCX>;
> > > +				power-domains = <&rpmhpd RPMHPD_MMCX>,
> > 
> > Should it continue to be RPMHPD_MMCX or should it become
> > DISP_CC_MDSS_CORE_GDSC?
> > 
> It should remain RPMHPD_MMCX, as this power domain is used by the DPU OPP
> table for performance-state voting.
> 
> DISP_CC_MDSS_CORE_GDSC remains attached to the parent MDSS device because it
> supplies hardware shared across the MDSS subsystem. Since the DPU is a child
> of MDSS, it inherits access to this power domain through the parent-child
> runtime PM hierarchy.
> 
> Only INT2 is attached directly to the DPU, as it exclusively powers a subset
> of the DPU source pipes.

Then should we still attach both CORE and INT2 and ensure that
performance votes on core are translated to the votes on MMCX?

> 
> > > +						<&dispcc DISP_CC_MDSS_CORE_INT2_GDSC>;
> > > +				power-domain-names = "mmcx", "int2";
> > >   				ports {
> > >   					#address-cells = <1>;
> > > 
> > > -- 
> > > 2.43.0
> > > 
> > 
> 

-- 
With best wishes
Dmitry
