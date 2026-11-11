Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F573606A331
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YEhTcyIX;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NKXtnVyi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0142310FCC9;
	Wed, 11 Nov 2026 17:14:02 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B20910FCC9
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:13:51 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABFOx7E013057
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=EAm+hwV1E45v1JKyU4Nifbxq
 jehcDV1sr0hUES+EoSE=; b=YEhTcyIXlx4E9RnEGwSCphsW0AKO38AGEF9jtVSG
 EgZUQ3d+YwvmqxK4JPxFIS94kg9o+KoSw719CoL8BKNYCWJnB2+DXXrhSVTlrdyY
 tUY30HpNfcFYP/e3SZj4BgtK+lJSIDV+NvppIaNGzlbDoOqCMFlcZ1sMUo9RGbTM
 +SjUlvoxFQmSwP0e/qUUKdbt2bFMtq+c0VSEhsdnBayDbDj2dzQAVU+Z0ltTgphu
 UC1z9mumF88MQriAoJjxgnJXxQrhjVdG9YcQfIr9AZXl/55NqOeXwfg7wd57T0uU
 V/310XioTUchrP4rjokX8gtKq4P3g0zu/bm4gSRUhNnh4Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvtymrfe8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:13:50 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-945c60b470dso508791885a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794417229; x=1795022029;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EAm+hwV1E45v1JKyU4NifbxqjehcDV1sr0hUES+EoSE=;
 b=NKXtnVyioVZAzLg9HwCZSA+dk385dEASo48+utlm5qYshd5L1gCpWxTReoE1M5Xhq4
 Zam3JWB1P0c00Q0mn5+41RwUeaBUbKQCM429TR2IMBNhdl3kvRFKzmnWPsftFFkp3RzF
 EaeA7ggQ5hl/6qsFI5K/VrXG+ztc5aeRYsgmwrF/Fij28fFmm9tWh3sT3TjQLxoM7Jqs
 pXUbT+FFoBgvee0sj75eibw8dETiN0EtN5JV24gESmd9IKGUfrzVd8tKz2GbH3uyyLiJ
 a0VPREXimMonUzlOETF03UL1UxgxEpUgqwPu8pqYeELIlUQeqi+wALBHeY7xHXXTkN3p
 VJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794417229; x=1795022029;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EAm+hwV1E45v1JKyU4NifbxqjehcDV1sr0hUES+EoSE=;
 b=ZBpFtXXvmkPwhLEI8Ycz8s9OvXKaHtVD/DQXgL6aoOTNXsOVGTw5HVbmsAubAZ/e6j
 tpxaL1rYaP5qPyWhqkjHAk6fdygmGIjHQCBBJvZr7+UtilKWDkdrZVm+bRt5/89s28Km
 AHj5zfO8lBB7WUdFH65w2qgMdROtw1SicFRsqC+zhOStx6gqTM9MzZwt/NZTih4KFQMv
 AwEvZKXMeXh94T9GyXDf5otaQcMp9qat6v5MRznQL56h3q70pN3YtLoFgCTV1mIl+t+G
 hrdDQiNVd9O4oAduxewGmlM8afNsqjE1Q+T1dOgGVDDIMiYN/LDc3SRyYVlsjhnaIxV2
 PrNw==
X-Forwarded-Encrypted: i=1;
 AL+hErGtddUyNWHyjj2D16aPMYJknFHm2guqUmv6Ts/VF9rNKTvon9y/s+bi0R5E2+4DVX3omxKKdX1UqOY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/vzLfUsKGriDHq4wWJti0bbxOwtOF+aQz2M7owRub3xIsoyiBT
 sN/TDTrPNndQs64KmXntOYLWBQiT3QwgWfa5I6ALV0O+LjYy4toG2XJykd5xddLcQG7Aln5susw
 o93u2cnOeR7kKmr+mn6Rea/V4EQdX/Ba3t3fNm/wsxGLkpbuCvCBrxIdkHo5fZ1+eL2DyZJw=
X-Gm-Gg: AYBFou1kcfNNJS/+QiNOwtUV/cwQh4ro7OykJKuhlTkf81iotuW2iBESabtS2djYWzP
 JFERNV8V3Y6bojKykhyHGA1zBPI0m5PihVwvj3qeZ9K/9iolI1dLmh2nVEpUMwFWbB2HSbxxux2
 8FjFT3KvOFEWd/N1Y1opTfzCZtZgBAz7s22u8rRa+HcMA13S2q4VYW8jPEZVoApKf+/Sj6xqkrE
 x3t1rg+jJgbqroEVZMtyjLqrPDmrPr51XtU0Ngo3Lr1Uu0s9Z32MMns4+Ep2Jwp9rnfllQqDPIG
 nyfcV1+Xx6Kdyfcvn9uP/76iDZAiW6bOANTnD7XTjCHfLopAyHGERZiOecrlSOXTjxhLm7PjQIK
 8eRS8I1EbMqVb33zqdlO9ZlMKt4jyxOnJtF8pZ06hTh7lJP6F8Toe5MiwLwutNMkWrhnrjVdH4a
 RpuKG2Gpkr1t/JgGc5Z29XSlpl23f+uXD8yqHS07zkN4Z889ui+JbtoME+o3IXcw==
