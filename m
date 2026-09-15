Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF79AC88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 13:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A4A610E57C;
	Tue, 15 Sep 2026 13:41:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YC/yFeUW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QzTMkN6O";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7766510E3AA
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 13:41:23 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FD0A8d3015914
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 13:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a9Ma2vHXggOVE6yEStb2WHtpUhRSkVE4YG7P0qkunmU=; b=YC/yFeUWbUk/TQZU
 /oZYDsbQHFGbZhbRXb0F6pRvynNxaCk1uZOlStF7LF1WlfqBewv9giMR/oA5YL8X
 utnLaOERlRjEwIaOLTOwceQVbZL/2B204PB7r0lMqm3SsnyIPgGhCTbFpBjHDaYb
 V7RPMgdmQnksh92eWK0CL+YPIdgRzMorgf43/9J2EXQalXRT462lRrVWMV+XRmDU
 TGw9uVD7lm4GKnBpyIUuWrLGndS68OQBjsD9CirRCy7e3hXt7l4+S7jH4/VV/CEy
 Hu5rqcRJ4c1/E5vm7s2UrW2bNl7aeTHMZIHSSdPToVR1L/eTF74vLO8Q4eYm0c0H
 G2DlLQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpx4sab9d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 13:41:22 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5c8573c977dso3834937e0c.1
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 06:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789479682; x=1790084482;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=a9Ma2vHXggOVE6yEStb2WHtpUhRSkVE4YG7P0qkunmU=;
 b=QzTMkN6Oe0TNokG+TUhn1YA9n5nQ4UCEwyqPTSGtVdRXSb8a452tuGZt7Hf5O6Z+cb
 RkPaDEwI4KgNmyscrufYMNu1b4EFGODVGmyYDWS7FFhQnsr3Skgu+cKQ0PNuNtYeVLLV
 md1fHXjPXwcbF36DmzRDyoKoeNW+tXXQEwqonTw2YLdXSKI/EnlVdKpZ7gXe9pHyjnmU
 tdeyjqPjFg/TTkIjNxVHOm4j9QQpWqoz27B5vTpffy/8ATc2dHlsW86G6VS/X6rt8hNv
 xQXXABEFyLuKgPNpkr4wR1WpTeyi2bBolH7nRwU/DcYWnVSHXsGHQbuOwoksCjE3ntcS
 3KcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789479682; x=1790084482;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a9Ma2vHXggOVE6yEStb2WHtpUhRSkVE4YG7P0qkunmU=;
 b=YMFnta3oQOOYGvlW7P5nAqy/oaYVdLADLDtzWdY+n4qJPvvjXPpXTI8aYOjrzb98oS
 OIWu50Xb178bGtvG0GDgqlVKJiATgjJN4ZviPO9QZgKHexMLTpkPCyNnt4eeFRNQuSpf
 mAGF9KzKJtnbVljLMxFF6mMFPMkWWyHotkQYY0DL6Xk8RI2w0uHh9OFQHX43lh6p7w7w
 BUvJrzH69zCBw5W7iGFwzpvHcdfDaDD30N8mEr1re2/g63mVDklCBzR0AYHYgdb+aDbj
 BwttBUEGFawgna3mwrfUeMF6KWejdXqSL6jyQeQjtuyvgCTkLUudiB3RPTcLJTnL0VA4
 uigQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy3+1hoAd0SqQFqJFrxOpUvwXnkPyYut7do6iS+21sn37RzmJKp6bPZSurHnLZkHweBO8Wu1bXxOso=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lMrLe+H6T0OVW2i75wdxPaMbMbzB5poBUYENFkhCoauyqztq93
 Yfrvc9lSIXxZ687h7YAi7jBilk5ViYFpFQq4RsLALoQ81fx26+cDDbvhRccg4dR3UgTyF8yvJqD
 NFZbRlqwni3ghIv2H6Sn9NTSt6iJsxoqN2Ous2TLHm+MfbgUt+Js8dAiTjbUZfHyP3/E2VG4=
X-Gm-Gg: AYBFou3upodi/ocIcj2uzjr5T4ILbdJXI81HmDovigSYTeqPxppi4xPGRQs5fX5e0ui
 nl0SYH0YAGOMO/Ou6WYl4g7JGjNMHwZ1reZQ2kFVwNZnMg9k7ZI1ELu7MSJYbr2Zd0aQcispksE
 SRKMUHTrzNIWH3Kdz09gjP3ZLsmQThvH4H205RZSclfPvUI+jf9nj76gJX1gOg1dAiaoPxbhj6o
 GkOa55wbJn+KDqzyjWJCEY10Kg59mgFlmZh0AlVe20390oQNYBIcFlb+qHXzABoFJxtYr8OR4YI
 NFUzJfLY2laShGD7tYCyIvFTnglaZixZ5AbfRzTtgeYQeZH2MFjwxrXztMRBAvNXpOKFRQMB4fS
 t7hxn8Yw8iZ3DQnBfm0sNIFAQ/WA=
