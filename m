Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E513ECC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2180910EA55;
	Wed, 14 Oct 2026 01:28:42 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85B8210EA55
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 01:28:30 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DHQNQ71592103
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 01:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=rgFtdCHlFEmrliTYjBmLINo3
 xN9OuOGBDuGALfW3hI4=; b=XNWQclOVBusiQovhlnn14imiJCnV2m3g8y7uzv2X
 /X70p8bmyAIX5mZzx3ZdJvXSFRRcyEVl1t/LZ2cW906pSgsCefHcw+TeXToaKtAv
 1pIVXMqZVQX1/bGKmgPt+8NVRuMdAnHg2BFpHlciV6/ZMXzCCSijvizCNbpZ+uGE
 Cgj0ae/hkCOI6Jrxbst5enyJDk6otADWmHpf0csA4X+DqckkDZBbZFo8lYMeKEOH
 qVAEmma3csLl3hRLNy13fyLMgJv9/3Trto0S2zoZzwnG0Wo3NbUlcOpkwD/xoV6y
 5WjFEbcFG7P2gD0OkzClZGrMOUcJhDSeH2RlFNN6f8F8NA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9s1thqw9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 01:28:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93e46b4b700so634791085a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791941308; x=1792546108;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rgFtdCHlFEmrliTYjBmLINo3xN9OuOGBDuGALfW3hI4=;
 b=DoNgbouwATv8/p1eyYxKEDD6VCmag2vwXDllXifocBjMrFwvdNf7HKVUlOf7FQx5I+
 sa+YgWwqLCY2lyL+QuL6yZBc53jKQf71zxjlMJEPrSqyoscErAfYfKsIngPPnvvRl61r
 PzEW19duiWGKfHMeS+OaKbRhYeMwpGAExWysNAZsWGNnTb6edOaZr0FX3G3NZW5Prcs7
 ddUIiR8kzUzZDMGOj2JOY8n78e+2ITx89n1f19UmQwJQx4dZ5k9v+ClsNsTqgRS8FK0J
 +OSMvgDmnC+tqnQ9yin1sYjJxX+/Hg/DN95ESdHEE7u1eRfAST+4o218MBTWErGAhNIJ
 2HRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791941308; x=1792546108;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rgFtdCHlFEmrliTYjBmLINo3xN9OuOGBDuGALfW3hI4=;
 b=mE6p6+2PHFC69MFNVosawBCWtUxDVeafiFDrJWl/rn0FS4tK5w+ddKXT+BqVcgyVbV
 1gzeWgWUYJgG3kxfsDK4H7WBl8IVyxsoXChodeGyaFgVbl2JMtzIlmi6qhFAGWW+css4
 dipie7OzeePprzrGOGwsp09sBW6t7ydTOhl8EIrjAmUCjxs9JlJgsoiNCgfn3UZByZ66
 /MMeni9UM5VKUdZyDQv/QjCrConofy45foRjMdtmU+evgV0F6Wl7cMCtM8qS5FzCwb+U
 V51O01YzOww4x8V5lNmL9fnzQwQImEoHkAQT5vLB+9bsFcrMl51ScaKJX8IDyu91u2+1
 vERQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5SZDV6p0jT8ujtIBhBb92r/TxvQmz32XOegJHg/bWwv4D224+H6+p/KYdCHOEFFayMpjX0ERPVpk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL7YfX2Or6xwh6zlYueJGn6zVYSFo+KG//RbMmbexSZ3/HLG8Dn
 eRAN1UveTNNPS8jgRFifeAuQ/ls6ANiiG7uvdm/YScaa718fTVcS8ffQ31ITFAy/nTrEsaL6HO/
 8Db7Rsg3UBI/17ve36gswKAuvUMvyKwt2pHgczj1vCzMIdMpnfPb9IEFnlZHyZl7Uq/IzQnI=
X-Gm-Gg: AYBFou1ywiLzka/NwOnj+Lz7lpx38uP/uR1TiERY/wN4JxzJF7OfIrT1rUnVeGsLN7n
 fMxpOM4UnqEaESiEnQ43oUvsPyXqxKbiqQZdXMe5/QuCoBgs5NkmUyDUfFF+/P3iU1CAFUhEkDs
 +hSlNjBkR4Mx7bzdadQ20i0YZDsp8WIxhGJqjQ7JepBSDFcvOilFQDHoWdhjnx8boQpIcDQwEA/
 T2Pi+OkZDL9Dz6N6EFoqJWrCWBgnMobgHxrWMW7zXzRv3bDuEIAa+4oFriiMs9ehjWExW03DUHt
 CRZTulC2DsDheakzZgnVO/dF0SkU0nzRl0U2i9NtqFK08chyP1VHoGf5O7UIhsPFF1+8zVd2BwW
 kcIu5JltID3sGrBlxbPI2nWVa/9erB2DiSpNI0otRuomFJJh+v/tsSU2Bbf0VA7REmbbh9eaXKp
 her1rPAy75lWC/
X-Received: by 2002:a05:620a:3187:b0:93e:c12c:9b73 with SMTP id
 af79cd13be357-93ec12c9f14mr2216299685a.78.1791941308317; 
 Tue, 13 Oct 2026 18:28:28 -0700 (PDT)
