Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A092C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:43:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4ADF10EC7B;
	Tue, 30 Jun 2026 12:43:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="F3n0sFhN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KUwKb3bw";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B267510EC78
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:43:42 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U9mxhU1613433
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 40HebzjMVnQxUW0qFO0coiRdTK0hbU3rpwuRRVO0fek=; b=F3n0sFhNv4vOtoPY
 BXpZieU5OTwgT+HxAP0Ui+awldHBAbEr4vblIJ9IdeTx7g2gtRrx1GseILh+9/Zz
 aUmOUzW30aW1DfxX0b6aivoylCA8dyu5nTTHJxTXKFcXYQeJpUqRYcH+cRLQPY2L
 mgBawKtvZMT/4MLeuXXScRU9UDEzx2vtpgQNU524wiU4QVKVdS2TJuOs1bU1B4gY
 PP3d9nugzR1z9WpP3ZipFIsVzxeM8o5ivIptJ8TRF5ogVjGNk69Bk7kkhKrB4KZH
 SX87UJJTfzONkxOeiEhrA3XT5VKplB3UT3HP8JIyDOMh/eDIuUKMKAkX4IkMSFbr
 Mib4eA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3x1cuw92-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:43:41 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5bbcdd9a269so262037e0c.2
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 05:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782823421; x=1783428221;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=40HebzjMVnQxUW0qFO0coiRdTK0hbU3rpwuRRVO0fek=;
 b=KUwKb3bwcGtZheCcZSXVIEfYwd9xCqP35niR/tTvKjkurSIVxREbhgTBsxBfgrF4aO
 FYfxQ376DR5FPYjq3+FocndO6oZE1j94SXJYFpFCa+B+oAcnn/ksHt+TjUgqXZY5wc1n
 +BG6GU1gg24vwSJbu/BT3M6PJRA8iketbgtdqwsesv152Oo0qyjxVirGN1/IUQaNnyq4
 DqaanmzmNXwLFyTuaRjJUC++xh5GW9MDAXNfWEzRt5zF1qLjdX8+ygKPpr7Kpx2Q9ULD
 bURAfI77MI/e6S9NzEmb9OCwBsRB6j3o2YwXNDOArUaI4gMMlfKJtsnNFLpTG74YKzz+
 hHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782823421; x=1783428221;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=40HebzjMVnQxUW0qFO0coiRdTK0hbU3rpwuRRVO0fek=;
 b=gLlJDkTr8qNGTB6dqIbMl7+T7jqJnLG33piRz7ZeXjJ2eJKLrJH0aWoDmNGSQiTQKz
 5FWitUPVjbIzhXXGf8EdCrCBF4AyC5A2Jj49SQiBY3Pik3OkKD01NCnjrrdw1vZT8Eg+
 lY1dh9SJf3nK37wUSFXUIVhDft4a03RfX+2ONGYk4Gay1bJSA1ADdCSSg1/nfamsogSR
 jKtRCTMJbDxU+K3h2bdfquDI1/oimnLFUiinHAXlQznydr+2iZKyxM3Kk2uMPrnIV5Lb
 AEUgHGxb6IG/k7QoIwRaDUSsIDZ8JKqI2rEWoRIlEWcyx3BC0f0Oz/iyaqtO+exWI8Tx
 gFcg==
X-Forwarded-Encrypted: i=1;
 AHgh+RovXLeHOCVsdSk+qFptueil9GDyEKoD4Y9v8evrzMnjgsuI6TwKN+wlZDJ4ExAQmf7TUAxvc0DpNhc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHO7Mdc8roveaJq5B/BUA5xDHrUbL2aH026J8+5jqvaPWfpXKe
 lq+RdD6LmjCLbu8WFhUo/mMnuTTnGFxsVnqhdN0RELTNZudQkDCLv3htQGjp2690FfE+esEaAQX
 CYcec2Di6U9+/dtL+xqPlau+FM5yGqdGR5+kH97kbVFHSunKBw5HxTY3k139fjTjAJVTmgHbwTa
 r2HrA=
