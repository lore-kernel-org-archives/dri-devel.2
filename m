Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74B9FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 12:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33DD710EB60;
	Tue, 28 Apr 2026 12:40:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CKsIJOx1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FBZ3kirj";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BE3D10EB60
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:40:31 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SA3ufN3274958
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Uhjj67hXf7BIeABzuefc/MGP
 fZZbHy7JAto/bctTxR4=; b=CKsIJOx1lRXbdaahx4+TZJq+jpJ4bTFxUYjB5k97
 XBZYMJTHX+W2DjoOctzm/SMzYrzPqoBNdltYsEYYVsiQ8+xOPETf5WP+6cq/hBVg
 IeEi011yBoJI64/nuV5/UlQ2LGJWlybcOgpB2xSaG9BFQT10VIKfnaBq0O0Sf3m9
 zrmyU+n9qjF/1/GJK5/AQbTj0OrpNnNKCcGkXsvqt8GBb25qQ/QVy+ZHsLOAAHon
 lQGMIcfi5VaoPRgnqP1WDWqKxuFPdqjLJlGj3ct2X2hmvA7T5lD+/2gmhUwGASbX
 UikQagn8zH50OqeX2mhKZ3/3LynvjkOaWk+Cs2aquFqcdg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtttjggxg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:40:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50da529ff48so65712431cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 05:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777380030; x=1777984830;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Uhjj67hXf7BIeABzuefc/MGPfZZbHy7JAto/bctTxR4=;
 b=FBZ3kirjJ3PMHHQPehvn9U1/CupVzOkAPyHPxLQY8DtdtF08QfOt92zncHvf3cpUqV
 +cx/XKNIOemvhoreSaFSbC7dKxeyDz7FecF8fDG5r8QiwNhO9lEmqbWCdv0aHty84vO9
 KdY1fh7UIay7L0QpJmo4FW50c14HM4WKILqIXlhOWltjXxmj7o5zHKkShF83Hja97qvB
 tizUOGPVt56mjpe+ive9MBmeU5BKZnB5h1K6VT93gLEzN9j+2CRjD0Pi7tTqAMcvK2Il
 g4WOmciiDnZJO8wTnLMAimouqY0JS009rQWqgAj4G+rbE2bJd8jEoVi3GABdiew756iw
 Qzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777380030; x=1777984830;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uhjj67hXf7BIeABzuefc/MGPfZZbHy7JAto/bctTxR4=;
 b=roxF10ZPzvycUIUUvS0iWOp+y4riI7o83wjCrTTjOjkJ4KO2aQTxFUbFhFisxsxElF
 pwLF1cDR95xeZF3zlfMEH8zRkPeYmX316GTOQ8LieFx34gNPYjuiPmeCjeKkZrCPUIZk
 P+TXyrviTvbsPcL7huPP57Id63RXm9uGafQRlL/9a19szfcHmhoIvTnyKFB6Cpr1JQ/5
 iFHUmHQSuvE4u2PyT0+77F4ueQWmeM+5Go9yEaQk7Hmao2iz7QH5/9TLioV6QdDJRAp5
 K2U2JEmQxhxfINZJm7lKYykzBW88LD+Kyy5fXaX1DbX/LJiUxZ7YELGkQnGeM6+WcK/C
 6s6g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fcKho2jFd7bdFwcerBxtjC6Et83eho8xZEVyIK3Foob6ApMEbVNlvp5/R2Yc82RfRq522kzLHE7o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+OUnuaaCNJs2Z3FrgnQ1PNqwB85PFklraF0dwvUCDN4fZKta2
 EMuxu62gMv8jkPRzjcKL1aF7XRGVMeNJqyhYKfLGb7JG0+OeDvlbDGa0ELZYq9LiDofVdQaysO0
 VrMLO9wGrzF2gPaaVFQ+Rl39eM2L+541/kP0MYHhFs/m7wG4ec5Z6t42VkK+4POHAXPBFJGw=
X-Gm-Gg: AeBDieuajvs8JXioNjaO5CWscV37gOrOrWKi996QyZaiB4Tls8vvbsik09MoCZMVUt+
 DfYd9Ih3R4gH+xVZFj/XFW3qb8ybxyp1MXZ+WwC2baSWUhjop9wDb2MWxDZHU4QHMxt76ovtJXJ
 bv5WtNr/Idg4nWyBEQHJvEl4W6V4gpDI99xXoVZUlpjjv5R+kwxtfuU/6UO0MQoa3DDDMvWHErg
 LVbpzIXA2beHHOQXPQVwmmKvVX26xVPtDPhe+PJhTGusbOVI6Jo+HwsXZRTDveoHg9Rc4nGydqS
 qREh4Bj2reWg3v+18GLBm4Lz4Ax+W/U5Fm1EVwum1/bAZzuBxSVagabfvcJ17rwfv+SULX1hEtH
 52sIX9YJZZIeTzSAM8+pgKdPU+PGqsratcWeAQK+o0njUaiAbZo28SVevroSHK+4vcBdm8Xxf8T
 vQW0QEdXj0bFR3HCCYwzC753L4xU2E4V6BGHJpffltRCdREg==
