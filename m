Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF6DC61CE3
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E2E10E55E;
	Mon, 24 Aug 2026 13:15:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WhICT3HH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dBCCOluQ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D080C10E377
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 13:15:49 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OCuxS91880532
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 13:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LFyU3mWvGyLTGThD9sv/hYIL2x60Kcu9mNScGO/gTbM=; b=WhICT3HHIExyzCtV
 yAy9/JcDQdv/ppry5xEJz8pokJqN4it4ImK4E7TBYrW49PJTKbYCRlpRpfpgstBP
 GxelFVEYqNMCEqtLU1giG5iankqt2tUQfbqOrRkgCEJYGOQNrqCCxg18ITPfycIT
 k5YmTK7CiOqIAOFdWqoXY8Xgs1IrOPPDf0S2l4uSijTwoOfJKxnG/kt9y4B+9uUc
 VY7BKZ921WlkaKIbXdnZdD+TTvpopik6e3/HzerWSffdGnI72OdetV6NlGi7B65x
 syX4yn7EVIXjE6KBqtD8bZyAR+TBxWfwbfjm8pe5qUsKOymDfYtRuFzD36Oo5tVG
 ohGYlg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8huf1cqa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 13:15:48 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-77969cb40dcso55150137.3
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 06:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787577348; x=1788182148;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LFyU3mWvGyLTGThD9sv/hYIL2x60Kcu9mNScGO/gTbM=;
 b=dBCCOluQH7BttuS3Y8wYieZUh7BGygJAGnHehVdlth6UIqzzAj34JgW8tjftOhwQHi
 V5AJPhf8+sDryKMoutJo4Zx0wGOAI6o+28l1IHAUmp/EU0b4YHdw21mEnmwqj4WWsZHV
 ttoE0B/3DK7rpO2MIEHzluccJST04tHkdZnM3wuQquwrakrzOAStHGrCJHzDlgzzL+lB
 /4/MSVgG+embOI+9+CAQbC0gIcSRJtNQQhb8675fg14pAoXqJyXRJosrRvuJ4trJ887R
 mBrBLi68KkWeo2dYy1nahvyyQUh6WmWgMxw6HxDKiSWt/NNIZVJJHaqqH42FXdq4+0fP
 xbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787577348; x=1788182148;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LFyU3mWvGyLTGThD9sv/hYIL2x60Kcu9mNScGO/gTbM=;
 b=M0qPd8ZhaRTb75+5S3DW4/qvinwPx26RCJsX+FM7wrZtmx7I14UGXZEKmSslO+5BFo
 RTmcgZcdLXekOP4lRLwwwyaDuDY9CdZ/cbN/ptGAWW2+I8kOy9vWxiP8nKAluJx4hjCz
 TySYqC1CNSGr50jzow4ofLWnsNsk9Mij38e7GaYKDo8oWodwpwimwE0jidK2JQmcEbEv
 o/hjEdi7IR7L/at8k5GTFJHQfP7XWiBXCa7SCnjZkGc1oEEiomUnLuAHfcZqRlVhtRYI
 Jof8aeuUyosIIQWv64GMg2HgGDKWgSTE6zWcPQFq5zlvtg/hAYImCxrn2RbnnCrMX/7Q
 r5sA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoeaKCmgX5D8Jy08yWWSAQkmcCCwHia5nBMPw5WekD0y+FaZSd9pkP+xyUh9Qv1KBNlg2rqN/msBO8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++npOZZ/51HioMbI5XU0/VGnwhLsKkt7v5vSH/VTVTuSi+3em9oX
 Zkfy/Zviuo2oJosRtzxsb5IO7ZL51sYrdb+YEz1YPDYDjR9KkN9QhU6sonHjjRy9Z77O5vTRKfw
 oTP/GFiUZhZOawZQoNgswe5b5IjDshR74w5XvzxYLjRh0Bn5mEp8n/+IPGuyuESQA92I0z/Y=
X-Gm-Gg: AR+sD11zdeaYEUmbn5qAgzOCCKKJv7N0BN9oyHYGoFaR59/jQ/vNBx0loub4nCn2b/G
 cafeUMeSBXNmaJyktM+hf5F0BZvU9H8ew6zbE2gXUBMfZ6WzaVEh8EDTQKepvbtfQJ/QBckyq4/
 L68NaFdmTicO1r+gCMBWqfDduKlRPjL4EFuXf1XhHmO9ku1A9Rpd2hjqh/A/A4syQ95V+2iPamu
 gBYeVMXxY/NnmhgpRIqc7o2b9ohrHfL7KfDIROwtydhPdNcTmp7XRtTHBD9UdFYVLRqbHehH4xt
 42IuePnvDUpGJOu6yZ9p1tv9sOFmGT2mHGbMSxNX8m2zM/97gz0TpS5WZ2/ce6jJHmgfLEKikK+
 E1/oPAQ6j9CkSDB7mcms1Q4d+
