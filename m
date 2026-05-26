Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D17CD5BB4
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 05:46:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC08A10E216;
	Tue, 26 May 2026 05:46:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AQcjNZ3u";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QwI+XmT9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23FD310E216
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 05:46:01 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64Q20KaS3604070
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 05:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=KDy9vXC1Rd1tq49bIIsepsbF
 IYBji5z/KFPlG+PXtu4=; b=AQcjNZ3unsyUZEiT/Vv8mevSYCIgge/foyWgPge9
 g4MiGFrL0sCHfSSZkLK4BI3DpIq5/IW4U1GKjuejBtIjq7wD/cR6/U0nz0+SNTya
 CzKrIbs+SEXxaR7AkPX/XgzUHXQ8X4lsWcHNowxua+oX5jBMf/wBTS3gYw6e1Clx
 qRQfCv8mq8ldQyCxB9M5DL8diX2HcK3iiOAa7on3vkEy7VAZhp4MvxLA85Ca950t
 z+mOFwfTYIHvmn/myV8yAAKSj1WG/Tbk7+ngzhNfOrQjAqaAG5w6xeQEjdLT8hMm
 5r716ZJNDF0gSTv9dY/UN05mv7spGTYheYYc2T+NdT/4zw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecpyqjewj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 05:46:00 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-6751db2792dso1733695137.3
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 22:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779774359; x=1780379159;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KDy9vXC1Rd1tq49bIIsepsbFIYBji5z/KFPlG+PXtu4=;
 b=QwI+XmT9E1sTTJOlCjYPTnanb6h7BKWrtWMp6lNMzLb9oaJ/xIfEYBUVlkE2rWExLQ
 NpicfZfk54gt+FxCSmzxxHkvkUoBCOIWrA3Ecxp98kN1Y0Ekc77LYgQXbQn6jnGDrApG
 33ddEZ9rHlztvLfBCA2dP/nx15BfiIBWjxsznRL+yGkJJucxeI5b2XCHpAwoxv4IFk9a
 0Krf8y1RAhwLKBiwBqOchpGp765subpR/NZ0hZHAG49P76YyOGTeBJ8zjhXOoJS7JkNs
 5tQAGqZZ3tfYGou6i9FAd2vSiejCbdyoEQjWVrs13Bwz2Qfj50+4ihL0mGM7cYlziQdk
 hzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779774359; x=1780379159;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KDy9vXC1Rd1tq49bIIsepsbFIYBji5z/KFPlG+PXtu4=;
 b=iLCqmDz6zlvSgJ6hekt9E8oEJGaVTHYF10+pGdvOWUa9nbxsArDD6POy5kdn5H0hWA
 3BOAlqX5rCQ95f7rVQidevjIETtWNAekwwIT7CKEsSO5ax5zTYXQm08ihJxb9RjC1l4B
 GOcagbaex69cC9uoHzVC12TZrhREvcE+lR2yOaaJ5B4KAwesFJcZQn7kzySvt50+4BDw
 pw9tcrmAF/r1h1pzueNuycdAkqRyiFoSlhu15SyXMN8bVr/LzNxNtxCuPZZw0+USygk3
 jgTY2tPHzJlxGuJMkU12e2QF1uCw0OvPNyA60P64uJnVafK3oU6CskWeE2YwM2AKeN4D
 YQDw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9FifXb/YG4Qs8O0+fQqDyVa4d5k+FJ3JccklW+Vd8z398KQLuRYOpmFIP9f4IocUA2YRlfQspge4c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz167Sn6MJ7yqD6LzNnDuwJLKGqsTIfl5pSIGxJmR6EoeEzLsoG
 OAVOhQjzf0EdN8ytXH3v7cJPnErpP1zeC3D3pbGhbV4vB+iZUtQV3Fl6fnQ9fTYgEf5uyVhe1ZB
 S/X1t4CYGsbCg4BgZ95mIw98ESeHIROHm7AcjNgSIhzvEYEgXbh9gKdo3rJLQGLVhpp7QUHw=
X-Gm-Gg: Acq92OHoSXTuhou/JCw/Pu4HIIkqpmmF0n/1xzhMuQzQA8wobijb9FDZbxybI7e8zUx
 xtGDF6GJZYU7xxLdaHvd0bl7RFHUI8ngSANUPaGJeQGVz0l7MtcUl/n2Wvp/hUK77MEE0smxXhX
 UcA2TXQSPU69rLJuyRR/9y4XAGgDfwrW1xEI6GeM2PiX9own88McCM8OKh/isoGhgU4BJKm5D99
 OcrxSF49K9CfhlGgH11GV/OuMsbDKI7E1IE7yXDsdGjb8G9QrTaYB1fGuKKPG+LHKnip73c95TA
 rWB4GxwibItViJaOzsGkb31nJABqSa9bt2tGYB6geuqXGjkWCQFFdii5mNKXY99lsCIpplpUDTY
 FTXDhiewQvXz84DI4/FGJIZYnRBVBpluipE1qIWjbKGkUFsL96i7ke1icmjp7n6MdmZiFecQLQ4
 rHQUF29H/LC5egIZZVivLXnCeteMQSIG7VHCk=
