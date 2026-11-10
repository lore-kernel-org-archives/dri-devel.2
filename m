Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38457606A33A
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I0O9t7D8;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fqCFNKRI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 532E210E924;
	Tue, 10 Nov 2026 04:14:43 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D3E210E905
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:14:27 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA4A6JV2275497
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vllnIhdcYddUgpKRqNaXWbED/1ru4P1SPL9KLTf0SHE=; b=I0O9t7D8jKbeREzo
 ogVy45Iay7aVJZznNjGFmNWwW8JAgZFxQAbZThtWYU3ji0d/tf+mAggZyhEffgiR
 ljFoEErCP6w4+hmyIezNVvPZqZBhs78n8bjN0uKsQHoqDt8VXN/6X6wfUF23dxcz
 f53LzLYB66830wEg18oIbUNId6eYPv0JXVNYxEVbPuxB1I3OgKjQh5EKE3aTJbxg
 xgGzJt9SgNCef4PZNZk48gHw2KIkun16+b5TRdDtB+dvXy4M3i46c94Pkfw47KLH
 +fxWBSELchTPlNO3An3AY/HBKNU1Aics//Hm1a7YLAdje6OEjfD1aLuLaJByahQq
 jqlxIg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hudf5bd55-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:14:25 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ae19907a31so1407198a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794284065; x=1794888865;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vllnIhdcYddUgpKRqNaXWbED/1ru4P1SPL9KLTf0SHE=;
 b=fqCFNKRIJoF/vdnrh587zVWIaC8y3C4w7WUJcRYDvv9b8fyP2F4W35eWknLkEKNZh3
 sLxvaqj6hL0TdFqrXh1eNUMqqTi1njgeQLIWVWO1BpMiVH0toRYe8Fpkn+MVPuuMCpbE
 2by5TdU2UxpwlS9vYTdNvXrehVGVtbpV1Itsuu8Tjku49DzriA/cEj6lSDlW+XWjGB0Y
 Z5hNRD/pwOxHFHqjekbwjtxGu9jAS+5nT+9lARDdwNm61Ec0SrNgfvk1mj/pKZIQwxsK
 atQgoXGJ+xloR5CvTEd+0ncTyV1Iu9BqNEa6NxiDn3TyEg4+PalBMa6WswtiHUS4LN+2
 piPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794284065; x=1794888865;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vllnIhdcYddUgpKRqNaXWbED/1ru4P1SPL9KLTf0SHE=;
 b=qrPk3ejYbKqqVOBoSClU8GwGWCT5npihsOX45xyAL+3TGLERrpYLoe0IKaGQ+ofp4k
 cDjI22lykXIIfaPOAVnBnNwG7jLRRpnzPWyAiYb6dSzTHQXwwIUo+NWtsXJq35NMmV96
 1z7Gm25cnhvD8xUa6Sdi9S6LJkpbZz7blWSOXUQA03QX87rt1jv2RsGBkKBDat8nEI6M
 0dGzi0zPDU1OjycFbhI63GP+QJmuHWyCM35Uav219XKguvCuIznF8C3cGughW7i4llVR
 aYX5tERR61JZYh6NkgZxbiR3GVhKIdBYsox+ywPFZbjExaNvxGEYCssHUz1safqGfGdc
 Nn2A==
X-Forwarded-Encrypted: i=1;
 AL+hErEf0x8/aS20dzd1TZ6AXTCiviTvUIBwtdzWU5PQ1YAnAVGUQ8BowdmPhDDOduzNXjVaxVQM6c13Dpk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9KoJQcZbCoPmj2Y8vVJZp/qeIRmjiFYA/DlpdC5vwm4TWrVemW
 Uj04JmCgAAtDfG1ttWbHY+zCrbShJZYFGVGoc/8A+mhRH8CYpncfBXKtw0MUNb7Cd71rsHEEUlj
 wb+vE/OSjx1bXvZZUqoa5l6BEWa82Q08PlYxkFUDYbZ7ZjNfFsNCURwdniz58UNvnXLE4hZE=
X-Gm-Gg: AYBFou2o5sPn9QSi/kYnekTPQ1zC3NW988LRXft7gJtnXt8DO6Af4JWYpCqbULM3gvJ
 defeacKSnVfoyGi0ua4gOLU/rvWT4mMtqtHW8Z2R4dbkxWpM7MCD6juCrxA/rFdwFstiwwRX3UZ
 u1cuaPm2UueyqqHpU6s+9UgsV5VB74YVZQJmWNdpUS2/Sw/eImMNuH0+P9oW5EJkr4dzsWTXev7
 U1H45QmqtQCR/Kgirtl7ERirEZ7Rm16th3c2Gy4eq9J5jo3yu0JslHkFrhOe2II/bSidd/BHrtD
 mlmTF5JUXQJ+THSZ2V4xueRNJP343CTqimASIrD0EyUlYdI+J9oxQ5YHVcsNAWqMSdAdIzbU9EK
 TIzSsXr3XQfFCl7/voLf55HxKMKT6w1gTQXUiyDJiuesRV7lXdM6Ps0uloNae4RvehJupmZSR0w
 h/
