Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB07ACA5FFE
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 05:56:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2298110E1C7;
	Tue,  6 Oct 2026 05:56:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y61x/0ZR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gyrlammo";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EEF010E069
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 05:56:52 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6963AAC0628328
 for <dri-devel@lists.freedesktop.org>; Tue, 6 Oct 2026 05:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=F7B4QuK2fsk9nNke4mivA/qr
 +54QLFDs3FrqTwcKT1Y=; b=Y61x/0ZRXG/nXIIAcpxskMTNmmCWOFxX9YTMHF4X
 CgAFOl88pHZacSEDWP7jzICjRcTNjo/YouoTdBOxgY5OD5x+N3gxzWnvOG9g17mc
 72WN66mVVKjoFUfznL3iGeTZBGhyoVk9JRIl6B+1DS8tR9uoj/VNtZvbGxw2whzV
 WHjvExSXWZC9oLAvB5EJF/dOyQ6E2F2kykJbhsRYnj1rpRAT5RgP5ma2fWUUXbiC
 BTYjIT5luVRlyJsVI0Sk3MG/5tyuAxLNIYkKYrLRD1yZjuSA6QsJUx10Wisggx1j
 PU1C8Jt8Gd4DJN8emt8iZe1EcI1lUxkeC0/LTk569T7SdA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4cuu3a2x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 05:56:51 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ce7a85f04so452697885a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 22:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791266210; x=1791871010;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F7B4QuK2fsk9nNke4mivA/qr+54QLFDs3FrqTwcKT1Y=;
 b=Gyrlammo9PUk7DteYiv24uSBiYGxZ3C7o19gOt7/752f/S3EINPjVwYUa0Dl4aM/3m
 SJkJ2Ttd2mvPjA3d7P0hY/KLiVlNAAz/i+0LWvlGCSmM27ja+8D0sa2SlhJGV/5Eqd8a
 5mlRVavjn7RjGjtuHCiT7fnja8g4cqWlfclMZgUBIzOGfS2zn37/0Xa4KOA8k45hNC6H
 yBacri+wMYjBsZSVjyj6MyGACioRuducqPJbROHp52Ur1No2wEOIQLDoaDs0FjGvNk5X
 /WR939Xwm/KoysfWkH9VHEkUM6gRCiG9RkTvEW6OdQIYZtirfSKmoVW01/ZUdAqgAc4A
 X0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791266210; x=1791871010;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F7B4QuK2fsk9nNke4mivA/qr+54QLFDs3FrqTwcKT1Y=;
 b=l3Si//is1+LpCbjbnw8FjYNbcWXd4clsJU+7Wnkc1xnH4l+ynxXiVATzKI506/Hsfa
 uUqYBtOO7qoB8V84cLmlI+2z2JNcddKsnNtTldi+erf2eiUpnL+ZOiXo3x25IIk5vm5j
 QMTt2CPmFrrPjQ5OCrOvuaiJnVgwJZ9vHyKlY+dE3OuRp5cVAFy8cpcPSkcx8na+cy2u
 iKX5DQhAR+TSrDVFmQIpD0CQgUQqPG3CuOOHn+1hIXcHLPqgOdRNBB12kZIVZPzhMzyr
 w+R5MrTriInr6Tgc9U2j/7AWpqxOvXYP1ncSlSc/HRiv2Q4j8cMwN1EY92WeyR12nn4U
 TITg==
X-Gm-Message-State: AFuF++mFiHR1I9oIx2Jbd/2Ji2OfxlL7arYvrxIyltnOqRJqS22jIi2h
 NSZ+f8hRsaMtG7OiFT4+/bKTkvibt3hmhB3SZvNOw6m5NhuMEKnqgNpDqmciE6z6ZWDuG94rwvh
 IIPMvhPGx+QFDi6SZJ0Aq//fwTWscC7v/omrjdQ8QNPXDJ9tOr4MPzJ2QEkQuWr0TmZPDjdFg9G
 qATfCx9A==
