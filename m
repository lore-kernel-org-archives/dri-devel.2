Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15184CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:22:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69E1410F5BA;
	Wed,  7 Oct 2026 13:22:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hQVLruBu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gXZx7ags";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7719A10F5BA
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 13:22:56 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697DJVrR4056425
 for <dri-devel@lists.freedesktop.org>; Wed, 7 Oct 2026 13:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=BjZrN+hkuGyVx/Cflq3VwuxQ
 GN0nui+PJTPi3KeyDmY=; b=hQVLruBuIcAcZ58hbB1ru6pS5+rp2PchQurd9mzH
 Cjd0KVZG/NnqWGIQdyVQg288r219R/JEbMS3svvQ0klRULTlugDVr6+/w8wRqxet
 2S6F8MD4780Vz3obRwb4BBFYOQKy9jT9f/soLNJuPyhVpAmxLcsaqhSfxOqFl5aE
 64MCXP72bi/M+/LwZbBsyN+/sb9mNo4gUHKzk/CTYe/nEVqDQ0vac6gD7w/CLDvU
 jaoJff+EyhomLL5I4gUXkcAaVIQlETGRMRVcZf1GlaHqcA3+pzj2mPqeRBy3PHJv
 QzyV6/ZRtG2KoQktzO4735tsYTkeb21f5/CTeqpbnu7JcA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5pv700dx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 13:22:55 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e92aad34aso330109385a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 06:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791379375; x=1791984175;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BjZrN+hkuGyVx/Cflq3VwuxQGN0nui+PJTPi3KeyDmY=;
 b=gXZx7agsdAoOBJhVDgyKEY/dZpYmZQHvP2JJ1hLxVdNOA/o5q8OqeA4xqzSoT4aLh9
 EyYzBNkxV4M1USTtWEM1l8KWv7962YqtlirSRPtHfmtUwNZE3dtwMWql21G+i7x3Vgcd
 4IbfnLwLIiYFl6v2KzQUCy1KIWxw/D7ljcswiZvtydyqnsLg5eK9m7qrkhHubAo1kLNU
 FDHsWSGgGY+DZdpPVcrAcwNrnbfrdjpoeQEHn17ir/tFgt4aMZH2DrV7sxcaw5I+Fvbs
 eVEs/QbXtG+b+91o8YE1de9xDuIZ+JPeC5HMHnu0RxW+/7CcD7BuY6X2PwQEwvtSukZv
 1+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791379375; x=1791984175;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BjZrN+hkuGyVx/Cflq3VwuxQGN0nui+PJTPi3KeyDmY=;
 b=l5he09rmgtQkN1JICmH7f5B+awPsF7fSXydcp+oi5p9WpiC30I1Ih+87ie+8f7Xaxp
 rewvZfxMb6eN4izgKXyltQuAweG/XCCtpjex7hpdO4/y0PeN+34foCI7vd6hed3nnG3E
 pF9Hd7oQyALPd0I4pjkPmUd6qkRLn15E71KNnGcAXEMmqbArgbM/PhwlfMdhvxdhwaOE
 4xdorLuB/bgiwyEuqu/erIV5sCE/L+hCcqXLxT8xnViNoYXkDsiW/IOn3v8un+Kuhq4t
 t3cOiB6pSq9N1G4RC1uRXZutrHjF9SsrxchonoloNC6pEtV0oY9gb5SqT6R7jj+BMqU4
 jadg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgJTzz9yf+aEWA51e9Jr8tRfw2J0+vlaZy+/heQ5X4aUj1nPMsNL6VZQBl2CWVvN87P0lQWF0kmwo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nlR71XLJpekryA7OKGwXxkPzv6B+RQzopem+FWB/LAcrGeeM8Y
 OVchsZxOz+dWXjt2CfYdIiDdUV4mMUTqoUqyP5yJladCzSpMtr26hneFnxx2Tn52vs4wXGXw47F
 cx4TQypEJO4AXiU/5Y36fuZx2HiOkEEB2bMYhozfFA0VQNZkz2gKrwHyy2+LRs2baYOPJiW8=
