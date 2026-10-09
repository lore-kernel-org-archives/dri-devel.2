Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB6ECA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 13:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6837112147;
	Fri,  9 Oct 2026 13:21:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="T67QzMw0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GcKnzlPJ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB16A112147
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 13:21:00 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699DKHjZ3024092
 for <dri-devel@lists.freedesktop.org>; Fri, 9 Oct 2026 13:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=4YcAJRG+vmBRk0xarN2r7ef8
 cFkDQcBJMpll1oXOAUs=; b=T67QzMw0FQyLGsTJz7dQho7dDIHV9HEaB4EBDqYf
 a51F6zFkzlh0uiRLYofyJwM5MV0zLu50ZfQw/ptPKGp6oM8MQJi/Pg+HrrE2EjZ6
 wA5LsayQ1tvNIVBgAofgOtbYEKUWxREW3230W/7ayHVl6YaJowDBjOBM9UTNucrq
 idZtlzsYkcIJJ4M3/C98Feq2bjWKzhffG/CKJTQOdfEV4hCJP3SnYdBQOA+NlFNr
 Wk7IzuP65i8AXiUdXP2ljuVr5jLjelfh3dW79AYSxQWYmhRfHwj7YqRUDMD3/Ra1
 7oJkhLxFBOzjKbS8/ae+JDCkDmUK56y4Knk62dY/XjIx/Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxwbpvh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 13:21:00 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-936aa34873bso1309688885a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 06:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791552059; x=1792156859;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4YcAJRG+vmBRk0xarN2r7ef8cFkDQcBJMpll1oXOAUs=;
 b=GcKnzlPJsNk3Mi7xPz9MT8QXOEGIRw0U5jsetATm4SJtwFLEobkkmwVpECFnau1WZQ
 c2qUvcA8aaS9dhsie3lzDEBXKHSJyFd8mJYyrib/MQGA7fS3cUf65p1Tu5wzieIQhASs
 QiYSlsetYfxRsQ7VG1rRr6yc1WgOTNOZEPWlY5U7DFhsnkF5XPtmuQ4u8rpPj/m6D52g
 ehueHxj2sNjX3ypi60CGH1RyZhhqqO/nZ70RoFEMjzTeyBtVZr4Bas+QorM5DPWVTRYO
 6o95E1Peygl9IU+TG82UrVg28yLDJ+U2H/ZzkTuAL12kqXQUhZiR7uQWKUbPo2F6ljC8
 AdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791552059; x=1792156859;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4YcAJRG+vmBRk0xarN2r7ef8cFkDQcBJMpll1oXOAUs=;
 b=dPvexyuLgcF5SUM3kUzlgYjGyz5LMEWebejbv2/XSIhwJsOkoGPIHkN/7WlBZC9adv
 DytqFl70lrkONsLjgl+sqduGmFBPZ6s6teyDRRsI9gvs4er3pVn9fTIh5LQyc5j99Kev
 sRUP0Gj4g9ft9GDkBpy2mYrnO0n6BVlieZKlZTJ/U+r3/pIBvKaQfdfVgbzDPNhaTzHs
 JQdWXdXn0UP/aIKjj04MW8NjjcB+4eAv9aIo3xW2nwO9Da72te28VSwjSQO55vrcVK2g
 M0/s81B5vPYNFOwJZPTgFlfcuOlyz1yrLgenFB4MQ2Yi2hUo8pQmFlP6D85luWRaNPG2
 prag==
X-Forwarded-Encrypted: i=1;
 AKwUvBwtU3egs6N6C0BWSBMxd+H8DEWXK2upzEyov3u9hQk8AxtQjlzFOhVnqZ38rF5IgYQj0RvV1k7D6bs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++khVQ0hFsEH5LGOof/NIKu1HDKM0dLIFdrqQy/ez2pVvdIRI5qe
 UV05b1fYETITTYppfHoJt+TOlQp+cW54AciYVq39H91k0TqKLPZ6dVHTgpQks1+3olEasC+7twU
 LzzNnHKosHYPjmi3G2wBcLHptf4Q9P2nAQ4pNEMW6/8vqiP1szPesJ2p/qeNf4aPa9HQ1I9w=
X-Gm-Gg: AYBFou2nROopue1DGPzU3BRvkyB+FNe4gQdlBe6vfmyRFoHDz813T63+iNSKKNaTCOY
 ulmtbOvUZgzesuqmwYEefZeD0QpYxhFE+aFabwmQ6rbMLhDFvqKrnLNefeBm/BvSpY8Sorluja6
 FD0ny13309k8o9YiqyPkXPyWnNUx+KZds2/N58aKsvKeYEvCgYVOBzNwpBW2IEVrSm4u3JsAp/J
 mDB95fZpm+4nw5qd8JkjRMH/4ns0Kq6duPwi67B9gILU9cP15cNPJLsnL53YUlp3BOoRPDEdEvV
 HrKDFLyOqyLJh+PFeZZ1zDQxdITiR0cMBqgP5zNl5kxrd8pQ7P7FsY2jhjrVDB/Cmjf3Vuqiv6i
 wQ1Aa/gBeageaXQV2LkAgIO4kCuV4p51aOpA3W6lUyTcB1zWq3kjjLWnwPXzbH2/IrQv4Qi9n04
 AWRWFKgjhCWRCZ
