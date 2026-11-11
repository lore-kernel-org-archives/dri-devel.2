Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5997606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gkqcOOJG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BLZHVTy6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5F4910E7BD;
	Wed, 11 Nov 2026 14:41:52 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6077F10F237
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:41:41 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABEJ6q3527413
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=8+OTqyFIZNj/ZWYD70+Pj87l
 VYrEXWlE6vL0wA6fPK8=; b=gkqcOOJGotekbX5HXwO4LsrSjuKCl2eipTR1QVn/
 IUnciLmv/akBpXvAMJa96jjJVWZfwxMRAwc71XXQKyGZIiGkfTjLh7+0tAhRt1di
 jk+WXfzHezA1lL4SHlRbkgbHdxjNf6REBRNrM2zP5D4JTjednuaW/mQwNCYKc9TM
 oMiit/f6uijQlKgsPymmf/EWPYv4OA6GnBwEEdvT8Dpd92C1iblOLiUr9pC78sO/
 ZlB2GKN/xW7yRUmIN/Vl9nIZ2St1vq++/BW5aS6FOF2O9V1pkTK99wbq5GChEK4G
 r4GZ972YegkzaPU3SbZIQ3kQoUnAlZ8btDCtr08Hb0u+Gg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvpjjs0g3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:41:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93caf7856ffso732789785a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 06:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794408100; x=1795012900;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8+OTqyFIZNj/ZWYD70+Pj87lVYrEXWlE6vL0wA6fPK8=;
 b=BLZHVTy6EeCDYYK18lMUAqh6lYNNhfJ8m9gZz/pX9jtEGmSty1pNohoNVSfm64n8QK
 ENk3+JbXOp+N/gQQ/3TstI+CnsQ2BKy+R8+XfKDf13iH5LWPgisbPrXrJdoA7m6lj0c9
 3soL/DZxoZUcsWfl9WYZ+4eqz4s1QJiaRWTeeH1HE0eFHbVIvDSFNiT3+3Ls7pOXMp2f
 5MNIPHYuVxs9Xl98LhcSd8HOXGC78FnGUQ5O8B4/tAVd+D0S2wgZCyAy29B95Uh+TQD6
 Cle4gHKJlhgJgjQSQTtcJ1n0qonVOFn+wEloiHc2Bks57t2k0Q8gX3H4ZLpI+vUqChrI
 7KUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794408100; x=1795012900;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8+OTqyFIZNj/ZWYD70+Pj87lVYrEXWlE6vL0wA6fPK8=;
 b=iWHD3TBBhYZyVa9Aurm++gRyvHPuiUy6+xVsV3CGan9tkhEtY7qLbG4QpXEu4awrf/
 nQmxXu29Srvwv5Rm+0tyxnr0Pi3Tm8Wdwvmi3u0VJ9o4CiDOZNL06FEzcBNgmpoBTlnr
 rj1IS+JK9S7AuezZLuQZK3h5hAYO7we9LThE47NaudWNv13rjbbEgELupyAMHtYOWHUw
 JEM5VZvQOAT1MyoG35FM75ZjX1PdK2VA7yxQrATNvwEUsvJqd1YaPdf9i+FxgCFZnTzA
 KtAIEoCnt/GHotANoE1lsX0efE06qU8Y6Z6mLIQ9Sa7TYrVSwH20cYt09Tad4GHo/HIy
 +qcg==
X-Forwarded-Encrypted: i=1;
 AL+hErGvb6yTIBPoRKZnwcq7y2geIbKndoJQZpfWpiuYY8Ol/q/Yrw6jXIeyEy4uckcfg41V6MtMy17HhHg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8E19JATd819RSa+QR95n+7FIhgHqERwNElks6cJWPsuWo1scWp
 sfPNoZFLSNuEhhfEDrovKWyMDSRKtBP/2KJDmFFbwPYdoaD3hZf8yrJYsy4J4iRFxH1BIwmf9qx
 zSpN9SWjqoSNjdj7iChdw6sMlrI5m4BmK/+LiaLcn7JE45RZIGhUmCZAqlwdS9IW+n+FGISQ=
