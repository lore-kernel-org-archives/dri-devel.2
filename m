Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29978109B48F
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 15:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FBC810E964;
	Tue, 31 Mar 2026 15:36:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="owN0pGh+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DGGKXeQO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4C8510E920
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 15:36:23 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62VCNH9U2164532
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 15:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Db/vFpaBzmlgTloXuvSM0YLf
 Oqas6qh0AtMWuHO6rHQ=; b=owN0pGh+ho9eP7hV4ZgoRb55vFMRm58Tfs22sHPz
 w0MNLBmdcGkMPmZ508AAV8WcMLCzVNuQkH9giXFzEtMrIV+MXV+gpa+Qtvk7OmLh
 BNWW9qzc9RcTFH13jO1xXK8/uSvuA6przpKqSO/xQt3fIdZ7/dg1c00IXfOr8RNW
 hadASL+Ox7aud1IeYe7WM4s7cTBWm2WsSyQVsUib2cagkoFWVF+sW4rUCd6CV6mk
 Bbx3Ao6wNJo7b+TX0851jQw+BQLBGl2sEep7TzWzDHoWPqrZcV+mK6OTqVaoVImH
 +YELMMhHOoi6bPjlVgoM9MCVyDRXbM2IeRaAaYwsd++y9Q==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d89ga2aqc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 15:36:23 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-604eba0f2f8so1622855137.3
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 08:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774971382; x=1775576182;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Db/vFpaBzmlgTloXuvSM0YLfOqas6qh0AtMWuHO6rHQ=;
 b=DGGKXeQOfj98RIOEsEc6lHl3O0V/kXQQZs/TiJaVBmhzRBtekl/568004CNmFMHP+d
 3brmWcseCxjdYBB9ovFU/zhGJrb8kRY3vy0OOjCBxycsjMUhHlWWAGCA8QeIGMfC/y7P
 Q0FU4/SGT2KJYpHk4LyaTVgIyjexZXWY4w6DdxJWu23Flq0We1IjDLFSfzy5t8kw3pPI
 7SBUiYjAE4BWu8kjF+cv0qR7RahQTpYQXUaxb/TWGtcSWw87EvQ6DkE0hKwxjGxqvn9Y
 0Y3Tqsbpqt2WvlQaUleRWgxXacZQ7IhS9OV1T+NzzG7f5kT2oc9g4Xm9tcVW+lSiQee8
 K7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774971382; x=1775576182;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Db/vFpaBzmlgTloXuvSM0YLfOqas6qh0AtMWuHO6rHQ=;
 b=lU7xJX2sRCnxcV/CVx3DzzR60IZ67ZIO3U0PiV1tKFT8YvS/BZIVJ3ub1nsgYbGKSl
 SJMNFa2BCsayL6/rJbMKpAf77hHouwDUXGlfsR2X9Almp4MZDmN6VTm7L6ggw6aryCGg
 heyKbWOYzGXaL91kVcyLLE0k6Mus13fSytYOHztMyB/ePUvtJzFA7+uNNISdkRoCQbAl
 I1SfCvPH7Dm93k5x5xSGdG1hJRceAbCE0CfYvrCxD62b9uHbkLZMEJrw+PYinmc/vc2k
 aSr3VJvlWYrIrWFlhIuIWGEko3AeHbs2kRHOUTDlK3eKlEnjCUx9j9VnnjXBFnEFHHV5
 3zug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsnNLdYUe66nMQuUza7qP3+Z5TunIK9/FQtdw8YBIBJOgNsmGl8YlAHANq+7PO8iONZsVombhPGRQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/ZAk3/x/4ZbUGn1r6mgNF3SjnuzXWkXpKMBdIpKLRd2ucT2BB
 K/EKLTAVKKcQMzXSXNZai3jLnHJYpk9sH1i1M1UNYB8TZS0Hi6N/JfxaHs+BX8wwH9ahRFzPf+u
 oE+I2EM8JDcPzLEuk1DKPbzXbEWxraZHtQilsUKfsq3kKco05ihhqCsQv39W2q/f4q4yV2uY=
X-Gm-Gg: ATEYQzyk3YlCBnENvwtGw0GX2M3nvq8u6SXCP7DZBdZkeNyD+F+dCa7xExQkmQrVAs7
 /MjreTyW/mSq0/Wfyhqgsmr9elIWSoLeLGPZ4MEF9sM+tPUdUjx2r5Rgb8Yb8nvzrXH/Y4mHCtp
 WEo3rs52ALaykGc1R2kbSubavkC1msarpVc4dvVpuSuwo61T5bw2P2ZU7xbdPW/ElWDYcxnJ0iK
 UUndqj8D7QI4En5F98IOVDRgQdjE1kOedvZZi7BsXufUZ+TjxlioHrWMBORX9os7RfAUsjwRqdp
 y6RCnH4F0m2JBVXqtPbPk46TUliMcMxlFyGIeN2XV4fs/NoHaGvfUfA/IwjS0Sf5j9djvelqrvF
 zI7u3YdRZsSLnzEgwkYfdPxG/CFg5EqLmVKhlCaLxn5N7BV+z1NDVkXHBRutP1gJhaiUnFgXXde
 OHGxx5Be/Tnw/MFCf9Eco/sc49Owk7pZdGnGs=
X-Received: by 2002:a05:6102:43:b0:605:c5c:10e8 with SMTP id
 ada2fe7eead31-6050c5c133emr4029080137.31.1774971382162; 
 Tue, 31 Mar 2026 08:36:22 -0700 (PDT)