X-Received: by 2002:a05:620a:6489:b0:939:3885:3131 with SMTP id
 af79cd13be357-93ebd0c2fc7mr254210485a.3.1791552059331; 
 Fri, 09 Oct 2026 06:20:59 -0700 (PDT)
X-Received: by 2002:a05:620a:6489:b0:939:3885:3131 with SMTP id
 af79cd13be357-93ebd0c2fc7mr254202885a.3.1791552058789; 
 Fri, 09 Oct 2026 06:20:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9c3befae8sm6442831fa.4.2026.10.09.06.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 06:20:57 -0700 (PDT)
Date: Fri, 9 Oct 2026 16:20:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Xilin Wu <sophon@radxa.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>,
 dragon@radxa.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Daniele Briguglio <hello@superkali.me>
Subject: Re: (subset) [PATCH v2 0/4] arm64: dts: qcom: Add support for Radxa
 Dragon Q8B
Message-ID: <zzl3xo6njlmuujbscy3djy37vwbs46uzborf7zpziwfegkgdy5@x5jybhyqpwny>
References: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
 <179153455955.2970577.14103639336377928226.b4-ty@b4>
 <b8cc8683-d114-48c8-af60-ecd8e16bdf46@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8cc8683-d114-48c8-af60-ecd8e16bdf46@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1MyBTYWx0ZWRfX68wC1tx8D2rt
 RHlAtDd4vFpE6jd2n3KL8P3ZcpYfatZrxBmUg7p5PIWRGfzXWndlGSzoQM0VdyieR8jMnGH6GNr
 FQTFWRl9GNIFMaHc25mVNoLCcsf313WPVvoEoGDQtagj9Y7m7XReVIgixoL4jH+VRaZP7uMJ5PK
 TsxmObhu3IME330IQwy9chbQz5w7E9IrcxSwjNC1Uj60UGJrgs9nTNiBmMmpTcsZDKy4SAeN1AV
 00TVuf2Fle9fS+jxbYocBCT9UUSrO0Gij7rPJGP+Ix0CzBBPu0Yx1AEmkMT7GOaa5jb6pBJ9/xX
 mYn8K5qGkIE8SWrrHq/kw0HzXvWO/lh+2Di936Pxnr7jtiX+YdVUmXZ3bN7/ZgWTgNJZ0arF3x9
 sSZ4sh4lGyVHtjhY+qj7UWIX8ZXVU2533FIpx8zxqXO9F7PENE2aSjvKqZQA7/ffszVvJiX8db7
 7LqG0a4moCl2t3sRopw==
X-Proofpoint-GUID: STrWTSvkycSuIRm59QnCrkTWj4kFcukx
X-Authority-Analysis: v=2.4 cv=cMB1IVeN c=1 sm=1 tr=0 ts=6ac8ea3c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=WytUIncG4urx4L10ewwA:9
 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1MyBTYWx0ZWRfX6g7oZTt+j4Lf
 ADGxEBVXHsnwoWO5Nk/q/kw0l+r2sONZ/pZjC6LX73L/Czx2xb9zoImdSZtNGOVwVon2qseVZ+e
 noFiB24x/vzXSqOzQoq2xDjcawm4EJU=
X-Proofpoint-ORIG-GUID: STrWTSvkycSuIRm59QnCrkTWj4kFcukx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090053
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

On Fri, Oct 09, 2026 at 01:43:09PM +0200, Krzysztof Kozlowski wrote:
> On 09/10/2026 10:29, Dmitry Baryshkov wrote:
> > On Fri, 09 Oct 2026 15:55:05 +0800, Xilin Wu wrote:
> >> The Radxa Dragon Q8B is a single-board computer based on the Qualcomm
> >> Snapdragon 8cx Gen 3 (SC8280XP) platform.
> >>
> >> The board provides UFS and microSD storage, two M.2 M-key slots, an M.2
> >> E-key slot, a QPS615/TC9563 PCIe switch, USB Type-C ports with DisplayPort
> >> alternate mode, USB Type-A ports, HDMI 2.1 output, headset audio and
> >> a 40-pin expansion header.
> >>
> >> [...]
> > 
> > Applied to drm-misc-next, thanks!
> > 
> > [1/4] dt-bindings: display: bridge: simple: document Chrontel CH7218A
> >       commit: 377682cf917027396211426c509cae5785305ba8
> 
> So the fake tag gets applied. Having 12 minutes to respond to this
> posting is NOT enough.

It had your a-b.


-- 
With best wishes
Dmitry
