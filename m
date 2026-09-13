Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B0CC88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 22:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DE4F10EA52;
	Sun, 13 Sep 2026 22:45:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AQ0A262F";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NBwa1bNu";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB56210EA52
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 22:45:21 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DK02gg2165455
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 22:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=daD/zPVERLcknSPfWxaXIlNx
 QG5d4LXKc3bwm1ECFEE=; b=AQ0A262Fw++6GHCgROTUj6tMhxoioAq5mvuZGUnn
 8XI1tNaD9wyTFy2wqAXPGRlb6hZz7tvOGrHWkuiDtuopWML5oxDIZOfhR7Ddl4gT
 OYH2nMryeKw/F/IMg80NcrLGSSVjCJnBMVRf/RtrqykEoaQxVGPlnnOpiVoQt3AC
 wSlv6A+ds0w6Z8CtnRHnmGIy1Ahf4FremIh7LJbpeJekRRBnh8iUd63KtnLJY3B4
 JA/yGjRCa4JAUDHlpkpKglzOjDkVaHR8MuKq5ivHhb8XYSCX0RBAg9XpieR2ED9k
 KVLIK40OaLR0MPPOAw9MBqI5ZAMSYPFVvMdVnljj2Dm+4Q==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmygd4aka-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 22:45:21 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5c82b120e93so624418e0c.3
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 15:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789339520; x=1789944320;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=daD/zPVERLcknSPfWxaXIlNxQG5d4LXKc3bwm1ECFEE=;
 b=NBwa1bNucokeqFctYGe/W2ibRy9w0uurJfGmkKP9faik1dP11THFW5LTIhy0jLFWLP
 lBJRPl7D5TunF5GmuX15INwPUaCukm24pag4qqRJ1erUz1/siyEkxVsd91NReJSufIBd
 kFGPZLstAdiljqcNEkZg1T5k2gZZ12MFn2RMOZhN4XblCIvpdLSh+u2nvKdNyRUWkffm
 fYxem7JR6UEBCRSXKurmCEcR6WRFsawiGSDq4+6E3pS97L0sIgTo/ZvYLNtpV78g3aDq
 jV5oMMrKmGxs92yaguMl4xebb3sp9HfbAeWQgYdkgul87ucMz+IX+YVG3kkSQetvYdJK
 wuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789339520; x=1789944320;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=daD/zPVERLcknSPfWxaXIlNxQG5d4LXKc3bwm1ECFEE=;
 b=aXy/FTEBWqc5hkbPdItDmav5OodRouN/lv4VH68A1oYxXQhndKNcoH61K4sWHMgX0p
 MrhAMYPGn/R9+QE3C0q55jf8ILJ+6WG9qlL2FjrCbMlvZ9wmb5Xgjkl8ajyn5QwnZwBn
 9IzHeKavmvGj/DVx6C4r3lD2ExAcXZj9RVmn77NNsP7gnzIGrEPdvJopgpt14lZRGwcQ
 H+HWfn4rOWXXVONJQuI6B6WRm6Y3OQNdcKWy9/owZGFzEiBcyRM40SRJelr4mGB2jtgc
 ioFvcW8QCYDVCipy2OaUxvGdF3lmle0o0Iw8fSPWn6NPby9ZcZT99QGvCqNiuqozxO7h
 pThw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwv2MgRZfS3LUm5lYo58x4FhebBydKLzpMqtD0+11w6XCa+hpx6wssEmz5YgjCKXBxn1dr0wN+/FyA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nORIv+uQzpcRZ4ix2fjfvnogYcHE7hV5QEEUA5b6fi//qRxyrD
 lJQ/4xKWn5ZOSW5PPlPkMT3VMQT76jRqROx1dy075nlfdGFDfQJVv0BLadX6lhp2tvT6zuN6w9s
 AWvGZcG7Vu8o9mgwziWdFoYOzXGhHQIK2g9FSGGNrveqrsDskwqsOp7R5ov6xlMmzwja5RLc=
X-Gm-Gg: AYBFou300KVNugFAZr/09Sip2m3rCjo+2KqyS2tRmYrza73iFV8OPEuDDYfwVgPO3Gi
 Hg/Cbp3HfRo6PXhCoqUVoQrxzVEWQg47EBqwozvc8Guw49ylR5rLQgTYrgNl1+IEg3BduCj/GMR
 Vf0BTo1uHOyA9Hlp/8t2+/rVNaXI/KwF1lg7WFw79/nctTIbf4sXOjUTCJUN9W6WV2WBeR6q5XK
 A3oCrstWQQ8LOhudeFcLKlkEWft+i9vyOjDwDqHH7RkcNGmM+z7GzlFyUFo7ZQEE70xeh67xPPf
 ZziacsjfxuDev45tWyd30uThqwBUVSI4zrqznQtSeu1CitEe2lQKc5KY+3+BtbLgWqy2Q/9mFVP
 bIyCIV6WKnmU5lx63rQ9OnRTNy1cBgWnnuuQ8UXjKTf26MFCYpEM7+ynE8NuRicrvU7/Qcf1WLO
 3KfhBq74OL8VnM
