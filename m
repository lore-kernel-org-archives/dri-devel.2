Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C28606A322
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PTLyfggU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XAdURKo3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6113410EEC7;
	Mon, 26 Oct 2026 12:16:23 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 042B510EEDC
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:16:11 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAtMQW2009940
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +LTz0oBJTc4CpLrS+/ZEJ4++07RrvK247eLZ+9FQt4w=; b=PTLyfggUoRL1+sjm
 /dcaXJcma7GaQiR9rDSTMAhb8C1uuduWHQ1g8oGnqheBndD0kclEKiPfTbucUCkI
 n6AqYRcXkAii+mT+Qr6pWfKFrkr8BF3iYjk7m/x7PCUAi3WKTgCQjlUwlpsdAxEt
 Bz/p6N029oxMmZV0QJ520ik9Jf3jdrhdUzQ+ItOwnVapESdlHRXSxb+SguRw6q6v
 AV3RoSnqS4pJrRPfJNI4O/hyC+uF+Zw4T7HZ2rWmsbupTHl1dcnXXNzEvMFdJUqD
 HLcguNwsRNBdjYMmeraNyIUUOsrrpPjeVoxvQywEM1IyKqKlM4lOdxfnJ4wTGTi5
 Ksrw7w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgn27xa9q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:16:10 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92eebb130dcso45215485a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793016970; x=1793621770;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+LTz0oBJTc4CpLrS+/ZEJ4++07RrvK247eLZ+9FQt4w=;
 b=XAdURKo3xu+4sezqYHRfWf09sIyntpW7/Z6Xqf2tNA0Rb+l4S22sZ+4zu4p1h6zi4G
 /Aivsuv9QBmdnRvM2ZQ9TOsj/rwginVryB5XS78MbTzzUeNYi21ZDtx8ZprBmmyXyca5
 iBlUqVppOE/NJrGa1kjJKRUKW3e0z3ZCIGBMyIr3GLt+TPZ5vCkMwuvj7S0cFrkn7BUD
 tLJrLeGutvBCsBCvxiIHmUp/LVNjsOqMYK+8t4PYM7arHbWyrM93c3TAvnk+E2ZHOtr8
 GOyZDjjuPy67E0LgcfBEGBuw1XI4T+KriDkMUFAZE6i5oeyo/SyfnhFRApPYCw9foleI
 DBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793016970; x=1793621770;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+LTz0oBJTc4CpLrS+/ZEJ4++07RrvK247eLZ+9FQt4w=;
 b=yoU7IxBp4wcHgFmipzOVth6W97UU+UIxrNKFZKo27y3cpWdsjU4c1CQzy3xF7l/FVT
 nNnwa5lhLSLdw8bm58tdI0M2eYgEqAuwgVVdNDSQSzFqVj25oywfLdEPsT1BcH06T8jT
 ylGvcnA7nOPyzYAgg14vTe01hviAH0BnYv+4fi4nuTcX06mu6Nxm6f+7BRV+biUTkvso
 s9HWz1TtRCQgMq6zmtzKjB3zQzewDTwU68OhSYD0KLKu195gdFm60N+AYW8HpgHAbWx4
 iLMEQwAwtuJsv1guWJ+oSupX7+A1rd5HhwsVjFY0ova+uZxNajSW16PNkv10YNbQ7AO5
 KG1A==
X-Forwarded-Encrypted: i=1;
 AKwUvByDCiVY5hUylRhfYIrTEkdeM9+kZWu0sf1O4UE9lM1R53N9IPHnXSrjT1KxQ07nwj8N/ApWPp6xOsY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYILXjXqLZq2O63COkatuzaF3f0tgkkc7Vujd1gQhfWCjJgKUXHo
 xTfVT8N8YhyX7nPFy8GDDcwftCx9A83H3vDX03CoVm/Gwq/myX2p6iNXyDvE1B4Gp2zULKi5k9s
 yUWqsAf3RLEpBB+xyykG3DtblXLzK2JRFbrmQuEiZCU3msfXcR0jUxnlkezGnU481pvAWrpo=
