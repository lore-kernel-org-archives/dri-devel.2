Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677EDF3D5FB
	for <dri-devel@archiver.kernel.org>; Sun, 29 Mar 2026 15:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8091410E086;
	Sun, 29 Mar 2026 15:51:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ghppxhz0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GrOBd5aI";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1222510E086
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 15:51:20 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62TAils54088648
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 15:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=+XFKuPsubpCNTnF1xZlcgXY3
 EdV75Y5UQd0HC6KEMlA=; b=Ghppxhz0cewlrm+xU5N73BddzzJzL4zFWUnQgLaZ
 oV6UxWEEcMyQzO3IueRm9Jykw0oT3RhXG2qZR/KJh0naNjrbkV3KmoI4A2/IvzNQ
 RkQtm6dZqEhq7Pd614O2jlBZZtNsGicUYPSXdT2yHUquemPargpJM8cIPxPuRQjA
 ZcnW5QOobeilIxQTpP0Sw0pedHSMP2iaVYhIUeNTf+wlVi5vFOhaM1bINHMZFlKa
 iEocgYF1/ihFECxwyDGhSOb1T9zG+omGxteROAm8kdig6bv4aWquA3Qn6+7dUyp1
 kTeeu8ILtECPH+yf98EkbQnl33dKmvv/oCddauwRZO06lg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d677133we-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 15:51:18 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5094ba09affso108983871cf.2
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 08:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774799478; x=1775404278;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+XFKuPsubpCNTnF1xZlcgXY3EdV75Y5UQd0HC6KEMlA=;
 b=GrOBd5aIyi07vHtiqIr3FSamukbAgD+0iW0wWPJOZKS6yH/T2cyexbNkI6jyJjuWkU
 gxvrKJeYOIFCz2lXoaUNQ0aqnCYSF+KawKyvrG4DikRIZpMBs3Jn9VE534L37uUQZt1I
 X7G95NjtYNs7ihDR6GPP6VV3lMDklPcvy47ZOPyYZZRO4BXdcY0cIYJrTCmKGl3jL+Kk
 SI8GGoB+AeHigT2Xhe2KwEXdyw4RSStzfKKyfDrBS4OWdR7lVeBHwdhPxkk2HioZ/8eX
 aHwpM/eHVjnd4kA8mtwqX2nyDCLh7j5TRNNDCQh5YNpglPoocrmhOYXVEr4NtCdeRAKR
 L4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774799478; x=1775404278;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+XFKuPsubpCNTnF1xZlcgXY3EdV75Y5UQd0HC6KEMlA=;
 b=rvs0z5SRTuQrclQVwGAzensd5j+l3v3wqLrCfqIf8UHwv0C1oc7v00kfdt26I1RGa+
 oXSk3eoGiheIrFz1RdCKFZD2oc7D90j+NMDcndOv8Q3hA35/UYbq93ydxNoMtFe8DNRa
 2evFK8WCyB5lEvTvPRGNB8bBmd7jZ7kgsIiGQuXQ5VIz5fTNZy6AylT/sZGQxE2I4kss
 0TcxutaJP0PIfNRap4t9OhjYXS/XyUlNmqg14Jaoy7oGTXIiGp/2aWrkZv6j5yNn1yGy
 IWMbIZfRuq/3uhpB/zcJwmoL6+AeA4qXR7pioQveMw9bo1/Bjh2nCGcBfEG7fcc+UjRo
 zLKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxRlJZBJWcJX9pTsRnChCS7vWz2ozClyfw0CdOgv2wAGR5qhIBQc0AghPvrhvLIrn9KMLCiufD+q0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZCb5RMso7nFILqAcqopvxAPH+Pc8hZFSVVvy3byfKMJYNI0Ow
 2siZPrqznqzCJKKuQzdfaE++Ny1dvfSOqvNMISS6qnGbvwwS79U9yL0c53aC7S7OP45JB6gZ9BR
 Ho+0CrK0f0v2P8NtJAZh8/QuRItq9ljL8KUOd120eV3tUskZbYsGDGcaHAuj8p1rGCRbDOOk=
X-Gm-Gg: ATEYQzwJlmm4jqUNa/oT/hKBhoJT3Jo6KOlfESVTfHCfUIz6woX5AoNRyVoPgNMYZxE
 R+RFStKMHICzq4ksiSMrD4LopnWkrbR1/ABCcmbxiIxGqiItRuXTL6J0Jz0jS169vEnEjGwmTo4
 g08vugu/Bn01bXmOGsF7HOOl79OkMMToX7WO5Hhdx9bC0eVa2Qs/JBXsoxnK06KBKFJ5Pj17GH3
 Dw+VPX2PEalVKdvLBOMb6aTAMih6rlLVIr7WmXjtfEdlqTDk1dvgdH3dz8L3Ae9HbxOuWLpso0N
 8mlC/Wh0NuWsSSSav2Lc9R6RqW+lCNuMdCVkjcc1BdQvQj/wUhbeKJ5unSaWVYDM4bycJUo7tIh
 NG8zqhWVr1U2optekew4NS2v8jGygG4Ou/DIlndt9JirUPrdG8t/7MT8ZjSGWon8S8n4+s18FFe
 FQdJf6ipyEN3WWk6O/ZTqpIQ2mbDk9xNSWU2E=
X-Received: by 2002:ac8:57d4:0:b0:50b:69c2:b86 with SMTP id
 d75a77b69052e-50ba38b7f26mr125930451cf.27.1774799477708; 
 Sun, 29 Mar 2026 08:51:17 -0700 (PDT)
