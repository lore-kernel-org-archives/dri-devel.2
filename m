Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECB4CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62D7E10EB18;
	Fri,  9 Oct 2026 18:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="M0bAF7d+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="isNYF6dp";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2472910EB18
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 18:48:17 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HZlVJ1016369
 for <dri-devel@lists.freedesktop.org>; Fri, 9 Oct 2026 18:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=jtA0Eo9d859FtFUw/2JWgY3k
 SSkkwzVmL4FautXCk04=; b=M0bAF7d+T1Jp1vpZmeagW1+h5r/Ec1QruyE9v76o
 alvaH5Ubtfr/4gNB6s59YvoruOCoFOorxEnyBHLUjv+wi+IjPQCl+ZOtZFl/I5+e
 wgR1eEqxiPfY5js+vxlPNAfCuRnMoSVOC2SJoYj1G8e2PkBrwv26Xf3ffSfiXeSL
 mGmnaO7nVjljRYMb+vlT0TcFmaxJEvyK2es+PQ25vhHODntMqTeuckpkRB02ZmsW
 Rdpdkri7axvX21fphpaxfGBU0gVa2Dk4347q3GH/YRaptG9orDO/2b5gFaJ8Tez6
 /eU6xeaXPzusNvTGKrDS2BH4dTYW8mMzQAbxB7hg2+nOvg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t88958-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 18:48:16 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93caa0ce0cdso861590285a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 11:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791571695; x=1792176495;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jtA0Eo9d859FtFUw/2JWgY3kSSkkwzVmL4FautXCk04=;
 b=isNYF6dpxpgLtWB/4Ceq8GEx70+Z56T7eJlvZ52r7Mroo+s1+KL7vTd4krOf8bMBlb
 LATEamD1uMGoJQUuIaaPhF5yA2Ftv/mgBiIVa4C+DiU6xeguTidA3otzB8FvZPFLoi7B
 FMO2cXnW3v0UynYJk1YJdFZHloYK/cRvYdRAIoW+s94DylE8Ol1InTZrEUGy2DN2b+2G
 +5dClwwS1Pgy+FPywtbj4MtQD6lrJstH9+8dpwDeeawi9vZVQg7Ysz0N/PGnIEscJvIF
 xphbUAFg149mWwmd1S16k7cbQQkbxafVQYAmqKMbdY0yWFNnwPxvLhB0r9W44/lEgFrr
 2rlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791571695; x=1792176495;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jtA0Eo9d859FtFUw/2JWgY3kSSkkwzVmL4FautXCk04=;
 b=HB9JxozOalziHAGDRoG9DFG7EMRNtSAfYrcdgL09WEAljLCs8Jxrb8Reve5OKDtMMD
 2TwAS1X3cEUCtkaX08Nd6en6ORCXEBinE3RUay87TjPv3yq7GwaQXkgs7yH0CC2tuZtl
 Ogiha8f2Yqsa4SYFx+VvjD2n7k1V6rHEeWZygnaVFTbkaddRNSjZQbprc6B5HF6yJB/u
 h+ltEqLtq+rJCoujjlLV9TfvzdIHbF2aKLFPMuMpW+L5vIha3RyfrWK4OGQfd3Jax2iR
 p+f6s34FltiGYcFfPntI5ZCr/xVb3qaVSYRlM91UVlnSOyqPBM4JJ8yOYajmw3ANs93O
 EZeg==
X-Forwarded-Encrypted: i=1;
 AKwUvByyuua7EcECJ8M/tvRLI775b34eruoCHcDDM1gnwALgYzobHiI5POBcVy6BENV2kPxxC+k+czBl/KU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIIo/ZEwbRNzQUuKfkHYHqhIITQnZWa+/LicxBuqfDDrrfUQTU5
 U12Dqn8byUqQXE+Bq9RTOSfu40H5kOaOQSmAp8Bh413JQtPKBDn3UMiGNcDF7JNQX4v5IfUMZni
 HpuJrSUQQ7E87yVopZa8iy1Y5QcIR6cjyF6WoCdaiNDr5Q11SOlxvLT/HwSqKaT1OR3I+bik=
X-Gm-Gg: AYBFou3V+2P8JhvdmNN8KA/sOjEhPt86RGWE0r2Mw5zcgoWcrjB1pJXfZWQT9wEIqnL
 irLy/FORl7SN7M/IhTYWYTa+VqK//hATkM4eVdEwRtv/oAv+lhJ2sBc7l5ReUkAOd1ZzzwZ9nBQ
 vjnJIdZBkv2vTowENlyM00ylOZXT5NPEFqu0B1FRRxn2ydiq3wPckrjdOscaPktJv0ElpRPjQlC
 tzzclYLwmccyAKsI/koGQbcT7reIj04bwY7k8m73pg78YlpsItPUMQOAa5/Zya2gyaG457nVw/n
 tYRte7qWKHgDj3+8GrdQApGf8Y9f6hDmeiK+nTz2FgKrSZchawrtUZVwjU3I88PC2AqOE1seI9P
 1uLaPPj6jtLiPHno=
