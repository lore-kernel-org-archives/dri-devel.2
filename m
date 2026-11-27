Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7492E606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=THB1VHR3;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BAkXParC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3E8E112DAE;
	Fri, 27 Nov 2026 20:19:29 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8141C112D88
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:19:18 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJB1WR1127964
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=pX3DK9XlkkOLl7dfdN2RnxYO
 IXZktAtin1GQHKKihSQ=; b=THB1VHR3BPbeTrE5jcBfGHagd0b7D30Cflz1I6AG
 +Xe/JSSEkdoyMtgBSzh62/PMtS3OFRkd3S6nEtlkCE1GppafxgMlC55IctQDwFJS
 0ZnsQcbbq6ap6cMPusM7xr39wlUxQSqx3O3oTHtWM4ViLjy25/5AEjaNVp56XXNR
 fzddVCajG/9ZR2LNhXPiqn+iupBAqhs2VVEMhNcYNA+s2+bfWTtYbfTmoUjjFhBu
 s3aX4VmWrtbacNX9fAt5BHCm/BRCYLTAHNEGzyur6mtvDLrX7FghU0AjceNhljgB
 0tONtfEsHV8136UnDDrAwaEQebEU6+oaI+cZd5ZiD8xE+A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74g6tuf3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:19:17 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-94960bd17b5so1304943785a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795810757; x=1796415557;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pX3DK9XlkkOLl7dfdN2RnxYOIXZktAtin1GQHKKihSQ=;
 b=BAkXParC8DXu9f5B/XcMG9ufsmhEm0D/OzX5gbTQK6ev7t11bxN7WYWzmAtzZbK2BF
 jIPqcSx6PmMJ4KMWclk1rWhbVWAP+PEcRSxxepYMbT6X5ofbPKMQncVFReMzxhZoPmRu
 t8McCMJKUbf0p+E+jYs2Ze2TlkRlxrRhKIxHSrLF1Lb4/Z14gRnDCDlOk+spCJy0Scet
 seT+ZX7wHZYyJJkRseLx2WCsKgB56UkWKyzWS/QjNafJUuIxK96suxivBub1EWYrR9Ab
 TTud1xUPzALibLuPrshXcCs9J76uU+s46JZIDRgCqE/Cl3+TJJh2FWxO9jd5XNAu1IXe
 3g/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795810757; x=1796415557;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pX3DK9XlkkOLl7dfdN2RnxYOIXZktAtin1GQHKKihSQ=;
 b=a7lJv+oQZsHHBfdcwbo14rLdTeuePOFbo5r5L2xyy38Wai6qlTIF+USwePO0ezM+WP
 hACxfmSLWNa6XwPkjyhRRu69VZjvjEZE57pcTXV78irEldqOyyoGJGCUQgLedsno9yYe
 cYYKmdTWV4YnPqXLyFLBQoEKth6aVQYezRn/3pT9aCAhjjwkIH8jmK1fqqUneJFPGi9o
 3LSj7ErBAU9/xOCuDZ3igndD73+ntGr1+rwAKjstX0K3PWxKn1eNolf5SIwTst6gr3qe
 ccb0idj22rtlTEgjj0DML9IZcFRf7LfrKedt4aq8DWleAIdQIYbzRLrAYz6PAMl6y4J0
 bMhw==
X-Forwarded-Encrypted: i=1;
 AL+hErFna6gO+U72P0skzFaDHQPusXELScBvFi6W1uMH62VOxvFTTWShFoYCB1EZ+ljmG0Z30BHpyvo25Fc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/8ENUfNkkOP3YAw0yGEqGbJFpmIQ9BRzYJW1NKdOTGlkCOxvDx
 lIm3kMUKXOSSeW6GI8IaPhl2m0PltUOSsq80mz2lLV78ZL6kNtIYbNa0C3fRPz9yS3MDuXW7rYr
 bjvzup9de5svUzvUv+ySdpBcyP4OC2F9QzdFnTEX9zwoKi0yV71kMvgdnpZyobVq3VKOmxHA=
X-Gm-Gg: AZFdTZfdxQsle0AyxvzbmwwcxNIpq3by1CpjSAUcA+gmfMhLoIa7/Xk6IUY4VKGVkgt
 G3eiPFSmpqu+4+OAMVTyvS1bEGb08W35e/gBuHj7DJ9HgCfEfuGiLzRRQ5SidrjgxSEKt4ZQ1JX
 kXmX5KXSTRvYJedLlRTI/JzZfjzNfWdSbf4L/O7Q2R+sreSmUrtapqedkQdGRbZHT2LDBQsvjUQ
 UYSJeDXU2hHuFbdbkd3k8X0c7TKhi61KoGAEenXDGgpVQxw9YmDq6Dah4GhslKG5bLPfAEXTda+
 mdYLk9NoN0i55lyTeAtwEFhdwRYsvWXWrAiNTuug+9Fu8hAP5wrnqU8ektFyFLGWNYc15jlCdEu
 32Ig7U7ZgSYBsbgUBmolQJR9YyueceQnN/EBChSTXlFEqhthmRAaEZbgyCST0dKOercsixJiznf
 ONS6weE2mUeiY3JXiRc9Fpqb6wrz5NG5XNnDMpSIVl7BOqK+A/VHuDDNyi+93Stg==
