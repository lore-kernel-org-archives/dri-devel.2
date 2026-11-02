Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE6D60A3835
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C0M4XKP3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LdQpbdO1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6A9010E624;
	Mon,  2 Nov 2026 11:58:41 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D1F010E624
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 11:58:30 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29AMHO2880846
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 11:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HYqwDlxIzrVgKHvVxNjVgcktbuyT/DDsBjlgMBa52zI=; b=C0M4XKP3WMXlU/3W
 I6Pj1JJOyuu6q8lbDD5FGGJsuqIZAn9QacRYoyujRdBogKQr5PyQq1El44cJhoKR
 ucaxCi8rYv+YXWlHpDzqUmcBpTTZhHgZlgmysX2Y0d8DK1JJiqws1V2GXBnqXibM
 4lAyjxIRZWsCyvf18riHvXJAe/HJe4lKMRDttvtnsZS8j+SYQQXwvs0YF3lWOKH4
 sR26Z47ZrAzBHAJ722VqhS9652ZXxw0SQn/Av1JpYKZaZSkgV+NV0XSEXzii8rC6
 rbeTDTHTJrrwpysUyn2jptg+rNkw3eNqGffeQ22D85iMbErKtFr6IPHaOlthnRQO
 rzgWCA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpqfrgpav-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 11:58:29 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93ea8a9cfe6so49831585a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 03:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793620709; x=1794225509;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HYqwDlxIzrVgKHvVxNjVgcktbuyT/DDsBjlgMBa52zI=;
 b=LdQpbdO1fkgqIiWyF6Oj345dxjjl9+mP/AGmhMOtdDanUDCrTH+2PDFCNJDLE1mzQC
 gh0mS8y0LPbHe7y5lbHMqCrJPJjbe0A7nUKFM3EjCRX4raMrO5Qe4ME2ILdNh6dN7iQE
 KOqwSpNREbLr4bbGIUJQY6GxSgOyvPpbC3zT/5F2zXpnrpDDn6hhW6FaVll2OeT2d3+6
 dEqmrwE/8LVHCr1rxfPXQBx2HqdmwZHCNwtDVk4iaiOQ+WRPiy1j5xFCHr7rzUtdMPYe
 ypcAgSENKaj5k+mCmeWMDDScz5AEfQkZr7fgdTRlLh6A7+hGLzGe2svjIwnbDgSP7AND
 QEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793620709; x=1794225509;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HYqwDlxIzrVgKHvVxNjVgcktbuyT/DDsBjlgMBa52zI=;
 b=GohB8SRMNXKQdi3KUxvP7HF9B76kbbV/wwdLyuAvacnCpxp96KlXY0xOFJFErf2LJT
 Z3+JfRfDzPy242I9LRAJ/Iww/E2GS6VWnSYemcyCNCV/t834793h3LrbgrujcdEYr+FT
 nDezD+5ZiABUbvT4un2axd3QpAtQ/5MtUa6uCz7+tJCWU2dW7oIlUm9RGQPhX4HbpQQg
 BWaZA+DA7Xya+kPmK7b3kPTERdGEj1vG/fGrAv5bByJhw//h1kqJp9F8zQQPw8TGbaGM
 Wewmjyft8sHvnpsr7l7DqXqz/pWIlyWISAWsbn5hhVRPqnHwoB7Uquu6hs6Dl8t1iOgJ
 edlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxkYEgHQEUWpxHVcSzo+8GRLGh1SHlATEWEGVg0/MATfKW6yzTOkCsXMntHZydypzXJipGJH/8ldaU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKdMyLrHfx/4UwBbmloBj06t7QCoaJ116UcOXNKEoJNxybvkI+I
 mV/iz2LbywnTxH1BZVpJzxWme8a14I4THuekUg4j26O+Igtbay/hweVtSpcwcSWH8EJIrfJJk5z
 WJK+hxGjML+Uy1uF2j6Y7WN+jzJL24WqWr99oWp43hfv/swwrVCkEOFpdw+6oZMuLXJthi7E=
