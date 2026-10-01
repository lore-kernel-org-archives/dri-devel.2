Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52816CA5FC4
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 02:50:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BAFE10F555;
	Thu,  1 Oct 2026 02:50:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WJhyWTby";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aauSFLWa";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC28310F55B
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 02:50:24 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6910jgr81141559
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 02:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=xn1eHsIfFrbIrU2VWkWaw0Rd
 lkAyIl9bNfmyYQyox/8=; b=WJhyWTbyv499wJmgzgNJMqSXaS8BPSLaH+d73ccN
 dqnrjaT6W44T0ffmxyr+dsIRUpSv+Cpve8Df37qMEEjPxqJsnLUaDH8ucnrYUIcZ
 I99Mcmg1DyK/3cTITGyl4qcuGcF22GLS79oNVkHxl18+8hWBrmCCI53H55pra//T
 +NSHqQX5BmBxr+wpWcqZ8DqEtpyFFkI1HQ+Nw4W5Q7fet0NuZ9QHfrblUFAFIm34
 /pOS8zmjGFtu8UGwBKGfV66KefqlS8nA+Kbk8XPiiG+VDyb8aiy9lN51Vf1xBvpa
 nRLx8XN2ix6WiyQLE1YPDn8rSj9EKhZquW6Hfr6MPSngoA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1bh58qdg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 02:50:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93ca9b53afaso299109585a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790823023; x=1791427823;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xn1eHsIfFrbIrU2VWkWaw0RdlkAyIl9bNfmyYQyox/8=;
 b=aauSFLWaZV0JKRAb45GnI/ZQTOwDM+Yi6BfUE8m4ZgktWZZYRu2hnFS32pcA61Uapg
 d6f2m07In08OLjW/8gZ1fkrohE4mhA1H0qPgfQeN83hWHuuN8TCv1c3oncecZ1bSoAxE
 1nEma33rezsukt7EPNvgPxsEy5nntlPH6H7FTRU6MGWnQU7ltiZ1H/sX7YloPPL6fNws
 RLUd0Cu8VrMV2dcHzjghM9aL7Kn53I8HPGZ+fs3IJFRSpHDB6Rv9RnTGl5lXlVAaagmZ
 yWgNUDO17Acv6WRcZNRLelOwlWVevGIfbw5kqN32SYjPswMCP4VIo6fUAt9MvJP509QK
 q2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790823023; x=1791427823;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xn1eHsIfFrbIrU2VWkWaw0RdlkAyIl9bNfmyYQyox/8=;
 b=JqcF42jG1eiSo+chgB+ON6X3wigWhjZP5GEkBw8+TMTwQN4Obk+daxAmk+l6k5F1z0
 14b1adX93W9DYpMNdWkziYOO4+h1ImP2H2eIYcsuW9iO2SFHnzcUeHfzwhPVfY3qHYw9
 3A9m29i3bmpUrUBZilu/1wUb9s9ejSGrM/BOPEorlr+uC78uSEr6bOckpocKRGGtyAsS
 PwxUIWTftpBJvLrh7uDgj1kdaU5slO0xsQ0U9HTaSf5sMrJcjY3qA9llzRi7FEPbcU28
 Yf6e6AefFqWoUJ1AM0UQgQ+52V/bSkxo4/6SzR13jpr8C4WyNprDT4adGvcXqTSGhO8j
 gS/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxKdGXym078ORD3U6eiabnoB6c6HhKsNYDCbZnMD9wbJoJ0kVCEfBxX9LXw3DkwueaUMltN1fsRzG8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l3Arg5jVMNjaBh/d2feO3xAEJSVrhGRMnvUNPjfqi+Rqj5zuUt
 bge6N73fQQ8FRLKkgMbyGw1hGNhUblPiv/FQeC+p4i2yegF467HTCKwvYUNC1iqgh5E0EYa4sd0
 MYfyq/0d/BtXoO2nV5IEorxgpCsQT8H5FkvRMTYFFlSoA/vYu5n2cJJP/ZwMfYULBjCZRLt4=
X-Gm-Gg: AYBFou2f7Tb2Will+AJIJttxlPJiOVDXKv3/ePlI6yhufdaKq5hkSop+b3Y53SJc9Qy
 uD+gHPauUW++PZ5/uredcYCVW0Axr4fERF3ImRaGIsa1RtWvXjG6lNODBvC23dSzyK9CnJYwod+
 AYqAUqbUfVVJU1INOIxTeaiN/w2SnsLJCBonHaIF/RNAkfYoZcKPJ/NbVdR1W56C7uWyb5zALYe
 OtWpb9t9chVOORg+nG48fJbP9GphTrtxcctFXE0VVynfoPSpuZNhPF4tRjXcGdF3aUjjJnbesN5
 5Ev3W/spHpkrf3PVMsn+/wYjyoGKoqhubtI9deAtM+Ytc+crB1wFvaMZ77lNbtBdXDWoJW1cuIm
 c5V/V5ZL1urFYm7+5fER9p8Dv44Q5OcsAGJ+kLBDKFQZZ3mS5XiMGQaF8iIk8gFh02gi4nMG2GA
 uZpwecamY0TKWX
