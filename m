Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019F1EC01C4
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 10:52:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5474510E03E;
	Mon, 23 Mar 2026 10:52:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="D4YRlTuY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KpnFKlHX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5791C10E03E
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 10:52:36 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62N7tCFB2291198
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 10:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KYGocshpbXFcrfOfvQgf/WesrIOihcHdA5GDk2E3Bzk=; b=D4YRlTuYV9+HbP+h
 C9qWOHmabtiG/YpE8C44Os+PkPwuSsgv470MvbTLBu1cJLexmJYPMSIymkxm63uX
 TniOOWimoO2GyO9WWQ07OHTMtpESEAFDU/YfHbX6Jwy+JrKd+/0fyQH4H0QoTxPc
 zgJSwZjHRTtcjoZgg3GMjz9WI2WqNpct1N/wywuChvn+8465WHsUouLIeB+hfWi+
 nOaNhy2qD/GiwKWb6WmHRzg8M/duaNFw71B/Tb+rkPzrlvD1+7ma5kMA76DNPgQs
 aFClfIo3KnpktOxBRuqqjDOF6Es/CYodGmy5iGUfwNd5mv3hBRhatZZXmZdk+Isu
 pAH/5Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d31j70m8g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 10:52:36 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b33a19837so40009461cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 03:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774263155; x=1774867955;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KYGocshpbXFcrfOfvQgf/WesrIOihcHdA5GDk2E3Bzk=;
 b=KpnFKlHX4je/xpEpU9Cu9/SHBGxrZJB3+jVdpMF0HirjXPQH2Vq+5YvBGJpJPHv5z5
 MJ9XWwzNbi/KCtSeq0GfZm3c1ChHfYpdszfDTlje6QC2JpCXGZfCuG604yMsSsKIYyTu
 wlGKbtzCoZ1F0JNRgWBpKONJXOzTsu/Irn39rHZgPzYkdkBbUCxy9rVyakIzIyodnddM
 oQu6NjQqG5xM/pm3diRdfdqZtc4u6t2+yajy57uMnc8H3Q+4d59bwVmTQtFE/kF1X0/J
 e3UWhoObIHbKke0gFo4z1+935dNHAtQGeXThx53L/2uTEpJETZCH0lHhJyXK53oFL+sj
 dQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774263155; x=1774867955;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KYGocshpbXFcrfOfvQgf/WesrIOihcHdA5GDk2E3Bzk=;
 b=WwhMY2HGs/y/tpv5Ybw70+68P1MYF+mzfhxs2P1gw2GygVR/G6ndyTfHFrFTHc6sKn
 Vx9lSm0rwO2jUMCdqY96pMKFcE+iSNjROcvziFCC9o8qnJhcvSiz9iyPbD28u4qgj3Bw
 X4O0n1WUVz/53ldl2Bs/LK6AODdUBEvDGAWlCCo/3ztMDSACMgxrj1kZvWTEC/hrMmAS
 UQleKPw2/OICo2cMSqOtf0c1vLHX57sH7q5cxNGpEPJ33q7xTeOKr5Y3YlIyXZVj/o2w
 A8u3o+/9sCoh8zxafyniILnzJButP5Lkfa2Sdr6WN8ZO7ae33Ttd1VcOTR4ARbdafA9X
 rigA==
X-Gm-Message-State: AOJu0YzfWjX7SNO0bGYVlmHLfvm0fBsq35maig0t4Hq8C0erZ7f1W4LO
 RgD/Gg6Xz8CfRCdd+wcO/B+X160LA2fqfPjICrsvCwtct4ds3RIGueTjDydxwjJP4hewSeFigG1
 7qQGoXbgsgskUyK3mcHqlyb4FXXbeAfW2hbeiw0CUA2VRkF4ftYdQfoknghk+BnthK04EBDI=
