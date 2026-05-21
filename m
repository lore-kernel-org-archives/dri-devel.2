Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742F8CD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 06:30:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D289D10E144;
	Thu, 21 May 2026 06:30:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="g7k0N3xx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QStjaMgC";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2CE310E144
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 06:30:26 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L0Ji49748495
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 06:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EcFnBmlGXUBnGQMannLvnZzhlvDc+81ZD8yCnd/foBU=; b=g7k0N3xxmtSzuTP5
 5D5t/X8ZeozBD6m1DF16BcKLvbd8VFULNoVRu3uRU43O+y7D1vZNfucCYlLcKJFc
 vl8fgFjDHUizBRQxRNmKP9rssOaKgSyHgpZh8HHzK+rTyzCjDzMwwK1kWDdqnGGr
 RZI7xXViQQI/bw1w8wH+Pm3wj8bhhdrR9zkLFFEE0g1Y3FXaID+SiKVJeDeihTsU
 n7YL2XKftFfGTCJSwgkijIzC05xOMpqTZr0mTHTaXR6UpEGEdecBbazHnwENBMoP
 qEe+rHKVfhZhbu85Ju9OiX5jOjVCKaDdoTrdDSJIggA/Mmr5UBtvw5l/STBp1VWl
 QsWIYQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9fb6k1mh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 06:30:26 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2bd04e4fe3dso101950395ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 23:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779345025; x=1779949825;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EcFnBmlGXUBnGQMannLvnZzhlvDc+81ZD8yCnd/foBU=;
 b=QStjaMgCokIC5t8VmzT2ZgBFALqJTGCt6qCR+ptpfhJ2OMgVShiecfD0n41yGeWLkw
 9I237Gwi4zDU6celCkHx8WchBmojbmkxdfg13/u4ESRLY41OISkYAF6fe+kQbi0MJ2Zi
 PFL3Pkj8czGAXtqRvsVcO6lrZvUxDn80ylXp8ZQRKvgb1wtmo+zY4vZ1d04zY9xM1WyU
 b1mV4CojExxARzs0Qt6k7cagW3I3SmidsUpkkFwHdPvKTqRwB8z78tpGJZqQm+9zPeDv
 ZCeL6xDDtBPHcY0c4uykxjHs/REm7OpjvOkJ1+0urQ9YkwdmtNmigB5pAVTIcJvLqmUR
 6Kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779345025; x=1779949825;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EcFnBmlGXUBnGQMannLvnZzhlvDc+81ZD8yCnd/foBU=;
 b=JVfZxpWqyIa+hvWwNSjuQB3tJa8pOj15ZWb/m56eJWarUGosPGl21ogfv6Q/4CoHYX
 mGFtLt7/RUvg6kM8AjlIhJTE8cA5VAF54cbsQgrdPOzKb26KYUQpiIl9tJNhCgXpC32K
 Qn5gcJzrnWWVHzl+dNWY8Ysmj7bsa1WFuQfDISH3y4NOni8Xyc+7jf6z9syi9ouqQ8CU
 BCy/W8hGJunCdAiJjBqK+rL2lGaI5IlpWTExYLiQUmTftd/GEL9IWQNETwIzjVzqgh/Q
 cZMxohlddmjjbbZO4R+JYZhjclhTw557YwMO79ojIJKZWkrJxixEqmOvhs4Kr70+vV4t
 pKvg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/h7uZcAMjM6JiIwiMLU8c/WL3SJBOWNnoT6BEpve/Jm507c5vGbhGGCwJsLHPoDXeytUU5cHevTfU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/5qg0hd8ZrkH1MXiZaZlYHbqifr7C0rzvREz2QgIZwz9JqQR4
 Tny+PRUEvrh5PEVHuOJF+cwlbfXmCeJ4/CNmAk8UweWImvQHLXXIlzbDiyPTrPJHSyHYAIUg5Vf
 pYV6sI50S4Vr0rxilLilazr+IuQHmBh44/ESaigPEVktBmepL3Ld0szO2cZekL6RS8+5pAxw=
