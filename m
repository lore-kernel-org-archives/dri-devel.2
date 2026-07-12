Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0DDC43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 23:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFB2E10E394;
	Sun, 12 Jul 2026 23:52:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aBZlC9PP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mch783Lx";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5FD210E4FC
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 23:52:39 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CNU3XM3768074
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 23:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=LxCHll1Aw78l1lcAz5g9/ywK
 BDMmON6JBEpVT0jGNq0=; b=aBZlC9PPWqL67IOxkDDTi2mza7EwcV0nf2AMHKoF
 mDq5UoVBJDh/lPhYX/irCs6CiHMIWwf4zYROhH7KMKjT6L96Ic8yK0N3/JlIQgfj
 3Xzfw3XYixQMb9HCsV7UfFzrkrrksDpFXUUqX83kmX+U4tAC0OijaAAAvyhwmitX
 vOamfTII84DKi6+TpqPlV7P3/YSi4tPU45P/eokm3v4KvDRpWELe6KXElmAEw/AL
 fwt+EZMIOCLP39EgigYF+NDnangBNt47XRqVzp9nCQZC4yAN+6Z1QcqoqvhjQiso
 Qr6QboCADCVjQBYxeR3msZ81sb3oKNNC8UL1ZwwmeDc8iQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbf483m6y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 23:52:39 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8efe7db1c42so38053026d6.3
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 16:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783900358; x=1784505158;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LxCHll1Aw78l1lcAz5g9/ywKBDMmON6JBEpVT0jGNq0=;
 b=Mch783LxsJY6dqj/D2fpfxeIH2AgWfr7tYcWePAyiTCEj8a6D3zcoHptYyCaEzvGLl
 y8xmg1MGuIgjdI8Z9WvvfE3RBZqZCSqwBukVPYix6p59Jr8+LqibuuQg7iYuS9GYGeqC
 XZxhMo+t5qdpJtn8DJ8BEHkSQho0oIt1vglYor3b3jyFPfSyunLs/UhDojZYqdyMzSHs
 ohGkokIULarrFadPSMhM9pvcg2CCdf/0MlWh76WqsxVYwerxktUczBq5X4hO1nmkHXRu
 H3Cjzr9AKxKDiYf2IIgtMqatjfqRL2UfJMlx1dmCaKH8Bv/p72xrYUO6jXgdNng5W5BS
 uyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783900358; x=1784505158;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LxCHll1Aw78l1lcAz5g9/ywKBDMmON6JBEpVT0jGNq0=;
 b=Ue8qo0yzeLCmL1ORn5u8y4ecqZ5hfpQ4aHxwjNi9Le2fQE6yEF2xFwIP9Hhf3B5Chh
 W4fdwOzh3ouhtty/SDC/tZpo+4l7FhHHU4AiS+t8xkerJTiwJ7JLzmG5AEPlqarZv0ie
 PYNZE/X6v1FdSmz1qjhwRiMMhc1Wml1WA7zZIYoUjn4Yjt/HzRK+GCtJr/jv9LuG6LsB
 aYwzsivwDBeN2IJSbIJJAguHBj5+xwqVpevld+Iy3MHzCEmU+IFjN5YEIyS9RBRmgVvn
 Q1MAjXQInF3MbkAod53y0/IQpbe/hSBwgaU7vkedvnoZUsP7BuekLIbMDmiG1rj/4XXL
 nABw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp5vkbUgWZ6LU/uQQXPc+eoKnz4aerB0/KOkBXJGusotIe8xwpc2vn7FeEPWRPZ20j8A8DHhNeqpmw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YygxSBzQp7B+xYZ0f2eOM8PQZ6bp2nXW5GbD7T4j7am/DO6HHKC
 dcHSIsTsXLH+cHoUCsJ8+DTnENLCDelL0Mi7VpnU5kjhMjDv8cvWC4BPByd0Iuul9FrbWuKdMJZ
 oBCJO25S+dknyQobildpADwmMnV57RAjqXLQaZ004FNNmwN3ISCEJVBDDpHFCHXdDEUdJsXo=
X-Gm-Gg: AfdE7cl1HFJjxvQ/d/jzZQ9NOXRai7cOvG8/2zIi4hVoxAWSOlqGjlo0OFuHXAMGx+x
 mRkLkbAqpg9GoDC7hwzUszmcijBI9EzdoRfaXOoKhvDNL60DAtx5WJn5AwfzUVZpiP1y2pKXPaR
 vRA+j1YKBXfRQxDkKuWpoYv5IcC+ZRibIieN2dizBkE8G35zuoiJGEZqH4i/Vqfh6nBnBbTzaHj
 KWcO01enx6Ivur1rZIeEZJS2YKfujbNBvZFVqANIA2kWN/e+7FgVbynhuNOdf2EFoXx2g702tYG
 ncYW/VzwB5PS0zJ0qOkyhBS7wOxf/SnOwW9AjEHPpoV70eqk7/nl7CgBSRrNYOAeCtcNQZPlJAc
 h46wZHWz0LvI6e8Vt14vaw/HWUmbqn23VVoqqTEaBG9t2dJ1ukKEAN26YhkMjw4EBvVnIspdcDA
 F8Ua9GbTXVjiukIQH4w4tDAe3K
