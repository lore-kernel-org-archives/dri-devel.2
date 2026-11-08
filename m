Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AD1606A31C
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 19:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eICtd3Gd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GFArpq1x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CAA910E422;
	Sun,  8 Nov 2026 19:18:01 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B04110E422
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 19:17:50 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A8HoYlL1769504
 for <dri-devel@lists.freedesktop.org>; Sun, 8 Nov 2026 19:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=1bB8siXgq9lNTN1p++gxRLJc
 cSlMsOx90u5ACH+aXpw=; b=eICtd3Gd02zQuqH9cb/bdGikiCeIAX/K8IybIhGY
 IP55UGP3jmLO6ii39WmYR+87OvnszYqWdW5HecyFPstcWdRoRIIztB3TG42dHciy
 +rEUIlBNI5AHcbRaTo8NmdXOgLYXLz3povWFaN+/0Dd2StQTAJEaDOxRVJwBByfC
 JpD5pawoRlx1INY8NNMBXkvW+FqFl4/Bcmc3SVhOVRCPdXQismoOng3EjPRh+lEV
 tc9GC2i95IQmL1pCHDTm4vBOLBngCP9NRoM+y5/ZNZBqrI+JePqkSBKajLEZvN4z
 JKoiiZABJZk+vv38RW35MfMlQAXSxuzy9Ug4O68DUHN1JA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsuagummd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 19:17:48 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91e9a0eae11so4032076d6.0
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 11:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794165468; x=1794770268;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1bB8siXgq9lNTN1p++gxRLJccSlMsOx90u5ACH+aXpw=;
 b=GFArpq1x3U26TXbc+8BjBcO+2PxgoYqbpqo6BjW3bnwLHoSNOOqrkImDVbFOwmp1dl
 jCKS4vtDJNSAZ4QJkk7V1VZO5H3SAjhpR+1wuhp2qqzvDXnw3OaFasTFOYPeAPbFGK1C
 2gbZObjfozO539K439CzJfquH7bZPvntWwzSIaTqMpLTbEwWiopcqthJG1DHBX62ewJ0
 zfueK24wGYkc8RlgSuhYBhQ7MLibfFq8LWFhM/4Xs8mZJ1lOUUz1gLfYuweazNfF4eXw
 9YKZsI6BecipBGdohaVF9VRZdAl50vCB87YL3uVWHGRyeL9jSRHUp6mYOy0ha/QRmS16
 cOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794165468; x=1794770268;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1bB8siXgq9lNTN1p++gxRLJccSlMsOx90u5ACH+aXpw=;
 b=wpggWxpOVFsm5c2M3vBioQuRLdoE4FKfuRtFJQA5E5eL7HcWOc4HlbcfXeNmyJiTQc
 ZnQV//S1MSdbzFOzZ/C4lxf2JZZ6unqK/nI9/+GglnCqI3x3xi7FHci71sshgrdoJMqW
 oUwaWFleJiALvzz5/VQ6MipStif3KD6Ju4v93iMSohNm0AWa+YrWjNt7I0eHu6kfGGC+
 GxKCsKMaQAmz1UicnEZ4FsA8oH5xD9cC+n4k9JwYQ1JRHi7+wLlrsuTDjKMO9V8XMFw0
 d4tJlYUptKyL/YR8tBPCnY8AHi8JIeuYwLR5Xbu1bTCRplq1nycGP2U1/3lhZpBJMTo9
 xCQQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF42bVyvspPTgVz2E5qvcLyD/eosTp4UAOaU7Ls8JptPtzauGQzsSIF0TLJ98LgcLwyRYCi+Kw4Eso=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8NabD5M8TqyIpIF7rtL0YAhtmf2xuDLOKa+i4diVtmN/OvWcfK
 szaO1MlN+sX30YR+e9lC0JaNAs1Dc+ipk/qAAr6Ol30AltxU/tsIXuALT/3OzMzyhDlIsN/eiCU
 YmBC2M5IyftuNM1RlvchPFbfbgCSfewDbuTOZRsg5zBrEGxBLPqnJguwu+ZYXf/c/hOU31Xw=
X-Gm-Gg: AYBFou3lrnjeWBSHQyIJzwli/3ZaMxKMJFTKkiInC02L4/jFOEEN/3N3hUOtRlDVFry
 91Y0e90kdjrMHb4siDQUXBVyxO3oudQEo9TBqaWX0+QL08ZmmDmSC55OgcD64FzBYjxzu6o/CMC
 zcjGD82dt/GjRDev1bb8CUBITMXlmb0k94yzckwVv9TcvRQxpWoe9Nfs+gA1PZ/2GRB1L5D/Ve4
 rOcFOrXvw7+zO4cBCcntjtRmx4uG3XJJ4rlRoJ7LPozRLQyB5fUhFcdiv9XsuXWhO3wK0LrzbvW
 AEh5DWuXfooRC+i7C0zOFWwZr3t2IQKaBE7KXMnKg0QNrkVl30db9+/8e5mTy7KBHFBZrQ2k6vW
 awwIfWdlI0I1T+fNYzFZqUjp/WuR6tM+zkGbHlMt1kz/hK4vbOsLtO2ie8naWcfOZbgbXMbEhug
 sQP8rUMKn3tPNVAbR5h6XoNZY6DMHSZdT1qWyZvvbw102jM3lapFSnQf4jjF+l
X-Received: by 2002:a05:6214:2242:b0:91e:7bef:a4b4 with SMTP id
 6a1803df08f44-91ed21dc9a0mr29241606d6.2.1794165467952; 
 Sun, 08 Nov 2026 11:17:47 -0800 (PST)
X-Received: by 2002:a05:6214:2242:b0:91e:7bef:a4b4 with SMTP id
 6a1803df08f44-91ed21dc9a0mr29241286d6.2.1794165467348; 
 Sun, 08 Nov 2026 11:17:47 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3adf9e11efdsm4742371fa.20.2026.11.08.11.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 11:17:46 -0800 (PST)
Date: Sun, 8 Nov 2026 21:17:44 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Joonhoe Kim <26rote@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Pengyu Luo <mitltlatltl@gmail.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 7/9] drm/msm/dp: handle the IRQ_HPD events reported by
 USB-C
Message-ID: <ojxncf2ac6pt4lyo5qgxddpri33jlazkkgkcto4bnlw2ctxr5t@y2btbks37qkd>
References: <20261024-hpd-irq-events-v8-0-6ee949e7a384@oss.qualcomm.com>
 <20261024-hpd-irq-events-v8-7-6ee949e7a384@oss.qualcomm.com>
 <20261108011501.4466-1-26rote@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261108011501.4466-1-26rote@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDA3NiBTYWx0ZWRfXzYlSUBjFYdop
 +SVILC/Ibrwf1qnjar5fthNbe+X8IQnEPZ7VBoHPV6MIQH7JlXW68F0d5jvi8LzsoloNfcYUuqy
 1fFSbRme8r0yqHmag+D66A4LSxr6L1tAI04UC2ArhZjS+hgf0wWBKz82fYCMwSxwVX01kzcnCLi
 DVFvm1K6O9Zxsxc/0gdZN+9jgAAvFLo2rsNNCf3HFFakn+k2yJvJEBObz+k/+5Q+erjqMPK290o
 x9cOiTt/7AzT6L3Olz52HpOlpIgfAv6SFvm07mgmfNHjAd19UGVKKRxHyfXT2qQB3b//jyGMEEN
 hj5EOBg51jxfnM6nVVM6fu0tZpMqVE4VkxdnfGvyTXYJEBpwpvAQEIdotBaFY6Q95W4DGom0jMG
 voaYFesjeomyGnHM5gCWuFMBnfekMYGU0Sm6RJJF+pC2udUit/tSumt+wSbC6AKF4Mg2SqGBOqm
 c7PBR0bl6VgH/LrIlEA==
X-Proofpoint-ORIG-GUID: 0s0fqHsCL-Wqn0awoVFgWApQsa8IhX83
X-Proofpoint-GUID: 0s0fqHsCL-Wqn0awoVFgWApQsa8IhX83
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDA3NiBTYWx0ZWRfX4ouR0B3B9HOn
 HwssL6q2FIGw4AHkpP0JZrIqyklk4DslVSzjBuiA1manytlgetM985eTFTaAPt1eq4PFsI5W551
 rOvposWVOX/ZgsiOemSTcXa7EadRhns=
