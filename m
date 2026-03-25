Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D75109C05D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 20:07:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8306810E161;
	Wed, 25 Mar 2026 20:07:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mo/mJRct";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KQw6kmYA";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD8A510E161
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 20:07:01 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PFH9uh3532408
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 20:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=iqqLnvToFpREO2Iofc/xS+E1
 0uwwM50L3x9HSlvOeVg=; b=Mo/mJRctKTzLh5aZSmjbg+V612DJe+GOdPr0732q
 3n28lO1qqal5KCY/5/2/rubx0ueaL0cA2DEakGMMes1+51CCWFwYHfYPvFKtb6mL
 a18plIammyJFL2LpnUJjZKqHdr6FPawa7BKlYnf0bAF25i7Ys50c7FrmKwVDE/L1
 pAldsigQB+GOFgfvXgqsKEiq5aPPgfIz98bpM9Ecy+0kuZce2KHNoD6PH1659VeD
 DqfYHmf7As7/ATFCSSuQGzraXMiNe9N/rHxFA0UNARq++r3L+sjA+sgQA+16KpMT
 xEwCtJMUGCNYA09tf3BCWTD7tsLQj2voTliZWaRk90Q0nA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4dy4j3x7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 20:07:00 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b44f7b7bbso9500611cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 13:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774469220; x=1775074020;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iqqLnvToFpREO2Iofc/xS+E10uwwM50L3x9HSlvOeVg=;
 b=KQw6kmYAWVVKW4RYKMxIOE5k3qL3S8VPhTgGB72Qrb3Eq5qZACPpcsj1w/JKgJqb/F
 4dUE8cFLOevOR4kcw2aqrQTxKGly558UFhiKrlVt/vI6847GGV2EDMAVhZEyHTuEeZtm
 haARmTUJxCwmEnOV5T5FBceDWs7EmnmLI6PeqlhP2zDLcvXQtiyfn1Gp/VJ+b6cmb3f3
 A7m4KhVu3rk+UmL6iKdF8N1batAu88BdGsN/CRwfU++qthZKvayKTlNXDoV9DJFOPzJ4
 SsKa4GEXFsI7rNSbinChuMeX3/KXiBonHchnjp3J77SY/pJcpPO3I1EBg0CfDtoQ4d75
 cHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774469220; x=1775074020;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iqqLnvToFpREO2Iofc/xS+E10uwwM50L3x9HSlvOeVg=;
 b=h5z9X1qhJjUojEO1L5vzSSLeDIxdIaocj5IoVyQADH0xfh+iePK5J6xZAA8Db3B5F3
 tKFwdMJdwluFjQj3oVh20DEwKYPC97Qc7/Cu5foZeTCz4boJTLr+U5OJJr/c8Yss/vSa
 FLDfGfZ0JQdpsEHV6Be6j8PCm0Qcjc1TpwW3oVyGmvgxdHAHKxBIPpvaanm34WsvcJv/
 cXqlOljFEWCIgSb5Q8btRicj+7o6wulWBWmrcgsAG0h8LQaED+lYNAA13Kk7ciS185vE
 GYU1vO146EbrE3o9jQesIVyvYVuk+ZVtreFF2uMkc5ixhrJsnsq/B3wt5SLbLMgvT7xz
 9inw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZaGGGFG1GrB0+6fVMzlX2PBA8euJtnzjaNQ4C+4Dh5sscJ2VTLe1AmaK6EL2lrif/riEyiQ6PO+M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNEl05eKXerJRM+ocWbMF2pwnO1b4Feg1tB32q92aiHgmSxOYc
 b4exQSqlMri9fv08dnf4IFhTRNGBTt9dCKxOJDqMJ0CNh2WpUgQvqYTaLCiWtpGkEeXVRkAXrDp
 KhPPnNDlaZdGaid9L4Vey2oZVTXGxIINDIOk1kAml3JPm/rEKJngQQYe9NP3xxtJ3VaYg4VQ=
X-Gm-Gg: ATEYQzyM6WmSDCcqBJpV1QCtsXEmGlq0/TfrBxrqShhRu6V2oFVyWWxoCxUWlrVQ9Ku
 r65vmFpKj8wAe3bYxm3Ot3vUYRTzZpNzL5ls1UnxtnKFBjsr1ZjRSyI2Pq1Eic7LB+SRH5WzSP5
 pRN50VrNZ97AZfUOrcuDVaz9D9CtvHrGr1s3aFtanD2ZEu+wVScYaA71gAMVf//PSPobB/3YpTz
 dV5Ddd+buthSOU+UadDzU54hu9OF1jmEt7UG77TXxYg5dVBGiBRHGPQlhX6bVa01kw8HY3Spbpx
 r6XTovvrgbfhYdZx/ht4egbw/BVSmcepnN76hagXs+OLVMy9AtUPi80GWYsiNUvHPzwUht4/nhu
 zTWY5CHcrRjY8BQVwwPzWQosU1zcOoiAU0q2SMRmdI3F256ftHkvwZ5/vt1fyUK5lEdprMgrRGa
 7lE+Xk3uEmLKs3lQAGCsZ61O7iScrAERhTkeU=
