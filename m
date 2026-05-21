Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EB3CD5BA4
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 08:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7D4010F2A2;
	Thu, 21 May 2026 08:54:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lrFQNDOq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CXaG3Xr9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 543BB10F2A1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:54:10 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L7AuLi119115
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v692eTKlDFQGKi6VPiSwojmbe3259bYPJucXnvxV50c=; b=lrFQNDOqLigfATeo
 ILD7zYr6EFuZEWZVySCOi9T3giU0ZrG9Y0erUE97iE5nuSVv+LO0pZmpClnlYs2I
 OHeLZ5OgpeQS76AcVh0D664APkYyNbUAjz2mp1c4XuxMJFLT0Hx2UFIU3H+oa+Qs
 +0gyVH8cWCyb7zY/cbjC2N+HUtTlMO+UJswOqoE4H+1zURNyG9pKynPr7hy3PHT9
 uvMTtbtMmvhyFxzkSufWG6phWotWwNpqmdEuIliQRC1j7x+VN9uJgqZZYQz3Hyl8
 /2hVOt3P3n0j7e792BC7Gb0L6dSRV9Fo/01kPo2nMAenog4dynjwKxKR/MYeJaQ6
 kKc5XA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee8c3md-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:54:09 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50d5d076d88so14705191cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 01:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779353649; x=1779958449;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v692eTKlDFQGKi6VPiSwojmbe3259bYPJucXnvxV50c=;
 b=CXaG3Xr9WHf4x5foV1PoLlj+EnKrY7YQf/a6mM+uFmpv+utqQVhv4ysuKbnt2ShHZ+
 ZVx1qtvrZCawAwgY1nVLyCMpW0jh+ekjeMBFaqTIN745zSFTzYDGPv3ZzIUCRJMAftR8
 czf95peQG1mEI68CY/AkY4vsZS0oxly7SV6Po3OfI73HgO9z+QLGmCixuIcxXzZY8aeY
 fjbEdv6trD5jqdt7tuGb3TOTlnc1siJhARaK1KXlUT+Jar3ZhRyGIaT0cHxBGC5U8KMt
 vebIwNd9rcIEm0QEsPtNAM1t+0dKimoAqCqRTmt2Nr2Ppv46wsXWrxl5bMYnlBzHMjGn
 p9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779353649; x=1779958449;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v692eTKlDFQGKi6VPiSwojmbe3259bYPJucXnvxV50c=;
 b=YeQaIlRn7TSI7nxqwTuQdXefpQa9tA+rB1x4XfNJT4AW7maUNW/o+zMMQATHExVj3F
 SmVwlTt/G9tnVSLsW9u3bIvaDWwE97G/7DX1dWSv52xc+FjLyG2gOUcpqRGXbk47JV/J
 rDmJTbpXK0U4r1MoSGES+X670+V33QNmEPsebrBEm6/gdRZnWZ//Az1qAn3Gux6sGJGR
 BPnWy60d3SP1sNhklAIshA3AW7uhm1qMrJVXaM30U01FAMe2evXrN3ZWKrGxq5H3y6wq
 MmbytJMQlSoxHRAQ/J+3i5Uh2qrxpObQdCUdY//Oolnh5/s8shB5BqTA1Cc5oo6nEcN2
 3wYw==
X-Gm-Message-State: AOJu0YylY3+7qpNCIoYcOC2QB/DC7exHvmW1RMH5RAJSolQ18w6LrxLX
 9aT33+Yy6POoKnoiD11jpYDiz124ONQgIuF7WeSaWX1r0LHC8cdaui8+rsz/zcYA5zZWJ79fm0d
 MISweTOx5pBXrAG/Fz1S9pjupElgadhsDpPxOpSeKf1xWVNZKTs25q0AzezsYkGKyrIlvGXs=
