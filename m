Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C2DCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 12:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51FB210EE39;
	Mon, 12 Oct 2026 12:21:24 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3C0E10EE39
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:21:13 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC0WI12252662
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=q3lb9in910fJkfWVBwHovBUr
 JZ9CnyxdzxZK5FoBJaA=; b=bm6/B2FXBO5AXh2KjISbNO/fYbm7R7VRBFK5EPUp
 jBjk6/szNDrZQYmZXlNaRFW+srEv/hc2TmBQ8l21uUsEzBBWtipk2XHcxbsFj//w
 KjXjIxB2ETmnK6d7puiNRDM82V5kY/HKAUYtOjoxtJZn3KpPxIdi0hFEqQX1Adu3
 XZTLgSbHmMpLI7sfBjKkf4ohdCui9bRhLJs7g+IncDrtAE55TPwMmKxEcQfY2kww
 MaS4fQwrFf2LLZ7Kn1FAf2wBOosgvlgSZgxH0pZ6WDRqedRc4N6g3vB7ZPdZxe1i
 UZ6cue79/63CMpKJhsJ540P5PfXuSonW5Th/VDBi5aVfKQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8j712xb3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:21:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93e46b4b700so337364485a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 05:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791807672; x=1792412472;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=q3lb9in910fJkfWVBwHovBUrJZ9CnyxdzxZK5FoBJaA=;
 b=a8en81jm09onfgsXOMcrj16kNZnGee6lSeMMouhueClGYy4wGdf4jL9P5hm9J9MB67
 9vWXrlC1SJ8RI3kQl1HOtYHQTsR/0saM1m13kSUGeH98pVpBiGq7GidREAvUBbYZ9t+t
 iH4TRejcRHX74mqqCtmWna+TbSWlhEP17lsDbV8P56Zuv2N5/5k0GTn2ZK9pTq8LBO+7
 H9+VrIOqA2f2zLNWBJzzFV2WTdLo3E9Uhrpgc18p0LL1Sm/zfmZYokGB68cHe6W91uIa
 4xJvMllnTwUwocubTEZHG3tb6bT2jw39CP6nqJ+knF0+cb/KOlzJEpB1D6+A6nY4boQ9
 5z+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791807672; x=1792412472;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q3lb9in910fJkfWVBwHovBUrJZ9CnyxdzxZK5FoBJaA=;
 b=Ra3w6CbUoBMZpdahrcazG/yRRm5dxGzbO7VxLEpQ2wIcrvz+ab9aoCMEmGs/RO/HIn
 THy7OiDcWm5+Ou9kOL7oxoo4JUJQ5b7WApxLLymMEUBihZ75AZeqUcscxx9YxFyJ14ZM
 YZ3ofYGpFGxnSlUEvYT1Worxe1ldYB6wBGRqJb0jsK1Gkw8kDTmmteATSl7ZGUfdb+ul
 +u3D01K5A4gvigkEX1y9RFlpNiQ1Sfr9r8MVtwSdA2CIfuyKAWbIlM2lbVucWkr1jjbx
 lP2PHysQWzgkaVYsv//Pl2hLpZMRxcA+0keqHuqoIP02wIukUhq0aT/gkXGQK7Ybity0
 BgbQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNBTOf6nhEdjsSuPo1Q5nM7Ezknudjy9AA9iL/41DXmF0EodEIIOiUf0IOrRgKScbfbP5/i6kw6+E=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLzDF1q/IVKEpPsnTp0cg3PiYMlN4JMdzVEPL4+frYjCuuo95hQ
 c+zpmv9FDs0pKHhfnVyp/Af3f0wuGBtftcEu8HjlY9jxtuV9illF9RzmWlfhPD6Ci6sFnAD5QEC
 El0NIZHY1URVUUVp1B+TyzntzdaD3cBX+gAcHHAU0urkB8NP3lJj6dap1gdCkmsmO66UzyaA=
