Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D137CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 11:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B39E10EC7F;
	Mon, 19 Oct 2026 11:48:10 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7951F10EC7F
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:47:59 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OuKp1168055
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=6Fg2JmWjJmbabOk9C0BRHqS/
 QtSPnqgEVZrkMmJYDlQ=; b=W37H1eAGqJuNpHajgHfNvWiBmHRMonKvZ+Har/aL
 XREv3Dz90mOkK1LB21+Y21PbRwkrbIiHlz0a3I9YLhfyQqi4h/kVNGpM1OBy5FCZ
 02jz5GxndLoxSOTs7grLBVrxe746oBd3PdDnFwK4lNWWCT4kyE0h+yU5U/SF6oXD
 bsh5rq5UjRZ+DNPyvD5qCkx8wok7FQRh8jGsvxlXwipCBTHN+HjupqQZw0ulTZXL
 Z5FjKZ+85zw4OEGDe4R4AVZe7AqSofxRgsx/5rStd4/OyGF9y2NHGjtz2EybqEd5
 qU8k7Qzuzzb4lvS5cwzU9ppIsV8g8XPxkeemXUCdjyyiMw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf5c8vx3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:47:58 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f3969a2a7so183319085a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 04:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792410478; x=1793015278;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6Fg2JmWjJmbabOk9C0BRHqS/QtSPnqgEVZrkMmJYDlQ=;
 b=SYo/CbttM4D2UnKzSl5kdVtqk0meIyw58rnDuMxWqIuw6MB11JGUhp1vuo2Uf5gMZs
 BDwHQBTCPiCtGjT3V4DhEJzpe2sN2RBrYzkhKhslyMDdwQH1UTE+yXqhXgIK/g/UIf8y
 ReXRD/GRSj5WL8XihuHWzG2pd3H5c9sdqMlZ/i5DUBU/hhoLrsESkJvJyTtvDF0JaijQ
 9CbsyBcdzwiV3x0QC//ajKaVwbFm7e0lQwIfYWanGEG5AhFDG8fVJ12AOGCNOchdH+JR
 QxHsFZ3/nUDuhWUcf/7CZJe+l3DWjjIR5WVAqi5Zodobn0pqtYL+duvsPZOKKjdX6Zy/
 viZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792410478; x=1793015278;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6Fg2JmWjJmbabOk9C0BRHqS/QtSPnqgEVZrkMmJYDlQ=;
 b=2tY/405rK8apt3p4vRFjchhNUEEJQQMXAPLqLIIv0DwkqUvUk4EVnR3gubYgv8rT+A
 PTVIEvrwiUN6TZn1UijjqwCSiaIiJbg7/TwpQmrO3j3fvbKIYBvoTCLNxpiX5x4x7H/7
 euNf3d6493gBC2u3OClOaDjMl597TkCC47HRlzhf21MkhDwmObhhFzVrMkD9/6XgOjWl
 Tx/wPtvXXYPXbmWKw/9XdhmP1Cl4uX/OjtLIW4l8zomRG2gJV/VJySYwAr3jnmTVQmVe
 gxfVS+WDXYlonxT++pg7oYxtCkZy6KhxTKyrIvAwWvJrfvtCXsyj+b9OE5yN2UmwqKuL
 6IHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4tjfVhvkTQbm9GPTpo3TvnsKdn18d70JbLuuI2/1YVIhxYL87eK1AfWhmQfIxZnsvvh3Qo+Hl8rk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLccmZ+EugREj2XrFQmMBNcl4jnctaCxrnviAwCfeRuWorW+rSS
 pSyQJcaYqSUDD62YCtcqY7YvJMlbUdQ6r/9lIUc/SAf4QwwLN7oRy0TT5RvEhTw2A4AuaC1T4Bp
 ZS6v4UrmMzQuZuGfB8L0iIyB4sIkUUklUEePyosDqAqB1ghlolgAmL2TnZJIVHZdSadZbjfc=
