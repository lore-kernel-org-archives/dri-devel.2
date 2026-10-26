Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2DE606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pjmq54yV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G8m7gDkm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A2E410E106;
	Mon, 26 Oct 2026 05:32:18 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27EC510E106
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:32:07 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4axMU2727320
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +pIQ82vdej/2mAxE5Ss98Wl8RmyGvtFzNZ9cyB2WStA=; b=pjmq54yVpPurVyB1
 3dDQuNvDNwsRIAzCPtq+eS1bIKHv9qdfPTBCDZ9SYpmaYPNosDzHjw6kBn4VcrVG
 6eLUEJzA+ZHxSBHnaqXeArZSLPO0lkWfIU54HU6KkDaWWFepRO0pBLKyQNXuY9Kk
 bJuZCwbbsDBeC/ZQ4tGkwP9+PPqz2Te1Qppl+izvLhat3cO3AiX0aBDvgOoMj0Ew
 E68yXAiwV4R4OV4sLaizjjozKWw7Yfy3QtiaeQ/0Z6RmZlMZORDpfzxgXyrMw/mc
 xvkLYQJ5rZzZTkHRa4RqGq+tqJ6fNUraHbA+32eRPUHkHR/i2H/Fc0vnJpgD1ZnJ
 7oQDAg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkp6n0w1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:32:05 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33713e5e6daso5311431eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 22:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792992725; x=1793597525;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+pIQ82vdej/2mAxE5Ss98Wl8RmyGvtFzNZ9cyB2WStA=;
 b=G8m7gDkmdAUZs7Z8Okld6FQIWj2KAstLsVYaFV8srIppEwHXDBvZ00pAkgP6ZgIgJV
 Tq1ZZD3fS/wj3hOyzrC2XFwCj0LLKWyANCQquIKrblUz1HMw/XIt4Pm06nnWwrGzxakj
 Q27kbdEHLMRiVlUDqIogIGHPirDLeOFS5eNOWXCdNbgur8CbwtK7fkZwrceuJ5jpp+dT
 ey2xwLyopv2aVrCT+/siHoDVjYeqA6hNVvqe7HCbKA6dMcHey4azEJuFsKM8UNLetBq/
 dMEPwuO4uCNHmVK9aKQXqRNT8uXGbuc+u0hHyE1rRd424U8hh2UjcpPev4HCQ1NQx+lc
 OuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792992725; x=1793597525;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+pIQ82vdej/2mAxE5Ss98Wl8RmyGvtFzNZ9cyB2WStA=;
 b=OWyLopGPEXDRqAaJX+qPFweZsSSlVRzP7/xnGbMQUKisSTbWbYivfLAOeN0CdK0066
 QZQ3XQ6MWNFSSk2RQkB1QYDkXMonnNxbH2nA0R7tTID9nCNzOYnqtucoiDoBR8sk+O9u
 /t2Xq9Q5mkqlOxLHrffUrxPguqlS/uRA0OMgzTWBtvA1u6Tsp5MFGHJNvggm9KQwffGs
 3TQMHC76XKkTYJpVluujTcf164e8QfRDPx/JA8N2HMETJER+3jjJtempSEFZfhzafSbl
 1niYGLIaA/53OzX9q0qIWzKWKn8M1SJSmiPbUqyp+XI2bykv5YJCzBNvDSv9H/6lpFU0
 TVnA==
X-Forwarded-Encrypted: i=1;
 AKwUvByAa5bCBVGh5rubbSabdyM2R8ZRKyQ9r9ZbVC/bWXsXKSk1vRGjG2tgty4YAewt6Y8ofQAg6HiiKww=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKNSAdV2e6EaGSiZ8W5EPFIdAt+HzR5CMmqk6ejOGM45FCaaeFO
 c5p7EwOJwUoAsyV2pzeo9DFNluJMM9d8xw8zQCQrfT9M4oUJTvs3Q3SUoArzBgTCDcGPJG+UweH
 o/IfG1LHsRa2hoh6J33dJjHcwNll7NlkcZaf2BqPKur/fV2ANSa0vj0nEZT4ZwmPdPfC1rz8=
