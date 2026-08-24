Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4155C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:17:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53D2410E1B7;
	Mon, 24 Aug 2026 13:17:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MyvUv0+u";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f4leWH8u";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7257410E1B7
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 13:17:27 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OCusnR2583541
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 13:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Tnp3mVv+VBCQVYi3QP6h/5zemYCms26RoK5XuVNMynM=; b=MyvUv0+uT9xblodW
 inR2ESKXfi2i/MYmnxDGXmaD3+heVXlWTgBUZeHI7tFtAWm7XN4ZI/JR2uMkiP3d
 b0rJRPNuYQrNyonn6A6ZWFyN5/T9MX3s8KV+ct56VBCBA8lBJ7LyDQq1W58W4UDx
 5Shl7HTW3K4NfqUd4iUOj4Z67MPaNRXGPo435us9kTQPybq+T+v2mUVuIhsJlgAa
 ItJcbwMqI1NhkCyFGqDSExToB0D9PzMbgEY/4WvXmSog9Y8Dy1MZ3JWjiB6gffda
 egZ3i3M8yIPotzB2BwPPzwlze2DLNSbWok1s9w50Gfcd+hxUQof7OKNztKnMG7/c
 5bsdnQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8hbthhqg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 13:17:26 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9349ba88188so50996085a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 06:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787577446; x=1788182246;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Tnp3mVv+VBCQVYi3QP6h/5zemYCms26RoK5XuVNMynM=;
 b=f4leWH8uCoGtF3ptt73bPnx+VT9F3ae0e+Vxvd8CbYkJD0LaSX5fE/eF7henNthw+k
 lGP6DxuJ5xEJGvrP6rPEbxuajGWxei/Wz0TEbGLe1EejJBemXQ4OtFANHOynmdgHNAhF
 BrOZiwAHIlZqfEigU+2wP9MG5PQN3gJA2WCAo56ARJGqPsbozoJu3oltj3yRT4YwwPAT
 ORoyQNFewCYHTh6kl0E1uaUtLWLa2CZNb7zousjtrlNIuZTXMnf40hvOibfW2dtC6Idk
 F9TP71E1ItKHpv7bZVlmH//PINDJhC7loZwmmZozYwTMmjFQfMN+KdTW7+x/hVwH3APo
 kpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787577446; x=1788182246;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tnp3mVv+VBCQVYi3QP6h/5zemYCms26RoK5XuVNMynM=;
 b=DAsI9f8Q7Lx7jANfP4kghaoam9DPiXOfUlc6SUHBgnh9l5yNal8mIjLQ95lKk20eo5
 xK7UUgJiKzi0aTh6+okOJafopH2uVrquGxu8U9W8S48HKW7RqqJVu89XzUA/caB7Mukr
 EeslR0yjZBGXI995JLLQTjiXFeUV6et7vk1XaLRTRhQ9Dg30hzGFWwf1G6UPeNSSlB5+
 fPrCz3X87170gEPsx8gg2fMg9XMy+r9vN2PqxdcFU6k1UTvTDUUSkyUa+RS0TSKRnwMA
 ZnWcjGgccAkQbGGKa2DONy5WHNcZTB4JvVhu8NWkGEyGkUpDPri85icPbv6a3AJQ36iH
 n5hQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoLfm7l8DRWyv2TnuzEXyxBDd+OgYGvBXDkY7K3Uqh71Yh0BbziG/+/x9jnJMe+hovUyZTKTYxWRhk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mWZ/FdL0ohhjfMZ/c4x0symlYea+6YkesQ2sksLyvsZBubiZJG
 G2RXrG0K7cSy2kzg/YajGnKf76sMXU+ASzUurO9aGIlEBDXG3pziMKrUNDxX5wY4kp7lb/rynRN
 kDhmkrZ9+75VI04VlKw7fI8kV18A/5rmgfX5MYNLKzGBQtpeE39HHyByPtYkhPABN7I0KAMk=
