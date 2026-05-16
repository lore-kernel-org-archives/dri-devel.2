Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3997BCD4F3C
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 15:25:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7094710E4C2;
	Sat, 16 May 2026 15:25:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XfJC5E11";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IkF0/kUs";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 675B010E4BD
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 15:25:26 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64G3gH7D1903013
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 15:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ruTiYkp6aQ4RGoWwbnJauZaAMDDWGd+o9GrPQbFZ+f8=; b=XfJC5E11Rq1DyuEi
 ITjtDr9G2xL5vBs03avzXduynWyRogEwU/A5BMxtkBJ/UvcU3Uc/LaDcfUPHFzja
 8aJb1lnJnz9ZHr4jBBnacBsuOgccqHA2xwbkcgmm+ukwDoyvtbLjabIAbNg9BrcQ
 /4HV2yj/Cyw6WXZCj7gxL9BMcw6heD86/o0TJwP9x05yxaGD3phKfHyaOntmIEGy
 1ySjLQ1XT674Uu7+oSmDL2ywZe/aW2H9TvZHBMsZoSFDV5TMbkuMTWcuVJO7hfKY
 ZvZ/jvCyNr8MCADYUKveDjNxZwdNcF4ZTW40/ouXCvgGXrdcf6q6q9hweBJu0aMz
 YXTrcQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gwm94x4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 15:25:25 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5165d10e036so4772121cf.3
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 08:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778945125; x=1779549925;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ruTiYkp6aQ4RGoWwbnJauZaAMDDWGd+o9GrPQbFZ+f8=;
 b=IkF0/kUsWpCpqqPeifV9ycb03v8FhrVAPUVuXDEDshrGdMWTJuGELE5kQo7QSP9OPB
 VkN96fo8Dg4/vvrNArjfT9+Np6QWJ2ufPbdmr/yK3CGcfe1Bg/dfkpLlGZYkdvsTu46w
 THHy/8XTmd9PqBH5oZKGdib7tCNWDyopy7ZoRwsqOiHOrCOBvR/GASnoHtjqIsySdf1n
 ig49z3xy8DhfgyAFmaqqi4aJNgKiHDIN7CU4CXjy+vtxSnONwSrFO5YKEZ3mTM+9r7d8
 /Hc7uOHH4/sgne08hQPWntfJ09BRwpy3gUHszvelpZ6wOKlTRTl9EDFFJHViDnHnjWPY
 Ws/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778945125; x=1779549925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ruTiYkp6aQ4RGoWwbnJauZaAMDDWGd+o9GrPQbFZ+f8=;
 b=HTZVFFh7hwNhCLnP3OAbt0vv1XqEAw+ilxss4tIyl/0u3hXChjtHFE1UL4C5BfsYxS
 jFfNg0S1kA5gCFzm/R86oEfrS0Kg/7M1PE9XVlnZHDE/NUIcOjwMoNBKggJlcK8RfkNO
 j6IsasO8/iJR+rRK1rf68QAT+FvUJ5DMbMXLBTjIqrRQkp8lW1hZeEN0wwOnDgCZCY4N
 oeT8ALeyzl0zFRrqLUVA3Z4RvlVoEDK5xCYdZxvhmrfRVr0cny1oBpkJFvdHPvieZd55
 YVBZfs7XT9RbC0BR5j3fMbhXwtyt66LCx33h73Ch7Uh/lAJoI+LLWirm/mMfhuBuuwKV
 Savw==
X-Forwarded-Encrypted: i=1;
 AFNElJ83HS3HgvOUBijwh7iYMUluuNJ3imxy6NMqpYnMng++f05gNju2sy0PktvJJwo1KYkbExwP2sdZf0o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxARqgzSvcNQliKSwz40U4jws6Y5aARYBR8LxBUaUhUyk+G4TCQ
 fcgnO+kjsEWdg1j9GhyoCY/p1pPj+XHJDJ4twLOCADACjlpZrDLAAHFYIEgHl/E5W5qCpEGfg6P
 Ige+jgT6Hluj3kPeE/4ryZOIuyr14di5ILDqPi/74RAbANbU3wCcqk5SISwnS+jEFPPiAKJQ=
