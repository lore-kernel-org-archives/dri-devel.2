Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54334F3029C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 03:23:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B57B110E273;
	Mon, 16 Mar 2026 03:23:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L8pQyTRr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tv4quAcR";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 692A410E273
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 03:23:45 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62FLxvJN3915137
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 03:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wCTtvtbeSyA/RrQyiGYTxM5IzCFNImcGvaMiSQ6lzRY=; b=L8pQyTRr6ABq1Yfa
 jLM98/76PZAWz/6nsKDgwUM/5ByFsruBDk9FQ8nOo4HEUZn+5N++MVI+fKsGIVER
 5I4rKPvCtzfmyJahr3ffKpxiInVlGl78wYCRHF1djQtDd2seEaf8rtVrYdNynYBD
 enfwpMSPHKz3/d0OhnCTYNaYEzayg+ZvYh544qqkijky15UGxMGor2Sc6v7FBTEm
 8E8b9ssuskZNdDf54vuw2O7KrQ7eRQixvKQ9jKaxwJ5CeQBFfXX4D9fze7AFC5Yj
 tQ7k4kbzHuQcWjdlggj5oXc99HC5Kh9fHwKwA2qAiGWYqXlbNh/AbHjdX0FhXGrW
 zs3jUQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw00bc21g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 03:23:44 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-509114d7418so57369361cf.1
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 20:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773631424; x=1774236224;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wCTtvtbeSyA/RrQyiGYTxM5IzCFNImcGvaMiSQ6lzRY=;
 b=Tv4quAcRvnucZwvRKRoJqlWaPnCY/U15C/IBefCHv6exdaaEYYc/vCV06dP/7mh5Fm
 K5sVeIy1uSPE9ztRuEtCISXoKMH6iFzdwACH8DgcYl5MKW5BceKdQZs/rhcWQgNJKfKW
 1hzf7SjWV0hIk395x2QVdW6fwgdOZrvfyOqV9KRDaGq7z8BiMDDJXlpxXVZcOzeF5NlV
 MNdv4Gco0qb5TerQF24X1HLsoSdtTLz1yYu+7GLPct9GcQ1h0cu0axWnVZqgY9k+kcnF
 mtFf7CgYYqoppQEALFZv64H9AIEWSvJNq2/HF/OTOGrUxzjze8w+CpbDcNp3JlGMTP7w
 FCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773631424; x=1774236224;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wCTtvtbeSyA/RrQyiGYTxM5IzCFNImcGvaMiSQ6lzRY=;
 b=FZYlQN1updp7nUU74T2CS0HdYQSvksUEB9KQv+6w7XXYES4xmPMgvw+g3insBPMxhI
 nqtjv7A1RmTkqq5gN8t5kqq/uCgGPUtvibFJQQ9F8G905ET2IgwNup0hD5LkSZyzmk8t
 l1mhIpZgVHfB98fFy1oaAksK9/eYwb1IA9T1SFZjp5tmwOO/B00Q5O0sI0wuXqpxJgDd
 LLhY1ZgmKImQw4olMYGPODmWOT40UzgFfJi8Eay0zeLCSBmyQWbGQqUk+RwzRXKrCNFF
 DS94nsVIFvCu475u348rDL/vbUPMzawrIZUL7DzjCt0zuXgmQJfQ5I+PQ2cija2m4ZzD
 ch+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVExFA0jNe45N6oHl51/I2fS6mpTQIk0oycg4E+UekH154DrOAmH9zcMIxA+YhmViBzyLTLVOZwELU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxrr489KBGltgVqNmv8js/PZcKA1xn+kC1+A1Ky7xtXXIyGCG66
 5bMwm8rH6Yy5E6YN0CYf0X7IecsT93o7vbS1TkBrFXNGTrmBpwzXtRUtphgTpZ9v4EDSjMZpu3t
 nyk000dTic96igXOBBycce4p/aKEBQkc1KvHKcBLJoX4O2UuIXcPjgOjPqgZzB1wFgDZw3fU=
