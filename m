Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500F56073B26
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 13:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XTPfigwt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RmuvXnPR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4E6C10E036;
	Tue, 10 Nov 2026 13:18:51 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19E4F10E1DC
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 13:18:40 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAB9qT63228346
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 13:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 x/m8qN0MPpjVIYc6xoOnMVMeEe7+lRfm54ryIioSZqI=; b=XTPfigwtgTvljF3i
 86m27RQrIcd+j5CVW8XsaTKNOo52BhyHmfJqrM3rLjEEC7UZBLagA+73oAuX/x2N
 A1o74BHkFVwZPfJM7w54UBMMV2lFDporMuo4nOecBtOkNv3VYLXhnrV8afoUdzzn
 W8Us1XxdQpXwiAOj5nfcJlTYsLU7OlK/QkDzJI2fKrLzdyoDBUvhur2EcsXlaGbP
 A/eH4fAitC++hP5d0tdXiceO457XGdI92TSBYYc+x/9k6qugFXNGNzQ5KpO/He9R
 9PbCkxFwPeRI5+4HnjjaPHOfqFEmXgojcBtA1f8eYrOhR9a4DJccQLqIDNua+Or6
 aB4Asg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huy5d951y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 13:18:39 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f13c143c8so378519285a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 05:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794316718; x=1794921518;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=x/m8qN0MPpjVIYc6xoOnMVMeEe7+lRfm54ryIioSZqI=;
 b=RmuvXnPR84Yu/9AbRgGGA3obxNivcdRjeVgcscLZAMMUYXxcHrX7pYlJ7bopW+9wAg
 kRqFM5PqMKYFrTwndjGKi7ClKL7MrK+I6+XYF8vtHgAR6GATUjBEgvAsrm1p2Op+6B5X
 otIonmyCHFUJ2pibSgk56OB85cLd4Hmc4NgL7o0YZaidf2r4QlUGh3SBM2/Drj24btFL
 k5bsWupJI+riOiYhO5O2IGSLa3wAHxWhJfXcii91Nr11npoaYoRMLDi/APHZ8AH9vB4a
 us8lm7Dze8OnkXQyQvzW3QV1RW4COnHAw6NUUkM9yc2V0FIHzYeQ7CXetDk2dSI2+n0f
 WeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794316718; x=1794921518;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x/m8qN0MPpjVIYc6xoOnMVMeEe7+lRfm54ryIioSZqI=;
 b=KRyM0kHgDTYv92dE/+m8M+SCH1ERI5tkZOdjE2VNWghX152b6X2ruJVHopuaHmzDoG
 r7NLtmT5uaWjux/owYQx3ANxbdqRzpGNsj7Ki4ZZ6z2wf/qI4U2AVPiGt5p54v75HIhH
 epZfVq4hKmNWgX5iFETTqEHG0cdamnWMVtM/XxgYiv1ZibXOKYLMmxmC/I46UDWae7g6
 XQa+SnRgOhDYNVjz0YBgPhejgWVr81TVUTTl4taToxlLxwGMbWpX6OHfdt3oYdJR3E/B
 V6o5IpVHVPuKv8lWDkXm6c3ZhFcYoH7+ito/4D+FJGa/812F74B81bFdj0BQm674h9mv
 UvWg==
X-Forwarded-Encrypted: i=1;
 AL+hErG/Lk4F7gw6Ap3UoSJM8KCBZKGevRxIX9zE5fLBNLhYrm1NThTTmyR4NvcmhQj7ukNLz7vFAZ17dSo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/p8qRLVM6sHggOKNK0aFnRMiAVBccP4jgGvtW45h0bW1sAQeUh
 wrAc4Px+4U9YSouzVbVUeT5UMQraqAtg5ZknIg0qkebIYspN+QnErkueLp0cZC3cBJQnl/rzkxd
 bNOIGNl43ioG3KsrV6EDuNh0XS5szA75G6vLYRlrcVqi6SYG79cZsuWqsjrNuslk1bGEHI8Y=
