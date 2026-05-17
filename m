Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0407CCD4F3C
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 21:03:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C4AA10E2B7;
	Sun, 17 May 2026 21:03:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="M8yoWMEM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DknvUIWZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AEDA10E29D
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 21:03:07 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64H1lROS849157
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 21:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=VVSuzLLDRHb7QkGv2Hj4Tw1K
 ZRnYa7BJhMxXlF9ykEI=; b=M8yoWMEMDAISG1SGUaIJrOGqjepTyR3+P0mzvQ/i
 rxQhKUxNBhUrib+kXilfFOBdKKBe6Am1gTkH4FcPxOeR0Dhy2ldF2ici9V5M7EeG
 HgfuhJ+IE5pYepRqXXPIhyM9Sn6xb4izhSEaxyDFgckl8p1D57MqJ6oJ0wu7Hnbh
 pwBYCPJ/+awgjCRBXiDIGluErU1xR9EFs9t6raJhbQdkEdmzx/fiaGBrOWAWNESh
 VyKoA4NxLwGCbYgsKgzBYwjPy4MUySM/JMh5HkIO5VkxtX806OFsm8NaWXeRQW+k
 Y6RncfVnstTkXzKKFdSB3Z0/L1qN0CMTUfjp0i3Y715drQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gwmbkkj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 21:03:06 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51650041428so38367631cf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 14:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779051786; x=1779656586;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VVSuzLLDRHb7QkGv2Hj4Tw1KZRnYa7BJhMxXlF9ykEI=;
 b=DknvUIWZJEJFn8l+fF5vNVAI5Cex4vysExIQrSH50zFCBECxgdM9Dk9b0JnI6QRscF
 5wOoe7DmPB+YzBLkJ71blh5ukk19SCbnX1iI9j7VbXRKPdAitpRDdzCx+hG3DNeYI/5D
 +KBIPbCRZniI+hkGJVzOZzApeKJZq609x+p75c9dJyfgQdFFJKmlKZV7tOzgdd6mjHN/
 AtUUzI4c3XqoIx/MVsJjL4NA4fvOhHUZDl0nXUvWWjFi+niMUl68L6RTxSrPP6H25KLd
 Tf4+jZUqEShaIrnKc4mrtbtlE2Z8NXd71p1UjnFXmkOZdSW5ZwWOtJPnf2FsSKo6VL8z
 bUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779051786; x=1779656586;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VVSuzLLDRHb7QkGv2Hj4Tw1KZRnYa7BJhMxXlF9ykEI=;
 b=QfK/vdsfC8ntt7CqBAm+RWhCMm+Wpaqoj5qWw5Id93+rblllB5oJIhdDLJJQiDCmxL
 AHoya8XktxFtTDRjg2q1OnG6br4ti586iDYMfmuIJYYIjjsFRtrt1MWNxPYSkts8tPf9
 bYLH3HWHZwa9D9hrGkpvazvKjcPgvWAsaDvkiVzQlGu4uJ88CjAFpwNypgwLKbSRIqwX
 aPjZDAC8FfKlDdQcZJSqf84hxBDN3dgicKGof0B+7W49fG9wr0QCfSHLOauxR1QIz+ZV
 9eH/B3lZM79ZfFnthpWzR6cBE2pgA0n46tQWP8APGIxj3lcMSTJcAls68HwFBDxgkLcM
 J3Zg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qk0DDyqk2Ndn5ahz7IiUpXAatFtkF+p0XFjz1JMHhcA0D6rS0sGgbB7PIcHOmoGrmOBWtLPmbvV0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTMcowYGN5J/pq7G7MZCcxGV/Qp9Dm/xwLnLXYntAsASqCk3+v
 ZPf0weHMMDBxoZ+aFxyu3ORxa95OQzRcYtEYgBpJyQdNOT6O3hrh3lBB51fAFfCc/EQ4acfTOWO
 MJtQDe9fNZn66LuqHXZxibgsKo3bU3pZbqPkzvdHdrOBi+3tzEPFvlfnBe6M8iZ0DkI4DAw4=
