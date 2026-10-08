Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED06CA600C
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A444C10E80E;
	Thu,  8 Oct 2026 13:52:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VRVpc3Ky";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TEt3R7MG";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4949710E80E
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 13:52:42 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698BK9252116478
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 13:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=g1ajShL5hmrzGWgmQJawATgi
 FWxzPKfgeC+DpQwr2bY=; b=VRVpc3KyYMp4R4uK0E4C3w62OUECuiWPeSNTQi9V
 dADXbuthWvDJt9lWQNbqEMwUj1jer1HUcWZPNGRydQao53uprRX8jVfTWLcmgw6F
 rzB1tJO+c3gVqvlIH9vkX84B4ggAg+W6RIKrxhVL39yN3p668+zs0SDK6zzZ0Ytk
 DgItnoxVNjtaVUZ7VKoatDwDAj9D0Y+VnuijNQNAwKS+Xhl+Oc0v5JWSejDphZuY
 ko+1BYHblMT9OuE0G4VzH7bZB/G7f+2lzJo6E1vjElDcoRpuSmo+Vtdf06mcJRfB
 jCMJKWUUIWVSDPtxBobvyOcw0EMvMGDMsB/k7RRa5bVJyw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe535nk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 13:52:41 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cc0b31ecaso1148755885a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 06:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791467561; x=1792072361;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g1ajShL5hmrzGWgmQJawATgiFWxzPKfgeC+DpQwr2bY=;
 b=TEt3R7MGoX1la666zQsk5awmF2HF3q+5Eix+/Mhj6i7oIBOC0o5ASlIqObo3EmOui0
 ovD0cEvXk8mr5kQq9JJHXIBfU6RTBkRqte6qzlWh1FPHf9KYo84Bg6RJ4mvYZ5BeVgQX
 UG4Jdc0tKd8LZmeOk2+GRqGJ21i/tgMVByD6hoxf27jm3YjUX40QkY/tk3jPk8FPv6qT
 B6pL5W9Myetm1go/ir6eQ7N9vrZLIbThRKebrrv9qTM1XpDL/98EgxYxskSt5dFhgkS6
 D7XkhHQXeaRm5x8M74htmrj7n1GBkH7TyM7srhJc/cUuHrw9yVBw7zesFeUdMLnK0EYJ
 k+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791467561; x=1792072361;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g1ajShL5hmrzGWgmQJawATgiFWxzPKfgeC+DpQwr2bY=;
 b=LiifF7zkkzKtWYIDsgSUNxB4nwTrsJNgHllFmGw0QgIV1ptVIAFjSz0lRrrAhT5grI
 ZQyB2LAb4qTr+Ox8Gbg0tLJdwsbn+HOzTZymiw6KKyjIK5Z11XmmomgeB37LMjgXyEH6
 fsyW48RuFof+Gg2iKsfFjLXPwRYNBqRN/89Xzp7opTCVtH7Rg4rdpQrqZcbK0fa3faGb
 iVacVOn2tBZbpEsqUbU9vVBUyPmO3lrrKXoEMQvDil6YldkAuQOydi+jzlZd7akrBaOJ
 2m+4rAh1OHIi94mii06TA4JE7h7EJv7nuu4lM/c8eBoycrRJlprp6lwlAEjsRvVL27Yr
 /4ew==
X-Gm-Message-State: AFuF++mRhIsnze4qSQoxP2TwZFbKWAoQEtU+D6hEibVxEQ8USmYtJqKh
 N0n5s48brxsYMPKM0CVnCBaX3/yPy9bB/uYaddWK1GkpEjfYBr+5XxRYJn6VTvY+cH5ELzEUKrz
 VS2o6amwYR3RuqcfWX4knoCqacZVfOb7GBIlSOqjDI0eW5Vb5Hceap5TyUidPU367Ay0kjDw=
