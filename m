Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B9AC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9864F10EC88;
	Tue, 30 Jun 2026 12:46:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UT9LN4wv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aCsUHyjD";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 734A210EC7D
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:46:02 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U9n1Mr1573374
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pY1T4mB/1x/HK2e6EPQsvZx0ZxpL5KScVB8u3NbiQqk=; b=UT9LN4wvBVpM64j3
 F2jAsfAILiZjYRi/KlD2eQ0MOKeqL67WC5X0+CrsUEriaIWFUiaGoLlo+n3Pwl9J
 uHDa0/8eFWFat/YWYLfcEJwEd5QF6bX9Z4OwXSJPbGg0GoMUjJkAUkQYMeCuapko
 T5OrkD9h97gJvlQSqmdsZWKCDQzeVfYFjItUkRfQjt7L4093O0XaIj8fw+CsdQzC
 6IzFQuULY5XFAu2s+/EvblbwfMuHoMlkrDqXKEflaNf/oL5S1uzyQqnYyoqrWkwx
 yTqAI/l1hiSsDIEpN5kwtUvgfTLuPIyzfTdhrgxG+nHg7+1/Cl2Pv2f0ACbtuBXG
 VvR2uQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4686289q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:46:01 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-734f7d8bb37so431245137.3
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 05:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782823561; x=1783428361;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pY1T4mB/1x/HK2e6EPQsvZx0ZxpL5KScVB8u3NbiQqk=;
 b=aCsUHyjDbA6MBiSxRegcSz0uVYvn7w7YmFZ0v7+1G2ZafbvDeuuZIM/dou79zCjJdz
 6pcIW2Lmmsbj0UeGzvJ66aZbOcQNdbI17ldNuFll0HCqkL8fQD38EJLBWXIRvQL7CKW5
 N9L/Oea2/udNQwnI2EQwTcMigCqRVVOR2VpXga9TiHA/Fa5cPzF9J3l8SrDjBJabUELO
 dI754BwEnGHOx4YNfaNLWtPVxfpuemj/goRS4KucfNW7816o+CKkJoS7c0UJmqhJ/i+4
 G/aIcAY/Ua/Je+DYWvRU/uzfWj0Hj6mMw1dEC31q2Rzcul0+xxxxtq7uSbiOfOW7u7oC
 sPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782823561; x=1783428361;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pY1T4mB/1x/HK2e6EPQsvZx0ZxpL5KScVB8u3NbiQqk=;
 b=tZzPSbKhKM9aba/w6YoBHzXn6nKw9x6bTVMvvU77MVkVTXw+R/DNpXIpziF+88DzvV
 8/bi8wp8LWduH94nzXi30+e8Wc0LWyvOjTjCa2T6h/veZauWYo1x17wegB3P98d5t1Nn
 TsPh7iVjHRIpGL/OG3WhCBID0zvC6z0XN15/xiLHH06rYySb4/OEq2mTYqiwDlMVRXic
 fonL0HerLMJXbLnvqdbnBLzf38sQpnI3Y0MGHOXYEVclVbGkkqxEh2PdFT4HJKmXPxZg
 k/gIw8JXqn/XPPenN6Q+iWZ1HKgXR1dIK3GKWbu2qKq+fBXvuqM+7DhXn6nXU2dzxSOu
 K9pQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RprrZ+jJqQsFEXjVFmsR0OtPzB6Sle+UEwtlJ3ehgNUU2LvnU8s7Jq/kNK0NCXzV41uUOdtn8q3bb8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyalBZ5MdlDIUtfM6c6AuQ93CaO4L/P+EfTtvIFbAQt8wcpdjBS
 l6Hug+nnFOsJm4kD6ROZWVEN45I3lXYi9/bEPntlFKoIb9kfxKlXD+lTu4UvjvisqySjMY4YbdG
 5U/StwFyjWVwh0ENmQQOKPKJFC/aX02MD+LoFM++9sbfahRIDaSr/+Mxq6quZyLzjhnNz8MA=
