Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB009C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B40D10E12C;
	Tue, 30 Jun 2026 12:39:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AhXU0K1N";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GHAlMtw0";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 766D410E12C
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:39:17 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U9n2b61602961
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j+0Tx25hFjaHzRNkLyNtbTDFfSp/eulHhiy7NQz4/zY=; b=AhXU0K1Nf3o7hIe+
 5inixK4SQz3a7GOF0doOZ3d6lGTX1peoFk/Aw/reVBsilnEOhcwnvUjGsNKN6LVW
 9/lg2AKYC/dxUOAWlYYde2OXi/nx8t2gZTtwdSPUjxTdf1ss+aoz1+zTdS9KFAVl
 15opLDPFxXbGqx5SoxixFqiXBaDN9ybNSUZRGvAhhYGwA1A6bnDz3ZIaH87H52s+
 iRBjEBUyl4nR5vfV1EvLwnokHifuTBtoeCohE+9HHBHXRBfy/KlvGBbUUkv2co+h
 madwEOSh2PZidgsAnJFI3cjXgtH9DhRdrOUy2IDykIFTaePdIf21edNObcStvN3E
 mAYgmA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4avprwvv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:39:16 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-734f7d8bb37so430919137.3
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 05:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782823156; x=1783427956;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=j+0Tx25hFjaHzRNkLyNtbTDFfSp/eulHhiy7NQz4/zY=;
 b=GHAlMtw0UQEu2E19lwnVhJOuUusrDWf7JwqeoFXwHYaxCXuLHkjFibIs2T2t6xERTR
 Ov2NBnEEmxBC1LyX9kOPOWh6t8ReRWaxWgYARNA28Xnm+64FjfecUyOf6JPiwiaLvskJ
 L+Fzd101rd2xDyjCnRkC39s7rzll8pxyRXd+84Eu1dMluY8Kq33qjnp21976Mjy8aCRc
 fHw5/XsnvkaFwiZEjBeHtCjheA9zR61cCTTnuX0dyZln/jbRn4CTCfZw8fPH0Cyxw0xf
 uuNwVHbICpks/BRxqocYlU/Oq2dsO9teeYyxxF89m6AstT03rOhK8dnZbG20mVFxNz9Z
 2bHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782823156; x=1783427956;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j+0Tx25hFjaHzRNkLyNtbTDFfSp/eulHhiy7NQz4/zY=;
 b=E41JyCofQsKCbd6R1CyDWmN87ZjUHge9ymJsg8DQFnN2UCwRp6WHLFaKCvspNFkrc8
 +kk6OFgXiUn1mpGjiGqI7A0mXyw+NXctg7zz5L3+zEucc1BhVO7phteFtS7zsImM9kst
 nZcHMNFUg5oGAcr0nl/m+V/Ib9URKUJkN9vm0D2UOLDGP8V2r1DZxKqXYSTerRmQRQAB
 PYf4Hut0xdxiSm4gBzAj+Eq5W1D8DCxcHu5gCn1j1X6ZLCXP8LCECVfhculnmIyj9qcW
 hxWmkaL9fQA+wrw3nOADVHFeLqLUSSRR74/fm0xeo2JudB5jQACOy4905jahPc3NY7yT
 2qnQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrEeb4dgOy0JRxtJu7+WV6/8OAFfA7a4PM+SxjFqtgMnNzIg/EqpLxeTDWlh0TtNGEw9+aWCPG7i6k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxdsjJpzjzKu3NJu9vzWUMucmnaVq2OLRUaQCDoNzrMUQrZ4rkh
 Oo80QVDnhT/a1X/oUQvsFNAJXtwktE5QtlYx3kByR1jZnCBILjGzx2zFFew5ZoNY/nkyANRug2m
 fFSRFxEpWM/etnK6rAvCC+LxR+VmkzGHuNPkFyl2jU2jPOEWpBancWDMNuvK3vcyliJkSssQ=
