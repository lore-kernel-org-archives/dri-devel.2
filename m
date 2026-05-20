Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B3BCD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 09:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8051E10EFB0;
	Wed, 20 May 2026 09:24:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tchpl7Cx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BYOdruYx";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8E7810EF7D
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:24:18 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K7IG4D341703
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=eyTiG6S7k3PZK4fzsR0OSDD8
 hW52XV0ZuVhq5LEPl0E=; b=Tchpl7CxZqIJCVXrLPkaquSJp3JJoEQgGHBofOCS
 An2DVyUHD0PFQvZQV7VORhoQMD2XPT/5xbT8h0Pz3IPtcEfNCNCj3kZ+8VK8NC1Z
 rOx2J/6hdXWktoCV+9rnDJrPooLB4DQkZVL1n1pWRZ6bmojZ0Xzc+u34h5Wn3dv0
 mq2jFYZqRpwVgY3fe38+yXsu0DjXzy84YMdjXjmCXUdMGvbBVn/yE+XpclXTiRX5
 NmUmQq5ZJaVQg0fTK42Y+3hLGjz7uqAHp8ICdlBBbbquNwHpjf1Qum7FXcVONU3M
 PUhSbdnzaROXZG+KyQ1tDfNiqSxJLyuw1qVifltQvw4/Ng==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3vc0db-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:24:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-515224a8aa0so55075441cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 02:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779269057; x=1779873857;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eyTiG6S7k3PZK4fzsR0OSDD8hW52XV0ZuVhq5LEPl0E=;
 b=BYOdruYxFLKMW4jZYizrPceSZdnuYc/degmdfCrXcYMaP3HH89Ed9OditZLBzK0wkn
 VxFC4dJEE8wUjkKPJIm7l+JwC7m9Wv9ttIn11P1uCKu323zpCOSOHMxOv8CuT/vgH+Of
 eQ/mZqxPIbOVjgrHsqvjjaFmD0WA8/bDoohNiEOkbGiK9ObCLjyKC19JLycLvlBOETc9
 khBAI2cRgA3bD9bCHjtHtKKOboBeiO041768KEUDT+6swsSiJ7FGM7gNdC++uqCQQGtd
 5OBqtflQGwRd1vZkCbHqIDUykB+g4sKCw1rjbQkJ9vojxO5uhZAIAIxeCwEs1Uoj/cwc
 b8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779269057; x=1779873857;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eyTiG6S7k3PZK4fzsR0OSDD8hW52XV0ZuVhq5LEPl0E=;
 b=WX9tvjQ2vs1/IOhQKzw28fnm3203d+L+9cHE7Nx9qCXB7Kv9IjGYMExZAsNrA1ccyP
 y1miv7oqqmaqM0AwsvWhIgN2EHuuGz8gC6LFi02Dq8HRAWqWWAhjjyElzm3pCAL6S584
 kJ9CAdFA0BE1qlkQe1VVhR20dv1mb3Cv08TesyOSZoEtJtkqWUF9d+ueWgb/A1yvHKfK
 DE3pJaK/sYLbBTr5jJcxNL1obIVn/LeM12RqFA1FE058bJp/m03WdsisIC+D7lUPSO3E
 +/AdSgfXFHXTNDi5QDAteP8jTV4RDamLGMUiF4WOFmoQRAVhnfnn2imQ/RJLd3zzrn7E
 QTAQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ92Kj6WlOWyylgnGTqZjXRvkIxfnN1fQHn9bhuZ8P3cFuoZmL3scC9V++c0WcGugAHLzCSiRfLJLNs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxEL1CxUguJxOpJUXrDzzLdrUnlgHzpMgjnXM/wr1oRKeZThqm3
 vc9DaXT+y6nNcTrPgc8cqTLgdhUbsTDF1+7GMmtqVQRxW+VIJRgrrRrkca3TkGCLnw68/9jT3U1
 zMbWZ83d+PfCWh/EKrDRu7IlZUTCLf4qvJBMBu7v8OhcETVFhpoO+aV5ycdAaV1lSLAsdrtE=
X-Gm-Gg: Acq92OE+MpwsS71YtgusiSw77MV+9tHQWQlJ6XkhSf7EzredafGEPIUVk4gPBig7j22
 Z+FzGIwAsJH0z4nNgekBeTY08dogU/Qy8Z2Vk8jzxOQAnSVjgizj9L9YaJA6bpwaJTbhENWiLdb
 ds6tSSy3x649D2vV/hl6mUVMKhY+/felBCEIRNzA+xXT0NaIyEiBzagBQtKifJ3PWvAAhlRbpYM
 CWW7clxKMGx98R5gxzJaFbxpUdEarmm9F7TrgJqFYT7fiRYApHcNCbVFBVfSHQe9vIJZnUPdNtU
 V9oEt7Aq18XGU/5XBK4dab76sT/nZJX6KQM0q8QWcNTs5pXxMLEnxuASPXcGqqQHyUiS2JF7opY
 ddStYmNhqmPRijAGSKeIXb2xfpjW+XufPKazr284WTM79itrYHuUf9X461IR9d/zX6yG6htsL5z
 BnzmAkbVhTBr5/abzprIhg7idOfbvXdjdJxGE=
