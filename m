Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BEAFA1FD9
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 17:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBE3310EEC5;
	Wed, 22 Apr 2026 17:48:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IF8Zj5Xn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GaFQWKPq";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A5010EEBD
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 17:48:07 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MG3kAa2012119
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 17:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rdIWJRBzLsT+FQdXZs2St3YIH/aQ6EawAyxBixIyb/Q=; b=IF8Zj5XnmrkSseLs
 Pct9+MnzQeWe8qjhN80UeXGPkkOc2IlaMzCf69EYWZQwJOxRcvBlzcz8eLh/OUaf
 WMgYNk+Wh8DmskZcc4RUydXb4F+73IP5KXoNa+yg5g4fDxuE+O8IrIp5hvLxDlli
 8dmclxrSetr9EwY14UIBDMxyflqAZLAgUEAlVDDCn41ZFh9A1xmuzVLU2430mzMW
 HjEncvCg3AvhDxOojHycs7UletsVbOh5l6LxfUKguW+7xgm5M/4oj11zy9I2G+zA
 Qp+1Re1LDz5TvwcjvM9TeoX6stG8ogSMSt+1+Lgx0DQ2BUoyDiv08Sdhc37ykOg7
 jVFTfw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1h78cuc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 17:48:06 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d8e8c47a3so150898701cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 10:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776880086; x=1777484886;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rdIWJRBzLsT+FQdXZs2St3YIH/aQ6EawAyxBixIyb/Q=;
 b=GaFQWKPqst6c+mgOEO5seDhnxe60dDaWatMURGzge6z7hyBKywnW504kJLzkJz/W6i
 mzlJ7CvO7MFJfpRSzVxHLpYsxutSs6lIkW+S2WR4JnOpSS+ma4H/itSKopB7V9mfJXBL
 //cZNiY24ceHON0q3ykRC37B9BJ7lY+zDC3YWqLbCY8Z7XAaN+z4oCtITVyhJ7gp1vTp
 ZODvM8GRpK2HgsbbV0hzRpUw3cloAtqr/ESRLe6IwtedoSHZUvLywR9+e3eWb1VK3e5k
 o3IwfeaEXpPir6dZUtNRpx4z6KQbg9RrD0s3ILZlfUUZywQ8S2ZpXlBI86bsjBevi80B
 lNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776880086; x=1777484886;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rdIWJRBzLsT+FQdXZs2St3YIH/aQ6EawAyxBixIyb/Q=;
 b=FSU0pxnQBH0fiCyLxQqtpJm2sl/7Z31QVZPZszaz6BUtitRBuI5yH7Ke6iBQN4QxMb
 xHyT6Jm+QsURJz2gQ6IodhUa/g7IdFNwG+zuQeD0/0qJm/NhZCTCKqIrkzKQQEcuk57p
 1lsoFpr8VLiyEoYkYeMPNgsVbTdhHCaMextsin3MHhZ873vKcWeLk1P2BWoea1nstYv3
 ekPakVQ43Oy2hV9miHtMXlNY2huW3RWkE7AuFZG3AYhK02ykpJd2gous9Pz3zQMurot0
 FJKsixAn8SNPn7+e+hsGB5QTLwQhDKkmKcQ4kObRqqcTAth4TKePwh58Epqm6oMyEOjX
 ZOww==
X-Gm-Message-State: AOJu0YxoCkWIeH3LMXXq6Yzo5wFJNDDxBmRCU2wQxrcMEpLISytQOmI7
 aBAZBXUrdRh+uwxmkmXbGHjqIsLxSPI14E8coVnVHo4oyBGlxnFpHeFrKxur2KVLAmVTQNtUEIG
 0i2r6BLyU9m45oEZ9frQ6xq2TZ/7Aylvr9hDwp7/fcKWJG3fjkxOkwOG59k2Qr/pQAmbuBMs=
X-Gm-Gg: AeBDiev8h6j4lRpQ2rQKitCDI1j0D18I8Go3KW0qXtLitKt/nF4l51QpF/xIwtEIhwd
 ClnszB6hzD8reMFsKIEDY/mchxOjUrcJ3G8GUfdMoYzpFIhqA59WjvS04x/aOd0o8zupZs7tqTn
 TMow4Qd1bYUe4hkL2ClBDcg0/LWLGmdI0IKaWComCSwrN7TZ7MM1P7xCGufBkwkvJj0+inL2trZ
 PIUvtYqeKmpmwoCKyzKBGJqPk8lLg0TN0pm0LI/zU0K/HmgO8ZJ2r8ymhKKuaIvBh9+CKWRV8Ca
 PFA63taL0PcrIQKCINaQPcPHHXTj8LH+daYSzGYIz1IgZcKC60RfX2oiP6hMQzxOPxLWyP3otX4
 qClBPnZJxoNB+U2Hn8b6AtHnjVPFq2Qt3dw3s9FN26LoUkwpFfTuh5TnVEiGbquGnw0+GQEIB1n
 2ANTnYNVnxxTCfL9k4T2HJ8WziIUhm4xSBbVKQ/yxJGtQuhA==
X-Received: by 2002:a05:622a:10e:b0:50b:29a6:8696 with SMTP id
 d75a77b69052e-50e3681d042mr350788551cf.7.1776880085643; 
 Wed, 22 Apr 2026 10:48:05 -0700 (PDT)