X-Received: by 2002:a05:620a:3187:b0:93e:c12c:9b73 with SMTP id
 af79cd13be357-93ec12c9f14mr2216295485a.78.1791941307752; 
 Tue, 13 Oct 2026 18:28:27 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9c3c9b104sm42828181fa.11.2026.10.13.18.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 18:28:26 -0700 (PDT)
Date: Wed, 14 Oct 2026 04:28:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Jasper Korten <jja2000@gmail.com>,
 Federico Amedeo Izzo <federico@izzo.pro>, Luca Weiss <luca@lucaweiss.eu>,
 Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: Add Samsung Galaxy Book2 Go
Message-ID: <emdm463llmoi6vsv3zmfjddqrfaf2iubdnydsqye2n6ui56oae@frsvj6el3zvq>
References: <20261012-book2go-v1-0-7188e7ea7a15@fairphone.com>
 <20261012-book2go-v1-3-7188e7ea7a15@fairphone.com>
 <fb634f17-de56-4f43-b139-3d040a35f019@oss.qualcomm.com>
 <DM3MSNLF42BV.1UV490PXB0C07@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3MSNLF42BV.1UV490PXB0C07@fairphone.com>
X-Authority-Analysis: v=2.4 cv=IpOL47/g c=1 sm=1 tr=0 ts=6acedabc cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8
 a=dlmhaOwlAAAA:8 a=6H0WHjuAAAAA:8 a=s7BF4lges1HAnKHfQr0A:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=y4cfut4LVr_MrANMpYTh:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAwNSBTYWx0ZWRfX+1PgO2hPR6gs
 pblZHm2ahyPTbZ0hYmw+aekcPLStvTi8Kumgme8Osbn5S9nK0SfRgRHHNYxJ3xGyTV2vyemrZye
 1esGgPsw5jN+Xy2etx5IshJkiziPqh8U/BeyiG30ER4alye3ipc/CzuUAWOFWYlrzhqM16nIX84
 i2R0Z68zdBXR1PDo4/MJLJKoanIJUKX6qXjyg9sT7e8QrketWe+cG2BVJ/nCtTtFNQ3ZdB+fUwJ
 HU51dFleoMNBT0kspAlVBUZWQUJX11R/IT4YkRv2vS6ilA0Hvbqp9xeyBWmLqVU9TpUptWuTkC6
 qO9x7RIFpNSDi5ywHr5mV2QkMfLUnPnmvzKq5XZygoN+P0++2CxOqACi3g6+sMfMRPilgabDnvc
 7Iz/zblTjkwr8PCayTQ4zj9UlOIIAT2XhAnKqAh867NVxY6XRgw3Ip8k+loTDHeItjxpiaC+VYy
 Na8jgdW03jfDtzAgdNw==
X-Proofpoint-ORIG-GUID: hdjKQsmgGl8YYSxWWL5AGPxuppamjMxX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAwNSBTYWx0ZWRfX9nsL4WyegrvA
 KN2ooo6ZYzwzTG1Sd7YpnfeAMsXTwpGqOBpCFxy2uxtuLgZZjdOyA/KaqyyGQfQbujdp4pDKfxz
 l1mxhbXCO9IAoKr5Q4ZJyY8RDhBT9gU=
X-Proofpoint-GUID: hdjKQsmgGl8YYSxWWL5AGPxuppamjMxX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140005
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

On Tue, Oct 13, 2026 at 12:17:05PM +0200, Luca Weiss wrote:
> On Tue Oct 13, 2026 at 12:10 PM CEST, Konrad Dybcio wrote:
> > On 10/12/26 8:11 PM, Luca Weiss wrote:
> >> From: Jasper Korten <jja2000@gmail.com>
> >
> > [...]
> >
> >> Signed-off-by: Jasper Korten <jja2000@gmail.com>
> >> Co-developed-by: Federico Amedeo Izzo <federico@izzo.pro>
> >> Signed-off-by: Federico Amedeo Izzo <federico@izzo.pro>
> >> Co-developed-by: Luca Weiss <luca@lucaweiss.eu>
> >> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> >> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> >
> > Good to see the Lucas are in agreement ;)
> 
> :)
> 
> >
> > [...]
> >
> >> +&usb_1 {
> >> +	dr_mode = "host";
> >
> > Does OTG not "just work"?
> 
> Is this a feature one would want on a laptop? On a phone for sure, but I
> don't quite see the use case for the laptop to be a peripheral? But I
> didn't try it, the USB basic setup was done by Jasper

Why not? It's more or less the same set of usecases: USB gadget device
(which can be a networking gadget, serial, etc).

> 
> >
> > I'm assuming there's no pmic-glink on this device?
> 
> I'm not quite sure yet how the USB stuff works. For sure from
> observation, USB-C only works when stuff was plugged-in at boot time
> (UEFI?), and charger also only supplies any power (but not actually
> charging) when plugged in at boot time.

This means that something is not 100% correct, for example, missing EC
support.

-- 
With best wishes
Dmitry