X-Gm-Gg: AfdE7cnuqKG/bDJbXWg4Yjq1Jq6kL2HHsMw/OhxRbfvFG4i8BVOZ/MsH1D2sA8jW6D/
 rg055HY42T/L0FjrQ0oGbIRMviNn6DL6hcOXOonxPobhOMcq3YE0TwU3QDwy4e2bEsXES+MVwTU
 XzIQNpPId5lgEtNKXnra7XQbair+YIVoKJjV4k9CBHxnv6zTmZt45koYKDmMpfln2AmbSVxeA9m
 4EwBV9k14MCwW3ztBybFO2SQDa4z+zdc4clfoV8luI/yvU1emef1fdsuDm03HTA6DvXflvJ8Ik4
 SFHLQ1sM45pxpxlCTZzLrVFSmSLil8dOk8PJ9ct9I/qnXbkuTRhwDCdyYpTEY+urAloD/986+4g
 0pHFZ2XHm2r3Ae0HTRRJSPOlHAEINW4SQzK4=
X-Received: by 2002:a05:6102:5802:b0:729:5cd5:8cc4 with SMTP id
 ada2fe7eead31-73a38839d2emr587878137.4.1782823560939; 
 Tue, 30 Jun 2026 05:46:00 -0700 (PDT)
X-Received: by 2002:a05:6102:5802:b0:729:5cd5:8cc4 with SMTP id
 ada2fe7eead31-73a38839d2emr587855137.4.1782823560577; 
 Tue, 30 Jun 2026 05:46:00 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6987c968400sm1131274a12.25.2026.06.30.05.45.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 05:45:59 -0700 (PDT)
Message-ID: <b14466a5-a064-4723-8ea0-98239cd50437@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:45:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 13/14] firmware: qcom_scm: Remove SCM PAS wrappers
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
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-14-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626133440.692849-14-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: bGiLAd_h38dlvSAEgQkzM_q25weTSnl4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExOCBTYWx0ZWRfX3pzG4FNbhrcN
 y2phHwvACefiWMdDovh8U3BAQpwpeQqkJVUQCJiFnZriPqvCIUCjkUP98XtUJIUKNrwEk6Ebrel
 cof0jt4Cor9x8+IVMmMFEex0DlZyMM3mY25mAVRU5DYhxuigZvQp8IM01QIMizOSdUkZ2zsMaIT
 SQ+39wn82bBXcdGQwZYhaGWLYkFH6vaSoj0sBytOiRX6YfQ+3uLJNdQqvbtA58DyVyeqw/Dcuin
 bZAxDB9mUvyNj81rG2THEST38xkbPhIckpVpkvqs8vPCp8lhYklj/NWQUdPwPd7NNFbeNkaZHCi
 rYhLTieiDNDZ7zZLfk1nw526OOK5xKKrC+ZEZSg8c8MPEEKIhgdk5mrCj0KVF1COjetfftrLe3N
 5W9hs2s3LQLK0Le27r74NMb6Kht4NieaTK/t8rpqsEt/28igU81fWc+Ucd2WEf895GO2k/5eUF1
 FObDOccnbL5LiY7oAIA==
X-Proofpoint-GUID: bGiLAd_h38dlvSAEgQkzM_q25weTSnl4
X-Authority-Analysis: v=2.4 cv=FbcHAp+6 c=1 sm=1 tr=0 ts=6a43ba89 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=n1VOVlC_Xzu4QXtT9DgA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExOCBTYWx0ZWRfX5IikKUhCLf54
 jArz3XSViIXi7M8boP8IKokfJEGrdzLU5iiHf/bL98/dbB/aJZ8n5VLCjoThpxBflHvTGxGA8Am
 hPDh+LtdSbNbqYCr6xLyz2ZyWfgfLOY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300118
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
> Now since all the Qcom SCM client drivers have been migrated over to
> generic PAS TZ service, let's drop the exported SCM PAS wrappers.
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Tested-by: Vignesh Viswanathan <vignesh.viswanathan@oss.qualcomm.com> # IPQ9650
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
