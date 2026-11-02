Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F5B606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=k95Hx2hD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hDkxn9px
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06D7010EDF0;
	Mon,  2 Nov 2026 13:18:12 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B0FC10E60B
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:18:00 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2DAfxw388987
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 13:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=JXpPTLRqM3tifKOcBlbkpJH/
 GIt4xSQu7xbUIhIeEi0=; b=k95Hx2hDB4ND3nI9Djd9/6fvSIEcALgSrll/6GjS
 unWzwCMxB+dp41/2/iLTuEgCVlhYCUK+DJhmENFLekRC9yT8fWu4QK+k+y03KtPt
 8rertyP9cv83DgLzVnbVFAzUDH39WpdnMmSSmf6xfEg/FNazDVgwXdlkDPcWn0FL
 u3ktz0fxjDpcd1SMibt0vxonB9VcsgOsidSCFKcFjDPnRegrfHnVYsHckTrN4PLT
 WxI8MM5r8m0vk6sJC9pOPjU9z7et2ZKucz2IFEzeqAwnsMQuJSOqAKaNsmVVsioj
 Nuq7Nqn5ZzxBwatjz/p9n2pLpdQJqiaI2xCldWoRRL3LoA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpph198vy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 13:17:59 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7cc099197b9so2491811137.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793625478; x=1794230278;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JXpPTLRqM3tifKOcBlbkpJH/GIt4xSQu7xbUIhIeEi0=;
 b=hDkxn9pxCDF3+WaTrDnwgBOldnHe9wYnFw/pzdPRxvQ7pjPfAJ1ebwTTLY3DgWTVbf
 3vavwqMl3B3XqqZdtfi/FbwP5kY7btJi5CCUxrTWWH4ZW5cymAsHqFYjLbHFdbxWqDEu
 C8jmeJE1FSTCVy1lFGyUZguTs158E+OPfgwdeb5fbdnsqii+/mS4SkY+kTajcU6eRcWF
 d+psUy/+zIj1Po883v7QqvR4+2AeX6SL4T2MK5jjDiCZFkvKwpWhZ8ddPNZ8yHW4VJG0
 tZKn1/WmlSHgdPyWI/uIaaO2VhA7fv20ad7lgVlaExolfeqptJWAtQmLIu7879PDZ7CW
 4UJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793625478; x=1794230278;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JXpPTLRqM3tifKOcBlbkpJH/GIt4xSQu7xbUIhIeEi0=;
 b=mIMvPw0Qp0DiNAmL1ANSX5KgOr1gao3CwCUcGICXRvHj7qC9LVHxveDPYEWJhUqQMi
 Kr7Yz0OuXcnPBlQqa174Ih8LJlAotmwhPCS2pv7PUFWEOYHNENKAG4Bu7a7l//VuoBtZ
 xJC8SnhVhE1FFjtPI2TCt+tS7BtytslXpN2bPgRC3iRl97kGfqKLXQcpXOEEwqdWxLgJ
 OsQ49y17ACaReyVsVoHuwV50OWZ2Y8lM26/o5k6sFYsolPyBiq/n8GZ/HmsxQ0AzT1Ww
 dV/SOo9qjhkmJh2KpsXPZKinEOr3e7qlfiiDa+aktFlDnVKHgFLHD++L6uPkUlxDUOm0
 Rf1w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxkgd3ODEPMtwc0joOEyyVNf8joO8PIXjqBFeehDE8ocy/Kcs0ZBDxdd4gy3DG+8pfyRqr63mxGG/o=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+CvQqT6QOD0f6EEkS0WO8c2aYwmc6j6ygyAjmSGOaWDU2MWWfK
 Y4rcgYQK0VRvWg+21S0IsEIBrov8RsslL9GYlEWO41lea+9wEOqOLcDnb81o4l3v1sQ/lar9YN3
 fhpVxLgL7lTdqnidGnkot3hcZDfsQ6Dof97WMPTzimdhLpIEvTDaNJs3KsjOMzBYeggoBw28=
