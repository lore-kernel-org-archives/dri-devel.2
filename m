Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D246FCD8CA7
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 07:23:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AB0910E138;
	Tue,  9 Jun 2026 07:23:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dRAzBHgj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ty2KTs2R";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D1B710E138
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 07:23:55 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6593wpm0994986
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 07:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=26ctOLrG+LfjHtllnuTsf5tP
 cBJk7XWtRnEDq5KZ1vc=; b=dRAzBHgjI+X/qTcFzoUztqNcAfkx263QVP5Wzndw
 lRKaTtANeJbEYfIXHHTS6MYuvu8fXbkk9mASvntOzkxB2VeYShyUx3QYnxSaSf/g
 +dyNyB4e5PWOhJVf3vvnEZwpEPYPHzoNRi1Dpr2ZtbLHytu2rL+3opBMqx7jxUbk
 TJ2tj5pjV1oifggpLpwM1LFhDzCvqIX2SO7OuJ1H81wQ5Ycy03iiEySxoakcHjW6
 G0jKfKIMdenfrIkry0QTlwmd19Ho1jJfbiUljMlc70wXdRBBgUL9RW5kCYe6RA6z
 Dr1x0XzZCqoVYT6ODSg/eVJhV02FfcTP5dWTIUmV/PjVpQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4entrkw9ky-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 07:23:54 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8cea98a0effso94005416d6.2
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 00:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780989834; x=1781594634;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=26ctOLrG+LfjHtllnuTsf5tPcBJk7XWtRnEDq5KZ1vc=;
 b=Ty2KTs2RyuXE3q+xFBwnvfiKqh44GIG9rO/l1UAKrW3t5p2vrD424p/i1S9HS70Hc0
 X1FKDpzOYresbtIZ33d2vy+PYLykruY8kC7SjbfC1yjAvykERQjoR+TcGqcqymWyrJhd
 3dDDCIlp6EynuUzCkjHZImbQTAYHEhCwnz2vlw4+z6iCwlSq1ZhubgMiGsFj9qArQDHb
 B61+BC3oz3YZOGZX+R8MCxL70G81ih6KxhFZOF24WsrqzD71jaRMiHoweZaYKeyoCjaw
 8oRGYWNhtA0u1Mducd+88UKo/ejRhSsJFVDxH+pvbwUI34m4YfVYtXOs3FUhK/SdiJ7I
 +IJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780989834; x=1781594634;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=26ctOLrG+LfjHtllnuTsf5tPcBJk7XWtRnEDq5KZ1vc=;
 b=f+Sf/nNlk2bO4d932VXh1G9eg9KJ/BUvAQRkJTy5JoGlE5wW30+JNNrnLmSDCTK7+f
 EuZJPdMV3QxBP/ZwUWI3I5Kk0xvolXfrLZY2CFabmNtOA70vGgquMrPUy+RN/242jXlK
 nUcjbGUznc95gDd1LQN8Ih6QbPBV+mMPEBJ3+fVbTUHpPen+VdIdgUFNPJia1USN7xCS
 6ABM9IdVFcHQsGwRXg5vmnYFapl1MoH4G0X71PGwwIKZPsGSfdF2Nyligc5b05Y9bmbq
 kvlmkuyUzuVO73gDCjYJYhFXOXThYz/RAhTOYtbgn3PwZ9UzuwGaMDHk5feOhnB9+4tO
 bUIw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Cwm+npvYW2PMRW1R9IIgzav+AjqopkZT7T7EhlMdLT1YoX937TgGb0kXbcuK7SrviqQlHnrUSYho=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwwOvo4OJO2xX4TuZu2tU4qt+VNyb0E46md6UsP964xaibZ0AFp
 E2FkfIe8jfkT/444PvMRqs0MGtvpHgoo6Z2br62ONhW79u0Ny8t8gXT/hUQnKVT5qoFEBQs8s12
 Xy/xzbd8FFW+IFqbU7pToQEQJZCpCge8wVyGvmf/nBNj3EUXvPjyN6MTrMTvmlc9uj3ZeGBM=