X-Received: by 2002:a05:6122:da2:b0:5c9:7a56:10ed with SMTP id
 71dfb90a1353d-5c993b59a15mr1424258e0c.8.1789479681811; 
 Tue, 15 Sep 2026 06:41:21 -0700 (PDT)
X-Received: by 2002:a05:6122:da2:b0:5c9:7a56:10ed with SMTP id
 71dfb90a1353d-5c993b59a15mr1424146e0c.8.1789479681335; 
 Tue, 15 Sep 2026 06:41:21 -0700 (PDT)
Received: from [192.168.68.120] ([5.133.47.210])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e81asm36821121f8f.7.2026.09.15.06.41.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 06:41:20 -0700 (PDT)
Message-ID: <9c09c1f5-cffc-421a-96df-753b294d63cd@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 14:41:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: arm: qcom: add Lenovo ThinkPad T14s Gen
 7 (Mahua)
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mpearson-lenovo@squebb.ca, abel.vesa@oss.qualcomm.com,
 sibi.sankar@oss.qualcomm.com
References: <20260913201835.250085-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260913201835.250085-2-srinivas.kandagatla@oss.qualcomm.com>
 <20260915-nimble-wakeful-stingray-5beaed@quoll>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20260915-nimble-wakeful-stingray-5beaed@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE5OCBTYWx0ZWRfX2gqL8eQApCzZ
 KmAOwVYg5/2XXRj+I1M35CdO8FJ/c1r0FUyXmdxrGpt2en+NAixDvkgTEckWk+LbPDjBdIaQR8J
 Zl7IBTvuVrOsvhIEaq2qu1+PM8FgnN0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE5OCBTYWx0ZWRfX6LxKkGLmZSpL
 ooDFE44dMc5siJDJkwW0V7SKKlXZqmPJwzScZ0tLF3vns77esgugwrEpNq2CYiRtj6CEzDFhWhl
 LOwFgihV7PFo4o43RiIALAHa9lPWLdTUiNygUdBY/YpbT+DEzu7vv+rfCBEKDg0DoZqrz77HuKZ
 qizOc7FtO1q+hCkSQMzyu8UNNMbu1W+vQ45MLThpGJE0pBtgcxwnw03oqghjcnVWpx7i1HRiZaQ
 hI10knkoCZ0EvJ5m2E190Y+ihjXftjN73bVGraLhO0l510mPXlR7WfG9fcfDkmgK3oQYJ0WzOxy
 Qfn0r4rbTv3PXRLOgyEQ+ofZR7Q2sptymdFp8kUZuu/0yyI99lKYqsvKK83gJu1jY8zJRjz4RYI
 GtLAFQ4broS3P1ry4ts01/bGXRuzeZMpaQzW5X3WRJJHUDgIMi3ZU/7n9yiixIvsP3MCNkU+Y/q
 yIbS1Zr0d4Y8n3feSyg==
X-Authority-Analysis: v=2.4 cv=HsDjiETS c=1 sm=1 tr=0 ts=6aa94b02 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=YQ8b7Xp_7Ef0BCHzhWkA:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: CYR8Bh6F2QXErkXurV8Ca7jX2rIN373q
X-Proofpoint-ORIG-GUID: CYR8Bh6F2QXErkXurV8Ca7jX2rIN373q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150198
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

On 9/15/26 11:47 AM, Krzysztof Kozlowski wrote:
> On Sun, Sep 13, 2026 at 09:18:32PM +0100, Srinivas Kandagatla wrote:
>> Add lenovo,thinkpad-t14s-gen7 as a board compatible under qcom,mahua.
>> The T14s Gen 7 uses the Mahua SoC (a 12-core variant of Glymur with
>> cluster2 / cpu12-cpu17 fused off) rather than Glymur proper, matching
>> what the platform's ACPI MADT dump reports (12 enabled + 6 disabled
>> processors).
> 
> There is variant with X2E and X2P processors, and on top of that touch
> and non-touch display. The first will be differentiated by SoC
> compatible but don't you need compatibles for the last part - display?

I only have the LCD variant in front of me
We could follow the Gen 6 T14s pattern (which already has the LCD/OLED
split upstream) and two variant SoCs for v2:
how about something like this?

  - items:
      - enum:
          - lenovo,thinkpad-t14s-gen7-lcd
          - lenovo,thinkpad-t14s-gen7-oled
      - const: lenovo,thinkpad-t14s-gen7
      - const: qcom,mahua
      - const: qcom,<X2P SOCNAME>


--srini

> 
> Best regards,
> Krzysztof
> 

