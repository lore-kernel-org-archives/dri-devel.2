Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D8DF43832
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 15:04:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C189310E137;
	Wed, 15 Apr 2026 15:04:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fw+M3cHG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H0hTmiqJ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B47210E6F8
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 15:04:53 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63FAsnJm1701790
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 15:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=S6yvXcs+saJM6pDkqxKkJBwAcz1oyiNnnADT4A51sdQ=; b=fw
 +M3cHGs+7LEwwds+pwdn8AcXhx7lB33loKA74OBywFOIFUn7VawDpXXzCZIL+cmj
 N932L0wO9lpYKl0H+zltcnsIBBQp3bizglCXvrr27O3Wc73oQ1Wuv607+cdbJtyy
 ieqqu+i1YWJDlVXsc1JzAP8cRm5s31qrWO9fB8chbaXOhc3L2zvsJZzjq+pVJB3p
 awOjCk+TGUJtw6XW/iPm3vhOIIKvvrk3/U7ccEaJNkefwn+6km9kIkdQUaKhceC5
 onrXQT7z3UJKDjqyvi5c6fpl3WYLPgwengTuxB45yjXKwOgftc4P+vBS6+g5mZmH
 3OeOVeNEOW568k16vXEQ==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dht56uvqh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 15:04:52 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-40ad1c724daso10584571fac.3
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 08:04:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776265491; cv=none;
 d=google.com; s=arc-20240605;
 b=e+GzG9yMdUuhp/ved/LV/pLjHcswDkphryI3BS+eMhgWHHQUoq3hHk5NAg4m/jLHHO
 Jwa8FMEBXza+Ev20ygH1W7Kyv04j/6r0UJcNFu207hqrLO4mBApICQQKvNkl3SWb/Qyt
 P/9R/w5a01CvaqdnRW9PNGvxL5Fvh8D3GXyCJtwvXQCWr5xP96rGsKXYsgm1kNSDD/Nj
 bZWtOgchTw6rZEXNlaBcgdIUCdVWCMpQMgwmgBo8IiV33rUwn9C7g+rN8CIL07iDzCBt
 OK1dBRFLrnBao+2cChzD+HC+RYqrfc4FTIjMX7KLutP71jZQmKIXY3hyk0d0gYWxjoXV
 J4Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=S6yvXcs+saJM6pDkqxKkJBwAcz1oyiNnnADT4A51sdQ=;
 fh=XbAeZbmFRPXgOGfd75JVFpyOg0/gz8ewGNx+UyznzbI=;
 b=UM/2KT5vmBpvoPT459mkA5YW8qhJRD0XpppR4nP3iDrhgozfBRJLMBqkYyRU7SprtK
 LOGWP458nnVibA4QEF8ir6vt3zRcfLU/xR+rT8VMXF6IY46d/WZmHE1pmhcIETN6FO9F
 d90WQH5L5/tQK0ANokPLfptzmnvCgwgFO3Xru36N6ym2BanluC5pNNGwnt391qG7IwAS
 3Y4gAMmYrsqcKduBa3SnjeSQKncPZeNKD/yo318XXBzQwvRJHln4Wkl0szE5OqfpyDio
 G/CeaLbHNcvnj2yYUKThNqNonrsDapAfBb8+6Q+aiz80910ozbqAp7saKAqjmwUFqvki
 pJAQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776265491; x=1776870291;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=S6yvXcs+saJM6pDkqxKkJBwAcz1oyiNnnADT4A51sdQ=;
 b=H0hTmiqJC0sl5BoV/DCy8D3cwwABAtLaUz//Z4SmWd/F0Ke8T1fHCGxBU7cxVxZnxs
 P/01KLE5U1hIJ9KEPIuEb+U8j+jLl8Lg/XTTSAz8TgZ+PF+2XzRoEhYsZo0sjzixDALs
 iVbPzG8aKAOkMToJcED+sSKb/A+Qm3FKobN1UHn2O2C2RcJTdoWuRxwmlZXMk0/G4r4t
 O7TUTGaqI7kG55B9gh7u5AgHSHWKEtX2xhbEWlElYIejx5r98414FYlGQbT9XXTna21V
 3qrnkYyOIpSIe0g9OsDv4wQ+oUE4KRxXfM61wGRWEOByOqlk6RyKw2oHQF3F9BZ98JzR
 hlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776265491; x=1776870291;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S6yvXcs+saJM6pDkqxKkJBwAcz1oyiNnnADT4A51sdQ=;
 b=sDlKni6m34bV1P2IAppgJOUbvFPszWltIo12TKNLJCtk2+pWruoHhQyuH/8Fs7WSbz
 jjUXyBxJydLf+KSaC5I+Mx7qQ3cwfQTEnKxm54RdnX+hScF33fyUSxMqao/ZPjRBiJj/
 rUcW92xJs/lXSAVI/ZEs8LxhusajMVoHHNlPPgKxLYxc7TdamAs+BG2XNIukE6ZOF7JT
 aRmMlDJmfuoPX0mz9EEI2mS72rZPCULANIK+XABJb+ESM0yZVbXzo4jt0rQoqh+DhUAk
 r5kYDWjR/KtklvvUrPxcew3WWfRoC6Gs49MJvI9q+9l5EK1h+pN8/3KIDsfntM2teo6H
 nfNw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qEbZLv4rO66PUhtq726jRfTeqtZlYNRtW+/fJvbkaGEoLAbWa+f3gjs86wbc4hEgUw1dK1CJctr8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyz0qXQ5nF526q6uPlffpaxdIaXbJqWjyNEdNXmwUIFi0s03oUD
 0D4/84tsXu+K6TvkGmx2MtBg2MwEIIJUrimCBpB85OSoEwc9q+ZhN9i3Vmo22bHNALx3uzKEdK8
 jeHKg3buf+Q7btBQmzeoW2eZvHL6Dg9CWCq8gyZFLjZ1wBB3ARIKDSYhQwxV17dNAGlDX2MAc5n
 AtN0QcaIv84WFtAsq0HRaqb9Od/sEFdpb9/HpiBwtBLsiskA==
