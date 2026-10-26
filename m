Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211A9606A323
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FWT5cY73;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cYrsFGR/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8284510ED66;
	Mon, 26 Oct 2026 09:55:41 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 803AD10ED5E
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:55:30 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4aZ1V2222712
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7eVMbuoHp1d3jFS1u8g/b+NSl629Wv469YVA1Y04lCg=; b=FWT5cY73LYPpV905
 WS4jiollJ/3aJTO/WUKXZt/iLngIwbjcfcRg6kOIMoYR0kTxcZykNFSDQJpBSIHJ
 2yc6nJjSoJDYRP0WPNjgB06MGCpLw6kOFQbNmo0OaYF9upCihH0ar70EPjRbOTT0
 oZeW+FYFyOvMPbVUy50KfRLzkEErDj3Rwd2C0BrE1H8USfmph4yl0DmzLHLJBdMc
 IWy608I7ORG4R1VnMsvh0esdRTaBsC/8bmaDEiHnvAl0wffuzGArg9+D+IaQaL/n
 c1LpyNAdGQhw7sQnVn7Rh8gs28uxsTDiO0Uy3SqKpmSfuYlXwpOuJJ6lcfcYEqbT
 lDWWCg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvdd9jdn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:55:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-536540909e5so12538211cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793008529; x=1793613329;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7eVMbuoHp1d3jFS1u8g/b+NSl629Wv469YVA1Y04lCg=;
 b=cYrsFGR/Dagt937hE6s5Ryqlk1UlNauTZ+0/d6slLrWpORJbVSUY41k3Z0d8tEEXcR
 Q4CwDyL1c4SUVGkh0rQMbBvE8NVAlsZCzU59DqVknUJmzFqRSFgLqsxt0fxj0l7xCe/c
 fq9iKL1kAsOm0QQPLKqM6oW+fg7BRU/YzOihqIegCbZMoAVlg5R1PUg7lXKfnZINi/GV
 RtN5OvCSNQ7KLvBRXsH20uVXxRrAHV8WOVSwdSu+LevNRJuBcVn1KF3yKNCrsp7AdRwY
 Tcy1wXYq7BmuA1/UI+eyCN8IDCh5nDq+u+rShbQUVjKf/lVvb7C2nI3y16occrn0eDNH
 BmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793008529; x=1793613329;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7eVMbuoHp1d3jFS1u8g/b+NSl629Wv469YVA1Y04lCg=;
 b=QJ6p/w9T6X7F3C/WchWuvLfWB2ZcVmWReNO1d69IE090ALXNdDmm6CtxbAjPw9asSw
 9qJ8QYohpOoF4qQ33nBLWovoV7rTMtvzLRXFquQL1M8C7bVUyVMGPn1MgbNjZf2rT5IP
 lqmqbHpjeGM5bdvTG3hNvrIb6EpR+lOTyfjh2HE/DZjbeY56roYlgeQkDb4WPY5y7muT
 Y8rbhfZcuWWECZ5RSXJgHMty6U/WXFKIEPdALs+n5wvik9OuyBFchyxe0HD5uT0cPJKr
 TdiqvgS7m0gQ5aguzTnODvIiRN0UKp4mOYRdoDPqX41RXESUAxTy56BUJ9y+dfbOXheg
 UaFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxp8+Sg716i52lTYFjCKMToJTerG3ZtzLNPLK4U8cvpfkjP5z8Ek9KntsFWViqrb++EXYk5Wo2UPz8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKjv9wDKVG4SuQsCz+dtXeH7qTCLUmjdFtyicqIFPm/PaQPeWAS
 xhe7c0gQp7XqRsCzlewPrSZLLws1C13U+pt+P99Xw1i9lCVOLpmgFN/A2RfyWnTLivtbXm0ELD8
 hpyJeLIrR+afNf/KVFhbbwM6LwwADIEDnmY3Wpbz6S++pKvh68em9VRxwaZ08uAgmsowpYuQ=
