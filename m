Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2838FC4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:40:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E98D10EB13;
	Tue, 21 Jul 2026 18:40:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="H/pijcCR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g0GS0QlR";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3206410E3BF
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:40:29 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LH2TFK3439769
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=J1E9XgqDLWxtZv8FcbIWlNPK
 dkn0kvALTOZvp+gJNuo=; b=H/pijcCRc7FErFAE+ghFC+kugdImVvMf+EvaVBuh
 kaJud9n5zlkqN9O4zHod7PvU15Jb9qOxOP3BP6/GAevlFzUA2aMA9GYZX66fjGs2
 RqWKACLHBhU8vqwltXAY/arA2u53QBZQpTw/Fa+yDokoWBn8y5rv9PVFzgY79FnI
 FB617hXmrC0IZwKTq0hNrOtdzz7vjNjiy9rnl72ixXGkPZa4Z2XI7zf025goBFqO
 lBVUeqsK5GaexAmo7DW68ej6L1a1xebzlZbQ1/4/Jswm/L+6zrUvpGexlRac1rIH
 dIJcmtmhIr85iDLqfdvHDGrMZ2UEyiRaZVaJP2D3bNmr5Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6nstgb5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:40:28 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51bff5c7035so131239311cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784659227; x=1785264027;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J1E9XgqDLWxtZv8FcbIWlNPKdkn0kvALTOZvp+gJNuo=;
 b=g0GS0QlRCwW3PMolYhYfoOaHer9szKUSykpBq/rCxY0IkuWwkQ61cKK/CdCgMD28iS
 5B3/tSIi8D2lzGwaq07KJQcilU1TUkHp2ADw1LoPsWOcEspS8kICH66Gt0wcGf1YTGDt
 qFd7F3Sm/I8JG8B4iyvO6yxf2WYtls2i5MO20rcipTFnzNKFMRMJhtzfLloRJ447LNSj
 ZiBKy6piic3Nrht7PHmuH+KHLm3zCQYxAtum21Y/+sPAwNamlL1PIGwRw9svvzBDhwb8
 tReG5VeJA0HXNWn8B/0+Rm7mhaiO4/fDx6uyu0tfH1D2HlK+BAxLd0/CEZ3GSy1botIZ
 Onzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784659227; x=1785264027;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J1E9XgqDLWxtZv8FcbIWlNPKdkn0kvALTOZvp+gJNuo=;
 b=Jh3C+I+U/mDmoLGcICBT7BLjdfSE/OgeGRPkz35zDKAfTFdpGL7lCk3f8F5AriXyHK
 s1CJ7Zo4bbFt+NUXADrQvQpxULWUevtwm1wPW6gufhO8w6pLaCSOTr2izTD7b6l4Nvyd
 +bpAgqIGc+Q8zPVQ6uVQjpFwj6UhdEsV5osPfoaq7Rm5jpS3Eb5PaFUf4k9DCk/c4j5+
 bAjzX+d0g6a3RZ9dhFQ8oNtaAq2v9LKqPy87mn4AiVegQyRhPGwczqYndJpccxX+hhkI
 mrn5m3GMGCUvqvcRgYLuXMdn6/rEBziofxuTvOKQoPH7MN2iv2Qyw0qGALhkZuOL6Apw
 PJIw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1Z5T9dhdLHpckrLsZbmiiBeMcFvhBQphoKMTAaBj7h6PRMyCksrm7tbZWiujJa8Tk+C+k+L/RCq4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxkekUFvsoBXNH7++m9wGvSVjW3BC379/MtoHOL86r4VNoWjO95
 DGqAr0uzqwwfDtH5U4loZlvVxcfDNZxOSwBwMuw9wIybqh2TbWF97xITlzWzWYAuE5+Bin3Ux5z
 oJjuXkK3OYSrbEU1WBEK4GDkrKwJsixQmMoGN1LqVQNMC2UmyLkOAXytb/G2Ho3aLfI5C7Ic=
X-Gm-Gg: AfdE7ck6RQmlsXkzx3NLbnLOTcjxGIIv1fjpZvfBNLOTMYiV/jXAKZlPTwe1snNVoOG
 5mbpxWHMMjnivrwMriLlspJWAHg6HiqKOWZWNJLhS/DR/4P1Jt3lrDAg9V98it7GDDGMFmFSEQo
 KVADQmVttAPKSOK2omxSaRfFdIaEVKJkUcRgwTCFpQc3ZcGVvSfAyJasiGjrxeyPsf5dO5j84fm
 tJozIvcXMeTcWt64tPc9OJKOCDrWMpN1NtwU5H68KQ3glJQdoToihIKOcmk6rR1D+PrzbUjDGWt
 L/9RuHumkvKLtKsCeFveAsjPq9tQpnIDomL1gX6fwe3vmcZZzh3LJk0iIcvDiVDUYNxBve1XMWn
 iDkd6JQCvf1eltElGSNPWZ/qr7RMrny6+l1Hs1YNZQKpyidnIOMqPke8VDutmSvwwTtA9DEW39Q
 SnJQVJ9Lo8nwn3mg==
