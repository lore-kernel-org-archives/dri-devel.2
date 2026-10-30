Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3150B606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ObMPLRYU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OARrdVDx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 654A610E86F;
	Fri, 30 Oct 2026 16:45:34 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5023210E86F
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 16:45:23 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERibk3207524
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 16:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4dVHIRd4XP8wCls0LamSIQUVU6Hcow9GRfU7ul96ths=; b=ObMPLRYUzvDQOx8T
 jOmMEcGai/36LLrYr3iAzAd6lGwhObWYTPIHbw4b4hgyzN2RpBVsZFPpE03hd5bB
 QXK0eT0uUvuPwCpZpU70nvpmlmNThdC5YxXzxtPJF8RVtcJSUQ91sGgfWAz7JXBX
 9yCsmxN8y/dWhtFfUEq5+4QkT1q0HKI+fqnMZeG8BeLdsmo3Ymu58LTjxj9FCC35
 jgONqHTr+vWUSHilkCuZZnM3d4S4JkEjzPxOnCgBQ/NqGAgTwbxfTUSc//5SCnak
 Hekq0ajz1GufnHLMFQwbu3Uce2bX1Tbet0Amfplcc5ntcVyxOLI+7XLYCZ3e1lbP
 6ZD0Pg==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qm256-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 16:45:22 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-703e6765034so512471eaf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793378721; x=1793983521;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4dVHIRd4XP8wCls0LamSIQUVU6Hcow9GRfU7ul96ths=;
 b=OARrdVDxFiU62+aJTVWrqXg5QHBrtZrajKzuI9miUBurYN+ajqpoaFC2ZDbFhQY2+6
 79V6eFvvSi+Rv+stjp5Aw9GOTg8Ys+TA64wEdOw68fyl5z4TwXUJI63sHJCbCWblojD3
 kufKRCI6qhL9IufXzBmADIcA1d3DusnT2ssC2Ape8Wvcza/09vfDKD74kcCzSJt9SorU
 lIHUCPl6wn8kSAswSYiV8dYfXlEnzdtZ7Whn+DMkVX9bw/Xs4UNrt+EsCAKwHMcVkFd8
 FiGJnoa4tLyQWL1ksAEUByS0CwHxYi65cwg0YfjqaxCINWPK0h05nBkCnPKFsboNs7VK
 Wvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793378721; x=1793983521;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4dVHIRd4XP8wCls0LamSIQUVU6Hcow9GRfU7ul96ths=;
 b=ffTemR2tltjlCirxgPC1wD+Bnu+unx3jjwI6z7q9eeep1FxD16RcADrWFOFMUwNDtt
 m6Urc0ebraXTvoG11E3WDnfCrqObCxuNmlduBVkeRT0hCh3BIeN75um7A4kOgouY5X3f
 UeY4F0tvK4PmCNxkkLfgZH1Tfyj4Uxh6J7oiKQEC8mC2JSAhXE8Ss2Vlb5LfRDwwrfIY
 7MINUt/ilCcvbByuarx+6uknB2FivjDiocPDbMU66sl1SY9Gg2gWxmZuELvK6opCVNd6
 qBwpCBGggNlxBYsxcCfNuwgb4a8cFdhRTEY5f4JtuUyavC5rxMdRp14q9LWbxUur1KnA
 tD1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwPGOzIfZk9keFzA+8IgSLLcJg/VirITBlGW5cd4YsKJfdlKdd2bbPxQQcpcCHjt/cHQ9agCJQZMZs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLR/BXllBF08zgEExffp/P9hKcz9xlXXywj7gGiAN4WnHJk2h2N
 GNhTCLti9tGYlPM8zJGKzrLNMH9Zjyw+AlFhLYGQ0vDKr8yh4xzEBHzj7ishTIJWrP8l8l4ra9k
 fNajDbgSB6kTBojNBlKq7UdbiGtUfgv8eEFlPsxSdkJeBpbNNeB/xv3dRVRU+BUuiR/FKArw=
X-Gm-Gg: AYBFou3NeStWBu+o0W6IGO6qHZMK66jkVtLEGDTtzLIcjb7dNEOy4Qyr023zcEOtiWL
 4dlfnsQUcaJRk91WBLxV5s34q5YnF5EGbqapxf1msna5RjySLrDLkLzjLkkkS4MqHS05CpYuWUc
 OEFufwa10KLnX/Z5bClOC8RQN647o8hEuFM1hf0vQXn9RiACMaTi8LqMQIpvFezGvy1lBZPDWkk
 Eb+wnvpy9jYTOp75hXtYgLkv014TV9Plgi7XewUS+dfzq7LepTkoR3C8xjs2ReEtJD9gj0uYyky
 2gNVMIvAWkFCwZFTk00SGpBRR1QTSnuAiF6goulGzXvz9Hclr76TbH2fcCEEmkV3O75GKQ/cl09
 brzopzt3gQovLbiYq1J36kPPC5rrVsJboKtek2rqbfYqexKSxBAOTqpmPPrZUCZsKawuj0pzI2s
 Gtri1eN9aZBZtwC8RENYNkYZc=
