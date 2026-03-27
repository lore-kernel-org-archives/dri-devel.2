Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE3110ED65C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCD1010EDB5;
	Fri, 27 Mar 2026 11:32:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cI8GtQcY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XqxuP9yD";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6074810EDB5
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 11:32:40 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62R6vu5w1226419
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 11:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 chefL0VhCP2pkztsvpJhn296SxnIHxiefqjU+kXnQV8=; b=cI8GtQcYB+hiYNoF
 CkemIfXlARwTQCsG9MN2k0UDCiLCkt/V7+QFFfHWNuNem27Qmb66I8Uznq+n9ZAp
 J/SN9i1rogwo9FlCkMsS0HbOHEprZWPdhSN5ZVBRsvCyV06S9CO+Ay8thXyrWiCr
 R1eUCieIKXoq/RVLQkuqskhB89f/7k7/xDG24/XGjDbHnRrCzOckHZUXzgPsUnuo
 OLlcZg3v+3QsbSfyvU+HKJOwNTBOPvlwVl12r2JWGBQm0eozlkPamT62cx7TsZz0
 5E7Ty2jnSVn94IUx33rac8NJmQLhqd85Hn1MDmX3lkhK1ljTP6Q7RuiFMaJfyIGv
 51whLQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d59r1bbur-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 11:32:39 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cfbd336c3eso66364185a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 04:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774611159; x=1775215959;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=chefL0VhCP2pkztsvpJhn296SxnIHxiefqjU+kXnQV8=;
 b=XqxuP9yDHBVEzh+U+q5lXnyinK0vUtov3XEBWKYA/NlhpOE08lyU+Y7aHEHxAYj+t/
 cugtPMQL04v8FljA8QaTIwQ1MQyjn5YixmRAWBoFvhQgXYTx7EfKFiFEDDzmn8fSgLvk
 S14xVRCX9xjWpAJ5ijjUhxoWabjqXg2Rjm1OZG4pXTXpWvEpGqzpu+OPBhFF1+XDgJtl
 HIAzTGjpLimxEugW/LdjchhPsvnI7DL2EW/lcegx+c2vHI2CI+66KtxVvVDAoiG9rVeZ
 0bHWGzLg6Uy+h8G+P2V4Q0b0ow94hqiDNZ2gfu1U/dZ5ciGm2rJ1Hf/Z2d1KfvumLMhj
 5QeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774611159; x=1775215959;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=chefL0VhCP2pkztsvpJhn296SxnIHxiefqjU+kXnQV8=;
 b=QQbtqp/TqBbTO41GWYkQHyFf9K/oHxyCMwfqworowAq+wX+3K2FCy4ZNbcFgwff4T2
 YyNAClwTL9IVBhJycvxUfW04QR/+eCpEjXAGAGU5jINY6HjCmFnZ55RWnHgXYQfNlW+A
 l9Pfzb17BcaY5MiIBkvtV6gvnSL1TBJJESyfFbEdNw6BHiM26F4hqkBiiyAM14ApDHiy
 7PJ+Y6o2KGDyhvskA6bNSnFKxJmII5qB450LJTUHJcElsoeMbzOv5Tst/yMWvZzgUES7
 5xDChc1xG7CnG69jySMlKLO11sBMwSWdmAJFRCrlOP/7oa/GnEY9c9Ax+ReQQwotSsXu
 bpkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMlk5wwlJxOJrfw8VelSRMmDgHD/r9Fn6a8+BDjrhrf7/b24uCOoiPsuoJLSxBervCFEczU8BeRzI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyhZSjLq27YLaA//SdzM3SR4kjt4RH/gDDVGDP9tp/gtEnTgZi+
 5fyWgagoKah/gUGGDZCGckqpzsfXy5PereCmZ30QsvckY4STyyfxbllmH4PGwRva1jo/rlGuX33
 MHP9AGIx8Ib52QFcnc4ieRpRgUew3l+85PRU+Rl2z/QmBYwv/EgnPbd8+8lAw1bWOEH/j30s=