X-Gm-Gg: AYBFou3S8hhD8BzLLnG68ZYZDKxj3qaLOynWcdKpTUb2QZndqklBySC7eqLUNIZoa4T
 oWmDFMkvE5kXixyj2ctS2EttfSlVfPJxLywGzV7StuExNPXZMuA5n7StjClGK2KWpsdqphORSjJ
 U6S5NoqUjCvCfStlZIvKDl9rvCBub7MqAeM4RYCiN8pCCO85c8+ZKO5wFjDp3NvaVT59kqYWQON
 5Yx52423t62xjNwHNscT+h5/sWkXs34SqZNKc6H0RT1M8/FHXyggwm3JwALL/aQBu9NjR5/bdUT
 t4dDNNPLAN/l6qiEkpsFtpQjFhOpVJsB4MFhvwVcfQa9holWfdn+4vpGyO9JJxpNmreYmd3NC9N
 phTsUOGVTjtJdLysvhkb0C4Ke6DLJRvFmFnB32wX+62KSlKvhAJFnz8fQuiihLdje9ValpLDAhh
 31cX6gr4wysqSZ
X-Received: by 2002:a05:620a:628e:b0:93c:8544:6adc with SMTP id
 af79cd13be357-93e9b76c7a4mr1088660585a.18.1791467560592; 
 Thu, 08 Oct 2026 06:52:40 -0700 (PDT)
X-Received: by 2002:a05:620a:628e:b0:93c:8544:6adc with SMTP id
 af79cd13be357-93e9b76c7a4mr1088651285a.18.1791467559710; 
 Thu, 08 Oct 2026 06:52:39 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcd30833d2sm1274813e87.42.2026.10.08.06.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 06:52:36 -0700 (PDT)
Date: Thu, 8 Oct 2026 16:52:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 03/10] drm/msm: release scanout framebuffers only
 after a vblank
Message-ID: <ztvgomgdl7hzfhwf5z5llwlv67246brexy2mfblb7nnixvuij4@agaiyj5bfys7>
References: <20261003-fd-kms-fix-smmu-v4-0-2a44d4d8ac77@oss.qualcomm.com>
 <20261003-fd-kms-fix-smmu-v4-3-2a44d4d8ac77@oss.qualcomm.com>
 <20261003013429.DF7271F000FF@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003013429.DF7271F000FF@smtp.kernel.org>
X-Proofpoint-ORIG-GUID: VuJAKyedGi7YOIfbn1lmzgXu6VJLsMlN
X-Authority-Analysis: v=2.4 cv=E4dYNqdl c=1 sm=1 tr=0 ts=6ac7a029 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=G3YaYXDeKChVjLYJJ7oA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA1NSBTYWx0ZWRfX/JIBREVKhC92
 aix2GhzkTiqcxwr9tP1UnZjM26QYQIQeFX+Lz+6YaJhwZfMt0/wE+ppR1Ow4+3hDlfShwQ/V1MN
 Q0D2p9oKWJBkRvA50DJrWZvK6iSfM+k=
X-Proofpoint-GUID: VuJAKyedGi7YOIfbn1lmzgXu6VJLsMlN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA1NSBTYWx0ZWRfX0nNWOUqW6wCQ
 6PQixYvCJTCjrv2IWPgRrUXTFSocKLqbTuGSpRiyl3ris6W+59/jpdHTrZOJv7daeGsUbFxoVF3
 LPXwXYn7Fiz4hQlJXbBlkID5KjhMcE0HcOt7QmliYMYnfloMmvSWGWRbKpTm3+C5ldZPo/eotwG
 8gr5HfxsYw4SLCVpHdhvN+lchvS3I5tno8r6W+XG026sWpV6YlATCm167nBnOAgbdEfiJysY7HP
 LAOL7kMx3yvhmYTkVoFkvM/JW9XZB+s6x2gcX1OdToFXRDZAvPVh47ixJ3IYcXDqdNagx0zcQHQ
 dgwcLlG8R40LW7ELFeovbDdzspqgSGyWPjFXSQkuXOWDSLeLCi6X9sxhInQds2q/ouvzwF9SgD4
 o2tEBJKs6XgztyzyFtz4r0JmjiBYSJ6x+z0PTDglsbbCNFQ/qjRZTQve+6IG5xQhgT8XEjf07cr
 35hi6/GSeXxEzwK1L6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080055
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

