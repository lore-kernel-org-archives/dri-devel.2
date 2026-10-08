Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79334CA6014
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 07:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF40310FCEF;
	Thu,  8 Oct 2026 07:43:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="c5XwdBy4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GaBVEJM4";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92A8B10FCED
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 07:43:04 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6987K5uM1341820
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 07:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=7nat/sc0rXD+7bccDq5WD70o
 EM3/iocHY40TJUcgDKU=; b=c5XwdBy4lYQ3eFwyizDxbLoGU05OLIsMPFQGV6Hu
 plLAFOI14FSXIH9B+ptb/H6Zr/5NM3/VMnPI9jdyYUZvZUUqfFShLohSeFtosREK
 73oNltZ2i9jIY9d8VyrocqSNnCJ91PFL5bqGipy02icgVyLsGvaYhlHvIEiO6wkv
 +I5P5hbrtbxbyXk8eqxgj76MiOPOw1+VAM7HGkLjTOsQzYWxsW2jCS98GPlspRu/
 WfBqPqhx+JaItfuVQk0TtSkLVOtiek1O9AnMKQNGrSM+vBd8M0LG2ySc3K28c4K/
 nX8n7eo6aQ/7tcVXU3drLeLrMDvf5GviFUXMBh7gubYuBA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe2sruq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 07:43:03 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-934963b2bc0so927301485a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 00:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791445382; x=1792050182;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7nat/sc0rXD+7bccDq5WD70oEM3/iocHY40TJUcgDKU=;
 b=GaBVEJM4KLOCSQlNvpGuiMZTIvyh/4IDG1xIVbrAcjB17ew4OMrLc1qGe6ZtpwYbRy
 kxaMZgVHmIO8zLS/F8P86+KN5MSZ6H9ZheVOPf3ma+jESmL8o/qkCkT9H+3xATF1jF23
 wLyAPppSZW8aXG1+Elrks2SeuoaZ8OANpMlkGZyo/8rOaQcHqSB1yWsG+GCiHZrln8Gb
 ORgweuqD2oSll7dEzKd4pIdctEcdYEpT3QWKh8SAH2PZl2FZvHf05jRPxC2kfqKf/bwL
 M6K0r7X7ygpQ5LlxrSzZu4dA8grnvnrcJGLQcq7IOanlyLJfBC6Ka7YCNbkMgrYd3uQH
 ineQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791445382; x=1792050182;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7nat/sc0rXD+7bccDq5WD70oEM3/iocHY40TJUcgDKU=;
 b=btOeREM1yvPwMhRWFYQHZcaFQzjs5rYhYi0KuZQ2qlmYI4bl+h1W3UxgKGyNuCsaFa
 mZbYyPnZ7QdhJ/WLkyzrutG3mWN1eO3GWZQDyL+LaTWuzmEdjRtVPOnAYhQgzHsI8IjH
 Vo9hns8PLoOfeuFk/8kEhs55aTvEYkFga5j29palLE8jxA+SL3W/elVQSYJ0tKdcWEHP
 54H+eQ1DgW0t+MowIE82gIRZ0DkpsznEbtkCxa9DUkxb2Z2VhX1yVZGsqqEiYxH59gx9
 KbUFpJKZ7aTTN0Jb5ciDUxoNNQpA+2GK32oTVxoM8SWMke4LsTegRHWfqSK2zz5zsdfR
 gNcg==
X-Gm-Message-State: AFuF++kJSBSeCgduA/soSrJuAikQjFub76lZDW0Bp1bEvvv6F+xkZBZ0
 4RCEmQTGVN5T+bOcWbgsBRvweqvek54Wr+Tww204WQE6nAsYsEF0fK8WsBu7A1y4vG0+ZQLH7xV
 1nSIve9Y/1gl7/+Q2xS3pLIEOhQofpbXhAzZWCILptrfFzvH7gOGryFrP6EDKqugGjWBy05s=
