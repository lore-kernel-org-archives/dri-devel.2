Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90D5C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 22:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01BC010E67A;
	Sun, 28 Jun 2026 22:53:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OgyRgftV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y808G8yC";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC55710E67A
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 22:53:53 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65SM9Eqw937468
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 22:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=DBiYvBC1dJo0dJZFGs5nOgph
 H0zzbBFmjSIO8xEAr8w=; b=OgyRgftVx1LaUcLi7CbJ7X+EZmlttu6Nb5pxO3lb
 bJxsyhC9uxJQ04+QS2kRlpajNDb9m4gH0QjapQJdq2qE6nVwiOB6X0zNtRXWlzma
 vWBJ0+4UJsdlNq9A0a3q/R4DnN9sdF9OTspNoY+YILH/qzGxJ00Asq+jHUwNg0wU
 A8h1FMaS4ZLgpg46LK8NIe5XrA5WME7QOg+ojudFi67tCYWtxW4LeLc4714YbGq0
 mnm4n6UGdIim4r7n11O2Pp4ewPyScXWYY7zA0BUMHc8egGF2VeNj5W48pJ6K0C1N
 QcsyKoyri5JcB30vf4R2Ar6b3SbXVXuDOOV+lwQfu2Cu5A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27pf3kua-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 22:53:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e53b8a302so27406985a.1
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 15:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782687232; x=1783292032;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DBiYvBC1dJo0dJZFGs5nOgphH0zzbBFmjSIO8xEAr8w=;
 b=Y808G8yC6one/QmGS6KxPaCZ/RNOBz5WZPTxK5Miw7DN92WAzjegGqUfNujnL98Y8u
 8jOAV+twSKYpIOZN9oFQv1JZI/oxc8fU08+f97T9kVKMmjZarQW1727/kmZ9jstM/Ha0
 CwuYW877ahWNMzL2DkJ0IlKKIGk4t3IXnpyCV/gGMl6HwzbBXAcD5qvgTOSMtZx70i2Q
 Y8Bo8VXR+T5AL5cmlzdDLz/mGT4OFI9dLwjaKB8sP0j1HMB/9/gnmE6M9WpGRHq+H4tW
 JcklI0eEmnNbxHX537+YB08Szw7/bCJYLxUqPaPBqPVdn1EKhJEPuOnSjKMulwdySeB2
 wi/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782687232; x=1783292032;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DBiYvBC1dJo0dJZFGs5nOgphH0zzbBFmjSIO8xEAr8w=;
 b=snV5jRKVYXeMldKZeeE5U/8MdQY9Y+L5s0Ad8gmbD4uFs0ku0KKk91roWPi8AeAeVn
 /RAL780Aud4orCxWJKj2wrcjUiAvD4qWIuHGmp24oLKxp4Yx1s8VN6ddTi/BY0ktZh9e
 bpuzWhMapNolgGsQL0AmPjI0CK1QeChKcYKoreRaVrdbBWuc4ANoYRLDnHUE5/28zJ/g
 xt3aJWb/ncVCi1L9GQeNXUdMS93unh4nWk5CgB5YBrKAE3aAMyay/AdSWwWvQTeXCg4n
 62DG5PuQtPwC4ntMfifKPQK0j8NsXqGubfkxu6Who5fZDNw2rM/6C0z2MaT5xHwU48/s
 C70Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8qhpvFJLtq6WCunrbnEYLSvUrb6lKNfbD1NlMcIHQM50F7c2UC230mROkj66cFb8Pmy5McLUd2nN8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyLvjccbQPTazn6OlEMer8jS3474YovPlb+uyO0oXORTIhqciun
 0Jg4TX82YL3dGQ21GzEfzM1vctKZ58sFDhJWA3AsvEsoZn1REW/LbIkUFUcMF7m2iwQS1sXecI8
 yStKsP4KGCx1CX7Kh5lGEBaO+IP9tY3y8GX/EIoJLoQmFszvEIl6yL8zfH626s6Dca8l/LOY=