X-Gm-Gg: Acq92OHF+75BlXUYg4bbDc7f/08Oaa4GltRb2cvMAQ0PEpWENgxi8EpKLMeXhFBSdnQ
 irNa+f8g+Y6Ym+0xv7MzZREZ9l6UEtB5u86DbPymrAyALCgFndrB/9DkdOd4pkxFjVBpvWVz/C7
 5M3ZVkh4M4gHq29OOgt3OzFSwwhKNubkLCDi3HWymMx40wpXgFcZBHP4dq4G/UXKSoYqfZeXSHV
 aa45NRQeANLuDX5W//r83CEzJL4PyKzDYyfxDsQypGuzgIotfA3awU8Oon57QRxUUdxZ2L2RxmD
 WNT/dmE85Dy/FQWY+KywrwSKVmonpuezEXB62tdEAyEjveACURIVsl5FpcE5Dk4xR7UChndpDt5
 1yjcAEPXvE3UDS43BpLM5ehoI9y3s07SD6QMISqinmpSjH8UfzLkzD4hG
X-Received: by 2002:a17:903:1a27:b0:2bd:ef12:14d6 with SMTP id
 d9443c01a7336-2bea33e5a0cmr16911095ad.34.1779345025341; 
 Wed, 20 May 2026 23:30:25 -0700 (PDT)
X-Received: by 2002:a17:903:1a27:b0:2bd:ef12:14d6 with SMTP id
 d9443c01a7336-2bea33e5a0cmr16910625ad.34.1779345024887; 
 Wed, 20 May 2026 23:30:24 -0700 (PDT)
Received: from [192.168.0.172] ([49.205.250.194])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c263a0fsm241748305ad.37.2026.05.20.23.30.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 23:30:24 -0700 (PDT)
Message-ID: <b62c2a16-9e73-47a5-8bf7-3878e21c3da7@oss.qualcomm.com>
Date: Thu, 21 May 2026 12:00:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/16] media: qcom: Pass proper PAS ID to
 set_remote_state API
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, konradybcio@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, dikshita.agarwal@oss.qualcomm.com,
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
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260518072856.22790-1-sumit.garg@kernel.org>
 <20260518072856.22790-13-sumit.garg@kernel.org>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260518072856.22790-13-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=do/rzVg4 c=1 sm=1 tr=0 ts=6a0ea682 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=X+kW/DRse7pI7A4riirJBw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Reuo-bjlSNWgIop-ackA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: vKRVnLff_NbzXLl-1haob8WBsKNQsl8t
X-Proofpoint-GUID: vKRVnLff_NbzXLl-1haob8WBsKNQsl8t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA2MCBTYWx0ZWRfX82nYbcqGRpEe
 GKHZ8470pFY78lhNrAwV6mDYfnWsj4C4xIJMss17Ymvo8sqGhujn+5u9yGOa41JCRCCcV/bVccH
 oDkm6DVsa5N7v+xzjb+O2CUtzqcwzw+ZCAbeKiolVHqJkhhUIENGQlwU0i4B+wAmr9iK3CPfaqj
 n4sFqsIJRlPkmrRlotjnpU8votKmdzZiOWAcwz+XVnCqMwCWVP7rNsdNCfnr8ZgYDFPV8pHbYCg
 T650SXwc3KkK7dZ/QcD/ryPKtTeKvyESHFxMPKc8kUhYtsYnEJ6VBnt7ga5J51yql9B5aRvelcr
 YVN3+kZ31IxcQs8K5nAbTDCKZSij1QARwZq1tTrNdooVU+OoOzv5UQfvFjYjRGwcpLjTBGwTA2L
 1jwYnnntG6slrJipcGwV/PAmK8RFTP17cQmcStU1Eb9Pa0L8SlOtFWxEJjU1Mu9475F6f35i+Kb
 HzDNV0Gk05gEoPw+aXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1011
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210060
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


On 5/18/2026 12:58 PM, Sumit Garg wrote:
> From: Sumit Garg<sumit.garg@oss.qualcomm.com>
> 
> As per testing the SCM backend just ignores it while OP-TEE makes
> use of it to for proper book keeping purpose.
> 
> Reviewed-by: Mukesh Ojha<mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha<mukesh.ojha@oss.qualcomm.com> # Lemans
> Signed-off-by: Sumit Garg<sumit.garg@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_firmware.c | 2 +-
>   drivers/media/platform/qcom/venus/firmware.c     | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
