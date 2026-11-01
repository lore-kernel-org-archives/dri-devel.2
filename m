Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BE2606A338
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cbjp4+2E;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OHMw4OKN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B25110E24A;
	Sun,  1 Nov 2026 10:58:53 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31CED10E32E
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 10:58:42 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A18Kcbi310516
 for <dri-devel@lists.freedesktop.org>; Sun, 1 Nov 2026 10:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=V26Rxt/dvQi8UJT1RGBvNKJz
 ELhSQFEnT8mAHiQZZLw=; b=Cbjp4+2EQhHPRe4vPcA3aMWtw6AnTDzXXsMkAlkP
 NSvAZTe2toamPYew41bCKmT4KDChnIS1gKngGgUBhdjsxtsNIqS00CYsdIdaJmH0
 OF5YOlJsIyUujDJLmR8dCOTpgrege3HvmDNrcwcviJGmfg/39VGIbzgeD7Lu5uRL
 KINv8MNjjuGoQEw0CqTNyvSlSEqYM+QPUQZpipu3NFNEPAGEkV7HbCbcXmmYbHTY
 2IOb/70CtbgBZ1Sm8qa2PL6yWKBC9pXYQwlK41+oKbQCxoZ7jBFhj/rYrI6Vb0iT
 wBvPXBRHGFahrJxOVOX8NdBhpc9+dAhjFY55MB5VOgy/Vg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8j2u6vs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 10:58:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f3969a2a7so336171585a.2
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 02:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793530720; x=1794135520;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=V26Rxt/dvQi8UJT1RGBvNKJzELhSQFEnT8mAHiQZZLw=;
 b=OHMw4OKN9VeOZKgohMkYn52FzlvzlrPPPglYWv5GI292CfVmOuwiB6mDLUlMiH82Xg
 cEt1NHKz4XvAiU6KMtut/xz4cY9ASRuJdaVLZM5/Ek+dr/xaTNywuDlG6yU0Dy+HzUbU
 812YObevQBd/R4FZiwMmWYTT0ifxePFDJsXzIh0Cjs1n3RCkJ+UsWzHD7jk7fLVxEPxd
 2DbA9DNm8I3QoDRF4zRK+9mCHE7R08eIHW6AV7eaf0CL7OHTf05mLRXUufgfz/aczIn3
 fhBdBcelixfa9L0d4L3jPD3oAsKsTvBifHtRkRcNfvhNgxbygo9HtZHwNsfc/7o5xwxt
 w79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793530720; x=1794135520;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V26Rxt/dvQi8UJT1RGBvNKJzELhSQFEnT8mAHiQZZLw=;
 b=sVSyvZ2ZwtnAx1ljWe5Wht95faQsv1f8bRGA9/KkD+v7kMWh9dVxv2A81pXIYapTME
 RzAhEDhY+D1phOBBKTqb3zOmLSriP9S9Pgw9omuWrYYvGTgFVSAYnAVawtkomSF+ouVy
 MU0FfBDhWftXyBkv3DEsaf324cNBHHNzRcxsoCjHCzRZCsgnT+/xga0DsiS4bccCVFzu
 Ob/Fu9fDRvS087UhjASGuIAUcKRz/MEKGLMY6dsicTBiYZZqk0GjkwmkMpiUZiMCCH1Q
 GvAlMqhDrl40DEOTEFNMwnWcHuv8ib2OMMU4u3Ym99+ddAmZo+uXFkMxGNSgZel/b+Fm
 dHEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjtx7oAWP7cJF7TcLdSFAhiWxwu+z0M/l3oUTG0hJOE+d/ZwWCh0Yg81OPEmJAadke5dVk6k0GiYI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIzWiE/ZXIzXwxBWiPN10WueS29Wl3f6OE3Z+VOY6dZRmZmQiOa
 fph19W7+4DO+0erssFK3sinCFh47rnnuds76abq/SFxW7smlUA9sgPO1cgqf/gPc1pnviASggmJ
 A/1LANjid1Ao0f9BmDzs1vw/ab41az62oSAlFbi6+z5vRhAfkMrPMl8GW2HYz0M/cHYDA2f0=