X-Gm-Gg: AYBFou1Yw98NNIWaznYsAxan9SiQ015kRc5KLyDas2YBMvspY/UjFDkh2w/XlfvaeV9
 rB2SKYKYJRg3SEadrNISnRz4vlWBccqb2LI4Z7acGvFb4LzH+jqo3HHuEOYwkgj7wvEAHupl/lE
 evgHLF/SW/G0yg+lRWJ6FboH8j4B6Btu5S1uxi3Vnbis+vdU6psbJBQ67GtUPzyWa+7HIwgXfJo
 07brNEh7FwThJIZ7FBuySiKpg8Q9kcY5h1EkqYcl1apyzEtR0n76xoHulknkV3afjvGKzuy0Bgn
 IS87gosTHkPAeL0EYI9F1eBqeSRFA9jHZIbSa7JWkGYm7to9Dhkmd1nsHFVcsJdeoHqNhCfoH8j
 +Kkd1f8IlAqqSj/Hwwj4YxPuj5MngpeqLh2NOxDUnifRkf3Cz/uvTHrtGYLAwG7PJm6SFR0WGQt
 +i5c0buEzOFiEo
X-Received: by 2002:a05:620a:c42:b0:93e:4833:82e7 with SMTP id
 af79cd13be357-93e8f4e77ddmr71045685a.46.1791266210033; 
 Mon, 05 Oct 2026 22:56:50 -0700 (PDT)
X-Received: by 2002:a05:620a:c42:b0:93e:4833:82e7 with SMTP id
 af79cd13be357-93e8f4e77ddmr71041485a.46.1791266209460; 
 Mon, 05 Oct 2026 22:56:49 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcbc7a1428sm1877753e87.32.2026.10.05.22.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 22:56:46 -0700 (PDT)
Date: Tue, 6 Oct 2026 08:56:41 +0300
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
Message-ID: <42emyzl5p3kpvq7e3b7npaaghl62r4skrpdflszk7v3jagexal@6jdg6h27eofw>
References: <20261005131545.23219-1-jean-francois.bobier@laposte.net>
 <20261005161824.36445-1-jean-francois.bobier@laposte.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005161824.36445-1-jean-francois.bobier@laposte.net>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAyMyBTYWx0ZWRfXxWo19XtHHt7/
 xpB6kHWKvhmbMJdXm2UwaJsqMF3U9SKZH+Ggmqx38PRZ30C6orQmKbLku8UKQ86UgHMd/Jsouea
 WNiRVrorpYZoYh9i9hZRItm9RDLVfQ0=
X-Authority-Analysis: v=2.4 cv=aKRlOr9m c=1 sm=1 tr=0 ts=6ac48da3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=AVbMHacnAAAA:8
 a=rEcrq_ABPuTkkkh6-BUA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=Z8w8RPyABVWp4NBWd0ke:22
X-Proofpoint-ORIG-GUID: 1MkJezBg6sUUD3y4MUrXUkvMSt0EsELy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAyMyBTYWx0ZWRfX44Gtmc9E2egR
 i1R8nPG9e4zt8vAWDtdWWSGzNBUzNoYC3o/Z9v2IJRKUeUqr9b1hTg2zwSxbO4ixhAz8cGn98un
 P2eJDkfs6jbuUhhyjXrd9IYKlDlCrpE52vU02NPHQ2UfA6qgpTMQ+ZQqdM7f8Gw4hNuI7hcd3XO
 gocEuqZMsLZwRrynRhyxHlqCgQ3IBP5XrZ0sMgYOe/1GePHbdAv5IWC4ZvGquxpZwEMbP0yvmex
 6BUT4Yso6/pF1F7ktaNbF62AYp5jy3MbvEBIJnjzSxjaMb8KX60Pfjqok4HmcqxwHdDGbshyyzG
 3db0UMUsafpGEbJ4qSLwmQ9pwmAjk09IWjxUYNul314LtS0DF4fUAeLkW1b7ABmR2lYX+FaTZ+s
 Ojk7QrdskDlLFDcaM+gjDcSNaOcs4qjlLH7mFK2HLJkrxANA2aaqw7IqDKgtdZQ6EMHZTBhckYP
 m7z/Z9QRGF01mErtu8w==
