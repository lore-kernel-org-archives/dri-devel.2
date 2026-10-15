Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083A5CC6B38
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1926411223A;
	Thu, 15 Oct 2026 09:14:11 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71B0311223A
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:13:59 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F6w7M92121427
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VRZJ39RIeVlC9MlaNvNvmqPLISdXkSaEEscPGaGxyaE=; b=b209s6JerXmXYSXQ
 3HXDqVZvh0not3UsLCYTlKutDsK5OE6QGtKdw4cO3ckd9JvVioOxU4kwAOralrPK
 Hn2dNFyhN3yAGLTjVy7cbo8tG7xF0aCPkb/CDsSz1lxmJNng5qEPgwBjA6cIdp4U
 hIR0ir+rg7pqungrNDR35VelJXd3KUGVlUUHpXOk/I+gv+Y59ioVabLUkwa410NS
 yKdGzAXuoC4R7Sj9n2mfzk6a/8YZnhGR7hJCYlxpJomk954semw8leIfp5dqaB9R
 Hq7TMsTYurNT0aBtYkwNJsgwoi6rIa3dE2BvHPv+BUsjO5KyuKwVYL7jcH29Houi
 cQI4tg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakwn1xcy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:13:58 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-530cd3dff25so10503821cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 02:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792055637; x=1792660437;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VRZJ39RIeVlC9MlaNvNvmqPLISdXkSaEEscPGaGxyaE=;
 b=CvSEwwBvqDH3TgCSspcaVgJ10M0OqQ9N83TObi7YBZeXMzyjUso1oNcaBwnGLx3eDk
 pXh1+mRSt3Q1yNP++dyLR/b5gXIWgFhqi6DKFi8XKur6EP1/K0z1yOfUHv1k7s4cC2KQ
 enRyRQlvW3ozfvUQyuT5z933qTIOwfEQFvrEHnBsqO6ldoz7sBzzdADCbCCQ4iAw2CIo
 A77AuYh84lZ353xSYXgkVmmnh1Y/gwoHpRmSZE4yJWjObYEGH6qBNvEvYrEHUl9+tzga
 z3oEHCSfJBWPSLylbwtQsrEoTLcgVEZ7r0AmnaZIoaWsJGGU4VtNT5c0zpVbtAOnQq9X
 8M6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792055638; x=1792660438;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VRZJ39RIeVlC9MlaNvNvmqPLISdXkSaEEscPGaGxyaE=;
 b=w+r3OAPIg08W7EGho3qj+xP3DDL67ZAaJn4wBcv66za50pEhWG1ne+vsmwej/Z+qD9
 nK87wnfyoTGkCWPCfaPn2yaR+SBKRJkh6zDWOZLhnPcHcKHN3mMI1lnbsaZNCvOoFsRI
 QPe3poCdUnDU6SX8iYHxSUOXVPSA9dZ2l8GicykN/4qgTGNZc/4l7gsEbCrWb2Sc8bR3
 t4kMgCjx7YayBczVxrRpccX69Nf0N4fUmkyIhtYXiuGynl3pyLmEXCmWffZDwx9lJTvG
 hg7AKNncy1bUs87GdsPfYlnCXNjE0zzS9+MjMJSZDalBXlp18nV82EGzcY+cS+aK+Z/l
 PdPg==
X-Forwarded-Encrypted: i=1;
 AKwUvBytu6Gcuk9RReFWO2ATjbRUEpSnVeOZooa+6h/Vm9FZlN4zRyq7b2Sq5H2AoGPs2G/U90VKQjSo6w4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI+8LMXCStmMBedYcmplRoLd96R1/unw49vC2kwLAKR/i31nhj8
 /HcPsrmutJjAawM6SUvjfK80Z4KKxpi4vcc7ctShZdX5Nezif3fNjCENAWIz21j0/jKmhFw6Qp7
 9VVZA4t5jOq5T2CgzhcdIexp0HP0IH5H9fFdx50sL4brYAwhAovstw2YM6/s0K6fm14tSJi8=