X-Gm-Gg: AYBFou1nwQTgMUVos/52OGNm3rnKt6noZUao0Jcj+BCxDvzyKYMMgjIU6TU0+zgaS06
 ta8brhu/0rch5AbCNpysLGFX2l3NcmgfUeig61CfKbZkTMlXcS84Px+n/W0epbRtpCAF1kgHBzj
 Fx8S/UagR2XeIhMpPRSXIEfZnzt6bZ2qhiMBUNzEucR20WZkl6DHA6s4ffmitbZ35ipdT80TEsU
 85JtD2dOrGhQOvPbMUABpVC1M7fPeJfIY7PVCOmx+w5olL6mWAc/QSZ5g83QBG+KwvYMb6AB1uP
 UC1ZZfBbSCYfw5pw7UmGa6Zolr1wOurxzNf2wB3b5hfi6/dM2QD4YdaSBv+x7IQh8Zr7yDO4TNX
 s/HmIaeLtslBaac0T2p3PwREbbDciCusmdreHXPONroueU1HZg0mLjIOU8QMmkLpd6dPBSg8uNH
 cxFGGSiwtHVy4gHp2PrGTX7S86PBm36qtQ9t5AOZ7g4a5p1tKY4VH9RwryptiH
X-Received: by 2002:a05:620a:4724:b0:93e:c12c:43fa with SMTP id
 af79cd13be357-9442171c8a4mr1167598085a.71.1793530720216; 
 Sun, 01 Nov 2026 02:58:40 -0800 (PST)
X-Received: by 2002:a05:620a:4724:b0:93e:c12c:43fa with SMTP id
 af79cd13be357-9442171c8a4mr1167596185a.71.1793530719592; 
 Sun, 01 Nov 2026 02:58:39 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfe07541b4sm1027580e87.81.2026.11.01.02.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 02:58:38 -0800 (PST)
Date: Sun, 1 Nov 2026 12:58:36 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: "Beat M. Liechti" <beat@softbase.tech>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: don't reassign resources on color
 management changes
