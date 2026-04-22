Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139ACF94CC1
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 03:34:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69E2210E16D;
	Wed, 22 Apr 2026 03:34:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="f5sspKtC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ecEZSE71";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BFB910E02C
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 03:34:55 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LIZj9W3377463
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 03:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=HydW/iQ1hGLia+6fY3rza5na
 MWMQ/7GHTu6W162sc9U=; b=f5sspKtCinRcD0WUBd4tS2A9grW7B2LUzuQnXG+7
 lVFbZU8w3VFJg16W+pK/hXzXlaVxtOhkFXlkdYfgZhQf+fwCfAD05gTHj2UD723f
 HozD1tSvSfRT1fgIOp4SUjuW+Oc0q1Za9SUC2PhIb9pa0a2cU/G9tz3p4lMAsSW8
 MRuuz8nrl4UIVOyUL147sI7gr3FIfh71DnwUNNJzAZwpF0nwVpJk2wVOKRJIbdVl
 J4NUBPOK84tYnHxp6OExXMgchLthEgvaup7JT6rY9xwkL9ycNk4m1CtVCQFJQ66l
 hz9f4VGBvYy1ag508YiYbw61bSAzCU4ZjG/iIQucTI8wXQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpeng1gae-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 03:34:54 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50fb6d713ddso23049271cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 20:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776828893; x=1777433693;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HydW/iQ1hGLia+6fY3rza5naMWMQ/7GHTu6W162sc9U=;
 b=ecEZSE71+X1yPJsaQCmiClF0fF7Ln7aqbpQPwP/6bLzp4ZQNGUp4kWcMUNRXAKGjtx
 etXJ942l7ptca4qVUiCxi8gexios8KYpwUFhxKoxUE105YB0CcjChoBCxenB2BrhoQTc
 CR0lhI9UNDBdtv5YMI60An7sJHx2RepYElGMLlAzwEqwXgpAIctnPTkqPozSgHp8d1hr
 YEBQBU6lEmxvspPoHiR0thuJPF8od0j2ghORmMSNq9at+VQTrzHDzCevInRgmpAFwhEe
 obnQtj9XzXGZ9dz0XGM9rssTYAk7pdx2sanPHa2tqO6Mv7rLWOKmsdEUdakkCt4d05Fh
 /O7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776828893; x=1777433693;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HydW/iQ1hGLia+6fY3rza5naMWMQ/7GHTu6W162sc9U=;
 b=gWToFJzIjNAj4iV328YsvV8kPataw4rPB2/NIeLxYDoKJ680Ef5gBo4/yX7+oZiXRS
 RHBn3p8dFY8N+tBPzlikDvbWYFR75H6yWxW5LHYc5mZB0Y7cZX7Vda8inozPgsSU6Y3F
 WNskGNJ7ww/D6UmhuIKjSfHOFO8nAh2jRdaczuBg+gm2DcRdWFf0sF4TbKwgnPi61Bzy
 kuqndXYBziW4+IZUDg1opNTk+wfkZhTprA8Rl489R8XAW8VCWNH6FuPP2oNKHC6Sbqsk
 lqJ/oDAhK0wfAxs+LTme7tkSIY9q2M7CcuH3Q158ojerbw7uqx60CKMckubCDnMcqIF4
 k9mw==
X-Gm-Message-State: AOJu0Yy2bOmzUk72NBesZ8rZNz7rAiK2xaAD7g7DeMJPpeQy7nQtCYn1
 3uro9KpwhBZbxRql9nFFVoKvE7+YYsl/1zB+12RP7b7QPqzCw483bAOiIsfI7Wtd1iY3wy0a9cA
 4sZ4bChq35ci4UDrHfPCmZDw5WWpHyavueKhg5zmEZUKswnfAqVaxU6KjLv7eKD9lnn5PR6o=
X-Gm-Gg: AeBDietfUhuAXwCS8/uXPexsnT1BI9aTAcd9fDGKVnHDTQM57CKkMBXfQnEATHtj7Qx
 0Rv6fiN/L5g8tiIIfGKwLootiyxp5KXerHk99uAFyBcJIZtSN8osCltCITpl8jdfG9OxG+N79y1
 ruL7Ma6PM1WW+oEnzWEi2qCIv3a2Oe60UWMbqMiqlIXKuk9IRCfFWIG8OFQ9qeHjLIo2Bq+mjKy
 4x56DAbwB817StNsNMIWQfEei3gjnjbfczwzgJdlEMu28SN+owtD7f/T1gdkIJB4Z8AIInlmFuU
 ZlIXrIc3/QoHqH4noQgtkFt91qXVxvZOL64gCZqVZXfGQmTaZ+Ky09c6Jw/YNdDXuBqGqHqJX2f
 ZBZw6J1iNLmcftBjK06XaIYg3scI2pVrRGv/aK1JCHpswyy9z87xYvPK2I4vpVIv5xw0O62b6f4
 RZ/6QaoMd/fCVLGdbEKr3FYx6juGL81zp/AlW8DRq/v69cug==