X-Received: by 2002:a17:90b:1c90:b0:3ac:9ed8:f301 with SMTP id
 98e67ed59e1d1-3b1679e96cbmr1115502a91.30.1794284064623; 
 Mon, 09 Nov 2026 20:14:24 -0800 (PST)
X-Received: by 2002:a17:90b:1c90:b0:3ac:9ed8:f301 with SMTP id
 98e67ed59e1d1-3b1679e96cbmr1115485a91.30.1794284064054; 
 Mon, 09 Nov 2026 20:14:24 -0800 (PST)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b168a8de09sm995443a91.0.2026.11.09.20.14.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 20:14:23 -0800 (PST)
Message-ID: <91e543e8-3e4a-464f-86cf-a9ac95ac84c8@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:14:17 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/35] drm/msm/dp: Add MST support for MSM chipsets
To: Joonhoe Kim <26rote@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20261108011450.4428-1-26rote@gmail.com>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <20261108011450.4428-1-26rote@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Jh7M7jOs1P-lt8KskaIXADjCB-DeAhLI
X-Proofpoint-GUID: Jh7M7jOs1P-lt8KskaIXADjCB-DeAhLI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxNiBTYWx0ZWRfX9S6muD5NU4rh
 Yhz5H5Bo44nJvluSs/MXMcaOmukVATDwkB5XuD8ecIiit7xK3QVKdsEesuQHFL7RoFdrpJeLc4Z
 Uo06n2WfXlJJvxusYJxvGH0HP8GOJUc=
