Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5D5CA5FCB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:15:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B076610E2C7;
	Wed, 30 Sep 2026 16:14:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oP3NiAuo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XshHNAAZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4358E10E2C7
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 16:14:58 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE05IM3942413
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 16:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Rtq/wWlS+mrwHHItxvMoEAAj
 +R0M3kvLrZoj3LoEtzE=; b=oP3NiAuo54T7zDU1eTumaSIwkL4GQadMojYc0zc9
 IDQkrrMY4ZY3BLa5qy7te+Wv5bzwRh7cGkpOix0R9VrYVUH8T6GqbAaFB48JW9wO
 bRi7QslIGBoSZ/UDWDZD6ZpoiMSDUvj4OsEv73GvixX2JS6rd+JMxFZa9CkjbA+9
 Rxc2FgyUq1n35psfc1/wYsCD+ZBgBmLu1sRf7xavKtHfTQZ23Eh/m1dYOE9bvGSL
 6FRYjFhDFkwDjAIaMFKOynFgaLwZVejDyMdv1A4LEb9diIEI60DJ6zoBiLqjH9HT
 rdZA503tVDLvLQGMcyA007KEi2d5aj3pRoUR+lQNb4Qfnw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h10bk9kt7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 16:14:57 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e82060977so385946785a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 09:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790784897; x=1791389697;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Rtq/wWlS+mrwHHItxvMoEAAj+R0M3kvLrZoj3LoEtzE=;
 b=XshHNAAZjStwbDpQ7R3Q55A6ExTxkcQ1tnB5NBeWyFXjhpbZdHIkmTdnrkCc6mm4Sv
 GS7Lgaf+SWTrDYm6w4lhxBZ7YGf9o+8voR9Sg1y1PaEWRWMk0jZoX5lOKI3u2moowRaN
 FTUJvSeZho80WLD/F/OQfTww4wWyOv1IEukAdI1uSb3JKqalp+szbvdzxVNNfr3pk/QI
 66Xa4Szq0qpGySILV+PaMBBrbn9tVeKri5nZnt9KXKbUo+hwTaCwpLt1PGxsXESqkl4n
 PoZBNKDXDS1a6AvUh216+qbpgsaoX5ir0nFQESK2EHINAUW9HV/zWkhuu9H3+vygECXe
 +oBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790784897; x=1791389697;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rtq/wWlS+mrwHHItxvMoEAAj+R0M3kvLrZoj3LoEtzE=;
 b=mhTx3kGAm7Btqn/jDmjK0gsKCIeAL6NoGN6NZEl1jlOVCzOh/r4/OBfah+/qA+xCSM
 PJliA/5OqjlNu8XguMCn6HCD302pSd5Ock6vHqA+CBGdhx4cLPyJXssgPvgCcNsj2HXN
 WtDEAN725qN6q1zZJkXbhn4DN0KLqXA4Y8HpLcoWtxMFiTHwIsHkEUSAkRsXtyU1Ow/r
 U0xRxZV/TfmhM6HeDLUppUumA4IKifvCZwe6Lmk64MjrcLJRhSsySnENbFrAlObwqBy7
 DSBIs3nrZlAiLDnMNEp8ZR0OuHyR5OYjO81H1Hw3UyAd/3tj2B8xuuOFldZ2glYLfdXr
 iekQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbA/sEhx0vnyef1bwFvzKXOVfXQZ4NtQDKKHxIeYNghJGRiFgu2dbyWCSQdWbJvJ1mh9M6tqpbF68=@lists.freedesktop.org
X-Gm-Message-State: AFuF++koHvjAgQs6il2APzwbXIdrfuHIWel5nwebFBzRJpj+xR+rhsKt
 zLTt7aDW9u9+SOrxuBxg3ra2QxOn76MLAP8iQwGOahQXPi6/JPUQ1n80OT/ro5ucVbxTEL9GQKd
 vk8IARkaj4tnKF9aXjARANLbpPZ0qoiYep6vYXJdfUQESWWHUfAxWNfLrmm0MBVf4VHGlD3s=
X-Gm-Gg: AYBFou2pbL5YHl6nXomwAgTW4cc5wcmKlzNkBJk1dtokiPTKD6D+Gq40m04i4l+2Nml
 3jbhr9olgFdaL66M73WNqf2gE0CLSILips/eYzt/JcYAbUo2tHKK427ea0zars2GtCSOjGCKHb3
 BzWqCPQhuWWurpJYICyJSW9x3zIVTukLWietZJy36YhwuP/PlZAZIbLmHTMgauIXXna61LA5P6B
 N76iE6Fc5tnWatLfthHAEQGJ2obBFeRnPXYtJv5n44VbANxsY1szi8Efw09CVHDitN4292fP3jp
 FDdHy1qTO2YY06zUIeCgLikuNjroZPaafipxTN4K26M9xLTPXjiNSEmkSGrEEImbYPhYy+bmbv9
 dHtcalRVQ29U83hVjBPpJ9idANwWZsRFAX3I+DhH0rF6mFM7DcfsgBiqw3uTnMYIp8ghIR7FZhB
 FswqyOBgS8tgxi
