Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B323C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 15:07:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0907A10F833;
	Fri,  3 Jul 2026 15:07:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="I2laStE7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NHQMyQSt";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A1B610F82D
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 15:07:08 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663BeoJF3053275
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 15:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g/Y1MW5COel2wWx4p2DALR7RRNLnSVd1oYyWrSpSJXk=; b=I2laStE7JVO14Zny
 RUxphdbyneMw1OsRlTiKt0N99oI1NUu4z/tGStXgdRwGaWC+kYOJ+B0YCoFSgdZk
 3kFuL3t4LyLKsVcAQDoHbZBAdp6uHK+DAp1Lvyg/4TDPszJd3VK2f1OAfufBvxXB
 HWDTC78TO/jS0BMzX1rmYzGuPS6h6LYKvonLQlGWwobLQEmNeTVNVD4wtPSFw69b
 /YWG2WQvs0zTl/iG/65M0nNCwOOvyH982WAl8ISIzOHiWx6RisnoNPrGzuYlQBIy
 r2Ayt+rO6n7GP7/qDetmB7+9Y3D3G/UW048SZ4923U0oQOznFMwLEf/z/Q75j3d6
 OswDTA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f67j01xx3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 15:07:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e66fe6152so14503285a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 08:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783091227; x=1783696027;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=g/Y1MW5COel2wWx4p2DALR7RRNLnSVd1oYyWrSpSJXk=;
 b=NHQMyQStkvrBGSmy2LsQoH76sseCb+L0+MJvfnSqXWDU10DPwFnFLBp0FfUHF6oStZ
 1rDFxWUUMw0WyelBvduDwaKkYL9AFkjTf1I6Fj7njQBSgmejm5a7szEdSnzQoKWFgue9
 N+8et0kB4cnrxen3sT49WiHnPhFZJYrmsLzLeQdJ5Ng8z7Cx0at4u1N1XL1x65xQ2f53
 OW2wVJl+exRE36U6XSaEurOnvgBAkpt4GHos9VRpN49zN1OK1SRo+wSNjYQHdNYmkUKA
 zrdOZDUHCBohCw4kx9HFYbATfORvxjFDJsIszUBHnkjkjjU7aj1meze6Q717lVximuRw
 jpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783091227; x=1783696027;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g/Y1MW5COel2wWx4p2DALR7RRNLnSVd1oYyWrSpSJXk=;
 b=oN/j472TpO3Dl3ZXBAojGUsF7dZc7UgTN9q0znPkADLG1ycp/kIhR/S0A7qlqr8aum
 5R2Xdhl63bfWk9iuJ2ScRvkMKvg6b0ecYdYYoJD9/kvbGG4evaReo6aGIUjzbvXN2JJK
 0Gy0/7qoM/tC65Xf5kTQrZQInc9AB92cuW+dyDBBwjXXif+CI886DJ66ypGYzdRFB5KQ
 pnMOClZ2Ka+hMXE+s5nJi3JRbqTySWJ+zq88kTADnB5qXOgJrbouFFJyqg/iO+oJf/6/
 zngfRREIdFeq2b5I3WOdCjt1HzEdYHYOcVcxQWiUVtKeVkuisXhzg8pn/fiDB/m+B1RZ
 YKCA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+WiT1DHUS+XdQObsm6Lzj/B9ihcGW/1Y/Q4JBJVkO+zeFoFq8PMIkkj7U2fCSXPJc8zzzaIqCtw8g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz3d5JyB1eJBfbO5qHrUU6H2XGR3PWAE7pNhDSbrF4SJRnUGZ++
 B1gSexZipXhsH+yZHrHE9klbyPAJSRVZBUgV4gqIgcj+PMQjqsVz4kFAvhPf1VPeWpnNkQufKW8
 kC65Wwzh1jzwFpqDQRt2wWWsilr075W4AdCHJ17lTKqScL/+LYMDqwtatClnWotodCQ5LnpE=
X-Gm-Gg: AfdE7cnliUe2Mh/hS5qtvBCsnz9LPCroHDqvLU35+VIZplOBf6h3AbUkoYdqFqN+UQc
 YYkDHs00Nc87rRSaGvhyI86eJAqoY+y5NBZxtAuztppk3UoucKsgZicNeWkvgvZtfhNgOA1Erw0
 PeBYaAEOe8bBy5lSrfJpZU28kUTAe/h1Seyd0VGOjZJlqDm2z4X/1WTjfj9AKbesG43UYkcRtR2
 8RT8CY/WUBeVsifOjcoowEZBFRemSQoGlGogCLwVzVY63x63GFOKKX8STWxHZ0TNurg5t0AOjAF
 UA/Te1UzrHBL+W+GjtMH8avomDp0487Xa53+8KtB0NRVB5iAl4c1YzgcjILdepAvzVaCGvGHnbo
 Xyh3JgZNCUDtZSj0Y9vurYbAY3ySBheaIEns=