X-Gm-Gg: AYBFou0biVGxPgKjGfwlLAhIxhwWxPcCFzqs7KSWAkUQkNTFavh+skiPqCVfx1P7RyB
 fKRIgTuBsEM2wn2ZEZDWWWLNWPR01WAVFBXFp533hQJ13SOtE4mMOKLWJ2oY0+qfjyUWe0DXCfP
 ihYWcKjOspKnNHHdIXW+w7/xYCPMzg0l/vEkVLH07kryEA0qU24uk1L1XgDO9KtsuPGPCTABngp
 iU0o9sUzBESP8jryuU5SiePSKaMnRZcFSvWKifEJEgzMqRhVgU3ymk8eEaApdhzoZWFlEqOKVHN
 FiuCwPr4IG6bNtFb2fzJvPUyMuzcFuUt5bzqHa4Muf/UeVFAavI7cd+q7QP0CwTlsAw4XRibHh+
 0TKBcda9iRJ/bl2P06GXYrkwUL5+eUJ/NgFSBjMmhIMXmMFpx6P4BWQSdiUsuUD1ChEopJ0yqGH
 jvdplS73PN/qxf
X-Received: by 2002:a05:620a:6489:b0:93c:6f06:8f7 with SMTP id
 af79cd13be357-93ebd20830bmr1398728385a.36.1791807671970; 
 Mon, 12 Oct 2026 05:21:11 -0700 (PDT)
X-Received: by 2002:a05:620a:6489:b0:93c:6f06:8f7 with SMTP id
 af79cd13be357-93ebd20830bmr1398724385a.36.1791807671463; 
 Mon, 12 Oct 2026 05:21:11 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9c3cd5adbsm27615531fa.29.2026.10.12.05.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 05:21:10 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:21:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Xilin Wu <sophon@radxa.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/6] drm/msm/dpu: limit the mode width to a pipe if
 the LM has no source split
Message-ID: <qavtboaz7zcxmt2pumasohhla23b7so5tm53nqtio63x6i55re@iemg6uqgecxk>
References: <20261008-lm_fixes_final-v4-0-fa986071c3c1@oss.qualcomm.com>
 <20261008-lm_fixes_final-v4-6-fa986071c3c1@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008-lm_fixes_final-v4-6-fa986071c3c1@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0OSBTYWx0ZWRfX0KBM7LJHC3iQ
 WJSpkTfVGmUVTQgeErfxo151vzPqRNOPFT9/SvIUvvo1juoyfPEM4gXTxVpaTKCM1M6kFRsRPde
 rKSVAeo/l2eMJ1CMHYsSoH6HVcftQEo=
X-Proofpoint-GUID: eO_G4LSsVrp0rhdHsXeE5d9oBDrav-Aw
X-Proofpoint-ORIG-GUID: eO_G4LSsVrp0rhdHsXeE5d9oBDrav-Aw
X-Authority-Analysis: v=2.4 cv=ePGGH3p1 c=1 sm=1 tr=0 ts=6accd0b8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=RCAr_VjVQrktO2oC:21 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=jQUIR41XILnKj_BXT3oA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0OSBTYWx0ZWRfX1HfQY4NTydqL
 ZyEqMUVBEEZC3/6d30QRmXw83PwhCDA8A9q45O1h+AHRMLMm7LWL1QfoSIDbloTB5rG4Ndp7FyQ
 u4sZVfvbO7I32cpBDoZnphkwH4/o+2ruPDvl6YciM99c6uMFfQqzrEe1Y6chNLZ1piUSmn2DsuM
 5tbChxU3Rv6pDpfHs+4E6XMa1Np0W5eIUf73n6p45ak5pXcWoreyyG/Echr+UUlAgzq7SZJ9KTw
 6GNdZc61D+KzsLmOtIXC3PSDxNzn3CRcyMhDM0PceOFdR/Hl7w+yWFR26TFHls1dkKcpynJC9gA
 8XLo8IAi2WqxXFwT3eEGRnWLXz8jOatK0/gDFbW5PQsSLFq1Nm94L4i9JuYhxC3iz0Ec/dn7DrE
 067SUtVKIEH+yrENPVg+nLQzkh1GY/S9ZRrqBybbsuD4XAAn0sZg9qBZ5iNyjT9VY/s5zaa8m2P
 7m3v+s1NsHnqAIeYCqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120049
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

On Thu, Oct 08, 2026 at 10:53:52PM +0530, Mahadevan P wrote:
> Layer mixers without DPU_MIXER_SOURCESPLIT stage one pipe per blend level,
> so a plane is fetched by a single pipe of at most max_linewidth pixels.
> 
> max_mixer_width used to reject wider modes. Now that the mode is checked
> against the PINGPONG width (4096/5120), keep max_linewidth as an extra
> bound when source split isn't available.

This sounds as a misplaced patch. If one of the previous patches
over-relaxed the check, then this patch should come beforehand.

> 
> Assisted-by: LLM
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

-- 
With best wishes
Dmitry