X-Received: by 2002:a05:6102:3c82:b0:790:c7bb:43fd with SMTP id
 ada2fe7eead31-795aad39567mr3174396137.8.1789339520026; 
 Sun, 13 Sep 2026 15:45:20 -0700 (PDT)
X-Received: by 2002:a05:6102:3c82:b0:790:c7bb:43fd with SMTP id
 ada2fe7eead31-795aad39567mr3174380137.8.1789339519561; 
 Sun, 13 Sep 2026 15:45:19 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a04709b3sm1975544e87.57.2026.09.13.15.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 15:45:17 -0700 (PDT)
Date: Mon, 14 Sep 2026 01:45:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vivek Kumar <vk092kumar@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dp: don't gate eDP on DP_SINK_COUNT
Message-ID: <eztwqufgpc3mxjeyfy2effil2my42rzl46meblopq23h2wrhwe@5jjgc7ruzlzf>
References: <20260908091708.3123735-1-vk092kumar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908091708.3123735-1-vk092kumar@gmail.com>
X-Authority-Analysis: v=2.4 cv=RY0FmFtv c=1 sm=1 tr=0 ts=6aa72781 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=pGLkceISAAAA:8
 a=9Ukn3v4DKVw18m4NUkcA:9 a=CjuIK1q_8ugA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDMyNiBTYWx0ZWRfX1U+utlm2wIHx
 5M+pRmqTXzPlchkbuXFoGaqvR+lju+9qmKyHNdwBeTf8ZxvwItFYP+pZK7ctemsg52go+EI1G7X
 MOUc+24J25RwrW1wBz4y85m6CctnEW2D1Iz7p7EkNdpgn2iCWSNvGBpF1wUTa3eWk5NI4h4vTnR
 U8AbvrmVnKhWQdL4Noc3lJ+tkzxkXVzReym/luiEks5xVJRagSDruF8/GzDy2lqVAHHZIfyFLRa
 p/F2omP77g5MAuR+MRB03hLCSBfsaYdgHZHyZWKdCMmvZZ+wM/lZJA0rX/HK2sEpKnRHuhxzWpo
 VE/ti8WpjE8C6tM91K2vJAxqsTVsB6xjEuq3winCkRzTfGLjKqNnNTvWM63W9qB+LhYcms3CM+N
 9EB7OLJrr5o7w2sF8AT+SGgrEVfSSfHP3Yp4XKP9LTzcrqpUpbZR4vIEAB6W2pJHTiPXFGHs5pm
 qlXPJ8xwuve8DjaJNYg==
X-Proofpoint-ORIG-GUID: k2BAk4OxfEBtTtfY7qWBjp7_Yamgx7Q5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDMyNiBTYWx0ZWRfXwKNY1IV3xiTD
 vF8UfXoxzNEmU9jP6j8OK+n23c1sLDdTWmgRJ0Cf1pT34HN+CkPX72QGt7XKA+QZOlcRa5WIP7y
 U8Y8toNwJLRtASJPCn1Oc8VI9OuOlEU=
X-Proofpoint-GUID: k2BAk4OxfEBtTtfY7qWBjp7_Yamgx7Q5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609130326
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

On Tue, Sep 08, 2026 at 02:47:08PM +0530, Vivek Kumar wrote:
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

I think the better way would be to fix the
msm_dp_link_parse_sink_status_field() to also use
drm_dp_read_sink_count_cap() and to set link->sink_count to 1 if the cap
is not available.

As a side note, we currently read sink count both in
dp_link and in dp_display. Could you please leave just one place? If
not, it's fine, just fix the link code reading the sink count.

> Tested on a Qualcomm QCS6490-based board driving a fixed-format
> eDP-to-HDMI bridge IC (chrontel,ch7218a) with no negotiable
> DPCD-capable panel behind it; without this fix,
> msm_dp_display_prepare_link() unconditionally returns -ENOTCONN
> and the display never comes up.
> 
> Fixes: ca16db3d18cf ("drm/msm/dp: break up dp_display_enable into two parts")

I don't think it's the commit which introduced the issue. We had code
checking for sink_count being not zero even beforehand.

> 
> Signed-off-by: Vivek Kumar <vk092kumar@gmail.com>

No empty lines betwee tags, please.

> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 

-- 
With best wishes
Dmitry