X-Gm-Gg: AYBFou2bMzl1z24GWL9j4ui+a/yODC+OdmVuQZ8hw6aG6t46CV4XA+sI36XreCma0NF
 e06gqRWBDGjBGsjb9TUA59FmCPMmSEdZVBEnJ5GiXBfVh9liFN4CaKUxz1VVLzOkAbP2qotQn1b
 ein+mpTK5NGo0RUZHGFVHP8w1+XaKzHh+KBSedoS+0LEA6vE13VqlkvssSIGekzOOE9rN7AJwxV
 huQNm6v3HM5IYWBJ7z/JmoGa2H4WYmsy5HL+RwKUDUXiu8Wkj0QzXblzeFxbTnOqYMiLSnxwGgm
 0MFRefUWJv2IRa3o2cWuuSUiUGOVNQ9CbdrRxJzi01+c/5mbe99TEmGvN/Qgl8p1/L/KVrtiBrn
 B65QQzl/4TTDNMFbBRmVJ0g==
X-Received: by 2002:a05:622a:4c7:b0:531:2133:cc7b with SMTP id
 d75a77b69052e-5359f05276amr354077181cf.0.1792055637339; 
 Thu, 15 Oct 2026 02:13:57 -0700 (PDT)
X-Received: by 2002:a05:622a:4c7:b0:531:2133:cc7b with SMTP id
 d75a77b69052e-5359f05276amr354076771cf.0.1792055636583; 
 Thu, 15 Oct 2026 02:13:56 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c3f0071777dsm87295266b.14.2026.10.15.02.13.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 02:13:55 -0700 (PDT)
Message-ID: <feb492d2-ec12-4077-9d5d-f1819586a41e@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:13:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] backlight: qcom-wled: fix string detection brightness
 on WLED5
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
 <20261015-sm8150-display-card-v1-2-5c14928cef29@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261015-sm8150-display-card-v1-2-5c14928cef29@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNiBTYWx0ZWRfX6zqDzOCBMtyY
 2408vNlQYbfUr/VoXOHTbspn7YN/3WNjr1Z6eubn6k1eE2KiZIQPSGFZbbaEaVqnnR9oJPOClbn
 DlJAfNqJkOA09yt9zm/Hx34hQ4S9m73DCcxlFqc5LfzRS5XQW24voY8+hPz4U7XNQ4OH7lGmkXg
 bmVi/vaq18kexP6fGYdnHgX3ya/QVUPDT0XOVIGWNcWwY4p+EI5oW/xBMEGQ3vOWCqEEVQga++V
 OnPg1Pb43KXuZVazKNZ0rT8hKF23DVzvEEhWs5jnIPvoM5Xb2GqOyCtmQcgD/goA7Tx0zTdj7hL
 faI9ilwgwcl8SwsAvUGD2S8/Mgkz/NgAPfH1HqsDMVgOzhlPih7wFhR1kELGzjzi8L6pg/tD6Ta
 5+u1W6SnPBTN58XEuo2qhaXMO//xQvBYuz4R/uQJN35m1FmZpzMwEJsvYavGmEGo8p3lfUS45vH
 EPtz6RSC0Ii5UYK1fLA==
X-Proofpoint-GUID: YpCB4Bcl86ULHtthD1QdUI8jD3DaKGm8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNiBTYWx0ZWRfX1lR5n+OmkxPo
 6TFsHD0d8S0ktntQ6KtR+VxdJ8a9Rd9SpOQfv5e40+fLKkM34yPskmboGPb4/K9yGyxtsEJ+oFj
 /RQhreYI9PUL0B/9dtU0V0m1urTzvzg=
X-Authority-Analysis: v=2.4 cv=BqUIUoX5 c=1 sm=1 tr=0 ts=6ad09956 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=9VxvTDaDK-J1xIkbkncA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: YpCB4Bcl86ULHtthD1QdUI8jD3DaKGm8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150036
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

On 10/15/26 10:58 AM, Dmitry Baryshkov wrote:
> The string detection sets the test brightness through
> wled4_set_brightness(). On WLED5 that writes to unrelated registers and
> the detection runs with whatever brightness has been programmed before.
> 
> Use the per-version callback and latch the new value on WLED5.
> 
> Fixes: 62a1d3f623ac ("backlight: qcom-wled: Add support for WLED5 peripheral that is present on PM8150L PMICs")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
