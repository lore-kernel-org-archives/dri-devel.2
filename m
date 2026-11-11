Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBE3606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CjZeU5PZ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OvTzYtal
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 263DB10E40B;
	Wed, 11 Nov 2026 14:49:22 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 939E210EA4A
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:49:10 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABEKBQk926470
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:49:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=qhJ2whnh2ftT/2vZqPRp8bR6
 iMbwhkvUovT1Mfig/hw=; b=CjZeU5PZOdIkO4DoAP9sLaaNn5bjwdbcNRvH79Yn
 ZD3XlMsXfX03NcJsfmpTFHvSQjkEell6uXR48rWaV5Iuo2QRhF166/xzlPbb4Nde
 YgN0B45RpF4wc32tTFVRW/4OY6aDsrKKxPT+FznCIc2MTO9p35ACu7sDkWVoUw94
 SRbLETysH/wOOk90LhNbBoxsboYRe0kwgZ+OSJjk+FV2kaFUlrwTyz7mUytQHkFy
 tZycqW5p6Br7KQgFSheKzHMK6f6VjAJPv9BNH+1z08Qi+2ZKOUJqkGJXL8mCYHVP
 sMpryz8JUB1d46w3xoouvooBPjgTXrKsz0R+7/sZbIwKmA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv9b33yx1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:49:10 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91ea5866643so61993096d6.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 06:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794408549; x=1795013349;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qhJ2whnh2ftT/2vZqPRp8bR6iMbwhkvUovT1Mfig/hw=;
 b=OvTzYtalOYK9lQDF/kgA4Q/U/5VYSIDFmwtFcnBGs7Vv+Gjyn6/tnsuvwEz0yiJpDb
 IMEJF01KbrVYwT6GvrGxtLJ9oHppzL/oH4h0EY1EX4ocvAc5hcEzWaJbcbztY03XWTEp
 MZxE5Clo2Zp1dxk9YaHk/Xw+ZzPf8JlEFzq8EhsxRCOKjZSzejaY0rGOnG/qGtFwlBX/
 cq90B8TVdtRsCy+iLExPzJ7f+fGfRp4eM3p3sdsGLS9jcri03eoPH2qP8OlYSVRZ9TId
 6v3dxTWGGLgqTCBWaSYRA9EMIVRdqmwONNmgv1Em7JQ2VHJw9uad1/y9UyQwczODt1L7
 wO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794408549; x=1795013349;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qhJ2whnh2ftT/2vZqPRp8bR6iMbwhkvUovT1Mfig/hw=;
 b=BJHkU/W4TedJxmJ8Sb1LjIJZ5GkCVJLDXYXIyn31/RHd35a9V47af5KG38AL0HPkmd
 Yfit/Fp36Yr6d9bhx+qaZtwjZnB7M3pYTsW3dKw5uHi4HEfgrjsOjdNNn9UQtdhX78n2
 xrrTuJJUlcnqgxEXK/iT1V/UfWMzF6ffuvsv5qWm2/UFYn+ljFyGFshMzxfuxrQzWGxb
 wB1wrMym/tijeb5MjnAyyNIgzvBgnRke23abKgURkEcXxC0HLBSlyjl6hgJ+O8vJ277+
 HHqtChgMWHKNdifxmamFpVLwGWjfqOc7sucuQXruim8wkMKDcS+Kf7n3Ux2IvAwQuoEH
 6SPQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEpHACtiINHryAqIvFUqzc2EEGuoN7p6WB6SRNwHN5T8xO3mxX6AdJXuYAy6p37AV/+m6YxW2FcCes=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8RNZOVuvmbCRtKKoNc6VS8R9Zcy/FOr/MpfPtypDmrx8oj3wBs
 lPuf3w7Ody5lBLGaG3y+92eKbabB4OtmfBPaFRLxAb++TNUBhPkLyWT8kH/+yo4wUYKkRzd/sLI
 QFtN9kfqxtG1G+JyXfUcZZJXT1TKSCWCEJtF1y/sz+SEu88dYSvVrQy4RwPFyUFyiJVaUJWc=
