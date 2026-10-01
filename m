Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87762CA5FC5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 01:30:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91CAB10F533;
	Thu,  1 Oct 2026 01:30:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jlohJp8/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ffx1KXZ9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 190AF10E2D7
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 01:30:23 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6910jtcW2099161
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 01:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=eGwclrvkGkFDi/gd8U3LJ8vU
 MTfgL1qtLx/RYSRBDR8=; b=jlohJp8/meS2pus0/0/GbJO4igfnxXNFvB3Z1YIX
 TO+6PiYRgG1i9OjsKz7xE9w0Wge+QTakFSyR8BuA9kKknRr648JMXbF8rBVJ3Kr+
 DQ3f39iOBaPBx1pu/FGvlkDn3BHqmU/GnTCvdOKyfSrn2ew51vOKENDoakS158xX
 LD/Htc8wKX5TI2XS9RtItvyMK73U2DNtIunQja7Wu6JYA5AifxCWNbFIU3Gg2p4I
 ONUQnURYVhtAiF8j8MtKmc+Uztk6Rybqg6LaHZ/opYlrG5lZsiHDUVk/DOdD5aad
 uoM/u4y+6+a6F7HFWxOX8QuXuINGB5KfjgLcJX5FE/iBVw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h136tjv75-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 01:30:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb71b1443so88895785a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790818221; x=1791423021;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eGwclrvkGkFDi/gd8U3LJ8vUMTfgL1qtLx/RYSRBDR8=;
 b=ffx1KXZ9qIHTzL6ryCQfijy0Ei2PDHH0jGMvj6MaVHKM95AOlNOVKIGZcAgmpqMQWy
 k4Ij1fwGiAjsgd1+Nsz9LA1entmpvbaP949Ve1GRnm2VARsV3ruIIuG6Q5V+h5KswfQ8
 pG9IaaURhtoOF2EXwtzidlz5vQl2b068mTLpVvD3punILfXILakoACYlPsd2bUkBfQlK
 OQd7sydyAeiAJeERJQffogj7cCD7qbHFEvm+VHzg6qmtQ5k0lwQhnhE5ToXX4O3JlYWC
 o5DZSVhM+B3znaSJkBkRvJxqa0UxuKqHiWN60JyouAoctcHYVuDnHK/Nl56xj3hH4t4u
 SmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790818221; x=1791423021;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eGwclrvkGkFDi/gd8U3LJ8vUMTfgL1qtLx/RYSRBDR8=;
 b=QdpvLlG1n1hmSS9tSGhLH89E/d0rUNaWIdEahM4dz0AMq9fS1lDUcBfpFJDNifD4Gr
 oIyNZ6JZR1y+Y3z1RoBf1BsjoYN6nPpNSGP1Ogozb4ZdLHLpW4rmfroBKOEXtmT0meG/
 GnVrLkhkpnU7uaEIQWer13N2yxVKtLflqXwExLALdUxajhCRMkUlp3FbpylVMLNrajYA
 Vg5nlxKDFEDMLEDwMunugbsLTddXcH+uLCoT4mX9nWyhRKQ92Tp9dWbTFe7uMS8LxRBQ
 nukRRDOrMdFENetAZtipHyA2qHub5pxruMeV2LZBJRDCZpsfXL1dvHHsmSj2L/ueAZAW
 xHRg==
X-Forwarded-Encrypted: i=1;
 AKwUvByUPljSmdwyf/RV0QmZ0oyH4vipVIs2PsIlwcaXyrkb8tMapJa/R7O1ZjQnZLE/Xw8UtSGoFjS1ToA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nWNpdPE8Na/qO31UiwBub/XG7953A8L+CpY8IqZPZNt9QSe6xF
 ce23mX+rrHPQCG8SrQeF9f4OkjkE304Re09WjKxKGXco6SJ1Qva9fzzfKbJYhDXMlNU26vScL7p
 42uKeVtVlm3vz3zeUsU32UG2DXQCYlz0VRMgt5tiUaO39zNFbv8QVSWh/NlXIE8zrJZO/zr4=
X-Gm-Gg: AYBFou0UYUWXydn6W2raw1ud8ARg0dUtJUwbbVw8n0OFtyI8QFfJr9QYS6MyTwKpTWm
 GHRYd9q/dzr53kapW5Nn9hiH7/qITjS8gguqkXCxj5FU+nVGUu4osJutvZJxXxCAIrDxqKO8l4M
 zPNd3FN4Eo/JoLE23rhSYiwoqJAUSBj1cLGmDAWkRMpmKFSjYXPjkH8HgSKIhibpfCdX2y9QhPQ
 WCPhbeihEa1G7nZ3rvpcK/sQMNa2Wt+M5V+wSyLfumfX+omSWR5dcZJQxYPj5WhIHuf4ccKZ8Er
 5X2pAdhoH578U686LoGzvWihEuJmViUD1CYBB9EfXy35eulKWbnsVqSq2zRQux1jq3dgx9RCi67
 8snJTSJTpBu1/PpIXyoXpGtUbVG8eT4ISsvg1QybYcCsyH+Z6dhTSy2IDnNvISKctWFP+KRyOMO
 ccCzKnYdGF5LmG