X-Received: by 2002:ac8:7f41:0:b0:50f:b974:7ef5 with SMTP id
 d75a77b69052e-50fb9748032mr63849011cf.32.1776828893378; 
 Tue, 21 Apr 2026 20:34:53 -0700 (PDT)
X-Received: by 2002:ac8:7f41:0:b0:50f:b974:7ef5 with SMTP id
 d75a77b69052e-50fb9748032mr63848741cf.32.1776828892775; 
 Tue, 21 Apr 2026 20:34:52 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187e7a3fsm4076260e87.59.2026.04.21.20.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 20:34:50 -0700 (PDT)
Date: Wed, 22 Apr 2026 06:34:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/13] drm/msm/registers: Add perfcntr json
Message-ID: <2hffq4vggj7udmaxiiqpkrx2dmik2eopscwnh7cztfw77umioj@lvxpatbxwsrv>
References: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
 <20260420222621.417276-5-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420222621.417276-5-robin.clark@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=CNUamxrD c=1 sm=1 tr=0 ts=69e841de cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=e5mUnYsNAAAA:8
 a=EUspDBNiAAAA:8 a=rwQr2M8RuynTKpNwVosA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: PYWyrEGrZmT2iDSllMN64_JQQYGHcdJE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDAzMyBTYWx0ZWRfX75vp56tWz0zf
 Wz5WGhX5PIdZgL8ZYHsyit6TBBjmPPQzgW1M9ZTX1cY0BIf2FY4bLVM5UcsN6nTJu2GMOO8ci9i
 mE0rJy9sRnUfFFuPzuw4JWqMPHFcMKLMl0nf4gA7uUp1cpicCm6toHXB+hNAJPBgBGp2JhCXjEB
 ew7wxvTkLFwvQYcHG7iMI7rS7KQQ3/3wSFS7qr3ab18rAkpNIiPytN4ht04UwQSZdkxA5uCzRP1
 q10/D6OfIU6+eS5fDlGdWFVTnOd+u8A845UH/r/TUHTnU78BK76AnzdTIDySHbpNFzWMynpyIAJ
 5Z/RlX8VfDlA2K2cbG7MYhQgJ+oUIWA28AzJptWQDttmVfNZKCggH/pc9gez8XJYUHLQ/tWXGGK
 oM2xWoLFjSOjsCPtqQHrmydmhCUFlbiWjYZD77TNFkJBpC1+/p0AvU/KBJp4wSz7r/UQYg02EjY
 8nx0btwtC991WfHcKWg==
X-Proofpoint-ORIG-GUID: PYWyrEGrZmT2iDSllMN64_JQQYGHcdJE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220033
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

On Mon, Apr 20, 2026 at 03:25:26PM -0700, Rob Clark wrote:
> Pull in perfcntr json and wire up generation of perfcntr tables.
> 
> Sync from https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40522
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/Makefile                  |  17 ++
>  .../msm/registers/adreno/a6xx_perfcntrs.json  | 105 ++++++++
>  .../msm/registers/adreno/a7xx_perfcntrs.json  | 228 +++++++++++++++++
>  .../msm/registers/adreno/a8xx_perfcntrs.json  | 240 ++++++++++++++++++
>  4 files changed, 590 insertions(+)
>  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a6xx_perfcntrs.json
>  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a7xx_perfcntrs.json
>  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a8xx_perfcntrs.json
> 
> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index ce00cfb0a875..55388544de9f 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -176,6 +176,11 @@ quiet_cmd_headergen = GENHDR  $@
>        cmd_headergen = mkdir -p $(obj)/generated && $(PYTHON3) $(src)/registers/gen_header.py \
>  		      $(headergen-opts) --rnn $(src)/registers --xml $< c-defines > $@
>  
> +# TODO how to do this for a2xx/a5xx which have different .xml arg?
> +quiet_cmd_headergen_json = GENHDRJSN  $@
> +      cmd_headergen_json = mkdir -p $(obj)/generated && $(PYTHON3) $(src)/registers/gen_header.py \
> +		      $(headergen-opts) --rnn $(src)/registers --xml $(src)/registers/adreno/a6xx.xml perfcntrs --json $< > $@
> +
>  $(obj)/generated/%.xml.h: $(src)/registers/adreno/%.xml \
>  		$(src)/registers/adreno/adreno_common.xml \
>  		$(src)/registers/adreno/adreno_pm4.xml \
> @@ -192,6 +197,18 @@ $(obj)/generated/%.xml.h: $(src)/registers/display/%.xml \
>  		FORCE
>  	$(call if_changed,headergen)
>  
> +$(obj)/generated/%.json.c: $(src)/registers/adreno/%.json \
> +		$(src)/registers/adreno/a6xx_perfcntrs.json \
> +		$(src)/registers/adreno/a7xx_perfcntrs.json \
> +		$(src)/registers/adreno/a8xx_perfcntrs.json \