X-Received: by 2002:a05:620a:171e:b0:92e:705f:1626 with SMTP id
 af79cd13be357-92e784f65a3mr825403585a.6.1783091226788; 
 Fri, 03 Jul 2026 08:07:06 -0700 (PDT)
X-Received: by 2002:a05:620a:171e:b0:92e:705f:1626 with SMTP id
 af79cd13be357-92e784f65a3mr825395785a.6.1783091226326; 
 Fri, 03 Jul 2026 08:07:06 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c12b628d65dsm295433566b.35.2026.07.03.08.07.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 08:07:05 -0700 (PDT)
Message-ID: <a2dd4a61-2585-40aa-9d05-18b66f3450d5@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 17:06:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/14] firmware: qcom: Add a generic PAS service
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org,
 konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
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
 amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Harshal Dev <harshal.dev@oss.qualcomm.com>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-2-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260702115835.167602-2-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: VmERx1CH3eXK3NtwzYTivSMTAAWHtSeo
X-Proofpoint-ORIG-GUID: VmERx1CH3eXK3NtwzYTivSMTAAWHtSeo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE0OSBTYWx0ZWRfX7Fh4g6Ok28+3
 W33KWh/2tTLB+JoxHydrBx26+PmWwnPa/uxbJMXUoJIAkC+o9wXtmoiSLaD+0CEoLaCHAMPIkj8
 McuAn5Ywn70fWHkjXOUR/IUwUqCia9E=
X-Authority-Analysis: v=2.4 cv=Yuc/gYYX c=1 sm=1 tr=0 ts=6a47d01b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=DWWpLck2SfFL7czMIZ0A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE0OSBTYWx0ZWRfX4Sc3pXdP+EJI
 h6vBGw2L4pFYhfqXxNRBDV9WAohrCgYLF/8rfgNQ5n/J4naYFB6zYltp4aJwTZRgYO73lVQVkGQ
 eCB0eloClLvrmE7Wfk5yDCd3hs2NYvv9HyEYP6Tg44hKobNgLyrzGLNBO/Qpcii8f4c2e8/g1rV
 EHRAbjJpe+NwbzFLQB3kZYv2LYP9A25DARcWXmQgURohyRSWX9n9vuVKU5noag5iXGEEK2PEiOH
 bMIhZex2/HSvA4N/jaEy6uHgq/cOoVWS5XC2wBLcBUZSgBy6dhUA44+HNFYFth73i5f046Buqn2
 C4ZqbDXsZCmYYGzfzMmh+Rne9zU3hnVLYeuwgAG6fhFHrrvXZvf665IgGRPQMv2p7LDTZHZqOO1
 Jr6HkK89KnjbdG/pFBQ48+gKobFahUeH7VeFC31du2Zc9fjKEbf+HUQZV6+0OE6j00qoZ39KDGW
 SIQWxIjjPAEXmH1mLrw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030149
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

On 7/2/26 1:58 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Qcom platforms has the legacy of using non-standard SCM calls
> splintered over the various kernel drivers. These SCM calls aren't
> compliant with the standard SMC calling conventions which is a
> prerequisite to enable migration to the FF-A specifications from Arm.
> 
> OP-TEE as an alternative trusted OS to Qualcomm TEE (QTEE) can't
> support these non-standard SCM calls. And even for newer architectures
> using S-EL2 with Hafnium support, QTEE won't be able to support SCM
> calls either with FF-A requirements coming in. And with both OP-TEE
> and QTEE drivers well integrated in the TEE subsystem, it makes further
> sense to reuse the TEE bus client drivers infrastructure.
> 
> The added benefit of TEE bus infrastructure is that there is support
> for discoverable/enumerable services. With that client drivers don't
> have to manually invoke a special SCM call to know the service status.
> 
> So enable the generic Peripheral Authentication Service (PAS) provided
> by the firmware. It acts as the common layer with different TZ
> backends plugged in whether it's an SCM implementation or a proper
> TEE bus based PAS service implementation.
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> Tested-by: Vignesh Viswanathan <vignesh.viswanathan@oss.qualcomm.com> # IPQ9650
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