X-Gm-Gg: ATEYQzzImWmNQb4z4YjLdel92zfc5idBuCoPhJIFdIQGPDUyga9NknB1E1YN2GgOTPs
 PkIO0diBDQHvW7IN4RiMUl5sMGjMGw2F7wq44912RYkpzbve8USwLKRMpuL+zwElDGMB3CLBF31
 lDF+JP5d0cAjfTXnBwN+0cztpn8/Q7OCoxYIx/pwundLK9P26ff3JrqBmS3zCGjQQukZcmTxdFQ
 EGESdnQjZh4REPwmYotjz9km+YVBjmlee9zzyWau5xh/G0LdFjK+dcYEknjMf1oAyKx8jvTh8HU
 r1zTtHmaVGBy+Fm1l9/J+U9ZyjZcZ93f/swq3N03ay9gUNkMA/Y9cnaW1jzBezOf1QP73i4S68A
 V/Q0fBAQJNXllkXh174NrMF9Jl3WGBAvsD9BDD7sPBQnA/bhm4Lu0Vkv0yWKbevoAFzVrBs4Zo3
 6ovzY=
X-Received: by 2002:ac8:574b:0:b0:509:2c6e:f6e0 with SMTP id
 d75a77b69052e-50ba39f670dmr19717461cf.8.1774611158907; 
 Fri, 27 Mar 2026 04:32:38 -0700 (PDT)
X-Received: by 2002:ac8:574b:0:b0:509:2c6e:f6e0 with SMTP id
 d75a77b69052e-50ba39f670dmr19717041cf.8.1774611158427; 
 Fri, 27 Mar 2026 04:32:38 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b203c10a0sm240967966b.39.2026.03.27.04.32.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 04:32:37 -0700 (PDT)
Message-ID: <2ddea137-bff2-4576-94ed-4f3a48aed386@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 12:32:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/17] drm/msm/a6xx: Switch to preemption safe AO
 counter
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
 <20260327-a8xx-gpu-batch2-v2-3-2b53c38d2101@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260327-a8xx-gpu-batch2-v2-3-2b53c38d2101@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA3OSBTYWx0ZWRfXzpWBtorfSD8s
 2LPChBKIdm+X3mZGOQFybigtIleRXmKLa+OnowV6nS14sAwT/X5vK0LO6XXrcdG4vCjQNjgLxe2
 Y3iLJvhnlfB2QYlHNAdYTT1cdB8MHavrIxxRRPiPzqg4L89JhuBqOdJJredUxKpgVuhe2vp4fHG
 D5Y+R2ObQjWjUkPTKFUXjXNEhgQMUmw54qqCG5+xVZ5dXdYQrMMTKq2JLIYAa42V9oya4UoRMse
 uNCUsmYk5fTps9Sc9I8w+OYIvl0zlwmtEI+HNyJYSugkEY5yozlPlaAMR2AYlC7f2YDqKDjYeWG
 5wBQgCb6TKqxcJpKuCeOuezhG5Pfhqygii3byl5VEFMzammPA2iLddk6liuriDBoWZIOE+XDteg
 MVfBM8ARdL2aJafpDe4ozgCGn5h6YzothLrZWWv7ysycD9Ordb1OGMemprezmqt0yeDdaZmG9AL
 RkFoY8FZ1X7DsDZpk9A==
X-Proofpoint-GUID: 4tcgz8kCoopa2GYbMzG_noO4H1w6p5ZB
X-Proofpoint-ORIG-GUID: 4tcgz8kCoopa2GYbMzG_noO4H1w6p5ZB
X-Authority-Analysis: v=2.4 cv=JaCxbEKV c=1 sm=1 tr=0 ts=69c66ad7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=wLQHWzgrVt_HrJ2nkkwA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270079
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

On 3/27/26 1:13 AM, Akhil P Oommen wrote:
> CP_ALWAYS_ON_COUNTER is not save-restored during preemption, so it won't
> provide accurate data about the 'submit' when preemption is enabled.
> Switch to CP_ALWAYS_ON_CONTEXT which is preemption safe.
> 
> Fixes: e7ae83da4a28 ("drm/msm/a6xx: Implement preemption for a7xx targets")
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

(this is not a blocking comment)

would the _COUNTER counter be useful to keep for any other purpose?

Konrad
