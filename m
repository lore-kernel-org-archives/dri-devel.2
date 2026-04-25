Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41DFFF885C
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 11:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EECE210E420;
	Sat, 25 Apr 2026 11:23:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BQMfRPhJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JuIVPZs7";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BDE610E420
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 11:23:48 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63P3QXtH470391
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 11:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fH7QGZwbDCoLyO1bwt3VrYsmvxr//vAEUJI0SlOWzQU=; b=BQMfRPhJ6Od33set
 Eg/xsxtIu1Nq+/EPAJqY30KFa79LysRlUM3qSMP/ZqD0OuW3gBZk+TeDTwrwkhBD
 T6IjzSGwyRupreTPxrVeKhtvm5wE/TH6YX1vWk1ezY2iiR9yOlenKCqtQysT8sH/
 7YSLYQgsK1ACgEPuOp9qG7hN0lYzDPJCMwKcTGYHrQSyNUTjKExPXYaazh4x0r8V
 n+MtQgFkfBxGhPuPU0G0ry14QOJ3vDhXZK9RTsvKbKC/9s3sinkRfG+CVGmZSWQ2
 np4BY42cA52P4Y0rUOyxPsD4mabwETf2RzU1+IeMVPCLMY4lqJokY2FVJFTesJf0
 mZON5w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnq5rsc2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 11:23:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50e5a336b44so103184321cf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 04:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777116227; x=1777721027;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fH7QGZwbDCoLyO1bwt3VrYsmvxr//vAEUJI0SlOWzQU=;
 b=JuIVPZs7P6AGt1I3jfC+Jc9bk+DIvDbkogDnTCX2JmPewt/NgeY7VJbvNRm/z2sXXi
 ojnJ4PFg4pDdSPj1fkBGH13cCTsJ4QqML9kw6ksrOj8jPgNophcyfSxu6cVZqj+sx/Aj
 pWlJg/YwFyOBeTc4utRucpboMPdJKbojEWZWKnUkHh7j+fMOLoOynkua1dTFcpv6Cdy4
 aRl+YclUwToU0vJzJw7r6CmyH9epakIa67MWBY/TVsVfUBbVo3QX/1Uswx3+4eKm05N2
 INg7A4H4NbabNqoc2T2TsSrDulmIQu+fo2NIJl7j9zj2JHBmqmjaorYr6z6kcP2ccncm
 y/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777116227; x=1777721027;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fH7QGZwbDCoLyO1bwt3VrYsmvxr//vAEUJI0SlOWzQU=;
 b=erBbQTrSkIE52Vvk/dOJCzHMwQdafFAWX3eKtNJLn9kMZrAgr9290zp2cm0qWvFgaR
 ZzxezRzfzDJwiqllkn4dxoS9b9oRWbBX/+PijrRpiZ7kyc1e7jbqEcGRtoYPO7dbXBr4
 CyYclMeGoMuQaVKC7Oa85bfuoaPUR1tyR9hwcT1IAAM+kgNYW4smkHmbmCIA5ZKbPler
 hn1KMkZNV5Y6G4kq2nzNcGC5knYGu/dw8SiKnlvWUkCpNEMzgrnABQqm454UMna3NGek
 9z2GHLwghSZDlb5EmGOYwopc0VatGsvwqOZrDPFyWVs9AXWSdmUJ6xKRpXB7zmyRC7MJ
 Lnuw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9eu8Ur/nbaN8zovls1DDNGyXbbVJpNz1pdGu3CkcO611zQv2Ew0GSuDYgSwSmwjuk3OtE0JUei/XA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyMnflM4wPSiRjFDY+SZtz3uQ6xvNBnOBJ8njJkTa1YWhIi+ruM
 8OzcNg9tFKV5QFFEuC5wM8+a3wZcJszFbGn2Mk56TkjsN/naIuVijpn7lFE/a9rO32rlqep+O21
 k9PnRmISfKSDLA4tnv02FcEe47fWKn8iz1AI9UOGUuzeRadk/eT4NY4CAZbj59Ru7Xazefjw=
X-Gm-Gg: AeBDievGCAD2JDW0TvxHQXpWvJobyUPw16k+ouyPPZeqmxeK9XDRd5pRzpVbWkwQ0dW
 5qDnMv8N0kqVl2hJMBIy10MHIrY1GPZBKJt8U8tRDCHo7blfjfuvWR3epSsUMFCLeGTNQZfGjKP
 GIF40+vhIyCg5fKnDVe9bFLmrH8gon/jjA64T9Wow7TaTFvTNfpU6zmQEFZJxB99XxSybPRq0SM
 j2Pncu37t74LgX9ALBuz6pljL1BKsC7NuHewP3C1L2mrZW5/IZ+h1E+ZskCJFnJVmFAvAmcFhce
 sEnhHfNuolycOCJGK1SGvKpA25ItG8XqSkfJG9gOBInu4GtGaacSJpoO07eC3RT7BgIsWeQxcjf
 uhlm2bCfqlGxt+LMavjiiunmRs7iMLrObpb8fY4EuZPzn1mVaQ5dmpsk/bVk1HR90CTMgJYLIv/
 TSYF6jvz16IGuVhRvGjKeTb1eB6UXOd15IbIdYO2ZE3db8wA==
