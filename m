Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92846CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 13:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2F5011214B;
	Fri,  9 Oct 2026 13:23:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZAodCrab";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LaNZchMi";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F0B511214A
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 13:23:57 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699DKZPe1302656
 for <dri-devel@lists.freedesktop.org>; Fri, 9 Oct 2026 13:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=pTb/nAfNcf8kmDxbDKy+Ovtj
 nlCj5G5u+5gd5OlFFHo=; b=ZAodCrabe3fUrhjjoTHdRkIIE87+b2J+h/B6Geh1
 tmMSwvyuWk/IZnKg80VRBHtUP0RGB5IICsSGqhbUNxZCg3meVXqjUv/vyzAuSfen
 qRIwkQLhnCEbkulp70eSu36zEg4UXkthNNn+1HQHbRZirJuWG9zEDQYmXi05uZRW
 yp9125PWxK8dR5KwYaAXqCcdhXaTtZvBipdEdYsaXUNWa6tWu8Vd7b7u/hRS+/iC
 feKdKji/X+1y8JP2m4ZCPQyumYSvSbQYn+I5Pd7M3hPWX8/cQYUplxrgkj1hic1C
 K4lmOk2/oxUB59s7Z+iU/BH4MtqZwZW8eae8MNXySAwVSA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxruu36-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 13:23:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93caf6c528aso1053949785a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791552236; x=1792157036;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pTb/nAfNcf8kmDxbDKy+OvtjnlCj5G5u+5gd5OlFFHo=;
 b=LaNZchMi9QpOrL5ygyYTCApPUkGfhKHnqP/3yTLhe6ZecLb7mctTRuE02Zgco9Pjz0
 HsKHDqi9ltU81N/PYIqvfHKCt+RIU262W1W50EHeZhfXcpVH5vEr9uJ2mrk4D21iqqg3
 cEK+ae2QUBcp9lI30Kf1lsKUAC9AbYpxs3jUHHc6+iUAXKZZVp3trG3SOxN2aOboV1Si
 oB/AXK/CdyziiO5IaI2VWJeccbEJGkUHVvPKczzTa7i5HdKYTyinlUyQtG3YVmLhDa3X
 vQ9LblEIVGHxfC56pwWE91GaU5QcymUN0x3ZLLJeQeN1G9KCdvMBCRYXB97/B1cM7JV3
 RmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791552236; x=1792157036;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pTb/nAfNcf8kmDxbDKy+OvtjnlCj5G5u+5gd5OlFFHo=;
 b=XfG0fzNm4TPjVziV5HnadO+7L1G5vTWKJY13MeO0xaK9qcy5S+97VUP5jD4bhkRf4j
 eW84LbDp+s2iijkr2ARJUFufIbsp6vp1T73t9RaaRyXuFDE6opgpBV2IDux4vMWBYCWi
 W4OdV4F5SrXAM2HZqaNxwmdBfy5cxjZlIwqu97skkBXgHkig3aSqOKiNoWA9+MoyEzfc
 LqH5WQTH8qc2HNWFbc+8KHXW29LQKTP3bDsv6HXXlcJEfnLHwPCK8u/73jCf64vpINkQ
 wqn8TfnHNM2S4DsCqwiyxO09HBKX5lV+odSJgKi9/YaObok7QECKCxAEHQzz/xl+Trbt
 bfdw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8zxT+SNirKRNYOajZA8U6L6hDDJjTvuA+fakHEoWiBDjJJSGHnyU38PXNjpHPrJChhgDg/MV/VB4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m4nIm5ag5lSoEVdePL4YpX80PucOI+LRqtm+hNCOsTHI4Etq9T
 k+ZG3rB3zNTh8HWsB1OpHK86JzPhlHOtXunuF0jsUjjef+KoWNK90cFTEEF1b8f+vtVYYpCjl8Q
 qgvY5EsdcAyxaGInm2Tri52kniih5M3efdYFF3w47mNFzmBrP0sZnXr3FKCBRXGAGZyTUKAQ=
X-Gm-Gg: AYBFou0Z+d35JoBVCzE1BL/RWqso2OrOEnqip/ujamf4TvdbYe44fTAh1gewN6ZsQTg
 oEm0Mp3bEN0srXPzb5r7aVuysJC7WcL9TQ5+99PKOPozKZ3MbOIZKg+AX94NxnqKGapZKf9vkmb
 /X3iMQR8uZIY4Yeox5zs4eASGW9A+PBPz0DLJ35j2c2gAHeVkuRIbbgPMu1caUru9jtvdJGsuiQ
 BaxmhGx/6NWNsbUNrRzu9EyIhx9QBGn7xIwhKE/4fKg/smab8n7V0faJ2c+LBEzRofJ+m3b7cJQ
 HsiexkvkY6L+wLBuHJ71/lIiyUkKuCtCLvrCh8gW1ppVqpGELH/dsM4pbIGhy4FS1/K7W/wj0ZA
 wGDcf1Wp0f7A2XYyhhbZ9N/UDUb4ODht1iIYT7GdGMq1jS8/ObfwCSxPpti8zuTs0fLd+YspLkb
 Ufi98y9IQPUJWH
