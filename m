Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3381606A331
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 20:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kaPwNDLP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=finWIGqq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 085ED112009;
	Wed, 18 Nov 2026 20:23:06 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77983112009
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 20:22:54 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AIJM4u72732945
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 20:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=hoK2xbseLTh4OhPRbFIj6Mws
 srqKcQWeYmF4tQfdihw=; b=kaPwNDLPYUD+g4X5/1zBy0pInHs/A4pMFq8vSiNq
 S6XhA71bUvcv+BbIwpEHARbDQiMSQIj2Z1AIc2mWFkIPNQO0mJN8HBO5ZkdPe2N/
 rKwIdLKNvAOvqoW1iUWKm4tCxLi6Wyi+i34qSmKsAMq9e35bG343wc8aICAuXn23
 EK5e/c14RCXoOW+bFF1MecPHT6etI8JBMrmZeYvmgxnOLv/J1f9pPl6FuV5MjqOw
 NPpvjYFpHv8SBxuYcHat6VNq/pf8Zavi6TxiiAkMAzHawZKUDCURXxMFxXHZd7YE
 stY9IAGTaV+9Xyj90pgbSQPYMITPdozkdFDMEYBS3h8XmQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1g3b8uen-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 20:22:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-94970ad532bso240759985a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795033373; x=1795638173;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hoK2xbseLTh4OhPRbFIj6MwssrqKcQWeYmF4tQfdihw=;
 b=finWIGqqePpY7k1lcf2ET57WMKvM3O4sQsWMg2Og1phq1+ag3DJM1G5NR+KsRwr3sM
 O5RFYkFIp5Qxog9McysilV9kM2U0F6xDxuFEfLXo2ZyuQRq3BOcVCxFC+9v+3SJWnt3n
 S8Cok1Ctti0pFZLleM81T1cxO8G+swiAqrA/U6HEqqFXWzxxrlpfcWjMEyAL7nVjvjj7
 CNytfFoVOmMaP/2RQiyFnbvQl9YDj33qCaMqSe8Nsm77lm3A/X1b3+Y83Qb7Llbj8hQX
 VgW65TaoX5q5Lha+POoDp9TrcDwvhmTfpfOvZloSFqQgeLY+r6e2KGS2ie7qyN3EBKsn
 uULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795033373; x=1795638173;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hoK2xbseLTh4OhPRbFIj6MwssrqKcQWeYmF4tQfdihw=;
 b=gkPvV3f+9GU97g2+SDxM/hATt2rYZY87ZRnDYTKU1C8iPB3EFap3QnigDCOZqhom1v
 EpcD1niPZik8cUOD8izhyXH3XvuACphcXqyLsQAoe1YXV2mnj6KuMMuq0nexgDJIh8Zz
 kG+WMLTjZO2k7h3B2qpQg9veIDEHTa5fe7gkpqJvnmt3NFTiNj05Aj32ACj9TAfEF4mx
 rwXUIEhamVH9E1nOB3+tHbwFaQhUGDScw16VBwIosjkmPRKj1MjjGG67S6+BUE2TFY/6
 OdfSH6y4ZC+1wSOfEOu4/h0Bvo18ijlvoPdI1WS945MVQ+62NSbpuPpPurOU4RHOkbSh
 L+3Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFY+JJlUhh4iVzhi9IHIE+3BMNA9W+jbtUjjSbgR+wQekK4HUD1pV8bAXGWos3bgHe1YRgIYpe3yc4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+xrNdtZ5TPUHIHtW0AiNeVQxdvS245hFHKVcUXaeGIvrb4iLPK
 jy1w851UBqGOePtuDFcm/TLbXG9+QoG4jhBfugylHCbpnfvDdaGb1Zz/7ycFJsB6YGg+1yfVvUR
 lkxEW66yJk/z62K88O6obWyAsWlgrSQdB1Vgtk+iLDB0PTkt44U29TK7ZrEQry+2nPyONh/8=
X-Gm-Gg: AYBFou3CJKLWfTcWcLzlrEbfZK9gD154c/IGusTbNP9AHOVS+pAW5jq0TrEHiXyl4zD
 AS9qks/4QUMxU3yTS5/wg86YWIu4oSefKpU2TeJSe7xuKWjSG8a/XiV6TZBnYp7z+Wn/eU88cWJ
 UqMUDWqk07048d+45XeqycdXx+Kpq1l7QLRJaHxOgHbZti4fyKz6xsvZ98pVSmglydPQtpD2Lpi
 +hHKZP++QMhFxvRuHCmPRlfXBULNoyBTq/n1ZoKP1VE9OUTn94h3Yv/5B5/7Nke90tFISrGxWf8
 IzFtilKEzgNElGQMxYGdjKYU9yLhFd64S/UH7U5DyqcxXKl6jIPncjj79JyHOrg1vrH71ogx7ry
 q2sCnslP3Pvx7SEbXtWJmaGDXC94ipH0IpUv3lizADxSgn19X0TYi7oq5+SNlkjko1ywybKTbzV
 PDHu/U4yeQFHqo1Aj1VWW673FD+tH9pcd33B2dcIg34aFaFXkK4fE9jmNo5aaReQ==
