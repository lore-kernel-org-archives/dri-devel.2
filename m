Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606F7FA1FE3
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 19:07:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78DC610EEF7;
	Wed, 22 Apr 2026 19:07:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jVnwLagj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G0U/RP4y";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E07B10EEF7
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:07:00 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MG3e1P1230138
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=7EZiYe5N6hRvm3v4NIe+b/e9
 uhWdqKzT0/KCiMPYNrs=; b=jVnwLagjUG5doy+C7taNoVt8DrO9QX7I2rU0QGG3
 vl/10/xgV4szHYqArzA2GWY7TzN+teJWKSM/eQqjfqzO/K1R3Ja50fzS40Xt0DLF
 uRZQywMtd0W5RySjbJdsb1PCsz5S6RAMlvnXzqN8EOnAlhu5z1VhLsWb280Uam0K
 EB/ojqeXH2USNHvyC0SmUt1JB2TaE+LELgnt7Q06Y7NbkkZN+7nQxJPUYD4OVAJt
 DdoYrjVkyscQBcj+7oSxqWsZkKk1BtuTjobLgq+PbaUzmWLkzjVynB+bSQWKTgiq
 ChcqiSRarCj8jRF2XkIaYuVdgZWrpBK1yqlnMpwZuOJhkQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1h68n3k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:06:59 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-61002acc895so3529766137.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 12:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776884818; x=1777489618;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7EZiYe5N6hRvm3v4NIe+b/e9uhWdqKzT0/KCiMPYNrs=;
 b=G0U/RP4y142Te5WKGhgwUmtDYgW+sl0Kx5QBv+He0lPsGF3MuoVyhmOhXxe0Irki+e
 qDhRHDW3ikGPPFja2AK6FkEWfgX/hoyR+TDgW4DTRjZT1ap9+BJOGCL/+5AlNb6tzOBO
 5av4sZpoPk+w7qW2IfpbPgq7pPvXjboHfeU6wyenpJtU7z1bW9OQ4DI9sy76u8EsXKpX
 6iEe+SrFmOWev+GTY110f1iQuNzPHyWF4FFKE3edm4TfAbgo5ZD9wHyphcQhqOiUul8y
 dA3k15GWBe2um1XkJXOL+ao+WIHOOsCzdymD5Y9yDGSNDyWpmxy0RMuAmKSOryyg7Wyr
 12bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776884818; x=1777489618;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7EZiYe5N6hRvm3v4NIe+b/e9uhWdqKzT0/KCiMPYNrs=;
 b=LHBT37faFBAcuMjxo7ouHNbQ5lW6UPRVgAZM91T+t+HgiQ6UDwAv0YGrySDW8Xgn3b
 G5NgY0zl4hjaBzQ9UQ4DOsDqHB+JWMp9yXLGh5QzGZqcHnnVl44vF7dyOJoS4oIcuq51
 ty/v1RkWqUIpp1jvxIopwBMV7aJnIBwUeO7cPQXIPlSZyaxDkkS70zyfLXdJ4nKcaGyd
 GL0JBurE0HFG2sO+TJAYozLgO//HVpiXoeDM2bGkh/hV2Tpq/YcM9I7GcqLbY/PT0z3/
 +bNuxfYtYgiFAlglHSkcyydgoxtARvWkhO16WpO+qyImMalkXIa0L76nMri2M9d0c0GL
 e7IQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+clTxtTFChs9hnIuiu/WVDfz6aGBQh6LUWPl03FeiApvJ5FwRFuhINrjcUjee0RxgCjhNbMkTYLfI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwsQDjbYjZQqswvRS07eCHfzGTK1xM99ZfhSTmrD2uetpIJ5qNV
 mi+09T4o7BNglmgEAZehsJ5G7FYeekuATBGCU1SthHug9hYKIwv+J7dwzO8I95j0NfWoOoRTgB0
 vE/FTKyKHuIrF/F6eMS5l77P1k1eLPOXmWlKdhK9XbCUeiplvV+a3TJqA/aIY8dMFR0ZzKEc=
X-Gm-Gg: AeBDievQbIr8wbGcp30ZHvVLIpUguQcytK39D3dW29xuJKROEe7uzvqV7ocaTa8JnNO
 yzFKg7JnRLIGAzV9N3H3Ko/uQ8CnENvQpreeHl0AXEBJrRzMM7GrU4RFrxbzoBtjjOC4Keq4WW9
 XRGB/eBpFD1WnSfjGBlBCiVXdQ4Ql9MVQGXZAxdGeDbtD56dQENqWRVHv/kCnDqlV+/jxEfGp0j
 LgrFC5jnQMcuEoWCtWDI6nYb51cXdvBkTdse9SyHavrHNaqHdZk9wsuEty8qnz/fNLtFWZGI4bF
 2LceYA+rY44BS2kXxMlMCFBjnF1Dh6F0xXa0MR58QdF2e7k6EFgAPO60hgKQOPEEBacR9VoAn7v
 GPxMnC5Y78vc0PfDJSiG1ogqo/nHjkNjovdcZ/nsNlDmHis5v7hoqZ4YHKF842/zlXtf5ar+9G1
 Enn+dpukXi4CB5GJmTLyrwgytEKPm1nwbxiURybQLkMOkFjA==