X-Gm-Gg: AYBFou0G4AHuNrEsFDaZn8G+wTQcYl183Uk54DV4GxF+wWWY4gNj3sYj4qW0kGb04h4
 mLC/095Gp0LUrMc84bnn4AEjljzD9yK6rKxBEDQf54Tmnz2b2EP1M3/96wsbUK00sllUEFtsC0O
 LhV/U7iqQyL1I8G3vX7drs1piP2/5IAGlJhIejPSTfFEGC0nlQttSkHroGAny0ZOWiXEA0S9PgP
 SyZRL9aAVpKlwgQWbolXeJj+JesxCkuySTN+NE3HMp19NyXV03rObzNpL5oMzVPuu+xx4C/CAQD
 /PZTC2LaNoGNLlOexk9Dr00db12GMY9O5r8bvOstC2TmtM/+F885Nix2ISXe+49fmUTkRXlZRnc
 Fyc+DrVqPJMpNIRcCpdsnRKcckPQ10+QBzkLy8kD/YyCKg+ob4WVDyY9Yx+y2g2/iZWq9VyQQpT
 xaDorJw6SjJ5guT/HVkx2FHpYuP1uGiVWEDMbPvMGufxcnkM/mNBu1hx26snhPjw==
X-Received: by 2002:a05:620a:4544:b0:93c:9d56:a860 with SMTP id
 af79cd13be357-947affe689amr432826285a.19.1794408099517; 
 Wed, 11 Nov 2026 06:41:39 -0800 (PST)
X-Received: by 2002:a05:620a:4544:b0:93c:9d56:a860 with SMTP id
 af79cd13be357-947affe689amr432816385a.19.1794408098527; 
 Wed, 11 Nov 2026 06:41:38 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae0926c65fsm11020011fa.28.2026.11.11.06.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 06:41:37 -0800 (PST)
Date: Wed, 11 Nov 2026 16:41:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v8 02/29] drm/msm/dp: add support to send ACT packets for
 MST
Message-ID: <ebgbhztbeifcty7tlzwykvwcfrn3bwsktfyy63nu4ocvygnqnm@prggbz5tzmct>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
 <20261110-msm-dp-mst-v8-2-d040fb33db5f@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-msm-dp-mst-v8-2-d040fb33db5f@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1OCBTYWx0ZWRfX7Qo8lLkqQ8VA
 6WknHT2jVhH7RzqgjrW0ZPJ+3l7DGthPwFN5JBg9e7R80xv+xoPe6Tq1Y0jXA9Qjt0rrOF5y/Ku
 eHGpMOYSUTc1tqAt2d8/8xySQuqyNWa2uAY/KYFQmJRlIxdORP2nPF3PcdeVpqfV8MjfFi2XcVC
 V4hxSUCuUSnNVLcskynvf7VfBFW42vyLXl634/yE5Une7j3vogeZu2HL3ZrHNrEmvqtma96j1MV
 /7G+Pk3XNR9wi7c9mEQs8NGuSxO5tPnUAv77uiREYKBIcNdqavSoGGqu6ynRjCDGjIZRL20XJZc
 BFTIYXSf5UweZk14u1rPNbPfqiUfqjN9/n3KRcbxuo+ceaGAMzrm6vOPJeURyqqokRJWTVg8nxI
 DVR/iUJ0RBey15DmOrCNHDBImsG53y5WCCXeV1tfDf+3BPUb3n12cVCanr1VdhDDaU+F8NiIoYo
 OVaf2H893k2VaGK3URw==
X-Proofpoint-ORIG-GUID: ENEYmBjoHFljdtFvWMQcx9MQ4v5DMVsR
X-Authority-Analysis: v=2.4 cv=FeuiV5+6 c=1 sm=1 tr=0 ts=6af47ea4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=CXPGfuEPe1jOflqu_poA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ENEYmBjoHFljdtFvWMQcx9MQ4v5DMVsR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1OCBTYWx0ZWRfXyZGDTwZtxERq
 4ApNn5CsemKjdzD8kvqihNsxAf7lKm1Mfetv3zoH+XHNT5918G3HGYvPFj/IK7evPIeSuDJKaws
 h13h74IMBLpbYv0WC6lUEImHWq8E7Ow=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_03,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110058
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

On Tue, Nov 10, 2026 at 12:54:23PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Whenever virtual channel slot allocation changes, the DP
> source must send the action control trigger sequence to notify
> the sink about the same. This would be applicable during the
> start and stop of the pixel stream. Add the infrastructure
> to be able to send ACT packets for the DP controller when
> operating in MST mode.
> 
> Add REG_DP_MST_ACT, the ACT trigger register used by this sequence.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 44 ++++++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  5 ++++-
>  drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
>  drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>  drivers/gpu/drm/msm/dp/dp_reg.h     |  1 +
>  5 files changed, 51 insertions(+), 3 deletions(-)
> 

Is Sashiko comment valid? Otherwise LGTM.

-- 
With best wishes
Dmitry