X-Gm-Gg: AfdE7cnAM5iRp2lkaUAtq/f2nYdJTS7IVlnThkLExo3QHwkeg3JPtNJmcaa2pPB4JvS
 UhGSaDxckXQXkD0Fm9CrZfReHUo10/NUNaIXibOaHS8IxsnqpslrzwOx2xJSuzvw3l9cTmERgrf
 8sK5HQv5uDkluClvObXGUGUOisI10Md3Ph4pPEnDXljlIwB4TYMt7kjMf42Fn83HeuDOzj3G+xQ
 VlGiKVaXr6iQ3Rvn/gEXZMUUJpKg4yUT5UZ2LzFxNBXU2Y8A+EwXaxiB70GCQDJrD8LHpjbNfKV
 tNvKKydSrhN/hnhfJWQZsHHtiuQgFNy9Y6FBe6rNhXeJUKI2jK8aGpYniDj1W1fwShNgmLnaCUa
 1ZqkvoN53aCrh0LlBhklTn3d56Zwnp1yar+UOCXnn/qhOXNk/vz4JW+/aPRx3+LItgtYYn3vqE7
 BNbE5R3yZiAK40B/SJtg4vd3XO
X-Received: by 2002:a05:620a:4405:b0:92c:3086:6d50 with SMTP id
 af79cd13be357-92c308679b7mr1003116885a.2.1782687232132; 
 Sun, 28 Jun 2026 15:53:52 -0700 (PDT)
X-Received: by 2002:a05:620a:4405:b0:92c:3086:6d50 with SMTP id
 af79cd13be357-92c308679b7mr1003112185a.2.1782687231656; 
 Sun, 28 Jun 2026 15:53:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39b134fb1f7sm360941fa.5.2026.06.28.15.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 15:53:49 -0700 (PDT)
Date: Mon, 29 Jun 2026 01:53:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
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
 iommu@lists.linux.dev, Aditya Sherawat <asherawa@qti.qualcomm.com>
Subject: Re: [PATCH v3 7/8] arm64: dts: qcom: shikra-cqs-evk: Enable A704 GPU
Message-ID: <2e7wfaejgbapxhmlxqne4rtxzcuyhijxns5su2kcr6k2do4c7l@3zdmkrtik4iy>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
 <20260628-shikra-gpu-v3-7-9b28a3b167e1@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628-shikra-gpu-v3-7-9b28a3b167e1@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDIwNyBTYWx0ZWRfX+DFGwbiK7Wi8
 7BsyBV0lKzxhkQkBbqMPLfJoZzlzyQSm0bnJcNzIaAOo2BfSsXG6QJbpnbSLLcyWqOlHKrMCwsI
 KFvScVaKH5aTqhlC1XsVteSNRO0Jt/U=
X-Proofpoint-GUID: Jkb5zS2O4IsC7pPy8Mwv-vX-mHTPrCDI
X-Proofpoint-ORIG-GUID: Jkb5zS2O4IsC7pPy8Mwv-vX-mHTPrCDI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDIwNyBTYWx0ZWRfX4tFyykUJZpJ1
 R8F7sUqavURQ5BALwhouvbmAjEvotbhNIhUveOrfLdUDKRtd3+7XtQekz9MNw3svhTQuj0Utmxj
 IghF3FR1jIUWYexi7a8NGmH10Wi/gf3ywhK33aO/ubVShsCvpNl405miIC4ujzXWt3YaKO7sDXF
 Ndiwcubk+M5OAipBDDu9e1IcDHkfRgh6VRXExi5/WwEa9c8P0CTChbEo88JucFp4n+pcPiIoY/3
 TpLOvmf7+owvtj5OT/MQcX/tIh6SdCCVschUyC51fQ8yo47s2Z0ihb/s8EAUqCYCH+3BlqdEOGn
 5XgY9ZYZbBsGDMJZ+uHS4f3Hde23I/1Hpwc75bA+GTbcZHFbYnYjGv6hVKx6oZzxrkkXyBwTyR8
 Osc7ykQUdC+bAY32R2yJxVLTx7qUqLRyjKITSFMLeV6OFURQzO/LCyRmAC3leoYpaNLFQMc97GM
 JOAKjaawV++69cAZ9ww==
X-Authority-Analysis: v=2.4 cv=R7Mz39RX c=1 sm=1 tr=0 ts=6a41a601 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=UQAiW8fk4jwks4S4FoYA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280207
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

On Sun, Jun 28, 2026 at 11:54:00PM +0530, Akhil P Oommen wrote:
> From: Aditya Sherawat <asherawa@qti.qualcomm.com>
> 
> Enable the A704 GPU and configure its zap-shader firmware on the
> Shikra CQS EVK board.
> 
> Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
