Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B446606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DQjh6u7s;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ilHbxGHg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA73310EE86;
	Mon, 26 Oct 2026 12:09:08 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 534A410EE86
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:08:57 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAt6Qc4126385
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XtJQf2VZGFLMhiJ3YFKF5xOzKvNswmAE4W5BOc9iUE0=; b=DQjh6u7ses5PHOUh
 /jynA5DQqOX/wdpP8HGWs+EuFDkOoXc2RRD7bivH5oj2kThoKCzGBjeaf4IaKUiC
 iWSuIJ//5bhq3MlqjoGYXIOLUQ15qobPfqECuD8FQYWh1y8hLzRdg3lLBWyJ6F3D
 Cuh9Fi2O1Y7sYNkRI3T/VgkU5lngwem8vGIp8xfpIr450Sgx24pID9u5UF8UrfBv
 0W3XIxkZHZo5LooqjQMqcVSxMdjjWZBXa3kRdoNNqsmGOBM9iXjO2s19rA/u7me5
 5a0C4rfw9O/zb4lL6Ptdd+FDXNY0bkF/4yiU+ZuaR/iTNUtoeLC/vhE5q0lw9wzv
 cAvuHA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhshpt9uw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:08:56 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5c9e0f047a6so52690e0c.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793016531; x=1793621331;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XtJQf2VZGFLMhiJ3YFKF5xOzKvNswmAE4W5BOc9iUE0=;
 b=ilHbxGHgUc3XTHPYrScFjrRilWVEeEhTt9dskvV7N9OFOiH1VwfwV5MKo+ZJqc/4/I
 lWCDRUi3ejBzOIItSe3VqHY5Ux8mdOCuvqSxSRp0vLg8BOqrsM+tLqqzJCEG8Suz3i4C
 1WaDJ9aLj6RslZoYRxHP5Y/cK6S28GcBTi7tCLvAoqzG4fGN/Ux8PZhJ/ijshPdfcSB6
 SarGKC35I8mfHdGrMdKMfkKPaVU1ZEtLjofnDe1Js7NBULjvfiEq9ZUsPai1QThL9q7n
 zfswNStBFZXILADadGPP5X8GYQJ08B26zQnZasAFotV/Os/K995nuYZ9jJoCd6kwkvgk
 K2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793016531; x=1793621331;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XtJQf2VZGFLMhiJ3YFKF5xOzKvNswmAE4W5BOc9iUE0=;
 b=RNj9cyfAaAbVmnhQUFSkje2rkqiyJ/kJg/bSP1HiTPOWFhzaSjh7loM2buPLalllBl
 /O4nH4sTlVnplk0MWjGIC6F+umSSNAv0+WXXhk36CQU/9xoeRa7j7qknhMb5NTXzNf4R
 jFM3/np9H1lf6G2TwiiNtq5EKAY4zsATYSDVmWIYXOVGbEdOzbbx8i0YtJ/kwCprVra1
 1OIPBkM3/4YVtJHA2wUACZ/qET9whXZfJz2gjrEQhwMuZu2ksDMgph7onWnnvF+lKK3t
 tjSdu/ljgxcHZcZ80JCI/7ZhAibYD79atxt6Ss9BO/iUORW0ECFFOEJR8uO6Be+qzJzx
 /11Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCvzzrE8RYtlHuZHjvzlv4uFVowCnH419vbdZc+MoWZ8SaOqs1LB21l9aMYuFvrl4goRX/pgYiI1Q=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKPQLaAUACYtBOGYOszjXZ8ueT5WPVma2LOUBVyE7IJPqwCJk/6
 XXq/oqdDm1jSGTVb6TqXuHLY0YhNvavw6jWZkBITBz0cOpHI3qKr5RRugyDe9pzW3M1K/4yofJW
 UerBqsX3Tk3xz0ebz6QjwruG69j7EhGAtnoU85O04j8ee7mViUNQIt1JCYLkk98aZPG96oxw=
