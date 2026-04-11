Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9317DF3ED5B
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 17:33:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 935E710E14E;
	Sat, 11 Apr 2026 17:33:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lYYlS5lf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j4aYU0ny";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67C2410E1FE
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:33:06 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B4TwjT3679665
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=7DahCnk19xtw/u9xAJUqbYe0
 2Y+jNxBzIhH9lPu8qaY=; b=lYYlS5lfXcSEYenbjqSgaAmOG4oF2HlgZPtPl51P
 tiw+FIqup3mcZa6kBwGTvFo/xV9StWbOIH160BJk3vO/cF73niWm4C/MT0K5y4au
 Arn3BKn2PMy973IvD6bvrPmmr1FHMsi9cZB4hR5BzwRMvB30T1GHk+ZD4GAbDQKW
 F/kQCyKA8JwPTss6H640eVLHkok59VCJUYr5N7DSCaGMUkZFSm9aXBZT++EireqB
 SOFJEEZsTlTldWauFsV0qcpahNdnui3SAdd8QXbhIKOx0SgEAKLi3+ivUsG3Dgz1
 66WI3FVSbGce1DyAztDxGuNFNvq/f7zTKtlkIWmwjgkkDw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dffb0h30m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:33:05 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b52a2d70cso13164751cf.3
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 10:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775928785; x=1776533585;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7DahCnk19xtw/u9xAJUqbYe02Y+jNxBzIhH9lPu8qaY=;
 b=j4aYU0nyoIqN/D0sCf0W48H7xkjnfmqK4HPRQKUCuKFji0GM7iwoHTHu2mzRTbjzZN
 cspv6XfwAKQ2JrNWhTkFreVIwtVTtKgEpK5DhLkksZuwcrMnRo4ivm46EwI/BL0HS/iO
 Hb5N+6RiDpEcozL6ySBulmqm25/xLC+y/IbJdpir1a3UkfU0TyIxvMmVcnh0+L1doU1J
 7AgvLIXxdbasir5djjw9HHReiIPnvKh8rM3tjkYHNB/3WF/vmZ0rdGFBqzlLWiIR1H9j
 OOsxbVvnFDG2oqZYjUpVQbPOuT8UMEhxMcQA9jZqctrVqCpG8h6OcTTKgwFc/gyN5/yj
 cBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775928785; x=1776533585;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7DahCnk19xtw/u9xAJUqbYe02Y+jNxBzIhH9lPu8qaY=;
 b=lZoKndbMrdpxq6eRLlMwx49q8trwfQq35u0WpCmvuvQONAmkrtrzft8Vt4swp2lt8M
 B6eNj9r5WKQcG7SOp9L6tZHb4kqa9INTLRK682aTMwWAcCS1PGBTuvAiHJln5sygZ1Zx
 XrLQUpx3Fjpl2qA6bmhpTBkyDw/o3/XUUdFPgRcfX3XeX7ZJrwtB69D8y9DH8zS+rt1a
 cLTVbjKRYWtF9wj6y4GFr0GwEYSQNEwTb2aqXvY3LxUZq4nKWBY/QI3VRtoIlMVI4AuK
 /i/aLoH98T9zUrwEEf8Sa+i6o6Sm//sSQ9tbA7FYLXRkXmTUXu+QBaF6tfL+0hzUsfUd
 chPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMPECL6RlVRNY8LyxBnvpg71AWbOO6thJ/bbxiflw36r28SsF9A/hl7iypbXYwAxlrhBomdo/fh2s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGpWAkdYj+LzF4cq3V0kKZt0kc8+bXCnxR3qSQszTsMxa0z1LR
 7ysMfBRzsbQg7elyX6+Q6h/fCgG3HIcAoN7enumoFN3q+r+S+DJh3/aF/C1MFuQx9SYWpZMGCQg
 Y0BxOmYqU7KY2ymc8OqQKvywKyASm8+58jPt6YNLgzS1umWIdaviM6ZKeH6TN7whxSjJun5Q=
