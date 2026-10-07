Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8506DCA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5B7D10E396;
	Wed,  7 Oct 2026 08:25:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HacJ4tN4";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uuzn19qA";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A6C810E396
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 08:25:28 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jY2R3298233
 for <dri-devel@lists.freedesktop.org>; Wed, 7 Oct 2026 08:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=pQBG5SbwlH1RkPs7F97Dw6PI
 C6xi4Vl8Iw2NiJzks4Y=; b=HacJ4tN4Qg83bgXfxkrxXlkf0wf0zZ/QGHe9tA6H
 YS4KXyMLf1TCaQ6GyHXpbbtBEfiXaWGJjRP4KJ5sAm4rh91gENY0Rgz+3drn1nN8
 9W1VdaOByzp4M3ZEDdJsytQp3eYK3ebhhqMXEiukrZbjw2kpp++/3EM4ASnABh+7
 wgY0opeshwrIzYhqiM5bAgJmvJslw9Vbf7CGaZnYXNjkBPsC7jXzCae6wG7DSbFl
 TpHnKjnOLi5QYtRjjdn+ANXPR9WxgPus65/AEhXGIlH7MpkeOtAHKdAv+JJdiudB
 MquMgxXuIwzOlKXyo2E9M3JXhnONimoyoYVuoSM5RNRBdA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5hdcr7r9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 08:25:26 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3510a481ae9so7367097eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 01:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791361525; x=1791966325;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pQBG5SbwlH1RkPs7F97Dw6PIC6xi4Vl8Iw2NiJzks4Y=;
 b=Uuzn19qAxnt07laoQV/DUDb1QyXj2GJIIGDuSUgvnsUQGzjICDhDRp2Q6cntCWQo5y
 ZsxGQ/2EKbXZrBN9kZZT8EdPZejSPxYn4b1OReZCU0bQxCePM0qG51YhcZCNuOP/87xI
 wAPn4eN4V6l1+Pl5cEeFotg2sEDy8t+2JY4xhfbVVFMezjbxUqNiQLxoS7fEVnqAGHGk
 AfitM20rj/dyGfTdixagX87ZD2TAINDyE1h4xI5ZXyrHPilFsSz0oodw+eN/5yH47MHc
 yWGWbro7/rnHuEcyW8MAFf2BxS2/dRQQyS19pFPJaugiB11zeb9xtWsokhbehclLMZmi
 7rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791361525; x=1791966325;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pQBG5SbwlH1RkPs7F97Dw6PIC6xi4Vl8Iw2NiJzks4Y=;
 b=wl6EhLsFj2wQe0aJ7oCmBSOcjLVom2RCrWrQPcKUNtDxjmPvauTiBIs7gCR9GOCTgj
 L7dGUv2/zwk4qyCR3ML7EvpZYiMIUn8a2r7+fKKH9XgFhuwuwKACRq8n+IosWcQpJhME
 jvaewW++N26jjKl29s+eOGPwmHTGP5CxcJh3CV9FGNLSo8xtbHHDh5DOzB7XD5uc2wVx
 9dDnOBAOqP0XdzwvbIInOTJFUmQ9ipdhpU0AVKL6xXyz8m45bmXZlORYQDdr+SiErx/l
 LyOng4Ls68zVcGOaipfoZs43RHAlv0xLXhlbvA93g4aeG10yOVs8LwIyxrxUHxYAQxRV
 1+rg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGP5zdBHbISrNSZhoYB3u0TpKZ9iooIeNsWTrJEWBG/5oNeeTxnQCjOcbDmuTqucjg5FMvzuEmemY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lWgcFrm4kR/RL52gLYu2cer/5FNdCAGaXBzuSd1IZNQAREHPN/
 RP5zP8Wa4kXITgCqCq/A+y07NUpdcinrqC16+L9AuS1f5YaLtFBOAF/FxA8A3xHJ8i8D7j2niua
 2ixL0X8Cxv9npQAPRDV9rmk0ePfBp2mQA5xcclxoHOxKfbQcD7HPNNvr5eRCmzpBKEx/ExRo=
X-Gm-Gg: AYBFou1lsH8eryxDXlyrm4Q2AsWMSygFoIGr5+a9NMJzvmL4IM4FvpDqJKd11p2sqpt
 IM1prOLUlKqRlWHJRAo2inBfpo+5naRbJrK5nbI9gyyHAsIt1pXW4p51SOOFD09PlY2ixlf2utf
 o4mTl4h97XDDPVZlrVmKyxwMmaJUHlLR5tuRCuKeaalsuUQvBK8StUoyoUVoppbKP7XEqmsrGSH
 KYXWQh/HI6hYONwaWwYyPEFDE/y+ELV40k7UvOElPETtecdUxJdbNnDOvB/OjPsVJyDQbkBg9eo
 fsnc87vK2IIW0vK34YuJDp/MTkdYB9aeLkR38JBWVSPOMr35qoxuwEN33JcnNtnyCiIyTmdXsxS
 PfCa/oBM1X89uLz5QZROfAN717w==