X-Gm-Gg: ATEYQzwJ897REviIhd0k00wBXT2PZHtpgnoaMoApnBRA+1QSbZ+QF3pQubYqBQv1Gcv
 hRlFmNHyqoHhGeyjpRwm1wzCEzaBW5Aht2HZBGfuTdVMVK0b4w9rmtDe+4BiErjQXKhK2930cox
 vXctArRLkKrxjk0XkYUwgxRR3W8IoIIr+bsT10MXW14vUZbmTNGMeXzW7MfBv2leBF4E+e/paQ+
 9baiHng7B6QxBFImX2XHt3Bocr+07mteJ+a/h3XiURu6lC6NhWcPPRqPxGFzwhacbCdufnydoPA
 gRlqi/i67vMi6a5cTiiutCBci0fkv4AESMhzHTRzgJWgxCy6l+gt3xyKj4vNNbxbqFRwiQeAhYe
 cDYxmEs/N/xbBbAmrcWTUxkVn9GLoloKgBKJ6ZOAoOCX0GgQNPstJ/s8yvWzgzkgDaP9VXmbGgA
 cw8g4=
X-Received: by 2002:ac8:7fcc:0:b0:509:9d9:e19c with SMTP id
 d75a77b69052e-50b3739034cmr137536631cf.1.1774263155433; 
 Mon, 23 Mar 2026 03:52:35 -0700 (PDT)
X-Received: by 2002:ac8:7fcc:0:b0:509:9d9:e19c with SMTP id
 d75a77b69052e-50b3739034cmr137536351cf.1.1774263154936; 
 Mon, 23 Mar 2026 03:52:34 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9833871a44sm484502966b.56.2026.03.23.03.52.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 03:52:34 -0700 (PDT)
Message-ID: <109d21b4-5d16-4689-8383-ecd29bbbf8a6@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 11:52:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] arm64: dts: qcom: msm8953-flipkart-rimob: Enable
 display and GPU
To: cristian_ci@protonmail.com, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20260321-rimob-new-features-v3-0-d4b8ee867de7@protonmail.com>
 <20260321-rimob-new-features-v3-3-d4b8ee867de7@protonmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260321-rimob-new-features-v3-3-d4b8ee867de7@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ArXjHe9P c=1 sm=1 tr=0 ts=69c11b74 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=sfOm8-O8AAAA:8 a=4mdWWUweJ5RzV2WhxXkA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-ORIG-GUID: iik0T0zMO1-4D75uLFuBXKcrrs55Hjjl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MyBTYWx0ZWRfX5rfDRiSlsAYk
 OEDA3zScskSNdGOsuqi1J2z7RwpPZlLUsr4mxUmipAdhIo38dPK9P9+Iam4UAufNZwkkR6PdQpB
 CYSKI44lv+MpirPY+ip0QEOZva6FGXINNY40yCK7DNjrYsH9/lXxhHE5x8fCOfLlbdOWXl7F1cS
 zOwuEQcM/OgOhZlMRnM0F2t4TOxl5TIfiw1fkg3iRlSegWqXZiyPWjyrtuSip+JnaB2aJQvCv9g
 xztNzMLM/OXzqZuaG1jOP9Hauwi1A/fsuEhmMBiGx6SE5LWWKNBikdYPT76Gyhy5tMHNlI3Qjwl
 xFlgT64zV2ywBG9Uy5mcSAXKF1GWSaQv4TWKU6XQEVGjRrwOJYmlCtzP0k4c0IpmoeaWWqE0mXo
 jjTss9lOgsFZ5qz2j5gqrf7V5W9eRd4TU3NzOsbF46mOP7cUT4bhlLlmc86O9BaCdpo4CKJnBQG
 uJ6XHXYcfyT3/RHsvCw==
X-Proofpoint-GUID: iik0T0zMO1-4D75uLFuBXKcrrs55Hjjl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230083
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

On 3/21/26 5:23 PM, Cristian Cozzolino via B4 Relay wrote:
> From: Cristian Cozzolino <cristian_ci@protonmail.com>
> 
> Add the description for the display panel found on this phone.
> And with this done we can also enable the GPU and set the zap shader
> firmware path.
> 
> Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
> ---

[...]

> +	panel_default: panel-default-state {
> +		pins = "gpio61";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-disable;
> +		output-high;

This says "by default, actively drive the pin not to reset the display
panel". Is this actually necessary?

Konrad