X-Received: by 2002:a05:622a:1f06:b0:50b:6cc1:38b7 with SMTP id
 d75a77b69052e-50b80ebf459mr65956251cf.58.1774469220107; 
 Wed, 25 Mar 2026 13:07:00 -0700 (PDT)
X-Received: by 2002:a05:622a:1f06:b0:50b:6cc1:38b7 with SMTP id
 d75a77b69052e-50b80ebf459mr65955851cf.58.1774469219478; 
 Wed, 25 Mar 2026 13:06:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2a063eecdsm107879e87.8.2026.03.25.13.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 13:06:58 -0700 (PDT)
Date: Wed, 25 Mar 2026 22:06:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: cristian_ci <cristian_ci@protonmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: display: panel: Add Novatek NT35532
 LCD DSI
Message-ID: <6yrsr3fsmg43xad7oasye4deankykwxef6m33ogypaeykclfyn@ws5gj2zydyyz>
References: <20260321-rimob-new-features-v3-0-d4b8ee867de7@protonmail.com>
 <20260321-rimob-new-features-v3-1-d4b8ee867de7@protonmail.com>
 <sdcfwycey5ykhn2fghun7imx3tjtnwat3ny3mut5dwstl7wvw6@maqrzlycwdn5>
 <GF8zsK-szOM98Ck2jznCOZ4xjuJTl9g1b0uPc1N79Dzf7PNzOiVgewdqPFGjqF3YD7tOUa2tzdc7rG_e7iNH8yjHOJ9DobsihTxRLUk8EL4=@protonmail.com>
 <fh7rfswcwcrquijgjq547b6jjuq2v3wxiweh5xnnd4z5ql5n7r@gt425ujkpctu>
 <E_O40YTvp6FW2yHa_lQOmzZwB1BZ7r_uCfh82T3BeO-SLK255eefzThCZDYJ2PFi3Hlnp3JXL7JWrlIU2ymh7m68wkNMTsM7jcMa8XxuxCs=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E_O40YTvp6FW2yHa_lQOmzZwB1BZ7r_uCfh82T3BeO-SLK255eefzThCZDYJ2PFi3Hlnp3JXL7JWrlIU2ymh7m68wkNMTsM7jcMa8XxuxCs=@protonmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0OCBTYWx0ZWRfX/xZZfve7VqbY
 esXTXap+bD5jBP820s5FF5GqaKmO8ejH56yf1IbkwM6CK61i2t0a1HhH94evqO2NdguKztP4VAW
 yvPzJg3bJFSVorG7+gEHIc5dWLjHPb6EH1ThKJRtriBvgfGAUKcTL3xkJ6rfrxIslvDSSYqr2ie
 d1cgZd4BbLk78D8QZJJh4wSQ1OPVJ1x8aJhKrpdjGi+BzsFAFApBFSBak/bWEUpo6o0wSNgbHJI
 4kC5Q2oV537HRHnk6a9PVUEbfyi75+TdnVOh/5r+6D6sZMxt4pqCNsEljYDsgLVMvw7kJVcd5ik
 H8OunNo6VnS1udIJcODfT36MDowzZMDaothOpq7lsf6U1FF5xjSiPqd7QttMaTnuDoV7QYVx9yU
 ssklPNa7oVt64uEmMBymPnkQLG4Ehppmkcb7CW8bRJVuFdrKInhhPiB5ymU/ypqcecpJUCdI81F
 eXa3d0/VfGx43RT67vQ==
X-Proofpoint-ORIG-GUID: q9aB9O0mp3fukIuakYzeZoGnLnH6oqBA
X-Proofpoint-GUID: q9aB9O0mp3fukIuakYzeZoGnLnH6oqBA
X-Authority-Analysis: v=2.4 cv=eeUwvrEH c=1 sm=1 tr=0 ts=69c44064 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=fnGvSGuzkqCyUKXIORQA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250148
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

On Wed, Mar 25, 2026 at 06:31:47PM +0000, cristian_ci wrote:
> On Tuesday, March 24th, 2026 at 23:20, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> wrote:
> 
> > On Tue, Mar 24, 2026 at 01:10:13PM +0000, cristian_ci wrote:
> > > On Saturday, March 21st, 2026 at 17:46, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > 
> > In the lack of any information, this is probably as good as anything
> > else. Please describe in your commit message that you don't know the
> > exact vendor of the panel (nor the id of the panel). 
> 
> Ok, apart adding a new compatible ("flipkart,rimob-panel-nt35532-cs") to 
> dt-bindings (patch 1/6) - leaving  "novatek,nt35532" as fallback - and 
> setting that to panel node (patch 3/6), I'll have to change (patch 2/6) 
> too, by renaming nt35532_on to rimob_panel_on and so on for nt35532_off, 
> nt35532_mode; by adding a new struct named rimob_panel_desc defining 

struct nt35532_panel_desc

> .mode, .on, .off members and moving .lanes, .format and .mode_flags from 
> nt35532_probe to this new desc specific struct and by adding .data argument 

I'd say, keep it simple. Move just let that struct have .mode and .on. I
think the rest can be generic until somebody needs those.

> to nt35532_of_match. What about the other nt35532 functions (i.e. nt35532_reset)?

You don't need to complicate the driver, keep the reset as is.

-- 
With best wishes
Dmitry