X-Gm-Gg: Acq92OFLh/ZKShIWnJLabx2c2yHvM80XrrwRjwjcfXe5JsWcrk0F5d2ymuZgW6RNq6E
 J1sJWfvhwENQbMmbG1f8YuDAnu69JARd9y3Y3XA7wb/UQX1Fn06P8saAHRMX/J5tnKa9eteTXNn
 Pgvzg4G9fF4PMSvBv9ERiGWzeCC82l/NKGgDKIvF8awaUlYAfW0NDBCAmzZMDnyBI2mb6rWaZPc
 P3kYSDsCXHK5EnSS/tPFFbcaUDbgLXSYWqjrxbZuuiMQLESXkMA6LALkHB0nhgI+0Po63FutpYm
 NmrnEJ7itezYx0KSyEZ5bnFJuGPo5fgRQhzRMHdcaXJg66mqtDhajcF2nvv5tM5AIr6UQhApJaV
 I8fzaGxUwTaiwIoYHi5did+INhTZn0dHP0E4CvJNY05U=
X-Received: by 2002:a05:622a:4e85:b0:517:5e32:f3b6 with SMTP id
 d75a77b69052e-51795a24229mr240024921cf.24.1780989833583; 
 Tue, 09 Jun 2026 00:23:53 -0700 (PDT)
X-Received: by 2002:a05:622a:4e85:b0:517:5e32:f3b6 with SMTP id
 d75a77b69052e-51795a24229mr240024491cf.24.1780989832986; 
 Tue, 09 Jun 2026 00:23:52 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.7.18])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351ac0sm106947297f8f.27.2026.06.09.00.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 00:23:52 -0700 (PDT)
Date: Tue, 9 Jun 2026 10:23:50 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 4/4] firmware: qcom: scm: Allow QSEECOM on Yoga Slim 7x
 Gen11
Message-ID: <iuxorxt5vp6nayxis4ec5n3qi2z3qlfpheaidqqj7ulshqt2b7@hrk2kf2vnqui>
References: <20260604-topic-yoga_submission-v1-0-57c70c23d0d6@oss.qualcomm.com>
 <20260604-topic-yoga_submission-v1-4-57c70c23d0d6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604-topic-yoga_submission-v1-4-57c70c23d0d6@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: NBdrEaiiyxFXA9yv2VCewmFa2hVOE9OU
X-Authority-Analysis: v=2.4 cv=Z+3c2nRA c=1 sm=1 tr=0 ts=6a27bf8a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=BSZ3G9h0/EKbgBlQZBbU/w==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=RNZNEj0NQT9gpfWmR7IA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: NBdrEaiiyxFXA9yv2VCewmFa2hVOE9OU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA2OCBTYWx0ZWRfX3zRip8JOwTZC
 3A8CON1fttI3/ErfTVIol6GADsix7FA2HcMZqfY2lQgZOeMBoDSMM2t7XTu3KRUN+x5WkopVdhK
 Yz1xtIO7HA4+ArQofEYeR6hvsyVgOCV1bJJIfRIuXsIc2CjaFsLd/NN9kQPyFkHUkPDveBXutQQ
 6WklXZC3FJU+rLMxz0K51aO3i2dAW6rPS7D7F8jimGBjOA5iA0N/XVjYSr0hatSKo5qsbGU6ttx
 GlPe3c3HOOXTQ2bvyn1pRrqWdL78QRUFO5gtzd+5AW45PGvKDhxdo2vi5YCBj1dzUBm4FKTAK/n
 9F9qHy3DHE0LtgqMjeWEhbI84preMPK9luxHKbZ2qflsghCw7Ua4oGxJ2NQlkKs4KL7lOcHwBTd
 5FhhyGLqJ3x9cWFRiRuNSQV4q0oxnW2QCPYi2Njz/fm3sg6/gtbpo6YE7gRs4q4YOKTlPkqfga7
 BNukAwbarj/XHRMa6xQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090068
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

On 26-06-04 10:06:57, Konrad Dybcio wrote:
> Allow the use of QSEECOM on the Glymur-based Lenovo Yoga Slim 7x Gen11,
> as there seem to be no issues with the firmware that would mandate
> disabling it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