X-Received: by 2002:a05:6102:80a8:b0:608:a960:c852 with SMTP id
 ada2fe7eead31-616f4d792b0mr12274686137.9.1776884818501; 
 Wed, 22 Apr 2026 12:06:58 -0700 (PDT)
X-Received: by 2002:a05:6102:80a8:b0:608:a960:c852 with SMTP id
 ada2fe7eead31-616f4d792b0mr12274635137.9.1776884817942; 
 Wed, 22 Apr 2026 12:06:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb5f65absm37608011fa.11.2026.04.22.12.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 12:06:56 -0700 (PDT)
Date: Wed, 22 Apr 2026 22:06:55 +0300
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
Message-ID: <urguajogb4zsz4jg3ef32hpyf2awxkywdtlk5ackdi2gjai4l7@vpjaf3sznkto>
References: <20260418101936.7731-1-rmxpzlb@gmail.com>
 <hdl63shkqubkvczlg7ryjah5psiqzrhu5llelzaetw7skbpujv@nyxgriryjxd5>
 <9c198d0e-a675-4d7e-a485-5a8ee4d97f88@gmail.com>
 <ggmfrel7xrhigcsvoegxwdxpljohiyspzcmhpmkxkqycu53zwm@ltkecyoshdax>
 <99f6fde4-ac69-4e7d-a345-a378762eb9bb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99f6fde4-ac69-4e7d-a345-a378762eb9bb@gmail.com>
X-Authority-Analysis: v=2.4 cv=f4Z4wuyM c=1 sm=1 tr=0 ts=69e91c53 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=kn-r4vqxNxNuTmBUix8A:9 a=CjuIK1q_8ugA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE4NSBTYWx0ZWRfX3LnFnZ5oe8as
 P8wqFh5r53GILevEno/wfzxgkASsXc/haxX2kvoQCxi6xyXnkgRNHSmIegbg00QlYx1Rkf9Q4qP
 cj7MwRO06lfcD1mQM1Q7ILOqubqH43yQtt1GrregNUBPTXEnVxrnOcWsgHsmfg+J+Byotm2dIzA
 hN4Q5t02XCYyhGVcOn3JbQ/ZBMD9GL1mAC+qJjYoEDSfp8GYn2SbO9NbaYFoHX84M2T9muNxv2w
 kjYlGj5grrdYuksUwE9R+SRZl3lABGgFIQatt0ms8WD6VK3tZpOuRfqDUGBiC3QmO6QdpsLi5LN
 k82t0rkHRlUBl1lS8SNL396smXlgRpQzVPs/SxnG8WBhN60eXBQOQG9qGKbb5tufjpGXPj6w9lv
 exg9Mb5e7PR3gcH1ojwaWeFnAQBVNxS8q0Hx961gasFV9l0ormlznGtyHv6ldgKUfcB0MInQ0BH
 R6xBTD4iKnMfTr4cw/w==
X-Proofpoint-GUID: lP0NhQl-ioFhETi4sm9aIwMh8RrvBmvu
X-Proofpoint-ORIG-GUID: lP0NhQl-ioFhETi4sm9aIwMh8RrvBmvu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220185
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

