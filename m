Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C485C43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 12:33:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56BA510E09B;
	Sat,  4 Jul 2026 12:33:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NxwSLxln";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jpLG9Xoi";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25F8010E081
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 12:33:14 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6646hkbR2281497
 for <dri-devel@lists.freedesktop.org>; Sat, 4 Jul 2026 12:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n7l+w1LkFRue1ZQFudjsniOqbsa/avBSZQtqmMh9NKg=; b=NxwSLxlnSUC+g1lR
 7NVdxQqrD2X5yEP9GceoXfoUjZh44a4vGxUoQ8nhE390jEYQSfUgen9jyHzUGs2O
 D5Bl7af9JbE0T9NtOGr0BWCOaaI/RPPDRqSAZ7ibwp8/GjX8JJKrJ5IUoBJ/STIc
 +byoJEJ2LJJmEaI7i3sGeBmcuG4zYZaRNqHV3Fsai3x4XZzu6f2irzrW+JvBADal
 b5PT7fNps+909/4cB/5uNGhJBY20GRg74igOXJGhxGlzsszkWnqmmQQK+isRhf31
 R2Lcit6DPc0dptb0CaKNoy4YmEUg73b2VE0vlpNyqpNIjBPTuI2dbAMqlqCfDgFB
 5JyiQQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qvgs55e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 12:33:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e4f27f49bso113429185a.0
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 05:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783168392; x=1783773192;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=n7l+w1LkFRue1ZQFudjsniOqbsa/avBSZQtqmMh9NKg=;
 b=jpLG9XoiO8ivz0Mn3XnNn6GCAsWIHGxNb5wRWZZzQCRiuWx5X4jb2eTqmUwIt1rks/
 e6Cp7UWdOyo8/Wi9C++Z+jsEp5F6nAsWGWzt/+xemN2tcRU82TNGTa3uiTpQrgbx2HIV
 pjcnO/HhKM+mtbqnE0ZMr7WMTJCjZv+afJYcwV5MXwRiu2uzadaiRS2i+A/WBFxLjdcI
 1dxNduTvQ6Ib5umNk5P28xBvSgqRWbfNzlam/9maYsXAmrxPlz2lBQVE4SKM5FAgcyf8
 dLaURvv2YWH0o/ERl11cxP78PeDT7ghFr5W3QA6H43SuyLDPm/OeAXz/oVJknVD3NJoe
 TQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783168392; x=1783773192;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n7l+w1LkFRue1ZQFudjsniOqbsa/avBSZQtqmMh9NKg=;
 b=MtiT0MBRKBW89CdOjQJIw5JqpLD85+1xNiAb0oUbZS69uDxMXi+ZToAm0qLpTu1EuU
 UpiX+LB8vWfEwwxksR0PenX0gQBO7k0+NoDs79vJuSIPNGumcXYTDjGR2IJLnK41XCE3
 t7pN5oDCph7+/TMjc/ejnuwHf/douF4naqDDdh/x6rFz1vCKMRKpqaOV0pn+jDHuTJCb
 32IsdRb8q6l3fafWpyZMX4CGuK1cPU2wWRjw1NTTFJuwuFMSMC4sfcWsSBGmreRkIUm+
 xHgpzceqmi0JYjmssEPqJYXfeyt5UuSooZN2cYaYxiDiRNV7Gii5jO3CRESQL/iJJ8p/
 Z7PA==
X-Forwarded-Encrypted: i=1;
 AFNElJ++hLGi3iS9BuegX7HcApEkO6guBVQoyxQ7nVv9HOOtIAYxFrCbpThiFiYcWflOPlAiCx8bya7L+0Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxoL3AFupJGY0WwxfiT49gAmGTgz4p21nv1xkBeX4NYIvk8ykFT
 EJIKOMW2lOs3inunIaNyshdTyT+UZ+zsX4Yy1Aqj4mlbEXbiOKookSbKOAL4dsTKN/Ou1G0hJkq
 KTpDaQBjmICrnQRBBQSgpQXwFxErUIfHSjbo8AAi0GehHoeBSbTlOwOD4MCZBVvx02uK4bkE=
X-Gm-Gg: AfdE7cnFKtPWHBSLKEx99NUqRCKypGN4WeW4Ay1FBhCTzDqefOP3b49/1QDOaAeYkcU
 KqGTcR/8uEQ9YpU7hOIKPsrVa8wkJsgXAp+oX8MUK/JczroAm3I++Bd2tgPo2FDSeGX0rlqmm0/
 j6yzH/AhLL5SC105zj4BA621FcCkAoNYCigkF6ZnCXPLMbhoU6ZXfYkgEO24A00fIgU1BXAk2Bz
 3vX00jFbK6lUagC9CmPnn5n/LIc0gB/cMbXcMyK9hl+pAqmg8R0kzxRr8KBKbvF7U6x93VMpqiv
 eBB/4ftM8fwRxGSMluBGJHlhV8VL0KjA0BS4hAVCIX1pr2IsRn8Ggv0U9F4uf/bbr1RT0lHcTyP
 BotlatqmkhmTXMOBNEeIkh/34Y7RObBKh5q19DxlStJd7CFr9CSDbGwx865DdbVaBOXTkFJ+Xzh
 fvjna2jsJzY0Z8ruxzCCDccmt3
