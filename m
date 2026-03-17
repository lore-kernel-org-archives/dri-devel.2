Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55526FED9E8
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E66210E6FD;
	Tue, 17 Mar 2026 16:49:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="M4H1y0ua";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IssijUbz";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30E9810E707
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 16:49:05 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62HAjvmg254219
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 16:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 451Gt6n+OxCGYuKYdPgYhLoSVjAkvBCo9iM63F8lQ8M=; b=M4H1y0uap5vzXLWE
 nJnxdL7qOlLsLRSIX6z+4Rnb2J4t684jbo4SxBFE2JpXwFPaTzvM81paBveqwGoC
 oE7ISkAzOS8Vgke/Gi8sN17RKuoDco3se8oythL7/Hz2G+1L6o1kTESoNBLRJtic
 CTxNbfEpdKjYDL8AJgxR7kmDtAjwGw4cInfIt+apFNizmHwnKI+vMQmE5+JD1Fof
 M2jaDqaKjRdIyXJjhjEPXui3hXc4q7qj44NWOTznj1bMvSq/JvXUo6N1wdCyfZ8v
 3kNvzHYJlL48EisMu1CLaTYDlBOxNcp1H61IzDcSOunNtkTsId+WVJlf84mTKFJv
 V8k7dw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy5g8hbc3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 16:49:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cb50dfd542so410347285a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 09:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773766144; x=1774370944;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=451Gt6n+OxCGYuKYdPgYhLoSVjAkvBCo9iM63F8lQ8M=;
 b=IssijUbzgparQLSULpZTkUOtZhA3u8lmPTAONlI8QmVBH5PJxKsC4YG5yuApZN0Fwn
 Ac88A8z3ePoB3HI0BPZ1K7ILuVF1SaMYgBVWgOcbPCTtKtUoXAWUsFwiwuNlFMjOMsxY
 QetLbfk5cUvPXIl0kpnsTwPklbNS/Awm4ATUhRV6ubIkfge5oSNrFJQwFaBo9tUvj65H
 PT5LsOcAVTLuENUeJyS2etz9FbJAme5Ocown9py3Oc2FIJdwQxu82N2aK79gh53Izfoj
 k5OfzJ4yiw75okJTN2kHgIqgnbSTVZ8DVDPQOartJI16w5y26kYmZadGEkoqkep+yZAP
 30Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773766144; x=1774370944;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=451Gt6n+OxCGYuKYdPgYhLoSVjAkvBCo9iM63F8lQ8M=;
 b=sxHWvOArCSW63C2Ze0BFahndNIWS3VSlOfBiIaBi9OFo0+4FhyPd5RkaONkUjmtE8E
 ALjkGVAw8E1Ky6VCX/Uj9bP9LlwOT9aJdNctLqekc+ztIsiHQmwT1bzGbpNcM1qak1Y/
 M0DHQwGbZSns4bjFaS9BUQB/NqOPbGlGnedWvKd2nI7Ki3+O71qRrtYWDGyMa3UegQhX
 suVPCzjnsiS2y0N66VsZCv8XEl9NoOl08ZNrNFY9khAHZ21RljFLXITTQfmPX7HevFsk
 +qj/RcYR6+SPk5Ajbc6IVlPq94oQPT152LW+jNhqaV7S6/CQLKaaeo7LAS4DcKx5HLFI
 31+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/+RYY8/MJbNK81jSyYKqLKytKXDWyVFEel/jBc51HIj5q2cBVIyEzhBnlZzG0ISjm4DNUc8biZEQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDgHx59jrUxcHOexdStE2O3KihxljWP8WyHFthKkUMPc+uuHPy
 wgt2s00e+j2PbkSXsNzinkIG4QCdzQuGXrxEm/aFgR2kjKoU+ewa/L8yPbnal5cgy0VgsdQPAOz
 cnWOyL332/Prk1ZormhW3dOk4v2+iqC000H/vGXgVsezuB7Ev7XmElle4lIo3syTffC7QoRs=
X-Gm-Gg: ATEYQzzDuC4UMXdbYtTrjtdoNCzvmH4OPc88jEVA0FvPbPstBRErAG3da2PNSSIdtTe
 m50SWqP0q96i37FyCl38zQ7OEzhYkGtGza+n1+SRpkCBykpCOw0OOFiy8/dcJhN5BeHTJiTKkuS
 QmePKIA5F1FsY0yh01s+UE6ZiD46S9QkB+m1LWP4TZlcXD5r/aIHz0NUE+PmR2rmCymOEMPHToO
 LEXv8v3nZZykA8kdLrkms8UICpE2AT3/WWz7tn2QChkdV428ilZfgWKoB36qV8cbK4/WdvpQOdE
 iQddnZQLhFVW3NWIZ4sfjK+sB0pRSOcsF66i8fXs/mjB6Fb8SJLZGDvUFp/fGeStvpxMJ457gvq
 l68TX6tdSc2dxp5e31No7m8ggeFtP5JxncHUVWVye26vm0VOwJ+gB93e2ggsBKBQX8VlOw10lUb
 5Ml60=