X-Gm-Gg: AfdE7cn7ufZaPb9Lzqox+aqFmJsHfkE1n/zaAEOskNW4//1nKZc2wo9YgG7MwF1mn7S
 oOgipiaWyjy3VicQRfk5jYS1ItVVIyvUFUKyaQ4XcvQGw+yDcWkfdHF4BQeoJJ6twXFTQteAcQN
 LKnPVYwc233j3JuEyh3+FhV2b0JU1fFp9QHPuSclC3A0TnysqIw53s0UpLJvAhGnBYNnAJED194
 0U50L01SDdJ8jm4qQBGFylTUmsmhuJWGdlgK2K/XmLkqK1m6dz9EZnL9brujUbPRw7oLo/X+JZl
 EqhFBejUyUsoBnYS68jY/zWk4kGpiPIWO/qfYWMDNhEee1bPZQnQ377t6ICyK+LnBG62x4Tn9Hs
 j28HblEscAwjAvp7j+MX72Osh3HARDmo4MzU=
X-Received: by 2002:a05:6102:6886:b0:631:b312:a2a6 with SMTP id
 ada2fe7eead31-73a333ba5c0mr489617137.0.1782823155807; 
 Tue, 30 Jun 2026 05:39:15 -0700 (PDT)
X-Received: by 2002:a05:6102:6886:b0:631:b312:a2a6 with SMTP id
 ada2fe7eead31-73a333ba5c0mr489583137.0.1782823155407; 
 Tue, 30 Jun 2026 05:39:15 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6987c3a3bc5sm1155708a12.5.2026.06.30.05.39.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 05:39:14 -0700 (PDT)
Message-ID: <f849f648-6891-4e51-89e6-dc803d07ee16@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:39:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/14] drm/msm: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
 mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
 mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
 jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-9-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626133440.692849-9-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ott7apdnZae2Ff1pAWjWltLT0T7pPWY3
X-Authority-Analysis: v=2.4 cv=KqJ9H2WN c=1 sm=1 tr=0 ts=6a43b8f4 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=E6O5LMYzsyQa2pg2XTQA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfXzfbzFx7mL0w5
 A2DlTRIiojDzmfQM+vTSWARMaAVJOWu6smzl5u3SNEBK0JKWhPhqSJfGFkMKXi9eDOa3Wg+/oDS
 6bdfMb1fZkJJd9UM4XDxHbUrTEOeoEv9rH17BK8fAS1+88jzgTthzaH6CEyG0BpGVFDdDyLHD8f
 ibPAXl49tcyDeQXKiAJbx40PdrYqPv7/OGRc9cz1A09h1g+voj8w3PoRXBsYiSQYcPWd6uKi+mD
 bes6Jd+COaMyHp4QwZNyYc+ULRP/idDQHPeiufmHPurEgUIUIwFSdJBz+Ut5NkVrqpxj3nRpbJ9
 IveyHRtc4Rk5Uo8vomt+auJgnHTxGO45QWE4xau3HcDUSNyQoBh6HYdKreupmMK0EwTbNt6zL0J
 XDbrv7muxOJlW8IsixRIPLn0L0OkaYUXIpwHWVaGkTeLD7NGEPykm53kUAfpXqCJoA4nHnpyxn9
 2JwKmOgpQKNmVzxTj6g==
X-Proofpoint-ORIG-GUID: ott7apdnZae2Ff1pAWjWltLT0T7pPWY3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX0utKsIpmeBvW
 muC4NaZuXsVcgk803QTNTRxwGSXdnE08jlXgDKVer+975SA5yNAxY3Y3nA7se3DHFC+nuIe1GBo
 RZcxZ6QrvE6Exky5Kfr2irQqaQ4Ley0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300116
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

On 6/26/26 3:34 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch drm/msm client drivers over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/Kconfig             |  1 +
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  4 ++--
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 11 ++++++-----
>  3 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> index 250246f81ea9..09469d56513b 100644
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -21,6 +21,7 @@ config DRM_MSM
>  	select SHMEM
>  	select TMPFS
>  	select QCOM_SCM
> +	select QCOM_PAS

NOP change

[...]

> -	/* We need SCM to be able to load the firmware */
> -	if (!qcom_scm_is_available()) {
> -		DRM_DEV_ERROR(&pdev->dev, "SCM is not available\n");
> +	/* We need PAS to be able to load the firmware */
> +	if (!qcom_pas_is_available()) {
> +		DRM_DEV_ERROR(&pdev->dev, "Qcom PAS is not available\n");

Just "PAS", drop the "Qcom"

Konrad