X-Received: by 2002:a05:7301:32cd:b0:34d:2c1a:987f with SMTP id
 5a478bee46e88-3515de554a1mr1487962eec.35.1791361524858; 
 Wed, 07 Oct 2026 01:25:24 -0700 (PDT)
X-Received: by 2002:a05:7301:32cd:b0:34d:2c1a:987f with SMTP id
 5a478bee46e88-3515de554a1mr1487913eec.35.1791361524067; 
 Wed, 07 Oct 2026 01:25:24 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515aeb6013sm5961752eec.5.2026.10.07.01.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 01:25:23 -0700 (PDT)
Date: Wed, 7 Oct 2026 13:55:15 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 1/2] dt-bindings: misc: qcom, fastrpc: Allow hex digits
 in compute-cb node names
Message-ID: <20261007082515.xmjpa5jjptgrl6y6@hu-mojha-hyd.qualcomm.com>
References: <20261006-glymur-dtfix-v3-0-44e2bc5370c2@oss.qualcomm.com>
 <20261006-glymur-dtfix-v3-1-44e2bc5370c2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-glymur-dtfix-v3-1-44e2bc5370c2@oss.qualcomm.com>
X-Proofpoint-GUID: LZywhsnG2nayckFYlJZD9kGlFqifwhjT
X-Authority-Analysis: v=2.4 cv=aKFlOr9m c=1 sm=1 tr=0 ts=6ac601f6 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=QGBbWe6yPyKI6YAsb-IA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzMyBTYWx0ZWRfX+KfBucNub53x
 kQqzJPCtK3FXeYz/g1XU+ri0PJOmwcW8c3uUa0DCNyeNnYt5OoGHJKi7Cl/d1vFT1zIGBmcmqou
 ZJD5j6jrdvWlKpfrhKtcs/MCY3uVL2M=
X-Proofpoint-ORIG-GUID: LZywhsnG2nayckFYlJZD9kGlFqifwhjT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzMyBTYWx0ZWRfXwAujxczRAko9
 1xGybNTB/lBcNJ+H0CitrhHql/K2SciTcn3LTJ+gEbTrusvcNfMwvzjWXk8VwwTLsqf1UqFcnPv
 R2WoXstIYa/jIE5Pz08BxcWkeAjE7CkZxRsX8gBzz0OA7ncEpjN05Ekr+lwFJvxAbpaG6+5tJPK
 N7CMLrgJz2T50EICttKmYVlW4p6IZ9oFAl5VbuX7upIecCgbj9u5DahdxXnHgoVjnh3yLJozeg0
 CiYwG2/Z6FwlESYKQF7Ks6RSbLOgHTeoQgGxI2pQi16u/RQOpBQ2P+ZTnHqOXYoRKTlQdhtWwFh
 0WQCTHrmBLsXdxpHa034IZ6odzWgszut2DAqX9eBhIeMzDN2cCxaU2pDwB/VA8ikj6KJcM9SFlI
 zn11C0duNFU0sHprBkzAj0zzOYsP9v21pdTnobJk5JSXs/I14+nWdFGHYA8tMEwVC5TQZ+E3/ok
 HJs6eChV/wpi/yOlu3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070033
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

On Tue, Oct 06, 2026 at 03:56:06PM +0530, Ekansh Gupta wrote:
> The patternProperties key for compute-cb subnodes used [0-9]* which
> only matches decimal digits. However, per DTS convention, node unit
> addresses must be the lowercase hexadecimal representation of the reg
> value. For compute-cb nodes with reg values >= 10 (e.g. 12, 13, 14),
> the correct node names are compute-cb@c, compute-cb@d, compute-cb@e
> respectively, which are not matched by the current pattern.
> 
> Extend the pattern to [0-9a-f]* to allow lowercase hex digits, making
> it consistent with DTS unit address conventions.
> 
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

> ---
>  Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> index 49d2a5e8ba39..14fed91fee50 100644
> --- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> @@ -79,7 +79,7 @@ properties:
>      const: 0
>  
>  patternProperties:
> -  "(compute-)?cb@[0-9]*$":
> +  "(compute-)?cb@[0-9a-f]*$":


While you are changing this, original change had * which allows
cb@ as well ? should we make it to "(compute-)?cb@[0-9a-f]+$":


>      type: object
>  
>      description: >
> 
> -- 
> 2.34.1
> 

-- 
-Mukesh Ojha