X-Gm-Gg: AeBDiesJY/rT07cFibI8j4YuXadH2zSxwjF+yk+XPyMj79R6U6aTUqP8IA0tC0lNjwp
 PACRAcB1Wxp2nU7nfakLpOUHobGVwclDNCMshgJOv3iEJJZnJHJzSYQhZasPS3LEWUPdaBv3shf
 ysqBfpaj30mEjOnLvSs6J3ZDbtmijIjn4DceLBeQVVPIZ71KPWRiICp/qL9P2XUakOvvcm8+VXV
 7Mcc1GSMyZ6w88kd3E/NTlFx9xGftdAkzLjan0IsMpgqcxyMrrey2OJ0cJTiN1Evkv2qElAxomI
 6kqGZAnLHT9yUoLUMXh1QevQpQTN0GvMTlWuuTLmOwckqw1T1TIwup49O78sdmri5xdWioxL92V
 GMvlkHc4gztrnQ8A2aDDNIswvW4DmMVwR+sx1aGZq+S3RnIBr2y9pGVoE8f8ggR2Sda816qG1dS
 aLde7+MwWhi1cidgDeNy9MWUVFlvXcjZF/G4w=
X-Received: by 2002:a05:622a:241:b0:50d:857d:7ad5 with SMTP id
 d75a77b69052e-50dd5c4345emr120722891cf.59.1775928784578; 
 Sat, 11 Apr 2026 10:33:04 -0700 (PDT)
X-Received: by 2002:a05:622a:241:b0:50d:857d:7ad5 with SMTP id
 d75a77b69052e-50dd5c4345emr120722201cf.59.1775928784064; 
 Sat, 11 Apr 2026 10:33:04 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eeee1253sm1536396e87.39.2026.04.11.10.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 10:33:02 -0700 (PDT)
Date: Sat, 11 Apr 2026 20:33:00 +0300
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
Subject: Re: [PATCH v4 03/39] drm/msm/dp: break up dp_display_enable into two
 parts
Message-ID: <xno7ng57gpsgakop3ftpzcytdcxgkg4ik5u6t4bvok5a3zdngk@qcsth4ves4nd>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-3-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-3-b20518dea8de@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=YfmNIQRf c=1 sm=1 tr=0 ts=69da85d1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=TcIZSSvsLDlm5hOJxbQA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDE1NCBTYWx0ZWRfXzXzCQ6NPbe1S
 SASO1EmMPRnrfieLx2CRZ/VL7CZ4nizybBQsJ4+FFwVdkNumLrJvqaoNRntS/rQZ8UBWLBmLuiE
 oY0B4teCV3O63nErFZN21kw3pRzfOsd79YuuV529Lx9REuhtof0Y8pbe65VC3bst74C4/xVrfGn
 +4HtzOWlNe9AiXQqyUDI+Ax1RpjSgcjBLV2KQDue+Bwj1JFt5trDU0eDhpSTesdXUh00WyC/ZV6
 AXBKc3zxXOKB9RZgi/XikzOsAu4WYdbs1kM40mL+RdhY8awJrtFOgx++1wXTdCgoEJBKz/wPOrZ
 R5hMO7f9V5VFqF2UDJjwlMtNFxp8l62kuOvuEMXVAeGabIxg3eLwy2cUKqT6PGPS/oQByYi+6U8
 yf9mFf2n3jNmYgJdJWdxj2Xd4amqivDsAixW4ell4CvG5GZG8Tb3fJjwJwtNiONKFLjZOjRfO8c
 w30UZPNXPRkGGa9Lcig==
X-Proofpoint-ORIG-GUID: 0RCfojXq_hdhCqi9XpCOK0aRX5PK-Vcm
X-Proofpoint-GUID: 0RCfojXq_hdhCqi9XpCOK0aRX5PK-Vcm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110154
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

On Fri, Apr 10, 2026 at 05:33:38PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> dp_display_enable() currently re-trains the link if needed and then
> enables the pixel clock, programs the controller to start sending the
> pixel stream. Split these two parts into prepare/enable APIs, to support
> MST bridges_enable insert the MST payloads funcs between enable
> stream_clks and program register.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    |  54 ++++++++++++-------
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |   3 +-
>  drivers/gpu/drm/msm/dp/dp_display.c | 105 +++++++++++++++++++++++-------------
>  3 files changed, 106 insertions(+), 56 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
