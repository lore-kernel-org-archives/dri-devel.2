Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BD5606A337
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Rdf41SCB;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cDZCw9bh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 267EF10FC6C;
	Wed, 11 Nov 2026 16:56:38 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B36FE10FC6C
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:56:27 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABF040b1665572
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=6SGhToZVDBAmY0nSnfy1kLVZ
 C6LifvOaMyucd4yV+pw=; b=Rdf41SCBIoPctfV9yhVogRIBhB1lPP41gPT1nb9i
 DQ4s1g2CBe17SzoFCoX8njivuVdDVVwNq0dA8P8Hj2+OM+E7FyHcyXdDVLd5WjYw
 yMGzriAL+eBnsZ2aU+BgmOjBnLkUiQkeU0B36OahrEL9h+LCWItm3uYpemidFq6A
 A01FlQWo/98RUT3/53wN4Bc2j0FxMKlVEtbzH8itRqys7IBPUawypb4sNWWu/6SS
 t0v8jFFI4H1Sgubjs8cA5x8c6QQlwmMRVEFyDbYaXqG9k2PwcKfF5nSJC6gvkgCF
 M7WRnFUH7eva5QPUXhBFst/i0iOsloLb0/vn1tCQnLXbxA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvk7pta1q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:56:27 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f3969a2a7so554600685a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794416186; x=1795020986;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6SGhToZVDBAmY0nSnfy1kLVZC6LifvOaMyucd4yV+pw=;
 b=cDZCw9bhX1n/XjI2zdd35Stl13QJIrJb29YYoCYDmEd3KgFS+vIKOHr4oVOmN9zB/s
 rum++s2AjvjEPPTYM2gLG3qnfX3pFyX0zJP0yVclIo59A+JNmugjAOtbIHghQLv6jGoj
 HAFpdZs31euG7O3MY1685Vw/6LzPEJJNDLeX3FfXcv38mT+qOHi4+Pcy7Iyy7cIOahHK
 oUvFOeGDOSikbBVL3mP2Qymqxk+WDxB5mO+s52uOh56NelpLWLl/NseSQMAc54gsHmBI
 MrLmTKXYKP4bTw5XBa6PaK//E0gjDsM74ZJz6ytvT3Ob2Jgzlmg5Mct0sItIyxlmsHD1
 AqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794416186; x=1795020986;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6SGhToZVDBAmY0nSnfy1kLVZC6LifvOaMyucd4yV+pw=;
 b=eWff8Tt3N7tbueOH959RDFoBlAfqzO56IHNoPDxP28URd0ftVIzedzLtmySiCffjWd
 pTUd/jn2/D5flBevXOdBJCllCnjAr8lbRkwSmY6RWYGNlzvol4ADu749eX7U5wkA7buC
 M9mA+0VxHPFSsI3IuUcSrzTTuehVo9QV1vjIRVSitCyaZ7HaeGcw9fY3m/pFG3zWVdHZ
 bjCYO2RNPicTZXVvtZZS22MZXGSr8raytiXaCMDT0zKMH/u2khQOUDzIMd70heyHcat1
 O382DTP4DEW96gxeOkncB0+Jl9w1JxdFH79aDg7MENIAokbmCgGWrqRb9bztBklyDfSy
 XJfw==
X-Forwarded-Encrypted: i=1;
 AL+hErECkSzKotbx0FRcPpWT3BsVi+ngG260A4xfXqVPfzDGSxUFR8F66FeVdS5z/emtUjg1jxxkm8kH8qQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8xwLUV+B12Gd5U5eWyvVw8zSes/5pXkQ/xvJrs36UlxqOUjsVk
 S2JMeGvgjyjlZdpdP3b0GQ68kGMnKd2kSGLIF/aivmlkoYH3P+GgzFmx8HjHFMqImGL0bTzXe+8
 mrsT3RbTPnSmksU19mOyAXs8bR7kXfsts3vgVddwY3Zrrdw8eIqejRcZEAvXyUbFvjbHpXQg=