X-Gm-Gg: AYBFou3hMOpl7cKvRSuaxw0y+SrjdaU+s7oiv7pTUKmHYGectRQvb66sv7aZKJNSruX
 YL/ZHBFrSz7V9EJy1KSJzwgKf6bhaPMl9QLMudk59GuNOICVE3LUHd4eRKKSa0e7TzfNbO2B9/P
 Kfl+ScECXCBk+H6OtctQIt1JM9Bxl5XrtKp/jMS+BQ/TlQp+qUPhwWMigE3CziyfcLOr3VQ59u8
 fS4K2bB/Qo/CCtvqDWqsi1e9dItsk+eSj47YrLOXzbYiCLjHdbx50bet9GdLZauaUn+j9JBrRFR
 J0s0hAzLzaUN3V3rP9Gt2wb996q9mPpo+a88FDQvWDoLjIXNF8q5qVbQLAGuev9qGkwfxXLSY7e
 EJvJZyR7rNuLy3gRng3rQ1A==
X-Received: by 2002:a05:620a:5797:b0:93f:740f:5a62 with SMTP id
 af79cd13be357-940ef995b07mr1112355485a.6.1793016970077; 
 Mon, 26 Oct 2026 05:16:10 -0700 (PDT)
X-Received: by 2002:a05:620a:5797:b0:93f:740f:5a62 with SMTP id
 af79cd13be357-940ef995b07mr1112351385a.6.1793016969543; 
 Mon, 26 Oct 2026 05:16:09 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a9c0bbsm1587764e87.77.2026.10.26.05.16.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 05:16:07 -0700 (PDT)
Message-ID: <673273c0-efd3-4ee7-a008-7e70fdada1b9@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 13:16:03 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: sdm630: Remove FastRPC compute
 CB9 entry
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
 arnd@arndb.de, stable@vger.kernel.org
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
 <20261023090308.2898683-6-abhinav.parihar@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261023090308.2898683-6-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=G7GJgNk5 c=1 sm=1 tr=0 ts=6adf448a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HmQ7WK16ZiDfZ1s1pZYA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: EU1DV2F0DXy8JAiCPaQg18a1K-OzivRO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0OCBTYWx0ZWRfX1mdLShQZ3pZe
 qbu/+CwbjYMcMf+zCdcwB0W1Iu9JHZtAUW3+K0bdTb5jWz8f//KZtWLGm9eQ0DSGXsnKE6l33xH
 rtzeNZvt1Hm1td//GvD6ROOORu5+ucw=
X-Proofpoint-GUID: EU1DV2F0DXy8JAiCPaQg18a1K-OzivRO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0OCBTYWx0ZWRfX6YoTTIw4jh6j
 Ul8cpONNKxhhS/m9ZH/6PQFhD1wLzvv/B7rPUNxLejG0ubV0STP5mqdNr4mE0tFYSIMSrqHJQEX
 1plxHlwhlA6m3wrT9Lj4fHB4l452SBwjupoQJG6CBl6Kjo7xJ6amjoAQ4qJzXwbzBOwEEcw2Kqt
 7hkTC9pywn8VgcaRmgiQ2Qr31LLEA/KJMGus7tmWeLUB4gPu6HeyWr8zBgHr04RHWPXmsoj9PKS
 8ZazI462/nfKBd+zUhh+f5wADP8MZ7CNZSQbulBtkdmRXLUM7JT70PWTDGoK41t3hx5IKGz2Iln
 egoHq6RCn/y/qvpH8USoo2B0pU/rGS2p8zMix/SrWJEI2iUMs+QGF68jzo2J++CJZsANenU0mJm
 Ebsrz4LHTaTOdRCtE6L9cKWxcWZ2kq1P6aOKaSHdKbERoIBneM7VGaWPIBDlI5wvauG1LoD3py5
 nfjdeoQ/A99n9BoBBdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260048
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

On 10/23/26 11:03 AM, Abhinav Parihar wrote:
> Remove the compute-cb@9 nodes from sdm630 device tree to
> prevent clients from selecting a secure context bank for normal FastRPC
> workloads.
> 
> Secure use case support is not currently implemented upstream.
> 
> Fixes: e8e1fb5c703f ("arm64: dts: qcom: sdm630: set adsp compute-cbs' regs properly")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sdm630.dtsi | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index a41ba0da380b..721885455639 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -2483,11 +2483,6 @@ compute-cb@8 {
>  						iommus = <&lpass_smmu 8>;
>  					};
>  
> -					compute-cb@9 {
> -						compatible = "qcom,fastrpc-compute-cb";
> -						reg = <9>;
> -						iommus = <&lpass_smmu 9>;
> -					};

I think 4/5 are secure on LPASS on 630.

Konrad