X-Gm-Gg: AYBFou07o30r8O9Ox6jR7dFzWtJmrmZNvzIg9rcBxZgJjtKCMsNW6H/EuxuSEU9X/AY
 KNbRJ/M/yVy1whtyGna0lnRcRGoe0pTB9ZgXqAAkJhlXYvfUhcLp7SmeUkg8yDWrSBrSEcF9vN1
 8SFtk5+4mSatVI0atcVhYwItUbZnvtezmZdesngoJ7SiTfaB10sH4iQL7drAJA/9q34G8F0xx9F
 QIUa4e83iH6gPFFMWvzZkwf8vNMLADIoNjud63PfhnfxmX6x7CTUGFbmbeRfIF0MCzXB6ZLsJi5
 8T9MGpk9yT9NtTTjKM6AGEvGB/4YW1ZPKOD+1d7VqiVaiB5sTIE3aBhlY2Pmb3+c2xNhywcL4hw
 B3ARde6T7ZZI2jWf+
X-Received: by 2002:a05:620a:6f87:20b0:93f:2d10:ea49 with SMTP id
 af79cd13be357-93f2d10f8a8mr730719885a.45.1792410477662; 
 Mon, 19 Oct 2026 04:47:57 -0700 (PDT)
X-Received: by 2002:a05:620a:6f87:20b0:93f:2d10:ea49 with SMTP id
 af79cd13be357-93f2d10f8a8mr730716685a.45.1792410476993; 
 Mon, 19 Oct 2026 04:47:56 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.187])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd5ad06bsm23495798f8f.14.2026.10.19.04.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 04:47:56 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:47:54 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH v2 8/8] arm64: dts: qcom: sm8150-hdk: add display card
 overlay
Message-ID: <zeuvurtobviw33jykidak63yf5kyo4y6api3bnctlvmxzgkfhq@bkxxhscma4st>
References: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
 <20261019-sm8150-display-card-v2-8-86c05068efc5@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-sm8150-display-card-v2-8-86c05068efc5@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NiBTYWx0ZWRfXxnv3ggaJDIGx
 FAtz6G0zcAlM6EfWnZFKCURkWBa8mbGU/n5tPcdAhKca55sgOJBHyHm4SieKyjG6V/CcW5/2EDp
 aPX8K9dHB/Ia2d/dKShfJFqUMdS+oyY=
X-Proofpoint-ORIG-GUID: uHXw0TeIRAXb1q9PQ2EdKEoEnGHti9jJ
X-Proofpoint-GUID: uHXw0TeIRAXb1q9PQ2EdKEoEnGHti9jJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NiBTYWx0ZWRfXxrxS1g3Q1yxi
 aWZrBahw8ixlxOTar5MsWvMY7ZUDqsxRo2kDmtFRYu6O0GfjVoO9q3HNduH3myTmpgh57HY3XFE
 fVDBjS/xpfUhapP3btLcDszdRv8f++k+zSZYyaYSVs+TgColvdr2lggUAVScL7Z9fA6Q27ccQ8W
 hT0mmHJfnys8RuhjsS2WOcH75TKZbNQu2eU8niqeQ9j+Q9eNvJ3/c4fO2hq4VDVjlY+M2KrV/k3
 +HXumc8AxLZQTaNFv8pZXYpPST4MjzMHdPA/6xgBVjIqIbrfS7r+WefEM23Sse/ZVM3pSpuBnIk
 k05MLwih7qRStjbBPl6ttDSi4t8e3iZ6jpzA1QdeANJVqx0B0MjHJjsCch1jUV2oElkx2PaVsy+
 OdmkbHjg+mzlFd71qjruOXyYtq9iZtavykru+AL5m2FBLyC/kUKrXZvA/J8egLnCZ2nWFmGbJlY
 N3U+u4H6rB9gq9WpsYg==
X-Authority-Analysis: v=2.4 cv=K6O3jCWI c=1 sm=1 tr=0 ts=6ad6036e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=Qvngrl3H0rQgGg+94q4QgA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=4ZraDTF-A1gCCZ4hMMYA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190046
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

On 26-10-19 14:25:44, Dmitry Baryshkov wrote:
> The SM8150 HDK can be fitted with a display card carrying a Truly
> NT36850 WQHD dual-DSI panel. It uses the PM8150L WLED for the backlight
> and LCDB for the bias rails, and it is mutually exclusive with the
> on-board LT9611 HDMI bridge.
> 
> Only two of the three WLED strings are connected on the card: the
> backlight stays dark and the boost runs into the overvoltage limit if
> only the third string is driven.
> 
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
