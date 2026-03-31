Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D82109B492
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 15:44:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 746FE10EB77;
	Tue, 31 Mar 2026 15:44:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fyw1gg6T";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C1DfrJBa";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC72F10EB77
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 15:44:45 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62VESYi1332256
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 15:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=6TAf7nEBKKkrb6urwtK+2WvS
 R6mnnMsyYenmFBA8pss=; b=Fyw1gg6TkUdSA8BJP93PR/LKuBvTeNeDCf3r8ygR
 YjOeDevTbWh9g+LP3pWOHl1/wPr0Rc3Ub3oTLNzMpvsuP+WaWSJAg/D3Cm81ZH8w
 qobvJM4zHAyjucIhXx6+4l+sduvt+QRyZGHV25+hDgDamj8ZEeeeuykHreizT0Kc
 tGQZGRMWPgg3rKrS5GgMcIAp7Y0pKrKuwB9jw5LyHgrBjLHdOs94DOIYS0mzF8B5
 HlB5GK7l6WPr+hpUiBtE4upJFDYRvfecByuZnbgYRPZdT7LEnAF/nkF0Z+d1rdLS
 A9cc3tP/FKPk7QLwpmvDSOkDi3fkRMlD6R4/sIC35Y+RYg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8g2arc8w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 15:44:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b781542c1so140830711cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 08:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774971884; x=1775576684;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6TAf7nEBKKkrb6urwtK+2WvSR6mnnMsyYenmFBA8pss=;
 b=C1DfrJBa7yWKJic92ike9aQf5PLGSUM1CkiIKM42iKOetwCa+c/apPU0GiteCeA4OU
 3CBGV83fKRhcJvILN/kjxwdyKaewZOzQ6JvVMNGdw9uPQTJ9ZCjsqPbnm3gzUrfrlaN3
 4XGxegWweJOtSqYv7j/W1TcgW8Ece5pS8vrtU3rOIBdW/FLUoBS5+utftuky1rCks1ub
 oG+5EXDpStharg3Qn+nYSw/Q0Sq8nqy0q0CD4hodzIdvFNdA/MSc0zOQ3W8ijxpI1EmY
 eU5CfMbuIIPWrwaig2NoWO0svXbP2rqnHY7cWQNotO9Bnonl6m6EAEu/0bG95BahAU7w
 fCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774971884; x=1775576684;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6TAf7nEBKKkrb6urwtK+2WvSR6mnnMsyYenmFBA8pss=;
 b=a9fFQVuyQRdGEgindA4TgzQnyGmf4nwfR9wx2qdc58/CCE2rZ3PBfDVdQOQ2bwRPFU
 BV/I4bwuNZ11sM1obAtiSEkfGY5CD5WghqEQ6PEiGs242k1AxEGZr04ygvM3yLSkaHP8
 Q3/ZikYpBxZr2VcxEqXQNe//YyLB006POYUdGg9yPyIuYlQvgOJ7B2i93xtATjAwcHnk
 /fJDwvrz1DcIFvsvSbEJOGLI7RY9X2R0uXK1n/pIGnbXq+dcYg7P7+mGZCjoaGrOCkji
 9kVRHL8nU5XTH9wHVFeNSSflHSgxzcl9NDFaPtwHvHd6kD2vy/b0lx3hSvRP6P1Ns5L/
 sXZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLVr2gJJCPMBphE2yjUrYVbLZqFu6PGZfFt5DDWKko5rvBXe3gS4XwLFIPGQi95Q9CbXSGYMtc6vE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzx5k77CKZxSepfV1yTZ+1ylkx5P7fomflek24qZXOsqoq63Ysd
 Mr9aEicm94KwuGda/DbVif9TaZFuTgDNtXkVaRqPkT8Ul7w/L94gz46LEBAkfk2CaJV6/aAIkC5
 y30VOJ9BQxcDjVBRE98u6Tej7Rwt1W94E193ubAF/YNcvJLt4DINA2XkvYCzy8TXryGeISbo=
