Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A06AD35176
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 11:38:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB10F10ED93;
	Wed,  1 Apr 2026 11:38:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LhBsvXTg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iiBX6lPp";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 112A910ED8F
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 11:38:44 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6317EuNI4106888
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 11:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=2YHUSDWpXQ41/aYcBpRP3MQ9
 m2yOueV672FiMPwKgK8=; b=LhBsvXTgVZhhuPUCWHlJmJt7vw7dA+9UP3zXTZfD
 gorHDku3dPsDnalbqOYR4I3LzACaV/kAUJfVtiezGV4c5Z+3vwEyHbFBLh4HAlMb
 0ypszBwaO70qDP+czIJVVhNf2wHjrkDQSuLYfzCI8aoGgNO6KwyJTq2wPsrhpImg
 PpAyc/zycQacjlVSYSRGdi4WBDzek/08hXpgHDrGlgz4sZOMMD6uj2cwxuqECu/X
 KXHAqt6Sb+lFtwSAwyKJLtmkkLbjpwM2Dsrd6wbSTCjpvR9pQOUp3unKi0Sw7gR6
 anVk+GzGvq4cXfx2MaUuxqnji5TXXlSR0yjxmgGTDJIIJQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8xt9129u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 11:38:43 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b4fe4ff7bso26188201cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 04:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775043522; x=1775648322;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2YHUSDWpXQ41/aYcBpRP3MQ9m2yOueV672FiMPwKgK8=;
 b=iiBX6lPpUf1YFf+Dg2s5M16l69xmohMNYgd9kD0vGO9J91Q/U3+IZXwHeDv6rTnW8U
 HcoTwRtSsKHxJPwGZA1Ds81CwTF+rZwkBBNTrW/nqCLeKEpV+ygqVjcEDRAjsdLP6QCA
 l7gKeD+BlqCv/5AG/OSLdLb2QIcJVqYz4lvk1Y6jGEAUddR9wep4ZYm5gJTIzR/uWi+C
 V3w9wrVzk7qLz3YPJpn2cBdBqzsLQRPvPhH6fFCoXHIZt5qkKQGiZM3hsydWFSiPg3jf
 liWgH1xYYFyu4DVT2XOip1y3VpUUM0tA2/JoVSir04xmcOiaH5rqkss9jJ8Cvs9cjwE3
 8Gvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775043522; x=1775648322;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2YHUSDWpXQ41/aYcBpRP3MQ9m2yOueV672FiMPwKgK8=;
 b=g7gFWOWwgEwAziKNJJ5a7JlNReJp//BA1WRTfj3gY5mKL+i+SU25HjNJt6CqgjKanJ
 MKKyj7Kbb50V1eu3BxdqbrsXDoYLrqYQFsPGrPBFrceqq3XRqwww6z2fo8yeVrAcxB+d
 QltluHbz070DA27yCZKir3hqyaJi0gSyL2Y8+p3pvH5e57uM7DAcZ2mkt6qqlUnNeR6z
 UvQdmmhFhAMCfNijd5LN0Tz+cR0H40oORIz3hi/PbpwhMBqeiVU5YyKP+rGfxQA0UUof
 7NBPZTPhpjXGNVd4iDm2eOFrxjRQO901nqjUTKrtg2u/3eZfXGLYzFsSHSLYW4+HpQW9
 Jgtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw0NlfIfM/WU9SMR3R/yBG7hUhKiY4ChzqzhGmgVReiq0P2ECH8SS0n5J94ldoNn4UFKWP+/nLu0c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywk+9WVYULSwaK45sX4seEAt7XqBBeusuCymZQD84M/90Ho/cne
 Zhyj4ZSR7EN2oeb30wk9VFj9b6Hr7MMyO+vjfmw6OJlwYCDhKgkooLLjCQsF3jj6OFMqAKIAFaL
 5iL2z9dkP6E6eSLXxwJGuKzZkVAZKDbNaPJq0HNirtLybUsb7xMAeeArw9hzeYeT37Gx3hnI=
