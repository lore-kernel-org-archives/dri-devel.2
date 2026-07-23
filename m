Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00737C531D2
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 14:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 391BA10E331;
	Thu, 23 Jul 2026 14:46:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lIgStT47";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hbejQn1+";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1914C10E331
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 14:46:46 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NCvewI038339
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 14:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=sI3FJbWondD2nkr78gzMhxoD
 OIU48NccLMlqvMaraaI=; b=lIgStT472fWGi5Z9LTE4SW4t3i/+Yk45sjzwrixx
 2PXRCZm6ZJoqMNponwzr51ORZJsyENv9weQdhIvnljKcwUDKm0zbUGNMwd+8dbi4
 deL/fo/VcGeTcl53j7JVZRmprUcwfXzoYxq/RaKNadgE2BKhmNh1eXuyWxm2Ne6B
 68LXyHVGjYEoLs6roNfAzR7/FSQBEu8vN6nYclVIDIqzDk7J/E3HQOF1fzkwpUBL
 TwSgHlMyqKhq9WwzX1ok+6iECE7iskN7I/QfDOgb/SBcymSr6BRjHlKxW7Mb6wUc
 7aMVe8X7anTm3y+JuwXz/Fz14SxhuMT2d9otknQHOy+Ncg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk5cc3tqq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 14:46:44 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51bfd1772d8so2142311cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 07:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784817999; x=1785422799;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sI3FJbWondD2nkr78gzMhxoDOIU48NccLMlqvMaraaI=;
 b=hbejQn1+kHySl4D7b005lvDA0NSrkx+DJoIAuMtqzNAdeHskCDFcBp7+tARfhpyK1H
 kuQsLlEaXfCM1FTt1ix9Bos98LuWOSSwnCmO5zlgivwENWlMdRCs8BFTsfKpyJzXfyse
 TnAWmOnHok7w7B4jiWliguXxDMXkiTkU8Jps9IbTBal7T/rN8u0RRgbDmoTayQFvdEZY
 0HOtHx4INfRdp+QlJAFWdSa8bA4SK68/dHBnqMNJLcljH+wPbFNx1OhXqMT/q+VuZfDm
 tybqbkpdfFHiD89cxQMuK9h8rA1ceqPO94ogicbpPL1XBy7KhYhPy56Y8UvlEuJUtc3X
 Rbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784817999; x=1785422799;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sI3FJbWondD2nkr78gzMhxoDOIU48NccLMlqvMaraaI=;
 b=mFPjvQ41b5yXI/JfwKgTOousL+AXj0ye62UEDCusp+noQtteEWchAPCt5okF5HCpa0
 EtQdPGZgK3UsvHQfM84KNhId/XB8d9jwf9YFf7hfP+oxr43L1+rmLogEm5WOLH+7FtYX
 9InGuQp2MmWHmAkNo+eUq8PUKq7hXgQcYPxC+gLghBOz2VnTSxfTK56hnKpXqf/o9jGS
 dKoKnj9X9ldBETBKbabkIIafQwsHW7OMTRCEBm9vCDFcVv5VgnmiGovAMIDBJ7aZwa7c
 OGi6j8S/nQlElPTLH+aM1rJdMTBwudXV9lRQwd2fL311cj72FZOthFjMGtuS8h6NfSak
 bTYg==
X-Gm-Message-State: AOJu0YzNkLl8jJNfz+WGnPJSyfUDNiRbVuhAnYbh3zIB0QIHpH8s/aNc
 IwQasGzOOLgqzZYJS0TxQ50jMqFGodz5tZ6Km7zeuLIGeRz4F0VbxtVxvpaWN62fylSXPsvh8UB
 39mvnmdQ1cOp+PcMCVJQ3RyX2FkXWWvrcKYl95h792TEYLKMV/JiYUPuiutrwHgzT5N4sCjA=
X-Gm-Gg: AR+sD10JEqB5jPQFEdpceFrWuaNwLj6FN9EX98reALSBUs1zT4iNjWcJ8EB87W8UgtC
 /4ZQzad6kGeW0o2UKnRyfdaZbLGUDbRhMHw7fiIt+bY61lECbCxM6L6ZRf92njHAq1Y9Nx3l7/P
 Zi1OLtKhB7sQI/XcUdW8bUH7Q+LxgpybmzSIQdtsG+mqUK59zIMWjQ1kDluEtILYAwZx80DruOt
 shAR1IcblTSTSY3npMt49Tv7G8ETU9YyTvIZfI8JRenWr03jE5srNXILZRHsQUxRZP8zSsDWx2Q
 UdFlQLqudeSc1KGIHpTxfSDze0i+erEWAJw564jwbgGp9/VVxbJvWzuGPiePeKMrBsjWzNuLeNq
 IsBySw1RqP9KFMy6pYA4XZmyMSS7p42B6jN42NapiSXTKrYZiOUijMvhycvz3QDzU+cYsUI8wYt
 Z0gfyTsYKLWBJqaTKS64TC
X-Received: by 2002:a05:622a:840c:20b0:51c:4ffa:9b71 with SMTP id
 d75a77b69052e-528474b0ec0mr5761781cf.6.1784817999513; 
 Thu, 23 Jul 2026 07:46:39 -0700 (PDT)
X-Received: by 2002:a05:622a:840c:20b0:51c:4ffa:9b71 with SMTP id
 d75a77b69052e-528474b0ec0mr5761561cf.6.1784817998972; 
 Thu, 23 Jul 2026 07:46:38 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9badae1sm1072445e87.28.2026.07.23.07.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 07:46:37 -0700 (PDT)
