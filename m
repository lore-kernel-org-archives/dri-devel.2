Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06E3CD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 09:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24E4410EFE3;
	Thu,  7 May 2026 09:52:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hk7CjrAb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HLEw/oOS";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9631C10EFE3
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 09:52:02 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6475LMU71067977
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 09:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=n2r+8tONPidRwC+bDiqTgIec
 2G+NFWKd4YQ4XHysQOU=; b=hk7CjrAbJWAFwoncPo8nXNSnkdWhlPzugC0Vuvbz
 oIs0tE86AQcPzXfDNbxNpJJC2h6m8Kzu3bYkDemd7XS6rc9QehjtbuV9ZL/FxZhz
 V+9VdE0I6Z812O4YAeCm1QCkhhgvRXznAYBODvtx/HrBInLvd9ON/OlZBCRKmYo7
 l/S6DiNpwzeIpQg7lnGhTiRTO6IgvYJII+56JS59usJiElGT3k/oskeLJ0/Tdman
 IZQ+h9pvhK2OYgmUrQjH/DSz4DzKha+cWGlUNod8b7bB3Jfb27siJT2aHK6A84mh
 hdrgVyyxuyMM3C92Ib81826vOMOkMOIUlSep3lVWR5Dqog==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0mh190t4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 09:52:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8d5d03ae893so108630885a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 02:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778147521; x=1778752321;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n2r+8tONPidRwC+bDiqTgIec2G+NFWKd4YQ4XHysQOU=;
 b=HLEw/oOSF5dUFQKd/lKzkmDaEGk0tauHgktu9xx30ybA9stJAnBUZkBLxtsNWz+xjr
 SH5kIWKFRweT4SSGlUCve4s43pacA9On1T+ZO+jBC87xzQVDN2rIirxIcZZsCQIllt0o
 x709u495E4p6tSkJJveG1xx2PkdPwlh2un8scP2t5uqRITmbznigHzWDRG2oMHvfjftm
 5Jx2GOOdifhieOViwBheaNQ4gKJvVilpRaZ5KvPlR8NSTzDwNlYcLkuZ7QGGWAwLW85H
 o4qquXbvm1yQE7o1CJmTPI2/DP7qewZCeOB2gwjJ0FLrWifRrTNDe280jC5hX5Je5QO+
 7Vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778147521; x=1778752321;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n2r+8tONPidRwC+bDiqTgIec2G+NFWKd4YQ4XHysQOU=;
 b=Ar/rYCqQHOvHFURDZjzsmmT8PZr3F9mN8aziJrI9cjwfRn7gdnDt4RMrmZM5qrdGH/
 wCQY7QZxmkvI3IIr4ecDSGLqCTL351Uuyoy1g8y7ODfx4aygWdYXtBKWcXnywB3wecge
 Qjer5sQacirDhsEI506LvGXwB1Pupo0ThikuFMaBqaBV+PqqF/M9N+TcHqX8CVOur6T6
 L3//35jKaU9FIy+CTl2KmUbFqCy0PNSSs2i8VoePByO9680sD5WdpZ0soQLKOCvwFJN8
 KJWYSim2l2I9eps4YhoCV8EOOzuCMWkEoTnFn6/Kx8ZEDLBghQYZyKAg4yDblZ6ybMKz
 7fWg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hDxmiwnbFBi8JRh0/Q4JVvnFongwLpYGfAX8yGg1DQjMKXPBPQp5vc/3dNo3CfKDoNKVeMVwUYmw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwmaDho/0DY87QymOcYl+JWRart2xMq27V5xnaCGhscjY0dNuEx
 lDj+hMdzE6I+6Hincwrg939V9zXn5zSzRKP3YI+epTZDj2ohesuI0xGaSqX7yvJ8GK9HoCLfCvl
 FCsigLjBJoOrS3r+YTtRQhUmMpKPNT827zDXUNyhwTPAs6c4RCo1xsFMtUDdPxA10gMp0Pqs=
X-Gm-Gg: AeBDiev9nC2weTRCTIN7Utc9O3T2XEYIxDbs3uT8a2PZ1e69RsOqqbL7zZJ+havJMiP
 G6MWrMNsZpp7Cx/K/LTKjnwBWGLoLHWhkhK8o+HIlJc+rq4KU7KUiaoiWMHNxQ2wFnllkKbr40f
 7AQ1x0dZg5QzWJUrFkzs9dVVBhJWJXSrrnwVmIbIDEo0RofRzDcEwCrTC70N37J+n79ghuBarHB
 zkgRCC9rarGftrFHsOhSFJHOYG6ivOhVSJn3Q2Rrp7vK0cBApjlRkXY9WcbCzadF8ZL8p9jrUnI
 9j34LG/DO+7bghZoHcKfGoy1GdM3rLOkRaEneLnWxAPKB4fjNHeM548m3XWMF7eQGpX6VrxjglL
 KQxVoPzCkZAnhzpd53waVrVNglufoQGBxOyZ5PoKtPTewq2Msxl3fK3o74jXwy7FYnc2ZMwbekN
 4uscndIN3j1NloPl1FzSZK+RSRA+YiZW9XT5L3IgpKodw56Q==
