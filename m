Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D462DCA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 10:23:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08E3B10F602;
	Thu,  1 Oct 2026 10:23:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MIrt2Iam";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RSaKobFV";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0D5210F601
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 10:23:49 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6916xgQB962581
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 10:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=yzAz2SWMqrTWqYRsucc7HPMS
 f2cC52cQm3KTbr2oPBs=; b=MIrt2IameCE0cj5sY1K8wpPRBmwy65JqkGjc1Qsp
 prgKmPwhBAAB6qFYeHuDUQMpfCYM4x6X1BVIKr+3XO0g/lkaW8PeRlGdzGN9Sqwu
 HZkmowlmhOIWGYgd+I3u3rTAZb7bTa7zaa9zn9yP628KQX3pCW3c+Gv2kF/RWdKj
 5Hpz8FktqStmcNBdS6HuXDy8ZigDmmvwqAuNhqoL5TdfEZRAct9V51WA2dmjoyFI
 x84w0mQr80Vww7ZLFxvkLwOGd3U6IbQLAirCaDg20JbOnSNgxzgZt6mTXnPy2+LQ
 sCi/ZTypQqPDvRnlduXsOjQgn9qGGvYO5YIgm93lWg5uHA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h16wcup0h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 10:23:48 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-936708f129aso1273425585a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 03:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790850228; x=1791455028;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yzAz2SWMqrTWqYRsucc7HPMSf2cC52cQm3KTbr2oPBs=;
 b=RSaKobFV7jlrZfEaqKuJjgUEjLub07nu++rLlm6zYIzNTVUgzgHHoClbzgBTcXOcGZ
 cHTFLMzikICNEluSgVZ04mgsYo9LM5Eb0YqB5RoDrg/gDnIdSpCb993Ai127DpADlUlO
 DuTjAn/eJc2X1Qu25rhxRtIu93y3++tPA5LNsKok97cQUf2CyY/xDB1Q/VY8FLOOrzkz
 tQyQ9QHRlH8Isqhu/oF18THkLBlbfp8e0seSSHYW2WzRFKV9SsaRM5U2yg9+YdVWAXPu
 pVm8U5d+FcHSZosuHeB6TalsK+kq2tIfu72Uut4kB3wre5uma8Zmj14CuaYwHxC9NN4W
 pTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790850228; x=1791455028;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yzAz2SWMqrTWqYRsucc7HPMSf2cC52cQm3KTbr2oPBs=;
 b=YKdJznHwNSsqQHgz+STY8IbEM4v6TJ5OpjnxfRqCnH/3/GwGPGhvB5yjBoMDSHvxtC
 GBnaww++NKZTAnHvjonHZISBHK9ZAOiJxMywLu0TV67+vgKaDOS6YrO1HVk8wfswl2ug
 7xtFdw4iQ4oqtz7xSL8w5vK2pEVHi/bO0TedOTycIbjLG8p5G7um7MaR/8ikHk746Zyt
 5LWMM8hXiCKpVv4pK8JrznG8PXuqzK9uxPDDVYGJ/RNGiIJ+OsS5ZyIRivvZX7mw05jU
 Vfroxo5vZeyK6Y025yDiOa5XZwHkYS9mgnppdE+qAM84K2f5hfLyJV+ODumZQfTq/hfd
 G7fA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxISsYLba6VLRPeEjTUCB3I2dqbvFfjW7YuY8YikAEF6OBNUn4tgeU0Ed3CdCyZK9tvMa8Cw0cRruc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n8YM5GsuKzhV81DsWauvXuUVFnSyLVouVuF5XgRLa46w2dgKnq
 Hplae19RBxLwsheq8Eb+nnDqcCoEDQtvGoJ2SBqGCswkXoZsmBrpjdXe60ZkzOm+FYuxRxdbBhV
 ta/FX8tOf3puDSFB+xgtX8ZbVIHZ2Fz/TbWXRbi0doDS6VslmQGjzl0J7xP9s1WcVXjOAmqU=
X-Gm-Gg: AYBFou11e1MUYBtaMLRXb+Y7VrjC8t7ybfr/fN2gPBUh3uZ+moWJdUvFQ9cXXPD9P0l
 TC7MpzPl3rg+oxevC+/9zOB5hc8rfdI+IgF3uEWoIWMHz318IWbE+/NyFoyK10Ve28436yQ7Ca4
 MJT4kzHQAmX5kAFnQIExRnb43WfgspffRVfbsjnPbzgNClneCRWEI5g9QJz4+YgPt88BLH9q7ya
 +I3k6cAsHTYjbYzS47RgYputGYryJBfWYcZsZ/d4B9X0eytaqdXrQmu4twZDcPX6r5k9KyqRIHY
 3qKe4yvaTR6OlGhRPiG1u+wM3Ko7VH7xfEqlCntjk0VQCk1oeXO9VBQtP5uCYnhrsHWb+IuQfHs
 AhQKMBt5Z8DxHL8COAZLpEmi6ZH1eI/OOomzufR1WLCyNXcke//vdA/YTlhYHQpJdj7gyDRMi7G
 rKYY3nozQ4eDCJ