X-Gm-Gg: Acq92OFC498rCPn7nzFimy9sBANzhTK1rLa/J9kvQRtj9Y0iK8HXFxAumzEBifD03N4
 jJMQZBslwmw/HVDiMHOUMZMSs+R7ZRaQWs07ardUltRrF3eRHwiwyXX2p46gGvHNyRMX2kDU4QG
 zMjzkEo3CDCsF4Wc2Wuo2boaSMJ8qeJvvACbmU3lX6+rn9lqqlHND/BExMlyySAOfsBsppAqDvg
 qvvM8EnU6geqydggQ4MJWrAnPOlATG8fd1uELjzlBboD0pAyfJPMvePkp9XL49oQ1nxZA+F4vCF
 j+LqFsySOJyzapddUxt5Y/1kr6lzm/JVmmEHj21kRh6K1feWHinG8isK73p7OOQk6kP46xWZHvy
 RUIJcUReh4wwBl9taFw8vrMJQX/2ERdy9W+kS/1yJ/JfxfeyWShcY2Nx14JJcmdxEngAExVe4z+
 R+sMC9sStv3mKvDDe4CQ2YwOO3kj61vzH3qTW7u4UkIpZGQw==
X-Received: by 2002:a05:622a:6189:b0:50f:af1b:1dec with SMTP id
 d75a77b69052e-5165a2c686amr113177271cf.40.1778945124523; 
 Sat, 16 May 2026 08:25:24 -0700 (PDT)
X-Received: by 2002:a05:622a:6189:b0:50f:af1b:1dec with SMTP id
 d75a77b69052e-5165a2c686amr113176881cf.40.1778945124076; 
 Sat, 16 May 2026 08:25:24 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164cd939sm2057972e87.70.2026.05.16.08.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 08:25:22 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: Fix Kaanapali CWB register configuration
Date: Sat, 16 May 2026 18:25:16 +0300
Message-ID: <177894506980.2448625.4812573221754001186.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428-kaanapali_cwb-v1-1-51fdb2c65498@oss.qualcomm.com>
References: <20260428-kaanapali_cwb-v1-1-51fdb2c65498@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fgcglkFNQl9WynFoK14fAkvmKh3rfDdf
X-Proofpoint-GUID: fgcglkFNQl9WynFoK14fAkvmKh3rfDdf
X-Authority-Analysis: v=2.4 cv=W/AIkxWk c=1 sm=1 tr=0 ts=6a088c65 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=e5mUnYsNAAAA:8
 a=icegP6A5NOjrOqdk07MA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDE1MiBTYWx0ZWRfX+rZX+Yd4iadQ
 cYCJnbJAHPMxowLGunVbEuv2UPbLCc2cP1RhRDV4aAcxTCT/e5tylaMpgbLG7JO4nWY2vmIIeel
 D/MUBj5JHWcjIQeZx+rHX9o1XdmzGO4yzmHpCodFbAt4G0pH/tv+UQrTBiyQYG0DSYeDB4EUoUt
 RKvJw0iKPz8VvdOIhYQEf4fQYLQpURDwQ793t+4o6/GN/z4UCuvTYSZftk3y4oW9bxEtt0RQ8bI
 Xada3AvPoSd2oAWVM7SVIbBBHkRvm/ZGHWznP8nh2WfMNORqMeguDropvutLmlfly/wj4VdUSSP
 W+0/lwgbdmvOkNvSJX050aV5T5r6Ri4GyoxP37SG/+7wpAv6P2T4znE3EOoB8HPK/z/IjNKjilr
 ZSTTRpn1/xQVQGue61T28gTkUxmvjtNW9Bv+aHOCzbuG6IuwV1PvDuskd6IQmbt/eA/on8oPCzs
 4cW1Qm3wePhTv60w0AA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-16_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605160152
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

On Tue, 28 Apr 2026 17:14:25 +0530, Mahadevan P wrote:
> The Kaanapali DPU catalog defines kaanapali_cwb[] with the correct
> CWB base addresses for this platform (0x169200, 0x169600, 0x16a200,
> 0x16a600), but the dpu_kaanapali_cfg struct was mistakenly pointing
> to sm8650_cwb instead. The SM8650 CWB blocks sit at completely
> different offsets (0x66200, 0x66600, 0x7E200, 0x7E600), so using
> them on Kaanapali would program CWB registers at wrong addresses,
> corrupting unrelated hardware blocks and breaking writeback capture.
> 
> [...]

Applied to msm-fixes, thanks!

[1/1] drm/msm/dpu: Fix Kaanapali CWB register configuration
      https://gitlab.freedesktop.org/lumag/msm/-/commit/d03279f0d9fd

Best regards,
-- 
With best wishes
Dmitry


