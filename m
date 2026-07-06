Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7C2C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 050E210E908;
	Mon,  6 Jul 2026 22:00:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nXloEUAu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hG1zJWaK";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 274FD10E261
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 22:00:31 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEI4r1639872
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 22:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UJ9CchBYgkba1ighCLzdrX5XHMqvhwflUCwUXgnlH/8=; b=nXloEUAus6N2V2gO
 A1DO4owpicH2FzAcrxJEyykSEBlIYqyCSXQsYFhlOY3ekVtKlmFjCwGDAHl+EtHq
 98SRm2L5V43Ueuu/GmeTDoJd2lQJ/0sjTRpiz+3bYYs5JeZ12/FNmy/jsPMXAU4e
 5PRAEAi+2m/qIJHwvyXpy8ZSI+XeRWvH8HTqvvM4q/WWGD4zqZMtX0K0iQ0ZsUP4
 pfP8AJHTtruE0TAYsG/HSVdadfx0nKINjL++ym6AkwUdSjxH3DKrF7SkqA6tuzs+
 MOo2jrIpOfdwVmlFBHPn0FtH3N+YRp/zYhGUd7828HyJIeeM78i2FOrdk9RdJnt3
 vyGHqw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r316q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 22:00:30 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c89704da8c7so5608514a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 15:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783375229; x=1783980029;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UJ9CchBYgkba1ighCLzdrX5XHMqvhwflUCwUXgnlH/8=;
 b=hG1zJWaKOP5KRQ4zpew5E79pl10JOfId/dg3P+FBouGenBQY0XhEspMnUCqgsNmKJ1
 mQpCh8wk7JltCHdRnKZf0tZRxEx5VdlpJMtaezp+GDEBPYcd5RsoW4K4F0DOpCfI7JM8
 mSUQylXDmwAwd9PB+wWJ03+PN2vLw4YxUhp3ZyVLH7qVbJMXP4cct303Qegdb4se/Cn2
 9Bj+nI9DF2Uky+RfUz2Upa5XS+eqoTu3ozTVC6B7P+dEENQfrMSOk03isSJEwRnrG/kR
 Cnto+8+9oy28XqYGJLIpTM4nwuO1opeN7ADFTnOpj/0s6/g6+z+hkHpgMN+xqKcuAbcT
 s2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783375229; x=1783980029;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UJ9CchBYgkba1ighCLzdrX5XHMqvhwflUCwUXgnlH/8=;
 b=FcxRGZZckirs0wrguSTdAxMJH2wY52gIZAkE+ai+y1cBTPnRWsxc27JLnUFxHjtcTS
 R2oR3YbtjxTnQzC7gYjZ0Aou6RgSMThlMOfVtWUH3NwA4Hpd3pTgQGHsvEgiLbi7zXWr
 Fw9V8Y0WvxZJcGa1G7N4eU3i9bwb25nyrc+FmpX3a+2iJBZhEKoChwJoRhnPMbjx6Ekj
 Y2b+subT3FGONfLRQy04LQfB+xaFUKTr9RPem9CRxYDq9yaAcPvWivggvo4WbvoE2AY1
 S+sT/PPxsv/opYBSlHStpTxkE9Pz+XcxqedVkpZEwj3yfmFsqP3yZe5okN8bHf7S/II/
 LL/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoD2rbjEkVJHg29+yjFNQ4r8qOWtDnd2YNyUbbMaNuhVdqmvtkMvi0BiHVCx027VjBRsu+SSRHtyd4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxUzv5TVhCrAHjqyqN/atwbqPGr4CMga1xxQo0ZGgdN5bIXTiZI
 CJe1nT+n1CXWPLn8pooaLvJBABkMcSerk4ZCITHxtehH1Pfy2xRilOgGwRgXU7VM+9BWknUr/Qx
 e8nfSflaJi9i4PO/DQ+FTf2f+0P5lPzIOsh+Jh/2QQ/a2xcleyv1+isyJ+EVtoGaXu4MIeuE=