X-Received: by 2002:a05:620a:2725:b0:940:7e5c:7424 with SMTP id
 af79cd13be357-947b008a44cmr488325785a.66.1794417229479; 
 Wed, 11 Nov 2026 09:13:49 -0800 (PST)
X-Received: by 2002:a05:620a:2725:b0:940:7e5c:7424 with SMTP id
 af79cd13be357-947b008a44cmr488319585a.66.1794417228930; 
 Wed, 11 Nov 2026 09:13:48 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae09173b53sm11554591fa.3.2026.11.11.09.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 09:13:46 -0800 (PST)
Date: Wed, 11 Nov 2026 19:13:45 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Val Packett <val@packett.cool>
Cc: Joonhoe Kim <26rote@gmail.com>, robin.clark@oss.qualcomm.com,
 lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com,
 sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
 simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, yongxing.mou@oss.qualcomm.com,
 Xilin Wu <sophon@radxa.com>
Subject: Re: drm/msm/dp: hold one runtime PM reference per plugged state
Message-ID: <2ndbj5fk7tnmexirfulh25kwx6pjzsmp7vjczbhqdxxuw3fm5u@qx5qumdw6ng3>
References: <20260929130627.959-1-26rote@gmail.com>
 <018c6fae-49d3-4f89-8212-8c6b64a2829c@packett.cool>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <018c6fae-49d3-4f89-8212-8c6b64a2829c@packett.cool>
X-Proofpoint-GUID: i6ZbB1aXBKm1UzCYFt24HIErmFrHWM9D
X-Proofpoint-ORIG-GUID: i6ZbB1aXBKm1UzCYFt24HIErmFrHWM9D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2OCBTYWx0ZWRfX+keUqmYCdxaW
 tj5MaVl2Nkna15KtL64yiGc6FMJv0aiX+3N29DWMCXxV64XIysCOBOip1DJ2H9yuez74IpCwX8X
 0v17XWnf46ahcVD2taHuey0YL20tXBF3bUWiT44gJoS4wwsPmE6EJsmTwM4yacQt5uk0bSGH5AY
 jdofXoTksSZcLgqrlkLpNT4nQm4u5Bgk4VtO9sd28o4xLwkHrowhvdaZ993hmlskfGCXAhZS0pH
 kA24r5QBKAx/zIllUyG9rEV5FLExFgeMC+f5Ab9v8Hvej5AfJ1h3G1CFnb/tpS2ybrMf979FLqA
 6qFyvay7FC/yfICbPa1wyLEDyZ9ric0mA6aj7FfgQWxdGUIZzf8EmpNefgLgl5vB1JAWNfuYC6a
 BdvIHwjjC6fmvofRVMlt3vsYA/03kCz9AfOXp2ssd+a9wHu+lycM9pASC0EAAlsBRap7QTxLHOu
 qF+3X+eFtNraPpSi4Qg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2OCBTYWx0ZWRfX9NXGseETPLpj
 wKQtve6zrD2LlAl9hl1SV+w79Yi+YiMBVYxW61qRq0rA2fbFiMUNtWNVLignLpunaIb5DGS63k1
 rvi3WG1mls6hBKKoeviDYrlEDARi4Vs=
