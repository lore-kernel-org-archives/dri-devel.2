Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1A4F557ED
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 09:00:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE06E10E135;
	Mon, 20 Apr 2026 09:00:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YMo7Yzcy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WR9Ctque";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B7F510E135
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 09:00:27 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63K7WxuE311150
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 09:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=/lO0wUKTVYLddzZduPrPryU/
 1GxHKJTrxAiMfoqglG0=; b=YMo7Yzcyug+Kfs3+ERy00tBibDuu24kBh7Y1UR1/
 zEp4+GzPUo5VfnVsywv86EEE6fG9G4KbnQSlsx8XCbP+FLpXznb2b0+Z1JmlMepI
 hv5WmG9UgHV0EYHjpUr6bkLPetaihYn3L0r3Kka5Ppt1EXhy6by+XEwoTmgijnfZ
 toLbXo042tXFXs1ZYNjfrBskT1RhjrRPmUPLXgTysvCFAH3izmfihUWmOj9KCtM0
 181JlYcQLqBCoTUlgm0Qo5FI+IiLkIH8qK9j68vLmZinPf8dGBBXnRCDkjR51e1B
 j/XDDWtkuF7AHrM51oi5+7t6ncTAhe26vT2mU6DGbQ6Fqw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkyannf0q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 09:00:25 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-612ef4e6c54so4285832137.2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 02:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776675624; x=1777280424;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/lO0wUKTVYLddzZduPrPryU/1GxHKJTrxAiMfoqglG0=;
 b=WR9CtqueT89aee4GFhGUe/dL+dRfgszM5Vy1cyzGchx93hg4tMhllZBfNFtVrur/n5
 qLWN4oCwsXxboHEuNcxkqeBlfztFGzwn9hmnxY0JsKeNGvEoAY527kCqlpSkYx03q/1i
 95cwcNd/J5A/NVKwIVhF/Pe+GZKgQpLUwsvRxQQ4GbF+TzVNZXTqb5GliLvTWmnlhBE2
 SQg1Vu5OE/Hswv9f3j56f4wmIVqhbQyvrfq94IafTYU7n9VRDw8D5pcNHWuShO1WU+5Q
 qoUIzk9DrR/cSFcV5fCT8RNPs+SHE1v3ZSiFe6jNLRqjsRS4a8QhxQYMw8izRkUltsED
 26Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776675624; x=1777280424;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/lO0wUKTVYLddzZduPrPryU/1GxHKJTrxAiMfoqglG0=;
 b=N3VIPHpxpCEr3eZDpQikesix/ERL2ffzWZqCxh7L61spDFdfA3ec8Be9SqkgPro0fC
 1ltkvoqbdlFXEoAjmliS1angEGdMdSwFkCVO1Yd5MetAsU8xxBtwun6Sb8AFIrrVes+b
 3udnJYx9R9uWYolS/UtCwS18OXnbjdsvmNw8UclXpG6p21W0ghUuUT0Ni5EqS9e5kTcf
 QVZ1WmCJEiYaerCflCsff7ZLzN0zRRaK7cpgG8sGOOnWHfFXsYe9WpSA5iOeinHIcJht
 o8pb+mYOXz1Qpk9GcHjwzZEVfd5ntMe12F3+cogu5igKfeT7pbWpYepICM+nQVUvuhST
 fing==
X-Forwarded-Encrypted: i=1;
 AFNElJ8VlRDH85Ax1kr+IslTI00ZzaebED9Ch7IkgHa+IVnx+DS43H6sbyb9rD6rjEqdDiohK8z2LVhonCo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyrYvSFLamypbn7h/WcGLpopfKDfiM7dUO5fvVbxv1uD9bFFEpU
 3ttXw2X/Ix2QLFm4OXGJkLdXwcJG2zHqkdB857573oIEA8gfANfpi1Ji+168luNZOv5gXrFbdp/
 jB6/wBtdDVhVERDEcYB9DuM7xArsCaPuAdUa6N/ZQ+Mphor15FsV/oDN+DxxNKrg2SqfoY5s=