X-Received: by 2002:a05:620a:6844:b0:939:5f4d:67b0 with SMTP id
 af79cd13be357-93cabf2a14emr658671985a.8.1790850227813; 
 Thu, 01 Oct 2026 03:23:47 -0700 (PDT)
X-Received: by 2002:a05:620a:6844:b0:939:5f4d:67b0 with SMTP id
 af79cd13be357-93cabf2a14emr658668585a.8.1790850227258; 
 Thu, 01 Oct 2026 03:23:47 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba42fc529dsm618361e87.80.2026.10.01.03.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 03:23:46 -0700 (PDT)
Date: Thu, 1 Oct 2026 13:23:44 +0300
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
Subject: Re: [PATCH v7 04/35] drm/msm/dp: introduce stream_id for each DP panel
Message-ID: <cef7gvd3v3oosjsgtoij2m2doaddnlrt3q7gaq7t7ih5w3em5l@a562vfmjv7y6>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-4-4b81473185e7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929-msm-dp-mst-v7-4-4b81473185e7@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MSBTYWx0ZWRfX1DCs6MeVQhil
 Zqwn/8wOlaJXfx+/oL2K+nA9B9IYZ29t+mztxVxo3niedTymu4IoEdluRw6EjyBnaYsVAUS600W
 dl2gaCjgsG0+jpaJ/kMRWwA/xLUnGQPvJfwydKclbxZ6ZE/I2m6O2XaXuSiA0TalTAmHZlE1rZU
 Zzb4B++aGyGxEl9jgJY3L6Pr0OE18VkutF8rDe4WTKIRKeqQ1jolcKcDzsXz21nNYQy2yh9cVMU
 sbc1kdzCNAHcG1B9yQbsE/Geu3x6hOU7CHyq7yXYmTOM2wix18rgPgtl/V399xZS8Nxj24eLxPb
 SWAiXDNbg5C2OxNb+lIjw+Jd/oRIHH5CU1lDRsNIi5cHkbWNLT2muPWcLtraRKVtMNHwb7nl1sQ
 lynAMgRi2rkG3GgDDYTeo/1eEtjJOzqHW4GvPOJyhJE8oV90YJOhjRY9vd86Idobh/ydA594uhW
 IO2KBxrOy3iNwnILQcg==
X-Proofpoint-GUID: omby20yqZB5dccVoQb9UcMSjcPsGgDRE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MSBTYWx0ZWRfX32+hMjjIvjyZ
 7N4OTERvMI4OldMQVfWhCdRbT6nBfLZu6LaILMdHpEfugeBIpkexKHwNcIAZlqtAQ1BWG582PMw
 yjYFxWa86s6AgJibM0JfnHpKZSHZjtQ=
X-Authority-Analysis: v=2.4 cv=S51MU4sP c=1 sm=1 tr=0 ts=6abe34b4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=einhxy-9zUKzVd8CT48A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: omby20yqZB5dccVoQb9UcMSjcPsGgDRE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010041
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

On Tue, Sep 29, 2026 at 12:25:28PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> With MST, each DP controller can handle multiple streams. There shall be
> one dp_panel for each stream but the dp_display object shall be shared
> among them. To represent this abstraction, add a stream_id field to
> struct msm_dp_panel and introduce the msm_dp_stream_id enum. For SST,
> the field is initialized to DP_STREAM_0.
> 
> In the MST path, each panel will be assigned an actual stream_id at
> stream-enable time by the MST layer (added in later patches).
> 
> Use the stream ID to control the pixel clock of that respective stream by
> extending the clock handles and state tracking of the DP pixel clock to
> an array of max supported streams. The maximum streams currently is 4.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 70 +++++++++++++++++++++++--------------
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
>  drivers/gpu/drm/msm/dp/dp_display.c |  2 +-
>  drivers/gpu/drm/msm/dp/dp_panel.c   |  1 +
>  drivers/gpu/drm/msm/dp/dp_panel.h   | 11 ++++++
>  5 files changed, 57 insertions(+), 29 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
