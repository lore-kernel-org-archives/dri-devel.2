Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBCBCA5FC5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 01:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28EAE10E263;
	Thu,  1 Oct 2026 01:50:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QzQsRAcf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XGMZRa9Z";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90BFB10E263
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 01:50:24 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6910k1Wa1384163
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 01:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=4EFomxxn+q0H1KdWbKrzZ6/a
 kRtlgLbLTJvHUklGuRg=; b=QzQsRAcfOz4JAfUdl3Hty9YDCHnT3a+CVkqBw7zd
 k8kmP0iqoUumg/iEx4OaoR6IrE3Pp9MYDiR8lwOYwltghxMTEQWKJupjqdj9H7f7
 NHqdUoeMwbhadVKUIAniKeKj+6A9r+SvBXXffNC/+7mkR5/n7b5PTNIP8oLILy4c
 xXWbOwIXc4yo6z8oqwFU174zPh6WGPN+zWjeQe77GeNyQAc8XVqwgkKS2Lz6SpE+
 qE8dygEkJsEwFOYEYMU2aB1RfnIHbt8MjzdoOIA0PD6xNsblxHoMnKtW2zhecc1x
 VEwAcZERLd7Gc/h4F7S1jBdmx8vMY9frVfMlAzZ3aijsmw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h155vt9qe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 01:50:23 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a1e564fd5so1090752985a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790819423; x=1791424223;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4EFomxxn+q0H1KdWbKrzZ6/akRtlgLbLTJvHUklGuRg=;
 b=XGMZRa9ZLG+wBTjiBnevFO0U6OuGU/jHMTElr+t5NaLreS3gVCEvZA69ChYKGXWvIc
 mL70othfq3Nf2Ee96BB04FGkKVC5X1He0IocA+WR4mU4xNOFJu2hOBrQRVm4D+E6coHR
 RzvEqrWOoum0++oLZB+v5nJ4BZ69/cU5Vb+Vh5o3006vcv1af6Oe2kor491XpCaDv0hL
 8UIngtGmfGL6Z7niIFeBHuvbU5ZereLLiDUUpbJaPvxDmSfY7zmD0GOGziFIr/7/Ufur
 lErWdlMnKuvtjY2wJuFycnWvH+DnhCbFzjDihMW11phMZX4EecxWEO4wA5ER3dNJFZzL
 DZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790819423; x=1791424223;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4EFomxxn+q0H1KdWbKrzZ6/akRtlgLbLTJvHUklGuRg=;
 b=Nx89hPLLFqJkTiYpTfY5g5Lyqicw0ij8nf+6vDSJHSOMbQivbivtwY+zPriP9d4JL+
 xT4y3QjucWR2o6RuC7GrUgrX7mVl0oTfXqY29nosNsiu7vi1S1U/aEJh3koMTGyTrHeh
 yvhxYL2W0qyubpELwDhEa3McCdq452i5pjIjZUQYQRqHzA7BcXjvf83P9YtCYe1eSmKE
 wq2jo9n5BFW0AaHCYFXlc3F3uSONKNDMuzwwYIFHNNShWK2okfJUSuz5wPOTS37J1jBj
 OcC+Dz6zowsm0C1zrYAHS4vaPtXL1Qa3GHyJ28GoHHRycvM/rnI7RCbQTqLCjCa//Lej
 N83w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxdxLJqf9SSHABLCaC6tbV8htlMUUGaXGudtI9BNAIx/Yvi/i+BzSP0b2Ch+zNeqy/1vpK40R45yFA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++muRhGI0fCJO5wYw+Zhe7niOMqMtJpEq6xJrb/n/GDuO8GUID81
 vCWFSR3qmdwnIQigZnX0Muq+JmQwLD4ST+ZRmrOdYtP2UcZ09L4tVIqKeTFoxAmRSMc3CG9w/pk
 TbuWTGjY66IuAJ0ulnqoG4lIxsgsxLoO0fZ8+YjQDY2FevgO3cU3gMa+QJwaA7EhqN4HFV2Y=
X-Gm-Gg: AYBFou1Xbpa/Hccasft3pa6IoGQfzcKCs16tLyNo+51UH3dqfSpM5Mq3LLdWcfL/q2u
 HHU9g8mtGZlJWNIaZBPoL+AJQ5gP0TLHAiyIbWFbx6ytW50rSdq6+XN+UDlOwK0qxv+bH+/88im
 5K0oXpORuV48DCkigEHAYz4xvdDthOLk+TuVlAAu4cu/Iv9TkHdPx4UTH4EsmhBWcihxHWeD+2A
 BjU8Iw2SkR0dUl+jqNUuwbwFZG0PxvPeYBiycxo83KtuUKIHovGg31Z8pByQ5+H/Q621erFKGIQ
 VyDWdbsMw5VgIZI851y1FnxgRRuH+y55AVRzzge/5hxlAQLx+uXa1FE7UwR4QUwWygzjnbyxZof
 QqwWbuWjlqWEhWkgtxaIPVlEhvcf+9sApYuxvhPtOQk0WdhXYRt3t5NFUr5xdKHEXkxNnl8TeqF
 5+8/f/mXeGyoJW
X-Received: by 2002:a05:620a:4625:b0:93c:6341:1d64 with SMTP id
 af79cd13be357-93ca9863312mr639813885a.57.1790819422591; 
 Wed, 30 Sep 2026 18:50:22 -0700 (PDT)
X-Received: by 2002:a05:620a:4625:b0:93c:6341:1d64 with SMTP id
 af79cd13be357-93ca9863312mr639811585a.57.1790819421958; 
 Wed, 30 Sep 2026 18:50:21 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba42fbf031sm349870e87.66.2026.09.30.18.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 18:50:20 -0700 (PDT)
Date: Thu, 1 Oct 2026 04:50:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vivek Kumar <vk092kumar@gmail.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/msm/dp: allow eDP sinks without DP_SINK_COUNT
Message-ID: <2hmqmjd6q322d6wobtbiyrem2zihayz6qcw42frjbbsbi5clp3@3gwkjqrv52yo>
References: <20260917124706.421107-1-vk092kumar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917124706.421107-1-vk092kumar@gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAwNyBTYWx0ZWRfX6n8YP0/wsaFW
 WHHvvzE5Z8X+n1/+wL6aqhDvKk6ciaU2EheFTPb3gjuEfkshf7i5GogLNLx9AIsW4A+ta/z+Inx
 Wd1WFLob8eTHUJNcIyiOgKh9HuafTdA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAwNyBTYWx0ZWRfX+CpjQwlPgoeA
 ZQs3l8cMKCAFPAuUD51B0nD8LL2V6FkZs7N+igBakB2RcoR034Qd7JTkrNaaEog1FXTd6DVldGn
 NpetHZcoT+hJU4mCCCwbOZh/Q5GGk+vNYhukOsVRIaqlDCt1CeF46YoybgzN85lO0tAL00kcwQJ
 1GnczguKTZZJahxweBSeBeoTleNDH3tokE/JFxX+hT34EGkVJIhyfRKnzbu5r89me8gFVX7wN8l
 gpBtBltS5Q9a5a8LR1Ha88VkT+utSSS0YizGIp420EsvaXdDEPndtmF/DlsuXx7wR1+Y6qGz3zI
 0ZYx4V5EnTjDfjxg9yprJu74Z5Ga9SFw2j40s+P0zPJAou3mxBnG7GRlkHVG/WGnVQ4RfJdiuZ/
 hTPgC7PImCAQZghMZ76C9Il62bkA/+AuVyxfIZGQjM/YAxn49wgFn6KZ8FG1F/Q/vObYpRWOrFb
 Mx5/snQ+gucwE2zZYSw==