X-Gm-Gg: AYBFou3Ew/iljT6oxCmOw4y4aDyLaSkSypYPDAkxTqsEczvUwMrhWtyJ4juFmOT1RCO
 VXGug7P/V89LvWSIfL1f4arHEi4w+Juc64ZktJA7yLxFMjAOuWokNcWzEl+wK07/bt5q450QvtW
 U+VJs9rN0iTZPA+TdN3pFg9YYAyw/UooxcRHp+JUntZRola2FzufVEXESGeNXEgi83LMChWe7Mr
 GQVBCdmub9EAPcqKZb/b5gpdXQvuxNlbl5s21AGPcUFYliYoOndM8EeoM25tkFMVoPtv0u/TVqo
 n80LleUCOwVMFNs8+IiuWzQHcka7fzG/ulS16jlyzMPstrcRwD3T9APQtEByJOAbzbcUyRa1Ndu
 KOgokLZ6aCZGnUa/MiPw5BAQhnHSGFHNFOdABd2/xt5EYX4baMgVl2YteyxMbgGxqbRmCuEVcx9
 cFG0k7FfaU9YBm
X-Received: by 2002:a05:620a:1729:b0:930:f337:ebeb with SMTP id
 af79cd13be357-93e9b2e9672mr871189985a.12.1791445381831; 
 Thu, 08 Oct 2026 00:43:01 -0700 (PDT)
X-Received: by 2002:a05:620a:1729:b0:930:f337:ebeb with SMTP id
 af79cd13be357-93e9b2e9672mr871186585a.12.1791445381348; 
 Thu, 08 Oct 2026 00:43:01 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcd3091191sm927262e87.48.2026.10.08.00.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 00:42:59 -0700 (PDT)
Date: Thu, 8 Oct 2026 10:42:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jean-Francois Bobier <jean-francois.bobier@laposte.net>
Cc: dri-devel@lists.freedesktop.org, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Saim Shujah <saimzst@gmail.com>, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v2] drm/display: let a bridge configure sink audio from
 hw_params
Message-ID: <3wcmymkzr5xcaa2s6gjupyixczgd5h2newuq2bkt7zvfq465rs@trytq2uvx4jp>
References: <20261005131545.23219-1-jean-francois.bobier@laposte.net>
 <20261005161824.36445-1-jean-francois.bobier@laposte.net>
 <42emyzl5p3kpvq7e3b7npaaghl62r4skrpdflszk7v3jagexal@6jdg6h27eofw>
 <41e65625-fb55-4440-825c-a47ed24800b0@laposte.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41e65625-fb55-4440-825c-a47ed24800b0@laposte.net>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzMCBTYWx0ZWRfX9bZN67xRvdW8
 Dh9TUJNZcUmUXrUQaN8Qlxoudi+WZmWVY+A297ST+aAyRceGJMIbR8zJg4kNX8wHuPkmwsaOHKC
 PQyBB/BMPMf4O1+mfMCsU6f72YChPiU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzMCBTYWx0ZWRfXxFA/KuOcIV6f
 x152+qx03SSrY8vn2NvaZwf5BEP6KEt/oiRGmRMAPuI7cpK8AqwwL0k7pwd4NUw+0Q0s5K2POtO
 PRs/vi6MofdxtVULczYgic7PP8sy1N/thQZaWtUliorOnOBagqxTPZoNMtu69L3+wYPR/F7O6bJ
 IfoAtrXqRLk3yoY83kf4khj9uhv9clO8ymMePQq/lOMXvI4h7qs0blkpg8ZB7fdW2nl+5bhuXqM
 Dbpr5KdrDUw33ScdaYyGyQLe2rY2VA6RM3/dhR4kuZaIfZ4x3adVo2hcHHpJOhVWHebY96QRPG/
 9a4cWBBJrlrRcY1CMBBdPNjuJxMY6lB+JC7jCjs/OqvQezpBCYEnBF+QnPy5LVBYPihusxOmP7l
 +E1Vy7LQttWfxkc8FjP9AINUbGmekPZkgTn5W+Ho2TEqelCIo4eYfaH9ESRTzy05ooLSAmc4N8y
 NhG4sdFYnZQP4yu1HJA==
