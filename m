Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09A0606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=olqaZRkW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cR7J8+tR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5042B10FCBA;
	Wed, 11 Nov 2026 17:08:15 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3335510EAA7
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:08:04 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABF045Z3597123
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=SxOyryHUbNQ1cfTF9VQJXNM+
 vPgoGOT43gQa9xsLuaw=; b=olqaZRkWfFlPRoXowPqT2XFofvzN3neVvYgeoSBN
 Lxo20Iy4WVfIsO2uFubngpftOURpdv5pxZlHZzZUWx17E+TtF987HAPafaDt5UYE
 MqiSMwtvs04WOsgZFfpFisIvG5+yr0PEQF2xxc/OKv+zut9F3pmSG9PrqrDUL6sh
 gPDguZ94O4EPkcpn6RbEpA8r5X3LF9y5lQccmacDKiTFnnXgWiITYxBwrsblsRiS
 TLBORvlsAug49jzlqHMgQoXOigI7FFTxJOi2QxeraA3NEcB8FCnwOjHdhAswKkmX
 E+0snCgosVKnMiWyC6bq9qgE04sUAKoGOIyTYrZiMKfH3g==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvt1u8qj9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:08:03 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5ecb636b587so913144e0c.3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794416883; x=1795021683;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SxOyryHUbNQ1cfTF9VQJXNM+vPgoGOT43gQa9xsLuaw=;
 b=cR7J8+tRfW0vrsic9Dw08v/XCTXvJfXUCdlOY8tip2C7WFn+BxyrQ23F9a/5Hq6hw6
 RDCGsAe8XfzVntLjSsp9AKPD/xt4c+e42t4gr7e4jJKTYjNHAXRvcGmXgfdRn76vsTTY
 +82obvAoCRcAcBu/Z7cDmTLKirP1Y6pnbfozdMXw7qcxurp8Rj9BkfZfQuHR5To1FqgP
 zdTeZ+nEBITNh0UjarAALLIN0qb02A+m+bthPg+PTWoBhrqh3d9RRZFWoWWjvnMYL0+b
 Q6RM1ztvp1uGLVgajOyZUPARtgHtgq+K61/481+we+q8V5ytUY/5S3rQW6iBiyQrM2fC
 Y41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794416883; x=1795021683;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SxOyryHUbNQ1cfTF9VQJXNM+vPgoGOT43gQa9xsLuaw=;
 b=VkMCA657GhkRN4jnUJkie1EOXe+eltylOchPjyYdl38QzwbLjWl9qCzafTftqTC9lk
 A4B/ORXtdtyQ6BlXU2biiLnNlDjbEB3/53yLgRFk9lhTM8lA8ALeU4F+VIsMc3LKTRNa
 TgZKOUtdjvH51dWn+XKazWBhoBj6hAuqLD0CReak1wL1oajaXNifcO7qd9GNRhw7j8sQ
 pU5OefTeh7ZsKSovwTAqVHBIorEDyQ75PUOfgagg2voW11Ku61o0+afKkNEcxBASM9lB
 UhhakxXDvhkegA+3oZYWg4s62Q8UDVNYeEYZbrckua5oIFFkgWwyUNSXy5waSe8bMGoM
 z0Wg==
X-Forwarded-Encrypted: i=1;
 AL+hErEIJplDglSdPvj7IlV06Qray8+7W6ef0DZ6DMY3CjWHtZp1f2JR54e5N9Ofxs3ZHxkcLJ+Do4q45OY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+iabJsxSAkd562+94adScNg/f+jmyQbiZx9CYzXKF1IrggAeZc
 m4vyJr5uyov7DGkYJ0ZX3ZqDQSX3eJFtRdJegK1rkYQXbJDIVNDHDgTnvU6p5P9PdqPebLUf6yu
 /vcW7tJpzMTCupNE5gy3OnksNKAyM09LOK0ytuDgwMMToPVSEJt5FPiyZYvz7vPRDO1XmxCA=
X-Gm-Gg: AYBFou1yBLASNxX6ZYlaF2mmlnYuIOHSnfo8QKA23KcFlelDBAtH8Zg9bAwlN9G7b0m
 TjtdMgLQRs8uTup4zm98FAw17ezCbYwafZYIwtChfP1ljlxvx5CJB4idOMDazS0RmebHmSaP0mQ
 NsZJFnAkADBmu9ljBvTYu3dEgcOHqcw4AT3IKFy0vf3ZFTEF6umFUJ4IEusIshqu4tsFSXSOWlO
 pZuv8JL0dT3wiSEs1qxr2wJ7bioTHp1sk6duH24+Y3xplFxMkAgklQK0f8h+W2fEnCSCy1Uc7QD
 h/IEB7ZXGHVgVI4PzDW8jA1wnFVqSfyIhtFh6Kvc1IYnoXp4SYMfN52x7K9j9uh67xLeF44PjRN
 2HOK20J92H33ya5Drj7KeUPpGvIARDiyjftC00rj+mhocnE8eInlAFGrlV5j3g8v88ELamjs5rh
 w3IONwQgPPDQWZqdd8OXQOLRJekBuTptuoshWhOsIk+s3Cc2NPYqlh4n8I4NQlzA==
