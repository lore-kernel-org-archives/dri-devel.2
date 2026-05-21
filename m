Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF74CD5BA4
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 12:02:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C59F10E410;
	Thu, 21 May 2026 12:02:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MagZcBaR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FtZqldsJ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8B2210E410
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 12:02:22 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L99oCE3118990
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 12:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bbdYJ37Dj/mkaWuuJiiG0P19drg5U9tRkBmSfdsb6f0=; b=MagZcBaRIG6HWzcq
 yVXNpicx44UafHv8rsJwH5zYonq6RsV+PdmG2ZQS8IGjJY2tZAWVFw70UyCf9gBO
 ymZQhNlV3UX/QicHsgZcowXhBbUvkGUmQWsoJRJ9tHMA2PAVbjzXrsQ6kb/ke4Kn
 4xeMUZ7SrwV1Lj8TXg2jxnWyqRbK2eImpf19SJ+pA9OnZ2DuneNE3GTlMPnjgxKK
 uMgfexuyza8GuIGIugEIs1BAHRJW7tJ9+bbkFJ6wCC3iBpxuNci6ZCaxvRu+YFVF
 P9Ovtr7sYLtk9tBr4wPlepuebhF5SfmnKNieQijAKPBBXO4XzPf2GT9Mv87ESR22
 s66R9g==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9r962a7m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 12:02:21 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7e5681f8f12so9175632a34.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 05:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779364941; x=1779969741;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bbdYJ37Dj/mkaWuuJiiG0P19drg5U9tRkBmSfdsb6f0=;
 b=FtZqldsJKpmD7konE69EchWLPqiKUkHQFK5VloXeELbe1egUTpjXImGS8BVliVIci8
 TJY7N9ZduWC1Qpv92W1Rtg05l+inv58fKFpjBN+fQz4+e/Y7OJ8hGqAHRLTZG8Z8S7pc
 F4pBOLLkJyIh++YZ5Yb9B0al2hQLVcniYgcHbNcNuifHwfIkQlQvj0OAnDNePeUZyhDP
 /KTHYGE0bYmZzIsoHTjZJRkb3xKP3vsD438vcmn8c36/hX00W2X/+I3S1hfr4B/sJzG7
 U0C/XZzUKQ4Hw9ab+4exO0xOHNolz8mMkAavrwEHyjst9iBwuGR26EfcJUwrxss7spwq
 2Mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779364941; x=1779969741;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bbdYJ37Dj/mkaWuuJiiG0P19drg5U9tRkBmSfdsb6f0=;
 b=ROuXWZm7KqRAHzDhnE7UViPcOAZ5wiyQvdPLVDkuZaF3Mwzr8vyn+050vnWckH365M
 2gXclJrXsRJKDf3OsT97F4Z+Q4LI8lbr8hi39aUyxNrwMJmVSq6eD+LaheQlKuibPCMF
 fqx79JlTKkNEEdFtqqVpwiD1uHkIk9G4pXoLpPDhb4QFtnbSGbnA30fz+eKs7L1bFZGO
 dxwgftWH+NodNjeeRVCa2YYMxsKF24QAanRA7l6r6rXU97SA9pJhHHSOEFf0Y8/J8coC
 F8bEtxnuaMiuTIdHfDYcnhpGcOJxDEnET8mBdIvsba8gmW0IzBhLLm4HgfTkz31d1H5L
 WMSQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/71WpvO2D2SSOm7gkXiaJLbzlF/EmGZz8sEOEhcUvpQRMTWFNvuNygTi1mI0pdPUdHalttsieIEA8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzrjh0EIOa4TZ/qCE7X/gdMkKKbLY6soTi7XuI4Y4cinTAxUhrM
 shLbIWBZ+v1SDip33i4lzdCo/SsGDTzD1j++V7PFO/sdAVXQu64S8VFNu8r+OpaQ5sHj6lud09B
 8XzucsUtzzeIHwIjx6RzcoxtGyUHfzDg1Gk5L7ZuWwXC3O4ArsVOkVmlvNisaWToN/OSBvCM=
X-Gm-Gg: Acq92OGTd6fbNSqi7zfdXoGrUU4cDPf7WrD22yDH9f/AeVYNZoyMQ3bkKYN2lMKDoBa
 oQDJFasUG+Lvwvxw00I1xVlF9aUSIVvoAn/KodKbB1RjbK96HL1BoH6KXFgmtfUDnpFq1ppSnkr
 wVSCNSAh7cyhMuRnUXWt/nn20z0vZL9IjksisRXYrnUMbfoIAjvqHp2/QI5fFgumrXSOpYu8FI6
 jDagVAJtTwyxcTDnK9veOd469bRFBPNlP2FQ7h0b1in15HZlTzaQIIE4fqVty6bWscB5pjownQ2
 TSMYWXQpWuSBvPSfczzTK/svwhPBAWMBulZFf2Ezj9ke5p8fx0B68E0Dqw//LZfOUhiDyQLJyDh
 BwLfU/5WyVd+7W1xO5sWki0+Jj1QjCKsJWc05ykqB1ObQb6IcYcGQTJFggjYeXVgphYxinXnF88
 5UHryXyFZYzCqrN1ePDaYl8YjDJuq9BjEN9m4=
X-Received: by 2002:a05:6830:660a:b0:7dd:e032:3cec with SMTP id
 46e09a7af769-7e5ec496808mr1186782a34.21.1779364931182; 
 Thu, 21 May 2026 05:02:11 -0700 (PDT)
