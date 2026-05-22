Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95A9CD5BB1
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 11:28:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23FEE10F55D;
	Fri, 22 May 2026 11:28:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YF3biwaZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TFSwf8Z2";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A81810F54E
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:28:34 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MB60Cu776932
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V39PQb1fgCsY5OB3p3CUoPFehh+XbPwwIIvuWqbWIR0=; b=YF3biwaZd+MbDKPh
 ElXPoX6ojzP+eejflsrrvCVolhpHXE7nGI/JrvIkZzsetNho4BaFrnmJA9Wr0ppP
 0t5xdm5toxI9MtHGINQb1nZkRdrR0IvvUngQp8lwkLj4ghm2VAfQL17YAagkgPCI
 WrF1k/ZZy0U4PfDFeVsgC4t1X9qHXagjC+jwK5MR4skyGz9i+ZTwxWbRBPCTJPAN
 9RQRG6DPFopZnuL41SEie41Ks8TKu2WoEIAdUqQCV29u/+gcHAaKUmnuixIaUQFy
 /5EMQy7KfpOFzzmOa7+K1rTTdlJNTHv8lo/dwdZ6Kwlyuem7sVO6VynLdzE2lxI+
 lysd0g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea94h38h7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:28:33 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8b02ea0c595so23992566d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 04:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779449313; x=1780054113;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V39PQb1fgCsY5OB3p3CUoPFehh+XbPwwIIvuWqbWIR0=;
 b=TFSwf8Z2jl1HO57Nar+RxRAICBP7KFwECZkqlRjGNnWrpM7L/TcFOtmSG9R2pK5lE+
 tq0WaJWq8hZm+sAuLGzVIBsTmMYwlHZsStCb9TvsjXmXNJboGIwWK13iy/0XwJM8Ajbw
 amMiYbWaCal6w7qnDVGBjLly2xCoOT2+eWeo7s5QEu+MB6I9VDvVoE8wNmL43yhIDgvY
 4mZHBuEqMqOYk9jqg9FoPzsUhhoBWYA5HCgtG8tGa60Dne6/QdJAjTNHrwG8biL7oJk4
 NJwD647u7yyIIE2eXTsgPQ2ONSOaSpW2L6trA4a5KG+6lTaYA10HYMrwSpYWvACEkxgK
 hLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779449313; x=1780054113;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V39PQb1fgCsY5OB3p3CUoPFehh+XbPwwIIvuWqbWIR0=;
 b=EGOh1TACBONuBFi+HcWLio8JDX7SF1SfHGlG4IVrrn0/uic4Dr29RnasS2W0HmRohr
 o3xPdRBztp2ftQ1q5UHwkWFrcoc2TeAXkXYCias5LTmNwcmpYY7nu13iL3HGPrIflX45
 vFw8X2bSUJJfaEIwvsYNlp42/Z9VqztLeMEFdC1Ld31uM9HX49xJrZjJ0VP6ZzSd3MSb
 QUGYygNg7PfP2B974jSEEgFGICkpJ/2CVuVUJ8YYAK4+f1Bk4H79RiKT+aZd06pbiMU7
 C1jTM9OG+WGAwYhnr4kERDikNSxyQ5yNvvaPzXp3+E3lfKanX2aUu7eHV4mhEtzFr8wo
 uO9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Qkl0hM1n9zih2380V6vZDWKBUHJUKLDBHfmdAZuiL1YLyn80wCkKj1wgFISuxgiTQiisTbP8ukP0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyiOPEKMa7KFt4KqVxZpws+7XdkPvhztOv9HurqspE3PCJ6kbq9
 P0HBfFJvay1Uf01elKHDQPLdJx/Htg+uM5QQBrGG7DBjDcFu/9nEtZSOYc4bNsDAv2KD2PEgXY/
 t/1eM6ZCC8Pfd0nWkn5f1Kjz5dX9MFW5mkv/aqLV85ifN1Dmv//u5LpJ0w/bJk3L7NUAm2Mw=