X-Gm-Gg: ATEYQzwKAj4juC9m9lFD2CzvZwzh1mwQ+7Mv6OSCVMnWN46iEqALiEEDq5r1JBymZgZ
 lrVNBz3zPzqAoYb8wacDbtZIVyZQoODFz9a0I+DDnA/IDYiml0ITGcTWI1b18Sfuq3ZCnhNccMq
 K+itpC55XTIjcP0ZVu0bOm4sAECmI+HiKaxIexrCrTtYomflkZkhZCWXAvRJ3Qo3O54KM3VCdC5
 IEMwUMBHukT5SWfMYwjIH2Ak6YuDCSVXA6ha4KmNUqeQRtcfRVhZvFa8wrY27jnXmTmbEI8K+67
 1vbpveod0MJUVVDs/0++fj5Izsvux1KhSI6bGEIEtt3a8kZeUY5Bx4X4uCFTQwoHfxtPx/dBvjt
 HXedwgsiNL9elVy8p3NeKn//C6G20CI7Xc2CtLZKsGrjXsadjHGEa/BCDT1YsoMcO4yCSh9I+3f
 DvpRJLREK1LA7OvtzFlajDKmQeJZLuga2gYqA=
X-Received: by 2002:a05:622a:291:b0:509:4db5:88c4 with SMTP id
 d75a77b69052e-50957e2c164mr143607811cf.53.1773631423542; 
 Sun, 15 Mar 2026 20:23:43 -0700 (PDT)
X-Received: by 2002:a05:622a:291:b0:509:4db5:88c4 with SMTP id
 d75a77b69052e-50957e2c164mr143607691cf.53.1773631423052; 
 Sun, 15 Mar 2026 20:23:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38a67e67a2dsm31696561fa.32.2026.03.15.20.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 20:23:40 -0700 (PDT)
Date: Mon, 16 Mar 2026 05:23:37 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Val Packett <val@packett.cool>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/10] drm/msm/dp: Drop the HPD state machine
Message-ID: <itszs6eu7l2zix4stdiokftgxjpqlfukbqbdg4u3sestln6pgl@yq3wud26vi25>
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
 <9c4dad2c-25bd-47d2-bc40-9b551d023615@packett.cool>
 <a6190a6c-60ae-4d24-b396-089f3b42973f@packett.cool>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6190a6c-60ae-4d24-b396-089f3b42973f@packett.cool>
X-Authority-Analysis: v=2.4 cv=IsATsb/g c=1 sm=1 tr=0 ts=69b777c0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8ndv8QXTNta43bgeejsA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=dawVfQjAaf238kedN5IG:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDAyNCBTYWx0ZWRfXwIjhHCn65gaM
 5nvTqDQMEfrX6VRi94aOJVDg8y8W0PdQyme+hJR8Q4Jpfbd77twLxMPFMymQ2qXvJaLacOaSoxW
 v9YVkqTxGgFrkI0MDC2b1FX8y1R0x76mZfq6co6Qn8vkhzZnmRWGD04c0zhvX6mY9jLEWpkg5MY
 Alsha3tZHBf2NmSWDh2zZgVz6w6oQcduth05WaUo3QWkWfklVuc+77MCe/LN3UHxYVe0Z2Bzyzz
 j/KVV7tf7jZpQT1wG9PixLaF/odlhum2jacQiq7eC2RMy+BGyrbUFiglSScBQj2D0Qpv53dE7QO
 DV0tTYi/Xh93kNNvmAySi4twoeOcNALMAdszE9K7R8AdIFPqITO77M3i1rtzd+ms6QIlU1MMDqc
 KvEmJTfRzVNC2K3NEBQK+C5lLO5NJdz7/RegVzM0IclBwGhAgBqET6Ae9DZIf9/q2epGjGhipmd
 86yJ4QVsvcFHPQKFReQ==
X-Proofpoint-GUID: A2qXUwZnVA46d5ni8RaXo3xE7dXYnRqM
X-Proofpoint-ORIG-GUID: A2qXUwZnVA46d5ni8RaXo3xE7dXYnRqM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_01,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160024
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

On Sat, Mar 14, 2026 at 10:10:26PM -0300, Val Packett wrote:
> 
> On 3/14/26 9:51 PM, Val Packett wrote:
> > 
> > On 3/13/26 10:09 PM, Dmitry Baryshkov wrote:
> > > Currently, all HPD interrupt handling must go through the HPD state
> > > machine.
> > > 
> > > This has caused many issues where the DRM framework assumes that DP is
> > > in one state while the state machine is stuck in another state.
> > > 
> > > As discussed here [1], this series:
> > > 
> > > - Removes the state machine
> > > - Moves link training to atomic_enable()
> > > - Changes the detect() behavior to return true if a display is
> > > physically
> > >    plugged in (as opposed to if the DP link is ready).
> > > - Remove event queue and move internal HPD handling to hpd_notify()
> > > 
> > > To correctly detect the displays which are plugged on boot on the boards
> > > which use dp-connector devices, this series depends on [2]. USB-C and
> > > eDP panels are handled natively.
> > > 
> > > [1] https://patchwork.freedesktop.org/patch/656312/?series=142010&rev=2#comment_1201738
> > > [2] https://lore.kernel.org/all/20260314-dp-connector-hpd-v1-0-786044cedc17@oss.qualcomm.com/
> > 
> > Unfortunately this currently seems to mostly break link training with
> > USB-C, on x1e80100-dell-latitude-7455:
> > 
> > [  102.190083] [drm:msm_dp_ctrl_link_train_1_2 [msm]] *ERROR* link
> > training #2 on phy 1 failed. ret=-110
> > [  102.192846] [drm:msm_dp_ctrl_setup_main_link [msm]] *ERROR* link
> > training of LTTPR(s) failed. ret=-110
> > [  102.211095] [drm:msm_dp_bridge_atomic_enable [msm]] *ERROR* Failed
> > link training (rc=-104)
> > [  102.211164] [drm:msm_dp_aux_isr [msm]] *ERROR* Unexpected DP AUX IRQ
> > 0x01000000 when not busy
> > [  102.247168] [drm:msm_dp_ctrl_link_train_1_2 [msm]] *ERROR* link
> > training #2 on phy 1 failed. ret=-110
> > [  102.252859] [drm:msm_dp_ctrl_setup_main_link [msm]] *ERROR* link
> > training of LTTPR(s) failed. ret=-110
> > 
> > [..]
> 
> Actually looks like that might've been due to having applied the [2]
> dp-connector series from above.

Interesting. The series only affects dp-connector. It can't affect
pmic-glink usecase.

> 
> Removed it and rebooted, now plugging and unplugging multiple times between
> the 2 ports works fine.
> 
> Except unplug is still not reliable, the "ghost" monitor often remains after
> unplugging.

Does the patch at [3] fix the issue?

[3] https://lore.kernel.org/linux-arm-msm/177362655076.7429.3868048981197120360.b4-ty@kernel.org/

> 
> Almost nothing is logged to dmesg, literally I've only seen this line once:
> [drm:msm_dp_panel_read_sink_caps [msm]] *ERROR* panel edid read failed

You might want to use drm.debug=0x100 to get DP-related messages.

> 
> But I have unplugged the monitor now and I still see:
> 
> crtc[108]: crtc-1
>         enable=1
>         active=1
>         self_refresh_active=0
>         planes_changed=1
>         mode_changed=0
>         active_changed=0
>         connectors_changed=0
>         color_mgmt_changed=0
>         plane_mask=2
>         connector_mask=2
>         encoder_mask=2
>         mode: "3840x2560": 60 631750 3840 3888 3920 4000 2560 2563 2573 2633
> 0x48 0x9
>         lm[0]=2
>         ctl[0]=1
>         lm[1]=3
>         ctl[1]=1
> connector[38]: DP-2
>         crtc=crtc-1
>         [..]
> 
> and the compositor thinks it's still present, I can move the mouse to where
> the screen was etc.

-- 
With best wishes
Dmitry
