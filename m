Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80BF606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hy6MTmRb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V4RyF8Fe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 189F710FCF6;
	Wed, 11 Nov 2026 17:16:27 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F56C10FCFD
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:16:16 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABF04AW1665502
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Th56ue+92RWSYswc5X7s/HSv
 9lUd6z9Xku8GEtzh0/E=; b=Hy6MTmRbd8McWpfq/m56Uk8aIITPw4xR9+PTzOzo
 RQZDAT7vBRTF3ZIO87q7lj8P486dcCfMhPiSGO4ClB2JCxoBsVqLgIIX/8kt6OGd
 i54YuCzNcqKFiKNiKdTWpx7i7yWhTPjUvC+2kci/5/K/FXiBxrg+mHMuanHnvmVQ
 iOiX6D4W9fMXZy8h+v4BeS/Barz2fn9hK/3C8/xQ3c2F/1j3UvHeV6IzyRyUcC6z
 fWuufxZRR8P9on/Bh25Tn8miq+dG94/JkCW9FjXbzDvzPDTvBx2JxX7vXwrHBmA1
 2TtSOfVvB4WJgGBLskqnUROmv5IKlPQEtSWjlmMkNne+jQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvk7ptcwb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:16:15 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5ece5510b79so2957466e0c.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794417374; x=1795022174;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Th56ue+92RWSYswc5X7s/HSv9lUd6z9Xku8GEtzh0/E=;
 b=V4RyF8FeHbsldhYjNGT/xk7w8D+9JiUNdzh+PvBRoSam8b3lXKIT31YINgGDZ8R8EY
 80ZyHxq0aa9NFf7GnHglDRt4X8dc3/ZtNc23Eo8kRWBVLNv/Oh5YfSBqwAs2AMH5/f2n
 SwzF8lZ33gBLdXvy8Q/DBalOu8FyVdec4VKktyaxJIRflmQEFX7Yrq1ZhkbogNwBXxmY
 RnX09Wt8hiniXvgNnLJnMaHOTqbDonaJ3/hRQN0GPHnHGQsFTAKHAF9jJSpwV7A3goyR
 vUeFeINaB88mox9jXFtSrISex6rTuekEwIGoTQtPNZOP7z1u9PGkghije8dInl8LXQEB
 WRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794417374; x=1795022174;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Th56ue+92RWSYswc5X7s/HSv9lUd6z9Xku8GEtzh0/E=;
 b=Z1CcZmTlZeiw2yLp9IJZtsv1cVQEhWYMQKq2sVQ21cN3EKSOsz/anWtZovdQZJRSBK
 DRlvVE2svtPxZPR0yOE00gK3KFnlekr2Gm1sjh6U1LVmvuM60LoC9cVt+mTXHFRyWw3E
 jB1IbH4IlBcQ1bEAYCV1Ia44kBG4/8Hp3Z0rvXY1dy9HIv4r8PqGZ03ohXioXNwNBWqJ
 9vZvs5domKe1pI4tsqAet0lcyRu1mZWRQ7nSzBSLEJ8IyY0XDh5INEyNtU4fYozUCfBd
 JoJgUwpm3YbCk1+u4QAjZdcwOpX9nQrz9pOHaktfl1d/564hdEP1aAUp73cBe+uV4ZUb
 YAWg==
X-Forwarded-Encrypted: i=1;
 AL+hErEL+TARkqH+jM5VwlIj6hZwcApjqzQaYX05TLLll/mrmKq1tI5BPAnyMSgjmLL0+PitUUYU3+7kqAw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/OSWwg6UzeH6wpUC709iHx8vWkmVpReoI1aVuMxyGg2CkdtmL5
 Szjaz5jDS83MubOyhiSABG9f9N1+oTelanTFdazKuLCz2vB6UOkH1kIPKOwkdy5geaF4nQrzfuB
 Ccn5/ZooJdUPF8/uWEGHyymZqA6V2ss5u2JBvLz67MvLdDkh0fj8l6M3umwXw0RhL52ebcuI=
X-Gm-Gg: AYBFou3DoFj4o84cJFIF93A7Ma2QrxglEAXI/W/padE49sXNxsGjTibGPzz0LcTPoVy
 0dMhLK+WwzHlFbsTk62VzFzMTKssz81E9DJ/0gX/hQbFnJ+vEGaeOI8lOgNFGvtc9zDRMgXOUzl
 5FsHR9nO51E9EZyHQF4U+Wmwf9BZm3Sv/vsLv2aiGDte5xo9qY3NnmxiA62LFPOxLbFpDw0oKA1
 Nl98J7b43V4ZqCg7NvJHYYTuS2b4c1fS+IEvqYOGxPvtPJBJEf7yy/2ZLyHqXPjp+8hC4r8inYH
 1v7tnegMoRw/jK4Zs/3F+hTKoD0zwyVhizGWgcW4wFRnB+1YpVISn5KhsUWX0cacbFZdowd29Kg
 FmuuwNZgYT8y+J+9HcVzvlNcGznY2PQWD0+mD61IarbOa/xG0XnPqERLxDEjDj4ATVGh/ePbasl
 s8Aky3Vw+sMVSoBOKH8kFL0JG9ZTbRrMg7KDUXoHTV0VGekGC4d9av55tEzUFvXA==