X-Gm-Gg: Acq92OEdtFxDre7Ol3zuTw7iSfx0S1U6p+qvyLdjVz5pfT2Qme3A7UuG8UzPTrM3Naj
 oHg3cZNZOmpwCFWLustgIXepMZ4BKuf0Pbl+wyr/foD4BMA0qEMAZ47j3EXD/cxc5ASoCovB10w
 1an0mOgk9ar8rb2WEGn8aAoXkuYN/2L6+nkVw36kAQLdqK4sAzrc+nXuyeaSCAYs9mm2HxQAs+d
 l3zfjHRjnGhZ/l0SK1qsBOUwCa3WmeFvX5RNkX8zOBymajMWb6DOJpPEd6wXawqxr3lzwh+2tte
 MGDfQMCNGbgEU7pLUgjVYBRDcznOrPkmFWPO/xL+3un8f1VwmYEeNUq4ZVEtrRYnKpEqb2EKIgv
 rOKP0p+USgLcrhisrGNMA9cuGN681zpQP6DQURcuscuSIbw==
X-Received: by 2002:a05:6214:1fcb:b0:8cc:85da:2d90 with SMTP id
 6a1803df08f44-8cc85da2e21mr3579496d6.3.1779449312927; 
 Fri, 22 May 2026 04:28:32 -0700 (PDT)
X-Received: by 2002:a05:6214:1fcb:b0:8cc:85da:2d90 with SMTP id
 6a1803df08f44-8cc85da2e21mr3579186d6.3.1779449312389; 
 Fri, 22 May 2026 04:28:32 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-688b9f6084fsm590899a12.11.2026.05.22.04.28.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 04:28:31 -0700 (PDT)
Message-ID: <792b6446-53f5-4324-ad6b-5bc9a88e25a1@oss.qualcomm.com>
Date: Fri, 22 May 2026 13:28:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10] drm/msm/dp: fix HPD state status bit shift value
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
 <20260314-hpd-refactor-v5-1-0c8450737d64@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260314-hpd-refactor-v5-1-0c8450737d64@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BqS68vON_MxGjR1fGY22y41JWVidN9H7
X-Authority-Analysis: v=2.4 cv=QblWeMbv c=1 sm=1 tr=0 ts=6a103de1 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=5rTfuJP6cXs4uNvNC2oA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: BqS68vON_MxGjR1fGY22y41JWVidN9H7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDExNCBTYWx0ZWRfX3U38yIlglMbM
 on0BsAZcl0Dtyb5BEdcBYuffapVbscpGhmON9fVxUfq03uJCO+MLtFtF/b1/qeg536K8I6eK6Da
 aD+4WpiNthx/EmiU8FYgiB6LMtx4DnLc9RgYxzFM1CbFwCFBCj+Tt8WeXp67jO77J3Vrv3uMbFy
 KHpJrWiYNrSocHEBXUnOYAn6tdTJuQcv7R2tMGaOXtLBYPy3Z/We82cMD9eJ7I6IzDkm+WfiaHs
 H9ILCC3+XltCf3oy1el+0qiYpnAh8cUTfM4n6+B3VntZtLGqZfbKJTIvZ+L7O/qpnH3ushCUh4T
 oc9esqE8Sz6qEhAWW2udL28wEE09rTYGE8xbXEDkB6gbczt2LNq8SLf4cEEA53F0WWkwmcw2VTu
 82mhIvipni/7RoAxeWJsZ5cHMY7J0uATwGU19tWtt2PHRspu0Ga0UD+e3i7OiLiP4w8FozGTOLU
 IzHmQYHhgj4QJB3SdhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220114
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

On 3/14/26 2:09 AM, Dmitry Baryshkov wrote:
> From: Jessica Zhang <jesszhan0024@gmail.com>
> 
> The HPD state status is the 3 most significant bits, not 4 bits of the
> HPD_INT_STATUS register.
> 
> Fix the bit shift macro so that the correct bits are returned in
> msm_dp_aux_is_link_connected().
> 
> Fixes: 19e52bcb27c2 ("drm/msm/dp: return correct connection status after suspend")
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Carrying over from v3..

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