X-Gm-Gg: AYBFou1sqPjTX9txkcexwcbxgukL8+X89RLnyaWh7HA+IBZol6pq+xD4Y8pIJMqIohz
 eD9lWpMkkiSpzsMFTq2fSS4nZl779arw8U64IbdmLLYomoOSmZR59No+A4aLPpIn8iGBFsW5+eM
 zc3U7E+nLfUOgM5nuGE3yvVRF4uZ5hrsk65xvSLmtY9LsiQI2bpSgm+eNN3uM4hoMGzpDYpZNi5
 RRl2oAfGkMf4PipkzMucksKiVQV9sriq4xaVFBO1S8PhrZNvtap/u9oJL6CEcQWPofXJZB7bdm9
 gLrMi4GtbPtCfN9jVoQeFzjV6kSABmIn4dGuqLLQ6E7nQJQUDjl/rd3cLaB9uLDqbzJmj7tuhZG
 bM1atgQa8qTy5g1gfh3Trz0EL3o8r0iFZEucq186vkkJRhD7ih4QwiZKhhXdXOJU=
X-Received: by 2002:a05:6102:3589:b0:7c3:f36:c7b with SMTP id
 ada2fe7eead31-7d072c2bafemr4799660137.14.1793625478378; 
 Mon, 02 Nov 2026 05:17:58 -0800 (PST)
X-Received: by 2002:a05:6102:3589:b0:7c3:f36:c7b with SMTP id
 ada2fe7eead31-7d072c2bafemr4799643137.14.1793625477637; 
 Mon, 02 Nov 2026 05:17:57 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80333sm21404342f8f.32.2026.11.02.05.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:17:56 -0800 (PST)
Date: Mon, 2 Nov 2026 15:17:55 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Taniya Das <taniya.das@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sm8750: describe all MDSS block
 resets
Message-ID: <buaeo5m3ozihgl5t6767jvu72umwbzqx2debegmzvkuigwwqki@zbtoarlnnihe>
References: <20261102055026.438521-1-xiaqinghuan@mail.ustc.edu.cn>
 <20261102055026.438521-4-xiaqinghuan@mail.ustc.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102055026.438521-4-xiaqinghuan@mail.ustc.edu.cn>
X-Proofpoint-GUID: YezLFeAIzvQlmPTbwh4tpqf6WLZjIJzU
X-Authority-Analysis: v=2.4 cv=IruL47/g c=1 sm=1 tr=0 ts=6ae88d87 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=yBVnyk2oG99e9CeqceQA:9 a=CjuIK1q_8ugA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: YezLFeAIzvQlmPTbwh4tpqf6WLZjIJzU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1MiBTYWx0ZWRfXyJORC0CtiKhY
 rcNRcsCBS0212ATg3VXrxakFAW4Rj11cEdHUUYk9ugdXNqj6Fsp1Jj6uJa+doJt/4MuaCARja7d
 OXa2NBNG4FSJYLqi733jUK/6vhlDsMC9pBP0Ud93KlLj5rf35QOuyZnjmyKDVcndRV3330wjSJy
 2E8IsJxpz6F4xc7yQL06MRkj6In2XwRlGzkBt8l+9wVm3N+IwBjEW0XdSAxjxfz3p0kMzfnHDib
 mcEVVoClm/zs+kzxeJSXPK0PdO/UpS4DtOfAxKoz4ki7IBeOei/Q4EzYP1fMROi2+nQk2EyLG8f
 /OiQ0lIGIkGZxzdPrIEie9NMXaPpr//NN3ux0jdmxmDHXlyvdd1udqSMm6R6MpZgkxOaoBbwXOI
 mRp8TlKxut9qbOhWYPYM5OiUP19R/sHbUoGB0I/qnMvKqqGwANQBGwhz+KQFF2e+vRVtPQv3/7n
 NZO2zNWPH3hPntcyw1Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1MiBTYWx0ZWRfX4T3d4fCgtZIF
 guCAFUtKJY3yJLBeic/BjUUlXFJ4CymZCu1uHPwSM8CXgSRVfY1L7rL9vLr+1yXX/2CkeTqVf1R
 GsFS3PJTUwGDq7tFMk9UyNqApUELFW0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020052
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26-11-02 13:50:26, Qianhui Xu wrote:
> The SM8750 display clock controller provides, beside the MDSS core
> reset, a block reset for the MDSS core INT2 interrupt controller.  On
> devices whose bootloader hands over with the display block still active,
> the kernel so far reset only the MDSS core and left the INT2 block in
> the state left behind by the bootloader; command-mode panel
> initialisation then fails with command DMA timeouts and the display
> comes up as backlight only, without a DRM device.
> 
> Describe both block resets so that the MDSS reset returns the MDSS
> blocks to a known state before any display hardware is programmed.
> 
> Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