X-Received: by 2002:a05:620a:2719:b0:93c:6e7d:da68 with SMTP id
 af79cd13be357-93ca9512ff6mr525948185a.3.1790823023082; 
 Wed, 30 Sep 2026 19:50:23 -0700 (PDT)
X-Received: by 2002:a05:620a:2719:b0:93c:6e7d:da68 with SMTP id
 af79cd13be357-93ca9512ff6mr525946285a.3.1790823022570; 
 Wed, 30 Sep 2026 19:50:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba42fb8616sm367486e87.58.2026.09.30.19.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 19:50:21 -0700 (PDT)
Date: Thu, 1 Oct 2026 05:50:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Joonhoe Kim <26rote@gmail.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dpu: stop the slave video interfaces before
 disabling a split encoder
Message-ID: <rzfyie7yah3c5ymterw2nkbyex4xw65heszybuqkrtvmtmmx5k@gcgxglxsfiaz>
References: <20260929174819.3855-1-26rote@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929174819.3855-1-26rote@gmail.com>
X-Proofpoint-GUID: 941FL7ITs_VbFg9RqjGguXbWN0De2Pmz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAxMSBTYWx0ZWRfX1W+91DP+Y3+J
 JQWzsruCnUL2bSBLPIUTpIgyYhiTcOvnpw5TIHTm6lYpaq7I+z10NpNFBY3JGn7W9g7HjSbS1gT
 BSyjyXck6+J3ntmnNdIXfRTmgzBXBn8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAxMSBTYWx0ZWRfX8mnjJJ9Dc0Kp
 tHZdjTenlx398tV/k2T4Eh+tZjTPg6yzMXnxg5ila/Y7dSDnSmLVgH7Rf2ot6UW7qdb+q9hWqW5
 LGWF8phDhYHtwnbCdNTFqV9QYnahefSHYxcuBwd8xgivS6adiplvUf1H4MkvMVQXIsbkbGvja4Y
 0hDIBoT8zsspIDn0qP9EFMEOZpdpdygBBvpNWz03iFSsm8rZCbiHRkmECQYsKrBkDSVQyWr0wuB
 A+uQhJW3qE1Xyecd5Ex+IzQrtS+n+ta7hIHaQbuSUuj5BD81kMKXfTezU3HArT/5JbeeuK7Se9Q
 IJ0xGTgGl258QDePE1KjVDv/lvYP2A5Flv5PjabiQHUclhY01lNJFinZNmQN2QDmZk/ejAv8Hjb
 Hv2c/a66MmP8jLniRITVrq3dNKeC73ynhGUNZZT/TIa4ZroYulDSi1fKu/YGEaWf+QMMMEFFjMU
 ws1G84z6zeTVdWubHgA==
X-Authority-Analysis: v=2.4 cv=NuxE4MdJ c=1 sm=1 tr=0 ts=6abdca70 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=gxmXS1c8SbOTWsDyRUkA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 941FL7ITs_VbFg9RqjGguXbWN0De2Pmz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010011
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

