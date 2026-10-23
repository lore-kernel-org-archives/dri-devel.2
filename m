Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B6C606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bTUuZtHO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BKOuVUAA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8E33112AA3;
	Fri, 23 Oct 2026 10:25:09 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE055112AA3
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:24:57 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAB0Cn1444125
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +B2mDtrqC9JVYUAg7RACbqAsn+KTkTYip4BH54T3Ik4=; b=bTUuZtHO9M0g+BSr
 G5I5Vs1nJcoQXL6/nL9gEGFKEcdTkN8+9AJkuDD/AL9NE6zVEftceZebyzrzjDV0
 CZHNWNwRdz9wKQIY7Usn+KElNRC3wR0hzHNKLCYiVx7BwPoJz3QyAPPAwj1D0Dsy
 Oem136dReW1uXyHbBxuco0022N+Nquycx67AJG7cLZI+Ah11DTpS1FZZKzil5qil
 JBtrRIiPqedM89aW4F2gux7W7deTC4dR4jwwRiyGU8z4Lrncs4eAT5HlNfakId8Y
 wxiBknlCjijP3xtnzX0uVMPfovSwbfFFDTNMvJaQqSnzfINiU2uSC/f1DXoL/zd7
 A6lwfA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmbk8xv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:24:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93ea6b66e53so11771385a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 03:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792751096; x=1793355896;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+B2mDtrqC9JVYUAg7RACbqAsn+KTkTYip4BH54T3Ik4=;
 b=BKOuVUAAavgI/3HsUT9qe4EjJSzITK5qIaZuyo/6/vnIMutE2eeLkbh379kMqQQuRe
 cS/eMCyNCDNHFslYK8m72Zxh+RoamYBEV8iO6MS2jjUNKl9gXeSMweoRanClSovfAiiq
 /D7WT4FUsCs/XRdbHTxm3LQ3D18+qiK/pe/P724Dlvn527aKf+pJGlcie+EyvdN83eF3
 s30ANAQCDHymXfb1davDhbfRMoiknne8kTyYgvluYXr9rfB5r1etFjD3rckWrXF1pk+G
 IG5vllJKe+dnd4sIAT9yB6m/aiF/Mcm2tqRXWJW1eVwN1I4J/hOpXy5yLKhztSvr3fbp
 XBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792751096; x=1793355896;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+B2mDtrqC9JVYUAg7RACbqAsn+KTkTYip4BH54T3Ik4=;
 b=y2Wmw/4/mW8XUHEBtvrSYgrkk4W24vuE6ya7gspL/u94M5o8wWZzuvWmXKgzWF3beA
 PfEQIqxTh2WB3x+qAACIwdS+TjMseMKoj/tl58dH5Htpo7bM3OdARlxRvC9QmVTLJFDW
 BvGK5z0akcE6G63nqq7OdKFGPl8xaF7Fq4K35cxIwOFUyfEV+ZbjiuJwQaQgAoMXwegh
 Tp///hWc8uKwBGlj63xXHCloRCbEgwvn6daNwTZtiyDg35RIVobLYOOUzRuG90G5uFhH
 seiZEW0p04Qc6Yal1asPcTyGGDu6MnPySuISLZ1R1hLhio7VUfiKVKlpm3FTN0w79fjT
 8GgA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzO/fXILiVr4xnQWr76fZyOsXM26mKnvrP4CCvhBOKc9b8jD/POo6ka7b24Q+fHQWsAOfPb3uCfubc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL3siuqFfEyl03MVp0NLqEB1Mp6AZBv+Z5bAbkfMgy5PK78eQUb
 SL8LKVP81IIu3RSFN8ws4ncdVaEtL9X/LoQ3rVM1fwx1Vgc+UH+iCWEyoZMXUPdIF26zEJrz4VI
 RoGzWhnWzjyfkSfSu53sZTKSymEXHPAObrrVPmOggBjGSnTB4o4rxarD/6ag781x+DmWejLQ=
