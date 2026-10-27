Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BCA606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y1uE8HYU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bCjs+yQn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69E8510F3F7;
	Tue, 27 Oct 2026 11:26:06 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9F3D10F3AD
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:25:55 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RAeJMU1427413
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gV1fCIZW2NicXlmFikXGuq/gfQCQSMfGDpxSV8le4/s=; b=Y1uE8HYUsfHvUvss
 Qj3DmyU2upZPPNVhR9q8/VjNENWt1taFK2PCoNcctzpcVmaHSbLjowUZbGsrD48B
 p+CrGgHE94fa0P9b8cx+dd5HR4xU7cyc9zzfR3Hs3ENoNyre2PvGr+UOfp/hNpNH
 y480kMXKzxhXjCExAEON2I8QqphpfXEuE1lVGB7JBLVZy7PuZmS/E7WS/GbXEswp
 oAY1B3aMUX25/y02/jQZ+OfB/4XfcOhM08IV3mfrM04dEwzZB2uS+ubEmQR8E7j9
 iRj1fCXbgIWcLnGR7gwMPEHwl2lqJy9qCJYf8H9+AraxJOHnNfdXIhZQjDBV11Cy
 FAF40Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmmbawe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:25:55 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5350173dc7aso13046831cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 04:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793100354; x=1793705154;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gV1fCIZW2NicXlmFikXGuq/gfQCQSMfGDpxSV8le4/s=;
 b=bCjs+yQnbuZg2tJU6Jf3N4herybMim07bp1+vW9QrkAsJFiSQh8J7pTlmCTs72pK5C
 tkMyV8e1f2scsEAAVckKcBy5QysJXKrlXEdTegje8kVH57Rjfidv+9leC73r9yvYNaJb
 WcILMYc9XW2776w/kSq4DPYE+mk4flE96L9fYuRnhKRAexcKXCAT2rYL9vwMpk6Gfbm7
 BE+4VD3O0w3WQfvMRt3bn9CR9QuBGGU0+sSjRlwLPTm6lgwl4ra/5fOfK1IiniKprKuc
 XfV1Zy/kc5GLU2EgWzQI6xVOwk3bHxwOCtPOl5dQ2GOmCwCQOa1ZmEfHmAk/slmIpzm2
 Cbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793100354; x=1793705154;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gV1fCIZW2NicXlmFikXGuq/gfQCQSMfGDpxSV8le4/s=;
 b=Xo/v+xKgoF5oSXdQHL4cqaTh6vmlqJKsrkjeGCL+6PQraijgA2HwZXBLuf5KvPtH1k
 BiWKIIoCq9j/7JtSVAnWgSmuoZzzXwK5vGPGDIcnBAQcPZJB5SF1HEhCPhpFGlP0HUO0
 oS5hvwAKP+dHgvF0i5inIgLikFRA2lKIzE2JF+0/IZGe42WdMgX/dZ6Ga1USgAWdqxr1
 Nn5Ve5h8JFmbtf4oofVEo/vSMiVgpr+CbpBN9AT47G8rAd9m8EO0hvQySyQpLdssdnOw
 WMIv6UbNpuwSaBWpszzYFKSzCP3aj0gCFYQMRsInAH81Imy00BgnoFCpBrj/8c5Wzs4k
 c+eA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTxZDvs6IkeLUeqPNEyGtN2sgjQC4R04HsnzghUVJ8+N2Kyz6qX/VVabWOs+/2/ea+ukqVboIc7hU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIFNmzSANfuCzcpO6PbLdk2vMKlMLcXaBXg6l9lDrBnfmvzjSt2
 1TkQjr8GYqm/m/0gbrXPtvwNy9dciJ0JBeDX4CiHztmqb8srV2QgmnsDnPYO1pkPwzvwvud07d5
 5rLor2TWA6g0F/60GQaCe4L7mw6L6aSumaS1CfltfU+UOro1EaOrlI9HxtT5F4PBrwteDCWw=
X-Gm-Gg: AYBFou0ViEUK2G8yAbWU71WkZUJaN+YJhW9GHLEG/w9v5J52srW48A96TTnh1WkjBWC
 RoxkGaBQOf2b/4FRtD5RgJih5NT10IRZugBAVwftENSJYDqGHjFCdlHeVj9MWRx2rHonfLh9riO
 ZLxssfVkXFS7GugzNuO3wEGsSfzKGx+XzlYc/mP9duH7p6FvBODcFViaph0uz7sjtCPnR9sFKF0
 fw2fbM5NVo811lf+dPChREowLtP+9oZl9MonYOV/1pi4AU/o/V/OOelSIe6cd2tn4PAcFjx/Ipr
 Z2PRDf00AD4T4B16rOVxKbg67IocUcC4VmoE2z/liFsqZebN+/OVAc/4jerAe075CN1nf/urPwM
 JLIOY3S31kFqPm4p7gTUNTw==
X-Received: by 2002:a05:622a:e0ca:20b0:538:40e2:bba3 with SMTP id
 d75a77b69052e-53840e30413mr135312711cf.0.1793100354144; 
 Tue, 27 Oct 2026 04:25:54 -0700 (PDT)
X-Received: by 2002:a05:622a:e0ca:20b0:538:40e2:bba3 with SMTP id
 d75a77b69052e-53840e30413mr135312391cf.0.1793100353679; 
 Tue, 27 Oct 2026 04:25:53 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b45e167f4esm3315889a12.2.2026.10.27.04.25.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 04:25:51 -0700 (PDT)
Message-ID: <7e6cfbd2-c54f-4a21-af27-f681e6ea19b4@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 12:25:48 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] drm/msm/a6xx: Factor out the common BCM list
To: patches@brar.si, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261027-adreno-a620-v4-0-b0095e028c76@brar.si>
 <20261027-adreno-a620-v4-3-b0095e028c76@brar.si>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261027-adreno-a620-v4-3-b0095e028c76@brar.si>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NSBTYWx0ZWRfX41Phqvesngtv
 D+ZPk7aBl8RVcCqGjvO7RFYJPnX+z+cg8dr6if0vb84f/g4dsETquEVcbxSDiZ49AXQxUXEQwNF
 ETa9q+w/1gbV+yYmtU9T9kNcnAoyWcc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NSBTYWx0ZWRfXytTH5+dXGQ+o
 kCIQdYdo829JkTB87hOGrXeO03R5CbIBHoeWQcwdns8gzmtbxiR/3TfGnYBgXp/PfvDPfkoUhlE
 ENnp7Z+Th5SBkq9KTx3lCXPoBlKQUelDD4zK6jHtA6iY7YU7V0S0WB4kqWJYmC4AScS2JnTyoYz
 L/hZzWQLI8g6htwFurpFoifv+v57xNO+CV9KBP2bBLwsofAn0TiS9S/ECc8Ria89d3KhprLE1Z0
 8hVcgeGqL0Bxkkr1w4l5ETx+yVqFC0ort+28ap90m1SnR/hXtbLY3oufOQp684WT05C2MYKXLR9
 fpCh7DyqGYmFILbuIPRESz+rt7oNI4gWcm+AF5z8tZca2nm1yqL5eyPdBv20g7HBXAh8kn8fcnk
 ykGeMZAZY6a3vE+56Tw2ut2r6uYGKh3v5FgkYaWHO05yXbtBzkPU/SMTh6TgadSDJZMoURyrknk
 A/Jrco31IvimYFdEHUA==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6ae08a43 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=J8-uP8xFOBs1Kl34Lf4A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 8lWmUfJsqG85lHf6leRWC73aZ_5hgCG6
X-Proofpoint-GUID: 8lWmUfJsqG85lHf6leRWC73aZ_5hgCG6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270045
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 8:14 AM, Ishu Brar via B4 Relay wrote:
> From: Ishu Brar <patches@brar.si>
> 
> The A690 entry carries a list of the Bus Clock Managers it votes for
      ^A623

Konrad
