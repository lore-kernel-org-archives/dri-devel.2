Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69672C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:20:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8A4910EB06;
	Tue, 21 Jul 2026 18:20:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mn1FQ1JN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IVpsdKx9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48BE710EB0A
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:20:37 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LH2TdV2548677
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=3WzoQyUz2yjA2sAZWuslYc8+
 DuQcXPV3q7EZvnD8d+I=; b=Mn1FQ1JNrs9v0OnYqnBMZaeccvDORgZdCLaCI1Nr
 ag2CMwpqeuDk/vCSi9kqY2m2IDXWXKIj6ol4aPYUaKVkw+du0EKbQ9xjcqyn2eGx
 2/mD9zhyD2LU1HeMkg+SCTB36qgaoV4Jg/+gKZVdBqui7eJtMCVJrw8Nc1zzqQ/G
 sHEPluLRo+jVZAYbZG5qeRXFXVWr6iZj5tOvIcTyJdu8szUzR06QY2O+PYe71RLk
 HtGnN4Cyc/OoC699lqvCpt/kg+/4FmsQ35AwS5I7ky0EpOq6Hx/CgOg5X+4/hkqK
 n1GbjoeY5y6+lQ6/J5U17f8979igscfEkxBi3KSb/sTQsg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6r3jc0r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:20:36 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c19493ac2so15212011cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784658036; x=1785262836;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3WzoQyUz2yjA2sAZWuslYc8+DuQcXPV3q7EZvnD8d+I=;
 b=IVpsdKx9con9CVBv4qZE7hGyFGyUZI15vrKPEj3PT3GGyA/zUz4+rYRRs4D68+FzuE
 gg8DPD1Bfm0Ucf0JP5bxoicxVCLLxDd+hXyh6EEcTujmezzKKuK0KU2gja/IcAGgEcig
 +mOvfBEJGnGfTjFyd9oOfNvxbWfrDm2bX6gNRcw6Foq2qUsuVmj8pm3rq3slWjDlTVMG
 39S7nQKj0I6IXcFp4N2EF+FcwiT4G5Fzp98yH6r2iNdlRACAyvCkiwX948X+JVrluDd1
 0nUnzXcWVIyLzq4d99HeFE/6fPngknvgvFGIJN13pNKrH/oJ8Y3HSvZ4J4NRHZIt+LtG
 jsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784658036; x=1785262836;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3WzoQyUz2yjA2sAZWuslYc8+DuQcXPV3q7EZvnD8d+I=;
 b=J66GGnZtZAJHn/uL6rcXPTF2uW0uoeRH6BmH8JvM/7dX5qEORZw98KBwEf+mYInpIb
 OXWrOB8ZxNcYFoxyEz9BGheyUJMWI+kXxNmljmVu+CmYvCCyOhdPvkt58AjjFGONJw5L
 eLYctOOVJ+I2P5t6gbqMK86FyFX+iDPdVBG+mKkXdy846IniCKQtCrM462ucJLqWxLCN
 CV31xfDhRWr8eqBJQRJQ6Yc0sLe7UztleUvAoXubjCHmPL4YtXggxhbWC43Ek2L46oND
 brWklg0CC3MlwOKZMXA4TaPrp2Z1k1uZHMRtNeEcdIDmJE+PWFxlbTiBRoyjdZ2Kqje+
 kgoQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpfIMd2TJ3BL9Nv3inANvk3imGue2IuPW+3vmgHf4Df5aUvC41EQOJeNscpUKE0csI328Rz70ngtbI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6SWZ/Im5un4a9U95TiABALcXMia1KuQlZ/dSYWxJLenrlobcj
 +5MaLnZsnbLvYHEMPMKqzriTVptdaQr0PqAnJIbhmuhNXNKkd/n6TsWjDnj2CsB57H7Ar+XiuIv
 2AQS3DQYM1PkaxfU3yhSRhC6Dr2/zfamcbM7T9dkILF3fz9HT9upDMcJVf5FUabmjbkA+BhAASG
 5YAnI=
X-Gm-Gg: AfdE7ckpgMKC6XiNFTUkg4QAfSFFeVwz3L+lZik52tsOVmouMDXvKDUaoEOKne4dPYt
 XkB9NOmU3BzcQkhxxYOblptvRD4feNdCTTIaE6amQhqfZFvmEix1fdJ938uvDpxiF8uRzXxaAml
 clrhfWtiy4+4npJVGv/81Y4rLTBSY+5xYoXQUdP9yfKU5un202VD7ocqsc6eZK44qd3VrsNRIKt
 v4EQqh0wIGfCMKaIFxWM26FjACvSMjcC8BObTtrZizf5IA4+S2TkFuaeuGsFiOUj7joNGmBA+Yl
 dsvJnd5cE44npAZlZAvcugFi3AmUV6xa1ssRyLAsl84Dqjc0+kd/8ahH8x6kMkwrBzNtv5htbh2
 Kt+Nc6i2FN/fIOwoqmcoNF0IK8becTJmUmfYgX5+EHBji4+h7KZzSaR2gzzH3sjKklfC2rJGrfu
 rEd1WTOSwFPJxSPQ==
