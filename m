Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0018606A326
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EmeCcw/a;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Nrwi591S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC12910E152;
	Wed, 11 Nov 2026 14:19:46 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80DDF10E152
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:19:35 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABEJGja2576925
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:19:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=nOnU/JaZv3F/cfJFlj7avMW/
 ikyx59lmzo0NaR/gsxc=; b=EmeCcw/aaC0JQj/Icd+SAeBRg/zEfP/P7Ps90xtJ
 zSD3/3FxQDZFeg52g1NGdcKLl1co7yaApS9/kmRLE8yAQeRR7SqhjV0NB/lfsdov
 O6Y5xYHUrs2QVPJOgb8eLFDApyWw+lEhFuQDd/XCPheUhnQ09AUENHDy5m5x4GFv
 4W4HFQaTzn6OIegmyLp6DW7efubUMl+6duA9r2QzhR0b+NaRLtgTwnRlzYzSvvbO
 BHIcxekW0iFOxVlI8Qok/8mD3hTqqqS+DfCw6yN4Qi+ObznJV493DnPamp8mX8RY
 /+uRB5kmUulFUwNJ7Nq55DdQNltxhcchduwjpuT6GG0/+w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvgjdj5k8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:19:34 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f5844cb60so675989185a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 06:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794406774; x=1795011574;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nOnU/JaZv3F/cfJFlj7avMW/ikyx59lmzo0NaR/gsxc=;
 b=Nrwi591Sk7+KyGT88gzrhTPPYoV2ZZeiRdF+XCJM3mApHN/+6EhOLllPoMk4wG4SMR
 Ny0Vz/kCOMatFoGVPu5TnYVlTb+r20qC2XDr/6KJlQqclw+aSAee/bOEi1aTploqEUTQ
 HuQfz101bY1LhuVn3BUd5U2KSMC55zblPHbSffUtT0EI6XgL63G6vVYexogYgB8WROwh
 b5d1PNW+URoU153DctURsLK7BdIuOB9PMp4qQ/MJ3rZ/Jxw3+iZEJRz3bIUQRirMeJEJ
 yeGQKtwywuHkXd6jp11YayK8dW7Plkfi0k+8upOCvGhCfopikwwB/z5lTKztw7GGBZh+
 AdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794406774; x=1795011574;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nOnU/JaZv3F/cfJFlj7avMW/ikyx59lmzo0NaR/gsxc=;
 b=f+BJyqbvBo9bvVZX64gI93nPnTDzeZL0ZL7Hy1kLhAaTTMrNkO/nFwL7iPuf81huyO
 qEFSbLaOtQh19CBjYuOg7aY454fqMNdDDdFQHAKR3eIb9quf/Zd9h1/u1XejBdwiBM00
 x8/ckyrcssFsB3ydrGii+hfv1Ez07G4jlAzX+U7YnHGWqf4HmzodmQE8bg33c5LMBiz5
 QCz0Dqb3Dvqu6W3ZhEJ3Lj8kYE5P6t3W6L1uGouiYj5NHltzR4swuCBnSIR++lwcis9M
 RxIIjOcoWRw/zIxgDfEaHrzjqCDyEuZ2/awT7uximnndC9k82oCRC6lMXb5GosDyrbYd
 VUsA==
X-Forwarded-Encrypted: i=1;
 AL+hErHSSUTbKPtLe9jODg70X6RAARAqR1kkNMc/XGIr0LQutMJd/PFIGss2h5xWT7cXZSTBvJKC1lP7efE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z80OHNdLUQra5WtTpLifhEhnTU5bo68HBEAnUq/uFeWQErmaBsi
 0giVFgJV6p0/M/JUTqihJ6U2Wp8HUaXVrgkdDuZ5/1GY31qLQ+p759LtH/Y8/mP77iabOyN1Df1
 JFYSqCougdMFlzMZveesT88vVKrMWoFGP/Y5Mxjw5j/mmnZbfM6Cngrs+4874dcSmOGLS9uA=