X-Received: by 2002:a05:6102:43:b0:605:c5c:10e8 with SMTP id
 ada2fe7eead31-6050c5c133emr4029061137.31.1774971381610; 
 Tue, 31 Mar 2026 08:36:21 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c8389524esm21654231fa.21.2026.03.31.08.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 08:36:20 -0700 (PDT)
Date: Tue, 31 Mar 2026 18:36:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Marek Vasut <marek.vasut@mailbox.org>
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
Subject: Re: [PATCH 0/4] drm/panel: simple: add Waveshare LCD panels
Message-ID: <kqrdzvu5ycajmdprrjqwcktq42t6453csi77ngzlkomtazxjhv@sxp7vh66my4x>
References: <20260330-ws-lcd-v1-0-309834a435c0@oss.qualcomm.com>
 <a13f5d5a-76aa-420e-a724-9b4714b51ccd@mailbox.org>
 <CAO9ioeUFfjr3Dh58TQ8EB7H3NgUX04N24OXXYijiigRZ8Kkh0A@mail.gmail.com>
 <982c4d97-695f-46b0-b819-a0b3d016b12b@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <982c4d97-695f-46b0-b819-a0b3d016b12b@mailbox.org>
X-Authority-Analysis: v=2.4 cv=KJpXzVFo c=1 sm=1 tr=0 ts=69cbe9f7 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=b3CbU_ItAAAA:8
 a=tnqjBxauYMpWV1rEDaEA:9 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-GUID: ap2lU3lU6qLIbJBIBZMOmfM0YlEqreMw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE1MCBTYWx0ZWRfXyqNn6Ih7huaI
 Vwtj58BGvwxOrU5913/KBZhK1vYrCyNd3gC7zZLs61tEmBzbuHYVSWfsJQmOEtxnTXEuIvC9K44
 QjBj01mOfR1rUghF2qYzcYvfF3d1Xk/oCKYSdi7RymUUtFCPocvwbeOmwVJrh5zjfYjEZcF8Yyg
 BFMfTAcFZWrjn53nT1srr9OA47b9wRnGR2H5MhjSBpfvv9dJFWAhhjJNJcxMIKE2MaG+XgWz9qP
 ODUcY1GutHNylNmaX7aP0S0HsJzJTRTn6X44UJlvQprvtN2PC1dLI0QBBZyOpz6c0V1MtmX9n1A
 Vur9QUmH1bpqiwh+F1r1lNk2GSk/SGGNscS9UtYuUyNtFPNgBPUWcJqCjq4OACklf7IP9MYU0E8
 LqeVggqaRDUsZ+uw+hbmqTZV3aj/vgFMD/uE7J3mQ1VqClmKInTMWHufbFPSRRu2TVNABLAqEXV
 MD2dOqtEr92KUNHWr8g==
X-Proofpoint-ORIG-GUID: ap2lU3lU6qLIbJBIBZMOmfM0YlEqreMw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310150
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

On Tue, Mar 31, 2026 at 05:11:43AM +0200, Marek Vasut wrote:
> On 3/31/26 3:22 AM, Dmitry Baryshkov wrote:
> > On Tue, 31 Mar 2026 at 00:07, Marek Vasut <marek.vasut@mailbox.org> wrote:
> > > 
> > > On 3/30/26 3:25 PM, Dmitry Baryshkov wrote:
> > > > Waveshare have a serie of DSI panel kits with the DPI or LVDS panel
> > > > being attached to the DSI2DPI or DSI2LVDS bridge. Commit 80b0eb11f8e0
> > > > ("dt-bindings: display: panel: Add waveshare DPI panel support")
> > > > described two of them in the bindings and commit 46be11b678e0
> > > > ("drm/panel: simple: Add Waveshare 13.3" panel support") added
> > > > definitions for one of those panels. Add support for the rest of them.
> > > Can we by any chance use the icn6211 driver in tree for this ?
> > 
> > As far as I can see, no. Waveshare kits have an extra ASIC in front of
> > ICN6211 / ICN6202, which completely hides all programming. So far the
> > interface is really better expressed by the waveshare,dsi2dpi /
> > dsi2lvds: this way, even if they decide to change the actual
> > implementation (like they did for DPI -> LVDS), we won't have to worry
> > about it for as long as their programming interface remains stable.
> Hmmm, I've seen this before, but I don't think this is extra ASIC. The
> ICN6211 pulls its register settings from EEPROM, does it not ?

The kits that I have at hand don't have I2C EEPROMs. They have 25Q8
QSPI. Also note that neither ICN6211 nor ICN6202 datasheets describe I2C
master interface. It is defined as a purely I2C slave.

The kits have WSVTH01 chip (CPLD?) and 25Q8 QSPI NOR. I assume the
bridge settings are loaded from by the WSVTH01 and programmed into the
ICN bridge.

> But no matter how the ICN loads its configuration, this is not waveshare
> specific. I have another display from another manufacturer here which is
> also ICN6211 that is preprogrammed. Can we instead have some generic-dsi
> display , because I don't think these proprogrammed DSI displays are going
> to be only ICN6211 based and only made by waveshare ?

If it was just about the bridge config, I would completely agree with
you. However if you check the waveshare-dsi.c, you'd notice that it is
not directly related to either of ICN bridges. It controls backlight
and panel regulators.

For the reference, *technically* the signal sequence should be:
DSI host -> ICN6202 -> WSVTH01 -> panel. But describing it this way
would require additional changes to the bridge driver to stop it from
programming the bridge (over the DSI). As such I really assume that it's
easier to omit the ICN bridges from the picture.

-- 
With best wishes
Dmitry