X-Gm-Gg: AeBDievqIQ1+5k0VZtPtGMLom6gkRjq1Eof+QOC9LiZ+pxLLSuIocJo7cS0aqs9TUFh
 QVwLQlbcHDwXCFr/KCxTZPONk+dyAPuIM7LaE7oJQUM01bfrY4XycT5XFCMUSERQIG8a41LU06f
 IIIEG4S0R32+jmi+3DyGzer6q6+WP3p50eMbX473zfqYsoVRtIALMuPWkmxQ6E/nJ/FmrHy+Fwh
 eAXkp8235+jWDoMVlPfAZrbbtX06bxFU2NW5w==
X-Received: by 2002:a05:6870:d1c6:b0:409:6227:d313 with SMTP id
 586e51a60fabf-423e10e4bb5mr12821221fac.35.1776265491337; 
 Wed, 15 Apr 2026 08:04:51 -0700 (PDT)
X-Received: by 2002:a05:6870:d1c6:b0:409:6227:d313 with SMTP id
 586e51a60fabf-423e10e4bb5mr12821108fac.35.1776265490753; Wed, 15 Apr 2026
 08:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260405-glymur-gpu-dt-v1-0-2135eb11c562@oss.qualcomm.com>
 <20260405-glymur-gpu-dt-v1-4-2135eb11c562@oss.qualcomm.com>
 <17b2ff60-d2e7-4f88-b2ae-f4dcad44fc33@oss.qualcomm.com>
In-Reply-To: <17b2ff60-d2e7-4f88-b2ae-f4dcad44fc33@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 08:04:38 -0700
X-Gm-Features: AQROBzC2ZxkOJ0HY0hvdTt9PTVU7VKw9IIw6uIzUxBLIym5bcPEvwHU4RlF6Xjw
Message-ID: <CACSVV00RSbV5-BsNwzAaTkJGHx4EKnek6WZJxEUdREmyT92HxA@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] arm64: dts: qcom: Enable GPU & GMU on Glymur CRD
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: CPQFK7kRm9YYzMWyuYCQQkb7hy3ROSyF
X-Proofpoint-GUID: CPQFK7kRm9YYzMWyuYCQQkb7hy3ROSyF
X-Authority-Analysis: v=2.4 cv=K9gS2SWI c=1 sm=1 tr=0 ts=69dfa914 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=emx6X9--i3bWQemKjywA:9
 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEzOSBTYWx0ZWRfXyMwRVuLSLG17
 M+3Zd8vkqzWVZR3WEKO6a9JyHpNtRfL7ue0JWZLMYDXHx6k9PXq1rcHfiwa/ISFNSuvT9ue4xz+
 0wsFLlOjPOS9+1G9N8c/H4b7pIl6o7htl82PpjP8JTboRKqZvd4iD7XpSQmK39t/qMssn1H371B
 xIZErBUyFmdhVp43hKytxSr9y56+WOJaoqg2O+KsUtluShhwBtCAmdQohbxKD7dG7sKuix+r2SO
 vkdmyLTP87XMo1RNBtj04Q50z7iaouOsbUQR1GII5hBsoShah62AbVR9GQtMOozN95tCerJujiK
 y/qZmHM36zopCbg8UeCsdhbD2fYnoguKejW/mmAntbJVG8PBDZnr1IYL3b2z2pBkaWmvqYUfg4U
 BgPEmYWe+W7r+KGGM2ZKRTS/wTKbDuVXWCfOTzwF4i+STFzvCiiQjoHQLTjJyOEh/AW91E6TAZn
 u9+thJZc18HAzt+BEug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604150139
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
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, Apr 15, 2026 at 2:12=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 4/4/26 11:03 PM, Akhil P Oommen wrote:
> > Enable the necessary DT nodes to add support for GPU on the Glymur CRD.
> > The Glymur CRD boots Linux at EL2, which means it doesn't require the
> > secure GPU firmware (zap fw).
> >
> > Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> > ---
>
> This isn't a blocker per se, but since there is no more zap, do you
> think we can just enable the GPU and GMU by default (i.e. no status=3D
> "disabled" in SoC DTSI)?

Agreed.. I'm pretty sure zap was the only reason for disabling by default.

BR,
-R

> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Konrad