X-Received: by 2002:a05:620a:270d:b0:949:7bb1:ac62 with SMTP id
 af79cd13be357-9499965a4c3mr611765185a.25.1795033372746; 
 Wed, 18 Nov 2026 12:22:52 -0800 (PST)
X-Received: by 2002:a05:620a:270d:b0:949:7bb1:ac62 with SMTP id
 af79cd13be357-9499965a4c3mr611762285a.25.1795033372290; 
 Wed, 18 Nov 2026 12:22:52 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae6ebe874bsm2924491fa.34.2026.11.18.12.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 12:22:51 -0800 (PST)
Date: Wed, 18 Nov 2026 22:22:48 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Erik Tagirov <erik@tagirov.ch>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC] drm/msm/dpu: set possible_crtcs on cursor planes
Message-ID: <7jyydebmplngfnie7sfidwkeomi4xrgaytey6522q7qqsybg47@obppph6ea4ta>
References: <av4OfY5sML97l2F_@oasis>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <av4OfY5sML97l2F_@oasis>
X-Proofpoint-ORIG-GUID: 47K_ee3hWCWY8Ot5iJC6Se7SDL3D_OHD
X-Proofpoint-GUID: 47K_ee3hWCWY8Ot5iJC6Se7SDL3D_OHD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA3NyBTYWx0ZWRfX1N1hikyZ4wRQ
 zYDvmcbdSFZNPxphQ/e6Dj8YLr2xzI66jjB/Z/b3fUX2P1Y22BpuZLYnT+1qAfrI6GB/b3H0Rx2
 Oh4mVyoQKhXdBtaRG6/bXckt/t331fo=
X-Authority-Analysis: v=2.4 cv=dZQVTnXe c=1 sm=1 tr=0 ts=6afe091d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=lh5ckT7KmLwKjNu5S8MA:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA3NyBTYWx0ZWRfXw/sfTHM7sRTO
 qpEOZcT2U0tU1Hmr/0QOD16HQEvhq6NgyeHFk24CSQw5Mfaj8zzFk6yk4Lpy7o+IHrmIa8bZw3+
 5+fw9T6U8Ig1rhaICKlUgy6ghdxdr9kUqcNQnJwq/E5VWZIxeu3BR90sfnPEo+n1JBpBnTIieGv
 2wjrLZvvXJo/ArhODcoq2Y9Ro2MGwrMv0sNPEUnqBh6QxqlGQaXzUb9GUvSkXV/sHK6ZuHjxxYG
 BvPeQanO+Ng9D5I7/2/LZcFrycJYLv0q4JPuCmz/XWvAairKHBCXMlxD567ZA/m5tj7smYjSfT1
 TnMbzrxbr5r0DTghO2OlUexjxxjUmjy/WqexLB1gIsMyQ4I8znSz3BTB5ROIsBatJMDu5L1uEbI
 pTISz526R8tEpw3o1B+GHXiW6Vozj+DjWTogcQ9LKy3m896mB04Jgd3PA0s1Y+paP/dGAM4QVHk
 ZWUT3QEoMC35aeei2bQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180077
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 09:47:42PM +0100, Erik Tagirov wrote:
> I am using a lesser known wayland compositor that uses the possible_crtcs field of a plane to detect
> which one to use for the cursor. On the Lenovo T14s two cursor planes are created, each with possible_crtcs set
> to 0xff. Which from my understanding means that they can be used with any crtc.
> 
> However, the compositor picks the wrong cursor plane which results in a lag of ~17ms
> on each DRM_IOCTL_MODE_SETPLANE call. Making the cursor movements sluggish.
> 
> After some investigation, I found out that this is due to the legacy_cursor_update flag not being set
> in drm_atomic_helper_update_plane() which has an impact in msm_atomic_commit_tail() where the fallback branch
> is taken.
> 
> The lag is solved with the patch below.
> 
> Best regards
> - Erik Tagirov
> 
> The cursor plane must be used with the correct crtc to ensure an
> asynchronous commit
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index da3556eb6ecc..4e0e9c2d8062 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -877,6 +877,9 @@ static int _dpu_kms_drm_obj_init(struct dpu_kms *dpu_kms)
>  			ret = PTR_ERR(crtc);
>  			return ret;
>  		}
> +		/* Ensure that cursor planes are commited asynchronously */
> +		if (cursor_planes[i])
> +			cursor_planes[i]->possible_crtcs = drm_crtc_mask(crtc);

Here you are setting that the plane can only be used on a particular
CRTC. This is not true for these planes (even being cursor, it still can
be used on all the CRTCs).

>  	}
>  
>  	/* All CRTCs are compatible with all encoders */
> -- 
> 2.49.0
> 

-- 
With best wishes
Dmitry