X-Received: by 2002:a05:620a:6886:b0:947:7f5e:2b63 with SMTP id
 af79cd13be357-949ba99a9demr4473187785a.34.1795810756935; 
 Fri, 27 Nov 2026 12:19:16 -0800 (PST)
X-Received: by 2002:a05:620a:6886:b0:947:7f5e:2b63 with SMTP id
 af79cd13be357-949ba99a9demr4473183485a.34.1795810756453; 
 Fri, 27 Nov 2026 12:19:16 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae8044e00dsm69635371fa.3.2026.11.27.12.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 12:19:15 -0800 (PST)
Date: Fri, 27 Nov 2026 22:19:13 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jesse Casco <jesse.casco@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jim Martin <jimmartin@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/msm/dp: carry the eDP rate-set selection into
 the link parameters
Message-ID: <yr77nbiqgbo5mttqzzqzhwj5boxhnd2snov7zechfcsequ5tva@7wow2ms2qkha>
References: <20261120192050.73315-1-jesse.casco@gmail.com>
 <20261120192050.73315-2-jesse.casco@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120192050.73315-2-jesse.casco@gmail.com>
X-Proofpoint-ORIG-GUID: EgR9JoqAHgVyPdIEcKn5miLZ084r_D-k
X-Authority-Analysis: v=2.4 cv=U5kHnuru c=1 sm=1 tr=0 ts=6b09e5c5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=OcNzFT8OvP80C1WdMtgA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4MCBTYWx0ZWRfX7Tk7Mm0YB21o
 k4t9R9iW9zYG7QsUqI9vudAWlLTbIPcBCMyg/uaA0k7mY4Zutf9miEiCoYO1ZXn6EDtiM4+EWDr
 i/mC18HCwmWL+l6Nc7HrbZMIylXA0hk=
X-Proofpoint-GUID: EgR9JoqAHgVyPdIEcKn5miLZ084r_D-k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4MCBTYWx0ZWRfX6ee+Kss0Ss9q
 Wl3A5o77Em1nwmtf+VbLboG7gEWDe0oBJqGhmnhAMBoS3A/Q10geJ/PJUyJKAmPxfc/NtBx2MVh
 3pMy/fv3o93gdfsVZ16MQy9dgBnz1m/I0bO6NZzkHMOzDZUclf+knIC8Z1o1+NsxrA8NV7b1KIq
 w1qHJoFpiW7wV4rEgLPxQNZz1tURoGsB1IAwP/LF2+m+yirzlTs72gxEZAOlMn/zhRDQitXekYi
 +WY2F/zl65POVdbyDgKSe/oNmQ0GusDpfBcf8i1/OZQusUCWaacsLvh5UdQAa+jXbWAPyWG0FqV
 UowDfGz6QEdVwFpvKhepJgXp6RsNdoiwvLv611lnZCVP4ZJpE+d0mxxxYN9rpgxRTlyNARfqFG7
 x2USt7F+tQzmPTpYPIKfR92M45WKXcQC0e8DURNYT6+Cv43CVAGz/2mN+isVTbRVhM0awoV7OJ1
 1m4rln+IaqwlTk33xgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270080
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

On Fri, Nov 20, 2026 at 02:20:49PM -0500, Jesse Casco wrote:
> msm_dp_panel_read_link_caps() picks an eDP 1.4 LINK_RATE_SET index and
> fills panel->link_info.rate_set, use_rate_set and supported_rates, but
> msm_dp_ctrl_on_link() only copies rate and num_lanes into
> ctrl->link->link_params. Link training builds its msm_dp_link_info from
> link_params, so use_rate_set is always false there and
> msm_dp_aux_link_configure() never writes LINK_RATE_SET. The rate-set
> branch of msm_dp_ctrl_link_rate_down_shift() is unreachable for the
> same reason.
> 
> Copy the rate-set fields along with the rate, pass them to
> msm_dp_aux_link_configure(), and restore rate_set together with the
> rate when falling back to fewer lanes.
> 
> Fixes: ed100aa239be ("drm/msm/dp: Enable support for eDP v1.4+ link rates table")
> Signed-off-by: Jesse Casco <jesse.casco@gmail.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