X-Received: by 2002:ac8:5ccc:0:b0:50f:b13e:b746 with SMTP id
 d75a77b69052e-5165a1e4662mr336323381cf.44.1779269057176; 
 Wed, 20 May 2026 02:24:17 -0700 (PDT)
X-Received: by 2002:ac8:5ccc:0:b0:50f:b13e:b746 with SMTP id
 d75a77b69052e-5165a1e4662mr336323081cf.44.1779269056782; 
 Wed, 20 May 2026 02:24:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3958874e9casm28093891fa.25.2026.05.20.02.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 02:24:15 -0700 (PDT)
Date: Wed, 20 May 2026 12:24:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v4 08/39] drm/msm/dp: allow dp_ctrl stream APIs to use
 any panel passed to it
Message-ID: <6b6uc5lk4tsxccwyyqlp4u6sqsv3x3uyu32qmgl63rgb2m4wuz@wjcroowka3zq>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-8-b20518dea8de@oss.qualcomm.com>
 <oughavmmvruhnehdpa4e3ptigcb4wndugxazhoeg2yed7ubvgi@aa7wtrz5s6mx>
 <09c14a80-d981-4584-b4bb-8fb2430d7a0a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09c14a80-d981-4584-b4bb-8fb2430d7a0a@oss.qualcomm.com>
X-Proofpoint-GUID: AfNRl6YbeEW9KLig8vvGZYcSjNCVVbXt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA4OSBTYWx0ZWRfX1ZNqZKGB3QO5
 PmvH8o/wrUgWCzcBYFml2AQ7GB89FqUI2AOS31sD9s5/e7wxNwibPe1L6HxrLr4dloZEeUbZT4t
 r5EB32ONlsJI48Aor5veCUUCjH8Ulhh0Ajd2ycQzRPkDOp4IzsV8zp1LQxb+uyTKWQqI1ggT0It
 rUh+zYbjQaupdDxuwez/Y+ulxrDSDP+/duarJnI+5MV8vn3n1czMY4cnZEt8QQzhIC01P0Z+gj1
 7EG06ZLC4iAic+a93M0CHu4PbF4XFkShWX6XbrgTReGREW8W+klaJBLOWFnyrw0HyV+H0ICrxem
 xGk+VjX3rDSX5YwAkvAGtS5B+f303YVhnBfX4wlFlaePoH9mLpPWcEWOVeSJEvoDmQcHCQD77GF
 vwzbj9J/xDRsHfr9swjqtE6cRcX5elzmaJ9mZO2ly3EiN/dmHEyiEEo+S70Vbrb8TktCKWcADwe
 RlvXSvLy75IX78Svg6Q==
X-Authority-Analysis: v=2.4 cv=JuPBas4C c=1 sm=1 tr=0 ts=6a0d7dc1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=Z__WNO7T8UARlRF9xIQA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: AfNRl6YbeEW9KLig8vvGZYcSjNCVVbXt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200089
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

On Tue, May 19, 2026 at 03:52:35PM +0800, Yongxing Mou wrote:
> 
> 
> On 4/12/2026 1:38 AM, Dmitry Baryshkov wrote:
> > On Fri, Apr 10, 2026 at 05:33:43PM +0800, Yongxing Mou wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > 
> > > Currently, the dp_ctrl stream APIs operate on their own dp_panel
> > > which is stored inside the dp_ctrl's private struct. However with MST,
> > > the stored panel represents the fixed link and not the sinks which
> > > are hotplugged. Allow the stream related APIs to work on the panel
> > > which is passed to them rather than the stored one. For SST cases,
> > > this shall continue to use the stored dp_panel.
> > 
> > Hmm. Why? Can't we get rid of it (in the followup patch)?
> > 
> In MST, the stream panel is bound to the connector, but in SST the panel is
> still stored in msm_dp_display_private and msm_dp_ctrl_private, so
>   dropping it does not seem necessary at this point. The purpose of these
> changes is to allow the functions to operate on the MST panel data passed in
> per stream.

I understand the panel being stored in msm_dp_display_private. Can we
drop it from msm_dp_ctrl_private?

> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 21 +++++++++++----------
> > >   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
> > >   drivers/gpu/drm/msm/dp/dp_display.c |  2 +-
> > >   3 files changed, 13 insertions(+), 12 deletions(-)
> > > 

-- 
With best wishes
Dmitry