X-Received: by 2002:a05:6820:2206:b0:6f7:6416:a33 with SMTP id
 006d021491bc7-714f29bd94cmr1754806eaf.39.1793378721320; 
 Fri, 30 Oct 2026 09:45:21 -0700 (PDT)
X-Received: by 2002:a05:6820:2206:b0:6f7:6416:a33 with SMTP id
 006d021491bc7-714f29bd94cmr1754776eaf.39.1793378720848; 
 Fri, 30 Oct 2026 09:45:20 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-714f2e5b450sm2196842eaf.11.2026.10.30.09.45.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 09:45:20 -0700 (PDT)
Message-ID: <6c2b6fdf-90b0-43f3-b5fe-97235aeb4219@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 10:45:18 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/drm_ras: Extend DRM RAS interface to include
 telemetry nodes
To: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
 rodrigo.vivi@intel.com, raag.jadav@intel.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, kuba@kernel.org, ogabbay@kernel.org,
 lizhi.hou@amd.com, karol.wachowski@linux.intel.com
Cc: carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
 youssef.abdulrahman@oss.qualcomm.com
References: <20261029203000.1763447-1-zachary.mckevitt@oss.qualcomm.com>
 <20261029203000.1763447-3-zachary.mckevitt@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261029203000.1763447-3-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KsrYSmWN c=1 sm=1 tr=0 ts=6ae4c9a2 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Y-R_HQd9ABXJcl_gd78A:9 a=QEXdDO2ut3YA:10
 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-ORIG-GUID: ZJJLC3IJfrt1DpUH0S380CnuuiY06nNv
X-Proofpoint-GUID: ZJJLC3IJfrt1DpUH0S380CnuuiY06nNv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2NiBTYWx0ZWRfX6fKvdQBQ4ucj
 qDrABjergltcmnYwkmwyFymWA0a58vq0Ve9F8fSG+BgEwJ8YpGXEw+E2Nzv0TVaSGwFOqMmjSUl
 tLuKlSY6aGul4EJz557JBqgdPNReCZH0CBImGPxZvkytXxUyQK/BWwb0pF0dJZbdN6sRfrLBdXk
 7Pq7k0tMuasMK6O1M3nMCVn6w5XIuDFhYySeSCbO9Uma0DAedodOkXXV7WS7cJB+7ymRmsN5xfP
 iIWwfJxZS/5PZqCLEwKkGUKp496004D6sr2xz+cOWhDSkNhFA8VkDIKlTHIvmviTdZJwZv3w6pI
 Hn/vGEn/ReBOPTDLedJiAe4AhfX19tIEUD7RjCgp+QmqO/3NFW6u/klfKb/vLq8n4elg4T9Zd1p
 anh6ve0936EoQziWfgDkdAIfi0Cir171T+L82iJ+SOlk+H0uwk6dFwXNC1zKuzrDy3eaiS+mtTH
 Jd3glxHzf6h/G80LRWA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2NiBTYWx0ZWRfX0OIyxqIE1mhc
 KazK7R0ROjOReyCmrLc7lpFvPQK7tHSh/Mh1G2n4m0bFf5Z2UshNITZ1fFj2onSNbFjEA8AE5by
 Keg7+RBe4umdwLhNmu66s8TRjJm/NT0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300066
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/2026 2:29 PM, Zack McKevitt wrote:
> Add a new node type, attribute set, and doit/dump functions for
> performing telemetry read and write operations using the DRM RAS
> interface.
> 
> ynl-regen.sh was used to regenerate drm_ras_nl.c, drm_ras_nl.h, and
> include/uapi/drm/drm_ras.h from the drm_ras.yaml spec.
> 
> Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>

One minor nit below.

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> index a88fdab7a1c7..a02aaed8772f 100644
> --- a/Documentation/netlink/specs/drm_ras.yaml
> +++ b/Documentation/netlink/specs/drm_ras.yaml
> @@ -16,11 +16,11 @@ definitions:
>       type: enum
>       name: node-type
>       value-start: 1
> -    entries: [error-counter]
> +    entries: [error-counter, telemetry]
>       doc: >-
> -         Type of the node. Currently, only error-counter nodes are
> -         supported, which expose reliability counters for a hardware/software
> -         component.
> +         Type of the node. The error-counter nodes expose reliability counters
> +         for a hardware/software component, and telemetry nodes expose an
> +         interface for reading and writing telemetry values to a device.
>   
>   attribute-sets:
>     -
> @@ -100,6 +100,34 @@ attribute-sets:
>           name: error-value
>           type: u32
>           doc: Current value of the error counter.
> +  -
> +    name: telemetry-attrs
> +    attributes:
> +      -
> +        name: node-id
> +        type: u32
> +        doc: >-
> +             Unique identifier for the node.
> +             Assigned dynamically by the DRM RAS core upon registration.
> +      -
> +        name: field
> +        type: u32
> +        doc:  Telemetry field to be read/written, e.g., SoC temp.
> +      -
> +        name: field-name
> +        type: string
> +        doc:  Name of the telemetry field defined by the device's uapi.

uapi -> uAPI
Might as well be consistent with the documentation elsewhere in this patch.