X-Received: by 2002:ac8:5988:0:b0:50d:9cfd:b01f with SMTP id
 d75a77b69052e-50e367967e3mr442519931cf.32.1777116226895; 
 Sat, 25 Apr 2026 04:23:46 -0700 (PDT)
X-Received: by 2002:ac8:5988:0:b0:50d:9cfd:b01f with SMTP id
 d75a77b69052e-50e367967e3mr442519461cf.32.1777116226424; 
 Sat, 25 Apr 2026 04:23:46 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a41abceab0sm6416323e87.61.2026.04.25.04.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 04:23:44 -0700 (PDT)
Date: Sat, 25 Apr 2026 14:23:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Doug Anderson <dianders@chromium.org>
Cc: Lukas Timmermann <linux@timmermann.space>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Alexandre Marquet <tb@a-marquet.fr>
Subject: Re: [PATCH 2/5] drm/panel-edp: Add support for Samsung
 LTL101DL02-002 panel
Message-ID: <ughwlscd4iksf45rdxwcoavtzpusslu4afphfp5gr5rrrmdtu5@7eu65pg7hp2p>
References: <20260423-manta-display-v1-0-196f80c5673a@timmermann.space>
 <20260423-manta-display-v1-2-196f80c5673a@timmermann.space>
 <CAD=FV=VNvPtG_f1W942SKJfM4ptK8Wvd-nZs4geBCG3bO_A0BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=VNvPtG_f1W942SKJfM4ptK8Wvd-nZs4geBCG3bO_A0BA@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=QNxYgALL c=1 sm=1 tr=0 ts=69eca443 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=bsQV_sbQVq-5e8UBBKAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: FpZBfvVWVw0kDFn4oNQxfPOgUogPpQbE
X-Proofpoint-ORIG-GUID: FpZBfvVWVw0kDFn4oNQxfPOgUogPpQbE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI1MDExMyBTYWx0ZWRfX1W59hTFDqPIv
 /gXT7uTKD7kX3rsABfoT8dfkWOt71cmrFtFz4bLxriRA1UgnWcNqsWTmDAai03QLeC+LmqQ4pux
 trhAfYFUc3fI/TmUNzLhrmpvBt54Tb1LGLoteUDF/Nbg9ZN1lwfvaD0QTF2igbl16jn7oOpRa5K
 qCObfAs+CkYcOMD+EYSD4miesGPWB6soXjCijeKFuKIWUrrPNlx3OarzGd7rTmRJism2VbIOgdx
 dqBhXOUhrraQ+P0eaBbUhaGnL4fxayMwsQ5+gLzkUVRZnUooqwqS15PU/szPtNsuji8hkYRJizW
 sWeuVb3hQDQi0FYT7/1LnOT7Noo6PtxkMYgQae3g21QuUFxCon8T6LyW62xSUOHFq4S0WKrjIeR
 Nlz1MSWEMxiWjYIxwNZVM8+p3U3TB3O/doZ9zuN1bDc5+5lja6Us4PCD68qNwQ19qzIEzz/hpAW
 aLDYlyq1k9gswvUHLLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-25_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604250113
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

On Thu, Apr 23, 2026 at 02:49:53PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Apr 23, 2026 at 2:15 PM Lukas Timmermann <linux@timmermann.space> wrote:
> >
> > From: Alexandre Marquet <tb@a-marquet.fr>
> >
> > Add a panel entry for the Samsung LTL101DL02-002 panel, as found in
> > Samsung Manta (Google Nexus 10).
> >
> > Signed-off-by: Alexandre Marquet <tb@a-marquet.fr>
> > Signed-off-by: Lukas Timmermann <linux@timmermann.space>
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> 
> Adding new panels like this is discouraged these days. Is there a
> reason you can't use the generic "edp-panel" compatible? I know that
> the exynos5 driver is pretty old, but a quick glance shows that it's
> based on the same analogix-dp core that "rockchip,analogix-dp" is, and
> that seems to have support for aux-bus...

I'd also prefer to NAK this change. If the driver can't cope with the
"edp-panel", the driver must be modified rather than pushing more and
more legacy panel compatibile strings.

-- 
With best wishes
Dmitry