X-Received: by 2002:a05:6102:d8e:b0:778:1bcd:ddc0 with SMTP id
 ada2fe7eead31-77a5f8ee1f7mr3817890137.0.1787577347807; 
 Mon, 24 Aug 2026 06:15:47 -0700 (PDT)
X-Received: by 2002:a05:6102:d8e:b0:778:1bcd:ddc0 with SMTP id
 ada2fe7eead31-77a5f8ee1f7mr3817872137.0.1787577347380; 
 Mon, 24 Aug 2026 06:15:47 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b48cda2b20sm1739539e87.25.2026.08.24.06.15.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 06:15:46 -0700 (PDT)
Message-ID: <315db50d-6553-412d-8fca-a4b4441f881b@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 15:15:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/msm/dp: skip LTTPR init when no LTTPRs are present
To: Saurabh Anand <saurabh.anand@oss.qualcomm.com>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Ritesh Kumar <quic_riteshk@quicinc.com>,
 Vishnuvardhan Prodduturi <quic_vproddut@quicinc.com>,
 Mani Chandana Kuntumalla <quic_mkuntuma@quicinc.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
References: <20260824-qcom-dp-typec-reconnect-fixes-v1-0-2825e5bf8a96@oss.qualcomm.com>
 <20260824-qcom-dp-typec-reconnect-fixes-v1-3-2825e5bf8a96@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260824-qcom-dp-typec-reconnect-fixes-v1-3-2825e5bf8a96@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExMSBTYWx0ZWRfX3T8gHsyz+uc3
 SzdTlw4PztAIXCfyj12oCMtQfuO7ee4lRYEzaJO+lxoaweLmfC0hrXeOepisLtDXHWyiC6huHdU
 qI7m0uN2o6oFoWxf3gt0asb+15Xgf/A=
X-Authority-Analysis: v=2.4 cv=Wac8rUhX c=1 sm=1 tr=0 ts=6a8c4404 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=HlmmvPtyU3BZVRE9FHQA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: wNigA5mIq_BH4_67WislnrHwGQFOOCTk
X-Proofpoint-GUID: wNigA5mIq_BH4_67WislnrHwGQFOOCTk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExMSBTYWx0ZWRfX7rzhCv7EJe43
 X6qMmc0JNReYjKyb5358rNjWsDOD+ABYMDfQw8UK+NVzFoM5i96Vam5qjJQQRnAR0jPG1T6JdsE
 q8dl6h9imOhC3fYwEGVeSZUxtxLcCUrAcVHevO2+U5F+8lANH5rsUrTP27iQ0lbbu/eEJZpvq9F
 xtbLkihD74KgBcWhdYCr/+NNvSEsQHyAIGkV+9PyY1rt+AOwzIb57tq9jI/A7KtnHL67pxZ6h6r
 9W0DzX4kCH3GxyZmWRGyBs9pl6da7Qg6iSJ7dWGq5whQW7RxeLseaUMggxsSonPPOY2/DBIc9/t
 ea4RzgS7gj9DuFUhPUGaI8/F+SJejFofL7gu1L1wVNenkbLC/yIKrdia0k1C7XHsXxoJzuQJZoB
 paNrMiIIeV4ibS0PsvNUVHmHM2qlUL43moSj71H/cjSSGGpLY8AIWKUOy+MoojoyxE50eTasUYH
 HIIOj8r0bWKfyRedDJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240111
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

On 8/24/26 1:28 PM, Saurabh Anand wrote:
> drm_dp_lttpr_count() returns 0 when no LTTPRs are detected and a
> negative value on error. The previous code passed the result directly
> to drm_dp_lttpr_init() without checking, which would call into the
> LTTPR transparency-mode setup with a zero or negative repeater count.
> 
> Add an early return for lttpr_count <= 0 to skip the init entirely
> when there are no repeaters in the link, matching the expected usage
> of drm_dp_lttpr_init().

Reading the body of that function, I'm not sure your statement is true

Konrad