X-Gm-Gg: AYBFou0ucyUozJEGJiyWdep/tEyq47IYXNPi1RAy9xJrH30Kae0bS6z95QoDCSiWG0w
 1LNj0ifk2Rjwm+O7XVKMhfF1rr7oikl/U2DDZVr0sgKRv4WpL6iKemzwE8mlZiUVnB3zMC6HOEM
 RBqQ5M00ksUAPQR1uJ5zp6mH1fE2XCgUzm+EH6/Y4DkLdr0nyrXfmPrJboxXZeZDWGCflecD5qa
 ALYn8BGlzaL9BDqgvgYOkWSI9vcR358baGq7MeyKfR6+PlHWpFaWBKfTVnhJvAe+3tAXB/JnNGm
 Wy18A7ITfj4aHP6OOrV64yvhZJkEAr9bS2PgUbmUj6SvYl7c28vz8l1Bzh9ex6iRL1nmQLH2h4b
 TDqcyF5autgRo1rx8KF7y/HzOo6daQMX7aWE1oY3PrO6wTnIe5DiZfkeueDtWvRg0qLW4otpagz
 QlXd7/1Hnqs+0IcjsvKg2SAoqivtjiXprV084mFduT/6VSKPzf0kr3yZjNiMQYpA==
X-Received: by 2002:a05:620a:2905:b0:944:2057:a091 with SMTP id
 af79cd13be357-947ae8caf6bmr430181585a.40.1794406773806; 
 Wed, 11 Nov 2026 06:19:33 -0800 (PST)
X-Received: by 2002:a05:620a:2905:b0:944:2057:a091 with SMTP id
 af79cd13be357-947ae8caf6bmr430177385a.40.1794406773303; 
 Wed, 11 Nov 2026 06:19:33 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c157bb1476sm955304e87.60.2026.11.11.06.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 06:19:32 -0800 (PST)
Date: Wed, 11 Nov 2026 16:19:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Taniya Das <taniya.das@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v3 2/3] drm/msm/mdss: reset all block resets described in
 DT
Message-ID: <awb7bslhrhemsgvu7ubaejvurk6fecotgvqlwtvsoe2benqdgq@tvh2sfjbuzyu>
References: <20261102055026.438521-1-xiaqinghuan@mail.ustc.edu.cn>
 <20261102055026.438521-3-xiaqinghuan@mail.ustc.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102055026.438521-3-xiaqinghuan@mail.ustc.edu.cn>
X-Authority-Analysis: v=2.4 cv=E7tYNqdl c=1 sm=1 tr=0 ts=6af47976 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=pMXFKWXFfIpy_3urjHkA:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: NIHWTm9ssl-IDkvhGVKNrcWjYJGqLGcW
X-Proofpoint-GUID: NIHWTm9ssl-IDkvhGVKNrcWjYJGqLGcW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfX8m8lBS7Xs7ae
 5lr0xKuhZEqD5WwcdCqdkfD39DFAbZnL2YMXg2BoS2Cmop9iovByY+myPJA2fZCPiFlTbA2OKhW
 ScfgOY9rwPOwWc+sOULk/tOc5yoxAvVlKIEDg4s5+ZsqFIeizuFX8JlZ3Aggk9RMZcbLo5Ytpc1
 DDIa4mQygaGV9YlV6f7zkBHXj+vBYChMieHIfQLNBVxoZQqaViqGrmCOULHuFyhg7fUNWddCNaR
 EKZ9ATaXPIQaHTsGOLSiZ/yEhRLcxAxrLwBC19zk77hED76IdSQEN1e6/KwlXwmPouZNluWvX6O
 n87wMOLY+wIaaK2CfB8s/ol78m6ozr4HYjoJq9YzFYV4NYevKu7QR+V/SBDuJRsaOwTPCvnzV+v
 sMRtZTshUmqzcMq3SqpN5duN4gMg1i07vt41pMsEcnlpEUwPOlkUsVKEd/ASDiaS1CPzYOl+6NG
 95jo/nUuWxGJUBqH5Xg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfX6X5huD67Lq5n
 QJgCaL4s90gmkEC9D0Ng1nKc18rPjW4yHAl1JlNIygQb0LF44eYfbgZE1K5dA7fid2K6ko5p1xT
 140BBf3STOQNzEXpZJhBJE9B9JaDnYE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_03,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110056
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 01:50:25PM +0800, Qianhui Xu wrote:
> msm_mdss_reset() acquires only the first reset listed in the MDSS
> device node.  Platforms can describe more than one MDSS block reset: the
> SM8750 display clock controller also provides a reset for the MDSS core
> INT2 interrupt controller, which is left out of reset when the

Is it an interrupt controller?

> bootloader hands over with the display block still running.

What is the side effect of it? How was it tested?

> 
> Switch to the reset control array API so that every reset listed in the
> device node is asserted and released as one group.  Devices without a
> reset in DT are unaffected, and for devices describing a single reset
> the assert/deassert sequence is unchanged.
> 
> Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
> ---
>  drivers/gpu/drm/msm/msm_mdss.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

-- 
With best wishes
Dmitry