X-Received: by 2002:a05:6122:3287:b0:5ea:9a2c:27a8 with SMTP id
 71dfb90a1353d-5ee1c43413fmr1408283e0c.14.1794417374495; 
 Wed, 11 Nov 2026 09:16:14 -0800 (PST)
X-Received: by 2002:a05:6122:3287:b0:5ea:9a2c:27a8 with SMTP id
 71dfb90a1353d-5ee1c43413fmr1408223e0c.14.1794417374012; 
 Wed, 11 Nov 2026 09:16:14 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c157ba56d5sm1031489e87.23.2026.11.11.09.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 09:16:12 -0800 (PST)
Date: Wed, 11 Nov 2026 19:16:11 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Joonhoe Kim <26rote@gmail.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, yongxing.mou@oss.qualcomm.com,
 val@packett.cool, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/msm/dp: hold one runtime PM reference per plugged
 state
Message-ID: <oidwbklgq7mqjyvd5n3irj7uxarxhke4fdpmipp3kwx7uqo5qa@7t4pal4q7wki>
References: <20261024051952.2006-1-26rote@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261024051952.2006-1-26rote@gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2OCBTYWx0ZWRfX1JSx4mWqNd+L
 QtsnorGVK+13V2HI6kQnvqupbFDzO9lv5/t3rZFwbwh7TrOehys5jvXpfD81S2inVG0mAHOoYmb
 65uJHJG4NatY3jRYQ0dY5eT+q2wDHn0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2OCBTYWx0ZWRfX2Dw2MaswVJ4r
 WQZdsreBk4XnJOGuZFRK+U/2VNpJAp35RVYFa/9Nsym6hRjZ4kqyQ+K6b85tnLDAN7GX3UOpGnC
 womqoOci93OHpp+7m1pF3cJ4OMHCTSoufVCHfilqN9TEKqKkrp4xvT+j5t2m5OCeSksIS87nkLn
 R8WfBX+uJo6gDcMsBjv/EY6FWXwu22HKVwbgU5Q+QvsmQWx7Q1EFMyR5kznKQE9eTUNSUA6UkcX
 JerI7H3rMO+jqrQZCvKoOPWYqj9Evdt/Dm97NRNECcRXJRcImTjGRD2my0Ax/8Rk8DwzlW1IJSH
 9BNB1Xx9mYhoZ5Mt8DWwQFEIkMlh9gxcbA82RVUzjKXN8aumOS2GugXIIWaR7i/fXJNrtzqHKmT
 sSxDSrCXFjmwXaNljTa3zBgtgve6k0SiDvW/lvFggWKlHEiTGssqt/6p4L4pjuYTfgzgrJP5/kv
 70Yr1kUHX8KzqH72pKQ==
X-Proofpoint-GUID: LR0WJsFYq2EvckX_MUPHvXj-UkWVEYW2
X-Proofpoint-ORIG-GUID: LR0WJsFYq2EvckX_MUPHvXj-UkWVEYW2
X-Authority-Analysis: v=2.4 cv=BpcIUoX5 c=1 sm=1 tr=0 ts=6af4a2df cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=2vbH5c1cT-B6TzbzCmYA:9 a=CjuIK1q_8ugA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110068
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

On Sat, Oct 24, 2026 at 02:19:52PM +0900, Joonhoe Kim wrote:
> msm_dp_bridge_detect() takes a runtime PM reference and keeps it when
> it leaves the sink plugged, so that the plugged state keeps the
> controller on. If the sink was plugged already, the plugged state holds
> a reference, and the new one is leaked. If the sink was plugged and
> detect() finds it gone, it drops only its own reference and clears the
> plugged state, so the unplug handler skips the put and the plugged
> state's reference is leaked as well.
> 
> detect() runs on every probe of the connector. When HPD comes from a
> later bridge, such as a USB-C connector, nothing else keeps the
> controller on, and the leaked references keep it and the MDSS core GDSC
> powered after the display is unplugged.
> 
> Hold the function's own reference for the duration of the call, take
> the plugged state's reference when detect() sets the plugged state and
> drop it when detect() clears it.
> 
> Fixes: 3ea2d1c3d154 ("drm/msm/dp: turn link_ready into plugged")
> Signed-off-by: Joonhoe Kim <26rote@gmail.com>
> ---
> Depends on patch 6/9 of the IRQ_HPD series v8 [1], which stops the
> plug handler from taking extra references; only detect() is left here.
> Dmitry, feel free to fold this into that series if you prefer.
> 
> Tested on v7.3 with 6/9 of [1] and this patch on a Lenovo Y700 Gen 5
> (TB323FU) with a USB-C display: booting with the display connected,
> plug, unplug, quick replug and s2idle. The controller suspends after
> unplug.
> 
> Changes in v3:
> - Rebase on [1] and drop the plug handler part
> - Hold detect()'s own reference with PM_RUNTIME_ACQUIRE_IF_ENABLED()
>   and take or drop the plugged state's reference only when detect()
>   changes the plugged state [Val]
> - detect() now drops its last reference with pm_runtime_put() instead
>   of pm_runtime_put_sync()
> - Link to v2: https://lore.kernel.org/all/20261007155848.106-1-26rote@gmail.com/
> 
> [1] https://lore.kernel.org/all/20261024-hpd-irq-events-v8-0-6ee949e7a384@oss.qualcomm.com/
> 
>  drivers/gpu/drm/msm/dp/dp_display.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