X-Received: by 2002:a05:6122:17a9:b0:5e9:731b:84f3 with SMTP id
 71dfb90a1353d-5ee1c3fa04dmr1120660e0c.12.1794416882305; 
 Wed, 11 Nov 2026 09:08:02 -0800 (PST)
X-Received: by 2002:a05:6122:17a9:b0:5e9:731b:84f3 with SMTP id
 71dfb90a1353d-5ee1c3fa04dmr1120632e0c.12.1794416881748; 
 Wed, 11 Nov 2026 09:08:01 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae09206aafsm12751441fa.9.2026.11.11.09.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 09:08:00 -0800 (PST)
Date: Wed, 11 Nov 2026 19:07:57 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vivek Kumar <vk092kumar@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] drm/msm/dp: allow eDP sinks without DP_SINK_COUNT
Message-ID: <wuuyudiqxomceind5f6yox53db5w6y75rcnbgscxujvv4cmnya@iq5522yhs7o3>
References: <20261019051441.2835682-1-vk092kumar@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019051441.2835682-1-vk092kumar@gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2OCBTYWx0ZWRfXwkD7+Zhy+ri/
 ry+h8YvcKPHH0mlkvot37sjNkXRJXhkRgDYTdCIi2Nfw53SrtTlZ/YJ/utJzZIiQsRO/Czn4rJA
 WTUAUTR1mTD05e4baX6t/xCWMql2hLE=
X-Proofpoint-GUID: lm18RzDLDD8ALAdMbum_74hLa9tC3M3k
X-Proofpoint-ORIG-GUID: lm18RzDLDD8ALAdMbum_74hLa9tC3M3k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2OCBTYWx0ZWRfXwceK9gfCA85c
 tctnmDeWN7Utf6CkGdIjxdTlWbcoeW93+FXu1f7oUUU/vTthIP6a3bLyTtSiwjgmZtQVxzd/Y4b
 rWIRrClE1HdCDBzvKjpg0a1GEQE6O7IXCUf2JkHuhoNcVJ6WLthm99U0F0ba/cB46AA0clp68aO
 +Jvm7/RH5XHxdSmkwFaSN6JUcZ7eK0WDFdgWXo3f8T2da8tcJVQghLVPs0suxFLGSGDLDGrRJPs
 quGnVBs4OEGBC/Rloa3yhH52Fw1e0Z1riorbBmmgWYJTGzovbNadC+JRRtDmtK4YXPAGmHmyWtH
 EI8YZGTes6poJXEcj/INjOpeiKh9ukVorjR0dCTQOh3V53liC2QMsV2Qp4PNjq6y653Erf6JPNb
 hR5rT5rjZMzZckhElB7im+1wmtXHH1dUuv+dCFrJyR21WNaf6x0BJ6IHpn3HbnjgKPRynz2Vwe9
 eJ/m5ESehfURZlPE/Pg==
X-Authority-Analysis: v=2.4 cv=LvcHWXdc c=1 sm=1 tr=0 ts=6af4a0f3 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8
 a=QhjrP75uP0Re7qhQPTAA:9 a=CjuIK1q_8ugA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110068
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

On Mon, Oct 19, 2026 at 10:44:41AM +0530, Vivek Kumar wrote:
> Some eDP sinks, especially fixed-format eDP-to-HDMI bridge chips with
> no downstream AUX-capable panel behind them, do not report a non-zero
> DP_SINK_COUNT even though they participate normally in DPCD capability
> exchange and link training.
> 
> Treating sink_count == 0 as a permanent disconnect is valid for external
> DisplayPort, but it breaks eDP probe/enable paths in
> msm_dp_display_prepare_link().
> 
> Use drm_dp_read_sink_count_cap() in msm_dp_link_parse_sink_status_field()
> and set link->sink_count to 1 when the capability is not available.
> 
> In dp_panel.c, msm_dp_panel_read_link_caps() still reads DP_SINK_COUNT
> for branch devices. That read is left unchanged here: the sink on the
> tested board reports DPCD 1.4 and does not advertise a downstream port,
> so that path is not taken.
> 
> Signed-off-by: Vivek Kumar <vk092kumar@gmail.com>
> Assisted-by : LLM
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c |  6 ++++--
>  drivers/gpu/drm/msm/dp/dp_link.c    | 30 +++++++++++++++++++++--------
>  drivers/gpu/drm/msm/dp/dp_link.h    |  5 ++++-
>  drivers/gpu/drm/msm/dp/dp_panel.c   |  5 +++++
>  drivers/gpu/drm/msm/dp/dp_panel.h   |  1 +
>  5 files changed, 36 insertions(+), 11 deletions(-)


Vivek please check the issues that Sashiko pointed out.
-- 
With best wishes
Dmitry