X-Received: by 2002:a05:6214:54c3:b0:8f4:6909:2a22 with SMTP id
 6a1803df08f44-90403f494d2mr77299476d6.43.1783900358246; 
 Sun, 12 Jul 2026 16:52:38 -0700 (PDT)
X-Received: by 2002:a05:6214:54c3:b0:8f4:6909:2a22 with SMTP id
 6a1803df08f44-90403f494d2mr77299316d6.43.1783900357772; 
 Sun, 12 Jul 2026 16:52:37 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b01caa635dsm2441846e87.62.2026.07.12.16.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 16:52:35 -0700 (PDT)
Date: Mon, 13 Jul 2026 02:52:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v7 00/15] drm/msm/dp: Prerequisite cleanup for upcoming
 MST support
Message-ID: <4kiwp4uec7hebailwhgxqkansskg6v4msdnt55vdheqdjrcq2s@jjer5jiprygc>
References: <20260609-dp_mstclean-v7-0-ea04113e8233@oss.qualcomm.com>
 <b05487fa-e282-4236-8f10-016e7ee4dd87@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b05487fa-e282-4236-8f10-016e7ee4dd87@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDI1OCBTYWx0ZWRfX+ifE+ynQuV0A
 /JsY1BcyLLVM4Ewe2gW53OhOyL3Ml10PIdHCxOmn74SU+b/TqRXh+YFCwSbqIhmIA4undb57bXH
 vy9Pj7vbrVxsBipzDYRge2uRAHEKSAY=
X-Authority-Analysis: v=2.4 cv=OsJ/DS/t c=1 sm=1 tr=0 ts=6a5428c7 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=Rg_EiSDVbbziMxJWx04A:9 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDI1OCBTYWx0ZWRfXzKpsH/IhC55G
 xV5fmR1WOVFKtQuKn2aovUEuuFNo5ARh4jOBL49fSk5RWWpAWA9SPcyLxAgGh6XuYeZ6yvGPmJU
 JYsX1+ScTmAD2k8X0G9YWDyhGxuNdruIC4npTCIy3QAIi0+J0+H/9RfvDtvx8zJvH8X0LANIwqX
 XyIJOnh1FH/JvC5AmMnlZzU38iIU4l2mFvYYfc+CFgcI3P0jCb1YilnzjD7yrO3DcP2Da2ACYPW
 yd4vuStYtVAr8pdQbAA67+XT4Ik6fjZGtqP13TcgP0umBGDy55zDrd2Mmgrukn/d6i8BEILQQSQ
 +Zq5mPivzG6mmTZv/9lj+qDcK4jnpJ1MANX7mR47olTHF1dOsNOLggB7ldFL6zrNZz9e75vy9WK
 2GuVglYfSS6MGWm9Nu7cyR0AYwh5Mb3wXXOjG/BZENn6ZUckMtAx+tPIlSPWpfOZfQrlSrjD/Pq
 qB8FCrmSQQpyLPWnPcA==
X-Proofpoint-GUID: RttztD9ls4XxeukNrKO8yZSV7fBma0KE
X-Proofpoint-ORIG-GUID: RttztD9ls4XxeukNrKO8yZSV7fBma0KE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_08,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120258
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

On Wed, Jun 24, 2026 at 11:16:39AM +0800, Yongxing Mou wrote:
> 
> 
> On 6/9/2026 5:46 PM, Yongxing Mou wrote:
> > This series is the SST-only prerequisite portion of the MSM DP MST
> > work. It refactors the existing DP code paths so that MST can
> > plug in cleanly in a follow-up series, without bundling the cleanup
> > with MST functionality in the same submission.
> > 
> > SST behaviour is preserved end-to-end; no new functionality is added
> > here. The intent is to land these refactors first to keep the
> > follow-up MST series focused, smaller, and easier to review.
> > 
> > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > 
> > ---
> > Abhinav Kumar (6):
> >        drm/msm/dp: break up dp_display_enable into two parts
> >        drm/msm/dp: re-arrange dp_display_disable() into functional parts
> >        drm/msm/dp: allow dp_ctrl stream APIs to use any panel passed to it
> >        drm/msm/dp: split dp_ctrl_off() into stream and link parts
> >        drm/msm/dp: make bridge helpers use dp_display to allow re-use
> >        drm/msm/dp: separate dp_display_prepare() into its own API
> > 
> > Yongxing Mou (9):
> >        drm/msm/dp: remove cached drm_edid from panel
> >        drm/msm/dp: drop deprecated .mode_set() and use .atomic_enable
> >        drm/msm/dp: move mode setup into msm_dp_panel_init_panel_info()
> >        drm/msm/dp: split msm_dp_ctrl_config_ctrl() into link parts and stream parts
> >        drm/msm/dp: extract MISC1_MISC0 configuration into a separate function
> >        drm/msm/dp: split link setup from source params
> >        drm/msm/dp: move the pixel clock control to its own API
> >        drm/msm/dp: simplify link and clock disable sequence
> >        drm/msm/dp: pass panel to display enable/disable helpers
> > 
> Hi Dmitry, will this series be merged next cycle?

Hi,

Would you mind responding to Sashiko reviews?


-- 
With best wishes
Dmitry