X-Gm-Gg: Acq92OElmgbG0jiBhdS9dEmmrc+TQ2eYaVPd2x1ZCg9RTWA2irKvmdApNvp2U0cVTGY
 fslVNYdqdj8k230sBWDngc5MS1TOvIc+VUCRx5B7DRrz1Urf4jRC2yBkrv8xDvnCVQH4dpgjQXW
 g2zbUAmSdDadNfF5SvMKadNRlkB7kiXGurZJrZong3e4BklXVDLmNBVEMP/TJzDkVwCU6ueNN5/
 s1ZTOHCNLfrLdRm6XfaOpIjGgPn0vG0ff8STfRWGE5Pj+HQaqiDVq1DG2aXXZfWSH4fzWUQUOj6
 lvjqytiTX+JH0rMZe0s1rER1zxltb9c/RGINAwbMsjv/xBvY1pBX5f9TgVhLiGZG+9qKZKXnxdH
 d6oKEq24Tgs3ZlGeC5FVImb0h8IT4p1IirX38/cYBDkOs7XpUufA3QrlLSxx7FH+feZ4O4KzyL0
 KrJhE=
X-Received: by 2002:a05:622a:182a:b0:509:2a92:8088 with SMTP id
 d75a77b69052e-516c54c365amr17392981cf.1.1779353648831; 
 Thu, 21 May 2026 01:54:08 -0700 (PDT)
X-Received: by 2002:a05:622a:182a:b0:509:2a92:8088 with SMTP id
 d75a77b69052e-516c54c365amr17392711cf.1.1779353648434; 
 Thu, 21 May 2026 01:54:08 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bdc87891207sm18449566b.7.2026.05.21.01.54.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 01:54:07 -0700 (PDT)
Message-ID: <4c89121d-9502-4cf2-b5a3-cb789284643b@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:54:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] arm64: dts: qcom: sc8280xp-arcata: Add volume
 up/down GPIO keys
To: jerome.debretagne@gmail.com, Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20260520-surface-sp9-5g-for-next-v1-0-9df52552bf87@gmail.com>
 <20260520-surface-sp9-5g-for-next-v1-7-9df52552bf87@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260520-surface-sp9-5g-for-next-v1-7-9df52552bf87@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FHLGi3BfJOCMR5eslcMBkEVE2kirhF3E
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0ec831 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=S3QPRrZGCkirkA1mjOoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4NiBTYWx0ZWRfX7ls5SXu9dRPs
 eBDVPMmf7f0QoJafVmgxyKyW2z5H2ZJh6iH9YRkEjt7j1L1KKFwwhakE0Y6VJws+O+o4VdtEOAD
 i0dC+mGhVTPmSDWFwyphsBgzfgbOh8MVfvkNVVycCYTrtBblEvANSAVzW3PjWbMBKMkn9RA5K2x
 Wjd99GqSY+aswNZ8BvprZZGTnLVMd6+iy81pyMA5mcLXLh8FD/O+uivnf950c8T71EAOO0LneC2
 WwDKFwiR5jW3w28fBA4iQsCh3vg03RNCiQrNDjNPE0vRq5amStbzwaPXlugIttgGcHAucgxjVBG
 YzxMR3v+GowOXin3VM+8WZKUcSaQCl7ibtEPLRXZQWDIaMCsMKJmR0kgDJEFmODQIhh0hLm1+8i
 /m6qNIw//EzvIcOCVDGqjldBterDMQbfU80f6SKRb13b5qZCTxn8L0iVGLLbnqI5tNBi+OdIB/Z
 D4u/zc22jnsa6XSN7qA==
X-Proofpoint-GUID: FHLGi3BfJOCMR5eslcMBkEVE2kirhF3E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210086
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

On 5/20/26 6:40 PM, Jérôme de Bretagne via B4 Relay wrote:
> From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> 
> Configure gpio6 to serve as volume down and gpio9 as volume up to enable
> the volume up/down keys located at the top of the screen.
> 
> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
