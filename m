Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0E6C79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25C2410EAA7;
	Tue,  8 Sep 2026 09:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LmFZn486";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ii71iOaJ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 452C310EAA4
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 09:04:18 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886M0Ds2502557
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 09:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nrvR5saH6GOs4h0ngL0nXxpJm3E6wYqtg0huqXOt+w0=; b=LmFZn486WXICePmu
 8VPDrT8OO4QAVN1CdIP4OlKS0F830Hi8u6KoHxbmo7R45Ms/xP5kA1YuDfngK/H1
 pmZ/yYUrUPZ6C0FIcpooxGAGe7T6HanS5RXEypDS43BrrWVTaKGIjn6jNQZpaAI4
 Rzgx6YEyVUpmpgncuWx58U6O18YF8OwbQ7gN7rustfrvfb2ByJMO4fUYq8TQNCy1
 6HAHyYYSqxxkPcL0rWhB7XTfrlndeHC337ygtS3N2XI3EQtmGvwMQbQbwZGAOANn
 RVifMakjkXtTk4s4UMz7IGkknE3fg70rjaiSu5B3BOUKBV4SoQPJb69LpGT+aOxL
 kc+ghw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjcv7gq0r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 09:04:16 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-934a8cd3a8bso76406085a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 02:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788858256; x=1789463056;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nrvR5saH6GOs4h0ngL0nXxpJm3E6wYqtg0huqXOt+w0=;
 b=Ii71iOaJaqOhOxp7rPBHoeZj3Mpu376SUXuwgYhNz2UGqI2lJKz2EvaFJst7ZMCKKr
 /N2xpfzlwEIFuUd5K90rZpb/zJ3/n0QjhWuYZaextvzYYRa9iW+9rtfOytNrvANVybvv
 ujk70YjtYh2hZrnhDqUiQIs610aVWVtZOJtx5Fq5DHo7h0zh2FwjmRnohGqa8+EyiHQI
 Ve9XwN4UlH341PMdBDvDqZjN0cJp+RcZ16gxv49ThzFcqGsR05FCl+tYvb7aAppJz0h3
 lAkeiVCzmLcBPcB+lSTRW+yVjgpTAmoa1vX9hZiyGpmqfVR8Zlf05gNbRKEKITXHN6zu
 Cydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788858256; x=1789463056;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nrvR5saH6GOs4h0ngL0nXxpJm3E6wYqtg0huqXOt+w0=;
 b=Z7TGKC2fTSbd8FEm3OLKrDhtQF71wdLSbyTnQynNz8WPL6gDb0hyB0KDKmqeuJ/xav
 a3sHyZcC4T5O/c6NdAUBIPm5OUAV5rPhB2izaoWIEeHFp4Eg7Py5M7d8jXewqfdCEqt6
 9m6x8lY4QbNUiDG0tJRuj06yR1xc2vEgCEk52yjx148/DRb1TByF+Rq1BY9sqEB1XfLR
 MThKyxszNcYvVd3nF56+FzLYcsXvFquElAoVpwDKDd9Exo1hi40U/SZnqEJkNdWT1BR/
 rkLo660yk6PC3LuP3zUCurnzI/5eZ0jbdSihomMlbCFtxNFvCZn4+i8f13ZbfGKhmtak
 FhDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByoUQS7ni1rV+O/pfG0NZxGEA3M3mBbaLxazf+DzZABJg2qtHadWe+AX9WZuMKeHt/3PecOnZX5178=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mEtY/0JGej4uj0MMxGSklHh+q7MJ0+nhuINp8ak3M6WOrhAqwI
 6d5bxU3eWw1PaijoE5BT5znPHmXunBy/ZApApH5d5+95Y5AAwJjS+eiLtBXSd+R8ncU23o1Rv0n
 dx8BsPEH94/heb6AdeNe/WwSJgc7XzAJeHEMfnGHp8XEgHdcpIA5JraY41PFX7XTFiUSa9Os=
X-Gm-Gg: AYBFou3XkPSQBVD/PA4kutGByy/gkjsyQV7LxBObO+Mrzds58XLsip9PJlzrqQvUmbC
 23OPka5i0EDfPA+G+nY51C5sZ9qizxKJ+o269bcqN2lNu/FeaNJpG/FuhsyioFwKmSOnjG/p6vS
 FSas6Yn/BCZAYgSPXqfviQlsKkbmFmpjf0n5FPMo48TbJfv0u3am53odhzcy5TcfjGVU1XXL0V0
 aPtCrxKfK72V9OUgA7D8AjlhEpLnENuBJm607UruLOCwF0oMtp1br//PT6K39tGafUeuNocFoLL
 t0S/VZ0v8C/BZ3M7SbAlGeijXFsfik6J9l+qjQkZtl8iAOKuI8eNNvXrnXrn1Ox486ZD0Wizcbz
 SzZzijuTEhnyf2ColHonj+Q==