Date: Thu, 23 Jul 2026 20:16:28 +0530
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: qcom: lemans-evk: Add LVDS display overlay
Message-ID: <amIpRKHXYKxvGCej@hu-vishsain-blr.qualcomm.com>
References: <20260719-lvds-support-v1-0-1f1aca3213ba@oss.qualcomm.com>
 <20260719-lvds-support-v1-1-1f1aca3213ba@oss.qualcomm.com>
 <b2pbwtqd5mf5d3sbbadx3e5o3ohys4mmjv5dxc3grycuuqjvgg@rh5veftljlrt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2pbwtqd5mf5d3sbbadx3e5o3ohys4mmjv5dxc3grycuuqjvgg@rh5veftljlrt>
X-Proofpoint-ORIG-GUID: UAdRinCu5P0RTUA_xSKQlDoNYzfxJsQ9
X-Proofpoint-GUID: UAdRinCu5P0RTUA_xSKQlDoNYzfxJsQ9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE0NiBTYWx0ZWRfX1oRDuUpNgyj+
 arelNpBSq9arpg2/SuYKLkj3xDYTvNvG22YUvn9yDbEDYpUE9kYMLdJUW2Y6BRJbwTCAN7o70OX
 N2Kh/qGxTeezyNvFMgudSVXFivA7iHI=
X-Authority-Analysis: v=2.4 cv=L/ItheT8 c=1 sm=1 tr=0 ts=6a622954 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=w-N4q8XgX6vL9HKy4AIA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE0NiBTYWx0ZWRfX6GZRVxpZ8iL+
 x5cmpxR52O2zlynPdX30cjurJed4mvOHoucuUb5G5FFJ1uOfu18CC1C+a1wl+0XloZfmmaJCQk8
 WzrVVgZ4/oE2/8jC0uIemCicYc2Z7GhWfrTKllLHnznlS+J4Kr5LChZrgbR1ylW0EfK7eIrV8ht
 vksQ9vhpzCgVdzYebbrfdWW03qTsvfHoiA9NzADRPIZKXF1XkkAkhUacLXVgQHp2wgeWuJsLg+8
 ga4WnAPopiei9fuFNlftI4wx5QySgMChhAwJJ6GDcq/MPp0Ti1S82lmGs/6wRCBYOZ9w7iwyJr+
 IqDs9uTRicvaoO9n8mdXT+HzKh1M0WKGVLcoUIwkCbn5U75TgXyKqmL8alo1DZyV39FxpARfHvf
 IsVN2YFVmFi+onno3cy8Ixn5EM8kb02bZTweBpHd+K/d7IqB+EIr91vi2utTLhwzThcQQCPNXhh
 cETrXUUCjrBLva7Ddug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230146
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

On Wed, Jul 22, 2026 at 04:44:14PM +0300, Dmitry Baryshkov wrote:
> On Sun, Jul 19, 2026 at 11:35:06PM +0530, Vishnu Saini wrote:
> > The Lemans EVK IFP mezzanine supports LVDS display output using the
> > Lontium LT9211C DSI-to-LVDS bridge. The bridge is connected to the
> > DSI0 output and drives a dual-channel 1920x1080 LVDS panel in
> > VESA-24 mapping.
> > 
> > Add a DTBO overlay, lemans-evk-lvds-boe,dv215fhm-r01.dtso, that wires
> > up the LT9211C bridge on I2C1 (address 0x2d) with reset on GPIO37,
> > a panel-lvds node describing the 476x268mm 1080p panel timing, and
> > an LCD display bias regulator supplied through the GPIO expander.
> > DSI power is provided by vreg_s4a.
> > 
> > The overlay is built as a composite DTB combining the base
> > lemans-evk.dtb, the IFP mezzanine overlay, and this LVDS overlay.
> > 
> > Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/Makefile                  |   4 +
> >  .../dts/qcom/lemans-evk-lvds-boe,dv215fhm-r01.dtso | 127 +++++++++++++++++++++
> >  2 files changed, 131 insertions(+)
> > 
> > +	model = "Qualcomm Technologies, Inc. Lemans-evk Mezzanine Lvds";
> 
> EVK, LVDS.
Will correct this in next revision. 
> > +
> > +	panel_lvds: panel-lvds {
> > +		compatible = "boe,dv215fhm-r01", "panel-lvds";
> 
> Thinking about it, does your panel have EDID? Is it readable from the
> device via the I2C bus?

The panel doesn't have edid and not connected with I2C bus. 
> My major concern is that if the user changes the LVDS panel, they'd need
> a new DTBO.
> 
> Would it make sense to implement EDID-based handling (like it's done in
> panel-edp)?
Your concern is valid, edid read will not work for this panel.

> > +		data-mapping = "vesa-24";
> > +		width-mm = <476>;
> > +		height-mm = <268>;
> > +		power-supply = <&lcd_disp_bias>;
> > +		status = "okay";
> > +
> > +		panel-timing {
> > +			clock-frequency = <148500000>;
> > +			hactive = <1920>;
> > +			vactive = <1080>;
> > +			hfront-porch = <88>;
> > +			hback-porch = <148>;
> > +			hsync-len = <44>;
> > +			vfront-porch = <4>;
> > +			vback-porch = <36>;
> > +			vsync-len = <5>;
> > +			de-active = <1>;
> > +		};
> 
> [..]
> 
> > +
> > +&i2c1 {
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&qup_i2c1_default>;
> > +	status = "okay";
> 
> Empty lines before the status property (here and later).
will correct this in next revision 
> > +
> 
> -- 
> With best wishes
> Dmitry
