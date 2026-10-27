Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C0F606A321
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dNk+1EAY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AMyCiU36
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 841C910F42C;
	Tue, 27 Oct 2026 12:05:27 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1147310F42D
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 12:05:16 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RAe3uQ432370
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 12:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /nGrw5+P3Y0pEQR3QfmVNANaa580jD8MzWmdSsoabTc=; b=dNk+1EAYHKu1SkT5
 NZaJqZrSsebaw/pG8/B8UGFtpN04c7sFTDsnVYp8VJeNtOAFONCavKky3Jw49gyZ
 HgiALa8r0pqhmWwL45lfha85g7MsIGCUCbSFjxZeCp+Bf/N+nnBY8TAy7eKl60om
 TA7lSbQt5wScaYf01w6pRO4jth1T1b+/rBPyGUwBzErUIhoFQVzjHViiLdJ6hNLN
 xE9B83B8TojrqLhC50iJvii9sJ3v3bd9NnasTdvctEL3eR+GyIlEi6rtyex92rs5
 fmjhwM082dn9r20UfvaQEvC4yKiaGn4M2aF8JO4Pl7UOhLMkw/6q+JtnLxw5zI5I
 YCr/GQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjb54kp30-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 12:05:15 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ac8f449d1bso3772074a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 05:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793102715; x=1793707515;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/nGrw5+P3Y0pEQR3QfmVNANaa580jD8MzWmdSsoabTc=;
 b=AMyCiU362Ut4df62oTTP4g5KvtR7XRlyQRY0OaEA87V18teXndz7wdpDNH9sbUyptL
 UKhDiwe8LEtJKyyUQpRfDSR315ZXIo4sIYQZGtYhjRpN2OoamD7wG/4Bfj9IMmnEL7OT
 NmMifQAnGxrMra+seuVXAvCLpf65CukbUwbz7cAOqlUh3xKrDIxX68HlbS4yHyzwTruM
 AIZDH3GsaXwMqTPjf1wlDu8sr2nz+ZaPrWyB82zJVxPOYWg4CCKv0PV0lMIDiVnwVtT/
 ERzAKhf7l4Kjc14+YCjGq5+WG0OTCx+ZEhf3EtV1xhFPpUd4N5SBrcH/URE8nbebT+li
 B/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793102715; x=1793707515;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/nGrw5+P3Y0pEQR3QfmVNANaa580jD8MzWmdSsoabTc=;
 b=nCbw5XQEjQqeh/i3ojKuK3Yf9cH5VZsCaFeQBzXZJv0KgmZcRvg1EhTnyRStBqREh4
 tNEQMkbtQQydx0AA0iCa5/h2RhoWsJkEY7R1l3BhH+I0OqmyZhr9Rjz+1gKsCBz3NgG3
 aetLRQKXIF4x4YLRi1U0dtnBWvT8z8ppfmEnW4/hc8bAj0N8WUyBxeTBab1XVE5Oaqw/
 qdfnzbc6mPA29gNDvjuB2UbZEeoRmVUNEs3QIwQHaT0Q8pYo+nJ6edg2aj0V9/v5WszR
 VLxKExVWwKu+1lHBOYyegxYxpmKAOjsAJOlfEPabWnYGlQ2sjo/5xd1qLmmjVWj9Wj93
 jmMA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDRAYB9rsWIB5olc8msh5Z/8509TW1nS9AGhCGtKjcvoTq4HBQE8c3WNHnA/1g9fg1M+3qP0Cy/wk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK+0RzDm0AazamGksV+6h7THXZuGGuwG+zoF1u1Hp0aXABgWMcN
 JsezgcGSB9NfvPe/B51bQJwbuiCoqb1iJWjzw9jwTBPDhIu/ALPbA+yn1tiIGfA7zNnNFCnJoy8
 Q6bFOt6sUUaapAbmEQox8QiKUIOIcRl/o/qjfGdxIzBIq7ek7nd0wRMfhinRdOznax5fhysc=
X-Gm-Gg: AYBFou1/19TdoEA3asyzli45EbmojZMQBwPkMCE3n3JRpOu8BlxGTT1KfjnZ3jd0/4s
 VFBa9TluVZPAbQIzTQ9y2DSIR2m8B3fTRIwaB2hAFFTTBBtnc0Z9UddP7qYStuR92sIvUCtHEUV
 XAwfvSC1fTgnSt0awF1edWV5YIxfooMcaceyp7HkKDnNK2Hbazm7JYqEToikHxA6mj0sT/iKJwF
 0kqn2RSNNn5qLIRN2R8GTX1Tr3XqbRIgfcifr3JR46g71dt8wpA9YmfxxwmQTAcniAaSX21n7FV
 6H3pWQ5AvUq4gCSn3ACRJi5rdrJGMwqhKdu8Yp3BP+bWD7LwYjJM0ufj/Z7yafcVnxJpqF+7Z+c
 h2mp4kfAxuphzwRTiEb4JrIjN/q6oaFk=