X-Received: by 2002:a05:620a:4409:b0:939:8bc:8826 with SMTP id
 af79cd13be357-93991702d25mr1758635685a.2.1788858256350; 
 Tue, 08 Sep 2026 02:04:16 -0700 (PDT)
X-Received: by 2002:a05:620a:4409:b0:939:8bc:8826 with SMTP id
 af79cd13be357-93991702d25mr1758631585a.2.1788858255922; 
 Tue, 08 Sep 2026 02:04:15 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c26263cb042sm447308466b.47.2026.09.08.02.04.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 02:04:15 -0700 (PDT)
Message-ID: <c8275581-7c02-4064-9824-aa77a5091d0b@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 11:04:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dp: don't gate eDP on DP_SINK_COUNT
To: 092vk <vk092kumar@gmail.com>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20260908090146.3100787-1-vk092kumar@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260908090146.3100787-1-vk092kumar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CMEamxrD c=1 sm=1 tr=0 ts=6a9fcf91 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=tHtyKFz_FhAUe0nsBNoA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA5NCBTYWx0ZWRfX5mlALXBSBfr6
 ZaksebVu1dD7LXozl8seetYLxxrIc1f9kgUxUPFkiK2Lsa0gkg8RpZxTbRqDsW/oZxkkCuzuzOh
 37BWcqUW+phbQCkwuohGfB/7mYnpEZs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA5NCBTYWx0ZWRfX32jJsRcjhwEf
 aYtY2iuZ/goGcUoDKpF4NbNXsoP7SXH1flhz81issxPaOUPWs1N5sdJTGqSDKpy/ccVbEYgwE9j
 zUWRg7PMjE/cPAAY5X3Lyc8mNAiBl1zKkYUkPMJtqsSPTeINC2dqqtgyQoF5mdznjEpWxDqNIOb
 QUqCSnaQaDIN8GyRVhQhtHVaq48He21hrl346o63Jc1LVclyM8TdSkHCb75WwJVnRZQqE67b8mr
 lMHk6YCK15udH5Na8RaVjCd4XEipLMYFuy6td3OAUyDh/WZ3WPgnG19jyjLLY236B4bSYl9JSEP
 jZLm3Ax6ociJoUgdo6li83yr6FMYF1CHFQSfzA4HdesNG08Xlj8Jr3rQfrP0PK8D8Eh5sedN7z6
 68D8QY3ECge/Q3wWn+zPAocFiGw14fcwJZv3H5iSbY3QRd0PmiWgNsvuYWoxfsWqpdRhgZDVFKd
 7S4OScgJkQKrMkLTPlw==
X-Proofpoint-ORIG-GUID: spNNb7lN4kzy_3TVYACsHVQq3KiAtz14
X-Proofpoint-GUID: spNNb7lN4kzy_3TVYACsHVQq3KiAtz14
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080094
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

On 9/8/26 11:01 AM, 092vk wrote:
> msm_dp_display_prepare_link(), msm_dp_display_disable(), and
> msm_dp_hpd_unplug_handle() all treat dp->link->sink_count == 0 as
> "nothing is connected", and in msm_dp_display_prepare_link() this
> causes probe/enable to fail outright with -ENOTCONN.
> 
> This is correct for external DisplayPort, where a compliant sink is
> required to report a valid DP_SINK_COUNT over the AUX channel. It is
> not correct for eDP: some eDP sinks -- particularly fixed-format
> eDP-to-HDMI bridge chips with no downstream AUX-capable panel
> behind them -- never populate DP_SINK_COUNT with a nonzero value,
> even while otherwise participating normally in DPCD capability
> exchange and link training.
> 
> drm_dp_read_sink_count_cap() already accounts for this by excluding
> eDP connectors from the sink-count requirement for other DPCD-derived
> checks (msm_dp_bridge_detect() takes care). Apply the same exemption
> to the raw sink_count reads in this file via a small shared
> helper, so eDP outputs with a non-AUX-capable downstream sink are
> not treated as permanently disconnected.
> 
> Tested on a Qualcomm QCS6490-based board driving a fixed-format
> eDP-to-HDMI bridge IC (chrontel,ch7218a) with no negotiable
> DPCD-capable panel behind it; without this fix,
> msm_dp_display_prepare_link() unconditionally returns -ENOTCONN
> and the display never comes up.
> 
> Fixes: ca16db3d18cf ("drm/msm/dp: break up dp_display_enable into two parts")
> 
> Signed-off-by: 092vk <vk092kumar@gmail.com>
> ---

Hi, please use a known identity

https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

Konrad