X-Gm-Gg: AYBFou2GU7ZKJjYXh+uwy2Ic/2oUOtwt0L6uBExbbXrv5FtpOOJCGRrX50HpPxvg+rK
 G5tNDRBBLk0RHhwtdXGEjpEWsh6kJgV8OaZomBYwzYnr9z5m1otcrvguJrtT4BbGg40CAHHZ401
 TEFVAA7GY+ZDw918Y8zqlLa08AYJjSH5Fh30vZEnv/QS420syNAHuCyM3MGTVpi4IAQI6fDGck+
 4jHjQgAxcdMLiHUy7z6LaZYpbeSyT4MlLhcKAGn1yXBtRmRdF+7BPNqYyVrPiRwXDbWRFhoJemo
 3yCPtP9nfYUlEJVQzqwbOHdOPFGpMSNezOSChIcfhQ1PYVY9OulI292NY1jxsyjH5lRG6fCUBot
 jAS4RX3xAFxu/Y2w3ywP9ghOV/Ai4Zj2F6bGDYyd0/htM0Ut2KQmOXqHu4poTEHVcnBODzckUxb
 ca9HUnaV+oOd3RCnUtyrOf4xzOvaignXnQKlJpMNreqll2wsrfER1HAAnaB29MZw==
X-Received: by 2002:a05:620a:2890:b0:93c:7a5c:77d8 with SMTP id
 af79cd13be357-947afcd2adbmr501041785a.4.1794416186060; 
 Wed, 11 Nov 2026 08:56:26 -0800 (PST)
X-Received: by 2002:a05:620a:2890:b0:93c:7a5c:77d8 with SMTP id
 af79cd13be357-947afcd2adbmr501036785a.4.1794416185561; 
 Wed, 11 Nov 2026 08:56:25 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c157ba5363sm1085381e87.27.2026.11.11.08.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 08:56:24 -0800 (PST)
Date: Wed, 11 Nov 2026 18:56:21 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] drm/msm/dpu: add source split order op for DPU 13.x
Message-ID: <scokoairkxrec2i5p2puxjbdkog6p7eo5s7rmx6q74l65rdd2e@c6lgdbvjgam2>
References: <20261010-pipe_order-v1-0-9d8bd29fd78a@oss.qualcomm.com>
 <20261010-pipe_order-v1-4-9d8bd29fd78a@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010-pipe_order-v1-4-9d8bd29fd78a@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfX7AI81ECqJSl4
 b8THR8xDF5SGUyS4esl+nSqkFJeFo/DCz5ESc9pctRUcqgs4/DW8skek1JSFIwoz2QIdWVqF5n9
 L7lwqLSSiWiuglak5pKTp4ddhmUQCfc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfX9eWNNVuAK/80
 p40X7MahoWb78QcvRq/TOo3YCcQaFmkTwbUt4ie2S+jPeJ33NDuG3AYTMT+FvTX/XZ8sFL50SyK
 hRdi+CTfPb005V9HpEcu4XGDq2bpps+/HzXe+wHJ633lkHXZ5fWYwVEAhjl3jVL/0BwU9vHMSws
 ax1v8ggm5itok4goVzAX0LMZMw/pfXr9ctz1cErutS4q1scp8gVQ7aMWSLpr54JvH9Jarn+NRcW
 HNWV6JSOM2FDlcwvq4jrOpZaM+dOMNtaKSTmwQ6C+HaNnVyC+cq3U2WOxZn6A9cW59WHuuFN0Sh
 nh6a4NsIScioO8nmfK3wCAE6cAELWM4AeyWyNzhLMtqeH/z0Zcnm+ID0Ub0KhQtbMtyyKaM4UWm
 h6ZABCp6hrm792QXC9gX087nsSWEkBJKWT2wS6pIgsPLp3DB6Y0j+9jk+P7FkPLt29PC/fdc/xh
 kHSBr7emKSmpQsKW1tQ==
X-Proofpoint-GUID: VCUsJ9hFJ8EgzO49jI_P3gtxYsaHnPJ3
X-Proofpoint-ORIG-GUID: VCUsJ9hFJ8EgzO49jI_P3gtxYsaHnPJ3
X-Authority-Analysis: v=2.4 cv=BpcIUoX5 c=1 sm=1 tr=0 ts=6af49e3b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=XSFdTqI9Vx7Z9g5_j8UA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110067
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

On Sat, Oct 10, 2026 at 07:08:24PM +0530, Mahadevan P wrote:
> DPU 13.x places the SSPP op-mode register in separate REC0 and REC1
> banks. Add the source split order operation for this layout, using
> the shared helper to update SRC_SPLIT_ORDER in the selected bank.
> 
> Assisted-by: LLM
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp_v13.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

This should come before the last patch. But as the fixes shouldn't
depend on the non-fixes patches, just squash those three.

-- 
With best wishes
Dmitry
