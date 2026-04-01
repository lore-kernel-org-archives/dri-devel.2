Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BB6D35171
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 11:30:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B34A910EC9B;
	Wed,  1 Apr 2026 11:30:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DIKFPZdC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hKDb8P+J";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5136B10EC9B
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 11:29:59 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6317CcIh3103857
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 11:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=+nRgKz9j6nL4bf3e3tPt9WJH
 q9YRYaWjBkj2eVIn7ek=; b=DIKFPZdCFWnqLNrlFdUhDQnI7J9j+g7PwvrJ/KtP
 /HGFvaPb3C3BwlV6DY1hM5xQKz/izIc2Ens7AOgDVj7OHgpC/z+fUdG0wsiF0Sth
 AUtJiijJo7f0eG1Hx7QET5lJ1oIoQwaQ74aGw7ltzzRVtKnccxUpb7vbou/UULND
 kAbSlYPXizi3/yryu5zslqqqk43fcxL2y+ecNyvkTtqn+2bfO1s6t7EF5vvOi2w2
 Uz0p/C4vkRRuZ9XuhA1v/Lr7HCZtKI6L8WQ+eULp8HFX6G8Lyx8lZS9YLRfvvTMY
 tzVIlr2tilCUXPUKYTrYaHgi0h+mb5hWSlBvgdJleU+v1A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8js242kj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 11:29:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5090e08dcfcso76298871cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 04:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775042997; x=1775647797;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+nRgKz9j6nL4bf3e3tPt9WJHq9YRYaWjBkj2eVIn7ek=;
 b=hKDb8P+J322bja6gAz9akAaCApyZ2v9KfAe073WKw+xSLCmyj6aSe9BfqQyz69Iwk0
 EEbwwfR1P0IKnc0GLS+uUSVeqOGR6HxwnMrwy9l/NcHDr7gXFkUh+pdvH8J9ruIIOO6Z
 Pemj7uPu5dwZrXheB4Jpe/+/m+ubOD1ekImzKrEaFasLr68rFWCJxNeokH14h5/1ELHs
 66he3wYoYLpX+OfrjxA+v1OoVtql500zIRrEcR6LO0rNUbcRwKKVZNvWHXV5mhzSrLnz
 bknO0lTLP/NEtWUn9cpeLCQ1icNlW1SymvrQ0TFJsGTulRkiX/PYqXhRFb8hVAwUW8oS
 cA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775042997; x=1775647797;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+nRgKz9j6nL4bf3e3tPt9WJHq9YRYaWjBkj2eVIn7ek=;
 b=Rgxh2G9+idwS6ZEsMu1az+SNK7mcDC2wYV4wp0CsFOI8ncnax0qfL0jchyK5Zqb8FH
 iG2IYVhwFD3zjcXvcbcbiZvDyYawlC+JFqKHU/oksxSAym6qkspjBuOURPIZ+Z6dtoWc
 r0Vt/SOuX6UdwWkaiJImDa5yjigTHKpQ3V0rNNQZXF0m9glGZVxRQEQ6EVWcmXb2HE65
 0lRw//Uj3FGV3wZy8+hJ91F3pK6ec2AW/VZ7Tq3XW4qPcdZOWqULeMaHDjsUXAlgFwu8
 sm/Idu0W6nUlvu6SwEQUucFkJNf66CGqr2RM3RUzVNWoqJKagHjEfAUMW6ii/He53Z0V
 GGpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuKzbSQGxkdWJUaqmDOzfZLMTi5oVvq2PXAkPssvYBx258Xl6j2VlrbnVeTANNwgdQ5wejb5gbEoQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzM/GDwApMu13guYjBQhEmiTnC7kuIlIbgZWrZJyIKAmkVmVsHF
 sBiggslRPHhNFraptOAtE9Y8WsD66vMnrnqddm6UMVbcTS7tLbtGGyzOQ1aDQQrQuoAOgHqljHw
 KnzMFNkvjiDVaEG4G8irH0aw+gWFK2o4x9lFlQL+LLrCxJkrbPoVPdBBWw11W/bmrFKKWSof+aT
 S69xk=
X-Gm-Gg: ATEYQzwAUkkI1jwVyFbFlsqX+LDKuG0e3bADJiDfKW36Kf6jc95ncPkyRk0qQntu3Wg
 jnzQc1nTqNHsmcjl9xNh2/S6JRSkb/nPfvCC8UvmS/wkXdoEiCTem3iVYekHG1Gc0KpTxUTEoOe
 NHNbGkApjyE8UghwPGpvgR797QQvZx3iaZFqvE3HrV6CFBjNC7QZDsQAHsSrjb1bjBft6Sy0kqj
 J6fesn8ecbaZZBjUChi+dmfDKoWL7qXF7NhsVwjteUN7MAWkJXTSIGsXZnsp/zx3TEpgQUDgpA8
 szNPYeGfJBBUrBwIku8IdXgTWNTwMa6f7TFM32UGMaFH9Yof70MZ65nadjiVx1m1jlGEuOZfrXu
 VmPeTGDWJpqExLgRzGE5NkFBQWQ4ou0dCkPj4gkCtB9kkTZAvnoOLo6RS6gfQwlP5nEVBll4eK/
 HPR0DErsORuZ+RnO8I4ssCbK4euwzjQX2vKPM=
X-Received: by 2002:a05:622a:8ca:b0:50b:51ad:35eb with SMTP id
 d75a77b69052e-50d3bc92052mr44872931cf.20.1775042996997; 
 Wed, 01 Apr 2026 04:29:56 -0700 (PDT)
X-Received: by 2002:a05:622a:8ca:b0:50b:51ad:35eb with SMTP id
 d75a77b69052e-50d3bc92052mr44872441cf.20.1775042996527; 
 Wed, 01 Apr 2026 04:29:56 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c838dece4sm29084391fa.35.2026.04.01.04.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 04:29:55 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:29:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v3 27/38] drm/msm/dp: add dp_display_get_panel() to
 initialize DP panel
Message-ID: <hiergjmqydw7lv6bqxvy3ahbccepv46c75e7on2gpjmk3qzivd@4vfbsz3lqe3b>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-27-01faacfcdedd@oss.qualcomm.com>
 <smvfckejheyi7oehubdkhnh6pxokn7yugvlrynraypsu6kssj3@6vinswn4yku4>
 <1698c35d-cefd-48b8-8776-c7deee000afc@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1698c35d-cefd-48b8-8776-c7deee000afc@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: Qos01FtD-X0tmrL2YNfyZE8q0Xx1Gz_6
X-Authority-Analysis: v=2.4 cv=XfqEDY55 c=1 sm=1 tr=0 ts=69cd01b6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=qqNhqcHm_pXtmdEkLVQA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEwNSBTYWx0ZWRfXwFNCIfvcgu9X
 bEFKMUUW0MOqxYepGvt+RoaIhHtQS1Vexxlxpe8RsdGraGgFsbfHSwh367JkKKBUXhJeWFmKdV6
 VCLBQSyUR6izvSZ8Q3g2YBTbzkgga3HspkVqa6Glg2JXUOrrslGdjA/FsNUFLHYbOdfyTos4DRv
 FH7MQnC1FDjXFfCXT07htrjvzPNUPye67ATX9nXWhcjRKeeFpX5WsskU4EN95U5ySu2fSpaHQNV
 9K7rOFAx6iRwyeupS/jTX9G+3F8c6EQZJ/SYwEXBsn1NBeggeyfJfxuS81DXDVtMK08oVAnJAIo
 tTDRB8bI/2V7zqXI8+2hqGet7XArAIOfGEXFNIG/SZ2SQhqg4uvrewNbdby+R4HaZlbDSSXH8XQ
 kZb+1f1VNhDz3DomEx7IX/YBNWexJgrqzXVKUP3ebk4/Gf/NGAnrWYTKSTH+Q4qSL8uj1NoVcqd
 vB6WQ0d9nQ54ZPbkoOg==
X-Proofpoint-GUID: Qos01FtD-X0tmrL2YNfyZE8q0Xx1Gz_6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010105
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

On Wed, Apr 01, 2026 at 05:43:48PM +0800, Yongxing Mou wrote:
> 
> 
> On 8/27/2025 12:33 AM, Dmitry Baryshkov wrote:
> > On Mon, Aug 25, 2025 at 10:16:13PM +0800, Yongxing Mou wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > 
> > > Add an API dp_display_get_panel() to initialize and return a DP
> > > panel to be used by DP MST module. Since some of the fields of
> > > DP panel are private, dp_display module needs to initialize these
> > > parts and return the panel back.
> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_display.c | 23 +++++++++++++++++++++++
> > >   drivers/gpu/drm/msm/dp/dp_display.h |  2 ++
> > >   2 files changed, 25 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > > index 84df34306fb557341bea288ea8c13b0c81b11919..abcab3ed43b6da5ef898355cf9b7561cd9fe0404 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > > @@ -632,6 +632,29 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp, u32 data)
> > >   	return 0;
> > >   }
> > > +struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display)
> > > +{
> > > +	struct msm_dp_display_private *dp;
> > > +	struct msm_dp_panel *dp_panel;
> > > +
> > > +	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
> > > +
> > > +	dp_panel = msm_dp_panel_get(&dp->msm_dp_display.pdev->dev, dp->aux, dp->link,
> > > +			       dp->link_base, dp->mst2link_base, dp->mst3link_base,
> > > +			       dp->pixel_base);
> > > +
> > > +	if (IS_ERR(dp->panel)) {
> > > +		DRM_ERROR("failed to initialize panel\n");
> > > +		return NULL;
> > > +	}
> > > +
> > > +	memcpy(dp_panel->dpcd, dp->panel->dpcd, DP_RECEIVER_CAP_SIZE);
> > > +	memcpy(&dp_panel->link_info, &dp->panel->link_info,
> > > +	       sizeof(dp->panel->link_info));
> > 
> > Both these lines show that link_info and dpcd belong to msm_dp_display
> > rather than the panel. The panel should only be describing properties of
> > the particular sink.
> > 
> I agree with your point.
> 
> This would require a larger cleanup of the panel abstraction, which
> seems out of scope for this series. Could we address it in a separate
> refactoring series?

I'd say, no. Or "yes, please send the cleanup first". I definitely don't
want to get more ugly code in the driver.

> 
> > > +
> > > +	return dp_panel;
> > > +}
> > > +
> > >   static void msm_dp_display_deinit_sub_modules(struct msm_dp_display_private *dp)
> > >   {
> > >   	msm_dp_audio_put(dp->audio);
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> > > index b1ea027438d952c94f3ae80725c92e46c631bdb2..d5889b801d190b6f33b180ead898c1e4ebcbf8f3 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_display.h
> > > +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> > > @@ -65,4 +65,6 @@ void msm_dp_display_unprepare(struct msm_dp *dp);
> > >   int msm_dp_display_get_active_stream_cnt(struct msm_dp *msm_dp_display);
> > > +struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display);
> > > +
> > >   #endif /* _DP_DISPLAY_H_ */
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> 

-- 
With best wishes
Dmitry