X-Received: by 2002:a05:620a:4482:b0:93c:9e87:de76 with SMTP id
 af79cd13be357-93cb59f3445mr22566685a.10.1790784896536; 
 Wed, 30 Sep 2026 09:14:56 -0700 (PDT)
X-Received: by 2002:a05:620a:4482:b0:93c:9e87:de76 with SMTP id
 af79cd13be357-93cb59f3445mr22559285a.10.1790784895947; 
 Wed, 30 Sep 2026 09:14:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba42fbf20fsm86487e87.78.2026.09.30.09.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:14:54 -0700 (PDT)
Date: Wed, 30 Sep 2026 19:14:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xilin Wu <sophon@radxa.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 07/13] drm/msm/dp: Track validity of cached sink link
 capabilities
Message-ID: <mtw5s2bogogbbc7eyxoc44pslactrsa5h6wdqa54b4hldwrhqm@nzg4zillqtt3>
References: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
 <20260930-msm-dp-hdr10-v1-7-dbbf8b2b42bc@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-msm-dp-hdr10-v1-7-dbbf8b2b42bc@radxa.com>
X-Proofpoint-GUID: _EYCqvUTjAM_15CXkfHEDl7VkSfdsna5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2NCBTYWx0ZWRfX2JbEDURixnL8
 ytPQsLeYAub4L0ZND2Irk3z4FJKiK+uddiT6pWykLknWz9W34KAeFGJYn8yxHXoBoVGZLbAD5/h
 hvKHNVs6LJa+iwRWzQFtrZvxe3mmtwZjcA9jXtAgoQRgKPv9oX/7d9hRmytJLxuN0xhnjdYCjDx
 rUfLSnnoNqMnuZPryDqMPdd1Ilss5t+BZ7a7OIam0GlSrYGKCkq/KB+mayoCBgj07JP6WezahY4
 8WdioiZlmiYl37xNSHpd83zovksl3UV/yC3OYwgA2yAJjZUtd92h32Ij0xLZNWnL8ik6RK3fEUJ
 bQy7BCV4GjdDVrfnXnJHhIr/lXrclSz6xuG6HIzYlR+G9V6DmlsVMeDX56+E4lIYpKGnpcBJ8Kq
 U/evETYBk316wvsWQwYCKxjJ+ScLFNASXgQMKCj8BZ+fjSxzZurs2OGlilNT8+lvt8Mf4veyNxd
 9eqYKE7gaDiIeFrahuA==
X-Authority-Analysis: v=2.4 cv=MZn5KJ/f c=1 sm=1 tr=0 ts=6abd3581 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=ksxQWNrZAAAA:8
 a=mPiFDlsqJXRWNEHsy4sA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2NCBTYWx0ZWRfX3D318lzc+eed
 ULezqatim/NdhiAkb35WkHThywUGPpvkf2GIn054Z7FflrerFFuhKn0XOlsYcLMRHJkxRTuW4c4
 87vmhcJ6KoqcGBHa3alHEwWIJxKcYyc=
X-Proofpoint-ORIG-GUID: _EYCqvUTjAM_15CXkfHEDl7VkSfdsna5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300064
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

On Wed, Sep 30, 2026 at 08:41:51PM +0800, Xilin Wu wrote:
> An eDP panel may not have been powered up when its mode is checked, and a
> disconnected DP sink can leave cached link capabilities behind. The cached
> values alone do not distinguish either case from a current read.

Since eDP caps (hopefully) don't change, would it be better to cache
them on the first access?

> 
> Track whether link capability discovery completed successfully. Clear the
> flag before reading capabilities and on unplug, and set it only after the
> downstream information has been read successfully. Subsequent atomic
> checks can then defer checks against unknown capabilities until the sink
> is accessible.
> 
> Assisted-by: LLM
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 1 +
>  drivers/gpu/drm/msm/dp/dp_panel.c   | 3 +++
>  drivers/gpu/drm/msm/dp/dp_panel.h   | 1 +
>  3 files changed, 5 insertions(+)
> 

-- 
With best wishes
Dmitry