X-Received: by 2002:ac8:5fd3:0:b0:51a:8c9c:7f41 with SMTP id
 d75a77b69052e-5213ed70eaamr180092381cf.68.1784658035716; 
 Tue, 21 Jul 2026 11:20:35 -0700 (PDT)
X-Received: by 2002:ac8:5fd3:0:b0:51a:8c9c:7f41 with SMTP id
 d75a77b69052e-5213ed70eaamr180092111cf.68.1784658035235; 
 Tue, 21 Jul 2026 11:20:35 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9bad324sm68041e87.29.2026.07.21.11.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:20:34 -0700 (PDT)
Date: Tue, 21 Jul 2026 21:20:31 +0300
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
Subject: Re: [PATCH 1/3] dt-bindings: display: msm: Allow two MDSS power
 domains
Message-ID: <5jozediov63riomokjzcphmpkpfqdgl73j4hd27vx6yttyddar@7bvbitl5ag2s>
References: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
 <20260720-msm_gdsc2-v1-1-4687866d6cb0@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-msm_gdsc2-v1-1-4687866d6cb0@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE5MiBTYWx0ZWRfXzU7jWcEu4PcF
 vIMHZ3wcg5DBODAlrQ9IK2akF6F8razbVThYm3VRT85EambqqvELNfQc1Wi2kqlv5cyFzc0DOJX
 sl+oFqsJ3ZSE/3u89O+V1sk8bXcpqOTVAhONEc5n9mTbr4tKL8y/1JKRZuNwcvTR5htzY/3qKk3
 00+Wz+NRnUMAVRE1TS+mnEBhSpgtLgMU7ECg4qgPYyZmFMhtpxbwt7z5pFXhqpjxL4PnVLhF5Vy
 jqOTKPpDs0ySPe7fyB1dutrgx4pYK5FxvrH2vzeAcFiF6IcpaWz4+GukC1eKlCoeJa2pIo7q2Ph
 o01B5CpQykX6liqAUzGxkNp8zVVp2KftDWxR8akoNs2K+CSRGLHj1pttraNKjRNtsyHazwdBQOr
 98qOOSfdIjDt+8xdT/Lq4fArwFf1QD6ksNvdZQL21I/cvuLOHTRHo4OYgdgjYW2H048+Qn+xyn7
 jLSBeklmgtfl9CWF+qw==
X-Proofpoint-ORIG-GUID: bnIp8FPhe-owciQSIUomGqhjgmtShBGm
X-Proofpoint-GUID: bnIp8FPhe-owciQSIUomGqhjgmtShBGm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE5MiBTYWx0ZWRfX3Wo5pG0Z0Kyf
 Y0AuX+zEhzOWWqv4uKMWiveuUgatpV/2CabtIpfbePwj5gvG2ghPRiKH61tZygm40MJscJWdPy2
 6GnYY3ga1GA82L3pFOanqvGUMt6fMWI=
X-Authority-Analysis: v=2.4 cv=SIRykuvH c=1 sm=1 tr=0 ts=6a5fb874 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=o2yrQjtzwsYVaXIb-dAA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210192
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

On Mon, Jul 20, 2026 at 04:43:53PM +0800, Yongxing Mou wrote:
> Kaanapali (SM8750) and Glymur use two display power domains.
> CORE_GDSC powers the main display hardware while INT2_GDSC
> powers a subset of SSPP blocks.
> 
> Allow the MDSS bindings to describe both power domains and
> their corresponding power-domain-names values.

Another question... If INT2_GDSC only powers up a subset of SSPPs, why
is it being declared as powering up the full MDSS? Can we move it to the
DPU device instead?

> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/display/msm/mdss-common.yaml        |  3 ++-
>  .../devicetree/bindings/display/msm/qcom,glymur-mdss.yaml   | 13 ++++++++++++-
>  .../bindings/display/msm/qcom,kaanapali-mdss.yaml           | 13 ++++++++++++-
>  3 files changed, 26 insertions(+), 3 deletions(-)
> 

-- 
With best wishes
Dmitry