X-Received: by 2002:a05:620a:440c:b0:939:ab90:8f6a with SMTP id
 af79cd13be357-93ca9779e92mr539018785a.18.1790818221281; 
 Wed, 30 Sep 2026 18:30:21 -0700 (PDT)
X-Received: by 2002:a05:620a:440c:b0:939:ab90:8f6a with SMTP id
 af79cd13be357-93ca9779e92mr539010885a.18.1790818220566; 
 Wed, 30 Sep 2026 18:30:20 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba44059a94sm170385e87.6.2026.09.30.18.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 18:30:19 -0700 (PDT)
Date: Thu, 1 Oct 2026 04:30:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Subject: Re: [PATCH 01/17] dt-bindings: phy: qcom,edp-phy: Document Nord eDP
 PHY
Message-ID: <vj37teqcz2gzmwjjn2exvadtby5vugpsloa46laktwiyv6yjlz@px7ludjbiub5>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-1-e25c073cf1b6@oss.qualcomm.com>
 <evvgtf6b46zqpolvybz6xfklakgoyv2llnvawrblgz6np7viza@gtmqflkwwmgk>
 <a5a4abe4-17a4-4ee3-a213-a9e136e31648@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5a4abe4-17a4-4ee3-a213-a9e136e31648@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAwNSBTYWx0ZWRfX7Z3DUK2h36gL
 R11mqcBMGZunqX1YjyecZy0FFgez0Yw35+ntaMdeSbr5+AknSMe8fUKMj4FzKDvjJ3FjjyNtVNJ
 UlPQtM6EwQNSjISdvvt8FNd78VfoLsE=
X-Authority-Analysis: v=2.4 cv=aPFlOr9m c=1 sm=1 tr=0 ts=6abdb7ae cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=vJekXL2k7A3vZJSvyLMA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: vLJRDdFH0qX4FYu8KQ5qXCwb7orPUcHj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAwNSBTYWx0ZWRfXyiXBsAvEkzK2
 jMIeZ3gYZBfJ3sW+rW38spyoNHjxL5pFw3mJgI7ZODgCI1dpN5o1wQV7ewfL1egjYISn0/I/Ty8
 AvVTMjg7xctN8RvQF9i/+KY783dmEXorQQxxbQJa3d4e5l+M/7q4pPW3zFKorQBRYf9sLWwJg+A
 GTaxvhFRzJd/X0gy1P/1unxuT9fWeJWHuB3GweSbB5Hl4dqzfgas9pxrs/CNBWq7Iqz723k8oVG
 ckNO2m+3BMOT7YTU8uNgzQMrWXEloRCYEUsruyoBEwAywbxjOykrFSfIl0gh7P4g7W0lkZ/xAhF
 5QedJQzmnwUdzmTu9vDevjHDy7KpuDlS7J7KYa4IyuiiGNzw4gCe2K/6899KZIMIiMbEUvAw0z3
 u8pH8lnT9isNAzk8VuS0hFBLz2vH/GP7KBUXxUNVLeGvpgXf6ULi4JFLnm4zNgEmD3EILwrr+MS
 NmdK3AyS6NdLuvKus3w==
X-Proofpoint-GUID: vLJRDdFH0qX4FYu8KQ5qXCwb7orPUcHj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010005
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

On Mon, Sep 21, 2026 at 12:26:54PM +0530, Nabige Aala wrote:
> 
> On 9/14/2026 4:59 AM, Dmitry Baryshkov wrote:
> > On Fri, Sep 11, 2026 at 09:06:32PM +0530, Nabige Aala wrote:
> > > From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> > > 
> > > Add the compatible for the eDP PHY found on the Qualcomm Nord SoC.
> > > 
> > > Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> > > Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> > > ---
> > >   Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml | 1 +
> > >   1 file changed, 1 insertion(+)
> > Does it use ref clock?
> 
> Yes, it is using the ref clock.
> 
> [PATCH v2 1/3] arm64: dts: qcom: nord: Add display subsystem nodes - Shawn
> Guo <https://lore.kernel.org/all/20260920091930.2215803-2-shengchao.guo@oss.qualcomm.com/>

Then why did you not add it to the list of the compatibles requiring the
ref clock?

> > > diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> > > index 0bf8bf4f66ac..91d7a5c8e19a 100644
> > > --- a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> > > +++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> > > @@ -19,6 +19,7 @@ properties:
> > >       oneOf:
> > >         - enum:
> > >             - qcom,glymur-dp-phy
> > > +          - qcom,nord-dp-phy
> > >             - qcom,sa8775p-edp-phy
> > >             - qcom,sc7280-edp-phy
> > >             - qcom,sc8180x-edp-phy
> > > 
> > > -- 
> > > 2.34.1
> > > 

-- 
With best wishes
Dmitry