X-Gm-Gg: AYBFou3zLr3YnfUGjVBiKblMcMVwtAeinCecfQtXlWY2dK0aO7rXaquqYkV6g2A7qDg
 JkeK40CjlTwDKmkKEWtB2BOWeSF+71nLvdQ3fburtCwFEhElQCrNHatHN//kqdK9Bepg4SyiSL2
 XQmUarMbnVjZ4xvh3mnlPFra5od747607EMclSjcR1mbNC6i5cLILX+7ON30a+eRwQYgvCjW7qe
 cc/qG1jp0LWTq30yujDeB/1B/EcApx+arBZhVpfcstnu4gyPIGo8xfrtHDYiYisjfbVSYy6d5uH
 0k9EpAeD9/l+SqIl0DriiebhKJCd6+uzxKFpbMynVgALC8ww6XHVht1xSoWVyKHp0BJYaWPY10S
 Ncl2qNR3VTSgn8LHvIQogrKQkkm/qc0R7lZfxHsLuC1mgIjEhmiEzOqek7YAY+TWsEu1askZmAe
 xFdin56FETPyTqOzCOe+GsyYDdAXaSgichKYUUw/DMAMKyqmtyE3av/wNBJL2LdA==
X-Received: by 2002:a05:6214:2028:b0:91c:65d0:1d85 with SMTP id
 6a1803df08f44-91f0426ddcbmr48004036d6.53.1794408548821; 
 Wed, 11 Nov 2026 06:49:08 -0800 (PST)
X-Received: by 2002:a05:6214:2028:b0:91c:65d0:1d85 with SMTP id
 6a1803df08f44-91f0426ddcbmr48003236d6.53.1794408548137; 
 Wed, 11 Nov 2026 06:49:08 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae0923c164sm12141891fa.20.2026.11.11.06.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 06:49:07 -0800 (PST)
Date: Wed, 11 Nov 2026 16:49:05 +0200
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
Subject: Re: [PATCH v8 10/29] drm/msm/dp: add link_ready to manage link-level
 operations
Message-ID: <xdahtkmsoxposnxuomytx2wcxthelxjpopecnxjellidqbjq6g@lgmcy4privcj>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
 <20261110-msm-dp-mst-v8-10-d040fb33db5f@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-msm-dp-mst-v8-10-d040fb33db5f@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=GKGdgeNK c=1 sm=1 tr=0 ts=6af48066 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=9BbQWiF9P2Ean-TlPn4A:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1OCBTYWx0ZWRfX0+tvIzR/LJMC
 3Y5Z4ptv5Mx0h6/BLbxawDV+rhrgdY/N13Wma5L+8fOEHhETxRpsuSvkSAC2yfbeqXH9uqqilqS
 lxCef2J1W/JaYkITa6SUuJhk6LpG+u9mmL/DrPZi+q4T7IZaA4CayHsVFOgoAtOe04PQL3Rs2b9
 m+fR/WqHEziC9papjwmavUwFXVPrC2blItl7CcR64ve/gLKLUk6PB+IEsqI7UUgVn2I6oL2AQTa
 RzeAib5+uyTZhe4cVY6H22OOizBbppZphsw/FimFJwvbSyFUu4Mh++C1sTszZ42ZfN/elRfrDCS
 QtahY1wD7bFY4uTbY9qrTJCD/WjDSezDDoa/Rf2VwbCoCxZQSg4kZgt6W5tvrcpdh3Muin5msSt
 qZ1cH6tM+bx07336zPEvM7cdWWLZPAwNY7umdIx31/sfNbetlMrjh8l9gb0pFdpPvq6jYvX0WeS
 4UnlJJuz8n+/AoV8lag==
X-Proofpoint-GUID: coE87o1IlbIkZWAGjGbSpNZgahWokyV2
X-Proofpoint-ORIG-GUID: coE87o1IlbIkZWAGjGbSpNZgahWokyV2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1OCBTYWx0ZWRfX/qE0mQunDCuO
 9bFf+dVb7OEaNEF9vgb9Ot8DHu3QGWCC0G9Rie3vs6OiSB3qaCO+ft9HmfXhpgPXWbhpHwC/qbS
 I3W7HjMiSk10xDi/gr9BlSlglds92LI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_03,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
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

On Tue, Nov 10, 2026 at 12:54:31PM +0800, Yongxing Mou wrote:
> In MST mode, multiple streams share the same DP link. Track a link_ready
> state so msm_dp_display_prepare_link() runs only once per link and
> repeated calls are skipped.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 48 +++++++++++++++++++++++++++----------
>  drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>  2 files changed, 37 insertions(+), 12 deletions(-)
> 
> @@ -1570,6 +1587,11 @@ void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
>  
>  	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>  
> +	if (!msm_dp_display->link_ready) {
> +		drm_dbg_dp(dp->drm_dev, "Link already setup, return\n");

Link already disabled.

With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry
