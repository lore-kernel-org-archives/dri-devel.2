Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09307606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fGimaLUT;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G+nBmmpu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6796D10E797;
	Fri, 13 Nov 2026 08:42:34 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECDD810E797
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:42:22 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD8V98Q074776
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nNGNRf4R7EeCQJB4NqQr3fbvYkp5IfNH3Pwk65XPQPk=; b=fGimaLUTuSPB67+L
 gkMMHlc562vtZxedcLBFHVCNY9pUSb5wic+JzVyNQC1ApGW5gxEPJCrGVMbLeGhP
 at0naneyMKTeLeh7CM/W9aU4HVHbb177KouisW5UPzmGkyeeEf/xMk8Sgmj4PNCi
 zb/Bddm9d2PDbV2/x4DROibRhIvH6dC4Juv0BlPKtRSYWSepO0yjekplezkHDyND
 tmQbv5xLCk/YTQyoR7YHZndsEI4+EKZ4s5llIUcHkKEKqwA3WubiOHbWVKXREdes
 G09MQgWippVzJhJ33E3es1ATdU3m4HUN9nWCia8E8yUyUyXXwzZq+F/+3eqpzZXQ
 nldyrw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwqufhj0j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:42:22 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-53635fe2335so1563681cf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 00:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794559341; x=1795164141;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nNGNRf4R7EeCQJB4NqQr3fbvYkp5IfNH3Pwk65XPQPk=;
 b=G+nBmmpuFAVFJEiYWE20nDPRxY5A8Ka8QIbNRhueUpPoTBpTbSiwMkl5Vj+H0hC7Ig
 6BIw6J+fFZ2rAUYT66RtsZpCILrIPnmPnqfuTrIPPJ9kguoxpIpWUvICB8kP+p0XLW5Q
 uKGhklGpKOJeHvGpQpuNQZ0nomLp7FW3oFdIEARrvJ4XnxMtFM7U3HW0bFp9P5sKVGcZ
 ZX7g91UPmGl00jgpgu8l5KvfcwGim7FsvOMLSSG5Rf1BmnpDj/wlu9J8+W76fUUaSGLa
 J9tXin3ZUnxjUEmxHgWXU/zoxVl04UT7x/gufalLbhevjP7angjWsJUe3+2G3jisXRr0
 tftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794559341; x=1795164141;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nNGNRf4R7EeCQJB4NqQr3fbvYkp5IfNH3Pwk65XPQPk=;
 b=ie//n331UhhCDzWihDdO2BmnfwgXeVzoqAsnYfZdjrevVUPLq9RMQPY/IDC3YjBgev
 TgKRSTE0SMupTxMGgn2y436vM4qduGqvpQrAKZGCMcQlmVX/gFvi56+vPRhSlMDPuvln
 CmHnnkU9gKyKJfiVFTQiLiUzDu2XVe65brsmfVTFkGvkQKw9J+TOd3j0QFYdcdJIgorZ
 +HiYiMcTji2e5lTq1Ooy2zuAYlxKdgd/inU1mxFGZLutC3dYLlc93mccfNnLZ0iE/2qL
 hDHVbXGb6ffAQJgxPlMw4wcbfN91krc0D2UFFFSmZNhR/KSOVAwshJl3Kj9fZoAB/FW2
 jjkA==
X-Forwarded-Encrypted: i=1;
 AL+hErHDDrnPqvJwpWmyJhIeCDzWO/jgxVp97GBdDu6I5P92u4JYUvMssjkZxFW/4aE77TMPsDI4Crt5n2k=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+EjN9iRzCDhgq60MsTrpWKVHOgPT/8c5fb5oFMZFDPjUhJ7UPe
 /6/AfgI59tGPUNswTJ+q3bbgbyu49aOuW+YI16/iQVp+RFpUyGaHmQs7UctsMEdYtJiyZdP0nLS
 bHF04/UOaTbmzL2ohVlZQfPiy9s6rWfW+nIBV/4pyQ//snB1uPnDdyMp/zqMcd/psOabM22E=