X-Proofpoint-GUID: 1MkJezBg6sUUD3y4MUrXUkvMSt0EsELy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_01,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060023
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

On Mon, Oct 05, 2026 at 06:18:24PM +0200, Jean-Francois Bobier wrote:
> drm_connector_hdmi_audio_ops implements .prepare and not .hw_params, so
> every bridge using the HDMI audio helper configures its sink's audio path
> from the codec DAI's prepare callback.
> 
> That is too late when the CPU side of the DAI link cannot start until the
> sink's audio clock is already running. ASoC's snd_soc_pcm_dai_prepare()
> walks CPU DAIs before codec DAIs and returns on the first error, so such
> a CPU DAI fails and aborts the loop before the bridge's prepare is
> reached -- the clock it was waiting for is enabled by a callback that the
> failure prevents from running.
> 
> Qualcomm's LPASS is one such CPU side. On an sm8250 board with the
> DisplayPort controller bound to the DISPLAY_PORT_RX AFE port, starting
> playback gives:
> 
>   qcom-q6afe: AFE enable for port 0x6020 failed -110
>   q6afe-dai: ASoC error (-110): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
> 
> and an ftrace of the attempt shows msm_dp_audio_prepare() is never
> called at all -- only msm_dp_audio_shutdown(), from the teardown path.
> 
> Add a .hw_params to the helper that runs the same configuration, and a
> drm_bridge flag to select it. hw_params runs for every DAI in the link
> before any of them is prepared, so the clock is up by the time the CPU
> DAI starts its port. Both callbacks receive identical parameters, so the
> configuration itself is unchanged.

Similar changes were proposed several times already. The IEC958 status
bits are usually set by the userspace after the .hw_params callback has
been called. With your approach the hardware will never receive correct
status bits.

If my understanding is correct, a more apropriate fix is to make the
a6afe driver to emit AFE enables at the .trigger point instead (maybe
together with other commands) or to split the DP audio init, moving the
necessary bits from the dp_audio_prepare to the dp_audio_startup
callback.

> 
> The flag defaults to off: a bridge that does not set it keeps being
> configured from prepare exactly as before. For one that does, prepare
> skips calling the sink's configuration again only for the specific call
> hw_params already did it for -- tracked per-connector, consumed on use --
> because ASoC reaches .prepare with no .hw_params ahead of it on XRUN
> recovery and on resume from suspend, and the sink still needs configuring
> then. Skipping unconditionally would have left it silently unconfigured
> after either.
> 
> Note that providing .hw_params at all means hdmi_codec_hw_params() no
> longer returns early for these connectors, so it now runs
> hdmi_codec_fill_codec_params() and the IEC958 channel status fill before
> the (inert, when nothing needs doing) callback. Both are computed into an
> on-stack hdmi_codec_params that is then discarded, and the one shared
> value written, daifmt->bit_fmt, is set by hdmi_codec_prepare() to the
> same value immediately afterwards.
> 
> One more side effect worth disclosing: hdmi_codec_fill_codec_params()
> also writes hcp->chmap_idx, which is not on-stack -- it persists on the
> hdmi-codec device and is reused by the next call to
> hdmi_codec_get_ch_alloc_table_idx(). hdmi_codec_prepare() recomputes it
> immediately afterwards from the same channel count, so the value itself
> does not go stale. But hdmi_codec_hw_params() now reaching this code at
> all means that a channel count the sink's ELD does not advertise is
> reported from hw_params() instead of prepare(), for every bridge sharing
> drm_connector_hdmi_audio_ops, not only the ones that set
> hdmi_audio_prepare_early. That changes when a bad channel count is
> reported, not whether it is, but it is a change to seven bridges this
> patch has no other reason to touch, and worth a maintainer's opinion.
> 
> Signed-off-by: Jean-Francois Bobier <jean-francois.bobier@laposte.net>

Please take a look at Documentation/process/submitting-patches.rst and
likely Documentation/process/coding-assistants.rst. For example, don't
send the new version of the patch as a response to the previous
revision.


-- 
With best wishes
Dmitry