X-Gm-Gg: AYBFou0lYM8MNE2+fp+dBMlxRl6qlmRIlimF+rQuEoVycG/WeCY/eDYZEjv0hKRm2AW
 +gXm5Q9Jx2EJ7KiZcXuxSPFx7Z/p8qaQF5TExdch/pEeFqpGs6gSguoKlZogTf11mOy5foOBA56
 RiDf+vESNyCQcrV9Njcg53sgdMY8zryJh6YEMChubJ7QKPUwZXabvgCG7cwsyZJ9V3oCwDJCwgt
 0NRjD/57NqMyQ4iqdutnXnauqimJlNxZltl3NhX8wR0KpYxxbt9we5YgQyCx1XAW9WWalOrOWmt
 snS1TPP3LZhTzRL45itPF/9HRf8Q5c9+REOOirVrU4CuBMm4W9ZJEpIjl1ZktrVKpv2ZhbG5tJW
 MSCUviU8KJWp9AUKfxGR6JIJZJ15YdFCHTVhaQHE6AgzkHZn7+QIL4tiRO0ET3jebqwiJ9pVWKl
 Cisbg9Bc9bYrQY
X-Received: by 2002:a05:620a:6408:b0:93c:6ded:4665 with SMTP id
 af79cd13be357-93e9b2e9408mr369820285a.1.1791379374670; 
 Wed, 07 Oct 2026 06:22:54 -0700 (PDT)
X-Received: by 2002:a05:620a:6408:b0:93c:6ded:4665 with SMTP id
 af79cd13be357-93e9b2e9408mr369816585a.1.1791379374144; 
 Wed, 07 Oct 2026 06:22:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcd3014cf4sm41282e87.3.2026.10.07.06.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 06:22:52 -0700 (PDT)
Date: Wed, 7 Oct 2026 16:22:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
 Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/5] firmware: qcom: scm: Allow QSEECOM on Surface Laptop
 8th Edition
Message-ID: <gfjao7xufwbu5unlqhvwri6k7h3inujospqwilwqhywqxuvs4f@gx76h6ntiqhk>
References: <20261006-mahua-surface-laptop-v1-0-406fc042162a@oss.qualcomm.com>
 <20261006-mahua-surface-laptop-v1-2-406fc042162a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-mahua-surface-laptop-v1-2-406fc042162a@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1MiBTYWx0ZWRfXzILhvT3Rn6IK
 XmBA57wnOVgNLG04UY13kwyCFBEgbN2XvK5ZMgdbjGSNx7wYtKTJ4MZX33j+zS3bqzM2nT/9/OF
 BJJwLvobvyfyic/LtxBprORSwr2thgc=
X-Authority-Analysis: v=2.4 cv=J4I/fwnS c=1 sm=1 tr=0 ts=6ac647af cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=JbvdwL0Z4G9UtC9WzY8A:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: zBmuNAZekYgu6NuBzQRGXrQRfOO2vBDa
X-Proofpoint-GUID: zBmuNAZekYgu6NuBzQRGXrQRfOO2vBDa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1MiBTYWx0ZWRfX15df0+mtn9ux
 g7q1oGE6vDk9mY+NTga5sFZmcZBON9eNnQa7M/jJngfPces/8P1N3b1yay6uUzSTtA5D9kLoIFt
 qhm4e42kI3sn6z2m9jZaCrYTSMdfngyhp71/lWqVh1kvT5N8hF/gWaSZtyJVTsJ0vVy0rdV+TD+
 hLAY5Z2VhK+zaiiI07A6w9s27jaKfGzOWvSUmDs12Te/hPcnKjM4mWerRBPZgbark6xudcqkJD5
 EXUqzEH4ZIqUZyh4Bp3N4AiaUZvjL4283cUj+vy++AXeuL7YyNeTfDZiW9zlh4T7YaeNOQM3Msf
 c1B5FYaAipr0M9B4HUHyIHcqQS9mnV/1yMuW4PRJO1cS08FxIGk+R4jr+V52RBtg8K5tw4cDuZC
 Spvncggz9T/4upHqjgGFD3FXDMfaqgqy6/fas5Wqp0pUBmHYIR40xOI0EgEmDIoRZ3xSLYqO7wy
 BtTE179RCx58tgjb6gQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070052
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

On Tue, Oct 06, 2026 at 02:50:28AM -0700, Gopikrishna Garmidi wrote:
> Allow the use of QSEECOM on the Mahua-based Microsoft Surface Laptop
> 13.8" 8th Edition, giving access to the UEFI variables and the RTC
> offset stored there.
> 
> Signed-off-by: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