On Tue, Apr 21, 2026 at 10:31:19AM +0800, Frank Zhang wrote:
> On 4/20/26 17:00, Dmitry Baryshkov wrote:
> > On Mon, Apr 20, 2026 at 02:11:28PM +0800, Frank Zhang wrote:
> > > On 4/19/26 08:40, Dmitry Baryshkov wrote:
> > > > On Sat, Apr 18, 2026 at 06:19:36PM +0800, Frank Zhang wrote:
> > > > > The following panic was observed during system reboot:
> > > > > 
> > > > > Kernel panic - not syncing: Asynchronous SError Interrupt
> > > > > CPU: 7 UID: 1000 PID: 2637 Comm: pipewire ... 6.19.10-300.fc44.aarch64
> > > > > Call trace:
> > > > >    ...
> > > > >    regmap_update_bits_base+0x5c/0x90
> > > > >    dw_hdmi_qp_bridge_clear_infoframe+0xb0/0x120 [dw_hdmi_qp]
> > > > >    drm_bridge_connector_clear_infoframe+0x28/0x48 [drm_display_helper]
> > > > >    ...
> > > > >    dw_hdmi_qp_audio_disable+0x24/0xb8 [dw_hdmi_qp]
> > > > >    drm_bridge_connector_audio_shutdown+0x30/0x60 [drm_display_helper]
> > > > >    drm_connector_hdmi_audio_shutdown+0x24/0x38 [drm_display_helper]
> > > > >    hdmi_codec_shutdown+0x60/0x90 [snd_soc_hdmi_codec]
> > > > >    ...
> > > > >    snd_pcm_release_substream.part.0+0x44/0xd8 [snd_pcm]
> > > > >    snd_pcm_release+0x60/0xe8 [snd_pcm]
> > > > >    ...
> > > > > 
> > > > > The root cause is pipewire tries to close the HDMI audio device after
> > > > > atomic_disable(), which sets tmds_char_rate to 0 and disable the PHY.
> > > > > 
> > > > > In this case, dw_hdmi_qp_audio_disable() will call
> > > > > drm_atomic_helper_connector_hdmi_clear_audio_infoframe() directly,
> > > > > accessing registers without checking tmds_char_rate.
> > > > > 
> > > > > Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside the
> > > > > if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
> > > > > 
> > > > > Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hdmi-qp")
> > > > > Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>
> > > > > 
> > > > > ---
> > > > > Changes in v2:
> > > > > - Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside
> > > > >     the if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
> > > > > - Link to v1: https://lore.kernel.org/all/20260416093150.13853-1-rmxpzlb@gmail.com/
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> > > > > index d649a1cf07f5..7760527484c8 100644
> > > > > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> > > > > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> > > > > @@ -526,10 +526,10 @@ static void dw_hdmi_qp_audio_disable(struct drm_bridge *bridge,
> > > > >    {
> > > > >    	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
> > > > > -	drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
> > > > > -
> > > > > -	if (hdmi->tmds_char_rate)
> > > > > +	if (hdmi->tmds_char_rate) {
> > > > > +		drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
> > > > >    		dw_hdmi_qp_audio_disable_regs(hdmi);
> > > > > +	}
> > > > 
> > > > Will audio and audio infoframe remain disabled after consequetive
> > > > atomic_enable() call?
> > > > 
> > > > >    }
> > > > >    static int dw_hdmi_qp_i2c_read(struct dw_hdmi_qp *hdmi,
> > > > > -- 
> > > > > 2.53.0
> > > > > 
> > > > 
> > > 
> > > Sorry, I missed clearing the audio infoframe when the PHY is down. The next
> > > atomic_enable() will write the stale audio infoframe. My mistake.
> > > 
> > > To clear the stale audio infoframe, dw_hdmi_qp_audio_disable() can handle it
> > > in the else branch directly, but this seems like a layering violation for a
> > > bridge driver
> > > 
> > > I think the better approach is to add a 'reset_audio_infoframe' interface in
> > > drm_hdmi_state_helper.c that does basically the same as
> > > drm_atomic_helper_connector_hdmi_clear_audio_infoframe(), but only clearing
> > > the software state without calling clear_infoframe(). It's also a bit odd
> > > since it would only be used by dw-hdmi-qp.
> > 
> > That sounds too fine-grained and it also will not work straight ahead...
> > 
> > Just for my understanding, let's consider the opposite situation: the
> > user tries to start audio playback before setting the mode. How is it
> > handled in the driver?
> > 
> 
> audio_prepare() will return -ENODEV before the mode is set.
> 
> I admit modifying dw-hdmi-qp is more reasonable. I have a new approach:
> 
> dw-hdmi-qp should have an internal function to clear the audio infoframe
> related registers.
> dw_hdmi_qp_bridge_clear_audio_infoframe() should check tmds_char_rate, call
> the new function only when tmds_char_rate is available.
> dw_hdmi_qp_bridge_write_audio_infoframe() should call the new function
> directly instead of dw_hdmi_qp_bridge_clear_audio_infoframe(), without
> checking tmds_char_rate.
> dw_hdmi_qp_audio_disable() doesn't need any modification.

Assuming that all audio-related registers are cleared when you perform
PHY disable / enable cycle, this looks good to me.

> 
> With this approach, clear_audio_infoframe guards register access by checking
> tmds_char_rate, while write_audio_infoframe does not need to check it again.
> How about it?
> 
> Thanks,
> Frank Zhang
> 
> > > 
> > > I'd like to get the maintainers' opinion about adding such an interface.
> > > 
> > > Thanks,
> > > Frank Zhang
> > > 
> > 
> 

-- 
With best wishes
Dmitry