X-Gm-Gg: AeBDiesfQTJPWtbw+wIx9n+MIvo1flOJ8frjAV+7autHZehz1v2uM9oyQI9Z14gYwyR
 FyZAjUCr3w2HaZOq7ZckkmvlXRRq4ilt7FrmOb4tQSfprAeyprpXipayopNwyZK/DPLnttXqJ5U
 68W1q81JfoHdMH8utedpuSN8Lo8vfXr8MF6Suahi7PnapLGYHGm1J6aqjaE5QmEpY/+MjveREna
 mXaSvOpXbjGOcwbfaKVBIJ9KEKzPzvedyExILE44qOpKFA5pjuQkildDO6xbycoyON7DVzw9vkl
 Ui/lBHMCDrpPVQ+hvDdcAddSvgwwLTza64QNCUW72Up69NamvZq7BwxQc5Dc8TctK+vv51+3Qm/
 tWfDvx63eDGJO+hU+9SeazXfVlllnJ3To60mbkbN6Ajbz8nggkTJKlUU2+zcuIkQEK7Ij+2bUqd
 pw98qEUH4aP6yJUiykPAfBJZ+YEwv85/x/Tp6x2evilo1TAg==
X-Received: by 2002:a05:6102:3581:b0:611:a5b6:f4d3 with SMTP id
 ada2fe7eead31-616f73fa0e4mr5157056137.22.1776675624418; 
 Mon, 20 Apr 2026 02:00:24 -0700 (PDT)
X-Received: by 2002:a05:6102:3581:b0:611:a5b6:f4d3 with SMTP id
 ada2fe7eead31-616f73fa0e4mr5157037137.22.1776675623997; 
 Mon, 20 Apr 2026 02:00:23 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb5f652asm22224871fa.12.2026.04.20.02.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 02:00:22 -0700 (PDT)
Date: Mon, 20 Apr 2026 12:00:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Frank Zhang <rmxpzlb@gmail.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 detlev.casanova@collabora.com, cristian.ciocaltea@collabora.com,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe
 when PHY is down
Message-ID: <ggmfrel7xrhigcsvoegxwdxpljohiyspzcmhpmkxkqycu53zwm@ltkecyoshdax>
References: <20260418101936.7731-1-rmxpzlb@gmail.com>
 <hdl63shkqubkvczlg7ryjah5psiqzrhu5llelzaetw7skbpujv@nyxgriryjxd5>
 <9c198d0e-a675-4d7e-a485-5a8ee4d97f88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c198d0e-a675-4d7e-a485-5a8ee4d97f88@gmail.com>
X-Proofpoint-GUID: bUxmM4_yiDBVt1kCndr2Lv3O5W3hxTha
X-Proofpoint-ORIG-GUID: bUxmM4_yiDBVt1kCndr2Lv3O5W3hxTha
X-Authority-Analysis: v=2.4 cv=SNFykuvH c=1 sm=1 tr=0 ts=69e5eb29 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=-aDFVIzMO8mTH3V4WnwA:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA4NiBTYWx0ZWRfX8k3Y7/NtkVGo
 Rm1agpHQAt4CnvjxAD6NNPVLqGayPMI4Ks/OyWVM1S/SLF737r1QPZLgyUCHMi+Y9Xy2Rtfr8FC
 u7NLllXRS+i5st6Ujra5qs5HVozQ7/hy4NayFslvJQhLtdjxuYKNyLrWMTfA2p8+AGWeAUG1SoM
 /bBz0RHab4UVdRDDzHwl2VUhDWQYPktlAwUfME4vWHSjjkch6cNyOTbd9qafkFX0T6bPfutxVsx
 xY/wPyZ9An2wa651OxDxefkwWL+Lo7TlYMD9EB9fez6hKJbEruJLl/3jm398haVz9ZmJyC8/YTc
 Nt/NhM/2LedizI9ZOxP5fiu7laK5nt1aw5JlD0gtMC1vLoe0SFSbFOk5o++G/RsRSBkwLIFY8RY
 wzwiR1Db0Ui3SZiiXNZj9v809MR/RgHnUFJE5NG/gEIZiTA2GPYC8AInVLyDtwfqfZhdiaH8b/U
 jtr4Bs0v5jJHa/f7gEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200086
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