X-Gm-Gg: Acq92OGBDkpL/Wof8uSdEewA+aPKQ1nZekpDBMdlISnqUvp0qQuGXCSxzb4IgWZ1Cfk
 ilM+o5KrQxkEcBvyie90BRtrcStx5NxRRREKedQYH32Xd/JgkP5KOGSXg1qvZkm+diBmKOjMlX+
 TOwjskgWfVF0tDixZGZPlgIhME5eyWB63ETjFmq9p6ysS/8FYl4MtgpXN+kmQ4KzN4UzoSP9q1e
 dAJofEaETKoDbtQ5lgrqHRmwfRbFzW8io1jcphWOd2bQRSMaH7J1A2J1/5+OCcxd0r4/8nAL4qg
 LdR6S4HEfKkGwO1bU/foc5loz6nM0YWZE1bWCeK1ZYUfoPon8IobBaGl/V6kbKCM+bouD2XgUjd
 CRIOMk0/+HfNWe/Ulxx4QvMSR5OWiW1C/BX3F3FG6EMUlcd5bYF/zF68Hkj8WCg/v/Zdgm6b7uD
 0CaOTRo2IEDYdmuIhGeWrHnIk2LWzoLAv/AjNZPvGX07WwVw==
X-Received: by 2002:ac8:7dd3:0:b0:50e:631c:c390 with SMTP id
 d75a77b69052e-5165a22d156mr183972331cf.44.1779051785715; 
 Sun, 17 May 2026 14:03:05 -0700 (PDT)
X-Received: by 2002:ac8:7dd3:0:b0:50e:631c:c390 with SMTP id
 d75a77b69052e-5165a22d156mr183971831cf.44.1779051785286; 
 Sun, 17 May 2026 14:03:05 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395882e734fsm7520441fa.18.2026.05.17.14.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 14:03:02 -0700 (PDT)
Date: Mon, 18 May 2026 00:03:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Frank.Li@oss.nxp.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev,
 Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] dt-bindings: display: simple: add avic,tm097tdh02
 panel
Message-ID: <qfyc3kuhd5qwgtbbvhix5upyfcn5s26vty2yrnkzun7vuujgco@44itayac2pfe>
References: <20260515195935.2415466-1-Frank.Li@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515195935.2415466-1-Frank.Li@oss.nxp.com>
X-Proofpoint-ORIG-GUID: ct0YamW4l8ukxQAbnClmEeL1ss6MmPtG
X-Proofpoint-GUID: ct0YamW4l8ukxQAbnClmEeL1ss6MmPtG
X-Authority-Analysis: v=2.4 cv=W/AIkxWk c=1 sm=1 tr=0 ts=6a0a2d0a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=8AirrxEcAAAA:8
 a=402Ol7Zq4xy1YCkJ2sQA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDIyNiBTYWx0ZWRfX7p54+re/C2Ch
 DMHpU4SRxUzPLuU6Ji0cU1LwZHg/I0CwF+xKzaVmgl8nMOGLBDj2VZpNVa75e0Y5g7u7gTcUcti
 4Hk8nwG1+ywhb3MhuFHFbjeSigu3Y4hTARJSR+MWP2UNCjC8dKlocjZ9sNZyxjWBdF1Ns36ZDxn
 vsJbRM9M07s4a/t8dFxUeaLuookP7SIxFByObKeW4l51V/bjP2zQRMiqvVhqaGh26pCrHtM08IX
 aL+QChnax9vnjP2nFVGoRaFZGT58P/5xiX64XyLTOCLAGEjIDd3cHVQUsgNcvLWluXldtCggxBq
 xUNN+SLeMdlx5JKxdRyUFGLi/Cqtz6kTvvrSyzF8mSHLomC0kFeUIfMuE41iVCpvU6GdSJI2Wre
 8I1kAyBQOvCfIAho6z3gbCxPgS+1lNXPEGUVlKf8vLnRk2KHHCMdy2V2HYfekxHY0149t6RFlVU
 b5VS3MTvA5rLTHbu/aw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_05,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605170226
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

On Fri, May 15, 2026 at 03:59:34PM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Add compatilbe string avic,tm097tdh02 for AVIC Optoelectronics 9.7".
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index fdf522a15d2ea..a8f057208e23d 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -63,6 +63,8 @@ properties:
>        - auo,p320hvn03
>          # Shanghai AVIC Optoelectronics 7" 1024x600 color TFT-LCD panel
>        - avic,tm070ddh03
> +        # Shanghai AVIC Optoelectronics 9.7" 1024x600 color TFT-LCD panel
> +      - avic,tm097tdh02

Not without the corresponding driver changes.

>          # BOE AV101HDT-a10 10.1" 1280x720 LVDS panel
>        - boe,av101hdt-a10
>          # BOE BP082WX1-100 8.2" WXGA (1280x800) LVDS panel
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