On Sat, Oct 03, 2026 at 01:34:29AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] drm/msm: premature unpin of framebuffers causing IOMMU fault
> --
> 
> commit 86394032733ab2293f0e387866c3cbd603bc3285
> Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Subject: drm/msm: release scanout framebuffers only after a vblank
> 
> This commit defers scanout framebuffer release until a vblank by handing them
> to a drm_vblank_work per CRTC. On CRTC disable, pending works are flushed and
> framebuffers are unpinned directly from msm_crtc_vblank_off().
> 
> > diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
> > index 7e1df472592d3..cb497d419ab83 100644
> > --- a/drivers/gpu/drm/msm/msm_kms.c
> > +++ b/drivers/gpu/drm/msm/msm_kms.c
> [ ... ]
> > +/*
> > + * The crtc stops fetching here, and with it the vblanks the pending works are
> > + * waiting for, so release the framebuffers directly.
> > + */
> > +static void msm_kms_fb_unpin_release_all(struct msm_kms_fb_unpin *pending)
> > +{
> [ ... ]
> > +		drm_vblank_work_cancel_sync(&unpin->base);
> > +		msm_kms_fb_unpin_release(unpin);
> > +	}
> > +}
> > +
> > +void msm_crtc_vblank_off(struct drm_crtc *crtc)
> > +{
> > +	struct msm_drm_private *priv = crtc->dev->dev_private;
> > +	struct msm_kms *kms = priv->kms;
> > +	unsigned int idx = drm_crtc_index(crtc);
> > +
> > +	if (kms && idx < ARRAY_SIZE(kms->fb_unpin))
> > +		msm_kms_fb_unpin_release_all(&kms->fb_unpin[idx]);
> > +
> > +	drm_crtc_vblank_off(crtc);
> > +}
> [ ... ]
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > index 77a2d1f6700d0..35daf46fc4257 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > @@ -1213,7 +1213,7 @@ static void dpu_crtc_disable(struct drm_crtc *crtc,
> >  	}
> >  
> >  	/* Disable/save vblank irq handling */
> > -	drm_crtc_vblank_off(crtc);
> > +	msm_crtc_vblank_off(crtc);
> 
> [Severity: High]
> Can this lead to an IOMMU context fault if the display hardware is still 
> fetching the frame?
> 
> When a userspace application issues an async plane update followed closely by 
> a CRTC disable, the ongoing hardware fetch might hit an IOMMU fault because 
> the memory is unmapped immediately during the disable sequence.
> 
> Because msm_crtc_vblank_off() now synchronously unpins and unmaps all pending 
> framebuffers via msm_kms_fb_unpin_release_all(), executing this before the 
> hardware is done fetching creates a race window.
> 
> Looking at dpu_crtc_disable(), we wait for the hardware to finish its current 
> frame fetch much later in the function:
>
> drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c:dpu_crtc_disable() {
>     ...
>     msm_crtc_vblank_off(crtc);
>     ...
>     if (_dpu_crtc_wait_for_frame_done(crtc))
>         DPU_ERROR(...);
>     ...
> }
> 
> Does this sequence leave a race window where the display is left reading 
> unmapped memory?

I think it is not a problem: the atomic helpers disable the encoders
before the CRTCs. dpu_encoder_virt_atomic_disable() waits for the
pending kickoffs to complete and dpu_encoder_phys_vid_disable() turns
off the timing engine and waits for the vsync which latches the to the
hardware. For the MDP5 driver mdp5_vid_encoder_disable() does the same.
After that the interface no longer fetches when dpu_crtc_disable() calls
msm_crtc_vblank_off(). Any async update is flushed by ->wait_flush() at
the start of msm_atomic_commit_tail(), before the disables.

-- 
With best wishes
Dmitry