X-Received: by 2002:ac8:57d4:0:b0:50b:69c2:b86 with SMTP id
 d75a77b69052e-50ba38b7f26mr125930101cf.27.1774799477136; 
 Sun, 29 Mar 2026 08:51:17 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c838b8db8sm9767781fa.29.2026.03.29.08.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 08:51:15 -0700 (PDT)
Date: Sun, 29 Mar 2026 18:51:12 +0300
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
Subject: Re: [PATCH v4 3/6] arm64: dts: qcom: msm8953-flipkart-rimob: Enable
 display and GPU
Message-ID: <s6kyh5wyamcxyd7xsbu5wrrpndpdb5xhxapmxze2qgblng5eiq@hl36nzg2lldg>
References: <20260327-rimob-new-features-v4-0-06edff9c4509@protonmail.com>
 <20260327-rimob-new-features-v4-3-06edff9c4509@protonmail.com>
 <us3ps4bgf5ekk2iudcgs2wa4b5qd4mzokec4q55pmhb6kvt6ht@qm4mmzdai2t2>
 <O7THc5h8ZhgzNpklYKTGOnEZKlN4BtHZHjKZt2KErekNb3E-hizt2dw7xuJ8G6giEyivmvC0f6-eIfCT6fJkUA7_CVQwhAktCXfBqAVV_Zo=@protonmail.com>
 <o2sbqzcix74u46g74sil2c3b6mgd6zsrmafesoqltfbbrzqhjh@uochk3so46yx>
 <VRCUEe2qHZa0a8HzVvhoRtAZyXO8pBU_l96B6U1kL5EFVSJyQBfYeKDvqPit-qpPRtIjUbtl7TH0JegJ7LXvctAxgyo50K6rTC5hwNjuV5k=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VRCUEe2qHZa0a8HzVvhoRtAZyXO8pBU_l96B6U1kL5EFVSJyQBfYeKDvqPit-qpPRtIjUbtl7TH0JegJ7LXvctAxgyo50K6rTC5hwNjuV5k=@protonmail.com>
X-Proofpoint-GUID: XFAyK1RyRwdwxij_1Hxh_DbNljIhxXTv
X-Authority-Analysis: v=2.4 cv=efYwvrEH c=1 sm=1 tr=0 ts=69c94a76 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=sfOm8-O8AAAA:8 a=j0FgyEIfbjhtT0SB758A:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-ORIG-GUID: XFAyK1RyRwdwxij_1Hxh_DbNljIhxXTv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI5MDEyMyBTYWx0ZWRfX3dt8KzgOY4pD
 ZrTmelSbtddZwd+cZ6CPChPkSwXyxcJHF93eBPqthEGkvFoN6g/DzysfvUAk326Gjc4t2Mgwott
 E4paKU77g9vnGVKCxmGp/+w4MBrlK3IoPiXw5/+hWMO7Cm7yduXqwBTAXAjYMZSs/NZABwSCgNe
 UWZBV9fzK2uu4fUU9xsZdUoDJFNVrK4NrHRC57ZM5FzzUim88SdD1cOydIBXzREw665Ffg9n4Mu
 Ok7YShA/cbNcbktQQnTKoNH0GyNSDrd+Wd66O7UV1xP84rvJwEuK4N0wZFcJRnk2haSjWlBiwCv
 DxPHE4IQ5bkZbL5pLbnHQwvIZ73xyHNbJAXV91KVtypxBV6XgvTlu8Dp1CzxRjbl6xHjnuA6f3N
 Z+HdNtFN10eXtW/1KIgw92Nxj/fv3vbCjQfzLRwR73/YbfIuDtfxvxE1ZEE166aMHlzmocH8WJ2
 NDyCYAkwf8rf3qDNbZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_04,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603290123
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

On Sun, Mar 29, 2026 at 03:26:48PM +0000, cristian_ci wrote:
> On Sunday, March 29th, 2026 at 12:12, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> wrote:
> 
> > On Sat, Mar 28, 2026 at 05:30:53PM +0000, cristian_ci wrote:
> > > On Friday, March 27th, 2026 at 23:57, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > >
> > > > On Fri, Mar 27, 2026 at 03:30:49PM +0100, Cristian Cozzolino via B4 Relay wrote:
> > > > > From: Cristian Cozzolino <cristian_ci@protonmail.com>
> > > > >
> > > > > Add the description for the display panel found on this phone.
> > > > > And with this done we can also enable the GPU and set the zap shader
> > > > > firmware path.
> > > > >
> > > > > Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
> > > > > ---
> > > > >  .../arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts | 73 ++++++++++++++++++++++
> > > > >  1 file changed, 73 insertions(+)
> > > > >
> > > >
> > > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > >
> > > I wonder if I should, instead, edit the compatible property by adding a
> > > second string (for the fallback), like this:
> > >
> > > compatible = "flipkart,rimob-panel-nt35532-cs", "novatek,nt35532";
> > >
> > > and, therefore, add "novatek,nt35532" string also to (patch 1/6)'s
> > > bindings example. Let me know what you think.
> > 
> > What would it mean? I think we usually don't include the IC into the
> > compat list for the panel, but feel free to prove me wrong.
> 
> I've noticed use of that in this [1] patch series but I don't know why IC 
> string is used there (in the example) if the specific panel string (the 
> first one) is already defined in the panel driver.
> 
> [1] https://lore.kernel.org/linux-arm-msm/20251001135914.13754-2-caojunjie650@gmail.com/

That's why I wrote "usually". In the end we also have several
(unfortunately) panel devices which use IC for compat string, etc.


-- 
With best wishes
Dmitry