X-Received: by 2002:a05:620a:1a20:b0:8fc:5e81:28eb with SMTP id
 af79cd13be357-904d65e1e89mr1081200985a.42.1778147520845; 
 Thu, 07 May 2026 02:52:00 -0700 (PDT)
X-Received: by 2002:a05:620a:1a20:b0:8fc:5e81:28eb with SMTP id
 af79cd13be357-904d65e1e89mr1081198385a.42.1778147520392; 
 Thu, 07 May 2026 02:52:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c33c8a3sm5505238e87.54.2026.05.07.02.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:51:58 -0700 (PDT)
Date: Thu, 7 May 2026 12:51:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Junzhi Zhao <junzhi.zhao@mediatek.com>, Jie Qiu <jie.qiu@mediatek.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] drm/mediatek: hdmi: report jack plugged state from
 bridge enable/disable
Message-ID: <lhxivpwo6aq3ehgzsnkgxnqis5tptmey4dtbhaokyckkl7ghbn@dzaj225pnpk3>
References: <a3e22cbae528c9a38d854a586d1736b860998d41.1776265222.git.daniel@makrotopia.org>
 <c4d62fc2244fb72207855c5a366ff10fad419f2d.1776265222.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4d62fc2244fb72207855c5a366ff10fad419f2d.1776265222.git.daniel@makrotopia.org>
X-Proofpoint-GUID: L5dDWwwKWRp9_72VlA6nuqJyH9kqFZ8q
X-Proofpoint-ORIG-GUID: L5dDWwwKWRp9_72VlA6nuqJyH9kqFZ8q
X-Authority-Analysis: v=2.4 cv=P9gKQCAu c=1 sm=1 tr=0 ts=69fc60c1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=VT4XjZGOAAAA:8 a=_OD9tO1ZYgXKlZaMhT4A:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA5OCBTYWx0ZWRfX9uoHzTyePNWD
 mvLo5KaCU9gYNlCSbArqNrx9ejbV4uumB0au7dTfNcd0aEDZfTd6eFZwu6aVWVL77/pC6cexnT+
 K21fst+0OgAGkd/6qJJYEU0WNSB+XCKlwN+PBa1dz413jCEnAaY0brYGTXqWWP8UarH9jNXajF9
 ME+2XANXfP82dbPMuvVYcJfrWfHsMF+yFHPAP7XhVZxPDsspfAcRFxVLW9rj66zBovmu+TSjyBv
 y8rfEjTMI9Dkrtgf9gLCVIM7K/mY2GTeHA17tFn5aCXIxnf/+SB2EJ6DtdHXFARKYx+5o3JI3wd
 gx0Gi5mUvhI9p/Cp/nBgiNPA5GAEYEIQpaBqLkFBypoxhFJ2RhV3BC1fwVazD+cnpLQ3d5lZpxG
 3IjePjVqvOp8Fk39409rjad2KSJCMSxzMovnGqDZCoTweg12GQFuIy2dWSIJpmFKmmCR2skR+oe
 0i2KgcIl8ta/H6U48HA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070098
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

On Wed, Apr 15, 2026 at 04:04:16PM +0100, Daniel Golle wrote:
> Notify hdmi-codec of the current sink plugged state from
> mtk_hdmi_bridge_atomic_enable() and mtk_hdmi_bridge_atomic_disable()
> via mtk_hdmi_update_plugged_status(). This matches the pattern used
> by dw-hdmi, which invokes handle_plugged_change() from the bridge
> enable and disable paths so that ASoC jack state stays in sync with
> the actual sink presence across atomic commit cycles, and not only
> on CEC HPD transitions.
> 
> Userspace audio daemons (e.g. pipewire) rely on the jack state to
> route streams, restore per-sink volume levels, and recover the last
> used device after a reconnect. Without this, those transitions are
> missed whenever the sink change is driven by a mode set rather than
> by a bare HPD event.

I can only hope to see mtk_hdmi to migrate to DRM_BRIDGE_OP_HDMI and
DRM_BRIDGE_OP_HDMI_AUDIO...

I think the correct timing was discussed several times and the overall
conclusion was that the correct time is when the actual HDMI cable is
being plugged / unplugged. See the discussion around [1] and the
captured response of Mark Brown.

[1] https://lore.kernel.org/dri-devel/cwxmu5a37qaqerpaolohxw57nzerkvlumx4dsqwmqwx5t7xhxo@kq6j63hfydra/

> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> index 9050d7785f109..565bb72c9b63a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -1013,6 +1013,8 @@ static void mtk_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
>  	hdmi->curr_conn = NULL;
>  
>  	hdmi->enabled = false;
> +
> +	mtk_hdmi_update_plugged_status(hdmi);
>  }
>  
>  static void mtk_hdmi_bridge_atomic_post_disable(struct drm_bridge *bridge,
> @@ -1082,6 +1084,8 @@ static void mtk_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
>  	mtk_hdmi_clk_enable_audio(hdmi);
>  
>  	hdmi->enabled = true;
> +
> +	mtk_hdmi_update_plugged_status(hdmi);
>  }
>  
>  static const struct drm_bridge_funcs mtk_hdmi_bridge_funcs = {
> -- 
> 2.53.0

-- 
With best wishes
Dmitry