X-Received: by 2002:a05:6102:390f:b0:605:7a45:c7c5 with SMTP id
 ada2fe7eead31-67c8a0759eemr7094133137.14.1779774359378; 
 Mon, 25 May 2026 22:45:59 -0700 (PDT)
X-Received: by 2002:a05:6102:390f:b0:605:7a45:c7c5 with SMTP id
 ada2fe7eead31-67c8a0759eemr7094126137.14.1779774358957; 
 Mon, 25 May 2026 22:45:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa4623be9asm200944e87.0.2026.05.25.22.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 22:45:57 -0700 (PDT)
Date: Tue, 26 May 2026 08:45:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Val Packett <val@packett.cool>
Subject: Re: [PATCH v6 09/10] drm/msm/dp: turn link_ready into plugged
Message-ID: <3jezpw5umag5pfyn6gvzqhcea7kpdg666c657rofwu7wzgpj7b@suwc7wn3poex>
References: <20260524-hpd-refactor-v6-0-cf3ab488dd7b@oss.qualcomm.com>
 <20260524-hpd-refactor-v6-9-cf3ab488dd7b@oss.qualcomm.com>
 <79fff2b4-d8c1-4225-a75a-f9c2dc6a85e4@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79fff2b4-d8c1-4225-a75a-f9c2dc6a85e4@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=dtfrzVg4 c=1 sm=1 tr=0 ts=6a153398 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=brEAT6A2eyJCnXEto54A:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: ABJRBhUrWFOwAiwGe-OQNesYYAh3EpNm
X-Proofpoint-ORIG-GUID: ABJRBhUrWFOwAiwGe-OQNesYYAh3EpNm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA0NyBTYWx0ZWRfXyPR9iLxMnq4i
 BueBNOzQXMkwkoS4WvfYuTIA9R30zfiNXXtKzjTioYgFYH+8BiYDuBN1/GglMcGaRBSPiyuoega
 QEd5sYuxdPzPtejJpUEYwcF5CVzAg4g4JzjVRbu4lRP+6XsNl8Duz2GAd59Na5o7uHOhlz2eU6s
 840AGW+adUOHzeY/mZPgUKxnUZhdmsJeqCVPPG3Lor2pZvtLsha/TEqNjf6lvimXtfruHlG7jA2
 ZHIedJGNh4B2If/Gv+iOu8AmseExaRi/Y1rsfCoWVK1kX6t3+1TDoTLf+xb65UxSusBtaWu6iPa
 +w7DaJB5OB6f7gk44KgBp3D4XnM8UHbYa90HzjuyyiJMF18NPDwNTYxvMOUGdVFxrMy5q9eupHl
 36gmLD+kFJ+V664eOmvmseKVlvub6mV7XuTxpRq3kRJKT8vX2KFYdEMxgMCBV9LEnu4FUziGdD9
 YE1Vht2zwkGj0aLgLKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260047
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

On Mon, May 25, 2026 at 04:01:23PM +0200, Konrad Dybcio wrote:
> On 5/24/26 12:33 PM, Dmitry Baryshkov wrote:
> > Tracking when the DP link is ready isn't that useful from the driver
> > point of view. It doesn't provide a direct information if the device
> > should be suspended, etc. Replace it with the 'plugged' boolean, which
> > is set when the driver knows that there is DPRX plugged.
> > 
> > Tested-by: Val Packett <val@packett.cool> # x1e80100-dell-latitude-7455
> > Tested-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com> # Hamoa IOT EVK, QCS8300 Ride
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> 
> [...]
> 
> > -static void msm_dp_display_host_phy_init(struct msm_dp_display_private *dp)
> > +/**
> > + * msm_dp_display_host_phy_init() - start up DP PHY
> > + * @dp: main display data structure
> > + *
> > + * Prepare DP PHY for the AUX transactions to succeed.
> > + *
> > + * Returns: true if this call has initliazed the PHY and false if the PHY has
> > + * already been setup beforehand.
> 
> This assumes no failure. I hope adding various return-value checks across
> this driver is somewhere on the todolist..
> 
> [...]
> 
> >  end:
> > -	pm_runtime_put_sync(&dp->pdev->dev);
> > +	/*
> > +	 * If we detected the DPRX, leave the controller on so that it doesn't
> > +	 * loose the state.
> 
> "lose"
> 
> That is done.. presumably so that one could correct a coredump or similar?

No. It is exactly as written: to keep the DPTX state. Otherwise the HPD
state machine will be reset, DPTX won't be able to respond to the HPD
pulses from the branch device, when the anything gets plugged into it,
etc.

> 
> Konrad

-- 
With best wishes
Dmitry