X-Gm-Gg: AYBFou1VCsfuYoOyBTICfoBVcvu7damTySRHHnw1v9CRXN02cpQEYfspkz+3zPc4UO6
 afzqk+Q/1nZdWWyKl92GNPn42QTqcUlmSweeVA/ZMtXfytHFGl7NKtEzQzVYAIHfc/t+qEBaFpK
 W4c1tIJ6mvR3HpKHjBh+q0+RSmvpgW2Xaczi1mgao79iCpZQS+QoGLqIRC0UIpDhzULE8FCymVM
 xStNpuC3jsudLKP0kjYlxT+lAxiQDgwS4/AsU8wcfMtlXrIFWxVqgTZxK85/pr7mYaBQDtTgnP9
 Q8PclTx7MI3CAjxnTHr8FST4Hc4e4L8SJ7GtMTSKPqi2hS5c/3B2MC83zWZRt956ZIKkstuK3YB
 j4Kl7FF3gfdjFnHxfpb/lcQ==
X-Received: by 2002:a05:6123:5ce:20b0:5ea:d67f:fd39 with SMTP id
 71dfb90a1353d-5ec232b5a4amr1485285e0c.5.1793016530729; 
 Mon, 26 Oct 2026 05:08:50 -0700 (PDT)
X-Received: by 2002:a05:6123:5ce:20b0:5ea:d67f:fd39 with SMTP id
 71dfb90a1353d-5ec232b5a4amr1485236e0c.5.1793016530072; 
 Mon, 26 Oct 2026 05:08:50 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd650118sm312729266b.49.2026.10.26.05.08.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 05:08:49 -0700 (PDT)
Message-ID: <b4b2c7fb-1c80-4101-b643-7a7f619f604d@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 13:08:47 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: msm8996: Remove FastRPC compute
 CB9 entry
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
 arnd@arndb.de, stable@vger.kernel.org
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
 <20261023090308.2898683-7-abhinav.parihar@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261023090308.2898683-7-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0OCBTYWx0ZWRfX/4S3kbQ6ZWRr
 srsZpW6Nw0TwaRLiyjjVN0xa7RVrnQhA/30EBRLtX2kFfcR/5Fi+ZtddqqdvSNQQWtW3B/n/AmH
 v9a168mCfp1nIJxIPGHCzuXlQzH18Ns=
X-Proofpoint-GUID: -JnjulYnlsu3gZbiJpXbOIQoAVmrWwzg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0OCBTYWx0ZWRfX/cRCxyZdf9oc
 UJG12d+vxbVqF21T+W7bv36V9vMWxpjYOq0LA1/mMr3wkl8wQ7bPaPP2mV/5DIzZOxeCchticl8
 uHnTJnMgyZL/WZs7TlZ196SQBtbPQk84fqWrxhlfFPlXdUkSGGFqunKwIm8zm9Ko4j3utXrKwT4
 Y1wqHo84Kl4NHpvSziFeUjvzFAjgeoVslJCRqJRghD3UEm3xbJz/Vv4TQtFGitX4Cwhe5YjAlQN
 ldT8EQ9HTrqfnI7qe1AfClovVpqvI3fxg7xjleo7gUGdXs0W9NayJwq8L3fGhXMXDcgEceFIU0U
 N0hUGDZOBrpKMtrv08U4l0k0w9We6w74D0q6glmDcGkFAUw6WzzXbuBMW+KroSHjHx2ulK0sdhP
 9KNU53QNOLPmfNHpiX+wjj76upseteeGVKlS7yE/uaulrb388SNJRPn5pa+79uA5SivW7txpVL1
 GqoD7W+ywP1PklJhqWQ==
X-Authority-Analysis: v=2.4 cv=HZWB3SE8 c=1 sm=1 tr=0 ts=6adf42d8 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HmQ7WK16ZiDfZ1s1pZYA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: -JnjulYnlsu3gZbiJpXbOIQoAVmrWwzg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260048
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
> Remove the compute-cb@9 nodes from msm8996 device tree to
> prevent clients from selecting a secure context bank for normal FastRPC
> workloads.
> 
> Secure use case support is not currently implemented upstream.
> 
> Fixes: 1b80b83f893d ("arm64: dts: qcom: msm8996: add fastrpc nodes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 818e5660df91..51ef306c1ce0 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -3701,12 +3701,6 @@ cb@8 {
>  						iommus = <&lpass_q6_smmu 8>;
>  					};
>  
> -					cb@9 {
> -						compatible = "qcom,fastrpc-compute-cb";
> -						reg = <9>;
> -						iommus = <&lpass_q6_smmu 9>;
> -					};

The docs I managed to find suggest the protected SIDs are
2 and 3 on msm8996

Konrad
