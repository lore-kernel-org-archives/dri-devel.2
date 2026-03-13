Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DAA105F7A7
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 12:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4182F10EBE1;
	Fri, 13 Mar 2026 12:56:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="STQWCDT9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OqqttS7r";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6E3710EBE1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:56:51 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DCcYlH3342534
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Bhrco7TKRrzpMs7dRSA6x2bGIqPZK6XKhh9qpBBTMwc=; b=STQWCDT9Hehj8Zr/
 /FROeHfetK9Is7uNcCwKgPpHjg9RtqRi2dFOK+MK4FSgXF9uibEp11G3IhWuTPbQ
 OgLaLAEL9/zZlYA2THUwVQfn5otFjv51MNC6Sm5jTVMQQI8RZFYl4AeUnnpgoKpH
 MdJMocSPDHtt2Q27KoPym5xlNur4ZxPsVA2GqZoc8Ys7TQrU1QzPM0CyBUl2PQcT
 JyYUOaqX4mXqiu4YsAbHgDt7HfsqfcMIrYFP6qaXs5RwXDG/Fvj2ihY5wRoyn4q3
 GhxdkjN1mWZe0hFQNpDwHdfMcqPP58D1joZ8qD0deLV7MhtTT88fGHVzp/NrwEkX
 Opmuxg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cus9w4uan-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:56:50 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-89a0100410fso12903776d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 05:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773406610; x=1774011410;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bhrco7TKRrzpMs7dRSA6x2bGIqPZK6XKhh9qpBBTMwc=;
 b=OqqttS7rUH8dhf00FCmOxSAZgikX4o2dx9TLTpenNbWELkY17rFUNXdGKYr9CugGV1
 p3h1Lkh2BthRhajiqXWWDgJ2YMfFjJH98HQ8Abhi1887UJQ3RMsuR/cnp/VT6gKDDbGr
 yuYPjRz+mU7MqNj+WEcSq50uepbJX4fSJhLZFTmgT7auduHKh+9EzknUFkMuBUJ8fWhJ
 kkpPo4M5t3ZECYbFpqh5ey6Hg1RV1zp67z7NJMSnBTVev2BImUD5SDKcUUk8kRQRxTS1
 jm+Yo+nX9HD6VL8MTkBPwjVC3VmqVXBGYBw1AJbPCa7ZKBRjGCtzUwy1e2o1LVQxnXvG
 1xDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773406610; x=1774011410;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bhrco7TKRrzpMs7dRSA6x2bGIqPZK6XKhh9qpBBTMwc=;
 b=ezwmxJMBIf0BgDD6vrKfnGn+YYS0knk+U/gpD+QcZrJRRKtD82pp1xraHdj8SjiGX0
 LooxaXLm3/hV67GUCxahDNRS9UFjIGAPYsDxYP72LGrFyZ9qdZh/VLhgkAjG+ets6cm3
 9M5pV+o6DBUYOVB+UrxTZCqFJOXcW5YYsqOBgpboGkgfKc5hhTxrelep8scYp/8FBG3A
 Q9zmkgfT4JTb8JZuVl8DnspWqatfIkasiwxhL5V0Cqx1l7Lj2AexJqfg+JqnpbEsJAxK
 rBrO9FJKIUsCU9zsDdQxNLD1KJvRLw14FKPEldpYERikaWmtqaX5dbYwpOhgdUYdmhqL
 4gYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBzo4NUtoYWXECMYfraRS/Sn1vBK3lDduyti5rmsQbxTqkCCfWNWH4CLtst49UJ6Kw2SyVJR/511M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyr3MTHnLsFmhHafdNu+Rn/q9zPCkPEwibGsAOWhKJXkTkEZ3D/
 pmC1B5R4qqKXjGAF40i16AinpWjmpUzv2v547C3YARUx9ST4uwoZErctk35QiMUmvalAA6wTIqq
 cQod7xkUqw/2CkJdfBApTERPh6On1YerPuizWSGl9uvb07E90T876GeLQDbBgL4kAsu8Jwh8=
