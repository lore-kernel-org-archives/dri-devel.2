Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B77606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 02:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KI/qRF06;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MB63mz6D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7363F10E454;
	Thu, 12 Nov 2026 02:40:32 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E2CF10E454
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 02:40:21 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC2ZULD4149288
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 02:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iih96abnjxj/PozHFDBWYCK9JcXmwzDO9tgu+OyMggw=; b=KI/qRF060qDr0r2Y
 cJuOgXtsBpuDssWcFJlKOO1nnz751BpTeh9oz1oPGvjmslvWwhtLwO06nYw9Mz4r
 ecj4zy4uuMABNaIYsfdpdtFlcLHOb0GPfLodjZXjXNDK8Vf+XQwfP+fvVcSjA1fG
 8h4TorsRex4rX7DoDD7Xb8uxUGXLLNcE7DByWRDzOUXxuwCBoKiBaRMH9GFL3BUA
 /SVMy9oqTiO0QrtV7oovqEHmjChkcnZA0sdNFtNSTh5HzTW33BNQPX4QbldT90Az
 F5ZYYFXjKa2Gozlp/vRRIx8hfdaKFek54kf3AKzEgLxcExHQcVbuPbqhhr1obTxj
 daAuAw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvxc61b5k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 02:40:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-534f3fe0236so81270881cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794451219; x=1795056019;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iih96abnjxj/PozHFDBWYCK9JcXmwzDO9tgu+OyMggw=;
 b=MB63mz6DLZYSoHsTbjR+0xTdgw77ISdF9F1cWV7J5CYrbRPCrWLtxQVE+jq0TkUiKs
 UO4jxuxQDNLaol1WP+Tzz6FEjEVKYPVSXzc4ypsEwkbVYBbHXNPF4dtQttj+3mkG4rm4
 /sk/bziO2InVR7IVnJRf4/Pg4HT06S34IhZFpj5mGR87fld8Pc0nyyrTFdWNSLEn6u0M
 9S1h3U8kIM6QPBWiuUgAoBP0UvQVbzHGjbmfQzvv9EPMpxktNOwsFI1czNtEh8/7AZwJ
 QSihNR740Ro3mPdcwmhxRrArUI/WMhF8aKn2iNRGnGImpznEyeZiEEI7h5Wuakh4clT6
 8azg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794451219; x=1795056019;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iih96abnjxj/PozHFDBWYCK9JcXmwzDO9tgu+OyMggw=;
 b=tEZtv1CuYG+JYY3BXsB/teTNm1a1nfnR7xpj/teKkUkjgWFY1Y2C70OIgL6Z6qJDIz
 Ea4qU3sIhUXHYYBti8Gp8S26ws/fAyPGtjrnqHeqNzS7gu+e/M9E062vtqDxYBARVOQx
 cqhSvrWZuiqk+m1bcHGn0sDvq3xGlM4cQuLfH6+J4mLkPb3jhzh9bPpQfDHr8dQYoy+C
 XsBNMwwFFO1niK8TMr2GAotE0p+W1ksOrDCVjXp5GXsQqiFh11YnQQJPiUKIbz4gofiZ
 16xV9mZO4158aCneZ/kCIGr4+0znCQQIfj3uHqRAsYZTq53Z8w9Y+pR36dzEzTHFDRZz
 wOtA==
X-Gm-Message-State: APuU4Z90RVPPskwwIFPYga0nRhR4ZzXBMr90OF4q5sLOaz6Hqbk3Er6a
 mg2U0qd2lvbujoGTr7ILvBaCuiTxKXI+17a3snLuj1r7t7O9Ce5forOLRa1SW5SuGT85QQ0Z5BK
 9A/R7a7NNWNdPniHHYRRs9ZwlYGfAvQYX2tiyAUG23FPyNKVuw5xh3hIR9z7VIWu1/GwId4Y=
X-Gm-Gg: AYBFou36x49InAgcI8I17IGertAdtYBuGAqcD7G2hpa2zODHVAoSLB4wSvQMcK5GDPy
 okvETRf/HAdhTn9QHEnczQrZFN2Upgbcw8ADYlUFLIJ6vKucW2dYUWrncfDbWagFZULdhGAv3y+
 DaPF3Kl5Ruy0c0m2mefiDzzea64u/V/ACxhn8H1PO9F1RohjamTKhjINMbI40lAe8mUqjN7zR6D
 cBMxJB894kIlIc2NdLvVfkj6zGzS6aK/RjXchO4W2MR+WLtKnLr9Cq5b2n6/sPqI8J/SDurgQCb
 RDF6QlxOb1urxHiLC2JVUjogj3ampBFtA6FVDctDGHcCg97rVv0O3D2+pKrXPPVbFoXnUxTCl4D
 VbFBMSsyufGRKKsNkzbOMXkVnjjEDZQTLIFFKCZaOhpQuaztK7t6onk7thXvpwLUu0nHfEIzP4Q
 LCyC4jnU3GyZLBhqhVc2aUHoU49XBkY/jVEGncLVA=