X-Gm-Gg: AYBFou32sX0XlD9W8rLTaTA84EAtwCk+QnNZMZxT1FsYnTtF+B3287bX/cQHN94r2yz
 9VadTQ6idnyPq/hMaojUUfDk4tz8yp/1ty8VIu21U/g7l5sZNhCXs+gi8A7KTrAQU0qAhMMp6hm
 Y6z+HBj/UGPp40L9CWikzf+OCGsIyQ1itbX4/rJSzxFJx/sb6A5um9om2qxcB+NdvvqBqw/HbOz
 YgL/fT2p2MFWRrNW0j6pfLINuHqpoxlSNZJy6r19rsntzm5qQeEpO/Bsv0fkcjwA/v/IsnsyICK
 VnMUj7a+NJ8lwwmqodi+OQioQ7rTAvHuWs5KSjVgNKp5Jne5MmGPAuYFS5SH+BubKgVv55HvfRN
 IqxQjF9FMURboTDQPE6q07A==
X-Received: by 2002:a05:622a:e2d3:20b0:535:1a83:1251 with SMTP id
 d75a77b69052e-5383b5b88c4mr95942071cf.4.1793008528685; 
 Mon, 26 Oct 2026 02:55:28 -0700 (PDT)
X-Received: by 2002:a05:622a:e2d3:20b0:535:1a83:1251 with SMTP id
 d75a77b69052e-5383b5b88c4mr95941781cf.4.1793008528118; 
 Mon, 26 Oct 2026 02:55:28 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b44595d5f3sm3471088a12.10.2026.10.26.02.55.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 02:55:27 -0700 (PDT)
Message-ID: <188545e7-c317-4f7a-b4d7-27eb3a4cbd07@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:55:24 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] drm/msm/a8xx: Add AQE firmware to Adreno X2-90 GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
 <20261024-assorted-fixes-oct-v1-8-2977f974ddb7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-assorted-fixes-oct-v1-8-2977f974ddb7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: KCiUpEIw0cpJnUw42ULMJTbHZK23J0Ft
X-Proofpoint-GUID: KCiUpEIw0cpJnUw42ULMJTbHZK23J0Ft
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOSBTYWx0ZWRfX904kVprHsjE0
 q6O5y3XLuYta0Y5obeXHY0wrbxPF41cQ3LStjiRL1+LFgFQWOH4PG1PkHVKNdsrK75ZUlRAPpTO
 Bus7ihRK65pj28GOABqoBxhitU2EV+zv8Gb+whoppjXHSChXXVftmqA250s6tQrZ6dQQqhyFkP+
 m8zda6WNqqQuEjanK4SH+qGYP5dFw7IrZYa+j5e3t8l3G7uKCSJNik/E3/EHIvA2Dg8bWk8BQWM
 N46cSKBlE2kr/RuvQCRni4M0vhsxROLsL2YUd4Lq4C7iMHNejGqVFMsnpdLi1CbMuhugMGJfh7O
 5QZzUoRatE5NkYvcOxS7fqCLkzK3amwf6DbnqNzDItBiYNiAIdkGJ+amgnmIn7aiv0x3ZjnjVpi
 phGzcJYp2dmDy4SKLhEb4gNSZSkFDOncJlrXGnsfo2s2Waj71D6Yxvn8kPMYold4pjqgjFcTmOS
 PGmLf18Maijhp7xBSMA==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adf2391 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=nkdzZAihEXyvZ3FekmAA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOSBTYWx0ZWRfX6XWncRMHa7Wz
 mIvfcJ1QhZfTIRyHEgo3o8Fknw3QAwoD++5mt7yln9lOMWK4eINWHBl1D5ePXT35PPte1qkcGjQ
 45OnQ5DAIz/vg95XA5Hwm2keDv0GUgs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260039
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

On 10/24/26 12:30 PM, Akhil P Oommen wrote:
> Update the catalog to add AQE firmware to the Adreno X2-90 GPU.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