X-Gm-Gg: AYBFou1wD7VIZZ1W/cgiIxyQHNMT+nC2WvrQNObv5t0RHkKoSxFGocPC45p0tgVt90N
 ahAGVj8t6Dsmpddcmt1Vk6cU2hCYJVFJUJ3AuN/PraSMnA3rbS8XfjT2q+oHFcTcA4wfToZMyUs
 HCf8qX/528SowVRoaI4urrxNihT7ZWZfS7OEr2xukCGu2BmOWxMWz2Tzt0bZJtRz+s61Tl9oqw9
 rv2m+WdYAp3HL0JeyHV4MLar9FmYY4qVxCIZwhwD8jBSAV4ZUO36FpGgzuMOc9y2Bc4hjDgBpG4
 9f+ZDyr5aHofqpqthKOFLg3Bs8haqpHDhSo2JyYzli2bZ5oLhFp9QKCW1rZA+/nRdl4HSJaOnc0
 z/soQvB4nhSvI1eLR2ytYdA==
X-Received: by 2002:ae9:e507:0:b0:93f:211f:7ba4 with SMTP id
 af79cd13be357-93f6fa10fabmr305993885a.5.1792751095979; 
 Fri, 23 Oct 2026 03:24:55 -0700 (PDT)
X-Received: by 2002:ae9:e507:0:b0:93f:211f:7ba4 with SMTP id
 af79cd13be357-93f6fa10fabmr305991785a.5.1792751095492; 
 Fri, 23 Oct 2026 03:24:55 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46b07f4977sm34567266b.31.2026.10.23.03.24.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 03:24:54 -0700 (PDT)
Message-ID: <2755bde3-a969-4ec2-9106-38eb1a69f43a@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 12:24:50 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] arm64: dts: qcom: kaanapali-mtp: Enable USB
 headset and Type-C accessory mode
To: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261022-kaanapali_dp-v3-0-b5ae8e6083c3@oss.qualcomm.com>
 <20261022-kaanapali_dp-v3-4-b5ae8e6083c3@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261022-kaanapali_dp-v3-4-b5ae8e6083c3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA0MCBTYWx0ZWRfX+DpSgtdoKeyk
 WPD0bgglbrwJiLMaCi+up6nfRvVV1B3l/DVcW50fagjlHnKIoY1XFqootOGufDdKddZxt1fu4ph
 nKj1XeTgRoXl2yZ0g6Ru9ZkdaCpYSfc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA0MCBTYWx0ZWRfX1ElGPzeUebvr
 pk5hmAn2rgtifHtsuZ5QvIc6hNhQ/A3XlkrsS0FuzCt+W6yGk9TEt2p5knnskCE4WH+jePbSq0T
 21hhOxoanaPXZwRsElrUEHvm9zgioIRptkqWAT4KB0942G2FQhuH8McngJG6RFnElCYx3Iwszp1
 qKs5Poycpfn3mpJWZj93uANsHN9FXVy9ioQaj4gNenL3RzqcAq/MWeDrQquc92fH8kXgS4i8Ab7
 JIq/TkZ0ZusAY17YymaE5E/AmCYwic58KRpKUu3AilavRhGA0rvdU1FBgJpjdslDb0welSWKuKa
 oJcTv02ldh54r0UEL617f4WO9zmik7ko1K2N81+75PlAEO6I355sNWxJuxa2/QiGycAuliKD0HK
 OAUM94A3jLUFhIYKshW4dl3LObX87K847gVZwnJQPiEZSERLv83rvALILiF+3JEfqZnDe7zyCyA
 hm7c+5UBagAyXxCzRiA==
X-Proofpoint-ORIG-GUID: Q1CwRE76Ttj_kKIH3b1e1BojquVhQB-L
X-Authority-Analysis: v=2.4 cv=Nt1E4MdJ c=1 sm=1 tr=0 ts=6adb35f8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=vVu4xHXG5oYAYlB2ed4A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: Q1CwRE76Ttj_kKIH3b1e1BojquVhQB-L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230040
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

On 10/22/26 11:49 AM, Balaji Kalkonda wrote:
> MTP does not have audio jack connected and relies on USB mux (WCD9395).
> Add necessary nodes for proper audio headset support along with USB
> Type-C accessory mode and orientation.
> 
> Set the I2C bus clock frequency to 100 kHz for the WCD9395 USBSS mux.
> 
> Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