X-Received: by 2002:a05:6830:660a:b0:7dd:e032:3cec with SMTP id
 46e09a7af769-7e5ec496808mr1184598a34.21.1779364912547; 
 Thu, 21 May 2026 05:01:52 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa2f144812sm195067e87.42.2026.05.21.05.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 05:01:49 -0700 (PDT)
Date: Thu, 21 May 2026 15:01:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v20] drm/msm/dpu: Enable quad-pipe for DSC and dual-DSI
 case
Message-ID: <owodrxvpxp2uwfd23feiavm2prngx4zc26zqbjypuoig477olz@ezxzy3omabem>
References: <20260415-msm-next-quad-pipe-split-v20-1-bc1fdf140b81@linaro.org>
 <177928444226.2567181.13284983255649878415.b4-ty@b4>
 <a2gwkgdnbwp2wfunhmdhm5mwqolzm6fgb4ex6khkzy2jh356tp@dcauzez4445x>
 <CABymUCMqto2namFoSfqgLyoAUwva8xHw93yUUJBqLrZg6+Avhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABymUCMqto2namFoSfqgLyoAUwva8xHw93yUUJBqLrZg6+Avhg@mail.gmail.com>
X-Proofpoint-ORIG-GUID: 5TYmXC-nT3KC4eXbyf5LcI1YrQ9xPyCh
X-Proofpoint-GUID: 5TYmXC-nT3KC4eXbyf5LcI1YrQ9xPyCh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEyMCBTYWx0ZWRfX1ZgFL226sb0w
 dO3ef19/BjsVRQj7rKl19k2Y1/5w2iGVsYr2VZ1IYJPqpuW0W0YgOHKOIwGpC3lL4vVYXuHay2J
 YXNHvVJMzcZX/t4r6gFr2a/zJemHkYPymp3oVYdh3vCGVg3rsUnYi6b0Kd8Tqjjejh9mTsLlpbi
 O0RJ5Ey9Vsb1eodjXKADzK77FT6ycxyespss7GMBW4MUusCx3Ox69A+HvF48q3Zrvu2Jg1DXNCT
 ZU4OvbJ7dlfANZxYaHN4L2bEp6LnNQc5GxiJwoZWjKs5Q4sh/J96eLceZvaVOLIoZ6HtRJlad6U
 iMdUjxt1OdMSrbQKWUXQwcSnC4OXtCQJ2aus1LkhSr/Or/Sh+XaV2Lmgo1rV5Lo+GgLUUNgDuSI
 fIG5iMOtS5AMjhoxWI1Qc+1RjyiWhriPGW+5Q9iXodxkgbIwz6ddXiF69jhrCF8wRmzszQDstoW
 NClVpXLR0lvdKnAiUWg==
X-Authority-Analysis: v=2.4 cv=GqFyPE1C c=1 sm=1 tr=0 ts=6a0ef44d cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=e5mUnYsNAAAA:8
 a=EUspDBNiAAAA:8 a=82_qQ5QTqq7nI4W3x4YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210120
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

On Thu, May 21, 2026 at 05:15:18PM +0800, Jun Nie wrote:
> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2026年5月21日周四 01:41写道：
> >
> > On Wed, May 20, 2026 at 04:41:29PM +0300, Dmitry Baryshkov wrote:
> > > On Wed, 15 Apr 2026 11:15:11 +0800, Jun Nie wrote:
> > > > To support high-resolution cases that exceed the width constrain
> > > > or scenarios that surpass the maximum MDP clock rate, additional
> > > > pipes are necessary to enable parallel data processing within
> > > > the width constraints and MDP clock rate.
> > > >
> > > > Expand pipe array size to 4. Request 4 mixers and 4 DSCs for
> > > > high-resolution cases where dual interfaces are enabled for virtual
> > > > plane case. More use cases can be incorporated later if quad-pipe
> > > > capabilities are required.
> > > >
> > > > [...]
> > >
> > > Applied to msm-next, thanks!
> > >
> > > [1/1] drm/msm/dpu: Enable quad-pipe for DSC and dual-DSI case
> > >       https://gitlab.freedesktop.org/lumag/msm/-/commit/218eb06a72bf
> >
> > And I'm going to drop it again.
> >
> > I tested on the SDM845, it tried enabling QUAD_PIPE for the follwing
> > mode, which then broke the display.
> >
> >         mode: "3840x2160": 30 297000 3840 4016 4104 4400 2160 2168 2178 2250 0x40 0x5
> >
> What's the platform? To enable QUAD_PIPE, both virtual plane feature and 2
> real time RT interfaces are needed besides width exceeding the constrain.
> If all conditions in the dpu_crtc_get_topology() are met, why QUAD_PIPE
> cannot be enabled on this platform, any other condition shall be added?

The platform is SDM845 HDK, it should also be reproducible on the RB3
platform, which uses the same chip. I assume the difference is related
to the active vs non-active CTL (which means that QUAD PIPE needs to be
disabled for all platforms before 5.x). I've asked my colleagues to test
quad pipe on other platforms, I'll report on it later.

But it also surprised me that the code selects 4 LMs for the 4k@30 mode.
It should be prefectly working with just 2LMs and 2 rectangles.

> 
> Regards,
> Jun

-- 
With best wishes
Dmitry