X-Authority-Analysis: v=2.4 cv=Q4BHcI2a c=1 sm=1 tr=0 ts=6af4a24e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=P0_V0cqhvWXbucGuATgA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 07, 2026 at 01:39:00AM -0300, Val Packett wrote:
> 
> On 9/29/26 10:06 AM, Joonhoe Kim wrote:
> > The plug handler takes a runtime PM reference every time it runs and
> > sets dp->plugged; the unplug handler drops a single reference when
> > dp->plugged is set. msm_dp_bridge_detect() also takes a reference and
> > marks the sink plugged, and keeps that reference as well -- on every
> > detect while the sink stays connected. On top of that, in the current
> > tree the plug handler runs more than once per plug:
> > drm_bridge_connector_detect() calls .detect() and then .hpd_notify(),
> > and pmic_glink altmode reports an IRQ_HPD as "connected" too. Every
> > extra reference is leaked on unplug.
> > 
> > On a Lenovo TB323FU (SM8850, DP over the USB-C port via pmic_glink
> > altmode) the DP controller's usage count reached 28-34 after a few
> > plugs (rpm_usage tracepoint), so the controller never runtime-suspended
> > after the display was unplugged. It in turn kept the MDSS core GDSC on
> > while all displays were off.
> > 
> > Make the plugged state own exactly one reference: the plug handler
> > only takes it when the sink was not plugged yet, and detect() returns
> > its own reference when the plugged state already holds one, or drops
> > both when it finds the sink gone.
> > 
> > With this the count stays at 1-3 while a display is connected, the
> > controller suspends 3-4 s after unplug, MDSS suspends and its GDSC
> > powers off on DPMS off, and replugging (quickly or after 20 s) still
> > brings the picture back. Only tested on this device.
> > 
> > Fixes: 3ea2d1c3d154 ("drm/msm/dp: turn link_ready into plugged")
> > Assisted-by: LLM
> > Signed-off-by: Joonhoe Kim <26rote@gmail.com>
> > ---
> > Related pending work: "drm: handle IRQ_HPD events correctly" v5
> > (https://lore.kernel.org/all/20260920-hpd-irq-events-v5-0-ff1de0090c72@oss.qualcomm.com/)
> > removes the IRQ_HPD-as-plug path, and MST v7 26/35
> > (https://lore.kernel.org/all/20260929-msm-dp-mst-v7-26-4b81473185e7@oss.qualcomm.com/)
> > the detect-based hpd_notify for DP; the reference that
> > msm_dp_bridge_detect() keeps is leaked either way. MST v7 27/35 touches
> > the same lines as the first hunk; happy to rebase on top of it.
> 
> Also kinda related / touching the same places, tho not yet sent to the lists
> AFAIK:
> 
> "drm/msm/dp: Mark the link bad when an active sink is replugged"
> https://github.com/radxa/kernel/commit/eb3247f6f9a39dcb15cf4b1df6d4732b1489b410
> 
> >   drivers/gpu/drm/msm/dp/dp_display.c | 23 +++++++++++++++++++----
> >   1 file changed, 19 insertions(+), 4 deletions(-)
> > 
> > 
> > base-commit: 6375e61c01e93e35ee7acd336a689ac1fae4b509
> > 
> > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > index 6abe30bdff12..4e47b659c71d 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > @@ -412,10 +412,17 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
> >   	guard(mutex)(&dp->plugged_lock);
> > -	ret = pm_runtime_resume_and_get(&pdev->dev);
> > -	if (ret) {
> > -		DRM_ERROR("failed to pm_runtime_resume\n");
> > -		return ret;
> > +	/*
> > +	 * The plugged state holds one runtime PM reference, dropped by the
> > +	 * unplug handler. The Type-C side repeats "connected" notifications,
> > +	 * and detect() may have seen the sink first: take it only once.
> > +	 */
> > +	if (!dp->plugged) {
> > +		ret = pm_runtime_resume_and_get(&pdev->dev);
> > +		if (ret) {
> > +			DRM_ERROR("failed to pm_runtime_resume\n");
> > +			return ret;
> > +		}
> >   	}
> >   	msm_dp_aux_enable_xfers(dp->aux, true);
> > @@ -897,6 +904,7 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
> >   	u8 dpcd[DP_RECEIVER_CAP_SIZE];
> >   	struct drm_dp_desc desc;
> >   	bool phy_deinit;
> > +	bool was_plugged;
> >   	int ret;
> >   	dp = to_dp_bridge(bridge)->msm_dp_display;
> > @@ -910,6 +918,7 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
> >   		return status;
> >   	}
> > +	was_plugged = priv->plugged;
> >   	phy_deinit = msm_dp_display_host_phy_init(priv);
> >   	msm_dp_aux_enable_xfers(priv->aux, true);
> > @@ -960,6 +969,12 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
> >   		}
> >   		pm_runtime_put_sync(&dp->pdev->dev);
> > +		/* the sink is gone: drop the plugged state's reference too */
> > +		if (was_plugged)
> > +			pm_runtime_put_sync(&dp->pdev->dev);
> > +	} else if (was_plugged) {
> > +		/* the plugged state already holds its reference */
> > +		pm_runtime_put_sync(&dp->pdev->dev);
> >   	}
> >   	return status;
> This last chunk looks odd, is that not equivalent to just doing
> 
> if (was_plugged) pm_runtime_put_sync(&dp->pdev->dev);
> 
> on the outer level, outside of the outer if/else?

I'll fix that while applying.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