On Wed, Sep 30, 2026 at 02:48:19AM +0900, Joonhoe Kim wrote:
> dpu_encoder_virt_atomic_disable() disables the physical encoders one by
> one. For a video-mode master, dpu_encoder_phys_vid_disable() stops its
> timing engine, waits for the frame to finish and then runs
> dpu_encoder_helper_phys_cleanup(), which resets the CTL. With a split
> display (two interfaces driven from one CTL, e.g. bonded DSI) that CTL
> is shared with the slave, whose timing engine is still running at that
> point: the source pipe starts fetching the slave's next frame and is
> left stalled half-way through it (on SM8850, SSPP_CMN_STATUS 0x10030
> with the fetch and unpack counters frozen, where an idle pipe shows
> 0x10003).
> 
> The stall is cleared by a power collapse of the MDSS core GDSC, which
> normally happens between a disable and the next enable, so it goes
> unnoticed. When MDSS stays powered across the disable -- a full modeset
> within one commit, or another runtime-active user of MDSS such as the
> DP controller -- the next enable of the bonded DSI panel scans out
> nothing: the DPU keeps committing frames, the layer mixers produce no
> output (CRC 0), and the panel shows black with the backlight on. A CTL
> reset at enable does not clear it.
> 
> Stop the timing engines of the slave interfaces before the master is
> disabled. The master keeps stopping its own timing engine in
> dpu_encoder_phys_vid_disable(), which counts the final vsync before it
> waits for it, and its cleanup then finds the slaves idle.
> 
> Seen on a Lenovo Legion Tab Y700 gen 5 (TB323FU, SM8850) with a bonded
> DSI video-mode panel (CSOT PP8807HB1-1). It reproduces without any
> external display by keeping MDSS runtime-active:
> 
>   echo on > /sys/bus/platform/devices/9800000.display-subsystem/power/control
> 
> then DPMS off and on from the compositor: black 3/3 before this change.
> Every full modeset (e.g. a refresh rate change) went black the same way.
> With this change: DPMS off/on 15/15 show the picture, with no "wait
> disable failed" timeouts. Only tested on this device.
> 
> Fixes: 22cb02bc96ff ("drm/msm/disp/dpu: reset the datapath after timing engine disable")
> Assisted-by: LLM
> Signed-off-by: Joonhoe Kim <26rote@gmail.com>
> ---
> Changes in v2:
> - Stop only the slave interfaces up front and leave the master to
>   dpu_encoder_phys_vid_disable(), which counts the final vsync before it
>   stops the timing engine and waits for it; v1 stopped the master too,
>   so that vsync could arrive before it was counted and the wait could
>   time out (Sashiko review). Subject updated to match.
> - Link to v1: https://lore.kernel.org/all/20260929130621.943-1-26rote@gmail.com/
> 
> Saim Shujah's "drm/msm/dpu: clear pending flush state before physical cleanup"
> (https://lore.kernel.org/all/20260826182459.1506522-1-saimzst@gmail.com/)
> alone does not help here: still black 3/3 with only that change.
> 
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 33 +++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 1f20695f81e3..2f8b6204c93e 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -1380,6 +1380,36 @@ static void dpu_encoder_virt_atomic_enable(struct drm_encoder *drm_enc,
>  	mutex_unlock(&dpu_enc->enc_lock);
>  }
>  
> +/*
> + * Stop the timing engines of the slave video interfaces of a split display
> + * (two interfaces on one CTL, e.g. bonded DSI) before the master is disabled.
> + * The master's cleanup resets the shared CTL; with a slave timing engine still
> + * running, the source pipes start fetching the slave's next frame and stall
> + * half-way through it. The stall survives until the MDSS core GDSC is
> + * power-collapsed, so when MDSS stays powered the next enable scans out
> + * nothing. The master itself is stopped by its own disable path, which counts
> + * the final vsync it waits for.
> + */

Drop.

> +static void dpu_encoder_stop_slave_timing(struct dpu_encoder_virt *dpu_enc)
> +{
> +	unsigned long lock_flags;
> +	int i;
> +
> +	for (i = 0; i < dpu_enc->num_phys_encs; i++) {
> +		struct dpu_encoder_phys *phys = dpu_enc->phys_encs[i];
> +
> +		if (phys->split_role != ENC_ROLE_SLAVE ||
> +		    phys->intf_mode != INTF_MODE_VIDEO || !phys->hw_intf ||
> +		    !phys->hw_intf->ops.enable_timing ||
> +		    phys->enable_state == DPU_ENC_DISABLED)
> +			continue;

I think a more correct way would be to follow the enable path. In
dpu_encoder_virt_atomic_disable() first call disable() for the slave,
then for the master. It should fix your issue.

> +
> +		spin_lock_irqsave(phys->enc_spinlock, lock_flags);
> +		phys->hw_intf->ops.enable_timing(phys->hw_intf, 0);
> +		spin_unlock_irqrestore(phys->enc_spinlock, lock_flags);
> +	}
> +}
> +
>  static void dpu_encoder_virt_atomic_disable(struct drm_encoder *drm_enc,
>  					struct drm_atomic_commit *state)
>  {
> @@ -1412,6 +1442,9 @@ static void dpu_encoder_virt_atomic_disable(struct drm_encoder *drm_enc,
>  
>  	dpu_encoder_resource_control(drm_enc, DPU_ENC_RC_EVENT_PRE_STOP);
>  
> +	if (dpu_enc->num_phys_encs > 1)
> +		dpu_encoder_stop_slave_timing(dpu_enc);
> +
>  	for (i = 0; i < dpu_enc->num_phys_encs; i++) {
>  		struct dpu_encoder_phys *phys = dpu_enc->phys_encs[i];
>  
> 
> base-commit: 6375e61c01e93e35ee7acd336a689ac1fae4b509
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