On Mon, Apr 20, 2026 at 02:11:28PM +0800, Frank Zhang wrote:
> On 4/19/26 08:40, Dmitry Baryshkov wrote:
> > On Sat, Apr 18, 2026 at 06:19:36PM +0800, Frank Zhang wrote:
> > > The following panic was observed during system reboot:
> > > 
> > > Kernel panic - not syncing: Asynchronous SError Interrupt
> > > CPU: 7 UID: 1000 PID: 2637 Comm: pipewire ... 6.19.10-300.fc44.aarch64
> > > Call trace:
> > >   ...
> > >   regmap_update_bits_base+0x5c/0x90
> > >   dw_hdmi_qp_bridge_clear_infoframe+0xb0/0x120 [dw_hdmi_qp]
> > >   drm_bridge_connector_clear_infoframe+0x28/0x48 [drm_display_helper]
> > >   ...
> > >   dw_hdmi_qp_audio_disable+0x24/0xb8 [dw_hdmi_qp]
> > >   drm_bridge_connector_audio_shutdown+0x30/0x60 [drm_display_helper]
> > >   drm_connector_hdmi_audio_shutdown+0x24/0x38 [drm_display_helper]
> > >   hdmi_codec_shutdown+0x60/0x90 [snd_soc_hdmi_codec]
> > >   ...
> > >   snd_pcm_release_substream.part.0+0x44/0xd8 [snd_pcm]
> > >   snd_pcm_release+0x60/0xe8 [snd_pcm]
> > >   ...
> > > 
> > > The root cause is pipewire tries to close the HDMI audio device after
> > > atomic_disable(), which sets tmds_char_rate to 0 and disable the PHY.
> > > 
> > > In this case, dw_hdmi_qp_audio_disable() will call
> > > drm_atomic_helper_connector_hdmi_clear_audio_infoframe() directly,
> > > accessing registers without checking tmds_char_rate.
> > > 
> > > Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside the
> > > if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
> > > 
> > > Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hdmi-qp")
> > > Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>
> > > 
> > > ---
> > > Changes in v2:
> > > - Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside
> > >    the if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
> > > - Link to v1: https://lore.kernel.org/all/20260416093150.13853-1-rmxpzlb@gmail.com/
> > > 
> > > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> > > index d649a1cf07f5..7760527484c8 100644
> > > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> > > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> > > @@ -526,10 +526,10 @@ static void dw_hdmi_qp_audio_disable(struct drm_bridge *bridge,
> > >   {
> > >   	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
> > > -	drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
> > > -
> > > -	if (hdmi->tmds_char_rate)
> > > +	if (hdmi->tmds_char_rate) {
> > > +		drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
> > >   		dw_hdmi_qp_audio_disable_regs(hdmi);
> > > +	}
> > 
> > Will audio and audio infoframe remain disabled after consequetive
> > atomic_enable() call?
> > 
> > >   }
> > >   static int dw_hdmi_qp_i2c_read(struct dw_hdmi_qp *hdmi,
> > > -- 
> > > 2.53.0
> > > 
> > 
> 
> Sorry, I missed clearing the audio infoframe when the PHY is down. The next
> atomic_enable() will write the stale audio infoframe. My mistake.
> 
> To clear the stale audio infoframe, dw_hdmi_qp_audio_disable() can handle it
> in the else branch directly, but this seems like a layering violation for a
> bridge driver
> 
> I think the better approach is to add a 'reset_audio_infoframe' interface in
> drm_hdmi_state_helper.c that does basically the same as
> drm_atomic_helper_connector_hdmi_clear_audio_infoframe(), but only clearing
> the software state without calling clear_infoframe(). It's also a bit odd
> since it would only be used by dw-hdmi-qp.

That sounds too fine-grained and it also will not work straight ahead...

Just for my understanding, let's consider the opposite situation: the
user tries to start audio playback before setting the mode. How is it
handled in the driver?

> 
> I'd like to get the maintainers' opinion about adding such an interface.
> 
> Thanks,
> Frank Zhang
> 

-- 
With best wishes
Dmitry