X-Gm-Gg: AR+sD12Ls3oN95Akt6bOf2TV59ioGRWF2viCitAuVGG8vzH67E93NL/jPYqyTykU2XO
 OWeWRDwx51Fh48BTGVtd7tOChhdu/XTisvqeo6N1meG8kBBBcurOcpDkRpMpFHNrAlOpauCFOfJ
 tFSv/Q2iqK5WBc8uA/qdmmVJR6wM/K20THhUJX5FQCROV23cBB1LV2fovYMggDZ2MdMmxXP3gha
 HskSM/IYb7sEQgyLKdtuM7BVW89XYy62shzruuuqdm4OvHtazVzXjdf0gHbd8XbQJxJuyFfCNMY
 aeoCNnh3gZzdGTeML46K4fX9mlX+gYnmx0/xrcLPsMfJ1JyBijTaGAHm5n9A1uI9bW9ZonlPvfK
 683Xp0y0ujTlNw+yBOHrWSGD/
X-Received: by 2002:a05:620a:2806:b0:92e:6485:f640 with SMTP id
 af79cd13be357-937395ae7ecmr1681795885a.4.1787577445643; 
 Mon, 24 Aug 2026 06:17:25 -0700 (PDT)
X-Received: by 2002:a05:620a:2806:b0:92e:6485:f640 with SMTP id
 af79cd13be357-937395ae7ecmr1681791585a.4.1787577445186; 
 Mon, 24 Aug 2026 06:17:25 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b48ce294a8sm1757332e87.81.2026.08.24.06.17.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 06:17:24 -0700 (PDT)
Message-ID: <2b1e73f4-a476-4dc8-83f2-42be1008c1fc@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 15:17:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/msm/dp: clear force_link_train flag when link
 training succeeds
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
 <20260824-qcom-dp-typec-reconnect-fixes-v1-2-2825e5bf8a96@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260824-qcom-dp-typec-reconnect-fixes-v1-2-2825e5bf8a96@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExMSBTYWx0ZWRfX7KXsoshdfupu
 Rlt3CJyxScIiPCzhrZUK+PjSwhSQdZ6I+sw5LXtqKj+U8y3cXzgkiEICH9OjUiGj7fUEnb8+/Sl
 KhRR5zT69ElWfDVKqXuBpWjVqNmYgZHO2S5aT924LjX+s7gZPvoEuMeDSz5/PMAOSEPaxII/+EE
 OThcP/8ihsxOZmKJTkmDm6qVLGe7yGyHdPs91M5DuqbV5d+eNB5aVA9MeQLB90/OWUXe2FOAys+
 1Ck93kj2GLP01P78VimOMJcKQf8k8SMejgKM3si2IkQ15rfKegc1Tb4fCRaDkkTMV/XB9Y3c9je
 rzFlXEHWTclAk4WMa5q6KH/ktREvMnKd71XzJhtM3sLNHX4yMA7jdrUP1A7j1mZQ38dT5AFhdzO
 ONEl3E9n284guGK3qseSps/aQAW0WKq3sL20KSRAvuaAN3+9JkZYWh0YU5O8rMyQSjGLHqCFcbX
 DQpaYhnDlFfqWMZrBsQ==
X-Authority-Analysis: v=2.4 cv=JL0LdcKb c=1 sm=1 tr=0 ts=6a8c4466 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=NP0x2mC5TxarURSXHOEA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExMSBTYWx0ZWRfX9iY6hdRNqyMO
 MZ0lNaZ0kayTHQ5rDscfxuNXbkFcEvLP3KYIX75t8Z5FfB9EmM0Xs1qPDs7/cSlCoGXaJobXA1X
 hTFEfT6Rd+E6gfhW7EVmFbRaDD2+aAs=
X-Proofpoint-GUID: pi6BHt8ohPxCwCVS9C1Oi7R-fkr6tLkq
X-Proofpoint-ORIG-GUID: pi6BHt8ohPxCwCVS9C1Oi7R-fkr6tLkq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
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
> msm_dp_display_prepare_link() sets force_link_train = true before calling
> msm_dp_ctrl_on_link(). On success the flag was never cleared, so
> msm_dp_ctrl_prepare_stream_on() would unconditionally trigger a second
> link retrain even though the link was already trained.
> 
> Clear force_link_train on the success path so that
> msm_dp_ctrl_prepare_stream_on() only retrains when the channel EQ check
> fails, as intended.
> 
> Signed-off-by: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index bc646d172abe..40e19d506a45 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -649,6 +649,8 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
>  		return rc;
>  	}
>  
> +	force_link_train = false;
> +
>  	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_train);

This makes the argument of this function useless

Konrad