The extra .json arguments are unnecessary. Instead there should be a
a6xx.xml as a target prerequisite. Also the .json.c names should be
added to the targets variable, otherwise they will be remade all the
time.

> +		FORCE
> +	$(call if_changed,headergen_json)
> +
> +adreno-y += \
> +	generated/a6xx_perfcntrs.json.o \
> +	generated/a7xx_perfcntrs.json.o \
> +	generated/a8xx_perfcntrs.json.o \
> +
>  ADRENO_HEADERS = \
>  	generated/a2xx.xml.h \
>  	generated/a3xx.xml.h \

Consider applying the following diff on top of your changes. It handles
a2xx and a5xx prefcntrs, all the dependencies, etc. I tried
experimenting a bit, but I think the generated rules is the easiest way
to handle all the requirements in a simplest way without extra
repetitions.

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 6143283d91fd..d405b04fa7b7 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -180,7 +180,7 @@ quiet_cmd_headergen = GENHDR  $@
 # TODO how to do this for a2xx/a5xx which have different .xml arg?
 quiet_cmd_headergen_json = GENHDRJSN  $@
       cmd_headergen_json = mkdir -p $(obj)/generated && $(PYTHON3) $(src)/registers/gen_header.py \
-		      $(headergen-opts) --rnn $(src)/registers --xml $(src)/registers/adreno/a6xx.xml perfcntrs --json $< > $@
+		      $(headergen-opts) --rnn $(src)/registers --xml $(filter %.xml,$^) perfcntrs --json $< > $@
 
 $(obj)/generated/%.xml.h: $(src)/registers/adreno/%.xml \
 		$(src)/registers/adreno/adreno_common.xml \
@@ -198,17 +198,22 @@ $(obj)/generated/%.xml.h: $(src)/registers/display/%.xml \
 		FORCE
 	$(call if_changed,headergen)
 
-$(obj)/generated/%.json.c: $(src)/registers/adreno/%.json \
-		$(src)/registers/adreno/a6xx_perfcntrs.json \
-		$(src)/registers/adreno/a7xx_perfcntrs.json \
-		$(src)/registers/adreno/a8xx_perfcntrs.json \
+ADRENO_PERFCNTRS =
+
+define adreno_perfcntrs
+ADRENO_PERFCNTRS += generated/$(1)_perfcntrs.json.c
+$$(obj)/generated/$(1)_perfcntrs.json.c: $$(src)/registers/adreno/$(1)_perfcntrs.json \
+		$$(src)/registers/adreno/$(2).xml \
 		FORCE
-	$(call if_changed,headergen_json)
+	$$(call if_changed,headergen_json)
+endef
+
+$(eval $(call adreno_perfcntrs,a2xx,a2xx))
+$(eval $(call adreno_perfcntrs,a5xx,a5xx))
+$(eval $(call adreno_perfcntrs,a6xx,a6xx))
+$(eval $(call adreno_perfcntrs,a7xx,a6xx))
+$(eval $(call adreno_perfcntrs,a8xx,a6xx))
 
-adreno-y += \
-	generated/a6xx_perfcntrs.json.o \
-	generated/a7xx_perfcntrs.json.o \
-	generated/a8xx_perfcntrs.json.o \
+adreno-y += $(ADRENO_PERFCNTRS:.c=.o)
 
 ADRENO_HEADERS = \
 	generated/a2xx.xml.h \
@@ -244,4 +249,4 @@ DISPLAY_HEADERS = \
 $(addprefix $(obj)/,$(adreno-y)): $(addprefix $(obj)/,$(ADRENO_HEADERS))
 $(addprefix $(obj)/,$(msm-display-y)): $(addprefix $(obj)/,$(DISPLAY_HEADERS))
 
-targets += $(ADRENO_HEADERS) $(DISPLAY_HEADERS)
+targets += $(ADRENO_HEADERS) $(DISPLAY_HEADERS) $(ADRENO_PERFCNTRS)

-- 
With best wishes
Dmitry