X-Gm-Gg: ATEYQzxcLcOGdwyAj0qjgtgZQNW69G7m4uDaD08dMjvPxIOUpx3FkRrNgHF1w+3R8l2
 t+bv7fbMfCH4tU3y2UMJokNepBooGVoV6L8H3Q8N7i4M1sicayflaTj1F+uDLdpCykGxzThlD1Q
 JdL0/t7PBOXgOwJWIkldw4RObQUWQkxCFMgqBRCoQItcHDkD4PRjlVEMqLSTeu5aY9SngigTtND
 dNfUlNiyCgOuFErV4P9UUi4OOb4AsluczUESlyDgjjXN6olVW/15wcmzW7GBhc186Q+G0Wh+oIw
 +PWCcUJBstFZjIN6W5ZlFtxhG+k/Upc7+YYoVeiytn7jMxb2Sn1c9h3dg0ZELuGhP2hylx/7pfX
 NakxS9fqvnmuXtLceeq5AYPF6sVWChGsSt2Y6/wYYp6f5rhXRGJh2UxQUVZhm3KmU+NQ40mW5Ue
 QKz7EtrWIXxerZTe7aH04Iab+I6QXqcDQiCgs=
X-Received: by 2002:a05:622a:87:b0:50d:3efd:bd93 with SMTP id
 d75a77b69052e-50d3efdc340mr23635731cf.11.1775043522540; 
 Wed, 01 Apr 2026 04:38:42 -0700 (PDT)
X-Received: by 2002:a05:622a:87:b0:50d:3efd:bd93 with SMTP id
 d75a77b69052e-50d3efdc340mr23635471cf.11.1775043522130; 
 Wed, 01 Apr 2026 04:38:42 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b140ae63sm3193341e87.37.2026.04.01.04.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 04:38:41 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:38:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Wangao Wang <wangao.wang@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v4 0/9] media: iris: migrate to using global
 UBWC config
Message-ID: <hko7spuzbp4ac57nligh75vi3tmz6mfb3hzuq3pyvaa6p5lyqe@6k76s47t3jex>
References: <20260125-iris-ubwc-v4-0-1ff30644ac81@oss.qualcomm.com>
 <177499105231.956796.588474423586543717.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177499105231.956796.588474423586543717.b4-ty@kernel.org>
X-Proofpoint-GUID: QpKpkXmiv0CVUEoYbFwjqxrEB9BzhyWa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEwNiBTYWx0ZWRfX1V2QsexPbhBL
 uF2Ex9mpjMStCJdhO4rGu+wyvcL7In9DHDDcxTvLSTvhvruzKI0cr1P6dnxu61+CZRWZg0rOFYM
 s+UgOZs2RSc9ftkSzM/vjpb5lRSsaJI6gdq7103+OlgbaWZIAMsKuW1hnOwE0KaLXjHrdaIiQzn
 70T+lS/IcdjpIYp6BPwWJ69Q+pZAMwqcFJQGJnSOwOFRitHjUO7RW7ujXNR7ecRlHYrfX0F+Uir
 Z9Pui/1SZXVomgKFjhS4kcjvPlTQ9c+gIIuwSDwJJqGLUsGAkvq9CzD6qcZs0AhRGjznfHFGEsC
 gdg9MjUTaQ1hGGYPePABtOpnaTCFRLXPpgn05ewKEZaJomBxvNoVS5LOVxX9qUlHlTL1zrAH8ba
 DZKcupTzOzIBT+f6n4fRtf/R0NO1/u4eK9mDHK6ijNT8xRNl2sc75t9KTuTcVzE8bKtvY9do6om
 /m3lx/T5kptOtH/MN6g==
X-Proofpoint-ORIG-GUID: QpKpkXmiv0CVUEoYbFwjqxrEB9BzhyWa
X-Authority-Analysis: v=2.4 cv=PoGergM3 c=1 sm=1 tr=0 ts=69cd03c3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=gYGmWrsk5Bp2t3VVqaYA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010106
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

On Tue, Mar 31, 2026 at 04:04:24PM -0500, Bjorn Andersson wrote:
> 
> On Sun, 25 Jan 2026 13:30:02 +0200, Dmitry Baryshkov wrote:
> > Having UBWC configuration in the driver is error prone. For example, the
> > driver specifies fixed values for HBB, while the actual value might
> > depend on the DDR type. Stop defining UBWC data in the iris driver and
> > use the global UBWC configuration registry.
> > 
> > Merge strategy: either merge SoC bits directly through the media tree
> > (with Bjorn's ack) or merge to the media tree through the immutable tag.
> > The drm patches will follow depending on the way the SoC patches are
> > merged.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/9] soc: qcom: ubwc: add helper to get min_acc length
>       commit: 68a66a44af6e196ca426d1250104d3018ed9e74b
> [2/9] soc: qcom: ubwc: add helpers to get programmable values
>       commit: b2571ef8d4ec9bb636889a9132090bcc3449792e

Is there an immutable tag, in case iris maintainers decide to pick the
rest of the series?

> 
> Best regards,
> -- 
> Bjorn Andersson <andersson@kernel.org>

-- 
With best wishes
Dmitry