X-Received: by 2002:a05:622a:10e:b0:50b:29a6:8696 with SMTP id
 d75a77b69052e-50e3681d042mr350788091cf.7.1776880085151; 
 Wed, 22 Apr 2026 10:48:05 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185ad0adsm4622156e87.11.2026.04.22.10.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 10:48:04 -0700 (PDT)
Date: Wed, 22 Apr 2026 20:48:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/13] drm/msm: Add PERFCNTR_CONFIG ioctl
Message-ID: <a36mlynml7egnts7lk2v46lxopuyxdxt7mp4vtbf7dbhn3gzpj@ufvqdjbnujif>
References: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
 <20260420222621.417276-14-robin.clark@oss.qualcomm.com>
 <a3nvz2coifdazaoyssm7xtxmyiusvofxu5f2p44kvrgvpa7hbc@jmj6gyttetcr>
 <CACSVV03+aZUnLWfGjMLAJmvHm7LxnugJDQ=_ZZFV00-UWeZ98g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSVV03+aZUnLWfGjMLAJmvHm7LxnugJDQ=_ZZFV00-UWeZ98g@mail.gmail.com>
X-Proofpoint-ORIG-GUID: _MLkqgmHvpnezLmLddOTlxvWaPmpoYQt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE3MiBTYWx0ZWRfX0rEhnZ89xY9U
 HBJFPpTFUktxECjQFdJUDXubFHhK6nZ4llPp5laCj3gvqo1kwXI0v/fdLAunXx4G7rJntRtccCa
 QJnipW2n7of/TA1W5ImspY+ikbRWKk1TJQas2qMvtOjLwvLJn8Y/BuK0u5aXR1CfLRaXfzGPLxG
 aPIcTf0zsSQ5bGTVK17SnRMTxtNqbL5f3cRMbIzeXgf91pITa2wwsRpFj5Yy1bQuPuGss3M/wgB
 FLg0daViHwEvaJtLDfA1ZvJ6UDjGm8MCkLiwoCht035bpYajqb8MOocvAfyYFHmKh7/heQ9LkRM
 VeKyx6cByilYVqu0zOoJ4w3M05fKBnTEoH41jzsSVXnhyUFYmVx1DEkHBIVJ6gJbG1rGtCLsAzT
 Rk9Ktd4JB+yNjQ0KXaeWOYl/7Rz/9xyPFGHNTmqFBnIi8Cgwbcx7Umcfd5Lt9okSvMqwXX1DlkW
 PddDooFvlrORDKHvhYA==
X-Authority-Analysis: v=2.4 cv=UqNT8ewB c=1 sm=1 tr=0 ts=69e909d6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=ul2Ekiw2JhVQIeWwY14A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: _MLkqgmHvpnezLmLddOTlxvWaPmpoYQt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220172
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

On Wed, Apr 22, 2026 at 07:20:09AM -0700, Rob Clark wrote:
> On Tue, Apr 21, 2026 at 8:41 PM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Mon, Apr 20, 2026 at 03:25:35PM -0700, Rob Clark wrote:
> > > Add new UABI and implementation of PERFCNTR_CONFIG ioctl.
> > >
> > > A bit more work is required to configure the pwrup_reglist for the GMU
> > > to restore SELect regs on exist of IFPC, before we can stop disabling
> > > IFPC while global counter collection.  This will follow in a later
> > > commit, but will be transparent to userspace.
> > >
> > > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > > ---
> > >  drivers/gpu/drm/msm/msm_drv.c      |   1 +
> > >  drivers/gpu/drm/msm/msm_drv.h      |   2 +
> > >  drivers/gpu/drm/msm/msm_perfcntr.c | 489 +++++++++++++++++++++++++++++
> > >  drivers/gpu/drm/msm/msm_perfcntr.h |  54 ++++
> > >  include/uapi/drm/msm_drm.h         |  41 +++
> > >  5 files changed, 587 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> > > index 3066547f319b..0a7fc06113e0 100644
> > > --- a/drivers/gpu/drm/msm/msm_drv.c
> > > +++ b/drivers/gpu/drm/msm/msm_drv.c
> > > @@ -801,6 +801,7 @@ static const struct drm_ioctl_desc msm_ioctls[] = {
> > >       DRM_IOCTL_DEF_DRV(MSM_SUBMITQUEUE_CLOSE, msm_ioctl_submitqueue_close, DRM_RENDER_ALLOW),
> > >       DRM_IOCTL_DEF_DRV(MSM_SUBMITQUEUE_QUERY, msm_ioctl_submitqueue_query, DRM_RENDER_ALLOW),
> > >       DRM_IOCTL_DEF_DRV(MSM_VM_BIND,      msm_ioctl_vm_bind,      DRM_RENDER_ALLOW),
> > > +     DRM_IOCTL_DEF_DRV(MSM_PERFCNTR_CONFIG,   msm_ioctl_perfcntr_config,    DRM_RENDER_ALLOW),
> > >  };
> > >
> > >  static void msm_show_fdinfo(struct drm_printer *p, struct drm_file *file)
> >
> >
> > Should we also increase MSM_VERSION_MINOR?
> 
> Generally I only bump minor for a change that can't
> otherwise/reasonably be probed for.  In this case, userspace can try
> the new ioctl to see if it succeeds.  And since it is only supported
> on gens w/ perfcntr support, userspace would still need to probe even
> if we bumped minor.

Ack

> 
> BR,
> -R
> 
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry
