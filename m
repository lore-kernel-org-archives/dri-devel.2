Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BC9F9D0EC
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 18:14:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A0E410E067;
	Tue, 14 Apr 2026 18:14:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CrNGhp2J";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nzzel8hH";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E12CC10E089
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 18:14:04 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63EGBnV81778950
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 18:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ws9Zx/NJA/KZE7MfJoVb1XDq
 yrA9asC27LhY1GKTgrg=; b=CrNGhp2JndyRFJDAy0fcjJQseHDVG+fEp0+lOcvN
 yUbpj0ijwJH1fp0grtuYUUT9N3gHFbgpG5cIALvs9lKpL3thkRwTp4moi+H5iaVu
 eTnJMswJqCD3VenJeD2jcQ3WOLNJn/rGETY+siM6R+ua7kvXNIy98ZWxZxu17crh
 iLeyD3uom6T7uy7RtzYWZYtE/3R1jEWQUhN6k97gVInJxmgA3Su3io3FZhNRBjax
 z3IeGAPwaqQBzjIsU92L6diSfuEMezllXuk7/CDMBO7GRg5EYWMu5GO8BqjbAeZO
 qd1A844ZmSGyIvMewd1kap0py6kyabr/dNQG0BSKGzvAqw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhrw00fmn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 18:14:04 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b52a2d70cso85087271cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 11:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776190443; x=1776795243;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ws9Zx/NJA/KZE7MfJoVb1XDqyrA9asC27LhY1GKTgrg=;
 b=Nzzel8hHiy+XAQVD+OVqqAHWWiHNWg3lDiVNngUeKFx6GDV8LYnA4Ng22tGPYq2Qxa
 9KxYj6EojPlO24PPBiHIvWZbJ/m9TgHW40DJdE33LenRRl5+IxxEZf3k9YHRItAwsiYS
 R++pObHaQOdLNkgsfscZmgQHxe+VFY/AiN888NrjyWaluJo0kIeo6+0vg0bwHoqbSiTY
 ofXSTkifxL3gMNirO1N03DctkSl5iF/77slA9/iBXY/hOqBxYDH2swsiaN0cKFADqiQA
 M56yD2oXJIVmAA8lYArAjPiJ2yKqQbxuN8s//V9sOBX6gOPDGwq6lx5KM9jkwLMBuPny
 VmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776190443; x=1776795243;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ws9Zx/NJA/KZE7MfJoVb1XDqyrA9asC27LhY1GKTgrg=;
 b=CrUJbSsr3t7IV+HaTfmDeetXYah4N3+VZHK5Eiw2NxRGmJsVkblovwiUgzBRCQmkq3
 bRqyqP0S1hoFIF2qmDLmudbVofvHvn/QbkxJxq3oEry8uRF5ArF8O9ku3nhCnhSpawob
 jaSew7Q8i7RYxUWAybzjQFi4ozCe9YbN/oEbvBarRP0IMA9fz2rjrTYtIgdJx2Qlof6o
 LBSIciy+mHR40bqPXCeAtyoqGyg6JlmeB8fmHP+qypwce8+rHq0QZaXFnwR7aGzOPS7q
 IUKfs31kl3qxCKR+aOEZuxt+FjHnhF1HkX/hcyyABPCGc/5+pMD9h+sa3Bugk6RLqz1B
 D6bA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fBCPQ/8u7T/LRsMwX1q1XmlZi6hukGtUuDSQ72UAN0iEVrZrINut2iVWYAMK0OPCzTXLTE5UDK0Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7I8iTXEL9trA7tqgouPGH8af9DLZfp/0Vuk36D5BCfZTqE50N
 Yuuh/iaGrPh/b9MLC8eDVfZFRGzZEjGZz30VsleVJbfaCaFv/vpfCA75gUAzGq3jtC+rhr+miFq
 v2I8EGQ6x7KmzUmkXiepC4HIu4CYKmGGkcsQl021IxGUKbGrw86umZzmvkogjeHXiXYx6hiE=
X-Gm-Gg: AeBDieusTCnng+d9lEzENsbDvqrK3NOtF97MfSvHlYOGskYWbbtGE3DBL0K60D4VZci
 9MHzQGiUxZmBlGKJrmyQSp/MLKq4DIEoMwS4vJuRfXx3v2q30jVRv6rnWGwxpKqHOjUaFSBpH0Z
 8I7Ti0B4HE1Z+oC3iJhdL/atNSNgtG9rOUWNnOCMnILOmVLYmFiuhDx8BtbLohL0sT3Ak23XDlo
 HGDq73EwIzcoav0lh7401q4Xkfdn2SiHuVMt1R5PuhBsQAfHV/1ntQHHYZ80eNLfn59cAA3zauB
 yT6I2Wm0aXUSBdoHkqNi79iEny7GNQfSEnnj7OuWP4A4znWZsmWueCl5kqWlnYmjGoHqmnwlVmT
 utSyrTJVSTkFd0KEA1iq2eUhBAksh+YCcj3tvyfJT70G84bS26fVedTfpWDT7pTIymUKyfjIwRe
 aq/DiGJejndWMaSQVBC1x4lR7JiQAtfHNWDNkqhxe17KC3Zw==
X-Received: by 2002:a05:622a:4686:b0:50d:8bf2:45cd with SMTP id
 d75a77b69052e-50dd5baa925mr183936561cf.34.1776190443064; 
 Tue, 14 Apr 2026 11:14:03 -0700 (PDT)
X-Received: by 2002:a05:622a:4686:b0:50d:8bf2:45cd with SMTP id
 d75a77b69052e-50dd5baa925mr183936021cf.34.1776190442538; 
 Tue, 14 Apr 2026 11:14:02 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eeee1201sm3368568e87.54.2026.04.14.11.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 11:14:01 -0700 (PDT)
Date: Tue, 14 Apr 2026 21:13:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>, linux-arm-msm@vger.kernel.org,
 Xilin Wu <sophon@radxa.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/display: add hw_params callback function to
 drm_connector_hdmi_audio_ops
Message-ID: <gyro53vff5xi6iwsk2vukf7ayfefrv5fpubz6gnkszxa57gfsp@ooqxoryikvxw>
References: <20250925040530.20731-1-liujianfeng1994@gmail.com>
 <DD8RLVPWQQ7O.1B3E1P6VNMWV1@fairphone.com>
 <DHSSUO5USR6B.1767MF8GNTUEL@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHSSUO5USR6B.1767MF8GNTUEL@fairphone.com>
X-Proofpoint-GUID: qj3P1Px4lRh71h70Y56AMbFapPscn3qh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE3MCBTYWx0ZWRfX8yMSQC/Vk3NZ
 tLectMmMOOAXdLhiMZK3+y87oyKIqGqgbIACNNNpecUvdEpPF+WsPiUpikMP/hW6VkH96c2xTmd
 6OgnXnfBD+CPh8KFKznbxm1ctjcci1g6MwrGZxPR2auJSeO9IGy3XcluVse+0MuxdcW+XWzfFv0
 FwBVbYoU0f7lWrjqpW2jXRvCXGokLETW7thFwnFOMyHXFhvljXnNRxdWGXVmh2n++ELx+1io1Nm
 YDDON86/Tt3xXu8xJmFU1FZyk411T3alHXqWqC+doj1KrKfDesW/QvVEznmgikw8LRpxwUSIPDc
 Wkq+MJOnbkPAHw9+f9pX7JaUa6wDFEKlMXbzxjS6poTLW51GgRdcnAwkCc+iqw27AHYu0XjJ7ip
 2Cvim4UWwOft1J6AcywIRWuSi/lzzQFChK7iPVXAy4Xm11c8VV+x+CLDhKGADu3C7GwHdNNSCCf
 pFfFuxQ5VG9WyLrRWXw==
X-Proofpoint-ORIG-GUID: qj3P1Px4lRh71h70Y56AMbFapPscn3qh
X-Authority-Analysis: v=2.4 cv=YMGvDxGx c=1 sm=1 tr=0 ts=69de83ec cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=0qvo2eI3NjoiYXvQkeMA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140170
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

On Tue, Apr 14, 2026 at 12:18:36PM +0200, Luca Weiss wrote:
> Hi all,
> 
> On Fri Oct 3, 2025 at 4:42 PM CEST, Luca Weiss wrote:
> > Hi Jianfeng Liu,
> >
> > On Thu Sep 25, 2025 at 6:05 AM CEST, Jianfeng Liu wrote:
> >> After reusing drm_hdmi_audio_* helpers and drm_bridge_connector
> >> integration in drm/msm/dp, we have dropped msm_dp_audio_hw_params and
> >> use msm_dp_audio_prepare instead. While userspace is still calling
> >> hw_params to do audio initialization, and we get the following errors:
> >>
> >> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >> hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
> >> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >> qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
> >> qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
> >> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to start APM port 104
> >> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
> >> MultiMedia2 Playback: ASoC error (-22): at dpcm_run_update_startup() on MultiMedia2 Playback
> >>
> >> msm_dp_audio_prepare is not called because hdmi-codec driver only checks
> >> and runs hw_params before q6apm_lpass_dai_prepare(). This commit will
> >> add hw_params callback same as drm_connector_hdmi_audio_prepare, so that
> >> hdmi-codec driver can work with userspace alsa.
> >
> > This also fixes DP audio regression on qcm6490-fairphone-fp5 (using
> > Elite audio architecture)
> >
> > [  133.986865] qcom-q6afe aprsvc:service:4:4: AFE enable for port 0x6020 failed -110
> > [  133.986878] q6afe-dai 3700000.remoteproc:glink-edge:apr:service@4:dais: fail to start AFE port 68
> > [  133.986881] q6afe-dai 3700000.remoteproc:glink-edge:apr:service@4:dais: ASoC error (-110): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
> > [  134.045112] qcom-q6afe aprsvc:service:4:4: cmd = 0x100e5 returned error = 0x9
> > [  134.045192] qcom-q6afe aprsvc:service:4:4: DSP returned error[9]
> > [  134.045214] qcom-q6afe aprsvc:service:4:4: AFE enable for port 0x6020 failed -22
> > [  134.045231] q6afe-dai 3700000.remoteproc:glink-edge:apr:service@4:dais: fail to start AFE port 68
> > [  134.045243] q6afe-dai 3700000.remoteproc:glink-edge:apr:service@4:dais: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
> >
> > Tested-by: Luca Weiss <luca.weiss@fairphone.com> # qcm6490-fairphone-fp5
> >
> > And I guess, even though I reported it after this patch was sent:
> >
> > Closes: https://lore.kernel.org/linux-arm-msm/DD8PK8AI24P7.YK0OGVYC0QFM@fairphone.com/
> 
> Is there any progress on resolving this issue? I'm still carrying this
> patch in my tree.
> 
> Shall I send a revert of "drm/msm/dp: reuse generic HDMI codec
> implementation" to at least temporarily get this working again until a
> more proper fix can be made?

My understanding was that it should be fixed by the following patch:

https://lore.kernel.org/all/20260402081118.348071-12-srinivas.kandagatla@oss.qualcomm.com/

> 
> Regards
> Luca

-- 
With best wishes
Dmitry