X-Received: by 2002:a05:620a:4095:b0:7e6:9e2b:6140 with SMTP id
 af79cd13be357-8cfad376157mr19977485a.8.1773766143568; 
 Tue, 17 Mar 2026 09:49:03 -0700 (PDT)
X-Received: by 2002:a05:620a:4095:b0:7e6:9e2b:6140 with SMTP id
 af79cd13be357-8cfad376157mr19974685a.8.1773766143117; 
 Tue, 17 Mar 2026 09:49:03 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b97f13ee739sm21035366b.12.2026.03.17.09.49.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 09:49:02 -0700 (PDT)
Message-ID: <df44b8d4-98fa-4a9e-9c24-b408f406b124@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 17:48:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dpu: don't try using 2 LMs if only one DSC is
 available
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Luca Weiss <luca.weiss@fairphone.com>
References: <20260317-fix-3d-dsc-v1-1-88b54f62f659@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260317-fix-3d-dsc-v1-1-88b54f62f659@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Y7D5WURt-sCFXdafYp4aTJYlGvRm_7DT
X-Authority-Analysis: v=2.4 cv=EeTFgfmC c=1 sm=1 tr=0 ts=69b98600 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=LbxHV1oPoWewQDzF:21 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=n8dURotSPeuEtQbmUPwA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: Y7D5WURt-sCFXdafYp4aTJYlGvRm_7DT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE0OCBTYWx0ZWRfX+BPNl8LcobMH
 qFuOgr+NSlcedpmwHav0mBWnz/ABkIz00y+JlyhN6dOPpFQoWLOKkH4HHvS9voElSFBktPAXnkJ
 uotiwQCAEkQOm2IRrWqUx3YdeEfRNheByTZEV69ssbKJGtAbsLO93GLR50Oeqr+H+5eOQVgAorP
 48zYZ/aeniDZdSkts+G5vl+yvEBOzVek0xCfiNSwpNarKXB0Vq/ZnrYOBxsq7+QPgqN0TakRThJ
 hgTGFZ3WnKIdQjfWeX0NHuOmYXW2qQYduVQ7GUFRLXgqrxtzvvenu1yO67hqJSCXUMvCnedFanb
 EffXpiXPnN2PH6US2W2c8P2prfFrLe2r5sYbYfyZLnvufGDT9lOpf1p6Kl8St38zu7tvYiBFCb4
 zGpFWoNWqKH6eG4tI+j3Q2SDkl2TRz/xe5oSBxwen/b3dIAwHWXrWxFzk0Z766DDxOu0G4tPyv0
 PdVkFfSwFgLz7Ol4X6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_03,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170148
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

On 3/17/26 4:30 PM, Dmitry Baryshkov wrote:
> Current topology code will try using 2 LMs with just one DSC, which
> breaks cases like SC7280 / Fairphone5.

(why/how?)

Konrad

>  Forbid using 2 LMs split in such
> a case.
> 
> Fixes: 1ce69c265a53 ("drm/msm/dpu: move resource allocation to CRTC")
> Reported-by: Luca Weiss <luca.weiss@fairphone.com>
> Closes: https://lore.kernel.org/r/DH1IKLU0YZYU.2SW4WYO7H3H4R@fairphone.com/
> Tested-by: Luca Weiss <luca.weiss@fairphone.com> # qcm6490-fairphone-fp5
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 6bf7c46379ae..96b67ea3fb4c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -1410,7 +1410,8 @@ static struct msm_display_topology dpu_crtc_get_topology(
>  		topology.num_lm = 2;
>  	else if (topology.num_dsc == 2)
>  		topology.num_lm = 2;
> -	else if (dpu_kms->catalog->caps->has_3d_merge)
> +	else if (dpu_kms->catalog->caps->has_3d_merge &&
> +		 topology.num_dsc == 0)
>  		topology.num_lm = (mode->hdisplay > MAX_HDISPLAY_SPLIT) ? 2 : 1;
>  	else
>  		topology.num_lm = 1;
> 
> ---
> base-commit: 50c4a49f7292b33b454ea1a16c4f77d6965405dc
> change-id: 20260317-fix-3d-dsc-4b073977ea19
> 
> Best regards,