X-Authority-Analysis: v=2.4 cv=V8LoQuni c=1 sm=1 tr=0 ts=6af0cadc cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=PZBFViYrEbeYNj6pPQoA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-08_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080076
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 08, 2026 at 10:15:01AM +0900, Joonhoe Kim wrote:
> On Sat, 24 Oct 2026 03:35:23 +0300, Dmitry Baryshkov wrote:
> > +		if (hpd_link_status == ISR_IRQ_HPD_PULSE_COUNT ||
> > +		    event == DRM_CONNECTOR_DP_IRQ_HPD)
> > +			msm_dp_irq_hpd_handle(dp);
> 
> With this, an IRQ_HPD that arrives while the link is down hangs the
> board. I hit it on the Lenovo Y700 Gen 5 (TB323FU, Kaanapali), DP over
> USB-C (pmic_glink altmode), when booting with a 5120x2160 SST monitor
> attached. The tree is Linux v7.3 with this series (6/9 replaced by an
> equivalent local change), the MST v7 series [1] and a few local fixes
> outside this path.
> 
> The path itself is not new: the native HPD block can reach it through
> ISR_IRQ_HPD_PULSE_COUNT. This patch makes it reachable from USB-C,
> where every IRQ_HPD now goes there.
> 
> When the boot-time mode is disabled for the first modeset from
> userspace, the monitor loses the link and sends an IRQ_HPD with
> LINK_STATUS_UPDATED (DPCD 0x204 = 0x80). From a boot with the
> active_stream_cnt check described below and drm.debug=0x100
> (msm_dp_irq_hpd_handle() is inlined into msm_dp_bridge_hpd_notify()):
> 
>  [    4.572532] [drm:msm_dp_ctrl_off_link] disable
>  [    4.573756] [drm:msm_dp_ctrl_link_clk_disable] disabled link clocks
>  [    4.608443] msm_dpu 9801000.display-controller: [drm:msm_dp_bridge_hpd_notify] type=10 link hpd_link_status=0x0, status=1
>  ...
>  [    4.823192] [drm:msm_dp_link_process_link_status_update] channel_eq_done = 0, clock_recovery_done = 0
>  [    4.823194] [drm:msm_dp_link_process_request] sink request=0x80
>  [    4.823197] msm_dpu 9801000.display-controller: [drm:msm_dp_bridge_hpd_notify] sink_request=128
>  [    4.823199] msm_dpu 9801000.display-controller: [drm:msm_dp_bridge_hpd_notify] 128
>  [    4.823201] msm_dpu 9801000.display-controller: [drm:msm_dp_bridge_hpd_notify] After, type=10, sink_count=1
> 
> Without the check, msm_dp_display_handle_irq_hpd() calls
> msm_dp_ctrl_handle_sink_request(), and msm_dp_ctrl_link_maintenance()
> starts with msm_dp_ctrl_push_idle(), which writes REG_DP_STATE_CTRL
> while the link clocks are off. The board hung on 3 of 3 boots with the
> monitor attached. On the one hung boot with drm.debug, the printk ring
> ends at the "128" line, the drm_dbg_dp() just before
> msm_dp_ctrl_handle_sink_request(). In the two RAM dumps I could
> analyse, CPU0 is still running pmic_glink_altmode_worker, which holds
> the encoder's bridge_chain_mutex taken in
> drm_bridge_connector_hpd_notify(), and ctrl->link_clks_on is false.
> 
> Locally I skip sink requests while the link is down. On this series
> alone the check would be on power_on:
> 
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -400,3 +400,6 @@ static int msm_dp_display_handle_irq_hpd(struct msm_dp_display_private *dp)
>  	drm_dbg_dp(dp->drm_dev, "%d\n", sink_request);
>  
> +	if (!dp->msm_dp_display.power_on)
> +		return 0;
> +
>  	msm_dp_ctrl_handle_sink_request(dp->ctrl, dp->panel);
> 
> This matches the !power_on check that already guards
> msm_dp_ctrl_push_idle() in msm_dp_display_atomic_disable().

This looks ok. Would you please send this change as a proper patch?

> 
> In my tree the MST series replaces power_on with active_stream_cnt.
> With the same check on active_stream_cnt, 2 of 2 boots came up on the
> monitor; the link is retrained about 1.2 s later, when the stream is
> enabled.
> 
> A check on ctrl->link_clks_on in msm_dp_ctrl_handle_sink_request()
> should also work.
> 
> [1] https://lore.kernel.org/all/20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com/
> 
> Thanks,
> Joonhoe Kim

-- 
With best wishes
Dmitry