X-Gm-Gg: AYBFou29vXOIVtdYXoiOdhaROZgJK2dUogQnjqFuY/CdlKP3ATiadgY7T9hahjdLqHu
 XA6c3yjJhIaKGVH/A6eSlHe3E3OxcWkJo3ZNJ1wocueOpImoImrpbOj/LmPnzt2YVJy0Gl8X2Ly
 rKaXxTkmfGI29omvnkR+DkzP9sM4D1rQqeyiCjkaCp8VHCxpYQ13EoPRCL1EYtNySXhwYvTCGEo
 tYBgFAE0fp/t5LeOJnJtwSK3auECTGr45TkpMF9CScNSoLk95qmAKZobxL0IKvkLejEZnRxObib
 PVs0AR1OSXf0nKmqI8PrbNap3ZhfaGIbZZdomBWkJoyZg2pKFtDM2ZGmaGZdQKG8AUB3Ul4Bl8C
 /5Qj6Te14DqHfb0NZGi8BoTpIeLijF9W/HcOs+1I6RpVWlLXN1wRPEgZpQK6YpFyphrsM9oY=
X-Received: by 2002:a05:620a:6f96:20b0:93e:54fc:2c79 with SMTP id
 af79cd13be357-94421878c51mr1514682285a.5.1793620708483; 
 Mon, 02 Nov 2026 03:58:28 -0800 (PST)
X-Received: by 2002:a05:620a:6f96:20b0:93e:54fc:2c79 with SMTP id
 af79cd13be357-94421878c51mr1514678885a.5.1793620708014; 
 Mon, 02 Nov 2026 03:58:28 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4eca211ddsm3086049a12.34.2026.11.02.03.58.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 03:58:27 -0800 (PST)
Message-ID: <4f1ec92b-0ef1-4139-856d-e9077cd7d4bb@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 12:58:24 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] arm64: dts: qcom: sm6350-lena: Add
 qcom,rmtfs-mem node
To: erebion <erebion@erebion.eu>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Luca Weiss <luca.weiss@fairphone.com>
References: <20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu>
 <20261102-pdx213-upstream-3-v3-3-cdc3be96d257@erebion.eu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261102-pdx213-upstream-3-v3-3-cdc3be96d257@erebion.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HMJWhYtv c=1 sm=1 tr=0 ts=6ae87ae5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=6H0WHjuAAAAA:8 a=JgZe5hknAAAA:8 a=EUspDBNiAAAA:8 a=RC7kgf61jvLRIQ5xqpwA:9
 a=QEXdDO2ut3YA:10 a=AYr37p2UDEkA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=Soq9LBFxuPC4vsCAQt-j:22 a=ODtDA1adfiiB3BH7YLNA:22
X-Proofpoint-GUID: TgKev9jAHq9dukBuAaBGltpwAFIZZQvq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0NyBTYWx0ZWRfX0mMOg9GrJCkt
 x5VukubR2YPxBanHqJhESpv7324Izmb1DxaBz2cF2+9TzfKIrTeoa2KSJoeWWxMmk/5zefgd+5L
 NhDx8iypGbxQtP6y5Z4A702yYP4HymM=
X-Proofpoint-ORIG-GUID: TgKev9jAHq9dukBuAaBGltpwAFIZZQvq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0NyBTYWx0ZWRfX7FEuxkpnGex+
 WN71NEcgGrMeuKfXarnY3eZYP8kO0zn8lnwtIQKLmgFZbOVj8IWuna7sU+HV7Yc5On5Qou37f5J
 rJJdiUGTnzjQCHyn1PxdABLsV/mUjpi84O2fqSn3evhs5GOQ0COUL4L8X+XzAvjg800cCaOpdYG
 fWE2DFeLhm9bAlIdVAyIbhElLH1ogU8X4MfI95/0QM2B/tNkZkWKHsuN6CNWHMgWF61nBAvagFa
 u0AKjnX2CwDjtih77b1vNMBi/ZcpSRdqXfimY88e6G7oO0VQgOVYANhvaZUh0e744CXljWlL9Nv
 SajtJgx84j5mU9I6Q2/uqVbPex9isumYDoipXW95rvc+/gKTgPxSWxYTqTO44RcXmoVSkJw3IHD
 by0GYpBkjAeRZ3UGlfHkwDYiAlg2LWXuOtYJNDPz28emforxMH0ACi+FfQQreu1yDWuGe0Ct1Lm
 C3JlrCbgBkj9ISaa5Nw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020047
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
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 12:32 AM, erebion wrote:
> Adds the qcom,rmtfs-mem node required for the modem
> 
> Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
> Signed-off-by: erebion <erebion@erebion.eu>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