X-Received: by 2002:ac8:5a55:0:b0:50e:6054:b4 with SMTP id
 d75a77b69052e-5100e0f3b1amr38739851cf.7.1777380029639; 
 Tue, 28 Apr 2026 05:40:29 -0700 (PDT)
X-Received: by 2002:ac8:5a55:0:b0:50e:6054:b4 with SMTP id
 d75a77b69052e-5100e0f3b1amr38739331cf.7.1777380029169; 
 Tue, 28 Apr 2026 05:40:29 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a7462cfef5sm596609e87.19.2026.04.28.05.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 05:40:28 -0700 (PDT)
Date: Tue, 28 Apr 2026 15:40:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/13] drm: bridge: dw_hdmi: Use
 drm_connector_helper_hpd_irq_event()
Message-ID: <6n44goy63rcd44r3l3qliqgybd7f7kn7p3ktosrjdtphuid5hj@lkigypdzbn3q>
References: <20260403185303.80748-1-jonas@kwiboo.se>
 <20260403185303.80748-11-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403185303.80748-11-jonas@kwiboo.se>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDExNyBTYWx0ZWRfX8rYhJlPzaz8l
 IHB7eSSBMsrtTp2FsdXLd5OAV6CjdteBnUJ4k2nA7egE04wyCPWt4MnMX87IRh/rV6zUw4jhSyB
 GBfDJ1L1YOoKkUQvNSooPwSomRV0X0eYUgvlzmwh9FwctiIn24s4xhApSE2YnUv8MXm0Ob6Vcgl
 UVLQOlaqaTXjGEYsYk9uVbth9mV9AXqgMgKL0YB3BFsL2yH1hf6l8wB2BAlLxEew1dzNiMlp5qe
 1COsG3Jjh6a7SD5BK8/oh4kxeFc21wCotgbrk0G/c1ehjVRtzc9uabLNBeQf7xBA85gbwi4jwX0
 rw/ti7RVCo2qLLjQd/BAQmEy/fwNzkPCHA+2O3mOb024HhxTDotpAkJqt6989m97FQqoijrOQPQ
 LQCMDOxHelp57I5YPsEhy+RMiM8EwaUcGTuUniebYKr1UDuXrlvhNtewGG76lI9lzDbzttK4kYZ
 PPLz0Yarkiqu0yZ1mzw==
X-Authority-Analysis: v=2.4 cv=TZKmcxQh c=1 sm=1 tr=0 ts=69f0aabe cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=LKZhR2v9Hn7qEMR8X70A:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: T7IPWwuP-_BFOgiI42CEGQ7lFX_NmiUW
X-Proofpoint-ORIG-GUID: T7IPWwuP-_BFOgiI42CEGQ7lFX_NmiUW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_03,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280117
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

On Fri, Apr 03, 2026 at 06:52:56PM +0000, Jonas Karlman wrote:
> Use drm_connector_helper_hpd_irq_event() or drm_helper_hpd_irq_event()
> depending on if a dw-hdmi connector or bridge is used.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v3: New patch
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 4d079b689b3b..4a0498922476 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -3054,10 +3054,13 @@ static void dw_hdmi_hpd_work(struct work_struct *work)
>  {
>  	struct dw_hdmi *hdmi = container_of(work, struct dw_hdmi, hpd_work.work);
>  
> -	if (hdmi->bridge.dev) {
> +	if (hdmi->connector.dev)
> +		drm_connector_helper_hpd_irq_event(&hdmi->connector);
> +	else if (hdmi->bridge.dev)
>  		drm_helper_hpd_irq_event(hdmi->bridge.dev);

Okay, following the comment to the previous patch it should rather
become:

	if (hdmi->bridge.dev)
		drm_bridge_hpd_notify(&hdmi->bridge, hdmi->last_connector_result);
	else if (hdmi->connector.dev)
		drm_connector_helper_hpd_irq_event(&hdmi->connector);


> +
> +	if (hdmi->bridge.dev)
>  		drm_bridge_hpd_notify(&hdmi->bridge, hdmi->last_connector_result);
> -	}
>  }
>  
>  static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