X-Authority-Analysis: v=2.4 cv=bar+w+PB c=1 sm=1 tr=0 ts=6af29a21 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=xnScQCINOySfzLI4sGMA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxNiBTYWx0ZWRfX01xKSDu2XXTA
 5Tuae7jQIc+IwNpxVkpIWNmiFK/EtuipuWWAwa0b+5HNIzvsn3mEdyf4dUgVfx1LGqObZqA25TR
 uEDQQFtHvVxogfIgIWP7rI89VlvBCY50r/GxqgWNwUZy4oUxaL/t2bGfzAcO9MVKyBJLR8jpzHc
 FNdx05qjLaPLVxIbXmWAJNl9uqSHuByC/vQ5UEZjtqpqB7R4qcUzq1RM6YBRi95PY6HbwiHKIKQ
 MctrNg42E72t5mXdvmdEZcCSbYkbUCIXYCCySd/Y3QG4Oudb471lb5Niex4MBFmmIpFgIZ2U+LN
 JApEwnL0o5vBGJeyuo3Ce4zXpkcfGxFP/2s1Uh1Fpc+D4wjton1bYH9nfCTgcDsIrafAAIgGnSE
 8ogljTlauzA6sw4JjlWrLW7n4bGd1r0tclj1vhjdXJK7siWu1oZ/+KbnKtwjsWd3PGX9Cv4TuS+
 lq3ZJO/h5U/3ZRw886Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100016
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/8/2026 9:14 AM, Joonhoe Kim wrote:
> I tested this series on the Lenovo Y700 Gen 5 (TB323FU, Kaanapali):
> DP0 over USB-C (pmic_glink altmode) to a dual-screen monitor with a
> built-in Realtek MST hub (two 1920x1200@60 sinks), with the built-in
> dual-DSI 1904x3040 panel also on. The base is Linux v7.3, not
> linux-next, with Dmitry's "drm: handle IRQ_HPD events correctly" v8
> [1] (the cover letter lists v5) and this series. A few hunks were
> adapted to other patches I carry. On hpd v8 the second hunk of 34/35 is
> not needed, because msm_dp_bridge_hpd_notify() already handles the
> plug before IRQ_HPD.
> 
> With three local changes, both screens show separate desktops next to
> the built-in panel and come back after s2idle.
> 
> 1. The plugged_lock / mode_config.mutex deadlock that Sashiko reported
>     on 32/35 happens at boot with the monitor attached. The stacks are
>     in my reply there [2]. I dropped 32/35.
> 
>  From the cover letter:
> 
>> With 4x4K monitors, due to lack of layer mixers that combination will not
>> work but this can be supported as well after some rework on the DPU side.
> 
Thanks , will  dropped in the next version, same as you did locally. It 
not needed
> 2. With all three displays on, the commit for the second MST screen
>     fails:
> 
>     [drm:_dpu_rm_check_lm_and_get_connected_blks] [dpu error]LM_4, invalid DSPP_-1
>     [drm:_dpu_rm_check_lm_and_get_connected_blks] [dpu error]LM_5, invalid DSPP_-1
>     [drm:_dpu_rm_check_lm_and_get_connected_blks] [dpu error]LM_6, invalid DSPP_-1
>     [drm:_dpu_rm_check_lm_and_get_connected_blks] [dpu error]LM_7, invalid DSPP_-1
>     [drm:_dpu_rm_make_reservation] [dpu error]unable to find appropriate mixers
>     [drm:dpu_rm_reserve] [dpu error]failed to reserve hw resources: -119
> 
>     The compositor sets a CTM on every CRTC, identity when unused
>     (adding or removing a CTM later forces a modeset that reassigns
>     resources), so each CRTC asks for one DSPP per LM. Kaanapali has
>     DSPPs only on LM 0-3. The built-in panel takes LM 0-1, and the
>     first MST screen takes LM 2-3 because 1920 > MAX_HDISPLAY_SPLIT
>     (1080), which leaves no DSPP for the second MST screen.
> 
>     This is a DPU topology issue rather than an MST one; MST just makes
>     three active CRTCs easy to reach. Locally, a CRTC that needs DSPPs
>     uses one LM up to max_mixer_width (2560) instead of
>     MAX_HDISPLAY_SPLIT, and the two MST screens then get LM 2 and LM 3.
>     This touches the same decision as Mahadevan's LM rework [3], which
>     drops max_mixer_width, so I have not sent it as a patch.
> 
>     Mahadevan, should a CRTC that needs DSPPs prefer a single LM
>     whenever the mode fits in one, on top of your rework?
> 
Yes, this issue will be solved in another series.
> 3. s2idle with both MST screens active hangs in resume. The console is
>     suspended; the printk ring in the RAM dump shows devices resuming,
>     nothing from DRM, and then "watchdog0: pretimeout event". The
>     rtcwake task is stuck in an AUX transfer in resume, while the MST
>     stream is re-enabled:
> 
>      wait_for_completion_timeout
>      msm_dp_aux_cmd_fifo_tx
>      msm_dp_aux_transfer
>      drm_dp_dpcd_access
>      drm_dp_dpcd_write
>      drm_dp_dpcd_write_data
>      drm_dp_dpcd_write_payload
>      drm_dp_create_payload_at_dfp
>      drm_dp_add_payload_part1
>      msm_dp_mst_stream_enable
>      dpu_encoder_mst_atomic_enable
>      drm_atomic_helper_commit_encoder_bridge_enable
>      drm_atomic_helper_commit_modeset_enables
>      ...
>      drm_atomic_helper_resume
>      drm_mode_config_helper_resume
>      msm_kms_pm_complete
>      dpm_complete
> 
>     Several kworkers wait for a modeset lock in
>     drm_self_refresh_helper_entry_work().
> 
>     At the hang active_stream_cnt is 0 but link_ready is 1, so
>     msm_dp_display_prepare_link() returns early and the payload write
>     goes over a link that system suspend has powered down
>     (aux->retry_cnt, the count of consecutive AUX failures, was 107).
>     While mst_active is set,
>     msm_dp_mst_stream_post_disable() does not unprepare the link after
>     the last stream, so nothing tears it down for system suspend.
> 
>     The series also does not call drm_dp_mst_topology_mgr_suspend() or
>     drm_dp_mst_topology_mgr_resume(); i915, nouveau and amdgpu call
>     them around their atomic suspend and resume.
> 
>     Locally, the DP system-suspend callback calls
>     drm_dp_mst_topology_mgr_suspend() and, when MST is active, tears
>     the link down through the unprepare path (clearing link_ready)
>     before pm_runtime_force_suspend(). On resume, after
>     pm_runtime_force_resume(), it re-inits the PHY and AUX and calls
>     drm_dp_mst_topology_mgr_resume(mgr, true); if that fails, it turns
>     MST off and sends a hotplug event. With that, 3 of 3 RTC-woken
>     s2idle cycles resumed with both screens on. After the third the
>     topology was rebuilt (the MST connectors came back under new
>     names). I can send this as a patch on top of the next version of
>     this series if you want it.
> 
Please feel free to send it. I tried to add these functions, but I 
didn't have enough time to fully test the code, so I removed them before 
sending the new version.
> Unplug and replug mostly works. When it failed (3 of 6 sequences),
> the hub had dropped HPD or stopped answering AUX right after the
> plug, and one or both screens stayed dark; the stock Android kernel
> shows similar failures with this monitor.
> 
Actually, link training is not always stable. It may be related to the 
dongle, and we need to improve it further.
> Not tested: daisy chain, 4K, audio over MST (no audio sink here).
> If it helps, I can test the next version of this series on this
> device.
> 
Thank you for all the testing and feedback. These are all real issues. 
Although we may not be able to fix all of them in the next release, your 
feedback is really helpful.
> [1] https://lore.kernel.org/all/20261024-hpd-irq-events-v8-0-6ee949e7a384@oss.qualcomm.com/
> [2] https://lore.kernel.org/all/20261108010724.4061-1-26rote@gmail.com/
> [3] https://lore.kernel.org/all/20261008-lm_fixes_final-v4-0-fa986071c3c1@oss.qualcomm.com/
> 
> Thanks,
> Joonhoe Kim