X-Proofpoint-ORIG-GUID: HrtA914nVFDah-UOABwpHfVF5jctk0YC
X-Proofpoint-GUID: HrtA914nVFDah-UOABwpHfVF5jctk0YC
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6abdbc5f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8
 a=VKs8yQVpha0xVrop0z4A:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010007
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

On Thu, Sep 17, 2026 at 06:17:06PM +0530, Vivek Kumar wrote:
> Some eDP sinks, especially fixed-format eDP-to-HDMI bridge chips with
> no downstream AUX-capable panel behind them, do not report a non-zero
> DP_SINK_COUNT even though they participate normally in DPCD capability
> exchange and link training.
> 
> Treating sink_count == 0 as a permanent disconnect is valid for external
> DisplayPort, but it breaks eDP probe/enable paths in
> msm_dp_display_prepare_link().
> 
> Use the same eDP exemption as drm_dp_read_sink_count_cap() for the raw
> sink_count checks in this driver, via a small shared helper, so valid eDP
> outputs are not rejected as disconnected just because the downstream sink
> does not expose a usable DP_SINK_COUNT.

This will still break if the DP has no sink count cap. Could you switch
your workaround to using the function which you just mentioned?

> 
> Tested on a Qualcomm QCS6490-based board driving a fixed-format
> eDP-to-HDMI bridge IC (chrontel,ch7218a).
> 
> Signed-off-by: Vivek Kumar <vk092kumar@gmail.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_aux.c  |  8 ++++++++
>  drivers/gpu/drm/msm/dp/dp_aux.h  |  1 +
>  drivers/gpu/drm/msm/dp/dp_link.c | 10 ++++++++++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.h b/drivers/gpu/drm/msm/dp/dp_aux.h
> index 4be02e8b4d0b..9ab401c8526f 100644
> --- a/drivers/gpu/drm/msm/dp/dp_aux.h
> +++ b/drivers/gpu/drm/msm/dp/dp_aux.h
> @@ -22,6 +22,7 @@ void msm_dp_aux_hpd_intr_enable(struct drm_dp_aux *msm_dp_aux);
>  void msm_dp_aux_hpd_intr_disable(struct drm_dp_aux *msm_dp_aux);
>  u32 msm_dp_aux_get_hpd_intr_status(struct drm_dp_aux *msm_dp_aux);
>  u32 msm_dp_aux_is_link_connected(struct drm_dp_aux *msm_dp_aux);
> +bool msm_dp_aux_is_edp(struct drm_dp_aux *msm_dp_aux);
>  
>  struct phy;
>  struct drm_dp_aux *msm_dp_aux_get(struct device *dev,
> diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
> index 34a91e194a12..bf08b5b18097 100644
> --- a/drivers/gpu/drm/msm/dp/dp_link.c
> +++ b/drivers/gpu/drm/msm/dp/dp_link.c
> @@ -725,6 +725,16 @@ static int msm_dp_link_parse_sink_status_field(struct msm_dp_link_private *link)
>  		DRM_ERROR("DP parse sink count failed\n");
>  		return ret;
>  	}
> +
> +	/*
> +	 * Some eDP sinks do not report a valid sink count, even though they
> +	 * otherwise participate in link training and DPCD capability exchange.
> +	 * Treat a zero raw count as a valid non-zero placeholder so we do not
> +	 * misclassify the link as disconnected on eDP.
> +	 */

I'm sorry, but this looks like you are using an AI agent. If so, please
see Documentation/process/coding-assistants.rst.

The comment duplicates commit message and is generally useless. Please
drop it.

> +	if (msm_dp_aux_is_edp(link->aux) && ret == 0)
> +		ret = 1;
> +
>  	link->msm_dp_link.sink_count = ret;
>  
>  	ret = drm_dp_dpcd_read_link_status(link->aux,
> -- 
> 2.55.0
> 

-- 
With best wishes
Dmitry