X-Gm-Gg: ATEYQzzexQyrbi+StwEhv63UkYtwcOTqHWI1VNe3Ej1WCMHEGauw/KYF2d7Miz9DPw2
 uRmP240dq6fxbTIV/q5FgdXo0aIYjzj1mFRKU1TBrQYf2Qcz90h30wwfn6zdzQJAAWWidOAkPOl
 gOHqENZ7tTCaNnSbIqeYnd19jxDLp0gz40UdcGkYT1DhOW50T8mQM4SEt5lJmKAWRfdGfzTO5R9
 mSUIcOznFU2YtoEuPntL1atglEzJ+IjHwtkTCUdIVxCmjGh1RQ84plon5iMF1R4lRz1Zrq+KdH+
 EImvbsiMrHpEAmlJCiTzNtziBRMojwChlIHQDgiiB0w1BPvwK5Yy/uGyD4Utumrlpf6FlBmpPjU
 3lZKIDg0Myxs1nU1uWjQibit19CzHhgtg+CZ4DkZk8D5I4OHOUnjUDP1SpJa0hJZBkvQIV1n552
 /t7ip0Bkto8328+/J9KK7hUlrHw12if3t0sW8=
X-Received: by 2002:a05:622a:2443:b0:50b:4b81:e376 with SMTP id
 d75a77b69052e-50ba38b2183mr217156061cf.42.1774971884375; 
 Tue, 31 Mar 2026 08:44:44 -0700 (PDT)
X-Received: by 2002:a05:622a:2443:b0:50b:4b81:e376 with SMTP id
 d75a77b69052e-50ba38b2183mr217155421cf.42.1774971883843; 
 Tue, 31 Mar 2026 08:44:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c8389524esm21709301fa.21.2026.03.31.08.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 08:44:42 -0700 (PDT)
Date: Tue, 31 Mar 2026 18:44:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, Joseph Guo <qijian.guo@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: display: waveshare,dsp2dpi: describe
 DSI2LVDS setup
Message-ID: <ffnfk5styiydummm5pb2psvojoucrfn43k5f6d37hnbhyus7k5@3blckxmwunbq>
References: <20260330-ws-lcd-v1-0-309834a435c0@oss.qualcomm.com>
 <20260330-ws-lcd-v1-1-309834a435c0@oss.qualcomm.com>
 <20260331-roaring-carrot-stork-edaef8@quoll>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331-roaring-carrot-stork-edaef8@quoll>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE1MSBTYWx0ZWRfX783onrL7XmOy
 cj1djj9QM+ONgRPJs3Jg62j4or6zbsKpH1h25jp6qhE2P6jutm4ILR6mvzRcOEX/Q1M2Zh7MeAV
 P1DhR0hI+eUfVJRRjB6Skwtbc/fGnSwI97M7RRW8qLUAurWqCpbJXEwIUgbS8gabbIdMI25UTpE
 3Q/WvT5jmhWJ4ZGZluAa2kbWdnZV/+bzOYTS205bfoquzZv9v80EvkJg6sbZPI3nrGvNi/lMFmm
 W1p9rXr2/TcFs7TsdBbY2Po1mMMGjpoUo35U3WsHwSYCOAYInHO/g48djjHnQnU4L8Ws2YGU6EF
 qpAcP2aj/UE1F6hY0Z43mXqV3VBLpDs+PjBDR8pmUacNbtpmNmHG96MuJAUw9f6Iv5OW4nZGVcv
 cowvbBiMOIp2RloP2vR2ufwVzDcRJFik6vFgnyJTsNXla2NXwXaISRoWC2LIL0vcr/MZxwVq/tn
 nfzNvWV/oLzW3QN5xUg==
X-Authority-Analysis: v=2.4 cv=G4ER0tk5 c=1 sm=1 tr=0 ts=69cbebed cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=DPn2wOqBzvvA9j5Ou-wA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: u7dpouh2IckDzp32f-rbKAJ_QuhIBtJz
X-Proofpoint-ORIG-GUID: u7dpouh2IckDzp32f-rbKAJ_QuhIBtJz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310151
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

On Tue, Mar 31, 2026 at 10:40:12AM +0200, Krzysztof Kozlowski wrote:
> On Mon, Mar 30, 2026 at 04:25:50PM +0300, Dmitry Baryshkov wrote:
> > Several the Waveshare DSI LCD panel kits use DSI2LVDS ICN6202 bridge
> 
> If you know the hardware bridge used, should not it be the front
> compatible (with waveshare,dsi2lvds fallback)? Or even alone? Can the
> waveshare kits come with different bridges? I guess yes, they could.

After additional thought (and an email to Marek): the actual ICN bridge
chip is an integrated entity. It is not (and it should not) be
programmed by the host. The kit handles it internally. As such, I don't
think we should be a part of the DT.

-- 
With best wishes
Dmitry