X-Gm-Gg: AYBFou1LR4DWwwX9yn5+AQTGEtrlo8cBlQdtjDTpRYKlnFBKAg2oNHPNQ9U30ejQihH
 +XuE/IM3uf8ru0dMKoApW5Cw8tkgp3nZNZ72okYqsTWvLOhE2EZ2y3C6xMVeOZYAonhWb0AMV9u
 fyZw5e75Eelu7udU7pyYnDKbKGrnAw2EbWZJY6e7G3uE9erpQb2b2MxUhpgUmNAET9jLKQqUaBP
 wFfvOAB0O43CpUBd/ycxIdr1Komf68ubMdoR1sBysO/MTZJ124a/7rnEkWZk6har4jcyHx+XsI2
 /NVcEFB1QFOEOF0ffufcqhbIm5NHLNU0OwEDqYzJCLe7uUvMuw2EAYoJFfgfs5tgoqKHvQ0F7rj
 4hweNg3+8FoV9tOuwzq1lJOTExqKCEZ18jw9LXDQ3ruSEEUhmCa8feMkeqqZWZtkQ34sRJ6j8UF
 w=
X-Received: by 2002:a05:620a:4152:b0:943:f4a1:7bb9 with SMTP id
 af79cd13be357-9479f3017e1mr423388785a.18.1794316718561; 
 Tue, 10 Nov 2026 05:18:38 -0800 (PST)
X-Received: by 2002:a05:620a:4152:b0:943:f4a1:7bb9 with SMTP id
 af79cd13be357-9479f3017e1mr423383385a.18.1794316718090; 
 Tue, 10 Nov 2026 05:18:38 -0800 (PST)
Received: from [192.168.1.110] ([178.197.218.7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835f1772dsm4995698f8f.31.2026.11.10.05.18.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 05:18:37 -0800 (PST)
Message-ID: <7f052309-63b1-40d2-a4e4-29421e46d6c7@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 14:18:34 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: qcom: msm8916: Disable disconnected DSI
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Del Regno <angelogioacchino.delregno@somainline.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Mahadevan <quic_mahap@quicinc.com>, Richard Acayan
 <mailingradian@gmail.com>, Danila Tikhonov <danila@mainlining.org>,
 Robert Foss <rfoss@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
References: <20261110-display-msm-of-graph-v1-0-0f3106f817b4@oss.qualcomm.com>
 <20261110-display-msm-of-graph-v1-1-0f3106f817b4@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261110-display-msm-of-graph-v1-1-0f3106f817b4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: oe89Va05KI3lbK51PNpKazJUv0ozPKjV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1MiBTYWx0ZWRfX2eW7A/Kf1Hqu
 HUcHIaQbJ+khTtZ57NS8KvQ4S2SudFrCHbN8O7sBlNrb1ZEoOx4fQUn1dep2dXrzGZt4YZ9fnWW
 ARI1bFWrCHiYVd0FHqOXJA5qraaTyns=
X-Authority-Analysis: v=2.4 cv=d+9gWhjE c=1 sm=1 tr=0 ts=6af319af cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=udFPpGrmtiWedX3Zxo8A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: oe89Va05KI3lbK51PNpKazJUv0ozPKjV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1MiBTYWx0ZWRfXxuUvJf9dktBf
 jCc1YfRYnU5hpBEUrDWLATOIfJeyggrthGHIxOedYCo0qNZwqgOnPTlKJ6WZ8+udB07PUlxQKl0
 PbPKp05BNw/ginkmdhWg9DVPzF6oxsx+U1cR1xzTRfQ3QpSiAvD217fRpOinm58cQtR8cE0gHlz
 NuHGUdfnQe8Zm7blqxMrx+nIJYNHuTWRt4cim3L1zyht8OYJ48Klmk5lgKCyYvbcA/TvKuS539M
 ILCAObJC57vjLGhCy/KgDiCpMuNFULurFxVFhkrWYUxxjwuuZs2sI5zxo2/O+EkzjL8h8MTzZ7Z
 D5jQuLxc+t4KZakvS0GdlxwIBQbuX+W4rRmqqb8/gqG78Cy7Q75pZ13J+1u3nEmP37z9FcmTKZ0
 DjjqoVxMU7Vv2eNh5q15PNJCFNODvu+ZbBYshZWp8nhmAnXWtpvkEaTvytZwgMf4HWPpD5cqc/f
 PqFlZjXbdphmg7rpipQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100052
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/11/2026 13:57, Krzysztof Kozlowski wrote:
> MDSS DSI and DSI PHY is useless, when nothing is attached (no panel
> description in DTS), thus should be disabled in DTS.  Linux MSM DRM
> drivers will also fail the probe.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts   | 6 ++++++
>  arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts     | 6 ++++++
>  arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts      | 6 ++++++
>  arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts | 6 ++++++
>  arch/arm64/boot/dts/qcom/msm8916.dtsi                  | 4 ++++
>  5 files changed, 28 insertions(+)
> 

Valid Sashiko feedback, I missed apq8016.

Best regards,
Krzysztof