Message-ID: <5jypdookmvfmrdaef2c54aab5kfcpjvejc6f2jyxvbjhwpqgzd@ipvdiwk3zxvc>
References: <20261101095754.33840-1-beat@softbase.tech>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101095754.33840-1-beat@softbase.tech>
X-Proofpoint-GUID: A5bSd6DRN7Jge66e2hc3X0JOchQA-3qj
X-Proofpoint-ORIG-GUID: A5bSd6DRN7Jge66e2hc3X0JOchQA-3qj
X-Authority-Analysis: v=2.4 cv=S5RMU4sP c=1 sm=1 tr=0 ts=6ae71b61 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=Ox7JqDZjdXA0ESHpvBYA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA0MyBTYWx0ZWRfX1vVtVQP9wNuk
 XRTSEZ5wdf3g0U6LxbFsxDfHcLiGlVQx9LSakaLre8042jQuc9huvlvt0MxQLVc/1jtjr2e08ZU
 fjzosmUvWOZ/fhFybP1prxZPwWcudG8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA0MyBTYWx0ZWRfXwcqhJs/WeqYj
 VYePg4P0kvJ3XHmsHEf8GmcfQq5pPyRr2Nj7k8CNqT8d0UHnX4KJNWRANcj/ISlhjQacWDzU0lg
 gpHczJysPRTskSoQfHw0REQH0KpEvYlnxMgqqegO1Yq8ay2hGMCOwOQMZNY52hAvaoCFqxqD2XC
 FYRk2EffhSnM9MGr3KTgEJ+lYegvpnwvh35ISywJCQLePBZuIh07x65ih5yFKBrqpEtI0Z+Hp/b
 n04O4dtJBEgcI/7lUgVaZhgydd4wWj+2GCESStqsR9vnTyPcB5zjD6E/Yr/YWqPvkGbX9fhaYtV
 0S4cbd3IcoA7xtDqnGqsyDgEL5S8Xbi9VygNxzDSfPjwlZgCAOJGoAuSYuYAWiNz1GqY63bOepi
 OihJW7uLDRh9erKEstPpql7pQpVT8aH/Izvl/8L7AICGl5TE8GrwErKVopxxRHADzVW0UDzaZ1N
 nwoWjvnzmX32afpPvsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010043
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 01, 2026 at 10:57:45AM +0100, Beat M. Liechti wrote:
> Since commit 39a750ff5fc9 ("drm/msm/dpu: Add DSPP GC driver to provide
> GAMMA_LUT DRM property"), dpu_crtc_atomic_check() releases and reserves
> the hardware blocks of a CRTC whenever color_mgmt_changed is set, not
> only on a modeset. A commit that merely replaces the GAMMA_LUT or CTM
> blob of an active CRTC can therefore move that CRTC to a different
> CTL/LM pair without disabling and re-enabling the pipeline, and the
> hardware keeps scanning out through blocks the driver no longer
> considers in use.
> 
> This is easy to hit with GNOME/mutter on a laptop driving an external
> display: closing the lid disables the eDP CRTC, and in the same atomic
> commit mutter sets new color blobs on the still active HDMI CRTC. With
> drm.debug enabled, dpu_rm_reserve() moves the HDMI CRTC from CTL_1 to
> the just released CTL_0 while its encoder is neither disabled nor
> re-enabled. A few seconds later the display SMMU reports context faults
> at the refresh rate and the external screen fills with garbage. Opening
> the lid again leads to a stream of "vblank timeout" and "frame done
> timeout" errors and the machine has to be power cycled.
> 
> Color management affects the topology in only one way: DSPP blocks are
> requested when either CTM or GAMMA_LUT is set. Handle that case in
> dpu_crtc_check_mode_changed() by forcing a full modeset when the
> presence of CTM/GAMMA_LUT changes, as msm_atomic_check() already does
> for the CTM, and stop reallocating resources on a bare
> color_mgmt_changed.
> 
> Fixes: 39a750ff5fc9 ("drm/msm/dpu: Add DSPP GC driver to provide GAMMA_LUT DRM property")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Beat M. Liechti <beat@softbase.tech>
> ---
> 
> Notes:
>     Testing: ThinkPad T14s Gen 6 (X1E78100), GNOME 50 / mutter on Wayland,
>     LG 4K60 monitor on the HDMI port (DP to HDMI bridge), logind set to not
>     suspend on lid close while on external power. Without this patch every
>     lid close reproduces the corruption and hang described above. With it,
>     closing and opening the lid produces no SMMU faults, vblank timeouts or
>     frame done timeouts, and both displays keep working.
>     
>     That testing was done on a v7.0.14 based distribution kernel (Ubuntu
>     7.0.0-42.42). On msm-next the patch has only been compile tested (W=1,
>     no new warnings), not run.
>     
>     Open questions:
>     - Like the existing CTM check in msm_atomic_check() (see the FIXME
>       there), this sets allow_modeset on behalf of userspace when the DSPP
>       requirement changes. Rejecting such commits without
>       DRM_MODE_ATOMIC_ALLOW_MODESET would be stricter, but could break
>       compositors that toggle GAMMA_LUT at runtime (night light). I am happy
>       to change it either way.
>     - The RFC "drm/msm/dpu: Force modeset if new CTLs have been reserved"
>       (https://lists.freedesktop.org/archives/freedreno/2025-March/036824.html)
>       addresses reassignment without a modeset in general. This patch only
>       removes the color management trigger.
>     
>     The root cause analysis of the drm.debug trace, the fix and the
>     changelog were developed with an AI coding assistant (Claude by
>     Anthropic). I reviewed the change and tested it on the hardware above.
> 
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 26 +++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 42d0a529b..3b304a896 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -1516,6 +1516,20 @@ int dpu_crtc_check_mode_changed(struct drm_crtc_state *old_crtc_state,
>  	    (!clone_mode_requested && clone_mode_enabled))
>  		new_crtc_state->mode_changed = true;
>  
> +	/*
> +	 * DSPP blocks are reserved only when CTM or GAMMA_LUT is set (see
> +	 * dpu_crtc_get_topology()), so enabling or disabling color management
> +	 * changes the hardware topology. Changing resources on an active CRTC
> +	 * requires a full modeset; otherwise the CTL/LM blocks get swapped
> +	 * underneath a running pipeline.
> +	 */
> +	if (new_crtc_state->enable &&
> +	    (!!(old_crtc_state->ctm || old_crtc_state->gamma_lut) !=
> +	     !!(new_crtc_state->ctm || new_crtc_state->gamma_lut))) {
> +		new_crtc_state->mode_changed = true;
> +		new_crtc_state->state->allow_modeset = true;

Having allow_modeset in the atomic_check() code was a hack, which should
not have been allowed in. We are trying to get rid of it, not introduce
new instances of it.

> +	}
> +
>  	return 0;
>  }
>  
> @@ -1534,9 +1548,15 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
>  
>  	bool needs_dirtyfb = dpu_crtc_needs_dirtyfb(crtc_state);
>  
> -	/* don't reallocate resources if only ACTIVE has beeen changed */
> -	if (crtc_state->mode_changed || crtc_state->connectors_changed ||
> -	    crtc_state->color_mgmt_changed) {
> +	/*
> +	 * Don't reallocate resources if only ACTIVE or color management
> +	 * values have changed. A change in DSPP requirements is turned into a
> +	 * modeset by dpu_crtc_check_mode_changed(). Reallocating on a plain
> +	 * color_mgmt_changed would move an active CRTC to different CTL/LM
> +	 * blocks without a modeset, leaving the hardware scanning out through
> +	 * stale CTL/LM state (SMMU faults, corrupted output, vblank timeouts).
> +	 */
> +	if (crtc_state->mode_changed || crtc_state->connectors_changed) {
>  		rc = dpu_crtc_assign_resources(crtc, crtc_state);
>  		if (rc < 0)
>  			return rc;
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