X-Received: by 2002:a05:622a:1cc4:b0:51a:8c86:bd3e with SMTP id
 d75a77b69052e-5213cdcae0cmr189114361cf.59.1784659227601; 
 Tue, 21 Jul 2026 11:40:27 -0700 (PDT)
X-Received: by 2002:a05:622a:1cc4:b0:51a:8c86:bd3e with SMTP id
 d75a77b69052e-5213cdcae0cmr189113991cf.59.1784659227184; 
 Tue, 21 Jul 2026 11:40:27 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9bad3besm73925e87.31.2026.07.21.11.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:40:25 -0700 (PDT)
Date: Tue, 21 Jul 2026 21:40:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drm/msm/mdss: Enable INT2_GDSC alongside CORE_GDSC
Message-ID: <nwz6ail4qwkmsejow6757nxkutojc2q76tw7lt6oj3h4pncp5f@w6xkgj3bnlmh>
References: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
 <20260720-msm_gdsc2-v1-2-4687866d6cb0@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-msm_gdsc2-v1-2-4687866d6cb0@oss.qualcomm.com>
X-Proofpoint-GUID: 4nZTxFyKtnjunCaVaTtgU5vPKqSJfu3D
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE5NiBTYWx0ZWRfXw2CCav2JPLKA
 HAZ2sgDPD2nXsQSvooWdI8vgXm4GKN7R+FJor8dkl3dWdkABGbmusuU0vMde+riBTuVCRF5v01p
 K/CX4JxQw70wV2SFlaTExBhTbSSJlQA=
X-Authority-Analysis: v=2.4 cv=ZJjnX37b c=1 sm=1 tr=0 ts=6a5fbd1c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=XCLxqskMeitJ3Y5ba8EA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 4nZTxFyKtnjunCaVaTtgU5vPKqSJfu3D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE5NiBTYWx0ZWRfX5vu6iciaz4BK
 kbs6rbbHMvshRk/4omcOZBOnDAun9jqPMa9cEIQeR2QYPFU67OIFoKMp+CnrEfqYO3tnYc4dJxf
 frbBUxGEeOS5ssyFjoaTOKNh8IQ5gfGG++UeoXFtSYUsr3R1gHAxIRUuhyozE5mXEpoIXPcPlv5
 +Ve2lufFL1xZOk7tvBERa196JKmbhoeu3Ab5aMfDrgZ6Dv93714tSFRHS4pRMkZ8R7B9bp9aK1p
 mSbm3G8TmH2yXgxxBQrnHz9kL9HEwiFZiWfmUoO+MHNxWyXOFTWxnSivKEOaYOr+NexrDHXloCq
 +K5a/idwvDoUrDjiDXb/qG2AU2wfavUphVrMmg/5huXX+I8+ggqcxy/AACqX5jGkI2vog9PEhGS
 Wp9dmhxYiFtX7Zt87oNkdY0ApyztUDXeck6YXzzjxzSFmfL7+IuhyvwIMi7qkW/o5pmdxfHGVZE
 Nyx3t8yJPaEHA6yUpTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210196
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

On Mon, Jul 20, 2026 at 04:43:54PM +0800, Yongxing Mou wrote:
> Kaanapali (SM8750) and Glymur use two display power domains.
> CORE_GDSC powers the main display hardware while INT2_GDSC powers
> a subset of SSPP blocks (VIG2/VIG3/DMA5/DMA6).
> 
> The MDSS driver currently relies on the default runtime PM handling
> and does not enable the secondary INT2_GDSC. As a result, display
> pipes backed by INT2_GDSC remain inaccessible.
> 
> Attach and manage both power domains explicitly and enable them
> during MDSS runtime PM activation.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_mdss.c | 53 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 52 insertions(+), 1 deletion(-)

Why is it being handled in the MDSS rather than DPU?

> @@ -421,6 +451,27 @@ static struct msm_mdss *msm_mdss_init(struct platform_device *pdev, bool is_mdp5
>  	irq_set_chained_handler_and_data(irq, msm_mdss_irq,
>  					 msm_mdss);
>  
> +	/*
> +	 * When two power domains are listed in DT, the core framework does not
> +	 * auto-attach either of them.  Attach and manage both explicitly so
> +	 * that INT2_GDSC (needed for VIG2/VIG3) is enabled alongside the main
> +	 * CORE_GDSC.  Single-domain platforms are unaffected.
> +	 */
> +	if (of_count_phandle_with_args(pdev->dev.of_node, "power-domains",
> +				       "#power-domain-cells") > 1) {
> +		static const char * const mdss_pd_names[] = { "core", "int2" };
> +		static const struct dev_pm_domain_attach_data pd_data = {
> +			.pd_names = mdss_pd_names,
> +			.num_pd_names = ARRAY_SIZE(mdss_pd_names),
> +			.pd_flags = PD_FLAG_NO_DEV_LINK,

Can't you use DL_FLAG_PM_RUNTIME here?

> +		};
> +
> +		ret = devm_pm_domain_attach_list(&pdev->dev, &pd_data,
> +						 &msm_mdss->pd_list);
> +		if (ret < 0)
> +			return ERR_PTR(ret);
> +	}
> +
>  	pm_runtime_enable(&pdev->dev);
>  
>  	return msm_mdss;
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