X-Received: by 2002:a17:90b:57e3:b0:3ab:17b6:9a93 with SMTP id
 98e67ed59e1d1-3adeb0fc65emr8055391a91.52.1793102714684; 
 Tue, 27 Oct 2026 05:05:14 -0700 (PDT)
X-Received: by 2002:a17:90b:57e3:b0:3ab:17b6:9a93 with SMTP id
 98e67ed59e1d1-3adeb0fc65emr8055353a91.52.1793102714216; 
 Tue, 27 Oct 2026 05:05:14 -0700 (PDT)
Received: from [10.204.101.238] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae404746b3sm3697041a91.17.2026.10.27.05.04.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 05:05:13 -0700 (PDT)
Message-ID: <1c24fbfd-bc88-41d9-8632-76c5dad9f2c8@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 17:34:57 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] media: qcom: Pass proper PAS ID to set_remote_state
 API
To: Sumit Garg <sumit.garg@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, bod@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
 pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
 srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@kernel.org>, Sumit Garg
 <sumit.garg@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20261027-pas-id-media-v10-1-8a5312d3050e@oss.qualcomm.com>
Content-Language: en-US
From: Gourav Kumar <gourav.kumar@oss.qualcomm.com>
In-Reply-To: <20261027-pas-id-media-v10-1-8a5312d3050e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0OCBTYWx0ZWRfX3m1dSBJnHU9o
 xyLnecqtQE0e+BefthkW6kQoigQXKnyvFjaobB10UtXl7/Uu3tBfg8aUewV0VyC72cqnF9Qif/z
 00vIoMPTd8jMJWD10h2NpMxrv6Ntc7A=
X-Authority-Analysis: v=2.4 cv=bsnZl0ai c=1 sm=1 tr=0 ts=6ae0937b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rTiepDLV5_WpOwre6ukA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 9fObKUwQmFVzPdX-qP_SEVX3hSq0MGyJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0OCBTYWx0ZWRfX3sZ2EnwO9jZ0
 6WU2fR9zfgpzlc3WEp2FaPt80rgcYhdPOlxyrauKH3+6vEWNi8klb0Ecw42l3JhWdfQCJrOahNM
 I4VAaVv5LeP3slLEIXckvFfDN1YkDx65dJGUhtouFdeCpEQAkZJAMHJAFJWCNQqFQhaQ4uAqxBB
 G5QZXA54+8v4RTMd7aa2SYEgmqijwbWwo/SNqGEO7dzJoZWH+GgAfDQbXaD12S+8pxzANlWBQ0n
 DehdIDmD46ja0ApBIbRMLpg4GPsTwHc980sBXrien85c9Hq5Ow4Xhzr7XNXUl0LjdsbPolvRcAm
 zeUn0tk6h+LiaeW4QXf4NVWKoLKNn68PMcri9NgxpFzqdau5y0E9gOcBHEcJ7TnxdcNVA6GEGtq
 YAXOibRYlPHlyMCTtIfBc1YQlNz9axFQQKVQoNxeF0YcamR+eFTXlA9d2gLS98Tv1So1Qi8BQ7L
 Apa++2dnmF0C+PujtnQ==
X-Proofpoint-GUID: 9fObKUwQmFVzPdX-qP_SEVX3hSq0MGyJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270048
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/27/2026 5:32 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> As per testing the SCM backend just ignores it while OP-TEE makes
> use of it to for proper book keeping purpose.
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
> Changes in v10:
> - Resent standalone, as all the earlier patches of the series are merged.
> - Link to v9: https://lore.kernel.org/all/20260702115835.167602-11-sumit.garg@kernel.org/
> ---
>  drivers/media/platform/qcom/iris/iris_firmware.c | 2 +-
>  drivers/media/platform/qcom/venus/firmware.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
> index 21f57d37da18..ed2bd0e83797 100644
> --- a/drivers/media/platform/qcom/iris/iris_firmware.c
> +++ b/drivers/media/platform/qcom/iris/iris_firmware.c
> @@ -262,5 +262,5 @@ int iris_fw_unload(struct iris_core *core)
>  
>  int iris_set_hw_state(struct iris_core *core, bool resume)
>  {
> -	return qcom_pas_set_remote_state(resume, 0);
> +	return qcom_pas_set_remote_state(resume, IRIS_PAS_ID);
>  }
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 3a38ff985822..3c0727ea137d 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -59,7 +59,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
>  	int ret;
>  
>  	if (core->use_tz) {
> -		ret = qcom_pas_set_remote_state(resume, 0);
> +		ret = qcom_pas_set_remote_state(resume, VENUS_PAS_ID);
>  		if (resume && ret == -EINVAL)
>  			ret = 0;
>  		return ret;
> 
> ---
> base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
> change-id: 20261027-pas-id-media-7cc70fc5716f
> 
> Best regards,

Reviewed-by: Gourav Kumar <gourav.kumar@oss.qualcomm.com>