X-Gm-Gg: AfdE7ckbvrt5+LDSJAjXVI2hGa2X1r7UZ17QouIScr1/Y6N25EULzSvc1HQHbj5dF2f
 EAmB2VolPKsM91fHL6VLp78jV2o0GkrikwqbxjaigFLN6DwALgAajJEmW5thFZ1w98TrEkITGI6
 6vtgF65gdj6kh0gEJNeVPswMdAh8iZUuJYLaH5iaeLDzozny/YDWG4I+xKrW7yBk46R6z205TMj
 D4ROM+UJrmBG9mO+TMiK8ZS2NWz1eQHlyHedcw9ZGpAPmLqUY3VI3OwNE+WnVu2D2FrF5oTbIGr
 2A9RGLn6fxOQFUaebSoQHzRtETPW37TspzehDziQ4oj2XjWirh6ZXiJOuqJ/wQTX0qCHDskAIan
 OsO3qj//VCT4JZ/Oree/rjv98uHpG23fs6XY=
X-Received: by 2002:a05:6a20:6a0e:b0:3bf:a0e5:99a5 with SMTP id
 adf61e73a8af0-3c08ef84c1amr2736376637.47.1783375228959; 
 Mon, 06 Jul 2026 15:00:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a0e:b0:3bf:a0e5:99a5 with SMTP id
 adf61e73a8af0-3c08ef84c1amr2736318637.47.1783375228354; 
 Mon, 06 Jul 2026 15:00:28 -0700 (PDT)
Received: from [192.168.1.9] ([106.222.230.254])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm693268c88.10.2026.07.06.15.00.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 15:00:27 -0700 (PDT)
Message-ID: <10e4f102-3dc9-4fb9-a6ba-2dfc23a16df3@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 03:30:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/13] Enable LPAC on a7xx series GPUs
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, iommu@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <mn7dmfbyt2hnvlb7u2vnxurqef3w45rrjanhkd5ei65sgasfnl@l73s4c6yqxbe>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <mn7dmfbyt2hnvlb7u2vnxurqef3w45rrjanhkd5ei65sgasfnl@l73s4c6yqxbe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyMiBTYWx0ZWRfX+9SMpR5Tkeuk
 vGQHamtBMY/77iSAtt+W9VD7Y7e7lMZ2lTj7hC94tU7gabLMmZrsjYnnoH7sY9LO3/omHhF/Dzq
 +sYkMahe2kNk+rVy4pBPJhh81oy45yfoJaf2NY0kNapEhwdHd3oy/hpyhYFKwHpcXTuPehYAfc2
 Nt2xWw69CvmsVhwFCSZppmb0Ig77+abKvR6nTLSRaMfQDKbKdMhTHkhuGJnY+I4AH/E1OzSYyE9
 oT9WquxlNlM+yYBV3xCTgcRJO3uvcnSKj5rc8hiAxJBBQRZ9XDCAUmYUqScnGAnfqj8XifVeAmg
 RkL9ibA05IyjWKDk3wm66jv1k8dzUF7W3E05RZ2dLGGNnmvsxW53OvFXn2lhuVFYxBdvgPjbW3y
 1rGY5fOOnhYbAYKM6eto6gltAwt63dthxE5SWJe0bWsLJLOnLLpkDDI1EWmCjyhwtc/zHIdGMcO
 FXjhNfNthGodbT+o6Bg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyMiBTYWx0ZWRfXzJzKd5Urb2RQ
 rGMyFfG/hImxTYn1drDxzAZvdlND+GPgjL1xL7MoVhv+HPLucQkf+qtMKdwynXNdyGOtmW2YL7U
 e/vy1BiwIo9AKOHkCHrfzRc4DusJ91o=
X-Proofpoint-GUID: 8QLw1On6l-x-X5LPdCV_V2_uumBJcIRE
X-Proofpoint-ORIG-GUID: 8QLw1On6l-x-X5LPdCV_V2_uumBJcIRE
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4c257e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fsdq8dFr2Uux402FS9br8A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=TH67rrwzn_JHXtltAFAA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060222
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

On 7/6/2026 8:27 PM, Dmitry Baryshkov wrote:
> On Sun, Jul 05, 2026 at 09:13:34PM +0200, Anna Maniscalco wrote:
>> This series enables LPAC on a7xx GPUs
> 
> What is LPAC? Please explain (or at least expand it once) it here and in
> the first commit goes to each subsystem

Low Priority Async Compute.

-Akhil.

> 
>>
>> Currently hangcheck and recovery are broken as the patches to make them
>> work depend on https://lore.kernel.org/linux-arm-msm/20250911-preemption_aware_hangcheck-v1-0-974819876819@gmail.com/
>>
>> The series also depends on https://lore.kernel.org/linux-arm-msm/177919116291.814652.1720687887970998122.b4-ty@kernel.org/
>> to work correctly.
>>
>> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> 