X-Received: by 2002:a05:620a:4398:b0:915:9d08:94e1 with SMTP id
 af79cd13be357-92e9a43b335mr448898785a.46.1783168392445; 
 Sat, 04 Jul 2026 05:33:12 -0700 (PDT)
X-Received: by 2002:a05:620a:4398:b0:915:9d08:94e1 with SMTP id
 af79cd13be357-92e9a43b335mr448892785a.46.1783168391916; 
 Sat, 04 Jul 2026 05:33:11 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39b4aba9ef2sm8519151fa.0.2026.07.04.05.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 05:33:10 -0700 (PDT)
Date: Sat, 4 Jul 2026 15:33:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
Subject: Re: [PATCH v4 6/9] arm64: dts: qcom: shikra: Add GPU cooling
Message-ID: <qqdaoc4tacx3dlh6bp43gu56w44cezkm345iconc7iqngircxm@hoywvq57otpm>
References: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
 <20260704-shikra-gpu-v4-6-90cf1a52e539@oss.qualcomm.com>
 <opgj6twppqwhb77itqelmyzniaifcja3wdazyzeal5axstr25g@a7v634mnimbm>
 <ca8f3731-3f23-45f5-82ed-ba1a65514b95@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca8f3731-3f23-45f5-82ed-ba1a65514b95@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=VvoTxe2n c=1 sm=1 tr=0 ts=6a48fd89 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=CvX1hmVerT4HThdZ_8QA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 8On-4H7NM5J-eErEDH611K7tegnLXsuo
X-Proofpoint-GUID: 8On-4H7NM5J-eErEDH611K7tegnLXsuo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDEyNiBTYWx0ZWRfX2zpSgRzWezLF
 Hvn1lXWF9PmpwOtgOlrs+WuzrKwJdAsi3ZF9uKkw2ycc3C4CzwVzRf289KWqnuponYudJX92V2X
 ti0+s7vJzVcQizV+N7l42mwREkytUQU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDEyNiBTYWx0ZWRfX13Hbudt9DOIL
 DR7247bj34dChX/speG9oqPJQbndJvDT8+lgCdU3wvxe+s08Atv5IY/0Z+ecpOjzcdqeExbMnAC
 aXHP2tiKoY4ARWCevwB2pYkb60Z02AMq/0Tg6nfb0AAwPKxPKArWarmOel6ne8v27Lp6SWy4n5C
 sfQwfBsb52mMBpndzVf6EL463FwQUXoqdH4w9Z0jrCALWKrp4Cl8ue6SX/RuMS2vGoypINSh6eu
 TYqIRTGpKe3ljXRgNYjAJnnfoYdUy9FaX7KFEudE/Az+vUeIWN90dE0GyhlhrJjcNIUOWIhAnUw
 4a4IA+zzyvL12cg6VbzW4fXup+kG3efVjAH1pS6j57NL2ViZPjNQg8FXa6LtlsJEW5zi7zr4zu5
 cegfBMdlsvMVs10/ZT0Xw7fKovl5Sp3L5sraWji0tqxNmbuwifVaKn8ON/u00rcnqlY7FbRRSv5
 PjaRBUa1XTXf84vKXGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040126
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

On Sat, Jul 04, 2026 at 01:56:30PM +0530, Aastha Pandey wrote:
> will update why part in commit message.

A. I should not
Q. Should I top-post on the mailing lists?

> 
> On 7/4/2026 4:41 AM, Dmitry Baryshkov wrote:
> > On Sat, Jul 04, 2026 at 02:04:32AM +0530, Akhil P Oommen wrote:
> > > From: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> > > 
> > > Unlike the CPU, the GPU does not throttle its speed automatically when it
> > > reaches high temperatures.
> > > 
> > > Set up GPU cooling by throttling the GPU speed
> > > when reaching 115°C.
> > 
> > Nit: 72 chars. It looks really strange to see two paragraphs with
> > different line wrapping.
> > 
> > > 
> > > Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> > > Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/shikra.dtsi | 16 +++++++++++++++-
> > >   1 file changed, 15 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
> > > index 34261221664b..eeeaa369d3a7 100644
> > > --- a/arch/arm64/boot/dts/qcom/shikra.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
> > > @@ -2510,6 +2510,7 @@ cpuss0-critical {
> > >   		};
> > >   		gpuss-thermal {
> > > +			polling-delay-passive = <10>;
> > 
> > Why?
> > 
> > >   			thermal-sensors = <&tsens0 6>;
> > >   			trips {
> > 
> 
> -- 
> Thanks & Regards,
> Aastha Pandey
> 

-- 
With best wishes
Dmitry
