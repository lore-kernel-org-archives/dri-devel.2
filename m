Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7806C88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 406BE10E3F9;
	Tue, 15 Sep 2026 14:33:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EWlxHE6o";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="btmHeH63";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 296DF10E3F9
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 14:33:30 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FD0Yqp3756847
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 14:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=If8WzIzCj6FHW4yPt0p5a8Pe
 wiklLs1ePVK8V2FeYF4=; b=EWlxHE6oZza4mxhEoziyf2ukQBFOoCLk7PWGfJ2+
 vLrYo8D1Z/lPwqjw4tVyBGdi5xj5GXgqv3mjPzU+GwmA74N5RSf3WnzkQPmtPOLs
 Afwks/PWGEibT/Gs9HE85NOI5XtPnUGJhFQXJwqiC/0R+v3imDlUpP29+RhsKl4N
 L/+jeqQ3OtCpsx+9Y/8ljqqMQEzXJNYwIMCGNf+j28o1QJZYEmp0am/j1/JHDZk/
 GEXclQ9utwXbr+BBpft+znME2At7txu5DLKE+laUWF2RpH+RymlcFsZUYJLdWPUv
 2F62taLANFIIJWdbg1eZcpiNfoU+4bfM6Jtf/qFMvADUpw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq38e1d5r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 14:33:28 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-381250979d5so5170764a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 07:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789482807; x=1790087607;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=If8WzIzCj6FHW4yPt0p5a8PewiklLs1ePVK8V2FeYF4=;
 b=btmHeH63zZ+e4dYTB3SkIZvNaBGWeOEoJ+FF4Ig68mX3X2wCPKpXJdixJaFbGqQJg/
 b8U+JxIUjHON4Y/2uAfjLLmzXhZfIuw110UgwceWl2YR9LgSZCSEO7ZFfA5PGszdBjV1
 WAymvSHQ/Ow3Fer+sEJlPhNV04pDDPDeD2UrxCWSBKffU9OLRhlOo3wcJMJf7FoGd00m
 +wDWeaCaQ67dPgUm29lG0Anvm9qsFfbR4JefxCP9leOlGgZeIAsIfd+VZxnijcxQe8gb
 B6swZSo0xK+1IdEePzPddSLgS7JF5dLsOwHvEWoyn1vsUnI1higw6I3Q9xF5lATuZe42
 y/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789482807; x=1790087607;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=If8WzIzCj6FHW4yPt0p5a8PewiklLs1ePVK8V2FeYF4=;
 b=idoMX4obuLnqhztipeDScAywPkNSx+b5QRmNrgz3zAg4v+d5RjX6+CXoa76T7vKnPU
 A12WgcZ/ZJOzL0noMItFfRbHSkixUlMMC83qVcr7nL4g70QkYKJNdhEZRa7unEfa99bl
 6N6QVr7Y3sUy2YOEqGiTurtW7lg5xkCq77zgY37z6uj7GWKNVRNO9oEnPg2yXCAmFwGF
 LQmGwFFlYp98GbwOoPZ5LulkfdU+9Webypr8iOWA1qT3L+94/nTDyanhjVoqINg7Ibhe
 ZmWZJmbqbLI8yoSF4/PEF6J9NNRczwo+DT7gGwGVFYHpEvgh5bllnxQhvFHSwYdnKTp3
 5Hxg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzid30UdeEWYgXfCzVSAsl04iNuN10+U9HS8J02FOksoF5Ba5JjamZzBTkf4n8mgLrzVIG4W7L+w64=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mt4mPZAi3XkpH986zXUAW30O6y5u9qGOZrS1ckvkB18sM8zo64
 IfEz0cenvTOpcV7m4dXNmcro87F+ZCVbVk5vHKeoZ2PlKr20lAWQYuCwH0sNBWSH6wnny8ilLXX
 ettX4UnrVRn5icx92ejFgut6BBE535pSsFMiABU0Ee9ZhcgwD4Yc3MjdbReF30swsZRhv44w=
X-Gm-Gg: AYBFou1FICA8WRMfNaSh/JNpuWHigYRJ7ojY9efqANWECpTMTRErb86+UgWdX0SulXv
 9EjKKWYPnzUzxiIqHYsc3LNECfeQRMy7dakhhTRIeVfSaepSycHrHl+GuAYa+Cp7vupxK0f/run
 z81HUfnyz/I8VVAr1Wzxhxr2Bja7FiDiNnce6y76p+OpSjsSVHDokqRU5tn4E6hGLNGXtneUsP8
 4N03D0OQlz8fi2ktegMBMb3jpRJAM6W84m3+ghaO845dlQXssGwRuh7x+SL/SBh4IupO4BUajkC
 kD0ljehR9/7XNKZkeFNHMQ2sglmcLpw1ASIBt/JvvI0tfnjFM3riW1Z7ebI4Cn9CivTW+h1vl1/
 pQow332Pmrh4CS/M2x7d5r3AtBA==