X-Gm-Gg: ATEYQzxIEnUy07dXX6kBthDdw9uMrP99ST8RX9yJ+IWxA/BVQTHtMTlWQQNO9PjddVZ
 pKwj80yDThBvhD8ZB8hb3n77R+fDPUKaluHrq2Tw/S/hUJsI4qJHHDlftx5ravDNWV+SRmHjEUT
 jG2hDYRGTImYJ7FmPgHAd4u9SKAe41bjMdvxbTutyeUHsVRinVoY3Fttb5OGw9qf4NhqLxfwVQw
 vRYAChPgsBXKa2hy0PqWGiZu3ibovxLQDh8W2whOVUkhJL5Y7IoIXeUi7ktBSpiEaP5QVY+9GL6
 AKZjGK0K6IGFsn8McpGnk5S5aIZKk8xak8Awhoo02REx64DMfweyZAnhFnBXqtZYBgYIZpkCkV9
 CC4S4MYVMZ6YwOeMJlDKXwIzogVaqUvaJRLNym3ZXWKg/joYNOqERfdCsgSU36mDoOm/e5Y55HQ
 E5GXQ=
X-Received: by 2002:a05:6214:5e07:b0:89a:62e2:375d with SMTP id
 6a1803df08f44-89a820fe6f7mr32687076d6.7.1773406610222; 
 Fri, 13 Mar 2026 05:56:50 -0700 (PDT)
X-Received: by 2002:a05:6214:5e07:b0:89a:62e2:375d with SMTP id
 6a1803df08f44-89a820fe6f7mr32686786d6.7.1773406609742; 
 Fri, 13 Mar 2026 05:56:49 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b976cf02b36sm44933466b.50.2026.03.13.05.56.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 05:56:48 -0700 (PDT)
Message-ID: <16501e2a-01be-4009-adf8-278f3a42b040@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 13:56:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/27] drm/msm/mdss: correct UBWC programming sequences
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260312-ubwc-rework-v3-0-b7e8f800176a@oss.qualcomm.com>
 <20260312-ubwc-rework-v3-1-b7e8f800176a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260312-ubwc-rework-v3-1-b7e8f800176a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: AJVJRVyA5ovSAl8g0LpZcaYOsv4QljEN
X-Authority-Analysis: v=2.4 cv=IIIPywvG c=1 sm=1 tr=0 ts=69b40992 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=g9AtgMIdhz7_Ts0mvgYA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEwMiBTYWx0ZWRfX2mdpnCDILI0j
 iN34he/TZhslj85jk3gPv+LkjJhqsrS/eThbk+J7HhPNPucIL9rMrOPAYsHQYy4wPjeHvacyoLA
 wbpLKSbADcVxfJR6WkkpCFLwxImFvKSP58mN4r9XsjgwlAJNW4kdWMe65LXBK5c7niZYfvCGqkn
 lswu/0ta2uizthpIGVx1+4BVi2u9hZUlRtif849f+n45MAIQyIWZBAvYQxW0wGf3KHtlJLzYw97
 DXu2R8ch65AwXNU/O7HKgQLJxEVcQtP3pVLTefmhTleznXNEhhjjj8VcwfVrouFMaidEwkuNMUS
 WjENDh4BXOBFFAkZGPMlaN04YPJu7RDPl3BVJg09ThADrlgJIU0AAOVzRS+xvcjEiDZLwPjnd1b
 EX37fdJturTT0iPWjRsvOim6ZbS+NSLxMy3YZSWIOqGODx5gkgyhH9MSGCrB/kYXdo478XFbibV
 7W76vrUnvnjTFDZW+sA==
X-Proofpoint-ORIG-GUID: AJVJRVyA5ovSAl8g0LpZcaYOsv4QljEN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130102
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

On 3/12/26 2:29 PM, Dmitry Baryshkov wrote:
> The UBWC registers in the MDSS region are not dependent on the UBWC
> version (it is an invalid assumption we inherited from the vendor SDE
> driver). Instead they are dependent only on the MDSS core revision.
> 
> Rework UBWC programming to follow MDSS revision and to use required (aka
> encoder) UBWC version instead of the ubwc_dec_version.
> 
> Fixes: d68db6069a8e ("drm/msm/mdss: convert UBWC setup to use match data")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