X-Gm-Gg: AYBFou0rIlqiQ4q73IOfDMgSGAiGThCtxeSRFsGj2MwEuxf1fdMlTWji/SK+cr7N7xs
 Wr7qMHN7sMPBcJCkhVSj1X2f7TwVq9k3dNNs+qEyyFa+8bzdboRyFI/WkbA/yzBwvrVal+9L/S3
 OdTOlx4eM9ymC0KBOq387TxfsTjgYYeRxDwFU4V0BJ0mACRbWnUJdeCMDap/4YLqXB42yUNKL2d
 0WIv16bufefuabVcbl+EFAEhJWMyjiGxDCyIJ8tMsbdTeiE5Knt6OT+cxQzBYVrcLfxlVgA5eE+
 udJacAH4dREapamd43Hsyk0AhjJU/qowz4pKQwDnDCFlm1ofZkVDmY9NsBHgROfvoMZw9/pzAKx
 6Gn7DjhQURHK5mNCoaUGPn0D6P3Jh
X-Received: by 2002:a05:7022:e888:b0:15e:3a65:5b97 with SMTP id
 a92af1059eb24-1993505df58mr9283565c88.16.1792992724852; 
 Sun, 25 Oct 2026 22:32:04 -0700 (PDT)
X-Received: by 2002:a05:7022:e888:b0:15e:3a65:5b97 with SMTP id
 a92af1059eb24-1993505df58mr9283530c88.16.1792992724312; 
 Sun, 25 Oct 2026 22:32:04 -0700 (PDT)
Received: from [10.219.57.104] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a064510b0sm1838859eec.2.2026.10.25.22.32.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2026 22:32:03 -0700 (PDT)
Message-ID: <d0f317a5-430e-47e7-bb14-b8d24678eddf@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:01:59 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: sdm660: Remove FastRPC compute
 CB9 entry
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de, stable@vger.kernel.org
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
 <20261023090308.2898683-5-abhinav.parihar@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20261023090308.2898683-5-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: w27JzWhvO7bDUnR8a0RnlOfrofG_Zt3H
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyMSBTYWx0ZWRfX37mknyhGjczF
 Wd7vQ7GZ5MZlpcXNuActI0xNRvZn4SDfc+K0+84bkixOD4b1BiQqvs3rZYk4ONDE/PN5xOZ9+yy
 aoG/wAQJVYGIpWqNOvPJ8mr7CUlPfhc=
X-Proofpoint-GUID: w27JzWhvO7bDUnR8a0RnlOfrofG_Zt3H
X-Authority-Analysis: v=2.4 cv=bq/Zl0ai c=1 sm=1 tr=0 ts=6adee5d5 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fi4xyBuKck7nv7155uYA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyMSBTYWx0ZWRfX0HnEoiqH/YWR
 cxUJZHlUcJkB1m371eLOV7jf+PPy3oweGXFb8uKroL39A6ibawx0T7lHy+D9xfjTfTsdUEL5pRi
 Vmt3mKGS+MbhvbovimWM1hS/O1DbYj2Yj79+VtwtQCU35sgaKGsqqVKJuLK1Lhmcn0ZYCgC2B0f
 B6aeIaNzxeS7lPLPslj7LejCE3gFyqUHnwrzVoDfFn1gMFxl3Vm2JUo/1fflfqBUPwBTTDdvL/w
 pBuVLnSxypLvFrX57DncoeTRsmpMsUbPpSSXgWumQfHwkWClrFeym3nxT8yzhFJ7vcViX0G2M06
 kl+yAd+Cb68BGhUP8il9Dqy87ooMv0UZ+FCsgvLfCHDwcMgRYrKQJANBhzQliKWaJe5fwv2/O7J
 fEgoRgRsShYcR/EKNVJPAQ25s86ZJ9zISBrb9gffdh0eib74MbbwNTq7RBsCP/xfP/DWjLUKium
 WuJtdYfc6BL1yQ5hxkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260021
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 23-10-2026 14:33, Abhinav Parihar wrote:
> Remove the compute-cb@9 nodes from sdm660 device tree to
> prevent clients from selecting a secure context bank for normal FastRPC
> workloads.
> 
> Secure use case support is not currently implemented upstream.
> 
> Fixes: 708ab9d3bc5b ("arm64: dts: qcom: sdm660: set cdsp compute-cbs' regs properly")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