X-Received: by 2002:a05:620a:4586:b0:93e:7ec0:7c63 with SMTP id
 af79cd13be357-93ebd2751d8mr253001985a.57.1791552235239; 
 Fri, 09 Oct 2026 06:23:55 -0700 (PDT)
X-Received: by 2002:a05:620a:4586:b0:93e:7ec0:7c63 with SMTP id
 af79cd13be357-93ebd2751d8mr252993785a.57.1791552234456; 
 Fri, 09 Oct 2026 06:23:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcddea81e6sm634124e87.46.2026.10.09.06.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 06:23:44 -0700 (PDT)
Date: Fri, 9 Oct 2026 16:23:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Xilin Wu <sophon@radxa.com>, Bjorn Helgaas <bhelgaas@google.com>,
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
 Linus Walleij <linusw@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-gpio@vger.kernel.org, Stephen Chen <stephen@radxa.com>,
 Junhao Xie <bigfoot@radxa.com>, dragon@radxa.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Daniele Briguglio <hello@superkali.me>
Subject: Re: [PATCH v2 3/4] dt-bindings: arm: qcom: document Radxa Dragon Q8B
Message-ID: <kzqftw7lugumzzkafcnsa36n6nix3kmwee66bzlv67aoqrkovc@7lbdhwfchvp3>
References: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
 <20261009-q8b-dts-v2-3-eda11e5dea8b@radxa.com>
 <cd97e6ab-eac0-4482-8b85-455ac8730241@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd97e6ab-eac0-4482-8b85-455ac8730241@kernel.org>
X-Authority-Analysis: v=2.4 cv=E+1YNqdl c=1 sm=1 tr=0 ts=6ac8eaec cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=CDNH-pee2JQSj4idvpEA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: ODJziHPtCgn3MB732H09plUtIKHpYv-M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1MyBTYWx0ZWRfX1E+ooENd66U0
 nG5+X7t/47GS/zp0MQDDjhnruY0u8dVjQkm7Wv6o+ynDwoZTNmVbjV7/xNaJRToeX0BBmJjVOW8
 i9UFFC8iqlPQ7hhRnar97d64Q1bSgzELAbkXEcjINUWTgK6fT/5h3nzITLPJxGRYWMFVpDcs2gE
 +3jUsxhekJ3a6DavC7ZuQi2Eo/jfKZx7MrVLgOcLCYIcGjDfZv6Rojg78Mxe8BsxCJcj3WuTViq
 CnES/Zww6nEmsJklmKcN8gZI6txu1Qk1jkXgRyMT8DwAgjH0Yn+owubbV+gzbaT6OPNKyco2oTo
 ZcSiX1p6LcZPDUAiPqkYhbJugtNM1UtmwpLBUrAv9Hk8qPhw3D8uRlN0Vr+X4jcau9iNquKoAC8
 pf1vlUi0Of/4kAx5k9hdnKQ7f4gfVEMyhpEcenRrhJXOtcpeqYoVrKycyRiApx6eXihqOilS5Qs
 JDkAskEahMW4WPdZe7g==
X-Proofpoint-ORIG-GUID: ODJziHPtCgn3MB732H09plUtIKHpYv-M
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1MyBTYWx0ZWRfX5H0rky/wgd0d
 KEiSInGMuCezc9W263WtDtOBmgukp2ZvTS1OaBS+0vYghI/z5RVI6L8pfh6qBWAE+DJZPA7Dijx
 S36FbzqQ0JGmAlqqq7JD6MFu5DfLERY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090053
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

On Fri, Oct 09, 2026 at 01:42:11PM +0200, Krzysztof Kozlowski wrote:
> On 09/10/2026 09:55, Xilin Wu wrote:
> > The Radxa Dragon Q8B is a single-board computer based on the Qualcomm
> > SC8280XP platform.
> > 
> > Document its radxa,dragon-q8b compatible.
> > 
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > Tested-by: Daniele Briguglio <hello@superkali.me>
> 
> Fake test, drop tag.
> 
> Why is this so problem to provide the tag ONLY to the patches which were
>  actually tested?

Please teach b4 to skip to skip Tested-by on dt-bindings patches (or to
have a flag / config to achieve that). This would solve 80% of these
issues.

-- 
With best wishes
Dmitry