X-Received: by 2002:a17:90b:1811:b0:39d:8794:5564 with SMTP id
 98e67ed59e1d1-39e10fbaf78mr2137386a91.12.1789482807462; 
 Tue, 15 Sep 2026 07:33:27 -0700 (PDT)
X-Received: by 2002:a17:90b:1811:b0:39d:8794:5564 with SMTP id
 98e67ed59e1d1-39e10fbaf78mr2137316a91.12.1789482806918; 
 Tue, 15 Sep 2026 07:33:26 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdb3045bsm6690697a91.17.2026.09.15.07.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 07:33:26 -0700 (PDT)
Date: Tue, 15 Sep 2026 20:03:16 +0530
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Sunyun Yang <syyang@lontium.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v15 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
Message-ID: <aqlXLJt5GGbRg8xk@hu-mdsor-hyd.qualcomm.com>
References: <20260915-lt9611c-v7-v15-0-88f9e9387eab@oss.qualcomm.com>
 <20260915-lt9611c-v7-v15-2-88f9e9387eab@oss.qualcomm.com>
 <DLFWR377PSNH.3253TRHVTTGMQ@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLFWR377PSNH.3253TRHVTTGMQ@bootlin.com>
X-Proofpoint-GUID: buXFGWXQQnymtdzSvag4A1xKfI009Ysq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIxMSBTYWx0ZWRfX2rEasu9ssRyx
 1shSutujwZo1Pd2udu0lz4RpDvGJtQk4xWetUUWwLgjPmMdqXEqS99CDdVRAnn6axN+3vtDxC+O
 VZTISMHSYkmKX3JMo9/84FRkDq2Kwd0=
X-Proofpoint-ORIG-GUID: buXFGWXQQnymtdzSvag4A1xKfI009Ysq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIxMSBTYWx0ZWRfX6RsSwq+Oye7i
 DaQdecxFwklaSYw3UnkXTgRQybzt6KzhAUm2vsXXtHRNLrV3yll3kRcojs6N6cJ7nkYGnyHBy1L
 prdzJQpg7YpUWhnsqLWupknDlLYA9uWC61LIBSMgs5spfYCBN3VyQmmXZkajZ0onTLCg4H4ZxhQ
 Y9NjIlvo6l/QbcMSzMVokF2JiiwC9F+4JeBxeUbWckIz75F6P33bmjJdtB0/X/DEqTobIJy2XGH
 ExgTFLVMUfnXIEcw+oNxlGrgeKH6QpCZyJ62qlG204FQiBxAgXFtAhumb2Y/AWkLRW/Ovkktytj
 Nga6ZcaWwS07//kOIG1SkhAZF1AMc/uN+IrgBl/j3VagbqiMcZFBuEiULG7p9lyKzTbvPKtSRfO
 bG62qz5kWDCftDtd71TtEJMfKZ9l8cwo930fh6Hu8FCdgaU8fKic8LJb6gpCqVsKCdtDs2pCpv9
 nPlwnXm0jxKB2kbGaPA==
X-Authority-Analysis: v=2.4 cv=BswIUoX5 c=1 sm=1 tr=0 ts=6aa95738 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=P-IC7800AAAA:8 a=Kz8-B0t5AAAA:8 a=EUspDBNiAAAA:8 a=Tr7HC1OQeac_aXw3zzUA:9
 a=CjuIK1q_8ugA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150211
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

On Tue, Sep 15, 2026 at 03:01:14PM +0200, Luca Ceresoli wrote:
> Hello Mohit,
> 
> On Tue Sep 15, 2026 at 2:33 PM CEST, mohit.dsor wrote:
> > From: Sunyun Yang <syyang@lontium.com>
> >
> > LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual port
> > mipi dsi and output hdmi, differences in hardware features:
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> You are carrying this Reviewed-by Dmitry since v11, but the patch has
> changed a lot since then. You should drop that R-by line, unless you got an
> explicit consent to keeping it for specific agreed changes.
Ok I will drop it and send next version. Can you please review it.
Thanks.

> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