X-Proofpoint-ORIG-GUID: Z0YNdaF32Dk0fVSARtD4fWWMuPS08BOO
X-Proofpoint-GUID: Z0YNdaF32Dk0fVSARtD4fWWMuPS08BOO
X-Authority-Analysis: v=2.4 cv=CIm/zhrD c=1 sm=1 tr=0 ts=6ac74987 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=tFzc-x1BRXlNayxtleEA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080030
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

On Wed, Oct 07, 2026 at 10:46:06AM +0200, Jean-Francois Bobier wrote:
> On Mon, Oct 05, 2026 at 06:18:24PM +0200, Jean-Francois Bobier wrote:
> [...]
> 
> > Similar changes were proposed several times already. The IEC958 status
> > bits are usually set by the userspace after the .hw_params callback has
> > been called. With your approach the hardware will never receive correct
> > status bits.
> 
> That's a real concern in general, but I don't think it applies to the
> case this patch is actually fixing. hdmi_codec_iec958_default_put()
> is optional -- hcp->iec_status already has a sane default from
> snd_pcm_create_iec958_consumer_default() at init, and both
> hdmi_codec_hw_params() and hdmi_codec_prepare() fill it from that same
> baseline. Userspace only needs to override it for passthrough of
> compressed formats, where IEC958_AES0_NONAUDIO has to be set correctly
> before the stream opens.
> 
> For ordinary PCM playback -- which is the only thing DP/HDMI audio on
> this board does -- nothing in the userspace stack ever touches that
> control. I checked our actual UCM profile rather than assume: the HDMI
> device there is a plain mixer enable and PlaybackChannels 2, nothing
> IEC958-related. So the ordering you're describing matters for
> passthrough users, but doesn't affect the case I have hardware for.

That's the difference between the framework and a single driver. At a
framework level we'd like to ensure that it doesn't let wrong values to
be programmed and transmitted to the receiver. Moreover, I don't think
there is anything preventing AC3 passthrough from working on Qualcomm
hardware (and then it becomes an issue).

> 
> > If my understanding is correct, a more apropriate fix is to make the
> > a6afe driver to emit AFE enables at the .trigger point instead (maybe
> > together with other commands) or to split the DP audio init, moving the
> > necessary bits from the dp_audio_prepare to the dp_audio_startup
> > callback.
> 
> I looked at q6afe-dai.c before replying. It doesn't implement .trigger
> at all today, for any of its port types -- HDMI/DP, SLIMBUS, MI2S, TDM,
> WSA codec DMA, USB all go through the same q6afe_dai_prepare(). Adding
> .trigger there to fix DP timing would change behavior for every one of
> those, on hardware I have no way to test.

Srinivas, would you have any suggestions or recommendation?

> 
> The startup/prepare split is narrower, but I don't think it's free
> either: .startup/.shutdown are tied to device open/close, not to each
> hw_params/prepare cycle, so I'm not sure it actually survives a
> suspend/resume any better than what this patch does -- it may just
> relocate the same question rather than close it. Possibly worth
> someone who knows this driver better confirming either way.
> 
> Given that, I'd rather not drop this while something that actually
> works waits on a rewrite of a shared CPU DAI driver that doesn't exist
> yet. Happy to be told I'm wrong about either of the above if I'm
> missing something.
> 

[...]

> 
> Please let me know what you think - the patch does work on my board and
> brought up DP audio 100% working, but I would understand if it's not worth
> upstreaming given architectural impacts. (The bot seems to have found other
> gotchas on my v2 patch already so I will hold off until it's confirmed it's
> worth upstreaming at all).

I think the issue is worth tracking and fixing, but at a different
place. I've pinged my colleague, let's see if he will have any detailed
suggestions.

-- 
With best wishes
Dmitry