X-Received: by 2002:a05:622a:4e0a:b0:536:352d:65e9 with SMTP id
 d75a77b69052e-556c25188e0mr64866271cf.65.1794451219074; 
 Wed, 11 Nov 2026 18:40:19 -0800 (PST)
X-Received: by 2002:a05:622a:4e0a:b0:536:352d:65e9 with SMTP id
 d75a77b69052e-556c25188e0mr64861391cf.65.1794451209677; 
 Wed, 11 Nov 2026 18:40:09 -0800 (PST)
Received: from [10.111.167.254] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5550bd33340sm64426881cf.21.2026.11.11.18.39.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 18:40:09 -0800 (PST)
Message-ID: <ffe9dd90-909c-4259-8a57-2ea67307a95b@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 10:39:56 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/9] drm/msm/dp: don't take extra references on
 multiple plug events
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Francesco Dolcini <francesco@dolcini.it>, Kevin Hilman
 <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Pengyu Luo <mitltlatltl@gmail.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
References: <20261024-hpd-irq-events-v8-0-6ee949e7a384@oss.qualcomm.com>
 <20261024-hpd-irq-events-v8-6-6ee949e7a384@oss.qualcomm.com>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <20261024-hpd-irq-events-v8-6-6ee949e7a384@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: xGweLEVylNnPDUfJXd5xhJtGMQeNor7-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAxMCBTYWx0ZWRfXyJym2pS81AI+
 CK2EGtRtf9FJWJpau6TvwGEbv7tdpInWnES5el+BT/zXKmIWLbk5mCIgFU85auRqCOTjDmyzScO
 ayOG1lJe1WNPofuCvca+9YPesk0UhNQKO5Uu4oL58FGXnqhyB8QAUAr/jdETVSRV/JQAadskR2G
 I/W+99Q2mQpcIcMcv5uzxbjuAGiiGLKvtPoK2W4gSB7NwYnjFWPoE8UMV4fJ5LkHHmdCuHaSADt
 5Pljl543L13sRe/KCNmG/t3Pqubdi+sVZRdugIF28TN11ZUli+Z1TwXEVppWq5RUoCI79reynf1
 TJMUK4KcaR2kozgjSFlAeXYuA48mHzpe5ccupKB/GHjAs1ZfMLRyZQJx4R9QFejUS7Igvxqix0M
 RzL1YnXlumBnBvTc1/yUZ0p5m4rZZMPoqrde4HVl7vH0Yy+wey2nHwDQdeJkdBrEtkIA55YDJat
 6MntRJH0O2aNdMwWIUA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAxMCBTYWx0ZWRfX1gvdMKwnW1Wf
 h/qgyRAYL1ueKgEzEWTV+4UshIg2YvwuMHaz+agt5ES5fEHOC5B142SBRnbzFgw/qLVO01TrrC9
 zIsHC9xPIeQ1UtsYmjqIKLxxWin31Lc=
X-Proofpoint-GUID: xGweLEVylNnPDUfJXd5xhJtGMQeNor7-
X-Authority-Analysis: v=2.4 cv=O/ysLx9W c=1 sm=1 tr=0 ts=6af52713 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=UkfVDg3vQ6na--iosyQA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120010
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/24/2026 8:35 AM, Dmitry Baryshkov wrote:
> The upper layers might signal multiple sequential HPD plug events. Don't
> take extra references and skip all further HPD plug events until we
> receive the unplug event.
> 
> Fixes: 3ea2d1c3d154 ("drm/msm/dp: turn link_ready into plugged")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_display.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index fa8942922b53..ce919a26fba2 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -412,6 +412,9 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
>   
>   	guard(mutex)(&dp->plugged_lock);
>   
> +	if (dp->plugged)
> +		return 0;
> +
>   	ret = pm_runtime_resume_and_get(&pdev->dev);
>   	if (ret) {
>   		DRM_ERROR("failed to pm_runtime_resume\n");
> 
Hi, the issue reported by the AI is real. There is a regression in the 
SST case: when .detect() runs first, it sets plugged to true. As a 
result, when msm_dp_hpd_plug_handle() is called, 
msm_dp_display_process_hpd_high() is skipped, which causes the 
subsequent failure.

I tried removing the plugged update from .detect(), and that fixes the 
SST issue. The display works now. However, there is still an 
intermittent issue where the wrong resolution is selected. I suspect 
this is related to the timing of the EDID read: when fbcon comes up, the 
correct EDID may not be available immediately.