X-Received: by 2002:a05:620a:2912:b0:93c:c987:7f70 with SMTP id
 af79cd13be357-93ebd211b0amr457762385a.21.1791571695266; 
 Fri, 09 Oct 2026 11:48:15 -0700 (PDT)
X-Received: by 2002:a05:620a:2912:b0:93c:c987:7f70 with SMTP id
 af79cd13be357-93ebd211b0amr457757985a.21.1791571694622; 
 Fri, 09 Oct 2026 11:48:14 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.193])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bbbdd75sm58588245e9.1.2026.10.09.11.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 11:48:13 -0700 (PDT)
Date: Fri, 9 Oct 2026 21:48:12 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Shivam Rawat <shivrawa@qti.qualcomm.com>
Subject: Re: [PATCH 3/5] arm64: dts: qcom: nord: Add Adreno 753 GPU and GMU
 nodes
Message-ID: <ndwyviaeqyxuoh5jbgapqumgfyli5wegmmvejurauxwsue32ma@f36ik4usw3bh>
References: <20261009-nord-gpu1-v1-0-a06a6c57bde7@oss.qualcomm.com>
 <20261009-nord-gpu1-v1-3-a06a6c57bde7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-nord-gpu1-v1-3-a06a6c57bde7@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: CPgt1QTrm_8RNmRVq9wVfuEDopBus62l
X-Proofpoint-GUID: CPgt1QTrm_8RNmRVq9wVfuEDopBus62l
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3NCBTYWx0ZWRfXxcfKhCj+0n/3
 okZsgiOn/UxAJy28RcTjx6yb+WHrpL5rk7JCtynBZ924C9rUuQfH/8r3wNFRI31s8vLX4m/2Fzx
 nbYwU1sYJnlmTRwXeDMtsUnFYywhDcY=
X-Authority-Analysis: v=2.4 cv=JuNkP84C c=1 sm=1 tr=0 ts=6ac936f0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=EiYrS7xXfcF7w+nkr41hpQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=nvc3KPOFl3TcXWLbZhUA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3NCBTYWx0ZWRfX2qLu05RZlYoY
 ws02GvzMwit2EbGnHpTC2Dq+jLZrgBv+aidAQIncLu93rJhbMR+/p4e8ppAsgNseFLOyrs1R1c0
 cYzEAYe8/SIMYX14hfB3hLvQ2xb5+7jFZmdh1S4YLeb7LcyXWuKGKayuCgmk7x5GjeRjnBT6Mgn
 KjtNVCeK3rGOkb/F/6BTPixeR+bNXfbS/44wIAyNikfiJyOFlVLWCs+6LGm9+Fc8ciVj+HL+8py
 CqwSx3akkITrtsb/xy0hM8RQhqjxWNNHp14EnmexB5bjWPE5KHbxws7UOsDWy3dAKShqet13sM+
 0RAcfxN8Kh3MHESg7dqbgRIIcncoC+4xFLf999/fCBSzFKreJg526KwfcDtkk+h5a3UWCbQIzSb
 /ASvNzuy7xhqm+8SMQEWDVg/017Jiau6F1Y0OSDdry/3rmbTuM9SHxsycOK8r0vDvXAvoi5QGdV
 PV/FXsl5GLpl09Fa+ww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090074
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

On 26-10-09 02:36:37, Akhil P Oommen wrote:
> From: Shivam Rawat <shivrawa@qti.qualcomm.com>
> 
> Nord SoC integrates an Adreno 753 GPU as its primary GPU, belonging to
> the A7xx Gen3 family, along with its Graphics Management Unit (GMU).
> 
> Add the GPU and GMU nodes together with their OPP tables. The GPU sits
> behind adreno_smmu_0 and uses the gen71300 zap shader, while the GMU is
> clocked and powered from GPUCC.
> 
> Unlike previous Adreno SoCs, where the GMU AXI clock comes from the
> single global clock controller, Nord splits its GCC into four blocks
> (GCC, SE_GCC, NE_GCC and NW_GCC). The GPU's AXI clock,
> NW_GCC_HSCNOC_GPU_AXI_CLK, is provided by NW_GCC, so the GMU node
> references nwgcc directly.
> 
> Signed-off-by: Shivam Rawat <shivrawa@qti.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