X-Gm-Gg: AYBFou14mCrtGEvQ5M0BVIgAzAvwaaP+JGeIsasjwNpeuxM+aonhEJP0yLz1d6okx4U
 DN2JrLtVjttBykrbYFcCIDhotcIfT9H3+8RN73THBQZsrmWMjkPfPpSLJS9HwYIcBOmVgMogfZh
 TBnQOEIS1cGWKxCLZ4oGmJD/zqf0SuZrklnNj3Yh9x1CBdo2fBDxudgiN5PlETHqEk+E9jiT0jb
 vLzcB7S22rAVNO9URX/LyjQtXK1qObP6E6/5cN0HHW/qo5akuoJqsxPELShIWog00EKe60w8GLK
 Q//5ONX5FNt3hpQ8TP1B7wlCkz/kWs80A6zz9bxUWjDb0ZvTn7pLMZvAbKdTO//eXq8DTyznh4I
 P8EWk6X8BCg0XuZvNhZNcec+dlj9txxVAi0EzpM+mqEriyW9CsTpvlHdxbzD5xCMVFr+b+gQ=
X-Received: by 2002:ac8:47d3:0:b0:532:d67e:bc2e with SMTP id
 d75a77b69052e-55ac1235400mr26691451cf.0.1794559341280; 
 Fri, 13 Nov 2026 00:42:21 -0800 (PST)
X-Received: by 2002:ac8:47d3:0:b0:532:d67e:bc2e with SMTP id
 d75a77b69052e-55ac1235400mr26691231cf.0.1794559340706; 
 Fri, 13 Nov 2026 00:42:20 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b911desm64855966b.81.2026.11.13.00.42.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 00:42:20 -0800 (PST)
Message-ID: <9d0a3aec-052f-4209-b2db-0c2112de33aa@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 09:42:17 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: sm8750: describe all MDSS block
 resets
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, dmitry.baryshkov@oss.qualcomm.com,
 abhinav.kumar@linux.dev, jesszhan0024@gmail.com,
 taniya.das@oss.qualcomm.com, andersson@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <cover.1794558882.git.xiaqinghuan@mail.ustc.edu.cn>
 <8a0c75949fcf428a2163a2e63b27fcf08d3b4f9c.1794558882.git.xiaqinghuan@mail.ustc.edu.cn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <8a0c75949fcf428a2163a2e63b27fcf08d3b4f9c.1794558882.git.xiaqinghuan@mail.ustc.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kU2DafPU-rfeAsMvBUFkBvaGUt4J4UgV
X-Proofpoint-ORIG-GUID: kU2DafPU-rfeAsMvBUFkBvaGUt4J4UgV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzNCBTYWx0ZWRfXygUfr/PAU0OC
 bPibwKMX/f9LXDcjCitgV1s3leZRJtzNFLRLkIbOW1zNyZ6KAFS50EMGcGbdUszg5fmkG41Bcrd
 MX2/JXeS9IeqknVLRZiXhEeK4c7csNc50+smkJmWC8VHuzhQLYASBfkrJgRJbE/XOP7opLFsqI4
 nain3ap+sK9lRHi1P/UNmsCY1NqxqhnlkYXeQoVp4yvY21gtBOjV3BQNik35GyPY0bmTp6yRIx8
 IFma8hVBX4WngzANH+l+NdwkQW6jhT+ccVPuFm4wc3T2vQl0oSSZWhVcTmp7fmhKzZ6vp93SAtO
 09DmLkBwDuJRIoYLwfKry0KA48WXXkF7guEL2pZjCXXViYz82Hxq6KHYD0bcjdHVbSA2n92kZ8u
 X0Oe8yrMuEEE9K58S4hZSyTyHxpNHaICzNECi5zt+1Fi7DqqiseqIms6VbhRy2hQeRfsML2LKqY
 +XYsye2d9k3ptiQcFyg==
X-Authority-Analysis: v=2.4 cv=XZocX455 c=1 sm=1 tr=0 ts=6af6cd6e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=PjA2QlHgYP8RnRe0R20A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzNCBTYWx0ZWRfX9lK4rpR55xsF
 Pj1trbZ7oTfHeSUpe/VNduG6LdqG6LJ6TsHRV6Fmiy7IFQPQystw3oaTQvEdA3lP1r1zxh2uINC
 x4/vHT71BavnMwDbGaqhTnfg+hOPukA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130034
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 9:36 AM, Qianhui Xu wrote:
> The SM8750 display clock controller provides, beside the MDSS core
> reset, a block reset for the MDSS core INT2 interrupt controller.  The
> MDSS node is an interrupt controller in DT and the DPU takes its IRQ
> from it, so INT2 is part of the same block, not a separate device.
> 
> Bootloaders hand over with the display block still running, so describe
> both block resets and let the MDSS reset return the whole group to a
> known state before any display hardware is programmed.
> 
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