X-Gm-Gg: AfdE7cnj1WXqsTAmXoVrfpscTU7B2B83SINz6WdVHJ3NIk10KRnjpEohFc2oSfDqs8H
 gyAcwhPNgJZP1bMU+tc0iLoeBbMare/wvGcg0i5N1ogoU798MmAOWHN45i4RMLiZo5gOYC0qIX2
 mX6F0MXFpD7wXtDdNTsJ6tKo3oNeEC6zP3Je+ggRiyXaIdWeW0d5RS0i21Vsoke9hxIH0oq9sEu
 WcC5FqJnd5KykLa6DnuAYPlp6PKA1+feCAO0RwrzllLSAp9LoDNbpCoHJQtt1AmjIsdKgMa3Jzi
 a1kIcd7xRwPVDCjmlA04IyahmRUqXC9z+vYi5BxnM7vT3khXodEj1Ir1Y0e7UQRzwmWsvntTx3V
 ApKeH/CTrkqclGBjzu3fKYENUdJC72qz9ECE=
X-Received: by 2002:a05:6122:860e:b0:5bd:9cbc:93c6 with SMTP id
 71dfb90a1353d-5bdbe9a7662mr493254e0c.0.1782823421021; 
 Tue, 30 Jun 2026 05:43:41 -0700 (PDT)
X-Received: by 2002:a05:6122:860e:b0:5bd:9cbc:93c6 with SMTP id
 71dfb90a1353d-5bdbe9a7662mr493224e0c.0.1782823420597; 
 Tue, 30 Jun 2026 05:43:40 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6987c968400sm1127666a12.25.2026.06.30.05.43.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 05:43:39 -0700 (PDT)
Message-ID: <e05fdb45-0ebf-4dee-8d25-05dfc65042fd@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:43:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/14] net: ipa: Switch to generic PAS TZ APIs
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
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Alex Elder <elder@riscstar.com>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-12-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626133440.692849-12-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExOCBTYWx0ZWRfXzWBzYi8+YaIf
 iPgfYUP4RKUm3TRjyNOlUcwpWb9SYZl/e5/ojhI86ffE8RMilW9MfLXCeJ4+sSD/1M+NVVhZit0
 TS6e9RHPHOf7U/akcd8DlCxZ1TeUBaJJzjVVP+GLlhxHbdN/5Y5zJkDBs+w1ilEycUOp53iYRor
 /PCjQi53dEyRjCajMKxT49UpO2m+lIEJjkG+GmtIloi5W/cJzMBpMPWrHEOaK4MJ0d/2bVaakKs
 AyRilLQhzzGazOQmi5RS2z2IGL4poY2JryweoT+QcrCZ+AVW66DwNRpR64lyrZDygCWQOI7dvl6
 SxHFPz/WTIAoyNWib2eTi/OxEInQo2RLGPnIULwgmNr0O6SajmOfyPEUDwiNtQvNlCz030K3Aua
 gupeiA4j00ZTqFDeI0SRulWsCvLEjQK4itJ/Nifr6Apu1NOLCIrcil9rAsxx2lAIUDTpAR1dWl1
 GhENqm7R4BUrfojAjBg==
X-Proofpoint-ORIG-GUID: 7gD_DVQHxjHi8zc8QhrPWBNGTtfgc0rb
X-Proofpoint-GUID: 7gD_DVQHxjHi8zc8QhrPWBNGTtfgc0rb
X-Authority-Analysis: v=2.4 cv=ftfsol4f c=1 sm=1 tr=0 ts=6a43b9fd cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ee_2aqc6AAAA:8 a=smRyAmGWe8i0dDVrb1gA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExOCBTYWx0ZWRfX3cB6x1Zbe3az
 V5PAo4FeVhtuR4klzAx3uX7UhnRw5srz4RGUU+y5eABRgRnPzzFIT+CtqhcY7zFYiFjCpMNwjfR
 yCFSIbPpRU8FvcjZHtpL7aCdMfUcwzo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
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
> Switch ipa client driver over to generic PAS TZ APIs. Generic PAS TZ
> service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Reviewed-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/net/ipa/Kconfig    |  2 +-
>  drivers/net/ipa/ipa_main.c | 13 ++++++++-----
>  2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ipa/Kconfig b/drivers/net/ipa/Kconfig
> index 01d219d3760c..a9aff1b7977d 100644
> --- a/drivers/net/ipa/Kconfig
> +++ b/drivers/net/ipa/Kconfig
> @@ -6,7 +6,7 @@ config QCOM_IPA
>  	depends on QCOM_RPROC_COMMON || (QCOM_RPROC_COMMON=n && COMPILE_TEST)
>  	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
>  	select QCOM_MDT_LOADER
> -	select QCOM_SCM
> +	select QCOM_PAS

"meh" for the reasons stated on rproc patches

otherwise

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

